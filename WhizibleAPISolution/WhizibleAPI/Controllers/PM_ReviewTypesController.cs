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
    public class PM_ReviewTypesController : ApiController
    {

        #region [Get list of all mapped to corporate review type]
        /// <summary>
        /// By Vishal Mahajan
        /// </summary>
        /// <param name="objCorporateReviewTypeParameter"></param>
        /// <returns></returns>
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        ////End of comment by imran on 06-09-2022
        [HttpPost]
        //public List<MappedCorporateReviewTypes> GetMappedCorporateReviewTypes([FromBody] MappedCorporateReviewTypeParameter objCorporateReviewTypeParameter)
        public object GetMappedCorporateReviewTypes([FromBody] MappedCorporateReviewTypeParameter objCorporateReviewTypeParameter)

        {
            try
            {
                DataTable corporateReviewTypes_Table;
                List<MappedCorporateReviewTypes> listCorporateReviewTypes = new List<MappedCorporateReviewTypes>();
                corporateReviewTypes_Table = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_CorporateReviewTypes_ForMapping " + objCorporateReviewTypeParameter.ProjectID, true, CommonController.connectionString);
                foreach (DataRow dr in corporateReviewTypes_Table.Rows)
                {
                    MappedCorporateReviewTypes ObjCorporateReviewType = new MappedCorporateReviewTypes()
                    {
                        CReviewTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["CReviewTypeID"], "0")),
                        CReviewType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["CReviewType"], "")),
                    };
                    listCorporateReviewTypes.Add(ObjCorporateReviewType);
                }
                return listCorporateReviewTypes;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion


        #region [Get list of all mapped to corporate review cause]
        /// <summary>
        /// By Vishal Mahajan
        /// </summary>
        /// <param name="objCorporateReviewCauseParameter"></param>
        /// <returns></returns>
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [HttpPost]
        //public List<MappedCorporateReviewCause> GetMappedCorporateReviewCauses([FromBody]MappedCorporateReviewCauseParameter objCorporateReviewCauseParameter)
        public object GetMappedCorporateReviewCauses([FromBody] MappedCorporateReviewCauseParameter objCorporateReviewCauseParameter)

        {
            try
            {
                DataTable corporateReviewCauses_Table;
                List<MappedCorporateReviewCause> listCorporateReviewTypes = new List<MappedCorporateReviewCause>();
                corporateReviewCauses_Table = CommonFunctions.Data.GetDataTable("usp_Sel_tbl_PM_CorporateReviewCauses_PopulateCombo " + objCorporateReviewCauseParameter.PReviewTypeID, true, CommonController.connectionString);
                foreach (DataRow dr in corporateReviewCauses_Table.Rows)
                {
                    MappedCorporateReviewCause ObjCorporateReviewCause = new MappedCorporateReviewCause()
                    {
                        CReviewCauseID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["CReviewCauseID"], "0")),
                        CReviewCause = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["CReviewCause"], "")),
                    };
                    listCorporateReviewTypes.Add(ObjCorporateReviewCause);
                }
                return listCorporateReviewTypes;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion


        #region [GetReviewTypes]
        /// <summary>
        /// By Vishal Mahajan
        /// </summary>
        /// <param name="objPM_ReviewTypeParameter"></param>
        /// <returns></returns>
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [HttpPost]
        //public List<PM_ReviewType> GetReviewTypes([FromBody] PM_ReviewTypeParameter objPM_ReviewTypeParameter)
        public object GetReviewTypes([FromBody] PM_ReviewTypeParameter objPM_ReviewTypeParameter)

        {
            try
            {
                DataTable routeType_Table;
                ReviewTypeCausesParameter objReviewTypeCausesParameter = new ReviewTypeCausesParameter();
                List<PM_ReviewType> listReviewTypes = new List<PM_ReviewType>();
                routeType_Table = CommonFunctions.Data.GetDataTable("usp_Whizible2_PM_ReviewType_Sel_tbl_PM_ProjectReviewTypes " + objPM_ReviewTypeParameter.ProjectID, true, CommonController.connectionString);
                foreach (DataRow dr in routeType_Table.Rows)
                {
                    PM_ReviewType ObjReviewType = new PM_ReviewType()
                    {
                        PReviewTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["PReviewTypeID"], "0")),
                        PReviewType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["PReviewType"], "")),
                        CReviewTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["CReviewTypeID"], "0")),
                        CReviewType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["CReviewType"], "")),
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["ProjectID"], "0")),
                    };
                    objReviewTypeCausesParameter = new ReviewTypeCausesParameter
                    {
                        PReviewTypeID = ObjReviewType.PReviewTypeID
                    };
                    ObjReviewType.listReviewTypeCauses = GetReviewTypesCauses(objReviewTypeCausesParameter);
                    listReviewTypes.Add(ObjReviewType);
                }
                return listReviewTypes;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion


        #region [GetReviewTypescauses] 
        /// <summary>
        /// By Vishal M 08-11-2019
        /// </summary>
        /// <param name="objReviewTypeCausesParameter"></param>
        /// <returns></returns>
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [HttpPost]
        public List<ReviewTypeCauses> GetReviewTypesCauses(ReviewTypeCausesParameter objReviewTypeCausesParameter)
    
        {
            
            {
                List<ReviewTypeCauses> listReviewTypesCauses = new List<ReviewTypeCauses>();
                listReviewTypesCauses = GetReviewTypesCauses(objReviewTypeCausesParameter.PReviewTypeID);
                return listReviewTypesCauses;
            }

        }
        #endregion

        #region [GetReviewTypescauses by pReviewTypeID]     
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        private List<ReviewTypeCauses> GetReviewTypesCauses(int pReviewTypeID)
        //private object GetReviewTypesCauses(int pReviewTypeID)

        {
            //try
            //{
                DataTable routeTypeCauses_Table;
                List<ReviewTypeCauses> listReviewTypesCauses = new List<ReviewTypeCauses>();
                routeTypeCauses_Table = CommonFunctions.Data.GetDataTable("usp_Whizible2_PM_ReviewTypeCause_Sel_tbl_PM_ProjectReviewCauses " + pReviewTypeID, true, CommonController.connectionString);
                foreach (DataRow dr in routeTypeCauses_Table.Rows)
                {
                    ReviewTypeCauses ObjReviewTypeCauses = new ReviewTypeCauses()
                    {
                        PReviewTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["PReviewTypeID"], "0")),
                        PReviewCauseID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["PReviewCauseID"], "0")),
                        PReviewCause = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["PReviewCause"], "")),
                        CReviewCauseID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["CReviewCauseID"], "0")),
                        CReviewCause = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["CReviewCause"], "")),
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["ProjectID"], "0")),
                    };
                    listReviewTypesCauses.Add(ObjReviewTypeCauses);
                }
                return listReviewTypesCauses;
            //}
            //catch (Exception ex)
            //{
            //    return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            //}
        }
        #endregion


        #region [SaveReviewType]
        /// <summary>
        /// save reviewType By Vishal Mahajan 08-11-2019
        /// </summary>
        /// <param name="objReviewType"></param>
        /// <returns></returns>
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveReviewType([FromBody] PM_ReviewType objReviewType)
        {
            try
            {
                int intPReviewTypeID;
                intPReviewTypeID = Convert.ToInt32(Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                               (CommonFunctions.Data.GetDataScalar("usp_Whizible2_PM_ReviewType_ins_tbl_PM_ProjectReviewTypes "
                                                                                    + objReviewType.PReviewTypeID + ",'"
                                                                                    + objReviewType.PReviewType.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "',"
                                                                                    + objReviewType.CReviewTypeID + ",'"
                                                                                    + objReviewType.CReviewType + "',"
                                                                                    + objReviewType.ProjectID + ",'"
                                                                                    + objReviewType.CreatedBy + "','"
                                                                                    + objReviewType.ModifiedBy + "'",
                                                                                    true, CommonController.connectionString
                                                                                    ),
                                                 "0")
                                                 )
                                                 );


                return intPReviewTypeID;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region [Delete ReviewType]
        /// <summary>
        /// By Vishal Mahajan 
        /// </summary>
        /// <param name="objReviewTypeParameter"></param>
        /// <returns></returns>
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteReviewType([FromBody] DeleteReviewTypeParameter objReviewTypeParameter)
        {
            try
            {
                string result = "";
                result = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                               (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Del_tbl_PM_ProjectReviewTypes "
                                                                                    + objReviewTypeParameter.ProjectID + ","
                                                                                    + objReviewTypeParameter.PReviewTypeID,
                                                                                    true, CommonController.connectionString
                                                                                    ),
                                                 ""));
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region [SaveReviewCause]
        /// <summary>
        /// save reviewCause By Vishal Mahajan 08-11-2019
        /// </summary>
        /// <param name="objReviewCause"></param>
        /// <returns></returns>
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveReviewCause([FromBody] ReviewTypeCauses objReviewCause)
        {
            try
            {
                int intPReviewCauseID;
                intPReviewCauseID = Convert.ToInt32(Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                               (CommonFunctions.Data.GetDataScalar("usp_Whizible2_PM_ReviewCause_ins_tbl_PM_ProjectReviewCauses "
                                                                                    + objReviewCause.PReviewCauseID + ",'"
                                                                                    + objReviewCause.PReviewCause.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "',"
                                                                                    + objReviewCause.CReviewCauseID + ",'"
                                                                                    + objReviewCause.CReviewCause.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "',"
                                                                                    + objReviewCause.PReviewTypeID + ","
                                                                                    + objReviewCause.ProjectID + ",'"
                                                                                    + objReviewCause.CreatedBy + "','"
                                                                                    + objReviewCause.ModifiedBy + "'",
                                                                                    true, CommonController.connectionString
                                                                                    ),
                                                 "0")
                                                 )
                                                 );


                return intPReviewCauseID;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region [Delete ReviewCause]
        /// <summary>
        /// By Vishal Mahajan 
        /// </summary>
        /// <param name="objReviewCauseParameter"></param>
        /// <returns></returns>
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteReviewCause([FromBody] DeleteReviewCausesParameter objReviewCauseParameter)
        {
            try
            {
                string result = "";
                result = Convert.ToString(CommonFunctions.Data.CheckIsDBNull
                                              (CommonFunctions.Data.GetDataScalar("usp_Whizible2_Del_tbl_PM_ProjectReviewCauses "
                                                                                   + objReviewCauseParameter.PReviewCauseID,
                                                                                   true, CommonController.connectionString
                                                                                   ),
                                                ""));
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public HttpResponseMessage GetProjectName([FromBody] int ProjectID)
        {
            try
            {
                string strSQL;
                HttpRequestMessage request = new HttpRequestMessage();
                try
                {


                    strSQL = "";
                    strSQL = "usp_Whizible2_Sel_tbl_pm_Project_GetProjectName " + HttpUtility.UrlDecode(ProjectID.ToString());
                    object ProjectName = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);


                    var configuration = new HttpConfiguration();
                    request.SetConfiguration(configuration);
                    return request.CreateResponse(HttpStatusCode.OK, ProjectName);
                }
                catch (Exception e)
                {

                    return request.CreateResponse(HttpStatusCode.BadRequest, e.Message);
                }

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region [check duplicate review cause]
        /// <summary>
        /// By Vishal Mahajan 30-11-2019
        /// </summary>
        /// <param name="objReviewCause"></param>
        /// <returns></returns>
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [HttpPost]
        public object IsDuplicateReviewCauseName([FromBody] ReviewTypeCauses objReviewCause)
        {
            try
            {
                bool boolIsDuplicateReviewCauseName = false;
                boolIsDuplicateReviewCauseName = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull
                                               (CommonFunctions.Data.GetDataScalar("usp_Whizible2_NameDuplicate_tbl_PM_ProjectReviewCauses "
                                                                                    + objReviewCause.ProjectID + ","
                                                                                    + objReviewCause.PReviewTypeID + ","
                                                                                    + objReviewCause.PReviewCauseID + ",'"
                                                                                    + objReviewCause.PReviewCause.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'"
                                                                                    , true, CommonController.connectionString
                                                                                    ),
                                                 "0"));
                return boolIsDuplicateReviewCauseName;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region [check duplicate review type]
        /// <summary>
        /// By Vishal Mahajan 30-11-2019
        /// </summary>
        /// <param name="objReviewType"></param>
        /// <returns></returns>
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [HttpPost]
        public object IsDuplicateReviewTypeName([FromBody] PM_ReviewType objReviewType)
        {
            try
            {
                bool boolIsDuplicateReviewTypeName = false;
                boolIsDuplicateReviewTypeName = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull
                                               (CommonFunctions.Data.GetDataScalar("usp_Whizible2_NameDuplicate_tbl_PM_ProjectReviewTypes "
                                                                                    + objReviewType.ProjectID + ","
                                                                                    + objReviewType.PReviewTypeID + ",'"
                                                                                    + objReviewType.PReviewType.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'"
                                                                                    , true, CommonController.connectionString
                                                                                    ),
                                                 "0"));
                return boolIsDuplicateReviewTypeName;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
            #endregion
        }
}
