using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Runtime.InteropServices;
using System.Web;
using System.Web.Http;
using System.Xml;
using WhizibleAPI.Models.Stakeholder;

namespace WhizibleAPI.Controllers
{
    /// <summary>
    /// By Vishal Mahajan for stakeholder
    /// </summary>
    public class PM_stakeholdersController : ApiController
    {

        #region[GetProjectContacts]
        /// <summary>
        /// Created Date    :   16 Aug 2019
        /// Purpose         :   Get Stakeholder Project Contacts
        /// <returns></returns> 
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        public object GetStakeholderProjectContacts([FromBody] StakeholdersProjectContactParameter objStakeholdersProjectContactParameter)
        {
            try
            {
                DataTable stakeholder_Table;
                List<PM_StakeholdersProjectContact> listStakeholdersProjectContact = new List<PM_StakeholdersProjectContact>();
                stakeholder_Table = CommonFunctions.Data.GetDataTable("Usp_Whizible2_sel_tbl_Stakeholders_ProjectContacts " + HttpUtility.UrlDecode(objStakeholdersProjectContactParameter.projectID.ToString()) + ",0, '"
                                                                + HttpUtility.UrlDecode(objStakeholdersProjectContactParameter.FilterQuery) + "'", true, CommonController.connectionString);
                foreach (DataRow drProjectTask in stakeholder_Table.Rows)
                {
                    PM_StakeholdersProjectContact RA = new PM_StakeholdersProjectContact()
                    {
                        ProjectContactID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drProjectTask["ProjectContactID"], "")),
                        Name = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["Name"], "")),
                        Designation = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["Designation"], "")),
                        ContactInfo = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["ContactInfo"], "")),
                        TypeOfContact = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["TypeOfContact"], "")),
                        ContactCategory = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["ContactCategory"], "")),
                        CategoryType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["CategoryType"], "")),
                        Status = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(drProjectTask["ActiveStatus"], "")),
                        //Added by Dipali V  on 13rd April 2020 for check InheritedClientID
                        InheritedClientID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["InheritedClientID"], "")),
                        //End of Added by Dipali V  on 13rd April 2020 for check InheritedClientID
                    };


                    listStakeholdersProjectContact.Add(RA);
                }

                ///=======================================================================================
                ///Calculate Count of Customer organization and other
                ///=======================================================================================
                int countofcustomers = (from c in listStakeholdersProjectContact
                                        select c).Where(g => g.CategoryType == "C").Count();
                int countofOrganization = (from c in listStakeholdersProjectContact
                                           select c).Where(g => g.CategoryType == "O").Count();
                int countofOther = (from c in listStakeholdersProjectContact
                                    select c).Where(g => g.CategoryType == "H").Count();

                listStakeholdersProjectContact.ForEach(m => m.CountofCustomers = countofcustomers);
                listStakeholdersProjectContact.ForEach(m => m.CountofOrganization = countofOrganization);
                listStakeholdersProjectContact.ForEach(m => m.CountofOthers = countofOther);

                return listStakeholdersProjectContact;

            }

            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }
        #endregion

        #region[GetProject]
        /// <summary>
        /// Created Date    :   29 July 2019
        /// Purpose         :   GetProject
        /// <returns></returns>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        public object GetProjectDropDown([FromBody] defaultFilterParameters parameters)
        {
            try
            {
                DataTable FillProjectDatatable;
                List<FillProjectParameters> listProjectName = new List<FillProjectParameters>();
                FillProjectDatatable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_AccessibleProjects_ForEmployee_Stakeholders "
                                                                                + HttpUtility.UrlDecode(parameters.UserID.ToString()) + ","
                                                                                     + HttpUtility.UrlDecode(parameters.ProjectID.ToString()) + "",
                                                                                     true, CommonController.connectionString);
                foreach (DataRow dr in FillProjectDatatable.Rows)
                {
                    FillProjectParameters CC = new FillProjectParameters()
                    {
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["ProjectID"], "")),
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["ProjectName"], "")),
                    };

                    listProjectName.Add(CC);
                }
                return listProjectName;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[SaveStakeholderProjectContacts]
        /// <summary>
        /// Created Date    :   18 July 2019
        /// Created By      :   
        /// Purpose         :   Save Stakeholder Project Contacts
        /// </summary>
        /// <param name="taskParameters"></param>
        /// <returns></returns>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveStakeholderProjectContacts([FromBody] StakeholdersProjectContactSaveParam stakeholdersprojectcontact)
        {
            try
            {
                int intProjectContactID;
                intProjectContactID = Convert.ToInt32(Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                               (CommonFunctions.Data.GetDataScalar("usp_whizible2_ins_tbl_Stakeholders_ProjectContacts "
                                                                                    + stakeholdersprojectcontact.ProjectContactID + ","
                                                                                    + stakeholdersprojectcontact.ContactCategoryID + ",'"
                                                                                    + stakeholdersprojectcontact.Name + "','"
                                                                                    + stakeholdersprojectcontact.Designation + "',"
                                                                                    + stakeholdersprojectcontact.TypeOfContactID + ",'"
                                                                                    + stakeholdersprojectcontact.ContactType + "',"
                                                                                    + stakeholdersprojectcontact.IsCorporateContact + ","
                                                                                    + stakeholdersprojectcontact.SiteID + ",'"
                                                                                    + stakeholdersprojectcontact.Address1 + "','"
                                                                                    + stakeholdersprojectcontact.Address2 + "','"
                                                                                    + stakeholdersprojectcontact.City + "','"
                                                                                    + stakeholdersprojectcontact.Zip + "','"
                                                                                    + stakeholdersprojectcontact.State + "',"
                                                                                    + stakeholdersprojectcontact.CountryID + ",'"
                                                                                    + stakeholdersprojectcontact.CorrespondenceAddress + "','"
                                                                                    + stakeholdersprojectcontact.Phone1 + "','"
                                                                                    + stakeholdersprojectcontact.Phone2 + "','"
                                                                                    + stakeholdersprojectcontact.Ext1 + "','"
                                                                                    + stakeholdersprojectcontact.Ext2 + "','"
                                                                                    + stakeholdersprojectcontact.Fax + "','"
                                                                                    + stakeholdersprojectcontact.Mobile + "','"
                                                                                    + stakeholdersprojectcontact.EmailID + "','"
                                                                                    + stakeholdersprojectcontact.URL + "',"
                                                                                    + stakeholdersprojectcontact.ActiveStatus + ","
                                                                                    + stakeholdersprojectcontact.ProjectID + ",'"
                                                                                    + stakeholdersprojectcontact.CreatedBy + "','"
                                                                                    + stakeholdersprojectcontact.ModifiedBy + "','"
                                                                                    + stakeholdersprojectcontact.EmployeeID + "',"
                                                                                    + stakeholdersprojectcontact.PrincipalContact + ",'"
                                                                                    + stakeholdersprojectcontact.OrganizationName + "','"
                                                                                    + stakeholdersprojectcontact.Notes + "',"
                                                                                    + stakeholdersprojectcontact.ClientId + "",
                                                                                    true, CommonController.connectionString
                                                                                    ),
                                                 "0")));

                return intProjectContactID;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region [SaveStakeholderProjectContactsForClient]
        /// <summary>
        /// By Vishal Mahajan 06-11-2019 
        /// </summary>
        /// <param name="stakeholdersprojectcontactforclient"></param>
        /// <returns></returns>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveStakeholderProjectContactsForClient([FromBody] StakeholdersProjectContactSaveParamForClient stakeholdersprojectcontactforclient)
        {
            try
            {
                int intProjectContactID;
                intProjectContactID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull
                                               (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_Stakeholders_ProjectContacts_InsertClientData 0,'"
                                                                                    + stakeholdersprojectcontactforclient.ClientIDs + "',"
                                                                                    + stakeholdersprojectcontactforclient.ProjectID + ",'"
                                                                                    + stakeholdersprojectcontactforclient.CreatedBy + "','"
                                                                                    + stakeholdersprojectcontactforclient.ModifiedBy + "'",
                                                                                    true, CommonController.connectionString
                                                                                    ),
                                                 "0"));
                return intProjectContactID;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region [GetClientsForSaveStakeholder]
        /// <summary>
        /// By Vishal Mahajan 06-11-2019
        /// </summary>
        /// <param name="parameters"></param>
        /// <returns></returns>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        public object GetClientsForSaveStakeholder([FromBody] defaultFilterParameters parameters)
        {
            try
            {
                DataTable StakeholdersContactCategoryTable;
                List<ClientResult> listContactCategory = new List<ClientResult>();
                StakeholdersContactCategoryTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_Client_For_AddStakeholder " + parameters.ProjectID, true, CommonController.connectionString);
                foreach (DataRow dr in StakeholdersContactCategoryTable.Rows)
                {
                    ClientResult CC = new ClientResult()
                    {
                        ClientId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["ClientId"], "")),
                        ClientName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["ClientName"], ""))
                    };
                    listContactCategory.Add(CC);
                }
                return listContactCategory;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        #endregion

        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public void DeleteStakeHolderProjectContacts([FromBody] DeleteStakeHolderParams parameter)
        {
            int result = 0;
            string strSQL = "";
            strSQL = "Exec usp_Whizible2_Del_tbl_PM_ProjectContacts " + parameter.ProjectContactID;
            result = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
        }




        #region[GetOrganizationNames]
        /// <summary>
        /// Created Date    :   18 July 2019
        /// Created By      :   
        /// Purpose         :   Get Organization Names
        /// </summary>
        /// <param name="taskParameters"></param>
        /// <returns></returns>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        public List<OrganizationResult> GetOrganizationNames([FromBody] defaultFilterParameters parameters)
        {
            DataTable StakeholdersContactCategoryTable;
            List<OrganizationResult> listContactCategory = new List<OrganizationResult>();
            StakeholdersContactCategoryTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_ProjectResources " + parameters.ProjectID + "," + parameters.EmployeeID, true, CommonController.connectionString);
            foreach (DataRow dr in StakeholdersContactCategoryTable.Rows)
            {
                OrganizationResult CC = new OrganizationResult()
                {
                    EmployeeId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["EmployeeId"], "")),
                    EmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["EmployeeName"], ""))
                };
                listContactCategory.Add(CC);
            }
            return listContactCategory;
        }
        #endregion

        #region[GetClients]
        /// <summary>
        /// Created Date    :   18 July 2019
        /// Created By      :   
        /// Purpose         :   Get Clients
        /// </summary>
        /// <param name="taskParameters"></param>
        /// <returns></returns>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        //public List<ClientResult> GetClients([FromBody] defaultFilterParameters parameters)
        public object GetClients([FromBody] defaultFilterParameters parameters)
        {
            try
            {
                DataTable StakeholdersContactCategoryTable;
                List<ClientResult> listContactCategory = new List<ClientResult>();
                StakeholdersContactCategoryTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_Client " + parameters.ProjectID, true, CommonController.connectionString);
                foreach (DataRow dr in StakeholdersContactCategoryTable.Rows)
                {
                    ClientResult CC = new ClientResult()
                    {
                        ClientId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["ClientId"], "")),
                        ClientName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["ClientName"], ""))
                    };
                    listContactCategory.Add(CC);
                }
                return listContactCategory;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }
        #endregion


        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        public object GetTypeOfContacts([FromBody] typeOfContactParameters parameters)
        {
            try
            {
                DataTable TypeOfContactResultTable;
                List<TypeOfContactResult> listTypeOfContact = new List<TypeOfContactResult>();
                TypeOfContactResultTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_TypeOfContact_ForGroups " + parameters.GroupID + "," + parameters.ProjectContactID + ",1", true, CommonController.connectionString);
                foreach (DataRow dr in TypeOfContactResultTable.Rows)
                {
                    TypeOfContactResult ObjTypeOfContactResult = new TypeOfContactResult()
                    {
                        TypeOfContactID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["TypeOfContactID"], "")),
                        TypeOfContact = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["TypeOfContact"], ""))
                    };
                    listTypeOfContact.Add(ObjTypeOfContactResult);
                }
                return listTypeOfContact;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        /// <summary>
        /// By Vishal Mahajan 16-11-2019 output is in C,O,H for other
        /// </summary>
        /// <param name="parameters"></param>
        /// <returns></returns>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        public object GetContactCategory([FromBody] typeOfContactParameters parameters)
        {
            try
            {
                string GetContactCategory = "";
                GetContactCategory = Convert.ToString(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Sel_TypeOfContact_ForGroups " + parameters.GroupID + "," + parameters.ProjectContactID + ",2", true, CommonController.connectionString));
                return GetContactCategory;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        #region[GetAdvanceFilterSelectFields]

        /// <summary>
        /// Created Date    :   18 July 2019
        /// Created By      :   
        /// Purpose         :   Get Advance Filter SelectFields
        /// </summary>
        /// <param name="taskParameters"></param>
        /// <returns></returns>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        public object GetAdvanceFilterSelectFields([FromBody] StakeholderFilterParameter parameters)
        {
            try
            {
                DataTable StakeholdersContactCategoryTable;
                List<AdvanceFilterSelectFiledResult> listContactCategory = new List<AdvanceFilterSelectFiledResult>();
                StakeholdersContactCategoryTable = CommonFunctions.Data.GetDataTable("usp_sel_tbl_UI_AdvanceFilters_ControlTypes " + parameters.TagID, true, CommonController.connectionString);
                foreach (DataRow dr in StakeholdersContactCategoryTable.Rows)
                {
                    AdvanceFilterSelectFiledResult CC = new AdvanceFilterSelectFiledResult()
                    {
                        ControlTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["ControlTypeID"], "")),
                        ControlName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["ControlName"], "")),
                        ControlCaption = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["ControlCaption"], ""))
                    };
                    listContactCategory.Add(CC);
                }
                return listContactCategory;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[GetAdvanceFilterCheckboxValues]
        /// <summary>
        /// Created Date    :   18 July 2019
        /// Created By      :   
        /// Purpose         :   Get Advance Filter Checkbox Values
        /// </summary>
        /// <param name="taskParameters"></param>
        /// <returns></returns>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        public object GetAdvanceFilterCheckboxValues([FromBody] StakeholderFilterParameter parameters)
        {
            try
            {
                DataTable StakeholdersContactCategoryTable;
                List<AdvanceFilterCheckboxResult> listContactCategory = new List<AdvanceFilterCheckboxResult>();
                StakeholdersContactCategoryTable = CommonFunctions.Data.GetDataTable("usp_sel_tbl_UI_AdvanceFilters_CheckboxValues", true, CommonController.connectionString);
                foreach (DataRow dr in StakeholdersContactCategoryTable.Rows)
                {
                    AdvanceFilterCheckboxResult CC = new AdvanceFilterCheckboxResult()
                    {
                        ActVal = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["ActVal"], "")),
                        ChkVal = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["ChkVal"], ""))
                    };
                    listContactCategory.Add(CC);
                }
                return listContactCategory;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }
        #endregion

        #region[GetAdvanceFilterOperators]
        /// <summary>
        /// Created Date    :   18 July 2019
        /// Created By      :   
        /// Purpose         :   Get AdvanceFilter Operators
        /// </summary>
        /// <param name="taskParameters"></param>
        /// <returns></returns>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        public object GetAdvanceFilterOperators([FromBody] StakeholderFilterParameter parameters)
        {
            try
            {
                DataTable StakeholdersContactCategoryTable;
                List<AdvanceFilterOperationResult> listContactCategory = new List<AdvanceFilterOperationResult>();
                StakeholdersContactCategoryTable = CommonFunctions.Data.GetDataTable("usp_sel_tbl_UI_AdvanceFilters_Operators", true, CommonController.connectionString);
                foreach (DataRow dr in StakeholdersContactCategoryTable.Rows)
                {
                    AdvanceFilterOperationResult CC = new AdvanceFilterOperationResult()
                    {
                        value = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["Filer_Operator"], ""))
                    };
                    listContactCategory.Add(CC);
                }
                return listContactCategory;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        #endregion

        #region[GetRoleAccess]
        /// <summary>
        /// Created Date    :   29 July 2019
        /// Purpose         :   GetRoleAccess
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public object GetRoleAccess([FromBody] RoleAccess roleAccess)
        {
            try
            {
                DataTable PM_wbs_cardTable;
                List<RoleAccess> listRoleAccess = new List<RoleAccess>();
                PM_wbs_cardTable = CommonFunctions.Data.GetDataTable("usp_Sel_RoleAccess " + roleAccess.RoleID + ",0," + roleAccess.TagID + " ", true, CommonController.connectionString);
                foreach (DataRow drProjectTask in PM_wbs_cardTable.Rows)
                {
                    RoleAccess RA = new RoleAccess()
                    {
                        AddRole = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["A"], "")),
                        EditRole = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["E"], "")),
                        DeleteRole = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["D"], "")),
                        ViewRole = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["V"], "")),
                    };

                    listRoleAccess.Add(RA);
                }
                return listRoleAccess;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        #endregion


        #region[ExportDocument]
        /// <summary>
        /// Created Date    :   18 July 2019
        /// Created By      :   
        /// Purpose         :   Get Clients
        /// </summary>
        /// <param name=""></param>
        /// <returns></returns>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        public object ExportDocument([FromBody] StakeholdersProjectContactExportParameter objStakeholdersProjectContactExportParameter)
        {
            try
            {
                string strSQL;
                string strFilePath;
                string m_strFileName;
                long m_lngReportID;
                int DateFormatID = 0;
                string CompanyName = "";
                string ReportFormat = HttpUtility.UrlDecode(objStakeholdersProjectContactExportParameter.ReportFormat);

                int lngDefaultLCID;
                int lngCurrentThreadUICultureID;
                lngDefaultLCID = 1033;
                lngCurrentThreadUICultureID = 1033;
                AdHocReports.Report.AdHocReport oRpt;
                strSQL = "Usp_Whizible2_Stakeholders_ProjectContactsReport " + HttpUtility.UrlDecode(objStakeholdersProjectContactExportParameter.projectID.ToString()) + ",0,'" + objStakeholdersProjectContactExportParameter.ReportFilterQuery + "'";
                IDataReader drCompInfo1 = CommonFunctions.Data.GetSQLDataReader(strSQL, CommonController.connectionString);
                if (drCompInfo1.Read() == false)
                {
                    return "";
                }
                m_lngReportID = 22283;
                CommonEngines.HashTables.Culture.ConnectionString = CommonController.connectionString;
                CommonEngines.HashTables.Culture.FillCultureHashTable();
                // The reports are created in the "Reports" folder
                strFilePath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../Reports/"));
                // get a unique file name
                m_strFileName = CommonFunctions.FileDirectory.GetUniqueFileName().Trim();
                // add extn to file name based on format requested
                switch (ReportFormat)
                {
                    case "PDF": m_strFileName += ".pdf"; break;
                    case "HTML": m_strFileName += ".htm"; break;
                    case "RTF": m_strFileName += ".rtf"; break;
                    case "EXCEL": m_strFileName += ".xls"; break;
                    case "CSV": m_strFileName += ".csv"; break;
                    case "TEXT": m_strFileName += ".txt"; break;
                    case "XML": m_strFileName += ".xml"; break;
                    default: m_strFileName += ".pdf"; break;
                }
                IDataReader drCompInfo = CommonFunctions.Data.GetSQLDataReader("usp_SEL_Tbl_PM_CompanyInformation", CommonController.connectionString);
                while (drCompInfo.Read())
                {
                    CompanyName = CommonFunctions.Data.CheckIsDBNull(drCompInfo["CompanyName"], "").ToString();
                    DateFormatID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drCompInfo["DateFormatID"], "0"));
                }

                // create object of Adhoc reports
                oRpt = new AdHocReports.Report.AdHocReport(m_lngReportID, strSQL, CommonController.connectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../ATTACHMENTS/Log/")));

                oRpt.UseMSSQL = true;
                oRpt.DefaultLCID = lngDefaultLCID;
                oRpt.LCID = lngCurrentThreadUICultureID;
                oRpt.UseHashTables = true;
                oRpt.DateFormat = DateFormatID;
                oRpt.CompanyName = CompanyName;
                oRpt.GraphImageGenerationAbsolutePath = HttpContext.Current.Server.MapPath("../../../Images/");

                //' generate the report in requested format
                AdHocReports.HashTables.CreateHashTables.ConnectionString = CommonController.connectionString;
                switch (ReportFormat)
                {
                    case "PDF": oRpt.GenerateReport(AdHocReports.Format.PDF); break;
                    case "HTML": oRpt.GenerateReport(AdHocReports.Format.HTML); break;
                    case "RTF": oRpt.GenerateReport(AdHocReports.Format.RTF); break;
                    case "EXCEL": oRpt.GenerateReport(AdHocReports.Format.EXCEL); break;
                    case "CSV": oRpt.GenerateReport(AdHocReports.Format.CSV); break;
                    case "TEXT": oRpt.GenerateReport(AdHocReports.Format.TEXT); break;
                    case "XML": oRpt.GenerateReport(AdHocReports.Format.XML); break;
                    default: oRpt.GenerateReport(AdHocReports.Format.PDF); break;
                }

                oRpt = null;
                return m_strFileName;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[GetAttachments]
        /// <summary>
        /// Created Date    :   18 July 2019
        /// Created By      :   
        /// Purpose         :   Get Clients
        /// </summary>
        /// <param name="taskParameters"></param>
        /// <returns></returns>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        public object GetAttachments([FromBody] StakeholdersAttachment objstakeholdersAttachment)
        {
            try
            {
                DataTable StakeholdersAttachmentTable;
                List<StakeholdersAttachment> listStakeholdersAttachment = new List<StakeholdersAttachment>();
                StakeholdersAttachmentTable = CommonFunctions.Data.GetDataTable("Usp_Whizible2_Sel_tbl_PM_ProjectStakeholders_Attachments " + objstakeholdersAttachment.ProjectID + "," + objstakeholdersAttachment.ProjectContactID, true, CommonController.connectionString);
                foreach (DataRow dr in StakeholdersAttachmentTable.Rows)
                {
                    var fileName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["SystemFileName"], ""));
                    string fileSize = "";
                    var filePath = HttpContext.Current.Server.MapPath("~/" + fileName);
                    filePath = filePath.Replace("WhizibleAPIService", @"ATTACHMENTS\StakeholderDocuments");
                    if (File.Exists(filePath))
                    {
                        string[] sizes = { "B", "KB", "MB", "GB", "TB" };
                        double len = new FileInfo(filePath).Length;
                        int order = 0;
                        while (len >= 1024 && order < sizes.Length - 1)
                        {
                            order++;
                            len = len / 1024;
                        }

                        // Adjust the format string to your preferences. For example "{0:0.#}{1}" would
                        // show a single decimal place, and no space.
                        string result = String.Format("{0:0.##} {1}", len, sizes[order]);
                        fileSize = result;
                    }

                    StakeholdersAttachment SA = new StakeholdersAttachment()
                    {
                        AttachmentID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["AttachmentID"], "")),
                        OrignalFileName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["OrignalFileName"], "")),
                        Description = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["Description"], "")),
                        AttachedBy = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["AttachedBy"], "")),
                        DateAttached = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["DateAttached"], "")),
                        FileSize = Convert.ToString(fileSize)
                    };
                    listStakeholdersAttachment.Add(SA);
                }
                return listStakeholdersAttachment;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion


        #region[SaveAttachment]
        /// <summary>
        /// Created Date    :   18 July 2019
        /// Created By      :   
        /// Purpose         :   Get Clients
        /// </summary>
        /// <param name=""></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public string SaveAttachment()
        {
            string msg = "";
            if (GetFileType())
            {
                var AttachedFileData = HttpContext.Current.Request["AttachedFileData"];
                var listAttachedDocuments = JsonConvert.DeserializeObject<List<AttachedFileData>>(AttachedFileData);
                for (int i = 0; i < listAttachedDocuments.Count; i++)
                {
                    var httpPostedFile = HttpContext.Current.Request.Files[i];
                    var LoginType = listAttachedDocuments[i].LoginType;
                    var projectid = listAttachedDocuments[i].ProjectID;
                    var ProjectContactID = listAttachedDocuments[i].ProjectContactID;
                    //var dateAttached = listAttachedDocuments[i].DateAttached;
                    var description = listAttachedDocuments[i].Description;
                    var AttachedBy = listAttachedDocuments[i].UserName;
                    string strFileName = CommonFunctions.FileDirectory.GetUniqueFileName();
                    var fileName = strFileName + System.IO.Path.GetExtension(httpPostedFile.FileName);
                    var filePath = HttpContext.Current.Server.MapPath("~/" + fileName);
                    var attachmentId = 0;
                    filePath = filePath.Replace("WhizibleAPIService", "ATTACHMENTS\\StakeholderDocuments");
                    httpPostedFile.SaveAs(filePath);

                    msg = Convert.ToString(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_ProjectContacts_Attachments "
                                                                                        + projectid + ","
                                                                                         + ProjectContactID + ",'"
                                                                                        + httpPostedFile.FileName + "','"
                                                                                        + fileName + "','"
                                                                                        + AttachedBy + "','"
                                                                                        + LoginType + "','"
                                                                                        + description + "', " +
                                                                                        attachmentId + " ",
                                                                                        true, CommonController.connectionString
                                                                                        ));
                }
            }
            else
            {
                msg = "Please upload valid files only";
            }
            return msg;

        }

        #endregion


        #region[DeleteStakeHolderAttachment]
        /// <summary>
        /// Created Date    :   18 July 2019
        /// Created By      :   
        /// Purpose         :   Get Clients
        /// </summary>
        /// <param name=""></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public void DeleteStakeHolderAttachment([FromBody] DeleteStakeHolderAttachment objStakeHolderAttachment)
        {
            int result = 0;
            string strSQL = "";
            strSQL = "Exec usp_Whizible2_Del_tbl_PM_ProjectContacts_Attachments " + objStakeHolderAttachment.AttachmentID;
            result = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
        }
        #endregion


        #region[GetStakeholders]
        /// <summary>
        /// Created Date    :   18 July 2019
        /// Created By      :   
        /// Purpose         :   Get Clients
        /// </summary>
        /// <param name="taskParameters"></param>
        /// <returns></returns>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        public object GetStakeholders([FromBody] Stakeholders objEditStakeholderDetails)
        {   
            try
            {
                DataTable EditStakeholders;
                List<Stakeholders> stakeholders = new List<Stakeholders>();
                EditStakeholders = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_Stakeholder " + HttpUtility.UrlDecode(objEditStakeholderDetails.ProjectContactID.ToString()), true, CommonController.connectionString);
                foreach (DataRow dr in EditStakeholders.Rows)
                {
                    Stakeholders SH = new Stakeholders()
                    {
                        ProjectContactID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["ProjectContactID"], "")),
                        ContactCategoryID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["ContactCategoryID"], "")),
                        Name = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["Name"], "")),
                        CustomerName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["CustomerName"], "")),
                        Designation = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["Designation"], "")),
                        TypeOfContactID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["TypeOfContactID"], "")),
                        ContactType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["ContactType"], "")),
                        IsCorporateContact = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["IsCorporateContact"], "")),
                        SiteID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["SiteID"], "")),
                        Address1 = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["Address1"], "")),
                        Address2 = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["Address2"], "")),
                        City = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["City"], "")),
                        Zip = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["Zip"], "")),
                        State = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["State"], "")),
                        CountryID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["CountryID"], "")),
                        CorrespondenceAddress = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["CorrespondenceAddress"], "")),
                        Phone1 = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["Phone1"], "")),
                        Phone2 = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["Phone2"], "")),
                        Ext1 = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["Ext1"], "")),
                        Ext2 = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["Ext2"], "")),
                        Fax = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["Fax"], "")),
                        Mobile = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["Mobile"], "")),
                        EmailID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["EmailID"], "")),
                        URL = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["URL"], "")),
                        PrincipalContact = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["PrincipalContact"], "")),
                        OrganizationName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["OrganizationName"], "")),
                        Notes = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["Notes"], "")),
                        ActiveStatus = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["ActiveStatus"], "")),
                        ClientId = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["ClientId"], "")),
                        EmployeeID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["EmployeeID"], "")),
                        //Added by Dipali V  on 13rd April 2020 for check InheritedClientID
                        InheritedClientID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["InheritedClientID"], "")),
                        //End of Added by Dipali V  on 13rd April 2020 for check InheritedClientID
                    };
                    stakeholders.Add(SH);
                }
                return stakeholders;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region [GetFileType]
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public bool GetFileType()
        {
            bool fileUploadFlag = false;
            string MimeType = "";
            string strFileName = CommonFunctions.FileDirectory.GetUniqueFileName();
            if (HttpContext.Current.Request.Files.AllKeys.Any())
            {
                for (int filecount = 0; filecount < HttpContext.Current.Request.Files.Count; filecount++)
                {

                   // Stream xmlStream = System.Web.HttpContext.Current.Request.Files[filecount].InputStream;
                   // Stream txtStream = System.Web.HttpContext.Current.Request.Files[filecount].InputStream;
                   // string filePath = System.Web.HttpContext.Current.Request.Files[filecount].FileName;
                   // string filename = Path.GetFileName(filePath);
                   // string ext = Path.GetExtension(filename);
                  // ext = ext.Substring(1, ext.Length - 1);
                  //  string contenttype = String.Empty;
                  //  Stream checkStream = System.Web.HttpContext.Current.Request.Files[filecount].InputStream;
                  //  BinaryReader chkBinary = new BinaryReader(checkStream);
                  //  Byte[] chkbytes = chkBinary.ReadBytes(0x10);
                  
                    //Comment and Added by Riddhesh on 25/1/2023
                    string strListofTypes = ConfigurationManager.AppSettings["FileContentType"];
                    string fileName = HttpContext.Current.Request.Files[filecount].FileName;
                    string fileName1= Utilities.Security.SecurityBuilder.CheckUserInput(fileName, 2, true, true, true,true);
                    string ValidateFileName = ConfigurationManager.AppSettings["ValidateFileName"];
                    string[] CharList;
                    CharList = ValidateFileName.Split(',');
                    for (int i = 0; i <= CharList.Length - 1; i++)
                    {
                        if (fileName.Contains(CharList[i].ToString()))
                        {
                            fileName1 = fileName.Replace(CharList[i].ToString(), "");
                        }
                    }
                    int IsFileValid = 1;
                    string[] extensionList;
                    extensionList = fileName.Split('.');
                    if (extensionList.Length > 2)
                    {
                        IsFileValid = 0;
                    }
                    if (fileName == fileName1 && IsFileValid == 1)
                    {
                        string ContentType = String.Empty;
                        byte[] buffer = new byte[257];

                        //string MimeType = "";
                        HttpPostedFile file = System.Web.HttpContext.Current.Request.Files[filecount];
                        //var strFileType = "";
                        var strFileType = getMimeFromFile(HttpContext.Current.Request.Files[filecount]);
                        file.InputStream.Read(buffer, 0, 256);
                        file.InputStream.Position = 0;
                        string magicNumber = BitConverter.ToString(buffer);
                        magicNumber = magicNumber.Replace("-", " ");
                        XmlDocument xmlDoc = new XmlDocument();
                        string xmlPath = CommonFunctions.FileDirectory.CleanPath(System.IO.Directory.GetParent(System.IO.Directory.GetParent(System.AppDomain.CurrentDomain.BaseDirectory).FullName).FullName);
                        xmlDoc.Load(xmlPath + "MIMEType.xml");
                        XmlNodeList nodes = xmlDoc.DocumentElement.SelectNodes("/MIMETYPE/MIME");
                        string xMagicNumber = "";
                        string xContentType = "";
                        string extfromContentType = "";

                        
                        //string fileNameExtention = HttpContext.Current.Request.Files[filecount].FileName;
                        //string ext1 = Path.GetExtension(fileNameExtention);
                        //int count = ext1.Split('.').Length - 1;
                        //int count2 = fileNameExtention.Split('.').Length - 1;
                        //if (count > 1)
                        //{
                        //    MimeType = "";
                        //}
                        //if (count == 1 && count2 == 1)
                        //{
                            foreach (XmlNode node in nodes)
                            {
                                xContentType = node.SelectSingleNode("ContentType").InnerText;
                                if (strFileType == xContentType)
                                {
                                    fileName = HttpContext.Current.Request.Files[filecount].FileName;
                                    string ext = Path.GetExtension(fileName);
                                    ext = ext.Substring(1, ext.Length - 1).ToLower();
                                    extfromContentType = node.SelectSingleNode("Extension").InnerText.ToLower();
                                    if (extfromContentType.IndexOf(ext) > -1)
                                    {
                                        MimeType = strFileType;
                                        break;
                                    }
                                }
                            }
                        //}
                        // End of comment by Riddhesh on 25-01-2023
                    }
                    else
                    {
                        MimeType = "";
                    }

                    if (MimeType == "" || MimeType == null)
                    {
                        MimeType = "unknown/unknowns";
                        fileUploadFlag = false;
                    }
                    if (strListofTypes.IndexOf(MimeType) > -1)
                    {
                        fileUploadFlag = true;
                    }
                }

            }

            return fileUploadFlag;
        }

        [DllImport("urlmon.dll", CharSet = CharSet.Unicode, ExactSpelling = true, SetLastError = false)]
        static extern int FindMimeFromData(IntPtr pBC, [MarshalAs(UnmanagedType.LPWStr)] string pwzUrl, [MarshalAs(UnmanagedType.LPArray, ArraySubType = UnmanagedType.I1, SizeParamIndex = 3)] byte[] pBuffer, int cbSize, [MarshalAs(UnmanagedType.LPWStr)] string pwzMimeProposed, int dwMimeFlags, out IntPtr ppwzMimeOut, int dwReserved);

        [System.Security.SecuritySafeCritical()]
        public static string getMimeFromFile(HttpPostedFile file)
        {
            IntPtr mimeout; int MaxContent = (int)file.ContentLength;
            if (MaxContent > 200)
                MaxContent = 200;
            byte[] buf = new byte[MaxContent];
            file.InputStream.Read(buf, 0, MaxContent);
            int result = FindMimeFromData(IntPtr.Zero, file.FileName, buf, MaxContent, null, 0, out mimeout, 0);
            if (result != 0)
            {
                Marshal.FreeCoTaskMem(mimeout); return "";
            }
            string mime = Marshal.PtrToStringUni(mimeout);
            Marshal.FreeCoTaskMem(mimeout); return mime.ToLower();
        }

        //End of Added By Dipali V On 31st Oct 2022 For Check File Content Type
        #endregion

        #region[StakeholderEmployeeDetails]
        /// <summary>
        /// Created Date    :   18 July 2019
        /// Created By      :   
        /// Purpose         :   Get Clients
        /// </summary>
        /// <param name=""></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public object StakeholderEmpDetails([FromBody] StakeholderEmployeeDetails objEditEmployeeDetails)
        {
            try
            {
                DataTable EditStakeholders;
                List<StakeholderEmployeeDetails> stakeholdersEmpDetails = new List<StakeholderEmployeeDetails>();
                EditStakeholders = CommonFunctions.Data.GetDataTable("Usp_Whizible2_Sel_Stakeholders_ResourceDetails " + HttpUtility.UrlDecode(objEditEmployeeDetails.EmployeeID.ToString()), true, CommonController.connectionString);
                foreach (DataRow dr in EditStakeholders.Rows)
                {
                    StakeholderEmployeeDetails SE = new StakeholderEmployeeDetails()
                    {
                        DesignationName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["DesignationName"], "")),
                        Phone = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["Phone"], "")),
                        CurrentPhone = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["CurrentPhone"], "")),
                        ExtensionNo = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["ExtensionNo"], "")),
                        MobileNumber = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["MobileNumber"], "")),
                        EmailID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["EmailID"], "")),
                        Address = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["Address"], "")),
                        CurrentAddress = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["CurrentAddress"], "")),
                        City = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["City"], "")),
                        State = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["State"], "")),
                        PinCode = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["PinCode"], "")),
                        Country = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["Country"], "")),

                    };
                    stakeholdersEmpDetails.Add(SE);
                }
                return stakeholdersEmpDetails;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[SaveStakeholderProjectContacts]
        /// <summary>
        /// Created Date    :   18 July 2019
        /// Created By      :   
        /// Purpose         :   Save Stakeholder Project Contacts
        /// </summary>
        /// <param name="taskParameters"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveStakeholderComment([FromBody] StakeholdersCommentSaveParam stakeholdersComment)
        {
            try
            {
                int intProjectContactID;
                intProjectContactID = Convert.ToInt32(Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                               (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_Whizible2_Stakeholder_Conversation "
                                                                                    + stakeholdersComment.ProjectContactID + ","
                                                                                    + stakeholdersComment.ParentConversationID + ",'"
                                                                                    + stakeholdersComment.Description + "' , '"
                                                                                    + stakeholdersComment.UserName + "' , "
                                                                                    + stakeholdersComment.postedID + " , 0 ",
                                                                                    true, CommonController.connectionString
                                                                                    ),
                                                 "0")
                                                 )
                                                 );
                return intProjectContactID;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        #endregion

        #region [Check duplicate stakeholder]
        /// <summary>
        /// Created Date    :   19 Oct 2019
        /// Created By      :   Vishal Mahajan
        /// Purpose         :   check duplicate stakeholder name
        /// </summary>
        /// <param name="ObjDuplicateStakeHolderName"></param>
        /// <returns></returns>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        public object IsDuplicateStakeholderName([FromBody] DuplicateStakeHolderName stakeholdersprojectcontact)
        {
            try
            {
                bool boolIsDuplicateStakeholderName = false;
                boolIsDuplicateStakeholderName = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull
                                               (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Stakeholder_NameDuplicate "
                                                                                    + stakeholdersprojectcontact.ProjectContactID + ","
                                                                                    + stakeholdersprojectcontact.ProjectID + ","
                                                                                    + stakeholdersprojectcontact.EmployeeID + ",'"
                                                                                    + stakeholdersprojectcontact.Name + "'"
                                                                                    , true, CommonController.connectionString
                                                                                    ),
                                                 "0"));
                return boolIsDuplicateStakeholderName;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region [Check principle contact is already existaccording to contact type]
        /// <summary>
        /// By Vishal Mahajan 11-11-2019
        /// </summary>
        /// <param name="ObjCheckprinciplecontactparam"></param>
        /// <returns></returns>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        public object IsCheckPrincipleContact([FromBody] CheckPrincipleContactParam ObjCheckprinciplecontactparam)
        {
            try
            {
                bool boolIsCheckPrincipleContact = false;
                boolIsCheckPrincipleContact = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull
                                               (CommonFunctions.Data.GetDataScalar("usp_Whizible2_PM_Stakeholder_CheckPrincipleContact "
                                                                                    + ObjCheckprinciplecontactparam.ProjectContactID + ","
                                                                                    + ObjCheckprinciplecontactparam.ProjectID + ","
                                                                                    + ObjCheckprinciplecontactparam.TypeOfContactID
                                                                                    , true, CommonController.connectionString
                                                                                    ),
                                                 "0")) == 0 ? false : true;
                return boolIsCheckPrincipleContact;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region [IsExternalContactType]
        /// <summary>
        /// By Vishal M 12-11-2019
        /// </summary>
        /// <param name="ObjCheckprinciplecontactparam"></param>
        /// <returns></returns>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        public object IsExternalContactType([FromBody] CheckPrincipleContactParam ObjCheckprinciplecontactparam)
        {
            try
            {
                bool boolIsExternalContactType = false;
                boolIsExternalContactType = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull
                                               (CommonFunctions.Data.GetDataScalar("usp_Whizible2_PM_Stakeholder_CheckExternalContactType "
                                                                                    + ObjCheckprinciplecontactparam.TypeOfContactID
                                                                                    , true, CommonController.connectionString
                                                                                    ),
                                                 "0")) == 0 ? false : true;
                return boolIsExternalContactType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region [IsCustomerGroupAvailable]
        /// <summary>
        /// By Vishal Mahajan 14-11-2019
        /// </summary>
        /// <param name="ObjCheckCustomerGroupAvailable"></param>
        /// <returns></returns>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        public object IsCustomerGroupAvailable([FromBody] CheckPrincipleContactParam ObjCheckCustomerGroupAvailable)
        {
            try
            {
                bool boolCustomerGroupAvailable = false;
                boolCustomerGroupAvailable = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull
                                               (CommonFunctions.Data.GetDataScalar("usp_Whizible2_PM_Stakeholder_CheckIsCustomerGroupAvailable "
                                                                                    + ObjCheckCustomerGroupAvailable.ProjectID
                                                                                    , true, CommonController.connectionString
                                                                                    ),
                                                 "0")) == 0 ? false : true;
                return boolCustomerGroupAvailable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        #endregion

        #region[GetCustomerNameOfStakeholder]
        /// <summary>
        /// By Vishal Mahajan
        /// </summary>
        /// <param name="stakeholdersprojectcontact"></param>
        /// <returns></returns>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        public object GetCustomerNameOfStakeholder([FromBody] OrganizationStakeHolderName stakeholdersprojectcontact)
        {
            try
            {
                string CustomerName = "";
                DataTable dtCustomerStakeHolderName = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_CustomerInformation_New "
                                                                                    + stakeholdersprojectcontact.ProjectID
                                                                                    , true, CommonController.connectionString
                                                                                    );
                foreach (DataRow dr in dtCustomerStakeHolderName.Rows)
                {
                    CustomerName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["CustomerName"], ""));
                    break;
                }
                return CustomerName;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[StakeholderEmployeeOrCustomerDetails]
        /// <summary>
        /// Created Date    :   24 Oct 2019
        /// Created By      :   Vishal Mahajan
        /// Purpose         :   Get Clients and employee details
        /// </summary>
        /// <param name=""></param>
        /// <returns></returns>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        public object StakeholderEmployeeOrCustomerDetails([FromBody] StakeholderEmployeeOrCustomerDetails objEditEmployeeDetails)
        {
            try
            {
                DataTable EditStakeholders;
                List<StakeholderEmployeeOrCustomerDetails> stakeholdersEmpDetails = new List<StakeholderEmployeeOrCustomerDetails>();
                EditStakeholders = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Stakeholders_EmployeeOrCustomer_Details " + HttpUtility.UrlDecode(objEditEmployeeDetails.EmployeeID.ToString()) + ","
                                                                                                                                  + HttpUtility.UrlDecode(objEditEmployeeDetails.IsEmployeeID.ToString()) + ","
                                                                                                                                  + HttpUtility.UrlDecode(objEditEmployeeDetails.ProjectID.ToString()), true, CommonController.connectionString);
                foreach (DataRow dr in EditStakeholders.Rows)
                {
                    StakeholderEmployeeOrCustomerDetails SE = new StakeholderEmployeeOrCustomerDetails()
                    {
                        DesignationName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["DesignationName"], "")),
                        Phone = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["Phone"], "")),
                        CurrentPhone = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["CurrentPhone"], "")),
                        ExtensionNo = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["ExtensionNo"], "")),
                        MobileNo = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["MobileNo"], "")),
                        Country = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["Country"], "")),
                        Fax = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["Fax"], "")),
                        EmailID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["EmailID"], "")),
                        Address = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["Address"], "")),
                        CurrentAddress = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["CurrentAddress"], "")),
                        City = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["City"], "")),
                        State = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["State"], "")),
                        PinCode = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["PinCode"], "")),
                    };
                    stakeholdersEmpDetails.Add(SE);
                }
                return stakeholdersEmpDetails;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region [get stakeholder risks]
        /// <summary>
        /// By Vishal Mahajan 25-10-2019
        /// </summary>
        /// <param name="objStakeholderRiskDetails"></param>
        /// <returns></returns>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        public object StakeholderRiskDetails([FromBody] StakeholderRiskDetails objStakeholderRiskDetails)
        {
            try
            {
                DataTable DtStakeholderRiskDetails;
                List<StakeholderRiskDetails> stakeholdersRiskDetails = new List<StakeholderRiskDetails>();
                DtStakeholderRiskDetails = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Stakeholders_Risk_Details " + HttpUtility.UrlDecode(objStakeholderRiskDetails.ProjectContactID.ToString()), true, CommonController.connectionString);
                foreach (DataRow dr in DtStakeholderRiskDetails.Rows)
                {
                    StakeholderRiskDetails StakeholderRiskDetails = new StakeholderRiskDetails()
                    {
                        RiskID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["RiskID"], "0")),
                        ProjectContactID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["ProjectContactID"], "0")),
                        RiskDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["RiskDescription"], "")),
                        RiskName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["RiskName"], "")),
                        RiskFrom = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(dr["RiskFrom"], "0")),
                    };
                    stakeholdersRiskDetails.Add(StakeholderRiskDetails);
                }
                return stakeholdersRiskDetails;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion


        #region [SaveStakeholderProjectContactsRisks]
        /// <summary>
        /// save stakeholder of risk details By Vishal Mahajan 04-11-2019
        /// </summary>
        /// <param name="objStakeholderRiskDetails"></param>
        /// <returns></returns>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveStakeholderProjectContactsRisks([FromBody] StakeholderRiskDetails objStakeholderRiskDetails)
        {
            try
            {
                int intProjectContactID;
                intProjectContactID = Convert.ToInt32(Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                               (CommonFunctions.Data.GetDataScalar("usp_whizible2_ins_tbl_Stakeholders_ProjectContacts_Risks "
                                                                                    + objStakeholderRiskDetails.RiskID + ","
                                                                                    + objStakeholderRiskDetails.ProjectContactID + ",'"
                                                                                    + objStakeholderRiskDetails.RiskName + "','"
                                                                                    + objStakeholderRiskDetails.RiskDescription + "',"
                                                                                    + objStakeholderRiskDetails.RiskFrom + ",'"
                                                                                    + objStakeholderRiskDetails.CreatedBy + "','"
                                                                                    + objStakeholderRiskDetails.ModifiedBy + "'",
                                                                                    true, CommonController.connectionString
                                                                                    ),
                                                 "0")
                                                 )
                                                 );


                return intProjectContactID;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region [DeleteStakeHolderProjectContactsRisk]
        /// <summary>
        /// By Vishal Mahajan 04-10-2019
        /// </summary>
        /// <param name="objStakeholderRiskDetails"></param>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public void DeleteStakeHolderProjectContactsRisk([FromBody] StakeholderRiskDetails objStakeholderRiskDetails)
        {
            int result = 0;
            string strSQL = "";
            strSQL = "Exec usp_Whizible2_Del_tbl_PM_ProjectContacts_Risks " + objStakeholderRiskDetails.RiskID;
            result = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
        }
        #endregion

        #region [GetFrequency list]
        /// <summary>
        /// By Vishal Mahajan 04-11-2019
        /// </summary>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public object StakeholderRequiredReportsFrequency()
        {
            try
            {
                DataTable DtStakeholderReportsFrequency;
                List<StakeholderFrequency> stakeholdersRiskDetails = new List<StakeholderFrequency>();
                DtStakeholderReportsFrequency = CommonFunctions.Data.GetDataTable("usp_Sel_Frequency ", true, CommonController.connectionString);
                foreach (DataRow dr in DtStakeholderReportsFrequency.Rows)
                {
                    StakeholderFrequency StakeholderReportsFrequency = new StakeholderFrequency()
                    {
                        Frequency = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["Frequency"], "")),
                    };
                    stakeholdersRiskDetails.Add(StakeholderReportsFrequency);
                }
                return stakeholdersRiskDetails;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion


        #region [Get Report Master List]
        /// <summary>
        /// By Vishal Mahajan 04-11-2019 get report tag master
        /// </summary>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public object StakeholderRequiredReportsTagMasters()
        {
            try
            {
                DataTable DtStakeholderReportsTagMasters;
                List<StakeholderReportTagMaster> stakeholdersReportsTagMasters = new List<StakeholderReportTagMaster>();
                DtStakeholderReportsTagMasters = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM__Stakeholders_Risks_ReportMater ", true, CommonController.connectionString);
                foreach (DataRow dr in DtStakeholderReportsTagMasters.Rows)
                {
                    StakeholderReportTagMaster StakeholderReportsTagMasters = new StakeholderReportTagMaster()
                    {
                        TagID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["TagID"], "0")),
                        ReportTitle = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["ReportTitle"], "")),
                    };
                    stakeholdersReportsTagMasters.Add(StakeholderReportsTagMasters);
                }
                return stakeholdersReportsTagMasters;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region [get stakeholder required report]
        /// <summary>
        /// By Vishal Mahajan 04-11-2019
        /// </summary>
        /// <param name="objStakeholderRequiredReports"></param>
        /// <returns></returns>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        public object StakeholderRequiredReports([FromBody] StakeholderRequiredReports objStakeholderRequiredReports)
        {
            try
            {
                DataTable DtStakeholderRequiredReports;
                List<StakeholderRequiredReports> stakeholdersRiskDetails = new List<StakeholderRequiredReports>();
                DtStakeholderRequiredReports = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_PM_Stakeholders_RequiredReports " + HttpUtility.UrlDecode(objStakeholderRequiredReports.ProjectContactID.ToString()), true, CommonController.connectionString);
                foreach (DataRow dr in DtStakeholderRequiredReports.Rows)
                {
                    StakeholderRequiredReports StakeholderRequiredReports = new StakeholderRequiredReports()
                    {
                        ReportID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["ReportID"], "0")),
                        ProjectContactID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["ProjectContactID"], "0")),
                        TagID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["TagID"], "0")),
                        ReportTitle = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["ReportTitle"], "")),
                        Frequency = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["Frequency"], "")),
                        ReportDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["ReportDescription"], "")),
                    };
                    stakeholdersRiskDetails.Add(StakeholderRequiredReports);
                }
                return stakeholdersRiskDetails;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region [Save stakeholder of required report]
        /// <summary>
        /// By Vishal M 04-11-2019
        /// </summary>
        /// <param name="objStakeholderRequiredReports"></param>
        /// <returns></returns>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveStakeholderProjectContactsRequiredReports([FromBody] StakeholderRequiredReports objStakeholderRequiredReports)
        {
            try
            {
                int intProjectContactID;
                intProjectContactID = Convert.ToInt32(Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                               (CommonFunctions.Data.GetDataScalar("usp_whizible2_ins_tbl_PM_Stakeholders_ProjectContacts_RequiredReports "
                                                                                    + objStakeholderRequiredReports.ReportID + ","
                                                                                    + objStakeholderRequiredReports.ProjectContactID + ","
                                                                                    + objStakeholderRequiredReports.TagID + ",'"
                                                                                    + objStakeholderRequiredReports.Frequency + "','"
                                                                                    + objStakeholderRequiredReports.ReportDescription + "','"
                                                                                    + objStakeholderRequiredReports.CreatedBy + "','"
                                                                                    + objStakeholderRequiredReports.ModifiedBy + "',"
                                                                                    + objStakeholderRequiredReports.IsInheritedClientID + ","
                                                                                    + objStakeholderRequiredReports.ProjectID,
                                                                                    true, CommonController.connectionString
                                                                                    ),
                                                 "0")
                                                 )
                                                 );


                return intProjectContactID;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region [Delete stakeholder of required report]
        /// <summary>
        /// By Vishal M 04-11-2019
        /// </summary>
        /// <param name="objStakeholderRequiredReports"></param>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public void DeleteStakeHolderProjectContactsRequiredReports([FromBody] StakeholderRequiredReports objStakeholderRequiredReports)
        {
            int result = 0;
            string strSQL = "";
            strSQL = "Exec usp_Whizible2_Del_tbl_PM_ProjectContacts_RequiredReports " + objStakeholderRequiredReports.ReportID;
            result = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
        }
        #endregion

        #region Filter code login created by Vishal M 22 Oct 2019

        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        public object CheckStakeholderDefaultFilter([FromBody] StakeholderFilterParameter StakeholderParameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_Whizible2_Filter_Query_GetDefaultFilter " + HttpUtility.UrlDecode(Convert.ToString(StakeholderParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(StakeholderParameters.TagID)) + ",'"
                                                                                    + HttpUtility.UrlDecode(StakeholderParameters.LoginType) + "' ," + HttpUtility.UrlDecode(Convert.ToString(StakeholderParameters.UserID));

                QueryList DefaultQuery = new QueryList();
                IDataReader DefaultQueryFilter;
                DefaultQueryFilter = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (DefaultQueryFilter.Read())
                {
                    DefaultQuery.FilterID = Convert.ToInt32(DefaultQueryFilter["FilterID"]);
                    DefaultQuery.FilterName = Convert.ToString(DefaultQueryFilter["FilterName"]);
                    DefaultQuery.QueryText = Convert.ToString(DefaultQueryFilter["QueryText"]);
                }
                return DefaultQuery;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        public object IsDuplicateStakeholderBasicFilter([FromBody] StakeholderFilterParameter StakeholderParameters)
        {
            try
            {
                bool boolIsDuplicateStakeholderName = false;
                boolIsDuplicateStakeholderName = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull
                                              (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Stakeholder_FilterNameDuplicate "
                                                                                  + HttpUtility.UrlDecode(Convert.ToString(StakeholderParameters.TagID)) + ","
                                                                                  + HttpUtility.UrlDecode(Convert.ToString(StakeholderParameters.ProjectID)) + ","
                                                                                  + HttpUtility.UrlDecode(Convert.ToString(StakeholderParameters.UserID)) + ",'"
                                                                                  + HttpUtility.UrlDecode(StakeholderParameters.FilterName) + "',"
                                                                                  + HttpUtility.UrlDecode(Convert.ToString(StakeholderParameters.FilterID))
                                                                                  , true, CommonController.connectionString
                                                                                  ),
                                                "0"));
                return boolIsDuplicateStakeholderName;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Save the basic filter
        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveStakeholderBasicFilter([FromBody] StakeholderFilterParameter StakeholderParameters)
        {
            try
            {
                string strSQL;

                if (StakeholderParameters.Flag == 1)
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(StakeholderParameters.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(StakeholderParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(StakeholderParameters.UserID)) + ",'" + HttpUtility.UrlDecode(StakeholderParameters.FilterName) + "','" + HttpUtility.UrlDecode(StakeholderParameters.LoginType) + "'," + "'" + HttpUtility.UrlDecode(StakeholderParameters.QueryText) + "'" + ",'" + HttpUtility.UrlDecode(StakeholderParameters.CreatedBy) + "'," + HttpUtility.UrlDecode(Convert.ToString(StakeholderParameters.Flag)) + " ," + HttpUtility.UrlDecode(Convert.ToString(StakeholderParameters.FilterID)) + "";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(StakeholderParameters.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(StakeholderParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(StakeholderParameters.UserID)) + ",'" + HttpUtility.UrlDecode(StakeholderParameters.FilterName) + "','" + HttpUtility.UrlDecode(StakeholderParameters.LoginType) + "'," + "'" + HttpUtility.UrlDecode(StakeholderParameters.QueryText) + "'" + ",'" + HttpUtility.UrlDecode(StakeholderParameters.CreatedBy) + "'";
                }
                //strSQL.Replace("/", "");

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //To get the list of filter for logged user.
        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        public object GetMyStakeholderFiltersList([FromBody] StakeholderFilterParameter StakeholderParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_sel_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(StakeholderParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(StakeholderParameters.TagID)) + ",'" + HttpUtility.UrlDecode(StakeholderParameters.LoginType) + "','" + HttpUtility.UrlDecode(Convert.ToString(StakeholderParameters.UserID)) + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Delete the filter
        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteStakeholderFilter([FromBody] int FilterID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_del_tbl_Whizible2_Filter_Query " + FilterID;

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Edit saved filter data.
        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        public object GetStakeholderWhereClauseOfFilter([FromBody] int FilterID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_tbl_Whizible2_Filter_Query_GetWhereClause " + FilterID;

                Object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SetStakeholderDefaultFilter([FromBody] StakeholderFilterParameter StakeholderParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Upd_tbl_Whizible2_Filter_Query_SetDefaultFilter " + HttpUtility.UrlDecode(Convert.ToString(StakeholderParameters.ProjectID)) + ",'" + StakeholderParameters.LoginType + "' ,"
                                                                                     + StakeholderParameters.UserID + "," + StakeholderParameters.TagID + "," + StakeholderParameters.FilterID;
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object RemoveStakeholderDefaultFilter([FromBody] StakeholderFilterParameter StakeholderParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Upd_tbl_Whizible2_Filter_Query_RemoveDefaultFilter " + HttpUtility.UrlDecode(Convert.ToString(StakeholderParameters.ProjectID)) + ",'" + StakeholderParameters.LoginType + "' ,"
                                                                                     + StakeholderParameters.UserID + "," + StakeholderParameters.TagID + "," + StakeholderParameters.FilterID;
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Edit saved filter data.
        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        public object EditStakeholderFilterData([FromBody] int FilterID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_sel_ByFilterID_tbl_Whizible2_Filter_Query " + FilterID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        public object GetWhereClauseFilter([FromBody] StakeholderFilterParameter StakeholderParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_tbl_Whizible2_Filter_Query_GetWhereClause " + HttpUtility.UrlDecode(Convert.ToString(StakeholderParameters.FilterID));
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion


        //Added By Usha Pandit On 04.11.2019 for discussion panel   
        //Get Discussion Details
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        public object GetDiscussions([FromBody] DiscussionsParameter Parameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec Usp_Whizible2_Sel_tbl_Whizible2_Stakeholder_DiscussionThreads " + HttpUtility.UrlDecode(Convert.ToString(Parameters.UniqueID));

                DataTable DiscussionsListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<GetDiscussions> DiscussionsLists = new List<GetDiscussions>();

                foreach (DataRow DiscussionsList in DiscussionsListTable.Rows)
                {
                    GetDiscussions DiscussionsListQuery = new GetDiscussions()
                    {
                        DiscussionID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(DiscussionsList["DiscussionID"], "0")),
                        UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(DiscussionsList["UniqueID"], "0")),
                        ParentID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(DiscussionsList["ParentID"], "0")),
                        LoginID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(DiscussionsList["LoginID"], "0")),
                        ReplyIndex = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(DiscussionsList["ReplyIndex"], "0")),
                        IsShowToCustomer = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(DiscussionsList["IsShowToCustomer"], "0")),
                        DiscussionThread = CommonFunctions.Data.CheckIsDBNull(DiscussionsList["DiscussionThread"], "").ToString(),
                        SubmittedBy = CommonFunctions.Data.CheckIsDBNull(DiscussionsList["SubmittedBy"], "").ToString(),
                        SubmittedDate = CommonFunctions.Data.CheckIsDBNull(DiscussionsList["SubmittedDate"], "").ToString(),
                        LoginType = CommonFunctions.Data.CheckIsDBNull(DiscussionsList["LoginType"], "").ToString(),
                        ReplyCount = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(DiscussionsList["ReplyCount"], "0")),
                        DiscussionLevel = CommonFunctions.Data.CheckIsDBNull(DiscussionsList["DiscussionLevel"], "").ToString(),
                    };
                    DiscussionsLists.Add(DiscussionsListQuery);
                }
                return DiscussionsLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Save Discussion Details

        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveDiscussion([FromBody] DiscussionsParameter Parameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec Usp_Whizible2_Ins_tbl_Whizible2_Stakeholder_DiscussionThreads " + HttpUtility.UrlDecode(Convert.ToString(Parameters.UniqueID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ParentID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.LoginID)) + ",'" + HttpUtility.UrlDecode(Parameters.DiscussionThread).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.SubmittedBy) + "','" + HttpUtility.UrlDecode(Parameters.LoginType) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.IsShowToCustomer)) + ",'" + HttpUtility.UrlDecode(Parameters.DiscussionLevel) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ReplyIndex)) + "";

                string Message;

                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //End Of Added By Usha Pandit On 04.11.2019 for discussion panel

        #region [Get token for download document]
        /// <summary>
        /// By Vishal Mahajan 05-11-2019
        /// </summary>
        /// <param name="Parameters"></param>
        /// <returns></returns>
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        [HttpPost]
        public object GetToken([FromBody] TokenParameter Parameters)
        {
            try
            {
                string pkToken = "";
                pkToken = CommonFunctions.Security.Token.GetToken(Parameters.TagID.ToString() + Parameters.DocumnetID.ToString() + Parameters.StakeHolderID.ToString() + Parameters.ProjectID.ToString());
                return pkToken;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        //Added By Rutuja D. on 23 Dec 2021 for Client Onchange Name is not display
        [HttpPost]
        //Added by imran on 25-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 25-08-2022
        public object GetClientContactPerson([FromBody] int client)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_tbl_pm_client_ClientName " + Convert.ToString(client);
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
            //End of Added By Rutuja D. on 23 Dec 2021 for Client Onchange Name is not display

    }

}
