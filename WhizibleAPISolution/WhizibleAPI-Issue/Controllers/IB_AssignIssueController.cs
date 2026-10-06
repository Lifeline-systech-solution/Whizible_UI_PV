using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Net;
using System.Net.Http;
using System.Configuration;
using System.Text.RegularExpressions;
using Newtonsoft.Json;
using System.IO;
using System.Xml;

namespace WhizibleAPI.Controllers
{


    public class IB_AssignIssueController : ApiController
    {
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetDetails([FromBody] Details HDParameters)
        {
            try
            {

                var strSQL = "";
              
                strSQL = "EXEC usp_Whizible_CRM_Get_RequestDetails_AssignIssue " + HttpUtility.UrlDecode(Convert.ToString(HDParameters.CRMRequestID)) + "";
                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


               
                return dt;
                    //+ "||" + resultIssueCount;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetIssueCount([FromBody] Details HDParameters)
        {
            try
            {
                var resultIssueCount = "";
                var strSQLIssue_Count = "";
                strSQLIssue_Count = "EXEC usp_CRM_Get_IssueCount " + HDParameters.CRMRequestID + "";
                resultIssueCount = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQLIssue_Count, true, CommonController.connectionString));
                return resultIssueCount;




            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        DetailsParameters Details = new DetailsParameters();


        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetData([FromBody] DetailsParameters RequestParameters)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
                if (RequestParameters.ProjectID != "0")
                {
                    if (RequestParameters.IssueType == "0") {
                        RequestParameters.IssueType = "";
                    }
                    strSQL = "";
                    strSQL = "Exec usp_CRM_Project_IssueTypes_ForCombo " + RequestParameters.ProjectID;
                    Details.ProjectIssueType = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                    strSQL = "";
                    strSQL = "usp_CRM_Get_ProjectEmployees " + HttpUtility.UrlDecode(RequestParameters.ProjectID.ToString()) + ",0,0";
                    Details.drProjectEmployee = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                    strSQL = "";
                    strSQL = "usp_CRM_Get_Default_IssueType " + HttpUtility.UrlDecode(RequestParameters.ProjectID.ToString()) + "";
                    string Defaultissuetype = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                    if (Defaultissuetype == "")
                    {
                        Defaultissuetype = RequestParameters.IssueType;
                    }
                    
                    strSQL = "";
                    strSQL = "usp_Sel_tbl_IB_Project_Type_Status_OpenStatus " + HttpUtility.UrlDecode(RequestParameters.ProjectID.ToString()) + ",'"+ Defaultissuetype + "'," + RequestParameters.PostID + "";
                    Details.ProjectStatus = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                    strSQL = "";
                    strSQL = "usp_Sel_tbl_IB_Project_Priorities " + HttpUtility.UrlDecode(RequestParameters.ProjectID.ToString()) + ",0";
                    Details.drProjectPriority = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);



                    strSQL = "";
                    strSQL = "usp_Sel_tbl_IB_Project_Severity " + HttpUtility.UrlDecode(RequestParameters.ProjectID.ToString()) + ",0";
                    Details.drProjectSeverity = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                    strSQL = "";
                    strSQL = "usp_tbl_PM_DepartMentMaster_DepartMentID_ExposeToProductExecution " + HttpUtility.UrlDecode(RequestParameters.DepartmentID.ToString()) + "";
                    Details.IsShowProduct = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));


                    strSQL = "";
                    strSQL = "usp_Sel_tbl_CRM_Query_Master_ProductAssociation " + HttpUtility.UrlDecode(RequestParameters.CRMRequestID.ToString()) + "," + HttpUtility.UrlDecode(RequestParameters.ProjectID.ToString()) + "";
                    Details.ProjectProductCustoer = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);



                    strSQL = "";
                    IDataReader drCustomerID;
                    var RequestCustomerID = "";
                    if (RequestParameters.strRequestorSLoginType == "C") {
                        drCustomerID = CommonFunctions.Data.GetDataReader("usp_NG2_Sel_CustomerID_tbl_PM_Customer '" + RequestParameters.strRequestorSUserName + "'", true, CommonController.connectionString);

                     if (drCustomerID.Read()) {
                            RequestCustomerID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.General.CheckIsNothing(drCustomerID["customer"], "0"), "0"));


