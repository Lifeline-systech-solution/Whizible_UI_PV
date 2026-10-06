using Microsoft.VisualBasic;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Script.Serialization;
using System.Xml;
using WhizibleAPI.Models;
using WhizibleAPI.Models.PM;
using System.Runtime.InteropServices;

namespace WhizibleAPI.Controllers
{
    public class PM_ProjectClosureController : ApiController
    {
        ProjectData projectData = new ProjectData();


        [HttpPost]
        ////Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetAllInfoAboutProject([FromBody] int ProjectId)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Sel_Whizible2_tbl_PM_Project " + HttpUtility.UrlDecode(Convert.ToString(ProjectId));

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetEmployeeToAllocateProject([FromBody] int ProjectId)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_GetProjectEmployeeWorkPeriod " + HttpUtility.UrlDecode(Convert.ToString(ProjectId));

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object Get_PM_ProjectTools([FromBody] PostSkillExperiance ExperianceAttribute)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_GetEmployeeSkillsOnProject " + HttpUtility.UrlDecode(Convert.ToString(ExperianceAttribute.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ExperianceAttribute.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ExperianceAttribute.IsProjectOver)) + "";
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetProjectActualEndDate([FromBody] int ProjectID)
        {
            try
            {
                string strSQL = "";
                strSQL = "usp_Whizible2_sel_tbl_PM_DailyActivity_Max_EntryDate_getdate " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));
                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return Result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //[Authorize]
        //[HttpPost]
        //public object GetMonthYearValidation([FromBody] PostSkillExperiance ExperianceAttribute)
        //{
        //    string strSQL = "usp_Whizible2_ValidateEmployeeExperienceOnProject  " + HttpUtility.UrlDecode(Convert.ToString(ExperianceAttribute.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ExperianceAttribute.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ExperianceAttribute.YearsExperience)) + "," + HttpUtility.UrlDecode(Convert.ToString(ExperianceAttribute.MonthsExperience)) + "";

        //    object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

        //    return Result;
        //}

        //Added By Dipali V On 19th April 2021 For Update Skill of All Resource
        [HttpPost]

