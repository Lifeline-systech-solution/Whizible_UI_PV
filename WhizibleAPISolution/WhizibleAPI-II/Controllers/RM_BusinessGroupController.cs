using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Extensions;
using WhizibleAPI.Models.RBG;

namespace WhizibleAPI.Controllers
{
    [Authorize] 
    public class RM_BusinessGroupController : ApiController
    {

        ////Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]   
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetBusinessGroups([FromBody] BGFilterParameter BgFilterParameter)
        {
            var BusinessGroupList = new List<BG_BusinessGroup>();
            string filterParms = "";
            try
            {
                if (BgFilterParameter != null && BgFilterParameter.BGWhereClause != null && !string.IsNullOrEmpty(BgFilterParameter.BGWhereClause))
                {
                    //  filterParms = BgFilterParameter.BGWhereClause;// HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");// DecodeWhereClause(BgFilterParameter.BGWhereClause);///HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                    filterParms = HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");
                    string strSQL = "";
                    if (filterParms != null && !string.IsNullOrEmpty(filterParms))
                    {
                        strSQL = "Exec usp_Whizible2_sel_tbl_BG_BusinessGroups '" + filterParms + "'";
                        DataTable BusinessgroupsTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                        if (BusinessgroupsTable != null)
                        {
                            BusinessGroupList = BusinessgroupsTable.ToList<BG_BusinessGroup>();
                        }
                    }

                }
                return Request.CreateResponse(HttpStatusCode.OK, BusinessGroupList);
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
        public HttpResponseMessage GetBGOrganizationUnit([FromBody]BG_Params BgOuParameter)
        {
            var BgOrganizationUnitList = new List<BG_OrganizationUnit>();
            try
            {
                if (BgOuParameter.BusinessGroupID > 0)
                {
                    //usp_Whizible2_Sel_tbl_BG_v_tbl_CNF_BusinessGroup_OUPools_OrgUnits
                    string strSQL = "Exec usp_Whizible2_Sel_tbl_BG_v_tbl_CNF_BusinessGroup_OUPools_OrgUnits " + BgOuParameter.BusinessGroupID + "";
                    DataTable BgOrganizationUnitListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (BgOrganizationUnitListTable != null)
                    {
                        BgOrganizationUnitList = BgOrganizationUnitListTable.ToList<BG_OrganizationUnit>();
                    }
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, BgOrganizationUnitList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            
        }

        #region Business manager :API call 

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetBGManagers([FromBody] BG_Params BgMangerParameter)
        {
            var BgManagerList = new List<BG_Manager>();
            try
            {
                if (BgMangerParameter.BusinessGroupID > 0)
                {
                    string strSQL = "Exec usp_Whizible2_Sel_v_tbl_CNF_BusinessGroup_Managers " + BgMangerParameter.BusinessGroupID + "";
                    DataTable BgManagerTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (BgManagerTable != null)
                        BgManagerList = BgManagerTable.ToList<BG_Manager>();

                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, BgManagerList);
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
        public HttpResponseMessage GetToFillBGManagers([FromBody] BG_Params BgMangerParameter)
        {
            var BgManagerCboList = new List<Bg_MangerCbo>();
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Employee_MediumManager " + BgMangerParameter.ManagerID + "";
                DataTable BgManagerCboTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (BgManagerCboTable != null)
                {
                    BgManagerCboList = BgManagerCboTable.ToList<Bg_MangerCbo>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, BgManagerCboList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
           
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage SaveBGManager([FromBody] BG_Manager BG_ManagerParameters)
        {
            string strtResult = string.Empty;
            try
            {
                if (BG_ManagerParameters != null && BG_ManagerParameters.ManagerID > 0 && BG_ManagerParameters.BusinessGroupID > 0)
                {
                    //string strSQL = "Exec usp_Whizible2_InsUpd_tbl_BG_Manager " + BG_ManagerParameters.UniqueID + "," + BG_ManagerParameters.BusinessGroupID + "," + BG_ManagerParameters.ManagerID + ",'" + BG_ManagerParameters.IsPrimaryResponsible + "'";
                    string strSQL = "Exec usp_Whizible2_InsUpd_tbl_BG_Manager " + BG_ManagerParameters.UniqueID + "," + BG_ManagerParameters.BusinessGroupID + "," + BG_ManagerParameters.ManagerID + " ," + BG_ManagerParameters.NewManagerID + ",'" + BG_ManagerParameters.IsPrimaryResponsible + "'";
                    //int Result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }
                    //else
                    //{
                    //    return Request.CreateResponse(HttpStatusCode.Created, "Updated");
                    //}

                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, strtResult);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
            
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteBGManager([FromBody] string BG_ManagerParameters)
        {
            try
            {
                if (BG_ManagerParameters != null)
                {
                    string Result = "";
                    var BG_MGRLIST = BG_ManagerParameters.Split(',').ToList();
                    //usp_Whizible2_Del_tbl_BG_Manager
                    foreach (var itemMGID in BG_MGRLIST)
                    {
                        //string strSQL = "Exec usp_Whizible2_Del_tbl_BG_Manager '" + BG_ManagerParameters + "'";
                        string strSQL = "Exec usp_Whizible2_Del_tbl_BG_Manager '" + itemMGID + "'";
                        var srtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        if (srtResult != "Deleted")
                        {
                            Result += srtResult;
                        }
                    }

                    return Request.CreateResponse(HttpStatusCode.OK, Result);
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


        #endregion

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetBGResources([FromBody] BG_Params BG_ResourceParameters)
        {
            var BG_ResourceList = new List<BG_Resource>();
            try
            {
                //Commented and added by Chetan M on 5 Jul 2021 for Filter Issue
                //if (BG_ResourceParameters != null && BG_ResourceParameters.BusinessGroupID > 0 && BG_ResourceParameters.RoleID > 0)
                if (BG_ResourceParameters != null && BG_ResourceParameters.BusinessGroupID > 0)
                //End of Commented and added by Chetan M on 5 Jul 2021 for Filter Issue
                {
                    string strSQL = "Exec usp_Whizible2_Sel_tbl_BG_MiddleResources " + BG_ResourceParameters.BusinessGroupID + "," + BG_ResourceParameters.RoleID + "";
                    DataTable BG_ResourceTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (BG_ResourceTable != null)
                        BG_ResourceList = BG_ResourceTable.ToList<BG_Resource>();
                    return Request.CreateResponse(HttpStatusCode.OK, BG_ResourceList);
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                //return Request.CreateResponse(HttpStatusCode.OK, BG_ResourceList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            
        }

       
        [HttpPost]
        public HttpResponseMessage GetBGResourceRoleGraph([FromBody] BG_Params BG_GraphParameters)
        {
            var BG_RolesGraphList = new List<BG_RolesGraph>();
            try
            {
                if (BG_GraphParameters != null && BG_GraphParameters.BusinessGroupID > 0)
                {
                    DataTable BG_GraphTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_BG_Roles_Graph " + BG_GraphParameters.BusinessGroupID + "", true, CommonController.connectionString);
                    if (BG_GraphTable != null && BG_GraphTable.Rows.Count > 0)
                    {
                        decimal totalCount = Convert.ToDecimal(BG_GraphTable.Compute("Sum(NoOfResource)", "NoOfResource > 0"));
                        var BG_RolesGraph = new BG_RolesGraph();
                        BG_RolesGraph.LstLabel = new List<string>();
                        BG_RolesGraph.LstColor = new List<string>();
                        BG_RolesGraph.LstData = new List<int>();
                        foreach (DataRow bgGraphRow in BG_GraphTable.Rows)
                        {
                            var count = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(bgGraphRow["NoOfResource"], "0"));
                            decimal perc = count > 0 ? (count * 100) / totalCount : 0;
                            string roleDec = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(bgGraphRow["RoleDescription"], ""));
                            string RoleDecPerce = string.Concat(roleDec, "(", perc.ToString("0.00") + "%", ")");
                            BG_RolesGraph.LstLabel.Add(RoleDecPerce);
                            BG_RolesGraph.LstData.Add(count);
                            BG_RolesGraph.LstColor.Add(GetBGRoleColor());
                        }

                        BG_RolesGraphList.Add(BG_RolesGraph);
                    }
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, BG_RolesGraphList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
           
        }



        #region Filter method

        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SaveBGFilter([FromBody]ApplyFilterParameter Parameters)
        {
            string strSQL = "", Message = "";
            try
            {
                if (Parameters.FilterID == 0)
                {
                    ///strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_Filter_Query " + DecodeUrl(Parameters.TagID) + "," + DecodeUrl(Parameters.ProjectID) + "," + DecodeUrl(Parameters.EmployeeID) + ",'" + HttpUtility.UrlDecode(Parameters.FilterName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.LoginType) + "','" + DecodeWhereClause(Parameters.WhereClause) + "','" + DecodeUrl(Parameters.CreatedBy) + "', " + DecodeUrl(Parameters.Flag) + ", NULL";
                    //strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TagID)) + ",NULL," + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + ",'" + HttpUtility.UrlDecode(Parameters.FilterName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.LoginType) + "','" + HttpUtility.UrlDecode(Parameters.WhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.CreatedBy) + "', " + HttpUtility.UrlDecode(Parameters.Flag) + ", NULL";
                    strSQL = "Exec usp_Whizible2_RM_Ins_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TagID)) + ",NULL," + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + ",'" + HttpUtility.UrlDecode(Parameters.FilterName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.LoginType) + "','" + HttpUtility.UrlDecode(Parameters.WhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.CreatedBy) + "', " + HttpUtility.UrlDecode(Parameters.Flag) + ", NULL";
                }
                else
                {

                    //strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TagID)) + ",NULL," + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + ",'" + HttpUtility.UrlDecode(Parameters.FilterName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.LoginType) + "','" + HttpUtility.UrlDecode(Parameters.WhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.CreatedBy) + "', " + HttpUtility.UrlDecode(Parameters.Flag) + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.FilterID));
                    strSQL = "Exec usp_Whizible2_RM_Ins_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TagID)) + ",NULL," + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + ",'" + HttpUtility.UrlDecode(Parameters.FilterName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.LoginType) + "','" + HttpUtility.UrlDecode(Parameters.WhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.CreatedBy) + "', " + HttpUtility.UrlDecode(Parameters.Flag) + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.FilterID));
                }
                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
                return Request.CreateResponse(HttpStatusCode.OK, Message);
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
        public HttpResponseMessage ExistBGFilter([FromBody]ApplyFilterParameter Parameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_chk_FilterName_Exists '" + HttpUtility.UrlDecode(Parameters.FilterName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "', " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TagID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID));
                //string strSQL = "Exec usp_Whizible2_chk_FilterName_Exists '" + DecodeWhereClause(Parameters.FilterName) + "', " + DecodeUrl(Parameters.TagID) + ", " + DecodeUrl(Parameters.ProjectID) + ", " + DecodeUrl(Parameters.EmployeeID);

                string Flag;

                Flag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
                return Request.CreateResponse(HttpStatusCode.OK, Flag);
                //return Flag;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteBGFilter([FromBody]int FilterID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_del_tbl_Whizible2_Filter_Query " + DecodeUrl(FilterID);

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        
        [HttpPost]
        public HttpResponseMessage GetMyBGFilters([FromBody]ApplyFilterParameter Parameters)
        {
            var myFilterLists = new List<MyFilterParameter>();
            try
            {
                string strSQL = "Exec usp_sel_tbl_Whizible2_Filter_Query NULL," + DecodeUrl(Parameters.TagID) + ",'" + DecodeUrl(Parameters.LoginType) + "'," + DecodeUrl(Parameters.EmployeeID);

                DataTable myFilterListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                if (myFilterListTable != null)
                {
                    myFilterLists = myFilterListTable.ToList<MyFilterParameter>();
                }

                //foreach (DataRow myFilterList in myFilterListTable.Rows)
                //{
                //    MyFilterParameter myFilterListQuery = new MyFilterParameter()
                //    {
                //        FilterId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(myFilterList["FilterId"], "0")),
                //        FilterName = CommonFunctions.Data.CheckIsDBNull(myFilterList["FilterName"], "").ToString(),
                //        SetDefault = CommonFunctions.Data.CheckIsDBNull(myFilterList["SetDefault"], "").ToString(),
                //        QueryText = CommonFunctions.Data.CheckIsDBNull(myFilterList["QueryText"], "").ToString(),
                //        EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(myFilterList["EmployeeID"], "0")),
                //    };
                //    myFilterLists.Add(myFilterListQuery);
                //}
                return Request.CreateResponse(HttpStatusCode.OK, myFilterLists);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

            
        }

        [HttpPost]
        //public List<MyFilterParameter> EditMyBGFilter([FromBody]int FilterID)
        public object EditMyBGFilter([FromBody] int FilterID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_sel_ByFilterID_tbl_Whizible2_Filter_Query  " + DecodeUrl(FilterID);

                DataTable myFilterListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<MyFilterParameter> myFilterLists = new List<MyFilterParameter>();

                foreach (DataRow myFilterList in myFilterListTable.Rows)
                {
                    MyFilterParameter myFilterListQuery = new MyFilterParameter()
                    {
                        FilterId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(myFilterList["FilterID"], "0")),
                        FilterName = CommonFunctions.Data.CheckIsDBNull(myFilterList["FilterName"], "").ToString(),
                        QueryText = CommonFunctions.Data.CheckIsDBNull(myFilterList["WhereClause"], "").ToString(),
                    };
                    myFilterLists.Add(myFilterListQuery);
                }
                return myFilterLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

         
        [HttpPost]
        public object GetWhereClauseOfFilter([FromBody]int FilterID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_tbl_Whizible2_Filter_Query_GetWhereClause " + HttpUtility.UrlDecode(Convert.ToString(FilterID));

                Object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //To set default filter
        [HttpPost]
        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SetDefaultFilter([FromBody]ApplyFilterParameter Parameters)
        {
            string strSQL;
            object dt;
            try
            {
                strSQL = "Exec usp_Whizible2_Upd_tbl_Whizible2_Filter_Query_SetDefaultFilter NULL, " + HttpUtility.UrlDecode(Parameters.LoginType) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.FilterID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.Flag));

                dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
                //throw;
            }



        }
        #endregion

        #region Private method

        private string GetBGRoleColor()
        {   
            var RandomBgGraph = new Random();
            Thread.Sleep(20);
            var ColorBGGraph = $"#{RandomBgGraph.Next(8, 0xFFFFFF):X6}";
            return ColorBGGraph;
        }

        private string DecodeWhereClause(string Clause)
        {
            ///string sdafd= HttpUtility.UrlDecode(Clause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
            return HttpUtility.UrlDecode(Clause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
        }

        private string DecodeUrl(int Url)
        {
            return HttpUtility.UrlDecode(Convert.ToString(Url));
        }
        private string DecodeUrl(string Url)
        {
            return HttpUtility.UrlDecode(Convert.ToString(Url));
        }
        #endregion

    }
}
