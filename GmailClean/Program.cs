using Google.Apis.Auth.OAuth2;
using Google.Apis.Gmail.v1;
using Google.Apis.Gmail.v1.Data;
using Google.Apis.Services;
using Google.Apis.Util.Store;
using System;
using System.IO;
using System.Net;
using System.Text.RegularExpressions;
using System.Threading;

class Program
{
    static void Main()
    {
        // Set up the Gmail API
        var service = InitializeGmailService();

        // Specify the user's email address
        var userId = "me";

        // List all labels
        var labelsList = service.Users.Labels.List(userId).Execute().Labels;

        //labelsList = (from q in labelsList where q.Name.Contains("PepperCompleted") == true select q).ToList();

        // Specify the labels you want to filter by
        string[] ignoreLabels = { "backup", "priya", "IMPORTANT", "INBOX", "SENT", "DRAFT", "Religare", "Religare/Bills", "Religare/Old", "Resume", "Income Tax", "IncomeTax" };  // Replace with the actual label names

        int labelIndex = 0;
        foreach (var lbl in labelsList)
        {
            labelIndex += 1;
            string label = lbl.Name;
            int? cnt = (from q in ignoreLabels
                        where q.ToLower().Trim() == label.ToLower().Trim()
                        select q).Count();
            if ((cnt ?? 0) > 0)
            {
                //Console.WriteLine($"label:{label}");
                continue;
            }
            else
            {
                try
                {
                    // Specify the date range
                    DateTime startDate = DateTime.Now.AddYears(-20);
                    DateTime endDate = DateTime.Now.AddYears(-2);

                    //label = WebUtility.UrlEncode(label).Replace("+", "%20");
                    // Build the query string with label and date filters
                    string queryString = $"label:{label} after:{startDate:yyyy/MM/dd} before:{endDate:yyyy/MM/dd}";

                    string nextPageToken = null;
                    // List messages that match the query
                    var listRequest = service.Users.Messages.List(userId);
                    listRequest.Q = queryString;
                    listRequest.MaxResults = int.MaxValue; // Set to a large number
                    do
                    {
                        // Set the page token for the next page, if available
                        listRequest.PageToken = nextPageToken;

                        var response = listRequest.Execute();
                        var messages = response.Messages;
                        if (messages != null)
                        {
                            int i = 0;
                            foreach (var message in messages)
                            {
                                i += 1;
                                // Get the full message details
                                var fullMessage = service.Users.Messages.Get(userId, message.Id).Execute();

                                // Extract the date of the message
                                DateTime messageDate = GetDateFromMessage(fullMessage);

                                var subjectHeader = fullMessage.Payload.Headers.FirstOrDefault(header => header.Name == "Subject");
                                string subject = "";
                                if (subjectHeader != null)
                                {
                                    subject = subjectHeader.Value;
                                }
                                //Console.WriteLine($"messageDate: {messageDate}, Subject:{subject}" + "," + label + " - " + i + " of " + messages.Count);
                                //Check if the message date is within the specified range
                                if (messageDate >= startDate && messageDate <= endDate)
                                {
                                    // Delete or perform other actions on the messages as needed
                                    service.Users.Messages.Delete(userId, message.Id).Execute();
                                    Console.WriteLine($"Deleted message with messageDate: {messageDate}, Subject:{subject} message.Id: {message.Id}");
                                }
                            }
                        }

                        // Set the token for the next page
                        nextPageToken = response.NextPageToken;
                    } while (!string.IsNullOrEmpty(nextPageToken));
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Exception ex=" + ex.Message);
                    if (ex.InnerException != null)
                    {
                        Console.WriteLine("Exception ex.InnerException=" + ex.InnerException.Message);
                    }
                }
            }

            Console.WriteLine(label + " (" + labelIndex + " of " + labelsList.Count + ")");
        }

        Console.WriteLine("Completed");
    }

    private static GmailService InitializeGmailService()
    {
        UserCredential credential;

        using (var stream = new FileStream("credentials.json", FileMode.Open, FileAccess.Read))
        {
            string credPath = "token.json";
            credential = GoogleWebAuthorizationBroker.AuthorizeAsync(
                GoogleClientSecrets.Load(stream).Secrets,
                new[] { GmailService.Scope.GmailModify, GmailService.Scope.MailGoogleCom },
                "user",
                CancellationToken.None,
                new FileDataStore(credPath, true)).Result;
        }

        var service = new GmailService(new BaseClientService.Initializer()
        {
            HttpClientInitializer = credential,
            ApplicationName = "YourAppName",
        });

        return service;
    }


