using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WhizibleAPI.Models.PM;
using System.Data;

namespace WhizibleAPI.Controllers
{
    public class PM_GraphAndOtherInformationController : ApiController
    {
        [HttpPost]
        ////Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetProjectInformation([FromBody] Project_Information_input parameter)
        {
            try
            {
                PM_GraphAndOtherInformation ProjectInformationdata = new PM_GraphAndOtherInformation();

                // for get project information
                string strSQL = "usp_Whizible2_Sel_f_tbl_PM_ProjectRevision " + parameter.ProjectID;

                DataTable FillBGDatatable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                ProjectInformationdata.ProjectInformation = new List<Project_Information_Output>();
                foreach (DataRow dataRow in FillBGDatatable.Rows)
                {
                    Project_Information_Output ProjectInfoObj = new Project_Information_Output();
                    {
                        ProjectInfoObj.ProjectName = dataRow["ProjectName"].ToString();
                        ProjectInfoObj.Practice = dataRow["Practice"].ToString();
                        ProjectInfoObj.StartDate = dataRow["StartDate"].ToString();
                        ProjectInfoObj.EndDate = dataRow["EndDate"].ToString();


                    };

                    ProjectInformationdata.ProjectInformation.Add(ProjectInfoObj);
                }

                DataTable FillARDatatable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_PB_RD_ResourceDetailsForProject " + parameter.ProjectID, true, CommonController.connectionString);

                ProjectInformationdata.ActiveResources = new List<Active_Resources_output>();
                foreach (DataRow dataRow in FillARDatatable.Rows)
                {
                    Active_Resources_output ActiveObj = new Active_Resources_output();
                    {
                        ActiveObj.Resource = dataRow["Resource"].ToString();
                        ActiveObj.StartDate = dataRow["Start Date"].ToString();
                        ActiveObj.EndDate = dataRow["End Date"].ToString();
                        ActiveObj.WorkHrs = dataRow["Work(Hrs)"].ToString();
                        ActiveObj.ActualWorkHrs = dataRow["Actual Work(Hrs)"].ToString();

                    };

                    ProjectInformationdata.ActiveResources.Add(ActiveObj);
                }


                DataTable FillPDDatatable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_PB_PhaseDetailsForProject " + parameter.ProjectID, true, CommonController.connectionString);

                ProjectInformationdata.PhaseDetails = new List<Phase_Details_output>();
                foreach (DataRow dataRow in FillPDDatatable.Rows)
                {
                    Phase_Details_output PhaseObj = new Phase_Details_output();
                    {
                        PhaseObj.RequirementAnalysis = dataRow["Requirement Analysis"].ToString();
                        PhaseObj.StartDate = dataRow["Start Date"].ToString();
                        PhaseObj.EndDate = dataRow["End Date"].ToString();
                        PhaseObj.WorkHrs = dataRow["Work(Hrs)"].ToString();
                        PhaseObj.ActualWorkHrs = dataRow["Actual Work(Hrs)"].ToString();
                        PhaseObj.WorkRatio = dataRow["Work Ratio (%)"].ToString();
                        PhaseObj.PlannedTasks = dataRow["Planned Tasks"].ToString();
                        PhaseObj.CompletedTasks = dataRow["Completed Tasks"].ToString();
                        PhaseObj.TaskRatio = dataRow["Task Ratio (%)"].ToString();

                    };

                    ProjectInformationdata.PhaseDetails.Add(PhaseObj);
                }

                DataTable FillMDDatatable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_PB_ModuleDetailsForProject " + parameter.ProjectID, true, CommonController.connectionString);

                ProjectInformationdata.ModuleDetails = new List<Module_Details_output>();
                foreach (DataRow dataRow in FillMDDatatable.Rows)
                {
                    Module_Details_output ModuleObj = new Module_Details_output();
                    {
                        ModuleObj.Module = dataRow["Module"].ToString();
                        ModuleObj.StartDate = dataRow["Start Date"].ToString();
                        ModuleObj.EndDate = dataRow["End Date"].ToString();
                        ModuleObj.WorkHrs = dataRow["Work(Hrs)"].ToString();
                        ModuleObj.ActualWorkHrs = dataRow["Actual Work(Hrs)"].ToString();
                        ModuleObj.WorkRatio = dataRow["Work Ratio (%)"].ToString();
                        ModuleObj.PlannedTasks = dataRow["Planned Tasks"].ToString();
                        ModuleObj.CompletedTasks = dataRow["Completed Tasks"].ToString();
                        ModuleObj.TaskRatio = dataRow["Task Ratio (%)"].ToString();

                    };

                    ProjectInformationdata.ModuleDetails.Add(ModuleObj);
                }

                DataTable FillSPDDatatable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_PB_SubProjectDetailsForProject " + parameter.ProjectID, true, CommonController.connectionString);

                ProjectInformationdata.SubProjectDetails = new List<SubProject_Details_output>();
                foreach (DataRow dataRow in FillSPDDatatable.Rows)
                {
                    SubProject_Details_output SubProjectObj = new SubProject_Details_output();
                    {
                        SubProjectObj.SubProject = dataRow["Sub-Project"].ToString();
                        SubProjectObj.StartDate = dataRow["Start Date"].ToString();
                        SubProjectObj.EndDate = dataRow["End Date"].ToString();
                        SubProjectObj.WorkHrs = dataRow["Work(Hrs)"].ToString();
                        SubProjectObj.ActualWorkHrs = dataRow["Actual Work(Hrs)"].ToString();
                        SubProjectObj.WorkRatio = dataRow["Work Ratio (%)"].ToString();
                        SubProjectObj.PlannedTasks = dataRow["Planned Tasks"].ToString();
                        SubProjectObj.CompletedTasks = dataRow["Completed Tasks"].ToString();
                        SubProjectObj.TaskRatio = dataRow["Task Ratio (%)"].ToString();

                    };

                    ProjectInformationdata.SubProjectDetails.Add(SubProjectObj);
                }

                DataTable FillMiDDatatable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_PB_MilestoneDetailsForProject  " + parameter.ProjectID, true, CommonController.connectionString);

                ProjectInformationdata.MilestoneDetails = new List<Milestone_Details_output>();
                foreach (DataRow dataRow in FillMiDDatatable.Rows)
                {
                    Milestone_Details_output MilestoneObj = new Milestone_Details_output();
                    {
                        MilestoneObj.Milestone = dataRow["Milestone"].ToString();
                        MilestoneObj.StartDate = dataRow["Start Date"].ToString();
                        MilestoneObj.EndDate = dataRow["End Date"].ToString();
                        MilestoneObj.WorkHrs = dataRow["Work(Hrs)"].ToString();
                        MilestoneObj.ActualWorkHrs = dataRow["Actual Work(Hrs)"].ToString();
                        MilestoneObj.WorkRatio = dataRow["Work Ratio (%)"].ToString();
                        MilestoneObj.PlannedTasks = dataRow["Planned Tasks"].ToString();
                        MilestoneObj.CompletedTasks = dataRow["Completed Tasks"].ToString();
                        MilestoneObj.TaskRatio = dataRow["Task Ratio (%)"].ToString();

                    };

                    ProjectInformationdata.MilestoneDetails.Add(MilestoneObj);
                }


                DataTable FillPVCDatatable = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_PM_ProjectTasks_ProjectGraph  " + parameter.ProjectID, true, CommonController.connectionString);

                ProjectInformationdata.PlannedvsCompletedDetail = new List<Planned_vs_Completed_Task_output>();
                foreach (DataRow dataRow in FillPVCDatatable.Rows)
                {
                    Planned_vs_Completed_Task_output PVCObj = new Planned_vs_Completed_Task_output();
                    {
                        PVCObj.Tasks = dataRow["Tasks"].ToString();
                        PVCObj.Total = Convert.ToInt32(dataRow["Total"].ToString());


                    };

                    ProjectInformationdata.PlannedvsCompletedDetail.Add(PVCObj);
                }


                DataTable FillOIDatatable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_IB_Issue_OpenIssuesForProject  " + parameter.ProjectID, true, CommonController.connectionString);

                ProjectInformationdata.OpenIssueDetail = new List<Open_Issue_for_Project_output>();
                foreach (DataRow dataRow in FillOIDatatable.Rows)
                {
                    Open_Issue_for_Project_output OpenIssueObj = new Open_Issue_for_Project_output();
                    {
                        OpenIssueObj.type = dataRow["type"].ToString();
                        OpenIssueObj.Count = Convert.ToInt32(dataRow["Count"].ToString());


                    };

                    ProjectInformationdata.OpenIssueDetail.Add(OpenIssueObj);
                }

                DataTable FillTSDatatable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_ProjectTasks_TaskStatusByResource  " + parameter.ProjectID, true, CommonController.connectionString);

                ProjectInformationdata.TaskStatusDetail = new List<Task_Status_by_Resource_output>();
                foreach (DataRow dataRow in FillTSDatatable.Rows)
                {
                    Task_Status_by_Resource_output TaskStatusObj = new Task_Status_by_Resource_output();
                    {
                        TaskStatusObj.ResourceName = dataRow["ResourceName"].ToString();
                        TaskStatusObj.TasksCompleted = Convert.ToInt32(dataRow["Tasks Completed"].ToString());
                        TaskStatusObj.TasksInProgress = Convert.ToInt32(dataRow["Tasks In-Progress"].ToString());
                        TaskStatusObj.TasksNotYetStarted = Convert.ToInt32(dataRow["Tasks Not Yet Started"].ToString());


                    };

                    ProjectInformationdata.TaskStatusDetail.Add(TaskStatusObj);
                }

                DataTable FillCVCatatable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_ProjectTasks_CumulativeVsCompleted  " + parameter.ProjectID, true, CommonController.connectionString);

                ProjectInformationdata.CumulativevsCompletedDetail = new List<Cumulative_vs_Completed_Task_output>();
                foreach (DataRow dataRow in FillCVCatatable.Rows)
                {
                    Cumulative_vs_Completed_Task_output CuVSCoObj = new Cumulative_vs_Completed_Task_output();
                    {
                        CuVSCoObj.Months = dataRow["Months"].ToString();
                        CuVSCoObj.Cumulative = Convert.ToInt32(dataRow["Cumulative"].ToString());
                        CuVSCoObj.TasksComplete = Convert.ToInt32(dataRow["Tasks Complete"].ToString());



                    };

                    ProjectInformationdata.CumulativevsCompletedDetail.Add(CuVSCoObj);
                }


                return ProjectInformationdata;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        }
}
