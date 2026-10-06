using ClosedXML.Excel;
using Newtonsoft.Json;

using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.IO;
//using static WhizibleAPI.Controllers.MyTimesheetController;
using System.Text;
using System.Net.Http;
using System.Net;
using System.Net.Http.Headers;

namespace WhizibleAPI.Controllers
{
    //Added by Vishal Mane on 20/08/2025 for Excel Upload functionality of Expleo
    public class ExcelUploadTimesheetController : ApiController
    {

        [HttpPost]
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DownloadTimesheetTemplate([FromBody] ExcelUploadParameters taskParameters)
        {
            try
            {
                string strtResult = string.Empty;
                var fileBytes = GenerateTimesheetExcel(taskParameters.dtFromDate, taskParameters.dtToDate, taskParameters.intEmployeeID);
                string folderPath = HttpContext.Current.Server.MapPath("../../../Attachments/ExcelTSTemplate/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }
                //var fileName = $"Timesheet_{weekStart:yyyyMMdd}.xlsx";
                var fileName = $"Timesheet_{Guid.NewGuid()}.xlsx";
                string filePath = Path.Combine(folderPath, fileName);
                File.WriteAllBytes(filePath, fileBytes);
                return fileName;
            }
            catch (Exception er)
            {
                return "Bad Request";
            }
        }
        public byte[] GenerateTimesheetExcel(string weekStDate, string weekEdDate, int userId)
        {
            // 1. Fetch all data at once
            var resources = GetResourceDataFromStoredProcedure(userId, weekStDate, weekEdDate);
            var projects = GetProjectNamesFromStoredProcedure(userId, weekStDate, weekEdDate);
            var tasks = GetTaskDataFromStoredProcedure(weekStDate, weekEdDate, userId);

            DateTime weekStartDate = DateTime.ParseExact(weekStDate, "M/d/yyyy", null);

            //To get dynamic dropdown for Duration in excel
            string strSQL;
            strSQL = "usp_Whizible2_Get_ProjectTimeSettings ";
            DataTable ProjectListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
            string restrictTsByMinHoursStr = "08:00"; // Default values in case the DataTable is empty
            string restrictTsByMinHoursHalfStr = "04:00";
            if (ProjectListTable != null && ProjectListTable.Rows.Count > 0)
            {
                restrictTsByMinHoursStr = ProjectListTable.Rows[0]["RestrictTSByMinHours"].ToString();
                restrictTsByMinHoursHalfStr = ProjectListTable.Rows[0]["RestrictTSByMinHours_HalfDay"].ToString();
            }
            var durationValues = new List<string>();
            durationValues.Add(restrictTsByMinHoursStr);
            durationValues.Add(restrictTsByMinHoursHalfStr);
            using (var workbook = new XLWorkbook())
            {
                var ws = workbook.AddWorksheet("Timesheet");

                // Header Part
                ws.Cell(1, 1).Value = "Resource Name";
                ws.Cell(1, 2).Value = "Project Name";
                ws.Cell(1, 3).Value = "Task Name";

                for (int i = 0; i < 7; i++)
                {
                    //var cell = ws.Cell(1, i + 4);
                    //cell.Value = weekStartDate.AddDays(i).ToString("dd MMM yyyy");
                    //cell.Style.Font.Bold = true;
                    //cell.Style.Fill.BackgroundColor = XLColor.LightGray;
                    // Check if the current day is a weekend (Saturday or Sunday)
                    var cell = ws.Cell(1, i + 4);
                    DateTime currentDate = weekStartDate.AddDays(i);
                    cell.Value = currentDate.ToString("dd MMM yyyy");
                    cell.Style.Font.Bold = true;
                    if (currentDate.DayOfWeek == DayOfWeek.Saturday || currentDate.DayOfWeek == DayOfWeek.Sunday)
                    {
                        // Set the background color to red for weekends
                        cell.Style.Fill.BackgroundColor = XLColor.Redwood;
                    }
                    else
                    {
                        // Keep the original color for weekdays
                        cell.Style.Fill.BackgroundColor = XLColor.LightGray;
                    }
                }
                for (int row = 2; row <= 101; row++)
                {
                    for (int col2 = 4; col2 <= 10; col2++)
                    {
                        ws.Cell(row, col2).Style.NumberFormat.Format = "@";
                    }
                }
                // 2. Create the hidden sheets for dependent dropdown data
                var resourceListSheet = workbook.AddWorksheet("ResourceData");
                var projectListSheet = workbook.AddWorksheet("AllProjects"); // NEW SHEET for VLOOKUP data
                var resourceProjectMappingSheet = workbook.AddWorksheet("ResourceProjectMapping"); // Renamed
                var taskMappingSheet = workbook.AddWorksheet("TaskData");
                var durationDataSheet = workbook.AddWorksheet("DurationData"); // NEW HIDDEN SHEET FOR DURATION

                // 3. Populate Resource List Sheet
                resourceListSheet.Cell(1, 1).Value = "ResourceName";
                resourceListSheet.Cell(1, 2).Value = "ResourceID";
                for (int i = 0; i < resources.Count; i++)
                {
                    resourceListSheet.Cell(i + 2, 1).Value = resources[i].ResourceName;
                    resourceListSheet.Cell(i + 2, 2).Value = resources[i].ResourceID;
                }
                var resourceNamesRange = resourceListSheet.Range(2, 1, resources.Count + 1, 1);
                workbook.NamedRanges.Add("ResourceNames", resourceNamesRange);

                // 4. Populate the new AllProjects sheet for VLOOKUP
                projectListSheet.Cell(1, 1).Value = "ProjectName";
                projectListSheet.Cell(1, 2).Value = "ProjectID";
                for (int i = 0; i < projects.Count; i++)
                {
                    projectListSheet.Cell(i + 2, 1).Value = projects[i].ProjectName;
                    projectListSheet.Cell(i + 2, 2).Value = projects[i].ProjectID;
                }

                // 5. Populate Resource-Project Mapping Sheet
                var groupedProjectsByResource = projects.GroupBy(p => p.ResourceID);
                int col = 1;
                foreach (var group in groupedProjectsByResource)
                {
                    string namedRangeName = $"Resource_{group.Key}";
                    int row = 1;
                    foreach (var project in group)
                    {
                        resourceProjectMappingSheet.Cell(row, col).Value = project.ProjectName;
                        row++;
                    }
                    var projectRange = resourceProjectMappingSheet.Range(1, col, row - 1, col);
                    workbook.NamedRanges.Add(namedRangeName, projectRange);
                    col++;
                }

                // 6. Populate Task Mapping Sheet
                var groupedTasks = tasks.GroupBy(t => new { t.ProjectID, t.ResourceID }); ;
                col = 1;
                foreach (var group in groupedTasks)
                {
                    // The named range is now a combination of ResourceID and ProjectID
                    string namedRangeName = $"Project_{group.Key.ProjectID}_Resource_{group.Key.ResourceID}";

                    int row = 1;
                    foreach (var task in group)
                    {
                        taskMappingSheet.Cell(row, col).Value = task.TaskName;
                        row++;
                    }
                    var taskRange = taskMappingSheet.Range(1, col, row - 1, col);
                    workbook.NamedRanges.Add(namedRangeName, taskRange);
                    col++;
                }

                // --- NEW LOGIC TO APPLY DURATION DROPDOWN ---
                durationDataSheet.Cell(1, 1).Value = "Duration";
                //for (int i = 0; i < durationValues.Count; i++)
                //{
                //    durationDataSheet.Cell(i + 2, 1).Value = durationValues[i];
                //}                
                for (int i = 0; i < durationValues.Count; i++)
                {
                    var durationCell = durationDataSheet.Cell(i + 2, 1);

                    // Force entry as text
                    durationCell.SetValue<string>(durationValues[i]);
                    durationCell.Style.NumberFormat.Format = "@";
                }
                var durationNamesRange = durationDataSheet.Range(2, 1, durationValues.Count + 1, 1);
                workbook.NamedRanges.Add("DurationList", durationNamesRange);
                // --- END NEW LOGIC ---

                // 7. Apply dropdowns with three-level dependent logic allowing manual entry also                
                for (int row = 2; row <= 101; row++)
                {
                    // Resource Name Dropdown (Column 1)
                    var resourceValidation = ws.Cell(row, 1).DataValidation;
                    resourceValidation.List("ResourceNames");
                    resourceValidation.IgnoreBlanks = true;
                    resourceValidation.ShowErrorMessage = true; // Set to false to allow manual entry without a pop-up error

                    // Project Name Dropdown (Dependent on Resource)
                    var projectValidation = ws.Cell(row, 2).DataValidation;
                    projectValidation.List($"=INDIRECT(\"Resource_\" & VLOOKUP(A{row}, ResourceData!A:B, 2, FALSE))");
                    projectValidation.IgnoreBlanks = true;
                    projectValidation.ShowErrorMessage = true; // Set to false to allow manual entry

                    // Task Name Dropdown (Dependent on Project)
                    var taskValidation = ws.Cell(row, 3).DataValidation;
                    taskValidation.List($"=INDIRECT(\"Project_\" & VLOOKUP(B{row}, AllProjects!A:B, 2, FALSE) & \"_Resource_\" & VLOOKUP(A{row}, ResourceData!A:B, 2, FALSE))");
                    taskValidation.IgnoreBlanks = true;
                    taskValidation.ShowErrorMessage = true; // Set to false to allow manual entry

                    // --- NEW LOGIC TO APPLY DURATION DROPDOWN ---
                    for (int col2 = 4; col2 <= 10; col2++)
                    {
                        var durationValidation = ws.Cell(row, col2).DataValidation;
                        durationValidation.List("DurationList");
                        durationValidation.IgnoreBlanks = true;
                        durationValidation.ShowErrorMessage = false;
                    }

                    // --- END NEW LOGIC ---
                }
                ws.Columns().AdjustToContents();

                // Hide the sheets
                resourceListSheet.Hide();
                projectListSheet.Hide(); // Hide the new sheet
                resourceProjectMappingSheet.Hide();
                taskMappingSheet.Hide();
                durationDataSheet.Hide(); // NEW: Hide the duration data sheet

                using (var stream = new MemoryStream())
                {
                    workbook.SaveAs(stream);
                    return stream.ToArray();
                }
            }
        }

        // New function to get the list of resources and their IDs
        private List<ResourceData> GetResourceDataFromStoredProcedure(int UserID, string weekStDate, string weekEdDate)
        {
            var resources = new List<ResourceData>();
            string strSQL;
            IDataReader sdr;

            // Assuming a stored procedure returns ResourceID and ResourceName for a given user
            strSQL = "usp_Whizible2_ProxyUser_ExcelUpload " + UserID + "";

            sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            while (sdr.Read())
            {
                resources.Add(new ResourceData
                {
                    ResourceID = Convert.ToInt32(sdr["ResourceID"]),
                    ResourceName = sdr["ResourceName"].ToString()
                });
            }
            return resources;
        }

        // Modified function to get projects based on a ResourceID
        private List<ProjectData> GetProjectNamesFromStoredProcedure(int UserID, string weekStDate, string weekEdDate)
        {
            var projects = new List<ProjectData>();
            string strSQL;
            IDataReader sdr;

            // Assuming the SP returns ProjectID, ProjectName, and ResourceID for a given resource
            strSQL = "usp_Whizible2_GetProjectsForAllResources " + UserID + "";

            sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            while (sdr.Read())
            {
                projects.Add(new ProjectData
                {
                    ProjectID = Convert.ToInt32(sdr["ProjectID"]),
                    ProjectName = sdr["ProjectName"].ToString(),
                    ResourceID = Convert.ToInt32(sdr["ResourceID"])
                });
            }
            return projects;
        }

        // This function remains largely the same but its output will be used in the new logic
        private List<TaskData> GetTaskDataFromStoredProcedure(string weekStDate, string weekEdDate, int UserID)
        {
            var tasks = new List<TaskData>();
            IDataReader sdr;
            string strSQL;
            string strWhichTask = "Pending";

            strSQL = "usp_Whizible2_sel_TaskList_ExcelUpload " + UserID + ",'" + weekStDate + "','" + weekEdDate + "'";
            strSQL += ",NULL";
            strSQL += ",'" + strWhichTask + "'";

            sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            while (sdr.Read())
            {
                tasks.Add(new TaskData
                {
                    TaskID = Convert.ToInt32(sdr["TaskID"]),
                    TaskName = sdr["TaskName"].ToString(),
                    ProjectID = Convert.ToInt32(sdr["ProjectID"]),
                    ResourceID = Convert.ToInt32(sdr["ResourceID"])
                });
            }
            return tasks;
        }

        [HttpPost]
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting (usp_Whizible2_Ins_tbl_PM_TimeSheet / DailyActivity ExcelUpload)
        public object ExcelUpload()
        {   //Added by Vishal Mane on 29/09/2025 to save uploaded file for further use 
            const string UploadDirectory = "../../../Attachments//UploadedExcelFiles/";
            //HttpContext.Current.Server.MapPath("../../../Attachments/UploadedExcelFiles/");
            //End of Added by Vishal Mane on 29/09/2025 to save uploaded file for further use 
            // Variable to hold the file's data in memory
            byte[] fileBytes = null;
            string UploadedfileName = "";
            try
            {
                var httpRequest = HttpContext.Current.Request;
                var file = httpRequest.Files["UploadedFile"];
                var FromDate = HttpContext.Current.Request.Form["dtFromDate"];
                var ToDate = HttpContext.Current.Request.Form["dtToDate"];
                var UserName = HttpContext.Current.Request.Form["UserName"];
                var UserID = HttpContext.Current.Request.Form["intEmployeeID"];
                string fileName = file.FileName;
                UploadedfileName = file.FileName;
                int timesheetid = 0;
                string Flag = "0";
                StringBuilder sb = new StringBuilder();
                if (file != null)
                {
                    using (var memoryStream = new MemoryStream())
                    {
                        file.InputStream.CopyTo(memoryStream);
                        fileBytes = memoryStream.ToArray(); // Store content in byte array
                    }

                    using (var stream = file.InputStream)
                    {
                        using (var workbook = new XLWorkbook(stream))
                        {
                            var worksheet = workbook.Worksheet("Timesheet");
                            //var projectNames = GetProjectNamesFromStoredProcedure(1, FromDate, ToDate);
                            var columnNames = new List<string>();
                            var firstRow = worksheet.Row(1);
                            var errorMessages = new List<string>();
                            // var rowCount = worksheet.RowsUsed().Count();

                            for (int col = 1; col <= firstRow.CellCount(); col++)
                            {
                                var cellValue = firstRow.Cell(col).Value.ToString();
                                if (!string.IsNullOrWhiteSpace(cellValue))  // Only count non-empty cells
                                {
                                    string columnName = firstRow.Cell(col).Value.ToString();
                                    columnNames.Add(columnName);  // Add the column name to the list
                                }
                            }
                            // Validate correct Header Names to check Timesheet submitted columns are correct or not 
                            bool isValid = true;
                            var rowCount = worksheet.RowsUsed().Count();
                            if (firstRow.Cell(1).Value.ToString().Trim() != "Resource Name")
                            {
                                errorMessages.Add("Invalid Templated Used");
                                isValid = false;
                            }
                            else if (firstRow.Cell(2).Value.ToString().Trim() != "Project Name")
                            {
                                errorMessages.Add("Invalid Templated Used");
                                isValid = false;
                            }
                            else if (firstRow.Cell(3).Value.ToString().Trim() != "Task Name")
                            {
                                errorMessages.Add("Invalid Templated Used");
                                isValid = false;
                            }
                            else if (rowCount == 1)
                            {                                
                                errorMessages.Add("Invalid Templated Used/Excel is empty");
                                isValid = false;
                            }
                            //else if (rowCount > 101) // Including header row
                            //{
                            //    errorMessages.Add("Maximum 100 records can be uploaded in a single file.");
                            //    isValid = false;
                            //}
                            List<DateTime> foundDatesInExcel = new List<DateTime>();
                            if (isValid == true)
                            {
                                //DateTime fromDate = DateTime.Parse(FromDate);
                                //DateTime toDate = DateTime.Parse(ToDate);

                                DateTime fromDate = DateTime.ParseExact(FromDate, "M/d/yyyy", null);
                                DateTime toDate = DateTime.ParseExact(ToDate, "M/d/yyyy", null);

                                for (int col = 4; col <= 10; col++)
                                {
                                    var dateValue = firstRow.Cell(col).Value.ToString();
                                    DateTime columnDate;
                                    if (isValid == true)
                                    {
                                        if (DateTime.TryParse(dateValue, out columnDate))
                                        {
                                            if (columnDate < fromDate || columnDate > toDate)
                                            {
                                                //errorMessages.Add("Invalid Templated Used");
                                                errorMessages.Add("Invalid template selected. The dates in the template do not match the chosen week.");                                                
                                                isValid = false;
                                                break;
                                            }                                            
                                        }
                                        foundDatesInExcel.Add(columnDate.Date);
                                    }
                                }
                            }                            
                            if (isValid)
                            {
                                DateTime fromDate1 = DateTime.ParseExact(FromDate, "M/d/yyyy", null);
                                DateTime toDate1 = DateTime.ParseExact(ToDate, "M/d/yyyy", null);
                                foreach (var item in foundDatesInExcel)
                                {
                                    if (item < fromDate1 || item > toDate1)
                                    {                                        
                                        errorMessages.Add("Invalid template selected. The dates in the template do not match the chosen week.");
                                        isValid = false;
                                        break;
                                    }
                                }
                                
                            }

                            if (isValid == true)
                            {
                                if (rowCount > 101) // Including header row
                                {
                                    errorMessages.Add("Maximum 100 records can be uploaded in a single file.");
                                    isValid = false;
                                }
                            }
                            var GRequestID = 0;
                            if (isValid == true)
                            {
                                string strSQL;
                                strSQL = "Exec usp_Whizible2_Ins_tbl_PM_TimeSheet_ExcelUploadStatus '" + HttpUtility.UrlDecode(Convert.ToString(UserID)) + "'," +
                                    "'" + HttpUtility.UrlDecode(Convert.ToString(FromDate)) + "'," +
                                    "'" + HttpUtility.UrlDecode(Convert.ToString(ToDate)) + "'," +
                                    "'" + HttpUtility.UrlDecode(Convert.ToString(UserName)) + "'," +
                                    "'" + HttpUtility.UrlDecode(Convert.ToString(fileName)) + "'," +
                                    "NULL";
                                string RequestID;
                                RequestID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
                                GRequestID = Convert.ToInt32(RequestID);
                            }
                            else
                            {
                                string strSQL;
                                strSQL = "Exec usp_Whizible2_Ins_tbl_PM_TimeSheet_ExcelUploadStatus '" + HttpUtility.UrlDecode(Convert.ToString(UserID)) + "'," +
                                    "'" + HttpUtility.UrlDecode(Convert.ToString(FromDate)) + "'," +
                                    "'" + HttpUtility.UrlDecode(Convert.ToString(ToDate)) + "'," +
                                    "'" + HttpUtility.UrlDecode(Convert.ToString(UserName)) + "'," +
                                    "'" + HttpUtility.UrlDecode(Convert.ToString(fileName)) + "'," +
                                    "'" + HttpUtility.UrlDecode(Convert.ToString(errorMessages[0])) + "'";
                                string Message;
                                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
                            }                            
                            var uniqueEntries = new HashSet<string>();
                            List<string> resourceNamesList = new List<string>();
                            List<string> projectNamesList = new List<string>();
                            List<string> taskNamesList = new List<string>();
                            var IsDuplicate = 0;
                            if (isValid == true)
                            {
                                var rowsData = new List<object>();
                                for (int row = 2; row <= rowCount; row++)
                                {
                                    var resourceName = worksheet.Cell(row, 1).Value.ToString().Trim();
                                    var projectName = worksheet.Cell(row, 2).Value.ToString().Trim();
                                    var taskName = worksheet.Cell(row, 3).Value.ToString().Trim();
                                    //string key = projectName + "|" + taskName;
                                    string key = resourceName + "|" + projectName + "|" + taskName;
                                    string errorMessage = "Duplicate entry found in the Excel file: " + resourceName + " - " + projectName + " - " + taskName;
                                    if (uniqueEntries.Contains(key))
                                    {
                                        if (!errorMessages.Contains(errorMessage))  // Check if the error message is already in the list
                                        {
                                            resourceNamesList.Add(resourceName);
                                            projectNamesList.Add(projectName);
                                            taskNamesList.Add(taskName);
                                            IsDuplicate = 1;
                                            errorMessages.Add(errorMessage);
                                        }
                                        isValid = false;
                                    }
                                    uniqueEntries.Add(key);

                                    var datesList = new List<Dictionary<string, string>>();
                                    for (int col = 4; col <= 10; col++)
                                    {
                                        var date = worksheet.Cell(1, col).Value.ToString();
                                        var duration = worksheet.Cell(row, col).Value.ToString();
                                        if (duration == "12/30/1899 8:00:00 AM")
                                        {
                                            duration = "";
                                        }
                                        datesList.Add(new Dictionary<string, string>
                                        {
                                            { "Date", date },
                                            { "Duration", duration }
                                        });
                                    }
                                    var rowData = new Dictionary<string, object>
                                    {
                                        { "Resource Name", resourceName },
                                        { "Project Name", projectName },
                                        { "Task Name", taskName },
                                        { "Dates", datesList }                                        
                                    };
                                    rowsData.Add(rowData);
                                }
                                if (IsDuplicate == 1)
                                {
                                    errorMessages.Clear();
                                    StringBuilder detailedErrorMessage = new StringBuilder();
                                    detailedErrorMessage.AppendLine("D$Duplicate entries detected for the same Resource Name, Project Name and Task Name in the Excel file:");
                                    for (int i = 0; i < projectNamesList.Count; i++)
                                    {
                                        detailedErrorMessage.AppendLine($"[ Resource Name: {resourceNamesList[i]}");
                                        detailedErrorMessage.AppendLine($"[ Project Name: {projectNamesList[i]}");
                                        detailedErrorMessage.AppendLine($"Task Name: {taskNamesList[i]} ], ");
                                        detailedErrorMessage.AppendLine();  // Add an empty line for better readability
                                    }
                                    errorMessages.Add(detailedErrorMessage.ToString());
                                }
                                if (isValid == true)
                                {
                                    var rowsDataJson = JsonConvert.SerializeObject(rowsData, Formatting.Indented);
                                    string strSQL = "Exec usp_Whizible2_Ins_tbl_PM_TimeSheet_Bulk_ExcelUpload " + HttpUtility.UrlDecode(Convert.ToString(GRequestID)) + "," +
                                          "" + HttpUtility.UrlDecode(Convert.ToString(UserID)) + "," +
                                          "'" + HttpUtility.UrlDecode(Convert.ToString(UserName)) + "'," +
                                          "'" + HttpUtility.UrlDecode(Convert.ToString(rowsDataJson)) + "'";
                                    string Message;
                                    Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
                                    //Added By Dipali V On 24th March 2025 For check if data is inserted successfully or not
                                    if (Message == "1")
                                    {
                                        strSQL = "Exec usp_Whizible2_ValidateDA_TimeSheet_ExcelUploadRequestDetails " + HttpUtility.UrlDecode(Convert.ToString(UserID)) + "," + HttpUtility.UrlDecode(Convert.ToString(GRequestID)) + "";
                                        Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

                                        if (Message == "1")
                                        {
                                            //Getting Email messages
                                            strSQL = "Exec usp_Whizible2_Ins_DailyActivity_ExcelUpload " + HttpUtility.UrlDecode(Convert.ToString(GRequestID)) + "," +
                                             "" + HttpUtility.UrlDecode(Convert.ToString(UserID)) + "";
                                            DataTable dt = new DataTable();
                                            dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                                            bool blnSendEmail = false, blnShowPopup = false;
                                            DataTable EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_EmailMessages 434", true, CommonController.connectionString);
                                            foreach (DataRow mailRow in EmailDataTable.Rows)
                                            {
                                                blnSendEmail = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["SendMail"], "0"));
                                                blnShowPopup = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["ShowPopup"], "0"));
                                            }                                            
                                            if (blnSendEmail == true)
                                            {
                                                foreach (DataRow row in dt.Rows)
                                                {
                                                    sb.Append(row["TimesheetID"].ToString());
                                                    sb.Append(","); // add comma
                                                    timesheetid = Convert.ToInt32(row["TimesheetID"]);                                                                                                        
                                                    string strFromEmailID = "";
                                                    string strToEmailID = "";
                                                    string strCCToEmailID = "";
                                                    string strSubject = "", strMessage = "";
                                                    EmailMessagesController.GetEmailMessage_434(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, timesheetid);
                                                    //EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
                                                    //Added by Vishal Mane on 29/09/2025 to save email history at back end 
                                                    string strSQLEmail = "Exec usp_Ins_tbl_PM_TimeSheet_ExcelUploadEmailHistory " + HttpUtility.UrlDecode(Convert.ToString(timesheetid)) + "," +
                                                                         "'" + HttpUtility.UrlDecode(Convert.ToString(strFromEmailID)) + "'," +
                                                                         " '" + HttpUtility.UrlDecode(Convert.ToString(strToEmailID)) + "'," +
                                                                         " '" + HttpUtility.UrlDecode(Convert.ToString(strCCToEmailID)) + "'," +
                                                                         "'" + HttpUtility.UrlDecode(Convert.ToString(strSubject)) + "'," +
                                                                         "'" + HttpUtility.UrlDecode(Convert.ToString(strMessage)) + "'," +
                                                                         "'" + HttpUtility.UrlDecode(Convert.ToString(UserName)) + "'," +
                                                                         "'" + HttpUtility.UrlDecode(Convert.ToString(FromDate)) + "'," +
                                                                         "'" + HttpUtility.UrlDecode(Convert.ToString(ToDate)) + "'" +
                                                                         "";  
                                                    string result = CommonFunctions.Data.GetDataScalar(strSQLEmail, true, CommonController.connectionString).ToString();
                                                    //End of Added by Vishal Mane on 29/09/2025 to save email history at back end 
                                                }

                                            }
                                        }
                                        //Added by Vishal Mane on 26/09/2025 to save file into uploaded folder 
                                        // 1. Get the physical path
                                        string physicalPath = HttpContext.Current.Server.MapPath(UploadDirectory);
                                        // 2. Ensure the directory exists
                                        if (!Directory.Exists(physicalPath))
                                        {
                                            Directory.CreateDirectory(physicalPath);
                                        }
                                        // 3. Define the final save path (using the original filename)
                                        string finalFilePath = Path.Combine(physicalPath, UploadedfileName);                                        
                                        // 4. Save the file (write the byte array to the final path)
                                        // This ensures the file is only saved if Message == "1"
                                        File.WriteAllBytes(finalFilePath, fileBytes);
                                        //End of Added by Vishal Mane on 26/09/2025 to save file into uploaded folder
                                        return Flag + '$' + sb;
                                    }
                                    //End of Added By Dipali V On 24th March 2025 For check if data is inserted successfully or not
                                }
                                else
                                {
                                    if (IsDuplicate == 1)
                                    {
                                        return errorMessages[0];
                                    }
                                    else
                                    {
                                        return '0' + '$' + errorMessages[0];
                                    }

                                }
                            }
                            else
                            {
                                return '0' + '$' + errorMessages[0];
                            }
                        }
                    }
                }
                return Flag + '$' + sb;
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }
        
        [Authorize]
        [HttpPost]
        public object GetRequestDetails(ExcelUploadParameters taskParameters)
        {
            try
            {

                string strSQL = "EXEC usp_Whizible2_GetRequestDetails " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'";
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }

            catch (Exception ex)
            {
                return "Bad Request";
            }
        }


        [Authorize]
        [HttpPost]
        public object GetErrorValidation(ExcelUploadParameters taskParameters)
        {
            try
            {

                string strSQL = "EXEC usp_Whizible2_GetRequestValidationDetails " + taskParameters.RequestID + "," +
                    "'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'," + taskParameters.Flag + "";
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }

            catch (Exception ex)
            {
                return "Bad Request";
            }
        }
        //Added By Vishal Mane on 25/09/2025
        [Authorize]
        [HttpPost]
        public object GetProxyUserCount(ExcelUploadParameters taskParameters)
        {
            try
            {

                string strSQL = "EXEC usp_Whizible2_Sel_tbl_CNF_ProxyUser_Mapping_Detail " + taskParameters.intEmployeeID + "";
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }

            catch (Exception ex)
            {
                return "Bad Request";
            }
        }
        //End of Added By Vishal Mane on 25/09/2025
    }

    public class ExcelUploadParameters
    {
        public int intEmployeeID { get; set; }
        public string dtFromDate { get; set; }
        public string dtToDate { get; set; }
        public int RequestID { get; set; }
        public int Flag { get; set; }
    }

    public class ResourceData
    {
        public int ResourceID { get; set; }
        public string ResourceName { get; set; }
    }

    public class ProjectData
    {
        public int ProjectID { get; set; }
        public string ProjectName { get; set; }
        public int ResourceID { get; set; } // Added this to link to the resource
    }

    public class TaskData
    {
        public int TaskID { get; set; }
        public string TaskName { get; set; }
        public int ProjectID { get; set; }
        public int ResourceID { get; set; } // Add this line
    }
    //End of Added by Vishal Mane on 20/08/2025 for Excel Upload functionality of Expleo
}
