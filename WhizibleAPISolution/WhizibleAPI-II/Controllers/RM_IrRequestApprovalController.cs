using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WhizibleAPI.Extensions;
using WhizibleAPI.Models.RBG;
using WhizibleAPI.Models.RM;

namespace WhizibleAPI.Controllers
{
    ////[Authorize] do the uncomment after getting menu details 
    public class RM_IrRequestApprovalController : ApiController
    {
        [HttpPost]
        public HttpResponseMessage GetIrProjectsForRequestApproval([FromBody] IR_RequestAppParams IrParameter)
        {
            var IrProjectList = new List<IR_RequestApprovalProjects>();
            try
            {
                if (IrParameter.UserID > 0)
                {
                    string strSQL = "Exec usp_Whizible2_Sel_AccessibleProjects_ForEmployee " + IrParameter.UserID + "";
                    DataTable IrProjectTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (IrProjectTable != null)
                        IrProjectList = IrProjectTable.ToList<IR_RequestApprovalProjects>();
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, IrProjectList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            
        }
        /// <summary>
        /// Approval list using logged user id and filter value
        /// </summary>
        /// <param name="IrParameter"></param>
        /// <returns></returns>

        [HttpPost]
        public HttpResponseMessage GetIrRequestApprovals([FromBody] IR_RequestApprovalListParams IrParameter)
        {
            var IrRequestApprovalList = new List<IR_RequestsApprovalRequest>();
            try
            {
                if (IrParameter.UserID > 0)
                { 
                    // we need do change the SP
                    string strSQL = "Exec usp_Whizible2_Sel_AccessibleProjects_ForEmployee " + IrParameter.UserID + "";
                    DataTable IrApprovalListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (IrApprovalListTable != null)
                        IrRequestApprovalList = IrApprovalListTable.ToList<IR_RequestsApprovalRequest>();
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, IrRequestApprovalList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }
        /// <summary>
        /// Week list : collapse panel and Next Previous Click on resp request
        /// </summary>
        /// <param name="IrParameter"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage GetIrRequestApprovalWeeks([FromBody] IR_RequestApprovalListParams IrParameter)
        {
            var IrRequestApprovalList = new List<IR_RequestsApprovalRequestWeek>();
            try
            {
                if (IrParameter.UserID > 0)
                {
                    // we need do change the SP
                    string strSQL = "Exec usp_Whizible2_Sel_AccessibleProjects_ForEmployee " + IrParameter.UserID + "";
                    DataTable IrApprovalWeekTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (IrApprovalWeekTable != null)
                        IrRequestApprovalList = IrApprovalWeekTable.ToList<IR_RequestsApprovalRequestWeek>();
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, IrRequestApprovalList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            
        }

        /// <summary>
        /// Click on details row or next if the details view is open 
        /// </summary>
        /// <param name="IrParameter"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage GetIrRequestApprovalWeekDetails([FromBody] IR_RequestApprovalListParams IrParameter)
        {
            var IrRequestApprovalWeekDetailsList = new List<IR_RequestsApprovalRequest>();
            try
            {
                if (IrParameter.UserID > 0)
                {
                    // we need do change the SP
                    string strSQL = "Exec usp_Whizible2_Sel_AccessibleProjects_ForEmployee " + IrParameter.UserID + "";
                    DataTable IrApprovalWeekDetailsTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (IrApprovalWeekDetailsTable != null)
                        IrRequestApprovalWeekDetailsList = IrApprovalWeekDetailsTable.ToList<IR_RequestsApprovalRequest>();
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, IrRequestApprovalWeekDetailsList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
           
        }


        [HttpPost]
        public object GetUserIsInfraApprover([FromBody] int userID)
        {
            string strSQL = "";
            DataTable dt;
            try
            {
                strSQL = "EXEC usp_Whizible2_RM_Check_InfraApproverAccess " + userID;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return "AuthenticationError";
            }

        }

    }
}
