using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using System.IO;
using System.Configuration;
using System.Data;
using Pepper.Framework.Authentication;
using System.Threading;
using Pepper.Framework.Helpers;
//using Pepper.Controllers.Deal;
using Pepper.Framework.Extensions;
using System.Data.Objects;
using Pepper.Models.CodeFirst;


namespace PepperExcelImport
{

    public class PrincipalProvider : IUserProvider
    {
        private const string entityKey = "CurrentEntity";
        private const string user = "CurrentUser";

        public User CurrentUser
        {
            get
            {
                PepperPrincipal principal = Thread.CurrentPrincipal as PepperPrincipal;
                if (principal != null)
                {
                    return principal.CurrentUser;
                }
                return new User { UserID = Globals.DefaultUserID, IsWrite = true, EntityID = Globals.DefaultEntityID };
                //return null;
            }
            set
            {
                PepperPrincipal principal = Thread.CurrentPrincipal as PepperPrincipal;
                if (principal == null)
                {
                    principal = new PepperPrincipal();
                    Thread.CurrentPrincipal = principal;
                }
                principal.CurrentUser = value;
            }
        }

        public Entity CurrentEntity
        {
            get
            {
                PepperPrincipal principal = Thread.CurrentPrincipal as PepperPrincipal;
                if (principal != null)
                {
                    return principal.CurrentEntity;
                }
                return new Entity { EntityID = Globals.DefaultEntityID };
                //return null;
            }
            set
            {
                PepperPrincipal principal = Thread.CurrentPrincipal as PepperPrincipal;
                if (principal == null)
                {
                    principal = new PepperPrincipal();
                    Thread.CurrentPrincipal = principal;
                }
                principal.CurrentEntity = value;
            }
        }

    }

    class Program
    {





        static void Main(string[] args)
        {

            try
            {

                Authentication.UserProvider = new PrincipalProvider();

                EntityHelper.Initialize();

                string currentDirectory = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);

                string excelFileName = ConfigurationManager.AppSettings["excel_filename"];

                //Globals.ConnectExcel(currentDirectory, excelFileName);

                //Import_Vintage_Update();
                //Import_Fund_Type_Update();

                //ImportUnderlyingFund.Import(); // 7-10Delta  

                //ImportInvestorAccount.Import(); // 7-20Delta  

                //ImportDeal.Import(); // 6-15Delta 

                //ImportDealUnderlyingFund.Import(); // 5-10Delta  

                //ImportDealUnderlyingDirect.Import(); // 5-11Delta 

                //ImportEquity.Import(); // 4-20Delta 

                //ImportEquitySplit.Import(); // 4-30Delta  

                //ImportUnderlyingFundCapitalCallLineItem.Import(); // 1-30Delta  

                //ImportCapitalDistribution.Import(); // 2-10Delta, 6-30Delta  

                //ImportCapitalCallLineItem.Import(); // 3-20Delta 

                //ImportCashDistribution.Import(); // 1-10Delta

                //ImportStockDistribution.Import(); // 1-15Delta

                //ImportUnderlyingFundCapitalCall.Import(); // 1-20Delta

                //ImportDealUnderlyingFundAdjustment.Import(); // 1-25Delta,5-30Delta

                //ImportSecurityConversion.Import(); // 4-35Delta, 4-36Delta

                //ImportSecuritySale.Import(); // 4-10Delta  

                //ImportSecuritySaleSourceMapping.Import(); // security sale mapping

                //SecurityLotReEntry.ReEntrySecurityLog();

                //ImportUnderlyingFundNAVReport.Import(); // 5-15Delta

                //ImportDealClosingCost.Import(); // 6-40Delta

                //ImportFundExpense.Import(); // 13-10Delta

                //UpdateSecuritySaleDealID.Import(); 

                //ConvertNAVReportNAV.Import();

                //UpdateCashDistributionTypeExcel.Import();

                //ImportCapitalDistributionToCashDistributionMap.Import(); // capital distribution to cash distribution map

                //ImportCapitalDistributionToSecuritySaleMap.Import(); // capital distribution to security sale map

                //SecurityLotResale.Import();

                //SecurityLotHistoryUpdate.Import();

                //CheckUnfundedAmount.Import();

                //ImportNAVDateReconciliation.Import();

                //UpdateSecurityConversionDetail.Import();

                //ManualDiscountNAVQuery.Import();

                //UpdateDealUnderlyingFundAdjustmentRecall.Import();

                //UpdateDealUnderlyingFundAdjustmentRecall.Import();

                //UpdateShortTermNettedDistributionRecall.Import();

                //UpdateDUFUnfundedAdjustment.Import();

                //UpdateDiscountNAV.Import();

                //UpdateSecurityConversionChecking.Import();

                //UpdateDealIDSecurityLot.Import();

                //UpdateSecuritySaleToSecurityLot.Import();

                //ReclassifyUnderlyingFund.Import();

                //UnderlyingFundRemove.Import();

                //CreateDealAssetReport.Import();


            }
            catch (Exception ex)
            {
                Console.WriteLine("Exception ex=" + ex.Message);
            }

            Console.WriteLine("Press any key to continue........");
            Console.ReadLine();


        }



