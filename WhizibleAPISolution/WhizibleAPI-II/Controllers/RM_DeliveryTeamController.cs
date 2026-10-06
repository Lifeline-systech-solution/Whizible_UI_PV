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
    public class RM_DeliveryTeamController : ApiController
    {

        //Added by imran on 19-08-2022  
        [Authorize, App_Start.ValidateHeaders] 
        ////End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetDeliveryTeam([FromBody] DTFilterParameter dTFilterParameter)
        {
            var DUGroupList = new List<RM_DeliveryTeam>();
            string filterParms = "";
            try
            {
                if (dTFilterParameter != null && dTFilterParameter.DTWhereClause != null && !string.IsNullOrEmpty(dTFilterParameter.DTWhereClause))
                {
                   // filterParms = dTFilterParameter.DTWhereClause;// HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");// DecodeWhereClause(BgFilterParameter.BGWhereClause);///HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                    filterParms = HttpUtility.UrlDecode(dTFilterParameter.DTWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");
                }
                else
                {
                    filterParms = null;
                }
                string strSql = "";
                if (filterParms != null)
                {
                    dTFilterParameter.IsFromDTHead = true;
                    // strSql = "Exec usp_Whizible2_sel_v_tbl_PM_GroupMaster " + dTFilterParameter.ResourceHeadID + " , '" + filterParms + "'";
                    strSql = "Exec usp_Whizible2_sel_v_tbl_PM_GroupMaster " + dTFilterParameter.ResourceHeadID + " ,'" + filterParms + "','"+ dTFilterParameter .IsFromDTHead+ "'";
                    
                }
                else
                {
                    strSql = "Exec usp_Whizible2_sel_v_tbl_PM_GroupMaster " + dTFilterParameter.ResourceHeadID + "";
                }

                DataTable DUTable = CommonFunctions.Data.GetDataTable(strSql, true, CommonController.connectionString);

                if (DUTable != null)
                {
                    DUGroupList = DUTable.ToList<RM_DeliveryTeam>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, DUGroupList);
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
        public HttpResponseMessage GetDeliveryTeamResouceData([FromBody] RM_DT_Resouces rM_DT)
        {
            List<RM_DT_Resouces> ResourcerList = new List<RM_DT_Resouces>();
            try
            {
                string strSQL = "Exec usp_Whizible2_sel_h_tbl_PM_Employee " + rM_DT.GroupID + "," + rM_DT.RoleID + "";
                DataTable DTResource = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (DTResource != null)
                {
                    ResourcerList = DTResource.ToList<RM_DT_Resouces>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, ResourcerList);

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        
        [HttpPost]
        public HttpResponseMessage GetDeliveryTeamResoucePoolGraph([FromBody] DTparams teamResourcePoolGraph)
        {
            var GraphList = new List<RM_DeliveryTeamResourcePoolGraph>();
            try
            {
                if (teamResourcePoolGraph != null && teamResourcePoolGraph.GroupID > 0)
                {
                    DataTable GraphTable = CommonFunctions.Data.GetDataTable("Exec usp_Whizible2_Sel_tbl_PM_Employee_Team_Role_Graph " + teamResourcePoolGraph.GroupID + "", true, CommonController.connectionString);
                    if (GraphTable != null && GraphTable.Rows.Count > 0)
                    {
                        decimal totalCount = Convert.ToDecimal(GraphTable.Compute("Sum(RoleCount)", "RoleCount > 0"));
                       
                        var DU_RolesGraph = new RM_DeliveryTeamResourcePoolGraph();
                        DU_RolesGraph.LstLabel = new List<string>();
                        DU_RolesGraph.LstColor = new List<string>();
                        DU_RolesGraph.LstData = new List<int>();
                        foreach (DataRow bgGraphRow in GraphTable.Rows)
                        {
                            var count = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(bgGraphRow["RoleCount"], "0"));
                            decimal perc = count > 0 ? (count * 100) / totalCount : 0;
                            string roleDec = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(bgGraphRow["RoleDescription"], ""));
                            string RoleDecPerce = string.Concat(roleDec, "(", perc.ToString("0.00") + "%", ")");
                            DU_RolesGraph.LstLabel.Add(RoleDecPerce);
                            DU_RolesGraph.LstData.Add(count);
                            DU_RolesGraph.LstColor.Add(GetDURoleColor());
                        }

                        GraphList.Add(DU_RolesGraph);
                    }
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, GraphList);
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
        public HttpResponseMessage GetById([FromBody] DTparams param)
        {
            var List = new RM_DeliveryTeamHead();
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_DT_TeamHead " + param.GroupID + "";
                var Table = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                if (Table != null)
                {
                    List.EmployeeID = Convert.ToInt32(Table);
                }
                return Request.CreateResponse(HttpStatusCode.OK, List);
            }

            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        #region Private method
        private string GetDURoleColor()
        {
            var RandomBgGraph = new Random();
            Thread.Sleep(20);
            var ColorGRPGraph = $"#{RandomBgGraph.Next(8, 0xFFFFFF):X6}";
            return ColorGRPGraph;
        }
        #endregion
    }
}
