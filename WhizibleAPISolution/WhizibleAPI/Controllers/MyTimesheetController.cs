using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models.Timesheet;

namespace WhizibleAPI.Controllers
{
    public class MyTimesheetController : ApiController
    {
        [HttpPost]
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        ////End of comment by Rehan on 19-10-2022
        public object GetData([FromBody] TaskParameter taskParameters)
        {
            try
            {
                DataTable MyTimesheetTable;
                MyTimesheet myTimesheet = new MyTimesheet();

                myTimesheet.ApprovalStatus = new List<ApprovalStatus>();
                DataTable approvalstatusTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_ResourceTimesheetForFilters " + taskParameters.employeeID + ",Status", true, CommonController.connectionString);
                foreach (DataRow approvalstatusRow in approvalstatusTable.Rows)
                {
                    ApprovalStatus approvalStatus = new ApprovalStatus()
                    {
                        StatusCode = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(approvalstatusRow["StatusCode"], "")),
                        StatusDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(approvalstatusRow["StatusDescription"], ""))
                    };
                    myTimesheet.ApprovalStatus.Add(approvalStatus);
                }

                //MyTimesheet List
                //Added By Dipali V On 26th March 2020 For Timehseet not listout
                myTimesheet.MyTimesheetLists = new List<MyTimesheetDetail>();

