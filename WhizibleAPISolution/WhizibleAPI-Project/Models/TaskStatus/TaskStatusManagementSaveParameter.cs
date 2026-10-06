using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.TaskStatus
{
    public class TaskStatusManagementSaveParameterList
    {
        public List<TaskStatusManagementSaveParameter> taskStatusManagementSaveParameters { get; set; }
    }
    public class TaskStatusManagementSaveParameter
    {
        public int m_intOperation { get; set; }
        public int ProjectId { get; set; }
        public int TaskId { get; set; }
        public int ParentTaskId { get; set; }
        public string TaskType { get; set; }
        public string strActualPercentComplete { get; set; }
        public string strTaskActualStartDate { get; set; }
        public string strTaskActualEndDate { get; set; }
        public int m_intMSPIntegrationMethod { get; set; }
    }
}