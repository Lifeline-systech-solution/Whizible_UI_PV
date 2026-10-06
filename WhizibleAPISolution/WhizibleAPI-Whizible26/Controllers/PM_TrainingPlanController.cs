using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Runtime.InteropServices.ComTypes;
using System.Web.Http;
using WhizibleAPI.Models.PM;

using CommonFunctions;
using Newtonsoft.Json;
using System.Configuration;
using System.IO;
using System.Runtime.InteropServices;
using System.Web;
using System.Xml;
using static CommonFunctions.Data;
using Newtonsoft.Json.Linq;

namespace WhizibleAPI.Controllers
{
    public class PM_TrainingPlanController : ApiController
    {

        //Added By Vyankat B on 18/04/2025 for API to fetch all Skills
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetAllSkills()

        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_AllSkills";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 18/04/2025 for API to fetch all Skills

        //Added By Vyankat B on 18/04/2025 for API to fetch Training Skills for the Default Project
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTrainingeedsForProject([FromBody] PM_TrainingPlan trainingPlan)

        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_TrainingNeeds " + trainingPlan.ProjectID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 18/04/2025 for API to fetch Training Skills for the Default Project

        // Added By Vyankat B on 18/04/2025 for API to fetch Training Skills for the Default Project
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object AddTrainingSkillForProject([FromBody] PM_TrainingPlan trainingPlan)

        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Ins_TrainingNeeds " +
                 "@ProjectId = " + trainingPlan.ProjectID + ", " +
                 "@ToolID = " + trainingPlan.ToolID  + ", " +
                 "@TrainingDuration = " + trainingPlan.TrainingDuration + ", " +
                 "@DayFormat = " + trainingPlan.DayFormat  + ", " +
                 "@TrainingArea = '" + trainingPlan.TrainingArea +"', " +
                 "@WaiverCriteria = '" + trainingPlan.WaiverCriteria +"', " +
                 "@CreatedBy = '" + trainingPlan.CreatedBy + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        // End of Added By Vyankat B on 18/04/2025 for API to fetch Training Skills for the Default Project

        // Added By Vyankat B on 18/04/2025 for API to fetch Training Skills Detail for the selected SkillID
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetDetailsOfTrainingByID([FromBody] PM_TrainingPlan trainingPlan)

        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_GetTrainingNeedsDetailsByToolId " + trainingPlan.ToolID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 18/04/2025 for API to fetch Training Skills Detail for the selected SkillID

        //Added By Vyankat B on 18/04/2025 for API to fetch  history of the training skill
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetHistoryOfTheTrainingSkill([FromBody] PM_TrainingPlan trainingPlan)

        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_TrainingSkillHistory " + trainingPlan.TagID +", "+ trainingPlan.IsSubTagID +", "+ trainingPlan.ProjectID +", "+ trainingPlan.UniqueID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 18/04/2025 for API to fetch  history of the training skill

        //Added By Vyankat B on 18/04/2025 for API to fetch  ModifiedFields For Dropdown
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetModifiedFields([FromBody] PM_TrainingPlan trainingPlan)

        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_DistinctFieldNames " + trainingPlan.TagID + ", " + trainingPlan.IsSubTagID + ", " + trainingPlan.ProjectID + ", " + trainingPlan.UniqueID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 18/04/2025 for API to fetch  ModifiedFields For Dropdown


        //Added By Vyankat B on 18/04/2025 for API to fetch Modified By For dropdown
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetModifiedBy([FromBody] PM_TrainingPlan trainingPlan)

        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_DistinctModifiedBy " + trainingPlan.TagID + ", " + trainingPlan.IsSubTagID + ", " + trainingPlan.ProjectID + ", " + trainingPlan.UniqueID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 18/04/2025 for API to fetch Modified By For dropdown


        //Added By Vyankat B on 18/04/2025 for API to delete the selected Training plan 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object DeleteSelectedTrainingPlan([FromBody] PM_TrainingPlan trainingPlan)

        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Del_TrainingPlan " + trainingPlan.UniqueID + ", " + trainingPlan.ProjectID + ", " + trainingPlan.Result;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 18/04/2025 for API to delete the selected Training plan .

