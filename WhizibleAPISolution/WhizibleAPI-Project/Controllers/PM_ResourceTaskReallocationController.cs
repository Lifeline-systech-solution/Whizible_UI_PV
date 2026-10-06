using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
//using WhizibleAPI.Extensions;
using WhizibleAPI.Models.PM;
using System.IO;
using Newtonsoft.Json;
//using WhizibleAPI.Models.RM;

namespace WhizibleAPI.Controllers
{
    public class PM_ResourceTaskReallocationController : ApiController
    {
        /*
         Created By : Vishal Mane
         Created Date : 29/09/2023
         Purpose : To get list of active resources with total count of Assigned or void tasks against each resource
         */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetActiveResourceList([FromBody] PM_ResourceTaskReallocation RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ProjectTasks_ResourcesList " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.OpenOrVoidFlag)) + "'";


                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /*
        Created By : Vishal Mane
        Created Date : 29/09/2023
        Purpose : To get list of active resources with total count of Assigned or void tasks against each resource
        */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetSelectedResourceTasksList([FromBody] PM_ResourceTaskReallocation RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ProjectTasks_OpenOrVoidTaskList " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ResourceID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.OpenOrVoidFlag));

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /*
         Created By : Vishal Mane
         Created Date : 05/10/2023
         Purpose : To show selected task list to selected resource
         */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetSelectedTaskList([FromBody] PM_ResourceTaskReallocation RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ProjectTasks_SelectedTaskList " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.OpenOrVoidFlag)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.TaskIDs)) + "'," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ResourceID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /*
        Created By : Vishal Mane
        Created Date : 18/10/2023
        Purpose : To get Resource List and Task List as per selected Project 
        */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetResourcesList([FromBody] PM_ResourceTaskReallocation RequestParameters)
        {

            List<RM_ResourceList> ActiveResourcesList = new List<RM_ResourceList>();
            try
            {

                var strSQL = "usp_Whizible2_Sel_tbl_PM_ProjectEmployeeRole_ActiveResourcesOnProject " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));

                DataTable ActiveResourceTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                //if (ActiveResourceTable != null)
                //{
                //    ActiveResourcesList = ActiveResourceTable.ToList<RM_ResourceList>();
                //}

                return ActiveResourceTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        /*
        Created By :  Vishal Mane
        Created Date : 10/10/2023
        Purpose : To bind selected resource with total count of Assigned or void tasks against each resource
        */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object BindSelectedResource([FromBody] PM_ResourceTaskReallocation RequestParameters)
        {
            List<RM_ResourceList> ActiveResourcesList = new List<RM_ResourceList>();
            try
            {
                var strSQL = "usp_Whizible2_Sel_tbl_PM_ProjectTasks_BindResource " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ResourceID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.OpenOrVoidFlag));
                DataTable ActiveResourceTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);                
                return ActiveResourceTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        /*
         Created By : Vishal Mane
         Created Date : 05/10/2023
         Purpose : To bind resources to dropdown except current employee dynamically
         */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object BindResourcesExceptCurrentEmployee([FromBody] PM_ResourceTaskReallocation RequestParameters)
        {
            List<RM_ResourceList> ActiveResourcesList = new List<RM_ResourceList>();
            try
            {
                var strSQL = "usp_Whizible2_Sel_tbl_PM_ProjectEmployeeRole_ExceptCurrentEmployee " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ResourceID));
                DataTable ActiveResourceTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);                
                return ActiveResourceTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        /*
        Created By : Vishal Mane
        Created Date : 21/10/2023
        Purpose : To assign single task to selected resource
        */
        [HttpPost]
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object AssignSelectedTasks([FromBody] PM_ResourceTaskReallocation RequestParameters)
        {
            string strtResult = string.Empty;

            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ProjectTasks_AssignSelectedTask " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.intFromEmployeeID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.intToEmployeeID)) + "'," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.TaskIDs)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.WorkHour)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.StartDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.EndDate)) + "'";
                strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return Request.CreateResponse(HttpStatusCode.OK, strtResult);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /*
         Created By : Vishal Mane
         Created Date : 05/10/2023
         Purpose : To assign selected task to selected resource
         */
        [HttpPost]
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object AssignAllSelectedTasks([FromBody] PM_ResourceTaskReallocation RequestParameters)
        {
            string strtResult = string.Empty;
            TaskIDsDetails[] taskDetails = RequestParameters.TaskIDsDetails;
            var param = JsonConvert.SerializeObject(RequestParameters.TaskIDsDetails);
            List<TaskIDsDetails> taskDetailsList = JsonConvert.DeserializeObject<List<TaskIDsDetails>>(param);
            try
            {
                foreach (TaskIDsDetails taskDetail in taskDetailsList)
                {
                    var taskID = taskDetail.taskID;
                    var StartDate = taskDetail.startDate;
                    var EndDate = taskDetail.endDate;
                    var WorkHour = taskDetail.workHour;
                    string strSQL;
                    strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ProjectTasks_AssignSelectedTask " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.intFromEmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.intToEmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(taskID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WorkHour)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(StartDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(EndDate)) + "'";
                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            strtResult = "1";
            return Request.CreateResponse(HttpStatusCode.OK, strtResult);
        }

        /*
        Created By : Vishal Mane
        Created Date : 18/10/2023
        Purpose : To get project details for validation purpose
        */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetProjectDetailsForValidation([FromBody] PM_ResourceTaskReallocation RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ProjectDetailsForValidation " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /*
        Created By : Vishal Mane
        Created Date : 18/10/2023
        Purpose : To get Resource Details for validation purpose
        */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetResourceDetailsForValidation([FromBody] PM_ResourceTaskReallocation RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ResourceDetailsForValidation " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.intToEmployeeID));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /*
        Created By : Vishal Mane
        Created Date : 18/10/2023
        Purpose : To get Project LocationID for validation purpose
        */

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetProjectLocationID([FromBody] PM_ResourceTaskReallocation RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_sel_tbl_PM_Project_TaskCaseStructure " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /*
        Created By : Vishal Mane
        Created Date : 18/10/2023
        Purpose : To get Project Holidays List for validation purpose
        */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetProjectHolidaysList([FromBody] PM_ResourceTaskReallocation RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Sel_tbl_PM_Location_Holiday " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectLocationID));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /*
        Created By : Vishal Mane
        Created Date : 18/10/2023
        Purpose : To get Employee Leave Validation Msg for validation purpose
        */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetEmployeeLeaveValidationMsg([FromBody] PM_ResourceTaskReallocation RequestParameters)
        {
            try
            {
                string strResult = "";
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_EmployeeLeaveValidationMsg " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.intToEmployeeID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.StartDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.EndDate)) + "'";
                strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return Request.CreateResponse(HttpStatusCode.OK, strResult);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /*
        Created By : Vishal Mane
        Created Date : 18/10/2023
        Purpose : To get Get Sprint Start Date End Date for validation purpose
        */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetSprintStDateEdDate([FromBody] PM_ResourceTaskReallocation RequestParameters)
        {
            try
            {
                string strResult = "";
                string strSQL;               
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ProjectTasksForSprintDateValidation " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.intToEmployeeID));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        /*
        Created By : Vishal Mane
        Created Date : 23/10/2023
        Purpose : To get Resource Profile pic of selected tasks resource
        */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetEmployeeDetails([FromBody] PM_ResourceTaskReallocation RequestParameters)
        {
            try
            {
                string strResult = "";
                string strSQL;
                strSQL = "Exec usp_Whizible2_tbl_RM_GetEmployeeDetails " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.intFromEmployeeID));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /*
        Created By : Vishal Mane
        Created Date : 23/10/2023
        Purpose : To get Resource Profile pic of selected tasks resource
        */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetCompanyInfo()
        {
            try
            {
                string strResult = "";
                string strSQL;
                strSQL = "Exec usp_sel_tbl_PM_CompanyInformation";
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetOUHoursDetails([FromBody] PM_ResourceTaskReallocation RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Get_ProjectLocationWorkingHours_Days " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


    }
}
