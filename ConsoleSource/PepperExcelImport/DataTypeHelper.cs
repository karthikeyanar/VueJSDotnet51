using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

namespace PepperExcelImport {
    public static class DataTypeHelper {

        public static string GetLetter(int intCol)
        {

            int intFirstLetter = ((intCol) / 676) + 64;
            int intSecondLetter = ((intCol % 676) / 26) + 64;
            int intThirdLetter = (intCol % 26) + 65;  // ' SHOULD BE + 64?

            char FirstLetter = (intFirstLetter > 64) ? (char)intFirstLetter : ' ';
            char SecondLetter = (intSecondLetter > 64) ? (char)intSecondLetter : ' ';
            char ThirdLetter = (char)intThirdLetter;

            return string.Concat(FirstLetter, SecondLetter, ThirdLetter).Trim();
        }

        public static decimal SafeDivision(decimal d1,decimal d2) {
            if(d2 == 0)
                //throw new System.DivideByZeroException();
                return 0;
            else
                return d1 / d2;
        }

        public static decimal ToDecimal(string value) {
            value = value.Replace(",","").Replace("$","").Replace("%","").Trim();
            decimal returnValue;
            decimal.TryParse(value,out returnValue);
            return Math.Round(returnValue,4);
        }

        public static string ToString(object value) {
            string returnValue = Convert.ToString(value);
            if(returnValue == "0") { returnValue = string.Empty; }
            return returnValue;
        }

        public static Int16 ToInt16(string value) {
            value = value.Replace(",","").Replace("$","").Trim();
            Int16 returnValue;
            Int16.TryParse(value,out returnValue);
            return returnValue;
        }

        public static Int32 ToInt32(string value) {
            value = value.Replace(",","").Replace("$","").Trim();
            int returnValue;
            Int32.TryParse(value,out returnValue);
            return returnValue;
        }

        public static DateTime ToDateTime(string value) {
            DateTime returnValue;
            DateTime.TryParse(value,out returnValue);
            return returnValue.Year <= 1900 ? new DateTime(1900,1,1) : returnValue;
        }

        public static DateTime ToFromOADate(string value) {
            DateTime returnValue;
            double dateValue = 0;
            double.TryParse(value,out dateValue);
            returnValue = DateTime.FromOADate(dateValue);
            return returnValue.Year <= 1900 ? new DateTime(1900,1,1) : returnValue;
        }

        public static bool CheckBoolean(string value) {
            value = value.Replace(",","").Replace("$","").Trim();
            bool returnValue = false;
            if(string.IsNullOrEmpty(value)) {
                returnValue = false;
            } else {
                if(value.ToLower().Contains("true"))
                    returnValue = true;
                if(value.ToLower().Contains("yes"))
                    returnValue = true;
            }
            return returnValue;
        }

        public static string GetValue(this DataRow row,string columnName) {
            string value = string.Empty;
            if(string.IsNullOrEmpty(columnName) == false) {
                columnName = columnName.Trim();
                if(string.IsNullOrEmpty(columnName) == false) {
                    try {
                        value = row[columnName].ToString();
                    } catch { }
                }
            }
            return value;
        }


        public static decimal TruncateDecimalPlaces(decimal val,int places) {
            var dv = DecimalPow(10m,places);
            return Math.Truncate(dv * val) / dv;
        }

        private static decimal DecimalPow(decimal b,int exp) {
            decimal result = 1m;
            if(exp >= 0) {
                while(exp > 0) {
                    if(exp % 2 != 0) {
                        result *= b;
                    }
                    exp /= 2;
                    b *= b;
                }
            } else {
                do {
                    if(exp % 2 != 0) {
                        result /= b;
                    }
                    exp /= 2;
                    b *= b;
                } while(exp < 0);
            }
            return result;
        }

        public static Int64 ToInt64(string value) {
            value = RemoveSymbols(value);
            if(value.Contains(".")) {
                decimal deValue = 0;
                decimal.TryParse(value,out deValue);
                return (Int64)deValue;
            } else {
                Int64 returnValue;
                Int64.TryParse(value,out returnValue);
                return returnValue;
            }
        }

        public static bool ToBoolean(object value) {
            if(value == null)
                return false;
            value = Convert.ToString(value);
            if(value.ToString().ToLower() == "true" || value.ToString() == "1" || value.ToString().ToLower() == "yes" || value.ToString().ToLower() == "y")
                return true;
            else
                return false;
        }

        private static string RemoveSymbols(string value) {
            if(string.IsNullOrEmpty(value) == false) {
                value = value.Replace("$","").Replace("%","").Replace(",","").Replace("(","-").Replace(")","");
            }
            return (value == null ? "" : value);
        }
    }
}