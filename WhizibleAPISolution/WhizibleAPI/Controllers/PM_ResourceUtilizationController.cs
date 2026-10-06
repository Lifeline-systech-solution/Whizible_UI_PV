using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;

namespace WhizibleAPI.Controllers
{
    /// Created Date    :  30-07-2021
    /// Purpose         :   Resource Utilization
    /// 
    public class PM_ResourceUtilizationController : ApiController
    {
        ////Added by Imran M 30-07-2021  Resource Utilization Default Data
        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object GetResourceUtilizationDefaultData([FromBody] ResourceUtilizationParameter UtilizationParameter)
        {
            try
            {
                string strSQL = "";
                if (UtilizationParameter.ResourceName == null || UtilizationParameter.ResourceName == "Select Resource")
                {
                    UtilizationParameter.ResourceName = "null";
                }
                else
                {
                    UtilizationParameter.ResourceName = UtilizationParameter.ResourceName;
                }

                if (UtilizationParameter.Month == null || UtilizationParameter.Month == "Select Month")
                {
                    UtilizationParameter.Month = "null";
                }
                else
                {
                    UtilizationParameter.Month = UtilizationParameter.Month;
                }

                if (UtilizationParameter.Year == null || UtilizationParameter.Year == "Select Year")
                {
                    UtilizationParameter.Year = "null";
                }
                else
                {
                    UtilizationParameter.Year = UtilizationParameter.Year;
                }

                strSQL = "Exec use_Sel_Whizible2_Utilization_DefaultData " + "'" + UtilizationParameter.ProjectID + "' ," + "'" + UtilizationParameter.ResourceName + "'," + "'" + UtilizationParameter.Month + "'," + "'" + UtilizationParameter.Year + "'," + "'" + UtilizationParameter.intPageNo + "'," + "'" + UtilizationParameter.PageSize + "' ";
                DataTable ProjectDeliverableType = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectDeliverableType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Imran M 30-07-2021  Resource Utilization Default Data
        [HttpPost]
        [Authorize]
        public object GetResourceUtilizationAvailabilityBasedData([FromBody] ResourceUtilizationParameter UtilizationParameter)
        {
            try
            {
                string strSQL = "";

                if (UtilizationParameter.ResourceName == null || UtilizationParameter.ResourceName == "Select Resource")
                {
                    UtilizationParameter.ResourceName = "null";
                }
                else
                {
                    UtilizationParameter.ResourceName = UtilizationParameter.ResourceName;
                }

                if (UtilizationParameter.Month == null || UtilizationParameter.Month == "Select Month")
                {
                    UtilizationParameter.Month = "null";
                }
                else
                {
                    UtilizationParameter.Month = UtilizationParameter.Month;
                }

                if (UtilizationParameter.Year == null || UtilizationParameter.Year == "Select Year")
                {
                    UtilizationParameter.Year = "null";
                }
                else
                {
                    UtilizationParameter.Year = UtilizationParameter.Year;
                }

                strSQL = "Exec use_Sel_Whizible2_Utilization_AvailabilityBasedData " + "'" + UtilizationParameter.ProjectID + "' ," + "'" + UtilizationParameter.ResourceName + "'," + "'" + UtilizationParameter.Month + "'," + "'" + UtilizationParameter.Year + "'";
                DataTable ProjectDeliverableType = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectDeliverableType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Imran M 30-07-2021  Resource Utilization Default Data
        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object GetResourceName([FromBody] ResourceUtilizationParameter UtilizationParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec use_Sel_Whizible2_Utilization_ResourceName " + UtilizationParameter.ProjectID;
                DataTable ProjectDeliverableType = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectDeliverableType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Imran M 30-07-2021  Resource Utilization Default Data
        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object GetResourceView([FromBody] ResourceUtilizationParameter UtilizationParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Sel_tbl_UI_Views_ForCombo " + "'" + UtilizationParameter.TagID + "' ," + "'" + UtilizationParameter.UserId + "'";
                DataTable ProjectDeliverableType = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectDeliverableType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Imran 30-07-2021  Resource Utilization Default Data
        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object GetResourceViewSaveCombo([FromBody] ResourceUtilizationParameter UtilizationParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec use_Sel_Whizible2_Utilization_SaveViewComboValue " + "'" + UtilizationParameter.TagID + "'";
                DataTable ProjectDeliverableType = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectDeliverableType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Imran 16-08-2021 Utilization ViewShow To Delete or apply
        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object GetUtilizationViewData([FromBody] ResourceUtilizationParameter UtilizationParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec use_Sel_Whizible2_Utilization_ViewsShow " + "'" + UtilizationParameter.TagID + "'," + "'" + UtilizationParameter.UserId + "'";
                DataTable ProjectDeliverableType = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectDeliverableType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


            //Added by Imran 16-08-2021 Utilization Save
            [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object GetResourceViewSaveData([FromBody]ResourceUtilizationParameter UtilizationParameter)
        {
            try { 
            string strSQL = "";
            strSQL = "Exec use_Sel_Whizible2_Utilization_SaveData " + "'" + UtilizationParameter.TagID + "'," + "'" + UtilizationParameter.UserId + "'," + "'" + UtilizationParameter.FilterId + "'," + "'" + UtilizationParameter.ViewName.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'," + "'" + UtilizationParameter.Columns + "'," + "'" + UtilizationParameter.HiddenViewID + "'";
            DataTable ProjectDeliverableType = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
            return ProjectDeliverableType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Imran 16-08-2021 Utilization delete
        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UtilizationViewDataDelete([FromBody] ResourceUtilizationParameter UtilizationParameter)
        {
            try
            {
                string strSQL = "";
                // DataTable items= new DataTable();
                int tcount = 0;
                string[] k = UtilizationParameter.ViewId.Split('`');

                for (int i = 0; i < k.Length; i++)
                {
                    if (k[i].ToString() == "" || k[i].ToString() == null)
                    { }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_del_Whizible2_SelectedViewDataDelete " + "'" + UtilizationParameter.TagID + "'," + "'" + k[i] + "'";
                        CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                        tcount += 1;
                    }
                }
                return tcount;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Imran 16-08-2021 Utilization Fill Data
        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object GetResourceViewDataForUpdate([FromBody] ResourceUtilizationParameter UtilizationParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec use_Sel_Whizible2_Utilization_DataForUpdate " + "'" + UtilizationParameter.TagID + "'," + "'" + UtilizationParameter.ViewId + "'";
                DataTable ProjectDeliverableType = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectDeliverableType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Imran 17-08-2021 Utilization Dynamic Column Fetch
        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object GetResourceDynamicColumnFetch([FromBody] ResourceUtilizationParameter UtilizationParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec use_Sel_Whizible2_Utilization_DynamicColumnFetch " + "'" + UtilizationParameter.TagID + "'," + "'" + UtilizationParameter.ViewName.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                DataTable ProjectDeliverableType = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectDeliverableType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Imran 17-08-2021 MonthNameFetch
        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object GetMonth([FromBody] ResourceUtilizationParameter UtilizationParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec use_Sel_Whizible2_Utilization_ResourceMonth " + "'" + UtilizationParameter.ProjectID + "'";
                DataTable ProjectDeliverableType = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectDeliverableType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Imran 17-08-2021 MonthYear FetchNameFetch
        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object GetYear([FromBody] ResourceUtilizationParameter UtilizationParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec use_Sel_Whizible2_Utilization_ResourceYear " + "'" + UtilizationParameter.ProjectID + "'";
                DataTable ProjectDeliverableType = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectDeliverableType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object GetResourceDynamicColumnDataFetch([FromBody] ResourceUtilizationParameter UtilizationParameter)
        {
            try
            {
                string strSQL = ""; string twh = " Where 1=1 AND ProjectID = " + UtilizationParameter.ProjectID;
                if (UtilizationParameter.ResourceName == null || UtilizationParameter.ResourceName == "Select Resource")
                { }
                else
                {
                    twh = twh + " And v_tbl_PM_ResourceUtilizationDetails_Monthly_Project.EmployeeName = " + "'" + UtilizationParameter.ResourceName + "'";
                }

                if (UtilizationParameter.Month == null || UtilizationParameter.Month == "Select Month")
                {

                }
                else
                {
                    twh = twh + " And v_tbl_PM_ResourceUtilizationDetails_Monthly_Project.MonthName = " + "'" + UtilizationParameter.Month + "'";
                }

                if (UtilizationParameter.Year == null || UtilizationParameter.Year == "Select Year")
                {

                }
                else
                {
                    twh = twh + " And v_tbl_PM_ResourceUtilizationDetails_Monthly_Project.YearID = " + "'" + UtilizationParameter.Year + "'";
                }

                strSQL = "Select " + UtilizationParameter.TSQL + " From v_tbl_PM_ResourceUtilizationDetails_Monthly_Project " + twh;
                DataTable ProjectDeliverableType = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectDeliverableType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added by Imran 16-08-2021 Utilization Applyfilter Save
        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object SaveFilterData([FromBody] ResourceUtilizationParameter UtilizationParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec use_Sel_Whizible2_Utilization_FilterSaveData " + "'" + UtilizationParameter.TagID + "'," + "'" + UtilizationParameter.UserId + "'," + "'" + UtilizationParameter.ViewId + "','1'";
                DataTable ProjectDeliverableType = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectDeliverableType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Imran 16-08-2021 Utilization Applyfilter Save
        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object FetchFilterSelectedViewID([FromBody] ResourceUtilizationParameter UtilizationParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec use_Sel_Whizible2_Utilization_FilterViewID " + "'" + UtilizationParameter.TagID + "'," + "'" + UtilizationParameter.UserId + "'";
                DataTable ProjectDeliverableType = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectDeliverableType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Imran 18-08-2021 Utilization Applyfilter Save
        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object SetDefaultFilter([FromBody] ResourceUtilizationParameter UtilizationParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec use_Del_Whizible2_Utilization_DefaultFilterSet " + "'" + UtilizationParameter.TagID + "'," + "'" + UtilizationParameter.UserId + "'";
                DataTable ProjectDeliverableType = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectDeliverableType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        }


    public class ResourceUtilizationParameter
    {
        public string TagID { get; set; }
        public string ProjectID { get; set; }
        public string ResourceName { get; set; }
        public string Month { get; set; }
        public string Year { get; set; } 
        public string UserId { get; set; } 
        public string ViewId { get; set; } 
        public string FilterId { get; set; } 
        public string ViewName { get; set; } 
        public string Columns { get; set; } 
        public string HiddenViewID { get; set; } 
        public string TSQL { get; set; } 
        public int intPageNo { get; set; } 
        public int PageSize { get; set; } 
    }
}
