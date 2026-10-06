using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web;
using System.Web.Http;
using System.Xml;
using WhizibleAPI.Models;
using WhizibleAPI.Models.PM;

namespace WhizibleAPI.Controllers
{
    public class PM_wbs_cardController : ApiController
    {
        #region[getProjectTasks]
        /// <summary>
        /// Created Date    :   14 July 2019
        /// Purpose         :   Get Project Task List for  scrum board
        /// <param name="pm_wbs_cardparameter"></param>
        /// <returns>PM_wbs_card list</returns>
        [HttpPost]
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        //public List<PM_wbs_card> getProjectTasks([FromBody]PM_wbs_card_parameters pm_wbs_cardparameter)
        public object getProjectTasks([FromBody] PM_wbs_card_parameters pm_wbs_cardparameter)
        {
            try
            {
                DataTable PM_wbs_cardTable;
                List<PM_wbs_card> projectTasklist = new List<PM_wbs_card>();
                string employeeID = "NULL", taskTypeID = "NULL", startDate = "NULL", endDate = "NULL";
                //if (!string.IsNullOrEmpty(pm_wbs_cardparameter.LoginID))
                //    employeeID = HttpUtility.UrlDecode(pm_wbs_cardparameter.LoginID);

                if (Convert.ToInt32(pm_wbs_cardparameter.LoginID) > 0)
                    employeeID = HttpUtility.UrlDecode(pm_wbs_cardparameter.LoginID);
                if (pm_wbs_cardparameter.TaskTypeID > 0)
                    taskTypeID = pm_wbs_cardparameter.TaskTypeID.ToString();
                if (!string.IsNullOrEmpty(pm_wbs_cardparameter.StartDate))
                    startDate = "'" + HttpUtility.UrlDecode(pm_wbs_cardparameter.StartDate) + "'";
                if (!string.IsNullOrEmpty(pm_wbs_cardparameter.EndDate))
                    endDate = "'" + HttpUtility.UrlDecode(pm_wbs_cardparameter.EndDate) + "'";
                PM_wbs_cardTable = CommonFunctions.Data.GetDataTable("Usp_Whizible2_Sel_tbl_WBS_ProjectTaskStages "
                                                                            + HttpUtility.UrlDecode(pm_wbs_cardparameter.ProjectID) +
                                                                            "," + employeeID + ","
                                                                            + HttpUtility.UrlDecode(pm_wbs_cardparameter.IsActive) +
                                                                            //",'" + HttpUtility.UrlDecode(pm_wbs_cardparameter.WhichTask) + "','"
                                                                            //+ HttpUtility.UrlDecode(pm_wbs_cardparameter.RoleAccess) + "'",
                                                                            ",'" + HttpUtility.UrlDecode(pm_wbs_cardparameter.WhichTask) +
                                                                            "'," + taskTypeID +
                                                                            "," + startDate +
                                                                             "," + endDate,
                                                                            true,
                                                                            CommonController.connectionString);
                foreach (DataRow drProjectTask in PM_wbs_cardTable.Rows)
                {
                    PM_wbs_card PT = new PM_wbs_card()
                    {
                        TaskID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drProjectTask["TaskID"], "")),
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drProjectTask["ProjectID"], "")),
                        EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drProjectTask["EmployeeID"], "")),
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["ProjectName"], "")),
                        EmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["EmployeeName"], "")),
                        ActualEndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["ActualEndDate"], "")),
                        ActualStartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["ActualStartDate"], "")),
                        StartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["StartDate"], "")),
                        EndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["EndDate"], "")),
                        DaysRemaining = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["DaysRemaining"], "")),
                        Priority = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["Priority"], "")),
                        IsActive = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["IsActive"], "")),
                        IsTaskComplete = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(drProjectTask["IsTaskComplete"], "")),
                        SubTaskTypes = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["SubTaskTypes"], "")),
                        TaskName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["TaskName"], "")),
                        StageID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["StageID"], "")),
                        OrderNo = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["OrderNo"], "")),
                        WhichTask = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["WhichTask"], "")),
                        MasterStageID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["MasterStageID"], "")),
                        ActualWork = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["ActualWork"], "")),
                        ActualPercentComplete = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["ActualPercentComplete"], "")),
                        WorkInHours = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["WorkInHours"], "")),
                        TaskNotes = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["TaskNotes"], "")),
                        //Added by Chetan M on 10th Feb 2020 for IssueID = 21829
                        StageName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["StageName"], "")),
                        //End of Added by Chetan M on 10th Feb 2020 for IssueID = 21829
                    };

                    projectTasklist.Add(PT);
                }
                return projectTasklist;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[getProjectTasks]
        /// <summary>
        /// Created Date    :   14 July 2019
        /// Purpose         :   Get Project Task List for  scrum board
        /// <param name="pm_wbs_cardparameter"></param>
        /// <returns>PM_wbs_card list</returns>
        [HttpPost]
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        //public List<ScrumeStages> getDefaultStages([FromBody]PM_wbs_card pm_wbs_cardparameter)
        public object getDefaultStages([FromBody] PM_wbs_card pm_wbs_cardparameter)
        {
            try
            {
                DataTable PM_wbs_cardTable;
                List<ScrumeStages> scrumestages = new List<ScrumeStages>();
                PM_wbs_cardTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_WBS_TaskStages " + pm_wbs_cardparameter.ProjectID + " ", true, CommonController.connectionString);
                foreach (DataRow drProjectTask in PM_wbs_cardTable.Rows)
                {
                    ScrumeStages SS = new ScrumeStages()
                    {
                        StageID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["StageID"], "")),
                        StageName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["StageName"], "")),
                        OrderNO = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["OrderNO"], "")),
                        ProjectID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["ProjectID"], "")),
                        MasterStageID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["MasterStageID"], "")),
                    };

                    scrumestages.Add(SS);
                }
                return scrumestages;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[SaveStage]
        /// <summary>
        /// Created Date    :   18 July 2019
        /// Created By      :   Chandrashekhar Salagar
        /// Purpose         :   Save New Stage
        /// </summary>
        /// <param name="taskParameters"></param>
        /// <returns></returns>
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object SaveStage([FromBody] ScrumeStages scrumeStagesParameter)
        {
            try
            {
                string Message;
                //changes by Vishal Mahajan 13-01-2020
                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                                (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_WBS_TaskStages '"
                                                                                     + HttpUtility.UrlDecode(scrumeStagesParameter.StageName) + "',"
                                                                                     + HttpUtility.UrlDecode(scrumeStagesParameter.OrderNO) + ",'"
                                                                                     + HttpUtility.UrlDecode(scrumeStagesParameter.IsCustom) + "',"
                                                                                     + HttpUtility.UrlDecode(scrumeStagesParameter.ProjectID) + ","
                                                                                     + HttpUtility.UrlDecode(scrumeStagesParameter.ColorID) + ",'"
                                                                                     + HttpUtility.UrlDecode(scrumeStagesParameter.CreatedBy) + "',"
                                                                                     + HttpUtility.UrlDecode(scrumeStagesParameter.MasterStageID) + " ",
                                                                                     true, CommonController.connectionString
                                                                                     ),
                                                  "")
                                                  );
                return Message;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[UpdateStage]
        /// <summary>
        /// Created Date    :   19 July 2019
        /// Created By      :   Chandrashekhar Salagar
        /// Purpose         :   Update stage
        /// </summary>
        /// <param name="pm_wbs_card"></param>
        /// <returns></returns>
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object UpdateStage([FromBody] PM_wbs_card updateStage)
        {
            try
            {
                string Message;
                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                                (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Upd_tbl_WBS_ProjectTaskStages "
                                                                                     + HttpUtility.UrlDecode(updateStage.TaskID.ToString()) + ","
                                                                                     + HttpUtility.UrlDecode(updateStage.StageID) + ",'"
                                                                                     + HttpUtility.UrlDecode(updateStage.EmployeeName) + "', "
                                                                                     + HttpUtility.UrlDecode(updateStage.ProjectID.ToString()) + ","
                                                                                     + HttpUtility.UrlDecode(updateStage.DragStageID) + " ",
                                                                                     true, CommonController.connectionString
                                                                                     ),
                                                  "")
                                                  );
                return Message;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
            #endregion

            #region[UpdateTaskCardOrder]
            /// <summary>
            /// Created Date    :   22 July 2019
            /// Created By      :   Chandrashekhar Salagar
            /// Purpose         :   Update stage
            /// </summary>
            /// <param name="pm_wbs_card"></param>
            /// <returns></returns>
            //Added by imran on 14-09-2022
            [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object UpdateTaskCardOrder([FromBody]PM_wbs_card TaskOrderArray)
        {
            try
            {
                string Message = "";
                //string[] ArrayTaskOrder = "35368,35374,34350,34348".Split(',').ToArray();
                string[] ArrayTaskOrder = TaskOrderArray.OrderNoString.Split(',').ToArray();
                for (int i = 0; i < ArrayTaskOrder.Length; i++)
                {
                    CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Upd_tbl_WBS_TaskCardOrder " + ArrayTaskOrder[i] + ","
                                                                                     + (i + 1) + "," + HttpUtility.UrlDecode(TaskOrderArray.ProjectID.ToString()) + "," + HttpUtility.UrlDecode(TaskOrderArray.StageID) + " ", true, CommonController.connectionString), "");
                }

                return Message = TaskOrderArray.OrderNoString;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[UpdateStageName]
        /// <summary>
        /// Created Date    :   23 July 2019
        /// Created By      :   Chandrashekhar Salagar
        /// Purpose         :   Update stage Name
        /// </summary>
        /// <param name="pm_wbs_card"></param>
        /// <returns></returns>
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object UpdateStageName([FromBody] PM_wbs_card updateStageName)
        {
            try
            {
                string Message;
                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                                (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Upd_tbl_WBS_StageName  "
                                                                                     + HttpUtility.UrlDecode(updateStageName.StageID) + ",'"
                                                                                     + HttpUtility.UrlDecode(updateStageName.StageName) + "','"
                                                                                     + HttpUtility.UrlDecode(updateStageName.EmployeeName) + "' ",
                                                                                     true, CommonController.connectionString
                                                                                     ),
                                                  "")
                                                  );
                return Message;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[UpdateAllStageOrders]
        /// <summary>
        /// Created Date    :   24 July 2019
        /// Created By      :   Chandrashekhar Salagar
        /// Purpose         :   Update All StageOrders
        /// </summary>
        /// <param name="pm_wbs_card"></param>
        /// <returns></returns>
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object UpdateAllStageOrders([FromBody] PM_wbs_card updateStage)
        {
            try
            {
                string Message = "";
                string[] StageArray = updateStage.StageName.Split(',').ToArray();
                for (int i = 0; i < StageArray.Length; i++)
                {
                    Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                              (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Upd_tbl_WBS_AllOrders  "
                                                                                   + StageArray[i] + ",'"
                                                                                   + HttpUtility.UrlDecode(updateStage.EmployeeName) + "' ",
                                                                                   true, CommonController.connectionString
                                                                                   ),
                                                "")
                                                );
                }

                return Message;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[DeleteStage]
        /// <summary>
        /// Created Date    :   25 July 2019
        /// Created By      :   Chandrashekhar Salagar
        /// Purpose         :   Delete stage 
        /// </summary>
        /// <param name="pm_wbs_card"></param>
        /// <returns></returns>
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object DeleteStage([FromBody] PM_wbs_card deleteStage)
        {
            try
            {
                string Message;
                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                                (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Del_tbl_WBS_Stage  "
                                                                                     + HttpUtility.UrlDecode(deleteStage.StageID) + " ",
                                                                                     true, CommonController.connectionString
                                                                                     ),
                                                  "")
                                                  );
                return Message;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[GetRoleAccess]
        /// <summary>
        /// Created Date    :   29 July 2019
        /// Purpose         :   GetRoleAccess
        /// <returns></returns>
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        // public List<RoleAccess> GetRoleAccess([FromBody] RoleAccess roleAccess)
        public object GetRoleAccess([FromBody] RoleAccess roleAccess)
        {
            try
            {
                DataTable PM_wbs_cardTable;
                List<RoleAccess> listRoleAccess = new List<RoleAccess>();
                PM_wbs_cardTable = CommonFunctions.Data.GetDataTable("usp_Sel_RoleAccess " + HttpUtility.UrlDecode(roleAccess.RoleID) + ",0," + HttpUtility.UrlDecode(roleAccess.TagID) + " ", true, CommonController.connectionString);
                foreach (DataRow drProjectTask in PM_wbs_cardTable.Rows)
                {
                    RoleAccess RA = new RoleAccess()
                    {
                        AddRole = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["A"], "")),
                        EditRole = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["E"], "")),
                        DeleteRole = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["D"], "")),
                        ViewRole = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["V"], "")),
                    };

                    listRoleAccess.Add(RA);
                }
                return listRoleAccess;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[UpdateAllStageOrders]
        /// <summary>
        /// Created Date    :   24 July 2019
        /// Created By      :   Chandrashekhar Salagar
        /// Purpose         :   Check Daily Activity
        /// </summary>
        /// <param name="pm_wbs_card"></param>
        /// <returns></returns>
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object CheckDailyActivity([FromBody] PM_wbs_card Task)
        {
            try
            {
                string Message = "";
                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                          (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Get_tbl_PM_DailyActivity  "
                                                                               + HttpUtility.UrlDecode(Task.TaskID.ToString()) + " ",
                                                                               true, CommonController.connectionString
                                                                               ),
                                            "")
                                            );

                return Message;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion


        #region[UpdateImpactedTask]
        /// <summary>
        /// Created Date    :   23 July 2019
        /// Created By      :   Chandrashekhar Salagar
        /// Purpose         :   Update stage Name
        /// </summary>
        /// <param name="pm_wbs_card"></param>
        /// <returns></returns>
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object UpdateImpactedTask([FromBody] PM_wbs_card impactedTask)
        {
            try
            {
                string Message;
                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                                (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Upd_tbl_WBS_ProjectTaskStages_ImpactStageID  "
                                                                                     + HttpUtility.UrlDecode(impactedTask.TaskID.ToString()) + ","
                                                                                     + HttpUtility.UrlDecode(impactedTask.ImpactedStageID) + " ,'"
                                                                                     + HttpUtility.UrlDecode(impactedTask.EmployeeName) + "' ",
                                                                                     true, CommonController.connectionString
                                                                                     ),
                                                  "")
                                                  );
                return Message;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        //ProjectID,EmployeesessionId,TagID
        //CommonFunctions.Security.Token.GetToken(objGlobal.TagID + CType(Session("IssueProject"), String) + CType(Session("intUserID"), String))        
        //CommonFunctions.Security.Token.ValidateToken(m_PKToken_ToIssueList, m_PKToken_FromIssueList)

        /// <summary>
        /// Created Date    :   17 Aug 2019.
        /// Purpose         :   Generate token for every request.
        /// Author          :   Chandrashekhar Salagar.
        /// <param name="tagId"></param>
        /// <param name="projectID"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        #region[GenerateToken]
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object GenerateToken(TokenGeneration tokenGeneration)
        {
            try
            {
                string Token = string.Empty;
                Token = CommonFunctions.Security.Token.GetToken(HttpUtility.UrlDecode(tokenGeneration.tagId) + HttpUtility.UrlDecode(tokenGeneration.projectID) + HttpUtility.UrlDecode(tokenGeneration.userId));
                return Token;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion


        /// <summary>
        /// Created Date    :   17 Aug 2019.
        /// Purpose         :   Validate token.
        /// Author          :   Chandrashekhar Salagar.
        /// <param name="tagId"></param>
        /// <param name="projectID"></param>
        /// <param name="userId"></param>
        /// <param name="Token"></param>
        /// <returns></returns>
        #region[ValidateToken]
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object ValidateToken(TokenGeneration validateToken)
        {
            try
            {
                return CommonFunctions.Security.Token.ValidateToken(HttpUtility.UrlDecode(validateToken.tagId) + HttpUtility.UrlDecode(validateToken.projectID) + HttpUtility.UrlDecode(validateToken.userId), HttpUtility.UrlDecode(validateToken.Token));
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion




        /// <summary>
        /// Created Date    :   21 Aug 2019.
        /// Purpose         :   Assign tasks in bulk
        /// Author          :   Chandrashekhar Salagar.
        /// <param name="tagId"></param>
        /// <param name="projectID"></param>
        /// <param name="userId"></param>
        /// <param name="Token"></param>
        /// <returns></returns>
        #region[AssignTaskInBulk]
        [Authorize]
        [HttpPost]
        //public string AssignTaskInBulk()
        // public List<FileUploadParameters> AssignTaskInBulk()
        public object AssignTaskInBulk()
        {
            try
            {
                List<FileUploadParameters> listFileUploadParameters = new List<FileUploadParameters>();
                var httpPostedFile = HttpContext.Current.Request.Files["UploadedImage"];
                DataTable data = new DataTable();
                string ExcelColumn = "";
                if (httpPostedFile != null)
                {
                    var FileName = httpPostedFile.FileName;
                    string fileSavePath = Path.Combine(HttpContext.Current.Server.MapPath("~/UploadedFiles"), httpPostedFile.FileName);
                    string folderSavePath = HttpContext.Current.Server.MapPath("~/UploadedFiles");
                    folderSavePath = folderSavePath.Replace("WhizibleAPIService", "ATTACHMENTS\\PM");
                    fileSavePath = fileSavePath.Replace("WhizibleAPIService", "ATTACHMENTS\\PM");
                    if (!Directory.Exists(folderSavePath))
                    {
                        Directory.CreateDirectory(folderSavePath);
                    }

                    httpPostedFile.SaveAs(fileSavePath);
                    using (OleDbConnection con = new OleDbConnection())
                    {
                        DataTable dt = new DataTable();
                        string fileExtension = Path.GetExtension(FileName);
                        if (Environment.Is64BitOperatingSystem)
                        {
                            con.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + fileSavePath + ";Extended Properties='Excel 12.0;Xml;HDR=No;IMEX=1'";
                        }
                        else
                        {
                            if (fileExtension == ".xls")
                            {
                                con.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + fileSavePath + ";Extended Properties='Excel 8.0;Xml;HDR=No;IMEX=1'";
                            }
                            if (fileExtension == ".xlsx")
                            {
                                con.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + fileSavePath + ";Extended Properties='Excel 12.0;Xml;HDR=No;IMEX=1'";
                            }
                        }
                        using (OleDbCommand cmd = new OleDbCommand())
                        {
                            try
                            {

                                /*Save Mapping configuration to table*/
                                var Data = HttpContext.Current.Request.Form["assigntaskinbulk"];
                                var assigntaskinbulk = JsonConvert.DeserializeObject<List<AssignTaskInBulk>>(Data);
                                foreach (var item in assigntaskinbulk)
                                {
                                    AssignTaskInBulk assigntask = new AssignTaskInBulk();
                                    if (item.WBSFieldName.ToLower() == "resource")
                                    {
                                        assigntask.FieldOrder = "1";
                                    }
                                    else if (item.WBSFieldName.ToLower() == "start date")
                                    {
                                        assigntask.FieldOrder = "2";
                                    }
                                    else if (item.WBSFieldName.ToLower() == "end date")
                                    {
                                        assigntask.FieldOrder = "3";
                                    }
                                    else if (item.WBSFieldName.ToLower() == "work")
                                    {
                                        assigntask.FieldOrder = "4";
                                    }
                                    else
                                    {
                                        assigntask.FieldOrder = "";
                                    }
                                    //string sql = "usp_Whizible2_Ins_tbl_PM_WBSExcelUpload_Fields " + item.projectId + ",'" + item.WBSFieldName + "', '" + item.ExcelFeildName + "','" + assigntask.FieldOrder + " '";
                                    //var result = CommonFunctions.Data.GetDataScalar(sql, true, CommonController.connectionString);

                                }


                                con.Open();
                                DataTable activityDataTable = con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                                string ExcelSheetName = activityDataTable.Rows[0]["Table_Name"].ToString();
                                cmd.CommandText = "Select * FROM [" + ExcelSheetName + "]";
                                cmd.Connection = con;

                                using (OleDbDataAdapter da = new OleDbDataAdapter())
                                {
                                    da.SelectCommand = cmd;
                                    da.Fill(dt);
                                    DataTable ExcelTable = dt;
                                    DataRow row = dt.Rows[0];
                                    ExcelColumn = dt.Columns.Count.ToString();
                                    //added by dipali V on 12th Feb 2020 For Remove blank row 
                                    /// DataRow row1 = dt.Rows[dt.Rows.Count - 1];
                                    dt.Rows.Remove(row);
                                    //dt.Rows.Remove(row1);
                                    //End of added by dipali V on 12th Feb 2020 For Remove blank row 
                                    data = ValaidateExcel(ExcelTable, assigntaskinbulk);
                                }
                            }
                            catch (Exception ex)
                            {
                                string exceptionMessage = ex.Message;
                            }
                        }
                        List<DataRow> list = data.AsEnumerable().ToList();
                        DataColumnCollection columns = data.Columns;

                        foreach (DataRow dr in data.Rows)
                        {
                            FileUploadParameters objFileUploadParameters = new FileUploadParameters();
                            //objFileUploadParameters.FileName = FileName;
                            //objFileUploadParameters.FilePath = fileSavePath;
                            objFileUploadParameters.TaskName = dr["Task Name"].ToString();
                            objFileUploadParameters.Resources = dr["Resources"].ToString();
                            objFileUploadParameters.StartDate = dr["Start Date"].ToString();
                            objFileUploadParameters.EndDate = dr["End Date"].ToString();
                            objFileUploadParameters.Priority = dr["Priority"].ToString();
                            objFileUploadParameters.TaskType = dr["Task Type"].ToString();
                            if (columns.Contains("User Story"))
                            {
                                objFileUploadParameters.UserStory = dr["User Story"].ToString();
                            }

                            //will check if column is present in generated datatable. if present the add to the list so user can see//
                            if (columns.Contains("Task Notes"))
                            {
                                objFileUploadParameters.TaskNotes = dr["Task Notes"].ToString();
                            }

                            if (columns.Contains("Estimation Type"))
                            {
                                objFileUploadParameters.EstimationType = dr["Estimation Type"].ToString();
                            }
                            if (columns.Contains("Work"))
                            {
                                objFileUploadParameters.Work = dr["Work"].ToString();
                            }
                            if (columns.Contains("Sub Project"))
                            {
                                objFileUploadParameters.SubProject = dr["Sub Project"].ToString();
                            }
                            if (columns.Contains("Change Request"))
                            {
                                objFileUploadParameters.ChangeRequest = dr["Change Request"].ToString();
                            }

                            if (columns.Contains("Release"))
                            {
                                objFileUploadParameters.Release = dr["Release"].ToString();
                            }

                            if (columns.Contains("Story Point"))
                            {
                                objFileUploadParameters.StoryPoint = dr["Story Point"].ToString();
                            }

                            if (columns.Contains("Feature"))
                            {
                                objFileUploadParameters.Feature = dr["Feature"].ToString();
                            }

                            //Commented and added by Chetan M on 11th Feb 2020 for IsssueID = 21827
                            //if (columns.Contains("Bilable"))                        
                            //{
                            //objFileUploadParameters.Bilable = dr["Bilable"].ToString();
                            if (columns.Contains("Billable"))
                            {
                                objFileUploadParameters.Billable = dr["Billable"].ToString();
                                //End of Commented and added by Chetan M on 11th Feb 2020 for IsssueID = 21827
                            }

                            if (columns.Contains("Deliverable"))
                            {
                                objFileUploadParameters.Deliverable = dr["Deliverable"].ToString();
                            }
                            if (columns.Contains("Module"))
                            {
                                objFileUploadParameters.Module = dr["Module"].ToString();
                            }
                            if (columns.Contains("Milestone"))
                            {
                                objFileUploadParameters.Milestone = dr["Milestone"].ToString();
                            }
                            if (columns.Contains("Sprint"))
                            {
                                objFileUploadParameters.Sprint = dr["Sprint"].ToString();
                            }
                            if (columns.Contains("Phase"))
                            {
                                objFileUploadParameters.Phase = dr["Phase"].ToString();
                            }

                            //objFileUploadParameters.ValidRecords = dr["ValidRecords"].ToString();
                            //objFileUploadParameters.InvalidRecords = dr["InvalidRecords"].ToString();
                            //Added By Dipali V On 26th Feb 2020 For Get Count of Excel column
                            objFileUploadParameters.ErrorMessage = dr["Error Message"].ToString();
                            //End of Added By Dipali V On 26th Feb 2020 For Get Count of Excel column
                            objFileUploadParameters.ExcelNoColumn = ExcelColumn.ToString();
                            //Commented And Added By Usha Pandit On 07.12.2020 For getting correct task count
                            //listFileUploadParameters.Add(objFileUploadParameters);
                            if (objFileUploadParameters.TaskName != "" && objFileUploadParameters.Resources != null && objFileUploadParameters.StartDate != null && objFileUploadParameters.EndDate != null && objFileUploadParameters.Priority != null && objFileUploadParameters.TaskType != null)
                            {
                                listFileUploadParameters.Add(objFileUploadParameters);
                            }
                            //End Of Added By Usha Pandit On 07.12.2020 For getting correct task count
                        }
                    }
                }

                //return listFileUploadParameters + "," + data.Columns;
                return listFileUploadParameters;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
            #endregion






            /// <summary>
            /// Created Date    :   31 Aug-2019
            /// Purpose         :   CreateTable     
            /// Author          :   Chandrashekhar Salagar
            /// </summary>
            public DataTable ValaidateExcel(DataTable excelTable, List<AssignTaskInBulk> assigntaskinbulk)
        {

            //Get project feilds from database//

            DataSet dsProjectSettings = GetProjectSettings(Convert.ToInt32(assigntaskinbulk[0].projectId));
            int intFieldCount = excelTable.Columns.Count;

            for (Int32 k = intFieldCount + 1; k <= 21; k++)
            {
                excelTable.Columns.Add("F" + k);
            }
            excelTable.Columns.Add("Error Message");
            excelTable.Columns.Add("ValidRecords");
            excelTable.Columns.Add("InvalidRecords");
            int inValidRecords = 0;
            int validRecords = 0;
            string strQuery = "";
            IDataReader drExceField;
            System.Collections.Specialized.StringDictionary FieldDictionary = new System.Collections.Specialized.StringDictionary();
            System.Collections.Specialized.StringDictionary FieldCaptionDictionary = new System.Collections.Specialized.StringDictionary();
            string[] arrColCaptions = new[] { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V" };
            string strFieldName;
            string errMsg = "";
            StringBuilder strQueryData = new StringBuilder("");
            StringBuilder strExcelValidateData = new StringBuilder("");
            StringBuilder strTableHeaderHTML = new StringBuilder("");
            string strTempQuery;
            string strTDData = "";
            string Work = "";

            //Modified code on 31-Aug-2019//
            DataTable MappedTable = new DataTable();
            MappedTable.Columns.Add("Error Message");

            //strQuery = "usp_Whizible2_Sel_tbl_PM_WBSExcelUpload_Fields  " + ProjectID;
            //drExceField = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            //while (drExceField.Read())
            //{
            //    FieldDictionary.Add(drExceField["ExcelFeildName"].ToString(), drExceField["WBSFieldName"].ToString());
            //    FieldCaptionDictionary.Add(drExceField["ExcelFeildName"].ToString(), drExceField["WBSFieldName"].ToString());
            //}

            /*Maintain checking order of Excel Fields*/
            int i = 1;
            List<ExcelDictionary> listExcelDictionary = new List<ExcelDictionary>();
            foreach (var item in assigntaskinbulk)
            {
                ExcelDictionary dict = new ExcelDictionary();
                if (item.WBSFieldName.ToLower() == "task name")
                {
                    dict.CheckOrder = 1;
                }
                else if (item.WBSFieldName.ToLower() == "resources")
                {
                    dict.CheckOrder = 2;
                }
                else if (item.WBSFieldName.ToLower() == "start date")
                {
                    dict.CheckOrder = 3;
                }
                else if (item.WBSFieldName.ToLower() == "end date")
                {
                    dict.CheckOrder = 4;
                }
                else if (item.WBSFieldName.ToLower() == "work")
                {
                    dict.CheckOrder = 5;

                }
                else
                {
                    i = 11;
                    dict.CheckOrder = i;
                    i++;
                }
                dict.ExcelFeildName = item.ExcelFeildName;
                dict.WBSFieldName = item.WBSFieldName;
                listExcelDictionary.Add(dict);

            }


            var NewList = listExcelDictionary.OrderBy(x => x.CheckOrder).ToList();

            //foreach (var item in assigntaskinbulk)
            //{
            foreach (var item in NewList)
            {
                FieldDictionary.Add(item.ExcelFeildName, item.WBSFieldName);
                FieldCaptionDictionary.Add(item.ExcelFeildName, item.WBSFieldName);
            }

            try
            {
                foreach (DataRow drPBUS in excelTable.Rows)
                {
                    MappedTable.Rows.Add();
                    var StartDate = "";
                    var EndDate = "";
                    var UserName = "";
                    var IsValidStartDate = "0";//Added By Dipali V On 17th Feb 2021 For Duplicated Error Msg Get display
                    var UsertStory = "";
                    int index = excelTable.Rows.IndexOf(drPBUS);
                    errMsg = "";
                    strQueryData.Clear();
                    strExcelValidateData.Clear();
                    //if (index != excelTable.Rows.Count-1)
                    //{
                        for (int j = 0; j <= assigntaskinbulk.Count(); j++)
                        {

                            strFieldName = FieldDictionary[arrColCaptions[j]];
                            strTDData = drPBUS[j].ToString();
                            if (index == 0 && strFieldName != null)
                            {
                                MappedTable.Columns.Add(strFieldName);
                            }

                            switch (strFieldName)
                            {
                                case "Task Name":
                                    {
                                        if (string.IsNullOrEmpty(strTDData))
                                        {
                                            if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                            {
                                                MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + "Task Name is blank";
                                            }
                                            else
                                            {
                                                MappedTable.Rows[index]["Error Message"] = "Task Name is blank";
                                            }
                                        }
                                        else
                                        {
                                            //if (strTDData.Length > 200)
                                            if (strTDData.Length > 255)
                                            {
                                                MappedTable.Rows[index]["Error Message"] = " Task Name should be less than 255 characters";
                                            }
                                            MappedTable.Rows[index][strFieldName] = strTDData;
                                        }
                                    }
                                    break;

                                case "Priority":
                                    {
                                        string result = "";
                                        MappedTable.Rows[index][strFieldName] = strTDData;
                                        if (string.IsNullOrEmpty(strTDData))
                                        {
                                            if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                            {
                                                MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + "Priority is blank";
                                            }
                                            else
                                            {
                                                result = "Priority is blank";
                                            // MappedTable.Rows[index][strFieldName] = strTDData;
                                            if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                            {
                                                MappedTable.Rows[index]["Error Message"] = result;
                                            }
                                            else
                                            {
                                                //MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                MappedTable.Rows[index]["Error Message"] = result;
                                            }
                                            }
                                        }
                                        else
                                        {
                                            bool isPriorityAssigned = false;
                                            /*Added by chandrashekhar salagar for validation of resource*/
                                            DataTable priorityTable = dsProjectSettings.Tables[2];
                                            for (int k = 0; k < priorityTable.Rows.Count; k++)
                                            {
                                                string strPriority = priorityTable.Rows[k]["Priority"].ToString();
                                                if (strPriority.ToLower() == strTDData.ToLower())
                                                {
                                                    isPriorityAssigned = true;
                                                    break;
                                                }
                                            }
                                            if (isPriorityAssigned)
                                            {
                                                MappedTable.Rows[index][strFieldName] = strTDData;
                                            }
                                            else
                                            {
                                                //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                MappedTable.Rows[index][strFieldName] = strTDData;
                                                //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                result = "Priority " + strTDData + " not defined for project";
                                                if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                {
                                                    MappedTable.Rows[index]["Error Message"] = result;
                                                }
                                                else
                                                {

                                                MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                //MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString();
                                            }
                                            }

                                            //string sql = "usp_Whizible2_Validate_WBS_ProjectTasks " + assigntaskinbulk[0].projectId + ",' ', '" + strTDData + "' ,' ',' ',' ',' ',' ',' ',' ',' ',' ',' '";
                                            //var result = CommonFunctions.Data.GetDataScalar(sql, true, CommonController.connectionString);
                                            //if (result == null)
                                            //{
                                            //    MappedTable.Rows[index][strFieldName] = strTDData;
                                            //}
                                            //else
                                            //{
                                            //    if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()) && !(MappedTable.Rows[index]["Error Message"].ToString().Contains(result.ToString())))
                                            //    {
                                            //        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + result;
                                            //    }
                                            //    else
                                            //    {
                                            //        MappedTable.Rows[index]["Error Message"] = result;
                                            //    }

                                            //}
                                        }
                                    }
                                    break;


                                case "Task Type":
                                    {
                                        string result = "";
                                        MappedTable.Rows[index][strFieldName] = strTDData;
                                        if (string.IsNullOrEmpty(strTDData))
                                        {
                                            if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                            {
                                                MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + "Task Type is blank";
                                            }
                                            else
                                            {
                                                MappedTable.Rows[index]["Error Message"] = "Task Type is blank";
                                            }
                                        }
                                        else
                                        {
                                            bool isValidTask = false;
                                            /*Added by chandrashekhar salagar for validation of resource*/
                                            DataTable TaskTypes = dsProjectSettings.Tables[13];
                                            for (int k = 0; k < TaskTypes.Rows.Count; k++)
                                            {
                                                string TaskType = TaskTypes.Rows[k]["TaskType"].ToString();
                                                if (TaskType.ToLower() == strTDData.ToLower())
                                                {
                                                    isValidTask = true;
                                                    break;
                                                }
                                            }
                                            if (isValidTask)
                                            {
                                                MappedTable.Rows[index][strFieldName] = strTDData;
                                            }
                                            else
                                            {
                                                //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                MappedTable.Rows[index][strFieldName] = strTDData;
                                                //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                result = " Task type" + strTDData + "  is not associated with project";
                                                if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                {
                                                    MappedTable.Rows[index]["Error Message"] = result;
                                                }
                                                else
                                                {

                                                    MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                    //MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString();
                                                }
                                        }

                                        }
                                    }
                                    break;

                            ////Added By Dipali V On 14th Feb 2020 For Sub Task Type Validation 
                            //case "Sub Task Type":
                            //    {
                            //        string result = "";
                            //        MappedTable.Rows[index][strFieldName] = strTDData;
                            //        if (string.IsNullOrEmpty(strTDData))
                            //        {
                            //            if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                            //            {
                            //                MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + "Task Type is blank";
                            //            }
                            //            else
                            //            {
                            //                MappedTable.Rows[index]["Error Message"] = "Sub Task Type is blank";
                            //            }
                            //        }
                            //        else
                            //        {
                            //            bool isValidTask = false;
                                       
                            //            DataTable SubTaskType = dsProjectSettings.Tables[14];
                            //            for (int k = 0; k < SubTaskType.Rows.Count; k++)
                            //            {
                            //                string SubTaskTypes = SubTaskType.Rows[k]["SubTaskType"].ToString();
                            //                if (SubTaskTypes.ToLower() == strTDData.ToLower())
                            //                {
                            //                    isValidTask = true;
                            //                    break;
                            //                }
                            //            }
                            //            if (isValidTask)
                            //            {
                            //                MappedTable.Rows[index][strFieldName] = strTDData;
                            //            }
                            //            else
                            //            {
                            //                //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                            //                MappedTable.Rows[index][strFieldName] = strTDData;
                            //                //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                            //                result = " Sub Task Type" + strTDData + "  is not associated with project";
                            //                if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                            //                {
                            //                    MappedTable.Rows[index]["Error Message"] = result;
                            //                }
                            //                else
                            //                {
                            //                    MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                            //                }
                            //            }

                            //        }
                            //    }
                            //    break;
                            ////End of Added By Dipali V On 14th Feb 2020 For Sub Task Type Validation
                            case "Start Date":
                                    {
                                        
                                        MappedTable.Rows[index][strFieldName] = strTDData;
                                        if (string.IsNullOrEmpty(strTDData))
                                        {
                                            if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                            {
                                                MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + "Start Date is blank";
                                            }
                                            else
                                            {
                                                MappedTable.Rows[index]["Error Message"] = "Start Date is blank";
                                            }
                                        }
                                        else
                                        {
                                            MappedTable.Rows[index][strFieldName] = strTDData;
                                            StartDate = strTDData;
                                            EndDate = strTDData;
                                        if (EndDate != "" && StartDate != "" && UserName != "")
                                        {
                                            string sql = "usp_Whizible2_Validate_WBS_ProjectTasks " + assigntaskinbulk[0].projectId + ",'" + UserName + "', ' ',' ',' ',' ',' ','" + StartDate + " ','" + strTDData + "',' ',' ',' ',' ',' '";
                                            var result = CommonFunctions.Data.GetDataScalar(sql, true, CommonController.connectionString);
                                            if (result == null)
                                            {
                                               
                                                MappedTable.Rows[index][strFieldName] = strTDData;
                                            }

                                            else
                                            {
                                                //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                MappedTable.Rows[index][strFieldName] = strTDData;
                                                //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                if ((!result.ToString().Contains("not associated with project")) && !(MappedTable.Rows[index]["Error Message"].ToString().Contains("not associated with project")))
                                                {
                                                    if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()) && !(MappedTable.Rows[index]["Error Message"].ToString().Contains(result.ToString())))
                                                    // if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    {

                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + result;
                                                    }
                                                    else if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = result;
                                                    }
                                                    else if (MappedTable.Rows[index]["Error Message"].ToString().Contains(result.ToString()))
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"];
                                                    }
                                                    else
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + result;
                                                    }
                                                }
                                                else
                                                {

                                                    if (MappedTable.Rows[index]["Error Message"].ToString().Contains(result.ToString()))
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"];
                                                    }
                                                    else
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + result;
                                                    }
                                                }

                                            }

                                            }
                                        }
                                    } 
                                    break;

                                case "End Date":
                                {
                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                    if (string.IsNullOrEmpty(strTDData))
                                    {
                                        if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                        {
                                            MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + "End Date is blank";
                                        }
                                        else
                                        {
                                            MappedTable.Rows[index]["Error Message"] = "End Date is blank";
                                        }
                                    }
                                    else
                                    {
                                        EndDate = strTDData;
                                        if (EndDate != "" && StartDate != "" && UserName != "")
                                        {
                                            string sql = "usp_Whizible2_Validate_WBS_ProjectTasks " + assigntaskinbulk[0].projectId + ",'" + UserName + "', ' ',' ',' ',' ',' ','" + StartDate + " ','" + strTDData + "',' ',' ',' ',' ',' '";
                                            var result = CommonFunctions.Data.GetDataScalar(sql, true, CommonController.connectionString);

                                            if (result == null)
                                            {
                                                //Commented and added by Chetan M on 3 May 2021 for Issue fixing
                                                //IsValidStartDate = result.ToString();//Added By Dipali V On 17th Feb 2021 For Duplicated Error Msg Get display
                                                MappedTable.Rows[index][strFieldName] = strTDData;
                                            }
                                            else
                                            {
                                                //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                MappedTable.Rows[index][strFieldName] = strTDData;
                                                //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                if ((!result.ToString().Contains("not associated with project")) && !(MappedTable.Rows[index]["Error Message"].ToString().Contains("not associated with project")))
                                                {
                                                    if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()) && !(MappedTable.Rows[index]["Error Message"].ToString().Contains(result.ToString())))
                                                    // if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    {

                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + result;
                                                    }
                                                    else if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = result;
                                                    }
                                                    else if (MappedTable.Rows[index]["Error Message"].ToString().Contains(result.ToString()))
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"];
                                                    }
                                                    else {
                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + result;
                                                    }
                                                }
                                                else
                                                {
                                                    if (MappedTable.Rows[index]["Error Message"].ToString().Contains(result.ToString()))
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"];
                                                    }
                                                    else
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + result;
                                                    }

                                                }

                                            }
                                        }


                                    }
                                }
                                    break;

                                case "User Story":
                                    {
                                        MappedTable.Rows[index][strFieldName] = strTDData;
                                        var result = "";
                                        bool IsAgileMethodFollowed = false;
                                        /*Added by chandrashekhar salagar for validation of resource*/
                                        DataTable ProjectSettings = dsProjectSettings.Tables[0];
                                        UsertStory = strTDData;
                                        if (Convert.ToBoolean(ProjectSettings.Rows[0]["IsAgileMethodFollowed"]))
                                        {
                                            IsAgileMethodFollowed = true;
                                        }
                                        if (IsAgileMethodFollowed)
                                        {
                                            //if (!string.IsNullOrEmpty(strTDData))
                                            //{
                                            if (string.IsNullOrEmpty(strTDData))
                                            {
                                                result = "User Story is blank";
                                                if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                {
                                                    MappedTable.Rows[index]["Error Message"] = result;
                                                }
                                                else
                                                {
                                                    MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                }
                                            }
                                            else
                                            {
                                                /*Check if this user story is current sprint*/
                                                if (dsProjectSettings.Tables[14].Rows.Count > 0)
                                                {
                                                /*Check if sprint is mapped to release*/
                                                //if (dsProjectSettings.Tables[14].Rows[0]["ReleaseID"]!=null)
                                                //{ 
                                                   
                                                    bool isOngoingSprint = false;
                                                    for (int k = 0; k < dsProjectSettings.Tables[14].Rows.Count; k++)
                                                    {
                                                        string UserStoryName = dsProjectSettings.Tables[14].Rows[k]["UserStoryName"].ToString();
                                                        if (UserStoryName.ToLower() == UserStoryName.ToLower())
                                                        {
                                                            isOngoingSprint = true;
                                                        }

                                                    }

                                                if (isOngoingSprint)
                                                {
                                                    //*Use stored Procedure for calculating user story sprint and all*//
                                                    string sql = "usp_Whizible2_Validate_WBS_ProjectTasks " + assigntaskinbulk[0].projectId + ",'" + UserName + "', ' ',' ',' ',' ',' ','" + StartDate + " ','" + EndDate + "','" + Work + "',' ',' ',' ','" + strTDData + " '";
                                                    var sqlresult = CommonFunctions.Data.GetDataScalar(sql, true, CommonController.connectionString);
                                                    result = Convert.ToString(sqlresult);
                                                    if (sqlresult == null)
                                                    {
                                                        MappedTable.Rows[index][strFieldName] = strTDData;
                                                    }
                                                    else
                                                    {
                                                        //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                        MappedTable.Rows[index][strFieldName] = strTDData;

                                                        //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                        //if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()) && !(MappedTable.Rows[index]["Error Message"].ToString().Contains(result.ToString())))
                                                        //{
                                                        //    MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + result;
                                                        //}
                                                        //else
                                                        //{
                                                        //    MappedTable.Rows[index]["Error Message"] = sqlresult;
                                                        //}


                                                        if ((!result.ToString().Contains("not associated with project")) && !(MappedTable.Rows[index]["Error Message"].ToString().Contains("not associated with project")))
                                                        {
                                                            if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()) && !(MappedTable.Rows[index]["Error Message"].ToString().Contains(result.ToString())))
                                                            // if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                            {

                                                                MappedTable.Rows[index]["Error Message"] = result;
                                                            }
                                                            else if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                            {
                                                                MappedTable.Rows[index]["Error Message"] = result;
                                                            }
                                                            else if (MappedTable.Rows[index]["Error Message"].ToString().Contains(result.ToString()))
                                                            {
                                                                MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"];
                                                            }
                                                            else
                                                            {
                                                                MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + result;
                                                            }
                                                        }
                                                        else
                                                        {

                                                            MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"];
                                                        }


                                                    }
                                                }
                                                else
                                                {
                                                    result = "User Story is not in current sprint";
                                                    //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                    //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = result;
                                                    }
                                                    else
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                    }
                                                }
                                                }
                                                else
                                                {
                                                    result = "User Story is not in current sprint";
                                                    //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                    //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = result;
                                                    }
                                                    else
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                    }
                                                }
                                            }
                                        }

                                        #region[SingleSPvalidation]
                                        //if (string.IsNullOrEmpty(strTDData))
                                        //{
                                        //    if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                        //    {
                                        //        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + "User story is blank";
                                        //    }
                                        //    else
                                        //    {
                                        //        MappedTable.Rows[index]["Error Message"] = "User story is blank";
                                        //    }
                                        //}
                                        //else
                                        //{
                                        //    MappedTable.Rows[index][strFieldName] = strTDData;
                                        //}
                                        #endregion
                                    }
                                    break;

                                case "Resources":
                                    {
                                        string result = "";
                                        inValidRecords++;
                                        if (string.IsNullOrEmpty(strTDData))
                                        {
                                            if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                            {
                                                MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + "Resources is blank";
                                            }
                                            else
                                            {
                                                result = "Resources is blank";
                                                if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                {
                                                    MappedTable.Rows[index]["Error Message"] = result;
                                                }
                                                else
                                                {
                                                    MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                }
                                            }

                                        }
                                        else
                                        {

                                            UserName = strTDData;
                                            bool isTeammember = false;
                                            /*Added by chandrashekhar salagar for validation of resource*/
                                            DataTable teammembers = dsProjectSettings.Tables[1];
                                            for (int k = 0; k < teammembers.Rows.Count; k++)
                                            {
                                                string TeamMember = teammembers.Rows[k]["UserName"].ToString();
                                                if (TeamMember.ToLower() == strTDData.ToLower())
                                                {
                                                    isTeammember = true;
                                                    break;
                                                }
                                            }
                                            if (isTeammember)
                                            {
                                                MappedTable.Rows[index][strFieldName] = strTDData;
                                            }
                                            else
                                            {
                                                //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                MappedTable.Rows[index][strFieldName] = strTDData;
                                                //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                result = "Resources " + UserName + " not associated with project";
                                                if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                {
                                                    MappedTable.Rows[index]["Error Message"] = result;
                                                }
                                                else
                                                {
                                                    MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                }
                                            }

                                            //string sql = "usp_Whizible2_Validate_WBS_ProjectTasks " + assigntaskinbulk[0].projectId + ",'" + UserName + "', ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '";
                                            //var result = CommonFunctions.Data.GetDataScalar(sql, true, CommonController.connectionString);
                                            //if (result == null)
                                            //{
                                            //    MappedTable.Rows[index][strFieldName] = strTDData;
                                            //}
                                            //else
                                            //{
                                            //    if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()) && !(MappedTable.Rows[index]["Error Message"].ToString().Contains(result.ToString())))
                                            //    {
                                            //        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + result;
                                            //    }
                                            //    else
                                            //    {
                                            //        MappedTable.Rows[index]["Error Message"] = result;
                                            //    }

                                            //}

                                        }
                                    }
                                    break;

                                case "Work":
                                    {
                                    if (string.IsNullOrEmpty(strTDData))
                                    {
                                        var errorMessage = MappedTable.Rows[index]["Error Message"].ToString();
                                        //MappedTable.Rows[index]["Error Message"] = "Work (hours) is blank";
                                        if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                        {
                                            MappedTable.Rows[index]["Error Message"] = "Work(hours) is blank";
                                        }
                                        else
                                        {
                                            MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + "Work(hours) is blank";
                                        }
                                        MappedTable.Rows[index][strFieldName] = strTDData;

                                    }
                                    else
                                    {
                                        try
                                        {
                                            //var timeSpan = TimeSpan.FromHours(Convert.ToDouble(strTDData));
                                            //var timeSpan = TimeSpan.Parse(strTDData);
                                            //int hh = timeSpan.Hours;
                                            //int mm = timeSpan.Minutes;

                                            //decimal timeInDecimal = Convert.ToDecimal(strTDData);

                                            //var hours = Math.Floor(timeInDecimal);
                                            //var mins = 60 * (timeInDecimal - hours);
                                            //strTDData = strTDData.ToString().Replace(":", ".");

                                            string sql = "usp_Whizible2_Validate_WBS_ProjectTasks " + assigntaskinbulk[0].projectId + ",'" + UserName + "', ' ',' ',' ',' ',' ','" + StartDate + " ','" + EndDate + "','" + strTDData + "',' ',' ',' '";
                                            var result = CommonFunctions.Data.GetDataScalar(sql, true, CommonController.connectionString);
                                            if (result == null)
                                            {
                                                MappedTable.Rows[index][strFieldName] = strTDData;
                                                //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                //MappedTable.Rows[index][strFieldName] = strTDData;
                                                //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                Work = strTDData;
                                            }
                                            else
                                            {

                                                //MappedTable.Rows[index][strFieldName] = hh + ":" + mm.ToString("00");
                                                //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                MappedTable.Rows[index][strFieldName] = strTDData;
                                                //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                if ((!result.ToString().Contains("not associated with project")) && !(MappedTable.Rows[index]["Error Message"].ToString().Contains("not associated with project")))
                                                {
                                                    if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()) && !(MappedTable.Rows[index]["Error Message"].ToString().Contains(result.ToString())))
                                                    // if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    {
                                                        //Added By Dipali V On 17th Feb 2021 For Duplicated Error Msg Get display
                                                        if ((!result.ToString().Contains(IsValidStartDate)) && !(MappedTable.Rows[index]["Error Message"].ToString().Contains(IsValidStartDate)))
                                                        {
                                                            MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + result;

                                                        }
                                                        else
                                                        {
                                                            MappedTable.Rows[index]["Error Message"] = result;

                                                        }
                                                    }   //End of Added By Dipali V On 17th Feb 2021 For Duplicated Error Msg Get display

                                                    else if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = result;
                                                    }
                                                    else
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + result;
                                                    }
                                                }
                                                else
                                                {


                                                    if (!strTDData.ToString().Contains(":"))
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = result;
                                                    }
                                                    else
                                                    {
                                                        //MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"];
                                                        if (MappedTable.Rows[index]["Error Message"].ToString().Contains(result.ToString()))
                                                        {
                                                            MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"];
                                                        }
                                                        else
                                                        {
                                                            MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + result;
                                                        }
                                                    }

                                                }

                                            }
                                        }
                                        catch (Exception ex)
                                        {
                                            MappedTable.Rows[index][strFieldName] = strTDData;
                                            //var errorMessage = MappedTable.Rows[index]["Error Message"].ToString();
                                            MappedTable.Rows[index]["Error Message"] = "Work should be in (HH:MM) ";

                                        }

                                    }
                                    }

                                    break;

                                case "Module":
                                    {
                                        MappedTable.Rows[index][strFieldName] = strTDData;
                                        var result = "";
                                        bool isModuleMandatory = false;
                                        /*Added by chandrashekhar salagar for validation of resource*/
                                        DataTable ProjectSettings = dsProjectSettings.Tables[0];

                                        if (Convert.ToBoolean(ProjectSettings.Rows[0]["ShowModuleInAT"]))
                                        {
                                            if (Convert.ToBoolean(ProjectSettings.Rows[0]["ModuleMandatoryInAT"]))
                                            {
                                                isModuleMandatory = true;
                                            }
                                            // isModuleMandatory = true;
                                        }
                                        if (isModuleMandatory)
                                        {
                                            if (string.IsNullOrEmpty(strTDData))
                                            {
                                                result = "Module is blank";
                                                MappedTable.Rows[index][strFieldName] = strTDData;
                                                if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                {
                                                    MappedTable.Rows[index]["Error Message"] = result;
                                                }
                                                else
                                                {
                                                //MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString();
                                                MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                            }
                                            }
                                            else
                                            {
                                                bool isModuleValid = false;
                                                /*Added by chandrashekhar salagar for validation of resource*/
                                                DataTable Module = dsProjectSettings.Tables[7];
                                                for (int k = 0; k < Module.Rows.Count; k++)
                                                {
                                                    string ModuleName = Module.Rows[k]["ModuleName"].ToString();
                                                    if (ModuleName.ToLower() == strTDData.ToLower())
                                                    {
                                                        isModuleValid = true;
                                                        break;
                                                    }
                                                }
                                                if (isModuleValid)
                                                {
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                }
                                                else
                                                {
                                                    //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                    //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    result = "Module " + strTDData + " is invalid";
                                                    if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = result;
                                                    }
                                                    else
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                    }
                                                }
                                            }
                                        }
                                        else
                                        {
                                            if (strTDData.Length > 0)
                                            {
                                                bool isModuleValid = false;
                                                /*Added by chandrashekhar salagar for validation of resource*/
                                                DataTable Module = dsProjectSettings.Tables[7];
                                                for (int k = 0; k < Module.Rows.Count; k++)
                                                {
                                                    string ModuleName = Module.Rows[k]["ModuleName"].ToString();
                                                    if (ModuleName.ToLower() == strTDData.ToLower())
                                                    {
                                                        isModuleValid = true;
                                                        break;
                                                    }
                                                }
                                                if (isModuleValid)
                                                {
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                }
                                                else
                                                {
                                                    //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                    //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    result = "Module " + strTDData + " is invalid";
                                                    if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = result;
                                                    }
                                                    else
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                    }
                                                }
                                            }


                                        }



                                        #region[SingleSpValidation]
                                        //if (!string.IsNullOrEmpty(strTDData))
                                        //{
                                        //    string sql = "usp_Whizible2_Validate_WBS_ProjectTasks " + assigntaskinbulk[0].projectId + ",' ', ' ', '" + strTDData + "',' ',' ',' ',' ',' ',' ',' ',' ',' '";
                                        //    var result = CommonFunctions.Data.GetDataScalar(sql, true, CommonController.connectionString);
                                        //    if (result == null)
                                        //    {
                                        //        MappedTable.Rows[index][strFieldName] = strTDData;
                                        //    }
                                        //    else
                                        //    {
                                        //        if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                        //        {
                                        //            MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + result;
                                        //        }
                                        //        else
                                        //        {
                                        //            MappedTable.Rows[index]["Error Message"] = result;
                                        //        }

                                        //    }
                                        //}
                                        #endregion
                                    }
                                    break;

                                case "Sub Project":
                                    {
                                        var result = "";
                                        bool isSubProjectMandatory = false;
                                        /*Added by chandrashekhar salagar for validation of resource*/
                                        DataTable ProjectSettings = dsProjectSettings.Tables[0];

                                        if (Convert.ToBoolean(ProjectSettings.Rows[0]["ShowSubprojectInAT"]))
                                        {
                                            if (Convert.ToBoolean(ProjectSettings.Rows[0]["SubprojectMandatoryInAT"]))
                                            {
                                                isSubProjectMandatory = true;
                                            }
                                            //isSubProjectMandatory = true;
                                        }
                                        if (isSubProjectMandatory)
                                        {
                                            if (string.IsNullOrEmpty(strTDData))
                                            {
                                                MappedTable.Rows[index][strFieldName] = strTDData;
                                                result = "Sub Project is blank";
                                                if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                {
                                                    MappedTable.Rows[index]["Error Message"] = result;
                                                }
                                                else
                                                {
                                                    MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                }
                                            }
                                            else
                                            {
                                                bool isSubProjectValid = false;
                                                /*Added by chandrashekhar salagar for validation of resource*/
                                                DataTable Subproject = dsProjectSettings.Tables[8];
                                                for (int k = 0; k < Subproject.Rows.Count; k++)
                                                {
                                                    string SubProjectName = Subproject.Rows[k]["SubProjectName"].ToString();
                                                    if (SubProjectName.ToLower() == strTDData.ToLower())
                                                    {
                                                        isSubProjectValid = true;
                                                        break;
                                                    }
                                                }
                                                if (isSubProjectValid)
                                                {
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                }
                                                else
                                                {
                                                    //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                    //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    result = "Sub Project " + strTDData + " is invalid";
                                                    if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = result;
                                                    }
                                                    else
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                    }
                                                }
                                            }
                                        }
                                        else
                                        {
                                            if (strTDData.Length > 0)
                                            {
                                                bool isSubProjectValid = false;
                                                /*Added by chandrashekhar salagar for validation of resource*/
                                                DataTable Subproject = dsProjectSettings.Tables[8];
                                                for (int k = 0; k < Subproject.Rows.Count; k++)
                                                {
                                                    string SubProjectName = Subproject.Rows[k]["SubProjectName"].ToString();
                                                    if (SubProjectName.ToLower() == strTDData.ToLower())
                                                    {
                                                        isSubProjectValid = true;
                                                        break;
                                                    }
                                                }
                                                if (isSubProjectValid)
                                                {
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                }
                                                else
                                                {
                                                    //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                    //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    result = "Sub Project " + strTDData + " is invalid";
                                                    if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = result;
                                                    }
                                                    else
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                    }
                                                }
                                            }

                                        }

                                        #region[SingleSpValidation]
                                        //if (!string.IsNullOrEmpty(strTDData))
                                        //{
                                        //    string sql = "usp_Whizible2_Validate_WBS_ProjectTasks " + assigntaskinbulk[0].projectId + ",' ', ' ',' ', '" + strTDData + "',' ',' ',' ',' ',' ' ,' ',' ',' ',' '";
                                        //    var result = CommonFunctions.Data.GetDataScalar(sql, true, CommonController.connectionString);
                                        //    if (result == null)
                                        //    {
                                        //        MappedTable.Rows[index][strFieldName] = strTDData;
                                        //    }
                                        //    else
                                        //    {
                                        //        if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                        //        {
                                        //            MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + result;
                                        //        }
                                        //        else
                                        //        {
                                        //            MappedTable.Rows[index]["Error Message"] = result;
                                        //        }

                                        //    }
                                        //}                                    //if (!string.IsNullOrEmpty(strTDData))
                                        //{
                                        //    string sql = "usp_Whizible2_Validate_WBS_ProjectTasks " + assigntaskinbulk[0].projectId + ",' ', ' ',' ', '" + strTDData + "',' ',' ',' ',' ',' ' ,' ',' ',' ',' '";
                                        //    var result = CommonFunctions.Data.GetDataScalar(sql, true, CommonController.connectionString);
                                        //    if (result == null)
                                        //    {
                                        //        MappedTable.Rows[index][strFieldName] = strTDData;
                                        //    }
                                        //    else
                                        //    {
                                        //        if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                        //        {
                                        //            MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + result;
                                        //        }
                                        //        else
                                        //        {
                                        //            MappedTable.Rows[index]["Error Message"] = result;
                                        //        }

                                        //    }
                                        //}
                                        #endregion
                                    }
                                    break;

                                case "Milestone":
                                    {

                                        var result = "";
                                        bool isMilestonetMandatory = false;
                                        /*Added by chandrashekhar salagar for validation of resource*/
                                        DataTable ProjectSettings = dsProjectSettings.Tables[0];
                                        //commented and add by omkar 30/01/2020
                                        //if (Convert.ToBoolean(ProjectSettings.Rows[0]["ShowSubprojectInAT"]))
                                        if (Convert.ToBoolean(ProjectSettings.Rows[0]["ShowMilestoneInAT"]))
                                        {
                                            //if (Convert.ToBoolean(ProjectSettings.Rows[0]["SubprojectMandatoryInAT"]))
                                            if (Convert.ToBoolean(ProjectSettings.Rows[0]["MilestoneMandatoryInAT"]))
                                            {
                                                //end of commented and add by omkar 30/01/2020
                                                isMilestonetMandatory = true;
                                            }
                                            // isMilestonetMandatory = true;
                                        }
                                        if (isMilestonetMandatory)
                                        {
                                            if (string.IsNullOrEmpty(strTDData))
                                            {
                                                result = "Milestone is blank";
                                                MappedTable.Rows[index][strFieldName] = strTDData;
                                                if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                {
                                                    MappedTable.Rows[index]["Error Message"] = result;
                                                }
                                                else
                                                {
                                                    MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                }
                                            }
                                            else
                                            {
                                                bool isMilestoneValid = false;
                                                /*Added by chandrashekhar salagar for validation of resource*/
                                                //add by omkar 30/01/2020
                                                DataTable Milestone = dsProjectSettings.Tables[9];
                                                //end of add by omkar 30/01/2020
                                                for (int k = 0; k < Milestone.Rows.Count; k++)
                                                {
                                                    string MilestoneName = Milestone.Rows[k]["MileStone"].ToString();
                                                    if (MilestoneName.ToLower() == strTDData.ToLower())
                                                    {
                                                        isMilestoneValid = true;
                                                        break;
                                                    }
                                                }
                                                if (isMilestoneValid)
                                                {
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                }
                                                else
                                                {
                                                    //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                    //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    result = "Milestone " + strTDData + " is invalid";
                                                    if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = result;
                                                    }
                                                    else
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                    }
                                                }
                                            }
                                        }
                                        else
                                        {
                                            if (strTDData.Length > 0)
                                            {
                                                bool isMilestoneValid = false;
                                                /*Added by chandrashekhar salagar for validation of resource*/
                                                //add by omkar 30/01/2020
                                                DataTable Milestone = dsProjectSettings.Tables[9];
                                                //end of add by omkar 30/01/2020
                                                for (int k = 0; k < Milestone.Rows.Count; k++)
                                                {
                                                    string MilestoneName = Milestone.Rows[k]["MileStone"].ToString();
                                                    if (MilestoneName.ToLower() == strTDData.ToLower())
                                                    {
                                                        isMilestoneValid = true;
                                                        break;
                                                    }
                                                }
                                                if (isMilestoneValid)
                                                {
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                }
                                                else
                                                {
                                                    //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                    //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    result = "Milestone " + strTDData + " is invalid";
                                                    if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = result;
                                                    }
                                                    else
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                    }
                                                }

                                            }
                                        }
                                        #region[SingleSpValidation]
                                        //if (!string.IsNullOrEmpty(strTDData))
                                        //{
                                        //    string sql = "usp_Whizible2_Validate_WBS_ProjectTasks " + assigntaskinbulk[0].projectId + ",' ', ' ',' ',' ', '" + strTDData + "',' ',' ',' ' ,' ',' ',' ',' ',' '";
                                        //    var result = CommonFunctions.Data.GetDataScalar(sql, true, CommonController.connectionString);
                                        //    if (result == null)
                                        //    {
                                        //        MappedTable.Rows[index][strFieldName] = strTDData;
                                        //    }
                                        //    else
                                        //    {
                                        //        if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()) && !(MappedTable.Rows[index]["Error Message"].ToString().Contains(result.ToString())))
                                        //        {
                                        //            MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + result;
                                        //        }
                                        //        else
                                        //        {
                                        //            MappedTable.Rows[index]["Error Message"] = result;
                                        //        }

                                        //    }
                                        //}
                                        #endregion
                                    }
                                    break;

                                case "Feature":
                                    {
                                        var result = "";
                                        bool isFeatureMandatory = false;
                                        /*Added by chandrashekhar salagar for validation of resource*/
                                        DataTable ProjectSettings = dsProjectSettings.Tables[0];

                                        if (Convert.ToBoolean(ProjectSettings.Rows[0]["ShowFeatureInAT"]))
                                        {
                                            if (Convert.ToBoolean(ProjectSettings.Rows[0]["FeatureMandatoryInAT"]))
                                            {
                                                isFeatureMandatory = true;
                                            }
                                            //add by omkar 03/02/2020
                                            // isFeatureMandatory = true;
                                            //end of omkar 03/02/2020
                                        }
                                        if (isFeatureMandatory)
                                        {
                                            //changed by omkar 30/01/2020
                                            if (string.IsNullOrEmpty(strTDData))
                                            {
                                                //end of changed by omkar 30/01/2020
                                                MappedTable.Rows[index][strFieldName] = strTDData;
                                                result = "Feature is blank";
                                                if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                {
                                                    MappedTable.Rows[index]["Error Message"] = result;
                                                }
                                                else
                                                {
                                                    MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                }
                                            }
                                            else
                                            {
                                                bool isMilestoneValid = false;
                                                /*Added by chandrashekhar salagar for validation of resource*/
                                                //add and change by omkar 30/01/2020
                                                DataTable ProjectFeature = dsProjectSettings.Tables[10];
                                                //end of add and change by omkar 30/01/2020
                                                for (int k = 0; k < ProjectFeature.Rows.Count; k++)
                                                {
                                                    string ProjectFeatureName = ProjectFeature.Rows[k]["FeatureName"].ToString();
                                                    if (ProjectFeatureName.ToLower() == strTDData.ToLower())
                                                    {
                                                        isMilestoneValid = true;
                                                        break;
                                                    }
                                                }
                                                if (isMilestoneValid)
                                                {
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                }
                                                else
                                                {
                                                    //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                    //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    result = "Project Feature " + strTDData + " is invalid";
                                                    if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = result;
                                                    }
                                                    else
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                    }
                                                }
                                            }
                                        }
                                        else
                                        {
                                            if (strTDData.Length > 0)
                                            {
                                                bool isMilestoneValid = false;
                                                /*Added by chandrashekhar salagar for validation of resource*/
                                                //add and change by omkar 30/01/2020
                                                DataTable ProjectFeature = dsProjectSettings.Tables[10];
                                                //end of add and change by omkar 30/01/2020
                                                for (int k = 0; k < ProjectFeature.Rows.Count; k++)
                                                {
                                                    string ProjectFeatureName = ProjectFeature.Rows[k]["FeatureName"].ToString();
                                                    if (ProjectFeatureName.ToLower() == strTDData.ToLower())
                                                    {
                                                        isMilestoneValid = true;
                                                        break;
                                                    }
                                                }
                                                if (isMilestoneValid)
                                                {
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                }
                                                else
                                                {
                                                    //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                    //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    result = "Project Feature " + strTDData + " is invalid";
                                                    if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = result;
                                                    }
                                                    else
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                    }
                                                }

                                            }
                                        }

                                        #region[SingleSpValidation]
                                        //if (!string.IsNullOrEmpty(strTDData))
                                        //{
                                        //    string sql = "usp_Whizible2_Validate_WBS_ProjectTasks " + assigntaskinbulk[0].projectId + ",' ', ' ',' ',' ', ' ','" + strTDData + "',' ',' ',' ',' ',' ',' ',' ' ";
                                        //    var result = CommonFunctions.Data.GetDataScalar(sql, true, CommonController.connectionString);
                                        //    if (result == null)
                                        //    {
                                        //        MappedTable.Rows[index][strFieldName] = strTDData;
                                        //    }
                                        //    else
                                        //    {
                                        //        if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()) && !(MappedTable.Rows[index]["Error Message"].ToString().Contains(result.ToString())))
                                        //        {
                                        //            MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + result;
                                        //        }
                                        //        else
                                        //        {
                                        //            MappedTable.Rows[index]["Error Message"] = result;
                                        //        }

                                        //    }
                                        //}
                                        #endregion
                                    }
                                    break;

                                case "Estimation Type":
                                    {
                                        var result = "";
                                        bool isEstimationTypeMandatory = false;
                                        /*Added by chandrashekhar salagar for validation of resource*/
                                        DataTable ProjectSettings = dsProjectSettings.Tables[0];

                                        if (Convert.ToBoolean(ProjectSettings.Rows[0]["ShowEstimationTypeInAT"]))
                                        {
                                            if (Convert.ToBoolean(ProjectSettings.Rows[0]["EstimationTypeMandatoryInAT"]))
                                            {
                                                isEstimationTypeMandatory = true;
                                            }
                                            //add by omkar 03/02/2020
                                            // isEstimationTypeMandatory = true;
                                            //end of add by omkar 03/02/2020
                                        }
                                        if (isEstimationTypeMandatory)
                                        {
                                            //changed by omkar 30/01/2020
                                            if (string.IsNullOrEmpty(strTDData))
                                            {
                                                //end of changed by omkar 30/01/2020
                                                result = "Estimation Type is blank";
                                                if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                {
                                                    MappedTable.Rows[index]["Error Message"] = result;
                                                }
                                                else
                                                {
                                                    MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                }
                                            }
                                            else
                                            {
                                                bool isEstimationTypeValid = false;
                                                /*Added by chandrashekhar salagar for validation of resource*/
                                                DataTable EstimationType = dsProjectSettings.Tables[11];
                                                for (int k = 0; k < EstimationType.Rows.Count; k++)
                                                {
                                                    string EstimationTypeName = EstimationType.Rows[k]["EstimationTypeName"].ToString();
                                                    if (EstimationTypeName.ToLower() == strTDData.ToLower())
                                                    {
                                                        isEstimationTypeValid = true;
                                                        break;
                                                    }
                                                }
                                                if (isEstimationTypeValid)
                                                {
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                }
                                                else
                                                {
                                                    //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                    //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    result = "Estimation Type " + strTDData + " is invalid";
                                                    //Added by Dipali V On 11th Feb 2020 For Validation MSG should common seprated
                                                    if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    //if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    //End of Added by Dipali V On 11th Feb 2020 For Validation MSG should common seprated
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = result;
                                                    }
                                                    else
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                    }
                                                }
                                            }
                                        }
                                        else
                                        {
                                            if (strTDData.Length > 0)
                                            {
                                                bool isEstimationTypeValid = false;
                                                /*Added by chandrashekhar salagar for validation of resource*/
                                                DataTable EstimationType = dsProjectSettings.Tables[11];
                                                for (int k = 0; k < EstimationType.Rows.Count; k++)
                                                {
                                                    string EstimationTypeName = EstimationType.Rows[k]["EstimationTypeName"].ToString();
                                                    if (EstimationTypeName.ToLower() == strTDData.ToLower())
                                                    {
                                                        isEstimationTypeValid = true;
                                                        break;
                                                    }
                                                }
                                                if (isEstimationTypeValid)
                                                {
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                }
                                                else
                                                {
                                                    //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                    //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    result = "Estimation Type " + strTDData + " is invalid";
                                                    //Added by Dipali V On 11th Feb 2020 For Validation MSG should common seprated
                                                    if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    //if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    {

                                                        //End of Added by Dipali V On 11th Feb 2020 For Validation MSG should common seprated
                                                        MappedTable.Rows[index]["Error Message"] = result;
                                                    }
                                                    else
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                    }
                                                }
                                            }

                                        }
                                    }
                                    break;

                                case "Change Request":
                                    {
                                        var result = "";
                                        bool isChangeRequestMandatory = false;
                                        /*Added by chandrashekhar salagar for validation of resource*/
                                        DataTable ProjectSettings = dsProjectSettings.Tables[0];

                                        if (Convert.ToBoolean(ProjectSettings.Rows[0]["ShowChangeRequestInAT"]))
                                        {
                                            if (Convert.ToBoolean(ProjectSettings.Rows[0]["ChangeRequestMandatoryInAT"]))
                                            {
                                                isChangeRequestMandatory = true;
                                            }
                                            //isChangeRequestMandatory = true;
                                        }
                                        if (isChangeRequestMandatory)
                                        {
                                            if (string.IsNullOrEmpty(strTDData))
                                            {
                                                result = "Change Request is Blank";
                                                //MappedTable.Rows[index]["Error Message"] = result;
                                                if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                {
                                                    MappedTable.Rows[index]["Error Message"] = result;
                                                }
                                                else
                                                {
                                                    MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                }
                                            }
                                            else
                                            {
                                                bool isChangeRequestValid = false;
                                                /*Added by chandrashekhar salagar for validation of resource*/
                                                DataTable ChangeRequest = dsProjectSettings.Tables[4];
                                                for (int k = 0; k < ChangeRequest.Rows.Count; k++)
                                                {
                                                    string ChangeRequestSummary = ChangeRequest.Rows[k]["ChangeRequestSummary"].ToString();
                                                    if (ChangeRequestSummary.ToLower() == strTDData.ToLower())
                                                    {
                                                        isChangeRequestValid = true;
                                                        break;
                                                    }
                                                }
                                                if (isChangeRequestValid)
                                                {
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                }
                                                else
                                                {
                                                    //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                    //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    result = "Change Request " + strTDData + " is invalid";
                                                    //Added by Dipali V On 11th Feb 2020 For Validation MSG should common seprated
                                                    if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    //if (!string.IsNullOrEmpty(MappedTabtnStepTwoble.Rows[index]["Error Message"].ToString()))
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = result;
                                                    }
                                                    else
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                    }
                                                }
                                            }
                                        }
                                        else
                                        {
                                            if (strTDData.Length > 0)
                                            {
                                                bool isChangeRequestValid = false;
                                                /*Added by chandrashekhar salagar for validation of resource*/
                                                DataTable ChangeRequest = dsProjectSettings.Tables[4];
                                                for (int k = 0; k < ChangeRequest.Rows.Count; k++)
                                                {
                                                    string ChangeRequestSummary = ChangeRequest.Rows[k]["ChangeRequestSummary"].ToString();
                                                    if (ChangeRequestSummary.ToLower() == strTDData.ToLower())
                                                    {
                                                        isChangeRequestValid = true;
                                                        break;
                                                    }
                                                }
                                                if (isChangeRequestValid)
                                                {
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                }
                                                else
                                                {
                                                    //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                    //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    result = "Change Request " + strTDData + " is invalid";
                                                    //Added by Dipali V On 11th Feb 2020 For Validation MSG should common seprated
                                                    if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    //if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = result;
                                                    }
                                                    else
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                    }
                                                }

                                            }

                                        }

                                    }
                                    break;

                                case "Release":
                                    {
                                        MappedTable.Rows[index][strFieldName] = strTDData;
                                    }
                                    break;

                                case "Story Point":
                                {
                                    if (!string.IsNullOrEmpty(strTDData))
                                    {

                                        //if (strTDData.All(char.IsDigit))

                                        //if (Char.IsNumber(Convert.ToChar(strTDData)))
                                        //Added By Dipali V on 26th Feb 2020 For Check Story points int or string
                                        double Num;
                                        bool isNum = double.TryParse(strTDData, out Num);
                                        //End of Added By Dipali V on 26th Feb 2020 For Check Story points int or string
                                        if (isNum)
                                        //if (strTDData.isNumeric)
                                        {
                                            if (UsertStory == "")
                                            {
                                                UsertStory = null;
                                            }
                                            else
                                            {
                                                UsertStory = UsertStory;
                                            }
                                            string sql = "usp_Whizible2_Validate_WBS_ProjectTasks " + assigntaskinbulk[0].projectId + ",' ', ' ',' ',' ', ' ',' ',' ',' ',' ',' ',' ',' ','" + UsertStory + "','" + strTDData + " ' ";
                                            var result = CommonFunctions.Data.GetDataScalar(sql, true, CommonController.connectionString);
                                            if (result == null)
                                            {
                                                MappedTable.Rows[index][strFieldName] = strTDData;
                                            }
                                            else
                                            {
                                                //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                MappedTable.Rows[index][strFieldName] = strTDData;
                                                //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()) && !(MappedTable.Rows[index]["Error Message"].ToString().Contains(result.ToString())))
                                                //if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                {

                                                    MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + result;
                                                }
                                                else if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                {
                                                    // MappedTable.Rows[index]["Error Message"] = result;
                                                    MappedTable.Rows[index]["Error Message"] = result;
                                                }
                                                else
                                                {
                                                    MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + result;
                                                }

                                            }
                                        }

                                        else
                                        {
                                            MappedTable.Rows[index][strFieldName] = strTDData;
                                            //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                            if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()) && !(MappedTable.Rows[index]["Error Message"].ToString().Contains("Story Point should be numeric".ToString())))
                                            {
                                                MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + "Story Point should be numeric";
                                            }
                                            else
                                            {
                                                MappedTable.Rows[index]["Error Message"] = "Story Point should be numeric";
                                            }

                                        }
                                    }
                                }
                                    break;
                                //Commented and added by Chetan M on 11th Feb 2020 for IssueID = 21827
                                //case "Bilable":
                                case "Billable":
                                    //End of Commented and added by Chetan M on 11th Feb 2020 for IssueID = 21827
                                    {
                                        MappedTable.Rows[index][strFieldName] = strTDData;
                                    }
                                    break;


                                case "Deliverable":
                                    {

                                        bool isDeliverable = false;
                                        /*Added by chandrashekhar salagar for validation of resource*/
                                        DataTable deliverable = dsProjectSettings.Tables[3];
                                    for (int k = 0; k < deliverable.Rows.Count; k++)
                                    {
                                        string DeliverableName = deliverable.Rows[k]["Title"].ToString();
                                        if (DeliverableName.ToLower() == strTDData.ToLower())
                                        {
                                            isDeliverable = true;
                                            break;
                                        }
                                    }
                                    if (isDeliverable)
                                    {
                                        MappedTable.Rows[index][strFieldName] = strTDData;
                                        
                                    }
                                    else
                                    {
                                        //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                        MappedTable.Rows[index][strFieldName] = strTDData;
                                        if (!string.IsNullOrEmpty(strTDData.ToString()) && !string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                        {
                                            MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + "Deliverable " + strTDData + " not associated with project";
                                            // MappedTable.Rows[index]["Error Message"] = "Deliverable is not associated with project";
                                        }
                                        //else
                                        //{
                                        //    MappedTable.Rows[index]["Error Message"] = "Deliverable is not associated with project";
                                        //}
                                       
                                    }
                                      
                                    }
                                    break;


                                case "Sprint":
                                    {
                                        string result = "";
                                        bool isValidSprint = false;
                                        /*Added by chandrashekhar salagar for validation of resource*/
                                        DataTable Sprint = dsProjectSettings.Tables[12];
                                        for (int k = 0; k < Sprint.Rows.Count; k++)
                                        {
                                            string SprintName = Sprint.Rows[k]["IterationName"].ToString();
                                            if (SprintName.ToLower() == strTDData.ToLower())
                                            {
                                                isValidSprint = true;
                                                break;
                                            }
                                        }
                                        if (isValidSprint)
                                        {
                                            MappedTable.Rows[index][strFieldName] = strTDData;
                                        }
                                        else
                                        {
                                            //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                            MappedTable.Rows[index][strFieldName] = strTDData;
                                            //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                            result = "Sprint " + strTDData + " is invalid";
                                            if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                            {
                                                MappedTable.Rows[index]["Error Message"] = result;
                                            }
                                            else
                                            {
                                                MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                            }
                                        }
                                    }
                                    break;


                                case "Phase":
                                    {

                                        var result = "";
                                        bool isPhaseRequestMandatory = false;
                                        /*Added by chandrashekhar salagar for validation of resource*/
                                        DataTable ProjectSettings = dsProjectSettings.Tables[0];

                                        if (Convert.ToBoolean(ProjectSettings.Rows[0]["ShowPhaseInAT"]))
                                        {
                                            if (Convert.ToBoolean(ProjectSettings.Rows[0]["PhaseMandatoryInAT"]))
                                            {
                                                isPhaseRequestMandatory = true;
                                            }
                                            // isPhaseRequestMandatory = true;
                                        }
                                        if (isPhaseRequestMandatory)
                                        {
                                            //add and commented by omkar 30/01/2020
                                            if (string.IsNullOrEmpty(strTDData))

                                            //end of add and commented by omkar 30/01/2020
                                            {
                                                result = "Phase is blank";
                                                if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                {
                                                    MappedTable.Rows[index]["Error Message"] = result;
                                                }
                                                else
                                                {
                                                    MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                }
                                            }
                                            else
                                            {
                                                bool isPhaseValid = false;
                                                /*Added by chandrashekhar salagar for validation of resource*/
                                                DataTable Phase = dsProjectSettings.Tables[6];
                                                for (int k = 0; k < Phase.Rows.Count; k++)
                                                {
                                                    string PhaseName = Phase.Rows[k]["Phase"].ToString();
                                                    if (PhaseName.ToLower() == strTDData.ToLower())
                                                    {
                                                        isPhaseValid = true;
                                                        break;
                                                    }
                                                }
                                                if (isPhaseValid)
                                                {
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                }
                                                else
                                                {
                                                    //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                    //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    result = "Phase " + strTDData + " is invalid";
                                                    //Added by Dipali V On 11th Feb 2020 For Validation MSG should common seprated
                                                    if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    //if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = result;
                                                    }
                                                    else
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                    }
                                                }
                                            }
                                        }
                                        else
                                        {
                                            if (strTDData.Length > 0)
                                            {
                                                bool isPhaseValid = false;
                                                /*Added by chandrashekhar salagar for validation of resource*/
                                                DataTable Phase = dsProjectSettings.Tables[6];
                                                for (int k = 0; k < Phase.Rows.Count; k++)
                                                {
                                                    string PhaseName = Phase.Rows[k]["Phase"].ToString();
                                                    if (PhaseName.ToLower() == strTDData.ToLower())
                                                    {
                                                        isPhaseValid = true;
                                                        break;
                                                    }
                                                }
                                                if (isPhaseValid)
                                                {
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                }
                                                else
                                                {
                                                    //Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    MappedTable.Rows[index][strFieldName] = strTDData;
                                                    //End of Added by Dipali V On 11th Feb 2020 For mapped Column values should display
                                                    result = "Phase " + strTDData + " is invalid";
                                                    //Added by Dipali V On 11th Feb 2020 For Validation MSG should common seprated
                                                    if (string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    //if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()))
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = result;
                                                    }
                                                    else
                                                    {
                                                        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"].ToString() + " , " + result;
                                                    }
                                                }

                                            }
                                        }

                                        #region[SingleSpValidation]
                                        //string sql = "usp_Whizible2_Validate_WBS_ProjectTasks " + assigntaskinbulk[0].projectId + ",' ', ' ',' ',' ', ' ',' ',' ',' ',' ',' ',' ','" + strTDData + "',' ' ";
                                        //var result = CommonFunctions.Data.GetDataScalar(sql, true, CommonController.connectionString);
                                        //if (result == null)
                                        //{
                                        //    MappedTable.Rows[index][strFieldName] = strTDData;
                                        //}
                                        //else
                                        //{
                                        //    if (!string.IsNullOrEmpty(MappedTable.Rows[index]["Error Message"].ToString()) && !(MappedTable.Rows[index]["Error Message"].ToString().Contains(result.ToString())))
                                        //    {
                                        //        MappedTable.Rows[index]["Error Message"] = MappedTable.Rows[index]["Error Message"] + " , " + result;
                                        //    }
                                        //    else
                                        //    {
                                        //        MappedTable.Rows[index]["Error Message"] = result;
                                        //    }

                                        //}
                                        #endregion
                                    }
                                    break;


                                default:
                                    if (strFieldName != null)
                                    {
                                        MappedTable.Rows[index][strFieldName] = strTDData;
                                    }
                                    break;
                            }
                        }
                    //}
                }
                //var Rowcount = MappedTable.Rows.Count - 1;
                validRecords = MappedTable.AsEnumerable().Where(x => x["Error Message"].ToString() != string.Empty).ToList().Count;
                inValidRecords = MappedTable.Rows.Count - validRecords;
                var columncount = MappedTable.Columns.Count;
                MappedTable.Columns["Error Message"].SetOrdinal(columncount - 1);
                //MappedTable.Rows[0]["ValidRecords"] = validRecords;
                //MappedTable.Rows[0]["InvalidRecords"] = inValidRecords;
            }
            catch (Exception ex)
            {
            }

            return MappedTable;


        }

        #region[UploadTasks]
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object UploadTasks([FromBody] TaskUploadViewModel taskuploadviewmodel)
        {
            try
            {
                string Message = "";
                var ProjectID = HttpUtility.UrlDecode(taskuploadviewmodel.ProjectID);
                var CreatedBy = HttpUtility.UrlDecode(taskuploadviewmodel.CreatedBy);

                foreach (var item in taskuploadviewmodel.lisFileUploadParameters)
                {
                    //Added & Commented By Dipali V on 4th march 2020 for Efforts
                    //string[] splittedTime = item.Work.Split(':');
                    //string Hours = "";
                    //if (splittedTime.Length > 1)
                    //{
                    //    Hours = splittedTime[0] + '.' + splittedTime[1];
                    //}
                    //else
                    //{
                    //    Hours = splittedTime[0];
                    //}
                    //var timeSpan = TimeSpan.FromHours(Convert.ToDouble(Hours));
                    //int hh = timeSpan.Hours;
                    //int mm = timeSpan.Minutes;
                    //string Work = hh + "." + mm;

                    string Work = item.Work.ToString();
                    //End of Added & Commented By Dipali V on 4th march 2020 for Efforts

                    //Added by Chetan M on 10th Feb 2020 for IssueID = 21827
                    if (item.Billable == "Yes")
                    {
                        item.Billable = "1";
                    }
                    else
                    {
                        item.Billable = "0";
                    }
                    //End of added by Chetan M on 10th Feb 2020 for IssueID = 21827

                    string WhichTask = "O";
                    string sql = "usp_Whizible2_Ins_tbl_PM_ProjectTasks_WBS " + "' '" + ","
                                                                            + ProjectID + ",'"
                                                                            + HttpUtility.UrlDecode(item.TaskName) + "','"
                                                                            + HttpUtility.UrlDecode(item.StartDate) + "','"
                                                                            + HttpUtility.UrlDecode(item.EndDate) + "','"
                                                                            + HttpUtility.UrlDecode(Work) + "','"
                                                                            + HttpUtility.UrlDecode(WhichTask) + "',"
                                                                            //Commented and added by Chetan M on 10th Feb 2020 for IssueID = 21827
                                                                            //+ 0 + ",'"
                                                                            + HttpUtility.UrlDecode(item.Billable) + ",'"
                                                                            //End of Commented and added by Chetan M on 10th Feb 2020 for IssueID = 21827
                                                                            + HttpUtility.UrlDecode(item.TaskNotes) + "','"
                                                                            + HttpUtility.UrlDecode(item.TaskType) + "','"
                                                                            + HttpUtility.UrlDecode(item.StartDate) + "','"
                                                                            + HttpUtility.UrlDecode(item.EndDate) + "','"
                                                                            //Commented and added by imran on 23-12-2021 insert baselinework
                                                                            //+ "" + "','"
                                                                            + HttpUtility.UrlDecode(Work) + "','"  // baselinework
                                                                                                                   //End comment by imran on 23-12-2021

                                                                            + HttpUtility.UrlDecode(item.Priority) + "','"
                                                                            + HttpUtility.UrlDecode(item.Phase) + "','"
                                                                            + HttpUtility.UrlDecode(item.Module) + "','"
                                                                            + HttpUtility.UrlDecode(item.SubProject) + "','"
                                                                            + item.Milestone + "',"
                                                                            + "' '" + ",'"
                                                                            + HttpUtility.UrlDecode(item.ChangeRequest) + "','"
                                                                            + HttpUtility.UrlDecode(item.Feature) + "','"
                                                                            + HttpUtility.UrlDecode(item.EstimationType) + "','"
                                                                            + HttpUtility.UrlDecode(item.Deliverable) + "','"
                                                                            + HttpUtility.UrlDecode(item.UserStory) + "',"
                                                                            + "' '" + ","
                                                                            + "' '" + ","
                                                                            + "' '" + ","
                                                                            + "' '" + ","
                                                                            + "' '" + ",'"
                                                                            + CreatedBy + "','"
                                                                            + 0 + "',"
                                                                            + "' '" + ","
                                                                            + "' '" + ",'"
                                                                            + HttpUtility.UrlDecode(item.Resources) + "'";

                    try
                    {

                        var result = CommonFunctions.Data.GetDataScalar(sql, true, CommonController.connectionString);
                    }
                    catch (Exception ex)
                    {

                    }

                }


                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        /// <summary>
        /// Created Date    :   22-08-2019
        /// Purpose         :   ExportDocument
        /// Author          :   Chandashekhar Salar=gar.
        /// </summary>
        /// <param name="pm_Wbs_Card"></param>
        /// <returns></returns>
        public object ExportDocument([FromBody] PM_wbs_card pm_Wbs_Card)
        {
            try
            {
                string strSQL;
                string strFilePath;
                string m_strFileName;
                long m_lngReportID;
                int DateFormatID = 0;
                string CompanyName = "";
                string ReportFormat = pm_Wbs_Card.ReportFormat;
                string employeeID = "NULL", taskTypeID = "NULL", startDate = "NULL", endDate = "NULL";
                if (!string.IsNullOrEmpty(pm_Wbs_Card.LoginID))
                    employeeID = HttpUtility.UrlDecode(pm_Wbs_Card.LoginID);
                if (pm_Wbs_Card.TaskTypeID > 0)
                    taskTypeID = pm_Wbs_Card.TaskTypeID.ToString();
                if (!string.IsNullOrEmpty(pm_Wbs_Card.StartDate))
                    startDate = "'" + HttpUtility.UrlDecode(pm_Wbs_Card.StartDate) + "'";
                if (!string.IsNullOrEmpty(pm_Wbs_Card.EndDate))
                    endDate = "'" + HttpUtility.UrlDecode(pm_Wbs_Card.EndDate) + "'";
                int lngDefaultLCID;
                int lngCurrentThreadUICultureID;
                lngDefaultLCID = 1033;
                lngCurrentThreadUICultureID = 1033;
                AdHocReports.Report.AdHocReport oRpt;
                //strSQL = "Usp_Whizible2_tbl_WBS_ProjectTaskStages_Report " + HttpUtility.UrlDecode(pm_Wbs_Card.ProjectID.ToString()) + ",'" + HttpUtility.UrlDecode(pm_Wbs_Card.IsActive) + "', " + HttpUtility.UrlDecode(pm_Wbs_Card.LoginID) + ",'" + HttpUtility.UrlDecode(pm_Wbs_Card.WhichTask) + "','" + HttpUtility.UrlDecode(pm_Wbs_Card.RoleAccess) + "'";
                strSQL = "Usp_Whizible2_tbl_WBS_ProjectTaskStages_Report " + HttpUtility.UrlDecode(pm_Wbs_Card.ProjectID.ToString()) + "," + HttpUtility.UrlDecode(pm_Wbs_Card.IsActive) + "," + employeeID + ",'" + HttpUtility.UrlDecode(pm_Wbs_Card.WhichTask) + "','" + HttpUtility.UrlDecode(pm_Wbs_Card.RoleAccess) + "'," + taskTypeID + "," + startDate + "," + endDate;

                IDataReader drCompInfo1 = CommonFunctions.Data.GetSQLDataReader(strSQL, CommonController.connectionString);
                if (drCompInfo1.Read() == false)
                {
                    return "";
                }
                m_lngReportID = 22274;
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
                    //Added & Commented By Dipali V On 20th Feb 2020 For Text Should be open in Doc file
                    //case "TEXT": m_strFileName += ".txt"; break;
                    case "TEXT": m_strFileName += ".doc"; break;
                    //End of Added & Commented By Dipali V On 20th Feb 2020 For Text Should be open in Doc file
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

            /// <summary>
            /// Created     Date    :   18-09-2019
            /// Purpose             :   Get Data Set for Multiple Validations based on project
            /// Author              :   Chandrashekhar Salagar
            /// </summary>
            /// <param name="ProjectID"></param>
            #region[GetProjectSettings]
            //Added by imran on 14-09-2022
            [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        public DataSet GetProjectSettings(int ProjectID)
        {
            string sql = "usp_Whizible2_Validate_WBS_Tasks " + ProjectID + " ";
            DataSet dsSettings = CommonFunctions.Data.GetDataSet(sql, "TeamMembers", 0, 0, true, CommonController.connectionString);
            return dsSettings;
        }
        #endregion

        [HttpPost]
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        //public ProjectSettings GetProjectConfiguration([FromBody] ProjectSettings projectsettings)
        public object GetProjectConfiguration([FromBody] ProjectSettings projectsettings)
        {
            try
            {
                ProjectSettings objprojectsettings = new ProjectSettings();
                DataSet ds = GetProjectSettings(Convert.ToInt32(HttpUtility.UrlDecode((projectsettings.ProjectID))));
                //Commented And Added By Usha Pandit On 02.09.2020 For DBNULL issue
                //objprojectsettings.isAgileProject = Convert.ToBoolean(ds.Tables[0].Rows[0]["IsAgileMethodFollowed"]);
                objprojectsettings.isAgileProject = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(ds.Tables[0].Rows[0]["IsAgileMethodFollowed"], "false"));
                //End Of Added By Usha Pandit On 02.09.2020 For DBNULL issue
                objprojectsettings.ShowPhaseInAt = Convert.ToBoolean(ds.Tables[0].Rows[0]["ShowPhaseInAt"]);
                objprojectsettings.PhaseMandatoryinAT = Convert.ToBoolean(ds.Tables[0].Rows[0]["PhaseMandatoryinAT"]);
                objprojectsettings.ShowModuleInAt = Convert.ToBoolean(ds.Tables[0].Rows[0]["ShowModuleInAt"]);
                objprojectsettings.ModuleMandatoryinAT = Convert.ToBoolean(ds.Tables[0].Rows[0]["ModuleMandatoryinAT"]);
                objprojectsettings.ShowSubProjectInAT = Convert.ToBoolean(ds.Tables[0].Rows[0]["ShowSubProjectInAT"]);
                objprojectsettings.SubProjectMandatoryInAT = Convert.ToBoolean(ds.Tables[0].Rows[0]["SubProjectMandatoryInAT"]);
                objprojectsettings.ShowMilestoneInAT = Convert.ToBoolean(ds.Tables[0].Rows[0]["ShowMilestoneInAT"]);
                objprojectsettings.MilestoneMandatoryInAT = Convert.ToBoolean(ds.Tables[0].Rows[0]["MilestoneMandatoryInAT"]);
                objprojectsettings.ShowChangeRequestInAT = Convert.ToBoolean(ds.Tables[0].Rows[0]["ShowChangeRequestInAT"]);
                objprojectsettings.ChangeRequestMandatoryInAT = Convert.ToBoolean(ds.Tables[0].Rows[0]["ChangeRequestMandatoryInAT"]);
                objprojectsettings.ShowFeatureInAT = Convert.ToBoolean(ds.Tables[0].Rows[0]["ShowFeatureInAT"]);
                objprojectsettings.FeatureMandatoryInAT = Convert.ToBoolean(ds.Tables[0].Rows[0]["FeatureMandatoryInAT"]);
                objprojectsettings.ShowEstimationTypeInAT = Convert.ToBoolean(ds.Tables[0].Rows[0]["ShowEstimationTypeInAT"]);
                objprojectsettings.EstimationTypeMandatoryInAT = Convert.ToBoolean(ds.Tables[0].Rows[0]["EstimationTypeMandatoryInAT"]);
                return objprojectsettings;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        /// Created Date        :       23 Sept 2019
        /// Purpose             :       Delete task card from list
        /// Author              :       Chanardashekhar Salagar
        /// </summary>
        /// <param name="deleteStage"></param>
        /// <returns></returns>
        #region
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object DeleteTask([FromBody] PM_wbs_card deleteTask)
        {
            try
            {
                string Message;
                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                                (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Del_tbl_WBS_ProjectTask  "
                                                                                     + HttpUtility.UrlDecode(deleteTask.TaskID.ToString()) + ",'"
                                                                                     + HttpUtility.UrlDecode(deleteTask.EmployeeName) + "',"
                                                                                     //Added by Chetan M on 7th Feb 2020 for IssueID = 21651
                                                                                     + HttpUtility.UrlDecode(Convert.ToString(deleteTask.EmployeeID)) + ",'"
                                                                                     //Added by Dipali V On 18th Feb 2020 For Void Task
                                                                                     + HttpUtility.UrlDecode(Convert.ToString(deleteTask.IsVoid)) + "'",
                                                                                     //End of Added by Dipali V On 18th Feb 2020 For Void Task
                                                                                     true, CommonController.connectionString
                                                                                     ), ""));

                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion



        #region  added by Vishal Mahajan 08-01-2020
        [HttpPost]
        [Authorize]

        public object GetPriorities()
        //public DataTable GetPriorities([FromBody]int ProjectID)

        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Priorities";

                DataTable result = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        // public List<Resources> GetResources([FromBody]MilestoneParameter Parameters)
        public object GetResources([FromBody] MilestoneParameter Parameters)
        {
            try
            {
                string strSQL = "";
                if (Parameters.TaskID > 0)
                {
                    strSQL = "Exec usp_Sel_teammembers " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.TaskID));
                }
                else
                {
                    strSQL = "Exec usp_Sel_CurrentTeamMembers " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));
                }

                DataTable ResourceListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                List<Resources> ResourceLists = new List<Resources>();
                List<ResourcesExpectedDate> ResourcesExpectedDates = new List<ResourcesExpectedDate>();
                foreach (DataRow ResourceRow in ResourceListTable.Rows)
                {
                    Resources ResourceListQuery = new Resources()
                    {
                        EmployeeId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ResourceRow["EmployeeId"], "0")),
                        EmployeeName = CommonFunctions.Data.CheckIsDBNull(ResourceRow["UserName"], "").ToString(),
                    };
                    ResourceLists.Add(ResourceListQuery);
                }

                string resourceSql = "Exec usp_Sel_CurrentTeamMembers_ExpectedDate " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",0";
                DataTable ResourceStartDateListTable = CommonFunctions.Data.GetDataTable(resourceSql, true, CommonController.connectionString);
                foreach (DataRow ResourceRow in ResourceStartDateListTable.Rows)
                {
                    ResourcesExpectedDate ResourcesExpectedDateQuery = new ResourcesExpectedDate()
                    {
                        EmployeeId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ResourceRow["EmployeeId"], "0")),
                        ExpectedStartDate = CommonFunctions.Data.CheckIsDBNull(ResourceRow["ExpectedStartDate"], "").ToString(),
                    };
                    ResourcesExpectedDates.Add(ResourcesExpectedDateQuery);
                }


                resourceSql = "Exec usp_Sel_CurrentTeamMembers_ExpectedDate " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",1";
                string endDate = "";
                int employeeId = 0;
                DataTable ResourceEndDateListTable = CommonFunctions.Data.GetDataTable(resourceSql, true, CommonController.connectionString);
                foreach (DataRow ResourceRow in ResourceEndDateListTable.Rows)
                {
                    employeeId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ResourceRow["EmployeeId"], "0"));
                    endDate = CommonFunctions.Data.CheckIsDBNull(ResourceRow["ExpectedEndDate"], "").ToString();
                    ResourcesExpectedDate item = ResourcesExpectedDates.Where(x => x.EmployeeId == employeeId).FirstOrDefault();
                    if (item != null)
                    {
                        item.ExpectedEndDate = endDate;
                    }
                }
                foreach (Resources item in ResourceLists)
                {
                    ResourcesExpectedDate ResourcesExpectedDate = new ResourcesExpectedDate();
                    ResourcesExpectedDate = ResourcesExpectedDates.Where(x => x.EmployeeId == item.EmployeeId).FirstOrDefault();
                    if (ResourcesExpectedDate != null)
                    {
                        item.ResourcesExpectedDates = ResourcesExpectedDate;
                    }
                }
                return ResourceLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        [HttpPost]
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        //public List<TaskTypeClass> GetTaskTypes([FromBody]PMChangeRequestParameter Parameters)
        public object GetTaskTypes([FromBody] PMChangeRequestParameter Parameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Project_TaskTypes_Names " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));

                List<TaskTypeClass> TaskTypes = new List<TaskTypeClass>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    TaskTypeClass ObjTaskTypeClass = new TaskTypeClass()
                    {
                        TaskTypeID = sdr["TaskTypeID"].ToString(),
                        TaskType = sdr["TaskType"].ToString(),
                    };
                    TaskTypes.Add(ObjTaskTypeClass);
                }

                return TaskTypes;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        //public List<GetChangeRequestDetails> GetChangeRequestDetails([FromBody]PMChangeRequestParameter Parameters)
        public object GetChangeRequestDetails([FromBody] PMChangeRequestParameter Parameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ChangeRequest_Master " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));

                DataTable ChangeRequestListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<GetChangeRequestDetails> ChangeRequestLists = new List<GetChangeRequestDetails>();

                foreach (DataRow ChangeRequestList in ChangeRequestListTable.Rows)
                {
                    GetChangeRequestDetails ChangeRequestListQuery = new GetChangeRequestDetails()
                    {
                        ChangeRequestID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ChangeRequestList["ChangeRequestID"], "0")),
                        ChangeRequestSummary = CommonFunctions.Data.CheckIsDBNull(ChangeRequestList["ChangeRequestSummary"], "").ToString(),
                    };
                    ChangeRequestLists.Add(ChangeRequestListQuery);
                }
                return ChangeRequestLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        //public List<Project_Phases> GetProjectPhases([FromBody]PM_wbs_card_parameters Parameters)
        public object GetProjectPhases([FromBody] PM_wbs_card_parameters Parameters)
        {
            try
            {
                List<Project_Phases> listPhase = new List<Project_Phases>();
                string strSQL = "Exec usp_PRS_GetProjectPhasesForSQA " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));

                DataTable Project_PhasesTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                foreach (DataRow drProject_Phases in Project_PhasesTable.Rows)
                {
                    Project_Phases project_Phases = new Project_Phases()
                    {
                        ProjectPhaseID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drProject_Phases["ProjectPhaseID"], "")),
                        Phase = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProject_Phases["Phase"], "")),
                    };
                    listPhase.Add(project_Phases);
                }

                return listPhase;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Get Milestone Details
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        // public List<Milestones> GetMilestones([FromBody]MilestoneParameter Parameters)
        public object GetMilestones([FromBody] MilestoneParameter Parameters)
        {
            try
            {
                string strSQL = "";
                if (Parameters.TaskID > 0)
                    strSQL = "Exec usp_Sel_tbl_PM_Milestones " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",'T'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.TaskID));
                else
                    strSQL = "Exec usp_Sel_tbl_PM_Milestones " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",'T',NULL";

                DataTable MilestoneListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<Milestones> MilestoneLists = new List<Milestones>();

                foreach (DataRow MilestoneList in MilestoneListTable.Rows)
                {
                    Milestones MilestoneListQuery = new Milestones()
                    {
                        MilestoneID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(MilestoneList["MilestoneID"], "0")),
                        Milestone = CommonFunctions.Data.CheckIsDBNull(MilestoneList["Milestone"], "").ToString(),
                    };
                    MilestoneLists.Add(MilestoneListQuery);
                }
                return MilestoneLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        //public List<Deliverables> GetProjectDeliverables([FromBody]PM_wbs_card_parameters Parameters)
        public object GetProjectDeliverables([FromBody] PM_wbs_card_parameters Parameters)
        {
            try
            {
                List<Deliverables> listDeliverable = new List<Deliverables>();
                string strSQL = "Exec usp_Whizible2_Sel_OtherSchedule_ForGantt " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));

                DataTable ProjectDeliverableTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                foreach (DataRow drProjectDeliverable in ProjectDeliverableTable.Rows)
                {
                    Deliverables project_Phases = new Deliverables()
                    {
                        ScheduleID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drProjectDeliverable["ScheduleID"], "")),
                        Title = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectDeliverable["Title"], "")),
                    };
                    listDeliverable.Add(project_Phases);
                }

                return listDeliverable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get User Story 
        //Commented And Added By Usha Pandit On 12.12.2020 For passing Task Id for getting correct user stories
        //[Authorize]
        //[HttpPost]
        //public List<UserStory> GetUserStories([FromBody]PMUserStoryParameter Parameters)
        //{
        //    string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ScrumUserStory " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));

        //    DataTable UserStoryListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

        //    List<UserStory> UserStoryLists = new List<UserStory>();

        //    foreach (DataRow UserStoryList in UserStoryListTable.Rows)
        //    {
        //        UserStory UserStoryListQuery = new UserStory()
        //        {
        //            UserStoryID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(UserStoryList["UserStoryID"], "0")),
        //            UserStoryName = CommonFunctions.Data.CheckIsDBNull(UserStoryList["UserStoryName"], "").ToString(),
        //        };
        //        UserStoryLists.Add(UserStoryListQuery);
        //    }
        //    return UserStoryLists;
        //}
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        // public List<UserStory> GetUserStories([FromBody]PM_wbs_card_parameters Parameters)
        public object GetUserStories([FromBody] PM_wbs_card_parameters Parameters)
        {
            try
            {
                string strSQL = "";
                if (Parameters.TaskID == "")
                {
                    strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ScrumUserStory " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID))
                    + ", NULL";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ScrumUserStory " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID))
                     + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TaskID));
                }

                DataTable UserStoryListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<UserStory> UserStoryLists = new List<UserStory>();

                foreach (DataRow UserStoryList in UserStoryListTable.Rows)
                {
                    UserStory UserStoryListQuery = new UserStory()
                    {
                        UserStoryID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(UserStoryList["UserStoryID"], "0")),
                        UserStoryName = CommonFunctions.Data.CheckIsDBNull(UserStoryList["UserStoryName"], "").ToString(),
                    };
                    UserStoryLists.Add(UserStoryListQuery);
                }
                return UserStoryLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End Of Added By Usha Pandit On 12.12.2020 For passing Task Id for getting correct user stories
        //Get Project Modules

        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        // public List<Modules> GetProjectModules([FromBody]ModuleParameter Parameters)
        public object GetProjectModules([FromBody] ModuleParameter Parameters)
        {
            try
            {
                string strSQL = "";
                if (Parameters.TaskID > 0)
                    strSQL = "Exec usp_Sel_tbl_PM_Module " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ModuleID)) + ", 'A'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.TaskID));
                else
                    strSQL = "Exec usp_Sel_tbl_PM_Module " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ", NULL, 'A',NULL";

                DataTable ModuleListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<Modules> ModuleLists = new List<Modules>();

                foreach (DataRow ModuleList in ModuleListTable.Rows)
                {
                    Modules ModuleListQuery = new Modules()
                    {
                        ModuleID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ModuleList["ModuleID"], "0")),
                        ModuleName = CommonFunctions.Data.CheckIsDBNull(ModuleList["ModuleName"], "").ToString(),
                    };
                    ModuleLists.Add(ModuleListQuery);
                }
                return ModuleLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Get Sub Project Details
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        // public List<GetSubProjectDetails> GetSubProjects([FromBody]SubProjectParameter Parameters)
        public object GetSubProjects([FromBody] SubProjectParameter Parameters)
        {
            try
            {
                string strSQL = "";
                if (Parameters.TaskID > 0)
                    strSQL = "Exec usp_Sel_tbl_PM_SubProject " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",NULL,'T'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.TaskID));
                else
                    strSQL = "Exec usp_Sel_tbl_PM_SubProject " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ", NULL, 'T',NULL";

                DataTable SubProjectListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<GetSubProjectDetails> SubProjectLists = new List<GetSubProjectDetails>();

                foreach (DataRow SubProjectList in SubProjectListTable.Rows)
                {
                    GetSubProjectDetails SubProjectListQuery = new GetSubProjectDetails()
                    {
                        SubProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(SubProjectList["SubProjectID"], "0")),
                        SubProjectName = CommonFunctions.Data.CheckIsDBNull(SubProjectList["SubProjectName"], "").ToString(),
                    };
                    SubProjectLists.Add(SubProjectListQuery);
                }
                return SubProjectLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        //public PM_WBS_Task GetTaskAssignmentDetails([FromBody]PM_wbs_card_parameters Parameters)
        public object GetTaskAssignmentDetails([FromBody] PM_wbs_card_parameters Parameters)
        {
            try
            {
                string strSQL = "Exec usp_Sel_tbl_PM_ProjectTasks_TaskAssignment " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TaskID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));

                DataTable TaskAssignmentDetailsListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<PM_WBS_Task> TaskAssignmentLists = new List<PM_WBS_Task>();

                bool haveSubTaskTypes = false, applyEffortDistribution = false;
                string projectStartDate = "", projectEndDate = "";
                int ResourceValidation = 0;
                string strTaskCaseStructureQuery = "usp_sel_tbl_PM_Project_TaskCaseStructure " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));
                DataTable TaskCaseStructureTable = CommonFunctions.Data.GetDataTable(strTaskCaseStructureQuery, true, CommonController.connectionString);
                foreach (DataRow TaskCaseStructureRow in TaskCaseStructureTable.Rows)
                {
                    haveSubTaskTypes = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(TaskCaseStructureRow["HaveSubTaskTypes"], "0"));
                    applyEffortDistribution = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(TaskCaseStructureRow["ApplyEffortDistribution"], "0"));
                    projectStartDate = CommonFunctions.Data.CheckIsDBNull(TaskCaseStructureRow["ExpectedStartDate"], "").ToString();
                    projectEndDate = CommonFunctions.Data.CheckIsDBNull(TaskCaseStructureRow["ExpectedEndDate"], "").ToString();
                    ResourceValidation = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskCaseStructureRow["ResourceValidation"], "0"));
                }
                foreach (DataRow TaskAssignmentRow in TaskAssignmentDetailsListTable.Rows)
                {
                    PM_WBS_Task PM_WBS_Task = new PM_WBS_Task()
                    {
                        IsUserStoryTask = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["IsUserStoryTask"], "0")),
                        TaskID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["TaskID"], "0")),
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["ProjectID"], "0")),
                        EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["EmployeeID"], "0")),
                        EmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["UserName"], "")),
                        TaskName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["TaskName"], "")),
                        TaskNotes = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["TaskNotes"], "")),
                        WhichTask = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["WhichTask"], "")),
                        IsActive = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["IsActive"], "0")),
                        IsTaskComplete = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["IsTaskComplete"], "0")),
                        BillableYN = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["BillableYN"], "0")),
                        Priority = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["Priority"], "")),
                        ModuleName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["ModuleName"], "")),
                        StartDate = Convert.ToDateTime(TaskAssignmentRow["StartDate"]).ToString("dd MMM yyyy"),
                        EndDate = Convert.ToDateTime(TaskAssignmentRow["EndDate"]).ToString("dd MMM yyyy"),
                        Duration = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["Duration"], "")),
                        WorkInHours = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["Work"], "")),
                        WorkHourMinute = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["WorkHourMinute"], "")),
                        ActualDuration = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["ActualDuration"], "")),
                        ActualWorkHourMinute = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["ActualWorkHourMinute"], "")),
                        BaselineWorkHourMinute = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["BaselineWorkHourMinute"], "")),
                        BaselineWork = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["BaselineWork"], "")),
                        ActualWork = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["ActualWork"], "")),
                        BaselineDuration = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["BaselineDuration"], "")),
                        ActualStartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["ActualStartDate"], "")) != "" ? Convert.ToDateTime(TaskAssignmentRow["ActualStartDate"]).ToString("dd MMM yyyy") : "",
                        //Commented And Added By Usha Pandit On 30.08.2020 For getting Actual End Date as DA max Entry date
                        //ActualEndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["ActualEndDate"], "")) != "" ? Convert.ToDateTime(TaskAssignmentRow["ActualEndDate"]).ToString("dd MMM yyyy") : "",
                        ActualEndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["DAMaxEntryDate"], "")) != "" ? Convert.ToDateTime(TaskAssignmentRow["DAMaxEntryDate"]).ToString("dd MMM yyyy") : "",
                        //End Of Added By Usha Pandit On 30.08.2020 For getting Actual End Date as DA max Entry date
                        BaselineStartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["BaselineStart"], "")) != "" ? Convert.ToDateTime(TaskAssignmentRow["BaselineStart"]).ToString("dd MMM yyyy") : "",
                        BaselineEndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["BaselineEnd"], "")) != "" ? Convert.ToDateTime(TaskAssignmentRow["BaselineEnd"]).ToString("dd MMM yyyy") : "",
                        LocationID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["LocationID"], "0")),
                        DepartmentID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["DepartmentID"], "0")),
                        GroupID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["GroupID"], "0")),
                        DeliverableID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["DeliverableID"], "0")),
                        DeliverableTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["DeliverableTypeID"], "0")),
                        SystemID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["SystemID"], "0")),
                        MPPTaskID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["MPPTaskID"], "0")),
                        MPPTask = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["MPPTask"], "")),
                        TaskTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["TaskTypeID"], "0")),
                        TaskOnHold = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["TaskOnHold"], "0")),
                        WBSID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["WBSID"], "0")),
                        Phase = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["Phase"], "")),
                        PhaseID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["PhaseID"], "0")),
                        Module = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["Module"], "")),
                        ModuleID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["ModuleID"], "0")),
                        SubProject = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["SubProject"], "")),
                        SubProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["SubProjectID"], "0")),
                        Milestone = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["Milestone"], "")),
                        MilestoneID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["MilestoneID"], "0")),
                        ChangeRequestID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["ChangeRequestID"], "0")),
                        ProjectFeatureID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["ProjectFeatureID"], "0")),
                        ProjectEstimationTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["ProjectEstimationTypeID"], "0")),
                        IsDeferredTask = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["IsDeferredTask"], "0")),
                        OtherTaskID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["OtherTaskID"], "0")),
                        MitigationPlanID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["MitigationPlanID"], "0")),
                        TrainingResourceID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["TrainingResourceID"], "0")),
                        TrainingID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["TrainingID"], "0")),
                        Void = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["ISACTIVE"], "0")),
                        ParentTaskID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["ParentTaskID"], "0")),
                        UserStoryID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["UserStoryID"], "0")),
                        //Added By Dipali V On 11th Feb 2020 For get StoryPoint value
                        StoryPoint = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskAssignmentRow["StoryPoint"], "0")),

                    };
                    string strQuery = "usp_sel_tbl_PM_ProjectTasks_SUM_ActualWork " + PM_WBS_Task.TaskID.ToString();

                    if (haveSubTaskTypes == false && applyEffortDistribution == false)
                    {
                        strQuery = "usp_sel_tbl_PM_ProjectTasks_SUM_ActualWork_TaskID " + PM_WBS_Task.TaskID.ToString();
                    }
                    PM_WBS_Task.ActualWork = Convert.ToString(CommonFunctions.Data.GetDataScalar(strQuery, true, CommonController.connectionString));
                    //Commented And Added By Usha Pandit On 29.08.2020 For handling NULL for Actual Work
                    //PM_WBS_Task.ActualWork = Convert.ToString(CommonFunctions.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + PM_WBS_Task.ActualWork + "',1)", true, CommonController.connectionString));
                    if (PM_WBS_Task.ActualWork == "")
                    {
                        PM_WBS_Task.ActualWork = Convert.ToString(CommonFunctions.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('0',1)", true, CommonController.connectionString));
                    }
                    else
                    {
                        string curActualWork = Convert.ToString(PM_WBS_Task.ActualWork);
                        PM_WBS_Task.ActualWork = Convert.ToString(CommonFunctions.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa(ISNULL('" + curActualWork + "', 0),1)", true, CommonController.connectionString));
                    }
                    //End Of Added By Usha Pandit On 29.08.2020 For handling NULL for Actual Work
                    PM_WBS_Task.TaskEndDate = Convert.ToString(CommonFunctions.Data.GetDataScalar("usp_sel_TaskEndDate_ChildTasks " + PM_WBS_Task.TaskID.ToString(), true, CommonController.connectionString));
                    PM_WBS_Task.TaskStartDate = Convert.ToString(CommonFunctions.Data.GetDataScalar("usp_sel_TaskStartDate_ChildTasks " + PM_WBS_Task.TaskID.ToString(), true, CommonController.connectionString));

                    DataTable drCompany = CommonFunctions.Data.GetDataTable("usp_sel_tbl_PM_CompanyInformation", true, CommonController.connectionString);
                    bool RestrictByMinHours = false;
                    foreach (DataRow CompanyRow in drCompany.Rows)
                    {
                        RestrictByMinHours = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(CompanyRow["RestrictByMinHours"], "0"));
                    }

                    double HoursPerDay = 0;
                    long WeekDays = 0;
                    strQuery = "Exec usp_Get_ProjectLocationWorkingHours_Days " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));
                    DataTable drWork = CommonFunctions.Data.GetDataTable(strQuery, true, CommonController.connectionString);
                    foreach (DataRow WorkRow in drWork.Rows)
                    {
                        HoursPerDay = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(WorkRow["WorkingHours"], "0"));
                        WeekDays = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(WorkRow["WorkingDays"], "0"));
                    }

                    double TotalAllocatedTaskLCE = 0, TotalLCE = 0;
                    //Added By Dipali V On 3th march 2020 For Get Assigned Task hours of particular projects 
                    //strQuery = "EXEC usp_Sel_PM_DepartmentBalanceLCE " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ", NULL";
                    strQuery = "EXEC usp_Whizible2_Sel_PM_DepartmentBalanceLCETaskCard " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ", NULL";
                    //End of Added By Dipali V On 3th march 2020 For Get Assigned Task hours of particular projects 
                    DataTable drAllocatedTask = CommonFunctions.Data.GetDataTable(strQuery, true, CommonController.connectionString);
                    foreach (DataRow AllocatedRow in drAllocatedTask.Rows)
                    {
                        TotalAllocatedTaskLCE = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(AllocatedRow["AllocatedLCETotal"], "0"));
                        TotalLCE = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(AllocatedRow["LCETotal"], "0"));
                    }


                    string ResourceStartDate = "", ResourceEndDate = "";
                    strQuery = "EXEC usp_Whizible2_Sel_ProjectEmployeeRole_Use_N_ExpectedDates " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));
                    DataTable drResource = CommonFunctions.Data.GetDataTable(strQuery, true, CommonController.connectionString);
                    foreach (DataRow ResourceRow in drResource.Rows)
                    {
                        var EmpID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ResourceRow["EmployeeID"], "0"));
                        if (EmpID == PM_WBS_Task.EmployeeID)
                        {
                            ResourceStartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(ResourceRow["ExpectedStartDate"], ""));
                            ResourceEndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(ResourceRow["ExpectedEndDate"], ""));
                            break;
                        }
                    }

                    //        m_strHolidays = ""
                    //strQuery = "EXEC usp_Sel_tbl_PM_Location_Holiday " & m_lngProjectLocationID.ToString()
                    //drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                    //If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                    //    While drWork.Read()
                    //        strTemp = drWork.Item("HolidayDate").ToString()
                    //        If strTemp<> "" Then
                    //           m_strHolidays &= CommonFunctions.Dates.GetDate(CType(strTemp, Date)) & ","
                    //        End If
                    //    End While
                    //End If
                    PM_WBS_Task.ResourceValidation = ResourceValidation;
                    PM_WBS_Task.ResourceStartDate = ResourceStartDate;
                    PM_WBS_Task.ResourceEndDate = ResourceEndDate;
                    PM_WBS_Task.RestrictByMinHours = RestrictByMinHours;
                    PM_WBS_Task.ProjectStartDate = projectStartDate;
                    PM_WBS_Task.ProjectEndDate = projectEndDate;
                    PM_WBS_Task.HaveSubTaskTypes = haveSubTaskTypes;
                    PM_WBS_Task.ApplyEffortDistribution = applyEffortDistribution;
                    PM_WBS_Task.HoursPerDay = HoursPerDay;
                    PM_WBS_Task.WeekDays = WeekDays;
                    PM_WBS_Task.TotalAllocatedTaskLCE = TotalAllocatedTaskLCE;
                    PM_WBS_Task.TotalLCE = TotalLCE;
                    TaskAssignmentLists.Add(PM_WBS_Task);
                }
                return TaskAssignmentLists.FirstOrDefault();
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        public object IsAgileMethodFollowed([FromBody] string projectID)
        {
            try
            {
                int result = 0;
                result = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull
                                              (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Sel_ProjectTypeInfo " + projectID
                                              , true, CommonController.connectionString)
                                              , "0"));
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        [HttpPost]
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        public object GetProjectDetails([FromBody] string projectID)
        {
            try
            {
                DataTable getProjectDetailsDT = new DataTable();
                getProjectDetailsDT = (CommonFunctions.Data.GetDataTable("usp_Sel_tbl_PRS_ProjectTypes NULL, " + projectID
                                              , true, CommonController.connectionString)
                                            );
                return getProjectDetailsDT;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        //public List<EstimationType> GetEstimationTypes([FromBody]string projectID)
        public object GetEstimationTypes([FromBody] string projectID)
        {
            try
            {
                DataTable getEstimationTypesDT = new DataTable();
                getEstimationTypesDT = (CommonFunctions.Data.GetDataTable("usp_Sel_tbl_PM_Project_EstimationTypes NULL, " + projectID
                                              , true, CommonController.connectionString)
                                            );
                List<EstimationType> EstimationTypesLists = new List<EstimationType>();
                foreach (DataRow EstimationDr in getEstimationTypesDT.Rows)
                {
                    EstimationType EstimationTypeQuery = new EstimationType()
                    {
                        ProjectEstimationTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(EstimationDr["ProjectEstimationTypeID"], "0")),
                        EstimationTypeName = CommonFunctions.Data.CheckIsDBNull(EstimationDr["EstimationTypeName"], "").ToString(),
                    };
                    EstimationTypesLists.Add(EstimationTypeQuery);
                }
                return EstimationTypesLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        // public List<Feature> GetFeatures([FromBody]string projectID)
        public object GetFeatures([FromBody] string projectID)
        {
            try
            {
                DataTable getFeaturesDT = new DataTable();
                getFeaturesDT = (CommonFunctions.Data.GetDataTable("usp_Sel_tbl_PM_Project_Features NULL, " + projectID
                                              , true, CommonController.connectionString)
                                            );
                List<Feature> FeatureLists = new List<Feature>();
                foreach (DataRow FeatureDr in getFeaturesDT.Rows)
                {
                    Feature EstimationTypeQuery = new Feature()
                    {
                        ProjectFeatureID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(FeatureDr["ProjectFeatureID"], "0")),
                        FeatureName = CommonFunctions.Data.CheckIsDBNull(FeatureDr["FeatureName"], "").ToString(),
                    };
                    FeatureLists.Add(EstimationTypeQuery);
                }
                return FeatureLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        #region [attachement document by Vishal Mahajan 09-01-2020]
        //get Documents List
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object GetDocumentsList([FromBody] PM_wbs_card_parameters Parameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ProjectDocuments " + HttpUtility.UrlDecode(Convert.ToString(Parameters.UniqueID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.RoleID));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //get  Document Category List
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object GetDocumnetCategoryList([FromBody] PM_wbs_card_parameters Parameters)
        {

            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_DocumentCategory_ForRole " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RoleID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //get Document sub Category List
        [Authorize]
        [HttpPost]
        public object GetDocumnetSubCategoryList([FromBody] Models.PM.Document AttachmentDocuments)
        {

            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_DocumentSubCategory " + HttpUtility.UrlDecode(Convert.ToString(AttachmentDocuments.Category)) + ", null ," + HttpUtility.UrlDecode(Convert.ToString(AttachmentDocuments.ProjectID));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

            public bool GetFileType()
        {
            bool fileUploadFlag = false;
            string MimeType = "";
            string strFileName = CommonFunctions.FileDirectory.GetUniqueFileName();
            if (HttpContext.Current.Request.Files.AllKeys.Any())
            {
                for (int filecount = 0; filecount < HttpContext.Current.Request.Files.Count; filecount++)
                {
                    Stream xmlStream = System.Web.HttpContext.Current.Request.Files[filecount].InputStream;
                    Stream txtStream = System.Web.HttpContext.Current.Request.Files[filecount].InputStream;
                    string filePath = System.Web.HttpContext.Current.Request.Files[filecount].FileName;
                    string filename = Path.GetFileName(filePath);
                    string ext = Path.GetExtension(filename);
                    ext = ext.Substring(1, ext.Length - 1);
                    string contenttype = String.Empty;
                    Stream checkStream = System.Web.HttpContext.Current.Request.Files[filecount].InputStream;
                    BinaryReader chkBinary = new BinaryReader(checkStream);
                    Byte[] chkbytes = chkBinary.ReadBytes(0x10);
                    string strListofTypes = ConfigurationManager.AppSettings["FileContentType"];
                    string magicNumber = BitConverter.ToString(chkbytes);
                    string magicCheck = magicNumber.Substring(0, 11);
                    magicNumber = magicNumber.Replace("-", " ");
                    magicCheck = magicCheck.Replace("-", " ");
                    XmlDocument xmlDoc = new XmlDocument();
                    string xmlPath = CommonFunctions.FileDirectory.CleanPath(System.IO.Directory.GetParent(System.IO.Directory.GetParent(System.AppDomain.CurrentDomain.BaseDirectory).FullName).FullName);
                    xmlDoc.Load(xmlPath + "MIMEType.xml");
                    XmlNodeList nodes = xmlDoc.DocumentElement.SelectNodes("/MIMETYPE/MIME");
                    string xMagicNumber = "";
                    for (int i = 0; i < nodes.Count; i++)
                    {
                        xMagicNumber = nodes[i].SelectSingleNode("MagicNumber").InnerText;
                        int strlength = xMagicNumber.Length;

                        if (xMagicNumber.IndexOf(magicCheck) != -1 || magicCheck.IndexOf(xMagicNumber) != -1)
                        {
                            MimeType = nodes[i].SelectSingleNode("ContentType").InnerText;
                            fileUploadFlag = true;
                            break;
                        }
                        else
                        {
                            if (ext == xMagicNumber)
                            {
                                MimeType = nodes[i].SelectSingleNode("ContentType").InnerText;
                                fileUploadFlag = false;
                            }

                        }

                    }
                    if (MimeType == null)
                    {
                        MimeType = "unknown/unknowns";
                        fileUploadFlag = false;
                    }
                    //Commented And Added By Usha Pandit On 28.08.2020 For Text file upload
                    //Commented And Added By Reshma Chavan on 9th Dec 2020 For Text file upload Issue
                    if (strListofTypes.IndexOf(MimeType) > -1)
                    {
                        fileUploadFlag = true;
                    }
                    //if (strListofTypes.IndexOf(MimeType) == -1)
                    //{
                    //    fileUploadFlag = true;
                    //}
                    //End of Commented And Added By Reshma Chavan on 9th Dec 2020 For Text file upload Issue
                    //End Of Added By Usha Pandit On 28.08.2020 For Text file upload
                }

            }

            return fileUploadFlag;
        }

        //deleted Document 
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object DeleteDocument([FromBody] int DocumentId)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Del_tbl_PM_ProjectDocuments " + HttpUtility.UrlDecode(Convert.ToString(DocumentId));
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //get task Document sub Category List
        [Authorize]
        [HttpPost]
        public object InsertDocumnetAttachment()
        {
            try
            {

                string msg = "";
                if (GetFileType())
                {
                    var AttachedFileData = HttpContext.Current.Request["AttachedFileData"];
                    var listAttachedDocuments = JsonConvert.DeserializeObject<List<Models.PM.Document>>(AttachedFileData);
                    for (int i = 0; i < listAttachedDocuments.Count; i++)
                    {
                        var httpPostedFile = HttpContext.Current.Request.Files[i];
                        var SubCategory = "";
                        var Category = listAttachedDocuments[i].Category;
                        var ProjectID = listAttachedDocuments[i].Parameters.ProjectID;
                        if (listAttachedDocuments[i].SubCategory != null)
                        {
                            SubCategory = listAttachedDocuments[i].SubCategory;
                        }

                        string DirectoryName;
                        if (SubCategory != "0")
                        {
                            DirectoryName = "SETPL_WHIZ_WSEM_-0057\\" + listAttachedDocuments[i].CategoryName + "\\" + listAttachedDocuments[i].SubCategoryName;
                        }
                        else
                        {
                            DirectoryName = "SETPL_WHIZ_WSEM_-0057\\" + listAttachedDocuments[i].CategoryName;
                        }
                        var description = listAttachedDocuments[i].Description;
                        var CreatedDate = DateTime.Now;
                        string strFileName = CommonFunctions.FileDirectory.GetUniqueFileName();
                        float FileSize = httpPostedFile.ContentLength;
                        FileSize = FileSize / 1024;
                        string FileExtention = Path.GetExtension(httpPostedFile.FileName);
                        FileExtention = FileExtention.Replace(".", "");
                        string OriginalFileName = Path.GetFileName(httpPostedFile.FileName);
                        int UserId = listAttachedDocuments[i].Parameters.UserID;
                        string LoginType = listAttachedDocuments[i].Parameters.LoginType;

                        int TagID = listAttachedDocuments[i].Parameters.TagID;
                        int UniqueID = listAttachedDocuments[i].UniqueID;
                        string strCodeTemplate = "SETPL/" + listAttachedDocuments[i].CategoryName + "_/<Job Code>/<Serial Number>";
                        string categoryName = listAttachedDocuments[i].CategoryName;
                        string subcategoryName = listAttachedDocuments[i].SubCategoryName;
                        var DirectoryPath = HttpContext.Current.Server.MapPath("~/" + "");
                        DirectoryPath = DirectoryPath.Replace("WhizibleAPIService", "Documents\\SETPL_WHIZ_WSEM_-0057");
                        string dir = "";
                        if (SubCategory != "0")
                        {
                            dir = DirectoryPath + categoryName + "\\" + subcategoryName;
                        }
                        else
                        {
                            dir = DirectoryPath + categoryName;
                        }
                        if (!Directory.Exists(dir))
                        {
                            DirectoryInfo di = Directory.CreateDirectory(dir);
                        }


                        string ChangeRequestID = "NULL";


                        var fileName = httpPostedFile.FileName;
                        var filePath = HttpContext.Current.Server.MapPath("~/" + fileName);
                        filePath = filePath.Replace("WhizibleAPIService", "Documents\\" + DirectoryName);

                        httpPostedFile.SaveAs(filePath);

                        //FileUpload.cUpload cUpload;

                        //cUpload = new FileUpload.cUpload(Convert.ToString(HttpContext.Current.Request.Files[i]), dir);
                        //cUpload.OverwriteIfExists = false;
                        //cUpload.UploadFile();

                        string strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ProjectDocuments " + HttpUtility.UrlDecode(Category.ToString()) + "," + HttpUtility.UrlDecode(ProjectID.ToString()) + ",'" + HttpUtility.UrlDecode(DirectoryName) + "','" + httpPostedFile.FileName.Substring(0, httpPostedFile.FileName.IndexOf('.')) + "','" + HttpUtility.UrlDecode(CreatedDate.ToString()) + "','" + HttpUtility.UrlDecode(CreatedDate.ToString()) + "','" + HttpUtility.UrlDecode(description.Replace("'", "''")) + "'," + HttpUtility.UrlDecode(FileSize.ToString()) + ",'" + HttpUtility.UrlDecode(FileExtention) + "','" + HttpUtility.UrlDecode(fileName.Substring(0, fileName.IndexOf('.'))) + "'," + HttpUtility.UrlDecode(UserId.ToString()) + ",'" + HttpUtility.UrlDecode(LoginType) + "'," + HttpUtility.UrlDecode(ChangeRequestID) + "," + HttpUtility.UrlDecode(SubCategory.ToString()) + "," + HttpUtility.UrlDecode(TagID.ToString()) + "," + HttpUtility.UrlDecode(UniqueID.ToString()) + ",'" + HttpUtility.UrlDecode(strCodeTemplate) + "'";
                        object result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                        msg = "File Uploaded Successfully";
                    }
                }
                else
                {
                    // msg = "Please upload valid files only";
                    msg = "Only files with extensions PDF, XLS, XLSX, ZIP, RAR, XML, LOG, PNG, JPEG, JPG, DOC, DOCX, TXT, EXE are  allowed!!!";
                }
                return msg;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion


        #endregion

        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object SaveProjectAsignTask([FromBody] PM_wbs_card PM_wbs_card)
        {
            try
            {
                int TaskID = 0;
                int ParentTaskID = 0;
                object result;
                if (PM_wbs_card != null)
                {
                    int ProjectID = PM_wbs_card.ProjectID;
                    PM_wbs_card.WorkInHours = PM_wbs_card.WorkInHours.Replace(':', '.');

                    if (PM_wbs_card.TaskID > 0)
                    {
                        string strChildParameters = "";
                        strChildParameters += Convert.ToString(PM_wbs_card.ParentTaskID);
                        strChildParameters += "," + Convert.ToString(PM_wbs_card.EmployeeID);
                        strChildParameters += "," + Convert.ToString(PM_wbs_card.TaskID);
                        strChildParameters += "," + Convert.ToString(ProjectID);

                        //Commented & Added By Dipali V On 10th Aug 2020 For Crash issue
                        //strChildParameters += ",'" + (PM_wbs_card.TaskName ?? "NULL");
                        strChildParameters += ",'" + (PM_wbs_card.TaskName.Replace("'", "''") ?? "NULL");
                        //End of Commented & Added By Dipali V On 10th Aug 2020 For Crash issue
                        strChildParameters += "','" + (PM_wbs_card.StartDate ?? "NULL");
                        strChildParameters += "','" + (PM_wbs_card.EndDate ?? "NULL");
                        strChildParameters += "','" + Convert.ToString(PM_wbs_card.WorkInHours);    //Work
                        strChildParameters += "','" + Convert.ToString(PM_wbs_card.WhichTask);                            //task.WhichTask;
                        strChildParameters += "'," + (PM_wbs_card.IsTaskBillable ?? "0");
                        //Commented & Added By Dipali V On 10th Aug 2020 For Crash issue
                        //strChildParameters += ",'" + (PM_wbs_card.TaskNotes ?? "NULL");
                        strChildParameters += ",'" + (PM_wbs_card.TaskNotes.Replace("'", "''") ?? "NULL");
                        //End of Commented & Added By Dipali V On 10th Aug 2020 For Crash issue
                        strChildParameters += "','" + (PM_wbs_card.TaskTypeName ?? "NULL");
                        strChildParameters += "','" + (PM_wbs_card.StartDate ?? "NULL");        //Baseline start
                        strChildParameters += "','" + (PM_wbs_card.EndDate ?? "NULL");          //Baseline end
                        strChildParameters += "','" + Convert.ToString(PM_wbs_card.WorkInHours);        //Baseline work
                        strChildParameters += "','" + (PM_wbs_card.Priority ?? "Critical");
                        strChildParameters += "'," + Convert.ToString(PM_wbs_card.PhaseID);
                        strChildParameters += ",'" + Convert.ToString(PM_wbs_card.Phase);
                        strChildParameters += "'," + Convert.ToString(PM_wbs_card.ModuleId);
                        strChildParameters += ",'" + Convert.ToString(PM_wbs_card.Module);
                        strChildParameters += "'," + Convert.ToString(PM_wbs_card.SubProjectID);
                        strChildParameters += ",'" + Convert.ToString(PM_wbs_card.SubProject);
                        strChildParameters += "'," + Convert.ToString(PM_wbs_card.MileStoneId);
                        strChildParameters += ",'" + Convert.ToString(PM_wbs_card.MileStone);
                        //Commented And Added By Usha Pandit On 28.08.2020 For passing Field as NULL if its 0
                        //strChildParameters += "'," + Convert.ToString(PM_wbs_card.OtherTaskID);                       //OtherTaskID             
                        if (PM_wbs_card.OtherTaskID == 0)
                        {
                            strChildParameters += "', NULL";     //OtherTaskID
                        }
                        else
                        {
                            strChildParameters += "'," + Convert.ToString(PM_wbs_card.OtherTaskID);                       //OtherTaskID             
                        }
                        //End Of Added By Usha Pandit On 28.08.2020 For passing Field as NULL if its 0

                        strChildParameters += "," + Convert.ToString(PM_wbs_card.ChangeRequestID);
                        strChildParameters += "," + Convert.ToString(PM_wbs_card.ProjectFeatureID);
                        strChildParameters += "," + Convert.ToString(PM_wbs_card.ProjectEstimationTypeID);
                        strChildParameters += "," + Convert.ToString(PM_wbs_card.DeliverableID);

                        //Commented And Added By Usha Pandit On 28.08.2020 For passing Field as NULL if its 0
                        //strChildParameters += "," + Convert.ToString(PM_wbs_card.MitigationPlanID);     //MitigationPlanID
                        //strChildParameters += "," + Convert.ToString(PM_wbs_card.TrainingResourceID);                       //TrainingResourceID
                        if (PM_wbs_card.MitigationPlanID == 0)
                        {
                            strChildParameters += ", NULL";     //MitigationPlanID
                        }
                        else
                        {
                            strChildParameters += "," + Convert.ToString(PM_wbs_card.MitigationPlanID);     //MitigationPlanID
                        }
                        if (PM_wbs_card.TrainingResourceID == 0)
                        {
                            strChildParameters += ", NULL";     //TrainingResourceID
                        }
                        else
                        {
                            strChildParameters += "," + Convert.ToString(PM_wbs_card.TrainingResourceID);                       //TrainingResourceID
                        }
                        //End Of Added By Usha Pandit On 28.08.2020 For passing Field as NULL if its 0
                        strChildParameters += "," + Convert.ToString(PM_wbs_card.TrainingID);                       //TrainingID
                        strChildParameters += "," + Convert.ToString(PM_wbs_card.Void);                        //Void
                        strChildParameters += "," + Convert.ToString(PM_wbs_card.OnHold);                        //OnHold
                        strChildParameters += ",'" + Convert.ToString(PM_wbs_card.CreatedBy);                          //CreatedBy
                        strChildParameters += "'," + Convert.ToString(PM_wbs_card.IsUserStoryTask);                       //IsUserStoryTask
                        strChildParameters += "," + Convert.ToString(PM_wbs_card.UserStoryID);
                        strChildParameters += "," + Convert.ToString(PM_wbs_card.StoryPoints);                      //StoryPoints
                        strChildParameters += ",'" + (PM_wbs_card.DeliverableStageID ?? "NULL") + "'";               //DeliverableStageID

                        result = CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_ProjectAssignedSubTasks " + strChildParameters, true, CommonController.connectionString);
                        TaskID = Convert.ToInt32(result);
                    }
                    else
                    {
                        string strParentParameters = "";
                        strParentParameters += "NULL";
                        strParentParameters += "," + Convert.ToString(ProjectID);
                        strParentParameters += ",'" + (PM_wbs_card.TaskName.Replace("'", "''") ?? "NULL");
                        strParentParameters += "','" + (PM_wbs_card.StartDate ?? "NULL");
                        strParentParameters += "','" + (PM_wbs_card.EndDate ?? "NULL");
                        strParentParameters += "','" + Convert.ToString(PM_wbs_card.WorkInHours);    //Work
                        strParentParameters += "','" + Convert.ToString("O");                            //task.WhichTask;
                        strParentParameters += "'," + (PM_wbs_card.IsTaskBillable ?? "0");
                        strParentParameters += ",'" + (PM_wbs_card.TaskNotes.Replace("'", "''") ?? "NULL");
                        strParentParameters += "','" + (PM_wbs_card.TaskTypeName ?? "NULL");
                        strParentParameters += "','" + (PM_wbs_card.StartDate ?? "NULL");        //Baseline start
                        strParentParameters += "','" + (PM_wbs_card.EndDate ?? "NULL");          //Baseline end
                        strParentParameters += "','" + Convert.ToString(PM_wbs_card.WorkInHours);        //Baseline work
                        strParentParameters += "','" + (PM_wbs_card.Priority ?? "Critical");
                        strParentParameters += "'," + Convert.ToString(PM_wbs_card.PhaseID);
                        strParentParameters += ",'" + Convert.ToString(PM_wbs_card.Phase);
                        strParentParameters += "'," + Convert.ToString(PM_wbs_card.ModuleId);
                        strParentParameters += ",'" + Convert.ToString(PM_wbs_card.Module);
                        strParentParameters += "'," + Convert.ToString(PM_wbs_card.SubProjectID);
                        strParentParameters += ",'" + Convert.ToString(PM_wbs_card.SubProject);
                        strParentParameters += "'," + Convert.ToString(PM_wbs_card.MileStoneId);
                        strParentParameters += ",'" + Convert.ToString(PM_wbs_card.MileStone);

                        //Commented And Added By Usha Pandit On 28.08.2020 For passing Field as NULL if its 0
                        //strParentParameters += "'," + Convert.ToString(PM_wbs_card.OtherTaskID);                       //OtherTaskID             
                        if (PM_wbs_card.OtherTaskID == 0)
                        {
                            strParentParameters += "', NULL";
                        }
                        else
                        {
                            strParentParameters += "'," + Convert.ToString(PM_wbs_card.OtherTaskID);                       //OtherTaskID 
                        }
                        //End Of Added By Usha Pandit On 28.08.2020 For passing Field as NULL if its 0

                        strParentParameters += "," + Convert.ToString(PM_wbs_card.ChangeRequestID);
                        strParentParameters += "," + Convert.ToString(PM_wbs_card.ProjectFeatureID);
                        strParentParameters += "," + Convert.ToString(PM_wbs_card.ProjectEstimationTypeID);
                        strParentParameters += "," + Convert.ToString(PM_wbs_card.DeliverableID);
                        strParentParameters += "," + "NULL";                       //MitigationPlanID
                        strParentParameters += "," + "NULL";                       //TrainingResourceID
                        strParentParameters += "," + Convert.ToString("0");                       //TrainingID
                        strParentParameters += "," + Convert.ToString("1");                        //Void
                        strParentParameters += "," + Convert.ToString(PM_wbs_card.OnHold);                        //OnHold
                        strParentParameters += ",'" + Convert.ToString(PM_wbs_card.CreatedBy);                          //CreatedBy
                        strParentParameters += "'," + Convert.ToString(PM_wbs_card.IsUserStoryTask);                       //IsUserStoryTask
                        strParentParameters += "," + Convert.ToString(PM_wbs_card.UserStoryID);
                        strParentParameters += "," + Convert.ToString(PM_wbs_card.StoryPoints);                      //StoryPoints

                        //Commented And Added By Usha Pandit On 17.10.2020 For passing correct NULL value
                        //strParentParameters += ",'" + (PM_wbs_card.DeliverableStageID ?? "NULL") + "'";
                        if (PM_wbs_card.DeliverableStageID == "0" || PM_wbs_card.DeliverableStageID == null)
                        {
                            strParentParameters += ", NULL";
                        }
                        else
                        {
                            strParentParameters += ",'" + Convert.ToString(PM_wbs_card.DeliverableStageID) + "'";                       //DeliverableStageID 
                        }
                        //End Of Added By Usha Pandit On 17.10.2020 For passing Field as NULL if its 0

                        result = CommonFunctions.Data.GetDataScalar("usp_Ins_tbl_PM_ProjectAssignedTasks " + strParentParameters, true, CommonController.connectionString);
                        ParentTaskID = Convert.ToInt32(result);
                        if (ParentTaskID > 0)
                        {
                            string strChildParameters = "";
                            strChildParameters += Convert.ToString(ParentTaskID);
                            strChildParameters += "," + Convert.ToString(PM_wbs_card.EmployeeID);
                            strChildParameters += "," + "NULL";
                            strChildParameters += "," + Convert.ToString(ProjectID);
                            //Commented & Added By Dipali V On 10th Aug 2020 For Crash
                            strChildParameters += ",'" + (PM_wbs_card.TaskName.Replace("'", "''") ?? "NULL");
                            //strChildParameters += ",'" + (PM_wbs_card.TaskName ?? "NULL");
                            //End of Commented & Added By Dipali V On 10th Aug 2020 For Crash
                            strChildParameters += "','" + (PM_wbs_card.StartDate ?? "NULL");
                            strChildParameters += "','" + (PM_wbs_card.EndDate ?? "NULL");
                            strChildParameters += "','" + Convert.ToString(PM_wbs_card.WorkInHours);    //Work
                            strChildParameters += "','" + Convert.ToString(PM_wbs_card.WhichTask);                            //task.WhichTask;
                            strChildParameters += "'," + (PM_wbs_card.IsTaskBillable ?? "0");
                            strChildParameters += ",'" + (PM_wbs_card.TaskNotes.Replace("'", "''") ?? "NULL");
                            strChildParameters += "','" + (PM_wbs_card.TaskTypeName ?? "NULL");
                            strChildParameters += "','" + (PM_wbs_card.StartDate ?? "NULL");        //Baseline start
                            strChildParameters += "','" + (PM_wbs_card.EndDate ?? "NULL");          //Baseline end
                            strChildParameters += "','" + Convert.ToString(PM_wbs_card.WorkInHours);        //Baseline work
                            strChildParameters += "','" + (PM_wbs_card.Priority ?? "Critical");
                            strChildParameters += "'," + Convert.ToString(PM_wbs_card.PhaseID);
                            strChildParameters += ",'" + Convert.ToString(PM_wbs_card.Phase);
                            strChildParameters += "'," + Convert.ToString(PM_wbs_card.ModuleId);
                            strChildParameters += ",'" + Convert.ToString(PM_wbs_card.Module);
                            strChildParameters += "'," + Convert.ToString(PM_wbs_card.SubProjectID);
                            strChildParameters += ",'" + Convert.ToString(PM_wbs_card.SubProject);
                            strChildParameters += "'," + Convert.ToString(PM_wbs_card.MileStoneId);
                            strChildParameters += ",'" + Convert.ToString(PM_wbs_card.MileStone);
                            //Commented And Added By Usha Pandit On 28.08.2020 For passing Field as NULL if its 0
                            //strChildParameters += "'," + Convert.ToString(PM_wbs_card.OtherTaskID);                       //OtherTaskID             
                            if (PM_wbs_card.OtherTaskID == 0)
                            {
                                strChildParameters += "', NULL";
                            }
                            else
                            {
                                strChildParameters += "'," + Convert.ToString(PM_wbs_card.OtherTaskID);                       //OtherTaskID             
                            }
                            //End Of Added By Usha Pandit On 28.08.2020 For passing Field as NULL if its 0
                            strChildParameters += "," + Convert.ToString(PM_wbs_card.ChangeRequestID);
                            strChildParameters += "," + Convert.ToString(PM_wbs_card.ProjectFeatureID);
                            strChildParameters += "," + Convert.ToString(PM_wbs_card.ProjectEstimationTypeID);
                            strChildParameters += "," + Convert.ToString(PM_wbs_card.DeliverableID);
                            strChildParameters += "," + "NULL";                      //MitigationPlanID
                            strChildParameters += "," + "NULL";                        //TrainingResourceID
                            strChildParameters += "," + Convert.ToString("0");                       //TrainingID
                            strChildParameters += "," + Convert.ToString("1");                           //Void
                            strChildParameters += "," + Convert.ToString(PM_wbs_card.OnHold);                        //OnHold
                            strChildParameters += ",'" + Convert.ToString(PM_wbs_card.CreatedBy);                          //CreatedBy
                            strChildParameters += "'," + Convert.ToString(PM_wbs_card.IsUserStoryTask);                       //IsUserStoryTask
                            strChildParameters += "," + Convert.ToString(PM_wbs_card.UserStoryID);
                            strChildParameters += "," + Convert.ToString(PM_wbs_card.StoryPoints);                      //StoryPoints
                            strChildParameters += ",'" + (PM_wbs_card.DeliverableStageID ?? "NULL") + "'";               //DeliverableStageID

                            result = CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_ProjectAssignedSubTasks " + strChildParameters, true, CommonController.connectionString);
                            TaskID = Convert.ToInt32(result);
                        }
                    }
                }
                return TaskID;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        // public PM_WBS_TaskConfigure GetProjectTaskConfigureDetails([FromBody]PM_wbs_card_parameters Parameters)
        public object GetProjectTaskConfigureDetails([FromBody] PM_wbs_card_parameters Parameters)
        {
            try
            {
                PM_WBS_TaskConfigure PM_WBS_TaskConfigure = new PM_WBS_TaskConfigure();

                bool haveSubTaskTypes = false, applyEffortDistribution = false;
                string projectStartDate = "", projectEndDate = "";
                int ResourceValidation = 0;
                string strTaskCaseStructureQuery = "usp_sel_tbl_PM_Project_TaskCaseStructure " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));
                DataTable TaskCaseStructureTable = CommonFunctions.Data.GetDataTable(strTaskCaseStructureQuery, true, CommonController.connectionString);
                foreach (DataRow TaskCaseStructureRow in TaskCaseStructureTable.Rows)
                {
                    haveSubTaskTypes = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(TaskCaseStructureRow["HaveSubTaskTypes"], "0"));
                    applyEffortDistribution = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(TaskCaseStructureRow["ApplyEffortDistribution"], "0"));
                    projectStartDate = CommonFunctions.Data.CheckIsDBNull(TaskCaseStructureRow["ExpectedStartDate"], "").ToString();
                    projectEndDate = CommonFunctions.Data.CheckIsDBNull(TaskCaseStructureRow["ExpectedEndDate"], "").ToString();
                    ResourceValidation = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TaskCaseStructureRow["ResourceValidation"], "0"));
                }
                DataTable drCompany = CommonFunctions.Data.GetDataTable("usp_sel_tbl_PM_CompanyInformation", true, CommonController.connectionString);
                bool RestrictByMinHours = false;
                foreach (DataRow CompanyRow in drCompany.Rows)
                {
                    RestrictByMinHours = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(CompanyRow["RestrictByMinHours"], "0"));
                }
                double HoursPerDay = 0;
                long WeekDays = 0;
                string strQuery = "Exec usp_Get_ProjectLocationWorkingHours_Days " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));
                DataTable drWork = CommonFunctions.Data.GetDataTable(strQuery, true, CommonController.connectionString);
                foreach (DataRow WorkRow in drWork.Rows)
                {
                    HoursPerDay = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(WorkRow["WorkingHours"], "0"));
                    WeekDays = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(WorkRow["WorkingDays"], "0"));
                }

                double TotalAllocatedTaskLCE = 0, TotalLCE = 0;
                //Added By Dipali V On 3th march 2020 For Get Assigned Task hours of particular projects 
                //strQuery = "EXEC usp_Sel_PM_DepartmentBalanceLCE " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ", NULL";
                strQuery = "EXEC usp_Whizible2_Sel_PM_DepartmentBalanceLCETaskCard " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ", NULL";
                //End of Added By Dipali V On 3th march 2020 For Get Assigned Task hours of particular projects 
                DataTable drAllocatedTask = CommonFunctions.Data.GetDataTable(strQuery, true, CommonController.connectionString);
                foreach (DataRow AllocatedRow in drAllocatedTask.Rows)
                {
                    TotalAllocatedTaskLCE = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(AllocatedRow["AllocatedLCETotal"], "0"));
                    TotalLCE = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(AllocatedRow["LCETotal"], "0"));
                }


                //        m_strHolidays = ""
                //strQuery = "EXEC usp_Sel_tbl_PM_Location_Holiday " & m_lngProjectLocationID.ToString()
                //drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                //If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                //    While drWork.Read()
                //        strTemp = drWork.Item("HolidayDate").ToString()
                //        If strTemp<> "" Then
                //           m_strHolidays &= CommonFunctions.Dates.GetDate(CType(strTemp, Date)) & ","
                //        End If
                //    End While
                //End If
                PM_WBS_TaskConfigure.ResourceValidation = ResourceValidation;
                PM_WBS_TaskConfigure.RestrictByMinHours = RestrictByMinHours;
                PM_WBS_TaskConfigure.ProjectStartDate = projectStartDate;
                PM_WBS_TaskConfigure.ProjectEndDate = projectEndDate;
                PM_WBS_TaskConfigure.HaveSubTaskTypes = haveSubTaskTypes;
                PM_WBS_TaskConfigure.ApplyEffortDistribution = applyEffortDistribution;
                PM_WBS_TaskConfigure.HoursPerDay = HoursPerDay;
                PM_WBS_TaskConfigure.WeekDays = WeekDays;
                PM_WBS_TaskConfigure.TotalAllocatedTaskLCE = TotalAllocatedTaskLCE;
                PM_WBS_TaskConfigure.TotalLCE = TotalLCE;
                return PM_WBS_TaskConfigure;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        #region custum field
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object GetCustomFieldMasterRowNumber([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                int MaxRow = 0, MaxColoumn = 0;

                string strsql = "Exec usp_Whizible2_Sel_tbl_PM_CustomFields_Master_Rows " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.Type)) + ",'" + HttpUtility.UrlDecode(WBSParameters.strEntityName) + "'," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.IsActive)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID)) + ",'" + HttpUtility.UrlDecode(WBSParameters.LoginType) + "'";

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



            List<int> CustomfileId1 = new List<int>();
        //int CustomFieldID;
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        //  public List<CustomFiledPloat_SubProject> PloatCustomFields([FromBody]WbsParameter WBSParameters)
        public object PloatCustomFields([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                List<CustomFiledPloat_SubProject> cfp = new List<CustomFiledPloat_SubProject>();
                List<CustomFiledPloat_SubProject> CustomFieldIDs = new List<CustomFiledPloat_SubProject>();

                string strSQL = "Exec usp_Whizible2_sel_tbl_PM_RoleCustomFieldSecurity " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.RoleID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID)) + ",'" + HttpUtility.UrlDecode(WBSParameters.strEntityName) + "','" + HttpUtility.UrlDecode(WBSParameters.LoginType) + "'";

                IDataReader sdr1;
                sdr1 = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr1.Read())
                {
                    CustomfileId1.Add(Convert.ToInt32(sdr1["CustomFieldID"]));

                }

                if (WBSParameters.Type != null)
                {
                    string strSQL1 = "Exec usp_Whizible2_Sel_tbl_PM_CustomFields_Master " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + ",NULL," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.IsActive)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.Type)) + ",'" + HttpUtility.UrlDecode(WBSParameters.strEntityName) + "'," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.LoginType)) + "'";
                    DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL1, true, CommonController.connectionString);

                    foreach (DataRow sdr in taskListTable.Rows)
                    {
                        CustomFiledPloat_SubProject layoutControl = new CustomFiledPloat_SubProject()
                        {

                            UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["UniqueID"].ToString(), "0")),
                            UserGivenCaption = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["UserGivenCaption"].ToString(), "")),
                            ValidationRules = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ValidationRules"].ToString(), "")),
                            DatabaseFieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["DatabaseFieldName"].ToString(), "")),
                            RowNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["RowNumber"].ToString(), "0")),
                            ColumnNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ColumnNumber"].ToString(), "0")),
                            IsCustomFieldAssigned = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["IsCustomFieldAssigned"].ToString(), "")),
                            DefaultValue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["DefaultValue"].ToString(), "")),
                            DefaultType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["DefaultType"].ToString(), "")),
                            ControlHeight = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ControlHeight"].ToString(), "")),
                            ControlWidth = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ControlWidth"].ToString(), "")),
                        };
                        cfp.Add(layoutControl);

                        if (CustomfileId1.Contains(layoutControl.UniqueID))
                        {
                            continue;
                        }
                    }
                }


                return cfp;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //To get the validation message for custom fields.
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object GetValidationForCustomFields([FromBody] CustomFiledPloat_SubProject customFiled)
        {
            try
            {
                string VALIDATION;
                VALIDATION = Convert.ToString(customFiled.CustomValidation).Replace("[", "").Replace("]", "").Replace("\"", string.Empty).Trim();//.Replace(",", "").

                List<ValidationData_SubProject> ValidationData = new List<ValidationData_SubProject>();

                string strsql = "Exec usp_Whizible2_sel_tbl_UI_Validation_ValidationID ";

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
                //Result = Result.Replace("\n", " ");
                foreach (string r in Result)
                {
                    foreach (DataRow sdr in ValidationDataTable.Rows)
                    {
                        ValidationData_SubProject ValidationDataControl = new ValidationData_SubProject()
                        {

                            ValidationID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ValidationID"].ToString(), "")),
                            ValidationMessage = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ValidationMessage"].ToString(), "")),
                            FieldName = Convert.ToString(customFiled.CustomFieldName),
                            FieldID = Convert.ToString(customFiled.FieldID)
                        };


                        if (Convert.ToString(ValidationDataControl.ValidationID) == Convert.ToString(r))
                        {
                            ValidationData.Add(ValidationDataControl);
                        }
                        else
                        {

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


            //get validation filed applied
            [HttpPost]
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        public object getValidationFiled([FromBody]WbsParameter WBSParameters)
        {
           try{
                string strSQL;
            strSQL = "exec usp_Whizible2_Sel_v_tbl_UI_ControlTagMaster " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TagID));

            DataTable dt = new DataTable();
            dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

            return dt;
        }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            }

        //[Authorize]
        //[HttpPost]
        //public List<CustomFiledPloat_BulkUpdate> GetExtendedCustomFieldComboboxValues([FromBody]CustomFiledPloat_BulkUpdate customFiled)
        //{

        //    List<CustomFiledPloat_BulkUpdate> cfp = new List<CustomFiledPloat_BulkUpdate>();


        //    string strSQL1 = "Exec usp_Whizible2_Sel_tbl_IB_ExtendedCustomFields_Details " + "'" + customFiled.DatabaseFieldName + "'," + customFiled.commonProperty.ProjectId;
        //    //   strSQL += ProjectId;
        //    DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL1, true, CommonController.connectionString);

        //    foreach (DataRow sdr in taskListTable.Rows)
        //    {
        //        CustomFiledPloat_BulkUpdate layoutControl = new CustomFiledPloat_BulkUpdate()
        //        {
        //            FieldID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["FieldID"].ToString(), "")),
        //            FieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["FieldName"].ToString(), "")),
        //            UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["UniqueID"].ToString(), "0")),

        //        };
        //        cfp.Add(layoutControl);

        //    }

        //    return cfp;
        //}

        #endregion



        [HttpPost]
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        public object IsEmployeeRoleAllowToFilter([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                int result = 0;
                result = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull
                                              (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Sel_tbl_PM_Task_ProjectRoleMap " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.RoleID))
                                              , true, CommonController.connectionString)
                                              , "0"));
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object GetLeaveDetails([FromBody] PM_wbs_card_parameters pm_wbs_cardparameter)
        {
            try
            {
                int result = 0;
                string strQuery = "";
                string strTemp = "";
                string strWFHDays = "";
                string strLeaveMessage = "";
                string strWFHMessage = "";
                string strEmployeeName = "";
                string strLeaveDays = "";
                string blnIsNewTask = "";
                if (pm_wbs_cardparameter.TaskID == "0")
                {
                    blnIsNewTask = "True";
                }
                else
                {
                    blnIsNewTask = "False";
                }


                strQuery = "Exec usp_Sel_tbl_PM_EmployeeLeaveDetails_ForGivenDates " + pm_wbs_cardparameter.UserID + ",'" + pm_wbs_cardparameter.StartDate + "','" + pm_wbs_cardparameter.EndDate + "'";

                PM_wbs_card_parameters defaultleave = new PM_wbs_card_parameters();
                IDataReader drDefaultQuery;
                drDefaultQuery = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                if (drDefaultQuery.Read())
                {
                    //strEmployeeName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drDefaultQuery("EmployeeName"), ""), "");
                    strEmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDefaultQuery["EmployeeName"].ToString(), ""));
                    if (strEmployeeName != "")
                    {

                        strLeaveDays = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDefaultQuery["LeaveDays"].ToString(), ""));
                        //strLeaveDays = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drDefaultQuery("LeaveDays"), ""), "");
                        //strWFHDays = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drDefaultQuery("WFHDays"), ""), "");
                        strWFHDays = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDefaultQuery["WFHDays"].ToString(), ""));
                        if (strLeaveDays != "")
                        {
                            strLeaveMessage = strEmployeeName + " has leaves(s) on : " + strLeaveDays.Remove(0, 1) + " Do you want to continue?";
                        }

                        if (strWFHDays != "")
                        {
                            strTemp = strLeaveMessage + " <==> " + strWFHMessage;
                        }
                        else
                        {
                            strTemp = strLeaveMessage;
                        }


                    }
                }

                //strLeaveMessage = strTempName
                return strTemp;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object GetHolidayDetails([FromBody] PM_wbs_card_parameters pm_wbs_cardparameter)
        {
            try
            {
                string strQuery = "";
                string m_strHolidays = "";
                //string m_strHolidays = "";
                string strTemp;
                PM_wbs_card_parameters defaultleave = new PM_wbs_card_parameters();
                IDataReader drDefaultQuery;
                strQuery = "Exec usp_Whizible2_Sel_tbl_PM_Location_Holiday " + pm_wbs_cardparameter.ProjectID + "";

                drDefaultQuery = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                while (drDefaultQuery.Read())
                {

                    strTemp = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDefaultQuery["HolidayDate"].ToString(), ""));
                    if (strTemp != "")
                    {
                        m_strHolidays += CommonFunctions.Dates.GetDate(System.Convert.ToDateTime(strTemp)) + ",";


                    }
                }
                return m_strHolidays;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object GetSprintRelease([FromBody] PM_wbs_card_parameters pm_wbs_cardparameter)
        {
            try
            {
                string strSQL;
                strSQL = "exec Usp_Whizible2_Sel_Scrum_UserStories 'UserStoryDetails', " + HttpUtility.UrlDecode(Convert.ToString(pm_wbs_cardparameter.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(pm_wbs_cardparameter.UserStoryID)) + "," + HttpUtility.UrlDecode(Convert.ToString(pm_wbs_cardparameter.TaskID)) + "";

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }




        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object SaveTaskCardFlag([FromBody] PM_wbs_card_parameters wbs_card_parameters)
        {
            try
            {
                string SaveFlag;

                SaveFlag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_Whizible2_TaskCard_Flag "
                                                                                     + HttpUtility.UrlDecode(Convert.ToString(wbs_card_parameters.ProjectID)) + ","
                                                                                     + HttpUtility.UrlDecode(Convert.ToString(wbs_card_parameters.TaskFlagID)) + ","
                                                                                     + HttpUtility.UrlDecode(Convert.ToString(wbs_card_parameters.TaskID)) + ",'"
                                                                                     + HttpUtility.UrlDecode(wbs_card_parameters.FlagDate) + "',"
                                                                                     + HttpUtility.UrlDecode(Convert.ToString(wbs_card_parameters.IsActive)) + ","
                                                                                     + HttpUtility.UrlDecode(Convert.ToString(wbs_card_parameters.UserID)) + ",'"
                                                                                     + HttpUtility.UrlDecode(wbs_card_parameters.EmployeeName) + "' ",
                                                                                     true, CommonController.connectionString
                                                                                     ),
                                                  "")
                                                  );
                return SaveFlag;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object GetFlagDetails([FromBody] PM_wbs_card_parameters pm_wbs_cardparameter)
        {
            try
            {
                string strSQL;
                strSQL = "exec usp_Whizible2_Sel_tbl_Whizible2_TaskCard_Flag " + HttpUtility.UrlDecode(Convert.ToString(pm_wbs_cardparameter.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(pm_wbs_cardparameter.TaskID)) + "";

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //added by omkar 28/01/2020
        /// <summary>
        /// Created Date    :   28/01/2020
        /// Purpose         :   GetProject
        /// <returns></returns>
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        // public List<FillProjectParameters> GetProjectDropDown([FromBody] PM_wbs_card_parameters parameters)
        public object GetProjectDropDown([FromBody] PM_wbs_card_parameters parameters)
        {
            try
            {
                DataTable FillProjectDatatable;
                List<FillProjectParameters> listProjectName = new List<FillProjectParameters>();
                FillProjectDatatable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_AccessibleProjects_ForEmployee_TaskCardView "
                                                                                + HttpUtility.UrlDecode(parameters.UserID.ToString()) + ","
                                                                                     + HttpUtility.UrlDecode(parameters.ProjectID.ToString()) + "",
                                                                                     true, CommonController.connectionString);
                foreach (DataRow dr in FillProjectDatatable.Rows)
                {
                    FillProjectParameters CC = new FillProjectParameters()
                    {
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["ProjectID"], "")),
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["ProjectName"], "")),
                    };

                    listProjectName.Add(CC);
                }
                return listProjectName;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //end of added by omkar 28/01/2020

        //Added By Usha Pandit On 28.08.2020 For validating start-end date with sprint start-end date
        /// <summary>
        /// Created Date    :   28.08.2020
        /// Purpose         :   For validating start-end date with sprint start-end date
        /// <returns></returns>
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object CheckIterationDates([FromBody] PM_wbs_card_parameters parameters)
        {
            try
            {
                string strSql = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_TaskPeriodFallsBetweenIteration " + HttpUtility.UrlDecode(Convert.ToString(parameters.UserStoryID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(parameters.StartDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(parameters.EndDate)) + "'", true, CommonController.connectionString), ""));
                return strSql;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End Of Added By Usha Pandit On 28.08.2020 For validating start-end date with sprint start-end date

        //Added By Usha Pandit On 28.08.2020 For validating task work hours with sprint work hours
        /// <summary>
        /// Created Date    :   28.08.2020
        /// Purpose         :   For validating task work hours with sprint work hours
        /// <returns></returns>
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object CheckIterationEfforts([FromBody] PM_wbs_card_parameters parameters)
        {
            try
            {
                string curTaskId = HttpUtility.UrlDecode(Convert.ToString(parameters.TaskID));
                string strSql = "";
                Decimal fltEfforts;
                fltEfforts = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + HttpUtility.UrlDecode(Convert.ToString(parameters.WorkInHours)) + "',2)", true, CommonController.connectionString), "0.00"));
                if (curTaskId == "0")
                {
                    strSql = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_TaskEffortsSprintValidate " + HttpUtility.UrlDecode(Convert.ToString(parameters.UserStoryID)) + "," + fltEfforts + ",NULL", true, CommonController.connectionString), ""));
                }
                else
                {
                    strSql = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_TaskEffortsSprintValidate " + HttpUtility.UrlDecode(Convert.ToString(parameters.UserStoryID)) + "," + fltEfforts + "," + HttpUtility.UrlDecode(Convert.ToString(parameters.TaskID)) + "", true, CommonController.connectionString), ""));
                }
                return strSql;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End Of Added By Usha Pandit On 28.08.2020 For validating task work hours with sprint work hours
        //Added By Usha Pandit On 28.08.2020 To retrieve the details of specific project baseline status
        /// <summary>
        /// Created Date    :   28.08.2020
        /// Purpose         :   To retrieve the details of specific project baseline status
        /// <returns></returns>
        //Added by imran on 14-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 14-09-2022
        [HttpPost]
        public object GetProjetBaselineStatus([FromBody] PM_wbs_card_parameters parameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_tbl_CNF_Project_Status " + HttpUtility.UrlDecode(Convert.ToString(parameters.ProjectID));

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End Of Added By Usha Pandit On 28.08.2020 To retrieve the details of specific project baseline status

        //added by imran on 10-01-2022


        [HttpPost]
        public object GetDropDownValue([FromBody] PM_wbs_card_parameters pm_wbs_cardparameter)
        {
            try
            {
                string strSQL;
                strSQL = "exec Usp_Whizible2_Sel_tbl_WBS_TaskFields ";
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
            //End comment by imran on 10-01-2022
        }

}
