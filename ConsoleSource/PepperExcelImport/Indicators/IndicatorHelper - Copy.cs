﻿using Ecam.Contracts;
using Ecam.Models;
using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Web.Http;
using System.Net.Mail;
using System.Linq;

using Newtonsoft.Json;
using System.IO;
using System.Web;
using System.Text.RegularExpressions;
using MySql.Data.MySqlClient;
using System.Data.Entity.Validation;
using Ecam.Models.Helpers;
using Ecam.Contracts.Enums;
using Ecam.Framework.ExcelHelper;
using CsvHelper;

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
            using(EcamContext context = new EcamContext()) {
                candles = (from q in context.tra_market
                           where q.symbol == symbol
                           select new Price {
                               symbol = q.symbol,
                               trade_date = q.trade_date,
                               high_price = q.high_price,
                               low_price = q.low_price,
                               open_price = q.open_price,
                               close_price = q.close_price,
                               is_indicator = q.is_indicator,
                           }).ToArray();
            }
            ATR atr = new ATR();
            atr.Calculate(candles);
            //MACD macd = new MACD();
            //macd.Calculate(candles);
            Supertrend supertrend = new Supertrend();
            supertrend.Calculate(candles);
            HeikinAshi heikinashi = new HeikinAshi();
            heikinashi.Calculate(candles);
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
                if(candles[i].trade_date.ToString("dd-MMM-yyyy") == "14-Feb-2017") {
                    string s = string.Empty;
                }
                if(
                    ((candles[i].super_trend_signal == "B" || candles[i].super_trend_signal == "S" || candles[i].heikin_ashi_signal == "B" || candles[i].heikin_ashi_signal == "S"))
                    && (candles[i].is_indicator ?? false) == false
                    ) {
                    if(candles[i].super_trend_signal == "B" || candles[i].heikin_ashi_signal == "B") {
                        var candle = (from q in candles
                                      where q.trade_date > candles[i].trade_date
                                      && q.super_trend_signal == "S"
                                      orderby q.trade_date ascending
                                      select q).FirstOrDefault();
                        if(candle == null) {
                            candle = (from q in candles
                                      where q.trade_date > candles[i].trade_date
                                      orderby q.trade_date ascending
                                      select q).FirstOrDefault();
                        }
                        if(candle != null) {
                            candles[i].sp_sell_date = candle.trade_date;
                        }
                        candle = (from q in candles
                                  where q.trade_date < candles[i].trade_date
                                  && (q.super_trend_signal == "B" || q.super_trend_signal == "S")
                                  orderby q.trade_date descending
                                  select q).FirstOrDefault();
                        if(candle != null) {
                            if(candle.super_trend_signal == "B") {
                                candles[i].sp_profit = (((candles[i].close_price ?? 0) - (candle.close_price ?? 0)) / (candle.close_price ?? 0)) * 100;
                            }
                        }
                        candle = (from q in candles
                                  where q.trade_date < candles[i].trade_date
                                  && (q.heikin_ashi_signal == "B" || q.heikin_ashi_signal == "S")
                                  orderby q.trade_date descending
                                  select q).FirstOrDefault();
                        if(candle != null) {
                            if(candle.heikin_ashi_signal == "B") {
                                candles[i].heikin_ashi_profit = (((candles[i].close_price ?? 0) - (candle.close_price ?? 0)) / (candle.close_price ?? 0)) * 100;
                            }
                        }
                    }
                } else {

                    var candle = (from q in candles
                                  where q.trade_date < candles[i].trade_date
                                  && (q.super_trend_signal == "B" || q.super_trend_signal == "S")
                                  orderby q.trade_date descending
                                  select q).FirstOrDefault();
                    if(candle != null) {
                        if(candle.super_trend_signal == "B") {
                            candles[i].sp_profit = (((candles[i].close_price ?? 0) - (candle.close_price ?? 0)) / (candle.close_price ?? 0)) * 100;
                        }
                    }

                    candle = (from q in candles
                              where q.trade_date < candles[i].trade_date
                              && (q.heikin_ashi_signal == "B" || q.heikin_ashi_signal == "S")
                              orderby q.trade_date descending
                              select q).FirstOrDefault();
                    if(candle != null) {
                        if(candle.heikin_ashi_signal == "B") {
                            candles[i].heikin_ashi_profit = (((candles[i].close_price ?? 0) - (candle.close_price ?? 0)) / (candle.close_price ?? 0)) * 100;
                        }
                    }

                }
                sql = string.Format("update tra_market set super_trend_signal='{0}',sp_profit={1},heikin_ashi_signal='{2}',heikin_ashi_profit={3},ema_5={4},ema_20={5},is_indicator={6} " +
                    " where trade_date='{7}' and symbol='{8}'"
                    ,candles[i].super_trend_signal
                    ,(candles[i].sp_profit ?? 0)
                    ,candles[i].heikin_ashi_signal
                    ,(candles[i].heikin_ashi_profit ?? 0)
                    ,(candles[i].ema_5 ?? 0)
                    ,(candles[i].ema_20 ?? 0)
                    ,1
                    ,candles[i].trade_date.ToString("yyyy-MM-dd")
                    ,candles[i].symbol);
                MySqlHelper.ExecuteNonQuery(Ecam.Framework.Helper.ConnectionString,sql);
            }
            Console.WriteLine("Completed symbol=" + symbol);
        }

        public string file_name { get { return _SYMBOL; } }
        private string _SYMBOL;
        private string _ORIGINAL_SYMBOL;

        private ManualResetEvent _doneEvent;
    }

}