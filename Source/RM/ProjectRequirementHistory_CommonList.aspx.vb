Imports CommonEngines.General.cEventHandlers
Public Class ProjectRequirementHistory_CommonList
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
#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.strListPage = "ProjectRequirementHistory_CommonList.aspx"
        MyBase.strFormPage = "ProjectRequirementHistory_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Function InitDynamicFilters() As CommonEngine.CommonList.cDynamicFilters
        Return New ProjectRequirementHistory_CommonList_DynamicFilters(MyBase.m_objGlobal)
    End Function

    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        If Args.HTMLLegend.ToUpper = "RED COLOR INDICATES APPLIED FILTER" Then
            Cancel = True
        End If
    End Sub
End Class
Public Class ProjectRequirementHistory_CommonList_DynamicFilters
    Inherits CommonEngine.CommonList.cDynamicFilters
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Sub Before_Filter_Print(ByRef Cancel As Boolean, ByRef Args As Whiz.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, ByVal WhizGlobal As WebPages.Template.IGlobal)

        Dim strProjectRequirementID As String

        strProjectRequirementID = CType(HttpContext.Current.Request.QueryString("ProjectRequirementID"), String)
        If Args.FilterName.ToUpper = "FIELDNAME" Then
            Args.SQL = " usp_Sel_tbl_RM_ProjectReqHistory_ModifiedField " & strProjectRequirementID
        ElseIf Args.FilterName.ToUpper = "MODIFIEDBY" Then
            Args.SQL = " usp_Sel_tbl_RM_ProjectReqHistory_ModifiedBy " & strProjectRequirementID
        End If

    End Sub
End Class