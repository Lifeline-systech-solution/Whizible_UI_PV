Imports CommonEngines.General.cEventHandlers
Public Class cTaskMapping_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cTaskMapping_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

End Class
Public Class cTaskMapping_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


    Protected Overrides Function GetUIPageWhereClause(ByVal objGlobal As WebPages.Template.IGlobal, ByVal TableName As String, ByVal PrimaryKey As String, Optional ByRef PrimaryKeyValue As String = "") As String
        'If (HttpContext.Current.Request("FromCL") = "1" And objGlobal.ParentTagID = 0) Or (HttpContext.Current.Request("SubTagFromCL") = "1" And objGlobal.ParentTagID <> 0) Then
        '    'Common Page is accessed from CommonList
        '    GetUIPageWhereClause = " WHERE " + PrimaryKey + "='" + CommonFunction.General.BuildQueryString(PrimaryKeyValue) + "'"

        '    GetUIPageWhereClause += " AND TaskID Not in (Select TaskID from tbl_RM_TaskMapping)"


        '    GetUIPageWhereClause += " AND ProjectRequirementID = " + HttpContext.Current.Session("intProjectRequirementID").ToString

        'End If
    End Function
End Class
Public Class cTaskMapping_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub
End Class


Public Class TaskMapping_CommonPage
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

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "TaskMapping_CommonList.aspx"
        MyBase.strFormPage = "TaskMapping_CommonPage.aspx"

        MyBase.Page_Load(sender, e)

    End Sub
    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cTaskMapping_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    'Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
    '    Return New c < PAGE_NAME > PlotControls(MyBase.m_objGlobal)
    'End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cTaskMapping_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cTaskMapping_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function

    'Protected Overrides Function InitSubTagCLSQL(ByVal WhizGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
    '    Return New c < PAGE_NAME > SubTagCLSQL(WhizGlobal)
    'End Function
End Class
