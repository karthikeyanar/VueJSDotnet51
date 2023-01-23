

using System;
using System.Collections.Generic;
using System.Net;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Net.Mail;
using System.Linq;

using Newtonsoft.Json;
using System.IO;
using System.Web;
using System.Text.RegularExpressions;
using System.Data.Entity.Validation;

using CsvHelper;
using Pepper.Models.CodeFirst;

namespace PepperExcelImport {
    public class IndicatorHelper {
        private List<string> _SYMBOLS_LIST = null;
        private bool _IS_NOT_SUCCESS = false;
        public IndicatorHelper(string file_name,List<string> symbols,ManualResetEvent doneEvent) {
            _SYMBOLS_LIST = symbols;
            _ORIGINAL_SYMBOL = file_name;
            _SYMBOL = file_name;
            _doneEvent = doneEvent;
        }

        public IndicatorHelper() {
        }

        // Wrapper method for use with thread pool.
        public void ThreadPoolCallback(Object threadContext) {
            int threadIndex = (int)threadContext;
            Console.WriteLine("thread {0} started...",threadIndex);
            if(string.IsNullOrEmpty(_SYMBOL) == false) {
                Update(_SYMBOL);
            }
            Console.WriteLine("thread {0} result calculated...",threadIndex);
            _doneEvent.Set();
        }

        public void Update(string symbol) {
            Price[] candles = null;
            using(PepperContext context = new PepperContext()) {
                candles = (from q in context.UnderlyingDirectLastPrices
                           join equity in context.Equities on q.SecurityID equals equity.EquityID
                           where equity.Symbol == symbol
                           select new Price {
                               symbol = equity.Symbol,
                               close_price = q.LastPrice,
                               last_date = q.LastPriceDate,
                               is_indicator = false,
                           }).ToArray();
            }
            EMA ema5 = new EMA();
            ema5.Calculate(candles,5);
            EMA ema20 = new EMA();
            ema20.Calculate(candles,20);
            EMAProfit p = new EMAProfit();
            p.Calculate(candles);
            DateTime minDate = Convert.ToDateTime("01/01/1900");
            //candles = (from q in candles
            //           where string.IsNullOrEmpty(q.super_trend_signal) == false
            //           select q).ToArray();
            string sql = string.Empty;
            for(int i = 0;i < candles.Length;i++) {
                if((candles[i].is_indicator ?? false) == false || candles[i].ema_signal == "B") {
                   
                }
            }
            Console.WriteLine("Completed symbol=" + symbol);
        }

        public string file_name { get { return _SYMBOL; } }
        private string _SYMBOL;
        private string _ORIGINAL_SYMBOL;

        private ManualResetEvent _doneEvent;
    }

}