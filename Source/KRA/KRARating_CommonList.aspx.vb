Imports CommonEngines.General.cEventHandlers
Public Class KRARating_CommonList
    Inherits CommonList



#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "KRARating_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)


    End Sub
#End Region

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cKRARating_CommonPageCPSQL1(MyBase.m_objGlobal)
    End Function
    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    '    Dim sbSQL As New System.Text.StringBuilder
    '    Dim intCount As Integer
    '    Dim arr() As String = DeletedIDList.Split(Convert.ToChar(","))
    '    Dim intUBound As Integer = UBound(arr)
    '    For intCount = 0 To intUBound
    '        sbSQL.Append("EXEC [dbo].[usp_del_tbl_KRA_EmployeeKRACalculation3Cycles] " + arr(intCount))
    '        sbSQL.Append(vbCrLf)
    '        CommonFunctions.Data.InsertOrUpdateData(sbSQL.ToString(), True)
    '    Next
    '    sbSQL = Nothing
    'End Function
    Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    End Function

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = ReturnCodes.DO_NOTHING.ToString
    End Function

End Class
Public Class cKRARating_CommonPageCPSQL1
    Inherits CommonEngine.CommonList.cCLSQL

    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String 'CLSQL, CPSQL, SubTagCPSQL
        '===================
        'Display records for specific reporting head.
        '
        'Dim strSql As String
        'strSql = "SELECT EmployeeId FROM tbl_pm_employee WHERE UserName='" & CommonFunctions.General.BuildQueryString(objGlobal.UserName) & "'"
        'Dim Reportingto As String
        'Reportingto = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSql, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)))
        GetPageSpecificFilters += " AND (ReportingTo=" + HttpContext.Current.Session("intUserID").ToString & " )"
    End Function
End Class
