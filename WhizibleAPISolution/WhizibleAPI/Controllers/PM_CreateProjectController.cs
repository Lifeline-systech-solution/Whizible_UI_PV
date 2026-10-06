using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using CommonFunctions;
using System.Text.RegularExpressions;
using System.Configuration;
using System.Web;
using System.IO;
using Newtonsoft.Json;
using WhizibleAPI.Models.PM;

namespace WhizibleAPI.Controllers
{
    public class PM_CreateProjectController : ApiController
    {
        ////Added By Imran 01-07-2021 For Custom Fields Combobox Validation
        bool result;
        string[] lstSpecialCharacters;
        //Added By Imran 01-07-2021

        //'Added  By Dipali V On 31st July 2020 For Alttech  Customzation
        [Authorize]
        [HttpPost]
        //public List<ConfigureControlPlot> GetplotConditionalyControl([FromBody] ProjectCommonProperty CommonProperty)
        public object GetplotConditionalyControl([FromBody] ProjectCommonProperty CommonProperty)

        {
            try
            {



                string strSQL = "Exec usp_Sel_CheckConfi_tbl_Whizible2_PM_ProjectSettings ";

                List<ConfigureControlPlot> Ctrl = new List<ConfigureControlPlot>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ConfigureControlPlot ObjCtrl = new ConfigureControlPlot()
                    {
                        ISDUEnabled = sdr["ISDUEnabled"].ToString(),
                        ISDTEnabled = sdr["ISDTEnabled"].ToString(),
                        ISDUMandetory = sdr["ISDUMandetory"].ToString(),
                        ISDTMandetory = sdr["ISDTMandetory"].ToString(),
                        ISDUDTDependent = sdr["ISDUDTDependent"].ToString(),

                    };
                    Ctrl.Add(ObjCtrl);
                }

                return Ctrl;
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
        //public List<DeliveryUnit> GetProjectDeliveryTeam([FromBody] ProjectCommonProperty CommonProperty)
        public object GetProjectDeliveryTeam([FromBody] ProjectCommonProperty CommonProperty)

        {
            try
            {

                string strSQL = "Exec usp_whizible2_sel_tbl_PM_GetDeliveryUnit " + CommonProperty.DUvalue;

                List<DeliveryUnit> DT = new List<DeliveryUnit>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    DeliveryUnit ObjDeliveryUnit = new DeliveryUnit()
                    {
                        DTID = sdr["GroupID"].ToString(),
                        DTName = sdr["GroupName"].ToString(),
                    };
                    DT.Add(ObjDeliveryUnit);
                }

                return DT;
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
        public object GetProjectDeliveryUNIT([FromBody] ProjectCommonProperty CommonProperty)
        {
            try
            {

                string strSQL = "Exec usp_Sel_GetResourcePoolForLocation " + CommonProperty.OUvalue + ",0,1," + CommonProperty.ProjectID;

                List<DeliveryUnit> DT = new List<DeliveryUnit>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    DeliveryUnit ObjDeliveryUnit = new DeliveryUnit()
                    {
                        DUID = sdr["ResourcePoolID"].ToString(),
                        DUName = sdr["ResourcePoolName"].ToString(),
                    };
                    DT.Add(ObjDeliveryUnit);
                }

                return DT;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        //End of Added  By Dipali V On 31st July 2020 For Alttech  Customzation


        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        //public List<Location> GetLocation([FromBody] ProjectCommonProperty CommonProperty)
        public object GetLocation([FromBody] ProjectCommonProperty CommonProperty)

        {
            try
            {

                //Commented & Added By Rutuja D. on 26 March 2020 For issueid = 23024
                //  string strSQL = "Exec usp_Whizible2_Sel_GetBusinessGroupsForLocation " + CommonProperty.BussinessGroup + ",NULL,0";
                string strSQL = "Exec usp_Whizible2_Sel_GetBusinessGroupsForLocation " + CommonProperty.BussinessGroup + ",NULL,0," + CommonProperty.ProjectID;
                //End Commented & Added By Rutuja D. on 26 March 2020 For issueid = 23024

                List<Location> OU = new List<Location>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    Location ObjLocation = new Location()
                    {
                        LocationID = sdr["OUPoolID"].ToString(),
                        LocationName = sdr["Location"].ToString(),
                    };
                    OU.Add(ObjLocation);
                }

                return OU;
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
        //public List<ProjectPracitce> GetProjectType([FromBody] ProjectCommonProperty CommonProperty)
        public object GetProjectType([FromBody] ProjectCommonProperty CommonProperty)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_tbl_PRS_Main_ProjectType_For_Practice '" + CommonProperty.ProjectPractice + "'";

                List<ProjectPracitce> ProjectPra = new List<ProjectPracitce>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ProjectPracitce ObjProjectPracitce = new ProjectPracitce()
                    {
                        ProjectType = sdr["ProjectType"].ToString(),

                    };
                    ProjectPra.Add(ObjProjectPracitce);
                }

