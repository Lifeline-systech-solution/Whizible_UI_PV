using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PMDashboard
{
    public class PMDashboard
    { 


        public int ETCID { get; set; }
        public int AnalysisID { get; set; }
        public int DailyActivityEntryID { get; set; }
        public int GetConcatenatedTaskID { get; set; }
        public int AssignedTasksFlag { get; set; }
        public int ScheduleID { get; set; }
        public int DeliverableUniqueid { get; set; }
        public int ReportID { get; set; }
        public int UniqueID { get; set; }
        public int TaskID { get; set; }
        public int Flag { get; set; }
        public int Querytype { get; set; }
        public int ProjectID { get; set; }
        public int MileStoneID { get; set; }
        public int UserID { get; set; }
        public int TagID { get; set; }
        public int IssueID { get; set; }
        public int GetProjectCount { get; set; }
        public int isComplete { get; set; } 
        public string FromDate { get; set; }
        public string ToDate { get; set; }
        public string OrderByClause { get; set; }
        public string WhereClause { get; set; }
        public string UserName { get; set; } 
        public string FromWhere { get; set; } 
        public string Paging { get; set; } 
        public string SortBy { get; set; } 
        public string SortOrder { get; set; } 
        public string Flagg { get; set; } 
        public string FlagTo { get; set; } 
        public string DueDate { get; set; }  
        public string ReportFormat { get; set; }  
        public string LoginType { get; set; }  
        public string ProjecIDs { get; set; }  
    }
}