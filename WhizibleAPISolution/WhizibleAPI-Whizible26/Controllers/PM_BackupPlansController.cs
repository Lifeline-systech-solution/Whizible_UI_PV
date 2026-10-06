using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models.PM;

namespace WhizibleAPI.Controllers
{
    public class PM_BackupPlansController : ApiController
    {
        /// <summary>
        /// Get accessible projects for the logged-in user
        /// </summary>
        /// <param name="projectSelectionParameter">User information and optional project ID</param>
        /// <returns>List of accessible projects</returns>
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetProjectID([FromBody] ProjectSelectionParameter projectSelectionParameter)
        {
            try
            {
                // Debug logging
                System.Diagnostics.Debug.WriteLine($"GetProjectID called with EmployeeId: {projectSelectionParameter.EmployeeId}, ProjectId: {projectSelectionParameter.ProjectId}, LoginType: {projectSelectionParameter.LoginType}");
                
                string strSQL = "Exec usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList " + HttpUtility.UrlDecode(Convert.ToString(projectSelectionParameter.EmployeeId)) + "";

                if (projectSelectionParameter.ProjectId == 0)
                {
                    strSQL = strSQL + ", 0, 0, NULL,0, '" + HttpUtility.UrlDecode(projectSelectionParameter.LoginType) + "', 1, 0, 0, 0, NULL, NULL";
                }
                else
                {
                    strSQL = strSQL + ", 0, 0, NULL,0, '" + HttpUtility.UrlDecode(projectSelectionParameter.LoginType) + "', 1, 0, 0, 0, NULL, " + HttpUtility.UrlDecode(Convert.ToString(projectSelectionParameter.ProjectId));
                }

                System.Diagnostics.Debug.WriteLine($"SQL Query: {strSQL}");
                
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                System.Diagnostics.Debug.WriteLine($"Query returned {dt.Rows.Count} rows");
                return dt;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Exception in GetProjectID: {ex.Message}");
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found: " + ex.Message);
            }
        }