        //Added By Vyankat B on 18/04/2025 for API to FetchResources For Training Plan 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetRsouresForTrainingPlan([FromBody] PM_TrainingPlan trainingPlan)

        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_TrainingResourcesByID " + trainingPlan.UniqueID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 18/04/2025 for API to FetchResources For Training Plan 

        //Added By Vyankat B on 18/04/2025 for API to update the selected Training plan
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object UpdateTrainingNeeds([FromBody] PM_TrainingPlan trainingPlan)

        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Upd_TrainingNeeds " +
                       trainingPlan.TrainingID + ", " +
                       trainingPlan.ProjectID + ", " +
                       trainingPlan.ToolID + ", " +
                       trainingPlan.TrainingDuration + ", " +
                       trainingPlan.DayFormat + ", " +
                       "'" + trainingPlan.TrainingArea.Replace("'", "''") + "', " +
                       "'" + trainingPlan.WaiverCriteria.Replace("'", "''") + "', " +
                       (trainingPlan.Completed ? 1 : 0) + ", " +
                       "'" + trainingPlan.CreatedBy.Replace("'", "''") + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 18/04/2025 for API to update the selected Training plan

        //Added By Vyankat B on 18/04/2025 for API to update the selected Training plan resources
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object UpdateTrainingPlanResources([FromBody] PM_TrainingPlan trainingPlan)

        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Upd_TrainingResource " +trainingPlan.TrainingResourceID + ", " + trainingPlan.EmployeeId + ", '" +
                       trainingPlan.StartDate + "', '" +
                       trainingPlan.EndDate + "','" +
                       trainingPlan.Hours +"'"; 
                      

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 18/04/2025 for API to update the selected Training plan resources


    
        //Added By Vyankat B on 18/04/2025 for API to fetch active resources for a project
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object FetchActiveProjectResources([FromBody] PM_TrainingPlan trainingPlan)

        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_ActiveProjectEmployees " + trainingPlan.ProjectID;


                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 18/04/2025 for API to fetch active resources for a project

        //Added By Vyankat B on 18/04/2025 for API to insert Training plan resources
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object InsertTrainingPlanResources([FromBody] PM_TrainingPlan trainingPlan)

        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Ins_TrainingResource "+ trainingPlan.EmployeeId + "," +
                       trainingPlan.TrainingID + ", '"+
                       trainingPlan.StartDate + "', '" +
                       trainingPlan.EndDate + "','" +
                       trainingPlan.Hours + "'";


                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 18/04/2025 for API to insert Training plan resources.

        //Added By Vyankat B on 18/04/2025 for API to insert Training plan resources
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object DeleteTrainingPlanResources([FromBody] PM_TrainingPlan trainingPlan)

        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Del_TrainingResource " + trainingPlan.TrainingResourceID;


                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 18/04/2025 for API to insert Training plan resources


        //Added By Vyankat B on 18/04/2025 for API to update Training plan
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object UpateTrainingPlan([FromBody] PM_TrainingPlan trainingPlan)

        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Upd_TrainingNeeds " +
                        trainingPlan.TrainingID + ", " +
                        trainingPlan.ProjectID + ", " +
                        trainingPlan.ToolID + ", " +
                        trainingPlan.TrainingDuration + ", " +
                        trainingPlan.DayFormat + ", '" +
                        trainingPlan.TrainingArea.Replace("'", "''") + "', '" +
                        trainingPlan.WaiverCriteria.Replace("'", "''") + "', " +
                        (trainingPlan.Completed ? 1 : 0) + ", '" +
                        trainingPlan.CreatedBy.Replace("'", "''") + "'";


                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 18/04/2025 for API to update Training plan

