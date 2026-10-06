using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Extensions;
using WhizibleAPI.Models.RM;
namespace WhizibleAPI.Controllers
{
    [Authorize]
    public class RM_GlobalResourcePoolController : ApiController
    {

        ////Added by imran on 19-08-2022 
        [Authorize, App_Start.ValidateHeaders]   
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetGlobalResourcePool([FromBody] GRPFilterParameter GrpFilterParameter)
        {
            
            try
            {
                var managerGroupList = new List<RM_GlobalResource>();
                string filterParms = "";

                if (GrpFilterParameter != null && GrpFilterParameter.GRPWhereClause != null && !string.IsNullOrEmpty(GrpFilterParameter.GRPWhereClause))
                {
                   // filterParms = GrpFilterParameter.GRPWhereClause;// HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");// DecodeWhereClause(BgFilterParameter.BGWhereClause);///HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                    filterParms = HttpUtility.UrlDecode(GrpFilterParameter.GRPWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");
                }
                else
                {
                    filterParms = null;
                }

                //string strSql = "SELECT BusinessGroup,BusinessGroupID,BusinessGroupCode,tbl_CNF_BusinessGroups.ManagerID,tbl_CNF_BusinessGroups.ModifiedBy,tbl_CNF_BusinessGroups.Active FROM tbl_CNF_BusinessGroups WITH (NOLOCK) WHERE 1=1 order by BusinessGroupCode ";
                //DataTable BusinessgroupsTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_BG_BusinessGroups", true, CommonController.connectionString);
                string strSQL = "";
                if (filterParms != null)
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_PM_GlobalResourcePool '" + filterParms + "'";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_PM_GlobalResourcePool";
                }


                DataTable GRPTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (GRPTable != null)
                {
                    managerGroupList = GRPTable.ToList<RM_GlobalResource>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, managerGroupList);
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
        public HttpResponseMessage GetGlobalResourcePoolManager([FromBody]GRP_Params grpParameter)
        {
            try
            {
                var ManagerList = new List<RM_GlobalResourcePoolManagerList>();
                DataTable ManagerTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_sel_tbl_PM_GlobalResourcePool_Managers " + grpParameter.GlobalResourcePoolID, true, CommonController.connectionString);
                if (ManagerTable != null)
                {
                    ManagerList = ManagerTable.ToList<RM_GlobalResourcePoolManagerList>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, ManagerList);
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
        public HttpResponseMessage SaveGRPManagerDetails([FromBody] RM_GlobalResourcePoolManager ManagerParameters)
        {
            
            try
            {
                string strtResult = string.Empty;
                if (ManagerParameters != null)
                {
                    string strSQL = "Exec usp_Whizible2_InsUpd_tbl_PM_GlobalResourcePoolManager " + ManagerParameters.UniqueID + "," + ManagerParameters.GlobalResourcePoolID + "," + ManagerParameters.ManagerID + " ," + ManagerParameters.NewManagerID + ",'" + ManagerParameters.IsPrimaryResponsible + "'";
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

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteGRPManager([FromBody] string ManagerParameters)
        {
            try
            {
                if (ManagerParameters != null)
                {
                    string Result = "";
                    var splitParmas = ManagerParameters.Split(',').ToList();
                    foreach (var itemUniqueID in splitParmas)
                    {
                        string strSQL = "Exec usp_Whizible2_Del_tbl_PM_GlobalResourcePool_Managers '" + itemUniqueID + "'";
                        //CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                        var strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        if (Result != "Deleted")
                        {
                            Result += strResult;
                        }
                    }
                    return Request.CreateResponse(HttpStatusCode.OK, Result);
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }
        
        
        [HttpPost]
        public HttpResponseMessage GetGResourceRoleGraph()
        {
          
            try
            {
                var GrpRolesGraphList = new List<RM_GlobalResourcePoolGraph>();
                DataTable GraphTable = CommonFunctions.Data.GetDataTable("Exec usp_Whizible2_Sel_tbl_PM_Employee_Global_Role_Graph ", true, CommonController.connectionString);
                if (GraphTable != null && GraphTable.Rows.Count > 0)
                {
                    //long TotalCount = Convert.ToInt32(GraphTable.Compute("SUM(Role Count)", 0));// GraphTable.Rows.Count;

                    decimal totalCount = Convert.ToDecimal(GraphTable.Compute("Sum(RoleCount)", "RoleCount > 0"));
                    var GRP_RolesGraph = new RM_GlobalResourcePoolGraph();
                    GRP_RolesGraph.LstLabel = new List<string>();
                    GRP_RolesGraph.LstColor = new List<string>();
                    GRP_RolesGraph.LstData = new List<int>();
                    foreach (DataRow bgGraphRow in GraphTable.Rows)
                    {
                        var count = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(bgGraphRow["RoleCount"], "0"));
                        decimal perc = count > 0 ? (count * 100) / totalCount : 0;
                        string roleDec = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(bgGraphRow["RoleDescription"], ""));
                        string RoleDecPerce= string.Concat(roleDec, "(" , perc.ToString("0.00")+"%", ")");
                        GRP_RolesGraph.LstLabel.Add(RoleDecPerce);
                        GRP_RolesGraph.LstData.Add(count);
                        GRP_RolesGraph.LstColor.Add(GetGRPRoleColor());
                    }

                    GrpRolesGraphList.Add(GRP_RolesGraph);
                }
                return Request.CreateResponse(HttpStatusCode.OK, GrpRolesGraphList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
          
        }
        
        [HttpPost]
        public HttpResponseMessage GetMaximumItemsToShowInList()
        {
           
            try
            {
                string strSql = "";
                int value;
                strSql = "SELECT MaximumItemsToShowInList  FROM tbl_PM_CompanyInformation";
                value = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSql, true, CommonController.connectionString));

                return Request.CreateResponse(HttpStatusCode.OK, value);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            
        }

        #region Private method
        private string GetGRPRoleColor()
        {
            var RandomBgGraph = new Random();
            Thread.Sleep(20);
            var ColorGRPGraph = $"#{RandomBgGraph.Next(8, 0xFFFFFF):X6}";
            return ColorGRPGraph;
        }
        #endregion
    }
}
