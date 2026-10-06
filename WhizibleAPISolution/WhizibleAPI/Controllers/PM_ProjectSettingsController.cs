using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models.PM;

namespace WhizibleAPI.Controllers
{

    public class PM_ProjectSettingsController : ApiController
    {



        //Get Selected Project Name 
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        ////End of comment by imran on 06-09-2022
        //public HttpResponseMessage GetProjectName([FromBody]int ProjectId)
        public HttpResponseMessage GetProjectName([FromBody] MarketSegmentation CT)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {


                strSQL = "";
                strSQL = "usp_Whizible2_Sel_tbl_pm_Project_GetProjectName " + CT.ProjectID;
                object ProjectName = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, ProjectName);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //////////////// Configure Timesheet Blocking Panel Start Here//////////////////////////////////////
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetConfigTimeBlockingList([FromBody] ConfigTimesheetBlocking ConfigureTimePrameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_f_tbl_PM_Project " + HttpUtility.UrlDecode(ConfigureTimePrameters.BackDatingEmployeeID.ToString());

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        //[App_Start.ValidateRateLimit]   //Commented by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateIsBackDatingAndIsForwardDating([FromBody] ConfigTimesheetBlocking ConfigureTimePrameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Upd_tbl_PM_Project_IsBackDatingAndIsForwardDating " + HttpUtility.UrlDecode(ConfigureTimePrameters.BackDatingEmployeeID.ToString());
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                if (ConfigureTimePrameters.IsBackDating == 1)
                {
                    strSQL = "Exec usp_Whizible2_Upd_tbl_PM_BackdatingConfiguration " + HttpUtility.UrlDecode(ConfigureTimePrameters.BackDatingEmployeeID.ToString())
                                   + ",'" + HttpUtility.UrlDecode(ConfigureTimePrameters.BackDateProjectID.ToString())
                                   + "',1,'Back'";
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                }
                if (ConfigureTimePrameters.IsForwardDating == 1)
                {
                    strSQL = "Exec usp_Whizible2_Upd_tbl_PM_BackdatingConfiguration " + HttpUtility.UrlDecode(ConfigureTimePrameters.BackDatingEmployeeID.ToString())
                    + ",'" + HttpUtility.UrlDecode(ConfigureTimePrameters.ForwardDateProjectID.ToString())
                    + "',1,'Fwd'";
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                }

                return Ok("Configuring Timesheet Blocking Updated Successfully.");
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //////////////////////////////////////// Project SLA Panel Start Here///////////////////////////////////////////////////
        //Get Project level SLA List
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetProjectLevelSLAList([FromBody] ConfigParameter ConfigParameters)
        {
            try
            {
                string strSQL;
                if (ConfigParameters.ProjectSLAID == null)
                {

                    strSQL = "Exec usp_Whizible2_Sel_V_tbl_PM_ProjectSLA " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID)) + ",Null";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Sel_V_tbl_PM_ProjectSLA " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectSLAID));
                }

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Project SLA Issue Type Dropdown list
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetProjSLAIssueType([FromBody] ConfigParameter ConfigParameters)
        {
            try
            {
                string strSQL;
                if (ConfigParameters.Flag == 1)
                {
                    strSQL = "EXEC usp_Whizible2_Sel_tbl_IB_Project_Sub_Type " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID)) + ",1";
                }
                else
                {
                    strSQL = "EXEC usp_Whizible2_Sel_tbl_IB_Project_Sub_Type " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID)) + ",2";
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
        //Added By Dipali V On 11st April 2023 For Validated Header missing
        //Add New Project Level SLA
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
       // public object InsertNewProjectLevelSLA([FromBody] object[] objInsProjectSLA)
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object InsertNewProjectLevelSLA([FromBody] string objInsProjectSLA)
        //End of Added By Dipali V On 11st April 2023 For Validated Header missing
        {
            try
            {
                string strSQL;
                string result;
                //Added By Riddhesh Patil on 31st March 2023
                string[] InsProjectSLA;
                InsProjectSLA = objInsProjectSLA.Split(',');

                //InsProjectSLA[1] = InsProjectSLA[1].Replace(' ', ',');
                //End of Added By Riddhesh Patil on 31st March 2023
                strSQL = "EXEC usp_Whizible2_Ins_tbl_PM_ProjectSLA " + Convert.ToInt32(InsProjectSLA[0].ToString());
                strSQL += ",'" + InsProjectSLA[1].ToString() + "'";
                if (InsProjectSLA[2].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += "," + InsProjectSLA[2].ToString();
                }
                if (InsProjectSLA[3].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += "," + InsProjectSLA[3].ToString();
                }
                if (InsProjectSLA[4].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += "," + InsProjectSLA[4].ToString();
                }
                if (InsProjectSLA[5].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += "," + InsProjectSLA[5].ToString();
                }

                strSQL += ",'" + InsProjectSLA[6].ToString() + "'";
                if (InsProjectSLA[7].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += "," + InsProjectSLA[7].ToString();
                }
                result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                String[] spearator = { "&&" };
                String[] NewResult = result.ToString().Split(spearator, 2, StringSplitOptions.None);
                return NewResult[0].ToString() + "||" + NewResult[1].ToString();
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Delete Project SLA
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteProjectSLAs([FromBody] ConfigParameter ConfigParameters)

        {
            try
            {
                string strSQL;
                string result;
                strSQL = "EXEC usp_Whizible2_Del_tbl_PM_ProjectSLA " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectSLAID));
                result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Project SLA History details for Project SLA 
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetprojectSLAHistoryDetails([FromBody] ConfigParameter ConfigParameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_Whizible2_PM_ProjectSLA_AuditTrail_History " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.TagID)) + ",0," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectSLAID));
                DataTable Historytable;
                Historytable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return Historytable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Existing Names For Add Norm To Project SLA
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetNormExistingNames([FromBody] ConfigParameter ConfigParameters)
        {
            try
            {
                string strSQL;
                strSQL = "usp_Whizible2_Sel_V_tbl_PM_ProjectSLADetails " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectSLAID));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Project Corporate level SLA List
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetProjectCorporateSLAList([FromBody] ConfigParameter ConfigParameters)
        {
            try
            {
                string strQuery = "Exec usp_Whizible2_Sel_V_tbl_cnf_Sel_SLADetails_CustomerID " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID));
                int CustomerID = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strQuery, true, CommonController.connectionString));


                string strSQL = "Exec usp_Whizible2_Sel_V_tbl_cnf_Sel_SLADetails " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID)) + "," + CustomerID + "";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Add Corporate Level SLA to Project SLA List
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object AddCorporateSLA([FromBody] ConfigParameter ConfigParameters)