                if (taskParameters.employeeID == 0)
                {
                    MyTimesheetTable = CommonFunctions.Data.GetDataTable("usp_WhizibleTS2_sel_tbl_PM_ResourceTimesheet Null," + taskParameters.intProxyUserID + ", Null", true, CommonController.connectionString);
                }
                else
                {
                    MyTimesheetTable = CommonFunctions.Data.GetDataTable("usp_WhizibleTS2_sel_tbl_PM_ResourceTimesheet " + taskParameters.intProxyUserID + "," + taskParameters.employeeID + ", Null", true, CommonController.connectionString);
                }
                //End of Added By Dipali V On 26th March 2020 For Timehseet not listout
                foreach (DataRow taskStatusRow in MyTimesheetTable.Rows)
                {
                    MyTimesheetDetail mytimesheetlist = new MyTimesheetDetail()
                    {
                        TimeSheetID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["TimeSheetID"], "0")),
                        CreatedDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["CreatedDate"], "")),
                        Period = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Period"], "")),
                        FromDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["FromDate"], "")),
                        ToDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ToDate"], "")),
                        ActualHours = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ActualHours"], "")),
                        ExpectedHours = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ExpectedHours"], "")),
                        StatusDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["StatusDescription"], "")),
                        Comment = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Comment"], ""))

                    };

                    myTimesheet.MyTimesheetLists.Add(mytimesheetlist);
                }

                return myTimesheet;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get MyTimesheet History data
        [HttpPost]
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        public object GetMyTimesheetHistoryData([FromBody] TaskParameter taskParameters)
        {
            try
            {

                MyTimesheet myTimesheet = new MyTimesheet();
                //Get Timesheet History of each employee
                myTimesheet.MyTimesheetHistoryLists = new List<MyTimesheetHistoryList>();
                DataTable TimesheetHistoryTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_tbl_PM_ResourceTimesheetStatus_History " + taskParameters.intTimesheetID + "", true, CommonController.connectionString);
                foreach (DataRow taskHistoryRow in TimesheetHistoryTable.Rows)
                {
                    MyTimesheetHistoryList mytimesheetHistoryList = new MyTimesheetHistoryList()
                    {
                        ResourceTimesheetStatusHistoryID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskHistoryRow["ResourceTimesheetStatusHistoryID"], "0")),
                        DateAndTime = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskHistoryRow["DateAndTime"], "")),
                        ModifiedBy = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskHistoryRow["ModifiedBy"], "")),
                        Field = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskHistoryRow["Field"], "")),
                        OldValue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskHistoryRow["OldValue"], "")),
                        NewValue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskHistoryRow["NewValue"], "")),
                        Status = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskHistoryRow["StatusDescription"], "")),
                        CreatedDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskHistoryRow["CreatedDate"], "")),
                        UpdatedDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskHistoryRow["UpdatedDate"], "")),
                        ActionTakenBy = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskHistoryRow["ActionTakenBy"], "")),
                        ActionTaken = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskHistoryRow["ActionTaken"], "")),
                        ApproverName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskHistoryRow["ApproverName"], ""))
                    };
                    myTimesheet.MyTimesheetHistoryLists.Add(mytimesheetHistoryList);
                }

                return myTimesheet;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Delete MyTimesheet

        [HttpPost]
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteMyTimesheet([FromBody] TaskParameter taskParameters)
        {
            try
            {
                string msg;
                msg = Convert.ToString(CommonFunctions.Data.InsertOrUpdateData("usp_Whizible2_Del_tbl_PM_ResourceTimesheet " + taskParameters.intTimesheetID + "", true, CommonController.connectionString));

                return (msg);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Validation of MyTimesheet

        [HttpPost]
        [Authorize]
        public object ValidateMyTimesheet([FromBody] TaskParameter taskParameters)
        {
            try
            {

                string strmsg;
                strmsg = Convert.ToString(CommonFunctions.Data.GetDataScalar("usp_Whizible2_sel_GetRTApprovers " + taskParameters.intTimesheetID + ",'" + taskParameters.employeeID + "','" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString));
                return (strmsg);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Regenerate MyTimesheet and send for Approval

        [HttpPost]
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object GenerateMyTimesheet([FromBody] TaskParameter taskParameters)
        {
            try
            {

                int timesheetid;
                if (taskParameters.intProxyUserID == 0)
                {
                    timesheetid = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("usp_WhizibleTS2_GenerateResourceTimeSheet Null," + taskParameters.employeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString));
                }
                else
                {
                    timesheetid = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("usp_WhizibleTS2_GenerateResourceTimeSheet " + taskParameters.intProxyUserID + "," + taskParameters.employeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString));
                }
                //Change Status to Regenerated in tbl_PM_ResourceTimesheetStatus table
                CommonFunctions.Data.GetDataScalar("Exec usp_WhizibleTS2_Upd_ResouceTimesheetStatus  " + taskParameters.intTimesheetID + ",'" + taskParameters.StatusCode + "'", true, CommonController.connectionString);

                string Flag = "0";
                string strFromEmailID = "";
                string strToEmailID = "";
                string strCCToEmailID = "";
                string strSubject = "", strMessage = "";
                bool blnSendEmail, blnShowPopup;

                //Getting Email messages

                DataTable EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_EmailMessages 434", true, CommonController.connectionString);
                foreach (DataRow mailRow in EmailDataTable.Rows)
                {
                    blnSendEmail = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["SendMail"], "0"));
                    blnShowPopup = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["ShowPopup"], "0"));

                    if (blnSendEmail == true)
                    {
                        if (blnShowPopup == true)
                        {
                            Flag = "1";
                        }
                        else
                        {

                            EmailMessagesController.GetEmailMessage_434(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, taskParameters.intTimesheetID);
                            EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
                        }

                    }
                }
                //return (message);
                return Flag;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        public object ValidateTimesheet([FromBody] TaskParameter taskParameters)
        {
            try
            {
                string strmsg;
                strmsg = Convert.ToString(CommonFunctions.Data.GetDataScalar("usp_Whizible2_ValidateMyTimesheet " + taskParameters.employeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString));
                return (strmsg);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object GenerateTimesheet([FromBody] TaskParameter taskParameters)
        {
            try
            {
                int timesheetID;
                //timesheetID = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("usp_Whizible2_GenerateResourceTimesheet " + taskParameters.employeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString));
                if (taskParameters.intProxyUserID == 0)
                {
                    timesheetID = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("usp_WhizibleTS2_GenerateResourceTimeSheet Null," + taskParameters.employeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString));
                }
                else
                {
                    timesheetID = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("usp_WhizibleTS2_GenerateResourceTimeSheet " + taskParameters.intProxyUserID + "," + taskParameters.employeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString));
                }
                //Change Status to Regenerated in tbl_PM_ResourceTimesheetStatus table
                CommonFunctions.Data.GetDataScalar("Exec usp_WhizibleTS2_Upd_ResouceTimesheetStatus  " + timesheetID + ",'" + taskParameters.StatusCode + "'", true, CommonController.connectionString);

                string Flag = "0";
                string strFromEmailID = "";
                string strToEmailID = "";
                string strCCToEmailID = "";
                string strSubject = "", strMessage = "";
                bool blnSendEmail, blnShowPopup;

                //Getting Email messages
                DataTable EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_EmailMessages 434", true, CommonController.connectionString);
                foreach (DataRow mailRow in EmailDataTable.Rows)
                {
                    blnSendEmail = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["SendMail"], "0"));
                    blnShowPopup = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["ShowPopup"], "0"));

                    if (blnSendEmail == true)
                    {
                        if (blnShowPopup == true)
                        {
                            if (taskParameters.intMobileView == 1)
                            {
                                EmailMessagesController.GetEmailMessage_434(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, timesheetID);
                                EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
                                Flag = "1";
                            }
                            else
                            {
                                Flag = "1";
                            }

                        }
                        else
                        {

                            EmailMessagesController.GetEmailMessage_434(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, timesheetID);
                            EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
                        }

                    }
                }
                return Flag + '$' + timesheetID;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        public object ExportDocument([FromBody] TaskParameter taskParameters)
        {
            try
            {
                string strSQL;
                string strFilePath;
                //string strFormat;
                //string strCaptions;
                string m_strFileName;
                long m_lngReportID;
                int DateFormatID = 0;
                string CompanyName = "";
                string ReportFormat = taskParameters.ReportFormat;

                int lngDefaultLCID;
                int lngCurrentThreadUICultureID;
                lngDefaultLCID = 1033;
                lngCurrentThreadUICultureID = 1033;
                AdHocReports.Report.AdHocReport oRpt;
                if (taskParameters.StatusCode != "Null")
                {
                    if (taskParameters.intProxyUserID == 0)
                    {
                        strSQL = "usp_Whizible2_CRW_Sel_tbl_PM_ResourceTimesheetReportList Null," + taskParameters.employeeID + ",'" + taskParameters.StatusCode + "'";
                    }
                    else
                    {
                        strSQL = "usp_Whizible2_CRW_Sel_tbl_PM_ResourceTimesheetReportList " + taskParameters.intProxyUserID + "," + taskParameters.employeeID + ",'" + taskParameters.StatusCode + "'";
                    }
                }
                else
                {
                    if (taskParameters.intProxyUserID == 0)
                    {
                        strSQL = "usp_Whizible2_CRW_Sel_tbl_PM_ResourceTimesheetReportList Null," + taskParameters.employeeID + ",Null";
                    }
                    else
                    {
                        strSQL = "usp_Whizible2_CRW_Sel_tbl_PM_ResourceTimesheetReportList " + taskParameters.intProxyUserID + "," + taskParameters.employeeID + ",Null";
                    }
                }


                IDataReader drCompInfo1 = CommonFunctions.Data.GetSQLDataReader(strSQL, CommonController.connectionString);
                if (drCompInfo1.Read() == false)
                {
                    return "";
                }
                m_lngReportID = 22272;
                CommonEngines.HashTables.Culture.ConnectionString = CommonController.connectionString;
                CommonEngines.HashTables.Culture.FillCultureHashTable();
                // The reports are created in the "Reports" folder
                strFilePath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../Reports/"));
                // get a unique file name
                m_strFileName = CommonFunctions.FileDirectory.GetUniqueFileName().Trim();
                // add extn to file name based on format requested
                switch (ReportFormat)
                {
                    case "PDF": m_strFileName += ".pdf"; break;
                    case "HTML": m_strFileName += ".htm"; break;
                    case "RTF": m_strFileName += ".rtf"; break;
                    case "EXCEL": m_strFileName += ".xls"; break;
                    case "CSV": m_strFileName += ".csv"; break;
                    case "TEXT": m_strFileName += ".txt"; break;
                    case "XML": m_strFileName += ".xml"; break;
                    default: m_strFileName += ".pdf"; break;
                }
                IDataReader drCompInfo = CommonFunctions.Data.GetSQLDataReader("usp_SEL_Tbl_PM_CompanyInformation", CommonController.connectionString);

                while (drCompInfo.Read())
                {
                    CompanyName = CommonFunctions.Data.CheckIsDBNull(drCompInfo["CompanyName"], "").ToString();
                    DateFormatID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drCompInfo["DateFormatID"], "0"));
                }

                // create object of Adhoc reports
                oRpt = new AdHocReports.Report.AdHocReport(m_lngReportID, strSQL, CommonController.connectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../ATTACHMENTS/Log/")));

                oRpt.UseMSSQL = true;
                oRpt.DefaultLCID = lngDefaultLCID;
                oRpt.LCID = lngCurrentThreadUICultureID;
                oRpt.UseHashTables = true;
                oRpt.DateFormat = DateFormatID;
                oRpt.CompanyName = CompanyName;
                oRpt.GraphImageGenerationAbsolutePath = HttpContext.Current.Server.MapPath("../../../Images/");

                //' generate the report in requested format
                AdHocReports.HashTables.CreateHashTables.ConnectionString = CommonController.connectionString;
                switch (ReportFormat)
                {
                    case "PDF": oRpt.GenerateReport(AdHocReports.Format.PDF); break;
                    case "HTML": oRpt.GenerateReport(AdHocReports.Format.HTML); break;
                    case "RTF": oRpt.GenerateReport(AdHocReports.Format.RTF); break;
                    case "EXCEL": oRpt.GenerateReport(AdHocReports.Format.EXCEL); break;
                    case "CSV": oRpt.GenerateReport(AdHocReports.Format.CSV); break;
                    case "TEXT": oRpt.GenerateReport(AdHocReports.Format.TEXT); break;
                    case "XML": oRpt.GenerateReport(AdHocReports.Format.XML); break;
                    default: oRpt.GenerateReport(AdHocReports.Format.PDF); break;
                }

                oRpt = null;
                return m_strFileName;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        public class TaskParameter
        {
            public int employeeID { get; set; }
            public int intProxyUserID { get; set; }
            public string StatusCode { get; set; }
            public int intTimesheetID { get; set; }
            public string dtFromDate { get; set; }
            public string dtToDate { get; set; }
            public string ReportFormat { get; set; }
            public int intMobileView { get; set; } = 0;

        }
    }
}
