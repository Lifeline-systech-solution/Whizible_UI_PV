using Microsoft.VisualBasic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models;
using System.Data;

using WhizibleAPI.Models.PM;




namespace WhizibleAPI.Controllers
{
    public class PM_ResourcesController : ApiController
    {
        ProjectResourceData projectData = new ProjectResourceData();

        //Get Old UI New UI added by imran 25-06-2021
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        public object GetResourceUIAllocation()
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_sel_UISetting";
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //End by imran 25-06-2021


        //Get  Accessible Project list for Login User
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetProjectID([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                
                string strSQL = "Exec usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.UserID)) + "";

                //Commented And Added By Usha Pandit On 08.07.2020 To show projects from Issue Base
                //if (ResourceParameters.ProjectID == 0)
                //{
                //    strSQL = strSQL + ", 0, 0, NULL,1, '" + HttpUtility.UrlDecode(ResourceParameters.LoginType) + "', 1, 0, 0, 0, NULL, NULL";
                //}
                //else
                //{
                //    strSQL = strSQL + ", 0, 0, NULL,1, '" + HttpUtility.UrlDecode(ResourceParameters.LoginType) + "', 1, 0, 0, 0, NULL, " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID));

                //}

                if (ResourceParameters.ProjectID == 0)
                {
                    strSQL = strSQL + ", 0, 0, NULL,0, '" + HttpUtility.UrlDecode(ResourceParameters.LoginType) + "', 1, 0, 0, 0, NULL, NULL";
                }
                else
                {
                    strSQL = strSQL + ", 0, 0, NULL,0, '" + HttpUtility.UrlDecode(ResourceParameters.LoginType) + "', 1, 0, 0, 0, NULL, " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID));
                }
                //End Of Added By Usha Pandit On 08.07.2020 To show projects from Issue Base

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Resources list for Project
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetResourcesList([FromBody] ResourcesParameter ResourceParameters)
        {           
            string strSQL = "";
            try
            {
                if (ResourceParameters.QueryText == "Null")
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_PM_ProjectEmployeeRole " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + ",Null," + ResourceParameters.PageNumber + "," + ResourceParameters.PageSize;
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_PM_ProjectEmployeeRole " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + "'" + HttpUtility.UrlDecode(ResourceParameters.QueryText) + "'," + ResourceParameters.PageNumber + "," + ResourceParameters.PageSize;
                }
                DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Resources count for Project
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetResourcesCount([FromBody] ResourcesParameter ResourceParameters)
        {

            string strSQL = "";
            try
            {
                if (ResourceParameters.QueryText == "Null")
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_PM_ProjectEmployeeRole_ResourceCount " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + ",Null";
                }
                else
                {

                    strSQL = "Exec usp_Whizible2_sel_tbl_PM_ProjectEmployeeRole_ResourceCount " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + "'" + HttpUtility.UrlDecode(ResourceParameters.QueryText) + "'";
                }


                DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Check is allow resource Allocation
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        public object GetResourcesTabAcess()
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_IsAllowResourceAllocation ";
                int IsAllowResourceAllocation = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "0"));
                return IsAllowResourceAllocation;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        
       //Get LINKS for Resources
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetResourcesLinks([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {

                string strSQL = "EXEC usp_Whizible2_Sel_ResourceActionLinks " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectEmployeeRoleID));

                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Check is Agile or not
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
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

        //Get the Start Date and End Date for Particular Sub Project
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetProjectStartDateEndDate([FromBody]int ProjectID)
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



        //Get Resource Tentative Date for Relieving and Joing date
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetResourceTentativeDateOfRelieving([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_ResourceTentativeDateOfRelieving " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectEmployeeRoleID));

                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added By Dipali V On 6th Feb 2021 For Re-Assign Resource
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetAllocation([FromBody] ResourcesParameter ResourceParameters)
        {
            string strSQL = "";
            try
            {
                strSQL = "Exec usp_Whizible2_sel_FreeHours_ChangeAllocation_New" +
        " '" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ExpectedStartDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ExpectedEndDate)) + "'," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID));
                int dt = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));


