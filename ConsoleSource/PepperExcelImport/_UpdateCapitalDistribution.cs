using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;

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
            tableName = "AMB 1";
            //dt = Globals.GetExcelDataTable(tableName);
           // UpdateGPProfits(dt,true,false);
            tableName = "AMB2 GP Profits";
            dt = Globals.GetExcelDataTable(tableName);
            UpdateGPProfits(dt,true,false);
           // tableName = "AMB 2 Mngmt fees";
            //dt = Globals.GetExcelDataTable(tableName);
           // UpdateGPProfits(dt,false,true);
        }


        private static void UpdateGPProfits(PagingDataTable dt, bool isGP, bool IsManagementFee)
        {
            string investorName;
            DateTime effectiveDate;
           // DateTime noticeDate;
            //decimal distributionAmount;
            decimal gpProfits;
            decimal returnManagementFees;

            int capitalDistributionID;
            DateTime minDate = Convert.ToDateTime("01/01/1900");
            foreach (DataRow row in dt.Rows)
            {
                capitalDistributionID = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["CapitalDistributionID"]));
                investorName = DataTypeHelper.ToString(row["Investor"]);
                effectiveDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Effective Date"]));
               // noticeDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Notice Date"]));
                //distributionAmount = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["DistributionAmount"]));
                if (isGP)
                    gpProfits = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["GPProfits"]));
                else
                    gpProfits = 0;
                if (IsManagementFee)
                    returnManagementFees = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["ReturnManagementFees"]));
                else
                    returnManagementFees = 0;
 

                using (PepperContext context = new PepperContext())
                {
                    Investor investor = _Investors.Where(q => q.InvestorName == investorName).FirstOrDefault();
                    string sql = string.Format("select top 1 * from CapitalDistribution_bak where CapitalDistributionID={0}", capitalDistributionID);
                    IEnumerable<CapitalDistribution> cdbakQuery;
                    List<CapitalDistribution> cdbaks;
                    cdbakQuery = context.Database.SqlQuery<CapitalDistribution>(sql);
                    cdbaks = cdbakQuery.ToList();
                    int? distributionNumber = 0;
                    int fundID = 0;
                    if (cdbaks.Count() > 0)
                    {
                        distributionNumber = cdbaks.Select(q => q.DistributionNumber).FirstOrDefault();
                        fundID = cdbaks.Select(q => q.FundID).FirstOrDefault();
                    }
                    if (investor == null)
                    {
                        Util.WriteError("Investor not exist=" + capitalDistributionID);
                    }
                    if (distributionNumber <= 0)
                    {
                        Util.WriteError("DistributionNumber not exist=" + capitalDistributionID);
                    }
                    if (fundID <= 0)
                    {
                        Util.WriteError("FundID not exist=" + capitalDistributionID);
                    }
                    if (investor != null && distributionNumber > 0 && fundID > 0)
                    {
                        CapitalDistributionLineItem lineItem = (from item in context.CapitalDistributionLineItems
                                                                join cd in context.CapitalDistributions on item.CapitalDistributionID equals cd.CapitalDistributionID
                                                                where item.InvestorID == investor.InvestorID
                                                                && cd.FundID == fundID
                                                                && EntityFunctions.TruncateTime(cd.CapitalDistributionDate) == effectiveDate
                                                                && cd.DistributionNumber == distributionNumber
                                                                select item).FirstOrDefault();
                        if (lineItem != null)
                        {
                            if (isGP)
                            {
                                lineItem.Profits = gpProfits;
                            }
                            if (IsManagementFee)
                            {
                                lineItem.ReturnManagementFees = returnManagementFees;
                            }
                            context.Entry(lineItem).State = EntityState.Modified;
                            context.SaveChanges();
                            Util.Log("Completed =" + capitalDistributionID);
                        }
                        else
                        {
                            Util.WriteError("LineItem not exist=" + capitalDistributionID);
                        }
                    }
                }
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

