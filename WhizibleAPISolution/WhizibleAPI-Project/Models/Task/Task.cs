using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.Task
{
    public class Task
    {
        public string UserName { get; set; }
        public string Priority { get; set; }
        public string Whichtask { get; set; }
        public string TaskName { get; set; }
        public bool IsUserStoryTask { get; set; }
        public int TaskID { get; set; }
        public string ActualPercentComplete { get; set; }
        public bool IsTaskComplete { get; set; }
        public string CurrentStart { get; set; }
        public string CurrentEnd { get; set; }
        public string CurrentDuration { get; set; }
        public string CurrentDecimalWork { get; set; }
        public string CurrentDecimalWorkHHMM { get; set; }
        public string CurrentWork { get; set; }
        public string BaseLineStart { get; set; }
        public string BaseLineEnd { get; set; }
        public string BaseLineDuration { get; set; }
        public string BaseLineDecimalWork { get; set; }
        public string BaseLineDecimalWorkHHMM { get; set; }
        public string BaseLineWork { get; set; }
        public string ActualStart { get; set; }
        public string ActualEnd { get; set; }
        public string ActualDecimalWork { get; set; }
        public string ActualDecimalWorkHHMM { get; set; }
        public string ActualWork { get; set; }
        public string ActualDuration { get; set; }
        public bool BillableYN { get; set; }
        public bool IsActive { get; set; }
        public string ModuleName { get; set; }
        public bool TaskOnHold { get; set; }
        public int PhaseId { get; set; }
        public int ModuleId { get; set; }
        public int SubProjectId { get; set; }
        public int MilestoneId { get; set; }
        public int ProjectFeatureId { get; set; }
        public int DeliverableId { get; set; }
        public int TaskTypeId { get; set; }
        public string TotalCurrentDecimalWorkHHMM { get; set; }
        public string TotalBaseLineDecimalWorkHHMM { get; set; }
        public string TotalActualDecimalWorkHHMM { get; set; }
    }
}