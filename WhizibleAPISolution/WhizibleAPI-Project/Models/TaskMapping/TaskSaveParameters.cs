using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.TaskMapping
{
    public class TaskSaveParameters
    {
        public List<TaskParameters> taskParameters { get; set; }
    }

    public class TaskParameters
    {
        public int TaskId { get; set; }
        public string ColumnName { get; set; }
        public string ColumnValueString { get; set; }
        public int ColumnValueInt { get; set; }
        public string Mode { get; set; }
        public string Action { get; set; }
        public int ProjectId { get; set; }
        public int PhaseId { get; set; }
        public string Phase { get; set; }
        public int TaskTypeId { get; set; }
        public string TaskType { get; set; }
        public int ModuleId { get; set; }
        public string Module { get; set; }
        public int SubProjectId { get; set; }
        public string SubProject { get; set; }
        public int MilestoneId { get; set; }
        public string Milestone { get; set; }
        public int FeatureId { get; set; }
        public int DeliverableId { get; set; }
    }
}