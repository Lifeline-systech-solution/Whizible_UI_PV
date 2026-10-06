using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PM
{
    public class TaskExcelUpload
    {
        public int ProjectID { get; set; }
        public int EmployeeID { get; set; }
        public int RequestID { get; set; }
        public string RequestName { get; set; }
        public string RequestDescription { get; set; }
        public int TemplateID { get; set; }
        public int StartRow { get; set; }
        public int EndRow { get; set; }
        public string TemplateName { get; set; }
        public string Status { get; set; }
        public int Flag { get; set; }
    }
}