using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using System.IO;
using System.Configuration;
using System.Data; 
using System.Threading;  
using System.Data.Objects; 
using System.Data.SqlClient;
using System.Collections.ObjectModel;
using System.Collections;
using Dapper;
using System.Text.RegularExpressions;
using System.Security.Policy;
using CsvHelper; 

namespace PepperExcelImport {
	 
	public class XIRRData {
		public DateTime Date { get; set; }
		public decimal Value { get; set; }
	}

	class Program {
        static void Main(string[] args) {
			ImportDealUnderlyingDirect.Import();
            ImportDealUnderlyingDirect.ImportAllocation();
            ImportDealUnderlyingDirect.CalculateXIRR();
            Console.WriteLine("Press any key to continue........");
			Console.ReadLine();
		}
	}
}
