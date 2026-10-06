using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PM
{
    public class PM_BackupPlans
    {
        public int BackPlanID { get; set; }
        public int ProjectId { get; set; }
        public string Description { get; set; }
        public string Responsibility { get; set; }
        public string Frequency { get; set; }
        public string DirectoryLocation { get; set; }
        public string Media { get; set; }
        public int NumberOfCopies { get; set; }
        public string Remarks { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
    }

    public class BackupPlanParameter
    {
        public int ProjectId { get; set; }
        public int EmployeeID { get; set; }
        public string UserName { get; set; }
        public string LoginType { get; set; }
        
        // Optional filter parameters
        public int? BackPlanID { get; set; }
        public string Responsibility { get; set; }
        public string DirectoryLocation { get; set; }
        public string Frequency { get; set; }
        public string Media { get; set; }
        public int? NumberOfCopies { get; set; }
        public string Remarks { get; set; }
        
        // Pagination parameters
        public int PageNumber { get; set; } = 1;
        public int PageSize { get; set; } = 10;
    }

    // Project selection parameter model to match PM_Risks pattern
    public class ProjectSelectionParameter
    {
        public int EmployeeId { get; set; }
        public int ProjectId { get; set; }
        public string LoginType { get; set; }
    }

    public class BackupPlanInsertParameter
    {
        public int ProjectId { get; set; }
        public string Description { get; set; }
        public string Responsibility { get; set; }
        public string DirectoryLocation { get; set; }
        public string Frequency { get; set; }
        public string Media { get; set; }
        public int NumberOfCopies { get; set; }
        public string Remarks { get; set; }
        public string CreatedBy { get; set; }
    }

    public class BackupPlanUpdateParameter
    {
        public int BackPlanID { get; set; }
        public int ProjectId { get; set; }
        public string Description { get; set; }
        public string Responsibility { get; set; }
        public string DirectoryLocation { get; set; }
        public string Frequency { get; set; }
        public string Media { get; set; }
        public int NumberOfCopies { get; set; }
        public string Remarks { get; set; }
        public string ModifiedBy { get; set; }
    }

    public class BackupPlanDeleteParameter
    {
        public int BackPlanID { get; set; }
    }


    // History Management Models
    public class BackupPlanHistoryParameter
    {
        public int ProjectId { get; set; }
        public int BackPlanID { get; set; }
        public string ModifiedField { get; set; }
        public string ModifiedBy { get; set; }
    }

    public class BackupPlanHistoryFilterParameter
    {
        public int ProjectId { get; set; }
        public int BackPlanID { get; set; }
        public int Flag { get; set; }
    }

    // Pagination response model
    public class BackupPlanResponse
    {
        public List<PM_BackupPlans> Data { get; set; }
        public int TotalRecords { get; set; }
        public int CurrentPage { get; set; }
        public int PageSize { get; set; }
        public int TotalPages { get; set; }
    }

}