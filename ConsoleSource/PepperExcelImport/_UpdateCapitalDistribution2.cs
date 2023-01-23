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
            //dt = Globals.GetExcelDataTable(tableName);
           // UpdateGPProfits(dt,true,false);
            tableName = "AMB 3 Distribution";
            dt = Globals.GetExcelDataTable(tableName);
            UpdateDistributionAmount(dt);
           // tableName = "AMB 2 Mngmt fees";
            //dt = Globals.GetExcelDataTable(tableName);
           // UpdateGPProfits(dt,false,true);
        }


        private static void UpdateDistributionAmount(PagingDataTable dt)
        {
            string investorName;
            string fundName;
            DateTime effectiveDate;
            DateTime noticeDate;
            decimal distributionAmount;

            int capitalDistributionID;
            DateTime minDate = Convert.ToDateTime("01/01/1900");
            List<int> missingCapitalDistributions = new List<int>();
            foreach (DataRow row in dt.Rows)
            {
                capitalDistributionID = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["CapitalDistributionID"]));
                investorName = DataTypeHelper.ToString(row["Investor"]);
                fundName = DataTypeHelper.ToString(row["Fund"]);
                effectiveDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Effective Date"]));
                noticeDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Notice Date"]));
                distributionAmount = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["DistributionAmount"]));

                using (PepperContext context = new PepperContext())
                {
                    Investor investor = _Investors.Where(q => q.InvestorName == investorName).FirstOrDefault();
                    int fundID = 0;
                    Pepper.Models.CodeFirst.Fund fund = context.Funds.Where(q => q.FundName == fundName).FirstOrDefault();
                    if (fund != null)
                    {
                        fundID = fund.FundID;
                    }
                    /*
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
                    */
                    if (investor == null)
                    {
                        Util.WriteError("Investor not exist=" + capitalDistributionID);
                    }
                    if (fundID <= 0)
                    {
                        Util.WriteError("FundID not exist=" + capitalDistributionID);
                    }
                    if (investor != null && fundID > 0)
                    {
                        CapitalDistributionLineItem lineItem = (from item in context.CapitalDistributionLineItems
                                                                join cd in context.CapitalDistributions on item.CapitalDistributionID equals cd.CapitalDistributionID
                                                                where item.InvestorID == investor.InvestorID
                                                                && cd.FundID == fundID
                                                                && EntityFunctions.TruncateTime(cd.CapitalDistributionDate) == effectiveDate
                                                                select item).FirstOrDefault();
                        if (lineItem != null)
                        {
                            lineItem.DistributionAmount = distributionAmount;
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

