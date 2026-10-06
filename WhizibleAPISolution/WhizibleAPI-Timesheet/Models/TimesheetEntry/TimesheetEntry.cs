using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.TimesheetEntry
{
    public class TimesheetEntry
    {
        public int intEmployeeID { get; set; }
        public string dtFromDate { get; set; }
        public string dtToDate { get; set; }
        public string dtSelectedDate { get; set; }
        public string ViewTimesheetPageLoad { get; set; }
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
        //public string strFilterSOWCategory { get; set; }
        //public string strFilterSOWParticulars { get; set; }
        public int ProjectID { get; set; }
        public int TaskID { get; set; }
        public int SubTasktypeID { get; set; }
        public int FilterProjectID { get; set; }
        public int FilterTaskTypeID { get; set; }

        public string Duration { get; set; }

        public string TotalDuration { get; set; }

        public int IsTaskComplete { get; set; }
        public int DailyActivityEntryID { get; set; }
        public string Description { get; set; }
        public bool IsDurationChange { get; set; }

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

        public string strTimesheetIDs { get; set; }
        public string FromWhere { get; set; }

        public string Flag { get; set; }

        //public int SOWCategory { get; set; }
        //public int SOWParticulars { get; set; }
        public int Phase { get; set; }
        public int Milestone { get; set; }
        public string MilestoneName { get; set; }
        public string ProjectIDs { get; set; }
        public int TaskTypeID { get; set; }
        public string TaskType { get; set; }
        public string WhereClause { get; set; }
        //Added by Vishal Mane on 19/08/2025 to update Proxy Resource ID in tbl_pm_DailyActivity
        public int ProxyResourceID { get; set; }
        //End of Added by Vishal Mane on 19/08/2025 to update Proxy Resource ID in tbl_pm_DailyActivity
    }

    public class TaskParameters
    {
        public int intEmployeeID { get; set; }
        public string dtFromDate { get; set; }
        public string dtToDate { get; set; }
        public string dtSelectedDate { get; set; }
        public string ViewTimesheetPageLoad { get; set; }
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
        public int FilterProjectID { get; set; }
        public int FilterTaskTypeID { get; set; }

        public string Duration { get; set; }

        public string TotalDuration { get; set; }

        public int IsTaskComplete { get; set; }
        public int DailyActivityEntryID { get; set; }
        public string Description { get; set; }
        public bool IsDurationChange { get; set; }

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
        public string strTimesheetIDs { get; set; }
        public string FromWhere { get; set; }

        public string Flag { get; set; }
        //public int SOWCategory { get; set; }
        //public int SOWParticulars { get; set; }
        public int Phase { get; set; }
        public int Milestone { get; set; }

    }

    public class DAParams
    {
        public int DailyActivityEntryID { get; set; }
        public int TaskID { get; set; }
        public int ProjectID { get; set; }
        public int EmployeeID { get; set; }
        public string EntryDate { get; set; }
        public float Duration { get; set; }
        public string Description { get; set; }
        public int SubTasktypeID { get; set; }
        public bool IsDurationChange { get; set; }
        public bool IsTaskComplete { get; set; }
        public float ActualPercentComplete { get; set; }
        public bool bitResourceTaskComplete { get; set; }
        public int StoryPoint { get; set; }
        //2021
        public string dtFromDate { get; set; }
        public string dtToDate { get; set; }

        //Added by Vishal Mane on 19/08/2025 to update Proxy Resource ID in tbl_pm_DailyActivity
        public int ProxyResourceID { get; set; }
        //End of Added by Vishal Mane on 19/08/2025 to update Proxy Resource ID in tbl_pm_DailyActivity
        //2021
    }

    public class RequestParameters
    {
        public int Flag { get; set; }
        public string WorkHrs { get; set; }

    }
}