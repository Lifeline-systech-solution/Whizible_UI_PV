using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.Task
{
    public class BaselineTask
    {
        public string BaselineChangeDate { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string BaselineStartDate { get; set; }
        public string BaselineEndDate { get; set; }
        public string Work { get; set; }
        public string Duration { get; set; }
    }
}