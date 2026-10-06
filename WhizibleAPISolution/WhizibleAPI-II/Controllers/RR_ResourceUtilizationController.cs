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
    public class RR_ResourceUtilizationController : ApiController
    {
        ////Added by imran on 19-08-2022   
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetProjectWiseMonthView([FromBody] ResourceUtilizationFilter filterParameter)
        {

            try
            {
                List<string> columnNames = null;
                var RrProjectList = new List<Rr_ProjectWiseList>();
                var RrResourceList = new List<Rr_ResourceWiseList>();
                var RrProjectLitForTotalSum = new RrResourcMonths();
                var RrProjectLitForTotalSumhalfyear = new RrResourcHalfYear();
                var RrProjectListhalfyear = new List<Rr_ProjectWiseListHalfYear>();
                var ObjResouceFilter = GetSqlString(filterParameter);

                //var strSQL = " usp_Whizible2_Sel_ResourceUtilizationDetails_Monthly_Project NULL ";
                //var strSQL = " Exec usp_Whizible2_Sel_ResourceUtilizationDetails_Monthly_Resource_Report @ForCurrentYear = 1,@IsForCapcityHr = 1,@IsHafYrarly = 0 ";
                DataSet CapacityPlanDSet = CommonFunctions.Data.GetDataSet(ObjResouceFilter.StrSql, "MothlyReport", ConnectionString: CommonController.connectionString);
                // DataTable ResourceTable = CommonFunctions.Data.GetDataTable(ObjResouceFilter.StrSql, true, CommonController.connectionString);

                if (ObjResouceFilter.ReportName == "ProjectMonthYear")
                {
                    columnNames = new List<string>();
                    foreach (DataRow itemHeader in CapacityPlanDSet.Tables[1].Rows)
                    {
                        columnNames.Add(Convert.ToString(itemHeader["MonthName"]));
                    }

                    //CapacityPlanDSet.Tables[1].Columns.Cast<DataColumn>().Select(x => x.ColumnName).ToList();
                    //var xfds = columnNames.Where();
                    //columnNames.RemoveRange(0, 3);

                    // var LastMonthIndex = 12;
                    //var LastIndex = columnNames.Count -;
                    // columnNames.RemoveRange(LastMonthIndex, 13);

                    //columnNames.RemoveRange(12, 20);

                    DataTable ResourceTable = CapacityPlanDSet.Tables[0];
                    if (ResourceTable.Rows.Count > 0)
                    {
                        if (ResourceTable != null && ResourceTable.Rows.Count > 0)
                        {
                            var RrResorceList = new List<RrResourcMonths>();
                            foreach (DataRow itemResource in ResourceTable.Rows)
                            {
                                RrResorceList.Add(GetRrResourceMonth(itemResource, string.Empty));
                            }
                            if (filterParameter.ReportIn == "0")
                            {
                                var MonthSummaryList = RrResorceList.GroupBy(y => y.ProjectId).Select(cpsummary =>
                                          new RrProjectMonths
                                          {
                                              ProjectId = cpsummary.Key,
                                              Month_1 = Math.Round(cpsummary.Average(x => x.Month_1), 2),
                                              Month_Ah1 = Math.Round(cpsummary.Average(x => x.Month_Ah1), 2),
                                              Month_2 = Math.Round(cpsummary.Average(x => x.Month_2), 2),
                                              Month_Ah2 = Math.Round(cpsummary.Average(x => x.Month_Ah2), 2),
                                              Month_3 = Math.Round(cpsummary.Average(x => x.Month_3), 2),
                                              Month_Ah3 = Math.Round(cpsummary.Average(x => x.Month_Ah3), 2),
                                              Month_4 = Math.Round(cpsummary.Average(x => x.Month_4), 2),
                                              Month_Ah4 = Math.Round(cpsummary.Average(x => x.Month_Ah4), 2),
                                              Month_5 = Math.Round(cpsummary.Average(x => x.Month_5), 2),
                                              Month_Ah5 = Math.Round(cpsummary.Average(x => x.Month_Ah5), 2),
                                              Month_6 = Math.Round(cpsummary.Average(x => x.Month_6), 2),
                                              Month_Ah6 = Math.Round(cpsummary.Average(x => x.Month_Ah6), 2),
                                              Month_7 = Math.Round(cpsummary.Average(x => x.Month_7), 2),
                                              Month_Ah7 = Math.Round(cpsummary.Average(x => x.Month_Ah7), 2),
                                              Month_8 = Math.Round(cpsummary.Average(x => x.Month_8), 2),
                                              Month_Ah8 = Math.Round(cpsummary.Average(x => x.Month_Ah8), 2),
                                              Month_9 = Math.Round(cpsummary.Average(x => x.Month_9), 2),
                                              Month_Ah9 = Math.Round(cpsummary.Average(x => x.Month_Ah9), 2),
                                              Month_10 = Math.Round(cpsummary.Average(x => x.Month_10), 2),
                                              Month_Ah10 = Math.Round(cpsummary.Average(x => x.Month_Ah10), 2),
                                              Month_11 = Math.Round(cpsummary.Average(x => x.Month_11), 2),
                                              Month_Ah11 = Math.Round(cpsummary.Average(x => x.Month_Ah11), 2),
                                              Month_12 = Math.Round(cpsummary.Average(x => x.Month_12), 2),
                                              Month_Ah12 = Math.Round(cpsummary.Average(x => x.Month_Ah12), 2),
                                          });

                                RrProjectLitForTotalSum = new RrResourcMonths()
                                {
                                    //ResourceId= RrResorceList.FirstOrDefault().ResourceId,
                                    Month_1 = Math.Round(MonthSummaryList.Average(x => x.Month_1), 2),
                                    Month_Ah1 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah1), 2),
                                    Month_2 = Math.Round(MonthSummaryList.Average(x => x.Month_2), 2),
                                    Month_Ah2 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah2), 2),
                                    Month_3 = Math.Round(MonthSummaryList.Average(x => x.Month_3), 2),
                                    Month_Ah3 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah3), 2),
                                    Month_4 = Math.Round(MonthSummaryList.Average(x => x.Month_4), 2),
                                    Month_Ah4 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah4), 2),
                                    Month_5 = Math.Round(MonthSummaryList.Average(x => x.Month_5), 2),
                                    Month_Ah5 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah5), 2),
                                    Month_6 = Math.Round(MonthSummaryList.Average(x => x.Month_6), 2),
                                    Month_Ah6 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah6), 2),
                                    Month_7 = Math.Round(MonthSummaryList.Average(x => x.Month_7), 2),
                                    Month_Ah7 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah7), 2),
                                    Month_8 = Math.Round(MonthSummaryList.Average(x => x.Month_8), 2),
                                    Month_Ah8 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah8), 2),
                                    Month_9 = Math.Round(MonthSummaryList.Average(x => x.Month_9), 2),
                                    Month_Ah9 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah9), 2),
                                    Month_10 = Math.Round(MonthSummaryList.Average(x => x.Month_10), 2),
                                    Month_Ah10 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah10), 2),
                                    Month_11 = Math.Round(MonthSummaryList.Average(x => x.Month_11), 2),
                                    Month_Ah11 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah11), 2),
                                    Month_12 = Math.Round(MonthSummaryList.Average(x => x.Month_12), 2),
                                    Month_Ah12 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah12), 2),
                                };

                                foreach (var itemProject in MonthSummaryList)
                                {
                                    var ProjectListFinal = new Rr_ProjectWiseList();
                                    ProjectListFinal.ProjectMonth = MonthSummaryList.Where(x => x.ProjectId == itemProject.ProjectId).FirstOrDefault();
                                    ProjectListFinal.ProjectMonth.RrResourceList = new List<RrResourcMonths>();

                                    var ProjectResList = RrResorceList.Where(x => x.ProjectId == itemProject.ProjectId).ToList();
                                    //ProjectListFinal.ProjectMonth.RrResourceList= new RrResourcMonths();
                                    ProjectListFinal.ProjectMonth.RrResourceList.AddRange(ProjectResList);
                                    ProjectListFinal.ProjectMonth.ProjectId = ProjectResList.FirstOrDefault().ProjectId;
                                    ProjectListFinal.ProjectMonth.ProjectName = ProjectResList.FirstOrDefault().ProjectName;// itemProject.ProjectName;
                                    ///Add total  sum
                                    RrProjectList.Add(ProjectListFinal);

                                }
                            }
                            else
                            {
                                var MonthSummaryList = RrResorceList.GroupBy(y => y.ProjectId).Select(cpsummary =>
                                                                         new RrProjectMonths
                                                                         {
                                                                             ProjectId = cpsummary.Key,
                                                                             Month_1 = cpsummary.Sum(x => x.Month_1),
                                                                             Month_Ah1 = cpsummary.Sum(x => x.Month_Ah1),
                                                                             Month_2 = cpsummary.Sum(x => x.Month_2),
                                                                             Month_Ah2 = cpsummary.Sum(x => x.Month_Ah2),
                                                                             Month_3 = cpsummary.Sum(x => x.Month_3),
                                                                             Month_Ah3 = cpsummary.Sum(x => x.Month_Ah3),
                                                                             Month_4 = cpsummary.Sum(x => x.Month_4),
                                                                             Month_Ah4 = cpsummary.Sum(x => x.Month_Ah4),
                                                                             Month_5 = cpsummary.Sum(x => x.Month_5),
                                                                             Month_Ah5 = cpsummary.Sum(x => x.Month_Ah5),
                                                                             Month_6 = cpsummary.Sum(x => x.Month_6),
                                                                             Month_Ah6 = cpsummary.Sum(x => x.Month_Ah6),
                                                                             Month_7 = cpsummary.Sum(x => x.Month_7),
                                                                             Month_Ah7 = cpsummary.Sum(x => x.Month_Ah7),
                                                                             Month_8 = cpsummary.Sum(x => x.Month_8),
                                                                             Month_Ah8 = cpsummary.Sum(x => x.Month_Ah8),
                                                                             Month_9 = cpsummary.Sum(x => x.Month_9),
                                                                             Month_Ah9 = cpsummary.Sum(x => x.Month_Ah9),
                                                                             Month_10 = cpsummary.Sum(x => x.Month_10),
                                                                             Month_Ah10 = cpsummary.Sum(x => x.Month_Ah10),
                                                                             Month_11 = cpsummary.Sum(x => x.Month_11),
                                                                             Month_Ah11 = cpsummary.Sum(x => x.Month_Ah11),
                                                                             Month_12 = cpsummary.Sum(x => x.Month_12),
                                                                             Month_Ah12 = cpsummary.Sum(x => x.Month_Ah12),
                                                                         });

                                RrProjectLitForTotalSum = new RrResourcMonths()
                                {
                                    //ResourceId= RrResorceList.FirstOrDefault().ResourceId,
                                    Month_1 = RrResorceList.Sum(x => x.Month_1),
                                    Month_Ah1 = RrResorceList.Sum(x => x.Month_Ah1),
                                    Month_2 = RrResorceList.Sum(x => x.Month_2),
                                    Month_Ah2 = RrResorceList.Sum(x => x.Month_Ah2),
                                    Month_3 = RrResorceList.Sum(x => x.Month_3),
                                    Month_Ah3 = RrResorceList.Sum(x => x.Month_Ah3),
                                    Month_4 = RrResorceList.Sum(x => x.Month_4),
                                    Month_Ah4 = RrResorceList.Sum(x => x.Month_Ah4),
                                    Month_5 = RrResorceList.Sum(x => x.Month_5),
                                    Month_Ah5 = RrResorceList.Sum(x => x.Month_Ah5),
                                    Month_6 = RrResorceList.Sum(x => x.Month_6),
                                    Month_Ah6 = RrResorceList.Sum(x => x.Month_Ah6),
                                    Month_7 = RrResorceList.Sum(x => x.Month_7),
                                    Month_Ah7 = RrResorceList.Sum(x => x.Month_Ah7),
                                    Month_8 = RrResorceList.Sum(x => x.Month_8),
                                    Month_Ah8 = RrResorceList.Sum(x => x.Month_Ah8),
                                    Month_9 = RrResorceList.Sum(x => x.Month_9),
                                    Month_Ah9 = RrResorceList.Sum(x => x.Month_Ah9),
                                    Month_10 = RrResorceList.Sum(x => x.Month_10),
                                    Month_Ah10 = RrResorceList.Sum(x => x.Month_Ah10),
                                    Month_11 = RrResorceList.Sum(x => x.Month_11),
                                    Month_Ah11 = RrResorceList.Sum(x => x.Month_Ah11),
                                    Month_12 = RrResorceList.Sum(x => x.Month_12),
                                    Month_Ah12 = RrResorceList.Sum(x => x.Month_Ah12)
                                };

                                foreach (var itemProject in MonthSummaryList)
                                {
                                    var ProjectListFinal = new Rr_ProjectWiseList();
                                    ProjectListFinal.ProjectMonth = MonthSummaryList.Where(x => x.ProjectId == itemProject.ProjectId).FirstOrDefault();
                                    ProjectListFinal.ProjectMonth.RrResourceList = new List<RrResourcMonths>();

                                    var ProjectResList = RrResorceList.Where(x => x.ProjectId == itemProject.ProjectId).ToList();
                                    //ProjectListFinal.ProjectMonth.RrResourceList= new RrResourcMonths();
                                    ProjectListFinal.ProjectMonth.RrResourceList.AddRange(ProjectResList);
                                    ProjectListFinal.ProjectMonth.ProjectId = ProjectResList.FirstOrDefault().ProjectId;
                                    ProjectListFinal.ProjectMonth.ProjectName = ProjectResList.FirstOrDefault().ProjectName;// itemProject.ProjectName;
                                    ///Add total  sum
                                    RrProjectList.Add(ProjectListFinal);

                                }
                            }
                        }
                    }
                }
                else if (ObjResouceFilter.ReportName == "ResourceMonthYear")
                {

                    ObjRr_ResourceProjectwisemonth Object = new ObjRr_ResourceProjectwisemonth();
                    Object = GetRrResourceMonthwise(CapacityPlanDSet, filterParameter.ReportIn);
                    return this.Request.CreateResponse(HttpStatusCode.OK, new { RrMonthsList = Object.RrResourceListmonth, TotalMontSum = Object.RrProjectLitForTotalSummonth, RrMonthsHeader = Object.columnNames, RrReportName = ObjResouceFilter.ReportName });

                }
                else if (ObjResouceFilter.ReportName == "ProjectHalfYear")
                {

                    ObjRr_Projectwisehalfyear Object = new ObjRr_Projectwisehalfyear();
                    Object = GetRrProjectwiseHalfYear(CapacityPlanDSet, filterParameter.ReportIn);
                    return this.Request.CreateResponse(HttpStatusCode.OK, new { RrMonthsList = Object.RrProjectListhalfyear, TotalMontSum = Object.RrProjectLitForTotalSumhalfyear, RrMonthsHeader = Object.columnNames, RrReportName = ObjResouceFilter.ReportName });
                }
                else if (ObjResouceFilter.ReportName == "ResourceHalfYear")
                {
                    ObjRr_Projectwisehalfyear Object = new ObjRr_Projectwisehalfyear();
                    Object = GetRrResourcwiseHalfYear(CapacityPlanDSet, filterParameter.ReportIn);
                    return this.Request.CreateResponse(HttpStatusCode.OK, new { RrMonthsList = Object.RrResourceListhalfyear, TotalMontSum = Object.RrProjectLitForTotalSumhalfyear, RrMonthsHeader = Object.columnNames, RrReportName = ObjResouceFilter.ReportName });

                }
                else if (ObjResouceFilter.ReportName == "ProjectQuarter")
                {

                    ObjRr_ProjectwiseQuarter Object = new ObjRr_ProjectwiseQuarter();
                    Object = GetRrProjectWiseQuarter(CapacityPlanDSet, filterParameter.ReportIn);
                    return this.Request.CreateResponse(HttpStatusCode.OK, new { RrMonthsList = Object.RrProjectListQuarter, TotalMontSum = Object.RrProjectLitForTotalSumQuarter, RrMonthsHeader = Object.columnNames, RrReportName = ObjResouceFilter.ReportName });
                }
                else if (ObjResouceFilter.ReportName == "ResourceQuarter")
                {
                    ObjRr_ProjectwiseQuarter Object = new ObjRr_ProjectwiseQuarter();
                    Object = GetRrResourcwiseQuarter(CapacityPlanDSet, filterParameter.ReportIn);
                    return this.Request.CreateResponse(HttpStatusCode.OK, new { RrMonthsList = Object.RrResourceListQuarter, TotalMontSum = Object.RrProjectLitForTotalSumQuarter, RrMonthsHeader = Object.columnNames, RrReportName = ObjResouceFilter.ReportName });

                }
                else if (ObjResouceFilter.ReportName == "ProjectWeek")
                {
                    ObjRr_ProjectwiseWeek Object = new ObjRr_ProjectwiseWeek();
                    Object = GetRrProjectWiseWeek(CapacityPlanDSet, filterParameter.ReportIn);
                    return this.Request.CreateResponse(HttpStatusCode.OK, new { RrMonthsList = Object.RrProjectListWeek, TotalMontSum = Object.RrProjectLitForTotalSumWeek, RrMonthsHeader = Object.columnNames, RrReportName = ObjResouceFilter.ReportName });

                }
                else if (ObjResouceFilter.ReportName == "ResourceWeek")
                {
                    ObjRr_ProjectwiseWeek Object = new ObjRr_ProjectwiseWeek();
                    Object = GetRrResourcwiseWeek(CapacityPlanDSet, filterParameter.ReportIn);
                    return this.Request.CreateResponse(HttpStatusCode.OK, new { RrMonthsList = Object.RrResourceListWeek, TotalMontSum = Object.RrProjectLitForTotalSumWeek, RrMonthsHeader = Object.columnNames, RrReportName = ObjResouceFilter.ReportName });

                }

                return this.Request.CreateResponse(HttpStatusCode.OK, new { RrMonthsList = RrProjectList, TotalMontSum = RrProjectLitForTotalSum, RrMonthsHeader = columnNames, RrReportName = "ProjectMonthYear" });

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }


        }

        private RrResourcMonths GetRrResourceMonth(DataRow TblRows, string Name = null)
        {
            var RrProjectMonths = new RrResourcMonths();
            RrProjectMonths.ResourceId = Convert.ToInt16(TblRows["ResourceId"]);
            RrProjectMonths.ProjectId = Convert.ToInt16(TblRows["ProjectId"]);
            RrProjectMonths.ResourceName = !string.IsNullOrEmpty(Name) ? Name : TblRows["ResourceName"].ToString();
            RrProjectMonths.ProjectName = !string.IsNullOrEmpty(Name) ? Name : TblRows["ProjectName"].ToString();
            RrProjectMonths.Month_1 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[4], "0"));
            RrProjectMonths.Month_Ah1 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[5], "0"));
            RrProjectMonths.Month_2 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[6], "0"));
            RrProjectMonths.Month_Ah2 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[7], "0"));
            RrProjectMonths.Month_3 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[8], "0"));
            RrProjectMonths.Month_Ah3 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[9], "0"));
            RrProjectMonths.Month_4 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[10], "0"));
            RrProjectMonths.Month_Ah4 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[11], "0"));
            RrProjectMonths.Month_5 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[12], "0"));
            RrProjectMonths.Month_Ah5 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[13], "0"));
            RrProjectMonths.Month_6 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[14], "0"));
            RrProjectMonths.Month_Ah6 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[15], "0"));
            RrProjectMonths.Month_7 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[16], "0"));
            RrProjectMonths.Month_Ah7 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[17], "0"));
            RrProjectMonths.Month_8 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[18], "0"));
            RrProjectMonths.Month_Ah8 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[19], "0"));
            RrProjectMonths.Month_9 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[20], "0"));
            RrProjectMonths.Month_Ah9 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[21], "0"));
            RrProjectMonths.Month_10 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[22], "0"));
            RrProjectMonths.Month_Ah10 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[23], "0"));
            RrProjectMonths.Month_11 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[24], "0"));
            RrProjectMonths.Month_Ah11 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[25], "0"));
            RrProjectMonths.Month_12 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[26], "0"));
            RrProjectMonths.Month_Ah12 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[27], "0"));

            //RrProjectMonths.ProfilePicURL = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TblRows[30], ""));
            if (CommonFunctions.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TblRows[30], "")))))
                RrProjectMonths.ProfilePicURL = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TblRows[30], ""));
            else
                RrProjectMonths.ProfilePicURL = "../../../Images/NoPreview.gif";

            RrProjectMonths.Designation = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TblRows[31], ""));
            return RrProjectMonths;
        }
        private ObjRr_ResourceProjectwisemonth GetRrResourceMonthwise(DataSet CapacityPlanDSet, string ReportIn)
        {

            List<string> columnNames = null;
            var RrResourceList = new List<Rr_ResourceWiseList>();
            var RrProjectLitForTotalSum = new RrResourcMonths();
            columnNames = new List<string>();
            foreach (DataRow itemHeader in CapacityPlanDSet.Tables[1].Rows)
            {
                columnNames.Add(Convert.ToString(itemHeader["MonthName"]));
            }

            DataTable ResourceTable = CapacityPlanDSet.Tables[0];
            if (ResourceTable.Rows.Count > 0)
            {
                if (ResourceTable != null && ResourceTable.Rows.Count > 0)
                {
                    var RrResorceList = new List<RrResourcMonths>();
                    foreach (DataRow itemResource in ResourceTable.Rows)
                    {
                        RrResorceList.Add(GetRrResourceMonth(itemResource, string.Empty));
                    }

                    if (ReportIn == "0")
                    {
                        var MonthSummaryList = RrResorceList.GroupBy(y => y.ResourceId).Select(cpsummary =>
                                  new RrResourcetMonths
                                  {
                                      ResourceId = cpsummary.Key,
                                      Month_1 = Math.Round(cpsummary.Average(x => x.Month_1), 2),
                                      Month_Ah1 = Math.Round(cpsummary.Average(x => x.Month_Ah1), 2),
                                      Month_2 = Math.Round(cpsummary.Average(x => x.Month_2), 2),
                                      Month_Ah2 = Math.Round(cpsummary.Average(x => x.Month_Ah2), 2),
                                      Month_3 = Math.Round(cpsummary.Average(x => x.Month_3), 2),
                                      Month_Ah3 = Math.Round(cpsummary.Average(x => x.Month_Ah3), 2),
                                      Month_4 = Math.Round(cpsummary.Average(x => x.Month_4), 2),
                                      Month_Ah4 = Math.Round(cpsummary.Average(x => x.Month_Ah4), 2),
                                      Month_5 = Math.Round(cpsummary.Average(x => x.Month_5), 2),
                                      Month_Ah5 = Math.Round(cpsummary.Average(x => x.Month_Ah5), 2),
                                      Month_6 = Math.Round(cpsummary.Average(x => x.Month_6), 2),
                                      Month_Ah6 = Math.Round(cpsummary.Average(x => x.Month_Ah6), 2),
                                      Month_7 = Math.Round(cpsummary.Average(x => x.Month_7), 2),
                                      Month_Ah7 = Math.Round(cpsummary.Average(x => x.Month_Ah7), 2),
                                      Month_8 = Math.Round(cpsummary.Average(x => x.Month_8), 2),
                                      Month_Ah8 = Math.Round(cpsummary.Average(x => x.Month_Ah8), 2),
                                      Month_9 = Math.Round(cpsummary.Average(x => x.Month_9), 2),
                                      Month_Ah9 = Math.Round(cpsummary.Average(x => x.Month_Ah9), 2),
                                      Month_10 = Math.Round(cpsummary.Average(x => x.Month_10), 2),
                                      Month_Ah10 = Math.Round(cpsummary.Average(x => x.Month_Ah10), 2),
                                      Month_11 = Math.Round(cpsummary.Average(x => x.Month_11), 2),
                                      Month_Ah11 = Math.Round(cpsummary.Average(x => x.Month_Ah11), 2),
                                      Month_12 = Math.Round(cpsummary.Average(x => x.Month_12), 2),
                                      Month_Ah12 = Math.Round(cpsummary.Average(x => x.Month_Ah12), 2),
                                  });

                        RrProjectLitForTotalSum = new RrResourcMonths()
                        {
                            //ResourceId= RrResorceList.FirstOrDefault().ResourceId,
                            Month_1 = Math.Round(MonthSummaryList.Average(x => x.Month_1), 2),
                            Month_Ah1 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah1), 2),
                            Month_2 = Math.Round(MonthSummaryList.Average(x => x.Month_2), 2),
                            Month_Ah2 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah2), 2),
                            Month_3 = Math.Round(MonthSummaryList.Average(x => x.Month_3), 2),
                            Month_Ah3 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah3), 2),
                            Month_4 = Math.Round(MonthSummaryList.Average(x => x.Month_4), 2),
                            Month_Ah4 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah4), 2),
                            Month_5 = Math.Round(MonthSummaryList.Average(x => x.Month_5), 2),
                            Month_Ah5 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah5), 2),
                            Month_6 = Math.Round(MonthSummaryList.Average(x => x.Month_6), 2),
                            Month_Ah6 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah6), 2),
                            Month_7 = Math.Round(MonthSummaryList.Average(x => x.Month_7), 2),
                            Month_Ah7 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah7), 2),
                            Month_8 = Math.Round(MonthSummaryList.Average(x => x.Month_8), 2),
                            Month_Ah8 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah8), 2),
                            Month_9 = Math.Round(MonthSummaryList.Average(x => x.Month_9), 2),
                            Month_Ah9 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah9), 2),
                            Month_10 = Math.Round(MonthSummaryList.Average(x => x.Month_10), 2),
                            Month_Ah10 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah10), 2),
                            Month_11 = Math.Round(MonthSummaryList.Average(x => x.Month_11), 2),
                            Month_Ah11 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah11), 2),
                            Month_12 = Math.Round(MonthSummaryList.Average(x => x.Month_12), 2),
                            Month_Ah12 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah12), 2)
                        };

                        foreach (var itemProject in MonthSummaryList)
                        {
                            var ProjectListFinal = new Rr_ResourceWiseList();
                            ProjectListFinal.ResourceMonth = MonthSummaryList.Where(x => x.ResourceId == itemProject.ResourceId).FirstOrDefault();
                            ProjectListFinal.ResourceMonth.RrRList = new List<RrResourcMonths>();

                            var ProjectResList = RrResorceList.Where(x => x.ResourceId == itemProject.ResourceId).ToList();
                            //ProjectListFinal.ProjectMonth.RrResourceList= new RrResourcMonths();
                            ProjectListFinal.ResourceMonth.RrRList.AddRange(ProjectResList);
                            ProjectListFinal.ResourceMonth.ResourceId = ProjectResList.FirstOrDefault().ResourceId;
                            ProjectListFinal.ResourceMonth.ResourceName = ProjectResList.FirstOrDefault().ResourceName;// itemProject.ProjectName;
                            //ProjectListFinal.ResourceMonth.ProfilePicURL = ProjectResList.FirstOrDefault().ProfilePicURL;
                            if (CommonFunctions.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(ProjectResList.FirstOrDefault().ProfilePicURL)))
                                ProjectListFinal.ResourceMonth.ProfilePicURL = ProjectResList.FirstOrDefault().ProfilePicURL;
                            else
                                ProjectListFinal.ResourceMonth.ProfilePicURL = "../../../Images/NoPreview.gif";

                            ProjectListFinal.ResourceMonth.Designation = ProjectResList.FirstOrDefault().Designation;
                            RrResourceList.Add(ProjectListFinal);

                        }
                    }
                    else
                    {
                        var MonthSummaryList = RrResorceList.GroupBy(y => y.ResourceId).Select(cpsummary =>
                                 new RrResourcetMonths
                                 {
                                     ResourceId = cpsummary.Key,
                                     Month_1 = cpsummary.Sum(x => x.Month_1),
                                     Month_Ah1 = cpsummary.Sum(x => x.Month_Ah1),
                                     Month_2 = cpsummary.Sum(x => x.Month_2),
                                     Month_Ah2 = cpsummary.Sum(x => x.Month_Ah2),
                                     Month_3 = cpsummary.Sum(x => x.Month_3),
                                     Month_Ah3 = cpsummary.Sum(x => x.Month_Ah3),
                                     Month_4 = cpsummary.Sum(x => x.Month_4),
                                     Month_Ah4 = cpsummary.Sum(x => x.Month_Ah4),
                                     Month_5 = cpsummary.Sum(x => x.Month_5),
                                     Month_Ah5 = cpsummary.Sum(x => x.Month_Ah5),
                                     Month_6 = cpsummary.Sum(x => x.Month_6),
                                     Month_Ah6 = cpsummary.Sum(x => x.Month_Ah6),
                                     Month_7 = cpsummary.Sum(x => x.Month_7),
                                     Month_Ah7 = cpsummary.Sum(x => x.Month_Ah7),
                                     Month_8 = cpsummary.Sum(x => x.Month_8),
                                     Month_Ah8 = cpsummary.Sum(x => x.Month_Ah8),
                                     Month_9 = cpsummary.Sum(x => x.Month_9),
                                     Month_Ah9 = cpsummary.Sum(x => x.Month_Ah9),
                                     Month_10 = cpsummary.Sum(x => x.Month_10),
                                     Month_Ah10 = cpsummary.Sum(x => x.Month_Ah10),
                                     Month_11 = cpsummary.Sum(x => x.Month_11),
                                     Month_Ah11 = cpsummary.Sum(x => x.Month_Ah11),
                                     Month_12 = cpsummary.Sum(x => x.Month_12),
                                     Month_Ah12 = cpsummary.Sum(x => x.Month_Ah12),
                                 });

                        RrProjectLitForTotalSum = new RrResourcMonths()
                        {
                            //ResourceId= RrResorceList.FirstOrDefault().ResourceId,
                            Month_1 = RrResorceList.Sum(x => x.Month_1),
                            Month_Ah1 = RrResorceList.Sum(x => x.Month_Ah1),
                            Month_2 = RrResorceList.Sum(x => x.Month_2),
                            Month_Ah2 = RrResorceList.Sum(x => x.Month_Ah2),
                            Month_3 = RrResorceList.Sum(x => x.Month_3),
                            Month_Ah3 = RrResorceList.Sum(x => x.Month_Ah3),
                            Month_4 = RrResorceList.Sum(x => x.Month_4),
                            Month_Ah4 = RrResorceList.Sum(x => x.Month_Ah4),
                            Month_5 = RrResorceList.Sum(x => x.Month_5),
                            Month_Ah5 = RrResorceList.Sum(x => x.Month_Ah5),
                            Month_6 = RrResorceList.Sum(x => x.Month_6),
                            Month_Ah6 = RrResorceList.Sum(x => x.Month_Ah6),
                            Month_7 = RrResorceList.Sum(x => x.Month_7),
                            Month_Ah7 = RrResorceList.Sum(x => x.Month_Ah7),
                            Month_8 = RrResorceList.Sum(x => x.Month_8),
                            Month_Ah8 = RrResorceList.Sum(x => x.Month_Ah8),
                            Month_9 = RrResorceList.Sum(x => x.Month_9),
                            Month_Ah9 = RrResorceList.Sum(x => x.Month_Ah9),
                            Month_10 = RrResorceList.Sum(x => x.Month_10),
                            Month_Ah10 = RrResorceList.Sum(x => x.Month_Ah10),
                            Month_11 = RrResorceList.Sum(x => x.Month_11),
                            Month_Ah11 = RrResorceList.Sum(x => x.Month_Ah11),
                            Month_12 = RrResorceList.Sum(x => x.Month_12),
                            Month_Ah12 = RrResorceList.Sum(x => x.Month_Ah12)
                        };

                        foreach (var itemProject in MonthSummaryList)
                        {
                            var ProjectListFinal = new Rr_ResourceWiseList();
                            ProjectListFinal.ResourceMonth = MonthSummaryList.Where(x => x.ResourceId == itemProject.ResourceId).FirstOrDefault();
                            ProjectListFinal.ResourceMonth.RrRList = new List<RrResourcMonths>();

                            var ProjectResList = RrResorceList.Where(x => x.ResourceId == itemProject.ResourceId).ToList();
                            //ProjectListFinal.ProjectMonth.RrResourceList= new RrResourcMonths();
                            ProjectListFinal.ResourceMonth.RrRList.AddRange(ProjectResList);
                            ProjectListFinal.ResourceMonth.ResourceId = ProjectResList.FirstOrDefault().ResourceId;
                            ProjectListFinal.ResourceMonth.ResourceName = ProjectResList.FirstOrDefault().ResourceName;// itemProject.ProjectName;
                                                                                                                       // ProjectListFinal.ResourceMonth.ProfilePicURL = ProjectResList.FirstOrDefault().ProfilePicURL;
                            if (CommonFunctions.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(ProjectResList.FirstOrDefault().ProfilePicURL)))
                                ProjectListFinal.ResourceMonth.ProfilePicURL = ProjectResList.FirstOrDefault().ProfilePicURL;
                            else
                                ProjectListFinal.ResourceMonth.ProfilePicURL = "../../../Images/NoPreview.gif";

                            ProjectListFinal.ResourceMonth.Designation = ProjectResList.FirstOrDefault().Designation;
                            RrResourceList.Add(ProjectListFinal);

                        }
                    }

                }
            }
            ObjRr_ResourceProjectwisemonth Obj = new ObjRr_ResourceProjectwisemonth();
            Obj.RrResourceListmonth = RrResourceList;
            Obj.RrProjectLitForTotalSummonth = RrProjectLitForTotalSum;
            Obj.columnNames = columnNames;
            return Obj;

        }

        #region ProjectHalfYear
        private RrResourcHalfYear GetRrResourceHalfYear(DataRow TblRows, string Name = null)
        {
            var RrProjectHalfYear = new RrResourcHalfYear();
            RrProjectHalfYear.ResourceId = Convert.ToInt16(TblRows["ResourceId"]);
            RrProjectHalfYear.ProjectId = Convert.ToInt16(TblRows["ProjectId"]);
            RrProjectHalfYear.ResourceName = !string.IsNullOrEmpty(Name) ? Name : TblRows["ResourceName"].ToString();
            RrProjectHalfYear.ProjectName = !string.IsNullOrEmpty(Name) ? Name : TblRows["ProjectName"].ToString();
            RrProjectHalfYear.Month_1 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[4], "0"));
            RrProjectHalfYear.Month_Ah1 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[5], "0"));
            RrProjectHalfYear.Month_2 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[6], "0"));
            RrProjectHalfYear.Month_Ah2 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[7], "0"));
            RrProjectHalfYear.Month_3 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[8], "0"));
            RrProjectHalfYear.Month_Ah3 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[9], "0"));
            RrProjectHalfYear.Month_4 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[10], "0"));
            RrProjectHalfYear.Month_Ah4 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[11], "0"));
            RrProjectHalfYear.Month_5 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[12], "0"));
            RrProjectHalfYear.Month_Ah5 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[13], "0"));
            RrProjectHalfYear.Month_6 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[14], "0"));
            RrProjectHalfYear.Month_Ah6 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[15], "0"));
            //RrProjectHalfYear.ProfilePicURL = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TblRows[18], ""));
            if (CommonFunctions.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TblRows[18], "")))))
                RrProjectHalfYear.ProfilePicURL = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TblRows[18], ""));
            else
                RrProjectHalfYear.ProfilePicURL = "../../../Images/NoPreview.gif";

            RrProjectHalfYear.Designation = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TblRows[19], ""));
            return RrProjectHalfYear;
        }

        private ObjRr_Projectwisehalfyear GetRrProjectwiseHalfYear(DataSet CapacityPlanDSet, string ReportIn)
        {
            List<string> columnNames = null;
            var RrProjectLitForTotalSumhalfyear = new RrResourcHalfYear();
            var RrProjectListhalfyear = new List<Rr_ProjectWiseListHalfYear>();
            columnNames = new List<string>();
            var splitlist = CapacityPlanDSet.Tables[1].Rows[0][0].ToString().Split(',').ToList();

            foreach (var itemHeader in splitlist)
            {
                if (!string.IsNullOrEmpty(itemHeader))
                    columnNames.Add(itemHeader);
            }

            DataTable ResourceTable = CapacityPlanDSet.Tables[0];
            if (ResourceTable.Rows.Count > 0)
            {
                if (ResourceTable != null && ResourceTable.Rows.Count > 0)
                {
                    var RrResorceList = new List<RrResourcHalfYear>();
                    foreach (DataRow itemResource in ResourceTable.Rows)
                    {
                        RrResorceList.Add(GetRrResourceHalfYear(itemResource, string.Empty));
                    }

                    if (ReportIn == "0")
                    {
                        var MonthSummaryList = RrResorceList.GroupBy(y => y.ProjectId).Select(cpsummary =>
                                  new RrProjectHalfYear
                                  {
                                      ProjectId = cpsummary.Key,
                                      Month_1 = Math.Round(cpsummary.Average(x => x.Month_1), 2),
                                      Month_Ah1 = Math.Round(cpsummary.Average(x => x.Month_Ah1), 2),
                                      Month_2 = Math.Round(cpsummary.Average(x => x.Month_2), 2),
                                      Month_Ah2 = Math.Round(cpsummary.Average(x => x.Month_Ah2), 2),
                                      Month_3 = Math.Round(cpsummary.Average(x => x.Month_3), 2),
                                      Month_Ah3 = Math.Round(cpsummary.Average(x => x.Month_Ah3), 2),
                                      Month_4 = Math.Round(cpsummary.Average(x => x.Month_4), 2),
                                      Month_Ah4 = Math.Round(cpsummary.Average(x => x.Month_Ah4), 2),
                                      Month_5 = Math.Round(cpsummary.Average(x => x.Month_5), 2),
                                      Month_Ah5 = Math.Round(cpsummary.Average(x => x.Month_Ah5), 2),
                                      Month_6 = Math.Round(cpsummary.Average(x => x.Month_6), 2),
                                      Month_Ah6 = Math.Round(cpsummary.Average(x => x.Month_Ah6), 2),

                                  });

                        RrProjectLitForTotalSumhalfyear = new RrResourcHalfYear()
                        {
                            //ResourceId= RrResorceList.FirstOrDefault().ResourceId,
                            Month_1 = Math.Round(MonthSummaryList.Average(x => x.Month_1), 2),
                            Month_Ah1 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah1), 2),
                            Month_2 = Math.Round(MonthSummaryList.Average(x => x.Month_2), 2),
                            Month_Ah2 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah2), 2),
                            Month_3 = Math.Round(MonthSummaryList.Average(x => x.Month_3), 2),
                            Month_Ah3 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah3), 2),
                            Month_4 = Math.Round(MonthSummaryList.Average(x => x.Month_4), 2),
                            Month_Ah4 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah4), 2),
                            Month_5 = Math.Round(MonthSummaryList.Average(x => x.Month_5), 2),
                            Month_Ah5 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah5), 2),
                            Month_6 = Math.Round(MonthSummaryList.Average(x => x.Month_6), 2),
                            Month_Ah6 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah6), 2),

                        };

                        foreach (var itemProject in MonthSummaryList)
                        {
                            var ProjectListFinal = new Rr_ProjectWiseListHalfYear();
                            ProjectListFinal.ProjectHalfYear = MonthSummaryList.Where(x => x.ProjectId == itemProject.ProjectId).FirstOrDefault();
                            ProjectListFinal.ProjectHalfYear.RrResourceList = new List<RrResourcHalfYear>();

                            var ProjectResList = RrResorceList.Where(x => x.ProjectId == itemProject.ProjectId).ToList();
                            //ProjectListFinal.ProjectMonth.RrResourceList= new RrResourcMonths();
                            ProjectListFinal.ProjectHalfYear.RrResourceList.AddRange(ProjectResList);
                            ProjectListFinal.ProjectHalfYear.ProjectId = ProjectResList.FirstOrDefault().ProjectId;
                            ProjectListFinal.ProjectHalfYear.ProjectName = ProjectResList.FirstOrDefault().ProjectName;// itemProject.ProjectName;
                            ///Add total  sum
                            RrProjectListhalfyear.Add(ProjectListFinal);

                        }
                    }
                    else
                    {
                        var MonthSummaryList = RrResorceList.GroupBy(y => y.ProjectId).Select(cpsummary =>
                                  new RrProjectHalfYear
                                  {
                                      ProjectId = cpsummary.Key,
                                      Month_1 = cpsummary.Sum(x => x.Month_1),
                                      Month_Ah1 = cpsummary.Sum(x => x.Month_Ah1),
                                      Month_2 = cpsummary.Sum(x => x.Month_2),
                                      Month_Ah2 = cpsummary.Sum(x => x.Month_Ah2),
                                      Month_3 = cpsummary.Sum(x => x.Month_3),
                                      Month_Ah3 = cpsummary.Sum(x => x.Month_Ah3),
                                      Month_4 = cpsummary.Sum(x => x.Month_4),
                                      Month_Ah4 = cpsummary.Sum(x => x.Month_Ah4),
                                      Month_5 = cpsummary.Sum(x => x.Month_5),
                                      Month_Ah5 = cpsummary.Sum(x => x.Month_Ah5),
                                      Month_6 = cpsummary.Sum(x => x.Month_6),
                                      Month_Ah6 = cpsummary.Sum(x => x.Month_Ah6),

                                  });

                        RrProjectLitForTotalSumhalfyear = new RrResourcHalfYear()
                        {
                            //ResourceId= RrResorceList.FirstOrDefault().ResourceId,
                            Month_1 = RrResorceList.Sum(x => x.Month_1),
                            Month_Ah1 = RrResorceList.Sum(x => x.Month_Ah1),
                            Month_2 = RrResorceList.Sum(x => x.Month_2),
                            Month_Ah2 = RrResorceList.Sum(x => x.Month_Ah2),
                            Month_3 = RrResorceList.Sum(x => x.Month_3),
                            Month_Ah3 = RrResorceList.Sum(x => x.Month_Ah3),
                            Month_4 = RrResorceList.Sum(x => x.Month_4),
                            Month_Ah4 = RrResorceList.Sum(x => x.Month_Ah4),
                            Month_5 = RrResorceList.Sum(x => x.Month_5),
                            Month_Ah5 = RrResorceList.Sum(x => x.Month_Ah5),
                            Month_6 = RrResorceList.Sum(x => x.Month_6),
                            Month_Ah6 = RrResorceList.Sum(x => x.Month_Ah6),

                        };

                        foreach (var itemProject in MonthSummaryList)
                        {
                            var ProjectListFinal = new Rr_ProjectWiseListHalfYear();
                            ProjectListFinal.ProjectHalfYear = MonthSummaryList.Where(x => x.ProjectId == itemProject.ProjectId).FirstOrDefault();
                            ProjectListFinal.ProjectHalfYear.RrResourceList = new List<RrResourcHalfYear>();

                            var ProjectResList = RrResorceList.Where(x => x.ProjectId == itemProject.ProjectId).ToList();
                            //ProjectListFinal.ProjectMonth.RrResourceList= new RrResourcMonths();
                            ProjectListFinal.ProjectHalfYear.RrResourceList.AddRange(ProjectResList);
                            ProjectListFinal.ProjectHalfYear.ProjectId = ProjectResList.FirstOrDefault().ProjectId;
                            ProjectListFinal.ProjectHalfYear.ProjectName = ProjectResList.FirstOrDefault().ProjectName;// itemProject.ProjectName;
                            ///Add total  sum
                            RrProjectListhalfyear.Add(ProjectListFinal);

                        }
                    }
                }
            }
            ObjRr_Projectwisehalfyear Obj = new ObjRr_Projectwisehalfyear();
            Obj.RrProjectListhalfyear = RrProjectListhalfyear;
            Obj.RrProjectLitForTotalSumhalfyear = RrProjectLitForTotalSumhalfyear;
            Obj.columnNames = columnNames;
            return Obj;
        }
        #endregion
        #region ResourceHalfYear
        private ObjRr_Projectwisehalfyear GetRrResourcwiseHalfYear(DataSet CapacityPlanDSet, string ReportIn)
        {
            List<string> columnNames = null;
            var RrResourceLitForTotalSumhalfyear = new RrResourcHalfYear();
            var RrResourceListhalfyear = new List<Rr_ResourceWiseListHalfYear>();
            columnNames = new List<string>();
            //  columnNames.AddRange(CapacityPlanDSet.Tables[1].Rows[0][0].ToString().Split(','));
            var splitlist = CapacityPlanDSet.Tables[1].Rows[0][0].ToString().Split(',').ToList();

            foreach (var itemHeader in splitlist)
            {
                if (!string.IsNullOrEmpty(itemHeader))
                    columnNames.Add(itemHeader);
            }

            DataTable ResourceTable = CapacityPlanDSet.Tables[0];
            if (ResourceTable.Rows.Count > 0)
            {
                if (ResourceTable != null && ResourceTable.Rows.Count > 0)
                {
                    var RrResorceList = new List<RrResourcHalfYear>();
                    foreach (DataRow itemResource in ResourceTable.Rows)
                    {
                        RrResorceList.Add(GetRrResourceHalfYear(itemResource, string.Empty));
                    }
                    if (ReportIn == "0")
                    {
                        var MonthSummaryList = RrResorceList.GroupBy(y => y.ResourceId).Select(cpsummary =>
                                  new RrByResourctHalfYear
                                  {
                                      ResourceId = cpsummary.Key,
                                      Month_1 = Math.Round(cpsummary.Average(x => x.Month_1), 2),
                                      Month_Ah1 = Math.Round(cpsummary.Average(x => x.Month_Ah1), 2),
                                      Month_2 = Math.Round(cpsummary.Average(x => x.Month_2), 2),
                                      Month_Ah2 = Math.Round(cpsummary.Average(x => x.Month_Ah2), 2),
                                      Month_3 = Math.Round(cpsummary.Average(x => x.Month_3), 2),
                                      Month_Ah3 = Math.Round(cpsummary.Average(x => x.Month_Ah3), 2),
                                      Month_4 = Math.Round(cpsummary.Average(x => x.Month_4), 2),
                                      Month_Ah4 = Math.Round(cpsummary.Average(x => x.Month_Ah4), 2),
                                      Month_5 = Math.Round(cpsummary.Average(x => x.Month_5), 2),
                                      Month_Ah5 = Math.Round(cpsummary.Average(x => x.Month_Ah5), 2),
                                      Month_6 = Math.Round(cpsummary.Average(x => x.Month_6), 2),
                                      Month_Ah6 = Math.Round(cpsummary.Average(x => x.Month_Ah6), 2),

                                  });

                        RrResourceLitForTotalSumhalfyear = new RrResourcHalfYear()
                        {
                            //ResourceId= RrResorceList.FirstOrDefault().ResourceId,
                            Month_1 = Math.Round(MonthSummaryList.Average(x => x.Month_1), 2),
                            Month_Ah1 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah1), 2),
                            Month_2 = Math.Round(MonthSummaryList.Average(x => x.Month_2), 2),
                            Month_Ah2 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah2), 2),
                            Month_3 = Math.Round(MonthSummaryList.Average(x => x.Month_3), 2),
                            Month_Ah3 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah3), 2),
                            Month_4 = Math.Round(MonthSummaryList.Average(x => x.Month_4), 2),
                            Month_Ah4 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah4), 2),
                            Month_5 = Math.Round(MonthSummaryList.Average(x => x.Month_5), 2),
                            Month_Ah5 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah5), 2),
                            Month_6 = Math.Round(MonthSummaryList.Average(x => x.Month_6), 2),
                            Month_Ah6 = Math.Round(MonthSummaryList.Average(x => x.Month_Ah6), 2),

                        };

                        foreach (var itemProject in MonthSummaryList)
                        {
                            var ProjectListFinal = new Rr_ResourceWiseListHalfYear();
                            ProjectListFinal.ResourceHalfYear = MonthSummaryList.Where(x => x.ResourceId == itemProject.ResourceId).FirstOrDefault();
                            ProjectListFinal.ResourceHalfYear.RrProjectList = new List<RrResourcHalfYear>();

                            var ProjectResList = RrResorceList.Where(x => x.ResourceId == itemProject.ResourceId).ToList();
                            //ProjectListFinal.ProjectMonth.RrResourceList= new RrResourcMonths();
                            ProjectListFinal.ResourceHalfYear.RrProjectList.AddRange(ProjectResList);
                            ProjectListFinal.ResourceHalfYear.ResourceId = ProjectResList.FirstOrDefault().ResourceId;
                            ProjectListFinal.ResourceHalfYear.ResourceName = ProjectResList.FirstOrDefault().ResourceName;
                            //ProjectListFinal.ResourceHalfYear.ProfilePicURL = ProjectResList.FirstOrDefault().ProfilePicURL;
                            if (CommonFunctions.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(ProjectResList.FirstOrDefault().ProfilePicURL)))
                                ProjectListFinal.ResourceHalfYear.ProfilePicURL = ProjectResList.FirstOrDefault().ProfilePicURL;
                            else
                                ProjectListFinal.ResourceHalfYear.ProfilePicURL = "../../../Images/NoPreview.gif";

                            ProjectListFinal.ResourceHalfYear.Designation = ProjectResList.FirstOrDefault().Designation;
                            // itemProject.ProjectName;
                            RrResourceListhalfyear.Add(ProjectListFinal);

                        }
                    }
                    else
                    {
                        var MonthSummaryList = RrResorceList.GroupBy(y => y.ResourceId).Select(cpsummary =>
                                 new RrByResourctHalfYear
                                 {
                                     ResourceId = cpsummary.Key,
                                     Month_1 = cpsummary.Sum(x => x.Month_1),
                                     Month_Ah1 = cpsummary.Sum(x => x.Month_Ah1),
                                     Month_2 = cpsummary.Sum(x => x.Month_2),
                                     Month_Ah2 = cpsummary.Sum(x => x.Month_Ah2),
                                     Month_3 = cpsummary.Sum(x => x.Month_3),
                                     Month_Ah3 = cpsummary.Sum(x => x.Month_Ah3),
                                     Month_4 = cpsummary.Sum(x => x.Month_4),
                                     Month_Ah4 = cpsummary.Sum(x => x.Month_Ah4),
                                     Month_5 = cpsummary.Sum(x => x.Month_5),
                                     Month_Ah5 = cpsummary.Sum(x => x.Month_Ah5),
                                     Month_6 = cpsummary.Sum(x => x.Month_6),
                                     Month_Ah6 = cpsummary.Sum(x => x.Month_Ah6),

                                 });

                        RrResourceLitForTotalSumhalfyear = new RrResourcHalfYear()
                        {
                            //ResourceId= RrResorceList.FirstOrDefault().ResourceId,
                            Month_1 = RrResorceList.Sum(x => x.Month_1),
                            Month_Ah1 = RrResorceList.Sum(x => x.Month_Ah1),
                            Month_2 = RrResorceList.Sum(x => x.Month_2),
                            Month_Ah2 = RrResorceList.Sum(x => x.Month_Ah2),
                            Month_3 = RrResorceList.Sum(x => x.Month_3),
                            Month_Ah3 = RrResorceList.Sum(x => x.Month_Ah3),
                            Month_4 = RrResorceList.Sum(x => x.Month_4),
                            Month_Ah4 = RrResorceList.Sum(x => x.Month_Ah4),
                            Month_5 = RrResorceList.Sum(x => x.Month_5),
                            Month_Ah5 = RrResorceList.Sum(x => x.Month_Ah5),
                            Month_6 = RrResorceList.Sum(x => x.Month_6),
                            Month_Ah6 = RrResorceList.Sum(x => x.Month_Ah6),

                        };

                        foreach (var itemProject in MonthSummaryList)
                        {
                            var ProjectListFinal = new Rr_ResourceWiseListHalfYear();
                            ProjectListFinal.ResourceHalfYear = MonthSummaryList.Where(x => x.ResourceId == itemProject.ResourceId).FirstOrDefault();
                            ProjectListFinal.ResourceHalfYear.RrProjectList = new List<RrResourcHalfYear>();

                            var ProjectResList = RrResorceList.Where(x => x.ResourceId == itemProject.ResourceId).ToList();
                            //ProjectListFinal.ProjectMonth.RrResourceList= new RrResourcMonths();
                            ProjectListFinal.ResourceHalfYear.RrProjectList.AddRange(ProjectResList);
                            ProjectListFinal.ResourceHalfYear.ResourceId = ProjectResList.FirstOrDefault().ResourceId;
                            ProjectListFinal.ResourceHalfYear.ResourceName = ProjectResList.FirstOrDefault().ResourceName;
                            //ProjectListFinal.ResourceHalfYear.ProfilePicURL = ProjectResList.FirstOrDefault().ProfilePicURL;
                            if (CommonFunctions.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(ProjectResList.FirstOrDefault().ProfilePicURL)))
                                ProjectListFinal.ResourceHalfYear.ProfilePicURL = ProjectResList.FirstOrDefault().ProfilePicURL;
                            else
                                ProjectListFinal.ResourceHalfYear.ProfilePicURL = "../../../Images/NoPreview.gif";

                            ProjectListFinal.ResourceHalfYear.Designation = ProjectResList.FirstOrDefault().Designation;
                            // itemProject.ProjectName;
                            RrResourceListhalfyear.Add(ProjectListFinal);

                        }
                    }
                }
            }
            ObjRr_Projectwisehalfyear Obj = new ObjRr_Projectwisehalfyear();
            Obj.RrResourceListhalfyear = RrResourceListhalfyear;
            Obj.RrProjectLitForTotalSumhalfyear = RrResourceLitForTotalSumhalfyear;
            Obj.columnNames = columnNames;
            return Obj;
        }
        #endregion
        #region ProjectResourceQuarterWise
        private RrResourcQuarter GetRrResourceQuarter(DataRow TblRows, string Name = null)
        {
            var RrProjectQuarter = new RrResourcQuarter();
            RrProjectQuarter.ResourceId = Convert.ToInt16(TblRows["ResourceId"]);
            RrProjectQuarter.ProjectId = Convert.ToInt16(TblRows["ProjectId"]);
            RrProjectQuarter.ResourceName = !string.IsNullOrEmpty(Name) ? Name : TblRows["ResourceName"].ToString();
            RrProjectQuarter.ProjectName = !string.IsNullOrEmpty(Name) ? Name : TblRows["ProjectName"].ToString();
            RrProjectQuarter.Q1 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[4], "0"));
            RrProjectQuarter.Q1_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[5], "0"));
            RrProjectQuarter.Q2 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[6], "0"));
            RrProjectQuarter.Q2_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[7], "0"));
            RrProjectQuarter.Q3 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[8], "0"));
            RrProjectQuarter.Q3_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[9], "0"));
            RrProjectQuarter.Q4 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[10], "0"));
            RrProjectQuarter.Q4_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[11], "0"));
            //RrProjectQuarter.ProfilePicURL = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TblRows[14], ""));
            if (CommonFunctions.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TblRows[14], "")))))
                RrProjectQuarter.ProfilePicURL = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TblRows[14], ""));
            else
                RrProjectQuarter.ProfilePicURL = "../../../Images/NoPreview.gif";

            RrProjectQuarter.Designation = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TblRows[15], ""));

            return RrProjectQuarter;
        }

        private ObjRr_ProjectwiseQuarter GetRrProjectWiseQuarter(DataSet CapacityPlanDSet, string ReportIn)
        {
            List<string> columnNames = null;
            var RrProjectLitForTotalSumQuarter = new RrResourcQuarter();
            var RrProjectListQuarter = new List<Rr_ProjectWiseListQuarter>();
            columnNames = new List<string>();
            //foreach (DataRow itemHeader in CapacityPlanDSet.Tables[1].Rows)
            //{
            //    columnNames.Add(Convert.ToString(itemHeader["MonthName"]));
            //}

            DataTable ResourceTable = CapacityPlanDSet.Tables[0];
            if (ResourceTable.Rows.Count > 0)
            {
                if (ResourceTable != null && ResourceTable.Rows.Count > 0)
                {
                    var RrResorceList = new List<RrResourcQuarter>();
                    foreach (DataRow itemResource in ResourceTable.Rows)
                    {
                        RrResorceList.Add(GetRrResourceQuarter(itemResource, string.Empty));
                    }

                    if (ReportIn == "0")
                    {
                        var MonthSummaryList = RrResorceList.GroupBy(y => y.ProjectId).Select(cpsummary =>
                                      new RrProjectQuarter
                                      {
                                          ProjectId = cpsummary.Key,
                                          Q1 = Math.Round(cpsummary.Average(x => x.Q1), 2),
                                          Q1_Ah = Math.Round(cpsummary.Average(x => x.Q1_Ah), 2),
                                          Q2 = Math.Round(cpsummary.Average(x => x.Q2), 2),
                                          Q2_Ah = Math.Round(cpsummary.Average(x => x.Q2_Ah), 2),
                                          Q3 = Math.Round(cpsummary.Average(x => x.Q3), 2),
                                          Q3_Ah = Math.Round(cpsummary.Average(x => x.Q3_Ah), 2),
                                          Q4 = Math.Round(cpsummary.Average(x => x.Q4), 2),
                                          Q4_Ah = Math.Round(cpsummary.Average(x => x.Q4_Ah), 2),
                                      });

                        RrProjectLitForTotalSumQuarter = new RrResourcQuarter()
                        {
                            //ResourceId= RrResorceList.FirstOrDefault().ResourceId,
                            Q1 = Math.Round(MonthSummaryList.Average(x => x.Q1), 2),
                            Q1_Ah = Math.Round(MonthSummaryList.Average(x => x.Q1_Ah), 2),
                            Q2 = Math.Round(MonthSummaryList.Average(x => x.Q2), 2),
                            Q2_Ah = Math.Round(MonthSummaryList.Average(x => x.Q2_Ah), 2),
                            Q3 = Math.Round(MonthSummaryList.Average(x => x.Q3), 2),
                            Q3_Ah = Math.Round(MonthSummaryList.Average(x => x.Q3_Ah), 2),
                            Q4 = Math.Round(MonthSummaryList.Average(x => x.Q4), 2),
                            Q4_Ah = Math.Round(MonthSummaryList.Average(x => x.Q4_Ah), 2),
                        };

                        foreach (var itemProject in MonthSummaryList)
                        {
                            var ProjectListFinal = new Rr_ProjectWiseListQuarter();
                            ProjectListFinal.ProjectQuarter = MonthSummaryList.Where(x => x.ProjectId == itemProject.ProjectId).FirstOrDefault();
                            ProjectListFinal.ProjectQuarter.RrResourceList = new List<RrResourcQuarter>();

                            var ProjectResList = RrResorceList.Where(x => x.ProjectId == itemProject.ProjectId).ToList();
                            //ProjectListFinal.ProjectMonth.RrResourceList= new RrResourcMonths();
                            ProjectListFinal.ProjectQuarter.RrResourceList.AddRange(ProjectResList);
                            ProjectListFinal.ProjectQuarter.ProjectId = ProjectResList.FirstOrDefault().ProjectId;
                            ProjectListFinal.ProjectQuarter.ProjectName = ProjectResList.FirstOrDefault().ProjectName;// itemProject.ProjectName;
                            ///Add total  sum
                            RrProjectListQuarter.Add(ProjectListFinal);

                        }
                    }
                    else
                    {
                        var MonthSummaryList = RrResorceList.GroupBy(y => y.ProjectId).Select(cpsummary =>
                                      new RrProjectQuarter
                                      {
                                          ProjectId = cpsummary.Key,
                                          Q1 = cpsummary.Sum(x => x.Q1),
                                          Q1_Ah = cpsummary.Sum(x => x.Q1_Ah),
                                          Q2 = cpsummary.Sum(x => x.Q2),
                                          Q2_Ah = cpsummary.Sum(x => x.Q2_Ah),
                                          Q3 = cpsummary.Sum(x => x.Q3),
                                          Q3_Ah = cpsummary.Sum(x => x.Q3_Ah),
                                          Q4 = cpsummary.Sum(x => x.Q4),
                                          Q4_Ah = cpsummary.Sum(x => x.Q4_Ah),
                                      });

                        RrProjectLitForTotalSumQuarter = new RrResourcQuarter()
                        {
                            //ResourceId= RrResorceList.FirstOrDefault().ResourceId,
                            Q1 = RrResorceList.Sum(x => x.Q1),
                            Q1_Ah = RrResorceList.Sum(x => x.Q1_Ah),
                            Q2 = RrResorceList.Sum(x => x.Q2),
                            Q2_Ah = RrResorceList.Sum(x => x.Q2_Ah),
                            Q3 = RrResorceList.Sum(x => x.Q3),
                            Q3_Ah = RrResorceList.Sum(x => x.Q3_Ah),
                            Q4 = RrResorceList.Sum(x => x.Q4),
                            Q4_Ah = RrResorceList.Sum(x => x.Q4_Ah),
                        };

                        foreach (var itemProject in MonthSummaryList)
                        {
                            var ProjectListFinal = new Rr_ProjectWiseListQuarter();
                            ProjectListFinal.ProjectQuarter = MonthSummaryList.Where(x => x.ProjectId == itemProject.ProjectId).FirstOrDefault();
                            ProjectListFinal.ProjectQuarter.RrResourceList = new List<RrResourcQuarter>();

                            var ProjectResList = RrResorceList.Where(x => x.ProjectId == itemProject.ProjectId).ToList();
                            //ProjectListFinal.ProjectMonth.RrResourceList= new RrResourcMonths();
                            ProjectListFinal.ProjectQuarter.RrResourceList.AddRange(ProjectResList);
                            ProjectListFinal.ProjectQuarter.ProjectId = ProjectResList.FirstOrDefault().ProjectId;
                            ProjectListFinal.ProjectQuarter.ProjectName = ProjectResList.FirstOrDefault().ProjectName;// itemProject.ProjectName;
                            ///Add total  sum
                            RrProjectListQuarter.Add(ProjectListFinal);

                        }
                    }
                }
            }
            ObjRr_ProjectwiseQuarter Obj = new ObjRr_ProjectwiseQuarter();
            Obj.RrProjectListQuarter = RrProjectListQuarter;
            Obj.RrProjectLitForTotalSumQuarter = RrProjectLitForTotalSumQuarter;
            Obj.columnNames = columnNames;
            return Obj;
        }
        private ObjRr_ProjectwiseQuarter GetRrResourcwiseQuarter(DataSet CapacityPlanDSet, string ReportIn)
        {
            List<string> columnNames = null;
            var RrResourceLitForTotalSumQuarter = new RrResourcQuarter();
            var RrResourceListQuarter = new List<Rr_ResourceWiseListQuarter>();
            columnNames = new List<string>();
            //foreach (DataRow itemHeader in CapacityPlanDSet.Tables[1].Rows)
            //{
            //    columnNames.Add(Convert.ToString(itemHeader["MonthName"]));
            //}

            DataTable ResourceTable = CapacityPlanDSet.Tables[0];
            if (ResourceTable.Rows.Count > 0)
            {
                if (ResourceTable != null && ResourceTable.Rows.Count > 0)
                {
                    var RrResorceList = new List<RrResourcQuarter>();
                    foreach (DataRow itemResource in ResourceTable.Rows)
                    {
                        RrResorceList.Add(GetRrResourceQuarter(itemResource, string.Empty));
                    }
                    if (ReportIn == "0")
                    {
                        var MonthSummaryList = RrResorceList.GroupBy(y => y.ResourceId).Select(cpsummary =>
                                  new RrByResourctQuarter
                                  {
                                      ResourceId = cpsummary.Key,
                                      Q1 = Math.Round(cpsummary.Average(x => x.Q1), 2),
                                      Q1_Ah = Math.Round(cpsummary.Average(x => x.Q1_Ah), 2),
                                      Q2 = Math.Round(cpsummary.Average(x => x.Q2), 2),
                                      Q2_Ah = Math.Round(cpsummary.Average(x => x.Q2_Ah), 2),
                                      Q3 = Math.Round(cpsummary.Average(x => x.Q3), 2),
                                      Q3_Ah = Math.Round(cpsummary.Average(x => x.Q3_Ah), 2),
                                      Q4 = Math.Round(cpsummary.Average(x => x.Q4), 2),
                                      Q4_Ah = Math.Round(cpsummary.Average(x => x.Q4_Ah), 2),

                                  });

                        RrResourceLitForTotalSumQuarter = new RrResourcQuarter()
                        {
                            //ResourceId= RrResorceList.FirstOrDefault().ResourceId,
                            Q1 = Math.Round(MonthSummaryList.Average(x => x.Q1), 2),
                            Q1_Ah = Math.Round(MonthSummaryList.Average(x => x.Q1_Ah), 2),
                            Q2 = Math.Round(MonthSummaryList.Average(x => x.Q2), 2),
                            Q2_Ah = Math.Round(MonthSummaryList.Average(x => x.Q2_Ah), 2),
                            Q3 = Math.Round(MonthSummaryList.Average(x => x.Q3), 2),
                            Q3_Ah = Math.Round(MonthSummaryList.Average(x => x.Q3_Ah), 2),
                            Q4 = Math.Round(MonthSummaryList.Average(x => x.Q4), 2),
                            Q4_Ah = Math.Round(MonthSummaryList.Average(x => x.Q4_Ah), 2),

                        };

                        foreach (var itemProject in MonthSummaryList)
                        {
                            var ProjectListFinal = new Rr_ResourceWiseListQuarter();
                            ProjectListFinal.ResourceQuarter = MonthSummaryList.Where(x => x.ResourceId == itemProject.ResourceId).FirstOrDefault();
                            ProjectListFinal.ResourceQuarter.RrProjectList = new List<RrResourcQuarter>();

                            var ProjectResList = RrResorceList.Where(x => x.ResourceId == itemProject.ResourceId).ToList();
                            //ProjectListFinal.ProjectMonth.RrResourceList= new RrResourcMonths();
                            ProjectListFinal.ResourceQuarter.RrProjectList.AddRange(ProjectResList);
                            ProjectListFinal.ResourceQuarter.ResourceId = ProjectResList.FirstOrDefault().ResourceId;
                            ProjectListFinal.ResourceQuarter.ResourceName = ProjectResList.FirstOrDefault().ResourceName;// itemProject.ProjectName;
                            //ProjectListFinal.ResourceQuarter.ProfilePicURL = ProjectResList.FirstOrDefault().ProfilePicURL;
                            if (CommonFunctions.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(ProjectResList.FirstOrDefault().ProfilePicURL)))
                                ProjectListFinal.ResourceQuarter.ProfilePicURL = ProjectResList.FirstOrDefault().ProfilePicURL;
                            else
                                ProjectListFinal.ResourceQuarter.ProfilePicURL = "../../../Images/NoPreview.gif";

                            ProjectListFinal.ResourceQuarter.Designation = ProjectResList.FirstOrDefault().Designation;
                            RrResourceListQuarter.Add(ProjectListFinal);

                        }
                    }
                    else
                    {
                        var MonthSummaryList = RrResorceList.GroupBy(y => y.ResourceId).Select(cpsummary =>
                                new RrByResourctQuarter
                                {
                                    ResourceId = cpsummary.Key,
                                    Q1 = cpsummary.Sum(x => x.Q1),
                                    Q1_Ah = cpsummary.Sum(x => x.Q1_Ah),
                                    Q2 = cpsummary.Sum(x => x.Q2),
                                    Q2_Ah = cpsummary.Sum(x => x.Q2_Ah),
                                    Q3 = cpsummary.Sum(x => x.Q3),
                                    Q3_Ah = cpsummary.Sum(x => x.Q3_Ah),
                                    Q4 = cpsummary.Sum(x => x.Q4),
                                    Q4_Ah = cpsummary.Sum(x => x.Q4_Ah),


                                });

                        RrResourceLitForTotalSumQuarter = new RrResourcQuarter()
                        {
                            //ResourceId= RrResorceList.FirstOrDefault().ResourceId,
                            Q1 = RrResorceList.Sum(x => x.Q1),
                            Q1_Ah = RrResorceList.Sum(x => x.Q1_Ah),
                            Q2 = RrResorceList.Sum(x => x.Q2),
                            Q2_Ah = RrResorceList.Sum(x => x.Q2_Ah),
                            Q3 = RrResorceList.Sum(x => x.Q3),
                            Q3_Ah = RrResorceList.Sum(x => x.Q3_Ah),
                            Q4 = RrResorceList.Sum(x => x.Q4),
                            Q4_Ah = RrResorceList.Sum(x => x.Q4_Ah),

                        };

                        foreach (var itemProject in MonthSummaryList)
                        {
                            var ProjectListFinal = new Rr_ResourceWiseListQuarter();
                            ProjectListFinal.ResourceQuarter = MonthSummaryList.Where(x => x.ResourceId == itemProject.ResourceId).FirstOrDefault();
                            ProjectListFinal.ResourceQuarter.RrProjectList = new List<RrResourcQuarter>();

                            var ProjectResList = RrResorceList.Where(x => x.ResourceId == itemProject.ResourceId).ToList();
                            //ProjectListFinal.ProjectMonth.RrResourceList= new RrResourcMonths();
                            ProjectListFinal.ResourceQuarter.RrProjectList.AddRange(ProjectResList);
                            ProjectListFinal.ResourceQuarter.ResourceId = ProjectResList.FirstOrDefault().ResourceId;
                            ProjectListFinal.ResourceQuarter.ResourceName = ProjectResList.FirstOrDefault().ResourceName;// itemProject.ProjectName;
                            //ProjectListFinal.ResourceQuarter.ProfilePicURL = ProjectResList.FirstOrDefault().ProfilePicURL;
                            if (CommonFunctions.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(ProjectResList.FirstOrDefault().ProfilePicURL)))
                                ProjectListFinal.ResourceQuarter.ProfilePicURL = ProjectResList.FirstOrDefault().ProfilePicURL;
                            else
                                ProjectListFinal.ResourceQuarter.ProfilePicURL = "../../../Images/NoPreview.gif";

                            ProjectListFinal.ResourceQuarter.Designation = ProjectResList.FirstOrDefault().Designation;
                            RrResourceListQuarter.Add(ProjectListFinal);

                        }
                    }
                }
            }
            ObjRr_ProjectwiseQuarter Obj = new ObjRr_ProjectwiseQuarter();
            Obj.RrResourceListQuarter = RrResourceListQuarter;
            Obj.RrProjectLitForTotalSumQuarter = RrResourceLitForTotalSumQuarter;
            Obj.columnNames = columnNames;
            return Obj;
        }
        #endregion
        #region ProjectResourceWeekWise
        private RrResourcWeek GetRrResourceWeek(DataRow TblRows, string Name = null)
        {
            var RrProjectQuarter = new RrResourcWeek();
            RrProjectQuarter.ResourceId = Convert.ToInt16(TblRows["ResourceId"]);
            RrProjectQuarter.ProjectId = Convert.ToInt16(TblRows["ProjectId"]);
            RrProjectQuarter.ResourceName = !string.IsNullOrEmpty(Name) ? Name : TblRows["ResourceName"].ToString();
            RrProjectQuarter.ProjectName = !string.IsNullOrEmpty(Name) ? Name : TblRows["ProjectName"].ToString();
            RrProjectQuarter.W1 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[4], "0"));
            RrProjectQuarter.W2 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[5], "0"));
            RrProjectQuarter.W3 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[6], "0"));
            RrProjectQuarter.W4 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[7], "0"));
            RrProjectQuarter.W5 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[8], "0"));
            RrProjectQuarter.W6 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[9], "0"));
            RrProjectQuarter.W7 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[10], "0"));
            RrProjectQuarter.W8 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[11], "0"));
            RrProjectQuarter.W9 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[12], "0"));
            RrProjectQuarter.W10 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[13], "0"));
            RrProjectQuarter.W11 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[14], "0"));
            RrProjectQuarter.W12 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[15], "0"));
            RrProjectQuarter.W13 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[16], "0"));
            RrProjectQuarter.W14 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[17], "0"));
            RrProjectQuarter.W15 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[18], "0"));
            RrProjectQuarter.W16 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[19], "0"));
            RrProjectQuarter.W17 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[20], "0"));
            RrProjectQuarter.W18 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[21], "0"));
            RrProjectQuarter.W19 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[22], "0"));
            RrProjectQuarter.W20 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[23], "0"));

            RrProjectQuarter.W21 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[24], "0"));
            RrProjectQuarter.W22 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[25], "0"));
            RrProjectQuarter.W23 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[26], "0"));
            RrProjectQuarter.W24 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[27], "0"));
            RrProjectQuarter.W25 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[28], "0"));
            RrProjectQuarter.W26 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[29], "0"));
            RrProjectQuarter.W27 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[30], "0"));
            RrProjectQuarter.W28 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[31], "0"));
            RrProjectQuarter.W29 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[32], "0"));
            RrProjectQuarter.W30 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[33], "0"));
            RrProjectQuarter.W31 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[34], "0"));
            RrProjectQuarter.W32 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[35], "0"));
            RrProjectQuarter.W33 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[36], "0"));
            RrProjectQuarter.W34 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[37], "0"));
            RrProjectQuarter.W35 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[38], "0"));
            RrProjectQuarter.W36 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[39], "0"));
            RrProjectQuarter.W37 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[40], "0"));
            RrProjectQuarter.W38 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[41], "0"));
            RrProjectQuarter.W39 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[42], "0"));
            RrProjectQuarter.W40 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[43], "0"));

            RrProjectQuarter.W41 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[44], "0"));
            RrProjectQuarter.W42 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[45], "0"));
            RrProjectQuarter.W43 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[46], "0"));
            RrProjectQuarter.W44 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[47], "0"));
            RrProjectQuarter.W45 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[48], "0"));
            RrProjectQuarter.W46 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[49], "0"));
            RrProjectQuarter.W47 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[50], "0"));
            RrProjectQuarter.W48 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[51], "0"));
            RrProjectQuarter.W49 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[52], "0"));
            RrProjectQuarter.W50 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[53], "0"));
            RrProjectQuarter.W51 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[54], "0"));
            RrProjectQuarter.W52 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[55], "0"));
            RrProjectQuarter.W53 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[56], "0"));

            RrProjectQuarter.W1_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[57], "0"));
            RrProjectQuarter.W2_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[58], "0"));
            RrProjectQuarter.W3_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[59], "0"));
            RrProjectQuarter.W4_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[60], "0"));
            RrProjectQuarter.W5_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[61], "0"));
            RrProjectQuarter.W6_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[62], "0"));
            RrProjectQuarter.W7_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[63], "0"));
            RrProjectQuarter.W8_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[64], "0"));
            RrProjectQuarter.W9_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[65], "0"));
            RrProjectQuarter.W10_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[66], "0"));
            RrProjectQuarter.W11_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[67], "0"));
            RrProjectQuarter.W12_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[68], "0"));
            RrProjectQuarter.W13_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[69], "0"));
            RrProjectQuarter.W15_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[70], "0"));
            RrProjectQuarter.W16_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[71], "0"));
            RrProjectQuarter.W17_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[72], "0"));
            RrProjectQuarter.W18_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[73], "0"));
            RrProjectQuarter.W19_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[74], "0"));
            RrProjectQuarter.W20_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[75], "0"));
            RrProjectQuarter.W21_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[76], "0"));
            RrProjectQuarter.W22_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[77], "0"));
            RrProjectQuarter.W23_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[78], "0"));
            RrProjectQuarter.W24_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[79], "0"));
            RrProjectQuarter.W25_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[80], "0"));
            RrProjectQuarter.W26_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[81], "0"));
            RrProjectQuarter.W27_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[82], "0"));
            RrProjectQuarter.W28_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[83], "0"));

            RrProjectQuarter.W29_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[84], "0"));
            RrProjectQuarter.W30_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[85], "0"));
            RrProjectQuarter.W31_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[86], "0"));
            RrProjectQuarter.W32_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[87], "0"));
            RrProjectQuarter.W33_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[88], "0"));
            RrProjectQuarter.W34_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[89], "0"));
            RrProjectQuarter.W35_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[90], "0"));
            RrProjectQuarter.W36_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[91], "0"));
            RrProjectQuarter.W37_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[92], "0"));
            RrProjectQuarter.W38_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[93], "0"));
            RrProjectQuarter.W39_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[94], "0"));
            RrProjectQuarter.W40_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[95], "0"));
            RrProjectQuarter.W41_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[96], "0"));
            RrProjectQuarter.W42_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[97], "0"));
            RrProjectQuarter.W43_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[98], "0"));
            RrProjectQuarter.W44_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[100], "0"));
            RrProjectQuarter.W45_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[101], "0"));
            RrProjectQuarter.W46_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[102], "0"));
            RrProjectQuarter.W47_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[103], "0"));
            RrProjectQuarter.W48_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[104], "0"));

            RrProjectQuarter.W49_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[105], "0"));
            RrProjectQuarter.W50_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[106], "0"));
            RrProjectQuarter.W51 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[107], "0"));
            RrProjectQuarter.W52_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[108], "0"));
            RrProjectQuarter.W53_Ah = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[109], "0"));
            //RrProjectQuarter.ProfilePicURL = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TblRows[112], ""));
            if (CommonFunctions.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TblRows[112], "")))))
                RrProjectQuarter.ProfilePicURL = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TblRows[112], ""));
            else
                RrProjectQuarter.ProfilePicURL = "../../../Images/NoPreview.gif";

            RrProjectQuarter.Designation = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TblRows[113], ""));
            return RrProjectQuarter;
        }

        private ObjRr_ProjectwiseWeek GetRrProjectWiseWeek(DataSet CapacityPlanDSet, string ReportIn)
        {
            List<string> columnNames = null;
            var RrProjectLitForTotalSumWeek = new RrResourcWeek();
            var RrProjectListWeek = new List<Rr_ProjectWiseListWeek>();
            columnNames = new List<string>();
            //foreach (DataRow itemHeader in CapacityPlanDSet.Tables[1].Rows)
            //{
            //    columnNames.Add(Convert.ToString(itemHeader["MonthName"]));
            //}

            DataTable ResourceTable = CapacityPlanDSet.Tables[0];
            if (ResourceTable.Rows.Count > 0)
            {
                if (ResourceTable != null && ResourceTable.Rows.Count > 0)
                {
                    var RrResorceList = new List<RrResourcWeek>();
                    foreach (DataRow itemResource in ResourceTable.Rows)
                    {
                        RrResorceList.Add(GetRrResourceWeek(itemResource, string.Empty));
                    }
                    if (ReportIn == "0")
                    {
                        var MonthSummaryList = RrResorceList.GroupBy(y => y.ProjectId).Select(cpsummary =>
                                  new RrProjectWeek
                                  {
                                      ProjectId = cpsummary.Key,
                                      W1 = Math.Round(cpsummary.Average(x => x.W1), 2),
                                      W1_Ah = Math.Round(cpsummary.Average(x => x.W1_Ah), 2),
                                      W2 = Math.Round(cpsummary.Average(x => x.W2), 2),
                                      W2_Ah = Math.Round(cpsummary.Average(x => x.W2_Ah), 2),
                                      W3 = Math.Round(cpsummary.Average(x => x.W3), 2),
                                      W3_Ah = Math.Round(cpsummary.Average(x => x.W3_Ah), 2),
                                      W4 = Math.Round(cpsummary.Average(x => x.W4), 2),
                                      W4_Ah = Math.Round(cpsummary.Average(x => x.W4_Ah), 2),
                                      W5 = Math.Round(cpsummary.Average(x => x.W5), 2),
                                      W5_Ah = Math.Round(cpsummary.Average(x => x.W5_Ah), 2),
                                      W6 = Math.Round(cpsummary.Average(x => x.W6), 2),
                                      W6_Ah = Math.Round(cpsummary.Average(x => x.W6_Ah), 2),
                                      W7 = Math.Round(cpsummary.Average(x => x.W7), 2),
                                      W7_Ah = Math.Round(cpsummary.Average(x => x.W7_Ah), 2),
                                      W8 = Math.Round(cpsummary.Average(x => x.W8), 2),
                                      W8_Ah = Math.Round(cpsummary.Average(x => x.W8_Ah), 2),
                                      W9 = Math.Round(cpsummary.Average(x => x.W9), 2),
                                      W9_Ah = Math.Round(cpsummary.Average(x => x.W9_Ah), 2),
                                      W10 = Math.Round(cpsummary.Average(x => x.W10), 2),
                                      W10_Ah = Math.Round(cpsummary.Average(x => x.W10_Ah), 2),

                                      W11 = Math.Round(cpsummary.Average(x => x.W11), 2),
                                      W11_Ah = Math.Round(cpsummary.Average(x => x.W11_Ah), 2),
                                      W12 = Math.Round(cpsummary.Average(x => x.W12), 2),
                                      W12_Ah = Math.Round(cpsummary.Average(x => x.W12_Ah), 2),
                                      W13 = Math.Round(cpsummary.Average(x => x.W13), 2),
                                      W13_Ah = Math.Round(cpsummary.Average(x => x.W13_Ah), 2),
                                      W14 = Math.Round(cpsummary.Average(x => x.W14), 2),
                                      W14_Ah = Math.Round(cpsummary.Average(x => x.W14_Ah), 2),
                                      W15 = Math.Round(cpsummary.Average(x => x.W15), 2),
                                      W15_Ah = Math.Round(cpsummary.Average(x => x.W15_Ah), 2),
                                      W16 = Math.Round(cpsummary.Average(x => x.W16), 2),
                                      W16_Ah = Math.Round(cpsummary.Average(x => x.W16_Ah), 2),
                                      W17 = Math.Round(cpsummary.Average(x => x.W17), 2),
                                      W17_Ah = Math.Round(cpsummary.Average(x => x.W17_Ah), 2),
                                      W18 = Math.Round(cpsummary.Average(x => x.W18), 2),
                                      W18_Ah = Math.Round(cpsummary.Average(x => x.W18_Ah), 2),
                                      W19 = Math.Round(cpsummary.Average(x => x.W19), 2),
                                      W19_Ah = Math.Round(cpsummary.Average(x => x.W19_Ah), 2),
                                      W20 = Math.Round(cpsummary.Average(x => x.W20), 2),
                                      W20_Ah = Math.Round(cpsummary.Average(x => x.W20_Ah), 2),

                                      W21 = Math.Round(cpsummary.Average(x => x.W1), 2),
                                      W21_Ah = Math.Round(cpsummary.Average(x => x.W1_Ah), 2),
                                      W22 = Math.Round(cpsummary.Average(x => x.W2), 2),
                                      W22_Ah = Math.Round(cpsummary.Average(x => x.W2_Ah), 2),
                                      W23 = Math.Round(cpsummary.Average(x => x.W3), 2),
                                      W23_Ah = Math.Round(cpsummary.Average(x => x.W3_Ah), 2),
                                      W24 = Math.Round(cpsummary.Average(x => x.W4), 2),
                                      W24_Ah = Math.Round(cpsummary.Average(x => x.W4_Ah), 2),
                                      W25 = Math.Round(cpsummary.Average(x => x.W5), 2),
                                      W25_Ah = Math.Round(cpsummary.Average(x => x.W5_Ah), 2),
                                      W26 = Math.Round(cpsummary.Average(x => x.W6), 2),
                                      W26_Ah = Math.Round(cpsummary.Average(x => x.W6_Ah), 2),
                                      W27 = Math.Round(cpsummary.Average(x => x.W7), 2),
                                      W27_Ah = Math.Round(cpsummary.Average(x => x.W7_Ah), 2),
                                      W28 = Math.Round(cpsummary.Average(x => x.W8), 2),
                                      W28_Ah = Math.Round(cpsummary.Average(x => x.W8_Ah), 2),
                                      W29 = Math.Round(cpsummary.Average(x => x.W9), 2),
                                      W29_Ah = Math.Round(cpsummary.Average(x => x.W9_Ah), 2),
                                      W30 = Math.Round(cpsummary.Average(x => x.W10), 2),
                                      W30_Ah = Math.Round(cpsummary.Average(x => x.W10_Ah), 2),

                                      W31 = Math.Round(cpsummary.Average(x => x.W31), 2),
                                      W31_Ah = Math.Round(cpsummary.Average(x => x.W31_Ah), 2),
                                      W32 = Math.Round(cpsummary.Average(x => x.W32), 2),
                                      W32_Ah = Math.Round(cpsummary.Average(x => x.W32_Ah), 2),
                                      W33 = Math.Round(cpsummary.Average(x => x.W33), 2),
                                      W33_Ah = Math.Round(cpsummary.Average(x => x.W33_Ah), 2),
                                      W34 = Math.Round(cpsummary.Average(x => x.W34), 2),
                                      W34_Ah = Math.Round(cpsummary.Average(x => x.W34_Ah), 2),
                                      W35 = Math.Round(cpsummary.Average(x => x.W35), 2),
                                      W35_Ah = Math.Round(cpsummary.Average(x => x.W35_Ah), 2),
                                      W36 = Math.Round(cpsummary.Average(x => x.W36), 2),
                                      W36_Ah = Math.Round(cpsummary.Average(x => x.W36_Ah), 2),
                                      W37 = Math.Round(cpsummary.Average(x => x.W37), 2),
                                      W37_Ah = Math.Round(cpsummary.Average(x => x.W37_Ah), 2),
                                      W38 = Math.Round(cpsummary.Average(x => x.W38), 2),
                                      W38_Ah = Math.Round(cpsummary.Average(x => x.W38_Ah), 2),
                                      W39 = Math.Round(cpsummary.Average(x => x.W39), 2),
                                      W39_Ah = Math.Round(cpsummary.Average(x => x.W39_Ah), 2),
                                      W40 = Math.Round(cpsummary.Average(x => x.W40), 2),
                                      W40_Ah = Math.Round(cpsummary.Average(x => x.W40_Ah), 2),

                                      W41 = Math.Round(cpsummary.Average(x => x.W41), 2),
                                      W41_Ah = Math.Round(cpsummary.Average(x => x.W41_Ah), 2),
                                      W42 = Math.Round(cpsummary.Average(x => x.W42), 2),
                                      W42_Ah = Math.Round(cpsummary.Average(x => x.W42_Ah), 2),
                                      W43 = Math.Round(cpsummary.Average(x => x.W43), 2),
                                      W43_Ah = Math.Round(cpsummary.Average(x => x.W43_Ah), 2),
                                      W44 = Math.Round(cpsummary.Average(x => x.W44), 2),
                                      W44_Ah = Math.Round(cpsummary.Average(x => x.W44_Ah), 2),
                                      W45 = Math.Round(cpsummary.Average(x => x.W45), 2),
                                      W45_Ah = Math.Round(cpsummary.Average(x => x.W45_Ah), 2),
                                      W46 = Math.Round(cpsummary.Average(x => x.W46), 2),
                                      W46_Ah = Math.Round(cpsummary.Average(x => x.W46_Ah), 2),
                                      W47 = Math.Round(cpsummary.Average(x => x.W47), 2),
                                      W47_Ah = Math.Round(cpsummary.Average(x => x.W47_Ah), 2),
                                      W48 = Math.Round(cpsummary.Average(x => x.W48), 2),
                                      W48_Ah = Math.Round(cpsummary.Average(x => x.W48_Ah), 2),
                                      W49 = Math.Round(cpsummary.Average(x => x.W49), 2),
                                      W49_Ah = Math.Round(cpsummary.Average(x => x.W49_Ah), 2),
                                      W50 = Math.Round(cpsummary.Average(x => x.W50), 2),
                                      W50_Ah = Math.Round(cpsummary.Average(x => x.W50_Ah), 2),
                                      W51 = Math.Round(cpsummary.Average(x => x.W51), 2),
                                      W51_Ah = Math.Round(cpsummary.Average(x => x.W51_Ah), 2),
                                      W52 = Math.Round(cpsummary.Average(x => x.W52), 2),
                                      W52_Ah = Math.Round(cpsummary.Average(x => x.W52_Ah), 2),
                                      W53 = Math.Round(cpsummary.Average(x => x.W53), 2),
                                      W53_Ah = Math.Round(cpsummary.Average(x => x.W53_Ah), 2),

                                  });

                        RrProjectLitForTotalSumWeek = new RrResourcWeek()
                        {
                            //ResourceId= RrResorceList.FirstOrDefault().ResourceId,


                            W1 = Math.Round(MonthSummaryList.Average(x => x.W1), 2),
                            W1_Ah = Math.Round(MonthSummaryList.Average(x => x.W1_Ah), 2),
                            W2 = Math.Round(MonthSummaryList.Average(x => x.W2), 2),
                            W2_Ah = Math.Round(MonthSummaryList.Average(x => x.W2_Ah), 2),
                            W3 = Math.Round(MonthSummaryList.Average(x => x.W3), 2),
                            W3_Ah = Math.Round(MonthSummaryList.Average(x => x.W3_Ah), 2),
                            W4 = Math.Round(MonthSummaryList.Average(x => x.W4), 2),
                            W4_Ah = Math.Round(MonthSummaryList.Average(x => x.W4_Ah), 2),
                            W5 = Math.Round(MonthSummaryList.Average(x => x.W5), 2),
                            W5_Ah = Math.Round(MonthSummaryList.Average(x => x.W5_Ah), 2),
                            W6 = Math.Round(MonthSummaryList.Average(x => x.W6), 2),
                            W6_Ah = Math.Round(MonthSummaryList.Average(x => x.W6_Ah), 2),
                            W7 = Math.Round(MonthSummaryList.Average(x => x.W7), 2),
                            W7_Ah = Math.Round(MonthSummaryList.Average(x => x.W7_Ah), 2),
                            W8 = Math.Round(MonthSummaryList.Average(x => x.W8), 2),
                            W8_Ah = Math.Round(MonthSummaryList.Average(x => x.W8_Ah), 2),
                            W9 = Math.Round(MonthSummaryList.Average(x => x.W9), 2),
                            W9_Ah = Math.Round(MonthSummaryList.Average(x => x.W9_Ah), 2),
                            W10 = Math.Round(MonthSummaryList.Average(x => x.W10), 2),
                            W10_Ah = Math.Round(MonthSummaryList.Average(x => x.W10_Ah), 2),

                            W11 = Math.Round(MonthSummaryList.Average(x => x.W11), 2),
                            W11_Ah = Math.Round(MonthSummaryList.Average(x => x.W11_Ah), 2),
                            W12 = Math.Round(MonthSummaryList.Average(x => x.W12), 2),
                            W12_Ah = Math.Round(MonthSummaryList.Average(x => x.W12_Ah), 2),
                            W13 = Math.Round(MonthSummaryList.Average(x => x.W13), 2),
                            W13_Ah = Math.Round(MonthSummaryList.Average(x => x.W13_Ah), 2),
                            W14 = Math.Round(MonthSummaryList.Average(x => x.W14), 2),
                            W14_Ah = Math.Round(MonthSummaryList.Average(x => x.W14_Ah), 2),
                            W15 = Math.Round(MonthSummaryList.Average(x => x.W15), 2),
                            W15_Ah = Math.Round(MonthSummaryList.Average(x => x.W15_Ah), 2),
                            W16 = Math.Round(MonthSummaryList.Average(x => x.W16), 2),
                            W16_Ah = Math.Round(MonthSummaryList.Average(x => x.W16_Ah), 2),
                            W17 = Math.Round(MonthSummaryList.Average(x => x.W17), 2),
                            W17_Ah = Math.Round(MonthSummaryList.Average(x => x.W17_Ah), 2),
                            W18 = Math.Round(MonthSummaryList.Average(x => x.W18), 2),
                            W18_Ah = Math.Round(MonthSummaryList.Average(x => x.W18_Ah), 2),
                            W19 = Math.Round(MonthSummaryList.Average(x => x.W19), 2),
                            W19_Ah = Math.Round(MonthSummaryList.Average(x => x.W19_Ah), 2),
                            W20 = Math.Round(MonthSummaryList.Average(x => x.W20), 2),
                            W20_Ah = Math.Round(MonthSummaryList.Average(x => x.W20_Ah), 2),

                            W21 = Math.Round(MonthSummaryList.Average(x => x.W1), 2),
                            W21_Ah = Math.Round(MonthSummaryList.Average(x => x.W1_Ah), 2),
                            W22 = Math.Round(MonthSummaryList.Average(x => x.W2), 2),
                            W22_Ah = Math.Round(MonthSummaryList.Average(x => x.W2_Ah), 2),
                            W23 = Math.Round(MonthSummaryList.Average(x => x.W3), 2),
                            W23_Ah = Math.Round(MonthSummaryList.Average(x => x.W3_Ah), 2),
                            W24 = Math.Round(MonthSummaryList.Average(x => x.W4), 2),
                            W24_Ah = Math.Round(MonthSummaryList.Average(x => x.W4_Ah), 2),
                            W25 = Math.Round(MonthSummaryList.Average(x => x.W5), 2),
                            W25_Ah = Math.Round(MonthSummaryList.Average(x => x.W5_Ah), 2),
                            W26 = Math.Round(MonthSummaryList.Average(x => x.W6), 2),
                            W26_Ah = Math.Round(MonthSummaryList.Average(x => x.W6_Ah), 2),
                            W27 = Math.Round(MonthSummaryList.Average(x => x.W7), 2),
                            W27_Ah = Math.Round(MonthSummaryList.Average(x => x.W7_Ah), 2),
                            W28 = Math.Round(MonthSummaryList.Average(x => x.W8), 2),
                            W28_Ah = Math.Round(MonthSummaryList.Average(x => x.W8_Ah), 2),
                            W29 = Math.Round(MonthSummaryList.Average(x => x.W9), 2),
                            W29_Ah = Math.Round(MonthSummaryList.Average(x => x.W9_Ah), 2),
                            W30 = Math.Round(MonthSummaryList.Average(x => x.W10), 2),
                            W30_Ah = Math.Round(MonthSummaryList.Average(x => x.W10_Ah), 2),

                            W31 = Math.Round(MonthSummaryList.Average(x => x.W31), 2),
                            W31_Ah = Math.Round(MonthSummaryList.Average(x => x.W31_Ah), 2),
                            W32 = Math.Round(MonthSummaryList.Average(x => x.W32), 2),
                            W32_Ah = Math.Round(MonthSummaryList.Average(x => x.W32_Ah), 2),
                            W33 = Math.Round(MonthSummaryList.Average(x => x.W33), 2),
                            W33_Ah = Math.Round(MonthSummaryList.Average(x => x.W33_Ah), 2),
                            W34 = Math.Round(MonthSummaryList.Average(x => x.W34), 2),
                            W34_Ah = Math.Round(MonthSummaryList.Average(x => x.W34_Ah), 2),
                            W35 = Math.Round(MonthSummaryList.Average(x => x.W35), 2),
                            W35_Ah = Math.Round(MonthSummaryList.Average(x => x.W35_Ah), 2),
                            W36 = Math.Round(MonthSummaryList.Average(x => x.W36), 2),
                            W36_Ah = Math.Round(MonthSummaryList.Average(x => x.W36_Ah), 2),
                            W37 = Math.Round(MonthSummaryList.Average(x => x.W37), 2),
                            W37_Ah = Math.Round(MonthSummaryList.Average(x => x.W37_Ah), 2),
                            W38 = Math.Round(MonthSummaryList.Average(x => x.W38), 2),
                            W38_Ah = Math.Round(MonthSummaryList.Average(x => x.W38_Ah), 2),
                            W39 = Math.Round(MonthSummaryList.Average(x => x.W39), 2),
                            W39_Ah = Math.Round(MonthSummaryList.Average(x => x.W39_Ah), 2),
                            W40 = Math.Round(MonthSummaryList.Average(x => x.W40), 2),
                            W40_Ah = Math.Round(MonthSummaryList.Average(x => x.W40_Ah), 2),

                            W41 = Math.Round(MonthSummaryList.Average(x => x.W41), 2),
                            W41_Ah = Math.Round(MonthSummaryList.Average(x => x.W41_Ah), 2),
                            W42 = Math.Round(MonthSummaryList.Average(x => x.W42), 2),
                            W42_Ah = Math.Round(MonthSummaryList.Average(x => x.W42_Ah), 2),
                            W43 = Math.Round(MonthSummaryList.Average(x => x.W43), 2),
                            W43_Ah = Math.Round(MonthSummaryList.Average(x => x.W43_Ah), 2),
                            W44 = Math.Round(MonthSummaryList.Average(x => x.W44), 2),
                            W44_Ah = Math.Round(MonthSummaryList.Average(x => x.W44_Ah), 2),
                            W45 = Math.Round(MonthSummaryList.Average(x => x.W45), 2),
                            W45_Ah = Math.Round(MonthSummaryList.Average(x => x.W45_Ah), 2),
                            W46 = Math.Round(MonthSummaryList.Average(x => x.W46), 2),
                            W46_Ah = Math.Round(MonthSummaryList.Average(x => x.W46_Ah), 2),
                            W47 = Math.Round(MonthSummaryList.Average(x => x.W47), 2),
                            W47_Ah = Math.Round(MonthSummaryList.Average(x => x.W47_Ah), 2),
                            W48 = Math.Round(MonthSummaryList.Average(x => x.W48), 2),
                            W48_Ah = Math.Round(MonthSummaryList.Average(x => x.W48_Ah), 2),
                            W49 = Math.Round(MonthSummaryList.Average(x => x.W49), 2),
                            W49_Ah = Math.Round(MonthSummaryList.Average(x => x.W49_Ah), 2),
                            W50 = Math.Round(MonthSummaryList.Average(x => x.W50), 2),
                            W50_Ah = Math.Round(MonthSummaryList.Average(x => x.W50_Ah), 2),
                            W51 = Math.Round(MonthSummaryList.Average(x => x.W51), 2),
                            W51_Ah = Math.Round(MonthSummaryList.Average(x => x.W51_Ah), 2),
                            W52 = Math.Round(MonthSummaryList.Average(x => x.W52), 2),
                            W52_Ah = Math.Round(MonthSummaryList.Average(x => x.W52_Ah), 2),
                            W53 = Math.Round(MonthSummaryList.Average(x => x.W53), 2),
                            W53_Ah = Math.Round(MonthSummaryList.Average(x => x.W53_Ah), 2),
                        };

                        foreach (var itemProject in MonthSummaryList)
                        {
                            var ProjectListFinal = new Rr_ProjectWiseListWeek();
                            ProjectListFinal.ProjectWeek = MonthSummaryList.Where(x => x.ProjectId == itemProject.ProjectId).FirstOrDefault();
                            ProjectListFinal.ProjectWeek.RrResourceList = new List<RrResourcWeek>();

                            var ProjectResList = RrResorceList.Where(x => x.ProjectId == itemProject.ProjectId).ToList();
                            //ProjectListFinal.ProjectMonth.RrResourceList= new RrResourcMonths();
                            ProjectListFinal.ProjectWeek.RrResourceList.AddRange(ProjectResList);
                            ProjectListFinal.ProjectWeek.ProjectId = ProjectResList.FirstOrDefault().ProjectId;
                            ProjectListFinal.ProjectWeek.ProjectName = ProjectResList.FirstOrDefault().ProjectName;// itemProject.ProjectName;
                            ///Add total  sum
                            RrProjectListWeek.Add(ProjectListFinal);

                        }
                    }
                    else
                    {
                        var MonthSummaryList = RrResorceList.GroupBy(y => y.ProjectId).Select(cpsummary =>
                                new RrProjectWeek
                                {
                                    ProjectId = cpsummary.Key,
                                    W1 = cpsummary.Sum(x => x.W1),
                                    W1_Ah = cpsummary.Sum(x => x.W1_Ah),
                                    W2 = cpsummary.Sum(x => x.W2),
                                    W2_Ah = cpsummary.Sum(x => x.W2_Ah),
                                    W3 = cpsummary.Sum(x => x.W3),
                                    W3_Ah = cpsummary.Sum(x => x.W3_Ah),
                                    W4 = cpsummary.Sum(x => x.W4),
                                    W4_Ah = cpsummary.Sum(x => x.W4_Ah),
                                    W5 = cpsummary.Sum(x => x.W5),
                                    W5_Ah = cpsummary.Sum(x => x.W5_Ah),
                                    W6 = cpsummary.Sum(x => x.W6),
                                    W6_Ah = cpsummary.Sum(x => x.W6_Ah),
                                    W7 = cpsummary.Sum(x => x.W7),
                                    W7_Ah = cpsummary.Sum(x => x.W7_Ah),
                                    W8 = cpsummary.Sum(x => x.W8),
                                    W8_Ah = cpsummary.Sum(x => x.W8_Ah),
                                    W9 = cpsummary.Sum(x => x.W9),
                                    W9_Ah = cpsummary.Sum(x => x.W9_Ah),
                                    W10 = cpsummary.Sum(x => x.W10),
                                    W10_Ah = cpsummary.Sum(x => x.W10_Ah),

                                    W11 = cpsummary.Sum(x => x.W11),
                                    W11_Ah = cpsummary.Sum(x => x.W11_Ah),
                                    W12 = cpsummary.Sum(x => x.W12),
                                    W12_Ah = cpsummary.Sum(x => x.W12_Ah),
                                    W13 = cpsummary.Sum(x => x.W13),
                                    W13_Ah = cpsummary.Sum(x => x.W13_Ah),
                                    W14 = cpsummary.Sum(x => x.W14),
                                    W14_Ah = cpsummary.Sum(x => x.W14_Ah),
                                    W15 = cpsummary.Sum(x => x.W15),
                                    W15_Ah = cpsummary.Sum(x => x.W15_Ah),
                                    W16 = cpsummary.Sum(x => x.W16),
                                    W16_Ah = cpsummary.Sum(x => x.W16_Ah),
                                    W17 = cpsummary.Sum(x => x.W17),
                                    W17_Ah = cpsummary.Sum(x => x.W17_Ah),
                                    W18 = cpsummary.Sum(x => x.W18),
                                    W18_Ah = cpsummary.Sum(x => x.W18_Ah),
                                    W19 = cpsummary.Sum(x => x.W19),
                                    W19_Ah = cpsummary.Sum(x => x.W19_Ah),
                                    W20 = cpsummary.Sum(x => x.W20),
                                    W20_Ah = cpsummary.Sum(x => x.W20_Ah),

                                    W21 = cpsummary.Sum(x => x.W1),
                                    W21_Ah = cpsummary.Sum(x => x.W1_Ah),
                                    W22 = cpsummary.Sum(x => x.W2),
                                    W22_Ah = cpsummary.Sum(x => x.W2_Ah),
                                    W23 = cpsummary.Sum(x => x.W3),
                                    W23_Ah = cpsummary.Sum(x => x.W3_Ah),
                                    W24 = cpsummary.Sum(x => x.W4),
                                    W24_Ah = cpsummary.Sum(x => x.W4_Ah),
                                    W25 = cpsummary.Sum(x => x.W5),
                                    W25_Ah = cpsummary.Sum(x => x.W5_Ah),
                                    W26 = cpsummary.Sum(x => x.W6),
                                    W26_Ah = cpsummary.Sum(x => x.W6_Ah),
                                    W27 = cpsummary.Sum(x => x.W7),
                                    W27_Ah = cpsummary.Sum(x => x.W7_Ah),
                                    W28 = cpsummary.Sum(x => x.W8),
                                    W28_Ah = cpsummary.Sum(x => x.W8_Ah),
                                    W29 = cpsummary.Sum(x => x.W9),
                                    W29_Ah = cpsummary.Sum(x => x.W9_Ah),
                                    W30 = cpsummary.Sum(x => x.W10),
                                    W30_Ah = cpsummary.Sum(x => x.W10_Ah),

                                    W31 = cpsummary.Sum(x => x.W31),
                                    W31_Ah = cpsummary.Sum(x => x.W31_Ah),
                                    W32 = cpsummary.Sum(x => x.W32),
                                    W32_Ah = cpsummary.Sum(x => x.W32_Ah),
                                    W33 = cpsummary.Sum(x => x.W33),
                                    W33_Ah = cpsummary.Sum(x => x.W33_Ah),
                                    W34 = cpsummary.Sum(x => x.W34),
                                    W34_Ah = cpsummary.Sum(x => x.W34_Ah),
                                    W35 = cpsummary.Sum(x => x.W35),
                                    W35_Ah = cpsummary.Sum(x => x.W35_Ah),
                                    W36 = cpsummary.Sum(x => x.W36),
                                    W36_Ah = cpsummary.Sum(x => x.W36_Ah),
                                    W37 = cpsummary.Sum(x => x.W37),
                                    W37_Ah = cpsummary.Sum(x => x.W37_Ah),
                                    W38 = cpsummary.Sum(x => x.W38),
                                    W38_Ah = cpsummary.Sum(x => x.W38_Ah),
                                    W39 = cpsummary.Sum(x => x.W39),
                                    W39_Ah = cpsummary.Sum(x => x.W39_Ah),
                                    W40 = cpsummary.Sum(x => x.W40),
                                    W40_Ah = cpsummary.Sum(x => x.W40_Ah),

                                    W41 = cpsummary.Sum(x => x.W41),
                                    W41_Ah = cpsummary.Sum(x => x.W41_Ah),
                                    W42 = cpsummary.Sum(x => x.W42),
                                    W42_Ah = cpsummary.Sum(x => x.W42_Ah),
                                    W43 = cpsummary.Sum(x => x.W43),
                                    W43_Ah = cpsummary.Sum(x => x.W43_Ah),
                                    W44 = cpsummary.Sum(x => x.W44),
                                    W44_Ah = cpsummary.Sum(x => x.W44_Ah),
                                    W45 = cpsummary.Sum(x => x.W45),
                                    W45_Ah = cpsummary.Sum(x => x.W45_Ah),
                                    W46 = cpsummary.Sum(x => x.W46),
                                    W46_Ah = cpsummary.Sum(x => x.W46_Ah),
                                    W47 = cpsummary.Sum(x => x.W47),
                                    W47_Ah = cpsummary.Sum(x => x.W47_Ah),
                                    W48 = cpsummary.Sum(x => x.W48),
                                    W48_Ah = cpsummary.Sum(x => x.W48_Ah),
                                    W49 = cpsummary.Sum(x => x.W49),
                                    W49_Ah = cpsummary.Sum(x => x.W49_Ah),
                                    W50 = cpsummary.Sum(x => x.W50),
                                    W50_Ah = cpsummary.Sum(x => x.W50_Ah),
                                    W51 = cpsummary.Sum(x => x.W51),
                                    W51_Ah = cpsummary.Sum(x => x.W51_Ah),
                                    W52 = cpsummary.Sum(x => x.W52),
                                    W52_Ah = cpsummary.Sum(x => x.W52_Ah),
                                    W53 = cpsummary.Sum(x => x.W53),
                                    W53_Ah = cpsummary.Sum(x => x.W53_Ah),

                                });

                        RrProjectLitForTotalSumWeek = new RrResourcWeek()
                        {
                            //ResourceId= RrResorceList.FirstOrDefault().ResourceId,


                            W1 = RrResorceList.Sum(x => x.W1),
                            W1_Ah = RrResorceList.Sum(x => x.W1_Ah),
                            W2 = RrResorceList.Sum(x => x.W2),
                            W2_Ah = RrResorceList.Sum(x => x.W2_Ah),
                            W3 = RrResorceList.Sum(x => x.W3),
                            W3_Ah = RrResorceList.Sum(x => x.W3_Ah),
                            W4 = RrResorceList.Sum(x => x.W4),
                            W4_Ah = RrResorceList.Sum(x => x.W4_Ah),
                            W5 = RrResorceList.Sum(x => x.W5),
                            W5_Ah = RrResorceList.Sum(x => x.W5_Ah),
                            W6 = RrResorceList.Sum(x => x.W6),
                            W6_Ah = RrResorceList.Sum(x => x.W6_Ah),
                            W7 = RrResorceList.Sum(x => x.W7),
                            W7_Ah = RrResorceList.Sum(x => x.W7_Ah),
                            W8 = RrResorceList.Sum(x => x.W8),
                            W8_Ah = RrResorceList.Sum(x => x.W8_Ah),
                            W9 = RrResorceList.Sum(x => x.W9),
                            W9_Ah = RrResorceList.Sum(x => x.W9_Ah),
                            W10 = RrResorceList.Sum(x => x.W10),
                            W10_Ah = RrResorceList.Sum(x => x.W10_Ah),

                            W11 = RrResorceList.Sum(x => x.W11),
                            W11_Ah = RrResorceList.Sum(x => x.W11_Ah),
                            W12 = RrResorceList.Sum(x => x.W12),
                            W12_Ah = RrResorceList.Sum(x => x.W12_Ah),
                            W13 = RrResorceList.Sum(x => x.W13),
                            W13_Ah = RrResorceList.Sum(x => x.W13_Ah),
                            W14 = RrResorceList.Sum(x => x.W14),
                            W14_Ah = RrResorceList.Sum(x => x.W14_Ah),
                            W15 = RrResorceList.Sum(x => x.W15),
                            W15_Ah = RrResorceList.Sum(x => x.W15_Ah),
                            W16 = RrResorceList.Sum(x => x.W16),
                            W16_Ah = RrResorceList.Sum(x => x.W16_Ah),
                            W17 = RrResorceList.Sum(x => x.W17),
                            W17_Ah = RrResorceList.Sum(x => x.W17_Ah),
                            W18 = RrResorceList.Sum(x => x.W18),
                            W18_Ah = RrResorceList.Sum(x => x.W18_Ah),
                            W19 = RrResorceList.Sum(x => x.W19),
                            W19_Ah = RrResorceList.Sum(x => x.W19_Ah),
                            W20 = RrResorceList.Sum(x => x.W20),
                            W20_Ah = RrResorceList.Sum(x => x.W20_Ah),

                            W21 = RrResorceList.Sum(x => x.W1),
                            W21_Ah = RrResorceList.Sum(x => x.W1_Ah),
                            W22 = RrResorceList.Sum(x => x.W2),
                            W22_Ah = RrResorceList.Sum(x => x.W2_Ah),
                            W23 = RrResorceList.Sum(x => x.W3),
                            W23_Ah = RrResorceList.Sum(x => x.W3_Ah),
                            W24 = RrResorceList.Sum(x => x.W4),
                            W24_Ah = RrResorceList.Sum(x => x.W4_Ah),
                            W25 = RrResorceList.Sum(x => x.W5),
                            W25_Ah = RrResorceList.Sum(x => x.W5_Ah),
                            W26 = RrResorceList.Sum(x => x.W6),
                            W26_Ah = RrResorceList.Sum(x => x.W6_Ah),
                            W27 = RrResorceList.Sum(x => x.W7),
                            W27_Ah = RrResorceList.Sum(x => x.W7_Ah),
                            W28 = RrResorceList.Sum(x => x.W8),
                            W28_Ah = RrResorceList.Sum(x => x.W8_Ah),
                            W29 = RrResorceList.Sum(x => x.W9),
                            W29_Ah = RrResorceList.Sum(x => x.W9_Ah),
                            W30 = RrResorceList.Sum(x => x.W10),
                            W30_Ah = RrResorceList.Sum(x => x.W10_Ah),

                            W31 = RrResorceList.Sum(x => x.W31),
                            W31_Ah = RrResorceList.Sum(x => x.W31_Ah),
                            W32 = RrResorceList.Sum(x => x.W32),
                            W32_Ah = RrResorceList.Sum(x => x.W32_Ah),
                            W33 = RrResorceList.Sum(x => x.W33),
                            W33_Ah = RrResorceList.Sum(x => x.W33_Ah),
                            W34 = RrResorceList.Sum(x => x.W34),
                            W34_Ah = RrResorceList.Sum(x => x.W34_Ah),
                            W35 = RrResorceList.Sum(x => x.W35),
                            W35_Ah = RrResorceList.Sum(x => x.W35_Ah),
                            W36 = RrResorceList.Sum(x => x.W36),
                            W36_Ah = RrResorceList.Sum(x => x.W36_Ah),
                            W37 = RrResorceList.Sum(x => x.W37),
                            W37_Ah = RrResorceList.Sum(x => x.W37_Ah),
                            W38 = RrResorceList.Sum(x => x.W38),
                            W38_Ah = RrResorceList.Sum(x => x.W38_Ah),
                            W39 = RrResorceList.Sum(x => x.W39),
                            W39_Ah = RrResorceList.Sum(x => x.W39_Ah),
                            W40 = RrResorceList.Sum(x => x.W40),
                            W40_Ah = RrResorceList.Sum(x => x.W40_Ah),

                            W41 = RrResorceList.Sum(x => x.W41),
                            W41_Ah = RrResorceList.Sum(x => x.W41_Ah),
                            W42 = RrResorceList.Sum(x => x.W42),
                            W42_Ah = RrResorceList.Sum(x => x.W42_Ah),
                            W43 = RrResorceList.Sum(x => x.W43),
                            W43_Ah = RrResorceList.Sum(x => x.W43_Ah),
                            W44 = RrResorceList.Sum(x => x.W44),
                            W44_Ah = RrResorceList.Sum(x => x.W44_Ah),
                            W45 = RrResorceList.Sum(x => x.W45),
                            W45_Ah = RrResorceList.Sum(x => x.W45_Ah),
                            W46 = RrResorceList.Sum(x => x.W46),
                            W46_Ah = RrResorceList.Sum(x => x.W46_Ah),
                            W47 = RrResorceList.Sum(x => x.W47),
                            W47_Ah = RrResorceList.Sum(x => x.W47_Ah),
                            W48 = RrResorceList.Sum(x => x.W48),
                            W48_Ah = RrResorceList.Sum(x => x.W48_Ah),
                            W49 = RrResorceList.Sum(x => x.W49),
                            W49_Ah = RrResorceList.Sum(x => x.W49_Ah),
                            W50 = RrResorceList.Sum(x => x.W50),
                            W50_Ah = RrResorceList.Sum(x => x.W50_Ah),
                            W51 = RrResorceList.Sum(x => x.W51),
                            W51_Ah = RrResorceList.Sum(x => x.W51_Ah),
                            W52 = RrResorceList.Sum(x => x.W52),
                            W52_Ah = RrResorceList.Sum(x => x.W52_Ah),
                            W53 = RrResorceList.Sum(x => x.W53),
                            W53_Ah = RrResorceList.Sum(x => x.W53_Ah),
                        };

                        foreach (var itemProject in MonthSummaryList)
                        {
                            var ProjectListFinal = new Rr_ProjectWiseListWeek();
                            ProjectListFinal.ProjectWeek = MonthSummaryList.Where(x => x.ProjectId == itemProject.ProjectId).FirstOrDefault();
                            ProjectListFinal.ProjectWeek.RrResourceList = new List<RrResourcWeek>();

                            var ProjectResList = RrResorceList.Where(x => x.ProjectId == itemProject.ProjectId).ToList();
                            //ProjectListFinal.ProjectMonth.RrResourceList= new RrResourcMonths();
                            ProjectListFinal.ProjectWeek.RrResourceList.AddRange(ProjectResList);
                            ProjectListFinal.ProjectWeek.ProjectId = ProjectResList.FirstOrDefault().ProjectId;
                            ProjectListFinal.ProjectWeek.ProjectName = ProjectResList.FirstOrDefault().ProjectName;// itemProject.ProjectName;
                            ///Add total  sum
                            RrProjectListWeek.Add(ProjectListFinal);

                        }
                    }
                }
            }
            ObjRr_ProjectwiseWeek Obj = new ObjRr_ProjectwiseWeek();
            Obj.RrProjectListWeek = RrProjectListWeek;
            Obj.RrProjectLitForTotalSumWeek = RrProjectLitForTotalSumWeek;
            Obj.columnNames = columnNames;
            return Obj;
        }
        private ObjRr_ProjectwiseWeek GetRrResourcwiseWeek(DataSet CapacityPlanDSet, string ReportIn)
        {
            List<string> columnNames = null;
            var RrResourceLitForTotalSumWeek = new RrResourcWeek();
            var RrResourceListWeek = new List<Rr_ResourceWiseListWeek>();
            columnNames = new List<string>();
            //foreach (DataRow itemHeader in CapacityPlanDSet.Tables[1].Rows)
            //{
            //    columnNames.Add(Convert.ToString(itemHeader["MonthName"]));
            //}

            DataTable ResourceTable = CapacityPlanDSet.Tables[0];
            if (ResourceTable.Rows.Count > 0)
            {
                if (ResourceTable != null && ResourceTable.Rows.Count > 0)
                {
                    var RrResorceList = new List<RrResourcWeek>();
                    foreach (DataRow itemResource in ResourceTable.Rows)
                    {
                        RrResorceList.Add(GetRrResourceWeek(itemResource, string.Empty));
                    }

                    if (ReportIn == "0")
                    {
                        var MonthSummaryList = RrResorceList.GroupBy(y => y.ResourceId).Select(cpsummary =>
                                  new RrByResourctWeek
                                  {
                                      ResourceId = cpsummary.Key,
                                      W1 = Math.Round(cpsummary.Average(x => x.W1), 2),
                                      W1_Ah = Math.Round(cpsummary.Average(x => x.W1_Ah), 2),
                                      W2 = Math.Round(cpsummary.Average(x => x.W2), 2),
                                      W2_Ah = Math.Round(cpsummary.Average(x => x.W2_Ah), 2),
                                      W3 = Math.Round(cpsummary.Average(x => x.W3), 2),
                                      W3_Ah = Math.Round(cpsummary.Average(x => x.W3_Ah), 2),
                                      W4 = Math.Round(cpsummary.Average(x => x.W4), 2),
                                      W4_Ah = Math.Round(cpsummary.Average(x => x.W4_Ah), 2),
                                      W5 = Math.Round(cpsummary.Average(x => x.W5), 2),
                                      W5_Ah = Math.Round(cpsummary.Average(x => x.W5_Ah), 2),
                                      W6 = Math.Round(cpsummary.Average(x => x.W6), 2),
                                      W6_Ah = Math.Round(cpsummary.Average(x => x.W6_Ah), 2),
                                      W7 = Math.Round(cpsummary.Average(x => x.W7), 2),
                                      W7_Ah = Math.Round(cpsummary.Average(x => x.W7_Ah), 2),
                                      W8 = Math.Round(cpsummary.Average(x => x.W8), 2),
                                      W8_Ah = Math.Round(cpsummary.Average(x => x.W8_Ah), 2),
                                      W9 = Math.Round(cpsummary.Average(x => x.W9), 2),
                                      W9_Ah = Math.Round(cpsummary.Average(x => x.W9_Ah), 2),
                                      W10 = Math.Round(cpsummary.Average(x => x.W10), 2),
                                      W10_Ah = Math.Round(cpsummary.Average(x => x.W10_Ah), 2),

                                      W11 = Math.Round(cpsummary.Average(x => x.W11), 2),
                                      W11_Ah = Math.Round(cpsummary.Average(x => x.W11_Ah), 2),
                                      W12 = Math.Round(cpsummary.Average(x => x.W12), 2),
                                      W12_Ah = Math.Round(cpsummary.Average(x => x.W12_Ah), 2),
                                      W13 = Math.Round(cpsummary.Average(x => x.W13), 2),
                                      W13_Ah = Math.Round(cpsummary.Average(x => x.W13_Ah), 2),
                                      W14 = Math.Round(cpsummary.Average(x => x.W14), 2),
                                      W14_Ah = Math.Round(cpsummary.Average(x => x.W14_Ah), 2),
                                      W15 = Math.Round(cpsummary.Average(x => x.W15), 2),
                                      W15_Ah = Math.Round(cpsummary.Average(x => x.W15_Ah), 2),
                                      W16 = Math.Round(cpsummary.Average(x => x.W16), 2),
                                      W16_Ah = Math.Round(cpsummary.Average(x => x.W16_Ah), 2),
                                      W17 = Math.Round(cpsummary.Average(x => x.W17), 2),
                                      W17_Ah = Math.Round(cpsummary.Average(x => x.W17_Ah), 2),
                                      W18 = Math.Round(cpsummary.Average(x => x.W18), 2),
                                      W18_Ah = Math.Round(cpsummary.Average(x => x.W18_Ah), 2),
                                      W19 = Math.Round(cpsummary.Average(x => x.W19), 2),
                                      W19_Ah = Math.Round(cpsummary.Average(x => x.W19_Ah), 2),
                                      W20 = Math.Round(cpsummary.Average(x => x.W20), 2),
                                      W20_Ah = Math.Round(cpsummary.Average(x => x.W20_Ah), 2),

                                      W21 = Math.Round(cpsummary.Average(x => x.W1), 2),
                                      W21_Ah = Math.Round(cpsummary.Average(x => x.W1_Ah), 2),
                                      W22 = Math.Round(cpsummary.Average(x => x.W2), 2),
                                      W22_Ah = Math.Round(cpsummary.Average(x => x.W2_Ah), 2),
                                      W23 = Math.Round(cpsummary.Average(x => x.W3), 2),
                                      W23_Ah = Math.Round(cpsummary.Average(x => x.W3_Ah), 2),
                                      W24 = Math.Round(cpsummary.Average(x => x.W4), 2),
                                      W24_Ah = Math.Round(cpsummary.Average(x => x.W4_Ah), 2),
                                      W25 = Math.Round(cpsummary.Average(x => x.W5), 2),
                                      W25_Ah = Math.Round(cpsummary.Average(x => x.W5_Ah), 2),
                                      W26 = Math.Round(cpsummary.Average(x => x.W6), 2),
                                      W26_Ah = Math.Round(cpsummary.Average(x => x.W6_Ah), 2),
                                      W27 = Math.Round(cpsummary.Average(x => x.W7), 2),
                                      W27_Ah = Math.Round(cpsummary.Average(x => x.W7_Ah), 2),
                                      W28 = Math.Round(cpsummary.Average(x => x.W8), 2),
                                      W28_Ah = Math.Round(cpsummary.Average(x => x.W8_Ah), 2),
                                      W29 = Math.Round(cpsummary.Average(x => x.W9), 2),
                                      W29_Ah = Math.Round(cpsummary.Average(x => x.W9_Ah), 2),
                                      W30 = Math.Round(cpsummary.Average(x => x.W10), 2),
                                      W30_Ah = Math.Round(cpsummary.Average(x => x.W10_Ah), 2),

                                      W31 = Math.Round(cpsummary.Average(x => x.W31), 2),
                                      W31_Ah = Math.Round(cpsummary.Average(x => x.W31_Ah), 2),
                                      W32 = Math.Round(cpsummary.Average(x => x.W32), 2),
                                      W32_Ah = Math.Round(cpsummary.Average(x => x.W32_Ah), 2),
                                      W33 = Math.Round(cpsummary.Average(x => x.W33), 2),
                                      W33_Ah = Math.Round(cpsummary.Average(x => x.W33_Ah), 2),
                                      W34 = Math.Round(cpsummary.Average(x => x.W34), 2),
                                      W34_Ah = Math.Round(cpsummary.Average(x => x.W34_Ah), 2),
                                      W35 = Math.Round(cpsummary.Average(x => x.W35), 2),
                                      W35_Ah = Math.Round(cpsummary.Average(x => x.W35_Ah), 2),
                                      W36 = Math.Round(cpsummary.Average(x => x.W36), 2),
                                      W36_Ah = Math.Round(cpsummary.Average(x => x.W36_Ah), 2),
                                      W37 = Math.Round(cpsummary.Average(x => x.W37), 2),
                                      W37_Ah = Math.Round(cpsummary.Average(x => x.W37_Ah), 2),
                                      W38 = Math.Round(cpsummary.Average(x => x.W38), 2),
                                      W38_Ah = Math.Round(cpsummary.Average(x => x.W38_Ah), 2),
                                      W39 = Math.Round(cpsummary.Average(x => x.W39), 2),
                                      W39_Ah = Math.Round(cpsummary.Average(x => x.W39_Ah), 2),
                                      W40 = Math.Round(cpsummary.Average(x => x.W40), 2),
                                      W40_Ah = Math.Round(cpsummary.Average(x => x.W40_Ah), 2),

                                      W41 = Math.Round(cpsummary.Average(x => x.W41), 2),
                                      W41_Ah = Math.Round(cpsummary.Average(x => x.W41_Ah), 2),
                                      W42 = Math.Round(cpsummary.Average(x => x.W42), 2),
                                      W42_Ah = Math.Round(cpsummary.Average(x => x.W42_Ah), 2),
                                      W43 = Math.Round(cpsummary.Average(x => x.W43), 2),
                                      W43_Ah = Math.Round(cpsummary.Average(x => x.W43_Ah), 2),
                                      W44 = Math.Round(cpsummary.Average(x => x.W44), 2),
                                      W44_Ah = Math.Round(cpsummary.Average(x => x.W44_Ah), 2),
                                      W45 = Math.Round(cpsummary.Average(x => x.W45), 2),
                                      W45_Ah = Math.Round(cpsummary.Average(x => x.W45_Ah), 2),
                                      W46 = Math.Round(cpsummary.Average(x => x.W46), 2),
                                      W46_Ah = Math.Round(cpsummary.Average(x => x.W46_Ah), 2),
                                      W47 = Math.Round(cpsummary.Average(x => x.W47), 2),
                                      W47_Ah = Math.Round(cpsummary.Average(x => x.W47_Ah), 2),
                                      W48 = Math.Round(cpsummary.Average(x => x.W48), 2),
                                      W48_Ah = Math.Round(cpsummary.Average(x => x.W48_Ah), 2),
                                      W49 = Math.Round(cpsummary.Average(x => x.W49), 2),
                                      W49_Ah = Math.Round(cpsummary.Average(x => x.W49_Ah), 2),
                                      W50 = Math.Round(cpsummary.Average(x => x.W50), 2),
                                      W50_Ah = Math.Round(cpsummary.Average(x => x.W50_Ah), 2),
                                      W51 = Math.Round(cpsummary.Average(x => x.W51), 2),
                                      W51_Ah = Math.Round(cpsummary.Average(x => x.W51_Ah), 2),
                                      W52 = Math.Round(cpsummary.Average(x => x.W52), 2),
                                      W52_Ah = Math.Round(cpsummary.Average(x => x.W52_Ah), 2),
                                      W53 = Math.Round(cpsummary.Average(x => x.W53), 2),
                                      W53_Ah = Math.Round(cpsummary.Average(x => x.W53_Ah), 2),
                                  });

                        RrResourceLitForTotalSumWeek = new RrResourcWeek()
                        {
                            //ResourceId= RrResorceList.FirstOrDefault().ResourceId,
                            W1 = Math.Round(MonthSummaryList.Average(x => x.W1), 2),
                            W1_Ah = Math.Round(MonthSummaryList.Average(x => x.W1_Ah), 2),
                            W2 = Math.Round(MonthSummaryList.Average(x => x.W2), 2),
                            W2_Ah = Math.Round(MonthSummaryList.Average(x => x.W2_Ah), 2),
                            W3 = Math.Round(MonthSummaryList.Average(x => x.W3), 2),
                            W3_Ah = Math.Round(MonthSummaryList.Average(x => x.W3_Ah), 2),
                            W4 = Math.Round(MonthSummaryList.Average(x => x.W4), 2),
                            W4_Ah = Math.Round(MonthSummaryList.Average(x => x.W4_Ah), 2),
                            W5 = Math.Round(MonthSummaryList.Average(x => x.W5), 2),
                            W5_Ah = Math.Round(MonthSummaryList.Average(x => x.W5_Ah), 2),
                            W6 = Math.Round(MonthSummaryList.Average(x => x.W6), 2),
                            W6_Ah = Math.Round(MonthSummaryList.Average(x => x.W6_Ah), 2),
                            W7 = Math.Round(MonthSummaryList.Average(x => x.W7), 2),
                            W7_Ah = Math.Round(MonthSummaryList.Average(x => x.W7_Ah), 2),
                            W8 = Math.Round(MonthSummaryList.Average(x => x.W8), 2),
                            W8_Ah = Math.Round(MonthSummaryList.Average(x => x.W8_Ah), 2),
                            W9 = Math.Round(MonthSummaryList.Average(x => x.W9), 2),
                            W9_Ah = Math.Round(MonthSummaryList.Average(x => x.W9_Ah), 2),
                            W10 = Math.Round(MonthSummaryList.Average(x => x.W10), 2),
                            W10_Ah = Math.Round(MonthSummaryList.Average(x => x.W10_Ah), 2),

                            W11 = Math.Round(MonthSummaryList.Average(x => x.W11), 2),
                            W11_Ah = Math.Round(MonthSummaryList.Average(x => x.W11_Ah), 2),
                            W12 = Math.Round(MonthSummaryList.Average(x => x.W12), 2),
                            W12_Ah = Math.Round(MonthSummaryList.Average(x => x.W12_Ah), 2),
                            W13 = Math.Round(MonthSummaryList.Average(x => x.W13), 2),
                            W13_Ah = Math.Round(MonthSummaryList.Average(x => x.W13_Ah), 2),
                            W14 = Math.Round(MonthSummaryList.Average(x => x.W14), 2),
                            W14_Ah = Math.Round(MonthSummaryList.Average(x => x.W14_Ah), 2),
                            W15 = Math.Round(MonthSummaryList.Average(x => x.W15), 2),
                            W15_Ah = Math.Round(MonthSummaryList.Average(x => x.W15_Ah), 2),
                            W16 = Math.Round(MonthSummaryList.Average(x => x.W16), 2),
                            W16_Ah = Math.Round(MonthSummaryList.Average(x => x.W16_Ah), 2),
                            W17 = Math.Round(MonthSummaryList.Average(x => x.W17), 2),
                            W17_Ah = Math.Round(MonthSummaryList.Average(x => x.W17_Ah), 2),
                            W18 = Math.Round(MonthSummaryList.Average(x => x.W18), 2),
                            W18_Ah = Math.Round(MonthSummaryList.Average(x => x.W18_Ah), 2),
                            W19 = Math.Round(MonthSummaryList.Average(x => x.W19), 2),
                            W19_Ah = Math.Round(MonthSummaryList.Average(x => x.W19_Ah), 2),
                            W20 = Math.Round(MonthSummaryList.Average(x => x.W20), 2),
                            W20_Ah = Math.Round(MonthSummaryList.Average(x => x.W20_Ah), 2),

                            W21 = Math.Round(MonthSummaryList.Average(x => x.W1), 2),
                            W21_Ah = Math.Round(MonthSummaryList.Average(x => x.W1_Ah), 2),
                            W22 = Math.Round(MonthSummaryList.Average(x => x.W2), 2),
                            W22_Ah = Math.Round(MonthSummaryList.Average(x => x.W2_Ah), 2),
                            W23 = Math.Round(MonthSummaryList.Average(x => x.W3), 2),
                            W23_Ah = Math.Round(MonthSummaryList.Average(x => x.W3_Ah), 2),
                            W24 = Math.Round(MonthSummaryList.Average(x => x.W4), 2),
                            W24_Ah = Math.Round(MonthSummaryList.Average(x => x.W4_Ah), 2),
                            W25 = Math.Round(MonthSummaryList.Average(x => x.W5), 2),
                            W25_Ah = Math.Round(MonthSummaryList.Average(x => x.W5_Ah), 2),
                            W26 = Math.Round(MonthSummaryList.Average(x => x.W6), 2),
                            W26_Ah = Math.Round(MonthSummaryList.Average(x => x.W6_Ah), 2),
                            W27 = Math.Round(MonthSummaryList.Average(x => x.W7), 2),
                            W27_Ah = Math.Round(MonthSummaryList.Average(x => x.W7_Ah), 2),
                            W28 = Math.Round(MonthSummaryList.Average(x => x.W8), 2),
                            W28_Ah = Math.Round(MonthSummaryList.Average(x => x.W8_Ah), 2),
                            W29 = Math.Round(MonthSummaryList.Average(x => x.W9), 2),
                            W29_Ah = Math.Round(MonthSummaryList.Average(x => x.W9_Ah), 2),
                            W30 = Math.Round(MonthSummaryList.Average(x => x.W10), 2),
                            W30_Ah = Math.Round(MonthSummaryList.Average(x => x.W10_Ah), 2),

                            W31 = Math.Round(MonthSummaryList.Average(x => x.W31), 2),
                            W31_Ah = Math.Round(MonthSummaryList.Average(x => x.W31_Ah), 2),
                            W32 = Math.Round(MonthSummaryList.Average(x => x.W32), 2),
                            W32_Ah = Math.Round(MonthSummaryList.Average(x => x.W32_Ah), 2),
                            W33 = Math.Round(MonthSummaryList.Average(x => x.W33), 2),
                            W33_Ah = Math.Round(MonthSummaryList.Average(x => x.W33_Ah), 2),
                            W34 = Math.Round(MonthSummaryList.Average(x => x.W34), 2),
                            W34_Ah = Math.Round(MonthSummaryList.Average(x => x.W34_Ah), 2),
                            W35 = Math.Round(MonthSummaryList.Average(x => x.W35), 2),
                            W35_Ah = Math.Round(MonthSummaryList.Average(x => x.W35_Ah), 2),
                            W36 = Math.Round(MonthSummaryList.Average(x => x.W36), 2),
                            W36_Ah = Math.Round(MonthSummaryList.Average(x => x.W36_Ah), 2),
                            W37 = Math.Round(MonthSummaryList.Average(x => x.W37), 2),
                            W37_Ah = Math.Round(MonthSummaryList.Average(x => x.W37_Ah), 2),
                            W38 = Math.Round(MonthSummaryList.Average(x => x.W38), 2),
                            W38_Ah = Math.Round(MonthSummaryList.Average(x => x.W38_Ah), 2),
                            W39 = Math.Round(MonthSummaryList.Average(x => x.W39), 2),
                            W39_Ah = Math.Round(MonthSummaryList.Average(x => x.W39_Ah), 2),
                            W40 = Math.Round(MonthSummaryList.Average(x => x.W40), 2),
                            W40_Ah = Math.Round(MonthSummaryList.Average(x => x.W40_Ah), 2),

                            W41 = Math.Round(MonthSummaryList.Average(x => x.W41), 2),
                            W41_Ah = Math.Round(MonthSummaryList.Average(x => x.W41_Ah), 2),
                            W42 = Math.Round(MonthSummaryList.Average(x => x.W42), 2),
                            W42_Ah = Math.Round(MonthSummaryList.Average(x => x.W42_Ah), 2),
                            W43 = Math.Round(MonthSummaryList.Average(x => x.W43), 2),
                            W43_Ah = Math.Round(MonthSummaryList.Average(x => x.W43_Ah), 2),
                            W44 = Math.Round(MonthSummaryList.Average(x => x.W44), 2),
                            W44_Ah = Math.Round(MonthSummaryList.Average(x => x.W44_Ah), 2),
                            W45 = Math.Round(MonthSummaryList.Average(x => x.W45), 2),
                            W45_Ah = Math.Round(MonthSummaryList.Average(x => x.W45_Ah), 2),
                            W46 = Math.Round(MonthSummaryList.Average(x => x.W46), 2),
                            W46_Ah = Math.Round(MonthSummaryList.Average(x => x.W46_Ah), 2),
                            W47 = Math.Round(MonthSummaryList.Average(x => x.W47), 2),
                            W47_Ah = Math.Round(MonthSummaryList.Average(x => x.W47_Ah), 2),
                            W48 = Math.Round(MonthSummaryList.Average(x => x.W48), 2),
                            W48_Ah = Math.Round(MonthSummaryList.Average(x => x.W48_Ah), 2),
                            W49 = Math.Round(MonthSummaryList.Average(x => x.W49), 2),
                            W49_Ah = Math.Round(MonthSummaryList.Average(x => x.W49_Ah), 2),
                            W50 = Math.Round(MonthSummaryList.Average(x => x.W50), 2),
                            W50_Ah = Math.Round(MonthSummaryList.Average(x => x.W50_Ah), 2),
                            W51 = Math.Round(MonthSummaryList.Average(x => x.W51), 2),
                            W51_Ah = Math.Round(MonthSummaryList.Average(x => x.W51_Ah), 2),
                            W52 = Math.Round(MonthSummaryList.Average(x => x.W52), 2),
                            W52_Ah = Math.Round(MonthSummaryList.Average(x => x.W52_Ah), 2),
                            W53 = Math.Round(MonthSummaryList.Average(x => x.W53), 2),
                            W53_Ah = Math.Round(MonthSummaryList.Average(x => x.W53_Ah), 2),

                        };

                        foreach (var itemProject in MonthSummaryList)
                        {
                            var ProjectListFinal = new Rr_ResourceWiseListWeek();
                            ProjectListFinal.ResourceWeek = MonthSummaryList.Where(x => x.ResourceId == itemProject.ResourceId).FirstOrDefault();
                            ProjectListFinal.ResourceWeek.RrProjectList = new List<RrResourcWeek>();

                            var ProjectResList = RrResorceList.Where(x => x.ResourceId == itemProject.ResourceId).ToList();
                            //ProjectListFinal.ProjectMonth.RrResourceList= new RrResourcMonths();
                            ProjectListFinal.ResourceWeek.RrProjectList.AddRange(ProjectResList);
                            ProjectListFinal.ResourceWeek.ResourceId = ProjectResList.FirstOrDefault().ResourceId;
                            ProjectListFinal.ResourceWeek.ResourceName = ProjectResList.FirstOrDefault().ResourceName;// itemProject.ProjectName;
                            //ProjectListFinal.ResourceWeek.ProfilePicURL = ProjectResList.FirstOrDefault().ProfilePicURL;
                            if (CommonFunctions.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(ProjectResList.FirstOrDefault().ProfilePicURL)))
                                ProjectListFinal.ResourceWeek.ProfilePicURL = ProjectResList.FirstOrDefault().ProfilePicURL;
                            else
                                ProjectListFinal.ResourceWeek.ProfilePicURL = "../../../Images/NoPreview.gif";

                            ProjectListFinal.ResourceWeek.Designation = ProjectResList.FirstOrDefault().Designation;
                            RrResourceListWeek.Add(ProjectListFinal);

                        }
                    }
                    else
                    {
                        var MonthSummaryList = RrResorceList.GroupBy(y => y.ResourceId).Select(cpsummary =>
                                 new RrByResourctWeek
                                 {
                                     ResourceId = cpsummary.Key,
                                     W1 = cpsummary.Sum(x => x.W1),
                                     W1_Ah = cpsummary.Sum(x => x.W1_Ah),
                                     W2 = cpsummary.Sum(x => x.W2),
                                     W2_Ah = cpsummary.Sum(x => x.W2_Ah),
                                     W3 = cpsummary.Sum(x => x.W3),
                                     W3_Ah = cpsummary.Sum(x => x.W3_Ah),
                                     W4 = cpsummary.Sum(x => x.W4),
                                     W4_Ah = cpsummary.Sum(x => x.W4_Ah),
                                     W5 = cpsummary.Sum(x => x.W5),
                                     W5_Ah = cpsummary.Sum(x => x.W5_Ah),
                                     W6 = cpsummary.Sum(x => x.W6),
                                     W6_Ah = cpsummary.Sum(x => x.W6_Ah),
                                     W7 = cpsummary.Sum(x => x.W7),
                                     W7_Ah = cpsummary.Sum(x => x.W7_Ah),
                                     W8 = cpsummary.Sum(x => x.W8),
                                     W8_Ah = cpsummary.Sum(x => x.W8_Ah),
                                     W9 = cpsummary.Sum(x => x.W9),
                                     W9_Ah = cpsummary.Sum(x => x.W9_Ah),
                                     W10 = cpsummary.Sum(x => x.W10),
                                     W10_Ah = cpsummary.Sum(x => x.W10_Ah),

                                     W11 = cpsummary.Sum(x => x.W11),
                                     W11_Ah = cpsummary.Sum(x => x.W11_Ah),
                                     W12 = cpsummary.Sum(x => x.W12),
                                     W12_Ah = cpsummary.Sum(x => x.W12_Ah),
                                     W13 = cpsummary.Sum(x => x.W13),
                                     W13_Ah = cpsummary.Sum(x => x.W13_Ah),
                                     W14 = cpsummary.Sum(x => x.W14),
                                     W14_Ah = cpsummary.Sum(x => x.W14_Ah),
                                     W15 = cpsummary.Sum(x => x.W15),
                                     W15_Ah = cpsummary.Sum(x => x.W15_Ah),
                                     W16 = cpsummary.Sum(x => x.W16),
                                     W16_Ah = cpsummary.Sum(x => x.W16_Ah),
                                     W17 = cpsummary.Sum(x => x.W17),
                                     W17_Ah = cpsummary.Sum(x => x.W17_Ah),
                                     W18 = cpsummary.Sum(x => x.W18),
                                     W18_Ah = cpsummary.Sum(x => x.W18_Ah),
                                     W19 = cpsummary.Sum(x => x.W19),
                                     W19_Ah = cpsummary.Sum(x => x.W19_Ah),
                                     W20 = cpsummary.Sum(x => x.W20),
                                     W20_Ah = cpsummary.Sum(x => x.W20_Ah),

                                     W21 = cpsummary.Sum(x => x.W1),
                                     W21_Ah = cpsummary.Sum(x => x.W1_Ah),
                                     W22 = cpsummary.Sum(x => x.W2),
                                     W22_Ah = cpsummary.Sum(x => x.W2_Ah),
                                     W23 = cpsummary.Sum(x => x.W3),
                                     W23_Ah = cpsummary.Sum(x => x.W3_Ah),
                                     W24 = cpsummary.Sum(x => x.W4),
                                     W24_Ah = cpsummary.Sum(x => x.W4_Ah),
                                     W25 = cpsummary.Sum(x => x.W5),
                                     W25_Ah = cpsummary.Sum(x => x.W5_Ah),
                                     W26 = cpsummary.Sum(x => x.W6),
                                     W26_Ah = cpsummary.Sum(x => x.W6_Ah),
                                     W27 = cpsummary.Sum(x => x.W7),
                                     W27_Ah = cpsummary.Sum(x => x.W7_Ah),
                                     W28 = cpsummary.Sum(x => x.W8),
                                     W28_Ah = cpsummary.Sum(x => x.W8_Ah),
                                     W29 = cpsummary.Sum(x => x.W9),
                                     W29_Ah = cpsummary.Sum(x => x.W9_Ah),
                                     W30 = cpsummary.Sum(x => x.W10),
                                     W30_Ah = cpsummary.Sum(x => x.W10_Ah),

                                     W31 = cpsummary.Sum(x => x.W31),
                                     W31_Ah = cpsummary.Sum(x => x.W31_Ah),
                                     W32 = cpsummary.Sum(x => x.W32),
                                     W32_Ah = cpsummary.Sum(x => x.W32_Ah),
                                     W33 = cpsummary.Sum(x => x.W33),
                                     W33_Ah = cpsummary.Sum(x => x.W33_Ah),
                                     W34 = cpsummary.Sum(x => x.W34),
                                     W34_Ah = cpsummary.Sum(x => x.W34_Ah),
                                     W35 = cpsummary.Sum(x => x.W35),
                                     W35_Ah = cpsummary.Sum(x => x.W35_Ah),
                                     W36 = cpsummary.Sum(x => x.W36),
                                     W36_Ah = cpsummary.Sum(x => x.W36_Ah),
                                     W37 = cpsummary.Sum(x => x.W37),
                                     W37_Ah = cpsummary.Sum(x => x.W37_Ah),
                                     W38 = cpsummary.Sum(x => x.W38),
                                     W38_Ah = cpsummary.Sum(x => x.W38_Ah),
                                     W39 = cpsummary.Sum(x => x.W39),
                                     W39_Ah = cpsummary.Sum(x => x.W39_Ah),
                                     W40 = cpsummary.Sum(x => x.W40),
                                     W40_Ah = cpsummary.Sum(x => x.W40_Ah),

                                     W41 = cpsummary.Sum(x => x.W41),
                                     W41_Ah = cpsummary.Sum(x => x.W41_Ah),
                                     W42 = cpsummary.Sum(x => x.W42),
                                     W42_Ah = cpsummary.Sum(x => x.W42_Ah),
                                     W43 = cpsummary.Sum(x => x.W43),
                                     W43_Ah = cpsummary.Sum(x => x.W43_Ah),
                                     W44 = cpsummary.Sum(x => x.W44),
                                     W44_Ah = cpsummary.Sum(x => x.W44_Ah),
                                     W45 = cpsummary.Sum(x => x.W45),
                                     W45_Ah = cpsummary.Sum(x => x.W45_Ah),
                                     W46 = cpsummary.Sum(x => x.W46),
                                     W46_Ah = cpsummary.Sum(x => x.W46_Ah),
                                     W47 = cpsummary.Sum(x => x.W47),
                                     W47_Ah = cpsummary.Sum(x => x.W47_Ah),
                                     W48 = cpsummary.Sum(x => x.W48),
                                     W48_Ah = cpsummary.Sum(x => x.W48_Ah),
                                     W49 = cpsummary.Sum(x => x.W49),
                                     W49_Ah = cpsummary.Sum(x => x.W49_Ah),
                                     W50 = cpsummary.Sum(x => x.W50),
                                     W50_Ah = cpsummary.Sum(x => x.W50_Ah),
                                     W51 = cpsummary.Sum(x => x.W51),
                                     W51_Ah = cpsummary.Sum(x => x.W51_Ah),
                                     W52 = cpsummary.Sum(x => x.W52),
                                     W52_Ah = cpsummary.Sum(x => x.W52_Ah),
                                     W53 = cpsummary.Sum(x => x.W53),
                                     W53_Ah = cpsummary.Sum(x => x.W53_Ah),

                                 });

                        RrResourceLitForTotalSumWeek = new RrResourcWeek()
                        {
                            //ResourceId= RrResorceList.FirstOrDefault().ResourceId,
                            W1 = RrResorceList.Sum(x => x.W1),
                            W1_Ah = RrResorceList.Sum(x => x.W1_Ah),
                            W2 = RrResorceList.Sum(x => x.W2),
                            W2_Ah = RrResorceList.Sum(x => x.W2_Ah),
                            W3 = RrResorceList.Sum(x => x.W3),
                            W3_Ah = RrResorceList.Sum(x => x.W3_Ah),
                            W4 = RrResorceList.Sum(x => x.W4),
                            W4_Ah = RrResorceList.Sum(x => x.W4_Ah),
                            W5 = RrResorceList.Sum(x => x.W5),
                            W5_Ah = RrResorceList.Sum(x => x.W5_Ah),
                            W6 = RrResorceList.Sum(x => x.W6),
                            W6_Ah = RrResorceList.Sum(x => x.W6_Ah),
                            W7 = RrResorceList.Sum(x => x.W7),
                            W7_Ah = RrResorceList.Sum(x => x.W7_Ah),
                            W8 = RrResorceList.Sum(x => x.W8),
                            W8_Ah = RrResorceList.Sum(x => x.W8_Ah),
                            W9 = RrResorceList.Sum(x => x.W9),
                            W9_Ah = RrResorceList.Sum(x => x.W9_Ah),
                            W10 = RrResorceList.Sum(x => x.W10),
                            W10_Ah = RrResorceList.Sum(x => x.W10_Ah),

                            W11 = RrResorceList.Sum(x => x.W11),
                            W11_Ah = RrResorceList.Sum(x => x.W11_Ah),
                            W12 = RrResorceList.Sum(x => x.W12),
                            W12_Ah = RrResorceList.Sum(x => x.W12_Ah),
                            W13 = RrResorceList.Sum(x => x.W13),
                            W13_Ah = RrResorceList.Sum(x => x.W13_Ah),
                            W14 = RrResorceList.Sum(x => x.W14),
                            W14_Ah = RrResorceList.Sum(x => x.W14_Ah),
                            W15 = RrResorceList.Sum(x => x.W15),
                            W15_Ah = RrResorceList.Sum(x => x.W15_Ah),
                            W16 = RrResorceList.Sum(x => x.W16),
                            W16_Ah = RrResorceList.Sum(x => x.W16_Ah),
                            W17 = RrResorceList.Sum(x => x.W17),
                            W17_Ah = RrResorceList.Sum(x => x.W17_Ah),
                            W18 = RrResorceList.Sum(x => x.W18),
                            W18_Ah = RrResorceList.Sum(x => x.W18_Ah),
                            W19 = RrResorceList.Sum(x => x.W19),
                            W19_Ah = RrResorceList.Sum(x => x.W19_Ah),
                            W20 = RrResorceList.Sum(x => x.W20),
                            W20_Ah = RrResorceList.Sum(x => x.W20_Ah),

                            W21 = RrResorceList.Sum(x => x.W1),
                            W21_Ah = RrResorceList.Sum(x => x.W1_Ah),
                            W22 = RrResorceList.Sum(x => x.W2),
                            W22_Ah = RrResorceList.Sum(x => x.W2_Ah),
                            W23 = RrResorceList.Sum(x => x.W3),
                            W23_Ah = RrResorceList.Sum(x => x.W3_Ah),
                            W24 = RrResorceList.Sum(x => x.W4),
                            W24_Ah = RrResorceList.Sum(x => x.W4_Ah),
                            W25 = RrResorceList.Sum(x => x.W5),
                            W25_Ah = RrResorceList.Sum(x => x.W5_Ah),
                            W26 = RrResorceList.Sum(x => x.W6),
                            W26_Ah = RrResorceList.Sum(x => x.W6_Ah),
                            W27 = RrResorceList.Sum(x => x.W7),
                            W27_Ah = RrResorceList.Sum(x => x.W7_Ah),
                            W28 = RrResorceList.Sum(x => x.W8),
                            W28_Ah = RrResorceList.Sum(x => x.W8_Ah),
                            W29 = RrResorceList.Sum(x => x.W9),
                            W29_Ah = RrResorceList.Sum(x => x.W9_Ah),
                            W30 = RrResorceList.Sum(x => x.W10),
                            W30_Ah = RrResorceList.Sum(x => x.W10_Ah),

                            W31 = RrResorceList.Sum(x => x.W31),
                            W31_Ah = RrResorceList.Sum(x => x.W31_Ah),
                            W32 = RrResorceList.Sum(x => x.W32),
                            W32_Ah = RrResorceList.Sum(x => x.W32_Ah),
                            W33 = RrResorceList.Sum(x => x.W33),
                            W33_Ah = RrResorceList.Sum(x => x.W33_Ah),
                            W34 = RrResorceList.Sum(x => x.W34),
                            W34_Ah = RrResorceList.Sum(x => x.W34_Ah),
                            W35 = RrResorceList.Sum(x => x.W35),
                            W35_Ah = RrResorceList.Sum(x => x.W35_Ah),
                            W36 = RrResorceList.Sum(x => x.W36),
                            W36_Ah = RrResorceList.Sum(x => x.W36_Ah),
                            W37 = RrResorceList.Sum(x => x.W37),
                            W37_Ah = RrResorceList.Sum(x => x.W37_Ah),
                            W38 = RrResorceList.Sum(x => x.W38),
                            W38_Ah = RrResorceList.Sum(x => x.W38_Ah),
                            W39 = RrResorceList.Sum(x => x.W39),
                            W39_Ah = RrResorceList.Sum(x => x.W39_Ah),
                            W40 = RrResorceList.Sum(x => x.W40),
                            W40_Ah = RrResorceList.Sum(x => x.W40_Ah),

                            W41 = RrResorceList.Sum(x => x.W41),
                            W41_Ah = RrResorceList.Sum(x => x.W41_Ah),
                            W42 = RrResorceList.Sum(x => x.W42),
                            W42_Ah = RrResorceList.Sum(x => x.W42_Ah),
                            W43 = RrResorceList.Sum(x => x.W43),
                            W43_Ah = RrResorceList.Sum(x => x.W43_Ah),
                            W44 = RrResorceList.Sum(x => x.W44),
                            W44_Ah = RrResorceList.Sum(x => x.W44_Ah),
                            W45 = RrResorceList.Sum(x => x.W45),
                            W45_Ah = RrResorceList.Sum(x => x.W45_Ah),
                            W46 = RrResorceList.Sum(x => x.W46),
                            W46_Ah = RrResorceList.Sum(x => x.W46_Ah),
                            W47 = RrResorceList.Sum(x => x.W47),
                            W47_Ah = RrResorceList.Sum(x => x.W47_Ah),
                            W48 = RrResorceList.Sum(x => x.W48),
                            W48_Ah = RrResorceList.Sum(x => x.W48_Ah),
                            W49 = RrResorceList.Sum(x => x.W49),
                            W49_Ah = RrResorceList.Sum(x => x.W49_Ah),
                            W50 = RrResorceList.Sum(x => x.W50),
                            W50_Ah = RrResorceList.Sum(x => x.W50_Ah),
                            W51 = RrResorceList.Sum(x => x.W51),
                            W51_Ah = RrResorceList.Sum(x => x.W51_Ah),
                            W52 = RrResorceList.Sum(x => x.W52),
                            W52_Ah = RrResorceList.Sum(x => x.W52_Ah),
                            W53 = RrResorceList.Sum(x => x.W53),
                            W53_Ah = RrResorceList.Sum(x => x.W53_Ah),

                        };

                        foreach (var itemProject in MonthSummaryList)
                        {
                            var ProjectListFinal = new Rr_ResourceWiseListWeek();
                            ProjectListFinal.ResourceWeek = MonthSummaryList.Where(x => x.ResourceId == itemProject.ResourceId).FirstOrDefault();
                            ProjectListFinal.ResourceWeek.RrProjectList = new List<RrResourcWeek>();

                            var ProjectResList = RrResorceList.Where(x => x.ResourceId == itemProject.ResourceId).ToList();
                            //ProjectListFinal.ProjectMonth.RrResourceList= new RrResourcMonths();
                            ProjectListFinal.ResourceWeek.RrProjectList.AddRange(ProjectResList);
                            ProjectListFinal.ResourceWeek.ResourceId = ProjectResList.FirstOrDefault().ResourceId;
                            ProjectListFinal.ResourceWeek.ResourceName = ProjectResList.FirstOrDefault().ResourceName;// itemProject.ProjectName;
                            //ProjectListFinal.ResourceWeek.ProfilePicURL = ProjectResList.FirstOrDefault().ProfilePicURL;
                            if (CommonFunctions.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(ProjectResList.FirstOrDefault().ProfilePicURL)))
                                ProjectListFinal.ResourceWeek.ProfilePicURL = ProjectResList.FirstOrDefault().ProfilePicURL;
                            else
                                ProjectListFinal.ResourceWeek.ProfilePicURL = "../../../Images/NoPreview.gif";

                            ProjectListFinal.ResourceWeek.Designation = ProjectResList.FirstOrDefault().Designation;
                            RrResourceListWeek.Add(ProjectListFinal);

                        }
                    }
                }
            }
            ObjRr_ProjectwiseWeek Obj = new ObjRr_ProjectwiseWeek();
            Obj.RrResourceListWeek = RrResourceListWeek;
            Obj.RrProjectLitForTotalSumWeek = RrResourceLitForTotalSumWeek;
            Obj.columnNames = columnNames;
            return Obj;
        }
        #endregion
        #region Private method
        //Rr_ProjectWiseList
        private RrProjectMonths GetRrProjectMonth(DataRow TblRows, string Name = null)
        {
            var RrProjectMonths = new RrProjectMonths();
            RrProjectMonths.ProjectId = Convert.ToInt16(TblRows["ProjectId"]);
            RrProjectMonths.ProjectName = !string.IsNullOrEmpty(Name) ? Name : TblRows["ResourceName"].ToString();
            RrProjectMonths.Month_1 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[4], "0"));
            RrProjectMonths.Month_Ah1 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[5], "0"));
            RrProjectMonths.Month_2 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[6], "0"));
            RrProjectMonths.Month_Ah2 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[7], "0"));
            RrProjectMonths.Month_3 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[8], "0"));
            RrProjectMonths.Month_Ah3 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[9], "0"));
            RrProjectMonths.Month_4 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[10], "0"));
            RrProjectMonths.Month_Ah4 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[11], "0"));
            RrProjectMonths.Month_5 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[12], "0"));
            RrProjectMonths.Month_Ah5 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[13], "0"));
            RrProjectMonths.Month_6 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[14], "0"));
            RrProjectMonths.Month_Ah6 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[15], "0"));
            RrProjectMonths.Month_7 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[16], "0"));
            RrProjectMonths.Month_Ah7 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[17], "0"));
            RrProjectMonths.Month_8 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[18], "0"));
            RrProjectMonths.Month_Ah8 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[19], "0"));
            RrProjectMonths.Month_9 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[20], "0"));
            RrProjectMonths.Month_Ah9 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[21], "0"));
            RrProjectMonths.Month_10 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[22], "0"));
            RrProjectMonths.Month_Ah10 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[23], "0"));
            RrProjectMonths.Month_11 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[24], "0"));
            RrProjectMonths.Month_Ah11 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[25], "0"));
            RrProjectMonths.Month_12 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[26], "0"));
            RrProjectMonths.Month_Ah12 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[27], "0"));

            return RrProjectMonths;
        }


        private ResourceUtilizationsFilter GetSqlString(ResourceUtilizationFilter filterParameter)
        {
            string strParms = string.Empty;
            string ReportName = string.Empty;
            string strSQL = string.Empty;
            bool IsNextMonth = false;
            if (!string.IsNullOrEmpty(filterParameter.YearPrevNext))
            {
                strParms += "@ForCurrentYear=" + filterParameter.YearPrevNext + ",";
            }
            if (!string.IsNullOrEmpty(filterParameter.ReportIn))
            {
                strParms += "@IsForCapcityHr=" + filterParameter.ReportIn + ",";
            }
            if (!string.IsNullOrEmpty(filterParameter.TimeLine) && filterParameter.TimeLine != "quarter" && filterParameter.TimeLine != "week")
            {
                int timeLine = 0;
                if (filterParameter.TimeLine == "halfyear")
                {
                    timeLine = 1;
                }
                strParms += "@IsHafYrarly=" + timeLine + ",";

            }
            if (filterParameter.RUWhereClause != null && !string.IsNullOrEmpty(filterParameter.RUWhereClause))
            {
                strParms += "@WhereClause= '" + filterParameter.RUWhereClause + "'" + ",";
            }
            strParms += "@IsForReport=" + 0 + ",";
            //Added by imran 12-10-2021
            strParms += "@intPageNo =" + filterParameter.PageNo + ",";
            strParms += "@intPageSize =" + filterParameter.PageSize + ",";
            // End by imran 12-10-2021
            strParms = strParms.TrimEnd(',');

            IDataReader drCompInfo = CommonFunctions.Data.GetSQLDataReader("usp_Whizible2_sel_tbl_PM_CompanyInformation", CommonController.connectionString);

            while (drCompInfo.Read())
            {
                var CompanyName = CommonFunctions.Data.CheckIsDBNull(drCompInfo["CompanyName"], "").ToString();
                var DateFormatID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drCompInfo["DateFormatID"], "0"));
                DateTime StartDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(drCompInfo["FinancialYearStart"], ""));
                DateTime EndDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(drCompInfo["FinancialYearEnd"], " "));

                var CurrentDate = DateTime.Now;
                var FinancialHafStartDate = StartDate.AddMonths(6);
                var FinancialHafStartDateMonth = FinancialHafStartDate.Month;
                if (FinancialHafStartDateMonth > 8 && CurrentDate > EndDate)
                {
                    IsNextMonth = true;
                }

            }
            drCompInfo.Close();

            if (filterParameter.ReportTab == "Project")
            {
                if (filterParameter.TimeLine == "quarter")
                {
                    ReportName = "ProjectQuarter";
                    strSQL = "Exec usp_Whizible2_Sel_ResourceUtilizationDetails_Qtr_Project_Report " + strParms;
                }
                else if (filterParameter.TimeLine == "week")
                {
                    ReportName = "ProjectWeek";
                    strSQL = "Exec usp_Whizible2_Sel_ResourceUtilizationDetails_Week_Project_Report " + strParms;
                }
                else
                {
                    if (filterParameter.TimeLine == "halfyear")
                    {
                        ReportName = "ProjectHalfYear";
                    }
                    else
                    {
                        ReportName = "ProjectMonthYear";
                    }
                    strSQL = "Exec usp_Whizible2_Sel_ResourceUtilizationDetails_Monthly_Project_Report " + strParms;
                }
            }
            else if (filterParameter.ReportTab == "Resources")
            {
                if (filterParameter.TimeLine == "quarter")
                {
                    ReportName = "ResourceQuarter";
                    //Commented and added by Chetan M on 19 Aug 2021 for report header
                    //strSQL = "Exec usp_Whizible2_Sel_ResourceUtilizationDetails_Qtr_Resource_Report " + strParms;
                    strSQL = "Exec usp_Whizible2_Sel_ResourceUtilizationDetails_Qtr_Resource_Report " + strParms + ",@BySiteResource ='" + filterParameter.ReportTab + "',@Year ='" + filterParameter.Year + "',@TimeLine ='" + filterParameter.TimeLine + "',@ReportIn ='" + filterParameter.ReportInStr + "',@intBusinessGroupsID =" + filterParameter.BusinessGroupID + ",@intLocationID =" + filterParameter.OrganizationUnitID + ",@ResourcePoolID =" + filterParameter.DeliveryUnitID + ",@ResourceGroupID =" + filterParameter.DeliveryTeamID + ",@ResourceName ='" + filterParameter.ResourceName + "'";
                    //End of Commented and added by Chetan M on 19 Aug 2021 for report header
                }
                else if (filterParameter.TimeLine == "week")
                {
                    ReportName = "ResourceWeek";
                    strSQL = "Exec usp_Whizible2_Sel_ResourceUtilizationDetails_Week_Resource_Report " + strParms;
                }
                else
                {
                    if (filterParameter.TimeLine == "halfyear")
                    {
                        ReportName = "ResourceHalfYear";
                    }
                    else
                    {
                        ReportName = "ResourceMonthYear";
                    }
                    //Commented and added by Chetan M on 19 Aug 2021 for report header
                    //strSQL = "Exec usp_Whizible2_Sel_ResourceUtilizationDetails_Monthly_Resource_Report " + strParms;
                    strSQL = "Exec usp_Whizible2_Sel_ResourceUtilizationDetails_Monthly_Resource_Report " + strParms + ",@BySiteResource ='" + filterParameter.ReportTab + "',@Year ='" + filterParameter.Year + "',@TimeLine ='" + filterParameter.TimeLine + "',@ReportIn ='" + filterParameter.ReportInStr + "',@intBusinessGroupsID =" + filterParameter.BusinessGroupID + ",@intLocationID =" + filterParameter.OrganizationUnitID + ",@ResourcePoolID =" + filterParameter.DeliveryUnitID + ",@ResourceGroupID =" + filterParameter.DeliveryTeamID + ",@ResourceName ='" + filterParameter.ResourceName + "'";
                    //End of Commented and added by Chetan M on 19 Aug 2021 for report header
                }
            }

            //Added by imran 12-10-2021
            strSQL = strSQL.Replace("\"", "");
            //End by imran on 12-10-2021


            ResourceUtilizationsFilter objFiler = new ResourceUtilizationsFilter();
            objFiler.ReportName = ReportName;
            objFiler.StrSql = strSQL;
            objFiler.IsNextHalfYear = IsNextMonth;
            return objFiler;
        }

        #endregion

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public object ExportDocument([FromBody] ResourceUtilizationFilter filterParameter)
        {           
            try
            {
                string strSQL = "";
                string strFilePath;
                string m_strFileName;
                long m_lngReportID;
                int DateFormatID = 0;
                string CompanyName = "";
                string ReportFormat = filterParameter.ReportFormat;
                int HalfYearlyReportId = 0;
                bool IsNextMonth = false;

                int lngDefaultLCID;
                int lngCurrentThreadUICultureID;
                lngDefaultLCID = 1033;
                lngCurrentThreadUICultureID = 1033;
                AdHocReports.Report.AdHocReport oRpt;
                string strParms = string.Empty;
                string ReportName = string.Empty;

                //Added by imran 14-10-2021 for pagination
                strParms += "@intPageNo =" + filterParameter.PageNo + ",@intPageSize =" + filterParameter.PageSize + ",";
                //End by imran 14-10-2021 for pagination

                if (!string.IsNullOrEmpty(filterParameter.YearPrevNext))
                {
                    strParms += "@ForCurrentYear=" + filterParameter.YearPrevNext + ",";
                }
                if (!string.IsNullOrEmpty(filterParameter.ReportIn))
                {
                    strParms += "@IsForCapcityHr=" + filterParameter.ReportIn + ",";
                }
                if (!string.IsNullOrEmpty(filterParameter.TimeLine) && filterParameter.TimeLine != "quarter" && filterParameter.TimeLine != "week")
                {
                    int timeLine = 0;
                    if (filterParameter.TimeLine == "halfyear")
                    {
                        timeLine = 1;
                    }
                    strParms += "@IsHafYrarly=" + timeLine + ",";

                }
                if (filterParameter.RUWhereClause != null && !string.IsNullOrEmpty(filterParameter.RUWhereClause))
                {
                    strParms += "@WhereClause= '" + filterParameter.RUWhereClause + "'" + ",";
                }

                strParms = strParms.TrimEnd(',');

                IDataReader drCompInfo = CommonFunctions.Data.GetSQLDataReader("usp_Whizible2_sel_tbl_PM_CompanyInformation", CommonController.connectionString);

                while (drCompInfo.Read())
                {
                    CompanyName = CommonFunctions.Data.CheckIsDBNull(drCompInfo["CompanyName"], "").ToString();
                    DateFormatID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drCompInfo["DateFormatID"], "0"));
                    DateTime StartDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(drCompInfo["FinancialYearStart"], ""));
                    DateTime EndDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(drCompInfo["FinancialYearEnd"], " "));

                    var CurrentDate = DateTime.Now;
                    var FinancialHafStartDate = StartDate.AddMonths(6);
                    var FinancialHafStartDateMonth = FinancialHafStartDate.Month;
                    if (FinancialHafStartDateMonth > 8 && CurrentDate > EndDate)
                    {
                        IsNextMonth = true;
                    }

                }

                drCompInfo.Close();

                if (filterParameter.ReportTab == "Project")
                {
                    if (filterParameter.TimeLine == "quarter")
                    {
                        ReportName = "ProjectQuarter";
                        //strSQL = "Exec usp_Whizible2_Sel_ResourceUtilizationDetails_Qtr_Project_Report " + strParms;
                        strSQL = "Exec usp_Whizible2_Sel_ResourceUtilizationDetails_Qtr_Project_Report " + strParms + ",@BySiteResource ='" + filterParameter.ReportTab + "',@Year ='" + filterParameter.Year + "',@TimeLine ='" + filterParameter.TimeLine + "',@ReportIn ='" + filterParameter.ReportInStr + "',@intBusinessGroupsID =" + filterParameter.BusinessGroupID + ",@intLocationID =" + filterParameter.OrganizationUnitID + ",@ResourcePoolID =" + filterParameter.DeliveryUnitID + ",@ResourceGroupID =" + filterParameter.DeliveryTeamID + ",@ResourceName ='" + filterParameter.ResourceName + "'";
                    }
                    else if (filterParameter.TimeLine == "week")
                    {
                        ReportName = "ProjectWeek";
                        //strSQL = "Exec usp_Whizible2_Sel_ResourceUtilizationDetails_Week_Project_Report " + strParms;
                        strSQL = "Exec usp_Whizible2_Sel_ResourceUtilizationDetails_Week_Project_Report " + strParms + ",@BySiteResource ='" + filterParameter.ReportTab + "',@Year ='" + filterParameter.Year + "',@TimeLine ='" + filterParameter.TimeLine + "',@ReportIn ='" + filterParameter.ReportInStr + "',@intBusinessGroupsID =" + filterParameter.BusinessGroupID + ",@intLocationID =" + filterParameter.OrganizationUnitID + ",@ResourcePoolID =" + filterParameter.DeliveryUnitID + ",@ResourceGroupID =" + filterParameter.DeliveryTeamID + ",@ResourceName ='" + filterParameter.ResourceName + "'";
                    }
                    else
                    {
                        if (filterParameter.TimeLine == "halfyear")
                        {
                            ReportName = "ProjectHalfYear";
                            HalfYearlyReportId = IsNextMonth ? 35017 : 35024;
                        }
                        else
                        {
                            ReportName = "ProjectMonthYear";

                        }
                        //strSQL = "Exec usp_Whizible2_Sel_ResourceUtilizationDetails_Monthly_Project_Report " + strParms;
                        strSQL = "Exec usp_Whizible2_Sel_ResourceUtilizationDetails_Monthly_Project_Report " + strParms + ",@BySiteResource ='" + filterParameter.ReportTab + "',@Year ='" + filterParameter.Year + "',@TimeLine ='" + filterParameter.TimeLine + "',@ReportIn ='" + filterParameter.ReportInStr + "',@intBusinessGroupsID =" + filterParameter.BusinessGroupID + ",@intLocationID =" + filterParameter.OrganizationUnitID + ",@ResourcePoolID =" + filterParameter.DeliveryUnitID + ",@ResourceGroupID =" + filterParameter.DeliveryTeamID + ",@ResourceName ='" + filterParameter.ResourceName + "'";
                    }
                }
                else if (filterParameter.ReportTab == "Resources")
                {
                    if (filterParameter.TimeLine == "quarter")
                    {
                        ReportName = "ResourceQuarter";
                        //Commented and added by Chetan M on 19 Aug 2021 for report header
                        //strSQL = "Exec usp_Whizible2_Sel_ResourceUtilizationDetails_Qtr_Resource_Report " + strParms;
                        strSQL = "Exec usp_Whizible2_Sel_ResourceUtilizationDetails_Qtr_Resource_Report " + strParms + ",@BySiteResource ='" + filterParameter.ReportTab + "',@Year ='" + filterParameter.Year + "',@TimeLine ='" + filterParameter.TimeLine + "',@ReportIn ='" + filterParameter.ReportInStr + "',@intBusinessGroupsID =" + filterParameter.BusinessGroupID + ",@intLocationID =" + filterParameter.OrganizationUnitID + ",@ResourcePoolID =" + filterParameter.DeliveryUnitID + ",@ResourceGroupID =" + filterParameter.DeliveryTeamID + ",@ResourceName ='" + filterParameter.ResourceName + "'";
                        //End of Commented and added by Chetan M on 19 Aug 2021 for report header
                    }
                    else if (filterParameter.TimeLine == "week")
                    {
                        ReportName = "ResourceWeek";
                        //strSQL = "Exec usp_Whizible2_Sel_ResourceUtilizationDetails_Week_Resource_Report " + strParms;
                        strSQL = "Exec usp_Whizible2_Sel_ResourceUtilizationDetails_Week_Resource_Report " + strParms;
                    }
                    else
                    {
                        if (filterParameter.TimeLine == "halfyear")
                        {
                            ReportName = "ResourceHalfYear";
                            HalfYearlyReportId = IsNextMonth ? 35015 : 35025;
                        }
                        else
                        {
                            ReportName = "ResourceMonthYear";
                        }
                        //Commented and added by Chetan M on 19 Aug 2021 for report header
                        //strSQL = "Exec usp_Whizible2_Sel_ResourceUtilizationDetails_Monthly_Resource_Report " + strParms;
                        //strSQL = "Exec usp_Whizible2_Sel_ResourceUtilizationDetails_Monthly_Resource_Report " + strParms + ",@BySiteResource ='" + filterParameter.ReportTab + "',@Year ='" + filterParameter.Year + "',@TimeLine='" + filterParameter .TimeLine + "',@ReportIn ='" + filterParameter.ReportInStr + "'";
                        strSQL = "Exec usp_Whizible2_Sel_ResourceUtilizationDetails_Monthly_Resource_Report " + strParms + ",@BySiteResource ='" + filterParameter.ReportTab + "',@Year ='" + filterParameter.Year + "',@TimeLine ='" + filterParameter.TimeLine + "',@ReportIn ='" + filterParameter.ReportInStr + "',@intBusinessGroupsID =" + filterParameter.BusinessGroupID + ",@intLocationID =" + filterParameter.OrganizationUnitID + ",@ResourcePoolID =" + filterParameter.DeliveryUnitID + ",@ResourceGroupID =" + filterParameter.DeliveryTeamID + ",@ResourceName ='" + filterParameter.ResourceName + "'";
                        //End of Commented and added by Chetan M on 19 Aug 2021 for report header
                    }
                }

                IDataReader drCompInfo1 = CommonFunctions.Data.GetSQLDataReader(strSQL, CommonController.connectionString);
                if (drCompInfo1.Read() == false)
                {
                    return "";
                }
                // var ReportTab = filterParameter.TimeLine;// filterParameter.ReportTab;
                switch (ReportName)
                {
                    case "ProjectQuarter":
                        m_lngReportID = 35019;
                        break;
                    case "ProjectWeek":
                        m_lngReportID = 35023;
                        break;
                    case "ProjectHalfYear":
                        m_lngReportID = HalfYearlyReportId;
                        //m_lngReportID = 35024;
                        /// m_lngReportID = 35017;--april
                        break;
                    case "ProjectMonthYear":
                        m_lngReportID = 35016;
                        break;

                    case "ResourceQuarter":
                        m_lngReportID = 35018;
                        break;
                    case "ResourceWeek":
                        m_lngReportID = 35022;
                        break;

                    case "ResourceHalfYear":
                        m_lngReportID = HalfYearlyReportId;
                        break;
                    case "ResourceMonthYear":
                        m_lngReportID = 35014;
                        break;
                    default:
                        m_lngReportID = 35016;
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
