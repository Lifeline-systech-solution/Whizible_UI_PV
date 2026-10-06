using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WhizibleAPI.App_Start;
using WhizibleAPI.Models.TaskStatus;

namespace WhizibleAPI.Controllers
{
    public class TaskStatusManagementController : ApiController
    {
        private const string TASK_TYPE_ASSIGNED = "O";
        private const string TASK_TYPE_MPP = "M";
        private const string TASK_TYPE_ISSUE = "B";
        private const string TASK_TYPE_REVIEW = "R";
        private const string TASK_TYPE_HELPDESK = "H";

        private const int OPERATION_VOID_TASKS = 1;
        private const int OPERATION_VALID_TASKS = 2;
        private const int OPERATION_BILLABEL_TASKS = 3;
        private const int OPERATION_NONBILLABEL_TASKS = 4;
        private const int OPERATION_ONHOLD_TASKS = 5;
        private const int OPERATION_REMOVE_ONHOLD_TASKS = 6;
        private const int OPERATION_REOPEN_TASKS = 7;
        private const int OPERATION_ACCRUAL_PRORATA = 9;
        private const int OPERATION_ACCRUAL_ONCOMPLETION = 10;
        private const int OPERATION_SET_BASELINE = 11;
        private const int OPERATION_CLEAR_BASELINE = 12;
        private const int OPERATION_SAVE_PERCENTCOMPLETE = 13;
        private const string MODE_LIST = "List";
        private const string MODE_SAVE = "Save";

