using Microsoft.AspNetCore.Mvc;
using System.Globalization;
using System;
using System.ComponentModel.DataAnnotations;
using System.Diagnostics;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Collections.Generic;
using System.Text.RegularExpressions;

namespace api.Helpers
{
    public class Select2List
    {
        public Select2List()
        {
            id = string.Empty;
            label = string.Empty;
            value = string.Empty;
        }
        public string id { get; set; }
        public string label { get; set; }
        public string value { get; set; }
        public string other { get; set; }
    }

    public class Helper {
        public static void Log(string log, string description = "", bool isWriteFile = true) {
			try {
				Console.WriteLine(log);
				if (isWriteFile == true) {
					string fileName = (description != "" ? description + "_" : "") + DateTime.Now.ToString("dd-MMM-yyyy") + ".txt";
					log = string.Format("{0} LOG: {1}", DateTime.Now.ToString("hh:mm:ss"), log + Environment.NewLine);
					string rootPath = Environment.CurrentDirectory;
					string tempFileName = Path.Combine(rootPath, "logs", fileName);
					string directoryName = Path.GetDirectoryName(tempFileName);
					if (Directory.Exists(directoryName) == false) {
						Directory.CreateDirectory(directoryName);
					}
					if (File.Exists(tempFileName) == false) {
						File.WriteAllText(tempFileName, log);
					} else {
						using (StreamWriter w = File.AppendText(tempFileName)) {
							w.WriteLine(log);
						}
					}
				}
			} catch (Exception ex) {
				Console.WriteLine("LOG:"  + ex.Message);
			}
		}
        
        public static string ConvertIds(List<int> ids)
        {
            string result = string.Empty;
            foreach (int id in ids)
            {
                result += string.Format("{0},", id);
            }
            if (string.IsNullOrEmpty(result) == false)
            {
                result = result.Substring(0, result.Length - 1);
            }
            return result;
        }

        public static string ConvertIds(List<string> ids)
        {
            string result = string.Empty;
            foreach (string id in ids)
            {
                if (string.IsNullOrEmpty(id) == false)
                {
                    result += string.Format("{0},", id);
                }
            }
            if (string.IsNullOrEmpty(result) == false)
            {
                result = result.Substring(0, result.Length - 1);
            }
            return result;
        }

        public static List<int> ConvertIntIds(string ids)
        {
            List<int> result = new List<int>();
            if (string.IsNullOrEmpty(ids) == false)
            {
                string[] arr = ids.Split((",").ToCharArray());
                foreach (string strid in arr)
                {
                    if (string.IsNullOrEmpty(strid) == false)
                    {
                        result.Add(Helper.ToInt32(strid));
                    }
                }
            }
            return result;
        }

        public static List<int?> ConvertIntNullIds(string ids)
        {
            List<int?> result = new List<int?>();
            if (string.IsNullOrEmpty(ids) == false)
            {
                string[] arr = ids.Split((",").ToCharArray());
                foreach (string strid in arr)
                {
                    if (string.IsNullOrEmpty(strid) == false)
                    {
                        result.Add(Helper.ToInt32(strid));
                    }
                }
            }
            return result;
        }

        public static string ConvertStringIds(string ids)
        {
            string result = string.Empty;
            if (string.IsNullOrEmpty(ids) == false)
            {
                string[] arr = ids.Split((",").ToCharArray());
                foreach (string strid in arr)
                {
                    if (string.IsNullOrEmpty(strid) == false)
                    {
                        //int id = Helper.ToInt32(strid);
                        result += string.Format("{0},", strid);
                    }
                }
            }
            if (string.IsNullOrEmpty(result) == false)
            {
                result = result.Substring(0, result.Length - 1);
            }
            return result;
        }

        public static string ConvertStringIds(List<string> ids)
        {
            string result = string.Empty;
            foreach (string strid in ids)
            {
                if (string.IsNullOrEmpty(strid) == false)
                {
                    result += string.Format("{0},", strid);
                }
            }
            if (string.IsNullOrEmpty(result) == false)
            {
                result = result.Substring(0, result.Length - 1);
            }
            return result;
        }

