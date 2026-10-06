using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Configuration;
using WhizibleAPI.Models.Navigation;

namespace WhizibleAPI.Controllers
{
    public class CommonController : ApiController
    {
        public static string connectionString = CommonFunctions.General.BuildConnectionString(ConfigurationManager.AppSettings["ConnectionString"]);
        [HttpPost]
        [Authorize]
        public object GetCompanyInformation()
        {
            try
            {
                List<CompanyInformation> companyInformationList = new List<CompanyInformation>();

                DataTable CompanyInformationTable = CommonFunctions.Data.GetDataTable("usp_SEL_Tbl_PM_CompanyInformation ", true, CommonController.connectionString);
                foreach (DataRow companyInformationRow in CompanyInformationTable.Rows)
                {
                    CompanyInformation companyInformation = new CompanyInformation()
                    {
                        StartingDayOfWeek = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(companyInformationRow["StartingDayOfWeek"], "0")),
                        FinancialYearStart = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(companyInformationRow["FinancialYearStart"], "0")),
                        FinancialYearEnd = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(companyInformationRow["FinancialYearEnd"], "0")),
                        //Commented By Dipali V on 29th April 2026 For Hide Server Details  for Security 
                        //SMTPUserName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(companyInformationRow["SMTPUserName"], "")),
                        //SMTPPassword = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(companyInformationRow["SMTPPassword"], "")),
                        //SMTPDomainName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(companyInformationRow["SMTPDomainName"], "")),
                        //SMTPServerPort = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(companyInformationRow["SMTPServerPort"], "0")),
                        //EmailFormat = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(companyInformationRow["EmailFormat"], "")),
                        //SMTPServer = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(companyInformationRow["SMTPServer"], "")),
                        //End of Commented By Dipali V on 29th April 2026 For Hide Server Details  for Security 
                        AllowResourceAllocation = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(companyInformationRow["AllowResourceAllocation"], "0")),
                    };
                    companyInformationList.Add(companyInformation);
                }
                return companyInformationList;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
    }

}
