using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WhizibleAPI.App_Start;
using WhizibleAPI.Models.Task;
using WhizibleAPI.Models.TaskMapping;

namespace WhizibleAPI.Controllers
{
    public class TaskMappingController : ApiController
    {
        private int getRecordCountForColumn(string columnName, int projectId)
        {
            string strSQL = "usp_Sel_tbl_PM_ProjectTasks_TaskDetails " + projectId + ",'" + columnName.Trim() + "','TaskName','ASC','-1','C'";
            return Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "0"));
        }

        [Authorize, ValidateHeaders, HttpPost]
        public TaskMappingReferences GetTaskReferences([FromBody] FilterParameters filterParameters)
        {
            TaskMappingReferences dropdownValues = new TaskMappingReferences();
            string m_strProjectTypeID = "";
            string strSQL = "usp_Sel_tbl_PM_Project " + filterParameters.ProjectId;
            IDataReader objDR = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (objDR.Read())
            {
                m_strProjectTypeID = CommonFunctions.Data.CheckIsDBNull(objDR["ProjectTypeID"], "").ToString() + "";
            }
            CommonFunctions.Data.DisposeDataReader(ref objDR);

            strSQL = "usp_Sel_tbl_PRS_ProjectTypes " + m_strProjectTypeID;
            objDR = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (objDR.Read())
            {
                dropdownValues.ShowPhases = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(objDR["ShowPhaseInAT"], "0").ToString());
                dropdownValues.ShowModules = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(objDR["ShowModuleInAT"], "0").ToString());
                dropdownValues.ShowSubProjects = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(objDR["ShowSubProjectInAT"], "0").ToString());
                dropdownValues.ShowMilestones = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(objDR["ShowMilestoneInAT"], "0").ToString());
                dropdownValues.ShowFeatures = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(objDR["ShowFeatureInAT"], "0").ToString());
            }

            dropdownValues.TaskTypes = new List<Models.Reference.StringReference>();
            dropdownValues.CountOfTaskInTaskTypes = getRecordCountForColumn("ModuleName", filterParameters.ProjectId);
            DataTable OpTable = CommonFunctions.Data.GetDataTable("EXEC usp_Sel_tbl_PM_Project_TaskTypes_Names_New " + filterParameters.ProjectId + "", true, CommonController.connectionString);
            foreach (DataRow opRow in OpTable.Rows)
            {
                string[] taskType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["TaskTypeID"], "")).Split(char.Parse("|"));
                dropdownValues.TaskTypes.Add(new Models.Reference.StringReference() { Id = taskType[0], Name = taskType[1] });
            }
            dropdownValues.Phases = new List<Models.Reference.StringReference>();
            if (dropdownValues.ShowPhases)
            {
                dropdownValues.CountOfTaskInPhases = getRecordCountForColumn("Phase", filterParameters.ProjectId);
                OpTable = CommonFunctions.Data.GetDataTable("EXEC Usp_Sel_tbl_IB_Project_Phases " + filterParameters.ProjectId + ",null,0,'T'", true, CommonController.connectionString);
                foreach (DataRow opRow in OpTable.Rows)
                {
                    dropdownValues.Phases.Add(new Models.Reference.StringReference()
                    {
                        Id = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ProjectPhaseID"], "0")),
                        Name = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["Phase"], ""))
                    });
                }
            }

            dropdownValues.Modules = new List<Models.Reference.StringReference>();
            if (dropdownValues.ShowModules)
            {
                dropdownValues.CountOfTaskInModules = getRecordCountForColumn("Module", filterParameters.ProjectId);
                OpTable = CommonFunctions.Data.GetDataTable("EXEC Usp_Sel_tbl_PM_Module " + filterParameters.ProjectId + ",NULL,'T'," + filterParameters.TaskId, true, CommonController.connectionString);
                foreach (DataRow opRow in OpTable.Rows)
                {
                    string[] taskType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ModuleId"], "")).Split(char.Parse("|"));
                    dropdownValues.Modules.Add(new Models.Reference.StringReference() { Id = taskType[0], Name = taskType[1] });
                }
            }

            dropdownValues.SubProjects = new List<Models.Reference.StringReference>();
            if (dropdownValues.ShowSubProjects)
            {
                dropdownValues.CountOfTaskInSubProjects = getRecordCountForColumn("SubProject", filterParameters.ProjectId);
                OpTable = CommonFunctions.Data.GetDataTable("EXEC usp_Sel_tbl_PM_SubProject " + filterParameters.ProjectId + ",NULL,'C'", true, CommonController.connectionString);
                foreach (DataRow opRow in OpTable.Rows)
                {
                    dropdownValues.SubProjects.Add(new Models.Reference.StringReference()
                    {
                        Id = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["SubProjectId"], "")),
                        Name = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["SubProjectName"], ""))
                    });
                }
            }

            dropdownValues.Milestones = new List<Models.Reference.StringReference>();
            if (dropdownValues.ShowMilestones)
            {
                dropdownValues.CountOfTaskInMilestones = getRecordCountForColumn("Milestone", filterParameters.ProjectId);
                OpTable = CommonFunctions.Data.GetDataTable("EXEC usp_Sel_tbl_PM_Milestones " + filterParameters.ProjectId + ",'C'," + filterParameters.TaskId, true, CommonController.connectionString);
                foreach (DataRow opRow in OpTable.Rows)
                {
                    dropdownValues.Milestones.Add(new Models.Reference.StringReference()
                    {
                        Id = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["MilestoneId"], "")),
                        Name = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["Milestone"], ""))
                    });
                }
            }
            dropdownValues.Features = new List<Models.Reference.StringReference>();
            if (dropdownValues.ShowFeatures)
            {
                dropdownValues.CountOfTaskInFeatures = getRecordCountForColumn("ProjectFeatureID", filterParameters.ProjectId);
                OpTable = CommonFunctions.Data.GetDataTable("EXEC usp_Sel_tbl_PM_Project_Features NULL," + filterParameters.ProjectId + "", true, CommonController.connectionString);
                foreach (DataRow opRow in OpTable.Rows)
                {
                    dropdownValues.Features.Add(new Models.Reference.StringReference()
                    {
                        Id = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ProjectFeatureID"], "")),
                        Name = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["FeatureName"], ""))
                    });
                }
            }
            dropdownValues.Deliverables = new List<Models.Reference.StringReference>();
            dropdownValues.CountOfTaskInDeliverables = getRecordCountForColumn("DeliverableID", filterParameters.ProjectId);
            OpTable = CommonFunctions.Data.GetDataTable("EXEC usp_Sel_tbl_PM_OtherSchedules_FillCombo " + filterParameters.ProjectId + "", true, CommonController.connectionString);
            foreach (DataRow opRow in OpTable.Rows)
            {
                dropdownValues.Deliverables.Add(new Models.Reference.StringReference()
                {
                    Id = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["DeliverableID"], "")),
                    Name = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["DeliverableTitle"], ""))
                });
            }
            return dropdownValues;
        }


        [Authorize, ValidateHeaders, HttpPost]
        public IHttpActionResult ExecuteTaskMapping([FromBody] ExecuteInputParameters executeInputParameters)
        {

            string m_strSQLQuery = "";
            string strSQL = "";
            switch (executeInputParameters.Mode)
            {
                case "RUN":

                    strSQL = " Where ProjectID=" + executeInputParameters.ProjectID + " AND IsActive=1 ";


                    if (executeInputParameters.SelectedValue == "Assigned Task")
                        strSQL += "   AND (WhichTask <>''Assigned Task'' AND WhichTask <>''General Task'' OR (WhichTask=''Assigned Task'' AND ParentTask_UID IS NULL))";
                    if (executeInputParameters.SelectedValue == "Assigned Issues")
                        strSQL += "   AND (WhichTask <>''Assigned Task'' AND WhichTask <>''General Task'' OR (WhichTask=''Assigned Issues'' AND ParentTask_UID IS NULL))";

                    if (executeInputParameters.Execute != "EXECUTE") strSQL += " And 1=2 ";

                    if (executeInputParameters.WhereClause != "")
                    {
                        strSQL += " And ( " + CommonFunctions.General.BuildQueryString(executeInputParameters.WhereClause) + " ) ";
                        strSQL += " And  ParentTask_UID IS NULL ";
                        if (strSQL.IndexOf("TaskType", 0) != -1)
                            strSQL = strSQL.Replace(" TaskType ", " ModuleName ");
                    }

                    if (executeInputParameters.Alphabet != "-1")
                        strSQL += " AND LTRIM(RTRIM(LEFT(ISNULL(TaskName,''''),1))) = ''" + CommonFunctions.General.BuildQueryString(executeInputParameters.Alphabet) + "'' ";


                    strSQL += " ORDER BY " + executeInputParameters.OrderBy + " " + executeInputParameters.SortOrder;
                    string strCheckSQL = "";
                    //Commented and Added By Riddhesh Patil on 15 May 2023 for Invalid Query Alert
                    //strCheckSQL = "Exec usp_Sel_QRB_QueriesForEntity_ProjectTasks '" + strSQL + "','T'";
                    strCheckSQL = "Exec usp_Whizible2_Sel_QRB_QueriesForEntity_ProjectTasks '" + strSQL + "','T',''";
                    //End of commented and Added By Riddhesh Patil on 15 May 2023 for Invalid Query Alert
                    string errorMessage = "";
                    bool m_blnIsValidQuery = CommonFunctions.Data.ValidateQuery(strCheckSQL, true, CommonController.connectionString, ref errorMessage);

                    if (m_blnIsValidQuery == true)
                        //m_strSQLQuery = "Exec usp_Sel_QRB_QueriesForEntity_ProjectTasks '" + strSQL + "','T'";
                        m_strSQLQuery = "Exec usp_Whizible2_Sel_QRB_QueriesForEntity_ProjectTasks '" + strSQL + "','T','" + m_blnIsValidQuery + "'";
                    else
                    {
                        //m_strSQLQuery = "Exec usp_Sel_QRB_QueriesForEntity_ProjectTasks '" + " Where ProjectID=" + executeInputParameters.ProjectID + " AND IsActive=1 ";
                        //Commented and Added By Riddhesh Patil on 15 May 2023 for Invalid Query Alert
                        //m_strSQLQuery = "Exec usp_Whizible2_Sel_QRB_QueriesForEntity_ProjectTasks '" + " Where ProjectID=" + executeInputParameters.ProjectID + " AND IsActive=1 ";
                        m_strSQLQuery = "Exec usp_Whizible2_Sel_QRB_QueriesForEntity_ProjectTasks '" + " Where ProjectID=" + "',"+ executeInputParameters.ProjectID +", AND IsActive=1 ,'T','"+ m_blnIsValidQuery + "' ";
                        //Commented and Added By Riddhesh Patil on 15 May 2023 for Invalid Query Alert
                        if (executeInputParameters.Execute != "Execute") strSQL += " And 1=2 ";
                        m_strSQLQuery += " ' ";
                    }
                    break;

                case "COUNT":
                    m_strSQLQuery = "usp_Sel_tbl_PM_ProjectTasks_TaskDetails " + executeInputParameters.ProjectID + ",'" + executeInputParameters.ColumnName + "','" + executeInputParameters.OrderBy + "','" + executeInputParameters.SortOrder + "','" + executeInputParameters.Alphabet + "'";
                    break;
            }
            DataTable dt = CommonFunctions.Data.GetDataTable(m_strSQLQuery, true, CommonController.connectionString);
            return Ok(dt);
        }

        [Authorize, ValidateHeaders, HttpPost]
        public IHttpActionResult SaveTaskDetails([FromBody] TaskSaveParameters taskSaveParameters)
        {
            string strSQL = "";
            string strSET = "";
            bool blnAddQuama;
            foreach (TaskParameters item in taskSaveParameters.taskParameters)
            {
                switch (item.Action)
                {
                    case "CLEAR":
                        var ColumnID = "";
                        if (item.ColumnName == "PHASE")
                        {
                            ColumnID = "PhaseID";
                        }

                        else if (item.ColumnName == "SUBPROJECT")
                        {
                            ColumnID = "SubProjectID";
                        }

                        else if (item.ColumnName == "MODULE")
                        {
                            ColumnID = "ModuleID";
                        }
                        else if (item.ColumnName == "MILESTONE")
                        {
                            ColumnID = "MilestoneID";
                        }
                        else if (item.ColumnName == "PROJECTFEATUREID")
                        {
                            ColumnID = "ProjectFeatureID";
                        }
                        else if (item.ColumnName == "DELIVERABLEID")
                        {
                            ColumnID = "DeliverableID";
                        }

                        strSQL = "usp_upd_tbl_PM_ProjectTasks_SetMapping " + item.ProjectId + ",'" + item.ColumnName + "','" + item.TaskId + "','NULL','" + ColumnID + "'";
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                        break;
                    case "SAVE":

                        switch (item.Mode)
                        {
                            case "COUNT":
                                switch (item.ColumnName)
                                {
                                    case "PHASE":
                                        strSET = " Set PhaseID=" + item.ColumnValueInt + ",";
                                        strSET += " Phase='" + item.ColumnValueString + "'";
                                        break;

                                    case "MODULENAME":
                                        strSET = " Set TaskTypeID=" + item.ColumnValueInt + ",";
                                        strSET += " ModuleName='" + item.ColumnValueString + "'";
                                        break;


                                    case "MODULE":
                                        strSET = " Set ModuleID=" + item.ColumnValueInt + ",";
                                        strSET += " Module='" + item.ColumnValueString + "'";

                                        break;
                                    case "SUBPROJECT":
                                        strSET = " Set SubProjectID=" + item.ColumnValueInt + ",";
                                        strSET += " Subproject='" + item.ColumnValueString + "'";
                                        break;

                                    case "MILESTONE":
                                        strSET = " Set MilestoneID=" + item.ColumnValueInt + ",";
                                        strSET += " Milestone='" + item.ColumnValueString + "'";

                                        break;
                                    case "PROJECTFEATUREID":
                                        strSET = " set ProjectFeatureID=" + item.ColumnValueInt;
                                        break;
                                    case "DELIVERABLEID":
                                        strSET = " Set DeliverableID=" + item.ColumnValueInt;
                                        break;
                                }

                                break;
                            case "RUN":
                                strSET = " Set ";
                                blnAddQuama = false;

                                if (item.Phase != "")
                                {
                                    strSET += " PhaseID=" + item.PhaseId + ",";
                                    strSET += " Phase='" + item.Phase + "'";
                                    blnAddQuama = true;
                                }
                                if (item.TaskType != "")
                                {
                                    string strQuery = "usp_UPD_tbl_PM_ProjectTasks_TaskManagement " + item.TaskTypeId + ",'" + item.TaskType + "','" + item.TaskId + "'";
                                    CommonFunctions.Data.InsertOrUpdateData(strQuery, true, CommonController.connectionString);
                                }
                                if (item.Module != "")
                                {
                                    if (blnAddQuama == true) strSET += " ,";
                                    strSET += " ModuleID=" + item.ModuleId + ",";
                                    strSET += " Module='" + item.Module + "'";
                                    blnAddQuama = true;
                                }
                                if (item.SubProject != "")
                                {
                                    if (blnAddQuama == true) strSET += " ,";
                                    strSET += " SubProjectID=" + item.SubProjectId + ",";
                                    strSET += " Subproject='" + item.SubProject + "'";
                                    blnAddQuama = true;
                                }
                                if (item.Milestone != "")
                                {
                                    if (blnAddQuama == true) strSET += " ,";
                                    strSET += " MilestoneID=" + item.MilestoneId + ",";
                                    strSET += " Milestone='" + item.Milestone + "'";
                                    blnAddQuama = true;
                                }
                                if (item.FeatureId != 0)
                                {
                                    if (blnAddQuama == true) strSET += " ,";
                                    strSET += " ProjectFeatureID=" + item.FeatureId;
                                    blnAddQuama = true;
                                }


                                if (item.DeliverableId != 0)
                                {
                                    if (blnAddQuama == true) strSET += " ,";

                                    strSET += " DeliverableID=" + item.DeliverableId + ",";
                                    strSET += " DeliverableTypeID = " + Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_OtherSchedules_ScheduleTypeID " + item.DeliverableId, true, CommonController.connectionString), "0"));
                                    blnAddQuama = true;
                                }



                                break;
                        }

                        if (strSET != "" && strSET.Trim().ToUpper() != "SET")
                        {
                            strSQL = "UPDATE tbl_PM_ProjectTasks " + strSET + " WHERE TaskID IN (" + item.TaskId + ")";
                            strSQL += " OR ( ParentTask_UID IN (" + item.TaskId + "))";
                            CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                        }
                        break;
                }
            }
            return Ok("Success");
        }
    }
}
