using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PepperExcelImport {
    [NotMapped]
    public class Price  {

        public string symbol { get; set; }
        public DateTime last_date { get; set; }
        public decimal? close_price { get; set; }
        public bool? is_indicator { get; set; }

        public decimal hl { get; set; }
        public decimal hcp { get; set; }
        public decimal lcp { get; set; }
        public decimal tr { get; set; }
        public decimal atr { get; set; }

        public decimal upper_band_basic { get; set; }
        public decimal lower_band_basic { get; set; }
        public decimal upper_band { get; set; }
        public decimal lower_band { get; set; }
        public decimal super_trend { get; set; }
        public DateTime? sp_sell_date { get; set; }
        
        public decimal ema_12 { get; set; }
        public decimal ema_26 { get; set; }
        public decimal m_singal { get; set; }
        public decimal? ema_cross { get; set; }
        public decimal? ema_profit { get; set; }
        public decimal? ema_min_profit { get; set; }
        public decimal? ema_max_profit { get; set; }
        public int? ema_cnt { get; set; }
        public decimal? ema_5 { get; set; }
        public decimal? ema_20 { get; set; }
        public int? ema_increase_cnt { get; set; }

        public string ema_signal { get; set; }
    }
}
