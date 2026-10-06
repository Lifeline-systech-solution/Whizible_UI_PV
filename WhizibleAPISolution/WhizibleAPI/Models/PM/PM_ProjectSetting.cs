using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

namespace WhizibleAPI.Models.PM
{
    public class PM_ProjectSetting
    {
    }
    public class ConfigParameter
    {
        //Project Level SLA
        public int ProjectID { get; set; }
        public string ProjectSLAID { get; set; }
        public int CorporateCustomerID { get; set; }
        public int CorporateSLAID { get; set; }
        public string CorporateType { get; set; }
        public int CorporateSLADetailID { get; set; }
        public int Flag { get; set; }
        public int ProjectSLADetailID { get; set; }
        public string Norm { get; set; }
        public string Unit { get; set; }
        public string UniqueID { get; set; }
        public string WeekDay { get; set; }
        public string IsWorking { get; set; }
        public string FromTime { get; set; }
        public string ToTime { get; set; }
        public int TagID { get; set; }
        public int CustomerID { get; set; }

        //Integration Setup
        public string IntegrationID { get; set; }
        public int SystemID { get; set; }
        public string FilePath  { get; set; }
        public int TimeZoneID { get; set; }
        public string IsSingleFLDForDateTime { get; set; }
        public string DisableReassignment { get; set; }
        public string UserName { get; set; }
        public string IsActiveAttribute { get; set; }
        public string WhizSysAttributeID { get; set; }
        public string SysAttributeName { get; set; }
        public string WhizAttributeName { get; set; }
        public string IsCustomeField  { get; set; }
        public string IsMandatory { get; set; }
        public string strOrderNo { get; set; }
        public int UserID { get; set; }
    }

    public class AttributeList
    {
        public string WhizAttributeName { get; set; }
        public string InsWhizAttributeName  { get; set; }
        public string strOrderNo { get; set; }
        public string IsMandatory { get; set; }
        public string WhizValue { get; set; }
        public string SysValue { get; set; }
        public int WhizSysValueID { get; set; }
    }

    public class Kernels
    {
        public int ProjectId { get; set; }
        public int KernelId { get; set; }
        public int[] KernelIds { get; set; }
        public string Kernel { get; set; }
        public string CreatedBy { get; set; }
        public DataTable GetKernelData { get; set; }
        public DataTable GetKernelList { get; set; }
        public DataTable GetKernelSpecificData { get; set; }
    }
    public class ProjectOS
    {
        public int ProjectId { get; set; }
        public int ProjectOSID { get; set; }
        public int[] ProjectOSIDs { get; set; }
        public string OS { get; set; }
        public string CreatedBy { get; set; }
        public DataTable GetProjectOSData { get; set; }
        public DataTable GetProjectOSList { get; set; }

    }
    public class ServiceSegmentation
    {
        public int ProjectId { get; set; }
        public DataTable GetServiceSegmentationData { get; set; }
        public DataTable GetServicesSegmentationIDs { get; set; }
        public DataTable GetServiceOfferingIDs { get; set; }
        public DataTable GetSubServiceOfferingIDs { get; set; }
        public string AllIds { get; set; }

    }
    public class ConfigureApprovers
    {
        public int ProjectId { get; set; }
        public int ReportToId { get; set; }
        public int RoleId { get; set; }
        public int EmployeeId { get; set; }
        public int[] ApproverIds { get; set; }
        public DataTable RowWiseApprovers { get; set; }
        public DataTable RowwiseApprovers_History { get; set; }
        public DataTable Approverlst { get; set; }
        public DataTable GetDefaultApproverName { get; set; }

    }

    public class IRRelatedSettings
    {
        public int ProjectId { get; set; }
        public string strSubTagName { get; set; }
        public int RoleID { get; set; }
        public int UserID { get; set; }
        public int CompanyID { get; set; }
        public int ApproverID { get; set; }
        public int GeneratorID { get; set; }
        public int BaseCurrency { get; set; }
        public int TagID { get; set; }
        public int ID { get; set; }
        public string LoginType { get; set; }
        public string FieldValue { get; set; }

        public string ProjectOrProduct { get; set; }
        public string ModifiedBy { get; set; }
        public DataTable SalesPersonsDetails { get; set; }
        public DataTable ProjectDetails { get; set; }
        public DataTable SalesPersonslist { get; set; }
        public DataTable IRApproversAccess { get; set; }
        public DataTable SalesCommissionSettingsAccess { get; set; }
        public DataTable InvoiceGeneratorsAccess { get; set; }
        public DataTable Role_RFIApprover { get; set; }
        public DataTable PM_AccountPersonList { get; set; }
        public DataTable IRApprovers { get; set; }
        public DataTable InvoiceGenerators { get; set; }
        public DataTable ProjectHistroy { get; set; }
        public DataTable ProjectHistroyTemp { get; set; }
        public int SalesPersonID { get; set; }
        public float SalesCommissionPercentage { get; set; }
        public int ProjectSalesPersonID { get; set; }
        public int[] ProjectSalesPersonIDs { get; set; }
        public int[] IDs { get; set; }

    }
    public class CreateProject
    {
        //@intTagID,@intRoleID,@intUserID,@strLoginType,@intProjectID,@intParentTagID
        public int TagID { get; set; }
        public int RoleID { get; set; }
        public int UserID { get; set; }
        public string LoginType { get; set; }
        public int ProjectID { get; set; }
        public int ParentTagID { get; set; }
        public DataTable GetDetailsWithAccess { get; set; }
        public DataTable NodeAccess { get; set; }
        public IDataReader TaskTypeColorDetails { get; set; }


    }


}