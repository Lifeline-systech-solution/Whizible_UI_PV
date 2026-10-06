using System;
using System.Data;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models.PM;

namespace WhizibleAPI.Controllers
{

    public class PM_Resource_SelectionController : ApiController
    {
        //Added controller Code by Imran 24-06-2021


        ////Get Resources list for Project   
        [HttpPost]
        [Authorize]
        public object GetResourcesList([FromBody] ResourceSelectionParameter ResourceParameters)
        {
            try
            {
                string strSQL = "";
                if (ResourceParameters.Role == null || ResourceParameters.Role == "Select Role")
                {
                    ResourceParameters.Role = "null";
                }
                else
                {
                    ResourceParameters.Role = ResourceParameters.Role;
                }

                if (ResourceParameters.DesignationName == null || ResourceParameters.DesignationName == "Select Designation")
                {
                    ResourceParameters.DesignationName = "null";
                }
                else
                {
                    ResourceParameters.DesignationName = ResourceParameters.DesignationName;
                }

                if (ResourceParameters.Department == null || ResourceParameters.Department == "Select Department")
                {
                    ResourceParameters.Department = "null";
                }
                else
                {
                    ResourceParameters.Department = ResourceParameters.Department;
                }

                if (ResourceParameters.BusinessGroup == null || ResourceParameters.BusinessGroup == "Select Business Group")
                {
                    ResourceParameters.BusinessGroup = "null";
                }
                else
                {
                    ResourceParameters.BusinessGroup = ResourceParameters.BusinessGroup;
                }

                if (ResourceParameters.Location == null || ResourceParameters.Location == "Select Organization Unit")
                {
                    ResourceParameters.Location = "null";
                }
                else
                {
                    ResourceParameters.Location = ResourceParameters.Location;
                }

                if (ResourceParameters.EmployeeName == null || ResourceParameters.EmployeeName == "")
                {
                    ResourceParameters.EmployeeName = "null";
                }
                else
                {
                    ResourceParameters.EmployeeName = ResourceParameters.EmployeeName;
                }
                strSQL = "Exec use_Sel_Whizible2_PM_Resource_Selection_DataTable " + "'" + ResourceParameters.Role + "'," + "'" + ResourceParameters.DesignationName + "'," + "'" + ResourceParameters.Department + "'," + "'" + ResourceParameters.BusinessGroup + "'," + "'" + ResourceParameters.Location + "'," + "'" + ResourceParameters.EmployeeName + "'," + "'" + ResourceParameters.ProjectID + "'";
                DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Get Resources list for Basic Filter
        [HttpPost]
        [Authorize]
        public object GetResourcesListAsPerBasicFilter([FromBody] ResourceSelectionParameter ResourceParameters)
        {
            try
            {
                string strSQL = ""; string twh = "";
                if (ResourceParameters.Role == null || ResourceParameters.Role == "Select Role")
                {
                    ResourceParameters.Role = "null";
                }
                else
                {
                    ResourceParameters.Role = ResourceParameters.Role;
                }

                if (ResourceParameters.DesignationName == null || ResourceParameters.DesignationName == "Select Designation")
                {
                    ResourceParameters.DesignationName = "null";
                }
                else
                {
                    ResourceParameters.DesignationName = ResourceParameters.DesignationName;
                }

                if (ResourceParameters.Department == null || ResourceParameters.Department == "Select Department")
                {
                    ResourceParameters.Department = "null";
                }
                else
                {
                    ResourceParameters.Department = ResourceParameters.Department;
                }

                if (ResourceParameters.BusinessGroup == null || ResourceParameters.BusinessGroup == "Select Business Group")
                {
                    ResourceParameters.BusinessGroup = "null";
                }
                else
                {
                    ResourceParameters.BusinessGroup = ResourceParameters.BusinessGroup;
                }

                if (ResourceParameters.Location == null || ResourceParameters.Location == "Select Organization Unit")
                {
                    ResourceParameters.Location = "null";
                }
                else
                {
                    ResourceParameters.Location = ResourceParameters.Location;
                }


                if (ResourceParameters.UserName == null || ResourceParameters.UserName == "")
                {
                    ResourceParameters.UserName = "null";
                }
                else
                {
                    ResourceParameters.UserName = ResourceParameters.UserName;
                }

                if (ResourceParameters.ResourceName == null || ResourceParameters.ResourceName == "")
                {
                    ResourceParameters.ResourceName = "null";
                }
                else
                {
                    ResourceParameters.ResourceName = ResourceParameters.ResourceName;
                }

                strSQL = "Exec use_Sel_Whizible2_PM_Resource_Selection_DataTableFilter " + "'" + ResourceParameters.Role + "'," + "'" + ResourceParameters.DesignationName + "'," + "'" + ResourceParameters.Department + "'," + "'" + ResourceParameters.BusinessGroup + "'," + "'" + ResourceParameters.Location + "'," + "'" + ResourceParameters.UserName + "'," + "'" + ResourceParameters.ResourceName + "'," + "'" + ResourceParameters.FRNM + "'," + "'" + ResourceParameters.FDept + "'," + "'" + ResourceParameters.FBG + "'," + "'" + ResourceParameters.FOU + "'," + "'" + ResourceParameters.FRole + "'," + "'" + ResourceParameters.FDesig + "'," + "'" + ResourceParameters.FUNm + "'," + "'" + ResourceParameters.ProjectID + "' ";
                DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        [HttpPost]
        public object GetDefaultApprover([FromBody] int ProjectID)
        {
            try
            {
                string strSQL; int strmsg;
                strSQL = "Exec use_Sel_Whizible2_GetDefaultApprover " + "'" + ProjectID + "'";
                strmsg = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return strmsg;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Check is Agile or not
        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object CheckIsAgileProject([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_NG2_chk_IsAgileProject " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID));
                int dt = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //CheckReportingTo
        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object CheckReportingTo([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_CheckReportingbl_PM_ProjectEmployeeRole " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.RoleID));
                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        [HttpPost]
        public object GetCountOfResources([FromBody] int ProjectID)
        {
            try
            {
                int Count;
                Count = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_Sel_Count_d_tbl_PM_ProjectEmployeeRole " + ProjectID + "", true, CommonController.connectionString));
                return Count;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //get min hours for da Entry       
        [Authorize]
        [HttpPost]
        public object GetRestrictByMinHours_MinHoursForDAEntry()
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_RestrictByMinHours_MinHoursForDAEntry ";
                ResourceCompanyInformation Information = new ResourceCompanyInformation();
                IDataReader CmpInformation;
                CmpInformation = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (CmpInformation.Read())
                {
                    Information.RestrictByMinHours = Convert.ToBoolean(CmpInformation["RestrictByMinHours"]);
                    Information.MinHoursForDAEntry = CommonFunctions.Data.CheckIsDBNull(CmpInformation["MinHoursForDAEntry"], "0").ToString();
                }
                return Information;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Avaliable Resource Allocation
        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object GetAvaliableAllocation([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_SEL_Calculate_ResourceAvailable_Percentage " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ExpectedStartDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ExpectedEndDate)) + "'";
                string dt = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Role for Resources
        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object GetReportingToInEditMode([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_sel_tbl_PM_RowWiseExternalApprovers " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + ",0,'-1', 'RoleDescription', 'DESC'";
                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022

        //Modified By Nikhil A on 1-March-2022
        //public int AllocateResources([FromBody] ResourceParameters resourceParameters)
        //{
        //    //string strSQL = "EXEC usp_Whizible2_ins_BulkResourceAllocation " + resourceParameters.SelectedProjectID + ",NULL,NULL," + resourceParameters.SelectedRoleID + ",0,'" + resourceParameters.ExpectedStartDate + "','" + resourceParameters.ExpectedEndDate + "','" + resourceParameters.WorkHrs + "','" + resourceParameters.ResourceStatus + "'," + resourceParameters.IsResourceBillable + ",'" + resourceParameters.Responsibility.Replace("'", "''") + "'," + resourceParameters.ReportingTo + "," + resourceParameters.IschkIsDefaultApprover + ",'" + resourceParameters.SelectedResources + "'," + resourceParameters.ResourcePercentage;
        //    string strSQL = "EXEC usp_Whizible2_ins_BulkResourceAllocation " + resourceParameters.SelectedProjectID + ",NULL,NULL," + resourceParameters.SelectedRoleID + ",0,'" + resourceParameters.ExpectedStartDate + "','" + resourceParameters.ExpectedEndDate + "','" + resourceParameters.WorkHrs + "','" + resourceParameters.ResourceStatus + "'," + resourceParameters.IsResourceBillable + ",'" + resourceParameters.Responsibility.Replace("'", "''") + "'," + resourceParameters.ReportingTo + "," + resourceParameters.IschkIsDefaultApprover + ",'" + resourceParameters.SelectedResources + "'," + resourceParameters.ResourcePercentage + "," + resourceParameters.IschkIsProductOwner;

        //    int result;
        //    result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
        //    return result;
        //}
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object AllocateResources([FromBody] ResourceParameters resourceParameters)
        {
            try
            {
                //string strSQL = "EXEC usp_Whizible2_ins_BulkResourceAllocation " + resourceParameters.SelectedProjectID + ",NULL,NULL," + resourceParameters.SelectedRoleID + ",0,'" + resourceParameters.ExpectedStartDate + "','" + resourceParameters.ExpectedEndDate + "','" + resourceParameters.WorkHrs + "','" + resourceParameters.ResourceStatus + "'," + resourceParameters.IsResourceBillable + ",'" + resourceParameters.Responsibility.Replace("'", "''") + "'," + resourceParameters.ReportingTo + "," + resourceParameters.IschkIsDefaultApprover + ",'" + resourceParameters.SelectedResources + "'," + resourceParameters.ResourcePercentage;
                string strSQL = "EXEC usp_Whizible2_ins_BulkResourceAllocation " + resourceParameters.SelectedProjectID + ",NULL,NULL," + resourceParameters.SelectedRoleID + ",0,'" + resourceParameters.ExpectedStartDate + "','" + resourceParameters.ExpectedEndDate + "','" + resourceParameters.WorkHrs + "','" + resourceParameters.ResourceStatus + "'," + resourceParameters.IsResourceBillable + ",'" + resourceParameters.Responsibility.Replace("'", "''") + "'," + resourceParameters.ReportingTo + "," + resourceParameters.IschkIsDefaultApprover + ",'" + resourceParameters.SelectedResources + "'," + resourceParameters.ResourcePercentage + "," + resourceParameters.IschkIsProductOwner;

                string result;
                result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Modified By Nikhil A on 1-March-2022
        //Get the Start Date and End Date for Particular Sub Project        
        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object GetProjectStartDateEndDate([FromBody] int ProjectID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_sel_StartDate_EndDate_tbl_PM_project " + ProjectID;
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added by imran 02-08-2021 For Filter save and apply
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        [HttpPost]
        public object chkFilterExists([FromBody] FilterParameter WBSParameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_chk_FilterName_Exists_ForResourceSelection '" + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.Flag)) + "','" + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.FilterID)) + "','" + HttpUtility.UrlDecode(WBSParameters.FilterName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "', " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TagID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID));
                string Flag;
                Flag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
                return Flag;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Filter save 
        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object MilestoneSavedFilters([FromBody] FilterParameter WBSParameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + ","
                                                                    + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID)) + ", '" + HttpUtility.UrlDecode(WBSParameters.FilterName) + "', '"
                                                                    + HttpUtility.UrlDecode(WBSParameters.LoginType) + "' ," + "'" + HttpUtility.UrlDecode(WBSParameters.QueryText) + "'"
                + ",'" + HttpUtility.UrlDecode(WBSParameters.UserName) + "'," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TaskFlag)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.FilterID));
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object GetWhereClause([FromBody] FilterParameter WBSParameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_tbl_Whizible2_Filter_Query_GetWhereClause " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.FilterID));
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Resource saved filter list
        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object ResourceFilters([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_sel_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.TagID)) + ",'"
                                                                      + HttpUtility.UrlDecode(ResourceParameters.LoginType) + "'," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.UserID));
                System.Data.DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Delete Filter
        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteFilterData([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_del_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.FilterID));
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return "Filter Deleted Successfully";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Edit Filter data.
        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object EditFilterData([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_sel_ByFilterID_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.FilterID));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Set Default filter for Milestone tab
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SetDefaultFilter([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string result = "";
                string strSQL = "Exec usp_Whizible2_Upd_tbl_Whizible2_Filter_Query_SetDefaultFilter " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID));
                strSQL += ",'" + HttpUtility.UrlDecode(ResourceParameters.LoginType);
                strSQL += "'," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.UserID));
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.TagID));
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.FilterID));
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.Flag));
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                if (ResourceParameters.Flag == 0)
                {
                    result = "Set Default Filter Successfully";
                }
                else
                {
                    result = "Default Filter Cleared Successfully";
                }
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

            //End by imran 02-08-2021

        }

    public class ResourceParameters
    {
        public string SelectedProjectID { get; set; }
        public string intProjectID { get; set; }

        public string StartDate { get; set; }
        public string Flag { get; set; }
        public int intEmployeeID { get; set; }
        public int SelectedRoleID { get; set; }
        public string ExpectedStartDate { get; set; }
        public string ExpectedEndDate { get; set; }
        public string ResourceStatus { get; set; }
        public string WorkHrs { get; set; }
        public int ReportingTo { get; set; }
        public float ResourcePercentage { get; set; }
        public string SelectedResources { get; set; }
        public string Responsibility { get; set; }
        public int IsResourceBillable { get; set; }
        public int IschkIsDefaultApprover { get; set; }
        public int IschkIsProductOwner { get; set; }
        public int IsWorking { get; set; }


        //Request Rresource
        public string UserName { get; set; }
        public int UserID { get; set; }
        public string FromDate { get; set; }
        public string ToDate { get; set; }
        public int NoOfResource { get; set; }
        public int Month { get; set; }
        public int Year { get; set; }
        public int SkillName { get; set; }

        public int ProjectSkillAdd { get; set; }
        public int Rating { get; set; }
        public string Type { get; set; }
        public int ResourcePool { get; set; }
        public int Priority { get; set; }
        public string SpecialRequest { get; set; }
        public string RequestDate { get; set; }
        public int RequestID { get; set; }
        public string QueryText { get; set; }

        //Added By Reshma Chavan on 8th Oct 2020 For JDUpgrade Pagination Change
        public int PageSize { get; set; }
        public int PageNumber { get; set; }
        //End of Added By Reshma Chavan on 8th Oct 2020 For JDUpgrade Pagination Change
        //Nikhil A 17-Dec-2020 for serch 
        public string SearchText { get; set; }
        //Nikhil A

    }
    //End by controller Code by Imran 24-06-2021

    public class FilterParameter
    {
        public int Flag { get; set; }
        public int FilterID { get; set; }
        public string FilterName { get; set; }
        public int TagID { get; set; }
        public int ProjectID { get; set; }
        public int UserID { get; set; }

        public string LoginType { get; set; }
        public string QueryText { get; set; }
        public string UserName { get; set; }
        public int TaskFlag { get; set; }
    }

    public class ResourceSelectionParameter
    {
        public string Role { get; set; }
        public string EmployeeID { get; set; }
        public string EmployeeName { get; set; }
        public string UserName { get; set; }
        public string BusinessGroup { get; set; }
        public string BusinessUnit { get; set; }
        public string Department { get; set; }
        public string Location { get; set; }
        public string RoleDescription { get; set; }
        public string DesignationName { get; set; }
        public string Deployable { get; set; }
        public string ProjectID { get; set; }


        public string FDept { get; set; }
        public string FBG { get; set; }
        public string FOU { get; set; }
        public string FRole { get; set; }
        public string FDesig { get; set; }
        public string FUNm { get; set; }
        public string FRNM { get; set; }

        public string ResourceName { get; set; }
    }
}