        public static string ConvertDateTimeIds(List<DateTime?> ids)
        {
            string result = string.Empty;
            foreach (DateTime? dt in ids)
            {
                if (dt.HasValue)
                {
                    if (dt.Value.Year > 1900)
                    {
                        result += string.Format("{0},", dt.Value.ToString("yyyy-MM-dd"));
                    }
                }
            }
            if (string.IsNullOrEmpty(result) == false)
            {
                result = result.Substring(0, result.Length - 1);
            }
            return result;
        }

        public static string ConvertDateTimeIds(List<DateTime> ids)
        {
            string result = string.Empty;
            foreach (DateTime dt in ids)
            {
                if (dt.Year > 1900)
                {
                    result += string.Format("{0},", dt.ToString("yyyy-MM-dd"));
                }
            }
            if (string.IsNullOrEmpty(result) == false)
            {
                result = result.Substring(0, result.Length - 1);
            }
            return result;
        }
        
        public static string ToSQL(string value)
        {
            return (string.IsNullOrEmpty(value) == false ? value.Replace("'", "''") : "''");
        }

        public static string ConvertStringSQLFormat(string values)
        {
            string result = string.Empty;
            if (string.IsNullOrEmpty(values) == false)
            {
                string[] arr = values.Split((",").ToCharArray());
                foreach (string strid in arr)
                {
                    if (string.IsNullOrEmpty(strid) == false)
                    {
                        result += string.Format("'{0}',", strid.Replace("'", ""));
                    }
                }
            }
            if (string.IsNullOrEmpty(result) == false)
            {
                result = result.Substring(0, result.Length - 1);
            }
            return result;
        }

        public static List<string> ConvertStringList(string ids)
        {
            List<string> list = new List<string>();
            if (string.IsNullOrEmpty(ids) == false)
            {
                string[] arr = ids.Split((",").ToCharArray());
                foreach (string strid in arr)
                {
                    if (string.IsNullOrEmpty(strid) == false)
                    {
                        list.Add(strid);
                    }
                }
            }
            return list;
        }

        public static double SafeDivision(double d1, double d2)
        {
            if (d2 == 0)
                //throw new System.DivideByZeroException();
                return 0;
            else
                return d1 / d2;
        }

        //public static int SafeDivision(int d1,int d2) {
        //    if(d2 == 0)
        //        //throw new System.DivideByZeroException();
        //        return 0;
        //    else
        //        return d1 / d2;
        //}

        //public static int SafeDivision(int? d1,int? d2) {
        //    if((d2 ?? 0) == 0)
        //        //throw new System.DivideByZeroException();
        //        return 0;
        //    else
        //        return (d1 ?? 0) / (d2 ?? 0);
        //}

        public static decimal SafeDivision(decimal d1, decimal d2)
        {
            if (d2 == 0)
                //throw new System.DivideByZeroException();
                return 0;
            else
                return d1 / d2;
        }

        public static decimal SafeDivision(decimal? d1, decimal? d2)
        {
            if ((d2 ?? 0) == 0)
                //throw new System.DivideByZeroException();
                return 0;
            else
                return (d1 ?? 0) / (d2 ?? 0);
        }

        private static string RemoveSymbols(string value)
        {
            if (string.IsNullOrEmpty(value) == false)
            {
                value = value.Replace("$", "").Replace("%", "").Replace(",", "").Replace("(", "-").Replace(")", "");
            }
            else
            {
                value = string.Empty;
            }
            return value;
        }

        public static decimal ToDecimal(string value)
        {
            value = RemoveSymbols(value);
            decimal returnValue;
            decimal.TryParse(value, NumberStyles.Any, null, out returnValue);
            return returnValue;
        }

        public static decimal ToDecimal(string value, int precision)
        {
            value = RemoveSymbols(value);
            decimal returnValue;
            decimal.TryParse(value, NumberStyles.Any, null, out returnValue);
            // toFixed
            value = returnValue.ToString("N" + precision);
            decimal.TryParse(value, NumberStyles.Any, null, out returnValue);
            return returnValue;
        }

        public static double ToDouble(string value)
        {
            value = RemoveSymbols(value);
            double returnValue;
            double.TryParse(value, NumberStyles.Any, null, out returnValue);
            return returnValue;
        }

        public static String ConvertString(object value)
        {
            if (value == null || value == DBNull.Value)
                return string.Empty;
            else
                return value.ToString();
        }