        [Authorize, ValidateHeaders]
        [HttpPost]
        public List<TaskStatusManagement> GetTaskList([FromBody] TaskManagementInput taskInput)
        {
            string strName;
            string strAttributes;
            string strTxtName;
            string strTxtActualPercent;
            string strActStartDate;
            string strActEndDate;
            string strActualStartDateValue;
            string strActualEndDateValue;
            string strActStartDatetxt;
            string strActEndDatetxt;
            string strTaskId1;
            double strtotalworkhrs;
            double childworkhrs;
            string strParentaskID;
            double Parenttaskwork;
            string startDate;
            string EndDate;
            string PstartDate;
            string PEndDate;
            string strSQLQuery = "";
            if (taskInput.strTaskFilter == "2")
                taskInput.strTaskFilter = "NULL";
            if (taskInput.m_intOperation == "8")
                strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksForCompletion " + taskInput.m_intProjectID + "," + taskInput.m_intEmployeeID + ", '" + taskInput.m_dtFromDate + "', '" + taskInput.m_dtToDate + "','" + taskInput.m_strTaskType + "'," + taskInput.strTaskFilter;
            else
                strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksFor_TaskStatusManagement " + taskInput.m_intProjectID + "," + taskInput.m_intEmployeeID + ", '" + taskInput.m_dtFromDate + "', '" + taskInput.m_dtToDate + "','" + taskInput.m_strTaskType + "'," + taskInput.m_intOperation + "," + taskInput.strTaskFilter;

            List<TaskStatusManagement> tasks = new List<TaskStatusManagement>();
            DataTable OpTable;
            OpTable = CommonFunctions.Data.GetDataTable(strSQLQuery, true, CommonController.connectionString);

            foreach (DataRow opRow in OpTable.Rows)
            {
                TaskStatusManagement task = new TaskStatusManagement();
                task.ParentTask_UID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["ParentTask_UID"], "0"));
                task.TaskId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["TaskID"], "0"));
                task.TaskName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["TaskName"], ""));
                task.UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["UniqueID"], "0"));
                task.DepartmentId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["DepartmentId"], "0"));
                task.ActualPercentComplete = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ActualPercentComplete"], ""));
                task.EmployeeId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["EmployeeId"], "0"));
                task.ActualWork = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ActualWork"], ""));
                task.EmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["EmployeeName"], ""));
                task.SubTaskTypes = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["SubTaskTypes"], ""));
                task.PlannedWork = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["PlannedWork"], ""));
                task.ActualWork = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ActualWork"], ""));
                task.StartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["StartDate"],""));
                task.StartDate = task.StartDate != "" ? Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(opRow["StartDate"])).ToString("d-MMM-yyyy") : "";
                task.EndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["EndDate"], ""));
                task.EndDate = task.EndDate != "" ? Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(opRow["EndDate"])).ToString("d-MMM-yyyy") : "";
                task.BaselineStart = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["BaselineStart"], ""));
                task.BaselineStart = task.BaselineStart != "" ? Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(opRow["BaselineStart"])).ToString("d-MMM-yyyy") : "";
                task.BaselineEnd = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["BaselineEnd"], ""));
                task.BaselineEnd = task.BaselineEnd != "" ? Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(opRow["BaselineEnd"])).ToString("d-MMM-yyyy") : "";
                task.ActualStartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ActualStartDate"], ""));
                task.ActualStartDate = task.ActualStartDate != "" ? Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(opRow["ActualStartDate"])).ToString("d-MMM-yyyy") : "";
                task.ActualEndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ActualEndDate"], ""));
                task.ActualEndDate = task.ActualEndDate != "" ? Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(opRow["ActualEndDate"])).ToString("d-MMM-yyyy") : "";
                task.CreatedDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["CreatedDate"], ""));
                task.ActualPercentComplete = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ActualPercentComplete"], ""));
                task.TaskStatus = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(opRow["TaskStatus"], "False"));
                if (taskInput.m_intOperation != "8")
                {
                    task.IsUserStoryTask = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(opRow["IsUserStoryTask"], "False"));
                }
                task.HasChildTasks = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["HasChildTasks"], ""));
                string strsql = "";
                strParentaskID = Convert.ToString(task.ParentTask_UID);
                strTaskId1 = Convert.ToString(task.TaskId);
                strsql = "usp_sel_tbl_PM_ProjectTasks_work_parenttaskid_TaskId " + strParentaskID + "," + strTaskId1;
                task.Parenttaskwork = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strsql, true, CommonController.connectionString), "0"));
                strsql = "usp_sel_tbl_PM_ProjectTasks_work_parenttask_uid " + strParentaskID;
                task.strtotalworkhrs = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strsql, true, CommonController.connectionString), "0"));
                task.childworkhrs = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + CommonFunctions.Data.CheckIsDBNull(task.PlannedWork, "0:00").ToString() + "',2)", true, CommonController.connectionString), "0"));
                strsql = "usp_sel_tbl_PM_ProjectTasks_StartDate_TaskID " + strParentaskID;
                task.PStartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strsql, true, CommonController.connectionString), ""));
                strsql = "usp_sel_tbl_PM_ProjectTasks_EndDate_TaskID " + strParentaskID;
                task.PEndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strsql, true, CommonController.connectionString), ""));
                tasks.Add(task);
            }
            return tasks;
        }


       

        // Modified by DipalI v On 4th sep 2026 - Purpose: AllowHashParams so SaveTasks can use slim hashed Params (large task lists) without removing ValidateHeaders
        //[Authorize, ValidateHeaders]
        [Authorize, ValidateHeaders(AllowHashParams = true)]
        [HttpPost]
        public string SaveTasks([FromBody] TaskStatusManagementSaveParameterList taskStatusManagementSaveParameterList)
        {
            // Added by DipalI v On 4th sep 2026 - Purpose: enforce max 1000 tasks per save (same as UI alert)
            const int MAX_SAVE_TASKS = 1000;
            int saveCount = taskStatusManagementSaveParameterList?.taskStatusManagementSaveParameters?.Count ?? 0;
            if (saveCount > MAX_SAVE_TASKS)
            {
                throw new HttpResponseException(Request.CreateErrorResponse(HttpStatusCode.BadRequest, "Only 1000 tasks are allowed to save at a time."));
            }

            var firstTask = taskStatusManagementSaveParameterList?.taskStatusManagementSaveParameters.FirstOrDefault();
            int m_intOperation = (int)firstTask?.m_intOperation;
            int m_intProjectID = (int)firstTask?.ProjectId;
            int intTaskIDs_Break = 0;
            string TaskID;
            string strPreviousReopendEfforts = "0";
            string strbalanceHrsMessage = "";
            string strTaskIDs = "";
            IDataReader objDRValidateEffort;
            string strProjectHrs = "";
            string strProjectAllocatedHrs = "";
            if (m_intOperation == OPERATION_VALID_TASKS)
            {




                objDRValidateEffort = CommonFunctions.Data.GetDataReader("usp_Sel_PM_DepartmentBalanceLCE " + m_intProjectID.ToString(), true, CommonController.connectionString);
                if (objDRValidateEffort.Read())
                {
                    strProjectHrs = CommonFunctions.Data.CheckIsDBNull(objDRValidateEffort["LCETotal"], "").ToString();
                    strProjectAllocatedHrs = CommonFunctions.Data.CheckIsDBNull(objDRValidateEffort["AllocatedLCETotal"], "").ToString();
                }

                CommonFunctions.Data.DisposeDataReader(ref objDRValidateEffort);

                foreach (TaskStatusManagementSaveParameter item in taskStatusManagementSaveParameterList.taskStatusManagementSaveParameters)
                {
                    if (strTaskIDs != "")
                    {
                        strTaskIDs += "," + item.TaskId;
                    }
                    else
                    {
                        strTaskIDs += item.TaskId;
                    }
                    objDRValidateEffort = CommonFunctions.Data.GetDataReader("usp_sel_ValidateReopendTasksEffors " + m_intProjectID.ToString() + "," + strProjectHrs + "," + strProjectAllocatedHrs + " , '" + strTaskIDs + "'," + strPreviousReopendEfforts, true, CommonController.connectionString);

                    if (objDRValidateEffort.Read())
                    {
                        strPreviousReopendEfforts = CommonFunctions.Data.CheckIsDBNull(objDRValidateEffort["ReopenedEffors"], "0").ToString();
                        strbalanceHrsMessage = CommonFunctions.Data.CheckIsDBNull(objDRValidateEffort["BalanceHrsMessage"], "").ToString();
                    }

                    CommonFunctions.Data.DisposeDataReader(ref objDRValidateEffort);
                }
            }
            if (strbalanceHrsMessage == "")
            {
                UpdateTasks(taskStatusManagementSaveParameterList.taskStatusManagementSaveParameters);
            }
            return strbalanceHrsMessage;
        }

        private void UpdateTasks(List<TaskStatusManagementSaveParameter> taskStatusManagementSaveParameters)
        {
            string strSQLQuery = "";
            foreach (TaskStatusManagementSaveParameter item in taskStatusManagementSaveParameters)
            {
                if (item.m_intOperation == 13)
                {
                    UpdateTaskActualPercent_Start_End_Date(taskStatusManagementSaveParameters);
                    return;
                }
                else
                {
                    if (item.m_intOperation == 8)
                        strSQLQuery = "EXEC usp_Upd_AssignedTasks_Updation '" + item.TaskId + "','" + item.TaskType + "'";
                    else
                        strSQLQuery = "EXEC usp_Upd_AssignedTasks_TaskStatusManagement '" + item.TaskId + "','" + item.TaskType + "',NULL,NULL,NULL," + item.m_intOperation + "," + item.ProjectId;


                    CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, true, CommonController.connectionString);
                    int m_intFlag = 0;
                    m_intFlag = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + item.ProjectId, true, CommonController.connectionString));
                    if (m_intFlag == 1)
                    {
                        string SQL = "";
                        SQL = "EXEC Usp_Upd_UserStoryStatus '" + item.TaskId + "'," + item.ProjectId + "," + item.m_intOperation;
                        CommonFunctions.Data.InsertOrUpdateData(SQL, true, CommonController.connectionString);
                    }
                }
            }
        }
        private void UpdateTaskActualPercent_Start_End_Date(List<TaskStatusManagementSaveParameter> taskStatusManagementSaveParameters)
        {
            string strQuery = "";
            string[] arrTaskId;
            long lngTaskId;
            string strActualPercentComplete = "";
            int intCnt;
            string strTaskList;
            string strTaskActualStartDate;
            string strTaskActualEndDate;
            string ParentTaskIds = "";
            foreach (TaskStatusManagementSaveParameter item in taskStatusManagementSaveParameters)
            {
                ParentTaskIds += item.ParentTaskId + ",";
                lngTaskId = item.TaskId;
                strActualPercentComplete = item.strActualPercentComplete;
                if (strActualPercentComplete != "")
                {
                    if (item.m_intMSPIntegrationMethod != 2)
                    {
                        if (Convert.ToInt32(strActualPercentComplete) == 100)
                        {
                            strQuery = " EXEC usp_Upd_AssignedTasks_Updation  '" + lngTaskId.ToString() + "','" + item.TaskType + "'";
                            CommonFunctions.Data.InsertOrUpdateData(strQuery, true, CommonController.connectionString);
                        }
                        else
                        {
                            strQuery = "UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " + strActualPercentComplete;
                            strQuery += ",ResourcePercentComplete = " + strActualPercentComplete;
                            strQuery += " WHERE TaskId = " + lngTaskId.ToString();
                            CommonFunctions.Data.InsertOrUpdateData(strQuery, true, CommonController.connectionString);
                        }
                    }
                    else
                    {
                        if (item.TaskType == "O")
                        {
                            if (Convert.ToInt32(strActualPercentComplete) == 100)
                            {
                                strQuery = " EXEC usp_Upd_AssignedTasks_Updation  '" + lngTaskId.ToString() + "','" + item.TaskType + "'";
                                CommonFunctions.Data.InsertOrUpdateData(strQuery, true, CommonController.connectionString);
                            }
                            else
                            {
                                strQuery = "UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " + strActualPercentComplete;
                                strQuery += ",ResourcePercentComplete = " + strActualPercentComplete;
                                strQuery += " WHERE TaskId = " + lngTaskId.ToString();
                                CommonFunctions.Data.InsertOrUpdateData(strQuery, true, CommonController.connectionString);
                            }

                        }
                        else if (item.TaskType == "M")
                        {
                            strTaskActualStartDate = item.strTaskActualStartDate;
                            strTaskActualEndDate = item.strTaskActualEndDate;


                            if (Convert.ToInt32(strActualPercentComplete) == 100)
                            {
                                strQuery = "UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " + strActualPercentComplete;
                                strQuery += ",ResourcePercentComplete = " + strActualPercentComplete;
                                strQuery += ",ActualStartDate='" + strTaskActualStartDate + "',ActualEndDate='" + strTaskActualEndDate;
                                strQuery += "',IsTaskComplete=1 WHERE TaskId = " + lngTaskId.ToString();
                            }
                            else
                            {
                                strQuery = "UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " + strActualPercentComplete;
                                strQuery += ",ResourcePercentComplete = " + strActualPercentComplete;
                                strQuery += ",ActualStartDate='" + strTaskActualStartDate;
                                strQuery += "' WHERE TaskId = " + lngTaskId.ToString();
                            }

                        }
                        CommonFunctions.Data.InsertOrUpdateData(strQuery, true, CommonController.connectionString);
                    }
                }
            }
          
            CommonFunctions.Data.InsertOrUpdateData("usp_UPD_ActualPercentComplete_forParentTask '" + ParentTaskIds + "',1", true, CommonController.connectionString);
            //CommonFunctions.Data.InsertOrUpdateData("usp_UPD_ActualPercentComplete_forParentTask '" + GTaskIds + "',NULL", true, CommonController.connectionString);
        }
    }
}
