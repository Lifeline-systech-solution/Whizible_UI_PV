using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WhizibleAPI.Extensions;
using System.Web;
using System.Data;
using WhizibleAPI.Models.RM;
using System.IO;
using System.Text.RegularExpressions;
using Newtonsoft.Json;
using Authentication;

namespace WhizibleAPI.Controllers
{
    [Authorize]
    public class RM_EmployeeMasterController : ApiController
    {
        ////Added by imran on 24-08-2022 
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022 
        [HttpPost]
        public HttpResponseMessage GetBusinessGroups([FromBody] OP_Filter OP_FilterParam)
        {

            List<OP_BusinessGroups> BgList = new List<OP_BusinessGroups>();
            try
            {

                var strSQL = "usp_Whizible2_sel_BGEmployee " + OP_FilterParam.LocationID + "," + OP_FilterParam.OprID;

                DataTable BgTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (BgTable != null)
                {
                    BgList = BgTable.ToList<OP_BusinessGroups>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, BgList);

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage GetBusinessGroupsLocation([FromBody] OP_Filter OP_FilterParam)
        {

            List<OP_BusinessGroupLocation> BusinessGroupsLocationList = new List<OP_BusinessGroupLocation>();
            try
            {

                var strSQL = "usp_Whizible2_Sel_GetBusinessGroupsForLocation " + OP_FilterParam.BusinessGroupID + "," + OP_FilterParam.OprID + "," + 0;

                DataTable BusinessGroupsLocationTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (BusinessGroupsLocationTable != null)
                {
                    BusinessGroupsLocationList = BusinessGroupsLocationTable.ToList<OP_BusinessGroupLocation>();
                }

                return Request.CreateResponse(HttpStatusCode.OK, BusinessGroupsLocationList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        // Added by Dipali V on 6th May 2026 for vendor management - active vendors for new employee and mapped inactive vendor for edit employee
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public HttpResponseMessage GetVendorDropdown([FromBody] RM_EmployeeVendorFilter vendorFilter)
        {
            var vendorList = new List<RM_EmployeeVendorDropdown>();
            try
            {
                int includeVendorID = 0;
                if (vendorFilter != null)
                {
                    includeVendorID = vendorFilter.IncludeVendorID;
                }

                string strSQL = "Exec usp_Whizible2_Sel_tbl_Whizible2_VendorMaster_Active " + includeVendorID;
                DataTable vendorTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (vendorTable != null)
                {
                    vendorList = vendorTable.ToList<RM_EmployeeVendorDropdown>();
                }

                return Request.CreateResponse(HttpStatusCode.OK, vendorList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Vishal Mane on 28/05/2026 To Make Vendor Dropdown Mandatory or Non Mandatory on Employee Master Based on Configurable Flag
        [Authorize]
        [HttpPost]
        public HttpResponseMessage GetVendorMandatoryConfig()
        {
            int isVendorMandatory = 0;
            try
            {                
                string strSQL = "Exec usp_Whizible2_tbl_RM_GetVendorMandatoryFlag";
                IDataReader drQuery = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (drQuery.Read())
                {
                    isVendorMandatory = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["IsVendorMandatory"], "0"));
                }
                return Request.CreateResponse(HttpStatusCode.OK, isVendorMandatory);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added by Vishal Mane on 28/05/2026 To Make Vendor Dropdown Mandatory or Non Mandatory on Employee Master Based on Configurable Flag

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage GetReleaseReportingToList([FromBody] RM_EmployeeReleaseApproval Op_Parameters)
        {
            var empRelease = new List<RM_EmployeeRelList>();
            try
            {
                var strSQL = "Exec usp_Whizible2_sel_tbl_PM_Employee_GetApproveToList " + Op_Parameters.ApproverID;
                DataTable releaseTbl = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (releaseTbl != null)
                {
                    empRelease = releaseTbl.ToList<RM_EmployeeRelList>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, empRelease);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //[Authorize]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        //public HttpResponseMessage SaveRelease([FromBody] List<RM_EmployeeSaveRelease> Op_Parameters)/// Release resource project
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SaveRelease([FromBody] lisEmpSaveRelease Op_Parameters)
        {

            string strtResult = string.Empty;
            string strSQL;
            try
            {
                var param = JsonConvert.SerializeObject(Op_Parameters.Op_Parameters);

                //if (Op_Parameters != null && Op_Parameters.Count > 0)
                //{
                //    foreach (var itemProjectRelease in Op_Parameters)
                //    {
                //        strSQL = "Exec Usp_Whizible2_Upd_Released_Resource " + itemProjectRelease.EmployeeID + "," + itemProjectRelease.ProjectID + "," + itemProjectRelease.ProjectRes + "," + itemProjectRelease.ApprovalRes + "," + itemProjectRelease.IRGenerator + "," + itemProjectRelease.IRApprover + ",'" + itemProjectRelease.ActualEndDate + "','" + itemProjectRelease.UserName + "'," + itemProjectRelease.WorkflowApprover + "";

                //        strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                //        if (strtResult != null)
                //        {
                //            ///return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                //        }
                //    }

                //}
                //else
                //{
                //    return Request.CreateResponse(HttpStatusCode.BadRequest);
                //}

                if (Op_Parameters != null)
                {
                    strSQL = "Exec Usp_Whizible2_Upd_Released_Resource '" + param + "'";

                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, strtResult);

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SaveReleaseResource([FromBody] RM_ReleaseResource Op_Parameters)
        {
            string strtResult = string.Empty;
            string strSQL;
            try
            {
                if (Op_Parameters != null)
                {
                    //Commented and added by Divya J on 2 September 2025 for Pointwest customisation
                    ////commented and added by Reshma on 03-03-2022
                    //strSQL = " Exec usp_Whizible2_Upd_tbl_PM_Employee_ReportingTo " + Op_Parameters.EmployeeId + "," + Op_Parameters.ReportingToId + ",'" + Op_Parameters.LeavingDate + "' ";
                    ////strSQL = " Exec usp_Whizible2_Upd_tbl_PM_Employee_ReportingTo " + Op_Parameters.EmployeeId + "," + Op_Parameters.ReportingToId + ",'" + Op_Parameters.LeavingDate + "' ,'" + Op_Parameters.CreatedBy + "'";
                    ////End of comment 03-03-2022
                    strSQL = " Exec usp_Whizible2_Upd_tbl_PM_Employee_ReportingTo " + Op_Parameters.EmployeeId + "," + Op_Parameters.ReportingToId + ",'" + Op_Parameters.LeavingDate + "' ,'" + Op_Parameters.CreatedBy + "','" + Op_Parameters.ReasonForLeaving + "'";
                    //End of Commented and added by Divya J on 2 September 2025 for Pointwest customisation
                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, strtResult);

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        public HttpResponseMessage GetReleaseIRorPIRTo([FromBody] RM_EmployeeReleaseApproval Op_Parameters)
        {
            var empRelease = new List<RM_EmployeeReleaseApprovers>();
            try
            {

                var strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Role_RFIApprover " + Op_Parameters.ProjectID;
                DataTable releaseTbl = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (releaseTbl != null)
                {
                    empRelease = releaseTbl.ToList<RM_EmployeeReleaseApprovers>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, empRelease);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        [HttpPost]
        public HttpResponseMessage GetReleaseInvoice([FromBody] RM_EmployeeReleaseApproval Op_Parameters)
        {
            var empRelease = new List<RM_EmployeeReleaseApprovers>();
            try
            {

                var strSQL = "Exec usp_Whizible2_sel_PM_AccountPersonList " + Op_Parameters.ProjectID;
                DataTable releaseTbl = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (releaseTbl != null)
                {
                    empRelease = releaseTbl.ToList<RM_EmployeeReleaseApprovers>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, empRelease);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


        [HttpPost]
        public HttpResponseMessage GetReleaseApprovalTo([FromBody] RM_EmployeeReleaseApproval Op_Parameters)
        {
            var empRelease = new List<RM_EmployeeReleaseApprovers>();
            try
            {

                var strSQL = "Exec usp_Whizible2_Sel_Approvers_List " + Op_Parameters.ProjectID + "," + Op_Parameters.ApproverID;
                DataTable releaseTbl = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (releaseTbl != null)
                {
                    empRelease = releaseTbl.ToList<RM_EmployeeReleaseApprovers>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, empRelease);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage GetReleaseProjectTo([FromBody] RM_EmployeeReleaseApproval Op_Parameters)
        {
            var EmpProjectRespToList = new List<RM_EmployeeReleaseApprovers>();
            var EmpApprovalRespToList = new List<RM_EmployeeReleaseApprovers>();
            var EmpInvoiceGenToList = new List<RM_EmployeeReleaseApprovers>();
            var EmpPirApprovalResToList = new List<RM_EmployeeReleaseApprovers>();
            try
            {
                var strSQLEmpProjectRespTo = "Exec usp_Whizible2_Sel_Approvers_List " + Op_Parameters.ProjectID + "," + Op_Parameters.ApproverID + "," + Op_Parameters.IsProjLevel;
                DataTable EmpProjectRespToTable = CommonFunctions.Data.GetDataTable(strSQLEmpProjectRespTo, true, CommonController.connectionString);
                if (EmpProjectRespToTable != null)
                {
                    EmpProjectRespToList = EmpProjectRespToTable.ToList<RM_EmployeeReleaseApprovers>();
                }
                var strSQLEmpApprovalRespTo = "Exec usp_Whizible2_Sel_Approvers_List " + Op_Parameters.ProjectID + "," + Op_Parameters.ApproverID;
                DataTable releaseTbl = CommonFunctions.Data.GetDataTable(strSQLEmpApprovalRespTo, true, CommonController.connectionString);
                if (releaseTbl != null)
                {
                    EmpApprovalRespToList = releaseTbl.ToList<RM_EmployeeReleaseApprovers>();
                }
                var strSQL = "Exec usp_Whizible2_sel_PM_AccountPersonList " + Op_Parameters.ProjectID;
                DataTable EmpInvoiceGenToAtble = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (EmpInvoiceGenToAtble != null)
                {
                    EmpInvoiceGenToList = EmpInvoiceGenToAtble.ToList<RM_EmployeeReleaseApprovers>();
                }
                var strSQLEmpPirApprovalResTo = "Exec usp_Whizible2_Sel_tbl_PM_Role_RFIApprover " + Op_Parameters.ProjectID;
                DataTable EmpPirApprovalResToTable = CommonFunctions.Data.GetDataTable(strSQLEmpPirApprovalResTo, true, CommonController.connectionString);
                if (EmpPirApprovalResToTable != null)
                {
                    EmpPirApprovalResToList = EmpPirApprovalResToTable.ToList<RM_EmployeeReleaseApprovers>();
                }
                return this.Request.CreateResponse(HttpStatusCode.OK,
            new { EmpProjectRespToLst = EmpProjectRespToList, EmpApprovalRespToLst = EmpApprovalRespToList, EmpInvoiceGenToLst = EmpInvoiceGenToList, EmpPirApprovalResToLst = EmpPirApprovalResToList });
                //return Request.CreateResponse(HttpStatusCode.OK, EmpProjectRespToList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage GetRelease([FromBody] string EmployeeID)
        {
            var empRelease = new List<RM_EmployeeRelease>();
            try
            {
                if (!string.IsNullOrEmpty(EmployeeID) && EmployeeID != null)
                {
                    // var strSQL = "Exec usp_Whizible2_Sel_Approvers_List_ToRelease 711";
                    var strSQL = "Exec usp_Whizible2_Sel_Approvers_List_ToRelease " + EmployeeID + "";
                    DataTable releaseTbl = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (releaseTbl != null)
                    {
                        empRelease = releaseTbl.ToList<RM_EmployeeRelease>();
                    }
                }
                return Request.CreateResponse(HttpStatusCode.OK, empRelease);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Commented And Added by Reshma Chavan on 23 feb 2022 for history 
        //[HttpPost]
        //public HttpResponseMessage GetHistory([FromBody] string EmployeeID)
        //{
        //    var empHistory = new List<RM_EmployeeHistory>();
        //    try
        //    {
        //        var strSQL = "Exec usp_Whizible2_Sel_tbl_RM_EmpHistory '" + EmployeeID + "'";
        //        DataTable infraDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
        //        if (infraDataTable != null)
        //        {
        //            empHistory = infraDataTable.ToList<RM_EmployeeHistory>();

        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
        //    }
        //    return Request.CreateResponse(HttpStatusCode.OK, empHistory);
        //}


        [HttpPost]
        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        public object GetHistory([FromBody] string EmployeeID)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_tbl_RM_EmpHistory '" + EmployeeID + "'";

                DataTable Historytable;
                Historytable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return Historytable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }
        //End of Commented And Added by Reshma Chavan on 23 feb 2022 for history 

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage GetCurrentAssignment([FromBody] RM_CurrentAssignment Op_Parameters)
        {
            var empHistory = new List<RM_EmployeeCurrentAssignment>();
            try
            {
                var strSQL = "";
                var Accessible = "";
                var Status = "";
                var Active = "";
                if (Op_Parameters.Accessible == "")
                {
                    //  Op_Parameters.Accessible = "NULL";
                    Accessible = "";
                }
                else
                {
                    Accessible = ", @strAccessible='" + Op_Parameters.Accessible + "'";
                }

                if (Op_Parameters.Status == "")
                {

                    Status = "";
                }
                else
                {
                    Status = ", @blnStatus=" + Op_Parameters.Status;
                }

                if (Op_Parameters.IsActive == "")
                {

                    Active = "";
                }
                else
                {
                    Active = ", @strIsActive='" + Op_Parameters.IsActive + "'";
                }
                strSQL = "Exec usp_Whizible2_sel_EmployeeCurrentProjects @strEmployeeID=" + Op_Parameters.EmployeeID + Accessible + Status + Active + ",  @strPageNumber='-1'";

                //var strSQL = "Exec usp_Whizible2_sel_EmployeeCurrentProjects " + Op_Parameters.EmployeeID + ",'" + Op_Parameters.Accessible + "'," + Op_Parameters.Status + ",'" + Op_Parameters.IsActive + "','-1'";
                DataTable costDetails = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (costDetails != null)
                {
                    empHistory = costDetails.ToList<RM_EmployeeCurrentAssignment>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, empHistory);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        //for dropdown
        public HttpResponseMessage GetGroups([FromBody] RM_EmployeeGroups Op_Parameters)
        {
            var empHistory = new List<RM_EmpGroups>();
            try
            {
                var strSQL = "Exec usp_Whizible2_Sel_tbl_UI_UserGroup_ForEmployee " + Op_Parameters.UserID + ",'" + Op_Parameters.LoginType + "'";
                DataTable groups = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (groups != null)
                {
                    empHistory = groups.ToList<RM_EmpGroups>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, empHistory);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by Chetan M on 6 Aug 2021 for get non added skills
        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        //for dropdown
        public object GetSkills([FromBody] RM_EmployeeGroups Op_Parameters)
        {
            try
            {
                DataTable Skills;

                //var strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Tools_PopulateCombo " + Op_Parameters.UserID;
                var strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Tools_PopulateCombo " + Op_Parameters.UserID + "," + Op_Parameters.EmployeeSkillID + "";
                Skills = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return Skills;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added by Chetan M on 6 Aug 2021 for get non added skills

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SaveGroups([FromBody] RM_EmployeeGroups Op_Patameters)
        {
            string strtResult = string.Empty;
            string strSQL;
            try
            {
                if (Op_Patameters != null)
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_PM_EmployeeGroups " + Op_Patameters.UserID + "," + Op_Patameters.GroupID + ",'" + Op_Patameters.LoginType + "'";

                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }
                    return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteGroup([FromBody] string Parameters)
        {
            try
            {
                string strResult = "";
                int delete = 0;
                int notDelete = 0;
                if (Parameters != null)
                {
                    var splitParmas = Parameters.Split(',').ToList();
                    foreach (var itemUniqueID in splitParmas)
                    {
                        string strSQL = "Exec usp_Whizible2_Del_tbl_PM_EmployeeGroup '" + itemUniqueID + "'";
                        strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        if (strResult == "deleted")
                        {
                            delete++;
                        }
                        else
                        {
                            notDelete++;
                        }
                    }
                    return Request.CreateResponse(HttpStatusCode.OK, new { deletedCount = delete, notDeletedCount = notDelete });
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage GetGroupsDetails([FromBody] string EmployeeID)
        {
            var empHistory = new List<RM_EmployeeGroups>();
            try
            {
                var strSQL = "Exec usp_Whizible2_Sel_tbl_PM_EmployeeGroups " + EmployeeID + "";
                DataTable groups = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (groups != null)
                {
                    empHistory = groups.ToList<RM_EmployeeGroups>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, empHistory);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage GetSkillsDetails([FromBody] string EmployeeID)
        {
            var empHistory = new List<RM_EmployeeSkillsDetails>();
            try
            {
                var strSQL = "Exec usp_Whizible2_Sel_tbl_PM_EmployeeSkills_Details " + EmployeeID + "";
                DataTable costDetails = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (costDetails != null)
                {
                    empHistory = costDetails.ToListCast<RM_EmployeeSkillsDetails>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, empHistory);

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage GetSkillsDetailsById([FromBody] string EmployeeSkillID)
        {
            var empSkill = new List<RM_EmployeeSkillsDetails>();
            try
            {
                if (EmployeeSkillID != null)
                {
                    var strSQL = "Exec usp_Whizible2_Sel_tbl_PM_EmployeeSkills_DetailsById " + Convert.ToInt32(EmployeeSkillID);
                    DataTable empskilltbl = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (empskilltbl != null)
                    {
                        empSkill = empskilltbl.ToListCast<RM_EmployeeSkillsDetails>();
                    }
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, empSkill);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteSkillDetails([FromBody] string Parameters)
        {
            try
            {
                string strResult = "";
                int delete = 0;
                int notDelete = 0;
                if (Parameters != null)
                {
                    var splitParmas = Parameters.Split(',').ToList();
                    foreach (var itemUniqueID in splitParmas)
                    {
                        string strSQL = "Exec usp_Whizible2_Del_tbl_PM_EmployeeSkill_Details '" + itemUniqueID + "'";
                        strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        if (strResult == "deleted")
                        {
                            delete++;
                        }
                        else
                        {
                            notDelete++;
                        }
                    }
                    return Request.CreateResponse(HttpStatusCode.OK, new { deletedCount = delete, notDeletedCount = notDelete });
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SaveSkillsDetails([FromBody] RM_EmployeeSkillsDetails Op_Patameters)
        {
            string strtResult = string.Empty;
            string strSQL;
            try
            {
                if (Op_Patameters != null)
                {

                    strSQL = "Exec usp_Whizible2_Ins_tbl_PM_EmployeeSkillMatrix " + Op_Patameters.EmployeeID + "," + Op_Patameters.ToolID + "," + Op_Patameters.YearsOfExperience + "," + Op_Patameters.MonthsOfExperience + "," + Op_Patameters.Proficiency + "," + Op_Patameters.HasCoreCompetency + ",'" + Op_Patameters.Notes + "'," + Op_Patameters.EmployeeSkillID;

                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, strtResult);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage GetQualificationDetails([FromBody] string EmployeeID)
        {
            var empHistory = new List<RM_QualificationDetails>();
            try
            {
                var strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Qualification_Details " + EmployeeID + "";
                DataTable qDetails = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (qDetails != null)
                {
                    empHistory = qDetails.ToList<RM_QualificationDetails>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, empHistory);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SaveQualificationDetails([FromBody] RM_QualificationDetails Op_Patameters)
        {
            string strtResult = string.Empty;
            string strSQL;
            try
            {
                if (Op_Patameters != null)
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_PM_Qualification_Details " + Op_Patameters.EmployeeID + "," + Op_Patameters.QualificationID + ",'" + Op_Patameters.University + "'," + Op_Patameters.PassoutYear + ",'" + Op_Patameters.Percentage + "','" + Op_Patameters.Class + "'";

                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }

                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, strtResult);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteQualificationDetails([FromBody] string Parameters)
        {
            try
            {
                string strResult = "";
                int delete = 0;
                int notDelete = 0;
                if (Parameters != null)
                {
                    var splitParmas = Parameters.Split(',').ToList();
                    foreach (var itemUniqueID in splitParmas)
                    {
                        string strSQL = "Exec usp_Whizible2_Del_tbl_PM_Qualification_Details '" + itemUniqueID + "'";
                        strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        if (strResult == "deleted")
                        {
                            delete++;
                        }
                        else
                        {
                            notDelete++;
                        }
                    }
                    return Request.CreateResponse(HttpStatusCode.OK, new { deletedCount = delete, notDeletedCount = notDelete });
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage GetCostDetails([FromBody] string EmployeeID)
        {
            var empHistory = new List<RM_EmployeeCostDetails>();
            try
            {
                var strSQL = "Exec usp_Whizible2_Sel_tbl_PM_EmployeeCost_Details " + EmployeeID + "";
                DataTable costDetails = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (costDetails != null)
                {
                    empHistory = costDetails.ToList<RM_EmployeeCostDetails>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, empHistory);

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SaveCostDetails([FromBody] RM_EmployeeCostDetails Op_Patameters)
        {
            string strtResult = string.Empty;
            string strSQL;
            try
            {
                if (Op_Patameters != null)
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_PM_EmployeeCost_Details " + Op_Patameters.EmployeeID + "," + Op_Patameters.CostPerHour + ",'" + Op_Patameters.StartDate + "','" + Op_Patameters.CreatedBy + "'";

                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }

                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, strtResult);

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteSaveCostDetails([FromBody] string Parameters)
        {
            try
            {
                string strResult = "";
                int delete = 0;
                int notDelete = 0;
                if (Parameters != null)
                {
                    var splitParmas = Parameters.Split(',').ToList();
                    foreach (var itemUniqueID in splitParmas)
                    {
                        string strSQL = "Exec usp_Whizible2_Del_tbl_PM_EmployeeCost_Details '" + itemUniqueID + "'";
                        strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        if (strResult == "deleted")
                        {
                            delete++;
                        }
                        else
                        {
                            notDelete++;
                        }
                    }
                    return Request.CreateResponse(HttpStatusCode.OK, new { deletedCount = delete, notDeletedCount = notDelete });
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveEmployee([FromBody] RM_EmployeeMaster OP_Parameters)
        {
            // Commented by Vyankat Bhure on 20-02-2025 - Changed to use DataSet instead of Emp_ReturnID object
            //Emp_ReturnID EmpID = new Emp_ReturnID();
            //string strtResult = string.Empty;
            // End of Commented by Vyankat Bhure on 20-02-2025
            //PWEncryption objEmailID = new PWEncryption("EmailID", OP_Parameters.Email);

            string strSQL = "";
            try
            {
                if (OP_Parameters != null)
                {
                    string strParms = "@BirthDate ='" + OP_Parameters.BirthDate + "',@EmailID = '" + OP_Parameters.Email + "',@EmployeeName = '" +
                       OP_Parameters.EmployeeName + "',@Deployable ='" + OP_Parameters.Deployable + "', @UserName = '" + OP_Parameters.UserName + "', @Gender = '" + OP_Parameters.Gender + "', @JoiningDate= '" +
                       OP_Parameters.JoiningDate + "',@Status = 0, @IsLDAPAuthentication = " + OP_Parameters.IsLDAPAuthntication + ", @BloodGroup = '" + OP_Parameters.BloodGroup + "', @EmployeeCode ='" + OP_Parameters.EmployeeCode + "', @DepartmentID = " +
                       OP_Parameters.DepartmentID + ",@PostID = " + OP_Parameters.RoleID + ", @DesignationID = " + OP_Parameters.DesignationID + ", @EmployeeType = '" + OP_Parameters.EmployeeType + "', @ReportingTo = " +
                       // Added by Dipali V on 6th May 2026 for vendor management - pass VendorID in employee save SP
                       OP_Parameters.ReportingTo + ", @VendorID = " + OP_Parameters.VendorID + ", @GradeID = " + OP_Parameters.GradeID + ", @BusinessGroupID = " + OP_Parameters.BusinessGroupID + ", @LocationID = " + OP_Parameters.LocationID + ", @ResourcePoolID = '" + OP_Parameters.ResourcePoolID + "', @GroupID = " +
                       OP_Parameters.GroupID + ", @FacilityID = " + OP_Parameters.FacilityID + ", @ExtensionNo = '" + OP_Parameters.ExtensionNo + "', @RatePerHour = " + OP_Parameters.RatePerHr + ", @CostPerHour = " + OP_Parameters.CostPerHr + ", @CostToCompany = " + OP_Parameters.CostToCompany + ", @CurrencyID = " + OP_Parameters.CurrencyID + ",@MessangerID = '" + OP_Parameters.MessangerID + "', @CreatedBy = '" + OP_Parameters.CreatedBy + "',";

                    if (!string.IsNullOrEmpty(OP_Parameters.LeavingDate.ToString()))
                    {
                        strParms += "@LeavingDate=" + OP_Parameters.LeavingDate + ",";
                    }
                    if (!string.IsNullOrEmpty(OP_Parameters.TentativeLeavingDate.ToString()))
                    {
                        strParms += "@TentativeLeavingDate=" + OP_Parameters.TentativeLeavingDate + ",";
                    }
                    // Added by Vyankat Bhure on 20-02-2025 - Commented PointWest Customization parameters as SP doesn't support these parameters
                    //Added By Divya J on 26 August 2025 For PointWest Customization 
                    //strParms += "@FirstName = '" + OP_Parameters.FirstName + "', @MiddleName = '" + OP_Parameters.MiddleName + "', @LastName = '" + OP_Parameters.LastName + "', @Nickname = '" + OP_Parameters.Nickname + "', @VotersID = '" + OP_Parameters.VotersID + "', @PAGIBIG = '" + OP_Parameters.PAGIBIG + "', @FunctionalRoleID = '" + OP_Parameters.FunctionalRoleID + "', @PhilHealthNo = '" + OP_Parameters.PhilHealthNo + "', @TIN = '" + OP_Parameters.TIN + "', @SSSNo = '" + OP_Parameters.SSSNo + "', @Agency = '" + OP_Parameters.Agency + "',";

                    //if (!string.IsNullOrEmpty(OP_Parameters.RegularizationDate.ToString()))
                    //{
                    //    strParms += "@RegularizationDate='" + OP_Parameters.RegularizationDate + "',";
                    //}
                    //End of Added By Divya J on 26 August 2025 For PointWest Customization
                    // End of Added by Vyankat Bhure on 20-02-2025
                    strParms = strParms.TrimEnd(',');
                    strSQL = "Exec usp_Whizible2_Ins_tbl_PM_EmployeeMaster " + strParms;

                    // Commented by Vyankat Bhure on 20-02-2025 - Changed to use GetDataSet to handle multiple result sets from SP
                    //IDataReader drQuery;
                    //drQuery = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                    //if (drQuery.Read())
                    //{
                    //    //objOPR.ApproxStartDate = String.Format("{0:dd MMMM yyyy}", drQuery["ApproxStartDate"]);
                    //    EmpID.EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["Id"], "0"));
                    //    EmpID.Message = Convert.ToString(drQuery["Message"]);
                    //}
                    //IDataReader drQuery = null;
                    //try
                    //{
                    //    drQuery = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                    //    if (drQuery.Read())
                    //    {
                    //        //objOPR.ApproxStartDate = String.Format("{0:dd MMMM yyyy}", drQuery["ApproxStartDate"]);
                    //        EmpID.EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["Id"], "0"));
                    //        EmpID.Message = Convert.ToString(drQuery["Message"]);
                    //    }
                    //}
                    //finally
                    //{
                    //    // Close DataReader to prevent connection issues and 500 errors
                    //    if (drQuery != null && !drQuery.IsClosed)
                    //    {
                    //        drQuery.Close();
                    //    }
                    //}
                    //DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    //return dt;
                    // End of Commented by Vyankat Bhure on 20-02-2025
                    
                    // Added by Vyankat Bhure on 20-02-2025 - Changed to use GetDataSet to handle multiple result sets from SP
                    DataSet ds = CommonFunctions.Data.GetDataSet(
                        strSQL, "EmployeeMaster", 0, 0, true, CommonController.connectionString
                    );

                    var result = new
                    {
                        Table1 = ds.Tables[0],   // First result set
                        Table2 = ds.Tables.Count > 1 ? ds.Tables[1] : null,    // Second result set (if exists)
                        Table3 = ds.Tables.Count > 2 ? ds.Tables[2] : null    // Third result set (if exists)
                    };
                    return result;
                    // End of Added by Vyankat Bhure on 20-02-2025
                }
                else
                {
                    // Commented by Vyankat Bhure on 20-02-2025 - Changed return type from HttpResponseMessage to object
                    //return Request.CreateResponse(HttpStatusCode.BadRequest);
                    // End of Commented by Vyankat Bhure on 20-02-2025
                    
                    // Added by Vyankat Bhure on 20-02-2025
                    return null;
                    // End of Added by Vyankat Bhure on 20-02-2025
                }
                // Commented by Vyankat Bhure on 20-02-2025 - Changed return type from HttpResponseMessage to object with DataSet
                //return Request.CreateResponse(HttpStatusCode.OK, EmpID);
                // End of Commented by Vyankat Bhure on 20-02-2025

            }
            catch (Exception ex)
            {
                // Commented by Vyankat Bhure on 20-02-2025 - Changed return type from HttpResponseMessage to object for consistency
                //return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
                //return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Error: " + ex.Message + (ex.InnerException != null ? " Inner: " + ex.InnerException.Message : ""));
                // End of Commented by Vyankat Bhure on 20-02-2025
                
                // Added by Vyankat Bhure on 20-02-2025 - Return error as object
                return new { error = "Error: " + ex.Message + (ex.InnerException != null ? " Inner: " + ex.InnerException.Message : "") };
                // End of Added by Vyankat Bhure on 20-02-2025
            }
        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage UpdateEmployee([FromBody] RM_EmployeeMaster OP_Parameters)
        {
            string strtResult = string.Empty;
            string strSQL = "";
            try
            {
                if (OP_Parameters != null)
                {

                    string strParms = "@EmployeeID = " + OP_Parameters.EmplpoyeeID + ", @BirthDate ='" + OP_Parameters.BirthDate + "',@EmailID = '" + OP_Parameters.Email + "',@EmployeeName = '" +
                       OP_Parameters.EmployeeName + "',@Deployable ='" + OP_Parameters.Deployable + "', @UserName = '" + OP_Parameters.UserName + "', @Gender = '" + OP_Parameters.Gender + "', @JoiningDate= '" +
                       OP_Parameters.JoiningDate + "',@Status = " + OP_Parameters.Status + ", @IsLDAPAuthentication = " + OP_Parameters.IsLDAPAuthntication + ", @BloodGroup = '" + OP_Parameters.BloodGroup + "', @EmployeeCode ='" + OP_Parameters.EmployeeCode + "', @DepartmentID = " +
                       OP_Parameters.DepartmentID + ",@PostID = " + OP_Parameters.RoleID + ", @DesignationID = " + OP_Parameters.DesignationID + ", @EmployeeType = '" + OP_Parameters.EmployeeType + "', @ReportingTo = " +
                       // Added by Dipali V on 6th May 2026 for vendor management - pass VendorID in employee update SP
                       OP_Parameters.ReportingTo + ", @VendorID = " + OP_Parameters.VendorID + ", @GradeID = " + OP_Parameters.GradeID + ", @BusinessGroupID = " + OP_Parameters.BusinessGroupID + ", @LocationID = " + OP_Parameters.LocationID + ", @ResourcePoolID = '" + OP_Parameters.ResourcePoolID + "', @GroupID = " +
                       OP_Parameters.GroupID + ", @FacilityID = " + OP_Parameters.FacilityID + ", @ExtensionNo = '" + OP_Parameters.ExtensionNo + "', @RatePerHour = " + OP_Parameters.RatePerHr + ", @CostPerHour = " + OP_Parameters.CostPerHr + ", @CostToCompany = " + OP_Parameters.CostToCompany + ", @CurrencyID = " + OP_Parameters.CurrencyID + ",@MessangerID = '" + OP_Parameters.MessangerID + "', @CreatedBy = '" + OP_Parameters.CreatedBy + "',";

                    if (!string.IsNullOrEmpty(OP_Parameters.LeavingDate.ToString()))
                    {
                        strParms += "@LeavingDate='" + OP_Parameters.LeavingDate + "',";
                    }
                    if (!string.IsNullOrEmpty(OP_Parameters.TentativeLeavingDate.ToString()))
                    {
                        strParms += "@TentativeLeavingDate='" + OP_Parameters.TentativeLeavingDate + "',";
                    }

                    // Added by Vyankat Bhure on 20-02-2025 - Commented PointWest Customization parameters as SP doesn't support these parameters
                    //Added By Divya J on 26 August 2025 For PointWest Customization
                    //strParms += "@FirstName = '" + OP_Parameters.FirstName + "', @MiddleName = '" + OP_Parameters.MiddleName + "', @LastName = '" + OP_Parameters.LastName + "', @Nickname = '" + OP_Parameters.Nickname + "', @VotersID = '" + OP_Parameters.VotersID + "', @PAGIBIG = '" + OP_Parameters.PAGIBIG + "', @FunctionalRoleID = '" + OP_Parameters.FunctionalRoleID + "', @PhilHealthNo = '" + OP_Parameters.PhilHealthNo + "', @TIN = '" + OP_Parameters.TIN + "', @SSSNo = '" + OP_Parameters.SSSNo + "', @Agency = '" + OP_Parameters.Agency + "',";

                    //if (!string.IsNullOrEmpty(OP_Parameters.RegularizationDate.ToString()))
                    //{
                    //    strParms += "@RegularizationDate='" + OP_Parameters.RegularizationDate + "',";
                    //}
                    //End of Added By Divya J on 26 August 2025 For PointWest Customization
                    // End of Added by Vyankat Bhure on 20-02-2025
                    strParms = strParms.TrimEnd(',');
                    strSQL = "Exec usp_Whizible2_Upd_tbl_PM_EmployeeMasterInfo " + strParms;

                    // Commented by Vyankat Bhure on 20-02-2025 - Changed to use GetDataSet to fetch message from 2nd table
                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }
                    // End of Commented by Vyankat Bhure on 20-02-2025

                    // Added by Vyankat Bhure on 20-02-2025 - Changed to use GetDataSet to fetch message from 2nd table
                    //DataSet ds = CommonFunctions.Data.GetDataSet(
                    //    strSQL, "EmployeeMasterUpdate", 0, 0, true, CommonController.connectionString
                    //);

                    // Extract message from 2nd table (Table2)
                    //if (ds.Tables.Count > 1 && ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
                    //{
                    //    // Get the first column value from first row of Table2 (message column has no name)
                    //    strtResult = Convert.ToString(ds.Tables[1].Rows[0][0]);
                    //}

                    //if (!string.IsNullOrEmpty(strtResult))
                    //{
                    //    return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    //}
                    // End of Added by Vyankat Bhure on 20-02-2025

                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                // Commented by Vyankat Bhure on 20-02-2025 - Added null check for strtResult before returning
                //return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                // End of Commented by Vyankat Bhure on 20-02-2025
                
                // Added by Vyankat Bhure on 20-02-2025
                return Request.CreateResponse(HttpStatusCode.OK, strtResult ?? "");
                // End of Added by Vyankat Bhure on 20-02-2025
            }
            catch (Exception ex)
            {
                // Commented by Vyankat Bhure on 20-02-2025 - Changed to return actual error message for debugging
                //return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
                // End of Commented by Vyankat Bhure on 20-02-2025
                
                // Added by Vyankat Bhure on 20-02-2025 - Return actual error message for debugging
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Error: " + ex.Message + (ex.InnerException != null ? " Inner: " + ex.InnerException.Message : ""));
                // End of Added by Vyankat Bhure on 20-02-2025
            }
        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SaveAdvanceInfo([FromBody] RM_EmployeeMaster OP_Parameters)
        {
            string strtResult = string.Empty;
            string strSQL = "";
            try
            {

                if (OP_Parameters != null)
                {
                    strSQL = "EXEC usp_Whizible2_Upd_tbl_PM_EmployeeMasterAdvanceInfo " + OP_Parameters.EmplpoyeeID + ",'" + OP_Parameters.Address + "','" + OP_Parameters.City + "','" +
                    OP_Parameters.State + "','" + OP_Parameters.PinCode + "','" + OP_Parameters.Phone + "','" + OP_Parameters.CurrentAddress + "','" +
                    OP_Parameters.CurrentCity + "','" + OP_Parameters.CurrentState + "','" + OP_Parameters.CurrentPinCode + "','" + OP_Parameters.CurrentPhone + "','" +
                    OP_Parameters.PassportNumber + "','" + OP_Parameters.PP_PlaceOfIssue + "','" + OP_Parameters.PP_DateOfIssue + "','" + OP_Parameters.PP_ExpiryDate + "','" +
                    OP_Parameters.PP_FullName + "','" + OP_Parameters.PP_RelativeName + "','" + OP_Parameters.NoofPagesLeft + "'";

                    //int Result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));


                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }

                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, strtResult);

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage GetAllEmployee([FromBody] RM_EmployeeFilterParams Op_Parameters)
        {

            var EmployeeList = new List<RM_EmployeeList>();

            string filterParms = "";
            try
            {
                if (Op_Parameters != null && Op_Parameters.EmpWhereClause != null && !string.IsNullOrEmpty(Op_Parameters.EmpWhereClause))
                {
                    // filterParms = vTFilter.VTWhereClause;// HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");// DecodeWhereClause(BgFilterParameter.BGWhereClause);///HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                    filterParms = HttpUtility.UrlDecode(Op_Parameters.EmpWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");
                }
                else
                {
                    filterParms = null;
                }
                string strSQL = "";
                if (filterParms != null)
                {
                    strSQL = "Exec usp_Whizible2_tbl_RM_Employee '" + filterParms + "'";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_tbl_RM_Employee";
                }
                DataTable EmployeeTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (EmployeeTable != null)
                {
                    EmployeeList = EmployeeTable.ToList<RM_EmployeeList>();                   
                }
                return Request.CreateResponse(HttpStatusCode.OK, EmployeeList);

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage GetEmployeeDetails([FromBody] int EmployeeID)
        {

            RM_EmployeeMaster objME = new RM_EmployeeMaster();
            try
            {
                if (EmployeeID > 0)
                {
                    string strSQL = "Exec usp_Whizible2_tbl_RM_GetEmployeeDetails '" + Convert.ToString(EmployeeID) + "'";
                    IDataReader drQuery, drQueryProb;
                    drQuery = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                    if (drQuery.Read())
                    {

                        //objOPR.ApproxStartDate = String.Format("{0:dd MMMM yyyy}", drQuery["ApproxStartDate"]);
                        objME.EmplpoyeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["EmployeeID"], "0"));
                        objME.EmployeeName = Convert.ToString(drQuery["EmployeeName"]);
                        objME.Deployable = Convert.ToString(drQuery["Deployable"]);
                        objME.BirthDate = String.Format("{0:dd MMMM yyyy}", drQuery["BirthDate"]);
                        objME.Email = Convert.ToString(drQuery["EmailID"]);
                        objME.UserName = Convert.ToString(drQuery["UserName"]);
                        objME.Gender = Convert.ToString(drQuery["Gender"]); //check this
                        objME.JoiningDate = String.Format("{0:dd MMMM yyyy}", drQuery["JoiningDate"]);
                        objME.IsLDAPAuthntication = Convert.ToBoolean(drQuery["IsLDAPAuthentication"]);
                        objME.EmployeeCode = Convert.ToString(drQuery["EmployeeCode"]);
                        objME.BloodGroup = Convert.ToString(drQuery["BloodGroup"]); //check this
                        objME.DepartmentID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["DepartmentID"], "0"));
                        objME.RoleID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["PostID"], "0"));
                        objME.DesignationID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["DesignationID"], "0"));
                        objME.EmployeeType = Convert.ToString(drQuery["EmployeeType"]); //check this****
                        objME.ReportingTo = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["ReportingTo"], "0"));
                        // Added by Dipali V on 6th May 2026 for vendor management - bind VendorID for edit flow
                        objME.VendorID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["VendorID"], "0"));
                        objME.GroupID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["GroupID"], "0"));
                        objME.BusinessGroupID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["BusinessGroupID"], "0"));
                        objME.ResourcePoolID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["ResourcePoolID"], "0"));
                        objME.FacilityID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["FacilityID"], "0"));
                        objME.DeliveryUnitId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["GroupID"], "0"));//check this  delivery unit dropdown
                        objME.DeliveryTeamId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["ResourcePoolID"], "0"));//check this delivery team dropdown
                        objME.ExtensionNo = Convert.ToString(drQuery["ExtensionNo"]);
                        objME.RatePerHr = Convert.ToDecimal(drQuery["RatePerHour"]);
                        objME.CostPerHr = Convert.ToDecimal(drQuery["CostPerHour"]);
                        objME.CostToCompany = Convert.ToString(drQuery["CostToCompany"]);
                        objME.CurrencyID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["CurrencyID"], "0"));//check this delivery team dropdown
                        objME.TentativeLeavingDate = String.Format("{0:dd MMMM yyyy}", drQuery["TentativeDateOfRelieving"]);
                        objME.LeavingDate = String.Format("{0:dd MMMM yyyy}", drQuery["LeavingDate"]);
                        objME.MessangerID = Convert.ToString(drQuery["CommunicationID"]);//check this messenger id 
                        //changes new assignments
                        objME.LocationID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["LocationID"], "0"));
                        objME.ProfilePicURL = Convert.ToString(drQuery["ProfilePicURL"]);
                        //tab 2
                        objME.CurrentAddress = Convert.ToString(drQuery["CurrentAddress"]);
                        objME.CurrentCity = Convert.ToString(drQuery["CurrentCity"]);
                        objME.CurrentState = Convert.ToString(drQuery["CurrentState"]);
                        objME.CurrentPinCode = Convert.ToString(drQuery["CurrentPinCode"]);
                        objME.CurrentPhone = Convert.ToString(drQuery["CurrentPhone"]);

                        objME.Address = Convert.ToString(drQuery["Address"]);
                        objME.City = Convert.ToString(drQuery["City"]);
                        objME.State = Convert.ToString(drQuery["State"]);
                        objME.PinCode = Convert.ToString(drQuery["PinCode"]);
                        objME.Phone = Convert.ToString(drQuery["Phone"]);

                        objME.PassportNumber = Convert.ToString(drQuery["PassportNumber"]);
                        objME.PP_PlaceOfIssue = Convert.ToString(drQuery["PP_PlaceOfIssue"]);
                        objME.PP_DateOfIssue = String.Format("{0:dd MMMM yyyy}", drQuery["PP_DateOfIssue"]);
                        objME.PP_ExpiryDate = String.Format("{0:dd MMMM yyyy}", drQuery["PP_ExpiryDate"]);
                        objME.PP_FullName = Convert.ToString(drQuery["PP_FullName"]);
                        objME.PP_RelativeName = Convert.ToString(drQuery["PP_RelativeName"]);
                        objME.NoofPagesLeft = Convert.ToString(drQuery["NoofPagesLeft"]);
                        objME.StatusNew = Convert.ToString(drQuery["StatusNew"]);
                        objME.Status = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["Status"], "0")); //Convert.ToString(drQuery["Status"]);
                        objME.GradeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["GradeID"], "0")); //Convert.ToString(drQuery["Status"]);
                        ////Added by Divya J on 26 August 2025 for Pointwest customisation
                        //objME.FirstName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drQuery["FirstName"], ""));
                        //objME.MiddleName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drQuery["MiddleName"], ""));
                        //objME.LastName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drQuery["LastName"], ""));
                        //objME.Nickname = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drQuery["Nickname"], ""));
                        //objME.VotersID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drQuery["VotersID"], ""));
                        //objME.PAGIBIG = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drQuery["PAGIBIG"], ""));
                        //objME.FunctionalRoleID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drQuery["FunctionalRoleID"], ""));
                        //objME.PhilHealthNo = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drQuery["PhilHealthNo"], ""));
                        //objME.TIN = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drQuery["TIN"], ""));
                        //objME.SSSNo = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drQuery["SSSNo"], ""));
                        //objME.Agency = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drQuery["Agency"], ""));
                        //objME.ReasonForLeaving = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drQuery["ReasonForLeaving"], ""));
                        //objME.RegularizationDate = Convert.ToString(String.Format("{0:dd MMMM yyyy}", drQuery["RegularizationDate"], ""));
                        //objME.SpecimenSignaturePicURL = Convert.ToString(drQuery["SpecimenSignaturePicURL"]);
                        //objME.PassportIDPictureURL = Convert.ToString(drQuery["PassportIDPictureURL"]);
                        //End of Added by Divya J on 26 August 2025 for Pointwest customisation
                        //Added by Vishal Mane on 28/05/2026 To Make Vendor Dropdown Mandatory or Non Mandatory on Employee Master Based on Configurable Flag
                        objME.IsVendorMandatory = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["IsVendorMandatory"], "0"));
                        //End of Added by Vishal Mane on 28/05/2026 To Make Vendor Dropdown Mandatory or Non Mandatory on Employee Master Based on Configurable Flag
                    }
                }
                return Request.CreateResponse(HttpStatusCode.OK, objME);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteEmployeeDetails([FromBody] int EmployeeId)
        {
            try
            {
                if (EmployeeId > 0)
                {

                    string strSQL = "Exec usp_Whizible2_Del_tbl_PM_Employee " + EmployeeId;
                    var srtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    return Request.CreateResponse(HttpStatusCode.OK, srtResult);
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.InternalServerError);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage GetEmployeeVisaDetails([FromBody] int EmployeeID)
        {

            var EmployeeVisaList = new List<RM_EmployeeVisaList>();
            try
            {
                if (EmployeeID > 0)
                {
                    string strSQL = "";
                    strSQL = "Exec usp_Whizible2_tbl_RM_GetEmployeeVisaDetails " + EmployeeID + "";

                    DataTable EmployeeVisaTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (EmployeeVisaTable != null)
                    {
                        EmployeeVisaList = EmployeeVisaTable.ToListCast<RM_EmployeeVisaList>();
                    }
                }

                return Request.CreateResponse(HttpStatusCode.OK, EmployeeVisaList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage SaveMEVisaDetails([FromBody] RM_EmployeeVisaList employeeVisaParameters)
        {
            string strtResult = string.Empty;
            try
            {
                if (employeeVisaParameters != null)
                {

                    string strSQL = "Exec usp_Whizible2_InsUpd_tbl_pm_Employeevisadetails " + employeeVisaParameters.EmployeeID + "," + employeeVisaParameters.CountryID + "," + employeeVisaParameters.VisaTypeID + " ,'" + employeeVisaParameters.dtValidFrom + "','" + employeeVisaParameters.dtValidUpto + "','" + employeeVisaParameters.Remarks + "','" + employeeVisaParameters.CreatedBy + "' ";

                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, strtResult);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteVisaDetails([FromBody] string Parameters)
        {
            try
            {
                string strResult = "";
                int delete = 0;
                int notDelete = 0;
                if (Parameters != null)
                {
                    var splitParmas = Parameters.Split(',').ToList();
                    foreach (var itemUniqueID in splitParmas)
                    {
                        string strSQL = "Exec usp_Whizible2_Del_tbl_PM_EmployeeVisaDetails '" + itemUniqueID + "'";
                        strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        if (strResult == "deleted")
                        {
                            delete++;
                        }
                        else
                        {
                            notDelete++;
                        }
                    }
                    return Request.CreateResponse(HttpStatusCode.OK, new { deletedCount = delete, notDeletedCount = notDelete });
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage GetMEPreAssignmentDetails([FromBody] int EmployeeID)
        {

            var EmployeePreAssignmentist = new List<RM_EmployeePreAssignmentList>();
            try
            {
                if (EmployeeID > 0)
                {
                    string strSQL = "";
                    strSQL = "Exec usp_Whizible2_tbl_RM_GetMEPreAssignmentsDetails " + EmployeeID + "";
                    DataTable EmployeePreAssignTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (EmployeePreAssignTable != null)
                    {
                        EmployeePreAssignmentist = EmployeePreAssignTable.ToListCast<RM_EmployeePreAssignmentList>();
                    }
                }

                return Request.CreateResponse(HttpStatusCode.OK, EmployeePreAssignmentist);

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage GetCertifications(RM_Certifications Op_parameters)
        {
            string strSQL = "";
            var List = new List<RM_EmpCertifications>();
            try
            {
                if (Op_parameters.EmployeeID > 0)
                {
                    if (Op_parameters.CertificationID > 0)
                    {
                        strSQL = "usp_Whizible2_Sel_GetEmployeeCertifications " + Op_parameters.EmployeeID + " , " + Op_parameters.CertificationID;

                    }
                    else
                    {
                        strSQL = "usp_Whizible2_Sel_GetEmployeeCertifications " + Op_parameters.EmployeeID;

                    }
                    DataTable CertTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (CertTable != null)
                        foreach (DataRow item in CertTable.Rows)
                        {
                            RM_EmpCertifications objCert = new RM_EmpCertifications()
                            {
                                EmployeeCertificationID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["EmployeeCertificationID"], "0")),
                                CertificationID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["CertificationID"], "0")),
                                TotalScore = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["TotalScore"], "0")),
                                ActualScore = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["ActualScore"], "0")),
                                CertificationName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(item["CertificationName"], "")),
                                CertificationDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(item["CertificationDate"], "")),
                                ValidUpto = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(item["ValidUpto"], "")),
                            };

                            List.Add(objCert);
                        }

                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, List);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SaveCertifications([FromBody] RM_EmpCertifications Op_parameters)
        {
            string strtResult = string.Empty;
            string strSQL = "";
            try
            {
                if (Op_parameters != null)
                {

                    strSQL = "Exec usp_Whizible2_Ins_tbl_PM_EmployeeCertificationMatrix " + Op_parameters.EmployeeID + "," + Op_parameters.CertificationID + ",'" + Op_parameters.CertificationDate + "','" + Op_parameters.ValidUpto + "'," + Op_parameters.ActualScore + "," + Op_parameters.TotalScore + "";

                    //int Result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    //CommonFunctions.Data.InsertOrUpdateData(strtResult, true, CommonController.connectionString);
                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, strtResult);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteCertificationDetails([FromBody] string Parameters)
        {
            try
            {
                string strResult = "";
                int delete = 0;
                int notDelete = 0;
                if (Parameters != null)
                {
                    var splitParmas = Parameters.Split(',').ToList();
                    foreach (var itemUniqueID in splitParmas)
                    {
                        string strSQL = "Exec usp_Whizible2_Del_tbl_PM_EmployeeCertificationMatrix '" + itemUniqueID + "'";
                        strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        if (strResult == "deleted")
                        {
                            delete++;
                        }
                        else
                        {
                            notDelete++;
                        }
                    }
                    return Request.CreateResponse(HttpStatusCode.OK, new { deletedCount = delete, notDeletedCount = notDelete });
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage SaveMEPreAssignmentDetails([FromBody] RM_EmployeePreAssignmentList employeePreAssignmentParameters)
        {
            string strtResult = string.Empty;
            try
            {
                if (employeePreAssignmentParameters != null)
                {
                    string strSQL;
                    if (employeePreAssignmentParameters.EmployeeHistoryProjectID != null && employeePreAssignmentParameters.EmployeeHistoryProjectID != 0)
                    {
                        strSQL = "Exec usp_Whizible2_Insert_tbl_pm_EmployeePreAssignmentdetails " + employeePreAssignmentParameters.EmployeeID + ",'" + employeePreAssignmentParameters.ProjectName + "'," + employeePreAssignmentParameters.Duration + " ," + employeePreAssignmentParameters.TeamSize + ",'" + employeePreAssignmentParameters.Role + "','" + employeePreAssignmentParameters.Environment + "','" + employeePreAssignmentParameters.SkillSet + "','" + employeePreAssignmentParameters.Description + "','" + employeePreAssignmentParameters.CreatedBy + "'," + employeePreAssignmentParameters.EmployeeHistoryProjectID + " ";
                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_Insert_tbl_pm_EmployeePreAssignmentdetails " + employeePreAssignmentParameters.EmployeeID + ",'" + employeePreAssignmentParameters.ProjectName + "'," + employeePreAssignmentParameters.Duration + " ," + employeePreAssignmentParameters.TeamSize + ",'" + employeePreAssignmentParameters.Role + "','" + employeePreAssignmentParameters.Environment + "','" + employeePreAssignmentParameters.SkillSet + "','" + employeePreAssignmentParameters.Description + "','" + employeePreAssignmentParameters.CreatedBy + "' ";
                    }

                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, strtResult);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteMEPreAssignment([FromBody] string PreAssignmentParameters)
        {
            try
            {

                string strResult = "";
                int delete = 0;
                int notDelete = 0;
                if (PreAssignmentParameters != null)
                {
                    var splitParmas = PreAssignmentParameters.Split(',').ToList();
                    foreach (var itemUniqueID in splitParmas)
                    {
                        string strSQL = "Exec usp_Whizible2_Del_tbl_PM_EmployeeHistory_Projects '" + itemUniqueID + "'";
                        strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        if (strResult == "Deleted")
                        {
                            delete++;
                        }
                        else
                        {
                            notDelete++;
                        }
                    }
                    return Request.CreateResponse(HttpStatusCode.OK, new { deletedCount = delete, notDeletedCount = notDelete });
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage GetMEPreWorkExperienceDetails([FromBody] int EmployeeID)
        {

            var EmployeePreWorkExpist = new List<RM_EmployeePreWorkExperienceList>();
            try
            {
                if (EmployeeID > 0)
                {
                    string strSQL = "";
                    strSQL = "Exec usp_Whizible2_tbl_RM_GetMEPreWorkExperienceDetails " + EmployeeID + "";
                    DataTable EmployeePreWorkExpTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (EmployeePreWorkExpTable != null)
                    {
                        EmployeePreWorkExpist = EmployeePreWorkExpTable.ToListCast<RM_EmployeePreWorkExperienceList>();
                    }
                }

                return Request.CreateResponse(HttpStatusCode.OK, EmployeePreWorkExpist);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage SaveMEPreWorkExperienceDetails([FromBody] RM_EmployeePreWorkExperienceList employeePreWorkExpParameters)
        {
            string strtResult = string.Empty;
            try
            {
                if (employeePreWorkExpParameters != null)
                {
                    string strSQL = "";
                    if (employeePreWorkExpParameters.EmployeeHistoryID != null && employeePreWorkExpParameters.EmployeeHistoryID != 0)
                    {
                        strSQL = "Exec usp_Whizible2_Insert_tbl_pm_EmployeeHistory " + employeePreWorkExpParameters.EmployeeID + ",'" + employeePreWorkExpParameters.OrganizationName + "','" + employeePreWorkExpParameters.WorkedFrom + "' ,'" + employeePreWorkExpParameters.WorkedTill + "'," + employeePreWorkExpParameters.WorkProfileNature + ",'" + employeePreWorkExpParameters.PositionHeld + "','" + employeePreWorkExpParameters.Summary + "'," + employeePreWorkExpParameters.EmployeeHistoryID + "";
                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_Insert_tbl_pm_EmployeeHistory " + employeePreWorkExpParameters.EmployeeID + ",'" + employeePreWorkExpParameters.OrganizationName + "','" + employeePreWorkExpParameters.WorkedFrom + "' ,'" + employeePreWorkExpParameters.WorkedTill + "'," + employeePreWorkExpParameters.WorkProfileNature + ",'" + employeePreWorkExpParameters.PositionHeld + "','" + employeePreWorkExpParameters.Summary + "'";
                    }

                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, strtResult);

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteMEPreWorkExperience([FromBody] string PreWorkExpParameters)
        {
            try
            {

                string strResult = "";
                int delete = 0;
                int notDelete = 0;
                if (PreWorkExpParameters != null)
                {
                    var splitParmas = PreWorkExpParameters.Split(',').ToList();
                    foreach (var itemUniqueID in splitParmas)
                    {
                        string strSQL = "Exec usp_Whizible2_Del_tbl_PM_EmployeeHistory '" + itemUniqueID + "'";
                        strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        if (strResult == "Deleted")
                        {
                            delete++;
                        }
                        else
                        {
                            notDelete++;
                        }
                    }
                    return Request.CreateResponse(HttpStatusCode.OK, new { deletedCount = delete, notDeletedCount = notDelete });
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public void ProfileUpload()
        {
            try
            {

                if (HttpContext.Current.Request.Files.Count != 0)
                {
                    string strtResult = "";
                    //for (int i = 0; i < HttpContext.Current.Request.Files.Count; i++)
                    //{
                    //    var file = HttpContext.Current.Request.Files[0];
                    var FromSave = HttpContext.Current.Request.Form["FromSave"];
                    var EmployeeId = HttpContext.Current.Request.Form["EmployeeId"];
                    var OldFileName = HttpContext.Current.Request.Form["OldFileName"];
                    var createdby = HttpContext.Current.Request.Form["CreatedBy"];
                    string OriginalfileName = Path.GetFileName(HttpContext.Current.Request.Files[0].FileName);
                    string extension = Path.GetExtension(HttpContext.Current.Request.Files[0].FileName).ToLower();
                    var newFileName = CommonFunctions.FileDirectory.GetUniqueFileName().Trim() + extension;
                    var rootpath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../Images/Photo/"));//FOR DEV ENV

                    XlsxUtility.CreateDocDirectory(rootpath);
                    var path = Path.Combine(rootpath, newFileName);
                    HttpContext.Current.Request.Files[0].SaveAs(path);

                    //get previous filename for delete in case of update
                    string strSQL2 = "Exec usp_Whizible2_tbl_RM_GetEmployeeDetails '" + Convert.ToString(EmployeeId) + "'";
                    IDataReader drQuery;
                    drQuery = CommonFunctions.Data.GetDataReader(strSQL2, true, CommonController.connectionString);
                    string ProfilePicURL = "";
                    if (drQuery.Read())
                    {
                        ProfilePicURL = Convert.ToString(drQuery["ProfilePicURL"]);
                    }
                    //save image
                    string strSQL = "Exec usp_Whizible2_Ins_tbl_RM_EmployeeMaintenance_Attachment " + EmployeeId + ",'" + OriginalfileName + "','" + newFileName + "' ,'" + createdby + "'";
                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    //delete image in update

                    if (strtResult != null)
                    {
                        if (FromSave == "0")
                        {
                            var deletepath = Path.Combine(rootpath, System.IO.Path.GetFileName(ProfilePicURL));
                            XlsxUtility.DeleteFileIfExist(deletepath);
                        }
                        //  return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }
                    else
                    {
                        //  return Request.CreateResponse(HttpStatusCode.BadRequest);
                    }
                }
            }
            catch (Exception ex)
            {
                //return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }

        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage GetCurrencySymbol([FromBody] int EmployeeID)
        {

            var Empcurrency = new List<RM_EmployeeCostSymbol>();
            try
            {
                if (EmployeeID > 0)
                {
                    string strSQL = "";
                    strSQL = "Exec usp_Whizible2_Sel_tbl_PM_CurrencyMaster_Symbol " + EmployeeID + "";
                    DataTable Employeecurrency = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (Employeecurrency != null)
                    {
                        Empcurrency = Employeecurrency.ToListCast<RM_EmployeeCostSymbol>();
                    }
                }

                return Request.CreateResponse(HttpStatusCode.OK, Empcurrency);

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        #region File upload 
        [Authorize]
        [HttpPost]
        public HttpResponseMessage UploadEmpXlsxFile()
        {
            var httpRequest = HttpContext.Current.Request;
            var server = HttpContext.Current.Server;
            string FilePath = string.Empty;
            DataTable dtXlsx = null;
            var RU_EmpsXlsxList = new List<RM_XslxEmployee>();
            if (httpRequest.Files.Count > 0)
            {
                var postedDocumentFile = httpRequest.Files[0];
                var CurrentDate = string.Format("{0:yyyyMMdd_HHmmss}", DateTime.Now);// DateTime.UtcNow;
                string extension = Path.GetExtension(postedDocumentFile.FileName).ToLower();
                string connString = "";
                var FolderPath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../Content/Uploads"));
                string[] FileNameArr = postedDocumentFile.FileName.Split('.');
                string FileName = string.Concat(FileNameArr[0], CurrentDate, '.', FileNameArr[1]);

                FilePath = string.Format("{0}/{1}", FolderPath, FileName);

                XlsxUtility.CreateDocDirectory(FolderPath);
                if (XlsxUtility.IsValidFileFile(extension))
                {
                    XlsxUtility.DeleteFileIfExist(FilePath);
                    postedDocumentFile.SaveAs(FilePath);
                    var FileExtension = extension.Trim();
                    string ConStringXsl = "";
                    string ConStringXslx = "";
                    if (Environment.Is64BitOperatingSystem)
                    {
                        ConStringXsl = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FilePath + ";Extended Properties='Excel 12.0;Xml;HDR=Yes;IMEX=1'";
                        ConStringXslx = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FilePath + ";Extended Properties='Excel 12.0;Xml;HDR=Yes;IMEX=1'";

                    }
                    else
                    {
                        ConStringXsl = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + FilePath + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
                        ConStringXslx = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + FilePath + ";Extended Properties='Excel 12.0;Xml;HDR=Yes;IMEX=1'";
                        //string ConStringXslx = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FilePath + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
                    }
                    switch (FileExtension)
                    {
                        case ".csv":
                            dtXlsx = XlsxUtility.ConvertCSVtoDataTable(FilePath);
                            break;
                        case ".xls":
                            connString = ConStringXsl;
                            dtXlsx = XlsxUtility.ConvertXSLXtoDataTable(FilePath, connString);
                            break;
                        case ".xlsx":
                            connString = ConStringXslx;
                            dtXlsx = XlsxUtility.ConvertXSLXtoDataTable(FilePath, connString);
                            break;
                    }

                    RU_EmpsXlsxList = SetXslxValues(dtXlsx);
                }
                else
                {
                    Request.CreateResponse(HttpStatusCode.Created, "File format not supported");
                }
            }
            else
            {
                Request.CreateResponse(HttpStatusCode.BadRequest, "Please select the file ");
            }

            return Request.CreateResponse(HttpStatusCode.Created, RU_EmpsXlsxList);
        }


        private List<RM_XslxEmployee> SetXslxValues(DataTable dtSetValues)
        {
            //Added by imran 24-08-2021  To check Excel header
            string Message = string.Empty;
            //string[] ColumnName = new string[19] { "Employee Name", "User", "Employee Code", "Gender", "Email", "Birth Date", "Role", "Reporting To", "Joining Date", "Business Group", "Organization Unit", "Designation", "Department", "Cost To Company", "Cost Per Hour", "Deployable", "Currency", "Employee Type","Rate Per Hour" };
            string[] ColumnName = new string[19] { "Employee Name", "User", "Employee Code", "Gender", "Email", "Birth Date", "Role", "Reporting To", "Joining Date", "Business Group", "Organization Unit", "Designation", "Department", "Employee Type", "Cost To Company", "Rate Per Hour", "Cost Per Hour", "Deployable", "Currency" };
            int ColsHeaderNamecheck = 0;
            //End by imran 24-08-2021

            var ObjXlsx = new RM_XslxEmployee();

            var ObjXlsxList = new List<RM_XslxEmployee>();
            var columnNames = dtSetValues.Columns.Cast<DataColumn>().Select(x => x.ColumnName).ToList();

            string ExcelStrSQL = "Select ISNULL(ExcelUploadRenge,0) from tbl_Whizible2_PM_ProjectSettings";
            object ExcelUploadRenge = CommonFunctions.Data.GetDataScalar(ExcelStrSQL, true, CommonController.connectionString);

            //Added by imran 24-08-2021 To check null
            for (int i = 0; i < columnNames.Count; i++)
            {
                if (i > 18)
                {
                }
                else
                {
                    if (columnNames[i] == ColumnName[i])
                    {
                        ColsHeaderNamecheck += 1;
                    }
                }
            }

            if (columnNames.Count != 19)
            {
                Message += string.Concat(':', "{0} Please Check Excel Column Configuration");
                ObjXlsx.ColumnError = Message;
                ObjXlsxList.Add(ObjXlsx);
            }
            else if (ColsHeaderNamecheck != 19)
            {
                Message += string.Concat(':', "{0} Excel Column Header Not Match");
                ObjXlsx.ColumnError = Message;
                ObjXlsxList.Add(ObjXlsx);
            }
            else if (dtSetValues.Rows.Count == 0)
            {
                Message += string.Concat(':', "{0} Uploaded Excel File is Blank");
                ObjXlsx.ColumnError = Message;
                ObjXlsxList.Add(ObjXlsx);
            }
            else if (dtSetValues.Rows.Count > Convert.ToInt32(ExcelUploadRenge))
            {
                Message += string.Concat(':', "{0} Please upload " + ExcelUploadRenge + " record");
                ObjXlsx.ColumnError = Message;
                ObjXlsxList.Add(ObjXlsx);
            }
            else if (dtSetValues.Rows.Count > 500)
            {
                Message += string.Concat(':', "{0} Uploaded file should not be greater than 500 record.");
                ObjXlsx.ColumnError = Message;
                ObjXlsxList.Add(ObjXlsx);
            }
            else
            {
                //end by imran 24-08-2021
                var selectedbirthdate = "";
                foreach (DataRow itemRow in dtSetValues.Rows)
                {
                    ObjXlsx = new RM_XslxEmployee();
                    foreach (var itemcl in columnNames)
                    {
                        var CurrentValue = itemRow[itemcl].ToString();

                        switch (itemcl)
                        {
                            case XlsxEmpHeaderNameConst.EmployeeName:
                                ObjXlsx.EmployeeName = CurrentValue;
                                continue;
                            case XlsxEmpHeaderNameConst.User:
                                if (XlsxUtility.IsEmptyfield(CurrentValue))
                                {
                                    Message += string.Concat(':', "{0}  User should not be left blank.");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else
                                {
                                    ObjXlsx.UserName = CurrentValue;
                                }
                                continue;
                            case XlsxEmpHeaderNameConst.EmployeeCode:
                                if (XlsxUtility.IsEmptyfield(CurrentValue))
                                {
                                    Message += string.Concat(':', "{0}  Employee Code should not be left blank.");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else
                                {
                                    ObjXlsx.EmployeeCode = CurrentValue;
                                }
                                continue;
                            case XlsxEmpHeaderNameConst.Gender:
                                if (XlsxUtility.IsEmptyfield(CurrentValue))
                                {
                                    Message += string.Concat(':', "{0}  Gender should not be left blank.");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else
                                {
                                    ObjXlsx.Gender = CurrentValue;
                                }
                                continue;
                            case XlsxEmpHeaderNameConst.Email:
                                if (XlsxUtility.IsEmptyfield(CurrentValue))
                                {
                                    Message += string.Concat(':', "{0}  Email should not be left blank.");
                                    ObjXlsx.ColumnError = Message;
                                }//Added By Dipali V On 1st March 2022 For Valid EmailID
                                else if (CurrentValue != "")
                                {
                                    string email = CurrentValue;
                                    Regex regex = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
                                    Match match = regex.Match(email);
                                    if (match.Success)
                                    {
                                        ObjXlsx.Email = CurrentValue;
                                    }
                                    else
                                    {
                                        Message += string.Concat(':', "{0} Email Address is Invalid .");
                                        ObjXlsx.ColumnError = Message;
                                    }
                                }//End of Added By Dipali V On 1st March 2022 For Valid EmailID
                                else
                                {
                                    ObjXlsx.Email = CurrentValue;
                                }
                                continue;
                            case XlsxEmpHeaderNameConst.Birthate:
                                //ObjXlsx.BirthDate = CurrentValue;

                                //Added by imran 26-08-2021 to convert date
                                if (CurrentValue == "" || CurrentValue == null || CurrentValue == "undefined")
                                {
                                    Message += string.Concat(':', "{0} Birth Date Sholud Not Be Left Blank.");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else
                                {
                                    try
                                    {
                                        selectedbirthdate = CurrentValue;
                                        string tdt = CurrentValue.Replace(" 00:00:00", "");
                                        DateTime dt = Convert.ToDateTime(tdt);
                                        ObjXlsx.BirthDate = dt.ToString("dd MMM yyyy");

                                    }
                                    catch
                                    {
                                        Message += string.Concat(':', "{0} Birth Date Is Invalid Date Format Or Invalid Date.");
                                        ObjXlsx.ColumnError = Message;
                                    }
                                }
                                //End by imran 26-08-2021

                                continue;
                            case XlsxEmpHeaderNameConst.Role:
                                if (XlsxUtility.IsEmptyfield(CurrentValue))
                                {
                                    Message += string.Concat(':', "{0}  Role should not be left blank.");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else
                                {
                                    ObjXlsx.RoleName = CurrentValue;
                                }
                                continue;
                            case XlsxEmpHeaderNameConst.ReportingTo:
                                if (XlsxUtility.IsEmptyfield(CurrentValue))
                                {
                                    Message += string.Concat(':', "{0}  Reporting To should not be left blank.");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else
                                {
                                    ObjXlsx.ReportingTo = CurrentValue;
                                }
                                continue;
                            case XlsxEmpHeaderNameConst.JoiningDate:
                                //ObjXlsx.JoiningDate = CurrentValue;
                                //Added by imran 26-08-2021 to convert date
                                if (CurrentValue == "" || CurrentValue == null || CurrentValue == "undefined")
                                {
                                    Message += string.Concat(':', "{0} Joining Date Sholud Not Be Left Blank.");
                                    ObjXlsx.ColumnError = Message;
                                }
                                //Added By Dipali V On 1st March 2022 For Validate Employee Age
                                else if (selectedbirthdate != "" && CurrentValue != "")
                                {
                                    try
                                    {
                                        DateTime DtDob = Convert.ToDateTime(selectedbirthdate);
                                        DateTime DtDoj = Convert.ToDateTime(CurrentValue);
                                        int DiffInYear = DtDoj.Year - DtDob.Year;
                                        if (DiffInYear <= 18)
                                        {
                                            Message += string.Concat(':', "{0} Employee should be greater than 18 years");
                                            ObjXlsx.ColumnError = Message;
                                        }
                                        else
                                        {
                                            string tdt = CurrentValue.Replace(" 00:00:00", "");
                                            DateTime dt = Convert.ToDateTime(tdt);
                                            ObjXlsx.JoiningDate = dt.ToString("dd MMM yyyy"); ;
                                        }
                                    }
                                    catch
                                    {
                                        Message += string.Concat(':', "{0} Joining Date Is Invalid Date Format Or Invalid Date. ");
                                        ObjXlsx.ColumnError = Message;
                                    }
                                }
                                //End of Added By Dipali V On 1st March 2022 For Validate Employee Age
                                else
                                {
                                    try
                                    {
                                        string tdt = CurrentValue.Replace(" 00:00:00", "");
                                        DateTime dt = Convert.ToDateTime(tdt);
                                        ObjXlsx.JoiningDate = dt.ToString("dd MMM yyyy"); ;
                                    }
                                    catch { }
                                }
                                //End by imran 26-08-2021
                                continue;
                            case XlsxEmpHeaderNameConst.BusinessGroup:
                                if (XlsxUtility.IsEmptyfield(CurrentValue))
                                {
                                    Message += string.Concat(':', "{0}  Business Group should not be left blank.");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else
                                {
                                    ObjXlsx.BusinessGroup = CurrentValue;
                                }
                                continue;
                            case XlsxEmpHeaderNameConst.Designation:
                                if (XlsxUtility.IsEmptyfield(CurrentValue))
                                {
                                    Message += string.Concat(':', "{0}  Designation should not be left blank.");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else
                                {
                                    ObjXlsx.Designation = CurrentValue;
                                }
                                continue;
                            case XlsxEmpHeaderNameConst.Department:
                                if (XlsxUtility.IsEmptyfield(CurrentValue))
                                {
                                    Message += string.Concat(':', "{0}  Department should not be left blank.");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else
                                {
                                    ObjXlsx.Department = CurrentValue;
                                }
                                continue;
                            case XlsxEmpHeaderNameConst.EmployeeType:
                                if (CurrentValue == "" || CurrentValue == null || CurrentValue == "undefined")
                                {
                                    Message += string.Concat(':', "{0} Employee Type Sholud Not Be Left Blank.");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else
                                {
                                    ObjXlsx.EmployeeType = CurrentValue;
                                }
                                continue;
                            case XlsxEmpHeaderNameConst.CostToCompany:
                                //Added by imran 24-08-2021 To check only number
                                if (CurrentValue == "" || CurrentValue == null || CurrentValue == "undefined")
                                {
                                    Message += string.Concat(':', "{0} Cost To Company Sholud Not Be Left Blank.");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else if (!XlsxUtility.IsDecimal(CurrentValue))
                                {
                                    ObjXlsx.CostToCompany = 0;
                                    Message += string.Concat(':', "{0}  Cost To Company should be in decimal.");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else if (Convert.ToDouble(CurrentValue) > 999999999.99)
                                {
                                    ObjXlsx.CostToCompany = 0;
                                    Message += string.Concat(':', "{0}  Cost To Company should not greater than 999999999.99");
                                    ObjXlsx.ColumnError = Message;
                                }
                                //Added By Dipali V On 1st March 2022 For Check Value is negative or positive
                                else if (Convert.ToDouble(CurrentValue) < 0)
                                {
                                    Message += string.Concat(':', "{0}  Cost To Company should be positive value");
                                    ObjXlsx.ColumnError = Message;
                                }
                                //End of Added By Dipali V On 1st March 2022 For Check Value is negative or positive

                                else
                                {
                                    ObjXlsx.CostToCompany = string.IsNullOrEmpty(CurrentValue) ? 0 : Convert.ToDecimal(CurrentValue);
                                }
                                //End by imran 24-08-2021  
                                continue;
                            case XlsxEmpHeaderNameConst.RatePerHour:
                                //Added by imran 24-08-2021 To check only number
                                if (CurrentValue == "" || CurrentValue == null || CurrentValue == "undefined")
                                {
                                    Message += string.Concat(':', "{0} Rate Per Hr Sholud Not Be Left Blank.");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else if (!XlsxUtility.IsDecimal(CurrentValue))
                                {
                                    Message += string.Concat(':', "{0}  Rate Per Hour should be in decimal. ");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else if (Convert.ToDouble(CurrentValue) > 99999.99)
                                {
                                    Message += string.Concat(':', "{0}  Rate Per Hour should not greater than 99999.99");
                                    ObjXlsx.ColumnError = Message;
                                }
                                //Added By Dipali V On 1st March 2022 For Check Value is negative or positive
                                else if (Convert.ToDouble(CurrentValue) < 0)
                                {
                                    Message += string.Concat(':', "{0}  Rate Per Hour should be positive value");
                                    ObjXlsx.ColumnError = Message;
                                }
                                //End of Added By Dipali V On 1st March 2022 For Check Value is negative or positive

                                else
                                {
                                    ObjXlsx.RatePerHr = string.IsNullOrEmpty(CurrentValue) ? 0 : Convert.ToDecimal(CurrentValue);
                                }
                                //End by imran 24-08-2021 
                                continue;
                            case XlsxEmpHeaderNameConst.CostPerHour:

                                if (XlsxUtility.IsEmptyfield(CurrentValue))
                                {
                                    Message += string.Concat(':', "{0}  Cost Per Hour should not be left blank.");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else if (!XlsxUtility.IsDecimal(CurrentValue))
                                {
                                    Message += string.Concat(':', "{0}  Cost Per Hour Should be in decimal. ");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else if (Convert.ToDouble(CurrentValue) > 99999.99)
                                {
                                    Message += string.Concat(':', "{0}  Cost per Hour should not greater than 99999.99");
                                    ObjXlsx.ColumnError = Message;
                                }
                                //Added By Dipali V On 1st March 2022 For Check Value is negative or positive
                                else if (Convert.ToDouble(CurrentValue) < 0)
                                {
                                    Message += string.Concat(':', "{0}  Cost per Hour should be positive value");
                                    ObjXlsx.ColumnError = Message;
                                }
                                //End of Added By Dipali V On 1st March 2022 For Check Value is negative or positive
                                else
                                {
                                    ObjXlsx.CostPerHr = string.IsNullOrEmpty(CurrentValue) ? 0 : Convert.ToDecimal(CurrentValue);
                                }
                                continue;
                            case XlsxEmpHeaderNameConst.Deployable:
                                if (XlsxUtility.IsEmptyfield(CurrentValue))
                                {
                                    Message += string.Concat(':', "{0}  Deployable should not be left blank.");
                                    ObjXlsx.ColumnError = Message;
                                }
                                //else if (CurrentValue != "Yes" && CurrentValue != "No" && CurrentValue != "yes" && CurrentValue != "no")
                                else if (CurrentValue != "1" && CurrentValue != "0")
                                {
                                    Message += string.Concat(':', "{0}  Deployable does not exists.");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else
                                {
                                    ObjXlsx.Deployable = CurrentValue;
                                }
                                continue;
                            case XlsxEmpHeaderNameConst.Currency:
                                if (XlsxUtility.IsEmptyfield(CurrentValue))
                                {
                                    Message += string.Concat(':', "{0}  Currency should not be left blank.");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else
                                {
                                    ObjXlsx.Currency = CurrentValue;
                                }
                                continue;
                            case XlsxEmpHeaderNameConst.OrganizationUnit:
                                if (XlsxUtility.IsEmptyfield(CurrentValue))
                                {
                                    Message += string.Concat(':', "{0}  Organization Unit should not be left blank.");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else
                                {
                                    ObjXlsx.OrganizationUnit = CurrentValue;
                                }
                                continue;
                        }
                    }

                    string CurrentDate = DateTime.Today.ToString("dd MMM yyyy");
                    if (!XlsxUtility.IsEmptyfield(ObjXlsx.JoiningDate))
                    {
                        try
                        {
                            if (Convert.ToDateTime(ObjXlsx.JoiningDate) > Convert.ToDateTime(CurrentDate))
                            {
                                Message += string.Concat(':', "{0} 'Joining Date' should not greater than Today's date.");
                                ObjXlsx.ColumnError = Message;
                            }
                        }
                        catch { }
                    }

                    if (!XlsxUtility.IsEmptyfield(ObjXlsx.JoiningDate))
                    {
                        if (!XlsxUtility.IsEmptyfield(ObjXlsx.BirthDate))
                        {
                            try
                            {
                                if (Convert.ToDateTime(ObjXlsx.BirthDate) > Convert.ToDateTime(ObjXlsx.JoiningDate))
                                {
                                    Message += string.Concat(':', "{0} 'Birth Date' should not be greater than 'Joining Date'.");
                                    ObjXlsx.ColumnError = Message;
                                }
                            }
                            catch { }
                        }

                    }
                    #region Validate values
                    ///Check user exist in table using Code and UserName
                    if (!XlsxUtility.IsEmptyfield(ObjXlsx.EmployeeCode) && !XlsxUtility.IsEmptyfield(ObjXlsx.UserName))
                    {
                        var IsExistUser = false;
                        //var strSQLIsExistr = "SELECT COUNT(EmployeeCode) FROM tbl_PM_Employee WHERE USERNAME= '" + ObjXlsx.UserName.Trim() + "' AND EmployeeCode= '" + ObjXlsx.EmployeeCode.Trim() + "'  ";
                        var strSQLIsExistr = "SELECT COUNT(EmployeeCode) FROM tbl_PM_Employee WHERE USERNAME= '" + ObjXlsx.UserName.Trim().Replace("'", "''") + "' OR EmployeeCode= '" + ObjXlsx.EmployeeCode.Trim().Replace("'", "''") + "'  ";
                        var Result = Convert.ToInt64(CommonFunctions.Data.GetDataScalar(strSQLIsExistr, true, CommonController.connectionString));
                        IsExistUser = Result > 0 ? true : false;
                        if (!IsExistUser)
                        {
                            if (XlsxUtility.IsEmptyfield(ObjXlsx.EmployeeName))
                            {
                                Message += string.Concat(':', "{0}  Employee Name should not be left blank");
                                ObjXlsx.ColumnError = Message;
                            }

                            //Added by imran 24-08-2021 To check null
                            if (ObjXlsx.EmployeeName != null)
                            {
                                if (ObjXlsx.EmployeeName.Length > 50)
                                {
                                    Message += string.Concat(':', "{1}  Employee Name should not greater than 50 characters. ");
                                    ObjXlsx.ColumnError = Message;
                                }
                            }
                            //end by imran 24-08-2021

                            if (XlsxUtility.IsEmptyfield(ObjXlsx.UserName))
                            {
                                Message += string.Concat(':', "{0}  User Name should not be left blank");
                                ObjXlsx.ColumnError = Message;
                            }

                            //Added by imran 24-08-2021 To check null
                            if (ObjXlsx.UserName != null)
                            {
                                if (XlsxUtility.IsEmptyfield(ObjXlsx.UserName) && ObjXlsx.UserName.Length > 10)
                                {
                                    Message += string.Concat(':', "{0}  User Name should not greater than 10 characters. ");
                                    ObjXlsx.ColumnError = Message;
                                }
                            }
                            //End by imran 24-08-2021

                            if (XlsxUtility.IsEmptyfield(ObjXlsx.EmployeeCode))
                            {
                                Message += string.Concat(':', "{0} Employee Code should not be left blank");
                                ObjXlsx.ColumnError = Message;
                            }
                            //Added by imran 24-08-2021 To check null
                            if (ObjXlsx.EmployeeCode != null)
                            {
                                if (XlsxUtility.IsEmptyfield(ObjXlsx.EmployeeCode) && ObjXlsx.EmployeeCode.Length > 10)
                                {
                                    Message += string.Concat(':', "{0}  Employee Code should not greater than 10 characters. ");
                                    ObjXlsx.ColumnError = Message;
                                }
                            }
                            //End by imran 24-08-2021

                            if (XlsxUtility.IsEmptyfield(ObjXlsx.EmployeeCode) && !XlsxUtility.IsDecimal(ObjXlsx.CostToCompany.ToString()))
                            {
                                Message += string.Concat(':', "{0}  Cost To Company Should be in decimal. ");
                                ObjXlsx.ColumnError = Message;
                            }

                            if (XlsxUtility.IsEmptyfield(ObjXlsx.RatePerHr.ToString()) && !XlsxUtility.IsDecimal(ObjXlsx.RatePerHr.ToString()))
                            {
                                Message += string.Concat(':', "{0}  RatePerHour Should be in decimal. ");
                                ObjXlsx.ColumnError = Message;
                            }

                            //if (XlsxUtility.IsEmptyfield(ObjXlsx.CostPerHr.ToString()) && !XlsxUtility.IsDecimal(ObjXlsx.CostPerHr.ToString()))
                            //{
                            //    Message += string.Concat(':', "{0}  CostPerHour Should be in decimal. ");
                            //    ObjXlsx.ColumnError = Message;
                            //}
                            //if (XlsxUtility.IsEmptyfield(ObjXlsx.Currency))
                            //{
                            //    Message += string.Concat(':', "{0}  Currency Name should not be left blank");
                            //    ObjXlsx.ColumnError = Message;
                            //}
                            //if (ObjXlsx.CostPerHr > 0 && ObjXlsx.RatePerHr > 0)
                            //{
                            //    if (XlsxUtility.CompareDecValues(ObjXlsx.CostPerHr, ObjXlsx.RatePerHr))
                            //    {
                            //        Message += string.Concat(':', "{0}  CostPerHour Should Not be greater than RatePerHour. ");
                            //        ObjXlsx.ColumnError = Message;
                            //    }
                            //}


                            #region Get Ids for bg type etc using name
                            if (!XlsxUtility.IsEmptyfield(ObjXlsx.BusinessGroup) && !XlsxUtility.IsEmptyfield(ObjXlsx.OrganizationUnit) && !XlsxUtility.IsEmptyfield(ObjXlsx.Department) && !XlsxUtility.IsEmptyfield(ObjXlsx.EmployeeType))
                            {
                                string strParms = "@BusinessGroup='" + ObjXlsx.BusinessGroup.Replace("'", "''") + "'," + "@OrganizationUnit='" + ObjXlsx.OrganizationUnit.Replace("'", "''") + "'," + "@Designation='" + ObjXlsx.Designation.Replace("'", "''") + "'," + "@Department='" + ObjXlsx.Department.Replace("'", "''") + "'," + "@Currency='" + ObjXlsx.Currency.Replace("'", "''") + "'," + "@ReportingTo='" + ObjXlsx.ReportingTo.Replace("'", "''") + "'," + "@RoleName='" + ObjXlsx.RoleName.Replace("'", "''") + "'," + "@EmployeeType='" + ObjXlsx.EmployeeType.Replace("'", "''") + "'";
                                var strSQL = "Exec usp_Whizible2_Select_IDs_BgOuDesgDepCurr_ByName " + strParms;

                                IDataReader drQuery;
                                drQuery = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                                int BusinessGroupId = 0, OrganizationId = 0, DesignationId = 0, DepartmentId = 0, CurrencyId = 0, RoleId = 0, ReportingToId = 0;
                                string StrEmployeeType = "";
                                if (drQuery.Read())
                                {
                                    DesignationId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["DesignationId"], "0"));
                                    DepartmentId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["DepartmentId"], "0"));
                                    BusinessGroupId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["BusinessGroupID"], "0"));
                                    OrganizationId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["OrganizationUnitId"], "0"));
                                    CurrencyId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["CurrencyId"], "0"));
                                    RoleId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["RoleId"], "0"));
                                    ReportingToId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["ReportingToId"], "0"));
                                    StrEmployeeType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drQuery["EmployeeType"], ""));
                                }
                                if (!drQuery.IsClosed)
                                {
                                    drQuery.Close();
                                }

                                if (DesignationId > 0)
                                {
                                    ObjXlsx.DesignationID = DesignationId;
                                }
                                else
                                {
                                    //Message += string.Concat(':', "Designation not found for " + ObjXlsx.Designation);
                                    if (!XlsxUtility.IsEmptyfield(ObjXlsx.Designation))
                                    {
                                        Message += string.Concat(':', "{0} Designation does not exists.");
                                        ObjXlsx.ColumnError = Message;
                                    }
                                }
                                ///ObjXlsx.DepartmentID = 1;
                                if (DepartmentId > 0)
                                {
                                    ObjXlsx.DepartmentID = DepartmentId;
                                }
                                else
                                {
                                    //Message += string.Concat(':', "Department not found for " + ObjXlsx.Department);
                                    if (!XlsxUtility.IsEmptyfield(ObjXlsx.Department))
                                    {
                                        Message += string.Concat(':', "{0} Department does not exists.");
                                        ObjXlsx.ColumnError = Message;
                                    }
                                }
                                if (BusinessGroupId > 0)
                                {
                                    ObjXlsx.BusinessGroupID = BusinessGroupId;
                                }
                                else
                                {
                                    //Message += string.Concat(':', "BusinessGroup  not found for " + ObjXlsx.BusinessGroup);
                                    if (!XlsxUtility.IsEmptyfield(ObjXlsx.BusinessGroup))
                                    {
                                        Message += string.Concat(':', "{0} Business Group does not exists.");
                                        ObjXlsx.ColumnError = Message;
                                    }
                                }
                                if (OrganizationId > 0)
                                {
                                    ObjXlsx.LocationID = OrganizationId;
                                }
                                else
                                {
                                    //Message += string.Concat(':', "OrganizationUnit not found for " + ObjXlsx.OrganizationUnit);
                                    if (!XlsxUtility.IsEmptyfield(ObjXlsx.OrganizationUnit))
                                    {
                                        Message += string.Concat(':', "{0} Business Group and Organization Unit are not associated with each other. ");
                                        ObjXlsx.ColumnError = Message;
                                    }
                                }
                                if (CurrencyId > 0)
                                {
                                    ObjXlsx.CurrencyID = CurrencyId;
                                }
                                else
                                {
                                    //Message += string.Concat(':', "Currency not found for " + ObjXlsx.Currency);
                                    if (!XlsxUtility.IsEmptyfield(ObjXlsx.Currency))
                                    {
                                        Message += string.Concat(':', "{0} Currency does not exists.");
                                        ObjXlsx.ColumnError = Message;
                                    }
                                }
                                if (ReportingToId > 0)
                                {
                                    ObjXlsx.ReportingToId = ReportingToId;
                                }
                                else
                                {
                                    //Message += string.Concat(':', "ReportingTo not found for " + ObjXlsx.ReportingTo);
                                    if (!XlsxUtility.IsEmptyfield(ObjXlsx.ReportingTo))
                                    {
                                        Message += string.Concat(':', "{0} Reporting To does not exists.");
                                        ObjXlsx.ColumnError = Message;
                                    }
                                }
                                if (RoleId > 0)
                                {
                                    ObjXlsx.RoleID = RoleId;
                                }
                                else
                                {
                                    // Message += string.Concat(':', "Role not found for " + ObjXlsx.ReportingTo);
                                    if (!XlsxUtility.IsEmptyfield(ObjXlsx.RoleName))
                                    {
                                        Message += string.Concat(':', "{0} Role does not exists.");
                                        ObjXlsx.ColumnError = Message;
                                    }
                                }
                                if (XlsxUtility.IsEmptyfield(StrEmployeeType))
                                {
                                    Message += string.Concat(':', "{0} Employee Type does not exists.");
                                    ObjXlsx.ColumnError = Message;
                                }

                                #endregion

                            }
                            else { }
                        }
                        else
                        {
                            Message += string.Concat(':', "{1}  User/Employee Code Already Exist.");
                            ObjXlsx.ColumnError = Message;
                        }

                    }
                    else
                    {
                        //Message += string.Concat(':', "{1}  User/Employee Code should not left blank.");
                        //ObjXlsx.ColumnError = Message;
                    }
                    #endregion
                    ObjXlsxList.Add(ObjXlsx);
                }
            }
            return ObjXlsxList;
        }

        //Added by imran 24-08-2021 To check Digit Only
        bool IsDigitsOnly(string str)
        {
            foreach (char c in str)
            {
                if (c < '0' || c > '9' || c == '.')
                    return false;
            }
            return true;
        }
        //End by imran 24-08-2021
        [Authorize]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage UploadXlsxRecord(List<RM_XslxEmployee> XlsxEmpListParams)
        {
            try
            {
                foreach (var itemXlsx in XlsxEmpListParams)
                {
                    if (itemXlsx != null)
                    {
                        string strParms = "@EmployeeName='" + itemXlsx.EmployeeName.Replace("'", "''") + "'," + "@UserName='" + itemXlsx.UserName.Trim().Replace("'", "''") + "',"
                        + "@EmployeeCode='" + itemXlsx.EmployeeCode.Trim().Replace("'", "''") + "'," + "@Gender='" + itemXlsx.Gender + "',"
                        + "@EmailID='" + itemXlsx.Email + "'," + "@BirthDate='" + itemXlsx.BirthDate + "'," + "@PostID='" + itemXlsx.RoleID + "',"
                        + "@ReportingTo='" + itemXlsx.ReportingToId + "'," + "@JoiningDate='" + itemXlsx.JoiningDate + "',"
                        + "@BusinessGroupID='" + itemXlsx.BusinessGroupID + "'," + "@LocationID='" + itemXlsx.LocationID + "'," + "@DesignationID='" + itemXlsx.DesignationID + "',"
                        + "@DepartmentID='" + itemXlsx.DepartmentID + "'," + "@EmployeeType='" + itemXlsx.EmployeeType + "',"
                        + "@CostToCompany='" + itemXlsx.CostToCompany + "'," + "@RatePerHour='" + itemXlsx.RatePerHr + "'," + "@CostPerHour='" + itemXlsx.CostPerHr + "',"
                        + "@Deployable='" + itemXlsx.Deployable + "'," + "@CurrencyID='" + itemXlsx.CurrencyID + "',"
                        + "@Status=0,@IsLDAPAuthentication=0,@CreatedBy='" + itemXlsx.UploadedBy + "' ";

                        var strSQL = "EXEC usp_Whizible2_Ins_tbl_PM_EmployeeMaster " + strParms;


                        var strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        if (strtResult != null)
                        {
                            // return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
            return Request.CreateResponse(HttpStatusCode.Created, "");
        }

        #endregion

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage GetCurrencyCostForEdit([FromBody] RM_EmployeeCostDetails Parameter)
        {
            HttpResponseMessage response;
            string strSQL;
            try
            {
                strSQL = "exec usp_Whizible2_Sel_tbl_PM_EmployeeCost_Details "
                    + Parameter.EmployeeID + ","
                    + Parameter.EmployeeCostID.ToString();
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                response = Request.CreateResponse(HttpStatusCode.OK, dt);
                return response;

            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage UpdateCostDetails([FromBody] RM_EmployeeCostDetails Op_Patameters)
        {
            string strtResult = string.Empty;
            string strSQL;
            try
            {
                if (Op_Patameters != null)
                {
                    strSQL = "Exec usp_Whizible2_Upd_tbl_PM_EmployeeCost_Details "
                        + Op_Patameters.EmployeeID + ","
                        + Op_Patameters.CostPerHour + ",'"
                        + Op_Patameters.StartDate + "','"
                        + Op_Patameters.CreatedBy + "',"
                        + Op_Patameters.EmployeeCostID + "";

                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }

                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, strtResult);

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage GetEditQualificationDetails([FromBody] RM_QualificationDetails Parameter)
        {
            HttpResponseMessage response;
            string strSQL;
            try
            {
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Qualification_Details " + Parameter.EmployeeID + "," + Parameter.QualificationID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                response = Request.CreateResponse(HttpStatusCode.OK, dt);
                return response;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage UpdateQualificationDetails([FromBody] RM_QualificationDetails Op_Patameters)
        {
            string strtResult = string.Empty;
            string strSQL;
            try
            {
                if (Op_Patameters != null)
                {
                    strSQL = "Exec usp_Whizible2_Upd_tbl_PM_EmployeeQualificationMatrix "
                        + Op_Patameters.EmployeeID + ","
                        + Op_Patameters.EmployeeQualificationID + ","
                        + Op_Patameters.QualificationID + ",'"
                        + Op_Patameters.University + "',"
                        + Op_Patameters.PassoutYear + ",'"
                        + Op_Patameters.Class + "',"
                        + Op_Patameters.Percentage + ",'"
                        + Op_Patameters.CreatedBy + "'";

                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }

                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, strtResult);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage GetPreviousWorkExpForEdit([FromBody] RM_EmployeeCostDetails Parameter)
        {
            HttpResponseMessage response;
            string strSQL;
            try
            {
                strSQL = "exec usp_Whizible2_tbl_RM_GetMEPreWorkExperienceDetails_Edit "
                    + Parameter.EmployeeID + ","
                    + Parameter.EmployeeCostID.ToString();
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                response = Request.CreateResponse(HttpStatusCode.OK, dt);
                return response;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage GetMEPreAssignmentDetailsEdit([FromBody] RM_EmployeePreAssignmentList Parameter)
        {

            var EmployeePreAssignmentist = new List<RM_EmployeePreAssignmentList>();
            try
            {
                if (Parameter.EmployeeID > 0)
                {
                    string strSQL = "";
                    strSQL = "Exec usp_Whizible2_tbl_RM_GetMEPreAssignmentsDetails " + Parameter.EmployeeID + "," + Parameter.EmployeeHistoryProjectID + "";
                    DataTable EmployeePreAssignTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (EmployeePreAssignTable != null)
                    {
                        EmployeePreAssignmentist = EmployeePreAssignTable.ToListCast<RM_EmployeePreAssignmentList>();
                    }
                }

                return Request.CreateResponse(HttpStatusCode.OK, EmployeePreAssignmentist);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage GetEditEmployeeVisaDetails([FromBody] RM_EmployeeVisaList Parameter)
        {
            HttpResponseMessage response;
            string strSQL;
            try
            {
                strSQL = "Exec usp_Whizible2_tbl_RM_GetEmployeeVisaDetails " + Parameter.EmployeeID + "," + Parameter.EmployeeVisaID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                response = Request.CreateResponse(HttpStatusCode.OK, dt);
                return response;
            }
            catch (Exception e)
            {
                //response = Request.CreateResponse(HttpStatusCode.BadRequest, e.Message);
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");

            }

        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage UpdateVisaDetails([FromBody] RM_EmployeeVisaList employeeVisaParameters)
        {
            string strtResult = string.Empty;
            string strSQL;
            try
            {
                if (employeeVisaParameters != null)
                {
                    strSQL = "Exec usp_Whizible2_Upd_tbl_pm_Employeevisadetails "
                        + employeeVisaParameters.EmployeeID + ","
                        + employeeVisaParameters.CountryID + ","
                        + employeeVisaParameters.VisaTypeID + " ,'"
                        + employeeVisaParameters.dtValidFrom + "','"
                        + employeeVisaParameters.dtValidUpto + "','"
                        + employeeVisaParameters.Remarks + "','"
                        + employeeVisaParameters.CreatedBy + "',"
                        + employeeVisaParameters.EmployeeVisaID;
                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }

                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, strtResult);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage UpdateCertifications([FromBody] RM_EmpCertifications Op_parameters)
        {
            string strtResult = string.Empty;
            string strSQL = "";
            try
            {
                if (Op_parameters != null)
                {

                    strSQL = "Exec usp_Whizible2_Upd_tbl_PM_EmployeeCertificationMatrix " + Op_parameters.EmployeeID + "," + Op_parameters.CertificationID + ",'" + Op_parameters.CertificationDate + "','" + Op_parameters.ValidUpto + "'," + Op_parameters.ActualScore + "," + Op_parameters.TotalScore + "," + Op_parameters.EmployeeCertificationID + "";

                    //int Result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    //CommonFunctions.Data.InsertOrUpdateData(strtResult, true, CommonController.connectionString);
                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, strtResult);

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage GetCertificationForEdit([FromBody] RM_EmpCertifications Parameter)
        {
            HttpResponseMessage response;
            string strSQL;
            try
            {
                strSQL = "exec usp_Whizible2_Sel_tbl_PM_EmployeeCertificationMatrix_Edit "
                    + Parameter.EmployeeID + ","
                    + Parameter.EmployeeCertificationID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                response = Request.CreateResponse(HttpStatusCode.OK, dt);
                return response;

            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        public HttpResponseMessage GetEmployeeGroupForEdit([FromBody] RM_EmployeeGroups Parameter)
        {
            HttpResponseMessage response;
            string strSQL;
            try
            {
                strSQL = "exec usp_Whizible2_Sel_tbl_PM_EmployeeGroups_Edit "
                    + Parameter.UserID + ","
                    + Parameter.UniqueID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                response = Request.CreateResponse(HttpStatusCode.OK, dt);
                return response;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage UpdateGroups([FromBody] RM_EmployeeGroups Op_Patameters)
        {
            string strtResult = string.Empty;
            string strSQL;
            try
            {
                if (Op_Patameters != null)
                {
                    strSQL = "Exec usp_Whizible2_Upd_tbl_PM_EmployeeGroups " + Op_Patameters.UserID + "," + Op_Patameters.GroupID + ",'" + Op_Patameters.LoginType + "'," + Op_Patameters.UniqueID + "";

                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }

                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, strtResult);

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added By Reshma Chavan on 28th Jan 2022
        //Added by imran on 24-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 24-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ReassignResource([FromBody] string EmployeeID)
        {
            try
            {
                int Result;
                var strSQL = "Exec usp_Whizible2_upd_EmployeeStatus " + EmployeeID + "";
                Result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return Result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added by Divya J on 28 August 2025 for Pointwest customisation
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage saveContractType([FromBody] RM_SubTab Op_Patameters)
        {
            string strtResult = string.Empty;
            string strSQL;
            HttpResponseMessage response;
            try
            {
                if (Op_Patameters != null)
                {
                    strSQL = "Exec usp_Whizible2_Ins_upd_tbl_PM_Employee_ContractType "
                        + Op_Patameters.EmployeeId + "," + Op_Patameters.ContractTypeID + ",'" + Op_Patameters.EffectiveFrom + "','" + Op_Patameters.EffectiveTo + "','" + Op_Patameters.Remarks + "','" + Op_Patameters.UserName + "'";

                    if (Op_Patameters.EmpContractTypeId != 0)
                    {
                        strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(Op_Patameters.EmpContractTypeId));
                    }
                    else
                    {
                        strSQL += ",NULL";
                    }

                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }
                    response = Request.CreateResponse(HttpStatusCode.OK, strtResult);
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }

            }
            catch (Exception ex)
            {
                //return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
                response = Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
            return response;
        }




        [HttpPost]
        public HttpResponseMessage GetContractTypeList([FromBody] RM_SubTab Op_Patameters)
        {
            HttpResponseMessage response;
            string strSQL;
            try
            {
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Employee_ContractType " + Op_Patameters.EmployeeId + ",";

                if (Op_Patameters.EmpContractTypeId != 0)
                {
                    strSQL += HttpUtility.UrlDecode(Convert.ToString(Op_Patameters.EmpContractTypeId));
                }
                else
                {
                    strSQL += "NULL";
                }
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                response = Request.CreateResponse(HttpStatusCode.OK, dt);
            }
            catch (Exception e)
            {
                response = Request.CreateResponse(HttpStatusCode.BadRequest, e.Message);
            }
            return response;

        }

        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteContractType([FromBody] string Parameters)
        {
            try
            {
                string strResult = "";
                int delete = 0;
                int notDelete = 0;
                if (Parameters != null)
                {
                    var splitParmas = Parameters.Split(',').ToList();
                    foreach (var itemUniqueID in splitParmas)
                    {
                        string strSQL = "Exec usp_Whizible2_Del_tbl_PM_Employee_ContractType '" + itemUniqueID + "'";
                        strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        if (strResult == "deleted")
                        {
                            delete++;
                        }
                        else
                        {
                            notDelete++;
                        }
                    }
                    return Request.CreateResponse(HttpStatusCode.OK, new { deletedCount = delete, notDeletedCount = notDelete });
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }

        }


        [HttpPost]
        public HttpResponseMessage ValidateTrainingDate([FromBody] RM_SubTab Op_Patameters)
        {
            string strtResult = string.Empty;
            string strSQL;
            try
            {
                if (Op_Patameters != null)
                {
                    strSQL = "Exec usp_Whizible2_Validate_TrainingDate "
                        + Op_Patameters.EmployeeId + ",'" + Op_Patameters.EffectiveFrom + "','" + Op_Patameters.EffectiveTo + "'," + Op_Patameters.TrainingID;

                    if (Op_Patameters.EmployeeTrainingID != 0)
                    {
                        strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(Op_Patameters.EmployeeTrainingID));
                    }
                    else
                    {
                        strSQL += ",NULL";
                    }

                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }

                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
            return Request.CreateResponse(HttpStatusCode.OK, strtResult);
        }


        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage saveTraining([FromBody] RM_SubTab Op_Patameters)
        {
            string strtResult = string.Empty;
            string strSQL;
            try
            {
                if (Op_Patameters != null)
                {
                    strSQL = "Exec usp_Whizible2_Ins_upd_tbl_PM_EmployeeTrainingDetails "
                        + Op_Patameters.EmployeeId + "," + Op_Patameters.TrainingID + ",'" + Op_Patameters.EffectiveFrom + "','"
                        + Op_Patameters.EffectiveTo + "','" + Op_Patameters.Achivements + "','" + Op_Patameters.UserName + "'";

                    if (Op_Patameters.EmployeeTrainingID != 0)
                    {
                        strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(Op_Patameters.EmployeeTrainingID));
                    }
                    else
                    {
                        strSQL += ",NULL";
                    }
                    strSQL += ",'" + Op_Patameters.SponseredBy + "','" + Op_Patameters.ConductedBy + "','" + Op_Patameters.TrainingCost + "'";

                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }

                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
            return Request.CreateResponse(HttpStatusCode.OK, strtResult);
        }


        [HttpPost]
        public HttpResponseMessage GetTrainingList([FromBody] RM_SubTab Op_Patameters)
        {
            HttpResponseMessage response;
            string strSQL;
            try
            {
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_EmployeeTrainingDetails " + Op_Patameters.EmployeeId + ",";

                if (Op_Patameters.EmployeeTrainingID != 0)
                {
                    strSQL += HttpUtility.UrlDecode(Convert.ToString(Op_Patameters.EmployeeTrainingID));
                }
                else
                {
                    strSQL += "NULL";
                }
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                response = Request.CreateResponse(HttpStatusCode.OK, dt);
            }
            catch (Exception e)
            {
                response = Request.CreateResponse(HttpStatusCode.BadRequest, e.Message);
            }
            return response;

        }

        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteTraining([FromBody] string Parameters)
        {
            try
            {
                string strResult = "";
                int delete = 0;
                int notDelete = 0;
                if (Parameters != null)
                {
                    var splitParmas = Parameters.Split(',').ToList();
                    foreach (var itemUniqueID in splitParmas)
                    {
                        string strSQL = "Exec usp_Whizible2_Del_tbl_PM_EmployeeTrainingDetails '" + itemUniqueID + "'";
                        strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        if (strResult == "deleted")
                        {
                            delete++;
                        }
                        else
                        {
                            notDelete++;
                        }
                    }
                    return Request.CreateResponse(HttpStatusCode.OK, new { deletedCount = delete, notDeletedCount = notDelete });
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }

        }

        [HttpPost]
        public HttpResponseMessage GetOrganizationUnit([FromBody] RM_SubTab Op_Patameters)
        {
            HttpResponseMessage response;
            string strSQL;
            try
            {
                strSQL = "Exec usp_Whizible2_OldSel_tbl_CNF_BusinessGroup_OUPools " + Op_Patameters.BusinessGroupID;
                // + ",";

                //if (Op_Patameters.EmployeeTrainingID != 0)
                //{
                //    strSQL += HttpUtility.UrlDecode(Convert.ToString(Op_Patameters.EmployeeTrainingID));
                //}
                //else
                //{
                //    strSQL += "NULL";
                //}
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                response = Request.CreateResponse(HttpStatusCode.OK, dt);
            }
            catch (Exception e)
            {
                response = Request.CreateResponse(HttpStatusCode.BadRequest, e.Message);
            }
            return response;

        }

        [HttpPost]
        public HttpResponseMessage GetDeliveryUnit([FromBody] RM_SubTab Op_Patameters)
        {
            HttpResponseMessage response;
            string strSQL;
            try
            {
                strSQL = "Exec usp_Whizible2_OldSel_tbl_PM_OUPool_ResourcePools " + Op_Patameters.OrganizationUnitID;
                // + ",";

                //if (Op_Patameters.EmployeeTrainingID != 0)
                //{
                //    strSQL += HttpUtility.UrlDecode(Convert.ToString(Op_Patameters.EmployeeTrainingID));
                //}
                //else
                //{
                //    strSQL += "NULL";
                //}
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                response = Request.CreateResponse(HttpStatusCode.OK, dt);
            }
            catch (Exception e)
            {
                response = Request.CreateResponse(HttpStatusCode.BadRequest, e.Message);
            }
            return response;

        }

        [HttpPost]
        public HttpResponseMessage GetDeliveryTeam([FromBody] RM_SubTab Op_Patameters)
        {
            HttpResponseMessage response;
            string strSQL;
            try
            {
                strSQL = "Exec usp_Whizible2_OldSel_tbl_PM_GroupMaster " + Op_Patameters.DeliveryUnitID;
                // + ",";

                //if (Op_Patameters.EmployeeTrainingID != 0)
                //{
                //    strSQL += HttpUtility.UrlDecode(Convert.ToString(Op_Patameters.EmployeeTrainingID));
                //}
                //else
                //{
                //    strSQL += "NULL";
                //}
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                response = Request.CreateResponse(HttpStatusCode.OK, dt);
            }
            catch (Exception e)
            {
                response = Request.CreateResponse(HttpStatusCode.BadRequest, e.Message);
            }
            return response;

        }

        //Added by Aditya J. on 05-03-2026 for GDPR Field Visibility Settings
        // -----------------------------------------------------------------------
        // GDPR Item 54 - Employee Master Field Visibility Configuration
        // Added for GDPR Compliance - Item 54
        // -----------------------------------------------------------------------

        /// <summary>
        /// GET: Returns all GDPR field visibility settings from DB.
        /// Called on Employee Master page load so JS can apply field visibility.
        /// API URL: /api/RM_EmployeeMaster/GetGDPRFieldConfig
        /// </summary>
        [Authorize]
        [HttpPost]
        public HttpResponseMessage GetGDPRFieldConfig()
        {
            var configList = new List<RM_GDPR_FieldConfig>();
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_GDPR_EmpMaster_GetFieldConfig";
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (dt != null)
                {
                    configList = dt.ToList<RM_GDPR_FieldConfig>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, configList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        /// SAVE: Upserts all GDPR field visibility settings into DB.
        /// Called when admin clicks "Save Settings" in the GDPR modal.
        /// API URL: /api/RM_EmployeeMaster/SaveGDPRFieldConfig
        /// </summary>

        // -----------------------------------------------------------------------
        // End of GDPR Item 54
        // -----------------------------------------------------------------------
        //End of Added by Aditya J. on 05-03-2026 for GDPR Field Visibility Settings

        [HttpPost]
        public HttpResponseMessage GetEmployeeMovementsList([FromBody] RM_SubTab Op_Patameters)
        {
            HttpResponseMessage response;
            string strSQL;
            try
            {
                strSQL = "Exec usp_Whizible2_Sel_v_tbl_PW_Employee_Promotion_Details " + Op_Patameters.EmployeeId + ",";

                if (Op_Patameters.UniqueID != 0)
                {
                    strSQL += HttpUtility.UrlDecode(Convert.ToString(Op_Patameters.UniqueID));
                }
                else
                {
                    strSQL += "NULL";
                }
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                response = Request.CreateResponse(HttpStatusCode.OK, dt);
            }
            catch (Exception e)
            {
                response = Request.CreateResponse(HttpStatusCode.BadRequest, e.Message);
            }
            return response;

        }


        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage saveEmployeeMovements([FromBody] RM_SubTab Op_Patameters)
        {
            string strtResult = string.Empty;
            string strSQL;
            try
            {
                if (Op_Patameters != null)
                {
                    strSQL = "Exec usp_Whizible2_Ins_upd_tbl_PW_Employee_Promotion_Details "
                        + Op_Patameters.EmployeeId
                        + "," + Op_Patameters.OldDesignationID + "," + Op_Patameters.NewDesignationID
                        + "," + Op_Patameters.OldPracticeID + "," + Op_Patameters.NewPracticeID
                        + "," + Op_Patameters.OldBusinessGroupID + "," + Op_Patameters.NewBusinessGroupID
                        + "," + Op_Patameters.OldOrganizationUnitID + "," + Op_Patameters.NewOrganizationUnitID
                        + "," + Op_Patameters.OldDeliveryUnitID + "," + Op_Patameters.NewDeliveryUnitID + "," + Op_Patameters.MovementTypeID
                        + ",'" + Op_Patameters.EffectiveDate + "','" + Op_Patameters.NewRate + "','" + Op_Patameters.Comments + "','" + Op_Patameters.ExpectedReturnDate + "','" + Op_Patameters.UserName + "'";

                    if (Op_Patameters.UniqueID != 0)
                    {
                        strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(Op_Patameters.UniqueID));
                    }
                    else
                    {
                        strSQL += ",NULL";
                    }

                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }

                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
            return Request.CreateResponse(HttpStatusCode.OK, strtResult);
        }


        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteEmployeeMovements([FromBody] string Parameters)
        {
            try
            {
                string strResult = "";
                int delete = 0;
                int notDelete = 0;
                if (Parameters != null)
                {
                    var splitParmas = Parameters.Split(',').ToList();
                    foreach (var itemUniqueID in splitParmas)
                    {
                        string strSQL = "Exec usp_Whizible2_Del_tbl_PW_Employee_Promotion_Details '" + itemUniqueID + "'";
                        strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        if (strResult == "deleted")
                        {
                            delete++;
                        }
                        else
                        {
                            notDelete++;
                        }
                    }
                    return Request.CreateResponse(HttpStatusCode.OK, new { deletedCount = delete, notDeletedCount = notDelete });
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }

        }

        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public void SpecimenSignatureUpload()
        {
            try
            {

                if (HttpContext.Current.Request.Files.Count != 0)
                {
                    string strtResult = "";
                    var FromSave = HttpContext.Current.Request.Form["FromSave"];
                    var EmployeeId = HttpContext.Current.Request.Form["EmployeeId"];
                    var OldFileName = HttpContext.Current.Request.Form["OldFileName"];
                    var createdby = HttpContext.Current.Request.Form["CreatedBy"];
                    var LoginType = HttpContext.Current.Request.Form["LoginType"];
                    string OriginalfileName = Path.GetFileName(HttpContext.Current.Request.Files[0].FileName);
                    string extension = Path.GetExtension(HttpContext.Current.Request.Files[0].FileName).ToLower();
                    var newFileName = CommonFunctions.FileDirectory.GetUniqueFileName().Trim() + extension;
                    var rootpath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../Images/Photo/"));//FOR DEV ENV

                    XlsxUtility.CreateDocDirectory(rootpath);
                    var path = Path.Combine(rootpath, newFileName);
                    HttpContext.Current.Request.Files[0].SaveAs(path);

                    //get previous filename for delete in case of update
                    string strSQL2 = "Exec usp_Whizible2_tbl_RM_GetEmployeeDetails '" + Convert.ToString(EmployeeId) + "'";
                    IDataReader drQuery;
                    drQuery = CommonFunctions.Data.GetDataReader(strSQL2, true, CommonController.connectionString);
                    string SpecimenSignaturePicURL = "";
                    if (drQuery.Read())
                    {
                        SpecimenSignaturePicURL = Convert.ToString(drQuery["SpecimenSignaturePicURL"]);
                    }
                    //save image
                    string strSQL = "Exec usp_Whizible2_Ins_tbl_PM_Attachments_SpecimenSignature " + EmployeeId + ",'" + OriginalfileName + "','" + newFileName + "' ,'" + createdby + "','" + LoginType + "'";
                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    //delete image in update

                    if (strtResult != null)
                    {
                        if (FromSave == "0")
                        {
                            var deletepath = Path.Combine(rootpath, System.IO.Path.GetFileName(SpecimenSignaturePicURL));
                            XlsxUtility.DeleteFileIfExist(deletepath);
                        }
                    }
                    else
                    {
                    }
                }
            }
            catch (Exception ex)
            {
            }

        }


        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public void PassportIDPictureUpload()
        {
            try
            {

                if (HttpContext.Current.Request.Files.Count != 0)
                {
                    string strtResult = "";
                    var FromSave = HttpContext.Current.Request.Form["FromSave"];
                    var EmployeeId = HttpContext.Current.Request.Form["EmployeeId"];
                    var OldFileName = HttpContext.Current.Request.Form["OldFileName"];
                    var createdby = HttpContext.Current.Request.Form["CreatedBy"];
                    var LoginType = HttpContext.Current.Request.Form["LoginType"];
                    string OriginalfileName = Path.GetFileName(HttpContext.Current.Request.Files[0].FileName);
                    string extension = Path.GetExtension(HttpContext.Current.Request.Files[0].FileName).ToLower();
                    var newFileName = CommonFunctions.FileDirectory.GetUniqueFileName().Trim() + extension;
                    var rootpath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../Images/Photo/"));//FOR DEV ENV

                    XlsxUtility.CreateDocDirectory(rootpath);
                    var path = Path.Combine(rootpath, newFileName);
                    HttpContext.Current.Request.Files[0].SaveAs(path);

                    //get previous filename for delete in case of update
                    string strSQL2 = "Exec usp_Whizible2_tbl_RM_GetEmployeeDetails '" + Convert.ToString(EmployeeId) + "'";
                    IDataReader drQuery;
                    drQuery = CommonFunctions.Data.GetDataReader(strSQL2, true, CommonController.connectionString);
                    string PassportIDPictureURL = "";
                    if (drQuery.Read())
                    {
                        PassportIDPictureURL = Convert.ToString(drQuery["PassportIDPictureURL"]);
                    }
                    //save image
                    string strSQL = "Exec usp_Whizible2_Ins_tbl_PM_Attachments_PassportIDPicture " + EmployeeId + ",'" + OriginalfileName + "','" + newFileName + "' ,'" + createdby + "','" + LoginType + "'";
                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    //delete image in update

                    if (strtResult != null)
                    {
                        if (FromSave == "0")
                        {
                            var deletepath = Path.Combine(rootpath, System.IO.Path.GetFileName(PassportIDPictureURL));
                            XlsxUtility.DeleteFileIfExist(deletepath);
                        }
                    }
                    else
                    {
                    }
                }
            }
            catch (Exception ex)
            {
            }

        }

    }

    //End of Added by Divya J on 28 August 2025 for Pointwest customisation

    public static class XlsxEmpHeaderNameConst
    {
        public const string EmployeeName = "Employee Name";
        public const string User = "User";
        public const string EmployeeCode = "Employee Code";
        public const string Gender = "Gender";
        public const string Email = "Email";
        public const string Birthate = "Birth Date";
        public const string Role = "Role";
        public const string ReportingTo = "Reporting To";
        public const string JoiningDate = "Joining Date";
        public const string BusinessGroup = "Business Group";
        public const string OrganizationUnit = "Organization Unit";
        public const string Designation = "Designation";
        public const string Department = "Department";
        public const string EmployeeType = "Employee Type";
        public const string CostToCompany = "Cost To Company";
        public const string RatePerHour = "Rate Per Hour";
        public const string CostPerHour = "Cost Per Hour";
        public const string Deployable = "Deployable";
        public const string Currency = "Currency";

    }

    //Added by Aditya J. on 05-03-2026 
    // -----------------------------------------------------------------------
    // GDPR Item 54 - Model Classes for Field Visibility Configuration
    // -----------------------------------------------------------------------

    /// <summary>
    /// Represents a single row returned by usp_GDPR_EmpMaster_GetFieldConfig.
    /// Maps to tbl_GDPR_EmpMaster_FieldConfig.
    /// </summary>
    public class RM_GDPR_FieldConfig
    {
        public string   FieldName   { get; set; }
        public bool     IsVisible   { get; set; }
        public string   ModifiedBy  { get; set; }
        public string   ModifiedOn  { get; set; }
    }

    /// <summary>
    /// Request body for SaveGDPRFieldConfig API.
    /// Each bool property corresponds to one configurable PII field.
    /// True = show the field, False = hide the field.
    /// ModifiedBy = logged-in username passed from the frontend.
    /// </summary>
    public class RM_GDPR_FieldConfigSave
    {
        public bool     BirthDate       { get; set; }
        public bool     Email           { get; set; }
        public bool     Gender          { get; set; }
        public bool     EmployeeType    { get; set; }
        public bool     Messanger       { get; set; }   // matches DB FieldName spelling
        public bool     ExtensionNo     { get; set; }
        public bool     Address         { get; set; }
        public string   ModifiedBy      { get; set; }
    }

    // -----------------------------------------------------------------------
    // End of GDPR Item 54 Model Classes
    // -----------------------------------------------------------------------
    //End of Added by Aditya J. on 05-03-2026 
}