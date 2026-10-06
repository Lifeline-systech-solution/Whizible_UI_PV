Public Class LoginConfigurationPage
    Inherits WebPages.Template.WhizTemplate
    ''
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
    End Sub
    <System.Web.Services.WebMethod>
    Public Shared Function SaveLoginConfiguration(ByVal ConfiText As String) As String
        Dim strSQL As String

        strSQL = "usp_ins_tbl_CNF_LoginConfiguration '" & ConfiText.Replace("'", "''") & "'"
        Dim strSave As String = CommonFunctions.Data.InsertOrUpdateData(strSQL, True)

        Return "1"
    End Function
    <System.Web.Services.WebMethod>
    Public Shared Function GetLoginConfiguration() As String
        Dim strSQL As String

        strSQL = "usp_Sel_tbl_CNF_LoginConfiguration "
        Dim ConfigText As String = CommonFunctions.Data.GetDataScalar(strSQL, True)

        Return ConfigText
    End Function
End Class