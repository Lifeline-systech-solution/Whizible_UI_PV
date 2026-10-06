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
    public class RM_CapacityPlanningController : ApiController
    {
        #region Const/required field

        const string TotalStrength = "Total Strength";
        const string Allocated = "Allocated to Projects";
        const string OpportinutyRequest = "Opportunity Requests";
        const string Bench = "Current Bench";
        const string Anticipated = "Anticipated Exits";
        const string JoiningPool = "Joining Pool";
        const string ProjectRequest = "Project Requests";

        #endregion
        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetCapacityPlanHeaderCounts([FromBody] string UserID)
        {

            RM_CapacityPlanning_Header objCPH = new RM_CapacityPlanning_Header();
            try
            {

                var strSQL = "usp_Whizible2_Get_CapacityPlanHeader " + UserID;
                IDataReader drQuery;
                drQuery = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (drQuery.Read())
                {
                    objCPH.TotalStrength = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(drQuery["TotalStrength"], "0"));
                    objCPH.Allocated = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(drQuery["Allocated"], "0"));
                    objCPH.Bench = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(drQuery["Bench"], "0"));
                    objCPH.ProjectRequests = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(drQuery["ProjectRequests"], "0"));
                    objCPH.SummaryCost = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drQuery["SummaryCost"], "0"));
                    objCPH.ForecastRevenue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drQuery["ForecastRevenue"], "0"));
                    objCPH.Currency = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drQuery["Currency"], " "));


                }
                ////GetCapacityPlanList();
                return Request.CreateResponse(HttpStatusCode.OK, objCPH);

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }


        }


        #region Capacityplaninglist view 

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetCapacityRolePlanList([FromBody] CP_Filter_params CapacityFilterparams)
        {
            #region Required const/field 

            List<string> columnNames = null;
            var CapacityPlaningList = new List<RM_CapacityPlannings>();

            #endregion

            try
            {
                var strSQL = "usp_Whizible2_Sel_CapacityPlanning_RoleWise_Qtr_View '" + CapacityFilterparams.BGOUType + "','" + CapacityFilterparams.BGOUFilter + "','" + CapacityFilterparams.SkillList + "',0";//  "usp_Whizible2_Sel_CapacityPlaningListView ";
                                                                                                                                                                                                                 // var strSQL = "usp_Whizible2_Sel_CapacityPlanning_RoleWise_Qtr_View ";

                DataSet CapacityPlanDSet = CommonFunctions.Data.GetDataSet(strSQL, "CP_listView", ConnectionString: CommonController.connectionString);
                if (CapacityPlanDSet.Tables.Count > 0)
                {
                    columnNames = CapacityPlanDSet.Tables[0].Columns.Cast<DataColumn>().Select(x => x.ColumnName).ToList();
                    columnNames.RemoveRange(0, 3);
                    //columnNames.RemoveAt(12);

                    #region Merge data -IP 
                    List<RM_CpQuarterMonthHeader> CpMonthHeaderTable = null;
                    DataTable CpQuarterMonthHeaderRoleTable = CapacityPlanDSet.Tables[1];
                    if (CpQuarterMonthHeaderRoleTable != null && CpQuarterMonthHeaderRoleTable.Rows.Count > 0)
                    {
                        CpMonthHeaderTable = CpQuarterMonthHeaderRoleTable.ToListCast<RM_CpQuarterMonthHeader>();
                    }

                    DataTable TotalStrengthRoleTable = CapacityPlanDSet != null && CapacityPlanDSet.Tables[0] != null ? CapacityPlanDSet.Tables[0] : null;
                    if (TotalStrengthRoleTable.Rows.Count > 0 && TotalStrengthRoleTable != null)
                    {
                        var Cp_MonthsList = new List<RM_CpQuarterMonths>();
                        foreach (DataRow itemttotalstrength in TotalStrengthRoleTable.Rows)
                        {
                            Cp_MonthsList.Add(GetCpMonthsObject(itemttotalstrength, string.Empty));
                        }


                        #endregion
                        if (Cp_MonthsList.Count > 0)
                        {
                            #region Generate lis object for UI

                            var Cp_DistinctRoles = Cp_MonthsList.GroupBy(x => x.RoleID).Select(g => new RM_CpQuarterMonths { RoleID = g.Key, RoleDescription = g.FirstOrDefault().RoleDescription }).ToList();

                            var Cp_List = new List<RM_CapacityPlannings>();
                            foreach (var item in Cp_DistinctRoles)
                            {
                                RM_CapacityPlannings objCP = new RM_CapacityPlannings();
                                objCP.Cp_list = new List<RM_CpQuarterMonths>();

                                var objTotalStrength = Cp_MonthsList.Find(x => x.RoleID == item.RoleID && x.Name == TotalStrength);
                                if (objTotalStrength == null)
                                {
                                    objTotalStrength = new RM_CpQuarterMonths { RoleID = item.RoleID, Name = TotalStrength, Month_1 = 0, Month_2 = 0, Month_3 = 0, Month_4 = 0, Month_5 = 0, Month_6 = 0, Month_7 = 0, Month_8 = 0, Month_9 = 0, Month_10 = 0, Month_11 = 0, Month_12 = 0 };
                                }
                                var objAllocated = Cp_MonthsList.Find(x => x.RoleID == item.RoleID && x.Name == Allocated);
                                if (objAllocated == null)
                                {
                                    objAllocated = new RM_CpQuarterMonths { RoleID = item.RoleID, Name = Allocated, Month_1 = 0, Month_2 = 0, Month_3 = 0, Month_4 = 0, Month_5 = 0, Month_6 = 0, Month_7 = 0, Month_8 = 0, Month_9 = 0, Month_10 = 0, Month_11 = 0, Month_12 = 0 };
                                }

                                var objOpportinutyRequest = Cp_MonthsList.Find(x => x.RoleID == item.RoleID && x.Name == OpportinutyRequest);
                                if (objOpportinutyRequest == null)
                                {
                                    objOpportinutyRequest = new RM_CpQuarterMonths { RoleID = item.RoleID, Name = OpportinutyRequest, Month_1 = 0, Month_2 = 0, Month_3 = 0, Month_4 = 0, Month_5 = 0, Month_6 = 0, Month_7 = 0, Month_8 = 0, Month_9 = 0, Month_10 = 0, Month_11 = 0, Month_12 = 0 };
                                }

                                var objProjectRequest = Cp_MonthsList.Find(x => x.RoleID == item.RoleID && x.Name == ProjectRequest);
                                if (objProjectRequest == null)
                                {
                                    objProjectRequest = new RM_CpQuarterMonths { RoleID = item.RoleID, Name = ProjectRequest, Month_1 = 0, Month_2 = 0, Month_3 = 0, Month_4 = 0, Month_5 = 0, Month_6 = 0, Month_7 = 0, Month_8 = 0, Month_9 = 0, Month_10 = 0, Month_11 = 0, Month_12 = 0 };
                                }

                                var objBench = Cp_MonthsList.Find(x => x.RoleID == item.RoleID && x.Name == Bench);

                                if (objBench == null)
                                {
                                    objBench = new RM_CpQuarterMonths { RoleID = item.RoleID, Name = Bench, Month_1 = 0, Month_2 = 0, Month_3 = 0, Month_4 = 0, Month_5 = 0, Month_6 = 0, Month_7 = 0, Month_8 = 0, Month_9 = 0, Month_10 = 0, Month_11 = 0, Month_12 = 0 };
                                }
                                var objAnticipated = Cp_MonthsList.Find(x => x.RoleID == item.RoleID && x.Name == Anticipated);

                                if (objAnticipated == null)
                                {
                                    objAnticipated = new RM_CpQuarterMonths { RoleID = item.RoleID, Name = Anticipated, Month_1 = 0, Month_2 = 0, Month_3 = 0, Month_4 = 0, Month_5 = 0, Month_6 = 0, Month_7 = 0, Month_8 = 0, Month_9 = 0, Month_10 = 0, Month_11 = 0, Month_12 = 0 };
                                }
                                var objJoiningPool = Cp_MonthsList.Find(x => x.RoleID == item.RoleID && x.Name == JoiningPool);
                                if (objJoiningPool == null)
                                {
                                    objJoiningPool = new RM_CpQuarterMonths { RoleID = item.RoleID, Name = JoiningPool, Month_1 = 0, Month_2 = 0, Month_3 = 0, Month_4 = 0, Month_5 = 0, Month_6 = 0, Month_7 = 0, Month_8 = 0, Month_9 = 0, Month_10 = 0, Month_11 = 0, Month_12 = 0 };
                                }
                                objCP.Cp_list.Add(objTotalStrength);
                                objCP.Cp_list.Add(objAllocated);
                                objCP.Cp_list.Add(objProjectRequest);
                                objCP.Cp_list.Add(objOpportinutyRequest);
                                objCP.Cp_list.Add(objBench);
                                objCP.Cp_list.Add(objAnticipated);
                                objCP.Cp_list.Add(objJoiningPool);
                                objCP.RoleID = item.RoleID;
                                objCP.RoleDescription = item.RoleDescription;
                                Cp_List.Add(objCP);



                            }

                            #region Summary

                            var MonthSummaryList = Cp_List.SelectMany(x => x.Cp_list).GroupBy(y => y.Name).Select(cpsummary =>
                                      new RM_CpQuarterRoleMonthsSummary
                                      {
                                          Name = cpsummary.Key,
                                          Month_1Sum = cpsummary.Sum(x => x.Month_1),
                                          Month_2Sum = cpsummary.Sum(x => x.Month_2),
                                          Month_3Sum = cpsummary.Sum(x => x.Month_3),
                                          Month_4Sum = cpsummary.Sum(x => x.Month_4),
                                          Month_5Sum = cpsummary.Sum(x => x.Month_5),
                                          Month_6Sum = cpsummary.Sum(x => x.Month_6),
                                          Month_7Sum = cpsummary.Sum(x => x.Month_7),
                                          Month_8Sum = cpsummary.Sum(x => x.Month_8),
                                          Month_9Sum = cpsummary.Sum(x => x.Month_9),
                                          Month_10Sum = cpsummary.Sum(x => x.Month_10),
                                          Month_11Sum = cpsummary.Sum(x => x.Month_11),
                                          Month_12Sum = cpsummary.Sum(x => x.Month_12)
                                      });
                            // objCP.Cp_listSummary = MonthSummaryList.ToList();

                            #endregion



                            SurplusDeficit objSurplusdeficit = GetSurplusDeficitForRole(MonthSummaryList);


                            #endregion
                            var CP_FinalList = Cp_List.OrderBy(x => x.RoleDescription);
                            return this.Request.CreateResponse(HttpStatusCode.OK, new { CpMonthsList = CP_FinalList, Cp_MonthListSummary = MonthSummaryList, CpMonthsListHeader = CpMonthHeaderTable, CpSurplusdeficit = objSurplusdeficit });

                        }
                        else
                        {
                            return this.Request.CreateResponse(HttpStatusCode.OK, new { CpMonthsList = "", Cp_MonthListSummary = "", CpMonthsListHeader = CpMonthHeaderTable, CpSurplusdeficit = "" });
                        }

                    }
                    else
                    {
                        return this.Request.CreateResponse(HttpStatusCode.OK, new { CpMonthsList = "", Cp_MonthListSummary = "", CpMonthsListHeader = CpMonthHeaderTable, CpSurplusdeficit = "" });
                    }
                }
                return Request.CreateResponse(HttpStatusCode.OK, "");

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
        public HttpResponseMessage GetCapacityQtrSkillWisePlanList([FromBody] CP_Filter_params CapacityFilterparams)
        {
            #region Required const/field 

            List<string> columnNames = new List<string>();
            //var CapacityPlaningList = new List<RM_CapacityPlannings>();

            #endregion


            try
            {
                var strSQL = "usp_Whizible2_Sel_CapacityPlanning_SkillWise_Qtr_View '" + CapacityFilterparams.BGOUType + "','" + CapacityFilterparams.BGOUFilter + "','" + CapacityFilterparams.SkillList + "',0";//  "usp_Whizible2_Sel_CapacityPlaningListView ";
                                                                                                                                                                                                                  // var strSQL = "usp_Whizible2_Sel_CapacityPlanning_RoleWise_Qtr_View ";

                DataSet CapacityPlanDSet = CommonFunctions.Data.GetDataSet(strSQL, "CP_SkilllistView", ConnectionString: CommonController.connectionString);
                if (CapacityPlanDSet.Tables.Count > 0)
                {

                    columnNames = CapacityPlanDSet.Tables[0].Columns.Cast<DataColumn>().Select(x => x.ColumnName).ToList();
                    columnNames.RemoveRange(0, 3);
                    //columnNames.RemoveAt(12);
                    List<RM_CpQuarterMonthHeader> CpMonthHeaderTable = null;
                    DataTable CpQuarterMonthHeaderTable = CapacityPlanDSet.Tables[1];
                    if (CpQuarterMonthHeaderTable != null && CpQuarterMonthHeaderTable.Rows.Count > 0)
                    {
                        CpMonthHeaderTable = CpQuarterMonthHeaderTable.ToListCast<RM_CpQuarterMonthHeader>();
                    }

                    #region Merge data -IP 
                    // merge the table
                    DataTable TotalStrengthSkillTable = CapacityPlanDSet != null && CapacityPlanDSet.Tables[0] != null ? CapacityPlanDSet.Tables[0] : null;
                    if (TotalStrengthSkillTable.Rows.Count > 0 && TotalStrengthSkillTable != null)
                    {
                        var Cp_MonthsSkillList = new List<RM_CpQuarterMonthsSkill>();
                        foreach (DataRow itemttotalstrength in TotalStrengthSkillTable.Rows)
                        {
                            Cp_MonthsSkillList.Add(GetCpSkillMonthsObject(itemttotalstrength, string.Empty));
                        }

                        #endregion


                        #region Generate list object for UI

                        var Cp_DistinctToolID = Cp_MonthsSkillList.GroupBy(x => x.ToolID).Select(g => new RM_CpQuarterMonthsSkill { ToolID = g.Key, Description = g.FirstOrDefault().Description }).ToList();

                        var Cp_ListSkill = new List<RM_CapacityPlanningsSkill>();
                        foreach (var item in Cp_DistinctToolID)
                        {
                            RM_CapacityPlanningsSkill objCP = new RM_CapacityPlanningsSkill();
                            objCP.Cp_Skilllist = new List<RM_CpQuarterMonthsSkill>();

                            var objTotalStrength = Cp_MonthsSkillList.Find(x => x.ToolID == item.ToolID && x.Name == TotalStrength);
                            if (objTotalStrength == null)
                            {
                                objTotalStrength = new RM_CpQuarterMonthsSkill { ToolID = item.ToolID, Name = TotalStrength, Month_1 = 0, Month_2 = 0, Month_3 = 0, Month_4 = 0, Month_5 = 0, Month_6 = 0, Month_7 = 0, Month_8 = 0, Month_9 = 0, Month_10 = 0, Month_11 = 0, Month_12 = 0 };
                            }
                            var objAllocated = Cp_MonthsSkillList.Find(x => x.ToolID == item.ToolID && x.Name == Allocated);
                            if (objAllocated == null)
                            {
                                objAllocated = new RM_CpQuarterMonthsSkill { ToolID = item.ToolID, Name = Allocated, Month_1 = 0, Month_2 = 0, Month_3 = 0, Month_4 = 0, Month_5 = 0, Month_6 = 0, Month_7 = 0, Month_8 = 0, Month_9 = 0, Month_10 = 0, Month_11 = 0, Month_12 = 0 };
                            }

                            var objOpportinutyRequest = Cp_MonthsSkillList.Find(x => x.ToolID == item.ToolID && x.Name == OpportinutyRequest);
                            if (objOpportinutyRequest == null)
                            {
                                objOpportinutyRequest = new RM_CpQuarterMonthsSkill { ToolID = item.ToolID, Name = OpportinutyRequest, Month_1 = 0, Month_2 = 0, Month_3 = 0, Month_4 = 0, Month_5 = 0, Month_6 = 0, Month_7 = 0, Month_8 = 0, Month_9 = 0, Month_10 = 0, Month_11 = 0, Month_12 = 0 };
                            }

                            var objProjectRequest = Cp_MonthsSkillList.Find(x => x.ToolID == item.ToolID && x.Name == ProjectRequest);
                            if (objProjectRequest == null)
                            {
                                objProjectRequest = new RM_CpQuarterMonthsSkill { ToolID = item.ToolID, Name = ProjectRequest, Month_1 = 0, Month_2 = 0, Month_3 = 0, Month_4 = 0, Month_5 = 0, Month_6 = 0, Month_7 = 0, Month_8 = 0, Month_9 = 0, Month_10 = 0, Month_11 = 0, Month_12 = 0 };
                            }

                            //#region calculate ProjectRequest using opr req and allocation here 

                            //var objProjectRequest = new RM_CpQuarterMonthsSkill { ToolID = item.ToolID, Name = ProjectRequest, Month_1 = objOpportinutyRequest.Month_1 + objAllocated.Month_1, Month_2 = objOpportinutyRequest.Month_2 + objAllocated.Month_2, Month_3 = objOpportinutyRequest.Month_3 + objAllocated.Month_3, Month_4 = objOpportinutyRequest.Month_4 + objAllocated.Month_4, Month_5 = objOpportinutyRequest.Month_5 + objAllocated.Month_5, Month_6 = objOpportinutyRequest.Month_6 + objAllocated.Month_6, Month_7 = objOpportinutyRequest.Month_7 + objAllocated.Month_7, Month_8 = objOpportinutyRequest.Month_8 + objAllocated.Month_8, Month_9 = objOpportinutyRequest.Month_9 + objAllocated.Month_9, Month_10 = objOpportinutyRequest.Month_10 + objAllocated.Month_10, Month_11 = objOpportinutyRequest.Month_11 + objAllocated.Month_11, Month_12 = objOpportinutyRequest.Month_12 + objAllocated.Month_12 };

                            //#endregion
                            var objBench = Cp_MonthsSkillList.Find(x => x.ToolID == item.ToolID && x.Name == Bench);

                            if (objBench == null)
                            {
                                objBench = new RM_CpQuarterMonthsSkill { ToolID = item.ToolID, Name = Bench, Month_1 = 0, Month_2 = 0, Month_3 = 0, Month_4 = 0, Month_5 = 0, Month_6 = 0, Month_7 = 0, Month_8 = 0, Month_9 = 0, Month_10 = 0, Month_11 = 0, Month_12 = 0 };
                            }
                            var objAnticipated = Cp_MonthsSkillList.Find(x => x.ToolID == item.ToolID && x.Name == Anticipated);

                            if (objAnticipated == null)
                            {
                                objAnticipated = new RM_CpQuarterMonthsSkill { ToolID = item.ToolID, Name = Anticipated, Month_1 = 0, Month_2 = 0, Month_3 = 0, Month_4 = 0, Month_5 = 0, Month_6 = 0, Month_7 = 0, Month_8 = 0, Month_9 = 0, Month_10 = 0, Month_11 = 0, Month_12 = 0 };
                            }
                            var objJoiningPool = Cp_MonthsSkillList.Find(x => x.ToolID == item.ToolID && x.Name == JoiningPool);
                            if (objJoiningPool == null)
                            {
                                objJoiningPool = new RM_CpQuarterMonthsSkill { ToolID = item.ToolID, Name = JoiningPool, Month_1 = 0, Month_2 = 0, Month_3 = 0, Month_4 = 0, Month_5 = 0, Month_6 = 0, Month_7 = 0, Month_8 = 0, Month_9 = 0, Month_10 = 0, Month_11 = 0, Month_12 = 0 };
                            }
                            objCP.Cp_Skilllist.Add(objTotalStrength);
                            objCP.Cp_Skilllist.Add(objAllocated);
                            objCP.Cp_Skilllist.Add(objProjectRequest);
                            objCP.Cp_Skilllist.Add(objOpportinutyRequest);
                            objCP.Cp_Skilllist.Add(objBench);
                            objCP.Cp_Skilllist.Add(objAnticipated);
                            objCP.Cp_Skilllist.Add(objJoiningPool);
                            objCP.ToolID = item.ToolID;
                            objCP.Description = item.Description;
                            Cp_ListSkill.Add(objCP);



                        }

                        #region Summary

                        var SkillMonthSummaryList = Cp_ListSkill.SelectMany(x => x.Cp_Skilllist).GroupBy(y => y.Name).Select(cpsummary =>
                                  new RM_CpQuarterSkillMonthsSummary
                                  {
                                      Name = cpsummary.Key,
                                      Month_1Sum = cpsummary.Sum(x => x.Month_1),
                                      Month_2Sum = cpsummary.Sum(x => x.Month_2),
                                      Month_3Sum = cpsummary.Sum(x => x.Month_3),
                                      Month_4Sum = cpsummary.Sum(x => x.Month_4),
                                      Month_5Sum = cpsummary.Sum(x => x.Month_5),
                                      Month_6Sum = cpsummary.Sum(x => x.Month_6),
                                      Month_7Sum = cpsummary.Sum(x => x.Month_7),
                                      Month_8Sum = cpsummary.Sum(x => x.Month_8),
                                      Month_9Sum = cpsummary.Sum(x => x.Month_9),
                                      Month_10Sum = cpsummary.Sum(x => x.Month_10),
                                      Month_11Sum = cpsummary.Sum(x => x.Month_11),
                                      Month_12Sum = cpsummary.Sum(x => x.Month_12)
                                  });

                        #endregion

                        SurplusDeficit objSurplusdeficit = GetSurplusDeficitForSkill(SkillMonthSummaryList);


                        #endregion
                        var CP_FinalList = Cp_ListSkill.OrderBy(x => x.Description);
                        return this.Request.CreateResponse(HttpStatusCode.OK, new { CpMonthsList = CP_FinalList, Cp_MonthListSummary = SkillMonthSummaryList, CpMonthsListHeader = CpMonthHeaderTable, CpSurplusdeficit = objSurplusdeficit });
                    }
                    else
                    {
                        SurplusDeficit objSurplusdeficit = new SurplusDeficit();
                        RM_CpQuarterSkillMonthsSummary objSumm = new RM_CpQuarterSkillMonthsSummary();
                        return this.Request.CreateResponse(HttpStatusCode.OK, new { CpMonthsList = "", Cp_MonthListSummary = objSumm, CpMonthsListHeader = CpMonthHeaderTable, CpSurplusdeficit = objSurplusdeficit });
                    }
                }
                return Request.CreateResponse(HttpStatusCode.OK, "");

            }

            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }


        }

        private RM_CpQuarterMonthsSkill GetCpSkillMonthsObject(DataRow TblRows, string Name = null)
        {
            var Cp_Months = new RM_CpQuarterMonthsSkill();
            Cp_Months.Description = TblRows["Description"].ToString();
            Cp_Months.ToolID = Convert.ToInt16(TblRows["ToolID"]);
            Cp_Months.Name = !string.IsNullOrEmpty(Name) ? Name : TblRows["Name"].ToString();
            Cp_Months.Month_1 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[3], "0"));
            Cp_Months.Month_2 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[4], "0"));
            Cp_Months.Month_3 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[5], "0"));
            Cp_Months.Month_4 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[6], "0"));
            Cp_Months.Month_5 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[7], "0"));
            Cp_Months.Month_6 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[8], "0"));
            Cp_Months.Month_7 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[9], "0"));
            Cp_Months.Month_8 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[10], "0"));
            Cp_Months.Month_9 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[11], "0"));
            Cp_Months.Month_10 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[12], "0"));
            Cp_Months.Month_11 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[13], "0"));
            Cp_Months.Month_12 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[14], "0"));
            return Cp_Months;
        }

        private RM_CpQuarterMonths GetCpMonthsObject(DataRow TblRows, string Name = null)
        {
            var Cp_Months = new RM_CpQuarterMonths();
            Cp_Months.RoleDescription = TblRows["RoleDescription"].ToString();
            Cp_Months.RoleID = Convert.ToInt16(TblRows["RoleID"]);
            Cp_Months.Name = !string.IsNullOrEmpty(Name) ? Name : TblRows["Name"].ToString();
            Cp_Months.Month_1 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[3], "0"));
            Cp_Months.Month_2 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[4], "0"));
            Cp_Months.Month_3 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[5], "0"));
            Cp_Months.Month_4 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[6], "0"));
            Cp_Months.Month_5 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[7], "0"));
            Cp_Months.Month_6 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[8], "0"));
            Cp_Months.Month_7 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[9], "0"));
            Cp_Months.Month_8 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[10], "0"));
            Cp_Months.Month_9 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[11], "0"));
            Cp_Months.Month_10 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[12], "0"));
            Cp_Months.Month_11 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[13], "0"));
            Cp_Months.Month_12 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[14], "0"));
            return Cp_Months;
        }

        private RM_CpMonthWeeks GetCpWeeksRoleObject(DataRow TblRows, int RowCount, string Name = null)
        {
            var Cp_Weeks = new RM_CpMonthWeeks();
            Cp_Weeks.RoleDescription = TblRows["RoleDescription"].ToString();
            Cp_Weeks.RoleID = Convert.ToInt16(TblRows["RoleID"]);
            Cp_Weeks.Name = !string.IsNullOrEmpty(Name) ? Name : TblRows["Name"].ToString();
            Cp_Weeks.Week_1 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[3], "0"));
            Cp_Weeks.Week_2 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[4], "0"));
            Cp_Weeks.Week_3 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[5], "0"));
            Cp_Weeks.Week_4 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[6], "0"));
            Cp_Weeks.Week_5 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[7], "0"));
            Cp_Weeks.Week_6 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[8], "0"));
            Cp_Weeks.Week_7 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[9], "0"));
            Cp_Weeks.Week_8 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[10], "0"));
            Cp_Weeks.Week_9 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[11], "0"));
            Cp_Weeks.Week_10 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[12], "0"));
            Cp_Weeks.Week_11 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[13], "0"));
            Cp_Weeks.Week_12 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[14], "0"));
            Cp_Weeks.Week_13 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[15], "0"));
            if (TblRows != null && RowCount > 16)
            {
                Cp_Weeks.Week_14 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[16], "0"));
            }
            if (TblRows != null && RowCount > 17)
            {
                Cp_Weeks.Week_15 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[17], "0"));
            }

            return Cp_Weeks;
        }

        private RM_CpSkillMonthWeeks GetCpWeeksSkillObject(DataRow TblRows, int RowCount, string Name = null)
        {
            var Cp_Weeks = new RM_CpSkillMonthWeeks();
            Cp_Weeks.Description = TblRows["Description"].ToString();
            Cp_Weeks.ToolID = Convert.ToInt16(TblRows["ToolID"]);
            Cp_Weeks.Name = !string.IsNullOrEmpty(Name) ? Name : TblRows["Name"].ToString();
            Cp_Weeks.Week_1 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[3], "0"));
            Cp_Weeks.Week_2 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[4], "0"));
            Cp_Weeks.Week_3 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[5], "0"));
            Cp_Weeks.Week_4 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[6], "0"));
            Cp_Weeks.Week_5 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[7], "0"));
            Cp_Weeks.Week_6 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[8], "0"));
            Cp_Weeks.Week_7 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[9], "0"));
            Cp_Weeks.Week_8 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[10], "0"));
            Cp_Weeks.Week_9 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[11], "0"));
            Cp_Weeks.Week_10 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[12], "0"));
            Cp_Weeks.Week_11 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[13], "0"));
            Cp_Weeks.Week_12 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[14], "0"));
            Cp_Weeks.Week_13 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[15], "0"));
            if (TblRows != null && RowCount > 16)
            {
                Cp_Weeks.Week_14 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[16], "0"));
            }
            if (TblRows != null && RowCount > 17)
            {
                Cp_Weeks.Week_15 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[17], "0"));
            }
            return Cp_Weeks;
        }

        private RM_CpQuarterMonths GetCpProjectRequest(RM_CpQuarterMonths itemOpp, RM_CpQuarterMonths itemAllo, string ProjectRequest = "Project Requests")
        {
            var Cp_Months = new RM_CpQuarterMonths();
            Cp_Months.RoleDescription = itemOpp != null && itemOpp.RoleDescription != null ? itemOpp.RoleDescription : itemAllo.RoleDescription;
            Cp_Months.RoleID = itemOpp != null ? itemOpp.RoleID : itemAllo.RoleID;
            Cp_Months.Name = ProjectRequest;
            Cp_Months.Month_1 = (itemOpp != null ? itemOpp.Month_1 : 0) + (itemAllo != null ? itemAllo.Month_1 : 0);
            Cp_Months.Month_2 = itemOpp.Month_2 + itemAllo.Month_2;
            Cp_Months.Month_3 = itemOpp.Month_3 + itemAllo.Month_3;
            Cp_Months.Month_4 = itemOpp.Month_4 + itemAllo.Month_4;
            Cp_Months.Month_5 = itemOpp.Month_5 + itemAllo.Month_5;
            Cp_Months.Month_6 = itemOpp.Month_6 + itemAllo.Month_6;
            Cp_Months.Month_7 = itemOpp.Month_7 + itemAllo.Month_7;
            Cp_Months.Month_8 = itemOpp.Month_8 + itemAllo.Month_8;
            Cp_Months.Month_9 = itemOpp.Month_9 + itemAllo.Month_9;
            Cp_Months.Month_10 = itemOpp.Month_10 + itemAllo.Month_10;
            Cp_Months.Month_11 = itemOpp.Month_11 + itemAllo.Month_11;
            Cp_Months.Month_12 = itemOpp.Month_12 + itemAllo.Month_12;
            return Cp_Months;
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetCapacityRolePlanListRoleMonthWise([FromBody] CP_Filter_params CapacityFilterparams)
        {
            #region Required const/field 

            List<string> columnNames = null;
            var CapacityPlaningList = new List<RM_CapacityPlannings>();

            #endregion


            try
            {
                var strSQL = "usp_Whizible2_Sel_CapacityPlanning_RoleWise_Month_View '" + CapacityFilterparams.BGOUType + "','" + CapacityFilterparams.BGOUFilter + "','" + CapacityFilterparams.SkillList + "',0";
                // var strSQL = "usp_Whizible2_Sel_CapacityPlanning_RoleWise_Qtr_View ";

                DataSet CapacityPlanDSet = CommonFunctions.Data.GetDataSet(strSQL, "CP_listView", ConnectionString: CommonController.connectionString);
                if (CapacityPlanDSet.Tables.Count > 0)
                {

                    columnNames = CapacityPlanDSet.Tables[0].Columns.Cast<DataColumn>().Select(x => x.ColumnName).ToList();
                    columnNames.RemoveRange(0, 3);
                    //columnNames.RemoveAt(12);

                    #region Merge data -IP 
                    List<RM_CpMonthHeader> CpMonthHeaderTable = null;
                    if (CapacityPlanDSet.Tables[1] != null && CapacityPlanDSet.Tables[1].Rows.Count > 0)
                    {
                        CpMonthHeaderTable = CapacityPlanDSet.Tables[1].ToListCast<RM_CpMonthHeader>();

                    }

                    var Cp_WeeksList = new List<RM_CpMonthWeeks>();
                    foreach (DataRow itemttotalstrength in CapacityPlanDSet.Tables[0].Rows)
                    {
                        Cp_WeeksList.Add(GetCpWeeksRoleObject(itemttotalstrength, CapacityPlanDSet.Tables[0].Columns.Count, string.Empty));
                    }
                    #endregion
                    //if (Cp_WeeksList.Count>0 )
                    //{

                    //}
                    //else
                    //{
                    //    SurplusDeficit objSurplusdeficit = new SurplusDeficit();
                    //    RM_CpQuarterSkillMonthsSummary objSumm = new RM_CpQuarterSkillMonthsSummary();
                    //    return this.Request.CreateResponse(HttpStatusCode.OK, new { CpMonthsList = "", Cp_MonthListSummary = objSumm, CpMonthsListHeader = CpMonthHeaderTable, CpSurplusdeficit = objSurplusdeficit });
                    //}

                    #region Generate lis object for UI

                    var Cp_DistinctRoles = Cp_WeeksList.GroupBy(x => x.RoleID).Select(g => new RM_CpMonthWeeks { RoleID = g.Key, RoleDescription = g.FirstOrDefault().RoleDescription }).ToList();

                    var Cp_List = new List<RM_CapacityPlannings>();
                    foreach (var item in Cp_DistinctRoles)
                    {
                        RM_CapacityPlannings objCP = new RM_CapacityPlannings();
                        objCP.Cp_list_Weeks = new List<RM_CpMonthWeeks>();

                        var objTotalStrength = Cp_WeeksList.Find(x => x.RoleID == item.RoleID && x.Name == TotalStrength);
                        if (objTotalStrength == null)
                        {
                            objTotalStrength = new RM_CpMonthWeeks { RoleID = item.RoleID, Name = TotalStrength, Week_1 = 0, Week_2 = 0, Week_3 = 0, Week_4 = 0, Week_5 = 0, Week_6 = 0, Week_7 = 0, Week_8 = 0, Week_9 = 0, Week_10 = 0, Week_11 = 0, Week_12 = 0, Week_13 = 0, Week_14 = 0, Week_15 = 0 };
                        }
                        var objAllocated = Cp_WeeksList.Find(x => x.RoleID == item.RoleID && x.Name == Allocated);
                        if (objAllocated == null)
                        {
                            objAllocated = new RM_CpMonthWeeks { RoleID = item.RoleID, Name = Allocated, Week_1 = 0, Week_2 = 0, Week_3 = 0, Week_4 = 0, Week_5 = 0, Week_6 = 0, Week_7 = 0, Week_8 = 0, Week_9 = 0, Week_10 = 0, Week_11 = 0, Week_12 = 0, Week_13 = 0, Week_14 = 0, Week_15 = 0 };
                        }

                        var objOpportinutyRequest = Cp_WeeksList.Find(x => x.RoleID == item.RoleID && x.Name == OpportinutyRequest);
                        if (objOpportinutyRequest == null)
                        {
                            objOpportinutyRequest = new RM_CpMonthWeeks { RoleID = item.RoleID, Name = OpportinutyRequest, Week_1 = 0, Week_2 = 0, Week_3 = 0, Week_4 = 0, Week_5 = 0, Week_6 = 0, Week_7 = 0, Week_8 = 0, Week_9 = 0, Week_10 = 0, Week_11 = 0, Week_12 = 0, Week_13 = 0, Week_14 = 0, Week_15 = 0 };
                        }

                        var objProjectRequest = Cp_WeeksList.Find(x => x.RoleID == item.RoleID && x.Name == ProjectRequest);
                        if (objProjectRequest == null)
                        {
                            objProjectRequest = new RM_CpMonthWeeks { RoleID = item.RoleID, Name = ProjectRequest, Week_1 = 0, Week_2 = 0, Week_3 = 0, Week_4 = 0, Week_5 = 0, Week_6 = 0, Week_7 = 0, Week_8 = 0, Week_9 = 0, Week_10 = 0, Week_11 = 0, Week_12 = 0, Week_13 = 0, Week_14 = 0, Week_15 = 0 };
                        }

                        var objBench = Cp_WeeksList.Find(x => x.RoleID == item.RoleID && x.Name == Bench);

                        if (objBench == null)
                        {
                            objBench = new RM_CpMonthWeeks { RoleID = item.RoleID, Name = Bench, Week_1 = 0, Week_2 = 0, Week_3 = 0, Week_4 = 0, Week_5 = 0, Week_6 = 0, Week_7 = 0, Week_8 = 0, Week_9 = 0, Week_10 = 0, Week_11 = 0, Week_12 = 0, Week_13 = 0, Week_14 = 0, Week_15 = 0 };
                        }
                        var objAnticipated = Cp_WeeksList.Find(x => x.RoleID == item.RoleID && x.Name == Anticipated);

                        if (objAnticipated == null)
                        {
                            objAnticipated = new RM_CpMonthWeeks { RoleID = item.RoleID, Name = Anticipated, Week_1 = 0, Week_2 = 0, Week_3 = 0, Week_4 = 0, Week_5 = 0, Week_6 = 0, Week_7 = 0, Week_8 = 0, Week_9 = 0, Week_10 = 0, Week_11 = 0, Week_12 = 0, Week_13 = 0, Week_14 = 0, Week_15 = 0 };
                        }
                        var objJoiningPool = Cp_WeeksList.Find(x => x.RoleID == item.RoleID && x.Name == JoiningPool);
                        if (objJoiningPool == null)
                        {
                            objJoiningPool = new RM_CpMonthWeeks { RoleID = item.RoleID, Name = JoiningPool, Week_1 = 0, Week_2 = 0, Week_3 = 0, Week_4 = 0, Week_5 = 0, Week_6 = 0, Week_7 = 0, Week_8 = 0, Week_9 = 0, Week_10 = 0, Week_11 = 0, Week_12 = 0, Week_13 = 0, Week_14 = 0, Week_15 = 0 };
                        }
                        objCP.Cp_list_Weeks.Add(objTotalStrength);
                        objCP.Cp_list_Weeks.Add(objAllocated);
                        objCP.Cp_list_Weeks.Add(objProjectRequest);
                        objCP.Cp_list_Weeks.Add(objOpportinutyRequest);
                        objCP.Cp_list_Weeks.Add(objBench);
                        objCP.Cp_list_Weeks.Add(objAnticipated);
                        objCP.Cp_list_Weeks.Add(objJoiningPool);
                        objCP.RoleID = item.RoleID;
                        objCP.RoleDescription = item.RoleDescription;
                        Cp_List.Add(objCP);

                    }

                    #region Summary

                    var WeekSummaryList = Cp_List.SelectMany(x => x.Cp_list_Weeks).GroupBy(y => y.Name).Select(cpsummary =>
                              new RM_CpMonthWeeksSkillSummary
                              {
                                  Name = cpsummary.Key,
                                  Week_1Sum = cpsummary.Sum(x => x.Week_1),
                                  Week_2Sum = cpsummary.Sum(x => x.Week_2),
                                  Week_3Sum = cpsummary.Sum(x => x.Week_3),
                                  Week_4Sum = cpsummary.Sum(x => x.Week_4),
                                  Week_5Sum = cpsummary.Sum(x => x.Week_5),
                                  Week_6Sum = cpsummary.Sum(x => x.Week_6),
                                  Week_7Sum = cpsummary.Sum(x => x.Week_7),
                                  Week_8Sum = cpsummary.Sum(x => x.Week_8),
                                  Week_9Sum = cpsummary.Sum(x => x.Week_9),
                                  Week_10Sum = cpsummary.Sum(x => x.Week_10),
                                  Week_11Sum = cpsummary.Sum(x => x.Week_11),
                                  Week_12Sum = cpsummary.Sum(x => x.Week_12),
                                  Week_13Sum = cpsummary.Sum(x => x.Week_13),
                                  Week_14Sum = cpsummary.Sum(x => x.Week_14),
                                  Week_15Sum = cpsummary.Sum(x => x.Week_15)
                              });
                    // objCP.Cp_listSummary = MonthSummaryList.ToList();

                    #endregion

                    SurplusDeficit objSurplusdeficit = GetSurplusDeficitForWeekRole(WeekSummaryList);
                    #endregion
                    var CP_FinalList = Cp_List.OrderBy(x => x.RoleDescription);
                    return this.Request.CreateResponse(HttpStatusCode.OK, new { CpWeeksList = CP_FinalList, Cp_WeeklistSummary = WeekSummaryList, CpWeeksListHeader = CpMonthHeaderTable, CpSurplusdeficit = objSurplusdeficit });

                }

            }

            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
            return Request.CreateResponse(HttpStatusCode.OK, "");


        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetCapacityRolePlanListSkillMonthWise([FromBody] CP_Filter_params CapacityFilterparams)
        {
            #region Required const/field 

            List<string> columnNames = null;
            var CapacityPlaningList = new List<RM_CapacityPlanningsSkill>();

            #endregion


            try
            {
                // var strSQL = "usp_Whizible2_Sel_CapacityPlanning_RoleWise_Qtr_View '"+ CapacityFilterparams.BGOUType +"','"+ CapacityFilterparams.BGOUFilter +"','"+CapacityFilterparams.SkillList + "',0";//  "usp_Whizible2_Sel_CapacityPlaningListView ";
                var strSQL = "usp_Whizible2_Sel_CapacityPlanning_SkillWise_Month_View '" + CapacityFilterparams.BGOUType + "','" + CapacityFilterparams.BGOUFilter + "','" + CapacityFilterparams.SkillList + "',0";

                DataSet CapacityPlanDSet = CommonFunctions.Data.GetDataSet(strSQL, "CP_listView", ConnectionString: CommonController.connectionString);
                if (CapacityPlanDSet.Tables.Count > 0)
                {

                    columnNames = CapacityPlanDSet.Tables[0].Columns.Cast<DataColumn>().Select(x => x.ColumnName).ToList();
                    columnNames.RemoveRange(0, 3);
                    //columnNames.RemoveAt(12);

                    #region Merge data -IP 


                    var Cp_WeeksList = new List<RM_CpSkillMonthWeeks>();
                    foreach (DataRow itemttotalstrength in CapacityPlanDSet.Tables[0].Rows)
                    {
                        Cp_WeeksList.Add(GetCpWeeksSkillObject(itemttotalstrength, CapacityPlanDSet.Tables[0].Columns.Count, string.Empty));
                    }
                    #endregion

                    #region Generate lis object for UI

                    var Cp_DistinctRoles = Cp_WeeksList.GroupBy(x => x.ToolID).Select(g => new RM_CpSkillMonthWeeks { ToolID = g.Key, Description = g.FirstOrDefault().Description }).ToList();

                    var Cp_List = new List<RM_CapacityPlanningsSkill>();
                    foreach (var item in Cp_DistinctRoles)
                    {
                        RM_CapacityPlanningsSkill objCP = new RM_CapacityPlanningsSkill();
                        objCP.Cp_list_Skill_Weeks = new List<RM_CpSkillMonthWeeks>();

                        var objTotalStrength = Cp_WeeksList.Find(x => x.ToolID == item.ToolID && x.Name == TotalStrength);
                        if (objTotalStrength == null)
                        {
                            objTotalStrength = new RM_CpSkillMonthWeeks { ToolID = item.ToolID, Name = TotalStrength, Week_1 = 0, Week_2 = 0, Week_3 = 0, Week_4 = 0, Week_5 = 0, Week_6 = 0, Week_7 = 0, Week_8 = 0, Week_9 = 0, Week_10 = 0, Week_11 = 0, Week_12 = 0, Week_13 = 0, Week_14 = 0, Week_15 = 0 };
                        }
                        var objAllocated = Cp_WeeksList.Find(x => x.ToolID == item.ToolID && x.Name == Allocated);
                        if (objAllocated == null)
                        {
                            objAllocated = new RM_CpSkillMonthWeeks { ToolID = item.ToolID, Name = Allocated, Week_1 = 0, Week_2 = 0, Week_3 = 0, Week_4 = 0, Week_5 = 0, Week_6 = 0, Week_7 = 0, Week_8 = 0, Week_9 = 0, Week_10 = 0, Week_11 = 0, Week_12 = 0, Week_13 = 0, Week_14 = 0, Week_15 = 0 };
                        }

                        var objOpportinutyRequest = Cp_WeeksList.Find(x => x.ToolID == item.ToolID && x.Name == OpportinutyRequest);
                        if (objOpportinutyRequest == null)
                        {
                            objOpportinutyRequest = new RM_CpSkillMonthWeeks { ToolID = item.ToolID, Name = OpportinutyRequest, Week_1 = 0, Week_2 = 0, Week_3 = 0, Week_4 = 0, Week_5 = 0, Week_6 = 0, Week_7 = 0, Week_8 = 0, Week_9 = 0, Week_10 = 0, Week_11 = 0, Week_12 = 0, Week_13 = 0, Week_14 = 0, Week_15 = 0 };
                        }

                        var objProjectRequest = Cp_WeeksList.Find(x => x.ToolID == item.ToolID && x.Name == ProjectRequest);
                        if (objProjectRequest == null)
                        {
                            objProjectRequest = new RM_CpSkillMonthWeeks { ToolID = item.ToolID, Name = ProjectRequest, Week_1 = 0, Week_2 = 0, Week_3 = 0, Week_4 = 0, Week_5 = 0, Week_6 = 0, Week_7 = 0, Week_8 = 0, Week_9 = 0, Week_10 = 0, Week_11 = 0, Week_12 = 0, Week_13 = 0, Week_14 = 0, Week_15 = 0 };
                        }

                        var objBench = Cp_WeeksList.Find(x => x.ToolID == item.ToolID && x.Name == Bench);

                        if (objBench == null)
                        {
                            objBench = new RM_CpSkillMonthWeeks { ToolID = item.ToolID, Name = Bench, Week_1 = 0, Week_2 = 0, Week_3 = 0, Week_4 = 0, Week_5 = 0, Week_6 = 0, Week_7 = 0, Week_8 = 0, Week_9 = 0, Week_10 = 0, Week_11 = 0, Week_12 = 0, Week_13 = 0, Week_14 = 0, Week_15 = 0 };
                        }
                        var objAnticipated = Cp_WeeksList.Find(x => x.ToolID == item.ToolID && x.Name == Anticipated);

                        if (objAnticipated == null)
                        {
                            objAnticipated = new RM_CpSkillMonthWeeks { ToolID = item.ToolID, Name = Anticipated, Week_1 = 0, Week_2 = 0, Week_3 = 0, Week_4 = 0, Week_5 = 0, Week_6 = 0, Week_7 = 0, Week_8 = 0, Week_9 = 0, Week_10 = 0, Week_11 = 0, Week_12 = 0, Week_13 = 0, Week_14 = 0, Week_15 = 0 };
                        }
                        var objJoiningPool = Cp_WeeksList.Find(x => x.ToolID == item.ToolID && x.Name == JoiningPool);
                        if (objJoiningPool == null)
                        {
                            objJoiningPool = new RM_CpSkillMonthWeeks { ToolID = item.ToolID, Name = JoiningPool, Week_1 = 0, Week_2 = 0, Week_3 = 0, Week_4 = 0, Week_5 = 0, Week_6 = 0, Week_7 = 0, Week_8 = 0, Week_9 = 0, Week_10 = 0, Week_11 = 0, Week_12 = 0, Week_13 = 0, Week_14 = 0, Week_15 = 0 };
                        }
                        objCP.Cp_list_Skill_Weeks.Add(objTotalStrength);
                        objCP.Cp_list_Skill_Weeks.Add(objAllocated);
                        objCP.Cp_list_Skill_Weeks.Add(objProjectRequest);
                        objCP.Cp_list_Skill_Weeks.Add(objOpportinutyRequest);
                        objCP.Cp_list_Skill_Weeks.Add(objBench);
                        objCP.Cp_list_Skill_Weeks.Add(objAnticipated);
                        objCP.Cp_list_Skill_Weeks.Add(objJoiningPool);
                        objCP.ToolID = item.ToolID;
                        objCP.Description = item.Description;
                        Cp_List.Add(objCP);



                    }

                    #region Summary

                    var WeekSummaryList = Cp_List.SelectMany(x => x.Cp_list_Skill_Weeks).GroupBy(y => y.Name).Select(cpsummary =>
                              new RM_CpMonthWeeksSummary
                              {
                                  Name = cpsummary.Key,
                                  Week_1Sum = cpsummary.Sum(x => x.Week_1),
                                  Week_2Sum = cpsummary.Sum(x => x.Week_2),
                                  Week_3Sum = cpsummary.Sum(x => x.Week_3),
                                  Week_4Sum = cpsummary.Sum(x => x.Week_4),
                                  Week_5Sum = cpsummary.Sum(x => x.Week_5),
                                  Week_6Sum = cpsummary.Sum(x => x.Week_6),
                                  Week_7Sum = cpsummary.Sum(x => x.Week_7),
                                  Week_8Sum = cpsummary.Sum(x => x.Week_8),
                                  Week_9Sum = cpsummary.Sum(x => x.Week_9),
                                  Week_10Sum = cpsummary.Sum(x => x.Week_10),
                                  Week_11Sum = cpsummary.Sum(x => x.Week_11),
                                  Week_12Sum = cpsummary.Sum(x => x.Week_12),
                                  Week_13Sum = cpsummary.Sum(x => x.Week_13),
                                  Week_14Sum = cpsummary.Sum(x => x.Week_14),
                                  Week_15Sum = cpsummary.Sum(x => x.Week_15)
                              });
                    // objCP.Cp_listSummary = MonthSummaryList.ToList();

                    #endregion

                    SurplusDeficit objSurplusdeficit = GetSurplusDeficitForWeekSkill(WeekSummaryList);

                    List<RM_CpMonthHeader> CpMonthHeaderTable = null;
                    if (CapacityPlanDSet.Tables[1] != null && CapacityPlanDSet.Tables[1].Rows.Count > 0)
                    {
                        CpMonthHeaderTable = CapacityPlanDSet.Tables[1].ToListCast<RM_CpMonthHeader>();

                    }


                    #endregion
                    var CP_FinalList = Cp_List.OrderBy(x => x.Description);
                    return this.Request.CreateResponse(HttpStatusCode.OK, new { CpWeeksList = CP_FinalList, Cp_WeeklistSummary = WeekSummaryList, CpMonthsListHeader = CpMonthHeaderTable, CpSurplusdeficit = objSurplusdeficit });

                }

            }

            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
            return Request.CreateResponse(HttpStatusCode.OK, "");


        }

        #endregion

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetCapacityPlanProjectRequestsToolTip([FromBody] CapacityPlanning_Params Capacityparams)
        {
            var projectRequestToolTip = new ProjectRequestToolTip();
            var ProjectRequestList = new List<RM_ProjectRequestToolTip>();
            int TotalResources = 0;
            double TotalProjectCost = 0;

            try
            {

                var strSQL = "usp_Whizible2_GetProjectRequestsByRoleID " + Capacityparams.RoleID + "," + Capacityparams.SkillID + "," + Capacityparams.UserID + ",'" + Capacityparams.StartDate + "','" + Capacityparams.EndDate + "'," + Capacityparams.RoleOrSkill + "," + Capacityparams.WeekOrMonth + ",'" + Capacityparams.SkillList + "','" + Capacityparams.BGOUType + "','" + Capacityparams.BGOUFilter + "'";


                DataTable ProjectRequestListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow taskStatusRow in ProjectRequestListTable.Rows)
                {
                    RM_ProjectRequestToolTip projectRequest = new RM_ProjectRequestToolTip()
                    {

                        NoOfResources = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["NoOfResources"], "0")),
                        ProjectCost = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ProjectCost"], "0")),
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ProjectName"], "")),
                        RoleDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["RoleDescription"], ""))

                    };
                    TotalResources = TotalResources + projectRequest.NoOfResources;
                    TotalProjectCost = TotalProjectCost + projectRequest.ProjectCost;
                    ProjectRequestList.Add(projectRequest);
                }
                var RoleDescription = "";
                if (Capacityparams.SkillID != 0)
                {
                    var strSQL1 = "select Description from tbl_PM_Tools where ToolID = " + Capacityparams.SkillID;
                    RoleDescription = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString));

                }
                if (Capacityparams.RoleID != 0)
                {
                    var strSQL1 = "select RoleDescription from tbl_PM_Role where RoleID = " + Capacityparams.RoleID;
                    RoleDescription = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString));

                }

                projectRequestToolTip.ProjectRequestToolTipList = ProjectRequestList;
                projectRequestToolTip.TotalNoOfResources = TotalResources;
                projectRequestToolTip.TotalProjectCost = TotalProjectCost;
                projectRequestToolTip.RoleDescription = RoleDescription;
                return Request.CreateResponse(HttpStatusCode.OK, projectRequestToolTip);

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
        public HttpResponseMessage GetCapacityPlanAllocatedToProjectToolTip([FromBody] CapacityPlanning_Params Capacityparams)
        {
            var allocatedToProjectToolTip = new AllocatedToProjectToolTip();
            var allocatedToProjectList = new List<AllocatedToProject>();
            int TotalCostPerHour = 0;
            int TotalRatePerHour = 0;

            try
            {

                var strSQL = "usp_Whizible2_GetProjectAllocationByRoleID " + Capacityparams.RoleID + "," + Capacityparams.SkillID + "," + Capacityparams.UserID + ",'" + Capacityparams.StartDate + "','" + Capacityparams.EndDate + "'," + Capacityparams.RoleOrSkill + "," + Capacityparams.WeekOrMonth + ",'" + Capacityparams.SkillList + "','" + Capacityparams.BGOUType + "','" + Capacityparams.BGOUFilter + "'";


                DataTable AllocatedToProjectListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow taskStatusRow in AllocatedToProjectListTable.Rows)
                {
                    AllocatedToProject allocatedToProject = new AllocatedToProject()
                    {

                        CostPerHour = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["CostPerHour"], "0")),
                        RatePerHour = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["RatePerHour"], "0")),
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ProjectName"], "")),
                        ResourceName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["EmployeeName"], "")),
                        ProjectRole = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ProjectRole"], ""))

                    };
                    TotalCostPerHour = TotalCostPerHour + allocatedToProject.CostPerHour;
                    TotalRatePerHour = TotalRatePerHour + allocatedToProject.RatePerHour;
                    allocatedToProjectList.Add(allocatedToProject);
                }

                var RoleDescription = "";
                if (Capacityparams.SkillID != 0)
                {
                    var strSQL1 = "select Description from tbl_PM_Tools where ToolID = " + Capacityparams.SkillID;
                    RoleDescription = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString));

                }
                if (Capacityparams.RoleID != 0)
                {
                    var strSQL1 = "select RoleDescription from tbl_PM_Role where RoleID = " + Capacityparams.RoleID;
                    RoleDescription = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString));

                }
                allocatedToProjectToolTip.AllocatedToProjectToolTipList = allocatedToProjectList;
                allocatedToProjectToolTip.TotalCostPerHour = TotalCostPerHour;
                allocatedToProjectToolTip.TotalRatePerHour = TotalRatePerHour;
                allocatedToProjectToolTip.RoleDescription = RoleDescription;
                return Request.CreateResponse(HttpStatusCode.OK, allocatedToProjectToolTip);

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
        public HttpResponseMessage GetCapacityPlanOpportunityRequestToolTip([FromBody] CapacityPlanning_Params Capacityparams)
        {
            var opportunityRequestToolTip = new OpportunityRequestToolTip();
            var opportunityRequestList = new List<OpportunityRequestData>();
            double TotalOpportunityCost = 0;
            double TotalOpportunityRate = 0;

            try
            {

                var strSQL = "usp_Whizible2_GetOpportunityRequestToolTipInfo " + Capacityparams.RoleID + "," + Capacityparams.SkillID + "," + Capacityparams.UserID + ",'" + Capacityparams.StartDate + "','" + Capacityparams.EndDate + "'," + Capacityparams.WeekOrMonth + "," + Capacityparams.RoleOrSkill + ",'" + Capacityparams.SkillList + "','" + Capacityparams.BGOUType + "','" + Capacityparams.BGOUFilter + "'";


                DataTable OpportunityRequestListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow taskStatusRow in OpportunityRequestListTable.Rows)
                {
                    OpportunityRequestData opportunityRequest = new OpportunityRequestData()
                    {

                        OpportunityName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Prospect"], "")),
                        NoOfResources = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["NoOfResources"], "0")),
                        OpportunityCost = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["OpportunityCost"], "0")),
                        OpportunityRate = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["OpportunityValue"], "0"))


                    };
                    TotalOpportunityCost = TotalOpportunityCost + opportunityRequest.OpportunityCost;
                    TotalOpportunityRate = TotalOpportunityRate + opportunityRequest.OpportunityRate;
                    opportunityRequestList.Add(opportunityRequest);
                }

                var RoleDescription = "";
                if (Capacityparams.SkillID != 0)
                {
                    var strSQL1 = "select Description from tbl_PM_Tools where ToolID = " + Capacityparams.SkillID;
                    RoleDescription = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString));

                }
                if (Capacityparams.RoleID != 0)
                {
                    var strSQL1 = "select RoleDescription from tbl_PM_Role where RoleID = " + Capacityparams.RoleID;
                    RoleDescription = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString));

                }

                opportunityRequestToolTip.OpportunityRequestToolTipList = opportunityRequestList;
                opportunityRequestToolTip.TotalOpportunityCost = TotalOpportunityCost;
                opportunityRequestToolTip.TotalOpportunityRate = TotalOpportunityRate;
                opportunityRequestToolTip.RoleDescription = RoleDescription;
                return Request.CreateResponse(HttpStatusCode.OK, opportunityRequestToolTip);

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
        public HttpResponseMessage GetCapacityPlanBenchToolTip([FromBody] CapacityPlanning_Params Capacityparams)
        {
            var benchToolTip = new BenchToolTip();
            var benchList = new List<Bench>();
            double TotalBenchCost = 0;

            try
            {

                var strSQL = "usp_Whizible2_Sel_AvailableStrengthToolTipInfo " + Capacityparams.RoleID + "," + Capacityparams.SkillID + "," + Capacityparams.UserID + ",'" + Capacityparams.StartDate + "'," + Capacityparams.Days + ",NULL,NULL," + Capacityparams.RoleOrSkill + ",'" + Capacityparams.SkillList + "','" + Capacityparams.BGOUType + "','" + Capacityparams.BGOUFilter + "'," + Capacityparams.WeekOrMonth + ",'" + Capacityparams.EndDate + "'";


                DataTable BenchListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow taskStatusRow in BenchListTable.Rows)
                {
                    Bench bench = new Bench()
                    {

                        ResourceName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["EmployeeName"], "")),
                        SkillOrRole = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Primaryskills"], "")),
                        BenchCost = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["BenchCost"], "0"))

                    };
                    TotalBenchCost = TotalBenchCost + bench.BenchCost;

                    benchList.Add(bench);
                }
                var RoleDescription = "";
                if (Capacityparams.SkillID != 0)
                {
                    var strSQL1 = "select Description from tbl_PM_Tools where ToolID = " + Capacityparams.SkillID;
                    RoleDescription = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString));

                }
                if (Capacityparams.RoleID != 0)
                {
                    var strSQL1 = "select RoleDescription from tbl_PM_Role where RoleID = " + Capacityparams.RoleID;
                    RoleDescription = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString));

                }

                benchToolTip.BenchToolTipList = benchList;
                benchToolTip.TotalBenchCost = TotalBenchCost;
                benchToolTip.RoleDescription = RoleDescription;
                return Request.CreateResponse(HttpStatusCode.OK, benchToolTip);


            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            return Request.CreateResponse(HttpStatusCode.OK, benchToolTip);


        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetCapacityPlanAnticipatedExitsToolTip([FromBody] CapacityPlanning_Params Capacityparams)
        {
            var anticipatedExitsToolTip = new AnticipatedExitsToolTip();
            var anticipatedExitsList = new List<AnticipatedExits>();

            try
            {

                var strSQL = "usp_Whizible2_GetAnticipatedExitsByRoleID " + Capacityparams.RoleID + "," + Capacityparams.SkillID + "," + Capacityparams.UserID + ",'" + Capacityparams.StartDate + "','" + Capacityparams.EndDate + "'," + Capacityparams.RoleOrSkill + "," + Capacityparams.WeekOrMonth + ",'" + Capacityparams.SkillList + "','" + Capacityparams.BGOUType + "','" + Capacityparams.BGOUFilter + "'";


                DataTable AnticipatedExitsListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow taskStatusRow in AnticipatedExitsListTable.Rows)
                {
                    AnticipatedExits anticipatedExits = new AnticipatedExits()
                    {

                        ResourceName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["EmployeeName"], "")),
                        DateOfLeaving = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["TentativeDateOfRelieving"] != null ? String.Format("{0:dd MMMM yyyy}", taskStatusRow["TentativeDateOfRelieving"]) : "")),
                        RoleOrSkill = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Skills"], ""))

                    };


                    anticipatedExitsList.Add(anticipatedExits);
                }

                var RoleDescription = "";
                if (Capacityparams.SkillID != 0)
                {
                    var strSQL1 = "select Description from tbl_PM_Tools where ToolID = " + Capacityparams.SkillID;
                    RoleDescription = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString));

                }
                if (Capacityparams.RoleID != 0)
                {
                    var strSQL1 = "select RoleDescription from tbl_PM_Role where RoleID = " + Capacityparams.RoleID;
                    RoleDescription = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString));

                }

                anticipatedExitsToolTip.AnticipatedExitsToolTipList = anticipatedExitsList;
                anticipatedExitsToolTip.NoOfResources = anticipatedExitsList.Count();
                anticipatedExitsToolTip.RoleDescription = RoleDescription;
                return Request.CreateResponse(HttpStatusCode.OK, anticipatedExitsToolTip);


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
        public HttpResponseMessage GetCapacityPlanJoiningPoolToolTip([FromBody] CapacityPlanning_Params Capacityparams)
        {
            var joiningPoolToolTip = new JoiningPoolToolTip();
            var joiningPoolList = new List<JoiningPool>();
            double TotalExpectedCost = 0;
            try
            {

                var strSQL = "usp_Whizible2_GetJoiningPoolByRoleID " + Capacityparams.RoleID + "," + Capacityparams.SkillID + "," + Capacityparams.UserID + ",'" + Capacityparams.StartDate + "','" + Capacityparams.EndDate + "'," + Capacityparams.RoleOrSkill + "," + Capacityparams.WeekOrMonth;


                DataTable JoiningPoolListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow taskStatusRow in JoiningPoolListTable.Rows)
                {
                    JoiningPool joiningPool = new JoiningPool()
                    {

                        NoOfResources = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["NoOfResources"], "0")),
                        RoleOrSkill = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Skills"], "")),
                        ExpectedCost = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ExpectedCost"], "0"))
                    };

                    TotalExpectedCost = TotalExpectedCost + joiningPool.ExpectedCost;
                    joiningPoolList.Add(joiningPool);
                }

                var RoleDescription = "";
                if (Capacityparams.SkillID != 0)
                {
                    var strSQL1 = "select Description from tbl_PM_Tools where ToolID = " + Capacityparams.SkillID;
                    RoleDescription = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString));

                }
                if (Capacityparams.RoleID != 0)
                {
                    var strSQL1 = "select RoleDescription from tbl_PM_Role where RoleID = " + Capacityparams.RoleID;
                    RoleDescription = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString));

                }

                joiningPoolToolTip.JoiningPoolToolTipList = joiningPoolList;
                joiningPoolToolTip.TotalExpectedCost = TotalExpectedCost;
                joiningPoolToolTip.RoleDescription = RoleDescription;
                return Request.CreateResponse(HttpStatusCode.OK, joiningPoolToolTip);


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
        public HttpResponseMessage GetCapacityPlanBGFilterList([FromBody] CapacityPlanning_Params Capacityparams)
        {

            var BGFilterList = new List<CapacityPlan_BG>();

            try
            {

                var strSQL = "usp_Whizible2_sel_BusinessGroups_LevelWise_PassI_II " + Capacityparams.UserID;


                DataTable BGFilterListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow taskStatusRow in BGFilterListTable.Rows)
                {
                    CapacityPlan_BG capacityPlan_BG = new CapacityPlan_BG()
                    {

                        BusinessGroupID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["BusinessGroupID"], "0")),
                        BusinessGroup = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["BusinessGroup"], ""))

                    };

                    BGFilterList.Add(capacityPlan_BG);
                }
                return Request.CreateResponse(HttpStatusCode.OK, BGFilterList);

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
        public HttpResponseMessage GetCapacityPlanOUFilterList([FromBody] CapacityPlanning_Params Capacityparams)
        {

            var OUFilterList = new List<CapacityPlan_OU>();

            try
            {

                var strSQL = "usp_Whizible2_sel_OrganizationUnits_LevelWise_PassI_II NULL," + Capacityparams.UserID;


                DataTable BGFilterListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow taskStatusRow in BGFilterListTable.Rows)
                {
                    CapacityPlan_OU capacityPlan_OU = new CapacityPlan_OU()
                    {

                        LocationID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["LocationID"], "0")),
                        Location = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Location"], ""))

                    };

                    OUFilterList.Add(capacityPlan_OU);
                }
                return Request.CreateResponse(HttpStatusCode.OK, OUFilterList);
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
        public HttpResponseMessage GetCapacityPlanSkillFilterList([FromBody] CapacityPlanning_Params Capacityparams)
        {

            var SkillFilterList = new List<CapacityPlan_Skill>();

            try
            {

                var strSQL = "usp_Whizible2_Sel_tbl_PM_Tools";


                DataTable BGFilterListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow taskStatusRow in BGFilterListTable.Rows)
                {
                    CapacityPlan_Skill capacityPlan_Skill = new CapacityPlan_Skill()
                    {

                        ToolID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ToolID"], "0")),
                        Description = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Description"], ""))

                    };

                    SkillFilterList.Add(capacityPlan_Skill);
                }
                return Request.CreateResponse(HttpStatusCode.OK, SkillFilterList);


            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }


        }


        public SurplusDeficit GetSurplusDeficitForRole(IEnumerable<RM_CpQuarterRoleMonthsSummary> MonthSummaryList)
        {
            SurplusDeficit_Month surplusDeficit_Month = new SurplusDeficit_Month();

            SrDfCurrentTotal srDfCurrentTotal = new SrDfCurrentTotal();
            SrDfFutureTotal srDfFutureTotal = new SrDfFutureTotal();
            foreach (var objMS in MonthSummaryList)
            {

                if (objMS.Name == Allocated)
                {
                    srDfCurrentTotal.CurrentTotal_1 = srDfFutureTotal.FutureTotal_1 = objMS.Month_1Sum;
                    srDfCurrentTotal.CurrentTotal_2 = srDfFutureTotal.FutureTotal_2 = objMS.Month_2Sum;
                    srDfCurrentTotal.CurrentTotal_3 = srDfFutureTotal.FutureTotal_3 = objMS.Month_3Sum;
                    srDfCurrentTotal.CurrentTotal_4 = srDfFutureTotal.FutureTotal_4 = objMS.Month_4Sum;
                    srDfCurrentTotal.CurrentTotal_5 = srDfFutureTotal.FutureTotal_5 = objMS.Month_5Sum;
                    srDfCurrentTotal.CurrentTotal_6 = srDfFutureTotal.FutureTotal_6 = objMS.Month_6Sum;
                    srDfCurrentTotal.CurrentTotal_7 = srDfFutureTotal.FutureTotal_7 = objMS.Month_7Sum;
                    srDfCurrentTotal.CurrentTotal_8 = srDfFutureTotal.FutureTotal_8 = objMS.Month_8Sum;
                    srDfCurrentTotal.CurrentTotal_9 = srDfFutureTotal.FutureTotal_9 = objMS.Month_9Sum;
                    srDfCurrentTotal.CurrentTotal_10 = srDfFutureTotal.FutureTotal_10 = objMS.Month_10Sum;
                    srDfCurrentTotal.CurrentTotal_11 = srDfFutureTotal.FutureTotal_11 = objMS.Month_11Sum;
                    srDfCurrentTotal.CurrentTotal_12 = srDfFutureTotal.FutureTotal_12 = objMS.Month_12Sum;


                }
                if (objMS.Name == Bench)
                {
                    srDfCurrentTotal.CurrentTotal_1 += objMS.Month_1Sum;
                    srDfCurrentTotal.CurrentTotal_2 += objMS.Month_2Sum;
                    srDfCurrentTotal.CurrentTotal_3 += objMS.Month_3Sum;
                    srDfCurrentTotal.CurrentTotal_4 += objMS.Month_4Sum;
                    srDfCurrentTotal.CurrentTotal_5 += objMS.Month_5Sum;
                    srDfCurrentTotal.CurrentTotal_6 += objMS.Month_6Sum;
                    srDfCurrentTotal.CurrentTotal_7 += objMS.Month_7Sum;
                    srDfCurrentTotal.CurrentTotal_8 += objMS.Month_8Sum;
                    srDfCurrentTotal.CurrentTotal_9 += objMS.Month_9Sum;
                    srDfCurrentTotal.CurrentTotal_10 += objMS.Month_10Sum;
                    srDfCurrentTotal.CurrentTotal_11 += objMS.Month_11Sum;
                    srDfCurrentTotal.CurrentTotal_12 += objMS.Month_12Sum;
                    srDfFutureTotal.FutureTotal_1 += objMS.Month_1Sum;
                    srDfFutureTotal.FutureTotal_2 += objMS.Month_2Sum;
                    srDfFutureTotal.FutureTotal_3 += objMS.Month_3Sum;
                    srDfFutureTotal.FutureTotal_4 += objMS.Month_4Sum;
                    srDfFutureTotal.FutureTotal_5 += objMS.Month_5Sum;
                    srDfFutureTotal.FutureTotal_6 += objMS.Month_6Sum;
                    srDfFutureTotal.FutureTotal_7 += objMS.Month_7Sum;
                    srDfFutureTotal.FutureTotal_8 += objMS.Month_8Sum;
                    srDfFutureTotal.FutureTotal_9 += objMS.Month_9Sum;
                    srDfFutureTotal.FutureTotal_10 += objMS.Month_10Sum;
                    srDfFutureTotal.FutureTotal_11 += objMS.Month_11Sum;
                    srDfFutureTotal.FutureTotal_12 += objMS.Month_12Sum;
                }
                if (objMS.Name == ProjectRequest)
                {
                    srDfFutureTotal.FutureTotal_1 += objMS.Month_1Sum;
                    srDfFutureTotal.FutureTotal_2 += objMS.Month_2Sum;
                    srDfFutureTotal.FutureTotal_3 += objMS.Month_3Sum;
                    srDfFutureTotal.FutureTotal_4 += objMS.Month_4Sum;
                    srDfFutureTotal.FutureTotal_5 += objMS.Month_5Sum;
                    srDfFutureTotal.FutureTotal_6 += objMS.Month_6Sum;
                    srDfFutureTotal.FutureTotal_7 += objMS.Month_7Sum;
                    srDfFutureTotal.FutureTotal_8 += objMS.Month_8Sum;
                    srDfFutureTotal.FutureTotal_9 += objMS.Month_9Sum;
                    srDfFutureTotal.FutureTotal_10 += objMS.Month_10Sum;
                    srDfFutureTotal.FutureTotal_11 += objMS.Month_11Sum;
                    srDfFutureTotal.FutureTotal_12 += objMS.Month_12Sum;
                }
                if (objMS.Name == OpportinutyRequest)
                {
                    srDfFutureTotal.FutureTotal_1 += objMS.Month_1Sum;
                    srDfFutureTotal.FutureTotal_2 += objMS.Month_2Sum;
                    srDfFutureTotal.FutureTotal_3 += objMS.Month_3Sum;
                    srDfFutureTotal.FutureTotal_4 += objMS.Month_4Sum;
                    srDfFutureTotal.FutureTotal_5 += objMS.Month_5Sum;
                    srDfFutureTotal.FutureTotal_6 += objMS.Month_6Sum;
                    srDfFutureTotal.FutureTotal_7 += objMS.Month_7Sum;
                    srDfFutureTotal.FutureTotal_8 += objMS.Month_8Sum;
                    srDfFutureTotal.FutureTotal_9 += objMS.Month_9Sum;
                    srDfFutureTotal.FutureTotal_10 += objMS.Month_10Sum;
                    srDfFutureTotal.FutureTotal_11 += objMS.Month_11Sum;
                    srDfFutureTotal.FutureTotal_12 += objMS.Month_12Sum;
                }
                if (objMS.Name == JoiningPool)
                {
                    srDfFutureTotal.FutureTotal_1 += objMS.Month_1Sum;
                    srDfFutureTotal.FutureTotal_2 += objMS.Month_2Sum;
                    srDfFutureTotal.FutureTotal_3 += objMS.Month_3Sum;
                    srDfFutureTotal.FutureTotal_4 += objMS.Month_4Sum;
                    srDfFutureTotal.FutureTotal_5 += objMS.Month_5Sum;
                    srDfFutureTotal.FutureTotal_6 += objMS.Month_6Sum;
                    srDfFutureTotal.FutureTotal_7 += objMS.Month_7Sum;
                    srDfFutureTotal.FutureTotal_8 += objMS.Month_8Sum;
                    srDfFutureTotal.FutureTotal_9 += objMS.Month_9Sum;
                    srDfFutureTotal.FutureTotal_10 += objMS.Month_10Sum;
                    srDfFutureTotal.FutureTotal_11 += objMS.Month_11Sum;
                    srDfFutureTotal.FutureTotal_12 += objMS.Month_12Sum;

                }
                if (objMS.Name == Anticipated)
                {
                    srDfFutureTotal.FutureTotal_1 = srDfFutureTotal.FutureTotal_1 - objMS.Month_1Sum;
                    srDfFutureTotal.FutureTotal_2 = srDfFutureTotal.FutureTotal_2 - objMS.Month_2Sum;
                    srDfFutureTotal.FutureTotal_3 = srDfFutureTotal.FutureTotal_3 - objMS.Month_3Sum;
                    srDfFutureTotal.FutureTotal_4 = srDfFutureTotal.FutureTotal_4 - objMS.Month_4Sum;
                    srDfFutureTotal.FutureTotal_5 = srDfFutureTotal.FutureTotal_5 - objMS.Month_5Sum;
                    srDfFutureTotal.FutureTotal_6 = srDfFutureTotal.FutureTotal_6 - objMS.Month_6Sum;
                    srDfFutureTotal.FutureTotal_7 = srDfFutureTotal.FutureTotal_7 - objMS.Month_7Sum;
                    srDfFutureTotal.FutureTotal_8 = srDfFutureTotal.FutureTotal_8 - objMS.Month_8Sum;
                    srDfFutureTotal.FutureTotal_9 = srDfFutureTotal.FutureTotal_9 - objMS.Month_9Sum;
                    srDfFutureTotal.FutureTotal_10 = srDfFutureTotal.FutureTotal_10 - objMS.Month_10Sum;
                    srDfFutureTotal.FutureTotal_11 = srDfFutureTotal.FutureTotal_11 - objMS.Month_11Sum;
                    srDfFutureTotal.FutureTotal_12 = srDfFutureTotal.FutureTotal_12 - objMS.Month_12Sum;
                }
            }

            surplusDeficit_Month.CurrentTotalMonth = srDfCurrentTotal;
            surplusDeficit_Month.FutureTotalMonth = srDfFutureTotal;

            SurplusDeficit surplusDeficit = new SurplusDeficit();

            surplusDeficit.SurplusDeficit_1 = srDfCurrentTotal.CurrentTotal_1 - srDfFutureTotal.FutureTotal_1;
            surplusDeficit.SurplusDeficit_2 = srDfCurrentTotal.CurrentTotal_2 - srDfFutureTotal.FutureTotal_2;
            surplusDeficit.SurplusDeficit_3 = srDfCurrentTotal.CurrentTotal_3 - srDfFutureTotal.FutureTotal_3;
            surplusDeficit.SurplusDeficit_4 = srDfCurrentTotal.CurrentTotal_4 - srDfFutureTotal.FutureTotal_4;
            surplusDeficit.SurplusDeficit_5 = srDfCurrentTotal.CurrentTotal_5 - srDfFutureTotal.FutureTotal_5;
            surplusDeficit.SurplusDeficit_6 = srDfCurrentTotal.CurrentTotal_6 - srDfFutureTotal.FutureTotal_6;
            surplusDeficit.SurplusDeficit_7 = srDfCurrentTotal.CurrentTotal_7 - srDfFutureTotal.FutureTotal_7;
            surplusDeficit.SurplusDeficit_8 = srDfCurrentTotal.CurrentTotal_8 - srDfFutureTotal.FutureTotal_8;
            surplusDeficit.SurplusDeficit_9 = srDfCurrentTotal.CurrentTotal_9 - srDfFutureTotal.FutureTotal_9;
            surplusDeficit.SurplusDeficit_10 = srDfCurrentTotal.CurrentTotal_10 - srDfFutureTotal.FutureTotal_10;
            surplusDeficit.SurplusDeficit_11 = srDfCurrentTotal.CurrentTotal_11 - srDfFutureTotal.FutureTotal_11;
            surplusDeficit.SurplusDeficit_12 = srDfCurrentTotal.CurrentTotal_12 - srDfFutureTotal.FutureTotal_12;


            return surplusDeficit;
        }


        public SurplusDeficit GetSurplusDeficitForSkill(IEnumerable<RM_CpQuarterSkillMonthsSummary> MonthSummaryList)
        {
            SurplusDeficit_Month surplusDeficit_Month = new SurplusDeficit_Month();

            SrDfCurrentTotal srDfCurrentTotal = new SrDfCurrentTotal();
            SrDfFutureTotal srDfFutureTotal = new SrDfFutureTotal();
            foreach (var objMS in MonthSummaryList)
            {

                if (objMS.Name == Allocated)
                {
                    srDfCurrentTotal.CurrentTotal_1 = srDfFutureTotal.FutureTotal_1 = objMS.Month_1Sum;
                    srDfCurrentTotal.CurrentTotal_2 = srDfFutureTotal.FutureTotal_2 = objMS.Month_2Sum;
                    srDfCurrentTotal.CurrentTotal_3 = srDfFutureTotal.FutureTotal_3 = objMS.Month_3Sum;
                    srDfCurrentTotal.CurrentTotal_4 = srDfFutureTotal.FutureTotal_4 = objMS.Month_4Sum;
                    srDfCurrentTotal.CurrentTotal_5 = srDfFutureTotal.FutureTotal_5 = objMS.Month_5Sum;
                    srDfCurrentTotal.CurrentTotal_6 = srDfFutureTotal.FutureTotal_6 = objMS.Month_6Sum;
                    srDfCurrentTotal.CurrentTotal_7 = srDfFutureTotal.FutureTotal_7 = objMS.Month_7Sum;
                    srDfCurrentTotal.CurrentTotal_8 = srDfFutureTotal.FutureTotal_8 = objMS.Month_8Sum;
                    srDfCurrentTotal.CurrentTotal_9 = srDfFutureTotal.FutureTotal_9 = objMS.Month_9Sum;
                    srDfCurrentTotal.CurrentTotal_10 = srDfFutureTotal.FutureTotal_10 = objMS.Month_10Sum;
                    srDfCurrentTotal.CurrentTotal_11 = srDfFutureTotal.FutureTotal_11 = objMS.Month_11Sum;
                    srDfCurrentTotal.CurrentTotal_12 = srDfFutureTotal.FutureTotal_12 = objMS.Month_12Sum;


                }
                if (objMS.Name == Bench)
                {
                    srDfCurrentTotal.CurrentTotal_1 += objMS.Month_1Sum;
                    srDfCurrentTotal.CurrentTotal_2 += objMS.Month_2Sum;
                    srDfCurrentTotal.CurrentTotal_3 += objMS.Month_3Sum;
                    srDfCurrentTotal.CurrentTotal_4 += objMS.Month_4Sum;
                    srDfCurrentTotal.CurrentTotal_5 += objMS.Month_5Sum;
                    srDfCurrentTotal.CurrentTotal_6 += objMS.Month_6Sum;
                    srDfCurrentTotal.CurrentTotal_7 += objMS.Month_7Sum;
                    srDfCurrentTotal.CurrentTotal_8 += objMS.Month_8Sum;
                    srDfCurrentTotal.CurrentTotal_9 += objMS.Month_9Sum;
                    srDfCurrentTotal.CurrentTotal_10 += objMS.Month_10Sum;
                    srDfCurrentTotal.CurrentTotal_11 += objMS.Month_11Sum;
                    srDfCurrentTotal.CurrentTotal_12 += objMS.Month_12Sum;
                    srDfFutureTotal.FutureTotal_1 += objMS.Month_1Sum;
                    srDfFutureTotal.FutureTotal_2 += objMS.Month_2Sum;
                    srDfFutureTotal.FutureTotal_3 += objMS.Month_3Sum;
                    srDfFutureTotal.FutureTotal_4 += objMS.Month_4Sum;
                    srDfFutureTotal.FutureTotal_5 += objMS.Month_5Sum;
                    srDfFutureTotal.FutureTotal_6 += objMS.Month_6Sum;
                    srDfFutureTotal.FutureTotal_7 += objMS.Month_7Sum;
                    srDfFutureTotal.FutureTotal_8 += objMS.Month_8Sum;
                    srDfFutureTotal.FutureTotal_9 += objMS.Month_9Sum;
                    srDfFutureTotal.FutureTotal_10 += objMS.Month_10Sum;
                    srDfFutureTotal.FutureTotal_11 += objMS.Month_11Sum;
                    srDfFutureTotal.FutureTotal_12 += objMS.Month_12Sum;
                }
                if (objMS.Name == ProjectRequest)
                {
                    srDfFutureTotal.FutureTotal_1 += objMS.Month_1Sum;
                    srDfFutureTotal.FutureTotal_2 += objMS.Month_2Sum;
                    srDfFutureTotal.FutureTotal_3 += objMS.Month_3Sum;
                    srDfFutureTotal.FutureTotal_4 += objMS.Month_4Sum;
                    srDfFutureTotal.FutureTotal_5 += objMS.Month_5Sum;
                    srDfFutureTotal.FutureTotal_6 += objMS.Month_6Sum;
                    srDfFutureTotal.FutureTotal_7 += objMS.Month_7Sum;
                    srDfFutureTotal.FutureTotal_8 += objMS.Month_8Sum;
                    srDfFutureTotal.FutureTotal_9 += objMS.Month_9Sum;
                    srDfFutureTotal.FutureTotal_10 += objMS.Month_10Sum;
                    srDfFutureTotal.FutureTotal_11 += objMS.Month_11Sum;
                    srDfFutureTotal.FutureTotal_12 += objMS.Month_12Sum;
                }
                if (objMS.Name == OpportinutyRequest)
                {
                    srDfFutureTotal.FutureTotal_1 += objMS.Month_1Sum;
                    srDfFutureTotal.FutureTotal_2 += objMS.Month_2Sum;
                    srDfFutureTotal.FutureTotal_3 += objMS.Month_3Sum;
                    srDfFutureTotal.FutureTotal_4 += objMS.Month_4Sum;
                    srDfFutureTotal.FutureTotal_5 += objMS.Month_5Sum;
                    srDfFutureTotal.FutureTotal_6 += objMS.Month_6Sum;
                    srDfFutureTotal.FutureTotal_7 += objMS.Month_7Sum;
                    srDfFutureTotal.FutureTotal_8 += objMS.Month_8Sum;
                    srDfFutureTotal.FutureTotal_9 += objMS.Month_9Sum;
                    srDfFutureTotal.FutureTotal_10 += objMS.Month_10Sum;
                    srDfFutureTotal.FutureTotal_11 += objMS.Month_11Sum;
                    srDfFutureTotal.FutureTotal_12 += objMS.Month_12Sum;
                }
                if (objMS.Name == JoiningPool)
                {
                    srDfFutureTotal.FutureTotal_1 += objMS.Month_1Sum;
                    srDfFutureTotal.FutureTotal_2 += objMS.Month_2Sum;
                    srDfFutureTotal.FutureTotal_3 += objMS.Month_3Sum;
                    srDfFutureTotal.FutureTotal_4 += objMS.Month_4Sum;
                    srDfFutureTotal.FutureTotal_5 += objMS.Month_5Sum;
                    srDfFutureTotal.FutureTotal_6 += objMS.Month_6Sum;
                    srDfFutureTotal.FutureTotal_7 += objMS.Month_7Sum;
                    srDfFutureTotal.FutureTotal_8 += objMS.Month_8Sum;
                    srDfFutureTotal.FutureTotal_9 += objMS.Month_9Sum;
                    srDfFutureTotal.FutureTotal_10 += objMS.Month_10Sum;
                    srDfFutureTotal.FutureTotal_11 += objMS.Month_11Sum;
                    srDfFutureTotal.FutureTotal_12 += objMS.Month_12Sum;

                }
                if (objMS.Name == Anticipated)
                {
                    srDfFutureTotal.FutureTotal_1 = srDfFutureTotal.FutureTotal_1 - objMS.Month_1Sum;
                    srDfFutureTotal.FutureTotal_2 = srDfFutureTotal.FutureTotal_2 - objMS.Month_2Sum;
                    srDfFutureTotal.FutureTotal_3 = srDfFutureTotal.FutureTotal_3 - objMS.Month_3Sum;
                    srDfFutureTotal.FutureTotal_4 = srDfFutureTotal.FutureTotal_4 - objMS.Month_4Sum;
                    srDfFutureTotal.FutureTotal_5 = srDfFutureTotal.FutureTotal_5 - objMS.Month_5Sum;
                    srDfFutureTotal.FutureTotal_6 = srDfFutureTotal.FutureTotal_6 - objMS.Month_6Sum;
                    srDfFutureTotal.FutureTotal_7 = srDfFutureTotal.FutureTotal_7 - objMS.Month_7Sum;
                    srDfFutureTotal.FutureTotal_8 = srDfFutureTotal.FutureTotal_8 - objMS.Month_8Sum;
                    srDfFutureTotal.FutureTotal_9 = srDfFutureTotal.FutureTotal_9 - objMS.Month_9Sum;
                    srDfFutureTotal.FutureTotal_10 = srDfFutureTotal.FutureTotal_10 - objMS.Month_10Sum;
                    srDfFutureTotal.FutureTotal_11 = srDfFutureTotal.FutureTotal_11 - objMS.Month_11Sum;
                    srDfFutureTotal.FutureTotal_12 = srDfFutureTotal.FutureTotal_12 - objMS.Month_12Sum;
                }
            }

            surplusDeficit_Month.CurrentTotalMonth = srDfCurrentTotal;
            surplusDeficit_Month.FutureTotalMonth = srDfFutureTotal;

            SurplusDeficit surplusDeficit = new SurplusDeficit();

            surplusDeficit.SurplusDeficit_1 = srDfCurrentTotal.CurrentTotal_1 - srDfFutureTotal.FutureTotal_1;
            surplusDeficit.SurplusDeficit_2 = srDfCurrentTotal.CurrentTotal_2 - srDfFutureTotal.FutureTotal_2;
            surplusDeficit.SurplusDeficit_3 = srDfCurrentTotal.CurrentTotal_3 - srDfFutureTotal.FutureTotal_3;
            surplusDeficit.SurplusDeficit_4 = srDfCurrentTotal.CurrentTotal_4 - srDfFutureTotal.FutureTotal_4;
            surplusDeficit.SurplusDeficit_5 = srDfCurrentTotal.CurrentTotal_5 - srDfFutureTotal.FutureTotal_5;
            surplusDeficit.SurplusDeficit_6 = srDfCurrentTotal.CurrentTotal_6 - srDfFutureTotal.FutureTotal_6;
            surplusDeficit.SurplusDeficit_7 = srDfCurrentTotal.CurrentTotal_7 - srDfFutureTotal.FutureTotal_7;
            surplusDeficit.SurplusDeficit_8 = srDfCurrentTotal.CurrentTotal_8 - srDfFutureTotal.FutureTotal_8;
            surplusDeficit.SurplusDeficit_9 = srDfCurrentTotal.CurrentTotal_9 - srDfFutureTotal.FutureTotal_9;
            surplusDeficit.SurplusDeficit_10 = srDfCurrentTotal.CurrentTotal_10 - srDfFutureTotal.FutureTotal_10;
            surplusDeficit.SurplusDeficit_11 = srDfCurrentTotal.CurrentTotal_11 - srDfFutureTotal.FutureTotal_11;
            surplusDeficit.SurplusDeficit_12 = srDfCurrentTotal.CurrentTotal_12 - srDfFutureTotal.FutureTotal_12;


            return surplusDeficit;
        }

        public SurplusDeficit GetSurplusDeficitForWeekRole(IEnumerable<RM_CpMonthWeeksSkillSummary> MonthSummaryList)
        {
            SurplusDeficit_Month surplusDeficit_Month = new SurplusDeficit_Month();

            SrDfCurrentTotal srDfCurrentTotal = new SrDfCurrentTotal();
            SrDfFutureTotal srDfFutureTotal = new SrDfFutureTotal();
            foreach (var objMS in MonthSummaryList)
            {

                if (objMS.Name == Allocated)
                {
                    srDfCurrentTotal.CurrentTotal_1 = srDfFutureTotal.FutureTotal_1 = objMS.Week_1Sum;
                    srDfCurrentTotal.CurrentTotal_2 = srDfFutureTotal.FutureTotal_2 = objMS.Week_2Sum;
                    srDfCurrentTotal.CurrentTotal_3 = srDfFutureTotal.FutureTotal_3 = objMS.Week_3Sum;
                    srDfCurrentTotal.CurrentTotal_4 = srDfFutureTotal.FutureTotal_4 = objMS.Week_4Sum;
                    srDfCurrentTotal.CurrentTotal_5 = srDfFutureTotal.FutureTotal_5 = objMS.Week_5Sum;
                    srDfCurrentTotal.CurrentTotal_6 = srDfFutureTotal.FutureTotal_6 = objMS.Week_6Sum;
                    srDfCurrentTotal.CurrentTotal_7 = srDfFutureTotal.FutureTotal_7 = objMS.Week_7Sum;
                    srDfCurrentTotal.CurrentTotal_8 = srDfFutureTotal.FutureTotal_8 = objMS.Week_8Sum;
                    srDfCurrentTotal.CurrentTotal_9 = srDfFutureTotal.FutureTotal_9 = objMS.Week_9Sum;
                    srDfCurrentTotal.CurrentTotal_10 = srDfFutureTotal.FutureTotal_10 = objMS.Week_10Sum;
                    srDfCurrentTotal.CurrentTotal_11 = srDfFutureTotal.FutureTotal_11 = objMS.Week_11Sum;
                    srDfCurrentTotal.CurrentTotal_12 = srDfFutureTotal.FutureTotal_12 = objMS.Week_12Sum;
                    //srDfCurrentTotal.CurrentTotal_13 = srDfFutureTotal.FutureTotal_12 = objMS.Week_13Sum;
                    //srDfCurrentTotal.CurrentTotal_14 = srDfFutureTotal.FutureTotal_12 = objMS.Week_14Sum;
                    //srDfCurrentTotal.CurrentTotal_15 = srDfFutureTotal.FutureTotal_12 = objMS.Week_15Sum;
                    srDfCurrentTotal.CurrentTotal_13 = srDfFutureTotal.FutureTotal_13 = objMS.Week_13Sum;
                    srDfCurrentTotal.CurrentTotal_14 = srDfFutureTotal.FutureTotal_14 = objMS.Week_14Sum;
                    srDfCurrentTotal.CurrentTotal_15 = srDfFutureTotal.FutureTotal_15 = objMS.Week_15Sum;



                }
                if (objMS.Name == Bench)
                {
                    srDfCurrentTotal.CurrentTotal_1 += objMS.Week_1Sum;
                    srDfCurrentTotal.CurrentTotal_2 += objMS.Week_2Sum;
                    srDfCurrentTotal.CurrentTotal_3 += objMS.Week_3Sum;
                    srDfCurrentTotal.CurrentTotal_4 += objMS.Week_4Sum;
                    srDfCurrentTotal.CurrentTotal_5 += objMS.Week_5Sum;
                    srDfCurrentTotal.CurrentTotal_6 += objMS.Week_6Sum;
                    srDfCurrentTotal.CurrentTotal_7 += objMS.Week_7Sum;
                    srDfCurrentTotal.CurrentTotal_8 += objMS.Week_8Sum;
                    srDfCurrentTotal.CurrentTotal_9 += objMS.Week_9Sum;
                    srDfCurrentTotal.CurrentTotal_10 += objMS.Week_10Sum;
                    srDfCurrentTotal.CurrentTotal_11 += objMS.Week_11Sum;
                    srDfCurrentTotal.CurrentTotal_12 += objMS.Week_12Sum;
                    srDfCurrentTotal.CurrentTotal_13 += objMS.Week_13Sum;
                    srDfCurrentTotal.CurrentTotal_14 += objMS.Week_14Sum;
                    srDfCurrentTotal.CurrentTotal_15 += objMS.Week_15Sum;
                    srDfFutureTotal.FutureTotal_1 += objMS.Week_1Sum;
                    srDfFutureTotal.FutureTotal_2 += objMS.Week_2Sum;
                    srDfFutureTotal.FutureTotal_3 += objMS.Week_3Sum;
                    srDfFutureTotal.FutureTotal_4 += objMS.Week_4Sum;
                    srDfFutureTotal.FutureTotal_5 += objMS.Week_5Sum;
                    srDfFutureTotal.FutureTotal_6 += objMS.Week_6Sum;
                    srDfFutureTotal.FutureTotal_7 += objMS.Week_7Sum;
                    srDfFutureTotal.FutureTotal_8 += objMS.Week_8Sum;
                    srDfFutureTotal.FutureTotal_9 += objMS.Week_9Sum;
                    srDfFutureTotal.FutureTotal_10 += objMS.Week_10Sum;
                    srDfFutureTotal.FutureTotal_11 += objMS.Week_11Sum;
                    srDfFutureTotal.FutureTotal_12 += objMS.Week_12Sum;
                    srDfFutureTotal.FutureTotal_13 += objMS.Week_13Sum;
                    srDfFutureTotal.FutureTotal_14 += objMS.Week_14Sum;
                    srDfFutureTotal.FutureTotal_15 += objMS.Week_15Sum;
                }
                if (objMS.Name == ProjectRequest)
                {
                    srDfFutureTotal.FutureTotal_1 += objMS.Week_1Sum;
                    srDfFutureTotal.FutureTotal_2 += objMS.Week_2Sum;
                    srDfFutureTotal.FutureTotal_3 += objMS.Week_3Sum;
                    srDfFutureTotal.FutureTotal_4 += objMS.Week_4Sum;
                    srDfFutureTotal.FutureTotal_5 += objMS.Week_5Sum;
                    srDfFutureTotal.FutureTotal_6 += objMS.Week_6Sum;
                    srDfFutureTotal.FutureTotal_7 += objMS.Week_7Sum;
                    srDfFutureTotal.FutureTotal_8 += objMS.Week_8Sum;
                    srDfFutureTotal.FutureTotal_9 += objMS.Week_9Sum;
                    srDfFutureTotal.FutureTotal_10 += objMS.Week_10Sum;
                    srDfFutureTotal.FutureTotal_11 += objMS.Week_11Sum;
                    srDfFutureTotal.FutureTotal_12 += objMS.Week_12Sum;
                    srDfFutureTotal.FutureTotal_13 += objMS.Week_13Sum;
                    srDfFutureTotal.FutureTotal_14 += objMS.Week_14Sum;
                    srDfFutureTotal.FutureTotal_15 += objMS.Week_15Sum;
                }
                if (objMS.Name == OpportinutyRequest)
                {
                    srDfFutureTotal.FutureTotal_1 += objMS.Week_1Sum;
                    srDfFutureTotal.FutureTotal_2 += objMS.Week_2Sum;
                    srDfFutureTotal.FutureTotal_3 += objMS.Week_3Sum;
                    srDfFutureTotal.FutureTotal_4 += objMS.Week_4Sum;
                    srDfFutureTotal.FutureTotal_5 += objMS.Week_5Sum;
                    srDfFutureTotal.FutureTotal_6 += objMS.Week_6Sum;
                    srDfFutureTotal.FutureTotal_7 += objMS.Week_7Sum;
                    srDfFutureTotal.FutureTotal_8 += objMS.Week_8Sum;
                    srDfFutureTotal.FutureTotal_9 += objMS.Week_9Sum;
                    srDfFutureTotal.FutureTotal_10 += objMS.Week_10Sum;
                    srDfFutureTotal.FutureTotal_11 += objMS.Week_11Sum;
                    srDfFutureTotal.FutureTotal_12 += objMS.Week_12Sum;
                    srDfFutureTotal.FutureTotal_13 += objMS.Week_13Sum;
                    srDfFutureTotal.FutureTotal_14 += objMS.Week_14Sum;
                    srDfFutureTotal.FutureTotal_15 += objMS.Week_15Sum;
                }
                if (objMS.Name == JoiningPool)
                {
                    srDfFutureTotal.FutureTotal_1 += objMS.Week_1Sum;
                    srDfFutureTotal.FutureTotal_2 += objMS.Week_2Sum;
                    srDfFutureTotal.FutureTotal_3 += objMS.Week_3Sum;
                    srDfFutureTotal.FutureTotal_4 += objMS.Week_4Sum;
                    srDfFutureTotal.FutureTotal_5 += objMS.Week_5Sum;
                    srDfFutureTotal.FutureTotal_6 += objMS.Week_6Sum;
                    srDfFutureTotal.FutureTotal_7 += objMS.Week_7Sum;
                    srDfFutureTotal.FutureTotal_8 += objMS.Week_8Sum;
                    srDfFutureTotal.FutureTotal_9 += objMS.Week_9Sum;
                    srDfFutureTotal.FutureTotal_10 += objMS.Week_10Sum;
                    srDfFutureTotal.FutureTotal_11 += objMS.Week_11Sum;
                    srDfFutureTotal.FutureTotal_12 += objMS.Week_12Sum;
                    srDfFutureTotal.FutureTotal_13 += objMS.Week_13Sum;
                    srDfFutureTotal.FutureTotal_14 += objMS.Week_14Sum;
                    srDfFutureTotal.FutureTotal_15 += objMS.Week_15Sum;

                }
                if (objMS.Name == Anticipated)
                {
                    srDfFutureTotal.FutureTotal_1 = srDfFutureTotal.FutureTotal_1 - objMS.Week_1Sum;
                    srDfFutureTotal.FutureTotal_2 = srDfFutureTotal.FutureTotal_2 - objMS.Week_2Sum;
                    srDfFutureTotal.FutureTotal_3 = srDfFutureTotal.FutureTotal_3 - objMS.Week_3Sum;
                    srDfFutureTotal.FutureTotal_4 = srDfFutureTotal.FutureTotal_4 - objMS.Week_4Sum;
                    srDfFutureTotal.FutureTotal_5 = srDfFutureTotal.FutureTotal_5 - objMS.Week_5Sum;
                    srDfFutureTotal.FutureTotal_6 = srDfFutureTotal.FutureTotal_6 - objMS.Week_6Sum;
                    srDfFutureTotal.FutureTotal_7 = srDfFutureTotal.FutureTotal_7 - objMS.Week_7Sum;
                    srDfFutureTotal.FutureTotal_8 = srDfFutureTotal.FutureTotal_8 - objMS.Week_8Sum;
                    srDfFutureTotal.FutureTotal_9 = srDfFutureTotal.FutureTotal_9 - objMS.Week_9Sum;
                    srDfFutureTotal.FutureTotal_10 = srDfFutureTotal.FutureTotal_10 - objMS.Week_10Sum;
                    srDfFutureTotal.FutureTotal_11 = srDfFutureTotal.FutureTotal_11 - objMS.Week_11Sum;
                    srDfFutureTotal.FutureTotal_12 = srDfFutureTotal.FutureTotal_12 - objMS.Week_12Sum;
                    srDfFutureTotal.FutureTotal_13 = srDfFutureTotal.FutureTotal_13 - objMS.Week_13Sum;
                    srDfFutureTotal.FutureTotal_14 = srDfFutureTotal.FutureTotal_14 - objMS.Week_14Sum;
                    srDfFutureTotal.FutureTotal_15 = srDfFutureTotal.FutureTotal_15 - objMS.Week_15Sum;
                }
            }

            surplusDeficit_Month.CurrentTotalMonth = srDfCurrentTotal;
            surplusDeficit_Month.FutureTotalMonth = srDfFutureTotal;

            SurplusDeficit surplusDeficit = new SurplusDeficit();

            surplusDeficit.SurplusDeficit_1 = srDfCurrentTotal.CurrentTotal_1 - srDfFutureTotal.FutureTotal_1;
            surplusDeficit.SurplusDeficit_2 = srDfCurrentTotal.CurrentTotal_2 - srDfFutureTotal.FutureTotal_2;
            surplusDeficit.SurplusDeficit_3 = srDfCurrentTotal.CurrentTotal_3 - srDfFutureTotal.FutureTotal_3;
            surplusDeficit.SurplusDeficit_4 = srDfCurrentTotal.CurrentTotal_4 - srDfFutureTotal.FutureTotal_4;
            surplusDeficit.SurplusDeficit_5 = srDfCurrentTotal.CurrentTotal_5 - srDfFutureTotal.FutureTotal_5;
            surplusDeficit.SurplusDeficit_6 = srDfCurrentTotal.CurrentTotal_6 - srDfFutureTotal.FutureTotal_6;
            surplusDeficit.SurplusDeficit_7 = srDfCurrentTotal.CurrentTotal_7 - srDfFutureTotal.FutureTotal_7;
            surplusDeficit.SurplusDeficit_8 = srDfCurrentTotal.CurrentTotal_8 - srDfFutureTotal.FutureTotal_8;
            surplusDeficit.SurplusDeficit_9 = srDfCurrentTotal.CurrentTotal_9 - srDfFutureTotal.FutureTotal_9;
            surplusDeficit.SurplusDeficit_10 = srDfCurrentTotal.CurrentTotal_10 - srDfFutureTotal.FutureTotal_10;
            surplusDeficit.SurplusDeficit_11 = srDfCurrentTotal.CurrentTotal_11 - srDfFutureTotal.FutureTotal_11;
            surplusDeficit.SurplusDeficit_12 = srDfCurrentTotal.CurrentTotal_12 - srDfFutureTotal.FutureTotal_12;
            surplusDeficit.SurplusDeficit_13 = srDfCurrentTotal.CurrentTotal_13 - srDfFutureTotal.FutureTotal_13;
            surplusDeficit.SurplusDeficit_14 = srDfCurrentTotal.CurrentTotal_14 - srDfFutureTotal.FutureTotal_14;
            surplusDeficit.SurplusDeficit_15 = srDfCurrentTotal.CurrentTotal_15 - srDfFutureTotal.FutureTotal_15;


            return surplusDeficit;
        }

        public SurplusDeficit GetSurplusDeficitForWeekSkill(IEnumerable<RM_CpMonthWeeksSummary> MonthSummaryList)
        {
            SurplusDeficit_Month surplusDeficit_Month = new SurplusDeficit_Month();

            SrDfCurrentTotal srDfCurrentTotal = new SrDfCurrentTotal();
            SrDfFutureTotal srDfFutureTotal = new SrDfFutureTotal();
            foreach (var objMS in MonthSummaryList)
            {

                if (objMS.Name == Allocated)
                {
                    srDfCurrentTotal.CurrentTotal_1 = srDfFutureTotal.FutureTotal_1 = objMS.Week_1Sum;
                    srDfCurrentTotal.CurrentTotal_2 = srDfFutureTotal.FutureTotal_2 = objMS.Week_2Sum;
                    srDfCurrentTotal.CurrentTotal_3 = srDfFutureTotal.FutureTotal_3 = objMS.Week_3Sum;
                    srDfCurrentTotal.CurrentTotal_4 = srDfFutureTotal.FutureTotal_4 = objMS.Week_4Sum;
                    srDfCurrentTotal.CurrentTotal_5 = srDfFutureTotal.FutureTotal_5 = objMS.Week_5Sum;
                    srDfCurrentTotal.CurrentTotal_6 = srDfFutureTotal.FutureTotal_6 = objMS.Week_6Sum;
                    srDfCurrentTotal.CurrentTotal_7 = srDfFutureTotal.FutureTotal_7 = objMS.Week_7Sum;
                    srDfCurrentTotal.CurrentTotal_8 = srDfFutureTotal.FutureTotal_8 = objMS.Week_8Sum;
                    srDfCurrentTotal.CurrentTotal_9 = srDfFutureTotal.FutureTotal_9 = objMS.Week_9Sum;
                    srDfCurrentTotal.CurrentTotal_10 = srDfFutureTotal.FutureTotal_10 = objMS.Week_10Sum;
                    srDfCurrentTotal.CurrentTotal_11 = srDfFutureTotal.FutureTotal_11 = objMS.Week_11Sum;
                    srDfCurrentTotal.CurrentTotal_12 = srDfFutureTotal.FutureTotal_12 = objMS.Week_12Sum;
                    srDfCurrentTotal.CurrentTotal_13 = srDfFutureTotal.FutureTotal_12 = objMS.Week_13Sum;
                    srDfCurrentTotal.CurrentTotal_14 = srDfFutureTotal.FutureTotal_12 = objMS.Week_14Sum;
                    srDfCurrentTotal.CurrentTotal_15 = srDfFutureTotal.FutureTotal_12 = objMS.Week_15Sum;


                }
                if (objMS.Name == Bench)
                {
                    srDfCurrentTotal.CurrentTotal_1 += objMS.Week_1Sum;
                    srDfCurrentTotal.CurrentTotal_2 += objMS.Week_2Sum;
                    srDfCurrentTotal.CurrentTotal_3 += objMS.Week_3Sum;
                    srDfCurrentTotal.CurrentTotal_4 += objMS.Week_4Sum;
                    srDfCurrentTotal.CurrentTotal_5 += objMS.Week_5Sum;
                    srDfCurrentTotal.CurrentTotal_6 += objMS.Week_6Sum;
                    srDfCurrentTotal.CurrentTotal_7 += objMS.Week_7Sum;
                    srDfCurrentTotal.CurrentTotal_8 += objMS.Week_8Sum;
                    srDfCurrentTotal.CurrentTotal_9 += objMS.Week_9Sum;
                    srDfCurrentTotal.CurrentTotal_10 += objMS.Week_10Sum;
                    srDfCurrentTotal.CurrentTotal_11 += objMS.Week_11Sum;
                    srDfCurrentTotal.CurrentTotal_12 += objMS.Week_12Sum;
                    srDfCurrentTotal.CurrentTotal_13 += objMS.Week_13Sum;
                    srDfCurrentTotal.CurrentTotal_14 += objMS.Week_14Sum;
                    srDfCurrentTotal.CurrentTotal_15 += objMS.Week_15Sum;
                    srDfFutureTotal.FutureTotal_1 += objMS.Week_1Sum;
                    srDfFutureTotal.FutureTotal_2 += objMS.Week_2Sum;
                    srDfFutureTotal.FutureTotal_3 += objMS.Week_3Sum;
                    srDfFutureTotal.FutureTotal_4 += objMS.Week_4Sum;
                    srDfFutureTotal.FutureTotal_5 += objMS.Week_5Sum;
                    srDfFutureTotal.FutureTotal_6 += objMS.Week_6Sum;
                    srDfFutureTotal.FutureTotal_7 += objMS.Week_7Sum;
                    srDfFutureTotal.FutureTotal_8 += objMS.Week_8Sum;
                    srDfFutureTotal.FutureTotal_9 += objMS.Week_9Sum;
                    srDfFutureTotal.FutureTotal_10 += objMS.Week_10Sum;
                    srDfFutureTotal.FutureTotal_11 += objMS.Week_11Sum;
                    srDfFutureTotal.FutureTotal_12 += objMS.Week_12Sum;
                    srDfFutureTotal.FutureTotal_13 += objMS.Week_13Sum;
                    srDfFutureTotal.FutureTotal_14 += objMS.Week_14Sum;
                    srDfFutureTotal.FutureTotal_15 += objMS.Week_15Sum;
                }
                if (objMS.Name == ProjectRequest)
                {
                    srDfFutureTotal.FutureTotal_1 += objMS.Week_1Sum;
                    srDfFutureTotal.FutureTotal_2 += objMS.Week_2Sum;
                    srDfFutureTotal.FutureTotal_3 += objMS.Week_3Sum;
                    srDfFutureTotal.FutureTotal_4 += objMS.Week_4Sum;
                    srDfFutureTotal.FutureTotal_5 += objMS.Week_5Sum;
                    srDfFutureTotal.FutureTotal_6 += objMS.Week_6Sum;
                    srDfFutureTotal.FutureTotal_7 += objMS.Week_7Sum;
                    srDfFutureTotal.FutureTotal_8 += objMS.Week_8Sum;
                    srDfFutureTotal.FutureTotal_9 += objMS.Week_9Sum;
                    srDfFutureTotal.FutureTotal_10 += objMS.Week_10Sum;
                    srDfFutureTotal.FutureTotal_11 += objMS.Week_11Sum;
                    srDfFutureTotal.FutureTotal_12 += objMS.Week_12Sum;
                    srDfFutureTotal.FutureTotal_13 += objMS.Week_13Sum;
                    srDfFutureTotal.FutureTotal_14 += objMS.Week_14Sum;
                    srDfFutureTotal.FutureTotal_15 += objMS.Week_15Sum;
                }
                if (objMS.Name == OpportinutyRequest)
                {
                    srDfFutureTotal.FutureTotal_1 += objMS.Week_1Sum;
                    srDfFutureTotal.FutureTotal_2 += objMS.Week_2Sum;
                    srDfFutureTotal.FutureTotal_3 += objMS.Week_3Sum;
                    srDfFutureTotal.FutureTotal_4 += objMS.Week_4Sum;
                    srDfFutureTotal.FutureTotal_5 += objMS.Week_5Sum;
                    srDfFutureTotal.FutureTotal_6 += objMS.Week_6Sum;
                    srDfFutureTotal.FutureTotal_7 += objMS.Week_7Sum;
                    srDfFutureTotal.FutureTotal_8 += objMS.Week_8Sum;
                    srDfFutureTotal.FutureTotal_9 += objMS.Week_9Sum;
                    srDfFutureTotal.FutureTotal_10 += objMS.Week_10Sum;
                    srDfFutureTotal.FutureTotal_11 += objMS.Week_11Sum;
                    srDfFutureTotal.FutureTotal_12 += objMS.Week_12Sum;
                    srDfFutureTotal.FutureTotal_13 += objMS.Week_13Sum;
                    srDfFutureTotal.FutureTotal_14 += objMS.Week_14Sum;
                    srDfFutureTotal.FutureTotal_15 += objMS.Week_15Sum;
                }
                if (objMS.Name == JoiningPool)
                {
                    srDfFutureTotal.FutureTotal_1 += objMS.Week_1Sum;
                    srDfFutureTotal.FutureTotal_2 += objMS.Week_2Sum;
                    srDfFutureTotal.FutureTotal_3 += objMS.Week_3Sum;
                    srDfFutureTotal.FutureTotal_4 += objMS.Week_4Sum;
                    srDfFutureTotal.FutureTotal_5 += objMS.Week_5Sum;
                    srDfFutureTotal.FutureTotal_6 += objMS.Week_6Sum;
                    srDfFutureTotal.FutureTotal_7 += objMS.Week_7Sum;
                    srDfFutureTotal.FutureTotal_8 += objMS.Week_8Sum;
                    srDfFutureTotal.FutureTotal_9 += objMS.Week_9Sum;
                    srDfFutureTotal.FutureTotal_10 += objMS.Week_10Sum;
                    srDfFutureTotal.FutureTotal_11 += objMS.Week_11Sum;
                    srDfFutureTotal.FutureTotal_12 += objMS.Week_12Sum;
                    srDfFutureTotal.FutureTotal_13 += objMS.Week_13Sum;
                    srDfFutureTotal.FutureTotal_14 += objMS.Week_14Sum;
                    srDfFutureTotal.FutureTotal_15 += objMS.Week_15Sum;

                }
                if (objMS.Name == Anticipated)
                {
                    srDfFutureTotal.FutureTotal_1 = srDfFutureTotal.FutureTotal_1 - objMS.Week_1Sum;
                    srDfFutureTotal.FutureTotal_2 = srDfFutureTotal.FutureTotal_2 - objMS.Week_2Sum;
                    srDfFutureTotal.FutureTotal_3 = srDfFutureTotal.FutureTotal_3 - objMS.Week_3Sum;
                    srDfFutureTotal.FutureTotal_4 = srDfFutureTotal.FutureTotal_4 - objMS.Week_4Sum;
                    srDfFutureTotal.FutureTotal_5 = srDfFutureTotal.FutureTotal_5 - objMS.Week_5Sum;
                    srDfFutureTotal.FutureTotal_6 = srDfFutureTotal.FutureTotal_6 - objMS.Week_6Sum;
                    srDfFutureTotal.FutureTotal_7 = srDfFutureTotal.FutureTotal_7 - objMS.Week_7Sum;
                    srDfFutureTotal.FutureTotal_8 = srDfFutureTotal.FutureTotal_8 - objMS.Week_8Sum;
                    srDfFutureTotal.FutureTotal_9 = srDfFutureTotal.FutureTotal_9 - objMS.Week_9Sum;
                    srDfFutureTotal.FutureTotal_10 = srDfFutureTotal.FutureTotal_10 - objMS.Week_10Sum;
                    srDfFutureTotal.FutureTotal_11 = srDfFutureTotal.FutureTotal_11 - objMS.Week_11Sum;
                    srDfFutureTotal.FutureTotal_12 = srDfFutureTotal.FutureTotal_12 - objMS.Week_12Sum;
                    srDfFutureTotal.FutureTotal_13 = srDfFutureTotal.FutureTotal_13 - objMS.Week_13Sum;
                    srDfFutureTotal.FutureTotal_14 = srDfFutureTotal.FutureTotal_14 - objMS.Week_14Sum;
                    srDfFutureTotal.FutureTotal_15 = srDfFutureTotal.FutureTotal_15 - objMS.Week_15Sum;
                }
            }

            surplusDeficit_Month.CurrentTotalMonth = srDfCurrentTotal;
            surplusDeficit_Month.FutureTotalMonth = srDfFutureTotal;

            SurplusDeficit surplusDeficit = new SurplusDeficit();

            surplusDeficit.SurplusDeficit_1 = srDfCurrentTotal.CurrentTotal_1 - srDfFutureTotal.FutureTotal_1;
            surplusDeficit.SurplusDeficit_2 = srDfCurrentTotal.CurrentTotal_2 - srDfFutureTotal.FutureTotal_2;
            surplusDeficit.SurplusDeficit_3 = srDfCurrentTotal.CurrentTotal_3 - srDfFutureTotal.FutureTotal_3;
            surplusDeficit.SurplusDeficit_4 = srDfCurrentTotal.CurrentTotal_4 - srDfFutureTotal.FutureTotal_4;
            surplusDeficit.SurplusDeficit_5 = srDfCurrentTotal.CurrentTotal_5 - srDfFutureTotal.FutureTotal_5;
            surplusDeficit.SurplusDeficit_6 = srDfCurrentTotal.CurrentTotal_6 - srDfFutureTotal.FutureTotal_6;
            surplusDeficit.SurplusDeficit_7 = srDfCurrentTotal.CurrentTotal_7 - srDfFutureTotal.FutureTotal_7;
            surplusDeficit.SurplusDeficit_8 = srDfCurrentTotal.CurrentTotal_8 - srDfFutureTotal.FutureTotal_8;
            surplusDeficit.SurplusDeficit_9 = srDfCurrentTotal.CurrentTotal_9 - srDfFutureTotal.FutureTotal_9;
            surplusDeficit.SurplusDeficit_10 = srDfCurrentTotal.CurrentTotal_10 - srDfFutureTotal.FutureTotal_10;
            surplusDeficit.SurplusDeficit_11 = srDfCurrentTotal.CurrentTotal_11 - srDfFutureTotal.FutureTotal_11;
            surplusDeficit.SurplusDeficit_12 = srDfCurrentTotal.CurrentTotal_12 - srDfFutureTotal.FutureTotal_12;
            surplusDeficit.SurplusDeficit_13 = srDfCurrentTotal.CurrentTotal_13 - srDfFutureTotal.FutureTotal_13;
            surplusDeficit.SurplusDeficit_14 = srDfCurrentTotal.CurrentTotal_14 - srDfFutureTotal.FutureTotal_14;
            surplusDeficit.SurplusDeficit_15 = srDfCurrentTotal.CurrentTotal_15 - srDfFutureTotal.FutureTotal_15;


            return surplusDeficit;
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public object ExportDocument([FromBody] CP_Filter_params CapacityFilterparams)
        {
            try { 
            string strSQL = "";
            string strFilePath;
            string m_strFileName;
            long m_lngReportID;
            int DateFormatID = 0;
            string CompanyName = "";
            string ReportFormat = CapacityFilterparams.ReportFormat;

            int lngDefaultLCID;
            int lngCurrentThreadUICultureID;
            lngDefaultLCID = 1033;
            lngCurrentThreadUICultureID = 1033;
            AdHocReports.Report.AdHocReport oRpt;
            //if (taskParameters.OpportunityID > 0)
            //{
            //    //strSQL = "usp_RPT_StaffingPlan";
            //}
            // strSQL = "usp_Whizible2_Sel_CapacityPlanning_RoleWise_Qtr_View '" + CapacityFilterparams.BGOUType + "','" + CapacityFilterparams.BGOUFilter + "','" + CapacityFilterparams.SkillList + "',0";//  "usp_Whizible2_Sel_CapacityPlaningListView ";
            strSQL = "usp_Whizible2_Sel_CpExportReport '" + CapacityFilterparams.BGOUType + "','" + CapacityFilterparams.BGOUFilter + "','" + CapacityFilterparams.SkillList + "','" + CapacityFilterparams.ReportTab + "',0";//  "usp_Whizible2_Sel_CapacityPlaningListView ";

            IDataReader drCompInfo1 = CommonFunctions.Data.GetSQLDataReader(strSQL, CommonController.connectionString);
            if (drCompInfo1.Read() == false)
            {
                return "";
            }
            var ReportTab = CapacityFilterparams.ReportTab;
            switch (ReportTab)
            {
                case "QtrWiseRole":
                    m_lngReportID = 35007;
                    break;
                case "QtrWiseSkill":
                    m_lngReportID = 35008;
                    break;
                case "MonthWiseRole":
                    m_lngReportID = 35005;
                    break;
                case "MonthWiseSkill":
                    m_lngReportID = 35006;
                    break;
                default:
                    m_lngReportID = 35005;
                    break;
            }

            CommonEngines.HashTables.Culture.ConnectionString = CommonController.connectionString;
            CommonEngines.HashTables.Culture.FillCultureHashTable();
            // The reports are created in the "Reports" folder
            strFilePath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../Reports/"));//FOR DEV ENV
            ///strFilePath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../../Reports/")); //FOR LOCAL ENV
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


}

}
