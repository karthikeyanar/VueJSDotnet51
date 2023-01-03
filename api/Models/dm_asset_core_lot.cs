using Microsoft.AspNetCore.Mvc;
using System;

namespace api.Models
{
    public class dm_asset_core_lot 
    {
        public dm_asset_core_lot()
        {
            this.dm_asset_core_lot_id = 0;
            this.Symbol = "";
            this.RecordDate = DateTime.Now.Date;
            this.SharePrice = 0;
            this.NumberOfShares = 0;
            this.LotType = "";
            this.RefID = "";
        }
        public int dm_asset_core_lot_id {get;set;}
        public string Symbol {get;set;}
        public DateTime RecordDate {get;set;}
        public decimal NumberOfShares {get;set;}
        public decimal SharePrice {get;set;}
        public string LotType {get;set;}
        public string RefID {get;set;}
    }

    public class dm_asset_core_lot_share
    {
        public dm_asset_core_lot_share()
        {
            this.Symbol = "";
            this.SharePrice = 0;
            this.NumberOfShares = 0;
            this.Amount = 0;
        }
        public string Symbol { get; set; }
        public DateTime RecordDate { get; set; }
        public decimal NumberOfShares { get; set; }
        public decimal SharePrice { get; set; }
        public decimal Amount { get; set; }
    }

    public class DealXIRRReportModel
    {

        public string Fund { get; set; }

        public int? DealNumber { get; set; }

        public string DealName { get; set; }

        public string UnderlyingFund { get; set; }

        public string Direct { get; set; }

        public string Symbol { get; set; }

        public DateTime? Date { get; set; }

        public decimal? Value { get; set; }

        public string Description { get; set; }

        public string Type { get; set; }

        public int SecurityTypeID { get; set; }

        public int SecurityID { get; set; }

        public decimal? NumberOfSharesUnsold { get; set; }

        public decimal? LastPrice { get; set; }

        public int? ID { get; set; }
    }
}