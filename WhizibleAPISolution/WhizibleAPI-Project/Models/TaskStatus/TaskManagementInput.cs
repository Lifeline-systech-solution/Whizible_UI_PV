using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.TaskStatus
{
    public class TaskManagementInput
    {
        public string m_intProjectID { get; set; }
        public string m_intEmployeeID { get; set; }
        public string m_dtFromDate { get; set; }
        public string m_dtToDate { get; set; }
        public string m_strTaskType { get; set; }
        public string m_intOperation { get; set; }
        public string strTaskFilter { get; set; }
    }
}