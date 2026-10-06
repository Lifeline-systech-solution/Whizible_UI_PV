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
        [Authorize]
        [HttpPost]
        public List<Location> GetLocation([FromBody] ProjectCommonProperty CommonProperty)
        {
            string strSQL = "Exec usp_Whizible2_Sel_GetBusinessGroupsForLocation " + CommonProperty.BussinessGroup + ",NULL,0";

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


        [Authorize]
        [HttpPost]
        public List<ProjectPracitce> GetProjectType([FromBody] ProjectCommonProperty CommonProperty)
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


        [Authorize]
        [HttpPost]
        public object GetDuration([FromBody] ProjectCommonProperty CommonProperty)
        {

            string query = "EXEC usp_Whizible2_GetWorkingDays '" + CommonProperty.strStartDate + "','" + CommonProperty.strEndDate + "'";
            object result = CommonFunctions.Data.GetDataScalar(query, true, CommonController.connectionString);

            return result;
        }

        //Get Duration as per Selected OU
        [Authorize]
        [HttpPost]
        public object GetOUDuration([FromBody] ProjectCommonProperty CommonProperty)
        {
            string query = "";
            query = "DECLARE @intDays INT " + System.Environment.NewLine;
            
            if (CommonProperty.ProjectID == "0")
            {
                query += "EXEC usp_Whizible2_GetOUWorkingDays NULL, '" + CommonProperty.strStartDate + "','" + CommonProperty.strEndDate + "', @intDays OUTPUT" + ", " + CommonProperty.UserID + ", 1," + CommonProperty.OU + ", '" + CommonProperty.FromWhereData + "'";
            }
            else
            {
                query += "EXEC usp_Whizible2_GetOUWorkingDays " + CommonProperty.ProjectID + ", '" + CommonProperty.strStartDate + "','" + CommonProperty.strEndDate + "', @intDays OUTPUT" + ", " + CommonProperty.UserID + ", 1, " + CommonProperty.OU + ", '" + CommonProperty.FromWhereData + "'";
            }
            
            query += " SELECT ' Days' = @intDays";
            object result = CommonFunctions.Data.GetDataScalar(query, true, CommonController.connectionString);

            return result;
        }
        //Validate Date Falls Between Project Start-End Date
        [HttpPost]
        [Authorize]
        public object ValidateDate([FromBody]ProjectMilestoneDetails Parameters)
        {
            string strSQL;

            strSQL = "Exec usp_Whizible2_Chk_Date_FallsBetween_Project_StartEndDate " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(Parameters.SelectedDate) + "','" + HttpUtility.UrlDecode(Parameters.WhichAction) + "'";

            object dt = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
            return dt;
        }
        [Authorize]
        [HttpPost]
        public List<OUHours> GetWorkingHrByOU([FromBody] ProjectCommonProperty CommonProperty)
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

        [Authorize]
        [HttpPost]
        public List<ProjectDetails> getProjectCode([FromBody] ProjectDetails ProjectDetailsProperty)
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

        [Authorize]
        [HttpPost]
        public object Save_ProjectJobCode([FromBody] ProjectDetails ProjectDetailsProperty)
        {
            string JobID = "";
            string strSQL = "Exec Usp_Whizible2_Ins_PM_JobCode " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectID));

            strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.strProjectCode)) + "', " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectValue)) + ", 0, " + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectCustomer)) + ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.StrUserName)) + "'";
           
            JobID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
            return JobID;
        }

        [Authorize]
        [HttpPost]
        public object Draft_UpdateProjectDetails([FromBody] ProjectDetails ProjectDetailsProperty)
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

        [Authorize]
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
                    strSQL = "Exec Usp_ins_tbl_Whizible2_PM_Project '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.FromWhichMode)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectName.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n"))) + "','" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.AbbProjectName.Replace("'", "''"))) + "','" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.Description.Replace("'", "''"))) + "'," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectGroupID)) + ","
                  + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.IsBillable)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectStartDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectEnddate)) + "',"
                  + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.Hours)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.Duration)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectValue)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectCurrency)) + ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.PracticeTemplate)) + "'," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.UserID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectType)) + "'," +
                   HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectBG)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectOU)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectCustomer)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectSponsar)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.StrUserName)) + "', NULL," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.WhichAction)) + "'";
                    //Added By Usha Pandit On 11.11.2019 For ConvertedToProject Flag Set
                    strSQL = strSQL + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.IsConvertedToProject));
                    //End Of Added By Usha Pandit On 11.11.2019 For ConvertedToProject Flag Set
                }
                else
                {
                    strSQL = "Exec Usp_ins_tbl_Whizible2_PM_Project '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.FromWhichMode)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectName.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n"))) + "','" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.AbbProjectName.Replace("'", "''"))) + "','" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.Description.Replace("'", "''"))) + "'," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectGroupID)) + ","
                   + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.IsBillable)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectStartDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectEnddate)) + "',"
                   + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.Hours)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.Duration)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectValue)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectCurrency)) + ", '" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.PracticeTemplate)) + "'," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.UserID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectType)) + "'," +
                    HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectBG)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectOU)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectCustomer)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectSponsar)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.StrUserName)) + "'," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.NoOfResource)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.WhichAction)) + "'";
                    //Added By Usha Pandit On 11.11.2019 For ConvertedToProject Flag Set
                    strSQL = strSQL + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectDetailsProperty.IsConvertedToProject));
                    //End Of Added By Usha Pandit On 11.11.2019 For ConvertedToProject Flag Set
                }
                ProjectDetails = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
                return ProjectDetails;
            }
            catch
            {

            }
            // }
            return ProjectDetails;
        }

        [Authorize]
        [HttpPost]
        public object Save_DefaultProjectSite([FromBody] ProjectDetails ProjectDetailsProperty)
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

        [Authorize]
        [HttpPost]
        public object Save_DraftToActualProjectCost([FromBody] ProjectDetails ProjectDetailsProperty)
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
        [Authorize]
        [HttpPost]
        public object Save_DraftToActualResourceCost([FromBody] ProjectDetails ProjectDetailsProperty)
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
        [Authorize]
        [HttpPost]
        public object Save_DraftToActualDiscussions([FromBody] ProjectDetails ProjectDetailsProperty)
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
        [Authorize]
        [HttpPost]
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
            }
            return ID;
        }

        [Authorize]
        [HttpPost]
        public object Save_ProjectAccess([FromBody] ProjectDetails ProjectDetailsProperty)
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

        [Authorize]
        [HttpPost]
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
            }
            return ID;
        }

        [Authorize]
        [HttpPost]
        public object Get_ProjectRoleDetails([FromBody] ProjectRoleDetails RoleDetailsProperty)
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

        [Authorize]
        [HttpPost]
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
            }
            return ID;
        }

        [Authorize]
        [HttpPost]
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
            }
            return ID;
        }

        [Authorize]
        [HttpPost]
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
            }
            return ID;
        }

        [Authorize]
        [HttpPost]
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
            }
            return ID;
        }

        [Authorize]
        [HttpPost]
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
            }
            return ID;
        }

        [Authorize]
        [HttpPost]
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
            }
            return NewSiteID;
        }

        [Authorize]
        [HttpPost]
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
            }
            return NewMilestoneID;
        }

        [Authorize]
        [HttpPost]
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

                ProjectDetails = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

                return ProjectDetails;
            }
            catch
            {

            }
            // }
            return ProjectDetails;
        }

        [Authorize]
        [HttpPost]
        public List<ProjectDetails> GetProjectDetails([FromBody] ProjectCommonProperty ProjectProperty)
        {
            string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ProjectDetails " + ProjectProperty.ProjectID + ",'" + ProjectProperty.FromWhereData + "'";

            List<ProjectDetails> ProjectDetails = new List<ProjectDetails>();

            IDataReader sdr;
            sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

            while (sdr.Read())
            {
                ProjectDetails ObjProject = new ProjectDetails()
                {
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
                    ProjectTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ProjectTypeID"], "0")),
                    ProjectGroupID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ProjectGroupID"], "")),
                    ProjectSponsar = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["FundedBy"], "0")),
                    ProjectBuget = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["ContractValue"], "0.00")),
                    ProjectValue = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["ContractValue"], "0.00")),
                    SumBillAmount = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["SumBillAmount"], "0.00")),
                    ContractType = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ContractType"], "0")),
                    Description = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["Description"], "")),
                    IsBillable = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["Billable"], "0")),
                    CorporateCurrencyCode = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["CorporateCurrencyCode"], "")),
                    ConversionRate = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["ConversionRate"], "0.00")),
                };
                ProjectDetails.Add(ObjProject);
            }

            return ProjectDetails;
        }

        [Authorize]
        [HttpPost]
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
            catch
            {
            }
            // }
            return MilesToneID;

        }

        [Authorize]
        [HttpPost]
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
            catch(Exception ex)
            {
            }
            return ProjectSiteID;
        }

        [Authorize]
        [HttpPost]
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
            }
            return WorkOrderCostID;
        }

        [Authorize]
        [HttpPost]
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
            }
            return ResourceCostID;
        }

        [Authorize]
        [HttpPost]
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
            }
            return ProjectCostHeadID;
        }

        [Authorize]
        [HttpPost]
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
            }
            return ProjectSiteID;
        }

        //Delete the Project Cost Details
        [HttpPost]
        [Authorize]
        public object DeleteProjectCost([FromBody]ProjectCostDetails ProjectCostDetailsProperty)
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

        //Delete the Project Cost Head Details
        [HttpPost]
        [Authorize]
        public object DeleteProjectCostHead([FromBody]ProjectCostHeadDetails ProjectCostHeadDetailsProperty)
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

        //Delete the Resource Cost Details
        [HttpPost]
        [Authorize]
        public object DeleteResourceCost([FromBody]ProjectCostDetails ProjectCostDetailsProperty)
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

        //Delete the Project Site Details
        [HttpPost]
        [Authorize]
        public object DeleteProjectSite([FromBody]ProjectSiteDetails ProjectSiteDetailsProperty)
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

        [Authorize]
        [HttpPost]
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
            }
            return ProjectSiteRoleID;
        }

        [Authorize]
        [HttpPost]
        public List<ProjectMilestoneDetails> GetMileStoneDetails([FromBody] ProjectMilestoneDetails MilesStoneDetailsProperty)
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


        [Authorize]
        [HttpPost]
        public List<ProjectSiteDetails> GetSiteDetails([FromBody] ProjectSiteDetails SiteDetailsProperty)
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

        [Authorize]
        [HttpPost]
        public List<ProjectRateCardDetails> GetRateCardDetails([FromBody] ProjectRateCardDetails RateCardDetailsProperty)
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

        [Authorize]
        [HttpPost]
        public List<ProjectPercentageSettings> GetPercentageSettings([FromBody] ProjectPercentageSettings ProjectSettingsProperty)
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
        [Authorize]
        [HttpPost]
        public List<ResourceRole> GetResourceCostDetails([FromBody] ResourceRole ResourceRoleProperty)
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
                    Budget = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["Budget"], "0.0")),
                    RoleCost = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["RoleCost"], "0.0")),
                    TotalBudget = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["TotalBudget"], "0.0")),
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

        [Authorize]
        [HttpPost]
        public List<ProjectCostDetails> GetProjectCostDetails([FromBody] ProjectCostDetails ProjectCostDetailsProperty)
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
                    CostToCompany = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["CostToCompany"], "0.0")),
                    Reimbersable = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["Reimbersable"], "0.0")),
                    Billable = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["BillableValue"], "0.0")),
                    IsSetByUser = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["IsSetByUser"], "0.0")),
                    TotalCostToCompany = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["TotalCostToCompany"], "0.0")),
                    TotalReimbersable = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["TotalReimbersable"], "0.0")),
                    TotalBillable = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(sdr["TotalBillable"], "0.0")),
                    Description = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["Description"], "")),
                    IsConvertedToProject = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["IsConvertedToProject"], "0")),
                };
                projectCostDetails.Add(ObjProjectCostDetails);
            }
            return projectCostDetails;
        }

        [Authorize]
        [HttpPost]
        public List<ProjectCostHeadDetails> GetProjectCostHeadDetails([FromBody] ProjectCostHeadDetails ProjectCostHeadDetailsProperty)
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
        
        [Authorize]
        [HttpPost]
        public List<ProjectCostDetails> GetProjectCostHeads([FromBody] ProjectCostDetails ProjectCostDetailsProperty)
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

        [Authorize]
        [HttpPost]
        public List<ProjectCostDetails> GetProjectCostGroups([FromBody] ProjectCostDetails ProjectCostDetailsProperty)
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
        [Authorize]
        [HttpPost]
        public List<ProjectRateCardDetails> GetTemplateRateCard([FromBody] ProjectRateCardDetails ProjectRateCardDetailsProperty)
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
        
        [Authorize]
        [HttpPost]
        public List<ProjectMilestoneDetails> BindMileStoneDetails([FromBody] ProjectMilestoneDetails MilesStoneDetailsProperty)
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

        [Authorize]
        [HttpPost]
        public List<SiteRole> GetProjectSiteRole([FromBody] SiteRole SiteRoleProperty)
        {
            string strSQL = "Exec Usp_Whizible2_Sel_tbl_PM_Roles_ProjectSite " + HttpUtility.UrlDecode(Convert.ToString(SiteRoleProperty.ProjectSiteID)) + "";
            strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(SiteRoleProperty.WhichAction)) + "'";
            List <SiteRole> SiteRoleDetails = new List<SiteRole>();

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

        [Authorize]
        [HttpPost]
        public List<ResourceRole> GetResourceCostRole([FromBody] ResourceRole ResourceRoleProperty)
        {
            string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Role_PopulateCombo " + ResourceRoleProperty.RequestID + "";

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

        [Authorize]
        [HttpPost]
        public List<ResourceRole> GetRatePerHour([FromBody] ResourceRole ResourceRoleProperty)
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

        [Authorize]
        [HttpPost]
        public List<ContractTypeDetails> CheckMilestoneSiteActiveDeactive([FromBody] ContractTypeDetails ContractTypeDetailsProperty)
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

        [Authorize]
        [HttpPost]
        public String chkProjectNameExists([FromBody]ProjectDetails ProjectDetailsProperty)
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

        [Authorize]
        [HttpPost]
        public String chkSiteExists([FromBody]ProjectSiteDetails Parameters)
        {
            string strSQL = "Exec usp_Whizible2_chk_Site_Exists '" + HttpUtility.UrlDecode(Parameters.Name).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "', " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectSiteID)) + ", '" + HttpUtility.UrlDecode(Parameters.WhichAction) + "'";

            string Flag;

            Flag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

            return Flag;
        }

        [Authorize]
        [HttpPost]
        public String chkMileStoneExists([FromBody]ProjectMilestoneDetails Parameters)
        {
            string strSQL = "Exec usp_Whizible2_chk_Milestone_Exists '" + HttpUtility.UrlDecode(Parameters.MileStoneName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "', " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.MileStoneID)) + ", '" + HttpUtility.UrlDecode(Parameters.WhichAction) + "'";

            string Flag;

            Flag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

            return Flag;
        }

        [Authorize]
        [HttpPost]
        public List<ProjectDetails> GetEmployeeSpecificBGOU([FromBody] ProjectDetails Projectproperty)
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

        //Added By Usha Pandit On 12.11.2019 To Get Discussion Details
        [Authorize]
        [HttpPost]
        public List<GetProjectDiscussions> GetDiscussions([FromBody]ProjectDiscussionsParameter Parameters)
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
        //Save Discussion Details
        [Authorize]
        [HttpPost]
        public String SaveDiscussion([FromBody]ProjectDiscussionsParameter Parameters)
        {
            string strSQL = "";
            string currentFlag = "";
            currentFlag = HttpUtility.UrlDecode(Parameters.Flag);

            if (currentFlag == "Draft Project")
            {
                strSQL = "Exec Usp_Whizible2_Ins_tbl_Whizible2_ProjInfo_DiscussionThread " + HttpUtility.UrlDecode(Convert.ToString(Parameters.UniqueID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ParentID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.LoginID)) + ",'" + HttpUtility.UrlDecode(Parameters.DiscussionThread).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.SubmittedBy) + "','" + HttpUtility.UrlDecode(Parameters.LoginType) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.IsShowToCustomer)) + ",'" + HttpUtility.UrlDecode(Parameters.DiscussionLevel) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ReplyIndex)) + "";
            }
            if (currentFlag == "Project")
            {
                strSQL = "Exec usp_Ins_tbl_PM_ProjInfo_Discussions " + HttpUtility.UrlDecode(Convert.ToString(Parameters.UniqueID)) + ",'" + HttpUtility.UrlDecode(Parameters.SubmittedBy) + "','" + HttpUtility.UrlDecode(Parameters.DiscussionThread).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.IsShowToCustomer)) + "";
            }            

            string Message;

            Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

            return Message;
        }
        //End Of Added By Usha Pandit On 12.11.2019 To Get Discussion Details

        //Practice Settings Integration Start
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
            catch (Exception e)
            {
                return request.CreateResponse(HttpStatusCode.BadRequest, e.Message);
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

        //WorkFlow Starting 

        [Authorize]
        [HttpPost]
        // public string PlotWorkflowLinks([FromBody] WBSParametersWorkFlow )
        public string PlotWorkflowLinks([FromBody] ProjectWorkFlow ParametersWorkFlows)
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
                            sbScript.Append("<a class='nobtnstyle - xs' id ='btnRejectApproved_" + ParametersWorkFlows.TagID + "' onclick=\"Javascript:Reject_Onclick(" + WFID + "," + WorkflowInstanceID + "," + ParametersWorkFlows.TagID + "," + ParametersWorkFlows.strPrimaryKey + ",'Reject','" + strPrimaryKeyName.ToString() + "'," + strIsApproverConfigured.ToString() + ",'" + strRequestStage.ToString() + "')\"  data-toggle='modal' data-target='#divAppReject' >Reject</a>");
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



        [Authorize]
        [HttpPost]
        // public string PlotWorkflowLinks([FromBody] WBSParametersWorkFlow )
        public string RevisionLink([FromBody] ProjectWorkFlow ParametersWorkFlows)
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
                sbScript.Append("<a class='nobtnstyle - xs' id ='btnRevision_" + ParametersWorkFlows.TagID + "' onclick=\"Javascript:RevisionOnclick(" + ParametersWorkFlows.strPrimaryKey + "," + ParametersWorkFlows.TagID + ")\" data-toggle='modal' data-target='#divRevision'>Revision</a>");//data-toggle='modal' data-target='#divRevision'
            }
            return sbScript.ToString();
        }

        [Authorize]
        [HttpPost]
        // public string PlotWorkflowLinks([FromBody] WBSParametersWorkFlow )
        public string PerformRevision([FromBody] ProjectWorkFlow ParametersWorkFlows)
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

        //For CheckList Response 
        [Authorize]
        [HttpPost]
        public string GetLinksAfterWorkFlowEnabled([FromBody]ProjectWorkFlow ParametersWorkFlows)
        {
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




            return Flag.ToString();

        }

        [HttpPost]
        [Authorize]
        public object GetRevisionHistory([FromBody]ProjectWorkFlow ParametersWorkFlows)
        {
            string strSQL = "";

            strSQL = "Exec usp_Whizible2_GetProjectRevisionHistoryDetails " + HttpUtility.UrlDecode(Convert.ToString(ParametersWorkFlows.ProjectID)) + "";


            DataTable Revisionhistory;
            Revisionhistory = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
            return Revisionhistory;

        }


        [Authorize]
        [HttpPost]
        // public string PlotWorkflowLinks([FromBody] WBSParametersWorkFlow )
        public string TakeActionHPHTBT([FromBody] ProjectWorkFlow ParametersWorkFlows)
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



        [HttpPost]
        [Authorize]
        public object GetComments([FromBody]ProjectWorkFlow ParametersWorkFlows)
        {
            string strSQL = "";

            strSQL = "Exec usp_Whizible2_get_WorkflowActions_Comments " + HttpUtility.UrlDecode(Convert.ToString(ParametersWorkFlows.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ParametersWorkFlows.TagID)) + "";


            DataTable Comments;
            Comments = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
            return Comments;

        }

        //Added by Dipali V On 7th Jan 2020 For WF Refresh Issues
        [HttpPost]
        [Authorize]
        public object GetSelectedWorkfLOW([FromBody]ProjectWorkFlow ParametersWorkFlows)
        {
            string strSQL = "";

            strSQL = "Exec usp_Whizible2_GetSeletedWorkFlow " + HttpUtility.UrlDecode(Convert.ToString(ParametersWorkFlows.GlobalUniqueID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ParametersWorkFlows.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ParametersWorkFlows.ProjectID)) + "";


            DataTable SelectedWF;
            SelectedWF = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
            return SelectedWF;

        }
        //End of Added by Dipali V On 7th Jan 2020 For WF Refresh Issues

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
        public double ProjectBuget { get; set; }
        public int ProjectSponsar { get; set; }
        public int ProjectTypeID { get; set; }
        public int UserID { get; set; }
        public string ProjectType { get; set; }
        public string StrUserName { get; set; }        
        public int IsOldProject { get; set; }
        public int NoOfResource { get; set; }
        public double ProjectValue { get; set; }
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
        //Added By Usha Pandit On 11.11.2019 For ConvertedToProject Flag Set
        public int IsConvertedToProject { get; set; }
        //End Of Added By Usha Pandit On 11.11.2019 For ConvertedToProject Flag Set
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
        public double Budget { get; set; }
        public double TotalBudget { get; set; }
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
}


