Imports Whizible
Imports CommonEngines.General.cEventHandlers
Public Class cExternalSystemMaster_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal whizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(whizGlobal)
    End Sub
End Class
Public Class cExternalSystemMaster_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal whizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(whizGlobal)
    End Sub

   
End Class
Public Class cExternalSystemMaster_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal whizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(whizGlobal)
    End Sub
End Class
Public Class cExternalSystemMaster_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal whizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(whizGlobal)
    End Sub
End Class


Public Class ExternalSystemMaster_CommonPage
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

        ''Commented and Added by Dhanashri S on 19 Feb 2015  Purpose:Page Crash after applying filter to Extended System
        'MyBase.strListPage = "ExternalSystemMaster_CommonList.aspx"
        MyBase.strListPage = "../General/CommonList.aspx"
        ''End of Comment and addition by Dhanashri S on 19 Feb 2015

        MyBase.strFormPage = "ExternalSystemMaster_CommonPage.aspx"
        MyBase.Page_Load(sender, e)

    End Sub


    'Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
    '    'Put user code to initialize the page here
    '    Return New cExternalSystemMaster_CommonPagePlotControls(MyBase.m_objGlobal)
    'End Function

    'Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
    '    Return New cExternalSystemMaster_CommonPagePlotControls(MyBase.m_objGlobal)
    'End Function

    'Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL

    '    Return New cExternalSystemMaster_CommonPageCPSQL(MyBase.m_objGlobal)
    'End Function

    'Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
    '    Return New cExternalSystemMaster_CommonPageDataManagement(MyBase.m_objGlobal)
    'End Function

    'Protected Overrides Function InitSubTagCLSQL(ByVal whizGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
    '    Return New cExternalSystemMaster_CommonPageSubTagCLSQL(whizGlobal)
    'End Function
End Class
