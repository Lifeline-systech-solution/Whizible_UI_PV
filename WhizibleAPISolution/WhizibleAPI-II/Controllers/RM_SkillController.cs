using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Extensions;
using WhizibleAPI.Models.Skill;

namespace WhizibleAPI.Controllers
{
    [Authorize]
    public class RM_SkillController : ApiController
    {

        //Added by imran on 19-08-2022 
        [Authorize, App_Start.ValidateHeaders]  
        ////End of comment by imran on 19-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage CreateSkills([FromBody]RM_Skill objSkills)
        {
         
            try
            {
                string strtResult;
                string strSQL;
                if (objSkills != null)
                {
                    if(objSkills.ToolID>0)
                    {
                        strSQL = "Exec usp_Whizible2_Upd_tbl_PM_Tools " + objSkills.ToolID + " ,'" + objSkills.Description + "'," + objSkills.RequiredForMatricCalc + "," + objSkills.ConfiguredDays + "," + objSkills.Tools_CategoryID + ",'"+ objSkills.ModifiedBy + "'";
                       
                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_Ins_tbl_PM_Tools  " + objSkills.ToolID + " ,'" + objSkills.Description + "'," + objSkills.RequiredForMatricCalc + "," + objSkills.ConfiguredDays + "," + objSkills.Tools_CategoryID + ",'" + objSkills.CreatedBy + "'";
                    }
                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }
                }

                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, strtResult);
            }
            catch (Exception ex)
            {
               return Request.CreateErrorResponse(HttpStatusCode.InternalServerError,"Bad Request found");
            }
          
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetSkills([FromBody] SklFilterParameter SklFilterParameter)
        {
            try
            {
                List<RM_Skill> skillsList = new List<RM_Skill>();
                string filterParms = "";
                if (SklFilterParameter != null && SklFilterParameter.SklWhereClause != null && !string.IsNullOrEmpty(SklFilterParameter.SklWhereClause))
                {
                    //filterParms = SklFilterParameter.SklWhereClause;
                    filterParms = HttpUtility.UrlDecode(SklFilterParameter.SklWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");
                }
                else
                {
                    filterParms = null;
                }
                    string strSQL = "";
                    if (filterParms != null)
                    {
                        strSQL = "Exec usp_Whizible2_sel_tbl_PM_ToolSkill '" + filterParms + "'";
                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_sel_tbl_PM_ToolSkill";
                    }
                    DataTable skillsListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (skillsListTable != null)
                    {
                        foreach (DataRow taskListRow in skillsListTable.Rows)
                        {
                            RM_Skill skills = new RM_Skill()
                            {
                                ToolID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["ToolID"], "")),
                                Description = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Description"], "")),
                                ConfiguredDays = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["ConfiguredDays"], "0")),
                                CategoryName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["CategoryName"], "")),
                                Tools_CategoryID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["Tools_CategoryID"], "0")),
                                RequiredForMatricCalc = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(taskListRow["RequiredForMatricCalc"], "0")),
                            };
                            skillsList.Add(skills);
                        }
                    }
                    return Request.CreateResponse(HttpStatusCode.OK, skillsList);
                }
            catch (Exception ex)
            {
               return Request.CreateErrorResponse(HttpStatusCode.InternalServerError,"Bad Request found");
            }
        }

        [HttpPost]
        public HttpResponseMessage GetToolsCategories()
        {
            try
            {
                List<RM_ToolsCategory> toolsCategoryList = new List<RM_ToolsCategory>();

                string strSQL = "Exec usp_Whizible2_sel_tbl_PM_Tools_Category_CategoryName";
                DataTable toolsCategoryListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow taskListRow in toolsCategoryListTable.Rows)
                {
                    RM_ToolsCategory toolsCategory = new RM_ToolsCategory()
                    {
                        Tools_CategoryID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["Tools_CategoryID"], "0")),
                        CategoryName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["CategoryName"], "")),

                    };
                    toolsCategoryList.Add(toolsCategory);
                }
                return Request.CreateResponse(HttpStatusCode.OK, toolsCategoryList);

            }
            catch (Exception ex)
            {
               return Request.CreateErrorResponse(HttpStatusCode.InternalServerError,"Bad Request found");
            }
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteSkills([FromBody]string skillIds)
        {
            try
            {
                string strSQL = "";
                string strResult = "";
                int delete=0;
                int notDelete=0;
                string[] arrSkillList = skillIds.Split(',');
                if (skillIds != null)
                {
                    foreach (var item in arrSkillList)
                    {
                        strSQL = "Exec usp_Whizible2_Del_tbl_PM_Tools_Skill " + item;
                        strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        if(strResult== "deleted")
                        {
                            delete++;
                        }
                        else
                        {
                               notDelete++;
                        }
                        //Skill deleted successfully.

                    }
                    return Request.CreateResponse(HttpStatusCode.OK,new { deletedCount = delete, notDeletedCount = notDelete});
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
            }
            catch (Exception ex)
            {
               return Request.CreateErrorResponse(HttpStatusCode.InternalServerError,"Bad Request found");
            }
            
        }

    }
}