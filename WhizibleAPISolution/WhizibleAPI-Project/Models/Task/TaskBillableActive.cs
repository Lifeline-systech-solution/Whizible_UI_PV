using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.Task
{
    public class TaskBillableActive
    {
        public int TaskId { get; set; }
        public bool Billable { get; set; }
        public bool Active { get; set; }
        public int m_lngProjectId { get; set; }
    }
    public class TaskBillableActiveList
    {
        public List<TaskBillableActive> taskBillableActives { get; set; }
    }
}