using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.Task
{
    public class TaskActualPercentage
    {
        public int TaskId { get; set; }
        public string ActualPercentage { get; set; }
        public string PrevActualPercentage { get; set; }
        public string m_strTaskType { get; set; }
    }

    public class TaskActualPercentageList {
       public List<TaskActualPercentage> taskActualPercentages { get; set; }
    }
}