        //Added By Vyankat B on 18/04/2025 for API to Add new filter
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object SaveNewFilter([FromBody] PM_TrainingPlan trainingPlan)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Ins_TrainingPlanAddNewFilter " +
                trainingPlan.ProjectID + ", " +
                trainingPlan.UserId + ", '" +
                (trainingPlan.WhereClause?.Replace("'", "''") ?? "") + "', '" +
                trainingPlan.LoginType + "', '" +
                (trainingPlan.CreatedBy?.Replace("'", "''") ?? "") + "', '" +
                (trainingPlan.FilterName?.Replace("'", "''") ?? "") + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }
        }
        //End of Added By Vyankat B on 18/04/2025 for API to Add new filter

        //Added By Vyankat B on 18/04/2025 for API to get selected Filter Parameter
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetSelectedFilterParameter([FromBody] PM_TrainingPlan trainingPlan)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_sel_TrainingPlanFilterWhereClauseByFilterID " + trainingPlan.FilterID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to get selected Filter Parameter

        //Added By Vyankat B on 18/04/2025 for API To Apply Filter
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public HttpResponseMessage ApplyFilter([FromBody] PM_TrainingPlan trainingPlan)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_sel_FilteredTrainingNeedsByParams " +
    "@ToolID = " + (trainingPlan.ToolID != 0 ? trainingPlan.ToolID.ToString() : "NULL") + ", " +
    "@TrainingArea = " + (!string.IsNullOrEmpty(trainingPlan.TrainingArea) ?
                          "'" + trainingPlan.TrainingArea.Replace("'", "''") + "'" : "NULL") + ", " +
    "@ProjectId = " + (trainingPlan.ProjectID != 0 ? trainingPlan.ProjectID.ToString() : "NULL") + ", " +
    "@DayFormat = " + (trainingPlan.DayFormat != 0 ? trainingPlan.DayFormat.ToString() : "NULL") + ", " +
    "@WaiverCriteria = " + (!string.IsNullOrEmpty(trainingPlan.WaiverCriteria) ?
                            "'" + trainingPlan.WaiverCriteria.Replace("'", "''") + "'" : "NULL") + ", " +
    "@TrainingDuration = " + (trainingPlan.TrainingDuration != 0 ?
                               trainingPlan.TrainingDuration.ToString() : "NULL") + ";";



                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return Request.CreateResponse(HttpStatusCode.OK, dt);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }
        }
        //End of Added By Vyankat B on 18/04/2025 for API To Apply Filter

        //Added By Vyankat B on 18/04/2025 for API to retrieve available filters
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object RetrieveAvailableFilters([FromBody] PM_TrainingPlan trainingPlan)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_sel_FilterForTrainingPlan " + trainingPlan.UserId + ", " + trainingPlan.TagID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to retrieve available filters

        //Added By Vyankat B on 18/04/2025 for API to set a filter as default
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object SetDefaultFilter([FromBody] PM_TrainingPlan trainingPlan)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_upd_SetDefaultFilterForTrainingPlan " + trainingPlan.FilterID + ", " + trainingPlan.UserId + ", " + trainingPlan.TagID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to set a filter as default

        //Added By Vyankat B on 18/04/2025 for API to unset a filter as default
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object UnSetDefaultFilter([FromBody] PM_TrainingPlan trainingPlan)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_upd_UnsetDefaultFilterOfTrainingPlan " + trainingPlan.FilterID + ", " + trainingPlan.UserId + ", " + trainingPlan.TagID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to unset a filter as default

        //Added By Vyankat B on 18/04/2025 for API to delete the selected filters
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object DeleteSelectedFilters([FromBody] PM_TrainingPlan trainingPlan)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_del_TrainingPlanFilter " + trainingPlan.FilterID + ", " + trainingPlan.UserId + ", " + trainingPlan.TagID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to delete the selected filters

        //Added By Vyankat B on 18/04/2025 for API to get parameter of a default filter
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetDefaultFilterParameter([FromBody] PM_TrainingPlan trainingPlan)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_sel_DefaultFilterIDOfTrainingPlan " + trainingPlan.UserId + ", " + trainingPlan.TagID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to get parameter of a default filter

        //Added By Vyankat B on 18/04/2025 for API to update the existing filter
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object UpdateExistingFilter([FromBody] PM_TrainingPlan trainingPlan)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_upd_ExistingFilterOfTrainingPlan " + trainingPlan.FilterID + ", " + trainingPlan.UserId + ", '" + trainingPlan.WhereClause + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to update the existing filter

        //Added By Vyankat B on 18/04/2025 for API to fetch history of the training skill
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object FetchTrainingPlanHistory([FromBody] PM_TrainingPlan trainingPlan)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Get_TrainingNeedsHistory " + trainingPlan.TrainingID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to fetch history of the training skill

        //Added By Vyankat B on 18/04/2025 for API to fetch project resources of change request section
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object FetchProjectResourcesOfChangeRequest([FromBody] PM_TrainingPlan trainingPlan)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_CurrentTeamMembers_TrainingPlan " + trainingPlan.ProjectID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to fetch project resources of change request section

        //Added By Vyankat B on 18/04/2025 for API to fetch priorities of change request section
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object FetchPrioritiesOfChangeRequest()
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_tbl_IB_Priorities_TrainingPlan";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to fetch priorities of change request section

        //Added By Vyankat B on 18/04/2025 for API to fetch task type of change request section
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object FetchTaskTypeOfChangeRequest([FromBody] PM_TrainingPlan trainingPlan)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_ProjectTaskTypeNames_TrainingPlan " + trainingPlan.ProjectID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to fetch task type of change request section

        //Added By Vyankat B on 18/04/2025 for API to fetch task type of change request section
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object Fetchchangereuest([FromBody] PM_TrainingPlan trainingPlan)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ChangeRequest_Master_Training " + trainingPlan.ProjectID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to fetch task type of change request section

        //Added By Vyankat B on 18/04/2025 for API to fetch task type of change request section
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object FetchSubProject([FromBody] PM_TrainingPlan trainingPlan)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_SubProject_Training " + trainingPlan.ProjectID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to fetch task type of change request section

        //Added By Vyankat B on 18/04/2025 for API to fetch module of change request section
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object FetchModuleOfChangeRequest([FromBody] PM_TrainingPlan trainingPlan)
        {

            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_Module_TrainingPlan " + trainingPlan.ModuleProjectID + ", " + trainingPlan.ModuleID + ", '" + trainingPlan.ModuleMode + "'," + trainingPlan.ModuleTaskID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to fetch module of change request section

        //Added By Vyankat B on 18/04/2025 for API to fetch phase of change request section
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object FetchPhaseOfChangeRequest([FromBody] PM_TrainingPlan trainingPlan)
        {

            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_ProjectPhasesForSQA_TrainingPlan " + trainingPlan.ProjectID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to fetch phase of change request section

        //Added By Vyankat B on 18/04/2025 for API to fetch milestone of change request section
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object FetchMilestoneOfChangeRequest([FromBody] PM_TrainingPlan trainingPlan)
        {

            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_Milestones_TrainingPlan " + trainingPlan.MilestoneProjectID + ", '" + trainingPlan.MilestoneMode + "', " + trainingPlan.MilestoneTaskID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to fetch milestone of change request section

        //Added By Vyankat B on 18/04/2025 for API to fetch sub project of change request section
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object FetchSubProjectOfChangeRequest([FromBody] PM_TrainingPlan trainingPlan)
        {

            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_SubProject_TrainingPlan " 
            + trainingPlan.ProjectID + ", "
            + trainingPlan.SubProjectID + ", '"
            + trainingPlan.SubProjectMode + "', "
            + trainingPlan.SubProjectTaskID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to fetch sub project of change request section

        //Added By Vyankat B on 18/04/2025 for API to assign task to resource 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object AssignTaskToResource([FromBody] PM_TrainingPlan trainingPlan)
        {

            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Ins_tbl_PM_ProjectTasks_Training " +

   "@TrainingID = " + trainingPlan.TrainingID + ", " +

   "@TaskID = " + (trainingPlan.TaskID.HasValue ? trainingPlan.TaskID.ToString() : "NULL") + ", " +
   "@TaskName = '" + (trainingPlan.TaskName ?? "") + "', " +
   "@ProjectID = " + trainingPlan.ProjectID + ", " +
   "@StartDate = '" + trainingPlan.StartDate + "', " +
   "@EndDate = '" + trainingPlan.EndDate + "', " +
   "@Work = " + (trainingPlan.Work != null ? trainingPlan.Work.ToString() : "NULL") + ", " +   // <-- Corrected
   "@BillableYN = " + trainingPlan.BillableYN + ", " +
   "@ModuleID = " + (trainingPlan.ModuleID.HasValue ? trainingPlan.ModuleID.ToString() : "NULL") + ", " +
   "@TaskNotes = '" + (trainingPlan.TaskNotes ?? "") + "', " +
   "@Priority = '" + (trainingPlan.Priority ?? "") + "', " +
   "@Void = " + trainingPlan.Void + " , " +
   "@OnHold = " + trainingPlan.OnHold + ", " +
   "@ChangeRequestID = " + trainingPlan.ChangeRequestID + ", " +
   "@SubProjectID = " + trainingPlan.SubProjectID + ", " +
   "@TrainingResourceID = " + trainingPlan.TrainingResourceID + ", " +
   "@Milestone = '" + trainingPlan.Milestone + "', " +
   "@DeliverableID = " + trainingPlan.ScheduleID + ", " +
   "@StoryPoints = " + trainingPlan.StoryPoints + ", " +
   "@IsUserStoryTask = " + trainingPlan.IsUserStoryTask + ", " +
   "@UserStoryID = " + trainingPlan.UserStoryID + ", " +
   "@TaskType = '" + trainingPlan.TaskType + "';";
              








                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to assign task to resource 

        //Added By Vyankat B on 18/04/2025 for API to fetch sub project of change request section
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object CreateTheSubTask([FromBody] PM_TrainingPlan trainingPlan)
        {

            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Ins_tbl_PM_ProjectAssignedSubTask_Training " +
   "@ParentTaskID = " + trainingPlan.ParentTaskID + ", " +
   "@TrainingID = " + trainingPlan.TrainingID + ", " +
   "@EmployeeID = " + trainingPlan.EmployeeId + ", " +

   "@TaskID = " + (trainingPlan.TaskID.HasValue ? trainingPlan.TaskID.ToString() : "NULL") + ", " +
   "@TaskName = '" + (trainingPlan.TaskName ?? "") + "', " +
   "@ProjectID = " + trainingPlan.ProjectID + ", " +
   "@StartDate = '" + trainingPlan.StartDate + "', " +
   "@EndDate = '" + trainingPlan.EndDate + "', " +
   "@Work = " + (trainingPlan.Work != null ? trainingPlan.Work.ToString() : "NULL") + ", " +   // <-- Corrected
   "@BillableYN = " + trainingPlan.BillableYN + ", " +
   "@ModuleID = " + (trainingPlan.ModuleID.HasValue ? trainingPlan.ModuleID.ToString() : "NULL") + ", " +
   "@TaskNotes = '" + (trainingPlan.TaskNotes ?? "") + "', " +
   "@Priority = '" + (trainingPlan.Priority ?? "") + "', " +
   "@Void = " + trainingPlan.Void + " , " +
   "@OnHold = " + trainingPlan.OnHold + ", " +
   "@SubProjectID = " + trainingPlan.SubProjectID + ", " +
   "@ChangeRequestID = " + trainingPlan.ChangeRequestID + ", " +
   "@TrainingResourceID = " + trainingPlan.TrainingResourceID + ", " +
   "@Milestone = '" + trainingPlan.Milestone + "', " +
   "@DeliverableID = " + trainingPlan.ScheduleID + ", " +
   "@StoryPoints = '" + trainingPlan.StoryPoints + "', " +
   "@UserStoryID = " + trainingPlan.UserStoryID + ", " +
   "@IsUserStoryTask = " + trainingPlan.IsUserStoryTask + ", " +
   "@TaskType = '" + trainingPlan.TaskType + "';";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to fetch sub project of change request section

        //Added By Vyankat B on 18/04/2025 for API to create task
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object CreateTask([FromBody] JToken jsonData)
        {

            string strSQL;
            try
            {
                strSQL = $"EXEC usp_Whizible2_Ins_tbl_PM_ProjectTasks_TPlan '{jsonData}'";


                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to create task


        //Added By Vyankat B on 18/04/2025 for API to get the Task ID
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTaskID([FromBody] PM_TrainingPlan trainingPlan)
        {

            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_TrainingResource_TaskID " +


   "@TrainingID = '" + trainingPlan.TaskType + "';";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to get the Task ID

        //Added By Vyankat B on 18/04/2025 for API to get selected task details 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetSelectedTaskDetails([FromBody] PM_TrainingPlan trainingPlan)
        {

            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ProjectTasks_TaskAssignment_TPlan  " +
   "@ProjectID = " + trainingPlan.ProjectID + ", " +
   "@TaskID = '" + trainingPlan.TaskID + "';";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to get selected task details 

        //Added By Vyankat B on 18/04/2025 for Arranging the resource schedule 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetResourceSchedule([FromBody] PM_TrainingPlan trainingPlan)
        {

            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ResourceSchedule_Training_Plan " +
             "@strEmployeeIDList = " + trainingPlan.EmployeeId + ", " +
             "@FromDate = '" + trainingPlan.StartDate + "' , " +
             "@ToDate = '" + trainingPlan.EndDate + "';";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End Added By Vyankat B on 18/04/2025 for Arranging the resource schedule 

        //Added By Vyankat B on 18/04/2025 for API to fetch deliverable Type
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetDeliverableType([FromBody] PM_TrainingPlan trainingPlan)
        {

            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_OtherSchedules_Deliverable " +

             "@intProjectID = " + trainingPlan.ProjectID + ";";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to fetch deliverable Type

        //Added By Vyankat B on 18/04/2025 for API to Get Scrum UserStory
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetScrumUserStory([FromBody] PM_TrainingPlan trainingPlan)
        {

            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_sel_tbl_PM_ScrumUserStory_TPlan " +

             "@intTaskId = " + trainingPlan.TaskID + ";";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to Get Scrum UserStory

        //Added By Vyankat B on 18/04/2025 for API to Get UserStory
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetUserStory([FromBody] PM_TrainingPlan trainingPlan)
        {

            string strSQL;
            try
            {
                strSQL = "EXEC Usp_Whizible2_Sel_Scrum_UserStories_TrainingPlan " +
             "@Flag = '" + trainingPlan.Flag + "', " +
             "@ProjectID = " + trainingPlan.ProjectID + ", " +
             "@UserStoryID = " + trainingPlan.UserStoryID + ";";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to Get UserStory

        //Added By Vyankat B on 18/04/2025 for API to check is agile project or not 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object CheckIsAgile([FromBody] PM_TrainingPlan trainingPlan)
        {

            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_tbl_PRS_ProjectTypes_IsAgile " +


             "@ProjectID = " + trainingPlan.ProjectID + ";";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Save filter failed");
            }

        }
        //End of Added By Vyankat B on 18/04/2025 for API to check is agile project or not 

        //Added By Vyankat B on 18/04/2025 for API to check is CustomFields Applicables
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object IsCustomFieldsApplicables([FromBody] PM_TrainingPlan trainingPlan)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_sel_ProjectID_tbl_PM_CustomFields_Master " + trainingPlan.ProjectID + "";
                var result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 18/04/2025 for API to check is CustomFields Applicables

        //Added By Vyankat B on 18/04/2025 for API to Get CustomField MasterRowNumber
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetCustomFieldMasterRowNumber([FromBody] CustomFieldModel Parameters)
        {
            try
            {
                //string layoutid;
                int MaxRow = 0, MaxColoumn = 0;

                string strsql = "Exec usp_Whizible2_Sel_tbl_PM_CustomFields_Master_MaxRows_Tplan " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.Type)) + ",'" + HttpUtility.UrlDecode(Parameters.strEntityName) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.IsActive)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.UserID)) + ",'" + HttpUtility.UrlDecode(Parameters.LoginType) + "'";

                DataTable CustomControlTable = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                foreach (DataRow sdr in CustomControlTable.Rows)
                {
                    MaxRow = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["MaxRows"], "0"));
                    MaxColoumn = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["MaxCols"], "0"));
                }
                object[] GetValue = { MaxRow, MaxColoumn };

                return GetValue;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 18/04/2025 for API to Get CustomField MasterRowNumber

        //Added By Vyankat B on 18/04/2025 for API to Get Validation ForCustomFields
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetValidationForCustomFields([FromBody] CustomFieldModel Parameters)
        {
            try
            {
                string VALIDATION;
                VALIDATION = Convert.ToString(Parameters.CustomValidation)
                    .Replace("[", "")
                    .Replace("]", "")
                    .Replace("\"", string.Empty)
                    .Trim();

                List<ValidationData_AssignedTask> ValidationData = new List<ValidationData_AssignedTask>();

                // SQL query to fetch validation data for assigned task
                string strsql = "Exec usp_Whizible2_Sel_tbl_UI_Validation_TPlan ";

                DataTable ValidationDataTable = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);

                if (VALIDATION.IndexOf("\n") != -1)
                {
                    VALIDATION = VALIDATION.Replace("\n", "").Trim();
                }

                if (VALIDATION.IndexOf("\r") != -1)
                {
                    VALIDATION = VALIDATION.Replace("\r", "").Trim();
                }

                VALIDATION = VALIDATION.Replace(" ", string.Empty).Trim();
                string[] Result = VALIDATION.Split(',');

                foreach (string r in Result)
                {
                    foreach (DataRow sdr in ValidationDataTable.Rows)
                    {
                        ValidationData_AssignedTask ValidationDataControl = new ValidationData_AssignedTask()
                        {
                            ValidationID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ValidationID"].ToString(), "")),
                            ValidationMessage = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ValidationMessage"].ToString(), "")),
                            FieldName = Convert.ToString(Parameters.CustomFieldName),
                            FieldID = Convert.ToString(Parameters.FieldID)
                        };

                        // Match the validation IDs
                        if (Convert.ToString(ValidationDataControl.ValidationID) == Convert.ToString(r))
                        {
                            ValidationData.Add(ValidationDataControl);
                        }
                    }
                }

                return ValidationData;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 18/04/2025 for API to Get Validation ForCustomFields

        //Added By Vyankat B on 18/04/2025 for API to Get Validation Filed
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object getValidationFiled([FromBody] CustomFieldModel Parameters)
        {
            try
            {
                string strSQL;

                strSQL = "exec usp_Whizible2_Sel_v_tbl_UI_ControlTagMaster_TPlan " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TagID));

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        List<int> CustomFieldIdList_AssignedTask = new List<int>();
        private object jsonString;

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object AssignedTaskPloatCustomFields([FromBody] CustomFieldPloat_AssignedTask Parameters)
        {
            try
            {
                List<CustomFieldPloat_AssignedTask> fieldLayoutList = new List<CustomFieldPloat_AssignedTask>();

                // Step 1: Get security-based CustomFieldIDs
                string strSQL = "Exec usp_Whizible2_sel_tbl_PM_RoleCustomFieldSecurity_TPlan " +
                                HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "," +
                                HttpUtility.UrlDecode(Convert.ToString(Parameters.RoleID)) + "," +
                                HttpUtility.UrlDecode(Convert.ToString(Parameters.UserID)) + ",'" +
                                HttpUtility.UrlDecode(Parameters.EntityName) + "','" +
                                HttpUtility.UrlDecode(Parameters.LoginType) + "'";

                IDataReader reader = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                while (reader.Read())
                {
                    CustomFieldIdList_AssignedTask.Add(Convert.ToInt32(reader["CustomFieldID"]));
                }

                // Step 2: Get custom fields based on type and entity
                if (Parameters.Type != null)
                {
                    string strSQL1 = "Exec usp_Whizible2_Sel_tbl_PM_CustomFields_MasterTPlan " +
                                     HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",NULL," +
                                     HttpUtility.UrlDecode(Convert.ToString(Parameters.IsActive)) + "," +
                                     HttpUtility.UrlDecode(Convert.ToString(Parameters.Type)) + ",'" +
                                     HttpUtility.UrlDecode(Parameters.EntityName) + "'," +
                                     HttpUtility.UrlDecode(Convert.ToString(Parameters.UserID)) + ",'" +
                                     HttpUtility.UrlDecode(Convert.ToString(Parameters.LoginType)) + "'";

                    DataTable fieldDataTable = CommonFunctions.Data.GetDataTable(strSQL1, true, CommonController.connectionString);

                    foreach (DataRow row in fieldDataTable.Rows)
                    {
                        CustomFieldPloat_AssignedTask fieldLayout = new CustomFieldPloat_AssignedTask()
                        {
                            UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(row["UniqueID"].ToString(), "0")),
                            UserGivenCaption = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["UserGivenCaption"].ToString(), "")),
                            ValidationRules = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["ValidationRules"].ToString(), "")),
                            DatabaseFieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["DatabaseFieldName"].ToString(), "")),
                            RowNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(row["RowNumber"].ToString(), "0")),
                            ColumnNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(row["ColumnNumber"].ToString(), "0")),
                            IsCustomFieldAssigned = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["IsCustomFieldAssigned"].ToString(), "")),
                            DefaultValue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["DefaultValue"].ToString(), "")),
                            DefaultType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["DefaultType"].ToString(), "")),
                            ControlHeight = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["ControlHeight"].ToString(), "")),
                            ControlWidth = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["ControlWidth"].ToString(), "")),
                            MaxLength = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["MaxLength"].ToString(), "0")),
                            MaxValue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["MaxValue"].ToString(), "0")),
                            MinValue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["MinValue"].ToString(), "0"))
                        };

                        fieldLayoutList.Add(fieldLayout);

                        // This block seems intended for flagging unassigned fields but isn't modifying anything,
                        // so we keep the check but skip else block.
                        if (!CustomFieldIdList_AssignedTask.Contains(fieldLayout.UniqueID))
                        {
                            // Could set IsCustomFieldAssigned = "0" explicitly here if required.
                        }
                    }
                }

                return fieldLayoutList;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Vyankat B on 18/04/2025 for API to Get ComboFieldDetails
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetComboFieldDetails([FromBody] CustomFieldModel Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_CustomFields_Details  " +
                  "@strDatabaseFieldName = '" + Parameters.FieldName + "', " +
                  "@intProjectID = " + Parameters.ProjectID + ";";
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 18/04/2025 for API to Get ComboFieldDetails


        //Added By Vyankat B on 18/04/2025 for API to Get CustomField
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetCustomField([FromBody] CustomFieldModel Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ProjectTasks_CustField " +
                  "@TaskID = '" + Parameters.TaskID + "', " +

                  "@CustomFieldName = '" + Parameters.CustomFieldName + "';";
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 18/04/2025 for API to Get CustomField

        //Added By Vyankat B on 18/04/2025 for API to Get TaskTypeID
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTaskTypeID([FromBody] CustomFieldModel Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "EXEC usp_Whizible2_sel_tbl_PM_TaskTypes_TaskTypeWise_TypeID " +
                  "@strTaskType = '" + Parameters.strTaskType + "';";
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 18/04/2025 for API to Get TaskTypeID

        //Added By Vyankat B on 18/04/2025 for API to Get Check date Is Between SprintDate
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object CheckIsBetweenSprintDate([FromBody] PM_TrainingPlan Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "EXEC usp_Whizible2_chk_TaskPeriodFallsBetweenIteration " +

                  "@intUserStoryID = " + Parameters.UserStoryID + ", " +
                  "@dtStartDate = '" + Parameters.StartDate + "', " +
                  "@dtEndDate = '" + Parameters.EndDate + "';";
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 18/04/2025 for API to Get Check date Is Between SprintDate

        //Added By Vyankat B on 18/04/2025 for API to Get Check date Is Between ProjectDate
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object CheckIsBetweenProjectDate([FromBody] PM_TrainingPlan Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "EXEC usp_Whizible2_tbl_PM_Project_TaskPeriodFallsBetween_Tplan " +

                  "@projectID = " + Parameters.ProjectID + ", " +
                  "@startDate = '" + Parameters.StartDate + "', " +
                  "@endDate = '" + Parameters.EndDate + "';";
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 18/04/2025 for API to Get Check date Is Between ProjectDate

    }


}

