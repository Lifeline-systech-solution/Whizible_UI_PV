using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WhizibleAPI.Models.Reference;

namespace WhizibleAPI.Models.Task
{
    public class DropdownValues
    {
        public List<References> TaskTypes { get; set; }
        public List<References> Phases { get; set; }
        public List<References> Modules { get; set; }
        public List<References> SubProjects { get; set; }
        public List<References> Milestones { get; set; }
        public List<References> Features { get; set; }
        public List<References> Deliverables { get; set; }
    }
}