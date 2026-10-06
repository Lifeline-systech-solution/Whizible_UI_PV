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
using System.Web.Script.Serialization;
using System.Xml;
using WhizibleAPI.Models;
using WhizibleAPI.Models.PM;

namespace WhizibleAPI.Controllers
{
    public class PM_CheckListController : ApiController
    {
        PM_CheckList checklist = new PM_CheckList();

        [HttpPost]
        ////Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetWorkOrderCheckListDetails([FromBody]int ProjectId)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {


                strSQL = "";
                strSQL = "usp_Whizible2_Sel_e_tbl_PM_WorkOrderCheckList " + HttpUtility.UrlDecode(ProjectId.ToString());
                checklist.WorkOrderCheckList = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, checklist);
            }
             catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object Save_RevisionNo([FromBody]PM_CheckList checkList)
        {
            string strSQL = "";
            int ID = 0;
            try
            {
                strSQL = "Exec usp_Whizible2_Upd_tbl_PM_WorkOrderChecklist_GetLatest " + HttpUtility.UrlDecode(Convert.ToString(checkList.ProjectCheckListId)) + "";

                ID = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return ID;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object Check_Revision([FromBody]PM_CheckList checkList)
        {
            string strSQL = "";
            string ID = "0";
            try
            {
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_WorkOrderChecklist_CheckLatest " + HttpUtility.UrlDecode(Convert.ToString(checkList.ProjectCheckListId)) + "";

                ID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
                if(ID == "" || ID == "0")
                {
                    ID = "0";
                }
                else
                {
                    ID = "1";
                }
                return ID;
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
        public HttpResponseMessage GetWorkOrderCheckList([FromBody]int ProjectId)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {


                strSQL = "";
                strSQL = "usp_Whizible2_Sel_V_tbl_PM_WorkOrderCheckList " + HttpUtility.UrlDecode(ProjectId.ToString());
                checklist.WorkOrderCheckList = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, checklist);
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
        public HttpResponseMessage CopyCheckList([FromBody]PM_CheckList checkList)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {


                strSQL = "";
                //@intOldProjectCheckListID,@strCheckListShortName

                strSQL = "usp_Whizible2_Copy_CheckList " + HttpUtility.UrlDecode(checkList.OldProjectCheckListID.ToString())+",'"+ HttpUtility.UrlDecode(Convert.ToString(checkList.CheckListShortName.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")))+"'";
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

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeletedCheckList([FromBody]PM_CheckList checkList)
        {
            string strSQL;
            object Result;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
                //Comment And Added By Riddhesh Patil on 21st March 2023
                //for (int i = 0; i < checkList.UniqueIDs.Length; i++)
                //{
                //    int UniqueID = checkList.UniqueIDs[i];
                //End of Comment And Added By Riddhesh Patil on 21st March 2023
                string[] uniqueIDs;
                uniqueIDs = checkList.UniqueIDs.Split(',');
                for (int i = 0; i < uniqueIDs.Length; i++)
                {
                    //int UniqueID = checkList.UniqueIDs[i];
                    int UniqueID = Convert.ToInt32(uniqueIDs[i]);

                    strSQL = "";
                    //@intOldProjectCheckListID,@strCheckListShortName

                    strSQL = "usp_Whizible2_Del_tbl_PM_WorkOrderCheckList " + HttpUtility.UrlDecode(UniqueID.ToString()) + "," + HttpUtility.UrlDecode(checkList.ProjectId.ToString()) + ",''";
                     Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                    string strres= "is Published, and cannot be deleted.";
                    if (Result.ToString().IndexOf(strres)>-1)
                    {
                        checklist.DeletedResult.Add(Result.ToString());
                    }
                }

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, checklist);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public HttpResponseMessage GetWorkOrderCheckListData([FromBody]int ProjectId)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {


                strSQL = "";
                strSQL = "usp_Whizible2_Sel_V_tbl_PM_WorkOrderCheckList_GetWorkOrderCheckList " + HttpUtility.UrlDecode(ProjectId.ToString());
                checklist.WorkOrderCheckList = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, checklist);
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage InsertWorkOrderCheckList([FromBody]PM_CheckList checkList)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
                //Comment And Added By Riddhesh Patil on 21st March 2023
                string[] questionnaireIDs;
                string[] checkListShortName;
                questionnaireIDs = checkList.QuestionnaireIDs.Split(',');
                checkListShortName= checkList.CheckListShortNames.Split(',');
                for (int i = 0; i < questionnaireIDs.Length; i++)
                {
                    //int QuestionnaireID = questionnaireIDs[i];
                    int QuestionnaireID = Convert.ToInt32(questionnaireIDs[i]);
                    //string CheckListShortName = checkList.CheckListShortNames[i];
                    string CheckListShortName = checkListShortName[i];
                    //End of Comment And Added By Riddhesh Patil on 21st March 2023
                    strSQL = "";
                    //EXEC usp_Ins_tbl_PM_WorkOrderCheckList 2208, 'Project Closure Checklist',6

                    strSQL = "usp_Whizible2_Ins_tbl_PM_WorkOrderCheckList " + HttpUtility.UrlDecode(checkList.ProjectId.ToString()) + ",'" + HttpUtility.UrlDecode(CheckListShortName.ToString()) + "'," + HttpUtility.UrlDecode(QuestionnaireID.ToString());
                    object result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                }

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, checklist);
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage PublishCheckList([FromBody]PM_CheckList checkList)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
               
                    strSQL = "";
                //EXEC usp_Ins_tbl_PM_WorkOrderCheckList 2208, 'Project Closure Checklist',6
                //@RevisionNo,@ProjectID,@ProjectCheckListId,@Revisiondate,@RevisedBy,@ApprovedBy,@Reason

                    strSQL = "usp_Whizible2_Ins_tbl_PM_Project_CheckList_Revision " + HttpUtility.UrlDecode(checkList.RevisionNo.ToString()) + "," + HttpUtility.UrlDecode(checkList.ProjectId.ToString()) + "," + HttpUtility.UrlDecode(checkList.ProjectCheckListId.ToString())+",'"+ HttpUtility.UrlDecode(checkList.Revisiondate.ToString())+"',"+ HttpUtility.UrlDecode(checkList.RevisedBy.ToString())+","+ HttpUtility.UrlDecode(checkList.ApprovedBy.ToString())+",'"+ HttpUtility.UrlDecode(Convert.ToString(checkList.Reason.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")))+"'";
                    object result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                strSQL = "";
                strSQL = "usp_Whizible2_Upd_PublishProjectDeliverableCheckList " + HttpUtility.UrlDecode(result.ToString()) ;
                object result1 = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, result1);
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
        public HttpResponseMessage WorkOrderCheckListGetSpecificData([FromBody]PM_CheckList checkList)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {

                strSQL = "";
                //EXEC usp_Ins_tbl_PM_WorkOrderCheckList 2208, 'Project Closure Checklist',6
                //@RevisionNo,@ProjectID,@ProjectCheckListId,@Revisiondate,@RevisedBy,@ApprovedBy,@Reason

                strSQL = "usp_Whizible2_e_tbl_PM_WorkOrderCheckList_GetSpecificData " + HttpUtility.UrlDecode(checkList.ProjectCheckListId.ToString()) ;
                checklist.WorkOrderCheckList = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                strSQL = "";
                //EXEC usp_Ins_tbl_PM_WorkOrderCheckList 2208, 'Project Closure Checklist',6
                //@RevisionNo,@ProjectID,@ProjectCheckListId,@Revisiondate,@RevisedBy,@ApprovedBy,@Reason

                strSQL = "usp_Whizible2_Sel_v_tbl_PM_WorkOrderCheckListItem_GetSpecificData " + HttpUtility.UrlDecode(checkList.ProjectCheckListId.ToString());
                checklist.WorkOrderCheckListItem = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                //added by omkar 09/01/2020
                strSQL = "";
                strSQL = "usp_Whizible2_Sel_v_tbl_Q_ProjectCategory_GetSpecificData " + HttpUtility.UrlDecode(checkList.ProjectCheckListId.ToString());
                checklist.WorkOrderCheckListSection = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                //end of added by omkar 09/01/2020

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, checklist);
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
        public HttpResponseMessage WorkOrderCheckListItemGetSpecificData([FromBody]PM_CheckList checkList)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {

                strSQL = "";
                //EXEC usp_Ins_tbl_PM_WorkOrderCheckList 2208, 'Project Closure Checklist',6
                //@RevisionNo,@ProjectID,@ProjectCheckListId,@Revisiondate,@RevisedBy,@ApprovedBy,@Reason

                strSQL = "usp_Whizible2_Sel_v_tbl_PM_WorkOrderCheckListItem_GetSpecificData_Use_ProjectCheckListItemID " + HttpUtility.UrlDecode(checkList.ProjectCheckListItemID.ToString());
                checklist.WorkOrderCheckListItem = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, checklist);
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
        public HttpResponseMessage CheckLIstProjectCategory([FromBody]PM_CheckList checkList)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {

                strSQL = "";
                //EXEC usp_Ins_tbl_PM_WorkOrderCheckList 2208, 'Project Closure Checklist',6
                //@RevisionNo,@ProjectID,@ProjectCheckListId,@Revisiondate,@RevisedBy,@ApprovedBy,@Reason

                strSQL = "usp_Whizible2_sel_tbl_Q_ProjectCategory " + HttpUtility.UrlDecode(checkList.ProjectCheckListId.ToString());
                checklist.WorkOrderCheckListItem = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, checklist);
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
        public HttpResponseMessage CheckListAnswerSet([FromBody]PM_CheckList checkList)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {

                strSQL = "";
                //EXEC usp_Ins_tbl_PM_WorkOrderCheckList 2208, 'Project Closure Checklist',6
                //@RevisionNo,@ProjectID,@ProjectCheckListId,@Revisiondate,@RevisedBy,@ApprovedBy,@Reason

                strSQL = "usp_Whizible2_Sel_tbl_Q_AnswerSet " ;
                checklist.AnswerSet = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, checklist);
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
        public HttpResponseMessage CheckList_Q_Answer([FromBody]PM_CheckList checkList)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {

                strSQL = "";
                //EXEC usp_Ins_tbl_PM_WorkOrderCheckList 2208, 'Project Closure Checklist',6
                //@RevisionNo,@ProjectID,@ProjectCheckListId,@Revisiondate,@RevisedBy,@ApprovedBy,@Reason

                strSQL = "usp_Whizible2_Sel_tbl_Q_Answer_GetSpecificData "+ HttpUtility.UrlDecode(checkList.AnswerSetID.ToString()); ;
                checklist.tbl_Q_Answer = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, checklist);
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
        public HttpResponseMessage Update_WorkOrderCheckList([FromBody]PM_CheckList checkList)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {

                strSQL = "";
                //EXEC usp_Ins_tbl_PM_WorkOrderCheckList 2208, 'Project Closure Checklist',6
                //@ProjectID,@CheckListShortName,@IsActive,@ProjectCheckListID

                //Commented And Added By 11.06.2020 For escaping single quote from data
                //strSQL = "usp_Whizible2_Upt_tbl_PM_WorkOrderCheckList " + HttpUtility.UrlDecode(checkList.ProjectId.ToString())+",'"+ HttpUtility.UrlDecode(checkList.CheckListShortName.ToString()) +"',"+ HttpUtility.UrlDecode(checkList.IsActive.ToString())+","+ HttpUtility.UrlDecode(checkList.ProjectCheckListId.ToString());
                //object result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                strSQL = "usp_Whizible2_Upt_tbl_PM_WorkOrderCheckList " + HttpUtility.UrlDecode(checkList.ProjectId.ToString()) + ",'" + HttpUtility.UrlDecode(checkList.CheckListShortName.ToString()).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'," + HttpUtility.UrlDecode(checkList.IsActive.ToString()) + "," + HttpUtility.UrlDecode(checkList.ProjectCheckListId.ToString());
                object result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                //End Of Added By 11.06.2020 For escaping single quote from data

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, result);
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
        public HttpResponseMessage InsertWorkOrderCheckListItem([FromBody]PM_CheckList checkList)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
                strSQL = "usp_Whizible2_Upt_tbl_PM_WorkOrderCheckListItem " + HttpUtility.UrlDecode(checkList.ProjectId.ToString()) + ","+ HttpUtility.UrlDecode(checkList.ProjectCheckListId.ToString()) + ",'" + HttpUtility.UrlDecode(Convert.ToString(checkList.CheckListItemName.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n"))) + "'," + HttpUtility.UrlDecode(checkList.CatagoryId.ToString()) + "," + HttpUtility.UrlDecode(checkList.AnswerSetId.ToString())+","+ HttpUtility.UrlDecode(checkList.Compulsory.ToString())+","+ HttpUtility.UrlDecode(checkList.IsActive.ToString())+","+ HttpUtility.UrlDecode(checkList.ProjectCheckListItemID.ToString());
                object result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, result);
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
        //Added By Dipali V On 8th April 2023 For Crash ISsue
        //public HttpResponseMessage DeletedCheckListItem([FromBody]PM_CheckList checkList)
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeletedCheckListItem([FromBody] PM_CheckList_New checkList)
        {
            string strSQL;
            object Result;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
                string[] uniqueIDs;
                uniqueIDs = checkList.ProjectCheckListItemIDs.Split(',');
                for (int i = 0; i < uniqueIDs.Length; i++)
                {
                    //int UniqueID = checkList.ProjectCheckListItemIDs[i];

                    strSQL = "";
                    //@intOldProjectCheckListID,@strCheckListShortName
                    //Added By Dipali V On 8th April 2023 For Crash ISsue
                    //strSQL = "usp_Whizible2_Del_tbl_PM_WorkOrderCheckListItem " + HttpUtility.UrlDecode(UniqueID.ToString()) ;
                    strSQL = "usp_Whizible2_Del_tbl_PM_WorkOrderCheckListItem " + HttpUtility.UrlDecode(uniqueIDs[i]) ;
                     Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                    //object strres = "Checklist " + UniqueID + " is Published, and cannot be deleted.";
                    //if (strres == Result)
                    //{
                    //    checklist.unDeleted[i] = UniqueID;


                    //}
                }

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, checklist);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


        //add by omkar 09/01/2020

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public HttpResponseMessage InsertWorkOrderCheckListSection([FromBody]PM_CheckList checkList)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
                //Commented And Added By Usha Pandit On 29.04.2020 For Crash on Checklist Sections
                //strSQL = "usp_Whizible2_Upt_tbl_Q_ProjectCategory " + HttpUtility.UrlDecode(checkList.ProjectId.ToString()) + "," + HttpUtility.UrlDecode(checkList.ProjectCheckListId.ToString()) + ",'" + HttpUtility.UrlDecode(Convert.ToString(checkList.Description.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n"))) + "'," + HttpUtility.UrlDecode(checkList.CategoryCode.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "," + HttpUtility.UrlDecode(checkList.OrderNo.ToString()) + "," + HttpUtility.UrlDecode(checkList.ProjectCategoryID.ToString());
                strSQL = "usp_Whizible2_Upt_tbl_Q_ProjectCategory " + HttpUtility.UrlDecode(checkList.ProjectId.ToString()) + "," + HttpUtility.UrlDecode(checkList.ProjectCheckListId.ToString()) + ",'" + HttpUtility.UrlDecode(Convert.ToString(checkList.Description.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n"))) + "','" + HttpUtility.UrlDecode(checkList.CategoryCode.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "'," + HttpUtility.UrlDecode(checkList.OrderNo.ToString()) + "," + HttpUtility.UrlDecode(checkList.ProjectCategoryID.ToString());
                //End Of Added By Usha Pandit On 29.04.2020 For Crash on Checklist Sections
                object result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, result);
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
        //Added By Dipali V On 8th April 2023 For Crash ISsue
        // public HttpResponseMessage DeletedCheckListSection([FromBody]PM_CheckList checkList)
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeletedCheckListSection([FromBody] PM_CheckList_New checkList)
        {
            string strSQL;
            object Result;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
                //Added By Dipali V On 8th April 2023 For Crash ISsue
                string[] uniqueIDs;
                uniqueIDs = checkList.ProjectCategoryIDs.Split(',');
                for (int i = 0; i < uniqueIDs.Length; i++)
                {
                    //int UniqueID = checkList.ProjectCategoryIDs[i];

                    strSQL = "";
                    //@intOldProjectCheckListID,@strCheckListShortName

                    //strSQL = "usp_Whizible2_Del_tbl_Q_ProjectCategory " + HttpUtility.UrlDecode(UniqueID.ToString());
                    strSQL = "usp_Whizible2_Del_tbl_Q_ProjectCategory " + HttpUtility.UrlDecode(uniqueIDs[i]);
                    //End of Added By Dipali V On 8th April 2023 For Crash ISsue
                    Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                    //object strres = "Checklist " + UniqueID + " is Published, and cannot be deleted.";
                    //if (strres == Result)
                    //{
                    //    checklist.unDeleted[i] = UniqueID;


                    //}
                }

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, checklist);
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
        public HttpResponseMessage WorkOrderCheckListSectionGetSpecificData([FromBody]PM_CheckList checkList)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {

                strSQL = "";
                //EXEC usp_Ins_tbl_PM_WorkOrderCheckList 2208, 'Project Closure Checklist',6
                //@RevisionNo,@ProjectID,@ProjectCheckListId,@Revisiondate,@RevisedBy,@ApprovedBy,@Reason

                strSQL = "usp_Whizible2_Sel_v_tbl_Q_ProjectCategory_GetSpecificData_Use_ProjectCategoryID " + HttpUtility.UrlDecode(checkList.ProjectCategoryID.ToString());
                checklist.WorkOrderCheckListSection = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, checklist);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //end of add by omkar 09/01/2020
    }
}