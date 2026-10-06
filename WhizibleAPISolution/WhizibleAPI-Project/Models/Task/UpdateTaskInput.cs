using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.Task
{
    public class UpdateTaskInput
    {
        public string DeliverableId { get; set; }
        public string TaskTypeId { get; set; }
        public string TaskType { get; set; }
        public string PhaseId { get; set; }
        public string Phase { get; set; }
        public string ModuleId { get; set; }
        public string SubProjectId { get; set; }
        public string SubProject { get; set; }
        public string Module { get; set; }
        public string MilestoneId { get; set; }
        public string Milestone { get; set; }
        public string FeatureId { get; set; }
        public string TaskId { get; set; }
    }
}