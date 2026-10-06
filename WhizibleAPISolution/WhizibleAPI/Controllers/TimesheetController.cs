using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Http.Controllers;
using WhizibleAPI.Models.Timesheet;

namespace WhizibleAPI.Controllers
{

    public class TimesheetController : ApiController
    {
        [HttpPost]
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        ////public Timesheet GetTaskData([FromBody]TaskParameters taskParameters)
        public object GetTaskData([FromBody] TaskParameters taskParameters)
        {
            try
            {
                Timesheet timesheet = new Timesheet();

                //Timesheet Count
                DataTable taskcountTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Get_CriticlePendingSlipageTASKS " + taskParameters.intEmployeeID, true, CommonController.connectionString);
                foreach (DataRow taskcountRow in taskcountTable.Rows)
                {
                    TaskCount taskcount = new TaskCount();
                    taskcount.CriticalTask = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskcountRow["CriticalTask"], "0"));
                    taskcount.PendingTask = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskcountRow["PendingTask"], "0"));
                    taskcount.SlippageTask = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskcountRow["SlippageTask"], "0"));
                    taskcount.ScheduledTask = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskcountRow["ScheduledTask"], "0"));

                    timesheet.TaskCount = taskcount;
                }

                ////Get Access
                //DataTable taskAccessTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Get_TaskCreationAccess " + taskParameters.intEmployeeID +","+ taskParameters.ProjectID +"", true, CommonController.connectionString);
                //foreach (DataRow taskcountRow in taskAccessTable.Rows)
                //{
                //    Access access = new Access();
                //    access.intAccess = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskcountRow["Access"], "0"));
                //    timesheet.Access = access;
                //}

                //Timesheet Grid
                timesheet.timesheetLists = new List<TimesheetList>();
                string strSQL;
                strSQL = "usp_Whizible2_sel_tbl_PM_DailyActivity " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'";

                if (taskParameters.intIsDefault == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + taskParameters.intIsDefault;

                if (taskParameters.strWhichTask == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strWhichTask + "'";

                if (taskParameters.strTaskIDList == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strTaskIDList + "'";

                if (taskParameters.strFilterProjectList == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strFilterProjectList + "'";

                if (taskParameters.strFilterTaskTypeList == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strFilterTaskTypeList + "'";

                if (taskParameters.strFilterTaskCategories == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strFilterTaskCategories + "'";

                if (taskParameters.strFilterBillable == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strFilterBillable + "'";

                if (taskParameters.strFilterPriorityList == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strFilterPriorityList + "'";

                if (taskParameters.strFilterPhaseList == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strFilterPhaseList + "'";

                if (taskParameters.strFilterMilestoneList == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strFilterMilestoneList + "'";

                if (taskParameters.strFilterSubProjectList == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strFilterSubProjectList + "'";

                if (taskParameters.strFilterModuleList == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strFilterModuleList + "'";

                if (taskParameters.strFilterDeliverableList == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strFilterDeliverableList + "'";

                if (taskParameters.strFilterTaskStatus == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strFilterTaskStatus + "'";

                if (taskParameters.SubTaskTypeList == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.SubTaskTypeList + "'";

                DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow taskListRow in taskListTable.Rows)
                {
                    TimesheetList timesheetList = new TimesheetList()
                    {
                        TaskID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["TaskID"], "0")),
                        TaskName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["TaskName"], "")),
                        SubTaskType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["SubTaskType"], "")),
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["ProjectID"], "0")),
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ProjectName"], "")),
                        Description = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Description"], "")),
                        MonDAID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["MonDAID"], "0")),
                        TueDAID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["TueDAID"], "0")),
                        WedDAID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["WedDAID"], "0")),
                        ThuDAID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["ThuDAID"], "0")),
                        FriDAID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["FriDAID"], "0")),
                        SatDAID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["SatDAID"], "0")),
                        SunDAID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["SunDAID"], "0")),
                        //Commented & Added By Dipali V On 21st Oct 2021 For Conversion & Get Exact Hours
                        //Mon = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["Mon"], "0")),
                        //Tue = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["Tue"], "0")),
                        //Wed = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["Wed"], "0")),
                        //Thu = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["Thu"], "0")),
                        //Fri = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["Fri"], "0")),
                        //Sat = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["Sat"], "0")),
                        //Sun = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["Sun"], "0")),
                        Mon = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Mon"], "0")),
                        Tue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Tue"], "0")),
                        Wed = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Wed"], "0")),
                        Thu = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Thu"], "0")),
                        Fri = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Fri"], "0")),
                        Sat = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Sat"], "0")),
                        Sun = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Sun"], "0")),
                        //End of Commented & Added By Dipali V On 21st Oct 2021 For Conversion & Get Exact Hours
                        MonStoryPoint = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["MonStoryPoint"], "0")),
                        TueStoryPoint = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["TueStoryPoint"], "0")),
                        WedStoryPoint = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["WedStoryPoint"], "0")),
                        ThuStoryPoint = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["ThuStoryPoint"], "0")),
                        FriStoryPoint = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["FriStoryPoint"], "0")),
                        SatStoryPoint = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["SatStoryPoint"], "0")),
                        SunStoryPoint = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["SunStoryPoint"], "0")),
                        MonDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["MonDescription"], "")),
                        TueDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["TueDescription"], "")),
                        WedDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["WedDescription"], "")),
                        ThuDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ThuDescription"], "")),
                        FriDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["FriDescription"], "")),
                        SatDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["SatDescription"], "")),
                        SunDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["SunDescription"], "")),
                        //Commented And Added By Usha Pandit On 06.05.2021 For getting correct Actual Work
                        //ActualWork = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["ActualWork"], "0")),
                        ActualWork = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ActualWork"], "0")),
                        //End Added By Usha Pandit On 06.05.2021 For getting correct Actual Work
                        ActualStartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ActualStartDate"], "")),
                        ActualEndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ActualEndDate"], "")),
                        ActualPercentComplete = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["ActualPercentComplete"], "0")),
                        ResourcePercentComplete = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["ResourcePercentComplete"], "0")),
                        IsTaskComplete = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["IsTaskComplete"], "0")),
                        WhichTask = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["WhichTask"], "")),
                        SubTaskTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["SubTaskTypeID"], "0")),
                        IsProject = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["IsProject"], "0")),
                        Percentage = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["Percentage"], "0")),
                        Tasknotes = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Tasknotes"], "")),
                        StartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["StartDate"], "")),
                        EndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["EndDate"], "")),
                        Work = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["Work"], "0")),
                        MileStone = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["MileStone"], "")),
                        Phase = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Phase"], "")),
                        SubProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["SubProjectName"], "")),
                        DeliverableName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["DeliverableName"], "")),
                        ModuleName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ModuleName"], "")),
                        Issue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Issue"], "")),
                        IsAgileProject = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["IsAgileProject"], "0")),
                        ResourceLevelTaskCompletion = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["ResourceLevelTaskCompletion"], "0")),
                        ApplyEffortDistribution = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["ApplyEffortDistribution"], "0")),
                        TimesheetID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["TimesheetID"], "0")),
                        MonStatusFlag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["MonStatusFlag"], "")),
                        TueStatusFlag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["TueStatusFlag"], "")),
                        WedStatusFlag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["WedStatusFlag"], "")),
                        ThuStatusFlag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ThuStatusFlag"], "")),
                        FriStatusFlag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["FriStatusFlag"], "")),
                        SatStatusFlag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["SatStatusFlag"], "")),
                        SunStatusFlag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["SunStatusFlag"], "")),
                        MonAllowToResubmit = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["MonAllowToResubmit"], "0")),
                        TueAllowToResubmit = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["TueAllowToResubmit"], "0")),
                        WedAllowToResubmit = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["WedAllowToResubmit"], "0")),
                        ThuAllowToResubmit = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["ThuAllowToResubmit"], "0")),
                        FriAllowToResubmit = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["FriAllowToResubmit"], "0")),
                        SatAllowToResubmit = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["SatAllowToResubmit"], "0")),
                        SunAllowToResubmit = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["SunAllowToResubmit"], "0")),
                        RestrictByMinHours = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["RestrictByMinHours"], "0")),
                        //Commented & Addeed By Dipali V On 4th OCt 2021 For Getting Workhours As per DB i.e with digit 2
                        //TaskActualWork = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["TaskActualWork"], "0")),
                        TaskActualWork = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["TaskActualWork"], "0")),
                        //End of Commented & Addeed By Dipali V On 4th OCt 2021 For Getting Workhours As per DB i.e with digit 2
                        StatusFlag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["StatusFlag"], "")),
                        AllowActivityLevelDA = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["AllowActivityLevelDA"], "0")),
                        IsSubTaskFilled = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["IsSubTaskFilled"], "0")),
                    };
                    timesheet.timesheetLists.Add(timesheetList);
                }

                //Project Filter
                timesheet.ProjectFilterLists = new List<ProjectFilter>();
                DataTable ProjectFilterTable;
                //Commented And Added By Usha Pandit On 02.06.2020 for getting global projects in timesheet 
                //if (taskParameters.strFilterProjectList == "")
                //    ProjectFilterTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_AccessibleProjects_ForEmployee " + taskParameters.intEmployeeID + ",NULL", true, CommonController.connectionString);
                //else
                //    ProjectFilterTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_AccessibleProjects_ForEmployee " + taskParameters.intEmployeeID + ",'" + taskParameters.strFilterProjectList + "'", true, CommonController.connectionString);
                if (taskParameters.strFilterProjectList == "")
                    ProjectFilterTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_AccessibleProjects_ForEmployee " + taskParameters.intEmployeeID + ",NULL, 1", true, CommonController.connectionString);
                else
                    ProjectFilterTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_AccessibleProjects_ForEmployee " + taskParameters.intEmployeeID + ",'" + taskParameters.strFilterProjectList + "', 1", true, CommonController.connectionString);
                //End Of Added By Usha Pandit On 02.06.2020 for getting global projects in timesheet 
                foreach (DataRow projectFilterRow in ProjectFilterTable.Rows)
                {
                    ProjectFilter projectFilter = new ProjectFilter()
                    {
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["ProjectID"], "0")),
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["ProjectName"], ""))
                    };
                    timesheet.ProjectFilterLists.Add(projectFilter);
                }
                timesheet.filters = GetFilters(taskParameters);
                //Tasktype Filter


                //Task Categories Filter
                timesheet.TaskCategoryFilterLists = new List<TaskCategoryFilter>();
                DataTable TaskCategoryFilterTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_TaskTypes ", true, CommonController.connectionString);
                foreach (DataRow taskCategoryFilterRow in TaskCategoryFilterTable.Rows)
                {
                    TaskCategoryFilter taskCategoryFilter = new TaskCategoryFilter()
                    {
                        ID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskCategoryFilterRow["ID"], "0")),
                        Value = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskCategoryFilterRow["Value"], ""))
                    };
                    timesheet.TaskCategoryFilterLists.Add(taskCategoryFilter);
                }

                //Task Status Filter
                timesheet.TaskStatusFilterLists = new List<TaskStatusFilter>();
                DataTable TaskStatusFilterTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_TaskStatus ", true, CommonController.connectionString);
                foreach (DataRow taskStatusFilterRow in TaskStatusFilterTable.Rows)
                {
                    TaskStatusFilter taskStatusFilter = new TaskStatusFilter()
                    {
                        StatusID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusFilterRow["StatusID"], "0")),
                        Status = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusFilterRow["Status"], ""))
                    };
                    timesheet.TaskStatusFilterLists.Add(taskStatusFilter);
                }

                //Task Priority Filter
                timesheet.TaskPriorityFilterLists = new List<TaskPriorityFilter>();
                DataTable TaskPriorityFilterTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_IB_Priorities ", true, CommonController.connectionString);
                foreach (DataRow taskPriorityFilterRow in TaskPriorityFilterTable.Rows)
                {
                    TaskPriorityFilter taskPriorityFilter = new TaskPriorityFilter()
                    {
                        PriorityID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskPriorityFilterRow["PriorityID"], "0")),
                        Priority = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskPriorityFilterRow["Priority"], ""))
                    };
                    timesheet.TaskPriorityFilterLists.Add(taskPriorityFilter);
                }

                //Task Billable Filter
                timesheet.BillableFilterLists = new List<BillableFilter>();
                DataTable BillableFilterTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_ProjectBillableType ", true, CommonController.connectionString);
                foreach (DataRow billableFilterRow in BillableFilterTable.Rows)
                {
                    BillableFilter billableFilter = new BillableFilter()
                    {
                        ID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(billableFilterRow["ID"], "0")),
                        Value = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(billableFilterRow["Value"], ""))
                    };
                    timesheet.BillableFilterLists.Add(billableFilter);
                }



                //Week Total
                timesheet.WeekTotalLists = new List<WeekTotal>();
                DataTable WeekTotalTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetWeekTotalForEmployee " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString);

                foreach (DataRow weekTotalRow in WeekTotalTable.Rows)
                {
                    WeekTotal weekTotal = new WeekTotal()
                    {
                        Total = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(weekTotalRow["Total"], "0")),
                        EntryDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(weekTotalRow["EntryDate"], "")),
                        //Commented And Added By Reshma Chavan on 11th Nov 2021 getting Correct Weekly total
                        //AllTotal = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(weekTotalRow["AllTotal"], "0")),
                        AllTotal = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(weekTotalRow["AllTotal"], "0")),
                        //End of Commented And Added By Reshma Chavan on 11th Nov 2021 getting Correct Weekly total
                        WeekDays = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(weekTotalRow["WeekDays"], "0"))
                    };
                    timesheet.WeekTotalLists.Add(weekTotal);
                }

                timesheet.headerColumns = new List<HeaderColumn>();
                DataTable headerDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetTSWeekHeader " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString);

                foreach (DataRow headerRow in headerDataTable.Rows)
                {
                    HeaderColumn headerColumn = new HeaderColumn()
                    {
                        EntryDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(headerRow["EntryDate"], "0")),
                        DayName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(headerRow["DayName"], "")),
                        IsWorking = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(headerRow["IsWorking"], "0")),
                        Day = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(headerRow["Day"], "")),
                        DayNameFirst = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(headerRow["DayNameFirst"], "")),
                        MonthName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(headerRow["MonthName"], "")),
                        Year = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(headerRow["Year"], "")),
                        CurrentDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(headerRow["CurrentDate"], "")),
                    };
                    timesheet.headerColumns.Add(headerColumn);
                }
                return timesheet;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Timesheet Mobile view -Header section
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        //public List<HeaderColumn> GetMobileHeaderList([FromBody]TaskParameters taskParameters)
        public object GetMobileHeaderList([FromBody] TaskParameters taskParameters)
        {
            try
            {
                List<HeaderColumn> headerColumns = new List<HeaderColumn>();

                DataTable headerDataTable;

                if (taskParameters.dtFromDate == "")
                {
                    headerDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetTSWeekHeader_Mobile " + taskParameters.intEmployeeID + ",NULL,NULL", true, CommonController.connectionString);
                }
                else
                {
                    if (taskParameters.dtSelectedDate == null)
                    {
                        headerDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetTSWeekHeader_Mobile " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString);
                    }
                    else
                    {
                        headerDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetTSWeekHeader_Mobile " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "','" + taskParameters.dtSelectedDate + "'", true, CommonController.connectionString);
                    }
                }


                foreach (DataRow headerRow in headerDataTable.Rows)
                {
                    HeaderColumn headerColumn = new HeaderColumn()
                    {
                        EntryDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(headerRow["EntryDate"], "0")),
                        DayName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(headerRow["DayName"], "")),
                        IsWorking = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(headerRow["IsWorking"], "0")),
                        Day = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(headerRow["Day"], "")),
                        DayNameFirst = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(headerRow["DayNameFirst"], "")),
                        MonthName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(headerRow["MonthName"], "")),
                        Year = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(headerRow["Year"], "")),
                        CurrentDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(headerRow["CurrentDate"], "")),
                        IsTodayDate = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(headerRow["IsTodayDate"], "0")),
                    };
                    headerColumns.Add(headerColumn);
                }
                return headerColumns;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

            //Added by Rehan on 19-10-2022
            [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        [HttpPost]
        public Filters GetFilters([FromBody]TaskParameters taskParameters)
        {
            int intEmployeeID = taskParameters.intEmployeeID;
            string strFilterProjectList = taskParameters.strFilterProjectList;
            Filters filters = new Filters();
            filters.TaskTypeFilterLists = new List<TaskTypeFilter>();
            DataTable TaskTypeFilterTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_Project_TaskTypes " + intEmployeeID + "," + (strFilterProjectList == "" ? "Null" : "'" + strFilterProjectList + "'") + "", true, CommonController.connectionString);
            foreach (DataRow taskTypeFilterRow in TaskTypeFilterTable.Rows)
            {
                TaskTypeFilter taskTypeFilter = new TaskTypeFilter()
                {
                    TaskTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskTypeFilterRow["TaskTypeID"], "0")),
                    TaskType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskTypeFilterRow["TaskType"], ""))
                };
                filters.TaskTypeFilterLists.Add(taskTypeFilter);
            }

            //Task Phase Filter
            filters.PhaseFilterLists = new List<PhaseFilter>();
            DataTable PhaseFilterTable;
            PhaseFilterTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Get_tbl_IB_Project_Phases " + intEmployeeID + "," + (strFilterProjectList == "" ? "Null" : "'" + strFilterProjectList + "'") + "", true, CommonController.connectionString);

            foreach (DataRow phaseFilterRow in PhaseFilterTable.Rows)
            {
                PhaseFilter phaseFilter = new PhaseFilter()
                {
                    PhaseID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(phaseFilterRow["PhaseID"], "0")),
                    Phase = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(phaseFilterRow["Phase"], ""))
                };
                filters.PhaseFilterLists.Add(phaseFilter);
            }

            //Task Milestone Filter
            filters.MileStoneFilterLists = new List<MileStoneFilter>();
            DataTable MileStoneFilterTable;
            MileStoneFilterTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_Milestones " + intEmployeeID + "," + (strFilterProjectList == "" ? "Null" : "'" + strFilterProjectList + "'") + "", true, CommonController.connectionString);

            foreach (DataRow mileStoneFilterRow in MileStoneFilterTable.Rows)
            {
                MileStoneFilter mileStoneFilter = new MileStoneFilter()
                {
                    MileStoneId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(mileStoneFilterRow["MileStoneId"], "0")),
                    MileStone = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(mileStoneFilterRow["MileStone"], ""))
                };
                filters.MileStoneFilterLists.Add(mileStoneFilter);
            }

            //Task Deliverable Filter
            filters.DeliverableFilterLists = new List<DeliverableFilter>();
            DataTable DeliverableFilterTable;
            DeliverableFilterTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_ProjectSchedule " + intEmployeeID + "," + (strFilterProjectList == "" ? "Null" : "'" + strFilterProjectList + "'") + "", true, CommonController.connectionString);

            foreach (DataRow deliverableFilterRow in DeliverableFilterTable.Rows)
            {
                DeliverableFilter deliverableFilter = new DeliverableFilter()
                {
                    DeliverableID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(deliverableFilterRow["DeliverableID"], "0")),
                    Title = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(deliverableFilterRow["Title"], ""))
                };
                filters.DeliverableFilterLists.Add(deliverableFilter);
            }

            //Task SubProject Filter
            filters.SubProjectFilterLists = new List<SubProjectFilter>();
            DataTable SubProjectFilterTable;
            SubProjectFilterTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_SubProject " + intEmployeeID + "," + (strFilterProjectList == "" ? "Null" : "'" + strFilterProjectList + "'") + "", true, CommonController.connectionString);

            foreach (DataRow subProjectFilterRow in SubProjectFilterTable.Rows)
            {
                SubProjectFilter subProjectFilter = new SubProjectFilter()
                {
                    SubProjectId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(subProjectFilterRow["SubProjectId"], "0")),
                    SubProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(subProjectFilterRow["SubProjectName"], ""))
                };
                filters.SubProjectFilterLists.Add(subProjectFilter);
            }

            //Task Module Filter
            filters.ModuleFilterLists = new List<ModuleFilter>();
            DataTable ModuleFilterTable;
            ModuleFilterTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_Module " + intEmployeeID + "," + (strFilterProjectList == "" ? "Null" : "'" + strFilterProjectList + "'") + "", true, CommonController.connectionString);

            foreach (DataRow moduleFilterRow in ModuleFilterTable.Rows)
            {
                ModuleFilter moduleFilter = new ModuleFilter()
                {
                    ModuleId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(moduleFilterRow["ModuleId"], "0")),
                    ModuleName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(moduleFilterRow["ModuleName"], ""))
                };
                filters.ModuleFilterLists.Add(moduleFilter);
            }
            return filters;
        }

        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        [HttpPost]
        public object GetFilterResultCount([FromBody] TaskParameters taskParameters)
        {
            try
            {
                List<TimesheetList> timesheetLists = new List<TimesheetList>();
                timesheetLists = GetTaskListFromAdvanceSearch(taskParameters);
                return timesheetLists.Count();
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2
        [HttpPost]
        //public List<ProjectFilter> GetProjectDropdownValuesForFilter([FromBody]TaskParameters taskParameters)
        public object GetProjectDropdownValuesForFilter([FromBody] TaskParameters taskParameters)
        {
            try
            {
                List<ProjectFilter> projectFilterLists = new List<ProjectFilter>();
                DataTable ProjectFilterTable;
                //Commented And Added By Usha Pandit On 02.06.2020 for getting global projects in timesheet 
                //if (taskParameters.strFilterProjectList == "")
                //ProjectFilterTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_AccessibleProjects_ForEmployee " + taskParameters.intEmployeeID + ",NULL", true, CommonController.connectionString);
                //else
                //ProjectFilterTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Get_ProjectNames '" + taskParameters.strFilterProjectList + "'", true, CommonController.connectionString);

                if (taskParameters.strFilterProjectList == "")
                    ProjectFilterTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_AccessibleProjects_ForEmployee " + taskParameters.intEmployeeID + ",NULL, 1", true, CommonController.connectionString);
                else
                    ProjectFilterTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Get_ProjectNames '" + taskParameters.strFilterProjectList + "'", true, CommonController.connectionString);

                //End Of Added By Usha Pandit On 02.06.2020 for getting global projects in timesheet			
                foreach (DataRow projectFilterRow in ProjectFilterTable.Rows)
                {
                    ProjectFilter projectFilter = new ProjectFilter()
                    {
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["ProjectID"], "0")),
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["ProjectName"], ""))
                    };
                    projectFilterLists.Add(projectFilter);
                }
                return projectFilterLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

            //Added by Rehan on 19-10-2022
            [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        [HttpPost]
        public List<TimesheetList> GetTaskListFromAdvanceSearch([FromBody]TaskParameters taskParameters)
        {

            string strSQL = "usp_Whizible2_Sel_FilterTaskList " + taskParameters.intEmployeeID + "";
            if (taskParameters.strFilterProjectList == "")
                strSQL += ",NULL";
            else
                strSQL += ",'" + taskParameters.strFilterProjectList + "'";

            if (taskParameters.strFilterTaskTypeList == "")
                strSQL += ",NULL";
            else
                strSQL += ",'" + taskParameters.strFilterTaskTypeList + "'";

            if (taskParameters.strFilterTaskCategories == "")
                strSQL += ",NULL";
            else
                strSQL += ",'" + taskParameters.strFilterTaskCategories + "'";

            if (taskParameters.strFilterBillable == "")
                strSQL += ",NULL";
            else
                strSQL += ",'" + taskParameters.strFilterBillable + "'";

            if (taskParameters.strFilterPriorityList == "")
                strSQL += ",NULL";
            else
                strSQL += ",'" + taskParameters.strFilterPriorityList + "'";

            if (taskParameters.strFilterPhaseList == "")
                strSQL += ",NULL";
            else
                strSQL += ",'" + taskParameters.strFilterPhaseList + "'";

            if (taskParameters.strFilterMilestoneList == "")
                strSQL += ",NULL";
            else
                strSQL += ",'" + taskParameters.strFilterMilestoneList + "'";


            if (taskParameters.strFilterSubProjectList == "")
                strSQL += ",NULL";
            else
                strSQL += ",'" + taskParameters.strFilterSubProjectList + "'";

            if (taskParameters.strFilterDeliverableList == "")
                strSQL += ",NULL";
            else
                strSQL += ",'" + taskParameters.strFilterDeliverableList + "'";

            if (taskParameters.strFilterModuleList == "")
                strSQL += ",NULL";
            else
                strSQL += ",'" + taskParameters.strFilterModuleList + "'";

            if (taskParameters.strFilterTaskStatus == "")
                strSQL += ",NULL";
            else
                strSQL += ",'" + taskParameters.strFilterTaskStatus + "'";
            //Added by Vishal Mane on 09/10/2024 to fix Base issue on Timesheet Filter page when we select All Projects 
            //if (taskParameters.FilterProjectID == 0)
            if (taskParameters.FilterProjectID == null)
            //End of Added by Vishal Mane on 09/10/2024 to fix Base issue on Timesheet Filter page when we select All Projects
                strSQL += ",NULL";
            else
                strSQL += ",'" + taskParameters.FilterProjectID + "'";

            DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
            List<TimesheetList> timesheetLists = new List<TimesheetList>();
            foreach (DataRow taskListRow in taskListTable.Rows)
            {
                TimesheetList timesheetList = new TimesheetList()
                {
                    TaskID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["TaskID"], "0")),
                    TaskName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["TaskName"], "")),
                    Tasknotes = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Tasknotes"], "")),
                    StartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["StartDate"], "")),
                    EndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["EndDate"], "")),
                    Work = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["Work"], "0")),
                    MileStone = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["MileStone"], "")),
                    Phase = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Phase"], "")),
                    SubProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["SubProjectName"], "")),
                    DeliverableName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["DeliverableName"], "")),
                    ModuleName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ModuleName"], "")),
                    Issue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Issue"], "")),
                    ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ProjectName"], "")),
                    //Commented And Added By Usha Pandit On 06.05.2021 For getting correct Actual Work
                    //ActualWork = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["ActualWork"], "0")),
                    ActualWork = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ActualWork"], "0")),
                    //End Of Added By Usha Pandit On 06.05.2021 For getting correct Actual Work
                    ProjectCode = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ProjectCode"], "")),
                    ProjectStartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ProjectStartDate"], "")),
                    ProjectEndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ProjectEndDate"], "")),
                    WhichTask = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["WhichTask"], "")),
                };
                timesheetLists.Add(timesheetList);
            }
            return timesheetLists;
        }

        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        [HttpPost]
        //  public Timesheet GetTaskListDayView([FromBody]TaskParameters taskParameters)
        public object GetTaskListDayView([FromBody] TaskParameters taskParameters)
        {
            try
            {
                Timesheet timesheet = new Timesheet();
                //Week Total
                timesheet.WeekTotalLists = new List<WeekTotal>();
                DataTable WeekTotalTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetWeekTotalForEmployee_DailyView " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "'", true, CommonController.connectionString);

                foreach (DataRow weekTotalRow in WeekTotalTable.Rows)
                {
                    WeekTotal weekTotal = new WeekTotal()
                    {
                        Total = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(weekTotalRow["Total"], "0")),
                        EntryDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(weekTotalRow["EntryDate"], "")),
                        //Commented And Added By Reshma Chavan on 11th Nov 2021 getting Correct Weekly total
                        //AllTotal = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(weekTotalRow["AllTotal"], "0")),
                        AllTotal = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(weekTotalRow["AllTotal"], "0")),
                        //End of Commented And Added By Reshma Chavan on 11th Nov 2021 getting Correct Weekly total
                        WeekDays = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(weekTotalRow["WeekDays"], "0"))
                    };
                    timesheet.WeekTotalLists.Add(weekTotal);
                }

                timesheet.headerColumns = new List<HeaderColumn>();
                DataTable headerDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetTSWeekHeader " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "',Null", true, CommonController.connectionString);

                foreach (DataRow headerRow in headerDataTable.Rows)
                {
                    HeaderColumn headerColumn = new HeaderColumn()
                    {
                        EntryDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(headerRow["EntryDate"], "0")),
                        DayName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(headerRow["DayName"], "")),
                        IsWorking = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(headerRow["IsWorking"], "0")),
                    };
                    timesheet.headerColumns.Add(headerColumn);
                }
                timesheet.timesheetLists = new List<TimesheetList>();
                string strSQL = "";
                if (taskParameters.intMobileView == 1)
                {
                    if (taskParameters.intTimesheetID == 0)
                    {
                        strSQL = "usp_Whizible2_sel_tbl_PM_DailyActivity_Mobile " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "'";
                    }
                    else
                    {
                        strSQL = "usp_Whizible2_sel_tbl_PM_DailyActivity_ApprovalMobile " + taskParameters.intTimesheetID + "," + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "',NULL," + taskParameters.intApproverID + "";
                    }
                }
                else
                {
                    strSQL = "usp_Whizible2_sel_tbl_PM_DailyActivity_DailyView " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "'";
                }


                if (taskParameters.intIsDefault == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + taskParameters.intIsDefault;

                if (taskParameters.strWhichTask == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strWhichTask + "'";

                if (taskParameters.strTaskIDList == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strTaskIDList + "'";

                if (taskParameters.strFilterProjectList == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strFilterProjectList + "'";

                if (taskParameters.strFilterTaskTypeList == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strFilterTaskTypeList + "'";

                if (taskParameters.strFilterTaskCategories == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strFilterTaskCategories + "'";

                if (taskParameters.strFilterBillable == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strFilterBillable + "'";

                if (taskParameters.strFilterPriorityList == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strFilterPriorityList + "'";

                if (taskParameters.strFilterPhaseList == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strFilterPhaseList + "'";

                if (taskParameters.strFilterMilestoneList == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strFilterMilestoneList + "'";

                if (taskParameters.strFilterSubProjectList == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strFilterSubProjectList + "'";

                if (taskParameters.strFilterModuleList == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strFilterModuleList + "'";

                if (taskParameters.strFilterDeliverableList == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strFilterDeliverableList + "'";

                if (taskParameters.strFilterTaskStatus == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.strFilterTaskStatus + "'";

                if (taskParameters.SubTaskTypeList == "")
                    strSQL += ",NULL";
                else
                    strSQL += ",'" + taskParameters.SubTaskTypeList + "'";

                DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow taskListRow in taskListTable.Rows)
                {
                    TimesheetList timesheetList = new TimesheetList()
                    {
                        TaskID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["TaskID"], "0")),
                        TaskName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["TaskName"], "")),
                        SubTaskType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["SubTaskType"], "")),
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["ProjectID"], "0")),
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ProjectName"], "")),
                        Description = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Description"], "")),
                        Duration = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["Duration"], "0")),
                        //Commented And Added By Usha Pandit On 06.05.2021 For getting correct Actual Work
                        //ActualWork = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["ActualWork"], "0")),
                        ActualWork = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ActualWork"], "0")),
                        //End Of Added By Usha Pandit On 06.05.2021 For getting correct Actual Work
                        ActualStartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ActualStartDate"], "")),
                        ActualEndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ActualEndDate"], "")),
                        ActualPercentComplete = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["ActualPercentComplete"], "0")),
                        ResourcePercentComplete = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["ResourcePercentComplete"], "0")),
                        IsTaskComplete = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["IsTaskComplete"], "0")),
                        WhichTask = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["WhichTask"], "")),
                        SubTaskTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["SubTaskTypeID"], "0")),
                        IsProject = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["IsProject"], "0")),
                        Percentage = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["Percentage"], "0")),
                        Tasknotes = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Tasknotes"], "")),
                        StartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["StartDate"], "")),
                        EndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["EndDate"], "")),
                        Work = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["Work"], "0")),
                        MileStone = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["MileStone"], "")),
                        Phase = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Phase"], "")),
                        SubProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["SubProjectName"], "")),
                        DeliverableName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["DeliverableName"], "")),
                        ModuleName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ModuleName"], "")),
                        Issue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Issue"], "")),
                        DayName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["DayName"], "")),
                        DAID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["DAID"], "0")),
                        StoryPoint = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["StoryPoint"], "0")),
                        IsAgileProject = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["IsAgileProject"], "0")),
                        ResourceLevelTaskCompletion = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["ResourceLevelTaskCompletion"], "0")),
                        ApplyEffortDistribution = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["ApplyEffortDistribution"], "0")),
                        StatusFlag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["StatusFlag"], "")),
                        AllowToResubmit = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["AllowToResubmit"], "0")),
                        //Commented & Addeed By Dipali V On 4th OCt 2021 For Getting Workhours As per DB i.e with digit 2
                        TaskActualWork = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["TaskActualWork"], "0")),
                        //TaskActualWork = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["TaskActualWork"], "0")),
                        //End of Commented & Addeed By Dipali V On 4th OCt 2021 For Getting Workhours As per DB i.e with digit 2
                        TimesheetID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["TimesheetID"], "0")),
                        RestrictByMinHours = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["RestrictByMinHours"], "0")),
                        TaskStatusFlag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["TaskStatusFlag"], "")),
                        IsApprover = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["IsApprover"], "0")),

                        AllowActivityLevelDA = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["AllowActivityLevelDA"], "0")),
                        IsSubTaskFilled = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["IsSubTaskFilled"], "0")),

                    };
                    timesheet.timesheetLists.Add(timesheetList);

                }
                return timesheet;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        [HttpPost]
        // public List<SubTaskList> GetSubTaskList([FromBody]TaskParameters taskParameters)
        public object GetSubTaskList([FromBody] TaskParameters taskParameters)
        {
            try
            {
                List<SubTaskList> subTaskLists = new List<SubTaskList>();
                DataTable SubTaskListTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_Project_SubTaskTypes " + taskParameters.ProjectID + "," + taskParameters.TaskID + "", true, CommonController.connectionString);
                foreach (DataRow subTaskListRow in SubTaskListTable.Rows)
                {
                    SubTaskList subTaskList = new SubTaskList()
                    {
                        SubTaskTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(subTaskListRow["SubTaskTypeID"], "0")),
                        SubTaskType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(subTaskListRow["SubTaskType"], "")),
                        TaskName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(subTaskListRow["TaskName"], "")),
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(subTaskListRow["ProjectName"], ""))
                    };
                    subTaskLists.Add(subTaskList);
                }
                return subTaskLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        [HttpPost]
        //public List<ScheduleTSEntry> GetScheduleTSEntryData([FromBody]TaskParameters taskParameters)
        public object GetScheduleTSEntryData([FromBody] TaskParameters taskParameters)
        {
            try
            {
                List<ScheduleTSEntry> scheduleTSEntryList = new List<ScheduleTSEntry>();
                DataTable ScheduleTSEntryTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Get_tbl_PM_ScheduleTasksDetails " + taskParameters.TaskID + "," + taskParameters.SubTasktypeID + "", true, CommonController.connectionString);
                foreach (DataRow scheduleTSEntry in ScheduleTSEntryTable.Rows)
                {
                    ScheduleTSEntry objscheduleTSEntry = new ScheduleTSEntry()
                    {
                        TaskID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(scheduleTSEntry["TaskID"], "0")),
                        PostWorkHrs = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(scheduleTSEntry["PostWorkHrs"], "0")),
                        StartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(scheduleTSEntry["StartDate"], "")),
                        PostEndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(scheduleTSEntry["PostEndDate"], "")),
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(scheduleTSEntry["ProjectName"], "")),
                        TaskName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(scheduleTSEntry["TaskName"], "")),
                        SubTaskType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(scheduleTSEntry["SubTaskType"], "")),
                        work = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(scheduleTSEntry["work"], "0")),
                        IsTaskComplete = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(scheduleTSEntry["IsTaskComplete"], "0")),
                    };
                    scheduleTSEntryList.Add(objscheduleTSEntry);
                }
                return scheduleTSEntryList;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        [HttpPost]
        public object ValidateScheduleTask([FromBody] TaskParameters taskParameters)
        {
            try
            {
                string Message;

                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_ValidateScheduledTask " + taskParameters.TaskID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString), ""));

                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteScheduleTask([FromBody] TaskParameters taskParameters)
        {
            try
            {
                string Message;

                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.InsertOrUpdateData("usp_Whhizible2_del_tbl_PM_ScheduleTasks " + taskParameters.TaskID, true, CommonController.connectionString), ""));

                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveScheduledTask([FromBody] TaskParameters taskParameters)
        {
            try
            {
                string Message;

                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.InsertOrUpdateData("usp_Whizible2_Ins_Upd_tbl_PM_ScheduleTasks " + taskParameters.TaskID + ",'" + taskParameters.Duration + "'," + taskParameters.IsTaskComplete + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'," + taskParameters.intEmployeeID + "," + taskParameters.bitFlag, true, CommonController.connectionString), ""));

                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        [HttpPost]
        //public List<AdditionalRequestTime> GetAdditionalRequestedTime([FromBody]TaskParameters taskParameters)
        public object GetAdditionalRequestedTime([FromBody] TaskParameters taskParameters)
        {
            try
            {
                List<AdditionalRequestTime> additionalRequestTimeList = new List<AdditionalRequestTime>();
                //DataTable AdditionalRequestTimeTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Get_tbl_PM_ProjectTaskETC " + taskParameters.TaskID + "", true, CommonController.connectionString);

                //Commented and Added By Reshma on 25th Dec for issue id:16566
                DataTable AdditionalRequestTimeTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Get_tbl_PM_ProjectTaskETC " + taskParameters.TaskID + "," + taskParameters.SubTasktypeID + " ", true, CommonController.connectionString);



                foreach (DataRow additionalRequestTime in AdditionalRequestTimeTable.Rows)
                {
                    AdditionalRequestTime objAdditionalRequestTime = new AdditionalRequestTime()
                    {
                        TaskID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(additionalRequestTime["TaskID"], "0")),
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(additionalRequestTime["ProjectID"], "0")),
                        StartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(additionalRequestTime["StartDate"], "")),
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(additionalRequestTime["ProjectName"], "")),
                        TaskName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(additionalRequestTime["TaskName"], "")),
                        SubTaskType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(additionalRequestTime["SubTaskType"], "")),
                        work = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(additionalRequestTime["work"], "0")),
                        ETC = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(additionalRequestTime["ETC"], "0")),
                        Reason = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(additionalRequestTime["Reason"], "")),
                        ActualWork = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(additionalRequestTime["ActualWork"], "0")),
                    };
                    additionalRequestTimeList.Add(objAdditionalRequestTime);
                }
                return additionalRequestTimeList;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize]
        [HttpPost]
        // public List<TaskCategoryFilter> GetTaskCategories()
        public object GetTaskCategories()
        {
            try
            {
                List<TaskCategoryFilter> taskCategoryFilterList = new List<TaskCategoryFilter>();

                DataTable TaskCategoryFilterTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_TaskTypes ", true, CommonController.connectionString);
                foreach (DataRow taskCategoryFilterRow in TaskCategoryFilterTable.Rows)
                {
                    TaskCategoryFilter taskCategoryFilter = new TaskCategoryFilter()
                    {
                        ID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskCategoryFilterRow["ID"], "0")),
                        Value = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskCategoryFilterRow["Value"], ""))
                    };
                    taskCategoryFilterList.Add(taskCategoryFilter);
                }
                return taskCategoryFilterList;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        [HttpPost]
        // public List<ProjectFilter> BindProject([FromBody]TaskParameters taskParameters)
        public object BindProject([FromBody] TaskParameters taskParameters)
        {
            try
            {
                List<ProjectFilter> projectFilterList = new List<ProjectFilter>();

                DataTable ProjectFilterTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_ListOfProject_QuickTask " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "'", true, CommonController.connectionString);
                foreach (DataRow projectFilterRow in ProjectFilterTable.Rows)
                {
                    ProjectFilter projectFilter = new ProjectFilter()
                    {
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["ProjectID"], "0")),
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["ProjectName"], ""))
                    };
                    projectFilterList.Add(projectFilter);
                }
                return projectFilterList;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        [HttpPost]
        // public List<TaskTypeFilter> GetTaskTypeFromProject([FromBody]TaskParameters taskParameters)
        public object GetTaskTypeFromProject([FromBody] TaskParameters taskParameters)
        {
            try
            {
                List<TaskTypeFilter> taskTypeFilterList = new List<TaskTypeFilter>();

                DataTable TaskTypeFilterTable = CommonFunctions.Data.GetDataTable("Usp_Whizible2_Sel_TaskType_QuickTask " + taskParameters.FilterProjectID, true, CommonController.connectionString);
                foreach (DataRow tasktypeFilterRow in TaskTypeFilterTable.Rows)
                {
                    TaskTypeFilter taskTypeFilter = new TaskTypeFilter()
                    {
                        TaskTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(tasktypeFilterRow["TaskTypeID"], "0")),
                        TaskType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(tasktypeFilterRow["TaskType"], ""))
                    };
                    taskTypeFilterList.Add(taskTypeFilter);
                }
                return taskTypeFilterList;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Mobile View - Get Task type

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        //public List<TaskTypeFilter> GetTaskTypeFromProject_MV([FromBody]TaskParameters taskParameters)
        public object GetTaskTypeFromProject_MV([FromBody] TaskParameters taskParameters)
        {
            try
            {
                List<TaskTypeFilter> taskTypeFilterList = new List<TaskTypeFilter>();

                DataTable TaskTypeFilterTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_Project_TaskTypes " + taskParameters.intEmployeeID + "," + taskParameters.FilterProjectID, true, CommonController.connectionString);
                foreach (DataRow tasktypeFilterRow in TaskTypeFilterTable.Rows)
                {
                    TaskTypeFilter taskTypeFilter = new TaskTypeFilter()
                    {
                        TaskTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(tasktypeFilterRow["TaskTypeID"], "0")),
                        TaskType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(tasktypeFilterRow["TaskType"], ""))
                    };
                    taskTypeFilterList.Add(taskTypeFilter);
                }
                return taskTypeFilterList;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        [HttpPost]
        //public List<SubTaskList> GetSubTaskTypeFromProject([FromBody]TaskParameters taskParameters)
        public object GetSubTaskTypeFromProject([FromBody] TaskParameters taskParameters)
        {
            try
            {
                List<SubTaskList> subTaskTypeList = new List<SubTaskList>();

                DataTable SubTaskTypeFilterTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_SubTasks_QuickTask " + taskParameters.FilterProjectID + "," + taskParameters.FilterTaskTypeID, true, CommonController.connectionString);
                foreach (DataRow subtasktypeFilterRow in SubTaskTypeFilterTable.Rows)
                {
                    SubTaskList subTaskList = new SubTaskList()
                    {
                        SubTaskTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(subtasktypeFilterRow["SubTaskTypeID"], "0")),
                        SubTaskType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(subtasktypeFilterRow["SubTaskType"], ""))
                    };
                    subTaskTypeList.Add(subTaskList);
                }
                return subTaskTypeList;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        [HttpPost]
        public object ValidateDA([FromBody] TaskParameters taskParameters)
        {
            try
            {
                string Message;
                if (taskParameters.Flag != "Responsive")
                {
                    Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_ValidateDA " + taskParameters.ProjectID + "," + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.Duration + "','" + taskParameters.TotalDuration + "'," + taskParameters.TaskID + "," + taskParameters.IsTaskComplete + "," + taskParameters.SubTasktypeID + "", true, CommonController.connectionString), ""));
                }
                else
                {
                    Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_ValidateDA_Responsive " + taskParameters.ProjectID + "," + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.Duration + "','" + taskParameters.TotalDuration + "'," + taskParameters.TaskID + "," + taskParameters.IsTaskComplete + "," + taskParameters.SubTasktypeID + "", true, CommonController.connectionString), ""));
                }
                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        public object ValidateStoryPoint([FromBody] TaskParameters taskParameters)
        {
            try
            {
                string strsql = "";
                string strResult = "";


                strsql = "EXEC usp_Whizible2_chk_ValidateStoryPoint " + taskParameters.TaskID + "," + taskParameters.StoryPoint + ",'" + taskParameters.dtFromDate + "'";

                strResult = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strsql, true, CommonController.connectionString), ""));

                return strResult;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //[Authorize, App_Start.ValidateHeaders]
        [Authorize]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveDailyActivity(IEnumerable<DAParams> daParams)
        {
            try
            {

                //IEnumerable<string> headerValues = Request.Headers.GetValues("Params");
                //var id = headerValues.FirstOrDefault();
                //var o = JsonConvert.DeserializeObject <JArray>(CommonFunctions.General.DecryptString(id));
                
                //foreach (var jToken in o.Children().ToList())
                //{
                    
                //    var jTokenList = jToken.ToList();
                //    foreach (JValue li in jTokenList.Values())
                //    {
                //        var v = li["DailyActivityEntryID"];
                //    }
                //}


                    //Commented And Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue
                    DataTable countTable; 
                int ResourceTimesheetID = 0;

                countTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Get_tbl_PM_ResourceTimesheet null," + daParams.First().EmployeeID + ",'" + daParams.First().dtFromDate + "','" + daParams.First().dtToDate + "'", true, CommonController.connectionString);
                foreach (DataRow countRow in countTable.Rows)
                {
                    ResourceTimesheetID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(countRow["TimesheetID"], "0"));
                }
                //End Of Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue
                string Message = "0";
                foreach (var param in daParams)
                {
                    if (param.DailyActivityEntryID == 0)
                    {
                        //Commented And Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue
                        //Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_DailyActivity NULL," + param.TaskID + "," + param.ProjectID + "," + param.EmployeeID + ",'" + param.EntryDate + "'," + param.Duration + ",'" + param.Description + "',NULL," + param.SubTasktypeID + "," + param.IsDurationChange + "," + param.IsTaskComplete + "," + param.ActualPercentComplete + "," + param.bitResourceTaskComplete + ",NULL,NULL," + param.StoryPoint, true, CommonController.connectionString), ""));
                        Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_DailyActivity NULL," + param.TaskID + "," + param.ProjectID + "," + param.EmployeeID + ",'" + param.EntryDate + "'," + param.Duration + ",'" + param.Description + "',NULL," + param.SubTasktypeID + "," + param.IsDurationChange + "," + param.IsTaskComplete + "," + param.ActualPercentComplete + "," + param.bitResourceTaskComplete + ",NULL,NULL," + param.StoryPoint + ", " + ResourceTimesheetID, true, CommonController.connectionString), ""));
                        //End Of Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue
                    }
                    else
                    {
                        //Commented And Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue
                        //Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_DailyActivity " + param.DailyActivityEntryID + "," + param.TaskID + "," + param.ProjectID + "," + param.EmployeeID + ",'" + param.EntryDate + "'," + param.Duration + ",'" + param.Description + "',NULL," + param.SubTasktypeID + "," + param.IsDurationChange + "," + param.IsTaskComplete + "," + param.ActualPercentComplete + "," + param.bitResourceTaskComplete + ",NULL,NULL," + param.StoryPoint, true, CommonController.connectionString), ""));
                        Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_DailyActivity " + param.DailyActivityEntryID + "," + param.TaskID + "," + param.ProjectID + "," + param.EmployeeID + ",'" + param.EntryDate + "'," + param.Duration + ",'" + param.Description + "',NULL," + param.SubTasktypeID + "," + param.IsDurationChange + "," + param.IsTaskComplete + "," + param.ActualPercentComplete + "," + param.bitResourceTaskComplete + ",NULL,NULL," + param.StoryPoint + ", " + ResourceTimesheetID, true, CommonController.connectionString), ""));
                        //End Of Added By Usha Pandit On 16.03.2021 for timesheetid mismatch issue
                    }
                }
                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex);
            }
        }
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022

        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveETC([FromBody] TaskParameters taskParameters)
        {
            try
            {
                string Message;
                string Flag = "0";
                string strFromEmailID = "";
                string strToEmailID = "";
                string strCCToEmailID = "";
                string strSubject = "", strMessage = "";
                bool blnSendEmail, blnShowPopup;
                // Added By Reshma Chavan on 7th Dec 2020 For Incorrect To EmailID on Mail Popup
                string ProjectID = Convert.ToString(taskParameters.ProjectID);
                //End of Added By Reshma Chavan on 7th Dec 2020 For Incorrect To EmailID on Mail Popup


                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_ProjectTaskETC " + taskParameters.ProjectID + "," + taskParameters.intEmployeeID + "," + taskParameters.TaskID + ",'" + taskParameters.Duration + "','" + taskParameters.dtFromDate + "','" + taskParameters.Description + "'", true, CommonController.connectionString), ""));

                //Getting Email messages
                DataTable EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_EmailMessages 20047", true, CommonController.connectionString);
                foreach (DataRow mailRow in EmailDataTable.Rows)
                {
                    blnSendEmail = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["SendMail"], "0"));
                    blnShowPopup = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["ShowPopup"], "0"));

                    if (blnSendEmail == true)
                    {
                        if (blnShowPopup == true)
                        {
                            Flag = "1";
                        }
                        else
                        {
                            //Commented And Added By Reshma Chavan on 7th Dec 2020 For Incorrect To EmailID on Mail Popup
                            //EmailMessagesController.GetEmailMessage_20047(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, Convert.ToInt32(Message));
                            EmailMessagesController.GetEmailMessage_20047(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, Convert.ToInt32(Message), Convert.ToInt32(ProjectID));
                            //End of Commented And Added By Reshma Chavan on 7th Dec 2020 For Incorrect To EmailID on Mail Popup
                            EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
                        }

                    }
                }
                Message += "_Flag" + Flag;
                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        [HttpPost]
        public object ValidateCreateTask([FromBody] TaskParameters taskParameters)
        {
            try
            {
                string Message;

                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Validate_CreateTask '" + taskParameters.dtFromDate + "'," + taskParameters.ProjectID + "," + taskParameters.intEmployeeID + ",'" + taskParameters.Duration + "'", true, CommonController.connectionString), ""));

                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        [HttpPost]
        public object ValidateCreateTask_Work([FromBody] TaskParameters taskParameters)
        {
            try
            {
                string Message;
                if (taskParameters.intSubTaskTypeID == 0)
                {
                    Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Validate_CreateTask_WorkHrs " + taskParameters.ProjectID + ",'" + taskParameters.Duration + "','" + taskParameters.TaskName + "','" + taskParameters.CTselectdate + "'," + taskParameters.intEmployeeID + ",NULL", true, CommonController.connectionString), ""));
                }
                else
                {
                    Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Validate_CreateTask_WorkHrs " + taskParameters.ProjectID + ",'" + taskParameters.Duration + "','" + taskParameters.TaskName + "','" + taskParameters.CTselectdate + "'," + taskParameters.intEmployeeID + "," + taskParameters.intSubTaskTypeID + "", true, CommonController.connectionString), ""));
                }


                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveCreateTask([FromBody] TaskParameters taskParameters)
        {
            try
            {
                string Message;

                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_ProjectAssignedTasks_From_QuickTasks " + taskParameters.intEmployeeID + "," + taskParameters.ProjectID + ",'" + taskParameters.TaskName + "','" + taskParameters.Duration + "'," + taskParameters.FilterTaskTypeID + "," + taskParameters.SubTasktypeID + ",'" + taskParameters.CreatedBy + "','" + taskParameters.dtFromDate + "'," + taskParameters.PriorityID + "," + taskParameters.ActualPercentComplete + ",'" + taskParameters.Description + "'," + taskParameters.bitFlag, true, CommonController.connectionString), ""));

                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Mobile View - View Timesheet - Week Days (Added by Swapnagandha K.)
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        //public List<VTWeek_MV> BindWeekDays([FromBody]TaskParameters taskParameters)
        public object BindWeekDays([FromBody] TaskParameters taskParameters)
        {
            try
            {
                List<VTWeek_MV> WeekDaysList = new List<VTWeek_MV>();
                DataTable WeekDaysTable;
                if (taskParameters.intTimesheetID == 0)
                {
                    WeekDaysTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetWeekTotalForEmployee_Mobile " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "',NULL,'" + taskParameters.ViewTimesheetPageLoad + "'", true, CommonController.connectionString);
                }
                else
                {
                    WeekDaysTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetWeekTotalForEmployee_Mobile " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'," + taskParameters.intTimesheetID + "", true, CommonController.connectionString);

                }
                //WeekDaysTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetWeekTotalForEmployee_Mobile " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','"+ taskParameters.dtToDate +"'", true, CommonController.connectionString);
                foreach (DataRow projectFilterRow in WeekDaysTable.Rows)
                {
                    VTWeek_MV weekDays = new VTWeek_MV()
                    {
                        Total = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["Total"], "")),
                        EntryDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["EntryDate"], "")),
                        Day = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["Day"], "")),
                        DayName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["DayName"], "")),
                        Year = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["Year"], "")),
                        MonthName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["MonthName"], "")),
                        AllTotal = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["AllTotal"], "")),
                        ExpectedHours = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["ExpectedHours"], "")),
                        CurrentDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["CurrentDate"], "")),
                        Period = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["Period"], "")),
                    };
                    WeekDaysList.Add(weekDays);
                }
                return WeekDaysList;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added By Usha Pandit On 17.04.2020 For getting project work hours
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        [HttpPost]
        public object GetProjectWorkHours([FromBody] int projectId)
        {
            try
            {
                string strSQL;
                strSQL = "EXEC usp_Whizible2_Sel_PM_DepartmentBalanceLCE @ProjectID = " + projectId;
                AssignHours ObjAssignHours = new AssignHours();
                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ObjAssignHours.AllocatedLCETotal = CommonFunctions.Data.CheckIsDBNull(sdr["AllocatedLCETotal"], "0").ToString();
                    ObjAssignHours.LCETotal = CommonFunctions.Data.CheckIsDBNull(sdr["LCETotal"], "0").ToString();
                }

                CommonFunctions.Data.DisposeDataReader(ref sdr);

                return (object)ObjAssignHours;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End Of Added By Usha Pandit On 17.04.2020 For getting project work hours
        //Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
        [Authorize]
        [HttpPost]
        public object GetCorporateOverrideTSCheck()
        {
            try
            {
                string strSQL;
                strSQL = "EXEC usp_Sel_CheckConfi_tbl_Whizible2_PM_ProjectSettings";
                bool IsAllowOverrideTS = false;
                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    IsAllowOverrideTS = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(sdr["IsAllowOverrideTS"], "0"));
                }

                CommonFunctions.Data.DisposeDataReader(ref sdr);

                return IsAllowOverrideTS;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End Of Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
        //Added By Usha Pandit On 08.03.2021 For getting corporate TS BackdatingDays Difference settings
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        [HttpPost]
        public object GetCorporateAllowToResubmitCheck([FromBody] TaskParameters taskParameters)
        {
            try
            {
                string strSQL;
                strSQL = "EXEC usp_Sel_Whizible2_DA_MaxEntryDate_ByTimehsheetID '" + taskParameters.strTimesheetIDs + "'," + taskParameters.intApproverID + ",'" + taskParameters.FromWhere + "'," + taskParameters.ProjectID + "";
                string IsAllowToResubmitCheck = "0";
                string IsBackDatingProject = "0";
                string IsForwardingProject = "0";
                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    IsAllowToResubmitCheck = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["AllowOverrideTS"], "0"));
                    //Added By Dipali V On 22nd March 2021 For Checking Project Level Backwarding & Forwarding Days
                    IsBackDatingProject = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["BackDatingProject"], "0"));
                    IsForwardingProject = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ForwardingProject"], "0"));
                    //End of Added By Dipali V On 22nd March 2021 For Checking Project Level Backwarding & Forwarding Days
                }

                CommonFunctions.Data.DisposeDataReader(ref sdr);

                return IsAllowToResubmitCheck + "," + IsBackDatingProject + "," + IsForwardingProject;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End Of Added By Usha Pandit On 08.03.2021 For getting corporate TS Override settings
        //Added By Usha Pandit On 09.03.2021 For getting Back dating No Days
        [Authorize]
        [HttpPost]
        public object GetBackdatingNoDays()
        {
            try
            {
                string strSQL;
                string BackdatingNoDays = "0";
                IDataReader sdr;
                strSQL = "usp_SEL_Tbl_PM_CompanyInformation ";
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    //BackdatingNoDays = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["BackdatingNoDays"], "0"));
                    BackdatingNoDays = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["BackdatingNoDays"], "00"));
                }
                return BackdatingNoDays;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
            //End Of Added By Usha Pandit On 09.03.2021 For getting Back dating No Days
        }

    public class TaskParameters
    {
        public int intEmployeeID { get; set; }
        public string dtFromDate { get; set; }
        public string dtToDate { get; set; }
        public string dtSelectedDate { get; set; }
        public string ViewTimesheetPageLoad { get; set; }//Added By Dipali V On 22nd May 2023 For Flag 
        public int intIsDefault { get; set; }
        public string strWhichTask { get; set; }
        public string strTaskIDList { get; set; }
        public string strFilterProjectList { get; set; }
        public string strFilterTaskTypeList { get; set; }
        public string strFilterTaskCategories { get; set; }
        public string strFilterBillable { get; set; }
        public string strFilterPriorityList { get; set; }
        public string strFilterPhaseList { get; set; }
        public string strFilterMilestoneList { get; set; }
        public string strFilterSubProjectList { get; set; }
        public string strFilterModuleList { get; set; }
        public string strFilterDeliverableList { get; set; }
        public string strFilterTaskStatus { get; set; }
        public int ProjectID { get; set; }
        public int TaskID { get; set; }
        public int SubTasktypeID { get; set; }
        //Added by Vishal Mane on 09/10/2024 to fix Base issue on Timesheet Filter page when we select All Projects
        //public int FilterProjectID { get; set; }
        public string FilterProjectID { get; set; }
        //End of Added by Vishal Mane on 09/10/2024 to fix Base issue on Timesheet Filter page when we select All Projects
        public int FilterTaskTypeID { get; set; }
        //public float Duration { get; set; }
        public string Duration { get; set; }
        //public float TotalDuration { get; set; }
        public string TotalDuration { get; set; } //Added By Chetan M on 17 March 2021
        //public bool IsTaskComplete { get; set; }
        public int IsTaskComplete { get; set; }
        public int DailyActivityEntryID { get; set; }
        public string Description { get; set; }
        public bool IsDurationChange { get; set; }
        //public float ActualPercentComplete { get; set; }
        public string ActualPercentComplete { get; set; }
        public bool bitResourceTaskComplete { get; set; }
        public int StoryPoint { get; set; }
        public int bitFlag { get; set; }
        public string TaskName { get; set; }
        public int PriorityID { get; set; }
        public string CreatedBy { get; set; }
        public string SubTaskTypeList { get; set; }
        public int intMobileView { get; set; } = 0;
        public string CTselectdate { get; set; }
        public int intSubTaskTypeID { get; set; }
        public int intTimesheetID { get; set; } = 0;
        public int intApproverID { get; set; }
        //Added By Usha Pandit On 10.03.2021 For getting corporate TS Override settings
        public string strTimesheetIDs { get; set; }
        public string FromWhere { get; set; }
        //End Of Added By Usha Pandit On 10.03.2021 For getting corporate TS Override settings
        //Added By Usha Pandit On 22.03.2021 For responsive actual hours entered validation
        public string Flag { get; set; }
        //End Of Added By Usha Pandit On 22.03.2021 For responsive actual hours entered validation

    }
}