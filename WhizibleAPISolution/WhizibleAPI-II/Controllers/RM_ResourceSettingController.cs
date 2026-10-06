using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models.RM;

namespace WhizibleAPI.Controllers
{
    public class ResourceSettingController : ApiController
    {
        ResourceSetting resourceSetting = new ResourceSetting();
        [HttpPost]
        [Authorize]
        public HttpResponseMessage GetResourceMasterNodeAccesDetails([FromBody] ResourceSetting resourceSettingPar)
        {
            try
            {
                string strSQL;
                HttpRequestMessage request = new HttpRequestMessage();
                try
                {
                    strSQL = "";
                    strSQL = "usp_Whizible2_Sel_tbl_Whizible2_PM_ResourceConfiguration";
                    resourceSetting.GetDetailsWithAccess = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                    resourceSetting.GetDetailsWithAccess.Columns.Add("A", typeof(System.Object));
                    resourceSetting.GetDetailsWithAccess.Columns.Add("D", typeof(System.Object));
                    resourceSetting.GetDetailsWithAccess.Columns.Add("E", typeof(System.Object));
                    resourceSetting.GetDetailsWithAccess.Columns.Add("V", typeof(System.Object));
                    ////resourceSetting.GetDetailsWithAccess.Columns.Add("Red", typeof(System.Object));
                    //resourceSetting.GetDetailsWithAccess.Columns.Add("Yellow", typeof(System.Object));
                    //resourceSetting.GetDetailsWithAccess.Columns.Add("Green", typeof(System.Object));
                    resourceSetting.GetDetailsWithAccess.Columns.Add("Access", typeof(System.Object));
                    resourceSetting.GetDetailsWithAccess.AcceptChanges();

                    for (int i = 0; i < resourceSetting.GetDetailsWithAccess.Rows.Count; i++)
                    {
                        for (int j = 0; j < resourceSetting.GetDetailsWithAccess.Columns.Count; j++)
                        {
                            if (j == 6)
                            {
                                object TagId = resourceSetting.GetDetailsWithAccess.Rows[i][j];
                                strSQL = "";
                                strSQL = "usp_Whizible2_Sel_tbl_UI_NodeAccess " + HttpUtility.UrlDecode(TagId.ToString()) + "," + HttpUtility.UrlDecode(resourceSettingPar.RoleID.ToString()) + "," + HttpUtility.UrlDecode(resourceSettingPar.UserID.ToString()) + ",'" + HttpUtility.UrlDecode(resourceSettingPar.LoginType.ToString()) + "',NULL ";
                                IDataReader rdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                                while (rdr.Read())
                                {
                                    object AddAccess = rdr["A"];
                                    object DeleteAccess = rdr["D"];
                                    object EditAccess = rdr["E"];
                                    object ViewAccess = rdr["V"];
                                    object CompleteAccess = rdr["Access"];

                                    resourceSetting.GetDetailsWithAccess.Rows[i][7] = AddAccess;
                                    resourceSetting.GetDetailsWithAccess.Rows[i][8] = DeleteAccess;
                                    resourceSetting.GetDetailsWithAccess.Rows[i][9] = EditAccess;
                                    resourceSetting.GetDetailsWithAccess.Rows[i][10] = ViewAccess;
                                    resourceSetting.GetDetailsWithAccess.Rows[i][14] = CompleteAccess;
                                }
                                //GetColorDetails(TagId, i, createProject);
                            }
                        }
                    }
                    var configuration = new HttpConfiguration();
                    request.SetConfiguration(configuration);
                    return request.CreateResponse(HttpStatusCode.OK, resourceSetting);
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
            //public void GetColorDetails(object TagId, int i, ResourceSetting resourceSetting)
            //{

            //    int UserID = resourceSetting.UserID;
            //    strSQL = "";
            //    if (TagId.ToString() == "<PageTagID>")
            //    {
            //        strSQL = "";
            //    }

            //    if (strSQL.Length > 0)
            //    {
            //        FillDataIntable(strSQL, i);
            //    }
            //}
            //public void FillDataIntable(string strSQL, int i)
            //{
            //    IDataReader rdr1 = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            //    while (rdr1.Read())
            //    {
            //        object Red = rdr1["Red"];
            //        object Green = rdr1["Green"];
            //        object Yellow = rdr1["Yellow"];
            //        resourceSetting.GetDetailsWithAccess.Rows[i][11] = Red;
            //        resourceSetting.GetDetailsWithAccess.Rows[i][12] = Yellow;
            //        resourceSetting.GetDetailsWithAccess.Rows[i][13] = Green;
            //    }
            //}

        }
}
