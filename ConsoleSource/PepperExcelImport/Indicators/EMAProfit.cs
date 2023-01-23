using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PepperExcelImport {
    public class EMAProfit {

        public EMAProfit() {
        }

        public void Calculate(Price[] candles) {
            Price last = null;
            int cnt = 0;
            for(int i = 0;i < candles.Count();i++) {
                if(candles[i].last_date.ToString("MM-dd-yyyy") == "01-31-2018") {
                    string s = string.Empty;
                }
                if((candles[i].ema_cross ?? 0) >= -3 && (candles[i].ema_cross ?? 0) <= 0) {
                    cnt = 0;
                    int lastJ = 0;
                    for(var j = (i - 1);j >= 0;j--) {
                        if(((candles[j].ema_cross ?? 0) < (candles[j + 1].ema_cross ?? 0)) || (candles[j].ema_cross ?? 0) < 0) {
                            cnt += 1;
                            lastJ = j;
                        } else {
                            break;
                        }
                    }
                    if (cnt > 0) {
                        for (var z = lastJ; z < i; z++) {
                            if (candles[z].close_price < candles[z + 1].close_price) {
                                candles[i].ema_increase_cnt = (candles[i].ema_increase_cnt ?? 0) + 1;
                            }
                        }
                    }
                    if (last != null) {
                        if(last.last_date.ToString("MM/dd/yyyy") == "09-30-2016") {
                            string s = string.Empty;
                        }
                        last.ema_min_profit = ((from q in candles
                                                where q.last_date > last.last_date
                                                && q.last_date < candles[i].last_date
                                                select q).Count() > 0 ? (from q in candles
                                              where q.last_date > last.last_date
                                              && q.last_date < candles[i].last_date
                                              select (q.ema_profit ?? 0)).Min() : 0);
                        last.ema_max_profit = ((from q in candles
                                                where q.last_date > last.last_date
                                                && q.last_date < candles[i].last_date
                                                select q).Count() > 0 ? (from q in candles
                                                                         where q.last_date > last.last_date
                                                                         && q.last_date < candles[i].last_date
                                                                         select (q.ema_profit ?? 0)).Max() : 0);
                    }
                    if (cnt >= 1) {
                        last = candles[i];
                        last.ema_cnt = cnt;
                    }
                } else {
                    if(last != null && (candles[i].ema_cross ?? 0) > 0) {
                        last.ema_signal = "B";
                        last.ema_cnt = cnt;
                        candles[i].ema_profit = (((candles[i].close_price ?? 0) - (last.close_price ?? 0)) / (last.close_price ?? 0)) * 100;
                        last.ema_profit = candles[i].ema_profit;
                    } else {
                        last = null;
                    }
                }
            }
        }

    }

}

