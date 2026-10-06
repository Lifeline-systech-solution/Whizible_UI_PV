Imports CommonEngines.General.cEventHandlers

Public Class cPRD_CustomerProductExecution_AMC_CommonPage
    Inherits CommonPage
#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        MyBase.ApplySecurity(True)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "PRD_CustomerProductExecution_AMC_CommonList.aspx"
        MyBase.strFormPage = "PRD_CustomerProductExecution_AMC_CommonPage.aspx"
        MyBase.Page_Load(sender, e)

    End Sub
#End Region

    ' Added by SandipL on 12 Jan 2007 for SEMSP9 IssueID 9327
    Protected Overrides Function InitSubTag_PlotGrid(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cPlotGrid
        Return New cPRD_CustomerProductExecution_AMC_CommonPagePlotGrid(m_objSubTagGlobal)
    End Function

    'Protected Overrides Function InitSubTagCLSQL(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
    '    Return New cPRD_CustomerProductExecution_AMC_CommonPageSubTagCLSQL(m_objSubTagGlobal)
    'End Function

End Class
Public Class cPRD_CustomerProductExecution_AMC_CommonPagePlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Private blneditaccess As Boolean = False
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
        If WhizGlobal.TagID = 3209 Then
            Dim objAccess As New WebPage.Templates.AccessRights
            objAccess.GetAccess(WhizGlobal)
            blneditaccess = objAccess.Edit
            objAccess = Nothing
        End If

    End Sub


    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If WhizGlobal.TagID = 3209 Then
            If blneditaccess = False Then
                Args.EnableLink = False
            End If
        End If
    End Sub
End Class
' End addition by SandipL on 12 Jan 2007

Public Class cPRD_CustomerProductExecution_AMC_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class

Public Class cPRD_CustomerProductExecution_AMC_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub


End Class

Public Class cPRD_CustomerProductExecution_AMC_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class

Public Class cPRD_CustomerProductExecution_AMC_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

End Class