    private static DateTime ConvertMailDateTimeToUtc(string gmailDate)
    {
        DateTime result = Convert.ToDateTime("01/01/1900");
        DateTime parsedDate;
        if (DateTime.TryParse(gmailDate, out parsedDate))
        {
            //DateTime parsedDate = DateTime.Parse(gmailDate);
            result = parsedDate.ToUniversalTime();
        }
        else
        {
            result = ConvertMailDateTime(gmailDate);
        }
        return result;
    }

    private static DateTime ConvertMailDateTime(string value)
    {
        DateTime result = Convert.ToDateTime("01/01/1900");
        try
        {
            Regex regex = new Regex(
                @"(?<day>[a-zA-Z]{3}),\s+(?<date>\d{1,2})\s+(?<month>[a-zA-Z]{"
                + @"3})\s+(?<year>\d{4})\s+(?<hour>\d{2})\:(?<minute>\d{2})\:(?<"
                + @"second>\d{2})\s+(?<sign>[+,-])(?<diff_hours>\d{1,2})(?<diff_"
                + @"minutes>\d{1,2})\s+\((?<zone>.*)\)",
                RegexOptions.IgnoreCase
                | RegexOptions.Multiline
                | RegexOptions.IgnorePatternWhitespace
                | RegexOptions.Compiled
                );
            string day = "";
            string date = "";
            string month = "";
            string year = "";
            string hour = "";
            string minute = "";
            string second = "";
            string sign = "";
            string diffHours = "";
            string diffMinutes = "";
            string zone = "";
            MatchCollection matches = null;
            if (regex.IsMatch(value))
            {
                matches = regex.Matches(value);
            }
            else
            {
                regex = new Regex(
                @"(?<day>[a-zA-Z]{3}),\s+(?<date>\d{1,2})\s+(?<month>[a-zA-Z]{"
                + @"3})\s+(?<year>\d{4})\s+(?<hour>\d{2})\:(?<minute>\d{2})\:(?<"
                + @"second>\d{2})\s+(?<sign>[+,-])(?<diff_hours>\d{1,2})(?<diff_"
                + @"minutes>\d{1,2})",
                RegexOptions.IgnoreCase
                | RegexOptions.Multiline
                | RegexOptions.IgnorePatternWhitespace
                | RegexOptions.Compiled
                );
                if (regex.IsMatch(value))
                {
                    matches = regex.Matches(value);
                }
                else
                {
                    regex = new Regex(
                @"(?<day>[a-zA-Z]{3}),\s+(?<date>\d{1,2})\s+(?<month>[a-zA-Z]{"
                + @"3})\s+(?<year>\d{4})\s+(?<hour>\d{2})\:(?<minute>\d{2})\:(?<"
                + @"second>\d{2})",
                RegexOptions.IgnoreCase
                | RegexOptions.Multiline
                | RegexOptions.IgnorePatternWhitespace
                | RegexOptions.Compiled
                );
                    if (regex.IsMatch(value))
                    {
                        matches = regex.Matches(value);
                    }
                }
            }
            if (matches != null)
            {
                foreach (Match m in matches)
                {
                    for (int i = 0; i < m.Groups.Count; i++)
                    {
                        day = m.Groups["day"].Value;
                        date = m.Groups["date"].Value;
                        month = m.Groups["month"].Value;
                        year = m.Groups["year"].Value;
                        hour = m.Groups["hour"].Value;
                        minute = m.Groups["minute"].Value;
                        second = m.Groups["second"].Value;
                        sign = m.Groups["sign"].Value;
                        diffHours = m.Groups["diff_hours"].Value;
                        diffMinutes = m.Groups["diff_minutes"].Value;
                        zone = m.Groups["zone"].Value;

                        result = Convert.ToDateTime(year + "/" + month + "/" + date + " " + hour + ":" + minute + ":" + second);
                        if (string.IsNullOrEmpty(sign) == false
                            && string.IsNullOrEmpty(diffHours) == false
                            && string.IsNullOrEmpty(diffMinutes) == false)
                        {
                            double d = Convert.ToDouble(sign + diffHours);
                            result = result.AddHours(d);
                            d = Convert.ToDouble(sign + diffMinutes);
                            result = result.AddMinutes(d);
                        }
                    }
                }
            }
        }
        catch { }
        return result;
    }

    private static DateTime GetDateFromMessage(Message message)
    {
        // Extract the date from the message headers
        var dateHeader = message.Payload.Headers.FirstOrDefault(header => header.Name == "Date");

        if (dateHeader != null)
        {
            return ConvertMailDateTimeToUtc(dateHeader.Value);
        }
        // Default to the current date if the date cannot be parsed
        return DateTime.Now;
    }
}
