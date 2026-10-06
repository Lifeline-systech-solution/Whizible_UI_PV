'PAGE ADDED BY Amit Mahadik FOR WHIZIBLESEM V10.0 
Imports CommonFunctions.General
Imports CommonFunctions.Data
Partial Public Class AjaxCall
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'ADDEED BY AMIT MAHADIK ON 04th OCTOBER 2011 WHIZIBLESEM 10.0
        If CheckIsNothing(Request.QueryString("Flag"), "").ToUpper() = "GETSUBTYPEFROMTYPE" Then
            Dim Type As String = CheckIsNothing(Request.QueryString("Type"), "")
            Dim ProjectID As String = CheckIsNothing(Request.QueryString("ProjectID"), "")
            Dim idrSubTypes As IDataReader

            Dim strQuery As String
            strQuery = "Exec  usp_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " + ProjectID + "," + "'S'," + "'" + Type + "'"
            idrSubTypes = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            Response.Clear()
            While idrSubTypes.Read()
                Response.Write(idrSubTypes("FieldName") & ",")
            End While
            'Exec usp_Sel_tbl_IB_Project_Sub_Type_ProjectGroup 90, 'S', 'Testing-Amit-'
            Response.End()
        End If

        If CheckIsNothing(Request.QueryString("Flag"), "").ToUpper() = "GETSTATUS" Then
            Dim Type As String = CheckIsNothing(Request.QueryString("Type"), "")
            Dim ProjectID As String = CheckIsNothing(Request.QueryString("ProjectID"), "")
            Dim RoleId As String = CheckIsNothing(Request.QueryString("RoleId"), "")
            Dim idrSubTypes As IDataReader

            Dim strQuery As String
            strQuery = "Exec  usp_Sel_tbl_IB_Project_Type_Status_OpenStatus " + ProjectID + ",'" + Type + "'," + RoleId
            idrSubTypes = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            Response.Clear()
            While idrSubTypes.Read()
                Response.Write(idrSubTypes("FieldName") & ",")
            End While
            '"Exec usp_Sel_tbl_IB_Project_Type_Status_OpenStatus 90, 'ptpt',7"
            Response.End()
        End If


        'END ADDEED BY AMIT MAHADIK ON 04th OCTOBER 2011 WHIZIBLESEM 10.0
    End Sub

End Class