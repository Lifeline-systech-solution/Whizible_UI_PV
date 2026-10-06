using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WhizibleAPI.Models.Navigation;

namespace WhizibleAPI.Controllers
{
    public class NavigationController : ApiController
    {
        [HttpPost]
        [Authorize]
        ////Commented and Added by Dipali V On 20th Jan 2020 For ProjectID To Plottree
        //  public List<TagMaster> GetTagMasters([FromBody]int employeeID , int ProjectID)
        //public List<TagMaster> GetTagMasters([FromBody]int employeeID)
        //{
        public object GetTagMasters([FromBody] TagMaster TagMasterParameters)
        {
            try
            {
                //End of Commented and Added by Dipali V On 20th Jan 2020 For ProjectID To Plottree
                List<TagMaster> tagMasters = new List<TagMaster>();

                DataTable tagMastersTable = CommonFunctions.Data.GetDataTable("usp_sel_tbl_Whizible2_TagMaster " + TagMasterParameters.EmployeeID + "," + TagMasterParameters.ProjectID, true, CommonController.connectionString);
                foreach (DataRow tagmasterRow in tagMastersTable.Rows)
                {

                    TagMaster tagMaster = new TagMaster();
                    tagMaster.TagID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(tagmasterRow["TagID"], "0"));
                    tagMaster.TemplateID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(tagmasterRow["TemplateID"], ""));
                    tagMaster.DisplayPageName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(tagmasterRow["DisplayPageName"], ""));
                    tagMaster.DisplayTagName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(tagmasterRow["DisplayTagName"], ""));
                    tagMaster.ParentTagId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(tagmasterRow["ParentTagId"], "0"));
                    tagMaster.IsParent = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(tagmasterRow["IsParent"], "0"));
                    tagMaster.Image = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(tagmasterRow["Image"], ""));
                    tagMaster.IsDefaultPage = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(tagmasterRow["IsDefaultPage"], "0"));
                    tagMaster.DisplayHeader = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(tagmasterRow["DisplayHeader"], ""));
                    tagMaster.AllowResponsive = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(tagmasterRow["AllowResponsive"], "0"));
                    tagMaster.ResponsivePageName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(tagmasterRow["ResponsivePageName"], ""));
                    tagMaster.ActiveResponsiveImage = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(tagmasterRow["ActiveResponsiveImage"], ""));
                    tagMaster.NonActiveResponsiveImage = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(tagmasterRow["NonActiveResponsiveImage"], ""));
                    tagMaster.IsLandingPage = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(tagmasterRow["IsLandingPage"], "0"));
                    tagMaster.IsDefaultModule = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(tagmasterRow["IsDefaultModule"], "0"));
                    tagMasters.Add(tagMaster);
                }
                return tagMasters;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        [HttpPost]
        [Authorize]
        public object GetEmployeeDetails([FromBody] int employeeID)
        {
            try
            {
                List<Employee> EmployeeDetails = new List<Employee>();
                DataTable EmployeeDetailsTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetEmployeeInformation " + employeeID, true, CommonController.connectionString);
                foreach (DataRow employeeRow in EmployeeDetailsTable.Rows)
                {
                    Employee employee = new Employee();
                    employee.EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(employeeRow["EmployeeID"], "0"));
                    employee.EmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(employeeRow["EmployeeName"], ""));
                    employee.Role = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(employeeRow["Role"], ""));
                    employee.EmployeeImage = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(employeeRow["EmployeeImage"], ""));
                    employee.RoleID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(employeeRow["RoleID"], "0"));
                    EmployeeDetails.Add(employee);
                }
                return EmployeeDetails;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        [HttpGet]
        public object GetString()
        {
            try
            {
                return "Test";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        [HttpPost]
        [Authorize]
        public object PostLandingPageInformation([FromBody] TMSParameters taskParameters)
        {
            try
            {
                string Message;

                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.InsertOrUpdateData("usp_Ins_tbl_Whizible2_UserLandingPage " + taskParameters.EmployeeID + "," + taskParameters.TagID + "", true, CommonController.connectionString), ""));

                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        }
    public class TMSParameters
    {
        public int EmployeeID { get; set; }
        public int TagID { get; set; }
    }

    //Added by Dipali V On 20th Jan 2020 For ProjectID To Plottree
    public class TagMaster
    {
        public int TagID { get; set; }
        public string TemplateID { get; set; }
        public string DisplayPageName { get; set; }
        public string DisplayTagName { get; set; }
        public int ParentTagId { get; set; }
        public int IsParent { get; set; }
        public string Image { get; set; }
        public int IsDefaultPage { get; set; }
        public string DisplayHeader { get; set; }
        public int AllowResponsive { get; set; }
        public string ResponsivePageName { get; set; }
        public string ActiveResponsiveImage { get; set; }
        public string NonActiveResponsiveImage { get; set; }
        public int ProjectID { get; set; }//Added by Dipali V On 20th Jan 2020 For ProjectID To Plottree
        public int EmployeeID { get; set; }
        public int IsLandingPage { get; set; }
        public int IsDefaultModule { get; set; }

    }

    //End of Added by Dipali V On 20th Jan 2020 For ProjectID To Plottree
}
