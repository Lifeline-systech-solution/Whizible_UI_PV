using System.Web;
using ClosedXML.Excel;
using System.IO;
using System;
using System.Collections;
using System.Data;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web.Http;
using WhizibleAPI.Models.PlannedVSActual;
using Microsoft.VisualBasic;


namespace WhizibleAPI.Controllers
{
    public class PlannedVSActualController : ApiController
    {


        [Authorize]
        [HttpPost]
        public object GetCurrentMonthYear()
        {
            try
            {
                DateTime dt = DateTime.Now;
                int Month = dt.Month;
                int Year = dt.Year;
                string Result = Month + "~" + Year;
                return Result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object FillOrganizationUnit([FromBody] PlannedVSActual PA)
        {
            try
            {
                if (PA.BGID == "0")
                {
                    PA.BGID = null;
                }

                string strsql = "Exec usp_sel_whizible2_tbl_PM_Location_OrganizationUnit '" + PA.BGID + "'," + PA.UserID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object FillDeliveryUnit([FromBody] PlannedVSActual PA)
        {
            try
            {
                if (PA.BGID == "0")
                {
                    PA.BGID = null;
                }
                if (PA.OUID == "0")
                {
                    PA.OUID = null;
                }

                string strsql = "Exec usp_sel_whizible2_DeliveryUnits '" + PA.BGID + "','" + PA.OUID + "'," + PA.UserID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object FillDeliveryTeam([FromBody] PlannedVSActual PA)
        {
            try
            {
                if (PA.BGID == "0")
                {
                    PA.BGID = null;
                }
                if (PA.OUID == "0")
                {
                    PA.OUID = null;
                }
                if (PA.DUID == "0")
                {
                    PA.DUID = null;
                }

                string strsql = "Exec usp_sel_whizible2_tbl_PM_GroupMaster_DeliveryTeam '" + PA.BGID + "','" + PA.OUID + "','" + PA.DUID + "'," + PA.UserID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object TBodyHeadFill([FromBody] PlannedVSActual PA)
        {
            try
            {
                int weekDays, StartingDayOfWeek;
                int m_intNoOfDaysInWeek = 0;
                int m_intStartingDayOfWeek = 0;
                string[] CompanyHolidays1;
                string CompanyHolidays="";
                string strsql = "Exec usp_Whizible2_tbl_PM_CompanyInformation ";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                foreach (DataRow row in dt.Rows)
                {
                    m_intNoOfDaysInWeek = Convert.ToInt32(row["weekDays"].ToString()); 
                    m_intStartingDayOfWeek = Convert.ToInt32(row["StartingDayOfWeek"].ToString());
                    CompanyHolidays = Convert.ToString(row["Holidays"].ToString());
                }

                CompanyHolidays1 = CompanyHolidays.Split(',');

                StringBuilder m_strCalenderHTML = new StringBuilder();
                string[] mstrCalenderHeader = new[] { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
                string[] arrWeekDays = mstrCalenderHeader;
                var intDay = 0;
                int firstDay, startDay, column, lastMonth, intCount, intYear1;
                int[] days = new[] { 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
                DateTime strDate;
                int intWeekDay;
                ArrayList arrlistHoliday = new ArrayList();
                ArrayList arrlistLeaves = new ArrayList();

                if (DateTime.IsLeapYear(PA.Year))
                {
                    days[2] = 29;
                }
                else
                {
                    days[2] = 28;
                }

                //m_strCalenderHTML.Append("<tr class=clsTREven>");
                //m_strCalenderHTML.Append("<Td align='center' height=5px width=13% colspan=32  > <B>" + GetMonthName(PA.Month) + "-" + PA.Year + "</B> </TD>");

                m_strCalenderHTML.Append("<tr> <th class=''>&nbsp;</th>");
                m_strCalenderHTML.Append("<th colspan=" + days[PA.Month] + "> ");
                m_strCalenderHTML.Append("<div class='monthheading'>");
                m_strCalenderHTML.Append("<a class='montharrow prvMonth' href='javascript:;' onclick='PreviousMonth()'><i class='fas fa-chevron-left' data-bs-toggle='tooltip' title='Previous Month' data-bs-placement='top' data-bs-container='body'></i></a>");
                m_strCalenderHTML.Append("<div class='tblmnthname'><i class='far fa-calendar-check'></i>&nbsp;" + GetMonthName(PA.Month) + " " + PA.Year + "</div>");
                m_strCalenderHTML.Append("<a class='montharrow nextMonth' href='javascript:;' onclick='NextMonth()'><i class='fas fa-chevron-right' data-bs-toggle='tooltip' data-bs-placement='top' title='Next Month' data-bs-container='body'></i></a>");
                m_strCalenderHTML.Append("</div>");
                m_strCalenderHTML.Append("</tr>");
                firstDay = Weekday(PA.Year, PA.Month, 1); 
                startDay = firstDay;
                column = 0;
                lastMonth = PA.Month - 1;
                if (lastMonth == 0)
                {
                    lastMonth = 12;
                }

                // --- Get current month days 
                intDay = 1;
                int intNoOfWorkDay = 7 - m_intNoOfDaysInWeek; 
                m_strCalenderHTML.Append(" ");
                column = 0;
                m_strCalenderHTML.Append(" ");
                intYear1 = PA.Year;
                m_strCalenderHTML.Append(" ");
                m_strCalenderHTML.Append(" <tr class=clsTRPageCaption width='100%'>");
                m_strCalenderHTML.Append(" <td width=10% >");
                m_strCalenderHTML.Append("</td>");

                for (intCount = intDay; intCount <= days[PA.Month]; intCount++)
                {
                    m_strCalenderHTML.Append(" ");
                    strDate = new DateTime(PA.Year, PA.Month, intDay);
                    m_strCalenderHTML.Append(" ");
                    //switch (m_intStartingDayOfWeek)
                    //{
                    //    case 1:
                    //        //intWeekDay = Weekday(strDate, Microsoft.VisualBasic.FirstDayOfWeek.Sunday);
                    //        intWeekDay= DateAndTime.Weekday(strDate, Microsoft.VisualBasic.FirstDayOfWeek.Sunday);
                    //        //intWeekDay = Weekday(PA.Year, PA.Month, intDay);
                    //        break;
                    //    case 2:
                    //        intWeekDay = DateAndTime.Weekday(strDate, Microsoft.VisualBasic.FirstDayOfWeek.Monday);
                    //        //intWeekDay = Weekday(PA.Year, PA.Month, intDay);
                    //        break;
                    //    case 3:
                    //        //intWeekDay = Weekday(PA.Year, PA.Month, intDay);
                    //        intWeekDay = DateAndTime.Weekday(strDate, Microsoft.VisualBasic.FirstDayOfWeek.Tuesday);
                    //        break;
                    //    case 4:
                    //        //intWeekDay = Weekday(PA.Year, PA.Month, intDay);
                    //        intWeekDay = DateAndTime.Weekday(strDate, Microsoft.VisualBasic.FirstDayOfWeek.Wednesday);
                    //        break;
                    //    case 5:
                    //        //intWeekDay = Weekday(PA.Year, PA.Month, intDay);
                    //        intWeekDay = DateAndTime.Weekday(strDate, Microsoft.VisualBasic.FirstDayOfWeek.Thursday);
                    //        break;
                    //    case 6:
                    //        //intWeekDay = Weekday(PA.Year, PA.Month, intDay);
                    //        intWeekDay = DateAndTime.Weekday(strDate, Microsoft.VisualBasic.FirstDayOfWeek.Friday);
                    //        break;
                    //    case 7:
                    //        //intWeekDay = Weekday(PA.Year, PA.Month, intDay);
                    //        intWeekDay = DateAndTime.Weekday(strDate, Microsoft.VisualBasic.FirstDayOfWeek.Saturday);
                    //        break;
                    //    default:
                    //        intWeekDay = DateAndTime.Weekday(strDate, Microsoft.VisualBasic.FirstDayOfWeek.Sunday);
                    //        break;
                    //}

                    DateTime dateValue = new DateTime(PA.Year, PA.Month, intDay);
                    string strDayName = dateValue.ToString("ddd");
                    string strFullDayName = dateValue.ToString("dddd");
                    strDayName = strDayName.Substring(0, 1);

                    //Company Holiday Fill
                    int T = 0;
                    for (int y= 0; y < CompanyHolidays1.Length; y++)
                    {
                        if(strFullDayName == CompanyHolidays1[y].ToString())
                        {
                            T = 1;
                            m_strCalenderHTML.Append(" <th class='thHoliday' id=" + intDay + " ALIGN=center height=5px width=2.5% valign=top>");
                        }
                    }
                    if(T==0)
                    {
                        m_strCalenderHTML.Append(" <th id=" + intDay + "  ALIGN=center height=5px width=2.5%  valign=top  >");
                    }
                    //End of Company Holiday Fill
  
                    m_strCalenderHTML.Append("<b data-bs-toggle='modal' title='" + strFullDayName + "'>" + strDayName + "</b>");
                    m_strCalenderHTML.Append("</th>");
                    m_strCalenderHTML.Append(" ");
                    m_strCalenderHTML.Append(" ");
                    column = column + 1;
                    m_strCalenderHTML.Append(" ");
                    intDay = intDay + 1;
                    m_strCalenderHTML.Append(" ");
                }
                m_strCalenderHTML.Append("</tr>");

                // rowspan=2
                m_strCalenderHTML.Append("<tr>");
                m_strCalenderHTML.Append("<th class='text-start sortbyrole'>");
                m_strCalenderHTML.Append("<div class='rsrsname'>" + PA.strName + "</div> </th>");
                m_strCalenderHTML.Append(" ");
                intDay = 1;
                string strdateConverted = "";

                for (intCount = intDay; intCount <= days[PA.Month]; intCount++)
                {
                    m_strCalenderHTML.Append(" ");
                    strDate = new DateTime(PA.Year, PA.Month, intDay);
                    strdateConverted = strDate.ToString("dd MMM yyyy");
                    string strFullDayName = strDate.ToString("dddd");

                    m_strCalenderHTML.Append(" ");

                    //switch (m_intStartingDayOfWeek)
                    //{
                    //    case 1:
                    //        intWeekDay = DateAndTime.Weekday(strDate, Microsoft.VisualBasic.FirstDayOfWeek.Sunday);
                    //        //intWeekDay = Weekday(PA.Year, PA.Month, intDay);
                    //        break;
                    //    case 2:
                    //        intWeekDay = DateAndTime.Weekday(strDate, Microsoft.VisualBasic.FirstDayOfWeek.Monday);
                    //        //intWeekDay = Weekday(PA.Year, PA.Month, intDay);
                    //        break;
                    //    case 3:
                    //        //intWeekDay = Weekday(PA.Year, PA.Month, intDay);
                    //        intWeekDay = DateAndTime.Weekday(strDate, Microsoft.VisualBasic.FirstDayOfWeek.Tuesday);
                    //        break;
                    //    case 4:
                    //        //intWeekDay = Weekday(PA.Year, PA.Month, intDay);
                    //        intWeekDay = DateAndTime.Weekday(strDate, Microsoft.VisualBasic.FirstDayOfWeek.Wednesday);
                    //        break;
                    //    case 5:
                    //        //intWeekDay = Weekday(PA.Year, PA.Month, intDay);
                    //        intWeekDay = DateAndTime.Weekday(strDate, Microsoft.VisualBasic.FirstDayOfWeek.Thursday);
                    //        break;
                    //    case 6:
                    //        //intWeekDay = Weekday(PA.Year, PA.Month, intDay);
                    //        intWeekDay = DateAndTime.Weekday(strDate, Microsoft.VisualBasic.FirstDayOfWeek.Friday);
                    //        break;
                    //    case 7:
                    //        //intWeekDay = Weekday(PA.Year, PA.Month, intDay);
                    //        intWeekDay = DateAndTime.Weekday(strDate, Microsoft.VisualBasic.FirstDayOfWeek.Saturday);
                    //        break;
                    //    default:
                    //        intWeekDay = DateAndTime.Weekday(strDate, Microsoft.VisualBasic.FirstDayOfWeek.Sunday);
                    //        break;
                    //} 

                    //if (intWeekDay <= m_intNoOfDaysInWeek)
                    //{
                    //    m_strCalenderHTML.Append(" <th id=" + intDay + "  ALIGN=center height=5px width=2.5%  valign=top  >");
                    //}
                    //else
                    //{
                    //    m_strCalenderHTML.Append(" <th class='thHoliday' id=" + intDay + " ALIGN=center height=5px width=2.5% valign=top>");
                    //}

                    //Company Holiday Fill
                    int T = 0;
                    for (int y = 0; y < CompanyHolidays1.Length; y++)
                    {
                        if (strFullDayName == CompanyHolidays1[y].ToString())
                        {
                            T = 1;
                            m_strCalenderHTML.Append(" <th class='thHoliday' id=" + intDay + " ALIGN=center height=5px width=2.5% valign=top>");
                        }
                    }
                    if (T == 0)
                    {
                        m_strCalenderHTML.Append(" <th id=" + intDay + "  ALIGN=center height=5px width=2.5%  valign=top  >");
                    }
                    //End of Company Holiday Fill

                    m_strCalenderHTML.Append("<b>" + intDay + "</b>");
                    m_strCalenderHTML.Append("</th>");
                    m_strCalenderHTML.Append(" ");
                    m_strCalenderHTML.Append(" ");
                    column = column + 1;
                    m_strCalenderHTML.Append(" ");
                    intDay = intDay + 1;
                    m_strCalenderHTML.Append(" ");
                }

                m_strCalenderHTML.Append("</tr>");
                return m_strCalenderHTML;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }        

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object TBodyFill([FromBody] PlannedVSActual PA)
        {
            try
            {
                if (PA.EmployeeName == "")
                {
                    PA.EmployeeName = "";
                }
                if (PA.BGID == "0")
                {
                    PA.BGID = "NULL";
                }
                if (PA.OUID == "0")
                {
                    PA.OUID = "NULL";
                }

                if (PA.RoleID == "0")
                {
                    PA.RoleID = "NULL";
                }

                if (PA.Designation == "0")
                {
                    PA.Designation = "NULL";
                }

                if (PA.Skill == "0")
                {
                    PA.Skill = "NULL";
                }

                if (PA.DUID == "0")
                {
                    PA.DUID = "NULL";
                }

                if (PA.DTID == "0")
                {
                    PA.DTID = "NULL";
                }

                if (PA.EmployeeType == "0")
                {
                    PA.EmployeeType = "NULL";
                }

                if (PA.Department == "0")
                {
                    PA.Department = "NULL";
                }

                if (PA.PoolID == "0")
                {
                    PA.PoolID = "NULL";
                }

                if (PA.Deployable == "0")
                {
                    PA.Deployable = "NULL";
                }
                string strsql = "Exec usp_Sel_Whizible2_OrganizationResources '" + PA.EmployeeName + "','" + PA.CurrentDayOneMonthYear + "','" + PA.CurrentlastDayMonthYear + "'," + PA.BGID + "," + PA.OUID + "," + PA.RoleID + "," + PA.Designation + "," + PA.Skill + "," + PA.DUID + "," + PA.DTID + "," + PA.EmployeeType + "," + PA.Department + "," + PA.UserID + ",1," + PA.PoolID + "," + PA.Deployable + "," + PA.MyTeam + " ," + PA.PageNo + "," + PA.PageSize + "";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object TBodyFillLegends([FromBody] PlannedVSActual PA)
        {
            try
            {
                string strsql = "Exec usp_sel_Whizible2_Holidays_Legends " + PA.EmpID + ",'" + PA.FromDate + "','" + PA.ToDate + "','L'";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object TBodyFillAginstEmployee([FromBody] PlannedVSActual PA)
        {
            try
            {
                string strsql = "Exec usp_Sel_Whizible2_MonthlyTasks_PlannedHrsForAllResources " + PA.EmpID + ",'" + PA.CurrentDayOneMonthYear + "','" + PA.CurrentlastDayMonthYear + "' ";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //In Progress Task Start
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object ProgressTasksDetails([FromBody] PlannedVSActual PA)
        {
            try
            {
                if (PA.TaskType == "0")
                {
                    PA.TaskType = null;
                }
                if (PA.TaskProjectID == "0")
                {
                    PA.TaskProjectID = "";
                }
                string strsql = "Exec usp_Sel_Whizible2_Monthly_InProgressTasks_Details_ForAllResources " + PA.EmpID + ",'" + PA.FromDate + "','" + PA.ToDate + "','" + PA.TaskType + "','" + PA.TaskProjectID + "' ";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object ProgressTasksEmployeeName([FromBody] PlannedVSActual PA)
        {
            try
            {
                string strsql = "Exec usp_sel_Whizible2_tbl_PM_Employee_EmployeeName " + PA.EmpID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object ProgressNotStartedTasksEmployeeName([FromBody] PlannedVSActual PA)
        {
            try
            {
                if (PA.TaskType == "0")
                {
                    PA.TaskType = null;
                }
                if (PA.TaskProjectID == "0")
                {
                    PA.TaskProjectID = "";
                }
                string strsql = "Exec usp_Sel_Whizible2_Monthly_NotStartedTasks_Details_ForAllResources " + PA.EmpID + ",'" + PA.FromDate + "','" + PA.ToDate + "','" + PA.TaskType + "','" + PA.TaskProjectID + "' ";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object ProgressCompletedTasksEmployeeName([FromBody] PlannedVSActual PA)
        {
            try
            {
                if (PA.TaskType == "0")
                {
                    PA.TaskType = null;
                }
                if (PA.TaskProjectID == "0")
                {
                    PA.TaskProjectID = "";
                }
                string strsql = "Exec usp_Sel_Monthly_Whizible2_CompletedTasks_Details_ForAllResources " + PA.EmpID + ",'" + PA.FromDate + "','" + PA.ToDate + "','" + PA.TaskType + "','" + PA.TaskProjectID + "' ";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Task completed

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object ProjectAllocationResource([FromBody] PlannedVSActual PA)
        {
            try
            {
                string strsql = "Exec usp_Sel_tbl_Whizible2_PM_Employee_ProjectEmployeeInfo_ProjectAllocation " + PA.EmpID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object ProjectAllocationData([FromBody] PlannedVSActual PA)
        {
            try
            {
                string strsql = "Exec usp_Sel_tbl_Whizible2_ProjectAllocationData " + PA.EmpID + ",'" + PA.ProjectName + "','" + PA.ReportingTo + "'," + PA.IsBillable + "," + PA.IsActive + "  ";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object SkillData([FromBody] PlannedVSActual PA)
        {
            try
            {
                string strsql = "Exec usp_Sel_Whizible2_SkillData " + PA.EmpID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object LeaveDetail([FromBody] PlannedVSActual PA)
        {
            try
            {
                string strsql = "Exec usp_Sel_Whizible2_LeaveDetail " + PA.EmpID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object LeaveDetailYearly([FromBody] PlannedVSActual PA)
        {
            try
            {
                string strsql = "Exec usp_Sel_Whizible2_LeaveFinancialMonthwise " + PA.EmpID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object ResourceUtilizationMonthly([FromBody] PlannedVSActual PA)
        {
            try
            {
                string strsql = "Exec usp_Sel_Whizible2_ResourceUtilization_Monthly NULL,NULL,NULL," + PA.EmpID + "," + PA.Period + ",1," + PA.UserID + ",null,NULL,0";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        private int Weekday(int Year, int month, int day)
        {
            DateTime dateValue = new DateTime(Year, month, day);
            return (int)dateValue.DayOfWeek;
        }


        private string GetMonthName(int month)
        {
            string strMonthName = "";

            switch (month)
            {
                case 1:
                    {
                        strMonthName = "January";
                        break;
                    }
                case 2:
                    {
                        strMonthName = "February";
                        break;
                    }
                case 3:
                    {
                        strMonthName = "March";
                        break;
                    }
                case 4:
                    {
                        strMonthName = "April";
                        break;
                    }
                case 5:
                    {
                        strMonthName = "May";
                        break;
                    }
                case 6:
                    {
                        strMonthName = "June";
                        break;
                    }
                case 7:
                    {
                        strMonthName = "July";
                        break;
                    }
                case 8:
                    {
                        strMonthName = "August";
                        break;
                    }
                case 9:
                    {
                        strMonthName = "September";
                        break;
                    }
                case 10:
                    {
                        strMonthName = "October";
                        break;
                    }
                case 11:
                    {
                        strMonthName = "November";
                        break;
                    }
                case 12:
                    {
                        strMonthName = "December";
                        break;
                    }
            }
            return strMonthName;
        }

        //Added by Vishal Mane on 19/12/2025 to improve performance for W26
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetReportingManagerResources([FromBody] PlannedVSActual PA)
        {
            try
            {
                if (PA.EmployeeName == "")
                {
                    PA.EmployeeName = "";
                }
                if (PA.BGID == "0")
                {
                    PA.BGID = "NULL";
                }
                if (PA.OUID == "0")
                {
                    PA.OUID = "NULL";
                }

                if (PA.RoleID == "0")
                {
                    PA.RoleID = "NULL";
                }

                if (PA.Designation == "0")
                {
                    PA.Designation = "NULL";
                }

                if (PA.Skill == "0")
                {
                    PA.Skill = "NULL";
                }

                if (PA.DUID == "0")
                {
                    PA.DUID = "NULL";
                }

                if (PA.DTID == "0")
                {
                    PA.DTID = "NULL";
                }

                if (PA.EmployeeType == "0")
                {
                    PA.EmployeeType = "NULL";
                }

                if (PA.Department == "0")
                {
                    PA.Department = "NULL";
                }

                if (PA.PoolID == "0")
                {
                    PA.PoolID = "NULL";
                }

                if (PA.Deployable == "0")
                {
                    PA.Deployable = "NULL";
                }
                string strsql = "Exec usp_Sel_Whizible2_ReportingManagerResources '" + PA.EmployeeName + "','" + PA.CurrentDayOneMonthYear + "','" + PA.CurrentlastDayMonthYear + "'," + PA.BGID + "," + PA.OUID + "," + PA.RoleID + "," + PA.Designation + "," + PA.Skill + "," + PA.DUID + "," + PA.DTID + "," + PA.EmployeeType + "," + PA.Department + "," + PA.UserID + ",1," + PA.PoolID + "," + PA.Deployable + "," + PA.MyTeam + " ," + PA.PageNo + "," + PA.PageSize + "," + PA.ReportingTo + ", " + PA.ReportingToLevel + ", " + PA.ReportMode + "";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetReportingManagers([FromBody] PlannedVSActual PA)
        {
            try
            {
                if (PA.EmployeeName == "")
                {
                    PA.EmployeeName = "";
                }
                if (PA.BGID == "0")
                {
                    PA.BGID = "NULL";
                }
                if (PA.OUID == "0")
                {
                    PA.OUID = "NULL";
                }

                if (PA.RoleID == "0")
                {
                    PA.RoleID = "NULL";
                }

                if (PA.Designation == "0")
                {
                    PA.Designation = "NULL";
                }

                if (PA.Skill == "0")
                {
                    PA.Skill = "NULL";
                }

                if (PA.DUID == "0")
                {
                    PA.DUID = "NULL";
                }

                if (PA.DTID == "0")
                {
                    PA.DTID = "NULL";
                }

                if (PA.EmployeeType == "0")
                {
                    PA.EmployeeType = "NULL";
                }

                if (PA.Department == "0")
                {
                    PA.Department = "NULL";
                }

                if (PA.PoolID == "0")
                {
                    PA.PoolID = "NULL";
                }

                if (PA.Deployable == "0")
                {
                    PA.Deployable = "NULL";
                }
                string strsql = "Exec usp_Sel_Whizible2_OrganizationResources_Performance '" + PA.EmployeeName + "','" + PA.CurrentDayOneMonthYear + "','" + PA.CurrentlastDayMonthYear + "'," + PA.BGID + "," + PA.OUID + "," + PA.RoleID + "," + PA.Designation + "," + PA.Skill + "," + PA.DUID + "," + PA.DTID + "," + PA.EmployeeType + "," + PA.Department + "," + PA.UserID + ",1," + PA.PoolID + "," + PA.Deployable + "," + PA.MyTeam + " ," + PA.PageNo + "," + PA.PageSize + ", "+ PA.ReportingToLevel + ", " + PA.ReportMode + "," + PA.IsFilter + "";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object TBodyFillAginstEmployee_Updated([FromBody] PlannedVSActual PA)
        {
            try
            {
                string strsql = "Exec usp_Sel_Whizible2_MonthlyTasks_PlannedHrsForAllResources_Snapshot " + PA.EmpID + ",'" + PA.CurrentDayOneMonthYear + "','" + PA.CurrentlastDayMonthYear + "', " + PA.ReportMode + "";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object TBodyFillLegends_Updated([FromBody] PlannedVSActual PA)
        {
            try
            {
                string strsql = "Exec usp_sel_Whizible2_Holidays_Legends_Snapshot " + PA.EmpID + ",'" + PA.FromDate + "','" + PA.ToDate + "','L'," + PA.ReportMode + "";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added by Vishal Mane on 19/12/2025 to improve performance for W26

        //Added by Vishal Mane on 30/12/2025 for Timesheet Compliance Export functionality
        [HttpPost]
        [Authorize]
        public object ExportDocument([FromBody] PlannedVSActual PA)
        {
            try
            {
                string strSQL;
                PA.EmployeeName = PA.EmployeeName ?? "";
                PA.BGID = PA.BGID == "0" ? "NULL" : PA.BGID;
                PA.OUID = PA.OUID == "0" ? "NULL" : PA.OUID;
                PA.RoleID = PA.RoleID == "0" ? "NULL" : PA.RoleID;
                PA.Designation = PA.Designation == "0" ? "NULL" : PA.Designation;
                PA.Skill = PA.Skill == "0" ? "NULL" : PA.Skill;
                PA.DUID = PA.DUID == "0" ? "NULL" : PA.DUID;
                PA.DTID = PA.DTID == "0" ? "NULL" : PA.DTID;
                PA.EmployeeType = PA.EmployeeType == "0" ? "NULL" : PA.EmployeeType;
                PA.Department = PA.Department == "0" ? "NULL" : PA.Department;
                PA.PoolID = PA.PoolID == "0" ? "NULL" : PA.PoolID;
                PA.Deployable = PA.Deployable == "0" ? "NULL" : PA.Deployable;

                strSQL = "Exec usp_Whizible2_CRW_Sel_TimesheetCompliance_Report '" + PA.EmployeeName + "','" + PA.CurrentDayOneMonthYear + "','" + PA.CurrentlastDayMonthYear + "'," + PA.BGID + "," + PA.OUID + "," + PA.RoleID + "," + PA.Designation + "," + PA.Skill + "," + PA.DUID + "," + PA.DTID + "," + PA.EmployeeType + "," + PA.Department + "," + PA.UserID + ",1," + PA.PoolID + "," + PA.Deployable + "," + PA.MyTeam + ", " + PA.ReportingToLevel + ", " + PA.ReportMode + "," + PA.IsFilter + "";
                //strSQL = "Exec usp_Whizible2_CRW_Sel_TimesheetCompliance_Report 491";
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (dt == null || dt.Rows.Count == 0)
                {
                    return "";
                }
                // Generate Excel using ClosedXML
                using (var workbook = new XLWorkbook())
                {
                    var ws = workbook.AddWorksheet("Timesheet Compliance");
                    // Create header row from DataTable columns
                    for (int col = 0; col < dt.Columns.Count; col++)
                    {
                        ws.Cell(1, col + 1).Value = dt.Columns[col].ColumnName;
                        ws.Cell(1, col + 1).Style.Font.Bold = true;
                        ws.Cell(1, col + 1).Style.Fill.BackgroundColor = XLColor.LightGray;
                        ws.Cell(1, col + 1).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                    }
                    // ✅ Freeze header + first columns
                    ws.SheetView.FreezeRows(1);
                    ws.SheetView.FreezeColumns(2);
                    // Fill data rows
                    for (int row = 0; row < dt.Rows.Count; row++)
                    {
                        for (int col = 0; col < dt.Columns.Count; col++)
                        {
                            var cellValue = CommonFunctions.Data.CheckIsDBNull(dt.Rows[row][col], "");
                            ws.Cell(row + 2, col + 1).Value = cellValue.ToString();                            
                            // Format time columns (HH:MM format) as text
                            if (dt.Columns[col].ColumnName.Contains("Day") || dt.Columns[col].ColumnName.Contains("Time") || dt.Columns[col].ColumnName.Contains("Hours"))
                            {
                                ws.Cell(row + 2, col + 1).Style.NumberFormat.Format = "@";
                            }
                        }
                    }
                    ws.Columns().AdjustToContents();
                    string folderPath = HttpContext.Current.Server.MapPath("../../../Attachments/Timesheet_Compliance_Reports/");                    
                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }
                    string fileName = $"TimesheetCompliance_{Guid.NewGuid()}.xlsx";
                    string filePath = Path.Combine(folderPath, fileName);
                    workbook.SaveAs(filePath);
                    return fileName;
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added by Vishal Mane on 30/12/2025 for Timesheet Compliance Export functionality
    }
}