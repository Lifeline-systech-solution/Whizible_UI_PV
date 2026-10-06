 using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Extensions;
using WhizibleAPI.Models.RM;

namespace WhizibleAPI.Controllers
{ 
    [Authorize]
    public class RM_OpportunityRequestController : ApiController
    {
        #region Resource plan

        ////Added by imran on 19-08-2022 
        [Authorize, App_Start.ValidateHeaders]      
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetORResourcePlans([FromBody] OR_Params ORParameter)
        {
           
            try
            {
                var OrResourcePlanList = new List<OR_ResourcePlan>();
                if (ORParameter != null && ORParameter.OpportunityID > 0)
                {
                    string strSQL = "Exec usp_Whizible2_sel_tbl_OR_v_tbl_RM_Pipeline_ResourcePlans '" + ORParameter.OpportunityID + "'";
                    DataTable ORResourcePlanTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (ORResourcePlanTable != null)
                    {
                        OrResourcePlanList = ORResourcePlanTable.ToListCast<OR_ResourcePlan>();
                    }
                }
                return Request.CreateResponse(HttpStatusCode.OK, OrResourcePlanList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
           

        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SaveORResourcePlan([FromBody] OR_ParamsSave ORParameter)
        {
          
            try
            {
                var OrResourcePlanList = new List<OR_ResourcePlan>();
                if (ORParameter != null && ORParameter.OpportunityID > 0)
                {
                    if (ORParameter.TentativeStartDate!=null  && ORParameter.TentativeEndDate!=null)
                    {
                        //if (ORParameter.TentativeStartDate> ORParameter.TentativeEndDate)
                        //{
                        //    return Request.CreateResponse(HttpStatusCode.OK, "StartDate");
                        //}
                        string strSQL = "";
                        
                        if (ORParameter.PipelineID > 0)
                        {
                            strSQL = "Exec usp_Whizible2_Upd_tbl_RM_Pipeline '" + ORParameter.PipelineID + "','" + ORParameter.OpportunityID + "','" + ORParameter.Description + "','" + ORParameter.RoleID + "','" + ORParameter.ToolID + "','" + ORParameter.TotalFTE + "','" + ORParameter.TentativeStartDate + "','" + ORParameter.TentativeEndDate + "','" + ORParameter.CreatedBy + "' ";
                            //Added By Reshma Chavan on 16th Dec 2021 For displaying 0 value in Distribution tab
                            int Result1 = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                            //End of Added By Reshma Chavan on 16th Dec 2021 For displaying 0 value in Distribution tab
                        }
                        else
                        {
                            strSQL = "Exec usp_Whizible2_Ins_tbl_RM_Pipeline '" + ORParameter.OpportunityID + "','" + ORParameter.Description + "','" + ORParameter.RoleID + "','" + ORParameter.ToolID + "','" + ORParameter.TotalFTE + "','" + ORParameter.TentativeStartDate + "','" + ORParameter.TentativeEndDate + "','" + ORParameter.CreatedBy + "' ";
                        }

                        int Result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                        if (Result > 0)
                        {
                            return Request.CreateResponse(HttpStatusCode.Created);
                        }
                        else
                        {
                            return Request.CreateResponse(HttpStatusCode.Created, "Updated");
                        }
                    }
                   
                }
                return Request.CreateResponse(HttpStatusCode.OK, OrResourcePlanList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            

        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteORResourcePlan([FromBody] OR_Params ORParameters)
        {
            try
            {
                if (ORParameters != null && ORParameters.PipelineID > 0)
                {
                    string Result = "";
                    string strSQL = "Exec usp_Whizible2_Del_tbl_RM_Pipeline '" + ORParameters.PipelineID + "'";
                    var srtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    if (srtResult != "Deleted")
                    {
                        Result += srtResult;
                    }


                    return Request.CreateResponse(HttpStatusCode.OK, Result);
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.InternalServerError, "Bad Request found");
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetORResourcePlansDistribution([FromBody] OR_Params ORParameter)
        {
          
            try
            {
                var OrDistributionList = new List<OR_ResourcePlanDistribution>();
                decimal TotalFTE = 0;
                if (ORParameter != null && ORParameter.PipelineID > 0)
                {
                    //string strSQL = "Exec usp_sel_v_tbl_RM_Pipeline_Distribution '" + ORParameter.PipelineID + "'";
                    //New  usp_Whizible2_sel_v_tbl_RM_Pipeline_Distribution
                    //usp_sel_v_tbl_RM_Pipeline_Distribution old wihout change name
                    string strSQL = "Exec usp_Whizible2_Sel_v_tbl_RM_Pipeline_Distribution '" + ORParameter.PipelineID + "'";
                    DataSet ORDistributionSet = CommonFunctions.Data.GetDataSet(strSQL, "DistAndPipeline", ConnectionString: CommonController.connectionString);

                    //var objDS = CommonFunctions.Data.GetDataSet(strSQL.ToString(), "ActionMessage", 0/* Conversion error: Set to default value for this argument */, 0/* Conversion error: Set to default value for this argument */, System.Convert.ToBoolean(true));
                    if (ORDistributionSet.Tables[0] != null)
                    {
                        OrDistributionList = ORDistributionSet.Tables[0].ToListCast<OR_ResourcePlanDistribution>();
                    }
                    if (ORDistributionSet.Tables[1] != null)
                    {
                        TotalFTE = ORDistributionSet.Tables[1].Rows.Count > 0 ? Convert.ToDecimal(ORDistributionSet.Tables[1].Rows[0][0]) : 0;
                    }


                    return this.Request.CreateResponse(HttpStatusCode.OK,
                                 new { DistributionLst = OrDistributionList, TotalFTE });
                }
                return Request.CreateResponse(HttpStatusCode.OK, OrDistributionList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
           

        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage UpdateORResourcePlanDistribution([FromBody] OR_ResourcePlanDistribution ORDistParameter)
        {
            try
            {
                if (ORDistParameter != null && ORDistParameter.DistributionID > 0)
                {
                    string strSQL = "";

                    string strParms = "" + ORDistParameter.DistributionID + "," + ORDistParameter.OpportunityID + "," + ORDistParameter.Year +"," ;
                    if (!string.IsNullOrEmpty(ORDistParameter.Jan.ToString()))
                    {
                        strParms += "@Jan=" + ORDistParameter.Jan + ",";
                    }
                    if (!string.IsNullOrEmpty(ORDistParameter.Feb.ToString()))
                    {
                        strParms += "@Feb=" + ORDistParameter.Feb + ",";
                    }
                    if (!string.IsNullOrEmpty(ORDistParameter.Mar.ToString()))
                    {
                        strParms += "@Mar=" + ORDistParameter.Mar + ",";
                    }
                    if (!string.IsNullOrEmpty(ORDistParameter.Apr.ToString()))
                    {
                        strParms += "@Apr=" + ORDistParameter.Apr + ",";
                    }
                    if (!string.IsNullOrEmpty(ORDistParameter.May.ToString()))
                    {
                        strParms += "@May=" + ORDistParameter.May + ","; ;
                    }
                    if (!string.IsNullOrEmpty(ORDistParameter.Jun.ToString()))
                    {
                        strParms += "@Jun=" + ORDistParameter.Jun + ","; ;
                    }
                    if (!string.IsNullOrEmpty(ORDistParameter.Jul.ToString()))
                    {
                        strParms += "@Jul=" + ORDistParameter.Jul + ",";
                    }
                    if (!string.IsNullOrEmpty(ORDistParameter.Aug.ToString()))
                    {
                        strParms += "@Aug=" + ORDistParameter.Aug + ",";
                    }
                    if (!string.IsNullOrEmpty(ORDistParameter.Sep.ToString()))
                    {
                        strParms += "@Sep=" + ORDistParameter.Sep + ",";
                    }
                    if (!string.IsNullOrEmpty(ORDistParameter.Oct.ToString()))
                    { 
                        strParms += "@Oct=" + ORDistParameter.Oct + ",";
                    }
                    if (!string.IsNullOrEmpty(ORDistParameter.Nov.ToString()))
                    {
                        strParms += "@Nov=" + ORDistParameter.Nov + ",";
                    }
                    if (!string.IsNullOrEmpty(ORDistParameter.Dec.ToString()))
                    {
                        strParms += "@Dec=" + ORDistParameter.Dec + ",";
                    }
                    strParms = strParms.TrimEnd(',');
                    strSQL = "Exec usp_Whizible2_Upd_tbl_tbl_RM_Pipeline_Distribution "+ strParms;
                    int Result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    if (Result > 0)
                    {
                        return Request.CreateResponse(HttpStatusCode.Created);
                    }

                }
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
           

        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetORResourcePlanSoftbookings([FromBody] OR_SodtBoonkingFilter ORSoftbookingParameter)
        {
           
            try
            {
                var ORSoftbookingList = new List<Softbooking>();
                string strSQL = "";
                List<int> EmpIdsList = new List<int>();
                if (ORSoftbookingParameter != null && !string.IsNullOrEmpty(ORSoftbookingParameter.WhereClause))
                {
                    strSQL = "Exec usp_Whizible2_Sel_V_tbl_PM_Resource_Selection_ResourceDemand '" + ORSoftbookingParameter.WhereClause + "'";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Sel_V_tbl_PM_Resource_Selection_ResourceDemand";
                }

                DataTable ORResourcePlanSoftbookingsTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (ORResourcePlanSoftbookingsTable != null)
                {
                    ORSoftbookingList = ORResourcePlanSoftbookingsTable.ToListCast<Softbooking>();
                }
                IDataReader drQuery;
                string strSQLEmp = "";
                if (ORSoftbookingParameter.OpportunityID>0 && ORSoftbookingParameter.PipelineID>0)
                {
                    strSQLEmp = "usp_Whizible2_Sel_SoftBookingResources '" + ORSoftbookingParameter.OpportunityID + "','" + ORSoftbookingParameter.PipelineID + "' ";
                    drQuery = CommonFunctions.Data.GetDataReader(strSQLEmp, true, CommonController.connectionString);

                    if (drQuery.Read())
                    {
                        var ids = CommonFunctions.Data.CheckIsDBNull(drQuery["EmpIds"], null);
                        if (ids != null)
                        {
                            string[] arrempIds = ids.ToString().Split(',');
                            foreach (var itemEmp in arrempIds)
                            {
                                if (itemEmp != null && !string.IsNullOrEmpty(itemEmp))
                                {
                                    EmpIdsList.Add(Convert.ToInt32(itemEmp));
                                }

                            }
                        }
                    }
                    ///usp_Whizible2_Sel_SoftBookingResources
                }
                return this.Request.CreateResponse(HttpStatusCode.OK, new { SoftbookingList = ORSoftbookingList, EmpIds = EmpIdsList });
                //return Request.CreateResponse(HttpStatusCode.OK, ORSoftbookingList);
            }

            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
          

        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SaveORResourcePlanSoftbookings([FromBody] OR_SoftbookingSave ORSoftBookParameter)
        {
            try
            {   //Commented and Added By RehanC for Array Conversion on 23rd Mar 2023
                //if (ORSoftBookParameter != null && ORSoftBookParameter.OpportunityID > 0 && ORSoftBookParameter.EmployeeIDs.Count > 0)
                //var employeeIDs = ORSoftBookParameter.EmployeeIDs.Split(',');
                if (ORSoftBookParameter != null && ORSoftBookParameter.OpportunityID > 0)
                //End Of Comment By RehanC
                {
                    string strSQLToDelete = "";
                    strSQLToDelete = "Exec usp_Whizible2_Del_tbl_RM_SoftBooking '" + ORSoftBookParameter.OpportunityID + "' ,'" + ORSoftBookParameter.PipelineID + "'";
                    var srtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQLToDelete, true, CommonController.connectionString));
                   
                    string strSQL = "";
                    //var splitEmpId = ORSoftBookParameter.EmployeeIDs.Split(',');
                    string[] uniqueIDs;
                    uniqueIDs = ORSoftBookParameter.EmployeeIDs.Split(',');
                    if (uniqueIDs.Length > 1)
                    {
                        //foreach (var itemEmpId in ORSoftBookParameter.EmployeeIDs)
                        for (int i = 0; i < uniqueIDs.Length; i++)
                        {   //Commented and Modified By RehanC for Array Conversion on 28th Mar 2023
                            //strSQL = "usp_Whizible2_Ins_tbl_RM_SoftBooking '" + ORSoftBookParameter.OpportunityID + "','" + ORSoftBookParameter.PipelineID + "','" + itemEmpId + "','" + ORSoftBookParameter.UserName + "'";
                            strSQL = "usp_Whizible2_Ins_tbl_RM_SoftBooking '" + ORSoftBookParameter.OpportunityID + "','" + ORSoftBookParameter.PipelineID + "','" + Convert.ToInt64(uniqueIDs[i].ToString()) + "','" + ORSoftBookParameter.UserName + "'";
                            //End Of Comment By RehanC
                            int Result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                            if (Result > 0)
                            {


                            }
                            else
                            {
                                //return Request.CreateResponse(HttpStatusCode.Created, "Updated");
                            }
                        }
                    }
                    else {
                        strSQL = "usp_Whizible2_Ins_tbl_RM_SoftBooking '" + ORSoftBookParameter.OpportunityID + "','" + ORSoftBookParameter.PipelineID + "','" + Convert.ToInt64(ORSoftBookParameter.EmployeeIDs) + "','" + ORSoftBookParameter.UserName + "'";
                        //End Of Comment By RehanC
                        int Result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                        if (Result > 0)
                        {

                        }
                        else
                        {
                            //return Request.CreateResponse(HttpStatusCode.Created, "Updated");
                        }
                    }
                    return Request.CreateResponse(HttpStatusCode.Created);
                    //usp_Whizible2_Ins_tbl_RM_SoftBooking
                    //strSQL = "Exec usp_Whizible2_Upd_tbl_RM_Pipeline '" + ORParameter.PipelineID + "','" + ORParameter.OpportunityID + "','" + ORParameter.Description + "','" + ORParameter.RoleID + "','" + ORParameter.ToolID + "','" + ORParameter.TotalFTE + "','" + ORParameter.TentativeStartDate + "','" + ORParameter.TentativeEndDate + "','" + ORParameter.CreatedBy + "' ";

                }
                return Request.CreateResponse(HttpStatusCode.Created);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

          
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        public object ExportDocument([FromBody]TaskParameter taskParameters)
        {

            try
            {
                string strSQL = "";
                string strFilePath;
                string m_strFileName;
                long m_lngReportID;
                int DateFormatID = 0;
                string CompanyName = "";
                string ReportFormat = taskParameters.ReportFormat;

                int lngDefaultLCID;
                int lngCurrentThreadUICultureID;
                lngDefaultLCID = 1033;
                lngCurrentThreadUICultureID = 1033;
                AdHocReports.Report.AdHocReport oRpt;  
                if (taskParameters.OpportunityID > 0)
                {
                    strSQL = "usp_Whizible2_CRW_OpportunityInformation '" + taskParameters.OpportunityID + "' ";
                }

                IDataReader drCompInfo1 = CommonFunctions.Data.GetSQLDataReader(strSQL, CommonController.connectionString);
                if (drCompInfo1.Read() == false)
                {
                    return "";
                }
                //m_lngReportID = 22286;  //22272
                m_lngReportID = 5000;
                CommonEngines.HashTables.Culture.ConnectionString = CommonController.connectionString;
                CommonEngines.HashTables.Culture.FillCultureHashTable();
                // The reports are created in the "Reports" folder
                strFilePath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../Reports/"));//FOR DEV ENV
                                                                                                                               //  strFilePath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../../Reports/")); //FOR LOCAL ENV
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
                    //case "DOC": m_strFileName += ".doc"; break;
                    default: m_strFileName += ".pdf"; break;
                }
                IDataReader drCompInfo = CommonFunctions.Data.GetSQLDataReader("usp_Whizible2_sel_tbl_PM_CompanyInformation", CommonController.connectionString);

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
                    // case "DOC": oRpt.GenerateReport(AdHocReports.Format.DOC); break;
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

        #region OR main  page 

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SaveOpportunityRequest([FromBody] OpportunityRequest OP_Parameters)
        {
            try
            {
                OP_Activestatus OP_status = new OP_Activestatus();
                if (OP_Parameters != null)
                {
                    var flag = 0;
                    if (OP_Parameters.IsApprovedOnce)
                    {
                        flag = 1;
                    }
                    string activeStatus=GetInactiveActiveStauts(OP_Parameters);
                    OP_status.Status = activeStatus;
                    if (activeStatus == "Active")
                    {
                        string strSQL = "EXEC usp_Whizible2_Ins_v_tbl_RM_Opportunity " + OP_Parameters.RaisedBy + ",'" + OP_Parameters.ApprovedStatus + "'," +
                            OP_Parameters.CustomerID + ",'" + OP_Parameters.Prospect + "','" + OP_Parameters.Title + "','" + OP_Parameters.Description + "','" +
                            OP_Parameters.Address + "'," + OP_Parameters.RegionID + ",'" + OP_Parameters.PinCode + "'," + OP_Parameters.CountryID + "," +
                            OP_Parameters.Size + "," + OP_Parameters.CurrencyID + ",'" + OP_Parameters.ApproxStartDate + "'," + OP_Parameters.ApproxDuration + ",'" +
                            OP_Parameters.RaisedDate + "','" + OP_Parameters.BusinessGroupID + "'," + OP_Parameters.LocationID + ",'" + OP_Parameters.ResourcePoolID + "'," +
                            OP_Parameters.GroupID + ",'" + OP_Parameters.CoolingOf + "'," + OP_Parameters.StatusID + "," + OP_Parameters.ProjectID + "," + OP_Parameters.ProductID + ",'" + OP_Parameters.CreatedBy + "'," + OP_Parameters.IntUserId;

                        int Result = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
                        OP_status.OprID = Result;
                        if (Result > 0)
                        {
                            string strSQLProb = "EXEC usp_Whizible2_Ins_tbl_RM_Opportunity_Probability " + OP_Parameters.IntUserId + ",'" + OP_Parameters.CreatedBy + "'," + Result + "," + OP_Parameters.ProbabilityCurrent + ",'" + OP_Parameters.ProbabilityComment + "'";
                            CommonFunctions.Data.InsertOrUpdateData(strSQLProb, true, CommonController.connectionString);
                        }
                        return Request.CreateResponse(HttpStatusCode.OK, OP_status);
                    }
                    else
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, OP_status);
                    }

                    
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.OK, "Bad Request found");
                }

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetOpportunityRequestData([FromBody] OR_Filter OP_Parameters)
        {

            
            try
            {
                List<RM_ORGetModel> OpportunityRequestList = new List<RM_ORGetModel>();
                string strSQL = "";
                string strSQL2 = "";
                IDataReader drQuery;
                if (OP_Parameters.IntUserID >0)
                {
                    strSQL2 = "SELECT BusinessGroupID,LocationID from tbl_PM_Employee where EmployeeID=" + OP_Parameters.IntUserID;
                    drQuery = CommonFunctions.Data.GetDataReader(strSQL2, true, CommonController.connectionString);
                    if (drQuery.Read())
                    {
                        OP_Parameters.BusinessGroupID = Convert.ToInt32(drQuery["BusinessGroupID"]);
                        OP_Parameters.LocationID = Convert.ToInt32(drQuery["LocationID"]);
                       CommonFunctions.Data.DisposeDataReader(ref drQuery);
                    }
                }
                if (OP_Parameters != null && !string.IsNullOrEmpty(OP_Parameters.WhereClause))
                {
                    strSQL = "Exec usp_Whizible2_sel_v_tbl_RM_Opportunity "+ OP_Parameters .IntUserID+ ",'" + OP_Parameters.WhereClause + "',"+ OP_Parameters.BusinessGroupID +","+OP_Parameters.LocationID;
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_sel_v_tbl_RM_Opportunity " + OP_Parameters.IntUserID + ",NULL," + OP_Parameters.BusinessGroupID + "," + OP_Parameters.LocationID;
                }

                var strSQL1 = "select DemandApprover from v_tbl_PM_Role Where RoleID = (Select PostId from v_tbl_PM_Employee Where EmployeeID = " + OP_Parameters.IntUserID + ")";
                var IsDemandApproverFlag = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString));
                var flag = 0;
                if (IsDemandApproverFlag == "True")
                {
                    flag = 1;
                }
                DataTable OpportunityRequestTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow taskStatusRow in OpportunityRequestTable.Rows)
                {
                    RM_ORGetModel empskill = new RM_ORGetModel()
                    {

                        OpportunityID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["OpportunityID"], "0")),
                        IntUserId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["UserId"], "0")),
                        Prospect = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Prospect"], "")),
                        Title = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Title"], "")),
                        CoolingOf = String.Format("{0:dd MMMM yyyy}", taskStatusRow["CoolingOf"]),
                        OpportunityStatus = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["OpportunityStatus"], "")),
                        ApprovedStatusFilter = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ApprovedStatusFilter"], "")),
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ProjectName"], "")),
                        //FrequencyName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["FrequencyName"], "")),
                        CustomerName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["CustomerName"], "")),
                        //IsDemandApprover = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["DemandApprover"], "0")),
                          IsDemandApprover = flag
                    };

                    OpportunityRequestList.Add(empskill);
                }

                //if (IsDemandApproverFlag != "True")
                //{
                //    OpportunityRequestList = OpportunityRequestList.Where(li => li.IntUserId == OP_Parameters.IntUserID).ToList();
                //}

                return Request.CreateResponse(HttpStatusCode.OK, OpportunityRequestList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }


        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteOpportunityRequest([FromBody] string OP_Parameter)
        {
            try
            {
                if (OP_Parameter != null)
                {
                    string Result = "";


                    string strSQL = "Exec usp_Whizible2_Del_tbl_RM_Opportunity " + OP_Parameter;
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


           [HttpPost]
        // [Authorize]
        public HttpResponseMessage GetOPCustomers()
        {

            
            try
            {
                List<OP_Customer> OPCustomerList = new List<OP_Customer>();
                var strSQL = "usp_Whizible2_sel_e_tbl_PM_Customer ";

                DataTable OPCustomersTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (OPCustomersTable != null)
                {
                    // OPCustomerList = OPCustomersTable.ToList<OP_Customer>();


                    foreach (DataRow taskStatusRow in OPCustomersTable.Rows)
                    {
                        OP_Customer op_approver = new OP_Customer()
                        {

                            CustomerName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["CustomerName"], "")),
                            Customer = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Customer"], "0")),
                            CustomerID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["CustomerID"], "")),
                            AccountNumber = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["AccountNumber"], "")),
                            ProjectOrProductCustomer = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ProjectOrProductCustomer"], "")),
                            Country = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Country"], "")),
                            City = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["City"], "")),
                            EmailID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["EmailID"], ""))
                        };

                        string strSQL1 = "Exec usp_Whizible2_sel_tbl_PM_Login_IsCreatedByCustomer " + op_approver.Customer;
                        var IsActiveLogin = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString));
                        if (IsActiveLogin == "1" )
                        {
                            op_approver.IsActiveLogin = true;
                        }

