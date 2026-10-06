using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RR_TimesSheetStorage
    {
        public string OrganizationUnit { get; set; }
        public string EmployeeName { get; set; }
        public string ReportingTo { get; set; }
        //Comment And Added by imran on 13-01-2022
        //public double MaxWorkAvailability { get; set; }
        public string MaxWorkAvailability { get; set; }
        public string RecordedHours { get; set; }
        //public double UnrecordedHours { get; set; }
        public string UnrecordedHours { get; set; }
        //End Of Comment by imran on 13-01-2022
    }
    public class RR_TimesSheetStorageFilter
    {
        public int LocationID { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public int intUserID { get; set; }
        public string ReportFormat { get; set; }
    }
    public class RR_TimesSheetStorageList
    {
        public string OrganizationUnit { get; set; }
        public List<RR_TimesSheetStorage> lstTSReport { get; set; }
    }
}
