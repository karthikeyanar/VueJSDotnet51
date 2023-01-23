using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;
using System.IO;
using System.Reflection;
using System.Configuration;

namespace PepperExcelImport
{
    class UpdateCapitalDistribution
    {

        private static List<Pepper.Models.CodeFirst.Investor> _Investors;

        public static void Import()
        {

            using (PepperContext context = new PepperContext())
            {
                _Investors = context.Investors.Where(q => q.EntityID == Globals.DefaultEntityID).ToList();
            }
            //using (PepperContext context = new PepperContext())
            //{
            //    List<int> fundIds = new List<int>() { 41, 42, 43 };
            //    foreach (int fundId in fundIds)
            //    {
            //        UpdateDistributionNumberOrder(fundId);
            //    }
            //}
            PagingDataTable dt;
            string tableName = string.Empty;
            tableName = "Table_1";
            dt = (PagingDataTable)Globals.GetExcelDataTable(tableName);
            UpdateDistributionAmount(dt);
        }


        private static void UpdateDistributionAmount(PagingDataTable dt)
        {
            string investorName;
            // string fundName;
            //DateTime effectiveDate;
            // DateTime noticeDate;
            //decimal distributionAmount;
            decimal gpProfits;
            decimal returnManagementFees;
            decimal preferredCatchUp;
            decimal preferredReturn;
            decimal returnFundExpenses;
            int capitalDistributionID;

            DateTime minDate = Convert.ToDateTime("01/01/1900");
            List<int> missingCapitalDistributions = new List<int>();


            foreach (DataRow row in dt.Rows)
            {
                capitalDistributionID = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["CapitalDistributionID"]));
                investorName = DataTypeHelper.ToString(row["Investor"]);
                //fundName = DataTypeHelper.ToString(row["Fund"]);
                //effectiveDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Effective Date"]));
                //noticeDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Notice Date"]));
                //distributionAmount = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["DistributionAmount"]));

                gpProfits = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["GPProfits"]));
                returnManagementFees = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["ReturnManagementFees"]));
                preferredCatchUp = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["PreferredCatchUp"]));
                preferredReturn = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["PreferredReturn"]));
                returnFundExpenses = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["ReturnFundExpenses"]));
                if (capitalDistributionID > 0)
                {
                  

                    using (PepperContext context = new PepperContext())
                    {
                        Investor investor = _Investors.Where(q => q.InvestorName == investorName).FirstOrDefault();
                        CapitalDistribution capitalDistribution = context.CapitalDistributions.Where(q => q.CapitalDistributionID == capitalDistributionID).FirstOrDefault();
                        if (investor == null)
                        {
                            Util.WriteError("Investor not exist=" + capitalDistributionID);
                        }
                        if (capitalDistribution == null)
                        {
                            Util.WriteError("CapitalDistribution not exist=" + capitalDistributionID);
                        }
                        if (investor != null && capitalDistribution != null)
                        {
                            CapitalDistributionLineItem lineItem = (from item in context.CapitalDistributionLineItems
                                                                    join cd in context.CapitalDistributions on item.CapitalDistributionID equals cd.CapitalDistributionID
                                                                    where item.InvestorID == investor.InvestorID
                                                                    && cd.CapitalDistributionID == capitalDistribution.CapitalDistributionID
                                                                    select item).FirstOrDefault();
                            if (lineItem != null)
                            {
                                lineItem.ReturnManagementFees = returnManagementFees;
                                lineItem.Profits = gpProfits;
                                lineItem.PreferredCatchUp = preferredCatchUp;
                                lineItem.PreferredReturn = preferredReturn;
                                lineItem.ReturnFundExpenses = returnFundExpenses;
                                context.Entry(lineItem).State = EntityState.Modified;
                                context.SaveChanges();
                                Util.Log("Completed =" + capitalDistributionID);
                            }
                            else
                            {
                                if (missingCapitalDistributions.Where(q => q == capitalDistributionID).Count() <= 0)
                                {
                                    missingCapitalDistributions.Add(capitalDistributionID);
                                }
                            }
                        }
                        else
                        {
                            Util.WriteError("capitalDistributionID = 0 = " + capitalDistributionID);
                        }
                    }
                }
            }
            foreach (var id in missingCapitalDistributions)
            {
                Util.WriteError("Missing Capital Distribution ID=" + id);
            }
        }


        private static void UpdateDistributionNumberOrder(int fundID)
        {
            using (PepperContext context = new PepperContext())
            {
                List<CapitalDistribution> capitalDistributions = (from cd in context.CapitalDistributions
                                                                  where cd.FundID == fundID
                                                                  orderby cd.CapitalDistributionDate, cd.CapitalDistributionDueDate
                                                                  select cd).ToList();
                int rowNumber = 0;
                foreach (var cd in capitalDistributions)
                {
                    rowNumber += 1;
                    cd.DistributionNumber = rowNumber;
                    context.Entry(cd).State = EntityState.Modified;
                }
                context.SaveChanges();
            }
        }
    }
}

