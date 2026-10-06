Imports CommonEngines.General.cEventHandlers
Public Class SkillCategory_CommonPage
    Inherits CommonPage

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region



    Protected Overrides Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "CommonList.aspx"
        MyBase.strFormPage = "SkillCategory_CommonPage.aspx"
        Dim strSQL As String
        Dim strCategoryID As String
        Dim strSelectedList As String
        If Request.QueryString("SaveSkills") = "1" Then
            strCategoryID = Request.QueryString("Tools_CategoryID_PK")
            strSelectedList = Request.Form("chkDelete3227")

            CommonFunction.Data.InsertOrUpdateData("UPDATE tbl_PM_Tools SET Tools_CategoryID=NULL WHERE Tools_CategoryID=" + strCategoryID, MyBase.UseSQL)
            If strSelectedList <> "" Then
                CommonFunction.Data.InsertOrUpdateData("UPDATE tbl_PM_Tools SET Tools_CategoryID=" + strCategoryID + " WHERE ToolID in (" + strSelectedList + ")", MyBase.UseSQL)
            End If

        End If

        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    End Function
End Class