        public object GetMonthYearValidation([FromBody] PostSkillExperiance ExperianceAttribute)
        {
            string strSQL = "";
            string strMsg;
            try
            {
                strSQL = "Exec usp_Whizible2_ValidateEmployeeExperienceOnProject " + HttpUtility.UrlDecode(Convert.ToString(ExperianceAttribute.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ExperianceAttribute.ProjectID)) + " ," + HttpUtility.UrlDecode(Convert.ToString(ExperianceAttribute.YearsOfExperience)) + "," + HttpUtility.UrlDecode(Convert.ToString(ExperianceAttribute.MonthsOfExperience));

                strMsg = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                return strMsg;
            }
            catch (Exception e)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Dipali V On 19th April 2021 For Update Skill of All Resource

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object PostAllResourceSkillExperiance([FromBody] PostSkillExperiance ExperianceAttribute)
        {
            try
            {
                string strSQL = "";
                string strMsg;
                strSQL = "Exec usp_Whizible2_Ins_tbl_PM_EmployeeSkillMatrix_DetailAllResource " + HttpUtility.UrlDecode(Convert.ToString(ExperianceAttribute.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ExperianceAttribute.EmployeeID)) + "";

                strMsg = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                return strMsg;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        public HttpResponseMessage Get_PM_MinDate([FromBody] int ProjectId)
        {

            try
            {
                HttpRequestMessage request = new HttpRequestMessage();
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_sel_tbl_PM_DailyActivity_MIN_EntryDate " + HttpUtility.UrlDecode(Convert.ToString(ProjectId));
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                projectData.StartDate = dt.ToString();
                if (projectData.StartDate != "")
                {
                    projectData.m_intYearsToBeShown = Convert.ToInt32(DateAndTime.DateDiff(DateInterval.Month, Convert.ToDateTime(projectData.StartDate), DateTime.Now) / (double)12);
                    if (Convert.ToInt32(DateAndTime.DateDiff(DateInterval.Month, Convert.ToDateTime(projectData.StartDate), DateTime.Now) % (double)12) >= 11)
                    {
                        projectData.m_intYearsToBeShown = 1;
                    }
                    if (projectData.m_intYearsToBeShown == 0)
                    {
                        projectData.m_intMonthsToBeShown = Convert.ToInt32(DateAndTime.DateDiff(DateInterval.Day, Convert.ToDateTime(projectData.StartDate), DateTime.Now) / (double)30);
                        if (projectData.m_intMonthsToBeShown < 11)
                        {
                            projectData.m_intMonthsToBeShown += 1;
                        }
                    }
                    else
                    {
                        projectData.m_intMonthsToBeShown = 11;
                    }
                }
                else
                {
                    projectData.m_intYearsToBeShown = 0;
                    projectData.m_intMonthsToBeShown = 0;
                }
                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, projectData);
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added By Dipali V On 16th Nov 2019 For Skill Dropdown

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetSkillDropDown([FromBody] PostSkillExperiance ExperianceAttribute)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible_GetAllSkillls " + HttpUtility.UrlDecode(Convert.ToString(ExperianceAttribute.ProjectID));

                System.Data.DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Dipali V On 16th Nov 2019 For Skill Dropdown

        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        public HttpResponseMessage GetExperienceYearMonth([FromBody] PostSkillExperiance ExperianceAttribute)
        {

            try
            {
                HttpRequestMessage request = new HttpRequestMessage();
                string strSQL = "EXEC usp_Whizible2_sel_ExpectedStartDate_tbl_PM_ProjectEmployeeRole " +
            HttpUtility.UrlDecode(Convert.ToString(ExperianceAttribute.ProjectID)) + "," +
            HttpUtility.UrlDecode(Convert.ToString(ExperianceAttribute.EmployeeID));

                object ExpectedStartDate = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);


                string StrartDate = ExpectedStartDate.ToString();
                //StrartDate = "1/4/2017 12:00:00 AM";
                //DateTime ExpectedStartDate1 = (DateTime)StrartDate;
                DateTime ExpectedStartDate1 = Convert.ToDateTime(StrartDate);
                string ActualYear = (ExpectedStartDate1.Year).ToString();
                if (StrartDate != "")
                {
                    projectData.m_intYearsToBeShown = Convert.ToInt32(DateAndTime.DateDiff(DateInterval.Month, Convert.ToDateTime(StrartDate), DateTime.Now) / (double)12);
                    if (Convert.ToInt32(DateAndTime.DateDiff(DateInterval.Month, Convert.ToDateTime(StrartDate), DateTime.Now) % (double)12) >= 11)
                    {
                        projectData.m_intYearsToBeShown = 1;
                    }
                    if (projectData.m_intYearsToBeShown == 0)
                    {
                        projectData.m_intMonthsToBeShown = Convert.ToInt32(DateAndTime.DateDiff(DateInterval.Day, Convert.ToDateTime(StrartDate), DateTime.Now) / (double)30);
                        if (projectData.m_intMonthsToBeShown < 11)
                        {
                            projectData.m_intMonthsToBeShown += 1;
                        }
                    }
                    else
                    {
                        DateTime TodayDate = DateTime.Now;
                        string Year = (TodayDate.Year).ToString();
                        string StrartDate1 = ExpectedStartDate1.ToString("dd/MM/yyyy hh:mm:ss tt");
                        StrartDate1 = StrartDate1.Replace(ActualYear, Year);
                        projectData.m_intMonthsToBeShown = Convert.ToInt32(DateAndTime.DateDiff(DateInterval.Day, Convert.ToDateTime(StrartDate1), DateTime.Now) / (double)30);
                        if (projectData.m_intMonthsToBeShown < 11)
                        {
                            projectData.m_intMonthsToBeShown += 1;
                        }
                    }
                }
                else
                {
                    projectData.m_intYearsToBeShown = 0;
                    projectData.m_intMonthsToBeShown = 0;
                }
                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, projectData);
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object Get_PM_MaxDate([FromBody] int ProjectId)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_sel_tbl_PM_DailyActivity_Max_EntryDate_getdate " + HttpUtility.UrlDecode(Convert.ToString(ProjectId));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        public object PostPM_Skills([FromBody] Post_Skills SkillAttribute)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Post_PM_ProjectTools '" + HttpUtility.UrlDecode(SkillAttribute.Description) + "','" + HttpUtility.UrlDecode(SkillAttribute.loggedPerson) + "'," + HttpUtility.UrlDecode(Convert.ToString(SkillAttribute.IsSkill));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object PostSkillsAllocateToProject([FromBody] SkillAllocateToProject SkillAllocateAttribute)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_INS_tbl_PM_ProjectTools " +
                HttpUtility.UrlDecode(SkillAllocateAttribute.ProjectID) + "," +
                HttpUtility.UrlDecode(SkillAllocateAttribute.ParameterId) + "," +
                HttpUtility.UrlDecode(SkillAllocateAttribute.Version) + "," +
                HttpUtility.UrlDecode(SkillAllocateAttribute.PercentageUtilization) + "," +
                HttpUtility.UrlDecode(SkillAllocateAttribute.IsCustomerSupplied) + "," +
                HttpUtility.UrlDecode(SkillAllocateAttribute.IsCritical) + "," +
                HttpUtility.UrlDecode(SkillAllocateAttribute.IsProcured) + "," +
                HttpUtility.UrlDecode(SkillAllocateAttribute.BriefDescription) + "," +
                HttpUtility.UrlDecode(SkillAllocateAttribute.NumberOfCopies) + "," +
                HttpUtility.UrlDecode(SkillAllocateAttribute.PlannedInDate) + "," +
                HttpUtility.UrlDecode(SkillAllocateAttribute.PlannedOutDate) + "," +
                HttpUtility.UrlDecode(SkillAllocateAttribute.ToolIDS) + "," +
                HttpUtility.UrlDecode(SkillAllocateAttribute.CreatedBy);

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object PostSkillExperiance([FromBody] PostSkillExperiance ExperianceAttribute)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Ins_tbl_PM_EmployeeSkillMatrix_Detail " +
            HttpUtility.UrlDecode(Convert.ToString(ExperianceAttribute.ProjectID)) + "," +
            HttpUtility.UrlDecode(Convert.ToString(ExperianceAttribute.EmployeeID)) + "," +
            HttpUtility.UrlDecode(Convert.ToString(ExperianceAttribute.ToolID)) + "," +
            HttpUtility.UrlDecode(Convert.ToString(ExperianceAttribute.YearsOfExperience)) + "," +
            HttpUtility.UrlDecode(Convert.ToString(ExperianceAttribute.MonthsOfExperience)) + "," +
            HttpUtility.UrlDecode(Convert.ToString(ExperianceAttribute.blnAddNewSkill));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object CheckProjectOver([FromBody] PostSkillExperiance ExperianceAttribute)
        {
            try
            {
                int strmsg;
                strmsg = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("Exec usp_sel_tbl_PM_Project_IsOver " + ExperianceAttribute.ProjectID + "", true, CommonController.connectionString));
                return strmsg;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //[HttpPost]
        //[Authorize]
        //public DataTable GetExperianceUpdated([FromBody]PostSkillExperiance GetExperianceAttribute)
        //{
        //    string strSQL = "";
        //    strSQL = "Exec usp_Sel_Whizible2_Get_tbl_PM_EmployeeSkillMatrix_Detail_ByID " + GetExperianceAttribute.ProjectID + "," + GetExperianceAttribute.EmployeeID;
        //    DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
        //    return dt;
        //}

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetEmployeeSkillMatrixDetails([FromBody] PostSkillExperiance GetExperianceAttribute)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_EmployeeSkillMatrix_Detail " + HttpUtility.UrlDecode(Convert.ToString(GetExperianceAttribute.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(GetExperianceAttribute.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(GetExperianceAttribute.ToolID));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //omkar code start

        //get Project view data and project size data        
        ProjectOverViewData projectOverViewData = new ProjectOverViewData();
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public HttpResponseMessage GetProjectViewData([FromBody] int ProjectId)
        {

            try
            {
                HttpRequestMessage request = new HttpRequestMessage();
                //get project details colsed or not using ProjectId
                string strSQL = "";
                strSQL = "select [over] from tbl_pm_Project where  ProjectID=" + HttpUtility.UrlDecode(ProjectId.ToString());
                projectOverViewData.CloseProject = Convert.ToBoolean(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                //get Project Overview data using ProjectId
                strSQL = "";
                strSQL = "Exec USP_Whizible2_RPT_CR_PROJECTOVERVIEW " + HttpUtility.UrlDecode(ProjectId.ToString());
                projectOverViewData.ProjectOverview = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                //get Project size of data using ProjectId
                strSQL = "";
                strSQL = "Exec usp_Whizible2_RPT_CR_PROJECTSIZE " + HttpUtility.UrlDecode(ProjectId.ToString());
                projectOverViewData.ProjectSize = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow dr in projectOverViewData.ProjectSize.Rows)
                {
                    var obj = dr["EFFORT VARIANCE"].ToString();
                    if (obj.Length > 0)
                    {
                        var value = projectOverViewData.ProjectSize.Rows[0].Field<double>("EFFORT VARIANCE");
                        dr["EFFORT VARIANCE"] = System.Math.Round(value, 2);
                    }
                }

                // get Project Parameters Data using ProjectId
                strSQL = "";
                strSQL = "Exec USP_Whizible2_RPT_CR_PROJPARAMETERS " + HttpUtility.UrlDecode(ProjectId.ToString());
                projectOverViewData.ProjectPlannedVsActual = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                //get Project SumOf work
                // projectOverViewData.SumOfWork = Convert.ToDecimal(projectOverViewData.ProjectPlannedVsActual.AsEnumerable().Sum(c => c.Field<double>("ESTIMATED EFFORTS")));

                // get Projcect SumOfActualWork
                //projectOverViewData.SumOfActualWork = Convert.ToDecimal(projectOverViewData.ProjectPlannedVsActual.AsEnumerable().Sum(c => c.Field<double>("ACTUAL EFFORTS")));
                //
                if (Convert.ToString(projectOverViewData.ProjectPlannedVsActual) != "")
                {

                    projectOverViewData.SumOfWork = CommonFunctions.Data.CheckIsDBNull(projectOverViewData.ProjectPlannedVsActual.Rows[0].Field<string>("SUM ESTIMATED EFFORTS"), "0").ToString();
                    projectOverViewData.SumOfActualWork = CommonFunctions.Data.CheckIsDBNull(projectOverViewData.ProjectPlannedVsActual.Rows[0].Field<string>("SUM ACTUAL EFFORTS"), "0").ToString();



                }

                ////get Project SumOfReivew
                //projectOverViewData.SumOfReivew = Convert.ToDecimal(projectOverViewData.ProjectReviewStatistics.AsEnumerable().Sum(c => c.Field<double>("NOOFREVIEWS")));

                ////get Project SumOfReviewEfforts
                //projectOverViewData.SumOfReviewEfforts = Convert.ToDecimal(projectOverViewData.ProjectReviewStatistics.AsEnumerable().Sum(c => c.Field<double>("REVIEWEFFORT")));

                ////get Project  SumOfDefects
                //projectOverViewData.SumOfDefects = Convert.ToDecimal(projectOverViewData.ProjectReviewStatistics.AsEnumerable().Sum(c => c.Field<int>("NOOFDEFECTS")));


                //get Project Review Statistics data
                strSQL = "";
                strSQL = "Exec USP_Whizible2_RPT_CR_REVIEWSTATISTICS " + HttpUtility.UrlDecode(ProjectId.ToString());
                projectOverViewData.ProjectReviewStatistics = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                if (Convert.ToString(projectOverViewData.ProjectReviewStatistics) != "")
                {
                    projectOverViewData.SumOfReivew = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectOverViewData.ProjectReviewStatistics.Rows[0].Field<string>("SUMREVIEWEFFORT"), "0").ToString());
                    projectOverViewData.SumOfDefects = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(projectOverViewData.ProjectReviewStatistics.Rows[0].Field<int>("NOOFDEFECTS"), "0").ToString());

                }
                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, projectOverViewData);
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


        //get Project closer count and details
        ProjectCloser projectCloser = new ProjectCloser();
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        //[App_Start.ValidateRateLimit]   //Commented by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage GetProjectCloserData([FromBody] ProjectCloser projectcloser)
        {

            try
            {
                string strSQL;
                HttpRequestMessage request = new HttpRequestMessage();

                //get Project Overview data using ProjectId
                strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Tasks_ProjectClosure " + HttpUtility.UrlDecode(projectcloser.ProjectId.ToString()) + ",'" + HttpUtility.UrlDecode(projectcloser.LocationType.ToString()) + "'";
                projectCloser.ProjectClosureDetails = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                //get Project size of data using ProjectId
                strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Tasks_ProjectClosure_GetCount " + HttpUtility.UrlDecode(projectcloser.ProjectId.ToString());
                projectCloser.ProjectClosureCount = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, projectCloser);
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //[HttpPost]
        //[Authorize]
        //public HttpResponseMessage ProjectTaskCloseOrVoid([FromBody] ProjectCloser projectcloser)
        //{

        //    try
        //    {
        //        string strSQL;
        //        HttpRequestMessage request = new HttpRequestMessage();
        //        foreach (var TaskId in projectcloser.Taskids)
        //        {
        //            strSQL = "Exec usp_Whizible2_tbl_PM_ProjectTasks_checkTaskType " + HttpUtility.UrlDecode(TaskId);
        //            object flag = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
        //            strSQL = "";
        //            if ((int)flag == 0)
        //            {
        //                strSQL = "Exec usp_Whizible2_Upd_AssignedTasks_Updation_ProjectClosure 1," + HttpUtility.UrlDecode(projectcloser.ProjectId.ToString()) + "," + HttpUtility.UrlDecode(TaskId);
        //                // object result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

        //            }
        //            else
        //            {
        //                strSQL = "Exec usp_Whizible2_Upd_AssignedTasks_Updation_ProjectClosure 2," + HttpUtility.UrlDecode(projectcloser.ProjectId.ToString()) + "," + HttpUtility.UrlDecode(TaskId);
        //                // object result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
        //            }
        //            object result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
        //        }




        //        var configuration = new HttpConfiguration();
        //        request.SetConfiguration(configuration);
        //        return request.CreateResponse(HttpStatusCode.OK, "Project Task is successfully closed");
        //    }
        //    catch (Exception e)
        //    {
        //        return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
        //    }

        //}


        // Added By Dipali V On 20th May 2026 - Purpose:-Batch close/void via usp_Whizible2_Upd_AssignedTasks_ProjectClosure_Batch (comma-separated TaskIdsCsv); avoids crash/timeout for 100+ tasks.
        [HttpPost]
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage ProjectTaskCloseOrVoid([FromBody] ProjectCloser projectcloser)
        {
            try
            {
                HttpRequestMessage request = new HttpRequestMessage();
                int projectId = projectcloser.ProjectId;
                if (projectId <= 0)
                {
                    return Request.CreateErrorResponse(HttpStatusCode.BadRequest, "Invalid project.");
                }

                var taskIdList = new List<string>();
                if (projectcloser.Taskids != null)
                {
                    foreach (var taskId in projectcloser.Taskids)
                    {
                        string id = Convert.ToString(taskId).Trim();
                        if (!string.IsNullOrEmpty(id))
                        {
                            taskIdList.Add(id);
                        }
                    }
                }
                if (!string.IsNullOrWhiteSpace(projectcloser.TaskIdsCsv))
                {
                    foreach (string part in projectcloser.TaskIdsCsv.Split(','))
                    {
                        string id = part.Trim();
                        if (!string.IsNullOrEmpty(id))
                        {
                            taskIdList.Add(id);
                        }
                    }
                }


                if (taskIdList.Count == 0)
                {
                    return Request.CreateErrorResponse(HttpStatusCode.BadRequest, "No tasks selected.");
                }

                string taskIdsCsv = string.Join(",", taskIdList.Distinct());
                string strSQL = "Exec usp_Whizible2_Upd_AssignedTasks_ProjectClosure_Batch "
                    + projectId.ToString()
                    + ", N'" + taskIdsCsv.Replace("'", "''") + "'";
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, "Project Task is successfully closed");
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Project Lessons Learned Details
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public HttpResponseMessage GetProjectLessonsLearnedDetails([FromBody] int ProjectId)
        {

            try
            {
                string strSQL;
                HttpRequestMessage request = new HttpRequestMessage();
                //Get Project Lessons Learned Details
                strSQL = "";
                strSQL = "Exec usp_Whizible2_sel_tbl_PM_ProjectLessonsLearned " + HttpUtility.UrlDecode(ProjectId.ToString());
                lessonLearnt.LessonLearntData = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ProjectDocuments_ProjectClosure_GetFileName " + HttpUtility.UrlDecode(ProjectId.ToString());
                lessonLearnt.LessonLearntDocument = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, lessonLearnt);
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Get Project Lessons Learned Details
        [HttpPost]
        [Authorize]
        public HttpResponseMessage GetLessonLeanProblemTypes()
        {
            try
            {
                string strSQL;
                HttpRequestMessage request = new HttpRequestMessage();

                //Get Project Lessons Learned Details
                strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_LessonLeanProblemTypes ";
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, dt);
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Commented & Added By Dipalii V On 8th July 2020 For Check FileType
        public bool GetFileType()
        {
            bool fileUploadFlag = false;
            string MimeType = "";
            string strFileName = CommonFunctions.FileDirectory.GetUniqueFileName();
            if (HttpContext.Current.Request.Files.AllKeys.Any())
            {
                for (int filecount = 0; filecount < HttpContext.Current.Request.Files.Count; filecount++)
                {
                    //Stream xmlStream = System.Web.HttpContext.Current.Request.Files[filecount].InputStream;
                    //Stream txtStream = System.Web.HttpContext.Current.Request.Files[filecount].InputStream;
                    //string filePath = System.Web.HttpContext.Current.Request.Files[filecount].FileName;
                    //string filename = Path.GetFileName(filePath);
                    //string ext = Path.GetExtension(filename);
                    //ext = ext.Substring(1, ext.Length - 1);//For TExt File
                    //string contenttype = String.Empty;
                    //Stream checkStream = System.Web.HttpContext.Current.Request.Files[filecount].InputStream;
                    //BinaryReader chkBinary = new BinaryReader(checkStream);
                    //Byte[] chkbytes = chkBinary.ReadBytes(0x10);
                    //string strListofTypes = ConfigurationManager.AppSettings["FileContentType"];
                    //string magicNumber = BitConverter.ToString(chkbytes);
                    //string magicCheck = magicNumber.Substring(0, 11);
                    //magicNumber = magicNumber.Replace("-", " ");
                    //magicCheck = magicCheck.Replace("-", " ");
                    //XmlDocument xmlDoc = new XmlDocument();
                    //string xmlPath = CommonFunctions.FileDirectory.CleanPath(System.IO.Directory.GetParent(System.IO.Directory.GetParent(System.AppDomain.CurrentDomain.BaseDirectory).FullName).FullName);
                    //xmlDoc.Load(xmlPath + "MIMEType.xml");
                    //XmlNodeList nodes = xmlDoc.DocumentElement.SelectNodes("/MIMETYPE/MIME");
                    //string xMagicNumber = "";
                    //for (int i = 0; i < nodes.Count; i++)
                    //{
                    //    xMagicNumber = nodes[i].SelectSingleNode("MagicNumber").InnerText;
                    //    int strlength = xMagicNumber.Length;

                    //    if (xMagicNumber.IndexOf(magicCheck) != -1 || magicCheck.IndexOf(xMagicNumber) != -1)
                    //    {
                    //        MimeType = nodes[i].SelectSingleNode("ContentType").InnerText;
                    //        fileUploadFlag = true;
                    //        break;
                    //    }
                    //    else
                    //    {
                    //        if (ext == xMagicNumber)
                    //        {
                    //            MimeType = nodes[i].SelectSingleNode("ContentType").InnerText;
                    //            fileUploadFlag = false;
                    //        }
                    //    }
                    //}

                    string fileName = HttpContext.Current.Request.Files[filecount].FileName;
                    string fileName1 = Utilities.Security.SecurityBuilder.CheckUserInput(fileName, 2, true, true, true);
                    string strListofTypes = ConfigurationManager.AppSettings["FileContentType"];
                    string ValidateFileName = ConfigurationManager.AppSettings["ValidateFileName"];
                    string[] CharList;
                    int IsFileValid = 1;
                    string[] extensionList;
                    CharList = ValidateFileName.Split(',');
                    for (int i = 0; i <= CharList.Length - 1; i++)
                    {
                        if (fileName.Contains(CharList[i].ToString()))
                        {
                            fileName1 = fileName1.Replace(CharList[i].ToString(), "");
                        }
                    }
                    extensionList = fileName.Split('.');
                    if (extensionList.Length > 2)
                    {
                        IsFileValid = 0;
                    }
                    if (fileName == fileName1 && IsFileValid == 1)
                    {
                        string ContentType = String.Empty;
                        byte[] buffer = new byte[257];
                        //string MimeType = "";
                        HttpPostedFile file = System.Web.HttpContext.Current.Request.Files[filecount];
                        //var strFileType = "";
                        var strFileType = getMimeFromFile(HttpContext.Current.Request.Files[filecount]);
                        file.InputStream.Read(buffer, 0, 256);
                        file.InputStream.Position = 0;
                        string magicNumber = BitConverter.ToString(buffer);
                        magicNumber = magicNumber.Replace("-", " ");
                        XmlDocument xmlDoc = new XmlDocument();
                        string xmlPath = CommonFunctions.FileDirectory.CleanPath(System.IO.Directory.GetParent(System.IO.Directory.GetParent(System.AppDomain.CurrentDomain.BaseDirectory).FullName).FullName);
                        xmlDoc.Load(xmlPath + "MIMEType.xml");
                        XmlNodeList nodes = xmlDoc.DocumentElement.SelectNodes("/MIMETYPE/MIME");
                        string xMagicNumber = "";
                        string xContentType = "";
                        string extfromContentType = "";

                        // Added by imran on 02-01-2023
                        //string fileNameExtention = HttpContext.Current.Request.Files[filecount].FileName;
                        //string ext1 = Path.GetExtension(fileNameExtention);
                        //int count = ext1.Split('.').Length - 1;
                        //int count2 = fileNameExtention.Split('.').Length - 1;
                        //if (count > 1)
                        //{
                        //    MimeType = "";
                        //}
                        //if (count == 1 && count2 == 1)
                        //{
                        foreach (XmlNode node in nodes)
                        {
                            xContentType = node.SelectSingleNode("ContentType").InnerText;
                            if (strFileType == xContentType)
                            {
                                fileName = HttpContext.Current.Request.Files[filecount].FileName;
                                string ext = Path.GetExtension(fileName);
                                ext = ext.Substring(1, ext.Length - 1).ToLower();
                                extfromContentType = node.SelectSingleNode("Extension").InnerText.ToLower();
                                if (extfromContentType.IndexOf(ext) > -1)
                                {
                                    MimeType = strFileType;
                                    break;
                                }
                            }
                        }
                        // }
                        // End of comment by imran on 02-01-2022
                    }
                    else
                    {
                        MimeType = "";
                    }

                    if (MimeType == "" || MimeType == null)
                    {
                        MimeType = "unknown/unknowns";
                        fileUploadFlag = false;
                    }
                    //Commented and added by Chetan M on 23rd Jully 2020 for IssueID = 24504
                    //if (strListofTypes.IndexOf(MimeType) == -1)
                    if (strListofTypes.IndexOf(MimeType) > -1 && MimeType != "unknown/unknowns")
                    //End of Commented and added by Chetan M on 23rd Jully 2020 for IssueID = 24504
                    {
                        fileUploadFlag = true;
                    }
                }

            }

            return fileUploadFlag;
        }

        //public bool GetFileType()
        //{
        //    bool fileUploadFlag = false;
        //    string MimeType = "";
        //    string strFileName = CommonFunctions.FileDirectory.GetUniqueFileName();
        //    if (HttpContext.Current.Request.Files.AllKeys.Any())
        //    {
        //        for (int filecount = 0; filecount < HttpContext.Current.Request.Files.Count; filecount++)
        //        {
        //            Stream xmlStream = System.Web.HttpContext.Current.Request.Files[filecount].InputStream;
        //            Stream txtStream = System.Web.HttpContext.Current.Request.Files[filecount].InputStream;
        //            string filePath = System.Web.HttpContext.Current.Request.Files[filecount].FileName;
        //            string filename = Path.GetFileName(filePath);
        //            string ext = Path.GetExtension(filename);
        //            ext = ext.Substring(1, ext.Length - 1);//For TExt File
        //            string contenttype = String.Empty;
        //            Stream checkStream = System.Web.HttpContext.Current.Request.Files[filecount].InputStream;
        //            BinaryReader chkBinary = new BinaryReader(checkStream);
        //            Byte[] chkbytes = chkBinary.ReadBytes(0x10);
        //            string strListofTypes = ConfigurationManager.AppSettings["FileContentType"];
        //            string magicNumber = BitConverter.ToString(chkbytes);
        //            string magicCheck = magicNumber.Substring(0, 11);
        //            magicNumber = magicNumber.Replace("-", " ");
        //            magicCheck = magicCheck.Replace("-", " ");
        //            XmlDocument xmlDoc = new XmlDocument();
        //            string xmlPath = CommonFunctions.FileDirectory.CleanPath(System.IO.Directory.GetParent(System.IO.Directory.GetParent(System.AppDomain.CurrentDomain.BaseDirectory).FullName).FullName);
        //            xmlDoc.Load(xmlPath + "MIMEType.xml");
        //            XmlNodeList nodes = xmlDoc.DocumentElement.SelectNodes("/MIMETYPE/MIME");
        //            string xMagicNumber = "";
        //            for (int i = 0; i < nodes.Count; i++)
        //            {
        //                xMagicNumber = nodes[i].SelectSingleNode("MagicNumber").InnerText;
        //                int strlength = xMagicNumber.Length;

        //                if (xMagicNumber.IndexOf(magicCheck) != -1 || magicCheck.IndexOf(xMagicNumber) != -1)
        //                {
        //                    MimeType = nodes[i].SelectSingleNode("ContentType").InnerText;
        //                    fileUploadFlag = true;
        //                    break;
        //                }
        //                else
        //                {
        //                    if (ext == xMagicNumber)
        //                    {
        //                        MimeType = nodes[i].SelectSingleNode("ContentType").InnerText;
        //                        fileUploadFlag = false;
        //                    }

        //                }

        //            }
        //            if (MimeType == null)
        //            {
        //                MimeType = "unknown/unknowns";
        //                fileUploadFlag = false;
        //            }
        //            if (strListofTypes.IndexOf(MimeType) == -1)
        //            {
        //                fileUploadFlag = true;
        //            }
        //        }

        //    }
        //    else
        //    {
        //        fileUploadFlag = true;
        //    }

        //    return fileUploadFlag;
        //}

        //Commented & Added By Dipalii V On 8th July 2020 For Check FileType

        [DllImport("urlmon.dll", CharSet = CharSet.Unicode, ExactSpelling = true, SetLastError = false)]
        static extern int FindMimeFromData(IntPtr pBC, [MarshalAs(UnmanagedType.LPWStr)] string pwzUrl, [MarshalAs(UnmanagedType.LPArray, ArraySubType = UnmanagedType.I1, SizeParamIndex = 3)] byte[] pBuffer, int cbSize, [MarshalAs(UnmanagedType.LPWStr)] string pwzMimeProposed, int dwMimeFlags, out IntPtr ppwzMimeOut, int dwReserved);

        [System.Security.SecuritySafeCritical()]
        public static string getMimeFromFile(HttpPostedFile file)
        {
            IntPtr mimeout; int MaxContent = (int)file.ContentLength;
            if (MaxContent > 200)
                MaxContent = 200;
            byte[] buf = new byte[MaxContent];
            file.InputStream.Read(buf, 0, MaxContent);
            int result = FindMimeFromData(IntPtr.Zero, file.FileName, buf, MaxContent, null, 0, out mimeout, 0);
            if (result != 0)
            {
                Marshal.FreeCoTaskMem(mimeout); return "";
            }
            string mime = Marshal.PtrToStringUni(mimeout);
            Marshal.FreeCoTaskMem(mimeout); return mime.ToLower();
        }

        //End of Added By Dipali V On 31st Oct 2022 For Check File Content Type

        LessonLearnt lessonLearnt = new LessonLearnt();
        //get phase Document sub Category List
        [Authorize]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveLessonLearnt()
        {

            string msg = "";
            try
            {
                if (Convert.ToString(HttpContext.Current.Request.Files.Count) != "0")//Commented & Added By Dipali V On 13th July 2020 if file not select then other details should update
                {
                    if (GetFileType())
                    {
                        var AttachedFileData = HttpContext.Current.Request["AttachedFileData"];

                        //Added By Usha Pandit On 16.06.2020 For escaping quotes in string
                        AttachedFileData = AttachedFileData.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");
                        //End Of Added By Usha Pandit On 16.06.2020 For escaping quotes in string

                        var listAttachedDocuments = JsonConvert.DeserializeObject<List<LessonLearnt>>(AttachedFileData);
                        //Replace Added By Dipali V On 19th Nov 2019 For Page Crash
                        lessonLearnt.Description = listAttachedDocuments[0].Description; //.Replace("'", "''");
                        lessonLearnt.Solution = listAttachedDocuments[0].Solution; //.Replace("'", "''");
                        lessonLearnt.ProblemType = listAttachedDocuments[0].ProblemType;
                        lessonLearnt.PreventiveAction = listAttachedDocuments[0].PreventiveAction; //.Replace("'", "''");
                        lessonLearnt.PTKM = listAttachedDocuments[0].PTKM;
                        lessonLearnt.CreatedBy = listAttachedDocuments[0].CreatedBy;
                        lessonLearnt.ProjectId = listAttachedDocuments[0].ProjectId;
                        object LessonId = InsertOrUpdateLessonLearntOld(lessonLearnt);
                        int ProjectId = listAttachedDocuments[0].ProjectId;
                        string CreatedBy = listAttachedDocuments[0].CreatedBy;
                        string LoginType = listAttachedDocuments[0].LoginType;
                        int UserID = listAttachedDocuments[0].UserID;
                        string[] deletedFileCnt = listAttachedDocuments[0].deletedFileCnt;

                        for (int i = 0; i < HttpContext.Current.Request.Files.Count; i++)
                        {

                            int datacnt = i + 1;
                            if (deletedFileCnt.Contains(datacnt.ToString()) == true)
                            {
                                continue;
                            }
                            else
                            {
                                var httpPostedFile = HttpContext.Current.Request.Files[i];
                                //int LessonLearntId = (int)LessonId;
                                string DirectoryName;

                                DirectoryName = "LessonLearntDocument";


                                //var dateAttached = listAttachedDocuments[i].DateAttached;

                                var CreatedDate = DateTime.Now;
                                string strFileName = CommonFunctions.FileDirectory.GetUniqueFileName();
                                float FileSize = httpPostedFile.ContentLength;
                                FileSize = FileSize / 1024;
                                string FileExtention = Path.GetExtension(httpPostedFile.FileName);
                                FileExtention = FileExtention.Replace(".", "");
                                string OriginalFileName = Path.GetFileName(httpPostedFile.FileName);


                                var DirectoryPath = HttpContext.Current.Server.MapPath("~/" + "");
                                DirectoryPath = DirectoryPath.Replace("WhizibleAPIService", "Documents\\LessonLearntDocument");

                                string dir = DirectoryPath;
                                if (!Directory.Exists(dir))
                                {

                                    DirectoryInfo di = Directory.CreateDirectory(dir);

                                }


                                //var fileName = strFileName + System.IO.Path.GetExtension(httpPostedFile.FileName);
                                var fileName = httpPostedFile.FileName;
                                //var fileName = httpPostedFile.FileName + System.IO.Path.GetExtension(httpPostedFile.FileName);
                                var filePath = HttpContext.Current.Server.MapPath("~/" + fileName);
                                var attachmentId = 0;
                                filePath = filePath.Replace("WhizibleAPIService", "Documents\\" + DirectoryName);
                                httpPostedFile.SaveAs(filePath);
                                string strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ProjectDocuments_ProjectClosure " + HttpUtility.UrlDecode(LessonId.ToString()) + "," + HttpUtility.UrlDecode(ProjectId.ToString()) + ",'" + HttpUtility.UrlDecode(DirectoryName) + "','" + HttpUtility.UrlDecode(fileName) + "','" + HttpUtility.UrlDecode(CreatedDate.ToString()) + "','" + HttpUtility.UrlDecode(CreatedDate.ToString()) + "'," + HttpUtility.UrlDecode(FileSize.ToString()) + ",'" + HttpUtility.UrlDecode(FileExtention) + "','" + HttpUtility.UrlDecode(OriginalFileName) + "'," + HttpUtility.UrlDecode(UserID.ToString()) + ",'" + HttpUtility.UrlDecode(LoginType) + "','" + HttpUtility.UrlDecode(CreatedBy) + "',39";
                                object result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                                msg = "Learn Lesson save successfully";
                            }
                        }
                    }
                    else
                    {
                        // msg = "Please upload valid files only";
                        //msg = "Only files with extensions PDF, XLS, XLSX, ZIP, RAR, XML, LOG, PNG, JPEG, JPG, DOC, DOCX, TXT, EXE are  allowed!!!";
                        msg = "Please upload valid file.";
                    }
                }
                else
                {
                    //Commented & Added By Dipali V On 13th July 2020 if file not select then other details should update
                    var AttachedFileData = HttpContext.Current.Request["AttachedFileData"];

                    //Added By Usha Pandit On 16.06.2020 For escaping quotes in string
                    AttachedFileData = AttachedFileData.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");
                    //End Of Added By Usha Pandit On 16.06.2020 For escaping quotes in string

                    var listAttachedDocuments = JsonConvert.DeserializeObject<List<LessonLearnt>>(AttachedFileData);
                    //Replace Added By Dipali V On 19th Nov 2019 For Page Crash
                    lessonLearnt.Description = listAttachedDocuments[0].Description; //.Replace("'", "''");
                    lessonLearnt.Solution = listAttachedDocuments[0].Solution; //.Replace("'", "''");
                    lessonLearnt.ProblemType = listAttachedDocuments[0].ProblemType;
                    lessonLearnt.PreventiveAction = listAttachedDocuments[0].PreventiveAction; //.Replace("'", "''");
                    lessonLearnt.PTKM = listAttachedDocuments[0].PTKM;
                    lessonLearnt.CreatedBy = listAttachedDocuments[0].CreatedBy;
                    lessonLearnt.ProjectId = listAttachedDocuments[0].ProjectId;
                    object LessonId = InsertOrUpdateLessonLearntOld(lessonLearnt);
                    int ProjectId = listAttachedDocuments[0].ProjectId;
                    string CreatedBy = listAttachedDocuments[0].CreatedBy;
                    string LoginType = listAttachedDocuments[0].LoginType;
                    int UserID = listAttachedDocuments[0].UserID;
                    string[] deletedFileCnt = listAttachedDocuments[0].deletedFileCnt;

                    for (int i = 0; i < HttpContext.Current.Request.Files.Count; i++)
                    {

                        int datacnt = i + 1;
                        if (deletedFileCnt.Contains(datacnt.ToString()) == true)
                        {
                            continue;
                        }
                        else
                        {
                            var httpPostedFile = HttpContext.Current.Request.Files[i];
                            //int LessonLearntId = (int)LessonId;
                            string DirectoryName;

                            DirectoryName = "LessonLearntDocument";


                            //var dateAttached = listAttachedDocuments[i].DateAttached;

                            var CreatedDate = DateTime.Now;
                            string strFileName = CommonFunctions.FileDirectory.GetUniqueFileName();
                            float FileSize = httpPostedFile.ContentLength;
                            FileSize = FileSize / 1024;
                            string FileExtention = Path.GetExtension(httpPostedFile.FileName);
                            FileExtention = FileExtention.Replace(".", "");
                            string OriginalFileName = Path.GetFileName(httpPostedFile.FileName);








                            var DirectoryPath = HttpContext.Current.Server.MapPath("~/" + "");
                            DirectoryPath = DirectoryPath.Replace("WhizibleAPIService", "Documents\\LessonLearntDocument");

                            string dir = DirectoryPath;
                            if (!Directory.Exists(dir))
                            {

                                DirectoryInfo di = Directory.CreateDirectory(dir);
                                //  Directory.CreateDirectory(Path.GetDirectoryName(DirectoryPath + "\\" + categoryName ));

                            }


                            //var fileName = strFileName + System.IO.Path.GetExtension(httpPostedFile.FileName);
                            var fileName = httpPostedFile.FileName;
                            //var fileName = httpPostedFile.FileName + System.IO.Path.GetExtension(httpPostedFile.FileName);
                            var filePath = HttpContext.Current.Server.MapPath("~/" + fileName);
                            var attachmentId = 0;
                            filePath = filePath.Replace("WhizibleAPIService", "Documents\\" + DirectoryName);
                            httpPostedFile.SaveAs(filePath);
                            string strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ProjectDocuments_ProjectClosure " + HttpUtility.UrlDecode(LessonId.ToString()) + "," + HttpUtility.UrlDecode(ProjectId.ToString()) + ",'" + HttpUtility.UrlDecode(DirectoryName) + "','" + HttpUtility.UrlDecode(fileName) + "','" + HttpUtility.UrlDecode(CreatedDate.ToString()) + "','" + HttpUtility.UrlDecode(CreatedDate.ToString()) + "'," + HttpUtility.UrlDecode(FileSize.ToString()) + ",'" + HttpUtility.UrlDecode(FileExtention) + "','" + HttpUtility.UrlDecode(OriginalFileName) + "'," + HttpUtility.UrlDecode(UserID.ToString()) + ",'" + HttpUtility.UrlDecode(LoginType) + "','" + HttpUtility.UrlDecode(CreatedBy) + "',39";
                            object result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                            msg = "Learn Lesson save successfully";


                        }

                    }
                }
                //Commented & Added By Dipali V On 13th July 2020 if file not select then other details should update
                return msg;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //save Project Lessons Learned Details
        //Commented And Added By Usha Pandit On 26.03.2020 For adding attachment during update
        //[HttpPost]
        //[Authorize]
        //public object InsertOrUpdateLessonLearnt([FromBody]LessonLearnt lesson)
        //{
        //    string strSQL;
        //    HttpRequestMessage request = new HttpRequestMessage();
        //    try
        //    {
        //        strSQL = "";
        //        if (lesson.LessonId == 0)
        //        {
        //            //Replace Added By Dipali V On 19th Nov 2019 For Page Crash
        //            strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ProjectLessonsLearned " + HttpUtility.UrlDecode(lesson.ProjectId.ToString()) + ",'" + HttpUtility.UrlDecode(lesson.Description.Replace("'", "''")) + "'," + "'" + HttpUtility.UrlDecode(lesson.Solution.Replace("'", "''")) + "','" + HttpUtility.UrlDecode(lesson.PreventiveAction.Replace("'", "''")) + "'," + HttpUtility.UrlDecode(Convert.ToString(lesson.PTKM)) + ",'" + HttpUtility.UrlDecode(lesson.ProblemType) + "','" + HttpUtility.UrlDecode(lesson.CreatedBy) + "'," + HttpUtility.UrlDecode(lesson.LessonId.ToString());
        //        }
        //        else
        //        {
        //            //Replace Added By Dipali V On 19th Nov 2019 For Page Crash
        //            strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ProjectLessonsLearned " + HttpUtility.UrlDecode(lesson.ProjectId.ToString()) + ",'" + HttpUtility.UrlDecode(lesson.Description.Replace("'", "''")) + "'," + "'" + HttpUtility.UrlDecode(lesson.Solution.Replace("'", "''")) + "','" + HttpUtility.UrlDecode(lesson.PreventiveAction.Replace("'", "''")) + "'," + HttpUtility.UrlDecode(Convert.ToString(lesson.PTKM)) + ",'" + HttpUtility.UrlDecode(lesson.ProblemType) + "','" + HttpUtility.UrlDecode(lesson.CreatedBy) + "'," + HttpUtility.UrlDecode(lesson.LessonId.ToString());
        //        }
        //        //Get Project Lessons Learned Details
        //        object Id = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
        //        //DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


        //        var configuration = new HttpConfiguration();
        //        request.SetConfiguration(configuration);
        //        return Id;
        //    }
        //    catch (Exception e)
        //    {

        //        return request.CreateResponse(HttpStatusCode.BadRequest, e.Message);
        //    }

        //}

        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object InsertOrUpdateLessonLearntOld([FromBody] LessonLearnt lesson)
        {

            try
            {
                string strSQL;
                HttpRequestMessage request = new HttpRequestMessage();
                strSQL = "";
                if (lesson.LessonId == 0)
                {
                    //Replace Added By Dipali V On 19th Nov 2019 For Page Crash
                    strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ProjectLessonsLearned " + HttpUtility.UrlDecode(lesson.ProjectId.ToString()) + ",'" + HttpUtility.UrlDecode(lesson.Description.Replace("'", "''")) + "'," + "'" + HttpUtility.UrlDecode(lesson.Solution.Replace("'", "''")) + "','" + HttpUtility.UrlDecode(lesson.PreventiveAction.Replace("'", "''")) + "'," + HttpUtility.UrlDecode(Convert.ToString(lesson.PTKM)) + ",'" + HttpUtility.UrlDecode(lesson.ProblemType) + "','" + HttpUtility.UrlDecode(lesson.CreatedBy) + "'," + HttpUtility.UrlDecode(lesson.LessonId.ToString());
                }
                else
                {
                    //Replace Added By Dipali V On 19th Nov 2019 For Page Crash
                    strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ProjectLessonsLearned " + HttpUtility.UrlDecode(lesson.ProjectId.ToString()) + ",'" + HttpUtility.UrlDecode(lesson.Description.Replace("'", "''")) + "'," + "'" + HttpUtility.UrlDecode(lesson.Solution.Replace("'", "''")) + "','" + HttpUtility.UrlDecode(lesson.PreventiveAction.Replace("'", "''")) + "'," + HttpUtility.UrlDecode(Convert.ToString(lesson.PTKM)) + ",'" + HttpUtility.UrlDecode(lesson.ProblemType) + "','" + HttpUtility.UrlDecode(lesson.CreatedBy) + "'," + HttpUtility.UrlDecode(lesson.LessonId.ToString());
                }
                //Get Project Lessons Learned Details
                object Id = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                //DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return Id;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        [HttpPost]
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object InsertOrUpdateLessonLearnt()
        {
            try
            {
                string msg = "";
                //Commented by Chetan M on 23rd Jully 2020 for IssueID = 23504
                //if (GetFileType())
                //{
                //End of Commented Chetan M on 23rd Jully 2020 for IssueID = 24504

                var AttachedFileData = HttpContext.Current.Request["AttachedFileData"];

                //Added By Usha Pandit On 16.06.2020 For escaping quotes in string
                AttachedFileData = AttachedFileData.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");
                //End Of Added By Usha Pandit On 16.06.2020 For escaping quotes in string

                var listAttachedDocuments = JsonConvert.DeserializeObject<List<LessonLearnt>>(AttachedFileData);
                lessonLearnt.Description = listAttachedDocuments[0].Description; //.Replace("'", "''");
                lessonLearnt.Solution = listAttachedDocuments[0].Solution; //.Replace("'", "''");
                lessonLearnt.ProblemType = listAttachedDocuments[0].ProblemType;
                lessonLearnt.PreventiveAction = listAttachedDocuments[0].PreventiveAction; //.Replace("'", "''");
                lessonLearnt.PTKM = listAttachedDocuments[0].PTKM;
                lessonLearnt.CreatedBy = listAttachedDocuments[0].CreatedBy;
                lessonLearnt.ProjectId = listAttachedDocuments[0].ProjectId;
                lessonLearnt.LessonId = listAttachedDocuments[0].LessonId;
                object LessonId = InsertOrUpdateLessonLearntOld(lessonLearnt);
                int ProjectId = listAttachedDocuments[0].ProjectId;
                string CreatedBy = listAttachedDocuments[0].CreatedBy;
                string LoginType = listAttachedDocuments[0].LoginType;
                int UserID = listAttachedDocuments[0].UserID;
                string[] deletedFileCnt = listAttachedDocuments[0].deletedFileCnt;

                for (int i = 0; i < HttpContext.Current.Request.Files.Count; i++)
                {

                    int datacnt = i + 1;
                    if (deletedFileCnt.Contains(datacnt.ToString()) == true)
                    {
                        continue;
                    }
                    else
                    {
                        var httpPostedFile = HttpContext.Current.Request.Files[i];

                        string DirectoryName;

                        DirectoryName = "LessonLearntDocument";

                        var CreatedDate = DateTime.Now;
                        string strFileName = CommonFunctions.FileDirectory.GetUniqueFileName();
                        float FileSize = httpPostedFile.ContentLength;
                        FileSize = FileSize / 1024;
                        string FileExtention = Path.GetExtension(httpPostedFile.FileName);
                        FileExtention = FileExtention.Replace(".", "");
                        string OriginalFileName = Path.GetFileName(httpPostedFile.FileName);

                        var DirectoryPath = HttpContext.Current.Server.MapPath("~/" + "");
                        DirectoryPath = DirectoryPath.Replace("WhizibleAPIService", "Documents\\LessonLearntDocument");

                        string dir = DirectoryPath;
                        if (!Directory.Exists(dir))
                        {

                            DirectoryInfo di = Directory.CreateDirectory(dir);

                        }

                        //var fileName = strFileName + System.IO.Path.GetExtension(httpPostedFile.FileName);
                        var fileName = httpPostedFile.FileName;
                        var filePath = HttpContext.Current.Server.MapPath("~/" + fileName);
                        var attachmentId = 0;
                        filePath = filePath.Replace("WhizibleAPIService", "Documents\\" + DirectoryName);
                        httpPostedFile.SaveAs(filePath);
                        //added by Chetan M on 23rd Jully 2020 for IssueID = 24504
                        if (GetFileType())
                        {
                            //End of added by Chetan M on 23rd Jully 2020 for IssueID = 24504
                            string strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ProjectDocuments_ProjectClosure " + HttpUtility.UrlDecode(lessonLearnt.LessonId.ToString()) + "," + HttpUtility.UrlDecode(ProjectId.ToString()) + ",'" + HttpUtility.UrlDecode(DirectoryName) + "','" + HttpUtility.UrlDecode(fileName) + "','" + HttpUtility.UrlDecode(CreatedDate.ToString()) + "','" + HttpUtility.UrlDecode(CreatedDate.ToString()) + "'," + HttpUtility.UrlDecode(FileSize.ToString()) + ",'" + HttpUtility.UrlDecode(FileExtention) + "','" + HttpUtility.UrlDecode(OriginalFileName) + "'," + HttpUtility.UrlDecode(UserID.ToString()) + ",'" + HttpUtility.UrlDecode(LoginType) + "','" + HttpUtility.UrlDecode(CreatedBy) + "',39";
                            object result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                            msg = "Learn Lesson save successfully";
                            //added by Chetan M on 23rd Jully 2020 for IssueID = 24504 
                        }
                        else
                        {
                            msg = "Only files with extensions PDF, XLS, XLSX, ZIP, RAR, XML, LOG, PNG, JPEG, JPG, DOC, DOCX, TXT, EXE are  allowed!!!";
                        }
                        //End of added by Chetan M on 23rd Jully 2020 for IssueID = 24504
                    }
                }
                //End of Commented by Chetan M on 23rd Jully 2020 for IssueID = 24504
                //}
                //else
                //{
                //    // msg = "Please upload valid files only";
                //    msg = "Only files with extensions PDF, XLS, XLSX, ZIP, RAR, XML, LOG, PNG, JPEG, JPG, DOC, DOCX, TXT, EXE are  allowed!!!";
                //}
                //End of Commented and added by Chetan M on 23rd Jully 2020 for IssueID = 24504

                return msg;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End Of Added By Usha Pandit On 26.03.2020 For adding attachment during update

        //Delete Project Lessons Learned Details
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage ProjectLessonsLearnedDelete([FromBody] int LessonId)
        {

            try
            {
                string strSQL;
                HttpRequestMessage request = new HttpRequestMessage();

                strSQL = "";
                strSQL = "Exec usp_Whizible2_Del_tbl_PM_ProjectLessonsLearned " + HttpUtility.UrlDecode(LessonId.ToString());
                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, Result);
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        public object GetToken([FromBody] TokenParameter Parameters)
        {
            try
            {
                string pkToken = "";
                pkToken = CommonFunctions.Security.Token.GetToken(Parameters.TagID.ToString() + Parameters.DocumnetID.ToString() + Parameters.LessonID.ToString() + Parameters.ProjectID.ToString());
                return pkToken;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteLessonLearntDocument([FromBody] LessonLearnt LessonParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_del_tbl_PM_ProjectDocuments_ProjectClosure " + HttpUtility.UrlDecode(Convert.ToString(LessonParameter.LessonId)) + "," + HttpUtility.UrlDecode(Convert.ToString(LessonParameter.DocumentID)) + "," + HttpUtility.UrlDecode(Convert.ToString(LessonParameter.ProjectID));
                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return Result;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //************************************************************************************
        //Chetan Muley code starts from here

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetProjectTeamData([FromBody] int ProjectID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec USP_Whizible2_RPT_CR_PROJECTTEAM " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));
                DataTable GetProjectTeamDatadt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return GetProjectTeamDatadt;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetHardwareUsed([FromBody] int ProjectID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_rpt_CR_HardwareUsed " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetToolsUsed([FromBody] int ProjectID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_rpt_CR_Tools " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        public object GetLessonsLearned([FromBody] int ProjectID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_rpt_CR_LessonsLearned " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetEffortDistribution([FromBody] int ProjectID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_rpt_CR_EffortDistriBution " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));
                DataTable EffortDistriButiondt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return EffortDistriButiondt;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetPublishedCheckList([FromBody] int ProjectID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_sel_tbl_PM_WorkOrderChecklist_Published " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));
                DataTable CheckListDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return CheckListDataTable;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetCheckListData([FromBody] CheckListClass ClosureParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_sel_tbl_PM_GetProjectChecklistItems " + HttpUtility.UrlDecode(Convert.ToString(ClosureParameter.ProjectCheckListId)) + "," + HttpUtility.UrlDecode(Convert.ToString(ClosureParameter.ContextID)) + ",'R','" + HttpUtility.UrlDecode(ClosureParameter.RespondedBy) + "'";
                DataTable CheckListDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                CheckListDataTable = Dedup(CheckListDataTable, "CheckListItemName");
                //CheckListDataTable= Dedup(CheckListDataTable, "ProjectCheckListItemId");
                CheckListDataTable = Dedup(CheckListDataTable, "Description");

                return CheckListDataTable;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        public DataTable Dedup(DataTable CheckListDataTable, string CheckListItemName)
        {
            for (int rowIndex = CheckListDataTable.Rows.Count - 1; rowIndex >= 1; rowIndex--)
            {
                var row = CheckListDataTable.Rows[rowIndex][CheckListItemName];
                var previousRow = CheckListDataTable.Rows[rowIndex - 1][CheckListItemName];

                if (row.ToString() == previousRow.ToString())
                {
                    CheckListDataTable.Rows[rowIndex][CheckListItemName] = "";
                }
            }

            return CheckListDataTable;
        }


        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object DeleteCheckListeResponses([FromBody] CheckListClass ClosureParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_del_tbl_Whizible2_PM_ProjectClosure_ChecklistResponses " + HttpUtility.UrlDecode(Convert.ToString(ClosureParameter.ContextID)) + ",'R','" + HttpUtility.UrlDecode(ClosureParameter.RespondedBy) + "'";
                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return Result;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveCheckListResponse([FromBody] CheckListClass ClosureParameter)
        {
            try
            {
                string strSQL = "";

                //Commented And Added By Usha Pandit On 16.06.2020 For escaping quotes in string
                //strSQL = "Exec usp_Ins_Upd_tbl_Whizible2_PM_ProjectClosure_ChecklistResponses " + HttpUtility.UrlDecode(Convert.ToString(ClosureParameter.ContextID)) + ",'R'," + HttpUtility.UrlDecode(Convert.ToString(ClosureParameter.ProjectCheckListId)) + "," + HttpUtility.UrlDecode(Convert.ToString(ClosureParameter.ResponseID)) + ",null,null,'" + HttpUtility.UrlDecode(ClosureParameter.RespondedBy) + "','" + HttpUtility.UrlDecode(ClosureParameter.Remarks) + "',0";
                strSQL = "Exec usp_Ins_Upd_tbl_Whizible2_PM_ProjectClosure_ChecklistResponses " + HttpUtility.UrlDecode(Convert.ToString(ClosureParameter.ContextID)) + ",'R'," + HttpUtility.UrlDecode(Convert.ToString(ClosureParameter.ProjectCheckListId)) + "," + HttpUtility.UrlDecode(Convert.ToString(ClosureParameter.ResponseID)) + ",null,null,'" + HttpUtility.UrlDecode(ClosureParameter.RespondedBy) + "','" + HttpUtility.UrlDecode(ClosureParameter.Remarks).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "',0";
                //End Of Added By Usha Pandit On 16.06.2020 For escaping quotes in string

                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return Result;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetLoggedPersonInfo([FromBody] int EmployeeID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_tbl_Sel_EmployeeInfo " + HttpUtility.UrlDecode(Convert.ToString(EmployeeID));
                DataTable EmployeeDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return EmployeeDataTable;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public HttpResponseMessage GetTaskDataOfPRoject([FromBody] int ProjectID)
        {
            try
            {
                HttpRequestMessage request = new HttpRequestMessage();
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_TasksForCompletion_ProjectClosure " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));
                projectData.TasksForCompletion = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_TasksForVoiding_ProjectClosure " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));
                projectData.TasksForVoiding = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_TasksForMPPing_ProjectClosure " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));
                projectData.TasksForMPPing = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, projectData);
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }




        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object CheckSkillHasOrNOt([FromBody] PostSkillExperiance ClosureParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "usp_Check_ProjectResoucesSkillUpdatedORNot " + HttpUtility.UrlDecode(Convert.ToString(ClosureParameter.ProjectID));
                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return Result;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object CloseProject([FromBody] CheckListClass ClosureParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Upd_tbl_ProjectClosure " + HttpUtility.UrlDecode(Convert.ToString(ClosureParameter.ProjectID)) + ",NULL,NULL,NULL,NULL,NULL,NULL,'" + HttpUtility.UrlDecode(ClosureParameter.LoggedaPersonEmailID) + "',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL";
                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                if (Result == null)
                {
                    strSQL = "usp_Whizible2_upd_ActualEndDate_tbl_PM_Project " + HttpUtility.UrlDecode(Convert.ToString(ClosureParameter.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ClosureParameter.ActualEndate)) + "'";
                    object Result1 = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                }
                if (Result == null)
                {
                    strSQL = "usp_Whizible2_Upd_tbl_PM_ProjectClosureComments " + HttpUtility.UrlDecode(Convert.ToString(ClosureParameter.ProjectID)) + "," + HttpUtility.UrlDecode(ClosureParameter.LoggedPersonID);
                    object Result1 = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                }


                //if (Result == null)
                //{
                //    strSQL = "usp_Check_ProjectResoucesSkillUpdatedORNot " + HttpUtility.UrlDecode(Convert.ToString(ClosureParameter.ProjectID)) + "," + HttpUtility.UrlDecode(ClosureParameter.LoggedPersonID);
                //    object Result1 = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                //}


                return Result;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ReopenProject([FromBody] ReOpenProjectParameter reOpenProject)
        {
            try
            {
                string strSQL = "";
                strSQL = "usp_Whizible2_Upd_ReopenProject " + HttpUtility.UrlDecode(Convert.ToString(reOpenProject.ProjectId)) + ",'" + reOpenProject.Comment.Replace("'", "''") + "'," + reOpenProject.UserId;
                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return Result;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        public object ExportToReport([FromBody] PM_ClosureReportParameter Parameters)
        {
            try
            {
                string strSQL = "";
                string strFilePath;
                string m_strFileName = "";
                long m_lngRiskReportID = 992;
                int lngDefaultLCID;
                int lngCurrentThreadUICultureID;
                string ProjectId = HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectId));
                lngDefaultLCID = 1033;
                lngCurrentThreadUICultureID = 1033;
                string CompanyName = "";
                int DateFormatID = 0;
                AdHocReports.Report.AdHocReport oRpt;
                IDataReader drReport;

                strSQL = "usp_rpt_CR_MainReport " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectId));

                drReport = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (drReport.Read())
                {
                    CommonEngines.HashTables.Culture.ConnectionString = CommonController.connectionString;
                    CommonEngines.HashTables.Culture.FillCultureHashTable();
                    strFilePath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../Reports/"));
                    m_strFileName = CommonFunctions.FileDirectory.GetUniqueFileName().Trim();
                    switch (Parameters.ReportFormat)
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

                    oRpt = new AdHocReports.Report.AdHocReport(m_lngRiskReportID, strSQL, CommonController.connectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../ATTACHMENTS/Log/")));

                    oRpt.UseMSSQL = true;
                    oRpt.DefaultLCID = lngDefaultLCID;
                    oRpt.LCID = lngCurrentThreadUICultureID;

                    oRpt.UseHashTables = true;

                    oRpt.DateFormat = DateFormatID;
                    oRpt.CompanyName = CompanyName;
                    oRpt.GraphImageGenerationAbsolutePath = HttpContext.Current.Server.MapPath("../../../Images/");
                    AdHocReports.HashTables.CreateHashTables.ConnectionString = CommonController.connectionString;

                    switch (Parameters.ReportFormat)
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
                else
                    return "0";
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Chetan Muley code ends here
        //****************************************************************************************

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetReusableItems([FromBody] int ProjectID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_rpt_CR_ReusableItems " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
    }


}