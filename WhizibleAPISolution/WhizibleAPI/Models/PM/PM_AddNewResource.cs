using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PM
{
    public class PM_AddNewResource
    {
        public ProjectDates ProjectDates { get; set; }
        public List<RoleCounts> countLists { get; set; }
        public List<HeaderRow> headerLists { get; set; }
        public List<MonthDates> MonthDatesLists { get; set; }
        public List<ResourceDetails> ResourceDetailsLists { get; set; }
        public List<ResourceProjects> ResourceProjectsLists { get; set; }
        public List<ReportingTo> ReportingTos { get; set; }
    }
    public class ProjectDates
    {
        public string DateLabel { get; set; }
    }
    public class RoleCounts
    {
        public int RoleID { get; set; }
        public string Role { get; set; }
        public int RoleCount { get; set; }
        public string ProjectStartDate { get; set; }
        public string ProjectStartMonth { get; set; }
        public int TotalDays { get; set; }
    }
    public class HeaderRow
    {
        public string day { get; set; }
        public string date { get; set; }
        public int ResourceCount { get; set; }
        //added by dipali V on 30th Dec 2019
        public int IsWorking { get; set; }
    }
    public class MonthDates
    {
        public string prevDate { get; set; }
        public string prevMonth { get; set; }
        public string nextDate { get; set; }
        public string nextMonth { get; set; }
    }

    public class ResourceDetails
    {
        public int EmployeeID { get; set; }
        public string EmployeeName { get; set; }
        public string RoleDescription { get; set; }
        public int TotalProjectAssigned { get; set; }
        public float AllocatedPercentage { get; set; }
        public float AvailablePercentage { get; set; }
        public string MonthDate { get; set; }
        public int IsLast { get; set; }
        public int IsOverAllocated { get; set; }
        public int IsOverAvailable { get; set; }
        public string QueryText { get; set; }
    }
    public class ResourceProjects
    {
        public string ProjectName { get; set; }
        public float ResourcePercentage { get; set; }
    }
    public class ReportingTo
    {
        public int EmployeeID { get; set; }
        public string EmployeeName { get; set; }
    }
}