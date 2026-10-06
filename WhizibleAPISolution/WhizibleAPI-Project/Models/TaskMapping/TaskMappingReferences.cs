using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WhizibleAPI.Models.Reference;

namespace WhizibleAPI.Models.TaskMapping
{
    public class TaskMappingReferences
    {
        public List<StringReference> Fields { get; set; }
        public List<StringReference> TaskTypes { get; set; }
        public List<StringReference> Phases { get; set; }
        public List<StringReference> Modules { get; set; }
        public List<StringReference> SubProjects { get; set; }
        public List<StringReference> Milestones { get; set; }
        public List<StringReference> Features { get; set; }
        public List<StringReference> Deliverables { get; set; }
        public bool ShowPhases { get; set; }
        public bool ShowModules { get; set; }
        public bool ShowSubProjects { get; set; }
        public bool ShowMilestones { get; set; }
        public bool ShowFeatures { get; set; }
        public bool DisableTaskTypes { get; set; }
        public bool DisablePhases { get; set; }
        public bool DisableModules { get; set; }
        public bool DisableSubProjects { get; set; }
        public bool DisableMilestones { get; set; }
        public bool DisableFeatures { get; set; }
        public bool DisableDeliverables { get; set; }
        public int CountOfTaskInPhases { get; set; }
        public int CountOfTaskInModules { get; set; }
        public int CountOfTaskInSubProjects { get; set; }
        public int CountOfTaskInMilestones { get; set; }
        public int CountOfTaskInFeatures { get; set; }
        public int CountOfTaskInDeliverables { get; set; }
        public int CountOfTaskInTaskTypes { get; set; }

    }
}