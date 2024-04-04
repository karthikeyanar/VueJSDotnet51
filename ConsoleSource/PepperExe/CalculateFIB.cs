using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using Dapper;
using Newtonsoft.Json.Linq;

namespace PepperExe
{ 

	public class CalculateEMA
	{
		private string _ConnectionString;
		private string _symbol;
		List<MovingAverage> _prices;

		public CalculateEMA(string connectionString, string symbol)
		{
			_ConnectionString = connectionString;
			_symbol = symbol;
		}

		public void Start()
		{
			_prices = GetHistoricalPrices(_symbol);
			this.CalculateMovingAverages();
			List<Trade> trades = GetTrades(_symbol);
			// Output trade information
			foreach (var trade in trades)
			{
				Console.WriteLine($"Entry Date: {trade.EntryDate}, Exit Date: {trade.ExitDate}, Buy Price: {trade.BuyPrice}, Sell Price: {trade.SellPrice}, Profit Amount: {trade.ProfitAmount}");
			}
			Console.ReadLine();
		}

		public void CalculateMovingAverages()
		{
			 

			for (int i = 0; i < _prices.Count; i++)
			{
				MovingAverage ma = new MovingAverage
				{
					Date = _prices[i].Date,
					Value = _prices[i].Value
				};

				if (i >= 49) // Calculate M50 after having at least 50 data points
				{
					_prices[i].M50 = CalculateSimpleMovingAverage(i, 50);
				}

				if (i >= 19) // Calculate M20 after having at least 20 data points
				{
					_prices[i].M20 = CalculateSimpleMovingAverage(i, 20);
				}

				 
			}
			 
		}

		private double CalculateSimpleMovingAverage(int currentIndex, int windowSize)
		{
			double sum = 0;

			for (int i = currentIndex; i > currentIndex - windowSize; i--)
			{
				sum += _prices[i].Value;
			}

			return sum / windowSize;
		}

		private List<Trade> GetTrades(string symbol)
		{
			List<Trade> trades = new List<Trade>();
 


			//decimal? buyPrice = null;
			//DateTime? buyDate = null;
			//bool isBuy = false;
			//for (int i = 0; i < _prices.Count; i++)
			//{
			//    if(i > 75)
			//    {
			//        double e50 = ema50[i];
			//        double e20 = ema20[i];
			//        Console.WriteLine("date=" + _prices[i].Date.ToString() + ",price=" + _prices[i].Value + ",e50=" + e50 + ",e20=" + e20);
			//        if(e20 > e50 && (e20 < (double)_prices[i].Value) && isBuy == false)
			//        {
			//            buyPrice = _prices[i].Value;
			//            buyDate = _prices[i].Date;
			//            isBuy = true;
			//            Console.WriteLine("IsBuy");
			//        }
			//        else if(isBuy == true)
			//        {
			//            if (ema50[i] > (double)_prices[i].Value)
			//            {
			//                // Sell signal found, create a trade
			//                Trade trade = new Trade
			//                {
			//                    EntryDate = buyDate.Value,
			//                    ExitDate = _prices[i].Date,
			//                    BuyPrice = buyPrice.Value,
			//                    SellPrice = _prices[i].Value,
			//                    ProfitAmount = _prices[i].Value - buyPrice.Value
			//                };
			//                trades.Add(trade);

			//                // Reset buyPrice and buyDate
			//                buyPrice = null;
			//                buyDate = null;
			//                isBuy = false;
			//            }
			//        }
			//    }
			//}

			/*
            for (int i = 0; i < _prices.Count; i++)
            {
                if (i > 49)
                {
                    if (buyPrice == null)
                    {
                        // Look for buy signal
                        if (IsBuySignal(_prices[i], ema20, ema50))
                        {
                            buyPrice = _prices[i].Value;
                            buyDate = _prices[i].Date;
                        }
                    }
                    else
                    {
                        // Look for sell signal
                        if (IsSellSignal(_prices[i], ema20, ema50))
                        {
                            // Sell signal found, create a trade
                            Trade trade = new Trade
                            {
                                EntryDate = buyDate.Value,
                                ExitDate = _prices[i].Date,
                                BuyPrice = buyPrice.Value,
                                SellPrice = _prices[i].Value,
                                ProfitAmount = _prices[i].Value - buyPrice.Value
                            };
                            trades.Add(trade);

                            // Reset buyPrice and buyDate
                            buyPrice = null;
                            buyDate = null;
                        }
                    }
                }
            }
             
            if (buyPrice != null && buyDate != null)
            {
                // Assuming the last price as the exit price for the open position
                Trade trade = new Trade
                {
                    EntryDate = buyDate.Value,
                    ExitDate = _prices.Last().Date,
                    BuyPrice = buyPrice.Value,
                    SellPrice = _prices.Last().Value,
                    ProfitAmount = _prices.Last().Value - buyPrice.Value
                };
                trades.Add(trade);
            }
            */
			return trades;
		}

		private List<MovingAverage> GetHistoricalPrices(string symbol)
		{
			string sql = $@"SELECT Price AS [Value], [Date] FROM [EquityPriceHistory] WHERE symbol = '{symbol}' order by [Date] asc";

			using (SqlConnection connection = new SqlConnection(_ConnectionString))
			{
				connection.Open();
				var prices = connection.Query<MovingAverage>(sql).ToList();
				return prices;
			}
		}

		private bool IsBuySignal(MovingAverage price, double[] ema20, double[] ema50)
		{
			int index = _prices.FindIndex(x => x.Date == price.Date);

			// Check if the 20-day EMA crosses above the 50-day EMA
			if (index >= 1 && ema20[index] > ema50[index] && ema20[index - 1] <= ema50[index - 1])
			{
				// 20-day EMA crossed above 50-day EMA
				return true;
			}
			return false;
		}

		private bool IsSellSignal(MovingAverage price, double[] ema20, double[] ema50)
		{
			int index = _prices.FindIndex(x => x.Date == price.Date);

			// Check if the 20-day EMA crosses below the 50-day EMA
			if (index >= 1 && ema20[index] < ema50[index] && ema20[index - 1] >= ema50[index - 1])
			{
				// 20-day EMA crossed below 50-day EMA
				return true;
			}
			return false;
		}
	}
}
