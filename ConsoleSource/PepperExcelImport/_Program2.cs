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

                List<int> _FundIDs = new List<int>();
                _FundIDs.Add(41);
                _FundIDs.Add(43);

                foreach (int fundId in _FundIDs)
                {
                    List<CapitalDistribution> capitalDistributions;
                    using (PepperContext context = new PepperContext())
                    {
                        capitalDistributions = (from cd in context.CapitalDistributions
                                                where cd.FundID == fundId
                                                select cd).ToList();
                        int autoNumber = 0;
                        foreach (var cd in capitalDistributions)
                        {
                            autoNumber++;
                            cd.DistributionNumber = autoNumber;
                            context.Entry(cd).State = EntityState.Modified;
                        }
                        context.SaveChanges();
                    }
                    foreach (var cd in capitalDistributions)
                    {
                        string sql = string.Format("select top 1 * from CapitalDistribution_bak where FundID={0} and CapitalDistributionDate='{1}' and DistributionAmount>={2} and DistributionAmount<={3}", cd.FundID, cd.CapitalDistributionDate.ToString("MM/dd/yyyy"), cd.DistributionAmount - 1, cd.DistributionAmount + 1);
                        IEnumerable<CapitalDistribution> cdbakQuery;
                        List<CapitalDistribution> cdbaks;
                        using (PepperContext context = new PepperContext())
                        {
                            cdbakQuery = context.Database.SqlQuery<CapitalDistribution>(sql);
                            cdbaks = cdbakQuery.ToList();
                        }
                        int count = 0;
                        foreach (var cdbak in cdbaks)
                        {
                            count++;
                            sql = string.Format("select * from CapitalDistributionSourceMapping_bak where CapitalDistributionID={0}", cdbak.CapitalDistributionID);
                            IEnumerable<CapitalDistributionSourceMapping> mapbakQuery;
                            List<CapitalDistributionSourceMapping> mapbaks;
                            using (PepperContext context = new PepperContext())
                            {
                                mapbakQuery = context.Database.SqlQuery<CapitalDistributionSourceMapping>(sql);
                                mapbaks = mapbakQuery.ToList();
                            }
                            using (PepperContext context = new PepperContext())
                            {
                                foreach (var mapbak in mapbaks)
                                {
                                    context.CapitalDistributionSourceMappings.Add(new CapitalDistributionSourceMapping
                                    {
                                        CapitalDistributionID = cd.CapitalDistributionID,
                                        CapitalDistributionSourceID = mapbak.CapitalDistributionSourceID,
                                        CapitalDistributionSourceTypeID = mapbak.CapitalDistributionSourceTypeID,
                                    });
                                }
                                context.SaveChanges();
                            }
                            UpdateCapitalDistribuionStatistics(cd.CapitalDistributionID);
                            Console.WriteLine("Capital Distribution Complete = " + cd.CapitalDistributionID);
                        }
                        if (count == 0)
                        {
                            Console.WriteLine("Error cdbak is null = " + cd.CapitalDistributionID);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Exception ex=" + ex.Message);
            }

            Console.WriteLine("Press any key to continue........");
            Console.ReadLine();


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