                        strSQL = "EXEC usp_Sel_tbl_PRD_ProductVersion_CustomerWise " + RequestCustomerID + " , 'C' ,0,1,Null , NULL , " + RequestParameters.ProjectID;
                        }

                    }
                    else {

                        strSQL = "if (1=2) SELECT '',''";
                       

                    }

                    Details.Product = Details.ProjectProductCustoer = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);  
                }

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, Details);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }





        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetProductCombo([FromBody] DetailsParameters RequestParameters)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
                if (RequestParameters.ProjectID != "0")
                {
                    IDataReader drMultipleRequests;
                    drMultipleRequests = CommonFunctions.Data.GetDataReader("usp_CRM_Get_RequestDetails " + RequestParameters.CRMRequestID + "", true, CommonController.connectionString);
                    String DepartmentID = "";
                    String strRequestorSLoginType = "";
                    String strRequestorSUserName = "";
                    if (drMultipleRequests.Read())
                    {
                        DepartmentID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drMultipleRequests["FunctionID"], "0"));
                        strRequestorSLoginType = drMultipleRequests["LoginType"].ToString();
                        strRequestorSUserName = drMultipleRequests["CustomerID"].ToString();
                    }
                       

                    strSQL = "";
                    IDataReader drCustomerID;
                    var RequestCustomerID = "";
                    if (RequestParameters.strRequestorSLoginType == "C")
                    {
                        strSQL = "EXEC usp_Sel_tbl_PRD_ProductVersion_CustomerWise " + RequestParameters.CustomerID + " , 'C' ,0,1,Null , " + RequestParameters.CustomerID + " , " + RequestParameters.ProjectID;
                    }
                    else
                    {
                        if (RequestParameters.CustomerID == "")
                        {
                            strSQL = "if (1=2) SELECT '',''";
                        }
                        else
                        {
                            strSQL = "EXEC usp_Sel_tbl_PRD_ProductVersion_CustomerWise " + RequestParameters.CustomerID + " , 'C' ,NULL,1,Null , " + RequestParameters.CustomerID + " , " + RequestParameters.ProjectID;

                        }
                    }

                    Details.Product = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                }


                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, Details);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }




        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetCRMDetails([FromBody] Details HDParameters)
        {
            try
            {
                var strSQL = "";
                strSQL = "EXEC usp_CRM_Get_RequestDetails " + HttpUtility.UrlDecode(Convert.ToString(HDParameters.CRMRequestID)) + "";
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
        [Authorize, App_Start.ValidateHeaders]
        public object SaveAssignIssue([FromBody] Details HDParameters)
        {
            try
            {
                var strSQL = "";
                var resultIssueCount = "";

                if (HDParameters.CboIssuePriority == "NULL") {
                    HDParameters.CboIssuePriority = "";
                }


                if (HDParameters.CboIssueSeverity == "NULL")
                {
                    HDParameters.CboIssueSeverity = "";
                }

                if (HDParameters.CboIssueProduct == "NULL")
                {
                    HDParameters.CboIssueProduct = "";
                }

                if (HDParameters.CboIssueComponent == "NULL")
                {
                    HDParameters.CboIssueComponent = "";
                }
                if (HDParameters.CboCustomer == "NULL")
                {
                    HDParameters.CboCustomer = "";
                }

                strSQL = "EXEC usp_CRM_Assign_Issue " + HttpUtility.UrlDecode(Convert.ToString(HDParameters.CboIssueProject)) + "," + HttpUtility.UrlDecode(Convert.ToString(HDParameters.objcboAssignTo)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(HDParameters.CboIssueType)) + "','" + HttpUtility.UrlDecode(Convert.ToString(HDParameters.CboIssueStatus)) + "','" + HttpUtility.UrlDecode(Convert.ToString(HDParameters.strUserName)) + "','E'," + HttpUtility.UrlDecode(Convert.ToString(HDParameters.CRMRequestID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(HDParameters.summary)) + "','" + HttpUtility.UrlDecode(Convert.ToString(HDParameters.desc)) + "','" + HttpUtility.UrlDecode(Convert.ToString(HDParameters.CboIssuePriority)) + "','" + HttpUtility.UrlDecode(Convert.ToString(HDParameters.CboIssueSeverity)) + "'," + HttpUtility.UrlDecode(Convert.ToString(HDParameters.CboCustomer)) + "," + HttpUtility.UrlDecode(Convert.ToString(HDParameters.CboIssueProduct)) + "," + HttpUtility.UrlDecode(Convert.ToString(HDParameters.CboIssueComponent)) + "";
                //        strSQL = "exec usp_CRM_Assign_Issue  " & CboIssueProject & "," & objcboAssignTo & ",'" & CboIssueType & "','" & CboIssueStatus & "','" & HttpContext.Current.Session("strUserName").ToString & "','E'," & RequestID & ",'" & summary & "','" & desc & "'," & IIf(CboIssuePriority <> "", "'" & CboIssuePriority & "'", "Null") & "," & IIf(CboIssueSeverity <> "", "'" & CboIssueSeverity & "'", "Null") & "," & CboCustomer & "," & CboIssueProduct & "," & CboIssueComponent & ""
                //'CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
                resultIssueCount = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return resultIssueCount;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }




        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetProjectDetails([FromBody] Details HDParameters)
        {
            try
            {
                var strSQL = "";
                strSQL = "EXEC usp_CRM_ProjectList_ForFunction_ForAssignIssueHelpDesk " + HttpUtility.UrlDecode(Convert.ToString(HDParameters.DepartmentID)) + "," + HttpUtility.UrlDecode(Convert.ToString(HDParameters.CRMRequestID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(HDParameters.strRequestorSLoginType)) + "','" + HttpUtility.UrlDecode(Convert.ToString(HDParameters.strRequestorSUserName)) + "'";
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
        [Authorize, App_Start.ValidateHeaders]
        public object GetAssignIssueDetails([FromBody] Details HDParameters)
        {
            try
            {
                var strSQL = "";
                strSQL = "EXEC usp_CRM_Get_Request_Issue_Details " + HttpUtility.UrlDecode(Convert.ToString(HDParameters.CRMRequestID)) + ",'Status','desc'";
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
        [Authorize, App_Start.ValidateHeaders]
        public object GetModuleOrComponent([FromBody] Details HDParameters)
        {
            try
            {
                var strSQL = "";
                strSQL = "EXEC usp_sel_Tbl_PRD_ProductVersion_Component_ComponentID " + HttpUtility.UrlDecode(Convert.ToString(HDParameters.ProductID)) + "";
                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


    }
    public class Details
    {
        public string ProjectID { get; set; }
        public string CRMRequestID { get; set; }
        public string Mode { get; set; }
        public string strUserName { get; set; }
        public string strRequestorSUserName { get; set; }
        public string strRequestorSLoginType { get; set; }
        public string DepartmentID { get; set; }
        public string IssueID { get; set; }
        public string comments { get; set; }
        public string UserID { get; set; }
        public string AttachementList { get; set; }
        public string CommentsList { get; set; }
        public string CboIssueProject { get; set; }
        public string objcboAssignTo { get; set; }
        public string CboIssueType { get; set; }
        public string CboIssueStatus { get; set; }
        public string summary { get; set; }
        public string ProductID { get; set; }
        public string desc { get; set; }
        public string CboIssuePriority { get; set; }
        public string CboIssueSeverity { get; set; }
        public string CboCustomer { get; set; }
        public string CboIssueProduct { get; set; }
        public string CboIssueComponent { get; set; }


    }


    public class DetailsParameters
    {
        public string CRMRequestID { get; set; }
        public string ProjectID { get; set; }
        public string IssueType { get; set; }
        public string CustomerID { get; set; }
        public string ProductID { get; set; }
        public string PostID { get; set; }
        public string IsShowProduct { get; set; }
        public string DepartmentID { get; set; }
        public string strRequestorSLoginType { get; set; }
        public string strRequestorSUserName { get; set; }
   
     
        public DataTable ProjectIssueType { get; set; }
        public DataTable Product { get; set; }
        public DataTable ProjectProductCustoer { get; set; }
        public DataTable ProjectStatus { get; set; }
 
        public DataTable drProjectSeverity { get; set; }
        public DataTable drProjectEmployee { get; set; }
        public DataTable drProjectStatus { get; set; }
        public DataTable drProjectPriority { get; set; }
     


    }
}