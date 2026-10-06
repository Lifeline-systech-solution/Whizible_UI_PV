using System;
using System.Collections.Generic;
using System.Data;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WhizibleAPI.Models.PM;

namespace WhizibleAPI.Controllers
{
    public class PM_QuantitativeObjectives_NewController : ApiController
    {
        [Authorize]
        [HttpPost]
        public object GetPMIID([FromBody] ProjectParameters Parameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_GetPMIID " + Parameters.ProjectID;
                int pmiID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "0"));
                
                return new { PMIID = pmiID };
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        public object GetPMIInformation([FromBody] PMIInformationParameters Parameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_PMI_Information " + Parameters.PMIID;
                if (Parameters.ProjectID.HasValue)
                {
                    strSQL += "," + Parameters.ProjectID.Value;
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

        [Authorize]
        [HttpPost]
        public object GetQuantitativeObjectives([FromBody] QuantitativeObjectivesParameters Parameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_PMI_Metric_ProjectValue " + Parameters.PMIID + "," + Parameters.ProjectID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize]
        [HttpPost]
        public object GetObjectiveValue([FromBody] QuantitativeObjectivesParameters Parameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_PMI_Information " + Parameters.PMIID + "," + Parameters.ProjectID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                
                if (dt.Rows.Count > 0)
                {
                    int metricID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dt.Rows[0]["MetricID"], "0"));
                    
                    strSQL = "EXEC usp_Whizible2_Sel_PMI_Metric_ProjectValue " + Parameters.PMIID + "," + Parameters.ProjectID + "," + metricID;
                    DataTable dtValue = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    
                    if (dtValue.Rows.Count > 0)
                    {
                        return new { Objective = CommonFunctions.Data.CheckIsDBNull(dtValue.Rows[0]["Objective"], "") };
                    }
                }
                return new { Objective = "" };
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize]
        [HttpPost]
        public object GetProjectType([FromBody] ProjectParameters Parameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_ProjectType 2," + Parameters.ProjectID;
                string result = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "").ToString();
                return new { ShowFlag = (result == "" ? 1 : 0) };
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize]
        [HttpPost]
        public object GetAvailableMetrics([FromBody] ProjectParameters Parameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_sel_tbl_PRS_MetricMaster_ForProject " + Parameters.ProjectID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize]
        [HttpPost]
        public object GetMetricProjectValue([FromBody] MetricProjectValueParameters Parameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_PMI_Metric_ProjectValue " + Parameters.PMIID + "," + Parameters.ProjectID + "," + Parameters.MetricID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize]
        [HttpPost]
        public object GetMetricProjectValueForGrid([FromBody] MetricProjectValueForGridParameters Parameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_PMI_Metric_ProjectValue_ForGrid " + Parameters.ProjectID + "," + Parameters.MetricID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize]
        [HttpPost]
        public object SaveQuantitativeObjectives([FromBody] SaveQuantitativeObjectivesParameters Parameters)
        {
            try
            {
                string strSQL = "";
                
                // Save revisions if data exists
                if (!string.IsNullOrEmpty(Parameters.Data))
                {
                    strSQL = "EXEC usp_Whizible2_Ins_Save_Revisions 2," + Parameters.ProjectID;
                    strSQL += ",'" + CommonFunctions.General.BuildQueryString(Parameters.UserName) + "'";
                    strSQL += ",'" + CommonFunctions.General.BuildQueryString(Parameters.Data) + "'";
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                }

                // Save objectives
                foreach (var objective in Parameters.Objectives)
                {
                    strSQL = "EXEC usp_Whizible2_ins_Quantitative_Objectives_NewMetric " + Parameters.PMIID + "," + Parameters.ProjectID;
                    strSQL += "," + objective.MetricID + "," + objective.Norms;
                    strSQL += ",'" + CommonFunctions.General.BuildQueryString(Parameters.Objective) + "'";
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                }

                return new { Success = true, Message = "Objectives saved successfully" };
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize]
        [HttpPost]
        public object AddMetricsToProject([FromBody] AddMetricsParameters Parameters)
        {
            try
            {
                string strSQL = "";
                
                foreach (int metricID in Parameters.MetricIDs)
                {
                    strSQL = "EXEC usp_Whizible2_ins_tbl_PRS_Quantitative_Objectives_AddMetric " + Parameters.ProjectID + "," + metricID;
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                }

                return new { Success = true, Message = "Metrics added successfully" };
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize]
        [HttpPost]
        public object SaveTargetValue([FromBody] SaveTargetValueParameters Parameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_ins_Quantitative_Objectives_NewMetric " + Parameters.PMIID + "," + Parameters.ProjectID + "," + Parameters.MetricID + "," + Parameters.ProjectValue + ",'" + CommonFunctions.General.BuildQueryString(Parameters.Description) + "'";
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return new { Success = true, Message = "Target value saved successfully" };
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize]
        [HttpPost]
        public object SaveStrategy([FromBody] SaveStrategyParameters Parameters)
        {
            string strSQL = "";
            try
            {
                // Use the correct SP format: PMIID, ProjectID, MetricID, ProjectValue, Description
                // For strategy: MetricID = 0, ProjectValue = 0, Description = strategy text
                strSQL = "EXEC usp_Whizible2_ins_Quantitative_Objectives_NewMetric " + Parameters.PMIID + "," + Parameters.ProjectID + ",0,0,'" + CommonFunctions.General.BuildQueryString(Parameters.Objective) + "'";
                
                // Debug: Log the SQL being executed
                System.Diagnostics.Debug.WriteLine("Executing SQL: " + strSQL);
                
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return new { Success = true, Message = "Strategy saved successfully", SQL = strSQL };
            }
            catch (Exception ex)
            {
                return new { Success = false, Message = "Error saving strategy: " + ex.Message, SQL = strSQL };
            }
        }

    }
}