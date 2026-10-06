Imports CommonEngines.General.cEventHandlers
Public Class InheritedWorkFlowCommonList
    Inherits CommonList

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

#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        If UCase(MyBase.strListPage) = "COMMONLIST.ASPX" Then
            MyBase.strListPage = "InheritedWorkFlowCommonList.aspx"
        End If
        If UCase(MyBase.strFormPage) = "COMMONPAGE.ASPX" Then
            MyBase.strFormPage = "InheritedWorkFlowCommonPage.aspx"
        End If
        MyBase.Page_Load(sender, e)
    End Sub
End Class
