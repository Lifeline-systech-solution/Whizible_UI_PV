using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models.Timesheet;
using WhizibleAPI.Models.EmailMessages;
using WhizibleAPI.Controllers;
using System.Net.Http;
using System.Net;

namespace WhizibleAPI.Controllers
{
    public class TimesheetApprovalController : ApiController
    {
        //public int empid;
        [HttpPost]
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        ////End of comment by Rehan on 19-10-2022
        public object GetTimesheetData([FromBody] TaskParameters1 taskParameters)
        {
            try
            {
                TimesheetApproval timesheetApproval = new TimesheetApproval();

                //Get Week Count and year of startdate and enddate
                DataTable WeekcountTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Get_WeekCount '" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString);
                foreach (DataRow WeekcountRow in WeekcountTable.Rows)
                {
                    GetWeekCount weekcount = new GetWeekCount();
                    weekcount.WeekNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(WeekcountRow["WeekNumber"], "0"));
                    weekcount.Year = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(WeekcountRow["Year"], ""));

                    timesheetApproval.GetWeekCount = weekcount;
                }

                //Status Filter to sort table
                timesheetApproval.TimesheetStatusLists = new List<TimesheetStatus>();
                DataTable TimesheetStatusTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_Timesheet_Status ", true, CommonController.connectionString);
                foreach (DataRow taskStatusRow in TimesheetStatusTable.Rows)
                {
                    TimesheetStatus timesheetStatusList = new TimesheetStatus()
                    {
                        StatusID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["StatusID"], "0")),
                        StatusCode = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["StatusCode"], "")),
                        StatusDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["StatusDescription"], ""))
                    };


                    timesheetApproval.TimesheetStatusLists.Add(timesheetStatusList);
                }

                //Employee Filter to sort Table
                timesheetApproval.TimesheetEmployeeList = new List<TimesheetApprovalEmployeeFilter>();
                DataTable TimesheetEmployeeTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_EmployeeFilter " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "',NULL", true, CommonController.connectionString);
                foreach (DataRow taskStatusRow in TimesheetEmployeeTable.Rows)
                {
                    TimesheetApprovalEmployeeFilter timesheetEmployeeList = new TimesheetApprovalEmployeeFilter()
                    {
                        EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["EmployeeID"], "0")),
                        EmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["EmployeeName"], "")),

                    };


                    timesheetApproval.TimesheetEmployeeList.Add(timesheetEmployeeList);
                }

                //Timesheet Approval List Table
                timesheetApproval.TimesheetApprovalLists = new List<TimesheetApprovalList>();
                //Commented And Added By Usha Pandit On 27.03.2020 For integrating missing code
                //DataTable TimesheetApprovalTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_PM_ResourceTimesheet_Approval "+ taskParameters.intEmployeeID +",'"+ taskParameters.dtFromDate + "','"+ taskParameters.dtToDate + "',NULL,NULL", true, CommonController.connectionString);
                DataTable TimesheetApprovalTable;
                //For Mobile View 
                if (taskParameters.dtFromDate == null)
                {
                    if (taskParameters.intResourceID != 0)
                    {
                        TimesheetApprovalTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_PM_ResourceTimesheet_Approval " + taskParameters.intEmployeeID + ",NULL,NULL," + taskParameters.intResourceID + ",NULL", true, CommonController.connectionString);
                    }
                    else
                    {
                        TimesheetApprovalTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_PM_ResourceTimesheet_Approval " + taskParameters.intEmployeeID + ",NULL,NULL,NULL,NULL", true, CommonController.connectionString);
                    }

                }
                //For Desktop View
                else
                {
                    TimesheetApprovalTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_PM_ResourceTimesheet_Approval " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "',NULL,NULL", true, CommonController.connectionString);
                }
                //End Of Added By Usha Pandit On 27.03.2020 For integrating missing code

                foreach (DataRow taskStatusRow in TimesheetApprovalTable.Rows)
                {
                    TimesheetApprovalList timesheetApprovalList = new TimesheetApprovalList()
                    {
                        TimeSheetID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["TimeSheetID"], "0")),
                        EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["EmployeeID"], "0")),
                        EmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["EmployeeName"], "")),
                        StatusCode = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["StatusCode"], "")),
                        StatusDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["StatusDescription"], "")),
                        FromDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["FromDate"], "")),
                        ToDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ToDate"], "")),
                        Period = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Period"], "")),
                        ActualHours = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ActualHours"], "")),
                        ExpectedHours = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ExpectedHours"], "")),
                        Comment = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Comment"], ""))
                    };


                    timesheetApproval.TimesheetApprovalLists.Add(timesheetApprovalList);
                }

                //Timesheet History Table
                //timesheetApproval.TimesheetHistoryLists = new List<TimesheetApprovalList>();
                //DataTable TimesheetHistoryTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_tbl_PM_ResourceTimesheetStatus_History 3956", true, CommonController.connectionString);
                //foreach (DataRow taskStatusRow in TimesheetApprovalTable.Rows)
                //{
                //    TimesheetHistoryList timesheetHistoryList = new TimesheetHistoryList()
                //    {
                //        TimeSheetID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["TimeSheetID"], "0")),
                //        EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["EmployeeID"], "0")),
                //        EmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["EmployeeName"], "")),
                //        StatusDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["StatusDescription"], "")),
                //        FromDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["FromDate"], "")),
                //        ToDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ToDate"], "")),
                //        ActualHours = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ActualHours"], "")),
                //        ExpectedHours = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ExpectedHours"], "")),
                //        Comment = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Comment"], "No Comment Added"))
                //    };


                //    timesheetApproval.TimesheetHistoryLists.Add(timesheetHistoryList);
                //}

                return timesheetApproval;

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
        public object GetTimesheetHistoryData([FromBody] TaskParameters1 taskParameters)
        {
            try
            {
                TimesheetApproval timesheetApproval = new TimesheetApproval();
                //Get Timesheet History of each employee
                timesheetApproval.TimesheetHistoryLists = new List<TimesheetHistoryList>();
                DataTable TimesheetHistoryTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_tbl_PM_ResourceTimesheetStatus_History " + taskParameters.intTimesheetID + "", true, CommonController.connectionString);
                foreach (DataRow taskHistoryRow in TimesheetHistoryTable.Rows)
                {
                    TimesheetHistoryList timesheetHistoryList = new TimesheetHistoryList()
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
                    timesheetApproval.TimesheetHistoryLists.Add(timesheetHistoryList);
                }

                return timesheetApproval;
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object PostTimesheetData([FromBody] TaskParameters1 taskParameters)
        {
            try
            {
                string Flag = "0";
                string strFromEmailID = "";
                string strToEmailID = "";
                string strCCToEmailID = "";
                string strSubject = "", strMessage = "";
                string TimesheetID; //Added By Dipali V On 26th March 2020 For Status Issues
                string strFromDate, strToDate, strRemarks, TaskStatusFlag;
                int intDailyActivityID, intVerified;
                bool blnSendEmail, blnShowPopup;
                DataTable ResourceTimesheetTable;
                // if (taskParameters.intTaskID == 0)
                //{
                ResourceTimesheetTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_ResourceTimesheetDADetails " + taskParameters.intTimesheetID + "," + taskParameters.intEmployeeID + ",null", true, CommonController.connectionString);
                //}
                //else
                //{
                //    ResourceTimesheetTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_ResourceTimesheetDADetails " + taskParameters.intTimesheetID + "," + taskParameters.intEmployeeID + ","+ taskParameters.intTaskID +"", true, CommonController.connectionString);
                //}

                foreach (DataRow taskRow in ResourceTimesheetTable.Rows)
                {
                    if ((Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskRow["IsDisabled"], "0"))) == "0")
                    {
                        strFromDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskRow["FromDate"], Convert.ToString(DateTime.Now)));
                        strToDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskRow["ToDate"], Convert.ToString(DateTime.Now)));
                        intDailyActivityID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskRow["DailyActivityEntryID"], "0"));
                        intVerified = 1;
                        strRemarks = "";
                        TaskStatusFlag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskRow["TimesheetStatusFlag"], "Not Set"));
                        //Added By Dipali V On 26th March 2020 For Status Issues
                        TimesheetID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskRow["TimesheetID"], ""));
                        //End of Added By Dipali V On 26th March 2020 For Status Issues
                        // Execute sp to update verification details to Daily Activity Table
                        if (taskParameters.Status == "V")
                        {
                            if (TaskStatusFlag != "J")
                            {
                                //Commented And Added By Dipali V On 26th March 2020 For Status Issues
                                //CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_upd_tbl_PM_ResourceTimesheetVerification " + intDailyActivityID + "," + intVerified + "," + taskParameters.intEmployeeID + ",'" + DateTime.Now + "',''," + taskParameters.intAllowToResubmit + ",'" + taskParameters.Status + "'", true, CommonController.connectionString);
                                CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_upd_tbl_PM_ResourceTimesheetVerification " + intDailyActivityID + "," + intVerified + "," + taskParameters.intEmployeeID + ",'" + DateTime.Now + "',''," + taskParameters.intAllowToResubmit + ",'" + taskParameters.Status + "'," + TimesheetID + "", true, CommonController.connectionString);
                                //End of Added By Dipali V On 26th March 2020 For Status Issues
                            }

                        }
                        else if (taskParameters.Status == "J")
                        {
                            if (TaskStatusFlag != "V")
                            {
                                //Commented And Added By Dipali V On 26th March 2020 For Status Issues
                                //CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_upd_tbl_PM_ResourceTimesheetVerification " + intDailyActivityID + "," + intVerified + "," + taskParameters.intEmployeeID + ",'" + DateTime.Now + "',''," + taskParameters.intAllowToResubmit + ",'" + taskParameters.Status + "'", true, CommonController.connectionString);
                                CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_upd_tbl_PM_ResourceTimesheetVerification " + intDailyActivityID + "," + intVerified + "," + taskParameters.intEmployeeID + ",'" + DateTime.Now + "',''," + taskParameters.intAllowToResubmit + ",'" + taskParameters.Status + "'," + TimesheetID + "", true, CommonController.connectionString);
                                //End of Added By Dipali V On 26th March 2020 For Status Issues
                            }
                        }

                    }
                }
                //Change Status to Verified in tbl_PM_ResourceTimesheetStatus table
                CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_Upd_tbl_PM_ResourceTimesheetStatus " + taskParameters.intTimesheetID + "," + taskParameters.intEmployeeID + ",'" + taskParameters.Status + "'", true, CommonController.connectionString);
                //If Resource TimeSheet are verified then change the status to 'verified' 
                DataTable ResourceTimesheetStatusTable = CommonFunctions.Data.GetDataTable("Exec usp_Whizible2_Sel_ResourceTimesheet_GetVerifiedTasksStatus " + taskParameters.intTimesheetID + "", true, CommonController.connectionString);
                // drVerify = CommonFunctions.Data.GetDataReader("Exec usp_Sel_ResourceTimesheet_GetVerifiedTasksStatus 3847", CommonFunctions.General.GetApplicationKeySetting("UseSQL"));
                CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_Upd_ResouceTimesheetStatus " + taskParameters.intTimesheetID + ",'" + taskParameters.Status + "','" + taskParameters.strComment.Replace("'", "''") + "','" + taskParameters.intAllowToResubmit + "'", true, CommonController.connectionString);

                //GetEmailMessage_435(taskParameters.intEmployeeID, taskParameters.dtFromDate, taskParameters.dtToDate);
                ////Email
                ///
                DataTable EmailDataTable;
                if (taskParameters.Status == "V")
                {
                    EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Sel_tbl_PM_EmailMessages 435", true, CommonController.connectionString);
                }
                else
                {
                    EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Sel_tbl_PM_EmailMessages 436", true, CommonController.connectionString);
                }

                foreach (DataRow mailRow in EmailDataTable.Rows)
                {
                    blnSendEmail = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["SendMail"], "0"));
                    blnShowPopup = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["ShowPopup"], "0"));

                    if (blnSendEmail == true)
                    {
                        if (blnShowPopup == true)
                        {
                            //Added By Usha Pandit On 27.03.2020 For integrating missing code
                            if (taskParameters.intMobileView == 1)
                            {
                                if (taskParameters.Status == "V")
                                {
                                    EmailMessagesController.GetEmailMessage_435(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, taskParameters.intEmployeeID, taskParameters.intResourceID, Convert.ToDateTime(taskParameters.dtFromDate), Convert.ToDateTime(taskParameters.dtToDate), taskParameters.intTimesheetID);
                                    EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);

                                }
                                else
                                {
                                    EmailMessagesController.GetEmailMessage_436(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, taskParameters.intEmployeeID, taskParameters.intResourceID, taskParameters.intTimesheetID);
                                    EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
                                }
                            }
                            else
                            {

                            }
                            //End Of Added By Usha Pandit On 27.03.2020 For integrating missing code
                            Flag = "1";
                        }
                        else
                        {
                            if (taskParameters.Status == "V")
                            {
                                EmailMessagesController.GetEmailMessage_435(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, taskParameters.intEmployeeID, taskParameters.intResourceID, Convert.ToDateTime(taskParameters.dtFromDate), Convert.ToDateTime(taskParameters.dtToDate), taskParameters.intTimesheetID);
                                EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);

                            }
                            else
                            {
                                EmailMessagesController.GetEmailMessage_436(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, taskParameters.intEmployeeID, taskParameters.intResourceID, taskParameters.intTimesheetID);
                                EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
                            }
                            Flag = "0";

                        }
                    }
                    else { return "1"; }
                }
                return Flag;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added By Usha Pandit On 27.03.2020 For integrating missing code
        //Get Employee List
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        //public List<TimesheetApprovalEmployeeFilter> GetEmployeeDropdownValuesForFilter([FromBody]TaskParameters taskParameters)
        public object GetEmployeeDropdownValuesForFilter([FromBody] TaskParameters taskParameters)

        {
            try
            {
                List<TimesheetApprovalEmployeeFilter> TimesheetEmployeeList = new List<TimesheetApprovalEmployeeFilter>();

                DataTable TimesheetEmployeeTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_EmployeeFilter_mv " + taskParameters.intEmployeeID + "", true, CommonController.connectionString);

                foreach (DataRow Emprow in TimesheetEmployeeTable.Rows)
                {
                    TimesheetApprovalEmployeeFilter timesheetEmployeeList = new TimesheetApprovalEmployeeFilter()
                    {
                        EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(Emprow["EmployeeID"], "0")),
                        EmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Emprow["EmployeeName"], "")),
                    };
                    TimesheetEmployeeList.Add(timesheetEmployeeList);
                }
                return TimesheetEmployeeList;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End Of Added By Usha Pandit On 27.03.2020 For integrating missing code

        //Added By Durgesh Dalvi On 22.01.2025 For Resource TimeSheet Fetching
        [HttpPost]
        //Added By Durgesh Dalvi On 22.01.2025
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by By Durgesh Dalvi On 22.01.2025
        public object GetResourceTimesheetData([FromBody] TaskParameters1 taskParameters)
        {
            try
            {
                //Added by Vishal Mane on 31/01/2025 to fix issue if Timesheet has 2 Approvers
                string strSQL = "EXEC usp_Whizible2_sel_ResourceTimesheetDetails " + taskParameters.intTimesheetID +", "+ taskParameters.intEmployeeID + ", '"+ taskParameters.dtFromDate +"', '"+ taskParameters.dtFromDate + "'," + taskParameters.intApproverID +"";
                //End of Added by Vishal Mane on 31/01/2025 to fix issue if Timesheet has 2 Approvers
                DataSet ds = CommonFunctions.Data.GetDataSet(strSQL.ToString(), "ResourceTimeSheet", 0, 0, System.Convert.ToBoolean(true), CommonController.connectionString);
                return ds;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
    }
    //End Of Added By Durgesh Dalvi On 22.01.2025 For Resource TimeSheet Fetching
    public class TaskParameters1 {
        public int intEmployeeID { get; set; }
        public string dtFromDate { get; set; }
        public string dtToDate { get; set; }
        public int intTimesheetID { get; set; }
        public string Status { get; set; }
        public string strComment { get; set; }
        public int intAllowToResubmit { get; set; } = 0;
        public int intTaskID { set; get; } = 0;
        public int intResourceID { get; set; } = 0;
        //Added By Usha Pandit On 27.03.2020 For integrating missing code
        public int intMobileView { get; set; } = 0;
        //End Of Added By Usha Pandit On 27.03.2020 For integrating missing code
        //Added by Vishal Mane on 31/01/2025 to fix issue if Timesheet has 2 Approvers
        public int intApproverID { get; set; } = 0;
        //End of Added by Vishal Mane on 31/01/2025 to fix issue if Timesheet has 2 Approvers
    }
}
