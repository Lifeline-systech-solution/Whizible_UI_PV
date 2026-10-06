using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models.RM;
using WhizibleAPI.Models.Skill;

namespace WhizibleAPI.Controllers
{
    public class RM_SkillCategoryController:ApiController
    {
        
        
        ////Added by imran on 19-08-2022 
        [Authorize, App_Start.ValidateHeaders]  
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetSkillCategorys([FromBody] SCFilterParameter filterParameter)
        {
            
            try
            {
                List<RM_SkillCategory> listSkillCat = new List<RM_SkillCategory>();
                string filterParms = "";
                if (filterParameter != null && filterParameter.SCWhereClause != null && !string.IsNullOrEmpty(filterParameter.SCWhereClause))
                {
                    //filterParms = filterParameter.GMWhereClause;// HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");// DecodeWhereClause(BgFilterParameter.BGWhereClause);///HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                    filterParms = HttpUtility.UrlDecode(filterParameter.SCWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");

                }
                else
                {
                    filterParms = null;
                }
                string strSQL = "";
                if (filterParms != null)
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_PM_SkillCategory '" + filterParms + "'";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_PM_SkillCategory";
                }


                DataTable skillCatTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (skillCatTable != null)
                {

                    foreach (DataRow item in skillCatTable.Rows)
                    {
                        RM_SkillCategory objSkillCategory = new RM_SkillCategory()
                        {
                            Tools_CategoryID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["Tools_CategoryID"], "0")),
                            CategoryName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(item["CategoryName"], "")),
                            Description = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(item["Description"], "")),

                        };

                        listSkillCat.Add(objSkillCategory);
                    }


                }
                return Request.CreateResponse(HttpStatusCode.OK, listSkillCat);
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
        public HttpResponseMessage SaveSkillCategory([FromBody] RM_SkillCategory rM_SkillCategory)
        {
           
            try
            {
                string strtResult = string.Empty;
                string strSQL;
                if (rM_SkillCategory != null)
                {
                    if (rM_SkillCategory.Tools_CategoryID > 0)
                    {
                        strSQL = "Exec usp_Whizible2_Upd_tbl_PM_SkillCategory " + rM_SkillCategory.Tools_CategoryID + ",'" + rM_SkillCategory.CategoryName + "','" + rM_SkillCategory.Description + "','" + rM_SkillCategory.CreatedBy + "'";
                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_Ins_tbl_PM_SkillCategory '" + rM_SkillCategory.CategoryName + "','" + rM_SkillCategory.Description + "','" + rM_SkillCategory.CreatedBy + "'";

                        //int Result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);      
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteSkillCategory([FromBody] string Parameters)
        {
            try
            {
                string strResult = "";
                int delete = 0;
                int notDelete = 0;
                if (Parameters != null)
                {
                    var splitParmas = Parameters.Split(',').ToList();
                    foreach (var itemUniqueID in splitParmas)
                    {
                        string strSQL = "Exec usp_Whizible2_Del_tbl_PM_TOOLS_CATEGORY '" + itemUniqueID + "'";
                        strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        if (strResult == "deleted")
                        {
                            delete++;
                        }
                        else
                        {
                            notDelete++;
                        }
                    }
                    return Request.CreateResponse(HttpStatusCode.OK, new { deletedCount = delete, notDeletedCount = notDelete });
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

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetSkillS([FromBody] int Tool_CategoryID)
        {
           
            try
            {
                List<SkillsMapping> listSkill = new List<SkillsMapping>();
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_SkillTools_Category " + Tool_CategoryID + "";
                DataTable skillCatTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (skillCatTable != null)
                {

                    foreach (DataRow item in skillCatTable.Rows)
                    {
                        SkillsMapping objSkill = new SkillsMapping()
                        {
                            ToolID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["ToolID"], "0")),
                            Description = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(item["Description"], "")),
                            SelCheckBox = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(item["SelCheckBox"], ""))

                        };

                        listSkill.Add(objSkill);
                    }


                }
                return Request.CreateResponse(HttpStatusCode.OK, listSkill);
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
        public HttpResponseMessage UpdateSkillWithCategory([FromBody] SkillCategories rM_Skill)
        {
            
            try
            {
                string strtResult = string.Empty;
                string strSQL = "";
                if (rM_Skill != null)
                {
                    //Commented & Added By Dipali V On 14th April 2023 For Skill Category Saving Issue
                    //if (rM_Skill.ToolID == "")
                    //{
                    //    strSQL = "UPDATE tbl_PM_Tools SET ToolID=NULL " + "WHERE Tools_CategoryID=" + rM_Skill.Tools_CategoryID;
                    //}
                    //else
                    //{
                    //    strSQL = "UPDATE tbl_PM_Tools SET Tools_CategoryID=" + rM_Skill.Tools_CategoryID + "WHERE ToolID IN(" + rM_Skill.ToolID + ")";
                    //}


                    strSQL = "UPDATE tbl_PM_Tools SET Tools_CategoryID=NULL " + " WHERE ToolID IN(" + rM_Skill.AllToolID + ")";
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                   
                    if (rM_Skill.ToolID != "")
                    {
                        strSQL = "UPDATE tbl_PM_Tools SET Tools_CategoryID=" + rM_Skill.Tools_CategoryID + " WHERE ToolID IN(" + rM_Skill.ToolID + ")";
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    }

                    //strSQL = "Exec usp_Upd_tbl_PM_ToolsSkillCategory " + rM_Skill.Tools_CategoryID + ",'" + rM_Skill.AllToolID + "','" + rM_Skill.ToolID + "'";  

                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, "Skills mapped Successfully.");
                    }
                    //End of Commented & Added By Dipali V On 14th April 2023 For Skill Category Saving Issue
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

    }
}