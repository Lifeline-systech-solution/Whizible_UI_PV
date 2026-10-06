using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models.PM;
using System.Net;
using System.Net.Http;
using System.Configuration;
using System.Text.RegularExpressions;
using Newtonsoft.Json;

using System.IO;
using System.Xml;
//Added By Dipali V On 25th Nov 2021 For File Upload
using System.Runtime.InteropServices;
// End of Added By Dipali V On 25th Nov 2021 For File Upload

namespace WhizibleAPI.Controllers
{

    public class PM_AddNewResourceController : ApiController
    {
        [HttpPost]
        [Authorize]
        //public PM_AddNewResource GetResourceData([FromBody]ResourceParameters resourceParameters)
        public object GetResourceData([FromBody]ResourceParameters resourceParameters)
        {
            PM_AddNewResource addNewResource = new PM_AddNewResource();
            try
            {

                //Display Header
                ProjectDates projectDates = new ProjectDates();
                projectDates.DateLabel = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_GetProjectDatesLabel " + resourceParameters.intProjectID + "", true, CommonController.connectionString), ""));
                addNewResource.ProjectDates = projectDates;

                //Display Role Counts
                addNewResource.countLists = new List<RoleCounts>();
                DataTable rolecountTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_tbl_Whizible2_AddRole_GetCountOfResources " + resourceParameters.intProjectID + ",'" + resourceParameters.StartDate + "'", true, CommonController.connectionString);
                foreach (DataRow rolecountRow in rolecountTable.Rows)
                {
                    RoleCounts roleCounts = new RoleCounts()
                    {
                        RoleID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(rolecountRow["RoleID"], "0")),
                        Role = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(rolecountRow["Role"], "0")),
                        RoleCount = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(rolecountRow["RoleCount"], "0")),
                        ProjectStartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(rolecountRow["ProjectStartDate"], "0")),
                        ProjectStartMonth = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(rolecountRow["ProjectStartMonth"], "0")),
                        TotalDays = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(rolecountRow["TotalDays"], "0"))
                    };
                    addNewResource.countLists.Add(roleCounts);
                }

                return addNewResource;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        [HttpPost]
        [Authorize]
        //public PM_AddNewResource GetResourceDetails([FromBody]ResourceParameters resourceParameters)
        public object GetResourceDetails([FromBody]ResourceParameters resourceParameters)
        {
            PM_AddNewResource addNewResource = new PM_AddNewResource();
            try
            {
                //Display Header
                addNewResource.headerLists = new List<HeaderRow>();
                DataTable headercountTable;
                if (Convert.ToInt32(resourceParameters.SelectedRoleID) == 0)
                {
                    headercountTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetMonthDatesForProject " + resourceParameters.intProjectID + ",'" + resourceParameters.StartDate + "',NULL", true, CommonController.connectionString);
                }
                else
                {
                    headercountTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetMonthDatesForProject " + resourceParameters.intProjectID + ",'" + resourceParameters.StartDate + "'," + resourceParameters.SelectedRoleID + "", true, CommonController.connectionString);
                }
                //DataTable headercountTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetMonthDatesForProject " + resourceParameters.intProjectID + ",'" + resourceParameters.StartDate + "'," + resourceParameters.SelectedRoleID + "", true, CommonController.connectionString);
                foreach (DataRow headercountRow in headercountTable.Rows)
                {
                    HeaderRow headerRow = new HeaderRow()
                    {
                        day = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(headercountRow["day"], "0")),
                        date = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(headercountRow["date"], "0")),
                        ResourceCount = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(headercountRow["ResourceCount"], "0")),
                        IsWorking = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(headercountRow["IsWorking"], "0"))
                    };
                    addNewResource.headerLists.Add(headerRow);
                }

                //Display Details grid
                addNewResource.ResourceDetailsLists = new List<ResourceDetails>();
                DataTable ResourceDetailsTable;
                if (resourceParameters.SelectedRoleID != 0)
                {
                    if (resourceParameters.QueryText != "")
                    {
                        ResourceDetailsTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetResourcesAvailableForProjectAssignment " + resourceParameters.intProjectID + ",'" + resourceParameters.StartDate + "',1,NULL," + resourceParameters.SelectedRoleID + ",'" + resourceParameters.QueryText + "'," + resourceParameters.PageNumber + "," + resourceParameters.PageSize + ",'" + resourceParameters.SearchText + "'", true, CommonController.connectionString);
                    }
                    else
                    {
                        ResourceDetailsTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetResourcesAvailableForProjectAssignment " + resourceParameters.intProjectID + ",'" + resourceParameters.StartDate + "',1,NULL," + resourceParameters.SelectedRoleID + ",NULL," + resourceParameters.PageNumber + "," + resourceParameters.PageSize + ",'" + resourceParameters.SearchText + "'", true, CommonController.connectionString);
                    }
                }
                else
                {
                    if (resourceParameters.QueryText == "")
                    {
                        ResourceDetailsTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetResourcesAvailableForProjectAssignment " + resourceParameters.intProjectID + ",'" + resourceParameters.StartDate + "',1,NULL,NULL,NULL," + resourceParameters.PageNumber + "," + resourceParameters.PageSize + ",'" + resourceParameters.SearchText + "'", true, CommonController.connectionString);
                    }
                    else
                    {
                        ResourceDetailsTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetResourcesAvailableForProjectAssignment " + resourceParameters.intProjectID + ",'" + resourceParameters.StartDate + "',1,NULL,NULL,'" + resourceParameters.QueryText + "'," + resourceParameters.PageNumber + "," + resourceParameters.PageSize + ",'" + resourceParameters.SearchText + "'", true, CommonController.connectionString);
                    }
                }
                foreach (DataRow ResourceDetailsRow in ResourceDetailsTable.Rows)
                {
                    ResourceDetails resourceDetails = new ResourceDetails()
                    {
                        EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ResourceDetailsRow["EmployeeID"], "0")),
                        EmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(ResourceDetailsRow["EmployeeName"], "0")),
                        RoleDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(ResourceDetailsRow["RoleDescription"], "0")),
                        TotalProjectAssigned = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ResourceDetailsRow["TotalProjectAssigned"], "0")),
                        AllocatedPercentage = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(ResourceDetailsRow["AllocatedPercentage"], "0")),
                        AvailablePercentage = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(ResourceDetailsRow["AvailablePercentage"], "0")),
                        MonthDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(ResourceDetailsRow["MonthDate"], "0")),
                        IsLast = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ResourceDetailsRow["IsLast"], "0")),
                        IsOverAllocated = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ResourceDetailsRow["IsOverAllocated"], "0")),
                        IsOverAvailable = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ResourceDetailsRow["IsOverAvailable"], "0")),
                    };
                    addNewResource.ResourceDetailsLists.Add(resourceDetails);
                }

                return addNewResource;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize]
        public object GetResourceDetailsCount([FromBody]ResourceParameters resourceParameters)
        {

            //Display Details grid
            try
            {
                DataTable ResourceDetailsTable;
                if (resourceParameters.SelectedRoleID != 0)
                {
                    if (resourceParameters.QueryText != "")
                    {
                        ResourceDetailsTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetResourcesAvailableForProjectAssignment_Count " + resourceParameters.intProjectID + ",'" + resourceParameters.StartDate + "',1,NULL," + resourceParameters.SelectedRoleID + ",'" + resourceParameters.QueryText + "'", true, CommonController.connectionString);
                    }
                    else
                    {
                        ResourceDetailsTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetResourcesAvailableForProjectAssignment_Count " + resourceParameters.intProjectID + ",'" + resourceParameters.StartDate + "',1,NULL," + resourceParameters.SelectedRoleID + ",NULL", true, CommonController.connectionString);
                    }
                }
                else
                {
                    if (resourceParameters.QueryText == "")
                    {
                        ResourceDetailsTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetResourcesAvailableForProjectAssignment_Count " + resourceParameters.intProjectID + ",'" + resourceParameters.StartDate + "',1,NULL,NULL,NULL", true, CommonController.connectionString);
                    }
                    else
                    {
                        ResourceDetailsTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetResourcesAvailableForProjectAssignment_Count " + resourceParameters.intProjectID + ",'" + resourceParameters.StartDate + "',1,NULL,NULL,'" + resourceParameters.QueryText + "'", true, CommonController.connectionString);
                    }
                }


                return ResourceDetailsTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }
        [HttpPost]
        [Authorize]
       // public PM_AddNewResource GetResourceProjects([FromBody]ResourceParameters resourceParameters)
        public object GetResourceProjects([FromBody]ResourceParameters resourceParameters)
        {
            try
            {
                PM_AddNewResource addNewResource = new PM_AddNewResource();
                addNewResource.ResourceProjectsLists = new List<ResourceProjects>();
                DataTable ResourceDetailsTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetResourcesAvailableForProjectAssignment " + resourceParameters.intProjectID + ",'" + resourceParameters.StartDate + "',2," + resourceParameters.intEmployeeID + ",NULL,'" + resourceParameters.QueryText + "'", true, CommonController.connectionString);
                foreach (DataRow ResourceDetailsRow in ResourceDetailsTable.Rows)
                {
                    ResourceProjects resourceDetails = new ResourceProjects()
                    {
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(ResourceDetailsRow["ProjectName"], "0")),
                        ResourcePercentage = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(ResourceDetailsRow["ResourcePercentage"], "0")),
                    };
                    addNewResource.ResourceProjectsLists.Add(resourceDetails);
                }

                return addNewResource;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        [HttpPost]
        [Authorize]
        //public List<MonthDates> GetMonthDates([FromBody]ResourceParameters resourceParameters)
        public object GetMonthDates([FromBody]ResourceParameters resourceParameters)
        {
            try
            {
                List<MonthDates> MonthDatesFilterList = new List<MonthDates>();

                DataTable MonthDatesFilterTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetPrevNextDates " + resourceParameters.intProjectID + ",'" + resourceParameters.StartDate + "'", true, CommonController.connectionString);
                foreach (DataRow MonthDatesFilterRow in MonthDatesFilterTable.Rows)
                {
                    MonthDates MonthDatesFilter = new MonthDates()
                    {
                        prevDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(MonthDatesFilterRow["prevDate"], "0")),
                        prevMonth = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(MonthDatesFilterRow["prevMonth"], "0")),
                        nextMonth = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(MonthDatesFilterRow["nextMonth"], "0")),
                        nextDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(MonthDatesFilterRow["nextDate"], ""))
                    };
                    MonthDatesFilterList.Add(MonthDatesFilter);
                }
                return MonthDatesFilterList;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //[HttpPost]
        //[Authorize]
        //public List<ReportingTo> GetReportingTo([FromBody]ResourceParameters resourceParameters)
        //{
        //    List<ReportingTo> ReportingToList = new List<ReportingTo>();

        //    DataTable ReportingToTable = CommonFunctions.Data.GetDataTable("usp_sel_tbl_PM_RowWiseExternalApprovers " + resourceParameters.intProjectID , true, CommonController.connectionString);
        //    foreach (DataRow ReportingToRow in ReportingToTable.Rows)
        //    {
        //        ReportingTo ReportingToFilter = new ReportingTo()
        //        {
        //            EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ReportingToRow["EmployeeID"], "0")),
        //            EmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(ReportingToRow["Employee Name"], "0"))
        //        };
        //        ReportingToList.Add(ReportingToFilter);
        //    }
        //    return ReportingToList;
        //}


        //[HttpPost]
        //[Authorize]
        //public string ValidateResourceAllocation([FromBody]ResourceParameters resourceParameters)
        //{
        //    string strSQL = "EXEC usp_Whizible2_validateResourceAllocationOnProject " + resourceParameters.SelectedProjectID + ",'" + resourceParameters.ExpectedStartDate + "','" + resourceParameters.ExpectedEndDate + "','" + resourceParameters.SelectedResources + "'," + resourceParameters.ResourcePercentage;
        //    string result;
        //    result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
        //    return result;
        //}

        //Added By Reshma Chavan on 22nd Oct 2020 For pagination Change
        [HttpPost]
        [Authorize]
        //public int GetTotaldaysInMonth ([FromBody]ResourceParameters resourceParameters)
        public object GetTotaldaysInMonth ([FromBody]ResourceParameters resourceParameters)
        {
            try
            {

                string strSQL = "EXEC usp_Whizible2_GetTotalDays_Months '" + resourceParameters.StartDate + "'";
                int result;
                result = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return result.ToString();
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //End of Added By Reshma Chavan on 22nd Oct 2020 For pagination Change


        [HttpPost]
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object AllocateResources([FromBody]ResourceParameters resourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_ins_BulkResourceAllocation " + resourceParameters.SelectedProjectID + ",NULL,NULL," + resourceParameters.SelectedRoleID + ",0,'" + resourceParameters.ExpectedStartDate + "','" + resourceParameters.ExpectedEndDate + "','" + resourceParameters.WorkHrs + "','" + resourceParameters.ResourceStatus + "'," + resourceParameters.IsResourceBillable + ",'" + resourceParameters.Responsibility.Replace("'", "''") + "'," + resourceParameters.ReportingTo + "," + resourceParameters.IschkIsDefaultApprover + ",'" + resourceParameters.SelectedResources + "'," + resourceParameters.ResourcePercentage;
                int result;
                result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        [Authorize]    
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
          public object RequestResource([FromBody]ResourceParameters resourceParameters)
        {
            try
            {
                //Added by Dipali V on 6th May 2026 for vendor management - Vendor selection in resource request creation
                string strSQL = "EXEC usp_Whizible2_Ins_tbl_PM_AddNewRequest " + resourceParameters.UserID + ",'" + resourceParameters.UserName + "'," + resourceParameters.SelectedProjectID + ",'" + resourceParameters.RequestDate + "'," + resourceParameters.SelectedRoleID + ",'" + resourceParameters.Type + "','" + resourceParameters.WorkHrs + "'," + resourceParameters.NoOfResource + "," + resourceParameters.ResourcePool + ",'" + resourceParameters.FromDate + "','" + resourceParameters.ToDate + "','" + resourceParameters.SpecialRequest.Replace("'", "''") + "'," + resourceParameters.Priority + ",'R'," + resourceParameters.Department + "," + resourceParameters.Location + "," + resourceParameters.TypeofRequirement + "," + resourceParameters.ReplacementEmployeeName + "," + resourceParameters.EngagementModel + "," + resourceParameters.BillablePosition + ",'" + resourceParameters.BillingStartDate + "'," + resourceParameters.SOWAvailable + ",'" + resourceParameters.NatureofRequest + "'," + resourceParameters.Vendor + ",'" + resourceParameters.UserName + "'";
                int result;
                result = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


         [HttpPost]
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
         public object SaveSkill([FromBody]ResourceParameters resourceParameters)
        {

            //if (resourceParameters.ProjectSkillAdd == "1")
            //{
            //    string strSQL = "EXEC usp_Whizible2_Ins_tbl_PM_ResourceRequestDetails " + resourceParameters.RequestID + "," + resourceParameters.SkillName + "," + resourceParameters.Month + "," + resourceParameters.Year + "," + resourceParameters.Rating + "," + resourceParameters.ProjectSkillAdd + "";
            //    int result;
            //    result = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

            //}

            try
            {

                string strSQL = "EXEC usp_Whizible2_Ins_tbl_PM_ResourceRequestDetails " + resourceParameters.RequestID + "," + resourceParameters.SkillName + "," + resourceParameters.Month + "," + resourceParameters.Year + "," + resourceParameters.Rating + "," + resourceParameters.ProjectSkillAdd + "," + resourceParameters.SelectedProjectID + ", " + resourceParameters.IsCoreCompetency + "";
                int result;
                result = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                //result = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "");
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        [Authorize]
        public object CheckSkillOnProjectNot([FromBody]ResourceParameters resourceParameters)
        {
            try
            {

                string strSQL = "EXEC usp_Whizible2_CheckSkillsHasOnProject '" + resourceParameters.SkillName + "'," + resourceParameters.SelectedProjectID + "";
                //int result;
                // result = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                //result = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "");
                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }




        string filename;
        [Authorize]
        [HttpPost]
        public object FileUplaod()
        {
            // string[] NewfileName = new string[5];
            HttpResponseMessage result = null;
            try
            {
                var httpRequest = HttpContext.Current.Request;
                var filesNames = new List<string>();
                // Check if files are available
                if (httpRequest.Files.Count > 0)
                {

                    var files = new List<string>();

                    // interate the files and save on the server
                    foreach (string file in httpRequest.Files)
                    {

                        var postedFile = httpRequest.Files[file];
                        // string strFileName = CommonFunctions.FileDirectory.GetUniqueFileName()+"."+postedFile.FileName.Remove(0,postedFile.FileName.IndexOf(".")-1);
                        string strFileName = CommonFunctions.FileDirectory.GetUniqueFileName();
                        filename = postedFile.FileName;
                        //sa = sa.Select(s => s.Replace("\"", "")).ToArray();
                        filename = filename.Replace(filename.Substring(0, filename.IndexOf(".") - 1), strFileName);
                        //File.Move(postedFile.FileName, strFileName);
                        //  var filePath = HttpContext.Current.Server.MapPath("~/" + postedFile.FileName);
                        var filePath = HttpContext.Current.Server.MapPath("~/" + filename);
                        filePath = filePath.Replace("WhizibleAPIService-Project", "ATTACHMENTS\\JDAttachments");
                        postedFile.SaveAs(filePath);
                        filesNames.Add(filename);
                        files.Add(filePath);

                    }


                    result = Request.CreateResponse(HttpStatusCode.Created, files);
                }
                else
                {


                    result = Request.CreateResponse(HttpStatusCode.BadRequest);
                }

                return filesNames;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [Authorize]
        [HttpPost]
        public object FileUplaodSaveDB([FromBody] object[] UploadFileParameter)
        {
            try
            {

                string strSQL = "";
                strSQL = "exec usp_INS_Tbl_Whizible_ResourceRequestAttachment " + Convert.ToInt32(UploadFileParameter[0].ToString()) + "," + Convert.ToInt32(UploadFileParameter[1].ToString()) + ",'" + UploadFileParameter[2].ToString() + "','" + UploadFileParameter[3].ToString() + "','" + UploadFileParameter[4].ToString() + "'";
                object result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return "Successfully uploaded file";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //[HttpPost]

        //[Authorize]
        //public DataTable CheckReqHasCoreCompentencyOrNot([FromBody] ResourceParameters resourceParameters)
        //{
        //    string strSQL = "EXEC usp_chk_tbl_PM_ResourceRequestDetails " + resourceParameters.RequestID + "";
        //    DataTable dt;
        //    dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

        //    return dt;
        //}

        [HttpPost]
        [Authorize]
        public object GetRequestSkillCombo([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "";
                if (ResourceParameters.RequestID.ToString() == "0")
                {
                     strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ProjectTools_ToolID " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + "NULL";
                }
                else {
                     strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ProjectTools_ToolID " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.RequestID));

                }
                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }




        //[HttpPost]
        //public DataTable GetRequestSkillDetails([FromBody] ResourcesParameter ResourceParameters)
        //{

        //    string strSQL = "EXEC usp_Whizible2_v_tbl_PM_ResourceRequestDetails " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.RequestID));

        //    DataTable dt;
        //    dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

        //    return dt;
        //}

        //Dipali V On 2nd Jan 2020 For Check D.Approver  Conditions
        [HttpPost]
        [Authorize]
        public object CheckDefaultApprover([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_CheckDefaultApprovertbl_PM_ProjectEmployeeRole " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.RoleID));

                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Dipali V On 2nd Jan 2020 For Check D.Approver  Conditions


        //Dipali V On 2nd Jan 2020 For Check Reporting to Conditions
        [HttpPost]
        [Authorize]
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
        //End of Dipali V On 2nd Jan 2020 For Check Reporting to Conditions

        //[HttpPost]
        //[Authorize]
        //public DataTable GetProjectOU([FromBody]int ProjectID)
        //{
        //    string strSQL;
        //    strSQL = "Exec usp_Whizible2_GetProjectOUWorkWours " + ProjectID;

        //    DataTable dt = new DataTable();
        //    dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

        //    return dt;
        //}

        //Added By Reshma on 7th Jan 2020 For IssueID-21380
        [Authorize]
        [HttpPost]
        public object GetDefaultApprover([FromBody]int ProjectID)
        {
            try
            {
                int strmsg;
                string strsql = "SELECT EmployeeID From tbl_PM_ProjectEmployeeRole WHERE ProjectID =" + ProjectID + " AND IsDefaultApprover = 1";
                strmsg = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strsql, true, CommonController.connectionString));
                return strmsg;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //End Added By Reshma on 7th Jan 2020 For IssueID-21380

        //Added By Rutuja D. 8 Jan 2020 For Project Is over Or not 
        [Authorize]
        [HttpPost]
        public object CheckProjectOver([FromBody]int ProjectID)
        {
            try
            {
                int strmsg;
                strmsg = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("Exec usp_sel_tbl_PM_Project_IsOver " + ProjectID + "", true, CommonController.connectionString));
                return strmsg;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize]
        [HttpPost]
        public object CheckResourcePoolMandatory()
        {
            try
            {
                int strmsg;
                strmsg = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_tbl_SEM_Settings_ResourcePoolMandatory ", true, CommonController.connectionString));
                return strmsg;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //End Added By Rutuja D. 8 Jan 2020 For Project Is over Or not 


        //Added By Chetan M. on 10th Jan 2020 For get count of resources of project
        [Authorize]
        [HttpPost]
        public object GetCountOfResources([FromBody]int ProjectID)
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


        //End of added by Chetan M on 10th Jan 2020
        //Added By Dipali V On 12th Nov 2022 For Sonata Customzation
        [Authorize]
        [HttpPost]
        public object ValidateNatureofRequest([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_ValidateNatureofRequest '" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.RillingStartDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.AddedDate)) + "'";

                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Dipali V On 12th Nov 2022 For Sonata Customzation


        string MimeType = "";
        //End of Commented and added by Chetan M on 5 May 2021 for Sonata Issue fixing
        bool fileUploadFlag;
        [Authorize]
        [HttpPost]
        public object GetFileType()
        {
            try
            {
                fileUploadFlag = true;
                return fileUploadFlag;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize]
        public object GetMaxUnits([FromBody] RequestParameters RequestParameters)
        {
            try
            {

                string strSQL;
                strSQL = "Exec usp_Whizible2_Get_MaxUnits_For_AllocationType '" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestType)) + "'," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize]
        public object ConvertDecimalToHourViceVersa([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_ConvertDecimalToHourViceVersa '"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.WorkHrs)) + "',"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Flag));
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        [HttpPost]
        [Authorize]
        public object GetProjectBalHrs([FromBody] RequestParameters RequestParameters)
        {

            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_PM_ProjectBalanceLCE " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + ",NULL,NULL";
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }


        }


        [HttpPost]
        [Authorize]
        public object GetLocationWorkingHours([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Location_WorkHours " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        [Authorize]
        public object GetresourceHrs()
        {
            try
            {

                string strSQL;
                strSQL = "Exec usp_Whizible2_sel_tbl_sem_settings_SettingValue ";
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        [HttpPost]
        [Authorize]
        public object SendEmail([FromBody] RequestParameters RequestParameters)
        {

            try
            {
                string Flag = "0";
            string strFromEmailID = "";
            string strToEmailID = "";
            string strCCToEmailID = "";
            string strSubject = "", strMessage = "";
            string intRequestID = HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestID));

            bool blnSendEmail, blnShowPopup;

            //Getting Email messages
            DataTable EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_EmailMessages 75", true, CommonController.connectionString);
            foreach (DataRow mailRow in EmailDataTable.Rows)
            {
                blnSendEmail = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["SendMail"], "0"));
                blnShowPopup = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["ShowPopup"], "0"));

                if (blnSendEmail == true)
                {
                    if (blnShowPopup == true)
                    {
                        Flag = "1";
                    }
                    else
                    {
                        EmailMessagesController.GetEmailMessage_75(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, intRequestID);
                        EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
                    }

                }
            }

            return Flag;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

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
           // public int SkillName { get; set; }
            public string SkillName { get; set; }
            
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



            //Added By Dipali V On 14th Nov 2022 For Sonata Customzation
            public int TypeofRequirement { get; set; }
            public int ReplacementEmployeeName { get; set; }
            public int Department { get; set; }
            public int Vendor { get; set; }
            public int Location { get; set; }
            public int EngagementModel { get; set; }
            public int BillablePosition { get; set; }
            public string BillingStartDate { get; set; }
            public int SOWAvailable { get; set; }
            public int IsCoreCompetency { get; set; }
            public string NatureofRequest { get; set; }
            //End of Added By Dipali V On 14th Nov 2022 For Sonata Customzation

        }
    }
}