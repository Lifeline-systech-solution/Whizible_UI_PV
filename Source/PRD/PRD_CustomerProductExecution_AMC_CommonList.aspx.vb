Imports CommonEngines.General.cEventHandlers
Public Class cPRD_CustomerProductExecution_AMC_CommonList
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
        MyBase.strListPage = "PRD_CustomerProductExecution_AMC_CommonList.aspx"
        MyBase.strFormPage = "PRD_CustomerProductExecution_AMC_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

#End Region

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        If MyBase.m_objGlobal.TagID = 1500 Then
            Return New cPRD_CustomerProductExecution_AMC_CommonListCLSQL(MyBase.m_objGlobal)
        Else
            Return New cPRD_CustomerProductExecution_AMC_CommonListCLSQL_Temp(MyBase.m_objGlobal)
        End If

    End Function

End Class

Public Class cPRD_CustomerProductExecution_AMC_CommonListSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cPRD_CustomerProductExecution_AMC_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    'Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
    '    If CStr(HttpContext.Current.Session("LoginType")) = "C" Then
    '        GetPageSpecificFilters = GetPageSpecificFilters + " And Customer = " & CStr(HttpContext.Current.Session("intUserID"))
    '    End If

    'End Function

End Class
Public Class cPRD_CustomerProductExecution_AMC_CommonListCLSQL_Temp
    Inherits CommonEngine.CommonList.cCLSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        If CStr(HttpContext.Current.Session("LoginType")) = "C" Then
            GetPageSpecificFilters = GetPageSpecificFilters + " And Customer = " & CStr(HttpContext.Current.Session("intUserID"))
        End If

    End Function

End Class
Public Class cPRD_CustomerProductExecution_AMC_CommonListCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


End Class