        public static void Import_Vintage_Update()
        {
            string tableName = "Vintage Updates";
            PagingDataTable dt = Globals.GetExcelDataTable(tableName);
            string fundName = string.Empty;
            short vintageYear = 0;

            using (PepperContext context = new PepperContext())
            {
                foreach (DataRow row in dt.Rows)
                {
                    fundName = DataTypeHelper.ToString(row["Fund Name"]);
                    vintageYear = DataTypeHelper.ToInt16(DataTypeHelper.ToString(row["New Vintage Year"]));
                    UnderlyingFund uf = context.UnderlyingFunds.Where(q => q.FundName == fundName).FirstOrDefault();
                    if (uf != null)
                    {
                        uf.VintageYear = vintageYear;
                        context.Entry(uf).State = EntityState.Modified;
                        Util.Log("Import_Vintage_Update Update underlying fund=" + fundName);
                    }
                    else
                    {
                        Util.WriteError("Import_Vintage_Update UnderlyingFund does not exist :" + fundName);
                    }
                }
                context.SaveChanges();
            }
        }

        public static void Import_Fund_Type_Update()
        {
            string tableName = "Fund Type Update";
            PagingDataTable dt = Globals.GetExcelDataTable(tableName);
            string fundName = string.Empty;
            string fundType = string.Empty;

            using (PepperContext context = new PepperContext())
            {
                foreach (DataRow row in dt.Rows)
                {
                    fundName = DataTypeHelper.ToString(row["Fund Name"]);
                    fundType = DataTypeHelper.ToString(row["New Fund Type"]);
                    UnderlyingFund uf = context.UnderlyingFunds.Where(q => q.FundName == fundName).FirstOrDefault();
                    if (uf != null)
                    {
                        int uftypeid = (Globals.GetUnderlyingFundTypeID(fundType) ?? 0);
                        if (uftypeid > 0)
                        {
                            uf.FundTypeID = uftypeid;
                        }
                        else
                        {
                            Util.WriteError("Import_Fund_Type_Update Fund Type ID = 0 :" + fundType);
                        }
                        context.Entry(uf).State = EntityState.Modified;
                        Util.Log("Import_Fund_Type_Update Update underlying fund=" + fundName);
                    }
                    else
                    {
                        Util.WriteError("Import_Fund_Type_Update UnderlyingFund does not exist :" + fundName);
                    }
                }
                context.SaveChanges();
            }
        }
        
        public static void UpdateCapitalDistribuionStatistics(int capitalDistributionId)
        {
            using (PepperContext context = new PepperContext())
            {
                CapitalDistribution capitalDistribution = context.CapitalDistributions.Where(q => q.CapitalDistributionID == capitalDistributionId).FirstOrDefault();
                if (capitalDistribution != null)
                {
                    decimal? total = 0;
                    var query = (from map in context.CapitalDistributionSourceMappings
                                 join securitySale in context.SecuritySales on map.CapitalDistributionSourceID equals securitySale.SecuritySaleID
                                 where map.CapitalDistributionSourceTypeID == (int)Pepper.Models.CodeFirst.Enums.CapitalDistributionSourceType.SaleOfSecurity
                                 && map.CapitalDistributionID == capitalDistributionId
                                 select securitySale.FinalSaleAmount);
                    if (query.Count() > 0)
                        total = query.Sum();

                    capitalDistribution.TotalSaleOfSecuritys = total;

                    total = 0;
                    query = (from map in context.CapitalDistributionSourceMappings
                             join cashDistribution in context.CashDistributions on map.CapitalDistributionSourceID equals cashDistribution.CashDistributionID
                             where map.CapitalDistributionSourceTypeID == (int)Pepper.Models.CodeFirst.Enums.CapitalDistributionSourceType.CashDistribution
                             && map.CapitalDistributionID == capitalDistributionId
                             select cashDistribution.Amount);
                    if (query.Count() > 0)
                        total = query.Sum();

                    capitalDistribution.TotalCashDistributions = total;

                    total = 0;
                    query = (from map in context.CapitalDistributionSourceMappings
                             join securityDistribution in context.SecurityDistributions on map.CapitalDistributionSourceID equals securityDistribution.SecurityDistributionID
                             where map.CapitalDistributionSourceTypeID == (int)Pepper.Models.CodeFirst.Enums.CapitalDistributionSourceType.SecurityDistribution
                             && map.CapitalDistributionID == capitalDistributionId
                             select securityDistribution.Proceeds);
                    if (query.Count() > 0)
                        total = query.Sum();

                    capitalDistribution.TotalSecurityDistributions = total;

                    total = 0;
                    query = (from map in context.CapitalDistributionSourceMappings
                             join dividendDistribution in context.DividendDistributions on map.CapitalDistributionSourceID equals dividendDistribution.DividendDistributionID
                             where map.CapitalDistributionSourceTypeID == (int)Pepper.Models.CodeFirst.Enums.CapitalDistributionSourceType.DividendDistribution
                             && map.CapitalDistributionID == capitalDistributionId
                             select dividendDistribution.Amount);
                    if (query.Count() > 0)
                        total = query.Sum();

                    capitalDistribution.TotalDividendDistributions = total;

                    total = 0;
                    query = (from map in context.CapitalDistributionSourceMappings
                             join fundExpense in context.FundExpenses on map.CapitalDistributionSourceID equals fundExpense.FundExpenseID
                             where map.CapitalDistributionSourceTypeID == (int)Pepper.Models.CodeFirst.Enums.CapitalDistributionSourceType.FundExpense
                             && map.CapitalDistributionID == capitalDistributionId
                             select fundExpense.Amount);
                    if (query.Count() > 0)
                        total = query.Sum();

                    capitalDistribution.TotalFundExpenses = total;

                    context.Entry(capitalDistribution).State = System.Data.EntityState.Modified;
                    context.SaveChanges();
                }
            }
        }
    }
}
