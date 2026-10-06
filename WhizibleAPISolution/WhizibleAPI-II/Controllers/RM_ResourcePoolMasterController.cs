using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Extensions;
using WhizibleAPI.Models.RM;

namespace WhizibleAPI.Controllers
{

    [Authorize]
    public class RM_ResourcePoolMasterController : ApiController
    {
        ////Added by imran on 19-08-2022 
        [Authorize, App_Start.ValidateHeaders] 
        //End of comment by imran on 19-08-2022 
        [HttpPost]
        public HttpResponseMessage GetResourcePool([FromBody] RM_ResourcePoolMaster OP_Parameters)
        {
           
            try
            {
                var RPMList = new List<RM_ResourcePoolMaster>();
                DataTable ResourcePoolTable = CommonFunctions.Data.GetDataTable("Exec usp_Whizible2_sel_v_tbl_PM_ResourcePoolMaster " + "'" + OP_Parameters.CreatedBy + "'" + "," +OP_Parameters.EmployeeID, true, CommonController.connectionString);
                if (ResourcePoolTable != null)
                {
                    //    GroupList = ResourcePoolTable.ToList<RM_ResourcePoolMaster>();

                    foreach (DataRow taskListRow in ResourcePoolTable.Rows)
                    {
                        RM_ResourcePoolMaster objRPM = new RM_ResourcePoolMaster();


                        objRPM.ResourcePoolID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["ResourcePoolID"], ""));
                        objRPM.Description = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Description"], ""));
                        objRPM.ResourcePoolCode = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ResourcePoolCode"], ""));
                        objRPM.OtherAttribute = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["OtherAttribute"], ""));
                        objRPM.ResourcePoolName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ResourcePoolName"], ""));
                        var strSQLProb = "usp_Whizible2_sel_tbl_PM_ResourcePoolSkillsSelected " + objRPM.ResourcePoolID;
                        DataTable drQueryProb = CommonFunctions.Data.GetDataTable(strSQLProb, true, CommonController.connectionString);
                        if (drQueryProb != null)
                        {
                            string ToolID = "";
                            List<string> lstToolIDs = new List<string>();
                            foreach (DataRow taskListRowItem in drQueryProb.Rows)
                            {
                                ToolID = Convert.ToString(taskListRowItem["ToolID"]);
                                lstToolIDs.Add(ToolID);
                            }

                            objRPM.SkillIds = string.Join(",", lstToolIDs);
                        }