                         OPCustomerList.Add(op_approver);
                    }
                }
                return Request.CreateResponse(HttpStatusCode.OK, OPCustomerList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }


        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage UpdateOpportunityRequest([FromBody] OpportunityRequest OP_Parameters)
        {
            try
            {
                OP_Activestatus OP_status = new OP_Activestatus();
                if (OP_Parameters != null)
                {
                    var flag = 0;
                    if (OP_Parameters.IsApprovedOnce)
                    {
                        flag = 1;
                    }
                    string activeStatus = GetInactiveActiveStauts(OP_Parameters);
                    OP_status.Status = activeStatus;
                    if (activeStatus == "Active")
                    {
                        string strSQL = "EXEC usp_Whizible2_Upd_tbl_RM_Opportunity " + OP_Parameters.OpportunityID + "," + OP_Parameters.RaisedBy + ",'" + OP_Parameters.ApprovedStatus + "'," +
                        OP_Parameters.CustomerID + ",'" + OP_Parameters.Prospect + "','" + OP_Parameters.Title + "','" + OP_Parameters.Description + "','" +
                        OP_Parameters.Address + "'," + OP_Parameters.RegionID + ",'" + OP_Parameters.PinCode + "'," + OP_Parameters.CountryID + "," +
                        OP_Parameters.Size + "," + OP_Parameters.CurrencyID + ",'" + OP_Parameters.ApproxStartDate + "'," + OP_Parameters.ApproxDuration + ",'" +
                        OP_Parameters.RaisedDate + "','" + OP_Parameters.BusinessGroupID + "'," + OP_Parameters.LocationID + ",'" + OP_Parameters.ResourcePoolID + "'," +
                        OP_Parameters.GroupID + ",'" + OP_Parameters.CoolingOf + "'," + OP_Parameters.StatusID + "," + OP_Parameters.ProductID + "," + OP_Parameters.ProjectID + ",'" + OP_Parameters.ModifiedBy + "'";

                        CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                        string strSQLProb = "EXEC usp_Whizible2_Upd_tbl_RM_Opportunity_Probability " + OP_Parameters.IntUserId + ",'" + OP_Parameters.CreatedBy + "'," + OP_Parameters.OpportunityID + "," + OP_Parameters.ProbabilityCurrent + ",'" + OP_Parameters.ProbabilityComment + "'";
                        CommonFunctions.Data.InsertOrUpdateData(strSQLProb, true, CommonController.connectionString);
                        //return Request.CreateResponse(HttpStatusCode.OK, "Success");
                        return Request.CreateResponse(HttpStatusCode.OK, OP_status);
                        

                    }
                    else
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, OP_status);
                    }
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.OK, "Bad Request found");
                }

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetOpportunityRequestById([FromBody] string OpportunityID)
        {
            try
            {
                RM_ORGetModel objOPR = new RM_ORGetModel();
                var strSQL = "usp_Whizible2_Sel_tbl_RM_OpportunityById " + OpportunityID;
                IDataReader drQuery, drQueryProb;
                drQuery = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (drQuery.Read())
                {
                    objOPR.OpportunityID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["OpportunityID"],"0"));
                    objOPR.Prospect = Convert.ToString(drQuery["Prospect"]);
                    objOPR.Title = Convert.ToString(drQuery["Title"]);
                    objOPR.Description = Convert.ToString(drQuery["Description"]);
                    objOPR.Address = Convert.ToString(drQuery["Address"]);
                    objOPR.ApprovedStatus = Convert.ToString(drQuery["ApprovedStatus"]);
                    objOPR.CountryID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["CountryID"],"0"));
                    objOPR.CurrencyID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["CurrencyID"],"0"));
                    objOPR.BusinessGroupID = Convert.ToInt32(drQuery["BusinessGroupID"]);
                    objOPR.ApproxStartDate = String.Format("{0:dd MMMM yyyy}", drQuery["ApproxStartDate"]);
                    objOPR.RaisedDate = String.Format("{0:dd MMMM yyyy}", drQuery["RaisedDate"]);
                    objOPR.ResourcePoolID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["ResourcePoolID"],"0"));
                    objOPR.CoolingOf = String.Format("{0:dd MMMM yyyy}", drQuery["CoolingOf"]);
                    objOPR.RaisedBy = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["RaisedBy"],"0"));
                    objOPR.ProductID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["ProductID"], "0"));
                    objOPR.ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["ProjectID"], "0"));
                    objOPR.RegionID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["RegionID"], "0"));
                    objOPR.PinCode = Convert.ToString(drQuery["PinCode"]);
                    objOPR.ApprovedStatusFilter = Convert.ToString(drQuery["ApprovedStatusFilter"]);
                    objOPR.Size = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drQuery["Size"],"0"));
                    objOPR.ApproxDuration = Convert.ToDouble(drQuery["ApproxDuration"]);
                    objOPR.LocationID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["LocationID"], "0"));
                    objOPR.GroupID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["GroupID"],"0"));
                    objOPR.StatusID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["StatusID"],"0"));
                    objOPR.CustomerID= Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["CustomerID"], "0"));
                    //CommonFunctions.Data.DisposeDataReader(ref drQuery);

                    var strSQLProb = "usp_Whizible2_sel_tbl_RM_Opportunity_Probability " + OpportunityID;
                    drQueryProb = CommonFunctions.Data.GetDataReader(strSQLProb, true, CommonController.connectionString);
                    if (drQueryProb.Read())
                    {
                        objOPR.ProbabilityComment = Convert.ToString(drQueryProb["Comments"]);
                        objOPR.ProbabilityCurrent = Convert.ToString(drQueryProb["EngagementProbability"]);
                        CommonFunctions.Data.DisposeDataReader(ref drQueryProb);
                    }

                }
                return Request.CreateResponse(HttpStatusCode.OK, objOPR);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
           


        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetOpportunityRequestApprovers([FromBody] string OP_Parameter)
        {

            
            try
            {
                List<OP_Approver> OpportunityRequestApproversList = new List<OP_Approver>();
                string strSQL="";
                if (OP_Parameter!=null && OP_Parameter!="")
                {
                    strSQL = "usp_Whizible2_Sel_tbl_RM_Opportunity_Approvers 'ApproversPage'," + OP_Parameter;
                }
                else
                {
                    strSQL = "usp_Whizible2_Sel_tbl_RM_Opportunity_Approvers 'ApproversPage'";
                }
                

                DataTable OpportunityRequestApproversTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (OpportunityRequestApproversTable != null)
                {
                    OpportunityRequestApproversList = OpportunityRequestApproversTable.ToList<OP_Approver>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, OpportunityRequestApproversList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

             
        }


        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetBusinessGroupsLocation([FromBody] OP_Filter OP_FilterParam)
        {

            
            try
            {
                List<OP_BusinessGroupLocation> BusinessGroupsLocationList = new List<OP_BusinessGroupLocation>();
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
        /// <summary>
        /// Get OU using BG id for filter (active and inactive)
        /// </summary>
        /// <param name="OP_FilterParam"></param>
        /// <returns></returns>
        /// 
        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetOrgUnitForFilter([FromBody] OP_Filter OP_FilterParam)
        {

            try
            {
                List<OP_BusinessGroupLocation> BusinessGroupsLocationList = new List<OP_BusinessGroupLocation>();
                var strSQL = "usp_Whizible2_Sel_GetOrgUnitForFilter " + OP_FilterParam.BusinessGroupID + ", NULL, 0";

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

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetResourcePoolForLocation([FromBody] OP_Filter OP_FilterParam)
        {

          
            try
            {
                List<OP_ResourcePoolLocation> ResourcePoolLocationList = new List<OP_ResourcePoolLocation>();
                var strSQL = "usp_Whizible2_Sel_GetResourcePoolForLocation " + OP_FilterParam.LocationID + ","+OP_FilterParam.OprID;

                DataTable ResourcePoolLocationTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (ResourcePoolLocationTable != null)
                {
                    ResourcePoolLocationList = ResourcePoolLocationTable.ToList<OP_ResourcePoolLocation>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, ResourcePoolLocationList);

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
         


        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]        
       public HttpResponseMessage GetBusinessGroups([FromBody] OP_Filter OP_FilterParam)
        {

            
            try
            {
                List<OP_BusinessGroups> BgList = new List<OP_BusinessGroups>();
                var strSQL = "usp_Whizible2_sel_BusinessGroupsLocation " + OP_FilterParam.LocationID + "," + OP_FilterParam.OprID;

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

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetDeliveryTeam([FromBody] OP_Filter OP_FilterParam)
        {

          
            try
            {
                List<OP_DeliveryTeam> DeliveryTeamList = new List<OP_DeliveryTeam>();
                var strSQL = "usp_Whizible2_sel_GetDeliveryTeam " + OP_FilterParam.LocationID + ","+OP_FilterParam.OprID;

                DataTable DeliveryTeamTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (DeliveryTeamTable != null)
                {
                    DeliveryTeamList = DeliveryTeamTable.ToList<OP_DeliveryTeam>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, DeliveryTeamList);

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            

        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        //Commented and Modified By RehanC for Parameter mismatch issue on 6th April 2023
        //public HttpResponseMessage FillProjectByCustomerID([FromBody] int customerID)
        public HttpResponseMessage FillProjectByCustomerID([FromBody] OP_FillProjectByCustomerID OP_Parameters)
        //End of Comment By RehanC on 6th April 2023
        {

          
            try
            {
                List<OP_Project> projectList = new List<OP_Project>();
                //Commented and Modified By RehanC for Parameter mismatch issue on 6th April 2023
                //var strSQL = "usp_Whizible2_sel_tbl_PM_Project " + customerID;
                var strSQL = "usp_Whizible2_sel_tbl_PM_Project " + OP_Parameters.CustomerID;
                //End of Comment By RehanC on 6th April2023

                DataTable projectTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (projectTable != null)
                {
                    projectList = projectTable.ToList<OP_Project>();
                }

                return Request.CreateResponse(HttpStatusCode.OK, projectList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            


        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SendForApproval([FromBody] OP_SendForApprovalParams OP_Parameters)
        {
            try
            {
                if (OP_Parameters != null)
                {
                    //string param1 = "INSERT INTO tbl_RM_OpportunityRevision(OpportunityID,Comment,StatusChangeDate,FromStatus,ToStatus,statusChangedBy) VALUES ("+ OP_Parameters.OpportunityID +",''"+OP_Parameters.Comment+"'',''"+ DateTime.UtcNow.ToString("dd MMMM yyyy") +"'',''"+OP_Parameters.FromStatus+"'', ''"+OP_Parameters.ToStatus+"'',"+OP_Parameters.statusChangedBy+")Select ''PK'' = SCOPE_IDENTITY() ";
                    //string param2 = "<WebFormData WebFormID=''3863''><Fields><OpportunityID>"+ OP_Parameters.OpportunityID +"</OpportunityID><Comment>"+ OP_Parameters.Comment +"</Comment><StatusChangeDate>"+  DateTime.UtcNow.ToString("dd MMMM yyyy")  +"</StatusChangeDate><FromStatus>"+OP_Parameters.FromStatus+"</FromStatus><ToStatus>"+OP_Parameters.ToStatus+"</ToStatus><statusChangedBy>"+OP_Parameters.statusChangedBy+"</statusChangedBy></Fields></WebFormData>";

                    string strSQL = "EXEC usp_Whizible2_Ins_tbl_RM_OpportunityRevision " + OP_Parameters.OpportunityID + ",'" + OP_Parameters.Comment + "','" + DateTime.UtcNow.ToString("dd MMMM yyyy") + "','" + OP_Parameters.FromStatus + "', '" + OP_Parameters.ToStatus + "'," + OP_Parameters.statusChangedBy;

                     var srtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                    return Request.CreateResponse(HttpStatusCode.OK, srtResult);
            }
                else
                {
                return Request.CreateResponse(HttpStatusCode.OK, "Bad Request found");
            }

        }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage OP_SendForRevision([FromBody] OP_SendForApprovalParams OP_Parameters)
        {
            try
            {
                if (OP_Parameters != null)
                {

                    string strSQL = "EXEC usp_Whizible2_Ins_tbl_RM_OpportunityRevision_Revision " + OP_Parameters.statusChangedBy + "," + OP_Parameters.OpportunityID + "";

                     var srtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                    return Request.CreateResponse(HttpStatusCode.OK, "Success");
            }
                else
                {
                return Request.CreateResponse(HttpStatusCode.OK, "Bad Request found");
            }

        }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage CheckForSendApprovalAndRevision([FromBody] OP_SendForApprovalParams OP_Parameters)
        {
            try
            {
                OP_SendForApprovalRevision oP_SendForApprovalRevision = new OP_SendForApprovalRevision();
                if (OP_Parameters != null)
                {

                    string strSQLSendForApproval = "select top 1 1 from tbl_RM_Opportunity O INNER JOIN tbl_RM_Pipeline P  ON O.OpportunityID = P.OpportunityID  INNER JOIN tbl_CNF_OpportunityStatus OS ON O.StatusID = OS.OpportunityStatusID AND ISNULL(MapToDrop,0) = 0 AND ISNULL(MapToReadyForClosure,0) = 0  WHERE O.OpportunityID = "+OP_Parameters.OpportunityID+"  AND (ISNULL(ApprovedStatus,'D') = 'D' OR ApprovedStatus = 'RE' ) AND ISNULL(ConvertedToProject,0) = 0";

                    string strSQLRevision = "SELECT 1 FROM tbl_RM_Opportunity INNER JOIN tbl_CNF_OpportunityStatus OS ON tbl_RM_Opportunity.StatusID = OS.OpportunityStatusID WHERE OpportunityID = "+OP_Parameters.OpportunityID+" AND ( ApprovedStatus <> 'D' AND ApprovedStatus <> 'RE' ) AND ISNULL(ConvertedToProject,0) = 0 AND ISNULL(MapToReadyForClosure,0) = 0";
                    string strSQLOprStatus = "SELECT ApprovedStatus FROM tbl_RM_Opportunity INNER JOIN tbl_CNF_OpportunityStatus OS ON tbl_RM_Opportunity.StatusID = OS.OpportunityStatusID WHERE OpportunityID =" + OP_Parameters.OpportunityID;
                    var srtResultSendForApproval = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQLSendForApproval, true, CommonController.connectionString));
                    var srtResultRevision = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQLRevision, true, CommonController.connectionString));
                    var srtOprStatus = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQLOprStatus, true, CommonController.connectionString));

                    if (srtResultSendForApproval == "1")
                    {
                        oP_SendForApprovalRevision.IsSendForApproval = true;
                    }

                    if (srtResultRevision == "1")
                    {
                        oP_SendForApprovalRevision.IsRevision = true;
                    }
                    oP_SendForApprovalRevision.OprStatus = srtOprStatus;
                    return Request.CreateResponse(HttpStatusCode.OK, oP_SendForApprovalRevision);
            }
                else
                {
                return Request.CreateResponse(HttpStatusCode.OK, "Bad Request found");
            }

        }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage CheckForApproveReject([FromBody] OP_SendForApprovalParams OP_Parameters)
        {
            try
            {
                OP_SendForApprovalRevision oP_SendForApprovalRevision = new OP_SendForApprovalRevision();
                if (OP_Parameters != null)
                {

                    string strSQL = "select 1 from tbl_RM_Opportunity where OpportunityID = "+OP_Parameters.OpportunityID+" AND (ApprovedStatus = 'S')";
                    string strSQLOprStatus = "SELECT ApprovedStatus FROM tbl_RM_Opportunity INNER JOIN tbl_CNF_OpportunityStatus OS ON tbl_RM_Opportunity.StatusID = OS.OpportunityStatusID WHERE OpportunityID =" + OP_Parameters.OpportunityID;
                    var srtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    var srtOprStatus = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQLOprStatus, true, CommonController.connectionString));

                    if (srtResult == "1")
                    {
                        oP_SendForApprovalRevision.IsSendForApproval = true;
                    }
                    else
                    {
                        oP_SendForApprovalRevision.IsSendForApproval = false;
                    }
                    oP_SendForApprovalRevision.OprStatus = srtOprStatus;

                    return Request.CreateResponse(HttpStatusCode.OK, oP_SendForApprovalRevision);
            }
                else
                {
                return Request.CreateResponse(HttpStatusCode.OK, "Bad Request found");
            }

        }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage CheckForComments([FromBody] OP_SendForApprovalParams OP_Parameters)
        {
           
            try
            {
                OP_Activestatus OP_status = new OP_Activestatus();
                string comment = "";
                if (OP_Parameters != null)
                {
                    string activeStatus = GetInactiveActiveStauts(OP_Parameters);
                   // OP_status.Status = activeStatus;
                    if (activeStatus == "Active")
                    {
                        string strSQL = "usp_Whizible2_CheckApproverComment "+ OP_Parameters.OpportunityID;
                        var srtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                   
                        if (srtResult == "0")
                        {
                            string strSQL1 = "usp_Whizible2_Sel_tbl_RM_Opportunity_Comment " + OP_Parameters.OpportunityID + ", 'A'";
                            comment = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString));
                            return Request.CreateResponse(HttpStatusCode.OK, comment);
                        }
                        else if (srtResult == "2")
                        {
                            return Request.CreateResponse(HttpStatusCode.OK, "2");
                        }
                        else
                        {
                            return Request.CreateResponse(HttpStatusCode.OK, false);
                        }
                    }
                    else
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, activeStatus);
                    }
                    }
                else
                {
                return Request.CreateResponse(HttpStatusCode.OK, "Bad Request found");
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage CheckForSenderComments([FromBody] OP_SendForApprovalParams OP_Parameters)
        {
            try
            {
                if (OP_Parameters != null)
                {
                        string strSQL = "usp_Whizible2_Sel_tbl_RM_Opportunity_Comment " + OP_Parameters.OpportunityID + ", 'S'";
                        var comment = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        return Request.CreateResponse(HttpStatusCode.OK, comment);
                    
                }
                else
                {
                return Request.CreateResponse(HttpStatusCode.OK, "Bad Request found");
                }

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetStatusOfOpportunityRequest([FromBody] OP_SendForApprovalParams OP_Parameters)
        {
            try
            {
                if (OP_Parameters != null)
                {
                        string strSQL = "select ApprovedStatus from tbl_RM_Opportunity where OpportunityID = " + OP_Parameters.OpportunityID;
                        var status = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        return Request.CreateResponse(HttpStatusCode.OK, status.Trim());
                    
                }
                else
                {
                return Request.CreateResponse(HttpStatusCode.OK, "Bad Request found");
                }

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

     //   [HttpPost]
        private string GetInactiveActiveStauts(OpportunityRequest OP_Parameters)
        {
            string activeStatus = "";
            try
            {
               
                if (OP_Parameters != null)
                {
                    string strSQL = "usp_Whizible2_sel_ActiveInactiveStatus " + OP_Parameters.BusinessGroupID + ","+ OP_Parameters.LocationID + "," + OP_Parameters.ResourcePoolID + "," + OP_Parameters.GroupID;
                    activeStatus = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                }
                return activeStatus;
            }
            catch (Exception ex)
            {
                return null;
            }
           
        }
        #endregion
    }
}
