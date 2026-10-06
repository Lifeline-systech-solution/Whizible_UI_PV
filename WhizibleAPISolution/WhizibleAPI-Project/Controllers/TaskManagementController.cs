using Microsoft.VisualBasic;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WhizibleAPI.App_Start;
using WhizibleAPI.Models.Employee;
using WhizibleAPI.Models.Task;

namespace WhizibleAPI.Controllers
{
    public class TaskManagementController : ApiController
    {
        [Authorize, ValidateHeaders]
        [HttpPost]
        public List<Task> GetTaskList([FromBody] TaskInput taskInput)
        {

            List<Task> tasks = new List<Task>();
            DataTable OpTable;
            OpTable = CommonFunctions.Data.GetDataTable("EXEC usp_Sel_ProjectTasks '" + taskInput.Flag + "'," + taskInput.ProjectId + ",'" + taskInput.PageNumber + "'," + taskInput.EmployeeId + ",'" + taskInput.SortBy + "','" + taskInput.ActiveAll + "'", true, CommonController.connectionString);
            decimal totalActualWork = 0;
            decimal totalBaselineWork = 0;
            decimal totalCurrentWork = 0;
            foreach (DataRow opRow in OpTable.Rows)
            {
                Task task = new Task();
                task.ActualDecimalWork = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ActualDecimalWork"], "0"));
                totalActualWork += Convert.ToDecimal(task.ActualDecimalWork);
                task.ActualDuration = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ActualDuration"], "0"));
                task.ActualPercentComplete = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ActualPercentComplete"], "0"));
                task.ActualWork = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ActualWork"], "0"));
                task.ActualDecimalWorkHHMM = Convert.ToString(CommonFunctions.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + task.ActualDecimalWork + "',1)", true, CommonController.connectionString));
                task.BaseLineDecimalWork = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["BaseLineDecimalWork"], "0"));
                totalBaselineWork += Convert.ToDecimal(task.BaseLineDecimalWork);
                task.BaseLineDecimalWorkHHMM = Convert.ToString(CommonFunctions.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + task.BaseLineDecimalWork + "',1)", true, CommonController.connectionString));
                task.BaseLineDuration = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["BaseLineDuration"], "0"));
                task.BaseLineWork = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["BaseLineWork"], "0"));
                task.BillableYN = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(opRow["BillableYN"], "False"));
                task.CurrentDecimalWork = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["CurrentDecimalWork"], "0"));
                task.CurrentDecimalWorkHHMM = Convert.ToString(CommonFunctions.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + task.CurrentDecimalWork + "',1)", true, CommonController.connectionString));
                totalCurrentWork += Convert.ToDecimal(task.CurrentDecimalWork);
                task.CurrentDuration = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["CurrentDuration"], "0"));
                task.CurrentStart = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["CurrentStart"], ""));
                task.CurrentStart = task.CurrentStart != "" ? Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(opRow["CurrentStart"])).ToString("d-MMM-yyyy") : "";
                task.CurrentEnd = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["CurrentEnd"], ""));
                task.CurrentEnd = task.CurrentEnd != "" ? Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(opRow["CurrentEnd"])).ToString("d-MMM-yyyy") : "";
                task.BaseLineStart = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["BaseLineStart"], ""));
                task.BaseLineStart = task.BaseLineStart != "" ? Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(opRow["BaseLineStart"])).ToString("d-MMM-yyyy") : "";
                task.BaseLineEnd = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["BaseLineEnd"], ""));
                task.BaseLineEnd = task.BaseLineEnd != "" ? Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(opRow["BaseLineEnd"])).ToString("d-MMM-yyyy") : "";
                task.ActualStart = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ActualStart"], ""));
                task.ActualStart = task.ActualStart != "" ? Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(opRow["ActualStart"])).ToString("d-MMM-yyyy") : "";
                task.ActualEnd = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ActualEnd"], ""));
                task.ActualEnd = task.ActualEnd != "" ? Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(opRow["ActualEnd"])).ToString("d-MMM-yyyy") : "";
                task.CurrentWork = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["CurrentWork"], "0"));
                task.IsActive = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(opRow["IsActive"], "False"));
                task.IsTaskComplete = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(opRow["IsTaskComplete"], "False"));
                task.IsUserStoryTask = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(opRow["IsUserStoryTask"], "False"));
                task.ModuleName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ModuleName"], ""));
                task.Priority = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["Priority"], ""));
                task.TaskID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["TaskID"], "0"));
                task.TaskName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["TaskName"], ""));
                task.TaskOnHold = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(opRow["TaskOnHold"], "False"));
                ////task.UserName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["UserName"], ""));
                tasks.Add(task);
            }
            int counter = 0;
            foreach (Task task in tasks)
            {
                if(counter == 0)
                {
                    task.TotalActualDecimalWorkHHMM = Convert.ToString(CommonFunctions.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + totalActualWork + "',1)", true, CommonController.connectionString));
                    task.TotalBaseLineDecimalWorkHHMM = Convert.ToString(CommonFunctions.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + totalBaselineWork + "',1)", true, CommonController.connectionString));
                    task.TotalCurrentDecimalWorkHHMM = Convert.ToString(CommonFunctions.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + totalCurrentWork + "',1)", true, CommonController.connectionString));
                }
                counter++;
            }
            return tasks;
        }

        [Authorize, ValidateHeaders]
        [HttpPost]
        public List<Employee> GetEmployees([FromBody] int projectId)
        {
            List<Employee> employees = new List<Employee>();
            DataTable OpTable;
            OpTable = CommonFunctions.Data.GetDataTable("EXEC usp_Sel_teammembers " + projectId, true, CommonController.connectionString);

            foreach (DataRow opRow in OpTable.Rows)
            {
                Employee employee = new Employee()
                {
                    EmployeeId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["EmployeeId"], "")),
                    EmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["UserName"], "")),
                };
                employees.Add(employee);
            }
            return employees;
        }

        [Authorize, ValidateHeaders]
        [HttpPost]
        public List<BaselineTask> GetTaskBaseline([FromBody] int taskId)
        {
            List<BaselineTask> baselineTasks = new List<BaselineTask>();
            DataTable OpTable;
            string m_strSortBy = "BaselineChangeDate";
            string m_strSortOrder = "ASC";
            OpTable = CommonFunctions.Data.GetDataTable("EXEC usp_Sel_tbl_PM_TaskBaselines " + taskId + ",'" + m_strSortBy + "','" + m_strSortOrder + "'", true, CommonController.connectionString);

            foreach (DataRow opRow in OpTable.Rows)
            {
                BaselineTask baselineTask = new BaselineTask()
                {
                    BaselineChangeDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["BaselineChangeDate"], "")),
                    BaselineEndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["BaselineEndDate"], "")),
                    BaselineStartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["BaselineStartDate"], "")),
                    Duration = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["Duration"], "")),
                    EndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["EndDate"], "")),
                    StartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["StartDate"], "")),
                    Work = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["Work"], "")) != "" ?  Convert.ToString(CommonFunctions.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + opRow["Work"] + "',1)", true, CommonController.connectionString)) : "",
                };
                baselineTask.BaselineStartDate = baselineTask.BaselineStartDate != "" ? Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(opRow["BaselineStartDate"])).ToString("d-MMM-yyyy") : "";
                baselineTask.BaselineEndDate = baselineTask.BaselineEndDate != "" ? Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(opRow["BaselineEndDate"])).ToString("d-MMM-yyyy") : "";
                baselineTask.EndDate = baselineTask.EndDate != "" ? Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(opRow["EndDate"])).ToString("d-MMM-yyyy") : "";
                baselineTask.StartDate = baselineTask.StartDate != "" ? Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(opRow["StartDate"])).ToString("d-MMM-yyyy") : "";
                baselineTask.BaselineChangeDate = baselineTask.BaselineChangeDate != "" ? Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(opRow["BaselineChangeDate"])).ToString("d-MMM-yyyy") : "";
                baselineTasks.Add(baselineTask);
            }
            return baselineTasks;
        }

        [Authorize, ValidateHeaders]
        [HttpPost]
        public string SaveTaskActualCompletion([FromBody] TaskActualPercentageList taskActualPercentageList)
        {
            foreach (TaskActualPercentage taskActualPercentage in taskActualPercentageList.taskActualPercentages)
            {
                string strQuery = "";
                int lngTaskId = taskActualPercentage.TaskId;
                string strActualPercentComplete = taskActualPercentage.ActualPercentage;
                string strActualPercentCompletetemp = taskActualPercentage.PrevActualPercentage;
                string m_strTaskType = taskActualPercentage.m_strTaskType;
                if (strActualPercentComplete != "" && strActualPercentCompletetemp != strActualPercentComplete)
                {
                    if (Convert.ToInt32(strActualPercentComplete) == 100)
                    {
                        strQuery = " EXEC usp_Upd_AssignedTasks_Updation  '" + lngTaskId.ToString() + "','" + m_strTaskType + "'";
                        CommonFunctions.Data.InsertOrUpdateData(strQuery, true, CommonController.connectionString);
                    }
                    else
                    {
                        strQuery = "UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " + strActualPercentComplete;
                        strQuery += ",ResourcePercentComplete = " + strActualPercentComplete;
                        strQuery += " WHERE TaskId = " + lngTaskId.ToString();
                        CommonFunctions.Data.InsertOrUpdateData(strQuery, true, CommonController.connectionString);
                        strQuery = "UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " + strActualPercentComplete;
                        strQuery += ",ResourcePercentComplete = " + strActualPercentComplete;
                        strQuery += " WHERE ParentTask_UID = " + lngTaskId.ToString();
                        CommonFunctions.Data.InsertOrUpdateData(strQuery, true, CommonController.connectionString);
                    }
                }
            }
            return "Success";
        }

        [Authorize, ValidateHeaders]
        [HttpPost]
        public string SaveTaskBillableActive([FromBody] TaskBillableActiveList taskBillableActiveList)
        {

            foreach (TaskBillableActive taskBillableActive in taskBillableActiveList.taskBillableActives)
            {
                string strQuery = "";
                int lngTaskId = taskBillableActive.TaskId;
                bool Billable = taskBillableActive.Billable;
                bool Active = taskBillableActive.Active;
                int m_lngProjectId = taskBillableActive.m_lngProjectId;
                if (!Active)
                {
                    strQuery = "UPDATE tbl_PM_ProjectTasks SET  IsActive = 1 WHERE (TaskId  IN (" + lngTaskId + ") ";
                    strQuery += " OR TaskID IN (SELECT DISTINCT TaskID FROM tbl_PM_ProjectTasks WHERE IsActive=0 AND ParentTask_UID IN (" + lngTaskId + "))";
                    strQuery += ") AND ProjectId=" + m_lngProjectId.ToString();
                    CommonFunctions.Data.InsertOrUpdateData(strQuery, true, CommonController.connectionString);
                }
                else
                {
                    strQuery = "UPDATE tbl_PM_ProjectTasks SET  IsActive = 0  WHERE (TaskId  IN (" + lngTaskId + ") ";
                    strQuery += " OR TaskID IN (SELECT DISTINCT TaskID FROM tbl_PM_ProjectTasks WHERE IsActive=1 AND ParentTask_UID IN (" + lngTaskId + "))";
                    strQuery += ")  AND ProjectId=" + m_lngProjectId.ToString();

                    CommonFunctions.Data.InsertOrUpdateData(strQuery, true, CommonController.connectionString);
                }
            }
            return "Success";
        }

        [Authorize,ValidateHeaders,HttpPost]
        public Task GetTaskDetails([FromBody] int taskId)
        {
            Task task = new Task();
            DataTable OpTable = CommonFunctions.Data.GetDataTable("EXEC usp_Sel_tbl_PM_ProjectTasks_TaskManagement " + taskId + "", true, CommonController.connectionString);
            foreach (DataRow opRow in OpTable.Rows)
            {
                task.TaskName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["TaskName"], ""));
                task.PhaseId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["PhaseId"], "0"));
                task.ModuleId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["ModuleId"], "0"));
                task.SubProjectId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["SubProjectId"], "0"));
                task.MilestoneId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["MilestoneId"], "0"));
                task.ProjectFeatureId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["ProjectFeatureID"], "0"));
                task.DeliverableId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["DeliverableId"], "0"));
                task.TaskTypeId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["TaskTypeId"], "0"));
            }
            return task;
        }

        [Authorize, ValidateHeaders, HttpPost]
        public List<Task> GetTaskListForSelectMore([FromBody] int projectId)
        {
            List<Task> tasks = new List<Task>();
            DataTable OpTable = CommonFunctions.Data.GetDataTable("EXEC usp_sel_tbl_PM_ProjectTasks " + projectId + "", true, CommonController.connectionString);
            foreach (DataRow opRow in OpTable.Rows)
            {
                Task task = new Task();
                task.TaskID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["TaskId"], "0"));
                task.TaskName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["TaskName"], ""));
                tasks.Add(task);
            }
            return tasks;
        }

        [Authorize, ValidateHeaders, HttpPost]
        public string SaveTaskListForSelectMore([FromBody] SaveSelectMoreParameter saveSelectMoreParameter)
        {
            CommonFunctions.Data.InsertOrUpdateData("EXEC usp_ins_PM_ProjectTask '" + saveSelectMoreParameter.TaskIds + "'," + saveSelectMoreParameter.ProjectId + "", true, CommonController.connectionString);
            return "Success";
        }

        [Authorize, ValidateHeaders, HttpPost]
        public DropdownValues GetTaskReferences([FromBody] FilterParameters filterParameters)
        {
            DropdownValues dropdownValues = new DropdownValues();
            dropdownValues.TaskTypes = new List<Models.Reference.References>();
            DataTable OpTable = CommonFunctions.Data.GetDataTable("EXEC usp_Sel_tbl_PM_Project_TaskTypes_Names_New " + filterParameters.ProjectId + "", true, CommonController.connectionString);
            foreach (DataRow opRow in OpTable.Rows)
            {
                string[] taskType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["TaskTypeID"], "")).Split(char.Parse("|"));
                dropdownValues.TaskTypes.Add(new Models.Reference.References() { Id = Convert.ToInt32(taskType[0]), Name = taskType[1] });
            }
            dropdownValues.Phases = new List<Models.Reference.References>();
            OpTable = CommonFunctions.Data.GetDataTable("EXEC Usp_Sel_tbl_IB_Project_Phases " + filterParameters.ProjectId + ",null,0,'T'", true, CommonController.connectionString);
            foreach (DataRow opRow in OpTable.Rows)
            {
                dropdownValues.Phases.Add(new Models.Reference.References() { 
                    Id = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["ProjectPhaseID"], "0")), 
                    Name = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["Phase"], ""))
                });
            }
            dropdownValues.Modules = new List<Models.Reference.References>();
            OpTable = CommonFunctions.Data.GetDataTable("EXEC Usp_Sel_tbl_PM_Module " + filterParameters.ProjectId + ",NULL,'T'," + filterParameters.TaskId, true, CommonController.connectionString);
            foreach (DataRow opRow in OpTable.Rows)
            {
                string[] taskType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ModuleId"], "")).Split(char.Parse("|"));
                dropdownValues.Modules.Add(new Models.Reference.References() { Id = Convert.ToInt32(taskType[0]), Name = taskType[1] });
            }
            dropdownValues.SubProjects = new List<Models.Reference.References>();
            OpTable = CommonFunctions.Data.GetDataTable("EXEC usp_Sel_tbl_PM_SubProject " + filterParameters.ProjectId + ",NULL,'C'", true, CommonController.connectionString);
            foreach (DataRow opRow in OpTable.Rows)
            {
                dropdownValues.SubProjects.Add(new Models.Reference.References()
                {
                    Id = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["SubProjectId"], "0")),
                    Name = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["SubProjectName"], ""))
                });
            }
            dropdownValues.Milestones = new List<Models.Reference.References>();
            OpTable = CommonFunctions.Data.GetDataTable("EXEC usp_Sel_tbl_PM_Milestones " + filterParameters.ProjectId + ",'C'," + filterParameters.TaskId, true, CommonController.connectionString);
            foreach (DataRow opRow in OpTable.Rows)
            {
                dropdownValues.Milestones.Add(new Models.Reference.References()
                {
                    Id = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["MilestoneId"], "0")),
                    Name = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["Milestone"], ""))
                });
            }
            dropdownValues.Features = new List<Models.Reference.References>();
            OpTable = CommonFunctions.Data.GetDataTable("EXEC usp_Sel_tbl_PM_Project_Features NULL," + filterParameters.ProjectId + "", true, CommonController.connectionString);
            foreach (DataRow opRow in OpTable.Rows)
            {
                dropdownValues.Features.Add(new Models.Reference.References()
                {
                    Id = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["ProjectFeatureID"], "0")),
                    Name = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["FeatureName"], ""))
                });
            }
            dropdownValues.Deliverables = new List<Models.Reference.References>();
            OpTable = CommonFunctions.Data.GetDataTable("EXEC usp_Sel_tbl_PM_OtherSchedules_FillCombo " + filterParameters.ProjectId + "", true, CommonController.connectionString);
            foreach (DataRow opRow in OpTable.Rows)
            {
                dropdownValues.Deliverables.Add(new Models.Reference.References()
                {
                    Id = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["DeliverableID"], "0")),
                    Name = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["DeliverableTitle"], ""))
                });
            }
            return dropdownValues;
        }

        [Authorize, ValidateHeaders]
        [HttpPost]
        public string UpdateTaskType([FromBody] UpdateTaskInput updateTaskInput)
        {
            string deliverableTypeID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_OtherSchedules_ScheduleTypeID " + updateTaskInput.DeliverableId, true, CommonController.connectionString), "0"));
            if(deliverableTypeID == "" || deliverableTypeID == null)
            {
                deliverableTypeID = "0";
            }

            string strQuery = "";
            strQuery = "UPDATE tbl_PM_ProjectTasks SET ";
            strQuery += "	TaskTypeID = " + updateTaskInput.TaskTypeId + ", ModuleName = '" + updateTaskInput.TaskType + "',";
            strQuery += "	PhaseID = " + updateTaskInput.PhaseId + ",Phase ='" + updateTaskInput.Phase + "',";
            strQuery += "	ModuleID = " + updateTaskInput.ModuleId + ",Module ='" + updateTaskInput.Module + "',";
            strQuery += "	SubProjectID = " + updateTaskInput.SubProjectId + ", SubProject = '" + updateTaskInput.SubProject + "',";
            strQuery += "	MilestoneID = " + updateTaskInput.MilestoneId + ", Milestone = '" + updateTaskInput.Milestone + "',";
            strQuery += "	ProjectFeatureID = " + updateTaskInput.FeatureId + ",";
            strQuery += "	DeliverableID = " + updateTaskInput.DeliverableId +",";
           // strQuery += "	DeliverableTypeID = " + deliverableTypeID != "" ? deliverableTypeID : "Null";
            strQuery += "	DeliverableTypeID = " + deliverableTypeID;
            strQuery += " WHERE	 (TaskID = " + updateTaskInput.TaskId;
            strQuery += " OR ParentTask_UID = " + updateTaskInput.TaskId + ")";
            CommonFunctions.Data.InsertOrUpdateData(strQuery, true, CommonController.connectionString);
            return "Success";
        }

        public class SaveSelectMoreParameter
        {
            public string TaskIds { get; set; }
            public int ProjectId { get; set; }
        }
    }
}
