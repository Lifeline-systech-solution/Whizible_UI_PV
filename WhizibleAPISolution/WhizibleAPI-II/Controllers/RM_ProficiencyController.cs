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
    public class RM_ProficiencyController : ApiController
    {

        ////Added by imran on 19-08-2022 
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022  
        [HttpPost]        
        public HttpResponseMessage GetProficiency([FromBody] PROFilterParameter filterParameter)
        {
            
            try
            {
                List<RM_Proficiency> listProficiency = new List<RM_Proficiency>();
                string filterParms = "";
                if (filterParameter != null && filterParameter.ProWhereClause != null && !string.IsNullOrEmpty(filterParameter.ProWhereClause))
                {
                    //filterParms = filterParameter.ProWhereClause;// HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");// DecodeWhereClause(BgFilterParameter.BGWhereClause);///HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                    filterParms = HttpUtility.UrlDecode(filterParameter.ProWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");

                }
                else
                {
                    filterParms = null;
                }
                string strSQL = "";
                if (filterParms != null)
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_HR_Parameters_phaseII '" + filterParms + "'";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_HR_Parameters_phaseII";
                }


                DataTable VisaTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (VisaTable != null)
                {
                   
                    foreach(DataRow item in VisaTable.Rows)
                    {
                        RM_Proficiency objProficiency = new RM_Proficiency()
                        {
                            ParameterID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["ParameterID"], "0")),
                            ParameterGroupID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["ParameterGroupID"], "0")),
                            ParameterValue= Convert.ToString(CommonFunctions.Data.CheckIsDBNull(item["ParameterValue"], "")),
                            ParameterDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(item["ParameterDescription"], "")),
                            OrderNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["OrderNumber"], "")),
                        };

                        listProficiency.Add(objProficiency);
                    }
                   

                }
                return Request.CreateResponse(HttpStatusCode.OK, listProficiency);
            }
            catch (Exception ex)
            {
                 return Request.CreateErrorResponse(HttpStatusCode.InternalServerError,"Bad Request found");
            }
            
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SaveProficiencyDetails([FromBody] RM_Proficiency rM_Proficiency)
        {
            
            try
            {
                string strtResult = string.Empty;
                string strSQL;
                if (rM_Proficiency != null)
                {
                    if (rM_Proficiency.ParameterID>0)
                    {
                        strSQL = "Exec usp_Whizible2_Upd_tbl_HR_Parameters " + rM_Proficiency.ParameterID + "," + rM_Proficiency.ParameterGroupID + ",'" + rM_Proficiency.ParameterValue + "', '" + rM_Proficiency.ParameterDescription + "'," + rM_Proficiency.OrderNumber + ",'" + rM_Proficiency.CreatedBy + "'";
                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_Ins_tbl_HR_Parameters " + rM_Proficiency.ParameterID + "," + rM_Proficiency.ParameterGroupID + ",'" + rM_Proficiency.ParameterValue + "', '" + rM_Proficiency.ParameterDescription + "'," + rM_Proficiency.OrderNumber + ",'" + rM_Proficiency.CreatedBy + "'";
                    }
                     
                    //int Result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
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
                 return Request.CreateErrorResponse(HttpStatusCode.InternalServerError,"Bad Request found");
            }
            
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteProficiencyDetails([FromBody] string Parameters)
        {
            try
            {
                string strResult = "";
                int delete = 0;
                int notDelete = 0;
                if (Parameters != null)
                {                  
                    var splitParmas = Parameters.Split(',').ToList();
                    foreach (var itemUniqueID in splitParmas)
                    {
                        string strSQL = "Exec usp_Whizible2_Del_tbl_HR_Parameters '" + itemUniqueID + "'";                      
                        strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        if (strResult == "deleted")
                        {
                            delete++;
                        }
                        else
                        {
                            notDelete++;
                        }
                    }
                    return Request.CreateResponse(HttpStatusCode.OK, new { deletedCount = delete, notDeletedCount = notDelete });
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
            }
            catch (Exception ex)
            {
                 return Request.CreateErrorResponse(HttpStatusCode.InternalServerError,"Bad Request found");
            }

        }


    }
}