                        RPMList.Add(objRPM);
                    }
                }
                return Request.CreateResponse(HttpStatusCode.OK, RPMList);
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
        public HttpResponseMessage SaveResourcePoolMaster([FromBody] RM_ResourcePoolMaster OP_Parameters)
        {
            try
            {
                if (OP_Parameters != null)
                {

                    string strSQL = "EXEC Usp_Whizible2_Ins_tbl_PM_ResourcePoolMaster " + "'" + OP_Parameters.ResourcePoolCode + "'" + ",'" + OP_Parameters.ResourcePoolName  +  "','" + OP_Parameters.Description + "','" + OP_Parameters.OtherAttribute + "','" + OP_Parameters.CreatedBy + "'";
                   

                    //int Result = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
                    //if (Result > 0)
                    //{
                    //    return Request.CreateResponse(HttpStatusCode.OK, "Success");
                    //}
                    //else
                    //{
                    //    return Request.CreateResponse(HttpStatusCode.OK, "Failed");
                    //}

                    var strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    
                       return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    
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
        public HttpResponseMessage UpdateResourcePoolMaster([FromBody] RM_ResourcePoolMaster OP_Parameters)
        {
            try
            {
                if (OP_Parameters != null)
                {
                    string strSQL = "EXEC Usp_Whizible2_Upd_tbl_PM_ResourcePoolMaster " + OP_Parameters.ResourcePoolID + ",'" + OP_Parameters.ResourcePoolCode + "'" + ",'" + OP_Parameters.ResourcePoolName + "','" + OP_Parameters.Description + "','" + OP_Parameters.OtherAttribute + "','" + OP_Parameters.CreatedBy + "','" + OP_Parameters.SkillIds + ",'";

                    var strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    
                       return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    //if (Result > 0)
                    //{
                    //    return Request.CreateResponse(HttpStatusCode.OK, "Success");
                    //}
                    //else
                    //{
                    //    return Request.CreateResponse(HttpStatusCode.OK, "Failed");
                    //}
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.OK,  "Bad Request found");
                    
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
        public HttpResponseMessage DeleteResourcePoolMaster([FromBody] string Parameters)
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
                        string strSQL = "Exec usp_Whizible2_Del_tbl_PM_ResourcePoolMaster '" + itemUniqueID + "'";
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
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetRPMResources(RPM_Params RPM_ResourceParameters)
        {
            
            try
            {
                var RPM_ResourceList = new List<RPM_Resource>();
                string strSQL = "";
                // if (RPM_ResourceParameters != null && RPM_ResourceParameters.ResourcePoolID > 0 && RPM_ResourceParameters.RoleID > 0)
                if (RPM_ResourceParameters != null && RPM_ResourceParameters.ResourcePoolID >0)
                {
                    if (RPM_ResourceParameters.WhereClause != null && RPM_ResourceParameters.WhereClause!="")
                    {
                        strSQL = "Exec usp_Whizible2_Sel_GetRPMResources " + RPM_ResourceParameters.ResourcePoolID + ",'" + RPM_ResourceParameters.WhereClause + "'";
                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_Sel_GetRPMResources " + RPM_ResourceParameters.ResourcePoolID;
                    }
                   
                    // string strSQL = "SELECT v_tbl_PM_ResourcePoolDetail.ResourcePoolDetailID,v_tbl_PM_ResourcePoolDetail.EmployeeID,v_tbl_PM_ResourcePoolDetail.BusinessGroup,v_tbl_PM_ResourcePoolDetail.Location,v_tbl_PM_ResourcePoolDetail.BusinessGroupID,v_tbl_PM_ResourcePoolDetail.LocationID,v_tbl_PM_ResourcePoolDetail.IsResourceActive,v_tbl_PM_ResourcePoolDetail.ResourcePoolID,v_tbl_PM_ResourcePoolDetail.EmployeeName,v_tbl_PM_ResourcePoolDetail.ResourcePoolName,v_tbl_PM_ResourcePoolDetail.RoleDescription,v_tbl_PM_ResourcePoolDetail.EmailID,v_tbl_PM_ResourcePoolDetail.ReportingTo,'Resume' AS [Hyperlink1] FROM v_tbl_PM_ResourcePoolDetail WITH (NOLOCK) WHERE ResourcePoolID= " + RPM_ResourceParameters.ResourcePoolID;
                    DataTable RPM_ResourceTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (RPM_ResourceTable != null)
                        RPM_ResourceList = RPM_ResourceTable.ToList<RPM_Resource>();
                  //  return Request.CreateResponse(HttpStatusCode.OK, RPM_ResourceList);
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }

                return Request.CreateResponse(HttpStatusCode.OK, RPM_ResourceList);
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
        public HttpResponseMessage GetResourcePoolForLocation([FromBody] RPM_BG RPMLocationParam)
        {


            try
            {
                List<OP_ResourcePoolLocation> ResourcePoolLocationList = new List<OP_ResourcePoolLocation>();
                var strSQL = "usp_Whizible2_Sel_GetResourcePoolForLocation " + RPMLocationParam.LocationID + ", 0";

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
        public HttpResponseMessage GetDeliveryTeam([FromBody] RPM_BG RPMLocationParam)
        {

            
            try
            {
                List<OP_DeliveryTeam> DeliveryTeamList = new List<OP_DeliveryTeam>();
                var strSQL = "usp_Whizible2_sel_GetDeliveryTeam " + RPMLocationParam.LocationID + ", 0";

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
        public HttpResponseMessage GetBusinessGroupsLocation([FromBody] RPM_BG RPMParameters)
        {

            
            try
            {
                List<OP_BusinessGroupLocation> BusinessGroupsLocationList = new List<OP_BusinessGroupLocation>();
                var strSQL = "usp_Whizible2_Sel_GetBusinessGroupsForLocation " + RPMParameters.BusinessGroupID + ", NULL, 0";

                DataTable BusinessGroupsLocationTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (BusinessGroupsLocationTable != null && BusinessGroupsLocationTable.Rows.Count>0)
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
        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022/// <returns></returns>

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
        public HttpResponseMessage GetRPMManagers(RPM_Params RPM_MangerParameter)
        {
           
            try
            {
                var ManagerList = new List<RPM_Manager>();
                if (RPM_MangerParameter.ResourcePoolID > 0)
                {
                    string strSQL = "usp_Whizible2_Sel_GetRPMManagers " + RPM_MangerParameter.ResourcePoolID;
                    DataTable ManagerTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (ManagerTable != null)
                        ManagerList = ManagerTable.ToList<RPM_Manager>();

                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
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
        public HttpResponseMessage GetResourceCount(RPM_Params pM_Params)
        {
           
            try
            {
                string strSql = "";
                int value = 0;
                if (pM_Params.ResourcePoolID > 0)
                {
                    strSql = "SELECT COUNT(1) FROM v_tbl_PM_ResourcePoolDetail WITH(NOLOCK)  WHERE 1 = 1  AND ResourcePoolID =" + pM_Params.ResourcePoolID;
                    value = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSql, true, CommonController.connectionString));
                }
                return Request.CreateResponse(HttpStatusCode.OK, value);
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
        public HttpResponseMessage GetResourcesForSelection([FromBody] RPM_ShowSelected Op_parameters)
        {
          
            try
            {
                var resourceList = new List<RPM_ResourceSelection>();
                string strSQL = "";
                List<int> EmpIdsList = new List<int>();
                //if (Op_parameters.ResourcePoolID > 0 && Op_parameters.IsShowSelected == true)
                //{
                //    string strSQLSel = "SELECT* FROM v_tbl_PM_EmployeeHistory_Skills WHERE 1 = 1  AND EmployeeID IN(SELECT EmployeeID FROM tbl_PM_ResourcePoolDetail WHERE ResourcePoolID = " + Op_parameters.ResourcePoolID + ")";
                //    DataTable resourceTableSel = CommonFunctions.Data.GetDataTable(strSQLSel, true, CommonController.connectionString);
                //    if (resourceTableSel != null)
                //        resourceList = resourceTableSel.ToList<RPM_ResourceSelection>();
                //}
                //else
                //{
                if (Op_parameters != null && !string.IsNullOrEmpty(Op_parameters.WhereClause))
                {
                    string[] fields = Op_parameters.WhereClause.Split('|');
                   //if(fields[0]=="") { fields[0] = null;}
                   // if(fields[1] == " ") { fields[1] = null;}
                   if(!string.IsNullOrWhiteSpace(fields[0]) && !string.IsNullOrWhiteSpace(fields[1]))
                    {
                        strSQL = "Exec usp_Whizible2_Sel_GetResourcesFilter '" + fields[0] + "','" + fields[1] + "'";
                    }
                    if (!string.IsNullOrWhiteSpace(fields[0]) && string.IsNullOrWhiteSpace(fields[1]))
                    {
                        strSQL = "Exec usp_Whizible2_Sel_GetResourcesFilter '" + fields[0] + "',NULL";
                    }
                    if (string.IsNullOrWhiteSpace(fields[0]) && !string.IsNullOrWhiteSpace(fields[1]))
                    {
                        strSQL = "Exec usp_Whizible2_Sel_GetResourcesFilter NULL,'" + fields[1] + "'";
                    }
                    if (string.IsNullOrWhiteSpace(fields[0]) && string.IsNullOrWhiteSpace(fields[1]))
                    {
                        strSQL = "Exec usp_Whizible2_Sel_GetResourcesFilter";
                    }


                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Sel_GetResourcesFilter";
                }
                 
                    DataTable resourceTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (resourceTable != null)
                    {
                        resourceList = resourceTable.ToList<RPM_ResourceSelection>();
                    }
                    IDataReader drQuery;
                    string strSQLEmp = "usp_Whizible2_Sel_GetResourcesForSelection " + Op_parameters.ResourcePoolID;
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
                // }
                return Request.CreateResponse(HttpStatusCode.OK, new { resourcesList = resourceList, EmpIds = EmpIdsList });
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
        public HttpResponseMessage GetManagersCount(RPM_Params mgr_Params)
        {
         
            try
            {
                string strSql = "";
                int value = 0;
                if (mgr_Params.ResourcePoolID > 0)
                {
                    strSql = "SELECT COUNT(1) FROM v_tbl_PM_ResourcePoolManagers WITH(NOLOCK)  WHERE 1 = 1  AND ResourcePoolID= " + mgr_Params.ResourcePoolID;
                    value = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSql, true, CommonController.connectionString));
                }
                return Request.CreateResponse(HttpStatusCode.OK, value);

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
        public HttpResponseMessage GetSelectionResourceDemand([FromBody] RPM_ShowSelected Op_parameters)
        {
          
            try
            {
                var RPM_ResourceList = new List<RPM_ManagerSelection>();
                List<int> EmpIdsList = new List<int>();
                string filterParms = "";
                if (Op_parameters != null && Op_parameters.WhereClause != null && !string.IsNullOrEmpty(Op_parameters.WhereClause))
                    {
                        filterParms = Op_parameters.WhereClause;// HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");// DecodeWhereClause(BgFilterParameter.BGWhereClause);///HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";

                    }
                    else
                    {
                        filterParms = null;
                    }
                string strSQL = "";
                if (filterParms != null)
                {
                    strSQL = "Exec usp_Whizible2_V_tbl_PM_Resource_Selection_ResourceDemand '" + filterParms + "'";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_V_tbl_PM_Resource_Selection_ResourceDemand";
                }
                DataTable resourceTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                        if (resourceTable != null)
                        {
                            RPM_ResourceList = resourceTable.ToList<RPM_ManagerSelection>();
                        }
                 
                
                IDataReader drQuery;
                string strSQLEmp = "usp_Whizible2_Sel_GetManagersForSelection " + Op_parameters.ResourcePoolID;
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
                //string strSQL = "SELECT V_tbl_PM_Resource_Selection_ResourceDemand.LocationID,V_tbl_PM_Resource_Selection_ResourceDemand.DesignationID,V_tbl_PM_Resource_Selection_ResourceDemand.BusinessGroupID,V_tbl_PM_Resource_Selection_ResourceDemand.DepartmentID,V_tbl_PM_Resource_Selection_ResourceDemand.RoleId,V_tbl_PM_Resource_Selection_ResourceDemand.EmployeeID,V_tbl_PM_Resource_Selection_ResourceDemand.UserName,V_tbl_PM_Resource_Selection_ResourceDemand.EmployeeName,V_tbl_PM_Resource_Selection_ResourceDemand.Department,V_tbl_PM_Resource_Selection_ResourceDemand.BusinessGroup,V_tbl_PM_Resource_Selection_ResourceDemand.Location,V_tbl_PM_Resource_Selection_ResourceDemand.RoleDescription,V_tbl_PM_Resource_Selection_ResourceDemand.DesignationName,V_tbl_PM_Resource_Selection_ResourceDemand.JoiningDate,V_tbl_PM_Resource_Selection_ResourceDemand.Address,V_tbl_PM_Resource_Selection_ResourceDemand.Phone FROM V_tbl_PM_Resource_Selection_ResourceDemand WITH (NOLOCK) WHERE 1=1";
                //DataTable RPM_ResourceTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                //if (RPM_ResourceTable != null) {

                //    foreach (DataRow taskListRow in RPM_ResourceTable.Rows)
                //    {
                //       // RPM_Manager objRPM = new RPM_Manager();
                //        RPM_ResourceList = RPM_ResourceTable.ToList<RPM_ManagerSelection>();                        
                //    }
                //}
                //else
                //{
                //    return Request.CreateResponse(HttpStatusCode.BadRequest);
                //}
                //    return Request.CreateResponse(HttpStatusCode.OK, RPM_ResourceList);

                return Request.CreateResponse(HttpStatusCode.OK, new { resourcesList = RPM_ResourceList, EmpIds = EmpIdsList });
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
        public HttpResponseMessage DeleteResourcePoolDetail([FromBody] string Parameters)
        {
            try
            {
                if (Parameters != null)
                {
                    string Result = "";
                    var splitParmas = Parameters.Split(',').ToList();
                    foreach (var itemUniqueID in splitParmas)
                    {
                        string strSQL = "usp_Whizible2_Del_tbl_PM_ResourcePoolDetail " + itemUniqueID;
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteManagersDetail([FromBody] string Parameters)
        {
            try
            {
                if (Parameters != null)
                {
                    string Result = "";
                    var splitParmas = Parameters.Split(',').ToList();
                    foreach (var itemUniqueID in splitParmas)
                    {
                        string strSQL = "usp_Whizible2_Del_tbl_PM_ResourcePoolManagers " + itemUniqueID;
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

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SaveSelectedResource([FromBody]RPM_SelectedResource OP_Parameters)
        {
            try
            {
                string strSQL = "";
                string strResult = "";
                if (OP_Parameters != null)
                {

                    string strSQLDel = "Exec usp_Whizible2_Del_GetResourcesMangerDelete " + OP_Parameters.ResourcePoolID + ",'" + OP_Parameters.From + "'";
                    string strResultDel = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQLDel, true, CommonController.connectionString));

                    string[] arrEmployeeList = OP_Parameters.EmployeeID.Split(',');
                    foreach (var item in arrEmployeeList)
                    {
                        strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ResourceManagerPool " + OP_Parameters.ResourcePoolID+"," + item + "," + "'" + OP_Parameters.From + "'";
                        strResult += Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                    }
                    return Request.CreateResponse(HttpStatusCode.OK, strResult);
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
    }
}