        public static string RemoveHTML(string input)
        {
            if (string.IsNullOrEmpty(input) == false)
            {
                return Regex.Replace(input, "<.*?>", String.Empty);
            }
            else
            {
                return "";
            }
        }

        public static Int32 ToInt32(string value)
        {
            value = RemoveSymbols(value);
            if (value.Contains("."))
            {
                decimal deValue = 0;
                decimal.TryParse(value, NumberStyles.Any, null, out deValue);
                return (Int32)deValue;
            }
            else
            {
                Int32 returnValue;
                Int32.TryParse(value, out returnValue);
                return returnValue;
            }
        }

        public static Int16 ToInt16(string value)
        {
            value = RemoveSymbols(value);
            if (value.Contains("."))
            {
                decimal deValue = 0;
                decimal.TryParse(value, NumberStyles.Any, null, out deValue);
                return (Int16)deValue;
            }
            else
            {
                Int16 returnValue;
                Int16.TryParse(value, out returnValue);
                return returnValue;
            }
        }

        public static Int64 ToInt64(string value)
        {
            value = RemoveSymbols(value);
            if (value.Contains("."))
            {
                decimal deValue = 0;
                decimal.TryParse(value, NumberStyles.Any, null, out deValue);
                return (Int64)deValue;
            }
            else
            {
                Int64 returnValue;
                Int64.TryParse(value, out returnValue);
                return returnValue;
            }
        }

        public static DateTime ToDateTime(string value)
        {
            DateTime returnValue;
            DateTime.TryParse(value, out returnValue);
            return returnValue.Year <= 1900 ? new DateTime(1900, 1, 1) : returnValue;
        }

        public static DateTime ToFromOADate(string value)
        {
            if (value.Contains("-") == true || value.Contains("/") == true)
            {
                return Helper.ToDateTime(value);
            }
            else
            {
                DateTime returnValue;
                double dateValue = 0;
                double.TryParse(value, out dateValue);
                returnValue = DateTime.FromOADate(dateValue);
                return returnValue.Year <= 1900 ? new DateTime(1900, 1, 1) : returnValue;
            }
        }

        public static bool CheckBoolean(string value)
        {
            bool calcValue = false;
            if (string.IsNullOrEmpty(value) == false)
                value = value.ToLower().Trim();
            else
                value = string.Empty;

            if (value.Contains("true"))
                calcValue = true;
            if (value.Contains("yes"))
                calcValue = true;
            if (value == "1")
                calcValue = true;
            if (value == "on")
                calcValue = true;

            return calcValue;
        }
    }

    public class DateTimeConverter : JsonConverter<DateTime>
  {
    public override DateTime Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
    {
      return Helper.ToDateTime(reader.GetString());
    }

    public override void Write(Utf8JsonWriter writer, DateTime value, JsonSerializerOptions options)
    {
      writer.WriteStringValue(value.ToLocalTime().ToString("yyyy-MM-ddTHH:mm:ss"));
    }
  }

  public class NullableDateTimeConverter : JsonConverter<DateTime?>
  {
    public override DateTime? Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
    {
      return reader.GetString() != null ? Helper.ToDateTime(reader.GetString()) : null;
    }

    public override void Write(Utf8JsonWriter writer, DateTime? value, JsonSerializerOptions options)
    {
      writer.WriteStringValue(value.HasValue ? value.Value.ToLocalTime().ToString("yyyy-MM-ddTHH:mm:ss") : "");
    }
  }

    public class BooleanConverter : JsonConverter<bool>
    {
        public override bool Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
        {
            return Helper.CheckBoolean(reader.GetString());
        }

        public override void Write(Utf8JsonWriter writer, bool value, JsonSerializerOptions options)
        {
            writer.WriteStringValue(value.ToString());
        }
    }

    public class NullableBooleanConverter : JsonConverter<bool?>
    {
        public override bool? Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
        {
            Console.WriteLine("reader.GetString()=" + reader.GetString());
            return Helper.CheckBoolean(reader.GetString());
        }

        public override void Write(Utf8JsonWriter writer, bool? value, JsonSerializerOptions options)
        {
            writer.WriteStringValue(value != null ? value.ToString() : "false");
        }
    }
}