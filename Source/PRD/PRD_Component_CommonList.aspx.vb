Imports CommonEngines.General.cEventHandlers
Public Class cPRD_Component_CommonList
    Inherits CommonList

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.strListPage = "PRD_Component_CommonList.aspx"
        MyBase.strFormPage = "PRD_Component_CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub
#End Region
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cPRD_Component_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cPRD_Component_CommonListCLSQL(MyBase.m_objGlobal)
    End Function
End Class



Public Class cPRD_Component_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class


Class cPRD_Component_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class


