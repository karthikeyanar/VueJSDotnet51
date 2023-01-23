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
using CsvHelper;
using System.Data.Entity.Validation;
using Pepper.Framework.Authentication;

namespace PepperExcelImport {
    class ImporUnderlyingDirectLastPrice {
        public static int entityID = 100001; // Brant Street Capital
        public static int defaultEntityUserID = 0;

        public static void UpdateLastPrice() {

            string currentDirectory = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
            string excelFileName = "lastprice.csv";
            string filePath = Path.Combine(currentDirectory,excelFileName);

            using (PepperContext context = new PepperContext()) {
                defaultEntityUserID = (from q in context.USERs
                                       where q.EntityID == entityID
                                       select q.UserID).FirstOrDefault();
            }

            // Start Underlying Fund Import
            using (TextReader reader = System.IO.File.OpenText(filePath)) {
                int i;
                CSVHeaderHelper csvHeader = new CSVHeaderHelper();
                CsvReader csv = null;
                csv = new CsvReader(reader);
                i = 0;
                while (csv.Read()) {
                    i += 1;
                    if (i == 1) {
                        int j;
                        for (j = 0;j < 100;j++) {
                            try {
                                csvHeader.Headers.Add(new CSVHeader { Name = csv[j],Index = j });
                            } catch {
                                break;
                            }
                        }
                    } else {
                        //Firm_ID LP/ GP   Investor Investor Search City    Country
                        //Date Price

                        DateTime date = DataTypeHelper.ToDateTime(csv[csvHeader.GetIndex("Date")]);
                        decimal price = DataTypeHelper.ToDecimal(csv[csvHeader.GetIndex("Price")]);

                        int dealId = 2080;
                        int equityId = 3510;
                        using (PepperContext context = new PepperContext()) {
                            Deal deal = (from q in context.Deals where q.DealID == dealId select q).FirstOrDefault();
                            Fund fund = (from q in context.Funds where q.FundID == deal.FundID select q).FirstOrDefault();
                            Equity equity = (from q in context.Equities where q.EquityID == equityId select q).FirstOrDefault();

                            UnderlyingDirectLastPrice lp = (from q in context.UnderlyingDirectLastPrices
                                                            where q.DealID == deal.DealID
                                                            && q.FundID == fund.FundID
                                                            && q.SecurityID == equity.EquityID
                                                            && q.SecurityTypeID == 1
                                                            && q.LastPriceDate == date
                                                            && q.LastPrice == price
                                                            select q).FirstOrDefault();
                            if (lp == null) {
                                lp = new UnderlyingDirectLastPrice {
                                    DealID = deal.DealID,
                                    FundID = deal.FundID,
                                    LastPrice = price,
                                    LastPriceDate = date,
                                    CreatedBy = defaultEntityUserID,
                                    CreatedDate = DateTime.Now.Date,
                                    SecurityTypeID = 1,
                                    SecurityID = equity.EquityID,
                                };

                                context.UnderlyingDirectLastPrices.Add(lp);
                                context.SaveChanges();
                                Console.WriteLine("Added =" + i);
                            } else {
                                Console.WriteLine("Already exist=" + lp.UnderlyingDirectLastPriceID);
                            }
                        }
                    }
                }
            }
            // End Underlying Fund Contact Import
        }

        public static void Calculate() {
            int dealId = 2080;
            int equityId = 3510;
            List<TempUnderlyingDirectLastPrice> prices;
            using (PepperContext context = new PepperContext()) {
                Deal deal = (from q in context.Deals where q.DealID == dealId select q).FirstOrDefault();
                Fund fund = (from q in context.Funds where q.FundID == deal.FundID select q).FirstOrDefault();
                Equity equity = (from q in context.Equities where q.EquityID == equityId select q).FirstOrDefault();

                prices = (from q in context.UnderlyingDirectLastPrices
                          where q.DealID == deal.DealID
                          && q.FundID == fund.FundID
                          && q.SecurityID == equity.EquityID
                          && q.SecurityTypeID == 1
                          orderby q.LastPriceDate
                          select new TempUnderlyingDirectLastPrice {
                              LastPrice = q.LastPrice,
                              LastPriceDate = q.LastPriceDate,
                          }).ToList();
            }
            ImporUnderlyingDirectLastPrice.Calculate(ref prices,50);
            //ImporUnderlyingDirectLastPrice.Calculate(ref prices,100);
            //ImporUnderlyingDirectLastPrice.Calculate(ref prices,150);
            ImporUnderlyingDirectLastPrice.Calculate(ref prices,200);

            List<decimal> changesList = new List<decimal>();
            decimal lp = 0;
            DateTime lpDate = DateTime.MinValue.Date;
            bool isStart = false;
            for (var i = 0;i < prices.Count;i++) {
                var p = prices[i];
                string dt = p.LastPriceDate.ToString("yyyy-MM-dd");
                if (dt == "2009-01-13") {
                    string s = string.Empty;
                }
                if(p.Avg200 < p.LastPrice && i > 199 && isStart == false) {
                    lp = (p.LastPrice ?? 0);
                    lpDate = p.LastPriceDate;
                    isStart = true;
                    continue;
                }  
                if (lp > 0) {
                    var diffDays = (p.LastPriceDate - lpDate).TotalDays;
                    if (p.Avg50 > p.LastPrice) {
                        decimal changes = (decimal)((p.LastPrice - lp) / lp) * 100;
                        changesList.Add(changes);
                        Console.WriteLine(p.LastPriceDate.ToString("yyyy-MM-dd") + ",PrevPrice=" + lp + ",LastPrice=" + p.LastPrice + ",Changes=" + changes + ",lpDate=" + lpDate.ToString("yyyy-MM-dd") + ",DiffDays=" + diffDays);
                        lp = 0;
                        isStart = false;
                        continue;
                    }
                }
            }
            Console.WriteLine("Avg=" + changesList.Sum() / changesList.Count);
        }

        public static void Calculate(ref List<TempUnderlyingDirectLastPrice> price,int period) {
            //Condition.Requires(price,"price")
            //    .IsNotEmpty();
            //Condition.Requires(period,"period")
            //    .IsGreaterThan(0)
            //    .IsLessOrEqual(price.Length);

            //var sma = new decimal[price.Count];

            decimal sum = 0;

            //for (var i = 0;i < period;i++) {
            //    sum += (price[i].LastPrice ?? 0);
            //    //sma[i] = sum / (i + 1);
            //    if (period == 50) {
            //        price[i].Avg50 = sum / (i + 1);
            //    }
            //    if (period == 100) {
            //        price[i].Avg100 = sum / (i + 1);
            //    }
            //    if (period == 200) {
            //        price[i].Avg200 = sum / (i + 1);
            //    }
            //}

            for (var i = period;i < price.Count;i++) {
                sum = 0;
                for (var j = i;j > i - period;j--) {
                    sum += (price[j].LastPrice ?? 0);
                }

                //sma[i] = sum / period;
                if (period == 50) {
                    price[i].Avg50 = sum / period;
                }
                if (period == 100) {
                    price[i].Avg100 = sum / period;
                }
                if (period == 150) {
                    price[i].Avg150 = sum / period;
                }
                if (period == 200) {
                    price[i].Avg200 = sum / period;
                }
            }

            //return sma;
        }
    }

    public class TempUnderlyingDirectLastPrice:UnderlyingDirectLastPrice {
        public decimal Avg50 { get; set; }
        public decimal Avg100 { get; set; }
        public decimal Avg150 { get; set; }
        public decimal Avg200 { get; set; }
        public decimal Diff {
            get {
                return this.Avg200 - this.Avg50;
            }
        }
    }
}

