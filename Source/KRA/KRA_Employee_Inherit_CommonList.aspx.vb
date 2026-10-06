Imports CommonEngines.General.cEventHandlers
Public Class KRA_Employee_Inherit_CommonList
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
        MyBase.strListPage = "KRA_Employee_Inherit_CommonList.aspx"
        MyBase.strFormPage = "KRA_Employee_Inherit_CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)


    End Sub
#End Region


    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    End Function

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = ReturnCodes.DO_NOTHING.ToString
    End Function





    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New kra_Employee_Inherit_CommonListCLSQL(MyBase.m_objGlobal)
    End Function
End Class
#Region "Grid_Class"
Public Class kra_Employee_Inherit_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String

        'Dim strSql As String = "SELECT EmployeeId FROM tbl_pm_employee WHERE UserName='" & CommonFunctions.General.BuildQueryString(objGlobal.UserName) & "'"
        'Dim intReportingTo As Integer
        'intReportingTo = CType(CommonFunction.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSql, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))), Integer)

        GetPageSpecificFilters += " AND (ReportingTo=" + HttpContext.Current.Session("intUserID").ToString & ")"
    End Function
End Class


#End Region