                //String[] spearator = { "&&" };
                //String[] NewResult = dt.ToString().Split(spearator, 2, StringSplitOptions.None);
                //return NewResult[0] + "||" + NewResult[1];
                strSQL = "Exec usp_Sel_ResAllocation_SettingValue ";
                int dtNew = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                strSQL = "Exec usp_Whizible2_Sel_FutureRequestCount " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectEmployeeRoleID)) + "";
                int FuturRequestCount = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                //return NewResult[0] + "||" + NewResult[1] + "," + dtNew.ToString();
                return dt.ToString() + "," + dtNew.ToString() + "," + FuturRequestCount.ToString();
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        


        //Added By Dipali V On 6th Feb 2021 For Re-Assign Resource
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object GetReAssignResource([FromBody] ResourcesParameter ResourceParameters)
        {
            string strSQL = "";
            try
            {
                strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ProjectEmployeeRole_New " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectRoleID)) + "," +
                    "" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ResourcePercentage)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ExpectedStartDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ExpectedEndDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.BudgetedHours)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.Responsibility)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ResourceStatus)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.CreatedBy)) + "', " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.IsResourceBillable)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ReportingTo)) + "";
                int dt = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                strSQL = " Usp_upd_ReassignedResource_CancelRequest " + ResourceParameters.EmployeeID.ToString() + "," + ResourceParameters.ProjectID.ToString();
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                string strFromEmailID = "";
                string strToEmailID = "";
                string strCCToEmailID = "";
                string strSubject = "";
                var strEmailMessage = "";
                var Flag = "";
                bool blnSendEmail, blnShowPopup;

                //Getting Email messages
                DataTable EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_EmailMessages 15", true, CommonController.connectionString);
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
                            Flag = "0";
                            EmailMessagesController.GetEmailMessage_15(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strEmailMessage, HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectRoleID)), HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)), Convert.ToString(ResourceParameters.UserID), HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)));
                            EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage);
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


        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetAvailableAllocation([FromBody] ResourcesParameter ResourceParameters)
        {
            string strSQL = "";
            try
            {
                strSQL = "Exec usp_Sel_tbl_PM_ProjectEmployeeRole_ResourcePer " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID));
                int dt = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //End of Added By Dipali V On 6th Feb 2021 For Re-Assign Resource

        //Get Resource End Date On Project
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetResourceEnddate([FromBody] ResourcesParameter ResourceParameters)
        {
            string strSQL = "";
            try
            {
                strSQL = "Exec usp_Whizible2_Sel_ResourceEndDateOnProject " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectEmployeeRoleID));
                int dt = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Get Resource Tentative Date for Relieving
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetResourceAllocationSettingValue([FromBody] ResourcesParameter ResourceParameters)
        {
            string strSQL = "";
            try
            {
                strSQL = "Exec usp_Whizible2_Sel_ResAllocation_SettingValue ";
                int dt = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "0"));
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Get Resource Tentative Date for Relieving
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetTotalPercentageallocation([FromBody] ResourcesParameter ResourceParameters)
        {
            string strSQL = "";
            try
            {
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ProjectEmployeeRole_ResourcePer " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID));
                int dt = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "0"));
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Get Resource Tentative Date for Relieving
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetProjectEmployeeID([FromBody] ResourcesParameter ResourceParameters)
        {
            string strSQL = "";
            try
            {
                IDataReader drGetDefaultApprover;
                ApproverList Approver = new ApproverList();
                strSQL = "SELECT EmployeeID From tbl_PM_ProjectEmployeeRole Where ProjectEmployeeRoleID = " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectEmployeeRoleID));
                int intEmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "0"));

                strSQL = "SELECT EmployeeID From tbl_PM_ProjectEmployeeRole WHERE ProjectID = " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + " AND IsDefaultApprover = 1 AND EmployeeID <> " + intEmployeeID;

                drGetDefaultApprover = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (drGetDefaultApprover.Read())
                {
                    Approver.intEmployeeID = Convert.ToInt32(drGetDefaultApprover["EmployeeID"]);

                }


                return Approver;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }




        //get min hours for da Entry
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        public object GetRestrictByMinHours_MinHoursForDAEntry()
        {
            string strSQL = "";
            try
            {
                strSQL = "Exec usp_Whizible2_Sel_RestrictByMinHours_MinHoursForDAEntry ";
                ResourceCompanyInformation Information = new ResourceCompanyInformation();
                IDataReader CmpInformation;
                CmpInformation = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (CmpInformation.Read())
                {
                    Information.RestrictByMinHours = Convert.ToBoolean(CmpInformation["RestrictByMinHours"]);
                    //Commented And Added By Usha Pandit On 18.06.2020 For getting exact value for MinHoursForDAEntry
                    //Information.MinHoursForDAEntry = float.Parse(Math.Round(Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(CmpInformation["MinHoursForDAEntry"], "0")), 2).ToString());
                    Information.MinHoursForDAEntry = CommonFunctions.Data.CheckIsDBNull(CmpInformation["MinHoursForDAEntry"], "0").ToString();
                    //End Of Added By UshaPandit On 18.06.2020 For getting exact value for MinHoursForDAEntry
                }
                return Information;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Get Working Days
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetWorkingDays([FromBody] ResourcesParameter ResourceParameters)
        {
            string strSQL = "";
            try
            {
                strSQL = "Exec usp_Whizible2_GetWorkingDays '" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ExpectedStartDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ExpectedEndDate)) + "'";


                int dt = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "0"));
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Get Role for Resources
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        public object GetRoleInEditMode()
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_Role_PopulateCombo ";

                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        

        //Get Role for Resources
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
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

        //Get Role for Resources
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetResourcesRateAndCost([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ProjectEmployeeRoleRateAndCost " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectEmployeeRoleID));

                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Resources data in Edit Mode
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetResourcesDataInEditMode([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_d_tbl_PM_ProjectEmployeeRole " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectEmployeeRoleID));

                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        // Added by Dipali V on 15th May 2026 - Purpose:-Return saved VendorID/VendorName for txtALVendor in edit mode.
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetProjectEmployeeRoleVendor([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ProjectEmployeeRole_Vendor " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectEmployeeRoleID));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }
        
        //Check is Agile or not
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetIsProductOwner([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_NG2_IsProductOwner_ProjectLevel " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectEmployeeRoleID));


                string dt = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }
        //Add new Milestone
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object InsertNewResource([FromBody] object[] objInsResource)
        {

            try
            {
                string strSQL1 = "Exec usp_Whizible2_NG2_chk_IsAgileProject " + HttpUtility.UrlDecode(Convert.ToString(objInsResource[0]));
                int IsAgile = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString));

                string strSQL;
                string result;

                strSQL = "EXEC usp_Whizible2_Ins_tbl_PM_ProjectEmployeeRole " + Convert.ToInt32(objInsResource[0]);

                if (objInsResource[1].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += "," + Convert.ToInt32(objInsResource[1]);
                }

                if (objInsResource[2].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += "," + objInsResource[2];
                }

                if (objInsResource[3].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += "," + objInsResource[3];
                }

                strSQL += "," + objInsResource[4] + "";
                strSQL += "," + objInsResource[5] + "";
                strSQL += "," + objInsResource[6] + "";
                strSQL += ",'" + objInsResource[7] + "'";
                strSQL += ",'" + objInsResource[8] + "'";
                strSQL += ",'" + objInsResource[9] + "'";

                if (objInsResource[10].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += ",'" + objInsResource[10] + "'";
                }


                if (objInsResource[11].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += ",'" + objInsResource[11].ToString().Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                }

                if (objInsResource[12].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += "," + objInsResource[12];
                }

                if (objInsResource[13].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += ",'" + objInsResource[13] + "'";
                }
                strSQL += ",'" + objInsResource[14] + "'";

                strSQL += ",'" + objInsResource[15].ToString() + "'";

                if (IsAgile == 1)
                {
                    if (objInsResource[17].ToString() == "Null")
                    {
                        strSQL += ",Null";
                    }
                    else
                    {
                        strSQL += ",'" + objInsResource[17] + "'";
                    }
                }
                else
                {
                    strSQL += ",Null";
                }

                result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                // Added By Dipali V On 2nd July 2026 for Allocation History
                String[] NewResult = result.ToString().Split(new string[] { "&&" }, StringSplitOptions.None);
                if (NewResult[0].StartsWith("ERROR", StringComparison.OrdinalIgnoreCase))
                {
                    return Request.CreateErrorResponse(HttpStatusCode.BadRequest, NewResult.Length > 1 ? NewResult[1] : NewResult[0]);
                }
                string strMessage = NewResult[0];
                string strProjectEmployeeRoleID = NewResult.Length > 1 ? NewResult[1] : "";
                string strPlannedStartDate = NewResult.Length > 2 ? NewResult[2] : "";
                string strFlag = strMessage + "||" + strProjectEmployeeRoleID;
                if (strPlannedStartDate != "")
                {
                    strFlag += "||" + strPlannedStartDate;
                }
                return strFlag;
                // End of Added By Dipali V On 2nd July 2026 for Allocation History
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        // Added By Dipali V On 2nd July 2026 for Allocation History
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]

        public object GetResourceAllocationHistory([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC Usp_Whizible2_Tbl_Whizible2_ProjectEmployeeRoleHistory " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectEmployeeRoleID));
                if (ResourceParameters.ProjectID > 0)
                {
                    strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID));
                }
                else
                {
                    strSQL += ",NULL";
                }

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        // End of Added By Dipali V On 2nd July 2026 for Allocation History


        //Get Task for Completion on Release click
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetTaskForCompletion([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_TasksForCompletion_ReleaseResource " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID));

                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }




        //Added By Dipali V On 11th Feb 2021 For Get Avaliable Resource Allocation
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetAvaliableAllocation([FromBody] ResourcesParameter ResourceParameters)
        {
            string strSQL = "";
            try
            {
                strSQL = "Exec usp_Whizible2_SEL_Calculate_ResourceAvailable_Percentage " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ExpectedStartDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ExpectedEndDate)) + "'";


                string dt = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }
        //End of Added By Dipali V On 11th Feb 2021 For Get Avaliable Resource Allocation





        //Get Task to be voided on Release click
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetTaskForVoided([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_TasksForVoiding_ReleaseResource " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID));

                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Get Task Approvers list on Release click
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetTaskApprovers([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                IDataReader TaskApproverDetails;
                TaskApproverList TaskApprover = new TaskApproverList();
                string strSQL = "EXEC Usp_Whizible2_Sel_TimesheetandExpenseApproveelist_ReleaseResource " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID));

                TaskApproverDetails = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (TaskApproverDetails.Read())
                {
                    TaskApprover.m_TimesheetApprovee = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskApproverDetails["TimesheetApproveelist"], ""));
                    TaskApprover.m_ExpenseApprovee = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskApproverDetails["ExpenseApproveelist"], ""));
                    TaskApprover.m_strDeliverableList = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskApproverDetails["DeliverableList"], ""));
                    TaskApprover.m_strIssueList = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskApproverDetails["IssueList"], ""));
                    TaskApprover.m_ResponsiblePersonForIssue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskApproverDetails["ResponsiblePersonForIssue"], ""));
                    TaskApprover.m_ResponsiblePersonForInvoice = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskApproverDetails["ResponsiblePersonForInvoice"], ""));
                    TaskApprover.m_MSPFileOwner = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskApproverDetails["MSPFileOwner"], ""));
                    TaskApprover.m_strRisksList = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskApproverDetails["RisksList"], ""));
                    TaskApprover.m_PersonResponsibleForTimesheetblocking = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskApproverDetails["PersonResponsibleForTimesheetblocking"], ""));
                    TaskApprover.m_strTimesheetDefaultApprover = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskApproverDetails["TimesheetDefaultApprover"], ""));
                    TaskApprover.m_strExpenseDefaultApprover = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskApproverDetails["ExpenseDefaultApprover"], ""));
                    TaskApprover.m_StrIRApprover = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskApproverDetails["IRApprover"], ""));
                    TaskApprover.m_strInvoiceGenerator = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskApproverDetails["InvoiceGenerator"], ""));
                    TaskApprover.m_TimesheetAuthenticator = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TaskApproverDetails["TimesheetAuthentication"], ""));
                }

                return TaskApprover;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Task Approvers list on Release click
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetApproverList([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_Approvers_List " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID));

                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        [HttpPost]
        public object ResourceDetails([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "";
                if (ResourceParameters.StrFlag == "TimesheetApprover")
                {
                    strSQL = "EXEC usp_Whizible2_Sel_Approvers_List " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + "";
                }
                else if (ResourceParameters.StrFlag == "DefaultApprover")
                {
                    strSQL = "EXEC usp_Whizible2_Sel_TeamMembers_ReleaseResource " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + "";
                }
                else if (ResourceParameters.StrFlag == "WorkflowApprover")
                {
                    strSQL = "EXEC usp_Whizible2_Sel_Approvers_List " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + "";
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

        //Get Default Approvers list on Release click
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetDefaultApprover([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_TeamMembers_ReleaseResource " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID));

                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Default Approvers list on Release click
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetRFIApproverList([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_Role_RFIApprover " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID));

                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Default Approvers list on Release click
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetAccountPersonList([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC USP_Whizible2_SEL_PM_ACCOUNTPERSONLIST " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID));

                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get GetcountofIRApprovers on Release click
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetcountofIRApprovers([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_EmployeeCount " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.Flag));

                int count;
                count = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "0"));

                return count;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Project Timesheet Approver list on Release click
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetProjectTimesheetApprovers([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_ProjectTimesheetApproversList " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID));

                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get IsWorkflowApprover on Release click
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetIsWorkflowApprover([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_sel_IsWorkflowApprover " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID));

                int count;
                count = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "0"));

                return count;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Start Skill Section plot

        //Get Skill Details
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        public object GetProjectSkills([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ProjectTools " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID));

                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
       

        ////Get Project Experience Details
        //[HttpPost]
        //[Authorize]
        //public ApproverList GetProjectExperienceDetails([FromBody] ResourcesParameter ResourceParameters)
        //{
        //    string strSQL = "";
        //    IDataReader ProjectExperienceDetails;
        //    ApproverList Approver = new ApproverList();

        //    strSQL = "EXEC usp_Whizible2_GetEmployeeSkillsOnProject " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) +","+ HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.IsProjectOver));
        //    //strSQL = "EXEC usp_Whizible2_GetEmployeeSkillsOnProject " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ToolID));

        //    ProjectExperienceDetails = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
        //    if (ProjectExperienceDetails.Read())
        //    {
        //        Approver.ToolID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ProjectExperienceDetails["ToolID"], "0"));
        //        Approver.strDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(ProjectExperienceDetails["Description"], ""));
        //        Approver.intEmployeeYears = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ProjectExperienceDetails["YearsOfExperience"],"0"));
        //        Approver.intEmployeeMonths = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ProjectExperienceDetails["MonthsOfExperience"],"0"));
        //    }
        //    return Approver;
        //}

        //Get Project Experience Details
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetProjectExperienceDetails([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "EXEC usp_Whizible2_GetEmployeeSkillsOnProject " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.IsProjectOver));
                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Chetan m on 16th Jan 2020 to check user has filled timesheet or not
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object CheckUserFilledTimesheet([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "EXEC usp_Whizible2_Chk_tbl_PM_DailyActivity " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID));
                int IsFilledTimesheet;
                IsFilledTimesheet = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return IsFilledTimesheet;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added by Chetan m on 16th Jan 2020 to check user has filled timesheet or not


        //Get IsWorkflowApprover on Release click
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object IsProjectOverOrNot([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_sel_tbl_PM_Project_IsOver " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID));

                int strresult;
                strresult = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                return strresult;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetMonthYearValidation([FromBody] ResourcesParameter ResourceParameters)
        {
            string strSQL = "";
            string strMsg;
            try
            {
                strSQL = "Exec usp_Whizible2_ValidateEmployeeExperienceOnProject " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + " ," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.YearsOfExperience)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.MonthsOfExperience));

                strMsg = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                return strMsg;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Get Resource Tentative Date for Relieving
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public Object GetProjectEmployeeWorkPeriod([FromBody] ResourcesParameter ResourceParameters)
        {
            string strSQL = "";
            try
            {
                IDataReader WorkPeriodDetails;
                ProjectEmployeeWorkPeriod WorkPeriod = new ProjectEmployeeWorkPeriod();

                strSQL = "EXEC usp_Whizible2_Sel_GetProjectEmployeeWorkPeriod " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectEmployeeRoleID));

                WorkPeriodDetails = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (WorkPeriodDetails.Read())
                {
                    WorkPeriod.m_lngEmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(WorkPeriodDetails["EmployeeID"], "0"));
                    WorkPeriod.m_strUserName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(WorkPeriodDetails["UserName1"], ""));
                    WorkPeriod.m_intTotalDays = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(WorkPeriodDetails["TotalDays"], "0"));
                    WorkPeriod.m_strEmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(WorkPeriodDetails["EmployeeName"], ""));
                    WorkPeriod.m_Currntdays = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(WorkPeriodDetails["CurrentDays"], "0"));
                }
                return WorkPeriod;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        ////Get GetProjectDetails on Release click
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public HttpResponseMessage GetProjectDetails([FromBody] ResourcesParameter ResourceParameters)
        {
            HttpRequestMessage request = new HttpRequestMessage();

            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_sel_tbl_PM_DailyActivity_MIN_EntryDate " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID));
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                projectData.StartDate = dt.ToString();
                if (projectData.StartDate != "")
                {
                    projectData.m_intYearsToBeShown = Convert.ToInt32(DateAndTime.DateDiff(DateInterval.Month, Convert.ToDateTime(projectData.StartDate), DateTime.Now) / (double)12);
                    if (Convert.ToInt32(DateAndTime.DateDiff(DateInterval.Month, Convert.ToDateTime(projectData.StartDate), DateTime.Now) % (double)12) >= 11)
                    {
                        projectData.m_intYearsToBeShown = 1;
                    }
                    if (projectData.m_intYearsToBeShown == 0)
                    {
                        projectData.m_intMonthsToBeShown = Convert.ToInt32(DateAndTime.DateDiff(DateInterval.Day, Convert.ToDateTime(projectData.StartDate), DateTime.Now) / (double)30);
                        if (projectData.m_intMonthsToBeShown < 11)
                        {
                            projectData.m_intMonthsToBeShown += 1;
                        }
                    }
                    else
                    {
                        projectData.m_intMonthsToBeShown = 11;
                    }
                }
                else
                {
                    projectData.m_intYearsToBeShown = 0;
                    projectData.m_intMonthsToBeShown = 0;
                }
            
                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, projectData);

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //End Skill Section plot

        //Get Project Timesheet Approver list on Release click
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetMPPTaskDetails([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_MPPTask_tbl_PM_ProjectTasks " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID));

                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Resource Release from project section start here
        //Update Assigned tasks
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateAssignedTasks([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Upd_AssignedTasks_Updation_ReleaseResource 1," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.UserName)) + "'," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.strTaskID)) + "";
                int result;
                result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Update Tasks Void
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateTasksVoid([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Upd_AssignedTasks_Updation_ReleaseResource 2," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.UserName)) + "'," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.strTaskID)) + "";
                int result;
                result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Update Approvers
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateApprovers([FromBody] object[] objUpdateApprover)
        {

            try
            {
                string strSQL;
                string strQuery1;
                string strQuery2;
                int result;
                string countofInvoiceGenerators;
                string countofIRApprovers;

                strQuery1 = "Exec usp_Whizible2_EmployeeCount " + HttpUtility.UrlDecode(Convert.ToString(objUpdateApprover[0])) + "," + HttpUtility.UrlDecode(Convert.ToString(objUpdateApprover[1])) + ",1";
                countofInvoiceGenerators = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery1, true, CommonController.connectionString), "0"));

                strQuery2 = "Exec usp_Whizible2_EmployeeCount " + HttpUtility.UrlDecode(Convert.ToString(objUpdateApprover[0])) + "," + HttpUtility.UrlDecode(Convert.ToString(objUpdateApprover[1])) + ",2";
                countofIRApprovers = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery2, true, CommonController.connectionString), "0"));

                strSQL = "EXEC usp_Whizible2_Upd_AssignedTasks_Updation_ReleaseResource 3," + HttpUtility.UrlDecode(Convert.ToString(objUpdateApprover[0])) + "," + HttpUtility.UrlDecode(Convert.ToString(objUpdateApprover[1])) + ",'" + HttpUtility.UrlDecode(Convert.ToString(objUpdateApprover[2])) + "',Null";
                //newTimesheetApprover
                if (objUpdateApprover[3].ToString() != "Null")
                {
                    strSQL = strSQL + "," + Convert.ToInt32(objUpdateApprover[3]);
                }
                else
                {
                    strSQL = strSQL + ",NULL";
                }
                //newTimesheetDefaultApprover
                if (objUpdateApprover[4].ToString() != "Null")
                {
                    strSQL = strSQL + "," + Convert.ToInt32(objUpdateApprover[4]);
                }
                else
                {
                    strSQL = strSQL + ",NULL";
                }
                //newExpenseApprover
                if (objUpdateApprover[5].ToString() != "Null")
                {
                    strSQL = strSQL + "," + Convert.ToInt32(objUpdateApprover[5]);
                }
                else
                {
                    strSQL = strSQL + ",NULL";
                }
                //newExpenseDefaultApprover
                if (objUpdateApprover[6].ToString() != "Null")
                {
                    strSQL = strSQL + "," + Convert.ToInt32(objUpdateApprover[6]);
                }
                else
                {
                    strSQL = strSQL + ",NULL";
                }
                //newDeliverableResponsiblePerson
                if (objUpdateApprover[7].ToString() != "Null")
                {
                    strSQL = strSQL + "," + Convert.ToInt32(objUpdateApprover[7]);
                }
                else
                {
                    strSQL = strSQL + ",NULL";
                }

                //newIssueResponsiblePerson
                if (objUpdateApprover[8].ToString() != "Null")
                {
                    strSQL = strSQL + "," + Convert.ToInt32(objUpdateApprover[8]);
                }
                else
                {
                    strSQL = strSQL + ",NULL";
                }

                //newResponsiblePersonForIssue
                if (objUpdateApprover[9].ToString() != "Null")
                {
                    strSQL = strSQL + "," + Convert.ToInt32(objUpdateApprover[9]);
                }
                else
                {
                    strSQL = strSQL + ",NULL";
                }

                //newResponsiblePersonForInvoice
                if (objUpdateApprover[10].ToString() != "Null")
                {
                    strSQL = strSQL + "," + Convert.ToInt32(objUpdateApprover[10]);
                }
                else
                {
                    strSQL = strSQL + ",NULL";
                }
                //newMSPFileOwner
                if (objUpdateApprover[11].ToString() != "Null")
                {
                    strSQL = strSQL + "," + Convert.ToInt32(objUpdateApprover[11]);
                }
                else
                {
                    strSQL = strSQL + ",NULL";
                }
                //newRisksResponsiblePerson
                if (objUpdateApprover[12].ToString() != "Null")
                {
                    strSQL = strSQL + "," + Convert.ToInt32(objUpdateApprover[12]);
                }
                else
                {
                    strSQL = strSQL + ",NULL";
                }
                //newPersonResponsibleForTimesheetblocking
                if (objUpdateApprover[13].ToString() != "Null")
                {
                    strSQL = strSQL + "," + Convert.ToInt32(objUpdateApprover[13]);
                }
                else
                {
                    strSQL = strSQL + ",NULL";
                }

                // 'Purpose:-To check whether resource is IRApprover or IRGenerator before releasing.
                //newIRApprover
                if (objUpdateApprover[14].ToString() != "Null")
                {
                    strSQL = strSQL + "," + Convert.ToInt32(objUpdateApprover[14]);
                }
                else
                {
                    strSQL = strSQL + ",NULL";
                }

                //newInvoiceGenerator
                if (objUpdateApprover[15].ToString() != "Null")
                {
                    strSQL = strSQL + "," + Convert.ToInt32(objUpdateApprover[15]);
                }
                else
                {
                    strSQL = strSQL + ",NULL";
                }

                //newTimesheetAuthenticator
                if (objUpdateApprover[16].ToString() != "Null")
                {
                    strSQL = strSQL + "," + Convert.ToInt32(objUpdateApprover[16]);
                }
                else
                {
                    strSQL = strSQL + ",NULL";
                }

                strSQL = strSQL + "," + countofIRApprovers + "," + countofInvoiceGenerators;

                result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Update Tasks Void
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateWorkflow([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_UPD_Workflow_ReleaseProjectResource " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.WorkflowApprover)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.UserName)) + "'";
                int result;
                result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Update Tasks Void
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateSkills([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strQuery = "EXEC usp_Whizible2_Ins_tbl_PM_EmployeeSkillMatrix_Resource " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ToolID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.intYrs)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.intMnths)) + ",0";
                int result;
                result = CommonFunctions.Data.InsertOrUpdateData(strQuery, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Extend Request List
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetExtendRequestGrid([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_sel_resource_request " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID));

                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Update Extend Request
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateRequests([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Upd_AssignedRequest_Updation " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.RequestID));
                int result;
                result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Release Resource Controller
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ReleaseResource([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string Flag = "";
                string intProjectEmployeeRoleID = HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectEmployeeRoleID));
                string intProjectID = HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID));
                string intUserID = HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.UserID));
                string strQuery1;
                string strQuery = "EXEC Usp_Whizible2_Sel_Isallowedtoreleaseresource_ReleaseResource " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectEmployeeRoleID));
                int intResult;
                intResult = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strQuery, true, CommonController.connectionString));
                if (intResult == 1)
                {
                    Flag = "2";
                }
                else
                {
                    strQuery1 = "Exec usp_Whizible2_Upd_tbl_PM_ProjectEmployeeRole '" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectEmployeeRoleID)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.UserName)) + "'";

                    CommonFunctions.Data.InsertOrUpdateData(strQuery1, true, CommonController.connectionString);
                    string strFromEmailID = "";
                    string strToEmailID = "";
                    string strCCToEmailID = "";
                    string strSubject = "";
                    var strEmailMessage = "";
                    bool blnSendEmail, blnShowPopup;

                    //Getting Email messages

                    DataTable EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_EmailMessages 16", true, CommonController.connectionString);
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
                                Flag = "0";
                                EmailMessagesController.GetEmailMessage_16(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strEmailMessage, intProjectEmployeeRoleID, intProjectID, intUserID);
                                EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage);
                            }

                        }
                    }
                    return Flag;
                }
                return Flag;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        
      

        //IsAllowed to relese resource
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object IsAllowedReleaseResource([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strQuery = "SELECT ActualEndDate From tbl_PM_ProjectEmployeeRole Where ProjectEmployeeRoleID = " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectEmployeeRoleID));
                string result;
                result = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, true, CommonController.connectionString), ""));
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Relese resource Update Section End here

        //Delete Resource 
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteResource([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strQuery = "usp_Whizible2_Del_tbl_PM_ProjectEmployeeRole " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectEmployeeRoleID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID));
                string result;
                result = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, true, CommonController.connectionString), ""));
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Filter Section Start Here

        //Resource save filter
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ResourcesSavedFilters([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + ","
                                                                    + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.UserID)) + ", '" + HttpUtility.UrlDecode(ResourceParameters.FilterName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "', '"
                                                                    + HttpUtility.UrlDecode(ResourceParameters.LoginType) + "' ," + "'" + HttpUtility.UrlDecode(ResourceParameters.QueryText) + "'"
                + ",'" + HttpUtility.UrlDecode(ResourceParameters.UserName) + "'," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.FilterFlag)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.FilterID));


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
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
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

        //Set Default filter for Milestone tab
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
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


        //Get Resource Default filter
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        [HttpPost]
        public object GetDefaultFilter([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_Whizible2_Filter_Query_GetDefaultFilter ";
                strSQL += HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID));
                strSQL += "," + Convert.ToString(ResourceParameters.TagID);
                strSQL += ",'" + HttpUtility.UrlDecode(ResourceParameters.LoginType);
                strSQL += "'," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.UserID));

                ARQueryList defaultQuery = new ARQueryList();
                IDataReader drDefaultQuery;
                drDefaultQuery = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (drDefaultQuery.Read())
                {
                    defaultQuery.FilterID = Convert.ToInt32(drDefaultQuery["FilterID"]);
                    defaultQuery.FilterName = Convert.ToString(drDefaultQuery["FilterName"]);
                    defaultQuery.QueryText = Convert.ToString(drDefaultQuery["QueryText"]);
                }
                return defaultQuery;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Edit Filter data.
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
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

        //Delete Filter
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
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

        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        [HttpPost]
        public object chkFilterExists([FromBody]ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_chk_FilterName_Exists '" + HttpUtility.UrlDecode(ResourceParameters.FilterName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "', " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.TagID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.UserID));

                string Flag;

                Flag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

                return Flag;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Max Items to show
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        public object GetMaxItemsToShow()
        {
            try
            {
                int strmsg;
                strmsg = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_Sel_MaxItemToShowInList ", true, CommonController.connectionString));
                return strmsg;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Reshma on 8th Jan 2020 For IssueID-21381
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        [HttpPost]
        public object IsTaskAgainstResource([FromBody]ResourcesParameter ResourceParameters)
        {
            try
            {
                int strmsg;
                string strsql = "Exec usp_Whizible2_Sel_tbl_PM_ProjectEmployeeRole_IsTask " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID));
                strmsg = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strsql, true, CommonController.connectionString));
                return strmsg;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //End Added By Reshma on 8th Jan 2020 For IssueID-21381


        //Added By Rutuja D. 9 Jan 2020 For Check Project Is OnHold
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object CheckProjectOnHold([FromBody] int ProjectID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_tbl_CNF_Project_Status " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //End Added By Rutuja D. 9 Jan 2020 For Check Project Is OnHold



        //Added By Rutuja D. 10 Jan 2020 For Check Project Is OnHold
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object CheckIsProjectCreationWorkflowReqd([FromBody] int ProjectID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_PM_GetProjectCreationWorkflowReqd_Status " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //End Added By Rutuja D. 10 Jan 2020 For Check Project Is OnHold




        //Added by Chetan M on 11th Dec 2020 for IssueID 21309
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        [HttpPost]
        public object GetFirstResourceID([FromBody] int ProjectID)
        {
            try
            {
                int ResourceID;
                ResourceID = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_Sel_ProjectEmployeeRoleId_d_tbl_PM_ProjectEmployeeRole " + HttpUtility.UrlDecode(Convert.ToString(ProjectID)) + "", true, CommonController.connectionString));
                return ResourceID;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added by Chetan M on 11th Dec 2020 for IssueID 21309

        //Added By Reshma on 13th Jan For Work Hours Validation
        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetProjectHours([FromBody]ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL1 = "";

                strSQL1 = "Exec usp_Whizible2_ProjectHours " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID));
                object ProjectValue = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString), "0"));


                return ProjectValue;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 02-09-2022
       [Authorize]
        //End of comment by imran on 02-09-2022
        public object GetResourcesWorkHours([FromBody]ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_ResourcesHoursValidation " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectEmployeeRoleID));


                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }
        //End Added By Reshma 13th Jan For Work Hours Validation


      
    }

}
