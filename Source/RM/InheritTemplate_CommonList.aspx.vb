Imports CommonEngines.General.cEventHandlers

Public Class InheritTemplate_CommonList
    Inherits CommonList
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

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.strListPage = "InheritTemplate_CommonList.aspx"
        MyBase.strFormPage = "InheritTemplate_CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
        'Put user code to initialize the page here
    End Sub

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New InheritTemplate_cCLSQL(MyBase.m_objGlobal)
    End Function



    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New InheritTemplate_cPlotGrid(m_objGlobal)
    End Function

    'Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)


    'End Sub
End Class
Public Class InheritTemplate_cCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Sub New(ByVal m_objGlobal As WebPages.Template.IGlobal)
        MyBase.New(m_objGlobal)
    End Sub

    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        'Modified by AbhijitD on 26-Jul-07 for the following issue
        'No template can be inherited to project if any template is explicitly defined at project level
        'GetPageSpecificFilters = " AND RMTemplateID NOT IN (SELECT CorporateRMTemplateID FROM tbl_RM_ProjectRequirementTemplate WHERE ProjectID =  " + HttpContext.Current.Request.QueryString("ProjectID") + ")"
        GetPageSpecificFilters = " AND RMTemplateID NOT IN (SELECT IsNull(CorporateRMTemplateID,0) FROM tbl_RM_ProjectRequirementTemplate WHERE ProjectID =  " + HttpContext.Current.Request.QueryString("ProjectID") + ")"
        'End of modification by AbhijitD on 26-Jul-07
    End Function
End Class
Public Class InheritTemplate_cPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Sub New(ByVal m_objGlobal As WebPages.Template.IGlobal)
        MyBase.New(m_objGlobal)
    End Sub


    Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If HttpContext.Current.Request.QueryString("DYNAMIC_ACTION") <> "" Then
            HttpContext.Current.Response.Write("<SCRIPT>window.opener.location.href=window.opener.location.href;</SCRIPT>")

        End If
    End Sub

    'Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub
End Class