        /// <summary>
        /// Get backup plans for a specific project with optional filtering
        /// </summary>
        /// <param name="backupPlanParameter">Project ID, user information, and optional filters</param>
        /// <returns>List of backup plans for the project</returns>
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetBackupPlans([FromBody] BackupPlanParameter backupPlanParameter)
        {
            try
            {
                // Validate required parameters
                if (backupPlanParameter.ProjectId <= 0)
                {
                    return Request.CreateErrorResponse(HttpStatusCode.BadRequest, "Valid Project ID is required");
                }

                // Build the stored procedure call with proper parameter handling including pagination
                string strSQL = "Exec usp_Whizible2_Sel_PM_tbl_PRS_BackupPlan " +
                    HttpUtility.UrlDecode(Convert.ToString(backupPlanParameter.ProjectId)) + "," +
                    (backupPlanParameter.BackPlanID.HasValue ? HttpUtility.UrlDecode(Convert.ToString(backupPlanParameter.BackPlanID)) : "NULL") + "," +
                    (string.IsNullOrEmpty(backupPlanParameter.Responsibility) ? "NULL" : "'" + HttpUtility.UrlDecode(backupPlanParameter.Responsibility).Replace("'", "''") + "'") + "," +
                    (string.IsNullOrEmpty(backupPlanParameter.DirectoryLocation) ? "NULL" : "'" + HttpUtility.UrlDecode(backupPlanParameter.DirectoryLocation).Replace("'", "''") + "'") + "," +
                    (string.IsNullOrEmpty(backupPlanParameter.Frequency) ? "NULL" : "'" + HttpUtility.UrlDecode(backupPlanParameter.Frequency).Replace("'", "''") + "'") + "," +
                    (string.IsNullOrEmpty(backupPlanParameter.Media) ? "NULL" : "'" + HttpUtility.UrlDecode(backupPlanParameter.Media).Replace("'", "''") + "'") + "," +
                    (backupPlanParameter.NumberOfCopies.HasValue ? HttpUtility.UrlDecode(Convert.ToString(backupPlanParameter.NumberOfCopies)) : "NULL") + "," +
                    (string.IsNullOrEmpty(backupPlanParameter.Remarks) ? "NULL" : "'" + HttpUtility.UrlDecode(backupPlanParameter.Remarks).Replace("'", "''") + "'") + "," +
                    HttpUtility.UrlDecode(Convert.ToString(backupPlanParameter.PageNumber)) + "," +
                    HttpUtility.UrlDecode(Convert.ToString(backupPlanParameter.PageSize));
                
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                
                // Check if the result contains error information
                if (dt.Rows.Count > 0 && dt.Columns.Contains("ErrorNumber"))
                {
                    var errorRow = dt.Rows[0];
                    return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, 
                        "Database Error: " + errorRow["ErrorMessage"].ToString());
                }
                
                List<PM_BackupPlans> backupPlans = new List<PM_BackupPlans>();
                int totalRecords = 0;
                int currentPage = backupPlanParameter.PageNumber;
                int pageSize = backupPlanParameter.PageSize;
                int totalPages = 0;
                
                // Extract pagination metadata from first row only (if available)
                if (dt.Rows.Count > 0 && dt.Columns.Contains("TotalRecords"))
                {
                    var firstRow = dt.Rows[0];
                    totalRecords = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(firstRow["TotalRecords"], "0"));
                    currentPage = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(firstRow["CurrentPage"], "1"));
                    pageSize = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(firstRow["PageSize"], "10"));
                    totalPages = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(firstRow["TotalPages"], "0"));
                }
                
                foreach (DataRow row in dt.Rows)
                {
                    
                    PM_BackupPlans backupPlan = new PM_BackupPlans
                    {
                        BackPlanID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(row["BackPlanID"], "0")),
                        ProjectId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(row["ProjectID"], "0")),
                        Description = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["Description"], "")),
                        Responsibility = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["Responsibility"], "")),
                        Frequency = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["Frequency"], "")),
                        DirectoryLocation = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["DirectoryLocation"], "")),
                        Media = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["Media"], "")),
                        NumberOfCopies = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(row["NumberOfCopies"], "0")),
                        Remarks = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["Remarks"], "")),
                        CreatedBy = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["CreatedBy"], "")),
                        CreatedDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(row["CreatedDate"], DateTime.MinValue.ToString())),
                        ModifiedBy = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["ModifiedBy"], "")),
                        ModifiedDate = row["ModifiedDate"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(row["ModifiedDate"], DateTime.MinValue.ToString()))
                    };
                    backupPlans.Add(backupPlan);
                }
                
                // Return paginated response
                BackupPlanResponse response = new BackupPlanResponse
                {
                    Data = backupPlans,
                    TotalRecords = totalRecords,
                    CurrentPage = currentPage,
                    PageSize = pageSize,
                    TotalPages = totalPages
                };
                
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Error retrieving backup plans: " + ex.Message);
            }
        }

        /// <summary>
        /// Insert a new backup plan for a specific project
        /// </summary>
        /// <param name="backupPlanInsertParameter">Backup plan details and user information</param>
        /// <returns>Generated BackPlanID if successful, error message if failed</returns>
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object InsertBackupPlan([FromBody] BackupPlanInsertParameter backupPlanInsertParameter)
        {
            try
            {
                // Validate required fields
                if (string.IsNullOrEmpty(backupPlanInsertParameter.Description))
                {
                    return Request.CreateErrorResponse(HttpStatusCode.BadRequest, "Description is required");
                }

                if (backupPlanInsertParameter.ProjectId <= 0)
                {
                    return Request.CreateErrorResponse(HttpStatusCode.BadRequest, "Valid Project ID is required");
                }

                // Build the stored procedure call
                string strSQL = "Exec usp_Whizible2_Ins_PM_tbl_PRS_BackupPlan " +
                    HttpUtility.UrlDecode(Convert.ToString(backupPlanInsertParameter.ProjectId)) + "," +
                    "'" + HttpUtility.UrlDecode(backupPlanInsertParameter.Description).Replace("'", "''") + "'," +
                    "'" + HttpUtility.UrlDecode(backupPlanInsertParameter.Responsibility ?? "").Replace("'", "''") + "'," +
                    "'" + HttpUtility.UrlDecode(backupPlanInsertParameter.DirectoryLocation ?? "").Replace("'", "''") + "'," +
                    "'" + HttpUtility.UrlDecode(backupPlanInsertParameter.Frequency ?? "").Replace("'", "''") + "'," +
                    "'" + HttpUtility.UrlDecode(backupPlanInsertParameter.Media ?? "").Replace("'", "''") + "'," +
                    HttpUtility.UrlDecode(Convert.ToString(backupPlanInsertParameter.NumberOfCopies)) + "," +
                    "'" + HttpUtility.UrlDecode(backupPlanInsertParameter.Remarks ?? "").Replace("'", "''") + "'," +
                    "'" + HttpUtility.UrlDecode(backupPlanInsertParameter.CreatedBy).Replace("'", "''") + "'";

                // Execute the stored procedure and get the result
                object result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                
                // Check if the result contains an error
                if (result != null && result.ToString().Contains("Error"))
                {
                    return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, result.ToString());
                }

                // Return the generated BackPlanID
                return new { BackPlanID = result, Success = true, Message = "Backup plan created successfully" };
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Error creating backup plan: " + ex.Message);
            }
        }

        /// <summary>
        /// Update an existing backup plan
        /// </summary>
        /// <param name="backupPlanUpdateParameter">Backup plan details and user information for update</param>
        /// <returns>Number of rows affected if successful, error message if failed</returns>
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object UpdateBackupPlan([FromBody] BackupPlanUpdateParameter backupPlanUpdateParameter)
        {
            try
            {
                // Validate required fields
                if (backupPlanUpdateParameter.BackPlanID <= 0)
                {
                    return Request.CreateErrorResponse(HttpStatusCode.BadRequest, "Valid BackPlanID is required");
                }

                if (string.IsNullOrEmpty(backupPlanUpdateParameter.Description))
                {
                    return Request.CreateErrorResponse(HttpStatusCode.BadRequest, "Description is required");
                }

                if (backupPlanUpdateParameter.ProjectId <= 0)
                {
                    return Request.CreateErrorResponse(HttpStatusCode.BadRequest, "Valid Project ID is required");
                }

                // Build the stored procedure call
                string strSQL = "Exec usp_Whizible2_Upd_PM_tbl_PRS_BackupPlan " +
                    HttpUtility.UrlDecode(Convert.ToString(backupPlanUpdateParameter.BackPlanID)) + "," +
                    HttpUtility.UrlDecode(Convert.ToString(backupPlanUpdateParameter.ProjectId)) + "," +
                    "'" + HttpUtility.UrlDecode(backupPlanUpdateParameter.Description).Replace("'", "''") + "'," +
                    "'" + HttpUtility.UrlDecode(backupPlanUpdateParameter.Responsibility ?? "").Replace("'", "''") + "'," +
                    "'" + HttpUtility.UrlDecode(backupPlanUpdateParameter.DirectoryLocation ?? "").Replace("'", "''") + "'," +
                    "'" + HttpUtility.UrlDecode(backupPlanUpdateParameter.Frequency ?? "").Replace("'", "''") + "'," +
                    "'" + HttpUtility.UrlDecode(backupPlanUpdateParameter.Media ?? "").Replace("'", "''") + "'," +
                    HttpUtility.UrlDecode(Convert.ToString(backupPlanUpdateParameter.NumberOfCopies)) + "," +
                    "'" + HttpUtility.UrlDecode(backupPlanUpdateParameter.Remarks ?? "").Replace("'", "''") + "'," +
                    "'" + HttpUtility.UrlDecode(backupPlanUpdateParameter.ModifiedBy).Replace("'", "''") + "'";

                // Execute the stored procedure and get the result
                object result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                
                // Check if the result contains an error
                if (result != null && result.ToString().Contains("Error"))
                {
                    return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, result.ToString());
                }

                // Return the number of rows affected
                return new { RowsAffected = result, Success = true, Message = "Backup plan updated successfully" };
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Error updating backup plan: " + ex.Message);
            }
        }

        /// <summary>
        /// Delete a backup plan
        /// </summary>
        /// <param name="backupPlanDeleteParameter">Backup plan ID to delete</param>
        /// <returns>Status message if successful, error message if failed</returns>
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object DeleteBackupPlan([FromBody] BackupPlanDeleteParameter backupPlanDeleteParameter)
        {
            try
            {
                // Validate required parameter
                if (backupPlanDeleteParameter.BackPlanID <= 0)
                {
                    return Request.CreateErrorResponse(HttpStatusCode.BadRequest, "Valid BackPlanID is required");
                }

                // Build the stored procedure call - using the correct stored procedure signature
                string strSQL = "Exec usp_Whizible2_Del_PM_tbl_PRS_BackupPlan " + 
                    HttpUtility.UrlDecode(Convert.ToString(backupPlanDeleteParameter.BackPlanID));

                // Execute the stored procedure and get the result
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                
                // Check if we got a result with the status message
                if (dt.Rows.Count > 0 && dt.Columns.Contains("Result"))
                {
                    string result = Convert.ToString(dt.Rows[0]["Result"]);
                    
                    // Check if the result contains an error
                    if (result.Contains("Error") || result.Contains("does not exist") || result.Contains("must be provided"))
                    {
                        return Request.CreateErrorResponse(HttpStatusCode.BadRequest, result);
                    }
                    
                    // Return success message
                    return new { Success = true, Message = result };
                }
                
                // Fallback if no result returned
                return new { Success = true, Message = "Backup plan deleted successfully" };
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Error deleting backup plan: " + ex.Message);
            }
        }









        /// <summary>
        /// Get filter dropdown options for backup plan history (Modified Field and Modified By)
        /// </summary>
        /// <param name="filterParameter">Backup Plan ID</param>
        /// <returns>List of unique field names and modified by values for dropdowns</returns>
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetBackupPlanFilterDropdowns([FromBody] BackupPlanHistoryFilterParameter filterParameter)
        {
            try
            {
                // Validate required parameters
                if (filterParameter.BackPlanID <= 0)
                {
                    return Request.CreateErrorResponse(HttpStatusCode.BadRequest, "Valid Backup Plan ID is required");
                }

                // Build the stored procedure call for backup plan history filter dropdowns
                string strSQL = "Exec usp_Whizible2_Sel_PM_tbl_PRS_BackupPlan_AuditTrail_FilterDropdown " +
                    HttpUtility.UrlDecode(Convert.ToString(filterParameter.BackPlanID));

                DataTable historyFilter;
                historyFilter = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return historyFilter;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Error retrieving backup plan filter dropdowns: " + ex.Message);
            }
        }

        /// <summary>
        /// Get detailed audit trail history for a specific backup plan
        /// </summary>
        /// <param name="historyParameter">Backup Plan ID and optional filters</param>
        /// <returns>Detailed audit trail history for the backup plan</returns>
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetBackupPlanAuditTrailHistory([FromBody] BackupPlanHistoryParameter historyParameter)
        {
            try
            {
                // Validate required parameters
                if (historyParameter.BackPlanID <= 0)
                {
                    return Request.CreateErrorResponse(HttpStatusCode.BadRequest, "Valid Backup Plan ID is required");
                }

                // Build the stored procedure call for detailed audit trail history with optional filtering
                string strSQL = "Exec usp_Whizible2_Sel_PM_tbl_PRS_BackupPlan_AuditTrail " +
                    HttpUtility.UrlDecode(Convert.ToString(historyParameter.BackPlanID)) + "," +
                    (string.IsNullOrEmpty(historyParameter.ModifiedField) ? "NULL" : "'" + HttpUtility.UrlDecode(historyParameter.ModifiedField).Replace("'", "''") + "'") + "," +
                    (string.IsNullOrEmpty(historyParameter.ModifiedBy) ? "NULL" : "'" + HttpUtility.UrlDecode(historyParameter.ModifiedBy).Replace("'", "''") + "'");

                DataTable auditTrailHistory;
                auditTrailHistory = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                // Check if the result contains error information
                if (auditTrailHistory.Rows.Count > 0 && auditTrailHistory.Columns.Contains("ErrorNumber"))
                {
                    var errorRow = auditTrailHistory.Rows[0];
                    return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, 
                        "Database Error: " + errorRow["ErrorMessage"].ToString());
                }

                return auditTrailHistory;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Error retrieving backup plan audit trail history: " + ex.Message);
            }
        }




    }
}