                return ProjectPra;
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
        public object GetDuration([FromBody] ProjectCommonProperty CommonProperty)
        {
            try
            {
                string query = "EXEC usp_Whizible2_GetWorkingDays '" + CommonProperty.strStartDate + "','" + CommonProperty.strEndDate + "'";
                object result = CommonFunctions.Data.GetDataScalar(query, true, CommonController.connectionString);

                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Duration as per Selected OU
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        public object GetOUDuration([FromBody] ProjectCommonProperty CommonProperty)
        {
            try
            {
                string query = "";
                query = "DECLARE @intDays INT " + System.Environment.NewLine;

                if (CommonProperty.ProjectID == "0")
                {
                    //Commented And Added By Usha Pandit On 15.01.2020 For days check on project creation
                    //query += "EXEC usp_Whizible2_GetOUWorkingDays NULL, '" + CommonProperty.strStartDate + "','" + CommonProperty.strEndDate + "', @intDays OUTPUT" + ", " + CommonProperty.UserID + ", 1," + CommonProperty.OU + ", '" + CommonProperty.FromWhereData + "'";
                    query += "EXEC usp_Whizible2_GetOUWorkingDays NULL, '" + CommonProperty.strStartDate + "','" + CommonProperty.strEndDate + "', @intDays OUTPUT" + ", " + CommonProperty.UserID + ", 0," + CommonProperty.OU + ", '" + CommonProperty.FromWhereData + "'";
                    //End Of Added By Usha Pandit On 15.01.2020 For days check on project creation
                }
                else
                {
                    //Commented And Added By Usha Pandit On 15.01.2020 For days check on project creation
                    //query += "EXEC usp_Whizible2_GetOUWorkingDays " + CommonProperty.ProjectID + ", '" + CommonProperty.strStartDate + "','" + CommonProperty.strEndDate + "', @intDays OUTPUT" + ", " + CommonProperty.UserID + ", 1, " + CommonProperty.OU + ", '" + CommonProperty.FromWhereData + "'";
                    query += "EXEC usp_Whizible2_GetOUWorkingDays " + CommonProperty.ProjectID + ", '" + CommonProperty.strStartDate + "','" + CommonProperty.strEndDate + "', @intDays OUTPUT" + ", " + CommonProperty.UserID + ", 0, " + CommonProperty.OU + ", '" + CommonProperty.FromWhereData + "'";
                    //End Of Added By Usha Pandit On 15.01.2020 For days check on project creation
                }

                query += " SELECT ' Days' = @intDays";
                object result = CommonFunctions.Data.GetDataScalar(query, true, CommonController.connectionString);

                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Validate Date Falls Between Project Start-End Date
        
        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        public object ValidateDate([FromBody]ProjectMilestoneDetails Parameters)
        {
            try
            {
                string strSQL;

                strSQL = "Exec usp_Whizible2_Chk_Date_FallsBetween_Project_StartEndDate " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(Parameters.SelectedDate) + "','" + HttpUtility.UrlDecode(Parameters.WhichAction) + "'";

                object dt = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return dt;
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
        //public List<OUHours> GetWorkingHrByOU([FromBody] ProjectCommonProperty CommonProperty)
        public object GetWorkingHrByOU([FromBody] ProjectCommonProperty CommonProperty)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_GetOUHours " + CommonProperty.OU + "";

                List<OUHours> ProjectOU = new List<OUHours>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    OUHours ObjOUHours = new OUHours()
                    {
                        WorkingHours = sdr["WorkingHours"].ToString(),
                        WorkingDays = sdr["WorkingDays"].ToString(),

                    };
                    ProjectOU.Add(ObjOUHours);
                }

                return ProjectOU;
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
        //public List<ProjectDetails> getProjectCode([FromBody] ProjectDetails ProjectDetailsProperty)
        public object getProjectCode([FromBody] ProjectDetails ProjectDetailsProperty)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_PM_GenenrateJobCode " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectOU)) + ", " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectBG)) + ", 0 ," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectGroupID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectCustomer)) + ", NULL," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.IsBillable)) + "";

                List<ProjectDetails> ProjectCodeDetails = new List<ProjectDetails>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ProjectDetails ObjProjectCodeDetails = new ProjectDetails()
                    {
                        ErrorCode = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ErrorCode"], "0")),
                        JobCode = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["JobCode"], "")),
                    };
                    ProjectCodeDetails.Add(ObjProjectCodeDetails);
                }

                return ProjectCodeDetails;
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object Save_ProjectJobCode([FromBody] ProjectDetails ProjectDetailsProperty)
        {
            try
            {
                string JobID = "";
                string strSQL = "Exec Usp_Whizible2_Ins_PM_JobCode " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectID));

                strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.strProjectCode)) + "', " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectValue)) + ", 0, " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectCustomer)) + ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.StrUserName)) + "'";

                JobID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
                return JobID;
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
        public object Draft_UpdateProjectDetails([FromBody] ProjectDetails ProjectDetailsProperty)
        {
            try
            {
                string strSQL = "";
                string ProjectDetails = "";

                try
                {
                    strSQL = "Exec Usp_upd_tbl_Whizible2_PM_Project "
                    + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ContractType)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.WhichAction)) + "'";

                    ProjectDetails = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
                    return ProjectDetails;
                }
                catch
                {

                }
                return ProjectDetails;
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
        public object Draft_ProjectDetails([FromBody] ProjectDetails ProjectDetailsProperty)
        {
           
            
            string strSQL = "";
            string strProjectCode;

            int ProjectID = 0;
            string strError;
            string strScript;
            int intErrorCode;
            string strUser;
            string ProjectDetails = "";

            //if (ProjectDetailsProperty.ProjectGroupID != "0")
            //{
            //    ProjectDetailsProperty.ProjectGroupID = ProjectDetailsProperty.ProjectGroupID;
            //}
            //else
            //{

            //    ProjectDetailsProperty.ProjectGroupID = "NULL";
            //}


            //if (ProjectDetailsProperty.IsBillable != 0)
            //{
            //    ProjectDetailsProperty.IsBillable = ProjectDetailsProperty.IsBillable;
            //}
            //else
            //{
            //    ProjectDetailsProperty.IsBillable = 0;
            //}


            //List<ProjectCode> Jobcode = new List<ProjectCode>();
            //strSQL = "usp_Whizible2_Sel_PM_GenenrateJobCode " + ProjectDetailsProperty.ProjectOU + ", " + ProjectDetailsProperty.ProjectBG + " 0 ," + ProjectDetailsProperty.ProjectCustomer + "NULL," + ProjectDetailsProperty.IsBillable + "";
            //IDataReader sdr;
            //sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            //ProjectCode ObjProjectCode = new ProjectCode();
            //while (sdr.Read())
            //{

            //    {
            //        strProjectCode = sdr["strProjectCode"].ToString();
            //       // ErrorCode = sdr["ErrorCode"].ToString();

            //    };
            //    ProjectDetailsProperty.strProjectCode = strProjectCode;
            //    Jobcode.Add(ObjProjectCode);
            //}

            //if (ProjectDetailsProperty.strProjectCode == "0")
            //{
            try
            {
                if (ProjectDetailsProperty.NoOfResource == 0)
                {
                    strSQL = "Exec Usp_ins_tbl_Whizible2_PM_Project '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.FromWhichMode)) + "','" + Convert.ToString(ProjectDetailsProperty.ProjectName.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "','" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.AbbProjectName.Replace("'", "''"))) + "','" + Convert.ToString(ProjectDetailsProperty.Description.Replace("'", "''")) + "'," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectGroupID)) + ","
                  + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.IsBillable)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectStartDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectEnddate)) + "',"
                  + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.Hours)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.Duration)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectValue)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectCurrency)) + ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.PracticeTemplate)) + "'," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.UserID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectType)) + "'," +
                   HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectBG)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectOU)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectCustomer)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectSponsar)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.StrUserName)) + "', NULL," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.WhichAction)) + "'";
                    //Added By Usha Pandit On 11.11.2019 For ConvertedToProject Flag Set
                    strSQL = strSQL + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.IsConvertedToProject));
                    //End Of Added By Usha Pandit On 11.11.2019 For ConvertedToProject Flag Set
                    //Added By Dipali V On 31st July 2020 For AllTech Customzation
                    strSQL = strSQL + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ResourcePoolID));
                    strSQL = strSQL + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ResourceGroupID));
                    //End of Added By Dipali V On 31st July 2020 For AllTech Customzation
                    strSQL = strSQL + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectStatus));
                    //Added By Nischal C on 25/08/2025 For PointWest Customization
                    // Fixed parameter order to match SP: CONTRACTID first, then PTC_ProjectCode
                    //strSQL = strSQL + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.CONTRACTID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.PTC_ProjectCode)) + "'";
                    //End of Added By Nischal C on 25/08/2025 For PointWest Customization
                }

                

                else
                {
                    strSQL = "Exec Usp_ins_tbl_Whizible2_PM_Project '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.FromWhichMode)) + "','" + Convert.ToString(ProjectDetailsProperty.ProjectName.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "','" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.AbbProjectName.Replace("'", "''"))) + "','" + Convert.ToString(ProjectDetailsProperty.Description.Replace("'", "''")) + "'," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectGroupID)) + ","
                   + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.IsBillable)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectStartDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectEnddate)) + "',"
                   + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.Hours)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.Duration)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectValue)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectCurrency)) + ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.PracticeTemplate)) + "'," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.UserID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectType)) + "'," +
                    HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectBG)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectOU)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectCustomer)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectSponsar)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.StrUserName)) + "'," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.NoOfResource)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.WhichAction)) + "'";
                    //Added By Usha Pandit On 11.11.2019 For ConvertedToProject Flag Set
                    strSQL = strSQL + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.IsConvertedToProject));
                    //End Of Added By Usha Pandit On 11.11.2019 For ConvertedToProject Flag Set
                    //Added By Dipali V On 31st July 2020 For AllTech Customzation
                    strSQL = strSQL + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ResourcePoolID));
                    strSQL = strSQL + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ResourceGroupID));
                    //End of Added By Dipali V On 31st July 2020 For AllTech Customzation
                    strSQL = strSQL + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectStatus));
                    //Added By Nischal C on 25/08/2025 For PointWest Customization
                   // strSQL = strSQL + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.CONTRACTID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.PTC_ProjectCode)) + "'";
                    //End of Added By Nischal C on 25/08/2025 For PointWest Customization
                }
                ProjectDetails = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
                return ProjectDetails;
            }
            catch (Exception ex)
            {
               
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            // }
           
        }

       // Added by Ajit L for Addition Info tab on 04/03/2024
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage Draft_ProjectDetailsAddInfo([FromBody] AdditionalInfo Parameter)
        {
            string strtResult = string.Empty;
            string strSQL;
            try
            {
                if (Parameter != null)
                {
                    strSQL = "Exec usp_Whizible2_ins_tbl_PM_ProjectAdditionalInfo " + Parameter.ProjectId + ", '" + Parameter.ProjectManager + "' , '" + Parameter.SQAName + "', '" + Parameter.DeliveryManager + "','" + Parameter.VerticalHead + "','" + Parameter.ManagedBy + "','" + Convert.ToString(Parameter.Description.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "','" + Parameter.UserName + "'";
                      
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




        //Added by Ajit L for Addition Info tab on 04/03/2024
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
          public object GetAdditiopnalInfo([FromBody] AdditionalInfo Parameter)
          {
                try
                {
                    string strSQL = "";

                    strSQL = "Exec usp_Whizible2_Sel_GetAdditionalInfo " + Parameter.ProjectId + " ";
                    DataTable dt = new DataTable();
                    dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    return dt;
                }
                catch (Exception ex)
                {
                    return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
                }
          }

        //Added by Ajit L for Addition Info tab on 08/03/2024
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetProjectManager([FromBody] AdditionalInfo Parameter)
        {
                try
                {
                    string strSQL = "";

                    strSQL = "Exec usp_Whizible2_Sel_Resource_AdditionalInfo  " + Parameter.Flag +"," + Parameter.ProjectId + " ";
                    DataTable dt = new DataTable();
                    dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    return dt;
                }
                catch (Exception ex)
                {
                    return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
                }           
        }


        //Added by Ajit L for Addition Info tab on 08/03/2024
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetSQAName([FromBody] AdditionalInfo Parameter)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_Resource_AdditionalInfo  " + Parameter.Flag + "," + Parameter.ProjectId + " ";
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        //Added by Ajit L for Addition Info tab on 08/03/2024
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object ShowHistory([FromBody] AdditionalInfo Parameter)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_Project_AdditionalInfo_AuditTrail " + HttpUtility.UrlDecode(Convert.ToString(Parameter.ProjectId)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameter.ModifiedField)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameter.ModifiedBy)) + "'";
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Codex on 11-05-2026 for project level vendor management
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetProjectVendorList([FromBody] ProjectVendorParameter parameter)
        {
            try

            {
                // Added By Dipali V On 14th May 2026 For split vendor list (selected vs non-selected), vendor type, optional name search
                string search = HttpUtility.UrlDecode(Convert.ToString(parameter.Search ?? "")).Replace("'", "''");
                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ProjectVendorList_Split " + HttpUtility.UrlDecode(Convert.ToString(parameter.ProjectID));
                strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(parameter.ProjectStatus)).Replace("'", "''") + "'";
                strSQL += ", N'" + search + "'";
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Codex on 11-05-2026 for saving draft vendor mappings
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveDraftVendorMapping([FromBody] ProjectVendorParameter parameter)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Ins_tbl_PM_DraftVendorMapping " + HttpUtility.UrlDecode(Convert.ToString(parameter.ProjectID));
                strSQL += ", N'" + HttpUtility.UrlDecode(Convert.ToString(parameter.VendorJson)).Replace("'", "''") + "'";
                strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(parameter.UserName)).Replace("'", "''") + "'";
                object result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return Convert.ToString(result);
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Codex on 11-05-2026 for saving project vendor mappings
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveActualProjectVendorMapping([FromBody] ProjectVendorParameter parameter)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ProjectVendorMapping " + HttpUtility.UrlDecode(Convert.ToString(parameter.ProjectID));
                strSQL += ", N'" + HttpUtility.UrlDecode(Convert.ToString(parameter.VendorJson)).Replace("'", "''") + "'";
                strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(parameter.UserName)).Replace("'", "''") + "'";
                object result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return Convert.ToString(result);
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Codex on 11-05-2026 for project vendor history
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetVendorHistory([FromBody] ProjectVendorParameter parameter)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ProjectVendor_History " + HttpUtility.UrlDecode(Convert.ToString(parameter.ProjectID));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        // Added By Dipali V On 19th May 2026 - Purpose:-On vendor save (draft/actual), batch-check comma-separated VendorIDs
        // against tbl_PM_ProjectEmployeeRole / tbl_PM_ResourceRequest / tbl_PM_AssignedResources; returns in-use vendor names.
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object CheckProjectVendorInUse([FromBody] ProjectVendorParameter parameter)
        {
            try
            {
                string vendorIds = HttpUtility.UrlDecode(Convert.ToString(parameter.VendorIDs ?? "")).Replace("'", "''");
                string strSQL = "Exec usp_Whizible2_Sel_PM_ProjectVendor_InUse "
                    + HttpUtility.UrlDecode(Convert.ToString(parameter.ProjectID))
                    + ", N'" + vendorIds + "'";
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Ajit L for Addition Info tab on 08/03/2024
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetModifiedFieldDetails([FromBody] AdditionalInfo Parameter)
        {
            try
            {
                string query = "";
                query = "EXEC usp_Whizible2_Sel_AdditionalInfo_ModifiedField " + HttpUtility.UrlDecode(Convert.ToString(Parameter.ProjectId)) + "";
                DataTable result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added by Ajit L for Addition Info tab on 08/03/2024
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetModifiedBYDetails([FromBody] AdditionalInfo Parameter)
        {
            try
            {
                string query = "";
                query = "EXEC usp_Whizible2_Sel_AdditionalInfo_ModifiedBy " + HttpUtility.UrlDecode(Convert.ToString(Parameter.ProjectId)) + "";
                DataTable result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return result;
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
        public object Save_DefaultProjectSite([FromBody] ProjectDetails ProjectDetailsProperty)
        {
            try
            {
                string strSQL = "";
                string NewProjectID = "0";
                try
                {

                    strSQL = "Exec Usp_Whizible2_DefaultProjectSite " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectID)) + "";
                    strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.DraftProjectID)) + "";
                    strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.StrUserName)) + "'";
                    NewProjectID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
                    return NewProjectID;
                }
                catch (Exception ex)
                {
                }
                return NewProjectID;
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object Save_DraftToActualProjectCost([FromBody] ProjectDetails ProjectDetailsProperty)
        {
            try
            {
                string strSQL = "";
                int NewSiteID = 0;
                try
                {
                    strSQL = "Exec Usp_Whizible2_Ins_DraftToProjectCost " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectID)) + "";
                    strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.DraftProjectID)) + "";
                    strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.StrUserName)) + "'";
                    NewSiteID = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    return NewSiteID;
                }
                catch (Exception ex)
                {
                }
                return NewSiteID;
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object Save_DraftToActualResourceCost([FromBody] ProjectDetails ProjectDetailsProperty)
        {
            try
            {
                string strSQL = "";
                int NewSiteID = 0;
                try
                {
                    strSQL = "Exec Usp_Whizible2_Ins_DraftToResourceCost " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectID)) + "";
                    strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.DraftProjectID)) + "";
                    strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.StrUserName)) + "'";
                    NewSiteID = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    return NewSiteID;
                }
                catch (Exception ex)
                {
                }
                return NewSiteID;
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object Save_DraftToActualDiscussions([FromBody] ProjectDetails ProjectDetailsProperty)
        {
            try
            {
                string strSQL = "";
                int NewSiteID = 0;
                try
                {
                    strSQL = "Exec Usp_Whizible2_Ins_DraftToDiscussionThread " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectID)) + "";
                    strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.DraftProjectID)) + "";
                    strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.StrUserName)) + "'";
                    NewSiteID = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    return NewSiteID;
                }
                catch (Exception ex)
                {
                }
                return NewSiteID;
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object Save_ProjectFixedBidRevision([FromBody] ProjectDetails ProjectDetailsProperty)
        {

            string strSQL = "";
                int ID = 0;
                try
                {
                    strSQL = "Exec Usp_Whizible2_Ins_tbl_PM_ProjectFixedBid_Revision_New_Project " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectID)) + "";

                    ID = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return ID;
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object Save_ProjectAccess([FromBody] ProjectDetails ProjectDetailsProperty)
        {
            try
            {
                string strSQL = "";
                int ID = 0;
                try
                {
                    strSQL = "Exec Usp_Whizible2_Ins_PM_ProjectAccess " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.UserID));

                    ID = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    return ID;
                }
                catch (Exception ex)
                {
                }
                return ID;
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object Save_DefaultProjectResource([FromBody] ProjectRoleDetails RoleDetailsProperty)
        {
            string strSQL = "";
            int ID = 0;
            try
            {
                strSQL = "Exec usp_Whizible2_Ins_tbl_PM_Project_Employee_Role " + HttpUtility.UrlDecode(Convert.ToString(RoleDetailsProperty.ProjectID)) + "";
                strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(RoleDetailsProperty.RoleID)) + "";
                strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(RoleDetailsProperty.UserID)) + "";
                ID = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return ID;
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
        public object Get_ProjectRoleDetails([FromBody] ProjectRoleDetails RoleDetailsProperty)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Role " + HttpUtility.UrlDecode(Convert.ToString(RoleDetailsProperty.RoleID));

                List<ProjectRoleDetails> ProjectRoleDetails = new List<ProjectRoleDetails>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ProjectRoleDetails ObjProject = new ProjectRoleDetails()
                    {
                        RoleDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["RoleDescription"], "")),
                        AssignToProjectByDefault = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["AssignToProjectByDefault"], "0")),
                        Level = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["Level"], "0")),
                    };
                    ProjectRoleDetails.Add(ObjProject);
                }

                return ProjectRoleDetails;
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object Save_ProjectIssueSLA([FromBody] ProjectDetails ProjectDetailsProperty)
        {
            string strSQL = "";
            int ID = 0;
            try
            {
                strSQL = "Exec Usp_Whizible2_Ins_Issue_SLA " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectID)) + "";

                ID = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return ID;
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object Save_ProjectWorkingHours([FromBody] ProjectDetails ProjectDetailsProperty)
        {
            string strSQL = "";
            int ID = 0;
            try
            {
                strSQL = "Exec Usp_Whizible2_Ins_tbl_PM_Project_WorkingHours " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectID)) + "";

                ID = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return ID;
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object Save_ProjectAttributes([FromBody] ProjectDetails ProjectDetailsProperty)
        {
            string strSQL = "";
            int ID = 0;
            try
            {
                strSQL = "Exec usp_Whizible2_Upd_tbl_IM_ProjectAttributes " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectID)) + "";
                strSQL += ", NULL, NULL";
                strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.StrUserName)) + "'";
                ID = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return ID;
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object Save_ProjectInheritWorkflow([FromBody] ProjectDetails ProjectDetailsProperty)
        {
            string strSQL = "";
            int ID = 0;
            try
            {
                strSQL = "Exec Usp_Whizible2_Ins_InheritWorkflowDefinationAtProjectLevel " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectID)) + "";
                strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.StrUserName)) + "'";
                ID = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return ID;
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object Save_ProjectInheritWorkOrderCosts([FromBody] ProjectDetails ProjectDetailsProperty)
        {
            string strSQL = "";
            int ID = 0;
            try
            {
                strSQL = "Exec Usp_Whizible2_Ins_tbl_PM_WorkOrderCosts_Inherits_ForProject " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectID)) + "";
                strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.StrUserName)) + "'";
                ID = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return ID;
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object Save_DraftToActualSites([FromBody] ProjectDetails ProjectDetailsProperty)
        {
            string strSQL = "";
            int NewSiteID = 0;
            try
            {
                strSQL = "Exec Usp_Whizible2_Ins_DraftToSite " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectID)) + "";
                strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.DraftProjectID)) + "";
                strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.StrUserName)) + "'";
                NewSiteID = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return NewSiteID;
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object Save_DraftToActualMilestones([FromBody] ProjectDetails ProjectDetailsProperty)
        {
            string strSQL = "";
            int NewMilestoneID = 0;
            try
            {
                strSQL = "Exec Usp_Whizible2_Ins_DraftToMilestone " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectID)) + "";
                strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.DraftProjectID)) + "";
                strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.StrUserName)) + "'";
                NewMilestoneID = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return NewMilestoneID;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Codex on 11-05-2026 for draft to actual vendor migration
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object Save_DraftToActualVendors([FromBody] ProjectDetails ProjectDetailsProperty)
        {
            string strSQL = "";
            int result = 0;
            try
            {
                strSQL = "Exec Usp_Whizible2_Ins_DraftToProjectVendor " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectID));
                strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.DraftProjectID));
                strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.StrUserName)) + "'";
                result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return result;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object Save_ProjectDetails([FromBody] ProjectDetails ProjectDetailsProperty)
        {
            string strSQL = "";
            string strProjectCode;

            int ProjectID = 0;
            string strError;
            string strScript;
            int intErrorCode;
            string strUser;
            string ProjectDetails = "";
            
            try
            {
                strSQL = "Exec Usp_Whizible2_Ins_tbl_PM_DraftToProject '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.FromWhichMode)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectName.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n"))) + "','" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.AbbProjectName.Replace("'", "''"))) + "','" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.Description.Replace("'", "''"))) + "'," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectGroupID)) + ","
               + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.IsBillable)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectStartDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectEnddate)) + "',"
               + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.Hours)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.Duration)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectValue)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectCurrency)) + ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.PracticeTemplate)) + "'," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.UserID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectType)) + "'," +
                HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectBG)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectOU)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectCustomer)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectSponsar)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.StrUserName)) + "'," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.NoOfResource)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ContractType)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.WhichAction)) + "'";

                strSQL += ", 1";
                strSQL += ",'C'";
                strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.strProjectCode)) + "'";
               //Added By Dipali V on 31stt July 2020 For All Tech Customzation
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ResourceGroupID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ResourcePoolID)) + "";
                //End of Added By Dipali V on 31stt July 2020 For All Tech Customzation
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectStatus)) + "";

                ProjectDetails = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

                return ProjectDetails;
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
        //public List<ProjectDetails> GetProjectDetails([FromBody] ProjectCommonProperty ProjectProperty)
        public object GetProjectDetails([FromBody] ProjectCommonProperty ProjectProperty)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ProjectDetails " + ProjectProperty.ProjectID + ",'" + ProjectProperty.FromWhereData + "'";
                
                

                List<ProjectDetails> ProjectDetails = new List<ProjectDetails>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                

                while (sdr.Read())
                {
                    try
                    {
                        ProjectDetails ObjProject = new ProjectDetails()
                        {
                        //Added By Dipali V On 20th Jan 2020 For Sonata Changes, Instead of Abb Name ProjectCode Display
                        // Safely map ProjectCode with error handling
                        ProjectCode = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ProjectCode"], "")),
                        //End of Added By Dipali V On 20th Jan 2020 For Sonata Changes, Instead of Abb Name ProjectCode Display
                        //Added by Dipali V on 21st Jan 2021 For tooltip changes instead of CustomerID CustomerName Should get 
                        CustomerName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["CustomerName"], "")),
                        //End of Added by Dipali V on 21st Jan 2021 For tooltip changes instead of CustomerID CustomerName Should get 


                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ProjectName"], "")),
                        CurrencyCode = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["CurrencyCode"], "")),

                        AbbProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ShortJobTitle"], "")),
                        ProjectStartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ExpectedStartDate"], "")),
                        ProjectEnddate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ExpectedEndDate"], "")),
                        Hours = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["EstimatedEfforts"], "0.00")),
                        Duration = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ExpectedDuration"], "0")),
                        ProjectBG = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["BusinessGroupID"], "0")),
                        ProjectOU = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["LocationID"], "0")),
                        ProjectCurrency = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["BaseCurrency"], "0")),
                        ProjectCustomer = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["CustomerID"], "0")),
                        IsOldProject = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["IsOldProject"], "0")),
                        NoOfResource = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["No_Of_Resource"], "0")),
                        ProjectType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ProjectType"], "")),
                        //Added By Dipali V On 16th Feb 2021 For Practice get Clear
                        ProjectTemplate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ProjectTemplate"], "")),
                        //End of Added By Dipali V On 16th Feb 2021 For Practice get Clear
                        ProjectTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ProjectTypeID"], "0")),
                        ProjectGroupID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ProjectGroupID"], "")),
                        ProjectSponsar = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["FundedBy"], "0")),
                        //ProjectBuget = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["ContractValue"], "0.00")),
                        //ProjectValue = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["ContractValue"], "0.00")),
                        //ProjectBuget = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(sdr["ContractValue"], "0.00")),
                       // ProjectValue = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(sdr["ContractValue"], "0.00")),
                        ProjectValue = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(sdr["ContractValue"], "0.00")),
                        ProjectBuget = String.Format("{0:0.00}", CommonFunctions.Data.CheckIsDBNull(sdr["ContractValue"], "0.00")),
                        SumBillAmount = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["SumBillAmount"], "0.00")),
                        ContractType = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ContractType"], "0")),
                        Description = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["Description"], "")),
                        IsBillable = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["Billable"], "0")),
                        CorporateCurrencyCode = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["CorporateCurrencyCode"], "")),
                        //Added By Usha Pandit On 17.01.2020 For Baseline Status
                        BaselineStatus = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["BaselineStatus"], "")),
                        //End Of Added By Usha Pandit On 17.01.2020 For Baseline Status
                        ConversionRate = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["ConversionRate"], "0.00")),
                        //Added By Dipali V On 31st July 2020 for Allttech  Customzation
                        ResourcePoolID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ResourcePoolID"], "")),
                        ResourceGroupID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ResourceGroupID"], "")),
                        //End of Added By Dipali V On 31st July 2020 for Allttech  Customzation

                        ProjectStatus = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ProjectStatusID"], "")),

                        //Added By Nischal C on 25/08/2025 For PointWest Customization
                        // Safely map PTC_ProjectCode and CONTRACTID with error handling
                        // Safely map with error handling
                        //PTC_ProjectCode = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["PTC_ProjectCode"], "")),
                        //CONTRACTID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["CONTRACTID"], "0")),
                        //End of Added By Nischal C on 25/08/2025 For PointWest Customization
                        
                        

                        };
                        ProjectDetails.Add(ObjProject);
                    }
                    catch (Exception fieldEx)
                    {
                       
                        // Continue with next record if there's an error
                        continue;
                    }
                }

                return ProjectDetails;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Nischal C on 25/08/2025 For PointWest Customization
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetCustomerSpecificContractNumber([FromBody] int CustomerID)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_GetContractNumberforCustomer " + CustomerID + ", NULL";
                
                List<ContractNumber> ContractNumbers = new List<ContractNumber>();
                
                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                
                while (sdr.Read())
                {
                    ContractNumber ObjContract = new ContractNumber()
                    {
                        CONTRACTID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["CONTRACTID"], "0")),
                        CONTRACTNUMBER = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["CONTRACTNUMBER"], ""))
                    };
                    ContractNumbers.Add(ObjContract);
                }
                
                return ContractNumbers;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Nischal C on 25/08/2025 For PointWest Customization

        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object Save_MileStoneDetails([FromBody] ProjectMilestoneDetails ProjectDetailsProperty)
        {
            string strSQL = "";
            int MilesToneID=0;
            string FromWhereData = "";
            try
            {
                //if (MilesToneID = 0)
                //{
                //    MilesToneID = null;
                //    FromWhereData = "Add";
                //}
                
                strSQL = "Exec usp_Whizible_Ins_tbl_Whizible2_PM_MilestonesDraft " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.MileStoneID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.MileStoneName.Replace("'", "''"))) + "','" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.StartDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.EndDate)) + "',"
               + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.BillAmount)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.StrUserName)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.FromWhichMode)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.WhichAction)) + "'";
                MilesToneID = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return MilesToneID;
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object Save_SiteDetails([FromBody] ProjectSiteDetails SiteDetailsProperty)
        {
            string strSQL = "";
            int ProjectSiteID = 0;                    
            try
            {
                strSQL = "Exec Usp_Whizible2_Ins_tbl_Whizible2_PM_ProjectSites " + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.Name).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "'";

                if (HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.ProjectSiteID)) == "0")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.ShortName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "'";
                }

                strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.City).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "',"

                + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.WeekDays)) + ", " + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.WorkHrs)) + ", " + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.HoursPerMonth)) + ", " + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.WorkHoursCapPerDay)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.StrUserName)) + "'";

                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.CurrencyID));

                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.RateMethod));

                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.IsOffshore));

                if (HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.ProjectSiteID)) == "0")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.Address).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "'";
                }

                if (HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.ProjectSiteID)) == "0")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.Address1).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "'";
                }

                if (HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.ProjectSiteID)) == "0")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.CountryID));
                }

                if (HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.ProjectSiteID)) == "0")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.State).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "'";
                }

                if (HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.ProjectSiteID)) == "0")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.Zip).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "'";
                }
                if (HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.ProjectSiteID)) == "0")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.Fax).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "'";
                }
                if (HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.ProjectSiteID)) == "0")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.Phone).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "'";
                }
                
                if (HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.ProjectSiteID)) == "0")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.EmailID).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "'";
                }
                if (HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.ProjectSiteID)) == "0")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.Remarks).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "'";
                }
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.StartingDayOfWeek));                

                if (HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.ProjectSiteID)) == "0")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.ProjectSiteID));
                }
                strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.WhichAction)) + "'";
                ProjectSiteID = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return ProjectSiteID;
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object Save_ProjectCostDetails([FromBody] ProjectCostDetails ProjectCostDetailsProperty)
        {
            string strSQL = "";
            int WorkOrderCostID = 0;
            try
            {
                strSQL = "Exec Usp_Whizible2_Ins_tbl_Whizible2_PM_Draft_WorkOrderCosts " + HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.ProjectID)) + "";                
                
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.Billable));
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.CostToCompany));
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.Reimbersable));
                strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.UserName)) + "'";
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.CurrencyID));
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.IsActive));
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.CostHeadID));

                if (HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.WorkOrderCostID)) == "0")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.WorkOrderCostID));
                }

                if (HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.Description)) == "")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.Description.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n"))) + "'";
                }
                strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.WhichAction)) + "'";
                WorkOrderCostID = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return WorkOrderCostID;
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object Save_ResourceCostDetails([FromBody] ResourceRole ResourceRoleDetailsProperty)
        {
            string strSQL = "";
            int ResourceCostID = 0;
            try
            {
                strSQL = "Exec Usp_Whizible2_Ins_tbl_PM_DraftResourceCostDetail " + HttpUtility.UrlDecode(Convert.ToString(ResourceRoleDetailsProperty.ProjectID)) + "";

                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ResourceRoleDetailsProperty.RoleID));
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ResourceRoleDetailsProperty.NoOfResource));
                strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(ResourceRoleDetailsProperty.StartDate)) + "'";
                strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(ResourceRoleDetailsProperty.EndDate)) + "'";
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ResourceRoleDetailsProperty.PercentageAllocation));
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ResourceRoleDetailsProperty.Budget));
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ResourceRoleDetailsProperty.RoleCost));
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ResourceRoleDetailsProperty.CurrencyID));
                strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(ResourceRoleDetailsProperty.UserName)) + "'";

                if (HttpUtility.UrlDecode(Convert.ToString(ResourceRoleDetailsProperty.ResourceCostID)) == "0")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ResourceRoleDetailsProperty.ResourceCostID));
                }

                strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(ResourceRoleDetailsProperty.WhichAction)) + "'";
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ResourceRoleDetailsProperty.IsOriginalBudgetChange));
                
                ResourceCostID = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return ResourceCostID;
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object Save_ResourceCostHeadDetails([FromBody] ProjectCostHeadDetails ProjectCostHeadDetailsProperty)
        {
            string strSQL = "";
            int ProjectCostHeadID = 0;
            try
            {
                strSQL = "Exec Usp_Whizible2_Ins_tbl_Whizible2_PM_Draft_WorkOrderCostsDetails '" + HttpUtility.UrlDecode(Convert.ToString(ProjectCostHeadDetailsProperty.StartDate)) + "'";

                strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectCostHeadDetailsProperty.EndDate)) + "'";
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ProjectCostHeadDetailsProperty.IsPublic));
                strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(ProjectCostHeadDetailsProperty.Billable));
                strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(ProjectCostHeadDetailsProperty.UserCanOverride));
                               
                if (HttpUtility.UrlDecode(Convert.ToString(ProjectCostHeadDetailsProperty.WorkOrderCostDetailID)) == "0")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ProjectCostHeadDetailsProperty.WorkOrderCostDetailID));
                }
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ProjectCostHeadDetailsProperty.WorkOrderCostID));
                strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectCostHeadDetailsProperty.UserName)) + "'";
                strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectCostHeadDetailsProperty.WhichAction)) + "'";
                ProjectCostHeadID = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return ProjectCostHeadID;
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object Save_TemplateSite([FromBody] ProjectRateCardDetails ProjectRateCardDetailsProperty)
        {
            string strSQL = "";
            string ProjectSiteID = "0";
            try
            {
                strSQL = "Exec Usp_Whizible2_Ins_tbl_PM_CustomerTemplate " + HttpUtility.UrlDecode(Convert.ToString(ProjectRateCardDetailsProperty.TemplateID)) + "";

                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ProjectRateCardDetailsProperty.ProjectID));
                strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectRateCardDetailsProperty.UserName)) + "'";
                
                //ProjectSiteID = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                //return ProjectSiteID;
                ProjectSiteID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "0"));
                return ProjectSiteID;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Delete the Project Cost Details
        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteProjectCost([FromBody]ProjectCostDetails ProjectCostDetailsProperty)
        {
            try
            {
                string strSQL;
                strSQL = "DECLARE @strReturn VARCHAR(1000) " + System.Environment.NewLine;
                strSQL += "Exec usp_Whizible2_Del_PM_Draft_WorkOrderCosts " + HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.WorkOrderCostID));
                strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.ProjectID));
                strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.WhichAction)) + "'";
                strSQL += ", " + " @strReturn OUTPUT";
                strSQL += " SELECT ' Status' = @strReturn";
                object dt = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Delete the Project Cost Head Details
        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteProjectCostHead([FromBody] ProjectCostHeadDetails ProjectCostHeadDetailsProperty)
        {
            try
            {
                string strSQL;
                strSQL = "DECLARE @strReturn VARCHAR(1000) " + System.Environment.NewLine;
                strSQL += "Exec usp_Whizible2_Del_PM_Draft_WorkOrderCostDetails '" + HttpUtility.UrlDecode(Convert.ToString(ProjectCostHeadDetailsProperty.WorkOrderCostDetailIDList)) + "'";
                strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectCostHeadDetailsProperty.WhichAction)) + "'";
                strSQL += ", " + " @strReturn OUTPUT";
                strSQL += " SELECT ' Status' = @strReturn";
                object dt = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Delete the Resource Cost Details
        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteResourceCost([FromBody] ProjectCostDetails ProjectCostDetailsProperty)
        {
            try
            {
                string strSQL;
                strSQL = "DECLARE @strReturn VARCHAR(1000) " + System.Environment.NewLine;
                strSQL += "Exec usp_Whizible2_Del_PM_DraftResourceCostDetail " + HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.WorkOrderCostID));
                strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.WhichAction)) + "'";
                strSQL += ", " + " @strReturn OUTPUT";
                strSQL += " SELECT ' Status' = @strReturn";
                object dt = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

            //Delete the Project Site Details
            [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteProjectSite([FromBody]ProjectSiteDetails ProjectSiteDetailsProperty)
        {
            try
            {
                string strSQL;
                strSQL = "DECLARE @strReturn VARCHAR(1000) " + System.Environment.NewLine;
                strSQL += "Exec usp_Whizible2_Del_tbl_PM_ProjectSites " + HttpUtility.UrlDecode(Convert.ToString(ProjectSiteDetailsProperty.ProjectSiteID));
                strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(ProjectSiteDetailsProperty.ProjectID));
                strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectSiteDetailsProperty.WhichAction)) + "'";
                strSQL += ", " + " @strReturn OUTPUT";
                strSQL += " SELECT ' Status' = @strReturn";
                object dt = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return dt;
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object Save_RoleDetails([FromBody] ProjectRateCardDetails RateCardDetailsProperty)
        {
            string strSQL = "";
            int ProjectSiteRoleID = 0;
            try
            {
                strSQL = "Exec Usp_Whizible2_Ins_tbl_Whizible2_PM_ProjectSiteRole " + HttpUtility.UrlDecode(Convert.ToString(RateCardDetailsProperty.ProjectSiteID)) + "";

                strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(RateCardDetailsProperty.RoleID)) + "";
                strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(RateCardDetailsProperty.NormalRate)) + "";
                strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(RateCardDetailsProperty.ExtraRate)) + "";
                strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(RateCardDetailsProperty.HolidayRate)) + "";
                strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(RateCardDetailsProperty.IsApplied)) + "";
                strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(RateCardDetailsProperty.CTC)) + "";
                strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(RateCardDetailsProperty.CurrencyID)) + "";
                strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(RateCardDetailsProperty.UserName)) + "'";
                if (HttpUtility.UrlDecode(Convert.ToString(RateCardDetailsProperty.ProjectSiteRoleID)) == "0")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(RateCardDetailsProperty.ProjectSiteRoleID));
                }
                strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(RateCardDetailsProperty.WhichAction)) + "'";
                ProjectSiteRoleID = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return ProjectSiteRoleID;
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
        //public List<ProjectMilestoneDetails> GetMileStoneDetails([FromBody] ProjectMilestoneDetails MilesStoneDetailsProperty)
        public object GetMileStoneDetails([FromBody] ProjectMilestoneDetails MilesStoneDetailsProperty)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_tbl_Whizible2_PM_Milestone " + HttpUtility.UrlDecode(Convert.ToString(MilesStoneDetailsProperty.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(MilesStoneDetailsProperty.WhichAction)) + "'";

                List<ProjectMilestoneDetails> MilestoneDetails = new List<ProjectMilestoneDetails>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ProjectMilestoneDetails ObjMilestoneDetails = new ProjectMilestoneDetails()
                    {
                        MileStoneName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["MileStone"], "")),
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ProjectID"], "0")),
                        MileStoneID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["MileStoneID"], "0")),
                        StartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["PlannedCompletionDate"], "")),
                        EndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ActualCompletionDate"], "")),
                        BillAmount = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["BillAmount"], "0.0")),
                        MilestoneStatus = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["MilestoneStatus"], "")),
                        WhichAction = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["WhichAction"], "")),
                        Currency = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["Currency"], "")),
                        CompletionPercentage = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["CompletionPercentage"], "")),
                        ProjectValue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ProjectValue"], "")),
                        SumOfAllBillAmt = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["SumOfAllBillAmt"], "0.0")),
                        IsClosed = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["IsClosed"], "0")),
                        //ProjectBG = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["BusinessGroupID"], "0")),
                        //ProjectOU = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["LocationID"], "0")),
                    };
                    MilestoneDetails.Add(ObjMilestoneDetails);
                }

                return MilestoneDetails;
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
        //public List<ProjectSiteDetails> GetSiteDetails([FromBody] ProjectSiteDetails SiteDetailsProperty)
        public object GetSiteDetails([FromBody] ProjectSiteDetails SiteDetailsProperty)

        {
            try
            {
                string strSQL = "Exec Usp_Whizible2_Sel_tbl_Whizible2_PM_ProjectSites " + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.ProjectID));

                if (HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.ProjectSiteID)) == "0")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.ProjectSiteID));
                }
                strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.WhichAction)) + "'";
                List<ProjectSiteDetails> SiteDetails = new List<ProjectSiteDetails>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ProjectSiteDetails ObjSiteDetails = new ProjectSiteDetails()
                    {
                        ProjectSiteID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ProjectSiteID"], "0")),
                        Name = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["Name"], "")),
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ProjectID"], "0")),
                        CurrencyID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["CurrencyID"], "0")),
                        RateMethod = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["RateMethod"], "0")),
                        IsOffshore = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["IsOffshore"], "0")),
                        //Added By Usha Pandit On 14.01.2020 For Getting Freeze site details
                        Freeze = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["Freeze"], "0")),
                        //End Of Added By Usha Pandit On 14.01.2020 For Getting Freeze site details
                        StartingDayOfWeek = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["StartingDayOfWeek"], "0")),
                        WeekDays = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["WeekDays"], "0")),
                        WorkHrs = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["WorkHrs"], "0.0")),
                        HoursPerMonth = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["HoursPerMonth"], "0.0")),
                        WorkHoursCapPerDay = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["WorkHoursCapPerDay"], "0.0")),
                        ShortName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ShortName"], "")),
                        //WhichAction = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["WhichAction"], "")),
                        Address = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["Address"], "")),
                        Address1 = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["Address1"], "")),
                        CountryID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["CountryID"], "0")),
                        State = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["State"], "")),
                        City = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["City"], "")),
                        Zip = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["Zip"], "")),
                        Phone = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["Phone"], "")),
                        Fax = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["Fax"], "")),
                        EmailID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["EmailID"], "")),
                        Remarks = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["Remarks"], "")),
                    };
                    SiteDetails.Add(ObjSiteDetails);
                }
                return SiteDetails;
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
        //public List<ProjectRateCardDetails> GetRateCardDetails([FromBody] ProjectRateCardDetails RateCardDetailsProperty)
        public object GetRateCardDetails([FromBody] ProjectRateCardDetails RateCardDetailsProperty)

        {
            try
            {
                string strSQL = "Exec Usp_Whizible2_Sel_tbl_Whizible2_PM_ProjectSiteRole " + HttpUtility.UrlDecode(Convert.ToString(RateCardDetailsProperty.ProjectSiteID));

                if (HttpUtility.UrlDecode(Convert.ToString(RateCardDetailsProperty.ProjectSiteRoleID)) == "0")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(RateCardDetailsProperty.ProjectSiteRoleID));
                }
                strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(RateCardDetailsProperty.WhichAction)) + "'";
                List<ProjectRateCardDetails> RateCardDetails = new List<ProjectRateCardDetails>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ProjectRateCardDetails ObjRateCardDetails = new ProjectRateCardDetails()
                    {
                        ProjectSiteRoleID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ProjectSiteRoleID"], "0")),
                        ProjectSiteID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ProjectSiteID"], "0")),
                        RoleID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["RoleID"], "0")),
                        CurrencyCode = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["CurrencyCode"], "")),
                        CurrencyID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["CurrencyID"], "0")),
                        IsApplied = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["IsApplied"], "0")),
                        CTC = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["CTC"], "0.0")),
                        NormalRate = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["NormalRate"], "0.0")),
                        ExtraRate = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["ExtraRate"], "0.0")),
                        HolidayRate = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["HolidayRate"], "0.0")),
                        RoleDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["RoleDescription"], "")),
                        IsConvertedToProject = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["IsConvertedToProject"], "0")),
                    };
                    RateCardDetails.Add(ObjRateCardDetails);
                }
                return RateCardDetails;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize]
        [HttpPost]
        //public List<ProjectPercentageSettings> GetPercentageSettings([FromBody] ProjectPercentageSettings ProjectSettingsProperty)
        public object GetPercentageSettings([FromBody] ProjectPercentageSettings ProjectSettingsProperty)

        {
            try
            {
                string strSQL = "Exec Usp_Whizible2_Sel_tbl_PM_Project_PercentageSettings ";

                List<ProjectPercentageSettings> curProjectSettings = new List<ProjectPercentageSettings>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ProjectPercentageSettings ObjProjectSettings = new ProjectPercentageSettings()
                    {
                        ResourceCostPercent = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["ResourceCostPercent"], "0.0")),
                        ProfitMarginPercent = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["ProfitMarginPercent"], "0.0")),
                    };
                    curProjectSettings.Add(ObjProjectSettings);
                }
                return curProjectSettings;
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
        //public List<ResourceRole> GetResourceCostDetails([FromBody] ResourceRole ResourceRoleProperty)
        public object GetResourceCostDetails([FromBody] ResourceRole ResourceRoleProperty)

        {
            try
            {
                string strSQL = "Exec Usp_Whizible2_Sel_tbl_PM_DraftResourceCostDetail " + HttpUtility.UrlDecode(Convert.ToString(ResourceRoleProperty.ProjectID));

                strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(ResourceRoleProperty.WhichAction)) + "'";
                List<ResourceRole> ResourceRoleDetails = new List<ResourceRole>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ResourceRole ObjResourceRoleDetails = new ResourceRole()
                    {
                        ResourceCostID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ResourceCostID"], "0")),
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ProjectID"], "0")),
                        RoleID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["RoleID"], "0")),
                        RoleDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["RoleDescription"], "")),
                        CurrencyCode = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["CurrencyCode"], "")),
                        CurrencyName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["CurrencyName"], "")),
                        CurrencyID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["CurrencyID"], "0")),
                        StartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["StartDate"], "")),
                        EndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["EndDate"], "")),
                        PercentageAllocation = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["PercentageAllocation"], "0.00")),
                        ProjectValue = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["ProjectValue"], "0.00")),
                        //Commented & Added By Dipali V On 26th Oct 2023 For Convert double
                        //Budget = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["Budget"], "0.0")),
                        Budget = String.Format("{0:0.00}", CommonFunctions.Data.CheckIsDBNull(sdr["Budget"], "0.00")),
                        RoleCost = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["RoleCost"], "0.0")),
                        //TotalBudget = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["TotalBudget"], "0.0")),
                        TotalBudget = String.Format("{0:0.00}", CommonFunctions.Data.CheckIsDBNull(sdr["TotalBudget"], "0.00")),
                        //End of Commented & Added By Dipali V On 26th Oct 2023 For Convert double
                        ResourceCostPercentage = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["ResourceCostPercentage"], "0.0")),
                        ProfitMargin = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["ProfitMargin"], "0.0")),
                        ConversionRate = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["ConversionRate"], "0.0")),
                        BudgetAfterConversion = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["BudgetAfterConversion"], "0.0")),
                        NoOfResource = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["NoOfResource"], "0")),
                        IsConvertedToProject = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["IsConvertedToProject"], "0")),
                        IsOriginalBudgetChange = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["OriginalBudgetChange"], "0")),
                    };
                    ResourceRoleDetails.Add(ObjResourceRoleDetails);
                }
                return ResourceRoleDetails;
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
        //public List<ProjectCostDetails> GetProjectCostDetails([FromBody] ProjectCostDetails ProjectCostDetailsProperty)
        public object GetProjectCostDetails([FromBody] ProjectCostDetails ProjectCostDetailsProperty)

        {
            try
            {
                string strSQL = "Exec Usp_Whizible2_Sel_tbl_Whizible2_PM_Draft_WorkOrderCosts " + HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.ProjectID)) + "";

                if (HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.CostHeadID)) == "0")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.CostHeadID));
                }
                if (HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.WorkOrderCostID)) == "0")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.WorkOrderCostID));
                }
                strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.WhichAction)) + "'";
                List<ProjectCostDetails> projectCostDetails = new List<ProjectCostDetails>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ProjectCostDetails ObjProjectCostDetails = new ProjectCostDetails()
                    {
                        WorkOrderCostID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["WorkOrderCostID"], "0")),
                        CostHeadID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["CostHeadID"], "0")),
                        CostHead = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["CostHead"], "")),
                        CostGroup = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["CostGroup"], "")),
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ProjectID"], "0")),
                        CurrencyCode = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["CurrencyCode"], "")),
                        CurrencyID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["CurrencyID"], "0")),
                        CurrencySymbol = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["CurrencySymbol"], "")),
                        IsActive = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["IsActive"], "0")),
                         CostToCompany = String.Format("{0:0.00}", CommonFunctions.Data.CheckIsDBNull(sdr["CostToCompany"], "0.00")),
                        //Commented By Dipali V On 26th Oct 2023 For Conversion to double
                         //CostToCompany = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["CostToCompany"], "")),
                        //Reimbersable = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["Reimbersable"], "0.00")),
                        //Reimbersable = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["Reimbersable"], "")),
                        Reimbersable = String.Format("{0:0.00}", CommonFunctions.Data.CheckIsDBNull(sdr["Reimbersable"], "0.00")),
                        //Billable = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["BillableValue"], "0.00")),
                        //Billable = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["BillableValue"], "")),
                        Billable = String.Format("{0:0.00}", CommonFunctions.Data.CheckIsDBNull(sdr["BillableValue"], "0.00")),
                        IsSetByUser = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["IsSetByUser"], "0.0")),
                        //TotalCostToCompany = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["TotalCostToCompany"], "")),
                        //TotalReimbersable = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["TotalReimbersable"], "")),
                        //TotalBillable = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["TotalBillable"], "")),
                        TotalCostToCompany = String.Format("{0:0.00}", CommonFunctions.Data.CheckIsDBNull(sdr["TotalCostToCompany"], "0.00")),
                        TotalReimbersable = String.Format("{0:0.00}", CommonFunctions.Data.CheckIsDBNull(sdr["TotalReimbersable"], "0.00")),
                        TotalBillable = String.Format("{0:0.00}", CommonFunctions.Data.CheckIsDBNull(sdr["TotalBillable"], "0.00")),
                        //Commented By Dipali V On 26th Oct 2023 For Conversion to double
                        Description = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["Description"], "")),
                        IsConvertedToProject = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["IsConvertedToProject"], "0")),
                    };
                    projectCostDetails.Add(ObjProjectCostDetails);
                }
                return projectCostDetails;
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
        //public List<ProjectCostHeadDetails> GetProjectCostHeadDetails([FromBody] ProjectCostHeadDetails ProjectCostHeadDetailsProperty)
        public object GetProjectCostHeadDetails([FromBody] ProjectCostHeadDetails ProjectCostHeadDetailsProperty)

        {
            try
            {
                string strSQL = "Exec Usp_Whizible2_Sel_tbl_Whizible2_PM_Draft_WorkOrderCostsDetails ";

                if (HttpUtility.UrlDecode(Convert.ToString(ProjectCostHeadDetailsProperty.WorkOrderCostID)) == "0")
                {
                    strSQL += " NULL";
                }
                else
                {
                    strSQL += HttpUtility.UrlDecode(Convert.ToString(ProjectCostHeadDetailsProperty.WorkOrderCostID));
                }

                strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectCostHeadDetailsProperty.WhichAction)) + "'";
                if (HttpUtility.UrlDecode(Convert.ToString(ProjectCostHeadDetailsProperty.WorkOrderCostDetailID)) == "0")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(ProjectCostHeadDetailsProperty.WorkOrderCostDetailID));
                }
                List<ProjectCostHeadDetails> projectCostHeadDetails = new List<ProjectCostHeadDetails>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ProjectCostHeadDetails ObjProjectCostHeadDetails = new ProjectCostHeadDetails()
                    {
                        WorkOrderCostID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["WorkOrderCostID"], "0")),
                        WorkOrderCostDetailID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["WorkOrderCostDetailID"], "0")),
                        StartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["StartDate"], "")),
                        EndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["EndDate"], "")),
                        LastDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["LastDate"], "")),
                        LastDateId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["LastDateId"], "0")),
                        IsPublic_YesNo = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["IsPublic_YesNo"], "")),

                        UserCanOverride_YesNo = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["UserCanOverride_YesNo"], "")),
                        Billable_YesNo = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["Billable_YesNo"], "")),
                        IsConvertedToProject = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["IsConvertedToProject"], "0")),
                    };
                    projectCostHeadDetails.Add(ObjProjectCostHeadDetails);
                }
                return projectCostHeadDetails;
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
        //public List<ProjectCostDetails> GetProjectCostHeads([FromBody] ProjectCostDetails ProjectCostDetailsProperty)
        public object GetProjectCostHeads([FromBody] ProjectCostDetails ProjectCostDetailsProperty)

        {
            try
            {
                string strSQL = "Exec Usp_Whizible2_Sel_tbl_CNF_CostHeads ";
                if (HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.ProjectID)) == "0")
                {
                    strSQL += " NULL";
                }
                else
                {
                    strSQL += "" + HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.ProjectID));
                }
                strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.CostGroupID));
                strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.WhichAction)) + "'";

                List<ProjectCostDetails> ProjectCostHeadsDetails = new List<ProjectCostDetails>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ProjectCostDetails ObjProjectCostHeadsDetails = new ProjectCostDetails()
                    {
                        CostHeadID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["CostHeadID"], "0")),
                        CostHead = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["CostHead"], "")),
                    };
                    ProjectCostHeadsDetails.Add(ObjProjectCostHeadsDetails);
                }

                return ProjectCostHeadsDetails;
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
        //public List<ProjectCostDetails> GetProjectCostGroups([FromBody] ProjectCostDetails ProjectCostDetailsProperty)
        public object GetProjectCostGroups([FromBody] ProjectCostDetails ProjectCostDetailsProperty)

        {
            try
            {
                string strSQL = "Exec Usp_Whizible2_Sel_tbl_CNF_CostGroups ";
                if (HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.ProjectID)) == "0")
                {
                    strSQL += " NULL";
                }
                else
                {
                    strSQL += "" + HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.ProjectID));
                }

                strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectCostDetailsProperty.WhichAction)) + "'";

                List<ProjectCostDetails> ProjectCostHeadsDetails = new List<ProjectCostDetails>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ProjectCostDetails ObjProjectCostHeadsDetails = new ProjectCostDetails()
                    {
                        CostGroupID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["CostGroupID"], "0")),
                        CostGroup = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["CostGroup"], "")),
                    };
                    ProjectCostHeadsDetails.Add(ObjProjectCostHeadsDetails);
                }

                return ProjectCostHeadsDetails;
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
        //public List<ProjectRateCardDetails> GetTemplateRateCard([FromBody] ProjectRateCardDetails ProjectRateCardDetailsProperty)
        public object GetTemplateRateCard([FromBody] ProjectRateCardDetails ProjectRateCardDetailsProperty)
        {
            try
            {
                string strSQL = "Exec Usp_Whizible2_Sel_tbl_PM_CustomerTemplate ";
                if (HttpUtility.UrlDecode(Convert.ToString(ProjectRateCardDetailsProperty.CustomerID)) == "0")
                {
                    strSQL += " NULL";
                }
                else
                {
                    strSQL += "" + HttpUtility.UrlDecode(Convert.ToString(ProjectRateCardDetailsProperty.CustomerID));
                }

                List<ProjectRateCardDetails> ProjectRateCardDetails = new List<ProjectRateCardDetails>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ProjectRateCardDetails ObjProjectRateCardDetails = new ProjectRateCardDetails()
                    {
                        TemplateID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["TemplateID"], "0")),
                        TemplateName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["TemplateName"], "")),
                        SiteCount = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["SiteCount"], "0")),
                    };
                    ProjectRateCardDetails.Add(ObjProjectRateCardDetails);
                }

                return ProjectRateCardDetails;
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
        //public List<ProjectMilestoneDetails> BindMileStoneDetails([FromBody] ProjectMilestoneDetails MilesStoneDetailsProperty)
        public object BindMileStoneDetails([FromBody] ProjectMilestoneDetails MilesStoneDetailsProperty)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_tbl_Whizible2_PM_BindMilestones " + HttpUtility.UrlDecode(Convert.ToString(MilesStoneDetailsProperty.MileStoneID)) + "," + HttpUtility.UrlDecode(Convert.ToString(MilesStoneDetailsProperty.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(MilesStoneDetailsProperty.WhichAction)) + "'";

                List<ProjectMilestoneDetails> MilestoneDetails = new List<ProjectMilestoneDetails>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ProjectMilestoneDetails ObjMilestoneDetails = new ProjectMilestoneDetails()
                    {
                        MileStoneName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["MileStone"], "")),
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ProjectID"], "0")),
                        MileStoneID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["MileStoneID"], "0")),
                        StartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["PlannedCompletionDate"], "")),
                        EndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ActualCompletionDate"], "")),
                        BillAmount = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["BillAmount"], "0.0")),
                        MilestoneStatus = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["MilestoneStatus"], "")),
                        WhichAction = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["WhichAction"], "")),
                        Currency = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["Currency"], "0")),
                        ProjectValue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ProjectValue"], "")),
                        SumOfAllBillAmt = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["SumOfAllBillAmt"], "0.0")),
                        //ProjectBG = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["BusinessGroupID"], "0")),
                        //ProjectOU = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["LocationID"], "0")),
                    };
                    MilestoneDetails.Add(ObjMilestoneDetails);
                }

                return MilestoneDetails;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize]
        [HttpPost]
        //public List<SiteRole> GetProjectSiteRole([FromBody] SiteRole SiteRoleProperty)
        public object GetProjectSiteRole([FromBody] SiteRole SiteRoleProperty)

        {
            try
            {
                //Commented & Added By Dipali V On 9th Dec 2020 For get Low level Role 
                string strSQL = "Exec Usp_Whizible2_Sel_tbl_PM_Roles_ProjectSite " + HttpUtility.UrlDecode(Convert.ToString(SiteRoleProperty.ProjectSiteID)) + "";

                // string strSQL = "Exec Usp_Whizible2_Sel_tbl_PM_Roles_ProjectSite " + HttpUtility.UrlDecode(Convert.ToString(SiteRoleProperty.ProjectSiteID)) + "";
                strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(SiteRoleProperty.WhichAction)) + "'";
                List<SiteRole> SiteRoleDetails = new List<SiteRole>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    SiteRole ObjSiteRole = new SiteRole()
                    {
                        Role = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["Role"], "0")),
                        roleDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["roleDescription"], "")),
                    };
                    SiteRoleDetails.Add(ObjSiteRole);
                }

                return SiteRoleDetails;
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
        public object GetResourceCostRole([FromBody] ResourceRole ResourceRoleProperty)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Role_PopulateCombo  " + ResourceRoleProperty.RequestID + "";


                List<ResourceRole> ResourceRoleDetails = new List<ResourceRole>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ResourceRole ObjResourceRole = new ResourceRole()
                    {
                        RoleID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["RoleID"], "0")),
                        RoleDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["RoleDescription"], "")),
                    };
                    ResourceRoleDetails.Add(ObjResourceRole);
                }

                return ResourceRoleDetails;
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
        //public List<ResourceRole> GetRatePerHour([FromBody] ResourceRole ResourceRoleProperty)
        public object GetRatePerHour([FromBody] ResourceRole ResourceRoleProperty)

        {
            try
            {
                string strSQL = "Exec Usp_Whizible2_Sel_tbl_PM_ResourceRole_RatePerHour " + ResourceRoleProperty.RoleID + "";

                List<ResourceRole> ResourceRoleDetails = new List<ResourceRole>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ResourceRole ObjResourceRole = new ResourceRole()
                    {
                        RoleCost = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["RoleCost"], "0.0")),
                    };
                    ResourceRoleDetails.Add(ObjResourceRole);
                }

                return ResourceRoleDetails;
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
        //public List<ContractTypeDetails> CheckMilestoneSiteActiveDeactive([FromBody] ContractTypeDetails ContractTypeDetailsProperty)
        public object CheckMilestoneSiteActiveDeactive([FromBody] ContractTypeDetails ContractTypeDetailsProperty)

        {
            try
            {
                string strSQL = "Exec Usp_Whizible2_Chk_ContractType_Milestone_Site_Active " + ContractTypeDetailsProperty.ContractTypeID + ", '" + ContractTypeDetailsProperty.WhichAction + "'";

                List<ContractTypeDetails> contractTypeDetails = new List<ContractTypeDetails>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ContractTypeDetails ObjContractType = new ContractTypeDetails()
                    {
                        MilestoneActive = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["MilestoneActive"], "0")),
                        SiteActive = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["SiteActive"], "0")),
                    };
                    contractTypeDetails.Add(ObjContractType);
                }

                return contractTypeDetails;
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
        public object chkProjectNameExists([FromBody]ProjectDetails ProjectDetailsProperty)
        {
            try
            {
                string strSQL = "";

                if (HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.Flag)) == "Project Name")
                {
                    strSQL = "Exec usp_Whizible2_chk_Project_Exists '" + HttpUtility.UrlDecode(ProjectDetailsProperty.ProjectName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "', " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectID)) + ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.Flag)) + "', '" + HttpUtility.UrlDecode(ProjectDetailsProperty.WhichAction) + "'";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_chk_Project_Exists '" + HttpUtility.UrlDecode(ProjectDetailsProperty.AbbProjectName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "', " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectID)) + ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.Flag)) + "', '" + HttpUtility.UrlDecode(ProjectDetailsProperty.WhichAction) + "'";
                }

                string Flag;

                Flag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

                return Flag;
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
        public object chkSiteExists([FromBody]ProjectSiteDetails Parameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_chk_Site_Exists '" + HttpUtility.UrlDecode(Parameters.Name).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "', " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectSiteID)) + ", '" + HttpUtility.UrlDecode(Parameters.WhichAction) + "'";

                string Flag;

                Flag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

                return Flag;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Usha Pandit On 18.01.2020 For Resource work hour validation
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        public object getResourceHours([FromBody]ProjectSiteDetails Parameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_SumPlannedWorkHours " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));

                Double WorkHr;

                WorkHr = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "0.0"));

                return WorkHr;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End Of Added By Usha Pandit On 18.01.2020 For Resource work hour validation

        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        public object chkMileStoneExists([FromBody]ProjectMilestoneDetails Parameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_chk_Milestone_Exists '" + HttpUtility.UrlDecode(Parameters.MileStoneName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "', " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.MileStoneID)) + ", '" + HttpUtility.UrlDecode(Parameters.WhichAction) + "'";

                string Flag;

                Flag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

                return Flag;
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
        //public List<ProjectDetails> GetEmployeeSpecificBGOU([FromBody] ProjectDetails Projectproperty)
        public object GetEmployeeSpecificBGOU([FromBody] ProjectDetails Projectproperty)

        {
            try
            {
                string strSQL = "Exec usp_Whizible_sel_EmployeeSpecificBGOU " + Projectproperty.UserID + "";

                List<ProjectDetails> Details = new List<ProjectDetails>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ProjectDetails ObjDetails = new ProjectDetails()
                    {
                        ProjectBG = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["BusinessGroupID"], "0")),
                        ProjectOU = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["locationID"], "")),
                    };
                    Details.Add(ObjDetails);
                }

                return Details;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Usha Pandit On 12.11.2019 To Get Discussion Details
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        //public List<GetProjectDiscussions> GetDiscussions([FromBody]ProjectDiscussionsParameter Parameters)
        public object GetDiscussions([FromBody] ProjectDiscussionsParameter Parameters)

        {
            try
            {
                string strSQL = "";
                string currentFlag = "";
                currentFlag = HttpUtility.UrlDecode(Parameters.Flag);

                if (currentFlag == "Draft Project")
                {
                    strSQL = "Exec Usp_Whizible2_Sel_tbl_Whizible2_ProjInfo_DiscussionThread " + HttpUtility.UrlDecode(Convert.ToString(Parameters.UniqueID));
                }
                if (currentFlag == "Project")
                {
                    strSQL = "Exec Usp_Whizible2_Sel_tbl_Whizible2_ProjInfo_DiscussionThread " + HttpUtility.UrlDecode(Convert.ToString(Parameters.UniqueID)) + ", 'C'";
                }

                DataTable DiscussionsListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<GetProjectDiscussions> DiscussionsLists = new List<GetProjectDiscussions>();

                foreach (DataRow DiscussionsList in DiscussionsListTable.Rows)
                {
                    GetProjectDiscussions DiscussionsListQuery = new GetProjectDiscussions()
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

        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveDiscussion([FromBody]ProjectDiscussionsParameter Parameters)
        {
            try
            {
                string strSQL = "";
                string currentFlag = "";
                currentFlag = HttpUtility.UrlDecode(Parameters.Flag);
                //Commented and Modified By Nikhil Adkar for Saving the comment On project information
                //if (currentFlag == "Draft Project")
                //{
                //    strSQL = "Exec Usp_Whizible2_Ins_tbl_Whizible2_ProjInfo_DiscussionThread " + HttpUtility.UrlDecode(Convert.ToString(Parameters.UniqueID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ParentID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.LoginID)) + ",'" + HttpUtility.UrlDecode(Parameters.DiscussionThread).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.SubmittedBy) + "','" + HttpUtility.UrlDecode(Parameters.LoginType) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.IsShowToCustomer)) + ",'" + HttpUtility.UrlDecode(Parameters.DiscussionLevel) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ReplyIndex)) + "";
                //}
                //if (currentFlag == "Project")
                //{
                //    strSQL = "Exec usp_Ins_tbl_PM_ProjInfo_Discussions " + HttpUtility.UrlDecode(Convert.ToString(Parameters.UniqueID)) + ",'" + HttpUtility.UrlDecode(Parameters.SubmittedBy) + "','" + HttpUtility.UrlDecode(Parameters.DiscussionThread).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.IsShowToCustomer)) + "";

                //}
                strSQL = "Exec Usp_Whizible2_Ins_tbl_Whizible2_ProjInfo_DiscussionThread " + HttpUtility.UrlDecode(Convert.ToString(Parameters.UniqueID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ParentID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.LoginID)) + ",'" + HttpUtility.UrlDecode(Parameters.DiscussionThread).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.SubmittedBy) + "','" + HttpUtility.UrlDecode(Parameters.LoginType) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.IsShowToCustomer)) + ",'" + HttpUtility.UrlDecode(Parameters.DiscussionLevel) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ReplyIndex)) + "";
                //End of Commeneted and Modified By Nikhil Adkar
                string Message;

                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End Of Added By Usha Pandit On 12.11.2019 To Get Discussion Details

        //Added By Usha Pandit On 14.01.2020 For Freezing Site
        //Freeze Site
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object FreezeSite([FromBody]ProjectSiteDetails SiteDetailsProperty)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec Usp_Whizible2_Upd_tbl_PM_ProjectSiteCalendar_Freeze " + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.ProjectSiteID)) + ", 1, '" + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.WhichAction)) + "'";

                string Message;

                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End Of Added By Usha Pandit On 14.01.2020 For Freezing Site

        //Added By Usha Pandit On 14.01.2020 For Updating Billing Info
        //Update Billing Info
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateBillingInfo([FromBody]ProjectSiteDetails SiteDetailsProperty)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec Usp_Whizible2_Upd_RatesToEmployeeBillingInfo " + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.ProjectSiteID)) + ", '" + HttpUtility.UrlDecode(Convert.ToString(SiteDetailsProperty.WhichAction)) + "'";

                string Message;

                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End Of Added By Usha Pandit On 14.01.2020 For Updating Billing Info

        //Practice Settings Integration Start
        CreateProject createproject = new CreateProject();
        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
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

        //Practice Settings Integration End





        //Added By Dipali V On 22nd Jan 2021 For to check Checklist is mandatory or not to WF
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        public object CheckWFChecklistMadatory([FromBody]ProjectSiteDetails Parameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_CheckWorkflowchecklist " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameters.StrUserName)) + "'";

                string Flag;

                Flag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

                return Flag;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //End of Added By Dipali V On 22nd Jan 2021 For to check Checklist is mandatory or not to WF

        //WorkFlow Starting 

        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        // public string PlotWorkflowLinks([FromBody] WBSParametersWorkFlow )
        public object PlotWorkflowLinks([FromBody] ProjectWorkFlow ParametersWorkFlows)
        {
            try
            {
                string strLinks = "";
                string strSQL = "usp_get_WorkflowLinkAccess ";
                System.Text.StringBuilder sbScript = new System.Text.StringBuilder();

                string strPrimaryKeyName = "";
                string strtablename = "";
                var strPageName = "";
                string strLinkName = "";
                string strIsApproverConfigured = "";
                string strRequestStage = "";
                string WFID = "";
                int iIsDocumentUploaded = 0;
                string WorkflowInstanceID = "";


                if (ParametersWorkFlows.strPrimaryKey.ToString() != "")
                {
                    strSQL += ParametersWorkFlows.strPrimaryKey;
                    strSQL += "," + ParametersWorkFlows.TagID;
                    strSQL += "," + ParametersWorkFlows.UserID;

                    strSQL += "," + ParametersWorkFlows.ProjectID;
                    strSQL += "," + ParametersWorkFlows.RoleID;

                    IDataReader drAttributeDetails;
                    drAttributeDetails = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                    if (drAttributeDetails.Read())
                    {
                        strPrimaryKeyName = Convert.ToString(drAttributeDetails["PrimaryKeyName"]);
                        strtablename = Convert.ToString(drAttributeDetails["tablename"]);
                        strPageName = Convert.ToString(drAttributeDetails["PageName"]);
                        strLinkName = Convert.ToString(drAttributeDetails["LinkName"]);
                    }

                    switch (strLinkName)
                    {
                        case "APPROVE":
                            {
                                strSQL = "usp_whizible2_sel_IsApproverConfigured_forStage ";
                                strSQL += ParametersWorkFlows.strPrimaryKey;
                                strSQL += "," + ParametersWorkFlows.TagID;
                                strSQL += ",'A'";
                                strSQL += "," + ParametersWorkFlows.UserID;
                                IDataReader dr;
                                //dr =  CommonFunctions.Data.GetDataReader(strSQL, true);
                                dr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                                while (dr.Read())
                                {
                                    strIsApproverConfigured = Convert.ToString(dr["IsAppSelected"]);
                                    strRequestStage = Convert.ToString(dr["Stage"]);
                                    iIsDocumentUploaded = Convert.ToInt32(dr["IsDocumentUploaded"]);
                                    WFID = Convert.ToString(dr["WFID"]);
                                    WorkflowInstanceID = Convert.ToString(dr["WorkflowInstanceID"]);
                                }



                                sbScript.Append("<a class='nobtnstyle - xs' id ='btnApproved_" + ParametersWorkFlows.TagID + "' onclick=\"Javascript:Approve_Onclick(" + WFID + "," + WorkflowInstanceID + "," + +ParametersWorkFlows.TagID + ", " + ParametersWorkFlows.strPrimaryKey + ",'Approve','" + strPrimaryKeyName.ToString() + "'," + strIsApproverConfigured.ToString() + ",'" + strRequestStage.ToString() + "')\"  data-toggle='modal'  >Approve</a>");// data - target = '#divAppReject'


                                strSQL = "usp_whizible2_sel_IsApproverConfigured_forStage ";
                                strSQL += ParametersWorkFlows.strPrimaryKey;
                                strSQL += "," + ParametersWorkFlows.TagID;
                                strSQL += ",'R'";
                                strSQL += "," + ParametersWorkFlows.UserID;

                                strIsApproverConfigured = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                                // dr = CommonFunctions.Data.GetDataReader(strSQL, true);
                                dr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                                while (dr.Read())
                                {
                                    strIsApproverConfigured = Convert.ToString(dr["IsAppSelected"]);
                                    strRequestStage = Convert.ToString(dr["Stage"]);
                                    WFID = Convert.ToString(dr["WFID"]);
                                    WorkflowInstanceID = Convert.ToString(dr["WorkflowInstanceID"]);
                                }
                                //sbScript.Append("<a class='nobtnstyle - xs' id ='btnRejectApproved_" + ParametersWorkFlows.TagID + "' onclick=\"Javascript:Reject_Onclick(" + WFID + "," + WorkflowInstanceID + "," + ParametersWorkFlows.TagID + "," + ParametersWorkFlows.strPrimaryKey + ",'Reject','" + strPrimaryKeyName.ToString() + "'," + strIsApproverConfigured.ToString() + ",'" + strRequestStage.ToString() + "')\"  data-toggle='modal' data-target='#divAppReject' >Reject</a>");
                                sbScript.Append("<a class='nobtnstyle - xs' id ='btnRejectApproved_" + ParametersWorkFlows.TagID + "' onclick=\"Javascript:Reject_Onclick(" + WFID + "," + WorkflowInstanceID + "," + ParametersWorkFlows.TagID + "," + ParametersWorkFlows.strPrimaryKey + ",'Reject','" + strPrimaryKeyName.ToString() + "'," + strIsApproverConfigured.ToString() + ",'" + strRequestStage.ToString() + "')\"  data-toggle='modal'  >Reject</a>");
                                break;
                            }

                        case "SUBMIT":
                            {
                                if (ParametersWorkFlows.strPrimaryKey.ToString() == "")
                                    // sbScript.Append("| <A class='Menu' style='TEXT-DECORATION:NONE' HREF=""Javascript:Submit_Onclick(" + lngTagID.ToString + "," + strPrimaryKey.ToString + ",'" + strPageName.ToString + "','" + strPrimaryKeyName.ToString + "','ADD_NEW')"" Title=""Submit"" >Send for Approval</A> ")
                                    sbScript.Append("<a class='nobtnstyle - xs' id ='btnSendforApproval_" + ParametersWorkFlows.TagID + "' onclick=\"Javascript:Submit_Onclick(" + ParametersWorkFlows.TagID + ",'Send for Approval','" + ParametersWorkFlows.strPrimaryKey + "','ADD_NEW')\"  data-toggle='modal' data-target='' >Send for Approval</a>");
                                else
                                    // sbScript.Append("| <A class='Menu' style='TEXT-DECORATION:NONE' HREF=""Javascript:Submit_Onclick(" + lngTagID.ToString + "," + strPrimaryKey.ToString + ",'" + strPageName.ToString + "','" + strPrimaryKeyName.ToString + "','Edit')"" Title=""Submit"" >Send for Approval</A> ")
                                    sbScript.Append("<a class='nobtnstyle - xs' id ='btnSendforApproval_" + ParametersWorkFlows.TagID + "' onclick=\"Javascript:Submit_Onclick(" + ParametersWorkFlows.TagID.ToString() + ",'Send for Approval','" + ParametersWorkFlows.strPrimaryKey + "','Edit')\"  data-toggle='modal' data-target='' >Send for Approval</a>");
                                break;
                            }
                    }
                }



                return sbScript.ToString();
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
        // public string PlotWorkflowLinks([FromBody] WBSParametersWorkFlow )
        public object RevisionLink([FromBody] ProjectWorkFlow ParametersWorkFlows)
        {
            try
            {
                //  string strResult = "";
                System.Text.StringBuilder sbScript = new System.Text.StringBuilder();
                string strSql = "";
                string strResult = "";
                int strPrimaryKey = 0;
                strSql = "usp_Show_RevisionLink " + ParametersWorkFlows.strPrimaryKey + "," + ParametersWorkFlows.TagID + "," + ParametersWorkFlows.UserID + "," + ParametersWorkFlows.ProjectID + "," + ParametersWorkFlows.RoleID;
                //strResult = CommonFunctions.Data.GetDataScalar(strSql, True);
                strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSql, true, CommonController.connectionString));
                if (strResult == "1")
                {
                    //sbScript.Append("<a class='nobtnstyle - xs' id ='btnRevision_" + ParametersWorkFlows.TagID + "' onclick=\"Javascript:RevisionOnclick(" + ParametersWorkFlows.strPrimaryKey + "," + ParametersWorkFlows.TagID + ")\" data-toggle='modal' data-target='#divRevision'>Revision</a>");//data-toggle='modal' data-target='#divRevision'
                    sbScript.Append("<a class='nobtnstyle - xs' id ='btnRevision_" + ParametersWorkFlows.TagID + "' onclick=\"Javascript:RevisionOnclick(" + ParametersWorkFlows.strPrimaryKey + "," + ParametersWorkFlows.TagID + ")\" data-bs-toggle='modal' data-bs-target='#divRevision'>Revision</a>");//data-toggle='modal' data-target='#divRevision'
                }
                return sbScript.ToString();
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
        // public string PlotWorkflowLinks([FromBody] WBSParametersWorkFlow )
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object PerformRevision([FromBody] ProjectWorkFlow ParametersWorkFlows)
        {

            try
            {

                string strSQL = "";
                strSQL = "Usp_Upd_BaseLineStatus " + ParametersWorkFlows.strPrimaryKey + "," + ParametersWorkFlows.TagID + ",'" + ParametersWorkFlows.UserName + "'";
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                string strSQL1 = "";
                strSQL1 = "usp_Whizible2_ins_tbl_whizible2_RevisionDetails " + ParametersWorkFlows.TagID + "," + ParametersWorkFlows.UserID + "," + ParametersWorkFlows.ProjectID + "," + ParametersWorkFlows.WBSID + ",'" + ParametersWorkFlows.Remarks + "','" + ParametersWorkFlows.UserName + "'";
                CommonFunctions.Data.InsertOrUpdateData(strSQL1, true, CommonController.connectionString);

                string StrRevision = "";
                StrRevision = "usp_Ins_tbl_PM_ProjectRevision_Revision " + ParametersWorkFlows.ProjectID + "";
                CommonFunctions.Data.InsertOrUpdateData(StrRevision, true, CommonController.connectionString);



                return "1";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Dipali V on 11th Dec 2020
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        public object chkInheritDataLink([FromBody]ProjectSiteDetails Parameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_CheckInheriateDataLink  " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "";
                string Flag;

                Flag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

                return Flag;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Dipali V on 11th Dec 2020

        //For CheckList Response 
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        //public List<LinkStatus> GetLinksAfterWorkFlowEnabled([FromBody]ProjectWorkFlow ParametersWorkFlows)
        public object GetLinksAfterWorkFlowEnabled([FromBody] ProjectWorkFlow ParametersWorkFlows)

        {
            try
            {
                List<LinkStatus> ls = new List<LinkStatus>();
                ////string[] arr = { "CR", "HT", "HP", "RT", "RP", "RH" };
                ////for (int i = 0; i < arr.Length; i++)
                ////{


                ////    string Flag = "";
                ////    string strSQL1 = "";
                ////    string strSQL = "usp_Whizible2_get_LinkAccess_ConfigurableWorkflow_Actions ";


                ////    strSQL += Convert.ToString(ParametersWorkFlows.ProjectID);
                ////    strSQL += "," + ParametersWorkFlows.UserID;
                ////    strSQL += "," + ParametersWorkFlows.TagID;
                ////    strSQL += ",'" + arr[i] + "'";



                ////    Flag = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                ////    if (arr[i] == "RH")
                ////    {
                ////        strSQL1 = "usp_Whizible2_GetRevisionhistory ";
                ////        strSQL1 += Convert.ToString(ParametersWorkFlows.ProjectID);
                ////        strSQL1 += ",'" + ParametersWorkFlows.LoginType + "'";
                ////        Flag = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString));
                ////    }

                ////    ls.Add(new LinkStatus() { 
                ////    Flag = arr[i],
                ////    IsEnabled = Flag
                ////    });

                ////}

                ////return ls;//Flag.ToString();
                string Flag = "";
                string strSQL1 = "";
                string strSQL = "usp_Whizible2_get_LinkAccess_ConfigurableWorkflow_Actions ";

                strSQL += Convert.ToString(ParametersWorkFlows.ProjectID);
                strSQL += "," + ParametersWorkFlows.UserID;
                strSQL += "," + ParametersWorkFlows.TagID;
                strSQL += ",'" + ParametersWorkFlows.WhichFlag + "'";

                Flag = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                if (ParametersWorkFlows.WhichFlag == "RH")
                {
                    strSQL1 = "usp_Whizible2_GetRevisionhistory ";
                    strSQL1 += Convert.ToString(ParametersWorkFlows.ProjectID);
                    strSQL1 += ",'" + ParametersWorkFlows.LoginType + "'";
                    Flag = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString));
                }

                ls.Add(new LinkStatus()
                {
                    Flag = ParametersWorkFlows.WhichFlag,
                    IsEnabled = Flag
                });
                return ls;
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
        public object GetRevisionHistory([FromBody]ProjectWorkFlow ParametersWorkFlows)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_GetProjectRevisionHistoryDetails " + HttpUtility.UrlDecode(Convert.ToString(ParametersWorkFlows.ProjectID)) + "";


                DataTable Revisionhistory;
                Revisionhistory = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return Revisionhistory;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by Chetan M on 3 Aug 2021 for Capture History
        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        public object GetProjectHistory([FromBody] ProjectWorkFlow ParametersWorkFlows)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_tbl_Whizible2_tbl_PM_Project_AuditTrail_History " + HttpUtility.UrlDecode(Convert.ToString(ParametersWorkFlows.ProjectID)) + "";


                DataTable Projecthistory;
                Projecthistory = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return Projecthistory;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added by Chetan M on 3 Aug 2021 for Capture History

        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        // public string PlotWorkflowLinks([FromBody] WBSParametersWorkFlow )
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object TakeActionHPHTBT([FromBody] ProjectWorkFlow ParametersWorkFlows)
        {
            try
            {

                string strSQL = "";
                if (ParametersWorkFlows.WhichFlag == "HT" || ParametersWorkFlows.WhichFlag == "RT") //Block Timesheet,Resume Timesheet
                {
                    strSQL = "usp_Whizible2_Upd_WorkflowInstance_TimesheetBlock " + ParametersWorkFlows.ProjectID + ",NULL," + ParametersWorkFlows.TagID + ",'" + ParametersWorkFlows.Remarks.Replace("'", "''") + "'";
                }
                else if (ParametersWorkFlows.WhichFlag == "HP" || ParametersWorkFlows.WhichFlag == "RP") //Put on hold,Resume project
                {
                    strSQL = "usp_Whizible2_UPD_ProjectStatus_ConfigurableWorkflow " + ParametersWorkFlows.ProjectID + ",'" + ParametersWorkFlows.Remarks.Replace("'", "''") + "','" + ParametersWorkFlows.UserName + "'";
                }


                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return "1";
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
        public object GetComments([FromBody] ProjectWorkFlow ParametersWorkFlows)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_get_WorkflowActions_Comments " + HttpUtility.UrlDecode(Convert.ToString(ParametersWorkFlows.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ParametersWorkFlows.TagID)) + "";


                DataTable Comments;
                Comments = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return Comments;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Dipali V On 7th Jan 2020 For WF Refresh Issues
        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        public object GetSelectedWorkfLOW([FromBody] ProjectWorkFlow ParametersWorkFlows)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_GetSeletedWorkFlow " + HttpUtility.UrlDecode(Convert.ToString(ParametersWorkFlows.GlobalUniqueID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ParametersWorkFlows.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ParametersWorkFlows.ProjectID)) + "";


                DataTable SelectedWF;
                SelectedWF = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return SelectedWF;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added by Dipali V On 7th Jan 2020 For WF Refresh Issues

        //Added By Rutuja D. on 26 March 2020 For Issueid = 23015
        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        public object GetBusinessGroup([FromBody] string ProjectID)
        {
            try
            {

                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_CNF_BusinessGroup 1,0," + Convert.ToInt32(ProjectID);
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End Added By Rutuja D. on 26 March 2020 For Issueid = 23015

        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        public object GetWFName([FromBody] string projectId)
        {
            try
            {
                string result = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Sel_ProjectWorkflowName " + projectId, true, CommonController.connectionString), "").ToString();
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        // Added By Imran M 01-07-2021

        // Added By Imran check GetCorporateRoleLevel
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        public object GetCorporateRoleLevel([FromBody] CustomFiledsProperty CustomFiledsProperty)
        {
            try
            {
                string strsql = "Exec usp_sel_tbl_PM_Role_Level_EmployeeID " + CustomFiledsProperty.UserID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        // Added By Imran Get RoleId
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        public object GetRoleId([FromBody] CustomFiledsProperty CustomFiledsProperty)
        {
            try
            {
                string strsql = "Exec usp_sel_tbl_PM_ProjectEmployeeRole_Role " + CustomFiledsProperty.ProjectID + "," + CustomFiledsProperty.UserID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added By Imran To get the Custom Fields list 
        [Authorize]
        [HttpPost]
        public object GetCustomFieldIDList([FromBody] CustomFiledsProperty CustomFiledsProperty)
        {
            try
            {
                string strsql = "Exec usp_sel_tbl_PM_RoleCustomFieldSecurity " + CustomFiledsProperty.ProjectID + "," + CustomFiledsProperty.RoleId + "," + CustomFiledsProperty.EmployeeID + "," + CustomFiledsProperty.EntityName + "," + CustomFiledsProperty.LoginType + " ";
                DataTable CustomControlTable = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return CustomControlTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        // Added By Imran Custom Master Data Fetch
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        public object GetCustomFieldsMaster([FromBody] CustomFiledsProperty CustomFiledsProperty)
        {
            try
            {
                string strsql = "Exec usp_Sel_tbl_PM_CustomFields_Master " + CustomFiledsProperty.ProjectID + "," + CustomFiledsProperty.DatabaseFieldName + "," + CustomFiledsProperty.ShowOnlyActive + "," + CustomFiledsProperty.Type + "," + CustomFiledsProperty.EntityName + "," + CustomFiledsProperty.UserID + "," + CustomFiledsProperty.LoginType + "  ";
                DataTable CustomControlTable = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return CustomControlTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Imran To Get MaxRows And MaxCols Number
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        public object GetCustomFieldMasterRowNumber([FromBody] CustomFiledsProperty CustomFiledsProperty)
        {
            try
            {
                int MaxRow = 0, MaxColoumn = 0;
                string strsql = "Exec usp_Sel_tbl_PM_CustomFields_Master_MaxRows " + CustomFiledsProperty.ProjectID + "," + CustomFiledsProperty.Type + "," + CustomFiledsProperty.ProjectType + ",'1'," + CustomFiledsProperty.UserID + "," + CustomFiledsProperty.LoginType + "";
                DataTable CustomControlTable = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                foreach (DataRow sdr in CustomControlTable.Rows)
                {
                    MaxRow = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["MaxRows"], "0"));
                    MaxColoumn = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["MaxCols"], "0"));
                }
                object[] GetValue = { MaxRow, MaxColoumn };
                return GetValue;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

            //Added By Imran To Get Validation for Custom fileds
            [Authorize]
        [HttpPost]
        public object GetValidationForCustomFields([FromBody]CustomFiledPloat_BulkUpdate customFiled)
        {
            try
            {
                string VALIDATION;
                string CustomFieldName;
                VALIDATION = Convert.ToString(customFiled.CustomValidation).Replace("[", "").Replace("]", "").Replace("\"", string.Empty).Trim();//.Replace(",", "").
                CustomFieldName = Convert.ToString(customFiled.CustomFieldName).Replace("'", "''").Trim();

                List<ValidationData_BulkUpdate> ValidationData = new List<ValidationData_BulkUpdate>();
                string strsql = "Exec usp_Whizible2_sel_tbl_UI_Validation '" + customFiled.FieldID + "','" + CustomFieldName + "','" + VALIDATION + "'";
                DataTable ValidationDataTable = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                if (VALIDATION.IndexOf("\n") != -1)
                {
                    VALIDATION = VALIDATION.Replace("\n", "").Trim();
                }
                if (VALIDATION.IndexOf("\r") != -1)
                {
                    VALIDATION = VALIDATION.Replace("\r", "").Trim();
                }
                VALIDATION = VALIDATION.Replace(" ", string.Empty).Trim();
                string[] Result = VALIDATION.Split(',');
                foreach (string r in Result)
                {
                    foreach (DataRow sdr in ValidationDataTable.Rows)
                    {
                        ValidationData_BulkUpdate ValidationDataControl = new ValidationData_BulkUpdate()
                        {
                            ValidationID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ValidationID"].ToString(), "")),
                            ValidationMessage = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ValidationMessage"].ToString(), "")),
                            FieldName = Convert.ToString(customFiled.CustomFieldName),
                            FieldID = Convert.ToString(customFiled.FieldID)
                        };

                        if (Convert.ToString(ValidationDataControl.ValidationID) == Convert.ToString(r))
                        {
                            ValidationData.Add(ValidationDataControl);
                        }
                        else
                        { }
                    }
                }
                return ValidationData;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Imran CustomFields Save

        [Authorize]
        [HttpPost]
        public object SaveCustomFieldsValue([FromBody] CustomFields CustomFields)
        {
            try
            {
                object Message;
                if (CustomFields.CustomFieldText1 == "" || CustomFields.CustomFieldText1 == null)
                {
                    CustomFields.CustomFieldText1 = "NULL";
                }
                else
                {
                    CustomFields.CustomFieldText1 = "'" + CustomFields.CustomFieldText1.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                }
                if (CustomFields.CustomFieldText2 == "" || CustomFields.CustomFieldText2 == null)
                {
                    CustomFields.CustomFieldText2 = "NULL";
                }
                else
                {
                    CustomFields.CustomFieldText2 = "'" + CustomFields.CustomFieldText2.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                }

                if (CustomFields.CustomFieldText3 == "" || CustomFields.CustomFieldText3 == null)
                {
                    CustomFields.CustomFieldText3 = "NULL";
                }
                else
                {
                    CustomFields.CustomFieldText3 = "'" + CustomFields.CustomFieldText3.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                }

                if (CustomFields.CustomFieldText4 == "" || CustomFields.CustomFieldText4 == null)
                {
                    CustomFields.CustomFieldText4 = "NULL";
                }
                else
                {
                    CustomFields.CustomFieldText4 = "'" + CustomFields.CustomFieldText4.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                }
                if (CustomFields.CustomFieldText5 == "" || CustomFields.CustomFieldText5 == null)
                {
                    CustomFields.CustomFieldText5 = "NULL";
                }
                else
                {
                    CustomFields.CustomFieldText5 = "'" + CustomFields.CustomFieldText5.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                }

                if (CustomFields.CustomFieldNumeric1 == "" || CustomFields.CustomFieldNumeric1 == null)
                {
                    CustomFields.CustomFieldNumeric1 = "NULL";
                }
                if (CustomFields.CustomFieldNumeric2 == "" || CustomFields.CustomFieldNumeric2 == null)
                {
                    CustomFields.CustomFieldNumeric2 = "NULL";
                }

                if (CustomFields.CustomFieldNumeric3 == "" || CustomFields.CustomFieldNumeric3 == null)
                {
                    CustomFields.CustomFieldNumeric3 = "null";
                }
                if (CustomFields.CustomFieldNumeric4 == "" || CustomFields.CustomFieldNumeric4 == null)
                {
                    CustomFields.CustomFieldNumeric4 = "NULL";
                }
                if (CustomFields.CustomFieldNumeric5 == "" || CustomFields.CustomFieldNumeric5 == null)
                {
                    CustomFields.CustomFieldNumeric5 = "NULL";
                }

                if (CustomFields.CustomFieldDate1 == "" || CustomFields.CustomFieldDate1 == null)
                {
                    CustomFields.CustomFieldDate1 = "NULL";
                }
                else
                {
                    CustomFields.CustomFieldDate1 = "'" + CustomFields.CustomFieldDate1 + "'";
                }

                if (CustomFields.CustomFieldDate2 == "" || CustomFields.CustomFieldDate2 == null)
                {
                    CustomFields.CustomFieldDate2 = "NULL";
                }
                else
                {
                    CustomFields.CustomFieldDate2 = "'" + CustomFields.CustomFieldDate2 + "'";
                }

                if (CustomFields.CustomFieldDate3 == "" || CustomFields.CustomFieldDate3 == null)
                {
                    CustomFields.CustomFieldDate3 = "NULL";
                }
                else
                {
                    CustomFields.CustomFieldDate3 = "'" + CustomFields.CustomFieldDate3 + "'";
                }

                if (CustomFields.CustomFieldDate4 == "" || CustomFields.CustomFieldDate4 == null)
                {
                    CustomFields.CustomFieldDate4 = "NULL";
                }
                else
                {
                    CustomFields.CustomFieldDate4 = "'" + CustomFields.CustomFieldDate4 + "'";
                }

                if (CustomFields.CustomFieldDate5 == "" || CustomFields.CustomFieldDate5 == null)
                {
                    CustomFields.CustomFieldDate5 = "NULL";
                }
                else
                {
                    CustomFields.CustomFieldDate5 = "'" + CustomFields.CustomFieldDate5 + "'";
                }

                string strsql = "Exec Usp_Upd_Whizible2_PM_CreatingProject_SaveCustomFields " + CustomFields.ProjectID + "," + CustomFields.CustomFieldText1 + "," + CustomFields.CustomFieldText2 + "," + CustomFields.CustomFieldText3 + "," + CustomFields.CustomFieldText4 + "," + CustomFields.CustomFieldText5 + "" +
                    " ," + CustomFields.CustomFieldNumeric1 + "," + CustomFields.CustomFieldNumeric2 + "," + CustomFields.CustomFieldNumeric3 + "," + CustomFields.CustomFieldNumeric4 + "," + CustomFields.CustomFieldNumeric5 + " " +
                    "," + CustomFields.CustomFieldDate1 + "," + CustomFields.CustomFieldDate2 + "," + CustomFields.CustomFieldDate3 + "," + CustomFields.CustomFieldDate4 + "," + CustomFields.CustomFieldDate5 + " ";
                Message = CommonFunctions.Data.GetDataScalar(strsql, true, CommonController.connectionString);
                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Get All CustomFields Value
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        public object GetCustomFieldsData([FromBody] CustomFields CustomFields)
        {
            try
            {
                string strsql = "Exec use_Sel_Whizible2_PM_CreatingProject_GetCustomFields " + CustomFields.ProjectID;
                DataTable CustomControlTable = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return CustomControlTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get All validation inputs
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        public object GetValidationCustomFieldsData([FromBody] CustomFields CustomFields)
        {
            try
            {
                string strsql = "Exec use_Sel_Whizible2_PM_CreatingProject_GetValidationCustomFields " + CustomFields.ProjectID;
                DataTable CustomControlTable = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return CustomControlTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Imran Get Default Value of Custom Fields
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        public object GetDefaultCustomFieldsValues([FromBody] CustomFields CustomFields)
        {
            try
            {
                string strsql = "Exec use_Sel_Whizible2_PM_CreatingProject_GetCustomFieldsDefaultValue " + CustomFields.ProjectID;
                DataTable CustomControlTable = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return CustomControlTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End By Imran M 01-07-2021
        //Added by Vishal Mane on 24/02/2026 : Integration of Bulk Extension into W26
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetProjectRevision([FromBody] int ProjectID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Expleo_Sel_tbl_PM_ProjectRevision_Revision " + ProjectID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added by Vishal Mane on 24/02/2026 : Integration of Bulk Extension into W26

    }

    //Added By Imran M 01-07-2021

    public class CommonProperty_NewIssue
    {
        public int ProjectId { get; set; }
        public int RoleId { get; set; }
        public int EmployeeId { get; set; }
        public string LoginType { get; set; }
        public int LoginId { get; set; }
        public string Type { get; set; }
        public string strMode { get; set; }
        public int FildFlag { get; internal set; }
        public int Customerid { get; set; }
        public int ProductVersionID { get; set; }
        public string ProductVersion { get; set; }
    }

    public class CustomFiledPloat1
    {
        public CustomFiledPloat1()
        {
            Caption = new List<string>();
            Value = new List<string>();
            commonProperty = new CommonProperty_NewIssue();
        }

        public CommonProperty_NewIssue commonProperty { get; set; }
        public List<string> Caption { get; set; }
        public List<bool> IscustomfileAssigned { get; set; }
        public string Type { get; set; }
        public string DatabaseFieldName { get; set; }
        public List<string> Value { get; set; }
    }

    public class CustomFiledsProperty
    {
        public string ProjectID { get; set; }
        public string Type { get; set; }
        public string EntityName { get; set; }
        public string UserID { get; set; }
        public string LoginType { get; set; }
        public string RoleId { get; set; }
        public string EmployeeID { get; set; }
        public string DatabaseFieldName { get; set; }
        public string ShowOnlyActive { get; set; }
        public string ProjectType { get; set; }
    }

    public class ProjectCommonProperty
    {
        public string ProjectID { get; set; }
        public string FromWhereData { get; set; }
        public int BussinessGroup { get; set; }
        public int OU { get; set; }
        public String ProjectPractice { get; set; }
        public String strStartDate { get; set; }
        public String strEndDate { get; set; }
        public int UserID { get; set; }     
        public String DUvalue { get; set; }//Added By Dipali V On 31st July 2020  For All Tech Customzation
        public String OUvalue { get; set; }
    }

    public class ProjectMilestoneDetails {
        public int MileStoneID { get; set; }
        public int ProjectID { get; set; }
        public string FromWhichMode { get; set; }
        public string WhichAction { get; set; }
        public int CurrencyId { get; set; }
        public string Currency { get; set; }
        public double BillAmount { get; set; }
        public double SumOfAllBillAmt { get; set; }
        public string MileStoneName { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string SelectedDate { get; set; }
        public string StrUserName { get; set; }
        public string MilestoneStatus { get; set; }
        public int IsClosed { get; set; }
        public string CompletionPercentage { get; set; }
        public string ProjectValue { get; set; }
    }


    public class ProjectDetails
    {
        public string FromWhichMode { get; set; }
        public string AbbProjectName { get; set; }
        //Added By Dipali V On 20th Jan 2020 For Sonata Changes, Instead of Abb Name ProjectCode Display
        public string ProjectCode { get; set; }
        public string ProjectTemplate { get; set; }//Added By Dipali V On 16th Feb 2021 For Pratice Name
        public string CustomerName { get; set; }//For tooltip changes instead of CustomerID CustomerName Should get 
        //End of Added By Dipali V On 20th Jan 2020 For Sonata Changes, Instead of Abb Name ProjectCode Display
        public string Flag { get; set; }
        public string strProjectCode { get; set; }
        public string ProjectName { get; set; }
        public string Description { get; set; }
        public string ProjectStartDate { get; set; }
        public string ProjectEnddate { get; set; }
        public int IsBillable { get; set; }
        public int ProjectCustomer { get; set; }
        public int Duration { get; set; }
        public double Hours { get; set; }
        public int ProjectBG { get; set; }
        public int ProjectOU { get; set; }
        public string PracticeTemplate { get; set; }
        public int ProjectCurrency { get; set; }
        public string ProjectGroupID { get; set; }
        
        //public double ProjectBuget { get; set; }
        //public Decimal ProjectBuget { get; set; }
        public string ProjectBuget { get; set; }
        public int ProjectSponsar { get; set; }
        public int ProjectTypeID { get; set; }
        public int UserID { get; set; }
        public string ProjectType { get; set; }
        public string StrUserName { get; set; }        
        public int IsOldProject { get; set; }
        public int NoOfResource { get; set; }
        
        //public double ProjectValue { get; set; }
        public Decimal ProjectValue { get; set; }
        public int ContractType { get; set; }
        public string WhichAction { get; set; }
        public int ProjectID { get; set; }
        public int DraftProjectID { get; set; }
        public int ErrorCode { get; set; }
        public string JobCode { get; set; }
        public string CurrencyCode { get; set; }
        public double SumBillAmount { get; set; }
        public string CorporateCurrencyCode { get; set; }
        public double ConversionRate { get; set; }
        //Added By Usha Pandit On 17.01.2020 For Baseline Status
        public string BaselineStatus { get; set; }
        //End Of Added By Usha Pandit On 17.01.2020 For Baseline Status

        //Added By Usha Pandit On 11.11.2019 For ConvertedToProject Flag Set
        public int IsConvertedToProject { get; set; }
        //End Of Added By Usha Pandit On 11.11.2019 For ConvertedToProject Flag Set
        //Added BY Dipali V On 31st July 2020 For All Tech Customzation
        public string ResourceGroupID { get; set; }
        public string ResourcePoolID { get; set; }
        public string ProjectStatus { get; set; }
        //End of Added BY Dipali V On 31st July 2020 For All Tech Customzation

        // Added by Vidhi on 31st DEC 2020 for displaying lable in page that show message 'please fill the additional info
        public bool isAdditionalInfoFlag { get; set; }
        // End of Added by Vidhi on 31st DEC 2020 for displaying lable in page that show message 'please fill the additional info

                        //Added By Nischal C on 25/08/2025 For PointWest Customization
                        public string PTC_ProjectCode { get; set; }  // Pointwest Project Code
                        public int CONTRACTID { get; set; }          // Contract Number ID
                        //End of Added By Nischal C on 25/08/2025 For PointWest Customization

    }

    public class CustomFiledPloat_BulkUpdate
    {
        public CustomFiledPloat_BulkUpdate()
        {
            Caption = new List<string>();

            Value = new List<string>();
            //IscustomfileAssigned = new List<String>();
            commonProperty = new CommonProperty_BulkUpdate();
        }
        //Added By Riddhesh Patil on 31st March 2023
        // public int ProjectId { get; set; }
        public int RoleId { get; set; }
        public int EmployeeId { get; set; }
        public string LoginType { get; set; }
        public int LoginId { get; set; }
        public string strMode { get; set; }
        //End of Added By Riddhesh Patil on 31st March 2023
        public CommonProperty_BulkUpdate commonProperty { get; set; }

        public List<string> Caption { get; set; }
        public List<bool> IscustomfileAssigned { get; set; }
        public string Type { get; set; }
        public string DatabaseFieldName { get; set; }
        public List<string> Value { get; set; }
        public object ValidationRules { get; internal set; }
        public object Rownumber { get; internal set; }
        public int RowNumber { get; internal set; }
        public int UniqueID { get; internal set; }
        public string UserGivenCaption { get; internal set; }
        public int ColumnNumber { get; internal set; }
        public string IsCustomFieldAssigned { get; set; }
        public string FieldID { get; set; }
        public object CustomFieldName { get; set; }
        public object CustomValidation { get; set; }
        public string FieldName { get; internal set; }
        public string CustomFieldID { get; internal set; }
        public string DefaultValue { get; internal set; }
        public string DefaultType { get; internal set; }
        public string MaxLength { get; internal set; }
        public string MinValue { get; internal set; }
        public string MaxValue { get; internal set; }
        public string ProjectId { get; set; }
        public string Mandatory { get; set; }

    }

    public class CommonProperty_BulkUpdate
    {
        public int ProjectId { get; set; }
        public int RoleId { get; set; }
        public int EmployeeId { get; set; }
        public string LoginType { get; set; }
        public int LoginId { get; set; }
        public string strMode { get; set; }
    }

    public class ProjectRoleDetails
    {
        public int ProjectID { get; set; }
        public int RoleID { get; set; }
        public int UserID { get; set; }
        public string RoleDescription { get; set; }
        public int AssignToProjectByDefault { get; set; }
        public int Level { get; set; }
    }

    public class SiteRole
    {
        public int Role { get;  set; }
        public int ProjectID { get;  set; }
        public int ProjectSiteID { get; set; }
        public string roleDescription { get; set; }
        public string WhichAction { get; set; }
    }

    public class ResourceRole
    {
        public int ResourceCostID { get; set; }        
        public int RoleID { get; set; }
        public int ProjectID { get; set; }
        public int RequestID { get; set; }
        public int CurrencyID { get; set; }
        public int NoOfResource { get; set; }
        public int IsOriginalBudgetChange { get; set; }
        public double PercentageAllocation { get; set; }
        public double ProjectValue { get; set; }
        //Commented & Added By Dipali V On 26th Oct 2023 For Convert double
        //public double Budget { get; set; }
        public string Budget { get; set; }
        //public double TotalBudget { get; set; }
        public string TotalBudget { get; set; }
        //End of Commented & Added By Dipali V On 26th Oct 2023 For Convert double
        public double BudgetAfterConversion { get; set; }
        public double ResourceCostPercentage { get; set; }
        public double ProfitMargin { get; set; }
        public double ConversionRate { get; set; }
        public double RoleCost { get; set; }
        public string RoleDescription { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string CurrencyName { get; set; }
        public string CurrencyCode { get; set; }
        public string UserName { get; set; }
        public string WhichAction { get; set; }
        public int IsConvertedToProject { get; set; }
    }

    public class CustomFields
    {
        public string CustomFieldText1 { get; set; }
        public string CustomFieldText2 { get; set; }
        public string CustomFieldText3 { get; set; }
        public string CustomFieldText4 { get; set; }
        public string CustomFieldText5 { get; set; }

        public string CustomFieldNumeric1 { get; set; }
        public string CustomFieldNumeric2 { get; set; }
        public string CustomFieldNumeric3 { get; set; }
        public string CustomFieldNumeric4 { get; set; }
        public string CustomFieldNumeric5 { get; set; }

        public string CustomFieldDate1 { get; set; }
        public string CustomFieldDate2 { get; set; }
        public string CustomFieldDate3 { get; set; }
        public string CustomFieldDate4 { get; set; }
        public string CustomFieldDate5 { get; set; }

        public int ProjectID { get; set; }
        public string UniqueID { get; set; }
    }


    //Added By Nischal C on 25/08/2025 For PointWest Customization
    public class ContractNumber
    {
        public int CONTRACTID { get; set; }
        public string CONTRACTNUMBER { get; set; }
    }
    //End of Added By Nischal C on 25/08/2025 For PointWest Customization

    //Added by Ajit L for Additional Info tab on 04/03/2024
    public class AdditionalInfo
    {
        public  int ProjectId { get; set; }
        public string ProjectManager { get; set; }
        public string SQAName { get; set; }
        public string DeliveryManager { get; set; }
        public string VerticalHead { get; set; }
        public string ManagedBy { get; set; }
        public bool SQAApplicable { get; set; }
        public string Description { get; set; }
        public int UserID { get; set; }
        public string UserName { get; set; }
        public int Flag { get; set; }
        public string ModifiedField { get; set; }
        public string ModifiedBy { get; set; }
    }

    //Added by Codex on 11-05-2026 for project level vendor management
    public class ProjectVendorParameter
    {
        public int ProjectID { get; set; }
        public string ProjectStatus { get; set; }
        public string VendorJson { get; set; }
        public string UserName { get; set; }
        // Added By Dipali V On 14th May 2026 For optional vendor name filter on split vendor list API
        public string Search { get; set; }
        // Added By Dipali V On 19th May 2026 For vendor-in-use batch check on save (comma-separated IDs)
        public string VendorIDs { get; set; }
    }
}