        {
            try
            {
                string strSQL;
                strSQL = "EXEC usp_Whizible2_Ins_ProjectCustomer_SLA " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID));
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.CorporateCustomerID));
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.CorporateSLAID));
                strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.CorporateType));
                strSQL += "'," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.CorporateSLADetailID));
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return Ok("Corporate SLA Added Successfully");
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Get Existing Names TO check Corporate SLA
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetExistingNames([FromBody] ConfigParameter ConfigParameters)
        {
            try{
                string strSQL;
                strSQL = "usp_Whizible2_Sel_V_tbl_PM_ProjectSLA " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID)) + ",Null";
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Norm Section Controllers Start Here
        //Get Project level SLA Norm List
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetSLANormDetailsList([FromBody] ConfigParameter ConfigParameters)
        {
            try {
                string strSQL = "Exec usp_Whizible2_Sel_V_tbl_PM_ProjectSLADetails " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectSLAID));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Project level SLA Norm data in Edit Mode
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetSLANormDetailsInEdit([FromBody] ConfigParameter ConfigParameters)
        {
            try {
                string strSQL = "Exec usp_Whizible2_Sel_V_tbl_PM_ProjectSLADetailsInEdit " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectSLADetailID));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Project Priorities on Add Norm
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetProjectPriorities([FromBody] ConfigParameter ConfigParameters)
        {
            try {
                string strSQL;

                strSQL = "EXEC usp_Whizible2_Sel_tbl_IB_Project_Priorities_Master " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID));

                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Project Priorities on Add Norm
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetProjectSeverity([FromBody] ConfigParameter ConfigParameters)
        {
            try {
                string strSQL;

                strSQL = "EXEC usp_Whizible2_Sel_tbl_IB_Project_Severity_Master " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID));

                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Project Priorities on Add Norm
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetProjectComplexity([FromBody] ConfigParameter ConfigParameters)
        {
            try {
                string strSQL;

                strSQL = "EXEC usp_Whizible2_Sel_tbl_IB_ProjectComplexityMaster " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID));

                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Project Priorities on Add Norm
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetFromToStatus([FromBody] ConfigParameter ConfigParameters)
        {
            try {
                string strSQL;

                strSQL = "EXEC usp_Whizible2_Sel_tbl_IB_Project_Type_Status " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectSLAID));

                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added By Dipali V On 11st April 2023 For Validated Header missing
        //Add New Project Level SLA Norm
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        //public object InsertNewSLANorm([FromBody] object[] objInsSLANorm)
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object InsertNewSLANorm([FromBody] string objInsSLANorm)
        //End of Added By Dipali V On 11st April 2023 For Validated Header missing
        {
            try {
                string strSQL;
                string result;
                //Added By Dipali V On 11st April 2023 For Validate Header Issues
                string[] objSLANorms;
                objSLANorms = objInsSLANorm.Split(',');

                //objSLANorms[1] = objSLANorms[1].Replace(' ', ',');
                //End of Added By  Dipali V On 11st April 2023 For Validate Header Issues
                strSQL = "EXEC usp_Whizible2_Ins_tbl_PM_ProjectSLADetails " + Convert.ToInt32(objSLANorms[0].ToString());
                strSQL += ",'" + objSLANorms[1].ToString().Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                strSQL += "," + Convert.ToInt32(objSLANorms[2].ToString()) + "";
                if (objSLANorms[3].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += "," + objSLANorms[3].ToString();
                }
                if (objSLANorms[4].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += "," + objSLANorms[4].ToString();
                }
                if (objSLANorms[5].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += "," + objSLANorms[5].ToString();
                }

                strSQL += "," + Convert.ToInt32(objSLANorms[6].ToString()) + "";
                strSQL += "," + Convert.ToInt32(objSLANorms[7].ToString()) + "";
                //Commented & Added By Rutuja D. For IssueID = 23093
                // strSQL += "," + objInsSLANorm[8] + "";
                strSQL += ",'" + objSLANorms[8].ToString() + "'";
                //End Commented & Added By Rutuja D. For IssueID = 23093
                strSQL += ",'" + objSLANorms[9].ToString() + "'";

                if (objSLANorms[10].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += "," + objSLANorms[10].ToString();
                }
                if (objSLANorms[11].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += "," + objSLANorms[11].ToString();
                }

                strSQL += ",'" + objSLANorms[12].ToString() + "'";
                if (objSLANorms[13].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += "," + objSLANorms[13].ToString();
                }
                result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                String[] spearator = { "&&" };
                String[] NewResult = result.ToString().Split(spearator, 2, StringSplitOptions.None);
                return NewResult[0].ToString() + "||" + NewResult[1].ToString();
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Delete Project SLA Norm
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteProjectSLANorms([FromBody] ConfigParameter ConfigParameters)

        {
            try {
                string strSQL;
                string result;
                strSQL = "EXEC usp_Whizible2_Del_tbl_PM_ProjectSLADetails " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectSLADetailID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID));
                result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get History details for Project SLA Details(Norm)
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetNormHistoryDetails([FromBody] ConfigParameter ConfigParameters)
        {
            try {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_tbl_Whizible2_PM_ProjectSLADetails_AuditTrail_History " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.TagID)) + ",1," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectSLADetailID));

                DataTable Historytable;
                Historytable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return Historytable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Norm Section Controllers End Here

        //get Project Working Hours List
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetProjectWorkingHoursList([FromBody] ConfigParameter ConfigParameters)
        {
            try
            {
                string strSQL;
                if (ConfigParameters.UniqueID == null)
                {
                    strSQL = "Exec usp_Whizible2_Sel_v_tbl_PM_ProjectWorkingHours " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID)) + ",Null";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Sel_v_tbl_PM_ProjectWorkingHours " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.UniqueID));
                }
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Save Project Working hours
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveProjectWorkingHours([FromBody] ConfigParameter ConfigParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ProjectWorkingHours " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.WeekDay)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.IsWorking)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.FromTime)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ToTime)) + "'," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.UniqueID));

                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return Ok("Project Working Hours Updated Successfully.");
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //get Project SLA Norm Details in Alert
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetSLADetailsNorms([FromBody] ConfigParameter ConfigParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_sel_tbl_PM_ProjectSLADetails_GetNorms " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectSLADetailID));

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //get Project SLA Norm Details in Alert
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveNormAlertDetails([FromBody] ConfigParameter ConfigParameters)
        {
            try
            {
                string strQuery;
                string strSQL;
                string m_strMailToEmployeeIdList = "";
                string m_strMailCcToEmployeeIdList = "";
                IDataReader drMailConfiguration;
                strQuery = "Exec usp_Whizible2_Sel_tbl_PM_SLAAlert_Configure " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectSLADetailID));

                drMailConfiguration = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                if (CommonFunctions.General.CheckIsNothing(drMailConfiguration) != "")
                {
                    if (drMailConfiguration.Read())
                    {

                        m_strMailToEmployeeIdList = CommonFunctions.General.CheckIsNothing(drMailConfiguration["AlertTo"]).Trim();
                        m_strMailCcToEmployeeIdList = CommonFunctions.General.CheckIsNothing(drMailConfiguration["AlertCCTo"]).Trim();

                    }
                }
                CommonFunctions.Data.DisposeDataReader(ref drMailConfiguration);

                strSQL = "Exec usp_Whizible2_Ins_tbl_PM_SLAAlert " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectSLADetailID)) + ",'" + m_strMailToEmployeeIdList + "','" + m_strMailCcToEmployeeIdList + "','" + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.Norm)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.Unit)) + "'";

                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return Ok("SLA Alert Details Updated Successfully.");
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Norm details
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetAlertDetailsNorms([FromBody] ConfigParameter ConfigParameters)

        {
            try
            {
                string strSQL;
                string result;
                strSQL = "EXEC usp_Whizible2_sel_tbl_PM_ProjectSLADetails_GetNormsData " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectSLADetailID));
                result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //////////////////////////////////////// Project SLA Panel End Here///////////////////////////////////////////////////

        //////////////////////////////////////// Integration Setup Panel Start Here///////////////////////////////////////////////////
        //Save Integration Details
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveIntegrationDetails([FromBody] ConfigParameter ConfigParameters)
        {
            try
            {
                string strSQL;
                string result;
                if (ConfigParameters.IntegrationID == "Null")
                {
                    strSQL = "Exec usp_Whizible2_INS_tbl_FCI_IntegrationDetails Null," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.SystemID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.FilePath)) + "'," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.TimeZoneID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.IsSingleFLDForDateTime)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.DisableReassignment)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.UserName)) + "'";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_INS_tbl_FCI_IntegrationDetails " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.IntegrationID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.SystemID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.FilePath)) + "'," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.TimeZoneID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.IsSingleFLDForDateTime)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.DisableReassignment)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.UserName)) + "'";
                }

                result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                String[] spearator = { "&&" };
                String[] NewResult = result.ToString().Split(spearator, 2, StringSplitOptions.None);
                return NewResult[0] + "||" + NewResult[1];
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Integration Details
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetIntegrationDetails([FromBody] ConfigParameter ConfigParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_tbl_FCI_IntegrationDetails " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID));

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get History details for Project SLA Details(Norm)
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetIntegrationHistoryDetails([FromBody] ConfigParameter ConfigParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_tbl_Whizible2_FCI_IntegrationDetails_AuditTrail_History " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.TagID)) + ",0," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.IntegrationID));

                DataTable Historytable;
                Historytable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return Historytable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Attribute Mapping Data
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetAttributeMappingData([FromBody] ConfigParameter ConfigParameters)
        {
            try
            {
                string strSQL = "";
                if (ConfigParameters.IsActiveAttribute == null || ConfigParameters.IsActiveAttribute == "")
                {
                    strSQL = "Exec usp_Whizible2_Sel_FCI_AttributeMapping " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.IntegrationID)) + ",Null";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Sel_FCI_AttributeMapping " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.IntegrationID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.IsActiveAttribute));
                }
                DataTable AttributeMappingtable;
                AttributeMappingtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return AttributeMappingtable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Get Attribute Name Data In Edit Mode
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetAttributeNameData([FromBody] ConfigParameter ConfigParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_v_tbl_FCI_ExternalSysAttribute_Mapping " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.WhizSysAttributeID));

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Update and Save Attribute In Edit
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        //[App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveAttribute([FromBody] ConfigParameter ConfigParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Upd_tbl_FCI_ExternalSysAttribute_Mapping '" + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.SysAttributeName.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n"))) + "'," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.IsActiveAttribute)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.UserName)) + "'," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.WhizSysAttributeID));

                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return Ok("Attribute Updated Successfully.");
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Map Attributes Data
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetMapAttributesData([FromBody] ConfigParameter ConfigParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_v_tbl_FCI_ExternalSysAttribute_Inherit " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.IntegrationID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.IsCustomeField));

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Map Attributes Data
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object AddDataForAddAttribute([FromBody] ConfigParameter ConfigParameters)
        {
            try
            {
                string strSQL;
                IDataReader drGetAttribute;
                AttributeList Attribute = new AttributeList();
                strSQL = "Exec usp_Whizible2_Sel_tbl_FCI_ExternalSysAttribute " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.IntegrationID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.IsCustomeField)) + "," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.strOrderNo));

                drGetAttribute = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (drGetAttribute.Read())
                {
                    Attribute.strOrderNo = Convert.ToString(drGetAttribute["RNum"]);
                    Attribute.IsMandatory = Convert.ToString(drGetAttribute["Mandatory"]);
                    Attribute.WhizAttributeName = Convert.ToString(drGetAttribute["WhizAttributeName"]);
                    Attribute.InsWhizAttributeName = Convert.ToString(drGetAttribute["InsWhizAttributeName"]);

                }
                return Attribute;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Add New Attribute In Map Attributes Tab
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        //[App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object AddNewAttribute([FromBody] ConfigParameter ConfigParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_UPD_tbl_FCI_ExternalSystemAttribute_Mapping '" + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.WhizAttributeName.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n"))) + "','" + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.SysAttributeName.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n"))) + "'," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.IntegrationID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.IsMandatory)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.strOrderNo)) + "'," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.IsCustomeField));

                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return Ok("Attribute Mapped Successfully.");
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Attribute Value Mapping Data
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetAttributeValueMappingData([FromBody] ConfigParameter ConfigParameters)
        {
            try
            {
                string strSQL = "";
                if (ConfigParameters.WhizSysAttributeID == null)
                {
                    strSQL = "Exec usp_Whizible2_Sel_FCI_AttributeValue_Mapping " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID)) + ",Null";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Sel_FCI_AttributeValue_Mapping " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.WhizSysAttributeID));
                }
                DataTable AttributeMappingtable;
                AttributeMappingtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return AttributeMappingtable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Define Value Mapped Data
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetDefineValueMappedData([FromBody] ConfigParameter ConfigParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_FCI_ExternalSysValue_Mapping " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.WhizSysAttributeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID));

                DataTable ValueMappingtable;
                ValueMappingtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ValueMappingtable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Add New Value mapping
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ValueMappedSave([FromBody] ConfigParameter ConfigParameters)
        {
            try
            {
                string strSQL;
                string result;
                strSQL = "Exec Usp_Whizible2_ins_tbl_FCI_ExternalSysValue_Mapping " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.WhizSysAttributeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.IntegrationID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.SysAttributeName.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n"))) + "','" + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.WhizAttributeName.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n"))) + "','" + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID)) + "'," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.UserID));

                result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Get Value Mapped History Data
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetValMapHistoryData([FromBody] ConfigParameter ConfigParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_v_tbl_Whizible2_FCI_ExternalSysValue_Mapping_AuditTrail_History " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.WhizSysAttributeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.UniqueID));

                DataTable ValMapHistorytable;
                ValMapHistorytable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ValMapHistorytable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Get Attribute Mapped History Data
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetattrMapHistoryData([FromBody] ConfigParameter ConfigParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_tbl_Whizible2_FCI_ExternalSysAttribute_Mapping_AuditTrail_History " + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.TagID)) + ",0," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ConfigParameters.UniqueID));

                DataTable attrMapHistorytable;
                attrMapHistorytable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return attrMapHistorytable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

            //////////////////////////////////////// Integration Setup Panel End Here///////////////////////////////////////////////////

            //////////////////////////////////////// Market  Segmentation Panel ///////////////////////////////////////////////////

            MarketSegmentation MarketSegmentation1 = new MarketSegmentation();

        //Get Project Market Segmentation Details
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object  GetMarketSegmentationDetails([FromBody]int ProjectID)
        {
          
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
                strSQL = "";
                strSQL = "exec usp_Whizible2_sel_Market_Seg ";
                MarketSegmentation1.GetMarketSegmentationData = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                strSQL = "";
                strSQL = "usp_Whizible2_sEL_tbl_PM_ExternalMarket_DomainID " + HttpUtility.UrlDecode(ProjectID.ToString());
                MarketSegmentation1.GetExternalMarketIDs = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                strSQL = "";
                strSQL = "usp_Whizible2_Sel_tbl_PM_MarketSubMarket_MarketID " + HttpUtility.UrlDecode(ProjectID.ToString());
                MarketSegmentation1.GetMarketIDs = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                strSQL = "";
                strSQL = "usp_Whizible2_Sel_tbl_PM_MarketSubMarket_SubMarketID " + HttpUtility.UrlDecode(ProjectID.ToString());
                MarketSegmentation1.GetSubMarketIDs = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, MarketSegmentation1);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

            }


        //Insert Project Market Segmentation Details
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object InsertMarketSegmentationDetails([FromBody] MarketSegmentation MarketSegmentation)
        {
            try
            {
                string strSQL;


                strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ServiceMarketMapping_ServiceMarketID " + HttpUtility.UrlDecode(MarketSegmentation.ProjectID.ToString());
                object ServiceMarketID = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                if (ServiceMarketID == null)
                {
                    strSQL = "exec usp_Whizible2_Ins_tbl_PM_ServiceMarketMapping NULL," + HttpUtility.UrlDecode(MarketSegmentation.ProjectID.ToString()) + ",'" + HttpUtility.UrlDecode(MarketSegmentation.AllMarketSegIds) + "','Market'";

                }
                else
                {
                    strSQL = "exec usp_Whizible2_Ins_tbl_PM_ServiceMarketMapping " + ServiceMarketID + "," + HttpUtility.UrlDecode(MarketSegmentation.ProjectID.ToString()) + ",'" + HttpUtility.UrlDecode(MarketSegmentation.AllMarketSegIds) + "','Market'";

                }
                object result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //////////////////////////////////////// Project Complexity Panel ///////////////////////////////////////////////////


        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetComplexityList([FromBody] ProjectComplexity ComplexityPrameters)
        {
            try
            {
                string strSQL;
                if (ComplexityPrameters.ComplexityID == 0)
                {
                    strSQL = "Exec usp_Whizible2_Sel_V_tbl_IB_ProjectComplexityMaster " + HttpUtility.UrlDecode(Convert.ToString(ComplexityPrameters.ProjectID)) + ",NULL";

                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Sel_V_tbl_IB_ProjectComplexityMaster " + HttpUtility.UrlDecode(Convert.ToString(ComplexityPrameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ComplexityPrameters.ComplexityID));

                }

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Existing Names TO check duplicate Complexity
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetExistingComplexityNames([FromBody] ProjectComplexity ComplexityPrameters)
        {
            try
            {
                string strSQL;
                if (ComplexityPrameters.ComplexityID == 0)
                {
                    strSQL = "usp_Whizible2_Sel_V_tbl_IB_ProjectComplexityMaster " + HttpUtility.UrlDecode(Convert.ToString(ComplexityPrameters.ProjectID)) + ",Null";
                }
                else
                {
                    strSQL = "usp_Whizible2_Sel_V_tbl_IB_ProjectComplexityMaster " + HttpUtility.UrlDecode(Convert.ToString(ComplexityPrameters.ProjectID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(ComplexityPrameters.ComplexityID)) + ", 1";
                }
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
        public object GetComplexity()
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ComplexityMaster_Complexity ";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object InsertORUpdateComplexity([FromBody] ProjectComplexity ComplexityPrameters)
        {
            try
            {
                string strSQL;

                if (ComplexityPrameters.ComplexityID == 0)
                {
                    //Commented And Added by Usha Pandit On 11.06.2020 For escaping quotes in string
                    //strSQL = "exec usp_Whizible2_Ins_tbl_IB_ProjectComplexityMaster '";
                    //strSQL += HttpUtility.UrlDecode(ComplexityPrameters.Complexity).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','"
                    //        + HttpUtility.UrlDecode(ComplexityPrameters.CorporateComplexity) + "' ,"
                    //    + HttpUtility.UrlDecode(ComplexityPrameters.ProjectID.ToString()) + ",'" + HttpUtility.UrlDecode(ComplexityPrameters.DefaultComplexity.ToString()) + "'";

                    strSQL = "exec usp_Whizible2_Ins_tbl_IB_ProjectComplexityMaster '";
                    strSQL += HttpUtility.UrlDecode(ComplexityPrameters.Complexity).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','"
                            + HttpUtility.UrlDecode(ComplexityPrameters.CorporateComplexity).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "' ,"
                        + HttpUtility.UrlDecode(ComplexityPrameters.ProjectID.ToString()) + ",'" + HttpUtility.UrlDecode(ComplexityPrameters.DefaultComplexity.ToString()) + "'";
                    //End Of Added by Usha Pandit On 11.06.2020 For escaping quotes in string
                }
                else
                {
                    //Commented And Added by Usha Pandit On 11.06.2020 For escaping quotes in string
                    //strSQL = "exec usp_Whizible2_Upd_tbl_IB_ProjectComplexityMaster '";
                    //strSQL += HttpUtility.UrlDecode(ComplexityPrameters.Complexity).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','"
                    //        + HttpUtility.UrlDecode(ComplexityPrameters.CorporateComplexity) + "' ,"
                    //    + HttpUtility.UrlDecode(ComplexityPrameters.ProjectID.ToString()) + ",'"
                    //    + HttpUtility.UrlDecode(ComplexityPrameters.DefaultComplexity.ToString()) + "','"
                    //    + HttpUtility.UrlDecode(ComplexityPrameters.ComplexityID.ToString()) + "'";

                    strSQL = "exec usp_Whizible2_Upd_tbl_IB_ProjectComplexityMaster '";
                    strSQL += HttpUtility.UrlDecode(ComplexityPrameters.Complexity).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','"
                            + HttpUtility.UrlDecode(ComplexityPrameters.CorporateComplexity).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "' ,"
                        + HttpUtility.UrlDecode(ComplexityPrameters.ProjectID.ToString()) + ",'"
                        + HttpUtility.UrlDecode(ComplexityPrameters.DefaultComplexity.ToString()) + "','"
                        + HttpUtility.UrlDecode(ComplexityPrameters.ComplexityID.ToString()) + "'";
                    //End Of Added by Usha Pandit On 11.06.2020 For escaping quotes in string
                }
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;


            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteComplexity([FromBody] ProjectComplexity ComplexityPrameters)
        {
            try
            {
                string strSQL;

                strSQL = "";
                strSQL = " Exec usp_Whizible2_Del_tbl_IB_ProjectComplexityMaster '" + HttpUtility.UrlDecode(ComplexityPrameters.DelComplexityIDs) + "'," + HttpUtility.UrlDecode(ComplexityPrameters.ProjectID.ToString());

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;


            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //////////////////////////////////////// Project Complexity Panel ///////////////////////////////////////////////////

        ////////////////////////////////////Project Info Role Access////////////////////////////////
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetProInfoRoleAcessList([FromBody] ProjectComplexity ComplexityPrameters)
        {
            try
            {
                string strSQL;

                strSQL = "";
                strSQL = " Exec usp_Whizible2_Sel_v_tbl_PM_Role_For_ProjectInfoRoleAccess ";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;


            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object RoleExistOrNot([FromBody] ProInfoRoleAcess ProInfoRoleAcessPrameters)
        {
            try
            {
                string strSQL;

                strSQL = "";
                strSQL = " Exec usp_Whizible2_Sel_tbl_PM_ProjectInfoRoleAccess_ExistsRole " + HttpUtility.UrlDecode(ProInfoRoleAcessPrameters.ProjectID.ToString()) + "," + HttpUtility.UrlDecode(ProInfoRoleAcessPrameters.RoleID.ToString());

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;


            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateProInfoRoleAcess([FromBody] ProInfoRoleAcess ProInfoRoleAcessPrameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Del_tbl_PM_ProjectInfoRoleAccess " + HttpUtility.UrlDecode(ProInfoRoleAcessPrameters.ProjectID.ToString());

                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);


                strSQL = "";
                if (ProInfoRoleAcessPrameters.RoleIDs != "")
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ProjectInfoRoleAccess " + HttpUtility.UrlDecode(ProInfoRoleAcessPrameters.ProjectID.ToString()) + ",'" + HttpUtility.UrlDecode(ProInfoRoleAcessPrameters.RoleIDs) + "'";

                    CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                }

                return Ok("Project Information Role Access Updated Successfully.");


            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

            ////////////////////////////////////Project Info Role Access////////////////////////////////

            Kernels kernels = new Kernels();
        //Get Project Kernel Details
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public HttpResponseMessage GetKernelDetails([FromBody]int ProjectId)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {


                strSQL = "";
                strSQL = "usp_Whizible2_sel_tbl_IB_Project_Kernels_GetKernelsList " + HttpUtility.UrlDecode(ProjectId.ToString());
                kernels.GetKernelData = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, kernels);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Get  Project Kernel list
        [HttpPost]
        [Authorize]
        public HttpResponseMessage GetKernelList()
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {

                strSQL = "";
                strSQL = "exec usp_Whizible2_Sel_tbl_IB_Kernels";
                kernels.GetKernelList = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, kernels);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Get specific Project Kernel Details
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetKernelSpecificData([FromBody]int KernelId)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {


                strSQL = "";
                strSQL = "usp_Whizible2_sel_tbl_IB_Project_Kernels_SpecificData " + HttpUtility.UrlDecode(KernelId.ToString());
                kernels.GetKernelSpecificData = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                strSQL = "";
                strSQL = "exec usp_Whizible2_Sel_tbl_IB_Kernels";
                kernels.GetKernelList = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, kernels);
            }
                        catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //save or updated Project Kernel Details
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveKernelData([FromBody]Kernels kernelsdata)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {


                strSQL = "";
                //Commented And Added By Usha Pandit On 11.06.2020 For escaping quotes in string
                //strSQL = "exec usp_Whizible2_Ins_tbl_IB_Project_Kernels " + HttpUtility.UrlDecode(kernelsdata.ProjectId.ToString()) + ",'" + HttpUtility.UrlDecode(kernelsdata.Kernel) + "','" + HttpUtility.UrlDecode(kernelsdata.CreatedBy) + "'," + HttpUtility.UrlDecode(kernelsdata.KernelId.ToString());
                strSQL = "exec usp_Whizible2_Ins_tbl_IB_Project_Kernels " + HttpUtility.UrlDecode(kernelsdata.ProjectId.ToString()) + ",'" + HttpUtility.UrlDecode(kernelsdata.Kernel).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(kernelsdata.CreatedBy) + "'," + HttpUtility.UrlDecode(kernelsdata.KernelId.ToString());
                //End Of Added By Usha Pandit On 11.06.2020 For escaping quotes in string

                int data = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, kernels);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //deleted Project Kernel Details
        object result;
        [HttpPost]       
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteKernel([FromBody]Kernels kernelsdata)
        {
            string strSQL;

            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
                for (int i = 0; i < kernelsdata.KernelIds.Length; i++)
                {
                    int kernelId = kernelsdata.KernelIds[i];

                    //Get Project Lessons Learned Details
                    strSQL = "";
                    strSQL = "exec usp_Whizible2_Del_tbl_IB_Project_Kernel " + HttpUtility.UrlDecode(kernelId.ToString()) + "," + HttpUtility.UrlDecode(kernelsdata.ProjectId.ToString() + ",''");
                    //Commented And Added By Usha Pandit On 22.04.2020 For appending all kernel details 
                    //result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                    result = result + " " + CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                    //End Of Added By Usha Pandit On 22.04.2020 For appending all kernel details
                    var configuration = new HttpConfiguration();
                    request.SetConfiguration(configuration);
                }
                return request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }
        ////////////////////////Project OS///////////////////
        ProjectOS projectos = new ProjectOS();

        //Get Project OS Details
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        //public HttpResponseMessage GetProjectOSDetails([FromBody]int ProjectId)
        public HttpResponseMessage GetProjectOSDetails([FromBody] MarketSegmentation MS)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {


                strSQL = "";
                strSQL = "usp_Whizible2_Sel_tbl_IB_Project_OS_GetDetails " + MS.ProjectID;
                projectos.GetProjectOSData = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, projectos);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //save or updated Project OS Details
        [HttpPost]
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SaveProjectOSData([FromBody]ProjectOS projectosdata)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {


                strSQL = "";
                //Commented And Added By Usha Pandit On 10.06.2020 For escaping quotes in string
                //strSQL = "exec usp_Whizible2_Ins_tbl_IB_Project_OS " + HttpUtility.UrlDecode(projectosdata.ProjectId.ToString()) + ",'" + HttpUtility.UrlDecode(projectosdata.OS) + "','" + HttpUtility.UrlDecode(projectosdata.CreatedBy) + "'," + HttpUtility.UrlDecode(projectosdata.ProjectOSID.ToString());
                strSQL = "exec usp_Whizible2_Ins_tbl_IB_Project_OS " + HttpUtility.UrlDecode(projectosdata.ProjectId.ToString()) + ",'" + HttpUtility.UrlDecode(projectosdata.OS).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(projectosdata.CreatedBy) + "'," + HttpUtility.UrlDecode(projectosdata.ProjectOSID.ToString());
                //End Of Added By Usha Pandit On 10.06.2020 For escaping quotes in string

                int data = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Commented And Added By Reshma On 19th Dec 2019 For IssueID=20815
        //deleted Project os 
        //[HttpPost]
        //[Authorize]
        //public HttpResponseMessage DeleteProjectOS([FromBody]ProjectOS projectosdata)
        //{
        //    string strSQL;

        //    HttpRequestMessage request = new HttpRequestMessage();
        //    try
        //    {
        //        for (int i = 0; i < projectosdata.ProjectOSIDs.Length; i++)
        //        {
        //            int projectosId = projectosdata.ProjectOSIDs[i];

        //            //Get Project Lessons Learned Details
        //            strSQL = "";
        //            strSQL = "exec usp_Whizible2_Del_tbl_IB_Project_OS " + HttpUtility.UrlDecode(projectosId.ToString()) + "," + HttpUtility.UrlDecode(projectosdata.ProjectId.ToString() + ",''");
        //            result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

        //            var configuration = new HttpConfiguration();
        //            request.SetConfiguration(configuration);
        //        }
        //        return request.CreateResponse(HttpStatusCode.OK, result);
        //    }
        //    catch (Exception e)
        //    {

        //        return request.CreateResponse(HttpStatusCode.BadRequest, e.Message);
        //    }

        //}

        //deleted Project os 
        [HttpPost]
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteProjectOS([FromBody] ProjectOS projectosdata)
        {
            try
            {
                string strSQL;

                int projectosId = projectosdata.ProjectOSID;

                strSQL = "exec usp_Whizible2_Del_tbl_IB_Project_OS " + HttpUtility.UrlDecode(projectosId.ToString()) + "," + HttpUtility.UrlDecode(projectosdata.ProjectId.ToString());


                string result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
            //End Added By Reshma On 19th Dec 2019 For IssueID=20815

            ///////////////// Service Segmentation ////////////////////////////////
            ServiceSegmentation ServiceSegmentation = new ServiceSegmentation();

        //Get Project Service Segmentation Details
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public HttpResponseMessage GetServiceSegmentationDetails([FromBody]int ProjectId)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {


                strSQL = "";
                strSQL = "exec usp_Whizible2_sel_Services_Seg ";
                ServiceSegmentation.GetServiceSegmentationData = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                strSQL = "";
                strSQL = "usp_Whizible2_sel_tbl_PM_Services_GetServicesSegmentationIDs " + HttpUtility.UrlDecode(ProjectId.ToString());
                ServiceSegmentation.GetServicesSegmentationIDs = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                strSQL = "";
                strSQL = "usp_Whizible2_Sel_tbl_PM_ServiceOffering_GetServiceOfferingIDs " + HttpUtility.UrlDecode(ProjectId.ToString());
                ServiceSegmentation.GetServiceOfferingIDs = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                strSQL = "";
                strSQL = "usp_Whizible2_Sel_tbl_PM_ServiceOffering_GetSubServiceOfferingIDs " + HttpUtility.UrlDecode(ProjectId.ToString());
                ServiceSegmentation.GetSubServiceOfferingIDs = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);




                return request.CreateResponse(HttpStatusCode.OK, ServiceSegmentation);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Get Project Service Segmentation Details
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage InsertSegmentationDetails([FromBody]ServiceSegmentation servicesegmentation)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {

                strSQL = "";
                strSQL = "exec usp_Whizible2_Ins_tbl_PM_ServiceMarketMapping Null," + HttpUtility.UrlDecode(servicesegmentation.ProjectId.ToString()) + ",'" + HttpUtility.UrlDecode(servicesegmentation.AllIds) + "','Services'";
                object result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //////////////////////////////////////// Configure Approvers ///////////////////////////////////
        ConfigureApprovers configureapprovers = new ConfigureApprovers();

        //Get project Row Wise Approvers Details
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public HttpResponseMessage GetRowWiseApproversDetails([FromBody]ConfigureApprovers configureApprovers)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
                //usp_sel_tbl_PM_RowWiseApprovers_ForGrid 2208,'-1',1,' AND PER.ReportingTo = 61 AND PER.Role = 70'
                strSQL = "";
                if (configureApprovers.ReportToId != 0 && configureApprovers.RoleId != 0)
                {
                    strSQL = "exec usp_Whizible2_sel_tbl_PM_RowWiseApprovers_ForGrid " + HttpUtility.UrlDecode(configureApprovers.ProjectId.ToString()) + ",'-1',0,'AND PER.ReportingTo = " + HttpUtility.UrlDecode(configureApprovers.ReportToId.ToString()) + " AND PER.Role = " + HttpUtility.UrlDecode(configureApprovers.RoleId.ToString()) + "' ";
                }
                else if (configureApprovers.ReportToId != 0)
                {

                    strSQL = "exec usp_Whizible2_sel_tbl_PM_RowWiseApprovers_ForGrid " + HttpUtility.UrlDecode(configureApprovers.ProjectId.ToString()) + ",'-1',0,'AND PER.ReportingTo = " + HttpUtility.UrlDecode(configureApprovers.ReportToId.ToString()) + "'";
                }
                else if (configureApprovers.RoleId != 0)
                {
                    strSQL = "exec usp_Whizible2_sel_tbl_PM_RowWiseApprovers_ForGrid " + HttpUtility.UrlDecode(configureApprovers.ProjectId.ToString()) + ",'-1',0,'AND PER.Role = " + HttpUtility.UrlDecode(configureApprovers.RoleId.ToString()) + "'";

                }
                else
                {

                    strSQL = "exec usp_Whizible2_sel_tbl_PM_RowWiseApprovers_ForGrid " + HttpUtility.UrlDecode(configureApprovers.ProjectId.ToString()) + ",'-1',0,''";
                }

                configureapprovers.RowWiseApprovers = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                strSQL = "";
                strSQL = "exec usp_Whizible2_Sel_GetDefaultApprover " + HttpUtility.UrlDecode(configureApprovers.ProjectId.ToString());
                configureapprovers.GetDefaultApproverName = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, configureapprovers);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Insert Row Wise Approvers
        [HttpPost]         
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage InsertRowWiseApprovers([FromBody] ConfigureApprovers configureApprovers)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
                for (int i = 0; i < configureApprovers.ApproverIds.Length; i++)
                {
                    int Approverid = configureApprovers.ApproverIds[i];

                    strSQL = "";
                    strSQL = "exec usp_Whizible2_Ins_RowWiseApprovers " + HttpUtility.UrlDecode(configureApprovers.ProjectId.ToString()) + "," + HttpUtility.UrlDecode(Approverid.ToString()) + "," + HttpUtility.UrlDecode(configureApprovers.EmployeeId.ToString());
                    object result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                }


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, "insert successfully");
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Get project Row wise Approvers History
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public HttpResponseMessage GetRowwiseApproversHistory([FromBody] int ProjectId)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {

                strSQL = "";
                strSQL = "exec usp_Whizible2_sel_tbl_PM_RowwiseApprovers_History " + HttpUtility.UrlDecode(ProjectId.ToString());
                configureapprovers.RowwiseApprovers_History = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, configureapprovers);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Get project Approvers List
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public HttpResponseMessage GetApproverlst([FromBody] int ProjectId)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {

                strSQL = "";
                strSQL = "exec usp_Whizible2_sel_tbl_PM_ProjectEmployeeRole_ReportingTo " + HttpUtility.UrlDecode(ProjectId.ToString());
                configureapprovers.Approverlst = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, configureapprovers);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //set default Row Wise Approvers
        [HttpPost]         
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SetDefaultRowWiseApprovers([FromBody] ConfigureApprovers configureApprovers)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
                for (int i = 0; i < configureApprovers.ApproverIds.Length; i++)
                {
                    int Approverid = configureApprovers.ApproverIds[i];

                    strSQL = "";
                    strSQL = "exec usp_Whizible2_Ins_RowWiseApprovers " + HttpUtility.UrlDecode(configureApprovers.ProjectId.ToString()) + "," + HttpUtility.UrlDecode(Approverid.ToString()) + "," + HttpUtility.UrlDecode(configureApprovers.EmployeeId.ToString()) + ",1";
                    object result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                }


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, "Set default successfully");
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Get project Row Wise Approvers Details
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public HttpResponseMessage GetRowWiseExpenseApproversDetails([FromBody]ConfigureApprovers configureApprovers)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
                //usp_sel_tbl_PM_RowWiseApprovers_ForGrid 2208,'-1',1,' AND PER.ReportingTo = 61 AND PER.Role = 70'
                strSQL = "";
                if (configureApprovers.ReportToId != 0 && configureApprovers.RoleId != 0)
                {
                    strSQL = "exec usp_Whizible2_sel_tbl_PM_ExpenseApprovers_ForGrid " + HttpUtility.UrlDecode(configureApprovers.ProjectId.ToString()) + ",'-1',0,'AND PER.ExpenseApprover = " + HttpUtility.UrlDecode(configureApprovers.ReportToId.ToString()) + " AND PER.Role = " + HttpUtility.UrlDecode(configureApprovers.RoleId.ToString()) + "' ";
                }
                else if (configureApprovers.ReportToId != 0)
                {

                    strSQL = "exec usp_Whizible2_sel_tbl_PM_ExpenseApprovers_ForGrid " + HttpUtility.UrlDecode(configureApprovers.ProjectId.ToString()) + ",'-1',0,'AND PER.ExpenseApprover = " + HttpUtility.UrlDecode(configureApprovers.ReportToId.ToString()) + "'";
                }
                else if (configureApprovers.RoleId != 0)
                {
                    strSQL = "exec usp_Whizible2_sel_tbl_PM_ExpenseApprovers_ForGrid " + HttpUtility.UrlDecode(configureApprovers.ProjectId.ToString()) + ",'-1',0,'AND PER.Role = " + HttpUtility.UrlDecode(configureApprovers.RoleId.ToString()) + "'";

                }
                else
                {

                    strSQL = "exec usp_Whizible2_sel_tbl_PM_ExpenseApprovers_ForGrid " + HttpUtility.UrlDecode(configureApprovers.ProjectId.ToString()) + ",'-1',0,''";
                }

                configureapprovers.RowWiseApprovers = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                strSQL = "";
                strSQL = "exec usp_Whizible2_Sel_GetExpenseDefaultApprover " + HttpUtility.UrlDecode(configureApprovers.ProjectId.ToString());
                configureapprovers.GetDefaultApproverName = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, configureapprovers);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Insert Row Wise Expense Approvers
        [HttpPost]       
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage InsertRowWiseExpenseApprovers([FromBody] ConfigureApprovers configureApprovers)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
                for (int i = 0; i < configureApprovers.ApproverIds.Length; i++)
                {
                    int Approverid = configureApprovers.ApproverIds[i];

                    strSQL = "";
                    strSQL = "exec usp_Whizible2_Ins_ExpenseApprovers " + HttpUtility.UrlDecode(configureApprovers.ProjectId.ToString()) + "," + HttpUtility.UrlDecode(Approverid.ToString()) + "," + HttpUtility.UrlDecode(configureApprovers.EmployeeId.ToString());
                    object result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                }


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, "insert successfully");
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Get project Row wise Expense Approvers History
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public HttpResponseMessage GetExpenseApproversHistory([FromBody] int ProjectId)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {

                strSQL = "";
                strSQL = "exec usp_Whizible2_sel_tbl_PM_ExpenseApprovers_History " + HttpUtility.UrlDecode(ProjectId.ToString());
                configureapprovers.RowwiseApprovers_History = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, configureapprovers);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Get project Expense Approvers List
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public HttpResponseMessage GetExpenseApproverlst([FromBody] int ProjectId)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {

                strSQL = "";
                strSQL = "exec usp_Whizible2_sel_tbl_PM_ProjectEmployeeRole_ExpenseApprover " + HttpUtility.UrlDecode(ProjectId.ToString());
                configureapprovers.Approverlst = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, configureapprovers);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Insert Row Wise Expense Approvers
        [HttpPost]         
        [Authorize]        
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SetDefaultExpenseApprovers([FromBody] ConfigureApprovers configureApprovers)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
                for (int i = 0; i < configureApprovers.ApproverIds.Length; i++)
                {
                    int Approverid = configureApprovers.ApproverIds[i];

                    strSQL = "";
                    strSQL = "exec usp_Whizible2_Ins_ExpenseApprovers " + HttpUtility.UrlDecode(configureApprovers.ProjectId.ToString()) + "," + HttpUtility.UrlDecode(Approverid.ToString()) + "," + HttpUtility.UrlDecode(configureApprovers.EmployeeId.ToString()) + ",1";
                    object result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                }


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, "insert successfully");
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //////////////////////////////////////// IR Related Settings ///////////////////////////////////
        IRRelatedSettings iRRelatedSettings = new IRRelatedSettings();

        //Get project Row Wise Approvers Details
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public HttpResponseMessage GetProjectSalesPersonsDetails([FromBody]IRRelatedSettings irrelatedsettings)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {

                strSQL = "";

                strSQL = "exec usp_Whizible2_sel_tbl_PM_Project_SalesPersons_GetDetails " + HttpUtility.UrlDecode(irrelatedsettings.ProjectId.ToString());


                iRRelatedSettings.SalesPersonsDetails = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                
                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, iRRelatedSettings);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


        //Get Project IR Relaeted Settings NodeAccess
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public HttpResponseMessage GetProjectIRRelaetedSettingsNodeAccess([FromBody]IRRelatedSettings irrelatedsettings)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {

                //strSQL = "";

                //strSQL = "exec usp_Whizible2_sel_tbl_PM_Project_SalesPersons_GetDetails " + HttpUtility.UrlDecode(irrelatedsettings.ProjectId.ToString());


                //iRRelatedSettings.SalesPersonsDetails = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                strSQL = "";
                strSQL = "exec usp_Whizible2_Sel_tbl_UI_SubNodeAccess 'Sales Commission Settings'," + HttpUtility.UrlDecode(irrelatedsettings.RoleID.ToString()) + "," + HttpUtility.UrlDecode(irrelatedsettings.UserID.ToString()) + ",'" + HttpUtility.UrlDecode(irrelatedsettings.LoginType.ToString()) + "'," + HttpUtility.UrlDecode(irrelatedsettings.ProjectId.ToString()) + "," + HttpUtility.UrlDecode(irrelatedsettings.TagID.ToString());
                iRRelatedSettings.SalesCommissionSettingsAccess = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                strSQL = "";
                strSQL = "exec usp_Whizible2_Sel_tbl_UI_SubNodeAccess 'IR Approvers'," + HttpUtility.UrlDecode(irrelatedsettings.RoleID.ToString()) + "," + HttpUtility.UrlDecode(irrelatedsettings.UserID.ToString()) + ",'" + HttpUtility.UrlDecode(irrelatedsettings.LoginType.ToString()) + "'," + HttpUtility.UrlDecode(irrelatedsettings.ProjectId.ToString()) + "," + HttpUtility.UrlDecode(irrelatedsettings.TagID.ToString());
                iRRelatedSettings.IRApproversAccess = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                strSQL = "";
                strSQL = "exec usp_Whizible2_Sel_tbl_UI_SubNodeAccess 'Invoice Generators'," + HttpUtility.UrlDecode(irrelatedsettings.RoleID.ToString()) + "," + HttpUtility.UrlDecode(irrelatedsettings.UserID.ToString()) + ",'" + HttpUtility.UrlDecode(irrelatedsettings.LoginType.ToString()) + "'," + HttpUtility.UrlDecode(irrelatedsettings.ProjectId.ToString()) + "," + HttpUtility.UrlDecode(irrelatedsettings.TagID.ToString());
                iRRelatedSettings.InvoiceGeneratorsAccess = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, iRRelatedSettings);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Project IR Relaeted Settings Get Details Specific Project
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        //public HttpResponseMessage GetProjectIRRelaetedSettingsGetDetailsSpecificProject([FromBody]int ProjectId)
        public HttpResponseMessage GetProjectIRRelaetedSettingsGetDetailsSpecificProject([FromBody] MarketSegmentation MS)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {

                strSQL = "";
                strSQL = "exec usp_Whizible2_sel_tbl_PM_Project_GetDetailsSpecificProject " + MS.ProjectID;
                iRRelatedSettings.ProjectDetails = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, iRRelatedSettings);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Project IR Relaeted Settings Update Specific Project Details
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public HttpResponseMessage GetProjectIRRelaetedSettingsUpdateSpecificProjectDetails([FromBody]IRRelatedSettings irrelatedsettings)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {

                strSQL = "";
                strSQL = "exec usp_Whizible2_update_tbl_PM_Project " + HttpUtility.UrlDecode(irrelatedsettings.ProjectId.ToString()) + "," + HttpUtility.UrlDecode(irrelatedsettings.CompanyID.ToString()) + ",'" + HttpUtility.UrlDecode(irrelatedsettings.BaseCurrency.ToString()) + "','" + HttpUtility.UrlDecode(irrelatedsettings.ProjectOrProduct.ToString()) + "','" + HttpUtility.UrlDecode(irrelatedsettings.ModifiedBy.ToString()) + "'";
                int result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                //HttpResponseMessage responseMessage = GetProjectIRRelaetedSettingsGetDetailsSpecificProject(irrelatedsettings.ProjectId);
                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, "Update Successfully");
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


        //Get Project IR Relaeted Settings Update Specific Project Details
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public HttpResponseMessage GetProjectIRRelaetedSettingsDDLSalesPersonsList([FromBody]IRRelatedSettings irrelatedsettings)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
                if (irrelatedsettings.ProjectSalesPersonID == 0)
                {
                    strSQL = "";
                    strSQL = "exec usp_Whizible2_Sel_tbl_PM_Employee_SalesPersonsList " + HttpUtility.UrlDecode(irrelatedsettings.ProjectId.ToString());
                    iRRelatedSettings.SalesPersonslist = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                }
                else
                {
                    strSQL = "";
                    strSQL = "exec usp_Whizible2_Sel_tbl_PM_Employee_SalesPersonsList " + HttpUtility.UrlDecode(irrelatedsettings.ProjectId.ToString()) + "," + HttpUtility.UrlDecode(irrelatedsettings.ProjectSalesPersonID.ToString());
                    iRRelatedSettings.SalesPersonslist = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                }


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, iRRelatedSettings);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Get Project IR Relaeted Settings Insert Or Update Sales Persons
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage GetProjectIRRelaetedSettingsInsertOrUpdateSalesPersons([FromBody]IRRelatedSettings irrelatedsettings)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {

                strSQL = "";
                strSQL = "exec usp_Whizible2_Ins_tbl_PM_Project_SalesPersons " + HttpUtility.UrlDecode(irrelatedsettings.ProjectId.ToString()) + "," + HttpUtility.UrlDecode(irrelatedsettings.SalesPersonID.ToString()) + "," + HttpUtility.UrlDecode(irrelatedsettings.SalesCommissionPercentage.ToString()) + "," + HttpUtility.UrlDecode(irrelatedsettings.ProjectSalesPersonID.ToString());
                int result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);



                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, "Deleted SuccessFully");
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        // Project IR Relaeted Settings Delete Sales Persons
        [HttpPost]
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage GetProjectIRRelaetedSettingsDeleteSalesPersons([FromBody]IRRelatedSettings irrelatedsettings)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
                for (int i = 0; i < irrelatedsettings.ProjectSalesPersonIDs.Length; i++)
                {
                    int ProjectSalesPersonID = irrelatedsettings.ProjectSalesPersonIDs[i];
                    strSQL = "";
                    strSQL = "exec usp_Whizible2_Del_tbl_PM_Project_SalesPersons " + HttpUtility.UrlDecode(ProjectSalesPersonID.ToString()) + ",''";
                    result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                }


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }
        //33424234
        //Get project PM_IRApprovers Details
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public HttpResponseMessage GetProjectIRApproversDetails([FromBody]IRRelatedSettings irrelatedsettings)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {

                strSQL = "";

                strSQL = "exec usp_Whizible2_Sel_tbl_PM_IRApprovers " + HttpUtility.UrlDecode(irrelatedsettings.ProjectId.ToString());


                iRRelatedSettings.IRApprovers = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, iRRelatedSettings);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Get Project IR Relaeted Settings DDL Role_RFIApprover List
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public HttpResponseMessage GetProjectIRRelaetedSettingsDDLRole_RFIApproverList([FromBody]IRRelatedSettings irrelatedsettings)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
                if (irrelatedsettings.ID == 0)
                {
                    strSQL = "";
                    strSQL = "exec usp_Whizible2_Sel_tbl_PM_Role_RFIApprover " + HttpUtility.UrlDecode(irrelatedsettings.ProjectId.ToString());
                    iRRelatedSettings.Role_RFIApprover = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                }
                else
                {
                    strSQL = "";
                    strSQL = "exec usp_Whizible2_Sel_tbl_PM_Role_RFIApprover " + HttpUtility.UrlDecode(irrelatedsettings.ProjectId.ToString()) + "," + HttpUtility.UrlDecode(irrelatedsettings.ID.ToString());
                    iRRelatedSettings.Role_RFIApprover = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                }


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, iRRelatedSettings);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Get Project IR Relaeted Settings Insert Or Update Sales Persons
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage GetProjectIRRelaetedSettingsInsertOrUpdateIRApprovers([FromBody]IRRelatedSettings irrelatedsettings)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {

                strSQL = "";
                strSQL = "exec usp_Whizible2_Ins_tbl_PM_IRApprovers " + HttpUtility.UrlDecode(irrelatedsettings.ProjectId.ToString()) + "," + HttpUtility.UrlDecode(irrelatedsettings.ApproverID.ToString()) + "," + HttpUtility.UrlDecode(irrelatedsettings.ID.ToString());
                int result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);



                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, "inserted SuccessFully");
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        // Project IR Relaeted Settings Delete IR Approvers
        [HttpPost]
        [Authorize]

        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage GetProjectIRRelaetedSettingsDeleteIRApprovers([FromBody] IRRelatedSettings irrelatedsettings)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
                for (int i = 0; i < irrelatedsettings.IDs.Length; i++)
                {
                    int ID = irrelatedsettings.IDs[i];
                    strSQL = "";
                    strSQL = "exec usp_Whizible2_Del_tbl_PM_IRApprovers " + HttpUtility.UrlDecode(ID.ToString());
                    result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                }


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }
        //45646644645

        //Get project InvoiceGenerators Details
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public HttpResponseMessage GetProjectInvoiceGeneratorsDetails([FromBody]IRRelatedSettings irrelatedsettings)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {

                strSQL = "";

                strSQL = "exec usp_Whizible2_Sel_tbl_PM_InvoiceGenerators " + HttpUtility.UrlDecode(irrelatedsettings.ProjectId.ToString());


                iRRelatedSettings.InvoiceGenerators = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, iRRelatedSettings);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Get Project IR Relaeted Settings DDL Role_RFIApprover List
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public HttpResponseMessage GetProjectIRRelaetedSettingsDDLAccountPersonList([FromBody]IRRelatedSettings irrelatedsettings)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
                if (irrelatedsettings.ID == 0)
                {
                    strSQL = "";
                    strSQL = "exec usp_Whizible2_sel_PM_AccountPersonList " + HttpUtility.UrlDecode(irrelatedsettings.ProjectId.ToString());
                    iRRelatedSettings.PM_AccountPersonList = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                }
                else
                {
                    strSQL = "";
                    strSQL = "exec usp_Whizible2_sel_PM_AccountPersonList " + HttpUtility.UrlDecode(irrelatedsettings.ProjectId.ToString()) + "," + HttpUtility.UrlDecode(irrelatedsettings.ID.ToString());
                    iRRelatedSettings.PM_AccountPersonList = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                }


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, iRRelatedSettings);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Get Project IR Relaeted Settings Insert Or Update InvoiceGenerators
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage GetProjectIRRelaetedSettingsInsertOrUpdateInvoiceGenerators([FromBody]IRRelatedSettings irrelatedsettings)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {


                strSQL = "";
                //Commemted & Added By Dipali V On 16th Nov 2023 For Track history
                //strSQL = "exec usp_Whizible2_Ins_tbl_PM_InvoiceGenerators " + HttpUtility.UrlDecode(irrelatedsettings.ProjectId.ToString()) + "," + HttpUtility.UrlDecode(irrelatedsettings.GeneratorID.ToString()) + "," + HttpUtility.UrlDecode(irrelatedsettings.ID.ToString());
                strSQL = "exec usp_Whizible2_Ins_tbl_PM_InvoiceGenerators " + HttpUtility.UrlDecode(irrelatedsettings.ProjectId.ToString()) + "," + HttpUtility.UrlDecode(irrelatedsettings.GeneratorID.ToString()) + "," + HttpUtility.UrlDecode(irrelatedsettings.ID.ToString()) + "," + HttpUtility.UrlDecode(irrelatedsettings.UserID.ToString());
                //End of Commemted & Added By Dipali V On 16th Nov 2023 For Track history
                int result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);



                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, "inserted SuccessFully");
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        // Project IR Relaeted Settings Delete IR Approvers
        [HttpPost] 
        [Authorize] 
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage GetProjectIRRelaetedSettingsDeleteInvoiceGenerators([FromBody]IRRelatedSettings irrelatedsettings)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
                for (int i = 0; i < irrelatedsettings.IDs.Length; i++)
                {
                    int ID = irrelatedsettings.IDs[i];
                    strSQL = "";
                    strSQL = "exec usp_Whizible2_Del_tbl_PM_InvoiceGenerators " + HttpUtility.UrlDecode(ID.ToString());
                    result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                }


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


        //Get Project Histroy Details
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public HttpResponseMessage GetProjectHistroyDetails([FromBody]IRRelatedSettings irrelatedsettings)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
                DataRow[] rows;
                strSQL = "";
                strSQL = "exec usp_Whizible2_Sel_tbl_Whizible2_PM_IRRelatedSettings_AuditTrail " + HttpUtility.UrlDecode(irrelatedsettings.ProjectId.ToString()) + "," + HttpUtility.UrlDecode(irrelatedsettings.TagID.ToString());

                iRRelatedSettings.ProjectHistroy = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                if (irrelatedsettings.FieldValue.Length != 0 && irrelatedsettings.ModifiedBy.Length != 0 && irrelatedsettings.FieldValue != "undefined" && irrelatedsettings.ModifiedBy != "undefined")
                {
                    //"undefined
                    rows = iRRelatedSettings.ProjectHistroy.Select("FieldName='" + HttpUtility.UrlDecode(irrelatedsettings.FieldValue) + "' AND ModifiedBy='" + HttpUtility.UrlDecode(irrelatedsettings.ModifiedBy) + "'");

                    iRRelatedSettings.ProjectHistroyTemp = rows.AsEnumerable().CopyToDataTable();

                }
                else if (irrelatedsettings.FieldValue.Length != 0 && irrelatedsettings.FieldValue != "undefined")
                {
                    rows = iRRelatedSettings.ProjectHistroy.Select("FieldName='" + HttpUtility.UrlDecode(irrelatedsettings.FieldValue) + "'");

                    iRRelatedSettings.ProjectHistroyTemp = rows.AsEnumerable().CopyToDataTable();                    

                }
                else if (irrelatedsettings.ModifiedBy.Length != 0 && irrelatedsettings.ModifiedBy != "undefined")
                {
                    rows = iRRelatedSettings.ProjectHistroy.Select("ModifiedBy='" + HttpUtility.UrlDecode(irrelatedsettings.ModifiedBy) + "'");
                    iRRelatedSettings.ProjectHistroyTemp = rows.AsEnumerable().CopyToDataTable();
                   
                }
                else
                {
                    iRRelatedSettings.ProjectHistroyTemp = iRRelatedSettings.ProjectHistroy;
                }




                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, iRRelatedSettings);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        ///////////////////////create Project Web Api Check Access all Tag in Projet Settings/////////
        // Object TagId;
        CreateProject createproject = new CreateProject();
        [HttpPost]
        [Authorize]
        public HttpResponseMessage GetProjectNodeAccesDetails([FromBody]CreateProject createProject)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {


                strSQL = "";
                strSQL = "usp_Whizible2_Sel_tbl_Whizible2_PM_ProjectPracticeConfiguration";
                createproject.GetDetailsWithAccess = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                createproject.GetDetailsWithAccess.Columns.Add("A", typeof(System.Object));
                createproject.GetDetailsWithAccess.Columns.Add("D", typeof(System.Object));
                createproject.GetDetailsWithAccess.Columns.Add("E", typeof(System.Object));
                createproject.GetDetailsWithAccess.Columns.Add("V", typeof(System.Object));
                createproject.GetDetailsWithAccess.Columns.Add("Red", typeof(System.Object));
                createproject.GetDetailsWithAccess.Columns.Add("Yellow", typeof(System.Object));
                createproject.GetDetailsWithAccess.Columns.Add("Green", typeof(System.Object));
                createproject.GetDetailsWithAccess.Columns.Add("Access", typeof(System.Object));
                createproject.GetDetailsWithAccess.AcceptChanges();
                for (int i = 0; i < createproject.GetDetailsWithAccess.Rows.Count; i++)
                {
                    for (int j = 0; j < createproject.GetDetailsWithAccess.Columns.Count; j++)
                    {
                        if (j == 6)
                        {
                            object TagId = createproject.GetDetailsWithAccess.Rows[i][j];
                            strSQL = "";
                            strSQL = "usp_Whizible2_Sel_tbl_UI_NodeAccess " + HttpUtility.UrlDecode(TagId.ToString()) + "," + HttpUtility.UrlDecode(createProject.RoleID.ToString()) + "," + HttpUtility.UrlDecode(createProject.UserID.ToString()) + ",'" + HttpUtility.UrlDecode(createProject.LoginType.ToString()) + "'," + HttpUtility.UrlDecode(createProject.ProjectID.ToString());
                            IDataReader rdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);


                            while (rdr.Read())
                            {
                                object AddAccess = rdr["A"];
                                object DeleteAccess = rdr["D"];
                                object EditAccess = rdr["E"];
                                object ViewAccess = rdr["V"];
                                object CompleteAccess = rdr["Access"];

                                createproject.GetDetailsWithAccess.Rows[i][7] = AddAccess;
                                createproject.GetDetailsWithAccess.Rows[i][8] = DeleteAccess;
                                createproject.GetDetailsWithAccess.Rows[i][9] = EditAccess;
                                createproject.GetDetailsWithAccess.Rows[i][10] = ViewAccess;
                                createproject.GetDetailsWithAccess.Rows[i][14] = CompleteAccess;

                            }

                            GetColorDetails(TagId, i, createProject);


                        }

                    }

                }


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, createproject);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }
        string strSQL;

        public void GetColorDetails(object TagId, int i, CreateProject createProject)
        {
            int ProjectId = createProject.ProjectID;
            int UserID = createProject.UserID;
            strSQL = "";
            if (TagId.ToString() == "1027")
            {
              
                strSQL = "usp_Whizible2_Sel_tbl_PM_Project_TaskTypes_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }
            if (TagId.ToString() == "1033")
            {

               
                strSQL = "usp_Whizible2_Sel_tbl_PM_ProjectReviewTypes_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }
            if (TagId.ToString() == "532")
            {
              
                strSQL = "usp_Whizible2_Sel_tbl_IB_Project_Priorities_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }
            if (TagId.ToString() == "536")
            {
             
                strSQL = "usp_Whizible2_Sel_tbl_IB_Project_Severity_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }
            if (TagId.ToString() == "531")
            {
            
                strSQL = "usp_Whizible2_Sel_tbl_IB_Project_KeyWords_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }
            if (TagId.ToString() == "537")
            {

                strSQL = "usp_Whizible2_Sel_tbl_IB_Project_Version_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }
            if (TagId.ToString() == "2005")
            {
              
                strSQL = "usp_Whizible2_Sel_v_tbl_IB_Project_RootCause_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }
            if (TagId.ToString() == "534")
            {
             
                strSQL = "usp_Whizible2_Sel_tbl_IB_Project_Kernels_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }
            if (TagId.ToString() == "535")
            {
               
                strSQL = "usp_Whizible2_Sel_tbl_IB_Project_OS_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }
            if (TagId.ToString() == "589")
            {
              
                strSQL = "usp_Whizible2_Sel_tbl_PM_ProjectEmails_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }

            if (TagId.ToString() == "920")
            {
              
                strSQL = "usp_Whizible2_Sel_v_tbl_PM_Project_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }
            if (TagId.ToString() == "538")
            {
              
                strSQL = "usp_Whizible2_Sel_IB_GetDefault_Type_Status_SubType_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }
            if (TagId.ToString() == "539")
            {
              
                strSQL = "Usp_Whizible2_Sel_IB_Get_CustomFields_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }
            if (TagId.ToString() == "1273")
            {
              
                strSQL = "usp_Whizible2_Sel_f_tbl_PM_Project_GetColorDetails " + HttpUtility.UrlDecode(UserID.ToString());

            }
            if (TagId.ToString() == "2118")
            {
               
                strSQL = "usp_Whizible2_Sel_d_tbl_CNF_ServicesSegmentation_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }
            if (TagId.ToString() == "2188")
            {
               
                strSQL = "usp_Whizible2_Sel_d_tbl_CNF_MarketSegmentation_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }
            if (TagId.ToString() == "3577")
            {
              
                strSQL = "usp_Whizible2_Sel_V_tbl_IB_ProjectComplexityMaster_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }
            if (TagId.ToString() == "3574")
            {
              
                strSQL = "usp_Whizible2_Sel_V_tbl_PM_ProjectSLA_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }
            if (TagId.ToString() == "2250")
            {
              
                strSQL = "usp_Whizible2_Sel_ConfigureApprover_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }
            if (TagId.ToString() == "3091")
            {
               
                strSQL = "usp_Whizible2_Sel_IRRelatedSettings_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }
            if (TagId.ToString() == "3083")
            {
              
                strSQL = "usp_Whizible2_Sel_tbl_PM_ProjectInfoRoleAccess_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }
            if (TagId.ToString() == "3561")
            {
              
                strSQL = "usp_Whizible2_Sel_tbl_PM_CustomFields_Master_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }
            if (TagId.ToString() == "2625")
            {
              
                strSQL = "usp_Whizible2_Sel_tbl_IB_CustomFields_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }
            if (TagId.ToString() == "3003")
            {
               
                strSQL = "usp_Whizible2_Sel_tbl_PM_projectDocumentCategory_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }
            if (TagId.ToString() == "2120")
            {
             
                strSQL = "usp_Whizible2_Sel_v_tbl_PM_ProjectSchedules_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }
            if (TagId.ToString() == "2175")
            {
              
                strSQL = "usp_Whizible2_Sel_v_tbl_PM_Project_PhaseTask_Template_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }
            if (TagId.ToString() == "2263")
            {
             
                strSQL = "usp_Whizible2_Sel_e_tbl_PM_WorkOrderCheckList_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());

            }
            if (TagId.ToString() == "3933")
            {
                strSQL = "usp_Whizible2_Sel_tbl_IM_ProjectAttributes_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());
            }
            if (TagId.ToString() == "3934")
            {
                strSQL = "usp_Whizible2_Sel_v_tbl_IM_ProjectNatureofDemand_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());
            }
            if (TagId.ToString() == "8056")
            {
                strSQL = "usp_Whizible2_Sel_tbl_FCI_IntegrationDetails_GetColorDetails " + HttpUtility.UrlDecode(ProjectId.ToString());
            }
            if (strSQL.Length > 0)
            {
                FillDataIntable(strSQL, i);
            }

        }

        public void FillDataIntable(string strSQL, int i)
        {

            IDataReader rdr1 = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);


            while (rdr1.Read())
            {
                object Red = rdr1["Red"];
                object Green = rdr1["Green"];
                object Yellow = rdr1["Yellow"];
                createproject.GetDetailsWithAccess.Rows[i][11] = Red;
                createproject.GetDetailsWithAccess.Rows[i][12] = Yellow;
                createproject.GetDetailsWithAccess.Rows[i][13] = Green;
            }

        }
        ///////////////////////create Project Web Api Check Access all Tag in Projet Settings/////////


        //Added By Rutuja D. 2 Jan 2020 For Fill Modified Field & Modified By
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        //public object FillModifiedFieldCombo([FromBody] int ProjectId)
        public object FillModifiedFieldCombo([FromBody] MarketSegmentation MS)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_Whizible2_PM_IRRelatedSettings_AuditTrail_GetFieldName 3091,0, " + MS.ProjectID + "," + MS.ProjectID;
                DataTable result = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object FillModifiedByCombo([FromBody] int ProjectId)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_Whizible2_PM_IRRelatedSettings_AuditTrail_GetModifiedBy 3091,0, " + HttpUtility.UrlDecode(ProjectId.ToString()) + "," + HttpUtility.UrlDecode(ProjectId.ToString());
                DataTable result = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added By Rutuja D. 2 Jan 2020 For Fill Modified Field & Modified By

        //Added By Usha Pandit On 02 Jan 2020 For for refresh of expense approver
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object FillExpenseDefaultApproverCombo([FromBody] int ProjectId)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_sel_tbl_PM_ExpenseApprovers " + HttpUtility.UrlDecode(ProjectId.ToString());
                DataTable result = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End Of Added By Usha Pandit On 02 Jan 2020 For for refresh of expense approver
        //Added By Rutuja D. For on 19 March 2020 Get Existing SysAttributeName  issueid = 23149
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetExistingSystemValues([FromBody] string Query)
        {
            try
            {
                string strSQL = Query;
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End Added By Rutuja D. For on 19 March 2020 Get Existing SysAttributeName  issueid = 23149

        //Added By Rutuja D. For on 19 March 2020 Get min DA Entry issueid = 23093
        //get min hours for da Entry
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object GetRestrictByMinHours_MinHoursForDAEntry()
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_RestrictByMinHours_MinHoursForDAEntry ";
                CompanyInformation Information = new CompanyInformation();
                IDataReader CmpInformation;
                CmpInformation = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (CmpInformation.Read())
                {
                    Information.RestrictByMinHours = Convert.ToBoolean(CmpInformation["RestrictByMinHours"]);

                    //Commented And Added By Usha Pandit On 18.06.2020 For getting exact value for MinHoursForDAEntry
                    //Information.MinHoursForDAEntry = float.Parse(Math.Round(Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(CmpInformation["MinHoursForDAEntry"], "0")), 2).ToString());
                    Information.MinHoursForDAEntry = CommonFunctions.Data.CheckIsDBNull(CmpInformation["MinHoursForDAEntry"], "0").ToString();
                    //End Of Added By Usha Pandit On 18.06.2020 For getting exact value for MinHoursForDAEntry
                }
                return Information;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        public object GetUserEmailID([FromBody] ProInfoRoleAcess p)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Sel_tbl_PM_Login_Email " + p.EmployeeID;
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
               
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        public class CompanyInformation
        {
            public Boolean RestrictByMinHours { get; set; }
            //Commented And Added By Usha Pandit On 18.06.2020 For getting exact value for MinHoursForDAEntry
            //public float MinHoursForDAEntry { get; set; }
            public string MinHoursForDAEntry { get; set; }
            //End Of Added By Usha Pandit On 18.06.2020 For getting exact value for MinHoursForDAEntry
        }
        //End Added By Rutuja D. 19 March 2020 For Get min DA Entry issueid = 23093

        public class ConfigTimesheetBlocking
        {
            public int BackDatingEmployeeID { get; set; }
            public string ForwardDateProjectID { get; set; }
            public string BackDateProjectID { get; set; }
            public int IsBackDating { get; set; }
            public int IsForwardDating { get; set; }
        }

        public class MarketSegmentation
        {
            public int ProjectID { get; set; }
            public DataTable GetMarketSegmentationData { get; set; }
            public DataTable GetExternalMarketIDs { get; set; }
            public DataTable GetMarketIDs { get; set; }
            public DataTable GetSubMarketIDs { get; set; }
            public string AllMarketSegIds { get; set; }
        }

        public class ProjectComplexity
        {
            public int ProjectID { get; set; }
            public string Complexity { get; set; }
            public string CorporateComplexity { get; set; }
            public int DefaultComplexity { get; set; }
            public int ComplexityID { get; set; }
            public string DelComplexityIDs { get; set; }
        }

        public class ProInfoRoleAcess
        {
            public int RoleID { get; set; }
            public int EmployeeID { get; set; }
            public int ProjectID { get; set; }
            public string RoleIDs { get; set; }

        }

    }
}
