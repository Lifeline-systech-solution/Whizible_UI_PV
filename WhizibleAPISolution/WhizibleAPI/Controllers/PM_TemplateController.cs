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
    public class PM_TemplateController : ApiController
    {
        [HttpPost]
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        ////End of comment by imran on 16-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object AddNewTemplate([FromBody] TemplateClass templateParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_PM_CustomerTemplate '" + HttpUtility.UrlDecode(templateParameter.TemplateName) + "','" + HttpUtility.UrlDecode(templateParameter.UserName) + "'";
                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return Result;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        [HttpPost]
        public object GetTemplateDetails([FromBody] int Nothing)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_sel_tbl_Whizible2_PM_CustomerTemplate ";
                DataTable TemplateDetails = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return TemplateDetails;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateSiteTemplate([FromBody] TemplateClass templateParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_upd_tbl_Whizible2_PM_CustomerTemplate " + HttpUtility.UrlDecode(Convert.ToString(templateParameter.TemplateID)) + ",'"
                                                                                     + HttpUtility.UrlDecode(templateParameter.TemplateName) + "',"
                                                                                     + HttpUtility.UrlDecode(Convert.ToString(templateParameter.IsActive));
                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return Result;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        [HttpPost]
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object AddNewTemplateSite([FromBody] TemplateClass templateParameter)
        {
            try
            {
                string strSQL = "";
                if (templateParameter.City == "")
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_PM_CustomerTemplateSite "
                        + HttpUtility.UrlDecode(Convert.ToString(templateParameter.TemplateID)) + ",'"
                        + HttpUtility.UrlDecode(templateParameter.SiteName) + "',NULL,NULL,"
                        + HttpUtility.UrlDecode(Convert.ToString(templateParameter.WeekDays)) + ",'"
                        + HttpUtility.UrlDecode(templateParameter.WorkHours) + "','"
                        + HttpUtility.UrlDecode(templateParameter.WorkHoursPerMonth) + "','"
                        + HttpUtility.UrlDecode(templateParameter.WorkHoursCapPerDay) + "','"
                        + HttpUtility.UrlDecode(templateParameter.UserName) + "',"
                        + HttpUtility.UrlDecode(Convert.ToString(templateParameter.CurrencyID)) + ","
                        + HttpUtility.UrlDecode(Convert.ToString(templateParameter.RateMethod)) + ",NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,"
                        + HttpUtility.UrlDecode(Convert.ToString(templateParameter.StartingDayOfWeek)) + ",NULL";


                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_PM_CustomerTemplateSite "
                         + HttpUtility.UrlDecode(Convert.ToString(templateParameter.TemplateID)) + ",'"
                         + HttpUtility.UrlDecode(templateParameter.SiteName) + "',NULL,'"
                         + HttpUtility.UrlDecode(templateParameter.City) + "',"
                         + HttpUtility.UrlDecode(Convert.ToString(templateParameter.WeekDays)) + ",'"
                         + HttpUtility.UrlDecode(templateParameter.WorkHours) + "','"
                         + HttpUtility.UrlDecode(templateParameter.WorkHoursPerMonth) + "','"
                         + HttpUtility.UrlDecode(templateParameter.WorkHoursCapPerDay) + "','"
                         + HttpUtility.UrlDecode(templateParameter.UserName) + "',"
                         + HttpUtility.UrlDecode(Convert.ToString(templateParameter.CurrencyID)) + ","
                         + HttpUtility.UrlDecode(Convert.ToString(templateParameter.RateMethod)) + ",NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,"
                         + HttpUtility.UrlDecode(Convert.ToString(templateParameter.StartingDayOfWeek)) + ",NULL";

                }

                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return Result;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveSiteDetails([FromBody] TemplateClass templateParameter)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_PM_CustomerTemplateSite "
                        + HttpUtility.UrlDecode(Convert.ToString(templateParameter.TemplateID)) + ",'"
                        + HttpUtility.UrlDecode(templateParameter.SiteName) + "','"
                        + HttpUtility.UrlDecode(templateParameter.SiteShortName) + "','"
                        + HttpUtility.UrlDecode(templateParameter.City) + "',"
                        + HttpUtility.UrlDecode(Convert.ToString(templateParameter.WeekDays)) + ",'"
                        + HttpUtility.UrlDecode(templateParameter.WorkHours) + "','"
                        + HttpUtility.UrlDecode(templateParameter.WorkHoursPerMonth) + "','"
                        + HttpUtility.UrlDecode(templateParameter.WorkHoursCapPerDay) + "','"
                        + HttpUtility.UrlDecode(templateParameter.UserName) + "',"
                        + HttpUtility.UrlDecode(Convert.ToString(templateParameter.CurrencyID)) + ","
                        + HttpUtility.UrlDecode(Convert.ToString(templateParameter.RateMethod)) + ",NULL,'"
                        + HttpUtility.UrlDecode(templateParameter.Address) + "',NULL,"
                        + HttpUtility.UrlDecode(Convert.ToString(templateParameter.CountryID)) + ",'"
                        + HttpUtility.UrlDecode(templateParameter.State) + "','"
                        + HttpUtility.UrlDecode(templateParameter.Zip) + "','"
                        + HttpUtility.UrlDecode(templateParameter.Fax) + "','"
                        + HttpUtility.UrlDecode(templateParameter.Phone) + "','"
                        + HttpUtility.UrlDecode(templateParameter.EmailID) + "',NULL,"
                        + HttpUtility.UrlDecode(Convert.ToString(templateParameter.StartingDayOfWeek)) + ","
                        + HttpUtility.UrlDecode(Convert.ToString(templateParameter.SiteID));

                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return Result;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        [HttpPost]
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveRoleData([FromBody] TemplateClass templateParameter)
        {
            try
            {
                string strSQL = "";
                if (HttpUtility.UrlDecode(Convert.ToString(templateParameter.SiteRoleID)) == "0")
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_PM_CustomerTemplateSiteRole "
                       + HttpUtility.UrlDecode(Convert.ToString(templateParameter.SiteID)) + ","
                       + HttpUtility.UrlDecode(Convert.ToString(templateParameter.RoleID)) + ",'"
                       + HttpUtility.UrlDecode(Convert.ToString(templateParameter.NormalRate)) + "','"
                       + HttpUtility.UrlDecode(Convert.ToString(templateParameter.ExtraRate)) + "','"
                       + HttpUtility.UrlDecode(Convert.ToString(templateParameter.HolidayRate)) + "',"
                       + HttpUtility.UrlDecode(Convert.ToString(templateParameter.TemplateID)) + ","
                       + HttpUtility.UrlDecode(Convert.ToString(templateParameter.UserName)) + ",NULL";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_PM_CustomerTemplateSiteRole "
                       + HttpUtility.UrlDecode(Convert.ToString(templateParameter.SiteID)) + ","
                       + HttpUtility.UrlDecode(Convert.ToString(templateParameter.RoleID)) + ",'"
                       + HttpUtility.UrlDecode(Convert.ToString(templateParameter.NormalRate)) + "','"
                       + HttpUtility.UrlDecode(Convert.ToString(templateParameter.ExtraRate)) + "','"
                       + HttpUtility.UrlDecode(Convert.ToString(templateParameter.HolidayRate)) + "',"
                       + HttpUtility.UrlDecode(Convert.ToString(templateParameter.TemplateID)) + ","
                       + HttpUtility.UrlDecode(Convert.ToString(templateParameter.UserName)) + ","
                       + HttpUtility.UrlDecode(Convert.ToString(templateParameter.SiteRoleID));

                }

                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return Result;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        public object GetSiteRoleData([FromBody] TemplateClass templateParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_sel_tbl_Whizible2_PM_CustomerTemplateSiteRole "
                        + HttpUtility.UrlDecode(Convert.ToString(templateParameter.SiteID)) + ","
                        + HttpUtility.UrlDecode(Convert.ToString(templateParameter.TemplateID));
                DataTable SiteRoleData = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return SiteRoleData;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        public object GetTemplateSiteDetails([FromBody] TemplateClass templateParameter)
        {
            try
            {
                string strSQL = "";
                if (templateParameter.SiteID != 0)
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_Whizible2_PM_CustomerTemplateSite " + templateParameter.TemplateID + "," + templateParameter.SiteID;
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_Whizible2_PM_CustomerTemplateSite " + templateParameter.TemplateID;
                }
                DataTable TemplateSiteDetails = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return TemplateSiteDetails;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        public object GetMappedCustomerToTemplate([FromBody] int TemplateID)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_sel_tbl_Whizible2_PM_CustomerTemplateMapping " + HttpUtility.UrlDecode(Convert.ToString(TemplateID));

                DataTable MappedCustomerToTemplate = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return MappedCustomerToTemplate;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        public object GetCustomerData([FromBody] int Nothing)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Customer_ForProject NULL,NULL,NULL,NULL";

                DataTable CustomerData = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return CustomerData;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        [HttpPost]
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveMappedCustomer([FromBody] TemplateClass templateParameter)
        {
            try
            {
                string strSQL = "";
                object Result = "";

                strSQL = "Exec usp_Whizible2_del_tbl_Whizible2_PM_CustomerTemplateMapping " + HttpUtility.UrlDecode(Convert.ToString(templateParameter.TemplateID));
                Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                //Added By Dipali V On 5th April 2023 For Saving Not Working
                var CustomerArr_New = templateParameter.CustomerArr.Split(',');
                for (int i = 0; i < (CustomerArr_New.Length); i++)
                //End of Added By Dipali V On 5th April 2023 For Saving Not Working
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_PM_CustomerTemplateMapping "
                        //Added By Dipali V On 5th April 2023 For Saving Not Working
                        + HttpUtility.UrlDecode(Convert.ToString(CustomerArr_New[i])) + ","
                        //End of Added By Dipali V On 5th April 2023 For Saving Not Working
                        + HttpUtility.UrlDecode(Convert.ToString(templateParameter.TemplateID)) + ",'"
                        + HttpUtility.UrlDecode(templateParameter.UserName) + "'";

                    Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                }

                return Result;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        public object checkDuplicateSite([FromBody] TemplateClass templateParameter)
        {
            try
            {
                string strSQL = "";
                object Result = "";

                strSQL = "Exec usp_Whizible2_chk_Site_Exists_tbl_Whizible2_PM_CustomerTemplateSite '" + HttpUtility.UrlDecode(templateParameter.SiteName) + "'," + HttpUtility.UrlDecode(Convert.ToString(templateParameter.TemplateID));
                Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return Result;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        public object checkDuplicateTemplate([FromBody] string TemplateName)
        {
            try
            {
                string strSQL = "";
                object Result = "";

                strSQL = "Exec usp_Whizible2_chk_Template_Exists_tbl_Whizible2_PM_CustomerTemplate '" + HttpUtility.UrlDecode(TemplateName) + "'";
                Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return Result;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        [HttpPost]
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        public object checkDuplicateRoleName([FromBody] TemplateClass templateParameter)
        {
            try
            {
                string strSQL = "";
                object Result = "";

                strSQL = "Exec usp_Whizible2_chk_Role_Exists_tbl_Whizible2_PM_CustomerTemplateSiteRole " + HttpUtility.UrlDecode(Convert.ToString(templateParameter.RoleID)) + ","
                                                                                                          + HttpUtility.UrlDecode(Convert.ToString(templateParameter.SiteID));
                Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return Result;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        public object GetTemplateSiteRole([FromBody] int SiteID)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec Usp_Whizible2_Sel_tbl_PM_Roles_TemplateSite " + SiteID;

                DataTable TemplateSiteRoleData = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return TemplateSiteRoleData;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        public object GetCorporateLevelSiteData([FromBody] int ProjectCostTypeID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_sel_tbl_CNF_ProjectCostType_ProjectCostTypeID " + ProjectCostTypeID;
                DataTable CorporateLevelSiteData = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return CorporateLevelSiteData;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Chetan M on 19th Dec 2019
        [HttpPost]
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        public object GetRolesOfProjectSiteMaster([FromBody] int ProjectCostTypeID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_whizible2_sel_v_tbl_CNF_ProjectCostTypeRole " + ProjectCostTypeID;
                DataTable CorporateLevelSiteRoleData = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return CorporateLevelSiteRoleData;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of addition by Chetan M on 19th Dec 2019

        public class TemplateClass
        {
            public int CustomerID { get; set; }
            public int TemplateID { get; set; }
            public int ProjectID { get; set; }
            public int WeekDays { get; set; }
            public int IsActive { get; set; }
            public int SiteID { get; set; }
            public int CurrencyID { get; set; }
            public int RateMethod { get; set; }
            public int CountryID { get; set; }
            public int StartingDayOfWeek { get; set; }
            public int RoleID { get; set; }
            public int SiteRoleID { get; set; }
            //Commented and Modified By RehanC for Parameter Mismatch issue on 05th May 2023
            //public double NormalRate { get; set; }
            //public double ExtraRate { get; set; }
            //public double HolidayRate { get; set; }
            public string NormalRate { get; set; }
            public string ExtraRate { get; set; }
            public string HolidayRate { get; set; }
            //End of Comment By RehanC on 05th May 2023
            public string TemplateName { get; set; }
            public string UserName { get; set; }
            public string SiteName { get; set; }
            public string SiteShortName { get; set; }
            public string City { get; set; }
            public string WorkHours { get; set; }
            public string WorkHoursPerMonth { get; set; }
            public string ExtraHoursCap { get; set; }
            public string Address { get; set; }
            public string State { get; set; }
            public string Zip { get; set; }
            public string Fax { get; set; }
            public string Phone { get; set; }
            public string EmailID { get; set; }
           // public int[] CustomerArr { get; set; }
            public string CustomerArr { get; set; }
            public string WorkHoursCapPerDay { get; set; }

        }
    }
}
