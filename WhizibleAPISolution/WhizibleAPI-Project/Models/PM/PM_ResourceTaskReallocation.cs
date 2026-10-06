using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PM
{
    public class PM_ResourceTaskReallocation
    {
        public int ProjectID { get; set; }
        public int OpenOrVoidFlag { get; set; }
        public string ResourceName { get; set; }
        public string Role { get; set; }
        public int NoOfTasks { get; set; }
        public int ResourceID { get; set; }
        public string TaskIDs { get; set; }
        public int intFromEmployeeID { get; set; }
        public int intToEmployeeID { get; set; }
        public int ProjectLocationID { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public float WorkHour { get; set; }

        public TaskIDsDetails[] TaskIDsDetails  { get; set; }
        public int MyProperty { get; set; }

        public HttpPostedFileBase ProfileImage { set; get; }

    }

    public class TaskIDsDetails
    {
        public int taskID { get; set; }
        public string startDate { get; set; }
        public string endDate { get; set; }
        public float workHour { get; set; }

    }

    public class TaskDetails
    {
        public int TaskID { get; set; }       
        public string TaskName { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string Work { get; set; }
        public string ActualWork { get; set; }
        public string RemainingWork { get; set; }

    }


    public class RM_ResourceList
    {
        public int EmployeeID { get; set; }
        public string EmployeeName { get; set; }
        
    }

   


    


}