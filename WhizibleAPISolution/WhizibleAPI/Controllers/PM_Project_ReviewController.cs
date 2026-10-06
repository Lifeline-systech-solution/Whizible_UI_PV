using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Xml;
using WhizibleAPI.Models.Project_Review;
using System.Runtime.InteropServices;
namespace WhizibleAPI.Controllers
{
    public class PM_Project_ReviewController : ApiController
    {
        #region[getProjectReviews]
        /// <summary>
        /// Created Date    :   04 October 2019
        /// Purpose         :   Get Project Review List 
        /// Created By      :   Chandrashekhar Salagar
        /// Modified by     :   Vishal Mahajan for filter 04-12-2019
        /// <param name="pm_wbs_cardparameter"></param>
        /// <returns>PM_wbs_card list</returns>
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        //public List<PM_Project_Review> getProjectReviews([FromBody]PM_Project_ReviewParameter project_Review)
        public object getProjectReviews([FromBody] PM_Project_ReviewParameter project_Review)

        {
            try
            {
                DataTable Project_Review = new DataTable();
                List<PM_Project_Review> lisProject_Review = new List<PM_Project_Review>();
                Project_Review = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_ReviewStatistics "
                                                + HttpUtility.UrlDecode(project_Review.projectID.ToString()) + ","
                                                + project_Review.IsPlannedReview + ", '"
                                                + HttpUtility.UrlDecode(project_Review.FilterQuery) + "'", true, CommonController.connectionString);
                foreach (DataRow drProjectTask in Project_Review.Rows)
                {
                    PM_Project_Review PR = new PM_Project_Review()
                    {
                        ReviewStatisticsID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["ReviewStatisticsID"], "")),
                        ReviewTitle = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["ReviewTitle"], "")),
                        ReviewStartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["ReviewStartDate"], "")),
                        ReviewEndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["ReviewEndDate"], "")),
                        ReviewType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["ReviewType"], "")),
                        ReviewedBy = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["ReviewedBy"], "")),
                        Reviewee = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["Reviewee"], "")),
                        ReviewEffort = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["ReviewEffort"], "")),
                        ReviewStatus = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["ReviewStatus"], "")),
                        //Start by Vishal mahajan 09-12-2019
                        IsSendReviewInvite = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["IsSendReviewInvite"], "")),
                        //end by Vishal mahajan 09-12-2019
                        //added by Vishal mahajan 03-01-2020
                        StartTime = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["StartTime"], "")),
                        EndTime = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["EndTime"], "")),
                        PhaseID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["PhaseID"], "")),
                        IterationID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["IterationID"], "")),
                        //added by Vishal mahajan 03-01-2020
                    };
                    lisProject_Review.Add(PR);
                }

                return lisProject_Review;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[getProjectReviewParameters]
        /// <summary>
        /// Created Date    :   10 October 2019
        /// Purpose         :   Get Project Review List 
        /// Created By      :   Chandrashekhar Salagar
        /// <param name="pm_wbs_cardparameter"></param>
        /// <returns>PM_wbs_card list</returns>
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        //public List<ReviewTypes> getProjectReviewParameters([FromBody]ReviewTypes reviewTypes)
        public object getProjectReviewParameters([FromBody] ReviewTypes reviewTypes)

        {
            try
            {
                DataTable ReviewTypeTable = new DataTable();
                List<ReviewTypes> listReviewTypes = new List<ReviewTypes>();/*Existing stored procedure encrypted*/
                ReviewTypeTable = CommonFunctions.Data.GetDataTable("usp_Sel_tbl_PM_ProjectReviewTypes " + HttpUtility.UrlDecode(reviewTypes.ProjectID.ToString()) + " ", true, CommonController.connectionString);
                foreach (DataRow drProjectTask in ReviewTypeTable.Rows)
                {
                    ReviewTypes PR = new ReviewTypes()
                    {
                        PReviewTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drProjectTask["PReviewTypeID"], "")),
                        PReviewType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["PReviewType"], "")),
                        CReviewTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drProjectTask["CReviewTypeID"], "")),
                        CReviewType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["CReviewType"], "")),
                    };
                    listReviewTypes.Add(PR);
                }

                return listReviewTypes;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion





        #region[getReviewers]
        /// <summary>
        /// Created Date    :   10 October 2019
        /// Purpose         :   Get Project Review List 
        /// Created By      :   Chandrashekhar Salagar
        /// <param name="pm_wbs_cardparameter"></param>
        /// <returns>PM_wbs_card list</returns>
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        ////public List<Reviwer> getReviewers([FromBody]Reviwer reviwer)
        public object getReviewers([FromBody] Reviwer reviwer)

        {
            try
            {
                DataTable Rewier = new DataTable();
                List<Reviwer> listReviwer = new List<Reviwer>();/*Existing stored procedure*/
                Rewier = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_ReviewStatistics_ReviewerList 'ReviewedBy', " + reviwer.ProjectID + ", NULL, NULL,NULL,NULL,Null,'-1',0", true, CommonController.connectionString);
                foreach (DataRow drProjectTask in Rewier.Rows)
                {
                    Reviwer R = new Reviwer()
                    {
                        EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drProjectTask["EmployeeID"], "")),
                        EmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["Employee Name"], "")),
                    };
                    listReviwer.Add(R);
                }

                return listReviwer;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[getReviewee]
        /// <summary>
        /// Created Date    :   10 October 2019
        /// Purpose         :   Get Project Review List 
        /// Created By      :   Chandrashekhar Salagar
        /// <param name="pm_wbs_cardparameter"></param>
        /// <returns>PM_wbs_card list</returns>
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        //public List<Reviwee> getReviewee([FromBody]Reviwee reviwee)
        public object getReviewee([FromBody] Reviwee reviwee)

        {
            try
            {
                DataTable ReviweeTable = new DataTable();
                List<Reviwee> listReviwee = new List<Reviwee>();/*Existing stored procedure*/
                ReviweeTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_ReviewStatistics_RevieweeList 'ReviewedOf', " + reviwee.ProjectID + ", NULL, NULL,NULL,NULL,Null,'',0", true, CommonController.connectionString);
                foreach (DataRow drProjectTask in ReviweeTable.Rows)
                {
                    Reviwee R = new Reviwee()
                    {
                        EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drProjectTask["EmployeeID"], "")),
                        EmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["Employee Name"], "")),
                    };
                    listReviwee.Add(R);
                }

                return listReviwee;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[getReviewee]
        /// <summary>
        /// Created Date    :   10 October 2019
        /// Purpose         :   Get Project Review List 
        /// Created By      :   Chandrashekhar Salagar
        /// <param name="pm_wbs_cardparameter"></param>
        /// <returns>PM_wbs_card list</returns>
        [HttpPost]
        [Authorize]
        //public List<Timezone> getTimezone()
        public object  getTimezone()

        {
            try
            {
                DataTable TimezoneTable = new DataTable();
                List<Timezone> listTimezone = new List<Timezone>();/*Existing stored procedure*/
                TimezoneTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_FCI_GMTZones", true, CommonController.connectionString);
                foreach (DataRow drProjectTask in TimezoneTable.Rows)
                {
                    Timezone timezone = new Timezone()
                    {
                        GMTID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drProjectTask["GMTID"], "")),
                        GMTZone = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["GMTZone"], "")),
                    };
                    listTimezone.Add(timezone);
                }

                return listTimezone;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion



        #region[GetReviewForEdit]
        /// <summary>
        /// Created Date    :   04 October 2019
        /// Purpose         :   Get Project Review List 
        /// Created By      :   Chandrashekhar Salagar
        /// <param name="pm_wbs_cardparameter"></param>
        /// <returns>PM_wbs_card list</returns>
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetReviewForEdit([FromBody]PM_Project_Review project_Review)
        {
            DataTable Project_Review = new DataTable();
            PM_Project_Review PR = new PM_Project_Review();
            Project_Review = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_ReviewStatistics_Edit " + HttpUtility.UrlDecode(project_Review.ReviewStatisticsID.ToString()) + " ", true, CommonController.connectionString);

            try
            {
                PR.ReviewTitle = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["ReviewTitle"], ""));
                PR.ReviewStartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["ReviewStartDate"], ""));
                PR.ReviewEndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["ReviewEndDate"], ""));
                PR.ReviewType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["ReviewType"], ""));
                PR.ReviewedBy = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["ReviewedBy"], ""));
                PR.Reviewee = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["Reviewee"], ""));
                PR.ReviewEffort = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["ReviewEffort"], ""));
                PR.ProjectId = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["ProjectId"], ""));
                PR.ProjectPhase = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["ProjectPhase"], ""));
                PR.NoOfReviews = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["NoOfReviews"], ""));
                PR.NoOfDefects = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["NoOfDefects"], ""));
                PR.ReviewNotes = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["ReviewNotes"], ""));
                PR.MeasurementNumber = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["MeasurementNumber"], ""));
                PR.MeasurementUnit = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["MeasurementUnit"], ""));
                PR.CReviewType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["CReviewType"], ""));
                PR.CreatedBy = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["CreatedBy"], ""));
                PR.CReviewTypeID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["CReviewTypeID"], ""));
                PR.PReviewTypeID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["PReviewTypeID"], ""));
                PR.ReviewStatus = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["ReviewStatus"], ""));
                PR.IsPlannedReview = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["IsPlannedReview"], ""));
                PR.WorkProductType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["WorkProductType"], ""));
                PR.WorkProductName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["WorkProductName"], ""));
                PR.Conclusion = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["Conclusion"], ""));
                PR.ModuleID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["ModuleID"], ""));
                PR.DeliverableID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["DeliverableID"], ""));
                PR.DeliverableTypeID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["DeliverableTypeID"], ""));
                PR.ChecklistTypeId = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["ChecklistTypeId"], ""));
                PR.IssueIds = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["IssueIds"], ""));
                PR.ActualStartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["ActualStartDate"], ""));
                PR.ActualEndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["ActualEndDate"], ""));
                PR.IsOfflineReview = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["IsOfflineReview"], ""));
                PR.IsReviewBillable = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["IsReviewBillable"], ""));
                PR.ModifiedBy = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["ModifiedBy"], ""));
                PR.FastTrackReviewName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["FastTrackReviewName"], ""));
                PR.UserStoryID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["UserStoryID"], ""));
                PR.IterationID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["IterationID"], ""));
                PR.ReleaseID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["ReleaseID"], ""));
                PR.IsCarryForwardedReview = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["IsCarryForwardedReview"], ""));
                PR.WhatWentWrong = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["WhatWentWrong"], ""));
                PR.WhatWasRight = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["WhatWasRight"], ""));
                PR.SubProjectID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["SubProjectID"], ""));
                PR.PhaseID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["PhaseID"], ""));
                PR.MilestoneID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["MilestoneID"], ""));
                PR.TimeZone = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["TimeZone"], ""));
                PR.StartTime = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["StartTime"], ""));
                PR.EndTime = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["EndTime"], ""));
                PR.IsSendReviewInvite = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["IsSendReviewInvite"], ""));
                //added by Vishal M 31-12-2019
                PR.IsReviewInviteCancelled = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["isReviewInviteCancelled"], ""));
                return PR;
            }
            catch (Exception ex)
            {
                return  Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion


        #region[getDeliverables]
        /// <summary>
        /// Created Date        :       09 Oct  2019
        /// Purpose             :       getDeliverables
        /// Author              :       Chandrashekhar Salagar
        /// </summary>
        /// <param name="project_Review"></param>
        /// <returns></returns>

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        //public List<Deliverables> getDeliverables([FromBody]PM_Project_Review project_Review)
        public object getDeliverables([FromBody] PM_Project_Review project_Review)

        {
            try
            {
                List<Deliverables> listDeliverables = new List<Deliverables>();
                DataTable DeliverablesTable = WBSAttributes(Convert.ToInt32(project_Review.ProjectId), 0);
                foreach (DataRow drDeliverables in DeliverablesTable.Rows)
                {
                    Deliverables R = new Deliverables()
                    {
                        ScheduleID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drDeliverables["ScheduleID"], "")),
                        Title = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDeliverables["Title"], "")),
                    };
                    listDeliverables.Add(R);
                }

                return listDeliverables;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion



        #region[GetModules]
        /// <summary>
        /// Created Date        :       09 Oct  2019
        /// Purpose             :       GetModules
        /// Author              :       Chandrashekhar Salagar
        /// </summary>
        /// <param name="project_Review"></param>
        /// <returns></returns>

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        //public List<Modules> GetModules([FromBody]PM_Project_Review project_Review)
        public object GetModules([FromBody] PM_Project_Review project_Review)

        {
            try
            {
                List<Modules> listModules = new List<Modules>();
                DataTable ModulesTable = WBSAttributes(Convert.ToInt32(project_Review.ProjectId), 1);
                foreach (DataRow drModules in ModulesTable.Rows)
                {
                    Modules modules = new Modules()
                    {
                        ModuleID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drModules["ModuleID"], "")),
                        ModuleName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drModules["ModuleName"], "")),
                    };
                    listModules.Add(modules);
                }

                return listModules;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion



        #region[GetSubProjects]
        /// <summary>
        /// Created Date        :       09 Oct  2019
        /// Purpose             :       GetModules
        /// Author              :       Chandrashekhar Salagar
        /// </summary>
        /// <param name="project_Review"></param>
        /// <returns></returns>
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        //public List<SubProjects> GetSubProjects([FromBody]PM_Project_Review project_Review)
        public object GetSubProjects([FromBody] PM_Project_Review project_Review)

        {
            try
            {
                List<SubProjects> listSubProjects = new List<SubProjects>();
                DataTable SubProjectsTable = WBSAttributes(Convert.ToInt32(project_Review.ProjectId), 2);
                foreach (DataRow drSubProjects in SubProjectsTable.Rows)
                {
                    SubProjects subProjects = new SubProjects()
                    {
                        SubProjectId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drSubProjects["SubProjectId"], "")),
                        SubProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drSubProjects["SubProjectName"], "")),
                    };
                    listSubProjects.Add(subProjects);
                }

                return listSubProjects;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion



        #region[GetMilestones]
        /// <summary>
        /// Created Date        :       09 Oct  2019
        /// Purpose             :       GetMilestones
        /// Author              :       Chandrashekhar Salagar
        /// </summary>
        /// <param name="project_Review"></param>
        /// <returns></returns>
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        //public List<Milestones> GetMilestones([FromBody]PM_Project_Review project_Review)
        public object GetMilestones([FromBody] PM_Project_Review project_Review)

        {
            try
            {
                List<Milestones> listMilestones = new List<Milestones>();
                DataTable MilestonesTable = WBSAttributes(Convert.ToInt32(project_Review.ProjectId), 3);
                foreach (DataRow drMilestones in MilestonesTable.Rows)
                {
                    Milestones milestones = new Milestones()
                    {
                        MileStoneID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drMilestones["MileStoneID"], "")),
                        MileStone = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drMilestones["MileStone"], "")),
                    };
                    listMilestones.Add(milestones);
                }

                return listMilestones;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion


        #region[GetProject_Phases]
        /// <summary>
        /// Created Date        :       09 Oct  2019
        /// Purpose             :       GetProject_Phases
        /// Author              :       Chandrashekhar Salagar
        /// </summary>
        /// <param name="project_Review"></param>
        /// <returns></returns>
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        //public List<Project_Phases> GetProject_Phases([FromBody] PM_Project_Review project_Review)
        public object GetProject_Phases([FromBody] PM_Project_Review project_Review)
        {
            try
            {
                List<Project_Phases> listPhase = new List<Project_Phases>();
                DataTable Project_PhasesTable = WBSAttributes(Convert.ToInt32(project_Review.ProjectId), 4);
                foreach (DataRow drProject_Phases in Project_PhasesTable.Rows)
                {
                    Project_Phases project_Phases = new Project_Phases()
                    {
                        ProjectPhaseID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drProject_Phases["ProjectPhaseID"], "")),
                        Phase = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProject_Phases["Phase"], "")),
                    };
                    listPhase.Add(project_Phases);
                }

                return listPhase;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
            #endregion



            #region[WBSAttributes]
            /// <summary>
            /// Created Date    :   09 Oct 2019
            /// Purpose         :   Get WBS Attributes
            /// Author          :   Chandrashekhar Salagar
            /// </summary>
            /// <param name="ProjectID"></param>
            /// <param name="TableIndex"></param>
            /// <returns></returns>
            public DataTable WBSAttributes(int ProjectID, int TableIndex)
        {
            DataTable WBSTable = new DataTable();
            DataSet wSAtributesDS = new DataSet();
            PM_Project_Review PR = new PM_Project_Review();
            wSAtributesDS = CommonFunctions.Data.GetDataSet("usp_Whizible2_Sel_WBSAttributes " + ProjectID + " ", "WbsAttributes", 0, 0, true, CommonController.connectionString);
            return wSAtributesDS.Tables[TableIndex];
        }
        #endregion

        #region[UpdateProjectReview]
        /// <summary>
        /// Created Date    :   10 October 2019
        /// Purpose         :   UpdateProjectReview
        /// Created By      :   Chandrashekhar Salagar
        /// <param name="pm_wbs_cardparameter"></param>
        /// <returns>PM_wbs_card list</returns>
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateProjectReview([FromBody]PM_Project_Review project_Review)
        {
            try
            {
                string Message = "";
                var StatisticsID = "";

                /*Validate start date end date*/
                Message = GetResourceStartEndDate(project_Review);

                //Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                //                              (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Validate_ReviewDates '"
                //                                                                   + HttpUtility.UrlDecode(project_Review.ProjectId) + "','"
                //                                                                   + HttpUtility.UrlDecode(project_Review.ReviewStartDate) + "','"
                //                                                                   + HttpUtility.UrlDecode(project_Review.ReviewEndDate) + "' "
                //                                                                   ,
                //                                                                   true, CommonController.connectionString
                //                                                                   ),
                //                                "")
                //                                );

                if (string.IsNullOrEmpty(Message))
                {
                    try
                    {
                        //Added By Usha Pandit On 13.04.2020 For not saving placeholder for WorkProductType
                        if (HttpUtility.UrlDecode(project_Review.WorkProductType) != "Select Work Product Type")
                        {
                            //End Of Added By Usha Pandit On 13.04.2020 For not saving placeholder for WorkProductType
                            StatisticsID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                                          (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Upd_tbl_PM_ReviewStatistics '"
                                                                                               + HttpUtility.UrlDecode(project_Review.ReviewStatisticsID) + "','"
                                                                                               + HttpUtility.UrlDecode(project_Review.ProjectId) + "','"
                                                                                               + HttpUtility.UrlDecode(project_Review.ReviewType) + "','"
                                                                                               + HttpUtility.UrlDecode(project_Review.ProjectPhase) + "','"
                                                                                               + HttpUtility.UrlDecode(project_Review.NoOfReviews) + "','"
                                                                                               + HttpUtility.UrlDecode(project_Review.ReviewEffort) + "','"
                                                                                               + HttpUtility.UrlDecode(project_Review.NoOfDefects) + "','"
                                                                                               + HttpUtility.UrlDecode(project_Review.ReviewedBy) + "',' "
                                                                                               + HttpUtility.UrlDecode(project_Review.ReviewNotes.Replace("'", "''")) + "','"
                                                                                               + HttpUtility.UrlDecode(project_Review.Reviewee) + "', "
                                                                                               + HttpUtility.UrlDecode(project_Review.CReviewTypeID) + ","
                                                                                               + HttpUtility.UrlDecode(project_Review.PReviewTypeID) + ",'"
                                                                                               + HttpUtility.UrlDecode(project_Review.IsPlannedReview) + "','"
                                                                                               + HttpUtility.UrlDecode(project_Review.WorkProductType) + "','"
                                                                                               + HttpUtility.UrlDecode(project_Review.WorkProductName) + "',"
                                                                                               + HttpUtility.UrlDecode(project_Review.ModuleID) + ","
                                                                                               + HttpUtility.UrlDecode(project_Review.DeliverableID) + ","
                                                                                               + HttpUtility.UrlDecode(project_Review.DeliverableTypeID) + ","
                                                                                               + HttpUtility.UrlDecode(project_Review.ChecklistTypeId) + ",'"
                                                                                               + HttpUtility.UrlDecode(project_Review.ReviewTitle.Replace("'", "''")) + "','"
                                                                                               + HttpUtility.UrlDecode(project_Review.ReviewStartDate) + "','"
                                                                                               + HttpUtility.UrlDecode(project_Review.ReviewEndDate) + "','"
                                                                                               + HttpUtility.UrlDecode(project_Review.IsOfflineReview) + "','"
                                                                                               + HttpUtility.UrlDecode(project_Review.IsReviewBillable) + "','"
                                                                                               + HttpUtility.UrlDecode(project_Review.ModifiedBy) + "',"
                                                                                               //+ HttpUtility.UrlDecode(project_Review.IsCarryForwardedReview) + "',"
                                                                                               + HttpUtility.UrlDecode(project_Review.SubProjectID) + ","
                                                                                               + HttpUtility.UrlDecode(project_Review.MilestoneID) + ","
                                                                                               + HttpUtility.UrlDecode(project_Review.PhaseID) + ",'"
                                                                                               + HttpUtility.UrlDecode(project_Review.StartTime) + "','"
                                                                                               + HttpUtility.UrlDecode(project_Review.EndTime) + "','"
                                                                                               + HttpUtility.UrlDecode(project_Review.TimeZone) + "','"
                                                                                               + HttpUtility.UrlDecode(project_Review.IsSendReviewInvite) + "','"
                                                                                               + HttpUtility.UrlDecode(project_Review.SelectedReviewerIDs) + "','"
                                                                                               + HttpUtility.UrlDecode(project_Review.SelectedRevieweeIDs) + "', "
                                                                                               + HttpUtility.UrlDecode(project_Review.IterationID == null ? "null" : project_Review.IterationID) + ""
                                                                                               ,
                                                                                               true, CommonController.connectionString
                                                                                               ),
                                                            "")
                                                            );
                        }
                        //Added By Usha Pandit On 13.04.2020 For not saving placeholder for WorkProductType
                        else
                        {
                            StatisticsID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                                                                  (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Upd_tbl_PM_ReviewStatistics '"
                                                                                                                       + HttpUtility.UrlDecode(project_Review.ReviewStatisticsID) + "','"
                                                                                                                       + HttpUtility.UrlDecode(project_Review.ProjectId) + "','"
                                                                                                                       + HttpUtility.UrlDecode(project_Review.ReviewType) + "','"
                                                                                                                       + HttpUtility.UrlDecode(project_Review.ProjectPhase) + "','"
                                                                                                                       + HttpUtility.UrlDecode(project_Review.NoOfReviews) + "','"
                                                                                                                       + HttpUtility.UrlDecode(project_Review.ReviewEffort) + "','"
                                                                                                                       + HttpUtility.UrlDecode(project_Review.NoOfDefects) + "','"
                                                                                                                       + HttpUtility.UrlDecode(project_Review.ReviewedBy) + "',' "
                                                                                                                       + HttpUtility.UrlDecode(project_Review.ReviewNotes.Replace("'", "''")) + "','"
                                                                                                                       + HttpUtility.UrlDecode(project_Review.Reviewee) + "', "
                                                                                                                       + HttpUtility.UrlDecode(project_Review.CReviewTypeID) + ","
                                                                                                                       + HttpUtility.UrlDecode(project_Review.PReviewTypeID) + ",'"
                                                                                                                       + HttpUtility.UrlDecode(project_Review.IsPlannedReview) + "','"
                                                                                                                       + "" + "','"
                                                                                                                       + HttpUtility.UrlDecode(project_Review.WorkProductName) + "',"
                                                                                                                       + HttpUtility.UrlDecode(project_Review.ModuleID) + ","
                                                                                                                       + HttpUtility.UrlDecode(project_Review.DeliverableID) + ","
                                                                                                                       + HttpUtility.UrlDecode(project_Review.DeliverableTypeID) + ","
                                                                                                                       + HttpUtility.UrlDecode(project_Review.ChecklistTypeId) + ",'"
                                                                                                                       + HttpUtility.UrlDecode(project_Review.ReviewTitle.Replace("'", "''")) + "','"
                                                                                                                       + HttpUtility.UrlDecode(project_Review.ReviewStartDate) + "','"
                                                                                                                       + HttpUtility.UrlDecode(project_Review.ReviewEndDate) + "','"
                                                                                                                       + HttpUtility.UrlDecode(project_Review.IsOfflineReview) + "','"
                                                                                                                       + HttpUtility.UrlDecode(project_Review.IsReviewBillable) + "','"
                                                                                                                       + HttpUtility.UrlDecode(project_Review.ModifiedBy) + "',"
                                                                                                                       //+ HttpUtility.UrlDecode(project_Review.IsCarryForwardedReview) + "',"
                                                                                                                       + HttpUtility.UrlDecode(project_Review.SubProjectID) + ","
                                                                                                                       + HttpUtility.UrlDecode(project_Review.MilestoneID) + ","
                                                                                                                       + HttpUtility.UrlDecode(project_Review.PhaseID) + ",'"
                                                                                                                       + HttpUtility.UrlDecode(project_Review.StartTime) + "','"
                                                                                                                       + HttpUtility.UrlDecode(project_Review.EndTime) + "','"
                                                                                                                       + HttpUtility.UrlDecode(project_Review.TimeZone) + "','"
                                                                                                                       + HttpUtility.UrlDecode(project_Review.IsSendReviewInvite) + "','"
                                                                                                                       + HttpUtility.UrlDecode(project_Review.SelectedReviewerIDs) + "','"
                                                                                                                       + HttpUtility.UrlDecode(project_Review.SelectedRevieweeIDs) + "', "
                                                                                                                       + HttpUtility.UrlDecode(project_Review.IterationID == null ? "null" : project_Review.IterationID) + ""
                                                                                                                       ,
                                                                                                                       true, CommonController.connectionString
                                                                                                                       ),
                                                                                    "")
                                                                                    );
                        }
                        //End Of Added By Usha Pandit On 13.04.2020 For not saving placeholder for WorkProductType
                    }
                    catch (Exception ex)
                    {
                    }

                    //Update Estimation Efforts//
                    string hh = "0";
                    string mm = "0";
                    if (!string.IsNullOrEmpty(project_Review.ReviewEffort))
                    {
                        string[] strarray = project_Review.ReviewEffort.Split(':');
                        hh = strarray[0];
                        if (strarray.Length > 1)
                            mm = strarray[1];
                    }
                    if (StatisticsID != "-1")
                    {
                        var msg = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                              (CommonFunctions.Data.GetDataScalar("usp_Whizible2_upd_EstimatedEffortsForWBS " + StatisticsID + ",'" + hh + "','" + mm + "',6 ", true, CommonController.connectionString)
                                              ,
                                              "")
                                              );
                    }
                    else
                    {
                    }
                    //start by Vishal Mahajan 07-12-2019
                    Message = StatisticsID;
                    //end by Vishal Mahajan 07-12-2019

                }


                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[GetProjectCheckList]
        /// <summary>
        /// Created Date    :   14 October 2019
        /// Purpose         :   GetProjectCheckList
        /// Created By      :   Chandrashekhar Salagar
        /// <param name="pm_wbs_cardparameter"></param>
        /// <returns>PM_wbs_card list</returns>
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        //public List<ProjectCheckList> GetProjectCheckList([FromBody]PM_Project_Review project_Review)
        public object GetProjectCheckList([FromBody] PM_Project_Review project_Review)

        {
            try
            {
                List<ProjectCheckList> listProjectCheckList = new List<ProjectCheckList>();
                DataTable ProjectListTable = new DataTable();
                ProjectListTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_GetProjectChecklistsAndGroups " + project_Review.ProjectId + ",0  ", true, CommonController.connectionString);
                foreach (DataRow drProjectList in ProjectListTable.Rows)
                {
                    ProjectCheckList projectCheckList = new ProjectCheckList()
                    {
                        ProjectCheckListID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["ProjectCheckListID"], "")),
                        CheckListShortName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["CheckListShortName"], "")),
                    };
                    listProjectCheckList.Add(projectCheckList);
                }
                return listProjectCheckList;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion


        #region[GetWorkProductType]
        /// <summary>
        /// Created Date    :   14 October 2019
        /// Purpose         :   GetWorkProductType
        /// Created By      :   Chandrashekhar Salagar
        /// <param name="pm_wbs_cardparameter"></param>
        /// <returns>PM_wbs_card list</returns>
        [HttpPost]
        [Authorize]
        //public List<ProductType> GetWorkProductType()
        public object GetWorkProductType()
        {
            try
            {
                List<ProductType> listWorkProductType = new List<ProductType>();
                DataTable WorkProductTypeTable = new DataTable();
                WorkProductTypeTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_WorkProductTypes ", true, CommonController.connectionString);
                foreach (DataRow drWorkProductType in WorkProductTypeTable.Rows)
                {
                    ProductType workProductType = new ProductType()
                    {
                        WorkProductType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drWorkProductType["WorkProductType"], "")),
                    };
                    listWorkProductType.Add(workProductType);
                }
                return listWorkProductType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        /// <summary>
        /// Created Date    :   16 Oct 2019
        /// Purpose         :   DeleteReview
        /// Author          :   Chandrashekhar Salagar
        /// </summary>
        /// <param name="project_Review"></param>
        /// <returns></returns>
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteReview([FromBody]PM_Project_Review project_Review)
        {
            try
            {
                string result = "";
                result = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                              (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Del_tbl_PM_ReviewStatistics "
                                              + HttpUtility.UrlDecode(project_Review.ProjectId) + ","
                                              + HttpUtility.UrlDecode(project_Review.ReviewStatisticsID) + " "

                                              , true, CommonController.connectionString)
                                              ,
                                              "")
                                              );
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object CheckWFApplicableOrNOt([FromBody]PM_Project_Review project_Review)
        {
            try
            {
                string m_blnIsProjectCreationWorkflowReqd = "";
                string m_strBaselineMessage = ""; //'Added By Dipali V On 8th April 2020 For Get alert MSG

                m_blnIsProjectCreationWorkflowReqd = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                              (CommonFunctions.Data.GetDataScalar("usp_Sel_PM_GetProjectCreationWorkflowReqd_Status "
                                              + HttpUtility.UrlDecode(project_Review.ProjectId) + ""

                                              , true, CommonController.connectionString)
                                              ,
                                              "")
                                              );
                if (m_blnIsProjectCreationWorkflowReqd != "true")
                {

                    DataTable ProjectReview = new DataTable();
                    ProjectReview = CommonFunctions.Data.GetDataTable("Exec usp_Sel_tbl_CNF_Project_Status " + project_Review.ProjectId + " ", true, CommonController.connectionString);
                    foreach (DataRow drProjectReview in ProjectReview.Rows)
                    {
                        //ProjectIteration projectCheckList = new ProjectIteration()
                        //{
                        m_strBaselineMessage = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drProjectReview["BaseLineMessage"], ""), "");


                        //};

                    }

                }
                return m_strBaselineMessage;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }




        #region[SaveConductedReview]
        /// <summary>
        /// Created Date    :   22 October 2019
        /// Purpose         :   SaveConductedReview
        /// Created By      :   Chandrashekhar Salagar
        /// <param name="pm_wbs_cardparameter"></param>
        /// <returns>PM_wbs_card list</returns>
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveConductedReview([FromBody] PM_Project_Review project_Review)
        {
            try
            {
                string Message = "";
                var StatisticsID = "";

                /*Validate start date end date*/
                Message = GetResourceStartEndDate(project_Review);
                //Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                //                              (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Validate_ReviewDates '"
                //                                                                   + HttpUtility.UrlDecode(project_Review.ProjectId) + "','"
                //                                                                   + HttpUtility.UrlDecode(project_Review.ReviewStartDate) + "','"
                //                                                                   + HttpUtility.UrlDecode(project_Review.ReviewEndDate) + "' "
                //                                                                   ,
                //                                                                   true, CommonController.connectionString
                //                                                                   ),
                //                                "")
                //                                );

                if (string.IsNullOrEmpty(Message))
                {
                    //Added By Usha Pandit On 13.04.2020 For not saving placeholder for WorkProductType
                    if (HttpUtility.UrlDecode(project_Review.WorkProductType) != "Select Work Product Type")
                    {
                        //End Of Added By Usha Pandit On 13.04.2020 For not saving placeholder for WorkProductType
                        StatisticsID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                                  (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_ReviewStatistics_Conducted '"
                                                                                       + HttpUtility.UrlDecode(project_Review.ReviewStatisticsID) + "','"
                                                                                       + HttpUtility.UrlDecode(project_Review.ProjectId) + "','"
                                                                                       + HttpUtility.UrlDecode(project_Review.ReviewType) + "','"
                                                                                       + HttpUtility.UrlDecode(project_Review.ProjectPhase) + "','"
                                                                                       + HttpUtility.UrlDecode(project_Review.NoOfReviews) + "','"
                                                                                       + HttpUtility.UrlDecode(project_Review.ReviewEffort) + "','"
                                                                                       + HttpUtility.UrlDecode(project_Review.NoOfDefects) + "','"
                                                                                       + HttpUtility.UrlDecode(project_Review.ReviewedBy) + "',' "
                                                                                       + HttpUtility.UrlDecode(project_Review.ReviewNotes.Replace("'", "''")) + "','"
                                                                                       + HttpUtility.UrlDecode(project_Review.Reviewee) + "', "
                                                                                       + HttpUtility.UrlDecode(project_Review.CReviewTypeID) + ","
                                                                                       + HttpUtility.UrlDecode(project_Review.PReviewTypeID) + ",'"
                                                                                       + HttpUtility.UrlDecode(project_Review.IsPlannedReview) + "','"
                                                                                       + HttpUtility.UrlDecode(project_Review.WorkProductType) + "','"
                                                                                       + HttpUtility.UrlDecode(project_Review.WorkProductName.Replace("'", "''")) + "',"
                                                                                       + HttpUtility.UrlDecode(project_Review.ModuleID) + ","
                                                                                       + HttpUtility.UrlDecode(project_Review.DeliverableID) + ","
                                                                                       + HttpUtility.UrlDecode(project_Review.DeliverableTypeID) + ","
                                                                                       + HttpUtility.UrlDecode(project_Review.ChecklistTypeId) + ",'"
                                                                                       + HttpUtility.UrlDecode(project_Review.ReviewTitle.Replace("'", "''")) + "','"
                                                                                       + HttpUtility.UrlDecode(project_Review.ReviewStartDate) + "','"
                                                                                       + HttpUtility.UrlDecode(project_Review.ReviewEndDate) + "','"
                                                                                       + HttpUtility.UrlDecode(project_Review.IsOfflineReview) + "','"
                                                                                       + HttpUtility.UrlDecode(project_Review.IsReviewBillable) + "','"
                                                                                       + HttpUtility.UrlDecode(project_Review.ModifiedBy) + "',"
                                                                                       //+ HttpUtility.UrlDecode(project_Review.IsCarryForwardedReview) + "',"
                                                                                       + HttpUtility.UrlDecode(project_Review.SubProjectID) + ","
                                                                                       + HttpUtility.UrlDecode(project_Review.MilestoneID) + ","
                                                                                       + HttpUtility.UrlDecode(project_Review.PhaseID) + ",'"
                                                                                       + HttpUtility.UrlDecode(project_Review.StartTime) + "','"
                                                                                       + HttpUtility.UrlDecode(project_Review.EndTime) + "','"
                                                                                       + HttpUtility.UrlDecode(project_Review.TimeZone) + "','"
                                                                                       + HttpUtility.UrlDecode(project_Review.IsSendReviewInvite) + "',"
                                                                                      + HttpUtility.UrlDecode(project_Review.MeasurementNumber == "" ? "null" : project_Review.MeasurementNumber) + ",'"
                                                                                      //Commented and Added By Reshma C on 19 March 2020 For IssueID-23419
                                                                                      //+ HttpUtility.UrlDecode(project_Review.Conclusion.Replace("'", "''")) + "','"
                                                                                      + HttpUtility.UrlDecode(project_Review.Conclusion.ToString().Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "','"
                                                                                      //Commented and Added By Reshma C on 19 March 2020 For IssueID-23419
                                                                                      + HttpUtility.UrlDecode(project_Review.MeasurementUnit) + "','"
                                                                                      //Commented and Added By Reshma C on 19 March 2020 For IssueID-23419
                                                                                      //+ HttpUtility.UrlDecode(project_Review.WhatWentWrong.Replace("'", "''")) + "','"
                                                                                      //+ HttpUtility.UrlDecode(project_Review.WhatWasRight.Replace("'", "''")) + "',"
                                                                                      + HttpUtility.UrlDecode(project_Review.WhatWentWrong.ToString().Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "','"
                                                                                      + HttpUtility.UrlDecode(project_Review.WhatWasRight.ToString().Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "',"
                                                                                      //End of Commented and Added By Reshma C on 19 March 2020 For IssueID-23419
                                                                                      + HttpUtility.UrlDecode(project_Review.IterationID == null ? "null" : project_Review.IterationID) + ",'"
                                                                                      + HttpUtility.UrlDecode(project_Review.ReviewStatus == "" ? "null" : project_Review.ReviewStatus) + "',' "
                                                                                      + HttpUtility.UrlDecode(project_Review.SelectedReviewerIDs) + "','"
                                                                                      + HttpUtility.UrlDecode(project_Review.SelectedRevieweeIDs) + "' "
                                                                                      , true, CommonController.connectionString
                                                                                       ),
                                                    "")
                                                    );
                    }
                    //Added By Usha Pandit On 13.04.2020 For not saving placeholder for WorkProductType
                    else
                    {
                        StatisticsID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                                                      (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_ReviewStatistics_Conducted '"
                                                                                                           + HttpUtility.UrlDecode(project_Review.ReviewStatisticsID) + "','"
                                                                                                           + HttpUtility.UrlDecode(project_Review.ProjectId) + "','"
                                                                                                           + HttpUtility.UrlDecode(project_Review.ReviewType) + "','"
                                                                                                           + HttpUtility.UrlDecode(project_Review.ProjectPhase) + "','"
                                                                                                           + HttpUtility.UrlDecode(project_Review.NoOfReviews) + "','"
                                                                                                           + HttpUtility.UrlDecode(project_Review.ReviewEffort) + "','"
                                                                                                           + HttpUtility.UrlDecode(project_Review.NoOfDefects) + "','"
                                                                                                           + HttpUtility.UrlDecode(project_Review.ReviewedBy) + "',' "
                                                                                                           + HttpUtility.UrlDecode(project_Review.ReviewNotes.Replace("'", "''")) + "','"
                                                                                                           + HttpUtility.UrlDecode(project_Review.Reviewee) + "', "
                                                                                                           + HttpUtility.UrlDecode(project_Review.CReviewTypeID) + ","
                                                                                                           + HttpUtility.UrlDecode(project_Review.PReviewTypeID) + ",'"
                                                                                                           + HttpUtility.UrlDecode(project_Review.IsPlannedReview) + "','"
                                                                                                           + "" + "','"
                                                                                                           + HttpUtility.UrlDecode(project_Review.WorkProductName.Replace("'", "''")) + "',"
                                                                                                           + HttpUtility.UrlDecode(project_Review.ModuleID) + ","
                                                                                                           + HttpUtility.UrlDecode(project_Review.DeliverableID) + ","
                                                                                                           + HttpUtility.UrlDecode(project_Review.DeliverableTypeID) + ","
                                                                                                           + HttpUtility.UrlDecode(project_Review.ChecklistTypeId) + ",'"
                                                                                                           + HttpUtility.UrlDecode(project_Review.ReviewTitle.Replace("'", "''")) + "','"
                                                                                                           + HttpUtility.UrlDecode(project_Review.ReviewStartDate) + "','"
                                                                                                           + HttpUtility.UrlDecode(project_Review.ReviewEndDate) + "','"
                                                                                                           + HttpUtility.UrlDecode(project_Review.IsOfflineReview) + "','"
                                                                                                           + HttpUtility.UrlDecode(project_Review.IsReviewBillable) + "','"
                                                                                                           + HttpUtility.UrlDecode(project_Review.ModifiedBy) + "',"
                                                                                                           //+ HttpUtility.UrlDecode(project_Review.IsCarryForwardedReview) + "',"
                                                                                                           + HttpUtility.UrlDecode(project_Review.SubProjectID) + ","
                                                                                                           + HttpUtility.UrlDecode(project_Review.MilestoneID) + ","
                                                                                                           + HttpUtility.UrlDecode(project_Review.PhaseID) + ",'"
                                                                                                           + HttpUtility.UrlDecode(project_Review.StartTime) + "','"
                                                                                                           + HttpUtility.UrlDecode(project_Review.EndTime) + "','"
                                                                                                           + HttpUtility.UrlDecode(project_Review.TimeZone) + "','"
                                                                                                           + HttpUtility.UrlDecode(project_Review.IsSendReviewInvite) + "',"
                                                                                                          + HttpUtility.UrlDecode(project_Review.MeasurementNumber == "" ? "null" : project_Review.MeasurementNumber) + ",'"
                                                                                                          + HttpUtility.UrlDecode(project_Review.Conclusion.Replace("'", "''")) + "','"
                                                                                                          + HttpUtility.UrlDecode(project_Review.MeasurementUnit) + "','"
                                                                                                          + HttpUtility.UrlDecode(project_Review.WhatWentWrong.Replace("'", "''")) + "','"
                                                                                                          + HttpUtility.UrlDecode(project_Review.WhatWasRight.Replace("'", "''")) + "',"
                                                                                                          + HttpUtility.UrlDecode(project_Review.IterationID == null ? "null" : project_Review.IterationID) + ",'"
                                                                                                          + HttpUtility.UrlDecode(project_Review.ReviewStatus == "" ? "null" : project_Review.ReviewStatus) + "',' "
                                                                                                          + HttpUtility.UrlDecode(project_Review.SelectedReviewerIDs) + "','"
                                                                                                          + HttpUtility.UrlDecode(project_Review.SelectedRevieweeIDs) + "' "
                                                                                                          , true, CommonController.connectionString
                                                                                                           ),
                                                                        "")
                                                                        );
                    }
                    //End Of Added By Usha Pandit On 13.04.2020 For not saving placeholder for WorkProductType
                    //Update Estimation Efforts//
                    string hh = "0";
                    string mm = "0";
                    if (!string.IsNullOrEmpty(project_Review.ReviewEffort))
                    {
                        string[] strarray = project_Review.ReviewEffort.Split(':');
                        hh = strarray[0];
                        if (strarray.Length > 1)
                            mm = strarray[1];
                    }
                    if (StatisticsID != "-1")
                    {
                        var msg = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                              (CommonFunctions.Data.GetDataScalar("usp_Whizible2_upd_EstimatedEffortsForWBS " + StatisticsID + ",'" + hh + "','" + mm + "',6 ", true, CommonController.connectionString)
                                              ,
                                              "")
                                              );
                    }
                    else
                    {
                    }
                    //start by Vishal Mahajan 12-12-2019
                    Message = StatisticsID;
                    //end by Vishal Mahajan 12-12-2019

                }


                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
            #endregion

            #region[GetProjectCheckList]
            /// <summary>
            /// Created Date    :   14 October 2019
            /// Purpose         :   GetProjectCheckList
            /// Created By      :   Chandrashekhar Salagar
            /// <param name="pm_wbs_cardparameter"></param>
            /// <returns>PM_wbs_card list</returns>
            [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        //public List<ProjectIteration> GetprojectIteration([FromBody]PM_Project_Review project_Review)
        public object GetprojectIteration([FromBody] PM_Project_Review project_Review)

        {
            try
            {
                List<ProjectIteration> listProjectIteration = new List<ProjectIteration>();
                DataTable ProjectListTable = new DataTable();
                ProjectListTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_ScrumIterationforRetrospective_Review " + project_Review.ProjectId + " ", true, CommonController.connectionString);
                foreach (DataRow drProjectList in ProjectListTable.Rows)
                {
                    ProjectIteration projectCheckList = new ProjectIteration()
                    {
                        IterationID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drProjectList["IterationID"], "")),
                        IterationName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["IterationName"], "")),
                    };
                    listProjectIteration.Add(projectCheckList);
                }
                return listProjectIteration;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[GetReviewCauses]
        /// <summary>
        /// Created Date    :   14 October 2019
        /// Purpose         :   GetReviewCauses
        /// Created By      :   Chandrashekhar Salagar
        /// <param name="pm_wbs_cardparameter"></param>
        /// <returns>PM_wbs_card list</returns>
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        //public List<Causes> GetReviewCauses([FromBody]PM_Project_Review project_Review)
        public object GetReviewCauses([FromBody] PM_Project_Review project_Review)

        {
            try {
                List<Causes> listCauses = new List<Causes>();
                DataTable CausesTable = new DataTable();
                CausesTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_ProjectReviewCausesForReviewMaster "
                                                                + "NULL" + ","
                                                                + "NULL" + ","
                                                                + HttpUtility.UrlDecode(project_Review.ProjectId) + ","
                                                                + HttpUtility.UrlDecode(project_Review.ReviewStatisticsID) + ","
                                                                + "1" + " "
                                                                , true,
                                                                CommonController.connectionString);

                foreach (DataRow drProjectList in CausesTable.Rows)
                {
                    Causes projectCheckList = new Causes()
                    {
                        CReviewCause = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["CReviewCause"], "")),
                        CReviewCauseID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["CReviewCauseID"], "")),
                        PReviewCause = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["PReviewCause"], "")),
                        PReviewCauseID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["PReviewCauseID"], "")),
                        PReviewType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["PReviewType"], "")),
                        PReviewTypeID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["PReviewTypeID"], "")),
                        Used = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["Used"], "")),
                    };
                    listCauses.Add(projectCheckList);
                }
                return listCauses;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[GetReviewActions]
        /// <summary>
        /// Created Date    :   23 October 2019
        /// Purpose         :   GetReviewActions
        /// Created By      :   Chandrashekhar Salagar
        /// <param name="pm_wbs_cardparameter"></param>
        /// <returns>PM_wbs_card list</returns>
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        //public List<ReviewActions> GetReviewActions([FromBody]PM_Project_Review project_Review)
        public object GetReviewActions([FromBody] PM_Project_Review project_Review)

        {
            try
            {
                List<ReviewActions> listReviewActions = new List<ReviewActions>();
                DataTable ReviewActionsTable = new DataTable();
                ReviewActionsTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_ReviewActions "
                                                                + HttpUtility.UrlDecode(project_Review.ReviewStatisticsID) + " "
                                                                , true,
                                                                CommonController.connectionString);

                foreach (DataRow drProjectList in ReviewActionsTable.Rows)
                {
                    ReviewActions reviewactions = new ReviewActions()
                    {
                        Action = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["Action"], "")),
                        CReviewCauseID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["CReviewCauseID"], "")),
                        CReviewType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["CReviewType"], "")),
                        PReviewCauseID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["PReviewCauseID"], "")),
                        IssueID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["IssueID"], "")),
                        PReviewType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["PReviewType"], "")),
                        ProjectID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["ProjectID"], "")),
                        ReviewActionID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["ReviewActionID"], "")),
                        ReviewStatisticsID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["ReviewStatisticsID"], "")),
                        TaskID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["TaskID"], "")),
                        CReviewCause = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["CReviewCause"], "")),
                        Reviewee = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["Reviewee"], "")),
                        TypeOfReview = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["ReviewType"], "")),
                        WorkInHours = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["WorkInHours"], "")),
                        ConvertedActionID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["ConvertedActionID"], "")),
                        TrackToNextReview = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["TrackToNextReview"], "")),
                        Closed = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["Closed"], "")),
                        //Added By Rutuja D. For IssueId = 21074
                        PReviewCause = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["PReviewCause"], "")),
                        //End Added By Rutuja D. For IssueId = 21074
                    };
                    listReviewActions.Add(reviewactions);
                }
                return listReviewActions;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[GetReviewActions]
        /// <summary>
        /// Created Date    :   23 October 2019
        /// Purpose         :   GetReviewActions
        /// Created By      :   Chandrashekhar Salagar
        /// <param name="pm_wbs_cardparameter"></param>
        /// <returns>PM_wbs_card list</returns>
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveReviewAction([FromBody] ReviewActions reviewactions)
        {
            try
            {
                string Message = "";
                if (string.IsNullOrEmpty(reviewactions.ReviewObservationID))
                {
                    reviewactions.ReviewObservationID = null;
                }

                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                              (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_ReviewActions "
                                                                                   + HttpUtility.UrlDecode(reviewactions.ReviewActionID) + ","
                                                                                   + HttpUtility.UrlDecode(reviewactions.ProjectID) + ","
                                                                                   + HttpUtility.UrlDecode(reviewactions.ReviewStatisticsID) + ","
                                                                                   + HttpUtility.UrlDecode(reviewactions.PReviewCauseID) + ",'"
                                                                                   + HttpUtility.UrlDecode(reviewactions.Action.Replace("'", "''")) + "', '"
                                                                                   + HttpUtility.UrlDecode(reviewactions.Reference) + "', '"
                                                                                   + HttpUtility.UrlDecode(reviewactions.ReviewObservationID) + "','"
                                                                                   + HttpUtility.UrlDecode(reviewactions.RevieweeComments) + "', "
                                                                                   + HttpUtility.UrlDecode(reviewactions.Reviewee) + ", '"
                                                                                   + HttpUtility.UrlDecode(reviewactions.CreatedBy) + "' "
                                                                                   ,
                                                                                   true, CommonController.connectionString
                                                                                   ),
                                                "")
                                                );

                if (!string.IsNullOrEmpty(reviewactions.WorkInHours))
                {
                    if (reviewactions.ReviewActionID == "0")
                    {
                        reviewactions.ReviewActionID = Message;
                    }
                    string[] strarray = reviewactions.WorkInHours.Split(':');
                    string hh = strarray[0];
                    string mm = "0";
                    if (strarray.Length > 1)
                        mm = strarray[1];
                    var msg = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                              (CommonFunctions.Data.GetDataScalar("usp_Whizible2_upd_EstimatedEffortsForWBS " + reviewactions.ReviewActionID + ",'" + hh + "','" + mm + "',7 ", true, CommonController.connectionString)
                                              ,
                                              "")
                                              );
                }


                /*Convert to Task if flag is true*/
                if (reviewactions.ConvertTaskChecked)
                {
                    if (reviewactions.ReviewActionID == "0")
                    {
                        reviewactions.ReviewActionID = Message;
                    }
                    /*Update Action*/
                    string ReviewActionID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                              (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_ReviewActions_TaskIssue "
                                                                                   + HttpUtility.UrlDecode(reviewactions.ReviewActionID) + ","
                                                                                   + HttpUtility.UrlDecode(reviewactions.ReviewStatisticsID) + ","
                                                                                   + HttpUtility.UrlDecode(reviewactions.ProjectID) + ",NULL,NULL,"
                                                                                   + HttpUtility.UrlDecode(reviewactions.PReviewCauseID) + ",NULL,'"
                                                                                   + HttpUtility.UrlDecode(reviewactions.Action.Replace("'", "''")) + "', '"
                                                                                   + HttpUtility.UrlDecode(reviewactions.Reference) + "', '"
                                                                                   + HttpUtility.UrlDecode(reviewactions.ReviewObservationID) + "','"
                                                                                   + HttpUtility.UrlDecode(reviewactions.CreatedBy) + "', "
                                                                                   + HttpUtility.UrlDecode(reviewactions.Reviewee) + " "
                                                                                   ,
                                                                                   true, CommonController.connectionString
                                                                                   ),
                                                 "")
                                                );
                    /*Create Task*/

                    string taskID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                             (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_ProjectTasks_AssignReviewActionPoint "
                                                                                  + ReviewActionID + ",'"
                                                                                  + HttpUtility.UrlDecode(reviewactions.CreatedBy) + "' "
                                                                                  ,
                                                                                  true, CommonController.connectionString
                                                                                  ),
                                                "")
                                               );

                }

                /*Convert to issue if flag is true*/
                if (reviewactions.ConvertIssueChecked)
                {
                    if (reviewactions.ReviewActionID == "0")
                    {
                        reviewactions.ReviewActionID = Message;
                    }
                    /*Update Action*/
                    string ReviewActionID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                              (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_ReviewActions_TaskIssue "
                                                                                   + HttpUtility.UrlDecode(reviewactions.ReviewActionID) + ","
                                                                                   + HttpUtility.UrlDecode(reviewactions.ReviewStatisticsID) + ","
                                                                                   + HttpUtility.UrlDecode(reviewactions.ProjectID) + ",NULL,NULL,"
                                                                                   + HttpUtility.UrlDecode(reviewactions.PReviewCauseID) + ",NULL,'"
                                                                                   + HttpUtility.UrlDecode(reviewactions.Action.Replace("'", "''")) + "', '"
                                                                                   + HttpUtility.UrlDecode(reviewactions.Reference) + "', '"
                                                                                   + HttpUtility.UrlDecode(reviewactions.ReviewObservationID) + "','"
                                                                                   + HttpUtility.UrlDecode(reviewactions.CreatedBy) + "', "
                                                                                   + HttpUtility.UrlDecode(reviewactions.Reviewee) + " "
                                                                                   ,
                                                                                   true, CommonController.connectionString
                                                                                   ),
                                                 "")
                                                );
                    /*Create Task*/

                    string taskID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                             (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_IB_Issue_AssignReviewActionPoint "
                                                                                  + ReviewActionID + ",'"
                                                                                  + HttpUtility.UrlDecode(reviewactions.CreatedBy) + "' "
                                                                                  ,
                                                                                  true, CommonController.connectionString
                                                                                  ),
                                                "")
                                               );

                }



                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion


        #region[DeleteReviewAction]
        /// <summary>
        /// Created Date    :   08 Sept 2019
        /// Purpose         :   Delete review action
        /// Created By      :   Chandrashekhar Salagar
        /// <param name="pm_wbs_cardparameter"></param>
        /// <returns>PM_wbs_card list</returns>
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteReviewAction([FromBody] ReviewActions reviewactions)
        {
            try
            {
                string Message = "";
                if (reviewactions.TypeOfReview == "Action")
                {
                    Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                                  (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Del_tbl_PM_ReviewActions "
                                                                                       + HttpUtility.UrlDecode(reviewactions.ReviewActionID) + ","
                                                                                       + HttpUtility.UrlDecode(reviewactions.ReviewStatisticsID) + "  "
                                                                                       ,
                                                                                       true, CommonController.connectionString
                                                                                       ),
                                                    "")
                                                    );
                }
                else
                {
                    Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                                 (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Del_tbl_PM_ReviewObservations "
                                                                                      + HttpUtility.UrlDecode(reviewactions.ReviewActionID) + ","
                                                                                      + "null"
                                                                                      ,
                                                                                      true, CommonController.connectionString
                                                                                      ),
                                                   "")
                                                   );
                }

                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[SaveReviewObservation]
        /// <summary>
        /// Created Date    :   08 Sept 2019
        /// Purpose         :   Save review observation
        /// Created By      :   Chandrashekhar Salagar
        /// <param name="pm_wbs_cardparameter"></param>
        /// <returns>PM_wbs_card list</returns>
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveReviewObservation([FromBody] Observations observations)
        {
            try
            {
                string Message = "";
                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                              (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_ReviewObservations "
                                                                                   + HttpUtility.UrlDecode(observations.ReviewObservationID.ToString()) + ","
                                                                                   + HttpUtility.UrlDecode(observations.ProjectID.ToString()) + ","
                                                                                   + HttpUtility.UrlDecode(observations.ReviewStatisticsID.ToString()) + ",'"
                                                                                   + HttpUtility.UrlDecode(observations.Observation.Replace("'", "''")) + "','"
                                                                                   + HttpUtility.UrlDecode(observations.CreatedBy) + "' "
                                                                                   ,
                                                                                   true, CommonController.connectionString
                                                                                   ),
                                                "")
                                                );
                if ((observations.TrackToNextReview == "1") || (observations.Closed == "1"))
                {
                    int id = 0;
                    int.TryParse(Message, out id);
                    var msg = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                              (CommonFunctions.Data.GetDataScalar("usp_Whizible2_upd_tbl_PM_ReviewObservations_CloseStatus "
                                                                                   + HttpUtility.UrlDecode(id.ToString()) + ","
                                                                                   + HttpUtility.UrlDecode(observations.ProjectID.ToString()) + ",'"
                                                                                    + HttpUtility.UrlDecode(observations.Observation.Replace("'", "''")) + "','"
                                                                                   + HttpUtility.UrlDecode(observations.TrackToNextReview) + "','"
                                                                                   + HttpUtility.UrlDecode(observations.Closed) + "','"
                                                                                   + HttpUtility.UrlDecode(observations.CreatedBy) + "' "
                                                                                   ,
                                                                                   true, CommonController.connectionString
                                                                                   ),
                                                "")
                                                );
                }

                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion


        #region[UpdateActionToObservation]
        /// <summary>
        /// Created Date    :   08 Sept 2019
        /// Purpose         :   Save review observation
        /// Created By      :   Chandrashekhar Salagar
        /// <param name="pm_wbs_cardparameter"></param>
        /// <returns>PM_wbs_card list</returns>
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateActionToObservation([FromBody] Observations observations)
        {
            try
            {
                string Message = "";
                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                              (CommonFunctions.Data.GetDataScalar("usp_Whizible2_upd_tbl_PM_ReviewObservations_ReviewActionID "
                                                                                   + HttpUtility.UrlDecode(observations.ReviewActionID.ToString()) + ","
                                                                                   + HttpUtility.UrlDecode(observations.ReviewObservationID.ToString()) + " "
                                                                                   ,
                                                                                   true, CommonController.connectionString
                                                                                   ),
                                                "")
                                                );

                return Message;
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
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        //public List<FillProjectParameters> GetProjectDropDown([FromBody] defaultFilterParameters parameters)
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

        #region[ConductedReviewCheck]
        /// <summary>
        /// Created Date    :   22 Sept 2019
        /// Purpose         :   Check if Review is conducted or not
        /// Created By      :   Chandrashekhar Salagar
        /// <param name="pm_wbs_cardparameter"></param>
        /// <returns>PM_wbs_card list</returns>
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object ConductedReviewCheck([FromBody] PM_Project_Review project_Review)
        {
            try
            {
                List<ReviewActions> listReviewActions = new List<ReviewActions>();
                DataTable ReviewActionsTable = new DataTable();
                ReviewActionsTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_ReviewActions "
                                                                + HttpUtility.UrlDecode(project_Review.ReviewStatisticsID) + " "
                                                                , true,
                                                                CommonController.connectionString);

                foreach (DataRow drProjectList in ReviewActionsTable.Rows)
                {
                    ReviewActions reviewactions = new ReviewActions()
                    {
                        Action = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["Action"], "")),
                        CReviewCauseID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["CReviewCauseID"], "")),
                        CReviewType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["CReviewType"], "")),
                        PReviewCauseID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["PReviewCauseID"], "")),
                        IssueID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["IssueID"], "")),
                        PReviewType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["PReviewType"], "")),
                        ProjectID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["ProjectID"], "")),
                        ReviewActionID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["ReviewActionID"], "")),
                        ReviewStatisticsID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["ReviewStatisticsID"], "")),
                        TaskID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["TaskID"], "")),
                        CReviewCause = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["CReviewCause"], "")),
                        Reviewee = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["Reviewee"], "")),
                        TypeOfReview = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectList["ReviewType"], "")),
                    };
                    listReviewActions.Add(reviewactions);
                }
                return listReviewActions.Count;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        //#region[GetChecklistIssues]
        ///// <summary>
        ///// Created Date    :   28 Nov 2019
        ///// Purpose         :   Get Checklist Issues
        ///// Created By      :   Chandrashekhar Salagar
        ///// <param name="pm_wbs_cardparameter"></param>
        ///// <returns>PM_wbs_card list</returns>
        //[HttpPost]
        //[Authorize]
        //public List<IB_Issues> GetChecklistIssues([FromBody]PM_Project_Review project_Review)
        //{
        //    List<IB_Issues> listIB_Issues = new List<IB_Issues>();
        //    DataTable IB_IssuesTable = new DataTable();
        //    IB_IssuesTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_IB_Issue "
        //                                                    + HttpUtility.UrlDecode(project_Review.ReviewStatisticsID) + " "
        //                                                    , true,
        //                                                    CommonController.connectionString);

        //    foreach (DataRow drIB_IssuesTable in IB_IssuesTable.Rows)
        //    {
        //        IB_Issues IB_issues = new IB_Issues()
        //        {
        //            IssueID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIB_IssuesTable["IssueID"], "")),
        //            Summary = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIB_IssuesTable["Summary"], "")),
        //            Type = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIB_IssuesTable["Type"], "")),
        //            Status = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIB_IssuesTable["Status"], "")),

        //        };
        //        listIB_Issues.Add(IB_issues);
        //    }
        //    return listIB_Issues;
        //}
        //#endregion




        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        public object CheckPMProjectReviewDefaultFilter([FromBody] ProjectReviewFilterParameter ProjectReviewParameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_Whizible2_PM_ReviewStatistics_Filter_Query_GetDefaultFilter "
                    + HttpUtility.UrlDecode(Convert.ToString(ProjectReviewParameters.ProjectID)) + ","
                    + HttpUtility.UrlDecode(Convert.ToString(ProjectReviewParameters.TagID)) + ","
                    + ProjectReviewParameters.IsPlannedReview + ",'"
                    + HttpUtility.UrlDecode(ProjectReviewParameters.LoginType) + "' ,"
                    + HttpUtility.UrlDecode(Convert.ToString(ProjectReviewParameters.UserID));

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


        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object IsDuplicatePMProjectReviewBasicFilter([FromBody] ProjectReviewFilterParameter ProjectReviewParameters)
        {
            try
            {
                bool boolIsDuplicatePMProjectReviewName = false;
                boolIsDuplicatePMProjectReviewName = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull
                                              (CommonFunctions.Data.GetDataScalar("usp_Whizible2_ReviewStatistics_FilterNameDuplicate "
                                                                                  + HttpUtility.UrlDecode(Convert.ToString(ProjectReviewParameters.TagID)) + ","
                                                                                  + HttpUtility.UrlDecode(Convert.ToString(ProjectReviewParameters.ProjectID)) + ","
                                                                                  + HttpUtility.UrlDecode(Convert.ToString(ProjectReviewParameters.UserID)) + ","
                                                                                  + ProjectReviewParameters.IsPlannedReview + ",'"
                                                                                  + HttpUtility.UrlDecode(ProjectReviewParameters.FilterName) + "',"
                                                                                  + HttpUtility.UrlDecode(Convert.ToString(ProjectReviewParameters.FilterID))
                                                                                  , true, CommonController.connectionString
                                                                                  ),
                                                "0"));
                return boolIsDuplicatePMProjectReviewName;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Save the basic filter
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SavePMProjectReviewBasicFilter([FromBody] ProjectReviewFilterParameter ProjectReviewParameters)
        {
            try
            {
                string strSQL;

                if (ProjectReviewParameters.Flag == 1)
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_PM_ReviewStatistics_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(ProjectReviewParameters.TagID)) + ","
                                                                                                      + HttpUtility.UrlDecode(Convert.ToString(ProjectReviewParameters.ProjectID)) + ","
                                                                                                      + HttpUtility.UrlDecode(Convert.ToString(ProjectReviewParameters.UserID)) + ","
                                                                                                      + ProjectReviewParameters.IsPlannedReview + ",'"
                                                                                                      + HttpUtility.UrlDecode(ProjectReviewParameters.FilterName) + "','"
                                                                                                      + HttpUtility.UrlDecode(ProjectReviewParameters.LoginType) + "'," + "'"
                                                                                                      + HttpUtility.UrlDecode(ProjectReviewParameters.QueryText) + "'" + ",'"
                                                                                                      + HttpUtility.UrlDecode(ProjectReviewParameters.CreatedBy) + "',"
                                                                                                      + HttpUtility.UrlDecode(Convert.ToString(ProjectReviewParameters.Flag)) + " ,"
                                                                                                      + HttpUtility.UrlDecode(Convert.ToString(ProjectReviewParameters.FilterID)) + "";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_PM_ReviewStatistics_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(ProjectReviewParameters.TagID)) + ","
                                                                                                      + HttpUtility.UrlDecode(Convert.ToString(ProjectReviewParameters.ProjectID)) + ","
                                                                                                      + HttpUtility.UrlDecode(Convert.ToString(ProjectReviewParameters.UserID)) + ","
                                                                                                      + ProjectReviewParameters.IsPlannedReview + ",'"
                                                                                                      + HttpUtility.UrlDecode(ProjectReviewParameters.FilterName) + "','"
                                                                                                      + HttpUtility.UrlDecode(ProjectReviewParameters.LoginType) + "'," + "'"
                                                                                                      + HttpUtility.UrlDecode(ProjectReviewParameters.QueryText) + "'" + ",'"
                                                                                                      + HttpUtility.UrlDecode(ProjectReviewParameters.CreatedBy) + "'";
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
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetMyPMProjectReviewFiltersList([FromBody] ProjectReviewFilterParameter ProjectReviewParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_sel_tbl_Whizible2_PM_ReviewStatistics_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(ProjectReviewParameters.ProjectID)) + ","
                                                                                        + HttpUtility.UrlDecode(Convert.ToString(ProjectReviewParameters.TagID)) + ","
                                                                                        + ProjectReviewParameters.IsPlannedReview + ",'"
                                                                                        + HttpUtility.UrlDecode(ProjectReviewParameters.LoginType) + "','"
                                                                                        + HttpUtility.UrlDecode(Convert.ToString(ProjectReviewParameters.UserID)) + "'";

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
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeletePMProjectReviewFilter([FromBody] int FilterID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_del_tbl_Whizible2_PM_ReviewStatistics_Filter_Query " + FilterID;

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
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetPMProjectReviewWhereClauseOfFilter([FromBody] int FilterID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_tbl_Whizible2_PM_ReviewStatistics_Filter_Query_GetWhereClause " + FilterID;

                Object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SetPMProjectReviewDefaultFilter([FromBody] ProjectReviewFilterParameter ProjectReviewParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Upd_tbl_Whizible2_PM_ReviewStatistics_Filter_Query_SetDefaultFilter "
                                                + HttpUtility.UrlDecode(Convert.ToString(ProjectReviewParameters.ProjectID)) + ",'"
                                                + ProjectReviewParameters.LoginType + "' ,"
                                                + ProjectReviewParameters.UserID + ","
                                                + ProjectReviewParameters.TagID + ","
                                                + ProjectReviewParameters.IsPlannedReview + ","
                                                + ProjectReviewParameters.FilterID;
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
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object RemovePMProjectReviewDefaultFilter([FromBody] ProjectReviewFilterParameter ProjectReviewParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Upd_tbl_Whizible2_PM_ReviewStatistics_Filter_Query_RemoveDefaultFilter "
                                                            + HttpUtility.UrlDecode(Convert.ToString(ProjectReviewParameters.ProjectID)) + ",'"
                                                            + ProjectReviewParameters.LoginType + "' ,"
                                                            + ProjectReviewParameters.UserID + ","
                                                            + ProjectReviewParameters.TagID + ","
                                                            + ProjectReviewParameters.IsPlannedReview + ","
                                                            + ProjectReviewParameters.FilterID;
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
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object EditPMProjectReviewFilterData([FromBody] int FilterID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_sel_ByFilterID_tbl_Whizible2_PM_ReviewStatistics_Filter_Query " + FilterID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


            [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetWhereClauseFilter([FromBody]ProjectReviewFilterParameter ProjectReviewParameters)
        {
            try { 
            string strSQL = "";

            strSQL = "Exec usp_Whizible2_tbl_Whizible2_PM_ReviewStatistics_Filter_Query_GetWhereClause " + HttpUtility.UrlDecode(Convert.ToString(ProjectReviewParameters.FilterID));
            object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
            return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            }

            [HttpPost]
        public string GetResourceStartEndDate(PM_Project_Review pM_Project_Review)
        {
            var invalidResource = "";
            string Message = "";
            string ResourceStartDate = "";
            string ResourceEndDate = "";

            /*Validate start date end date*/
            Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                          (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Validate_ReviewDates '"
                                                                               + HttpUtility.UrlDecode(pM_Project_Review.ProjectId) + "','"
                                                                               + HttpUtility.UrlDecode(pM_Project_Review.ReviewStartDate) + "','"
                                                                               + HttpUtility.UrlDecode(pM_Project_Review.ReviewEndDate) + "' "
                                                                               ,
                                                                               true, CommonController.connectionString
                                                                               ),
                                            "")
                                            );

            if (string.IsNullOrEmpty(Message))
            {
                #region[Validate all the resources for start date and end date]
                List<ExpectedStartEndDates> listExpectedStartEndDates = new List<ExpectedStartEndDates>();
                DataTable expectedStartEndDate = new DataTable();
                expectedStartEndDate = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_ProjectEmployeeRole_Use_N_ExpectedDates "
                                                                + pM_Project_Review.ProjectId + " "
                                                                , true,
                                                                CommonController.connectionString);

                foreach (DataRow drexpectedStartEndDate in expectedStartEndDate.Rows)
                {
                    ExpectedStartEndDates expectedStartEndDates = new ExpectedStartEndDates()
                    {
                        UserName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drexpectedStartEndDate["UserName"], "")),
                        EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drexpectedStartEndDate["EmployeeID"], "0")),
                        ExpectedStartDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(drexpectedStartEndDate["ExpectedStartDate"], "")),
                        ExpectedEndDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(drexpectedStartEndDate["ExpectedEndDate"], "")),

                    };
                    listExpectedStartEndDates.Add(expectedStartEndDates);
                }

                string[] revieweeArray = pM_Project_Review.SelectedRevieweeIDs.Split(',');
                foreach (var item in revieweeArray)
                {
                    var EmployeeId = Convert.ToInt32(string.IsNullOrEmpty(item) ? "0" : item);
                    var GetResourceStartEndDate = listExpectedStartEndDates.Find(x => x.EmployeeID == EmployeeId);
                    if (GetResourceStartEndDate != null)
                    {
                        var ReviewStartDate = Convert.ToDateTime(pM_Project_Review.ReviewStartDate);
                        var ReviewEndDate = Convert.ToDateTime(pM_Project_Review.ReviewEndDate);
                        ResourceStartDate = GetResourceStartEndDate.ExpectedStartDate.ToString("dd-MM-yyyy");
                        ResourceEndDate = GetResourceStartEndDate.ExpectedEndDate.ToString("dd-MM-yyyy");
                        if ((ReviewStartDate < GetResourceStartEndDate.ExpectedStartDate) || (ReviewStartDate > GetResourceStartEndDate.ExpectedEndDate))
                        {
                            invalidResource = GetResourceStartEndDate.UserName.ToString();
                            Message = "";
                            return Message = "Start date should be  between Reviewee start date (" + ResourceStartDate + ") and end date (" + ResourceEndDate + ")";
                        }
                        else if ((ReviewEndDate < GetResourceStartEndDate.ExpectedStartDate) || (ReviewEndDate > GetResourceStartEndDate.ExpectedEndDate))
                        {
                            invalidResource = GetResourceStartEndDate.UserName.ToString();
                            return Message = "End date should be between Reviewee start date (" + ResourceStartDate + ") and end date (" + ResourceEndDate + ")";
                        }
                        else
                        {
                             Message = "";
                        }
                    }
                }
                #endregion
            }
            return Message;
        }

        #region [send review invitation]
        /// <summary>
        /// By Vishal Mahajan 07-12-2019 for send review invitation
        /// </summary>
        /// <param name="project_Review"></param>
        /// <returns></returns>
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SendReviewInvite([FromBody] PM_Project_Review project_Review)
        {
            try
            {
                int result = 0;
                result = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull
                                              (CommonFunctions.Data.GetDataScalar("usp_Whizible2_upd_tbl_PM_ReviewStatistics_SendReviewInvite "
                                              + HttpUtility.UrlDecode(project_Review.ReviewStatisticsID) + " "
                                              , true, CommonController.connectionString)
                                              , "0"));
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion


        /// <summary>
        /// By Vishal Mahajan 07-12-2019 for review invitation cancellation
        /// </summary>
        /// <param name="project_Review"></param>
        /// <returns></returns>
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ReviewInviteCancellation([FromBody] PM_Project_Review project_Review)
        {
            try
            {
                int result = 0;
                result = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull
                                              (CommonFunctions.Data.GetDataScalar("usp_Whizible2_upd_tbl_PM_ReviewStatistics_ReviewInviteCancelled "
                                              + HttpUtility.UrlDecode(project_Review.ReviewStatisticsID) + " "
                                              , true, CommonController.connectionString)
                                              , "0"));
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        // Added by Chetan M. on 4th Dec 2019
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetProjectChecklistItems([FromBody] ProjectReviewCheckListClass ChecklistParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_tbl_PM_GetProjectChecklistItems " + HttpUtility.UrlDecode(Convert.ToString(ChecklistParameter.ChecklistTypeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ChecklistParameter.ReviewStaticID)) + ",'R','" + HttpUtility.UrlDecode(ChecklistParameter.UserName) + "'";
                DataTable CheckListDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                CheckListDataTable = Dedup(CheckListDataTable, "CheckListItemName");
                //CheckListDataTable= Dedup(CheckListDataTable, "ProjectCheckListItemId");
                CheckListDataTable = Dedup(CheckListDataTable, "Description");
                return CheckListDataTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

            public DataTable Dedup(DataTable CheckListDataTable, string CheckListItemName)
        {
            for (int rowIndex = CheckListDataTable.Rows.Count - 1; rowIndex >= 1; rowIndex--)
            {
                var row = CheckListDataTable.Rows[rowIndex][CheckListItemName];
                var previousRow = CheckListDataTable.Rows[rowIndex - 1][CheckListItemName];

                if (row.ToString() == previousRow.ToString())
                {
                    CheckListDataTable.Rows[rowIndex][CheckListItemName] = "";
                }
            }

            return CheckListDataTable;
        }



        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteCheckListeResponses([FromBody]ProjectReviewCheckListClass ChecklistParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_del_tbl_PM_ChecklistResponses " + HttpUtility.UrlDecode(Convert.ToString(ChecklistParameter.ReviewStaticID)) + ",'R','" + HttpUtility.UrlDecode(ChecklistParameter.UserName) + "'";
                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return Result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetCorporateReviewIssueMapping([FromBody] int CReviewTypeID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_sel_tbl_PM_CorporateReviewIssueMapping " + HttpUtility.UrlDecode(Convert.ToString(CReviewTypeID));
                DataTable CorporateReviewIssueMapping = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return CorporateReviewIssueMapping;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetCorporateReviewDefaultStatus([FromBody] ProjectReviewCheckListClass ChecklistParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Sel_IB_GetDefault_Type_Status_SubType 'ST'," + HttpUtility.UrlDecode(Convert.ToString(ChecklistParameter.ProjectID)) + ",'" + HttpUtility.UrlDecode(ChecklistParameter.Type) + "'";
                DataTable DefaultStatus = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return DefaultStatus;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetCorporateReviewDefaultType([FromBody] ProjectReviewCheckListClass ChecklistParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Sel_IB_GetDefault_Type_Status_SubType 'S'," + HttpUtility.UrlDecode(Convert.ToString(ChecklistParameter.ProjectID)) + ",'" + HttpUtility.UrlDecode(ChecklistParameter.Type) + "'";
                DataTable DefaultType = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return DefaultType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveCheckListResponse([FromBody] ProjectReviewCheckListClass ChecklistParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Ins_Upd_tbl_PM_ChecklistResponses " + HttpUtility.UrlDecode(Convert.ToString(ChecklistParameter.ProjectID)) + ","
                                                                                 + HttpUtility.UrlDecode(Convert.ToString(ChecklistParameter.ReviewStaticID)) + ",'R',"
                                                                                 + HttpUtility.UrlDecode(Convert.ToString(ChecklistParameter.ProjectCheckListItemId)) + ","
                                                                                 + HttpUtility.UrlDecode(Convert.ToString(ChecklistParameter.ResponseId)) + ",'"
                                                                                 + HttpUtility.UrlDecode(ChecklistParameter.Remarks) + "',NULL,NULL,'"
                                                                                 + HttpUtility.UrlDecode(ChecklistParameter.UserName) + "',"
                                                                                 + HttpUtility.UrlDecode(Convert.ToString(ChecklistParameter.NegativeResponseId)) + ",'"
                                                                                 + HttpUtility.UrlDecode(ChecklistParameter.IssueType) + "','"
                                                                                 + HttpUtility.UrlDecode(ChecklistParameter.IssueSubType) + "','"
                                                                                 + HttpUtility.UrlDecode(ChecklistParameter.CorporateSubType) + "','"
                                                                                 + HttpUtility.UrlDecode(ChecklistParameter.Staus) + "','"
                                                                                 + HttpUtility.UrlDecode(ChecklistParameter.CorporateStaus) + "',NULL,NULL,0";

                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return Result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

            //end of addition by Chetan Muley
            [HttpPost]
        public static ReviewInviteMailParameter GetReviewForInvitation(string ReviewStatisticsID)
        {
            DataTable Project_Review = new DataTable();
            ReviewInviteMailParameter PR = new ReviewInviteMailParameter();
            Project_Review = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_ReviewStatistics_Edit " + HttpUtility.UrlDecode(ReviewStatisticsID.ToString()) + " ", true, CommonController.connectionString);

            try
            {
                PR.ReviewStatisticsID = ReviewStatisticsID;
                PR.ReviewTitle = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["ReviewTitle"], ""));
                PR.ReviewStartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["ReviewStartDate"], ""));
                PR.ReviewEndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["ReviewEndDate"], ""));
                PR.ReviewType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["ReviewType"], ""));
                PR.ReviewedBy = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["ReviewedBy"], ""));
                PR.Reviewee = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["Reviewee"], ""));
                PR.ReviewEffort = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["ReviewEffort"], ""));
                PR.ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["ProjectId"], "0"));
                PR.WorkProductType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["WorkProductType"], "")).Replace("--Select--", "");
                PR.TimeZone = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["TimeZone"], ""));
                PR.StartTime = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["StartTime"], ""));
                PR.EndTime = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["EndTime"], ""));
                PR.IsSendReviewInvite = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["IsSendReviewInvite"], "0"));
                PR.GMTZone = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Project_Review.Rows[0]["GMTZone"], ""));
            }
            catch (Exception ex)
            {

            }

            return PR;
        }

        #region [Get Current Date]
        /// <summary>
        /// By Vishal Mahajan 17-12-2019
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        [Authorize]
        public DateTime GetCurrentDate()
        {
            DateTime result;
            result = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull
                                          (CommonFunctions.Data.GetDataScalar("usp_Whizible2_sel_GetDate "
                                          , true, CommonController.connectionString)
                                          , ""));
            return result;
        }
        #endregion

        #region [Get CheckList Issues]
        /// <summary>
        /// by Vishal Mahajan 18-12-2019 
        /// </summary>
        /// <param name="ReviewStatisticsID"></param>
        /// <returns></returns>
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        //public List<CheckListIssues> GetCheckListIssues([FromBody]string ReviewStatisticsID)
        public object GetCheckListIssues([FromBody] string ReviewStatisticsID)
        {
            try
            {
                DataTable dtCheckListIssues = new DataTable();
                List<CheckListIssues> getCheckListIssues = new List<CheckListIssues>();
                dtCheckListIssues = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_PM_Reviewstatistics_CheckListIssues "
                                              + ReviewStatisticsID + " "
                                              , true, CommonController.connectionString);
                foreach (DataRow drissue in dtCheckListIssues.Rows)
                {
                    CheckListIssues CheckListIssue = new CheckListIssues()
                    {
                        ReviewStatisticsID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drissue["ReviewStatisticsID"], "")),
                        IssueID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drissue["IssueID"], "")),
                        Summary = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drissue["Summary"], "")),
                        Type = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drissue["Type"], "")),
                        Status = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drissue["Status"], "")),
                    };
                    getCheckListIssues.Add(CheckListIssue);
                }
                return getCheckListIssues;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion


        #region [attachement document by Vishal Mahajan 19-12-2019]
        //get Documents List
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        public object GetDocumentsList([FromBody] PM_Project_Review PM_Project_Review)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ProjectDocuments " + HttpUtility.UrlDecode(Convert.ToString(PM_Project_Review.UniqueID)) + "," + HttpUtility.UrlDecode(Convert.ToString(PM_Project_Review.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(PM_Project_Review.RoleID));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //get  Document Category List
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        public object GetDocumnetCategoryList([FromBody] PM_Project_Review PM_Project_Review)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_DocumentCategory_ForRole " + HttpUtility.UrlDecode(Convert.ToString(PM_Project_Review.RoleID)) + "," + HttpUtility.UrlDecode(Convert.ToString(PM_Project_Review.ProjectID));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //get Document sub Category List
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        public object GetDocumnetSubCategoryList([FromBody] PM_Document AttachmentDocuments)
        {
            try
            {

                string strSQL = "EXEC usp_Sel_tbl_PM_DocumentSubCategory " + HttpUtility.UrlDecode(Convert.ToString(AttachmentDocuments.Category)) + ", null ," + HttpUtility.UrlDecode(Convert.ToString(AttachmentDocuments.ProjectID));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

            public bool GetFileType()
        {
            bool fileUploadFlag = false;
            string MimeType = "";
            string strFileName = CommonFunctions.FileDirectory.GetUniqueFileName();
            if (HttpContext.Current.Request.Files.AllKeys.Any())
            {
                for (int filecount = 0; filecount < HttpContext.Current.Request.Files.Count; filecount++)
                {
                    //Stream xmlStream = System.Web.HttpContext.Current.Request.Files[filecount].InputStream;
                    //Stream txtStream = System.Web.HttpContext.Current.Request.Files[filecount].InputStream;
                    //string filePath = System.Web.HttpContext.Current.Request.Files[filecount].FileName;
                    //string filename = Path.GetFileName(filePath);
                    //string ext = Path.GetExtension(filename);
                    //ext = ext.Substring(1, ext.Length - 1);
                    //string contenttype = String.Empty;
                    //Stream checkStream = System.Web.HttpContext.Current.Request.Files[filecount].InputStream;
                    //BinaryReader chkBinary = new BinaryReader(checkStream);
                    //Byte[] chkbytes = chkBinary.ReadBytes(0x10);
                    //string strListofTypes = ConfigurationManager.AppSettings["FileContentType"];
                    //string magicNumber = BitConverter.ToString(chkbytes);
                    //string magicCheck = magicNumber.Substring(0, 11);
                    //magicNumber = magicNumber.Replace("-", " ");
                    //magicCheck = magicCheck.Replace("-", " ");
                    //XmlDocument xmlDoc = new XmlDocument();
                    //string xmlPath = CommonFunctions.FileDirectory.CleanPath(System.IO.Directory.GetParent(System.IO.Directory.GetParent(System.AppDomain.CurrentDomain.BaseDirectory).FullName).FullName);
                    //xmlDoc.Load(xmlPath + "MIMEType.xml");
                    //XmlNodeList nodes = xmlDoc.DocumentElement.SelectNodes("/MIMETYPE/MIME");
                    //string xMagicNumber = "";
                    //for (int i = 0; i < nodes.Count; i++)
                    //{
                    //    xMagicNumber = nodes[i].SelectSingleNode("MagicNumber").InnerText;
                    //    int strlength = xMagicNumber.Length;

                    //    if (xMagicNumber.IndexOf(magicCheck) != -1 || magicCheck.IndexOf(xMagicNumber) != -1)
                    //    {
                    //        MimeType = nodes[i].SelectSingleNode("ContentType").InnerText;
                    //        fileUploadFlag = true;
                    //        break;
                    //    }
                    //    else
                    //    {
                    //        if (ext == xMagicNumber)
                    //        {
                    //            MimeType = nodes[i].SelectSingleNode("ContentType").InnerText;
                    //            fileUploadFlag = false;
                    //        }

                    //    }

                    //}

                    string strListofTypes = ConfigurationManager.AppSettings["FileContentType"];
                    string fileName = HttpContext.Current.Request.Files[filecount].FileName;
                    string fileName1 = Utilities.Security.SecurityBuilder.CheckUserInput(fileName, 2, true, true, true);
                    string ValidateFileName = ConfigurationManager.AppSettings["ValidateFileName"];
                    string[] CharList;
                    CharList = ValidateFileName.Split(',');
                    for (int i = 0; i <= CharList.Length - 1; i++)
                    {
                        if (fileName.Contains(CharList[i].ToString()))
                        {
                            fileName1 = fileName1.Replace(CharList[i].ToString(), "");
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

                        // Added by imran on 02-01-2023
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
                      //  }
                        // End of comment by imran on 02-01-2022
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
                    //Commented & Added By Dipali V On 22nd Dec 2020 For TEXT FILe
                    //Commented And Added By Usha Pandit On 21.08.2020 For Text file upload
                    //if (strListofTypes.IndexOf(MimeType) > -1)
                    //{
                    //    fileUploadFlag = true;
                    //}
                    if (strListofTypes.IndexOf(MimeType) > -1)
                    {
                        fileUploadFlag = true;
                    }
                    else
                    {
                        fileUploadFlag = false;
                        break;
                    }
                    //End Of Added By Usha Pandit On 21.08.2020 For Text file upload
                    //Commented & Added By Dipali V On 22nd Dec 2020 For TEXT FILe
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


        //deleted Document 
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteDocument([FromBody] int DocumentId)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Del_tbl_PM_ProjectDocuments " + HttpUtility.UrlDecode(Convert.ToString(DocumentId));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //get phase Document sub Category List
        [Authorize]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object InsertDocumnetAttachment()
        {
            try
            {
                string msg = "";
                if (GetFileType())
                {
                    var AttachedFileData = HttpContext.Current.Request["AttachedFileData"];
                    var listAttachedDocuments = JsonConvert.DeserializeObject<List<PM_Document>>(AttachedFileData);
                    for (int i = 0; i < listAttachedDocuments.Count; i++)
                    {
                        var httpPostedFile = HttpContext.Current.Request.Files[i];
                        var SubCategory = "";
                        var Category = listAttachedDocuments[i].Category;
                        var ProjectID = listAttachedDocuments[i].PMParameters.ProjectID;
                        if (listAttachedDocuments[i].SubCategory != null)
                        {
                            SubCategory = listAttachedDocuments[i].SubCategory;
                        }
                        else
                        {
                        }

                        string DirectoryName;
                        if (SubCategory != "0")
                        {
                            DirectoryName = "LSS_WHIZ_DEV_-0113\\" + listAttachedDocuments[i].CategoryName + "\\" + listAttachedDocuments[i].SubCategoryName;
                        }
                        else
                        {
                            DirectoryName = "LSS_WHIZ_DEV_-0113\\" + listAttachedDocuments[i].CategoryName;
                        }
                        var description = listAttachedDocuments[i].Description;
                        var CreatedDate = DateTime.Now;
                        string strFileName = CommonFunctions.FileDirectory.GetUniqueFileName();
                        float FileSize = httpPostedFile.ContentLength;
                        FileSize = FileSize / 1024;
                        string FileExtention = Path.GetExtension(httpPostedFile.FileName);
                        FileExtention = FileExtention.Replace(".", "");
                        string OriginalFileName = Path.GetFileName(httpPostedFile.FileName);
                        int UserId = listAttachedDocuments[i].PMParameters.UserID;
                        string LoginType = listAttachedDocuments[i].PMParameters.LoginType;

                        int TagID = listAttachedDocuments[i].PMParameters.TagID;
                        int PhaseId = listAttachedDocuments[i].UniqueID;
                        string strCodeTemplate = "SETPL/" + listAttachedDocuments[i].CategoryName + "_/<Job Code>/<Serial Number>";
                        string categoryName = listAttachedDocuments[i].CategoryName;
                        string subcategoryName = listAttachedDocuments[i].SubCategoryName;
                        var DirectoryPath = HttpContext.Current.Server.MapPath("~/" + "");
                        DirectoryPath = DirectoryPath.Replace("WhizibleAPIService", "Documents\\LSS_WHIZ_DEV_-0113");
                        string dir = "";
                        if (SubCategory != "0")
                        {
                            dir = DirectoryPath + categoryName + "\\" + subcategoryName;
                        }
                        else
                        {
                            dir = DirectoryPath + categoryName;
                        }
                        if (!Directory.Exists(dir))
                        {
                            DirectoryInfo di = Directory.CreateDirectory(dir);
                        }


                        string ChangeRequestID = "NULL";


                        var fileName = httpPostedFile.FileName;
                        var filePath = HttpContext.Current.Server.MapPath("~/" + fileName);
                        var attachmentId = 0;
                        filePath = filePath.Replace("WhizibleAPIService", "Documents\\" + DirectoryName);

                        //ADDED BY Vishal M 02-01-2019
                        httpPostedFile.SaveAs(filePath);

                        //FileUpload.cUpload cUpload;

                        //cUpload = new FileUpload.cUpload(Convert.ToString(HttpContext.Current.Request.Files[i]), dir);
                        //cUpload.OverwriteIfExists = false;
                        //cUpload.UploadFile();

                        //ADDED BY Vishal M 02-01-2019
                        string strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ProjectDocuments " + HttpUtility.UrlDecode(Category.ToString()) + "," + HttpUtility.UrlDecode(ProjectID.ToString()) + ",'" + HttpUtility.UrlDecode(DirectoryName) + "','" + httpPostedFile.FileName.Substring(0, httpPostedFile.FileName.IndexOf('.')) + "','" + HttpUtility.UrlDecode(CreatedDate.ToString()) + "','" + HttpUtility.UrlDecode(CreatedDate.ToString()) + "','" + HttpUtility.UrlDecode(description.Replace("'", "''")) + "'," + HttpUtility.UrlDecode(FileSize.ToString()) + ",'" + HttpUtility.UrlDecode(FileExtention) + "','" + HttpUtility.UrlDecode(fileName.Substring(0, fileName.IndexOf('.'))) + "'," + HttpUtility.UrlDecode(UserId.ToString()) + ",'" + HttpUtility.UrlDecode(LoginType) + "'," + HttpUtility.UrlDecode(ChangeRequestID) + "," + HttpUtility.UrlDecode(SubCategory.ToString()) + "," + HttpUtility.UrlDecode(TagID.ToString()) + "," + HttpUtility.UrlDecode(PhaseId.ToString()) + ",'" + HttpUtility.UrlDecode(strCodeTemplate) + "'";
                        object result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                        msg = "File Uploaded Successfully";
                    }
                }
                else
                {
                    // msg = "Please upload valid files only";
                    // msg = "Only files with extensions PDF, XLS, XLSX, ZIP, RAR, XML, LOG, PNG, JPEG, JPG, DOC, DOCX, TXT, EXE are  allowed!!!";
                    msg = "Please upload valid file.";
                }
                return msg;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

            //Added by imran on 15-09-2022
            [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteDocumnet([FromBody] int DocumentId)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Del_tbl_PM_ProjectDocuments " + HttpUtility.UrlDecode(Convert.ToString(DocumentId));
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        #endregion



        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetProjectEstimatedEfforts([FromBody] string projectID)
        {
            try
            {
                float result = 0;
                result = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull
                                              (CommonFunctions.Data.GetDataScalar("usp_Whizible2_sel_TBL_PM_Project_EstimatedEfforts " + projectID
                                              , true, CommonController.connectionString)
                                              , "0"));
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize]
        public object GetDefaultTimeZone()
        {
            try
            {
                int result = 0;
                result = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull
                                              (CommonFunctions.Data.GetDataScalar("usp_Whizible2_sel_tbl_PM_CompanyInformation_DefaultTimeZone "
                                              , true, CommonController.connectionString)
                                              , "0"));
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object IsAgileMethodFollowed([FromBody] string projectID)
        {
            try
            {
                int result = 0;
                result = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull
                                              (CommonFunctions.Data.GetDataScalar("usp_Whizible2_sel_tbl_PRS_ProjectTypes_IsAgileMethodFollowed " + projectID
                                              , true, CommonController.connectionString)
                                              , "0"));
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object IsReviewObservationIDExist([FromBody] string ReviewObservationID)
        {
            try
            {
                int result = 0;
                if (string.IsNullOrEmpty(ReviewObservationID))
                    ReviewObservationID = "0";
                result = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull
                                              (CommonFunctions.Data.GetDataScalar("usp_Whizible2_sel_tbl_PM_ReviewActions_IsReviewObservationID " + ReviewObservationID
                                              , true, CommonController.connectionString)
                                              , "0"));
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Reshma on 30th Dec 2019 For IssueID-21123
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetTotalReviewEfforts([FromBody] PM_Project_Review project_Review)
        {
            try
            {
                float result = 0;
                result = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull
                                              (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Sel_SumOf_ReviewEfforts_PlanReview " + HttpUtility.UrlDecode(project_Review.ProjectId.ToString()) + "," + HttpUtility.UrlDecode(project_Review.ReviewStatisticsID.ToString())
                                              , true, CommonController.connectionString)
                                              , "0"));
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End Added By Reshma on 30th Dec 2019 For IssueID-21123

        //Added By Reshma on 31st Dec 2019 For IssueID-21111
        //Get Default Type Mapped With Issue Type.
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetDefaultTypeConvertToAction([FromBody] ReviewActions reviewactions)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_IsDefaultType_ConvertToAction " + HttpUtility.UrlDecode(reviewactions.ProjectID);

                ReviewActions DefaultType = new ReviewActions();
                IDataReader DefaultTypeFilter;
                DefaultTypeFilter = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (DefaultTypeFilter.Read())
                {
                    DefaultType.Type = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(DefaultTypeFilter["Type"], ""));
                    DefaultType.CorporateType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(DefaultTypeFilter["CorporateType"], ""));
                }
                return DefaultType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
            //End Added By Reshma on 31st Dec 2019 For IssueID-21111
        }
}