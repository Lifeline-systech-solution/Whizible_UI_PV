using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.Task
{
    public class TaskInput
    {
        public string Flag { get; set; }
        public int ProjectId { get; set; }
        public string PageNumber { get; set; }
        public string EmployeeId { get; set; }
        public string SortBy { get; set; }
        public string ActiveAll { get; set; }
        
    }
}