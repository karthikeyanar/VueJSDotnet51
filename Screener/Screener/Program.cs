using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text.RegularExpressions;

public class SalesData
{
    public List<string> Headers { get; set; }
    public List<string> Values { get; set; }
}

class Program
{
    static void Main()
    {
        string rootHtmlContent = System.IO.File.ReadAllText("C:\\Users\\kart\\Desktop\\scree\\test.html");
        string pattern = @"<section\s+id=""quarters""[^>]*>(.*?)<\/section>";

        // Use Regex.Match to find the section with id="quarters"
        Match match = Regex.Match(rootHtmlContent, pattern, RegexOptions.Singleline);

        if (match.Success)
        {
            string htmlContent = match.Groups[1].Value;
          

            // Define the regular expressions to match the table headers and rows
            string headerPattern = "<th[^>]*>(.*?)</th>";
            string rowPattern = "<tr[^>]*>(.*?)</tr>";
            string colPattern = "<td[^>]*>(.*?)</td>";

            // Initialize lists to store the header and data
            List<string> headers = new List<string>();
            List<SalesData> salesDataList = new List<SalesData>();

            // Match the table headers using the header pattern
            var headerMatches = Regex.Matches(htmlContent, headerPattern, RegexOptions.Singleline);

            // Extract the column headers
            foreach (Match headerMatch in headerMatches)
            {
                string header = Regex.Replace(headerMatch.Groups[1].Value, "<.*?>", "").Trim();
                if (string.IsNullOrEmpty(header) == true)
                {
                    header = "Key";
                }
                headers.Add(header);
            }

            // Match the table rows using the row pattern
            var rowMatches = Regex.Matches(htmlContent, rowPattern, RegexOptions.Singleline);

            // Extract the data from each row
            foreach (Match rowMatch in rowMatches)
            {
                // Get the content of the current row
                string rowContent = rowMatch.Groups[1].Value;

                // Match the table columns using the column pattern
                var colMatches = Regex.Matches(rowContent, colPattern, RegexOptions.Singleline);

                // Extract the data values from each column
                List<string> values = new List<string>();
                foreach (Match colMatch in colMatches)
                {
                    string v = string.Empty;
                    string valueStr = Regex.Replace(colMatch.Groups[1].Value, @"[^\d]", "");
                    if (int.TryParse(valueStr, out int value))
                    {
                        v = value.ToString();
                    }
                    else
                    {
                        string pattern2 = @"<button[^>]*>(.*?)<\/button>";
                        Match match2 = Regex.Match(colMatch.Groups[1].Value, pattern2, RegexOptions.Singleline);
                        if (match2.Success)
                        {
                            string innerText = match2.Groups[1].Value;
                            v = Regex.Replace(innerText, @"<[^>]+>|&nbsp;", "").Replace("+","").Trim();
                        }
                        else
                        {
                            v = RemoveNewLines(colMatch.Groups[1].Value).Trim();
                        }
                    }
                    if (string.IsNullOrEmpty(v) == false && v.Contains("Raw PDF") == true)
                    {
                        break;
                    }
                    else
                    {
                        if (string.IsNullOrEmpty(v) == false && v.Contains("Raw PDF") == false)
                        {
                            if(v.Contains("EPS in R") == true)
                            {
                                v = "EPS";
                            }
                            values.Add(v);
                        }
                    }
                }
                if (values.Count > 0)
                {
                    // Create a new SalesData object and add it to the list
                    SalesData salesData = new SalesData
                    {
                        Headers = headers, // Assuming the first header is for quarters
                        Values = values
                    };
                    salesDataList.Add(salesData);
                }
            }

            foreach (var h in headers)
            {
                Console.WriteLine(h);
            }
            // Now, the 'salesDataList' contains the table content as a list of objects
            // You can do further processing or display the data as needed
            foreach (var salesData in salesDataList)
            {
                Console.WriteLine($"Headers:  {string.Join(", ", salesData.Headers)}, Values: {string.Join(", ", salesData.Values)}");
            }
        }
        else
        {
            Console.WriteLine("Section with id=\"quarters\" not found.");
        }

        Console.ReadLine();
    }

    public static string RemoveNewLines(string input)
    {
        string pattern = @"\r\n";
        string replacement = ""; // Replace with an empty string to remove \r\n
        string result = Regex.Replace(input, pattern, replacement);
        return result;
    }
}




//// See https://aka.ms/new-console-template for more information
//using System.Net.Http;
//using System.Text.RegularExpressions;

//ReadPath();

//Console.WriteLine("Hello, World!");
//Console.WriteLine();

//public class SalesData
//{
//    public string Quarter { get; set; }
//    public List<decimal> Values { get; set; }
//}

//static void ReadPath()
//{
//    string htmlContent = System.IO.File.ReadAllText("C:\\Users\\kart\\Desktop\\scree\\test.html");
//    // Define the regular expression pattern to match the section with id="quarters"
//    string pattern = @"<section\s+id=""quarters""[^>]*>(.*?)<\/section>";

//    // Use Regex.Match to find the section with id="quarters"
//    Match match = Regex.Match(htmlContent, pattern, RegexOptions.Singleline);

//    if (match.Success)
//    {
//        string sectionContent = match.Groups[1].Value;
//        Console.WriteLine(sectionContent);
//    }
//    else
//    {
//        Console.WriteLine("Section with id=\"quarters\" not found.");
//    }
//}

//static void ReadQuarters(string htmlContent)
//{
//    // Define the regular expressions to match the table headers and rows
//    string headerPattern = "<th[^>]*>(.*?)</th>";
//    string rowPattern = "<tr[^>]*>(.*?)</tr>";
//    string colPattern = "<td[^>]*>(.*?)</td>";

//    // Initialize lists to store the header and data
//    List<string> headers = new List<string>();
//    List<SalesData> salesDataList = new List<SalesData>();

//    // Match the table headers using the header pattern
//    var headerMatches = Regex.Matches(htmlContent, headerPattern, RegexOptions.Singleline);

//    // Extract the column headers
//    foreach (Match headerMatch in headerMatches)
//    {
//        string header = Regex.Replace(headerMatch.Groups[1].Value, "<.*?>", "").Trim();
//        headers.Add(header);
//    }

//    // Match the table rows using the row pattern
//    var rowMatches = Regex.Matches(htmlContent, rowPattern, RegexOptions.Singleline);

//    // Extract the data from each row
//    foreach (Match rowMatch in rowMatches)
//    {
//        // Get the content of the current row
//        string rowContent = rowMatch.Groups[1].Value;

//        // Match the table columns using the column pattern
//        var colMatches = Regex.Matches(rowContent, colPattern, RegexOptions.Singleline);

//        // Extract the data values from each column
//        List<int> values = new List<int>();
//        foreach (Match colMatch in colMatches)
//        {
//            string valueStr = Regex.Replace(colMatch.Groups[1].Value, @"[^\d]", "");
//            if (int.TryParse(valueStr, out int value))
//            {
//                values.Add(value);
//            }
//        }

//        // Create a new SalesData object and add it to the list
//        SalesData salesData = new SalesData
//        {
//            Quarter = headers[0], // Assuming the first header is for quarters
//            Values = values
//        };
//        salesDataList.Add(salesData);
//    }

//    // Now, the 'salesDataList' contains the table content as a list of objects
//    // You can do further processing or display the data as needed
//    foreach (var salesData in salesDataList)
//    {
//        Console.WriteLine($"Quarter: {salesData.Quarter}, Values: {string.Join(", ", salesData.Values)}");
//    }
//}