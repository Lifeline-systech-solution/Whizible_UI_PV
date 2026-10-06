using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.TaskStatus
{
    public class TaskStatusManagement
    {
        public int ParentTask_UID { get; set; }
        public int TaskId { get; set; }
        public int UniqueID { get; set; }
        public int DepartmentId { get; set; }
        public string TaskName { get; set; }
        public int EmployeeId { get; set; }
        public string EmployeeName { get; set; }
        public string SubTaskTypes { get; set; }
        public string PlannedWork { get; set; }
        public string ActualWork { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string BaselineStart { get; set; }
        public string BaselineEnd { get; set; }
        public string ActualStartDate { get; set; }
        public string ActualEndDate { get; set; }
        public string HasChildTasks { get; set; }
        public string CreatedDate { get; set; }
        public bool IsTaskComplete { get; set; }
        public string ActualPercentComplete { get; set; }
        public bool TaskStatus { get; set; }
        public double Parenttaskwork { get; set; }
        public double childworkhrs { get; set; }
        public double strtotalworkhrs { get; set; }
        public string PStartDate { get; set; }
        public string PEndDate { get; set; }
        public bool IsUserStoryTask { get; set; }
    }
}