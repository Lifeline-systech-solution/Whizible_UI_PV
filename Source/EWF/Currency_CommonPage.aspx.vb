Imports CommonEngines.General.cEventHandlers

Public Class cCurrency_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cCurrency_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub BeforePrintDetails_SubTag(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_SubTag, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        'Dim strSQL As String
        'Dim ExpenseWorkFlow As String


        'strSQL = "SELECT ExpenseWorkFlow FROM tbl_PM_CompanyInformation "
        'ExpenseWorkFlow = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0")

        'If ExpenseWorkFlow.ToUpper = "FALSE" Then
        '    Cancel = True
        'End If
    End Sub
End Class
Public Class cCurrency_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


End Class
Public Class cCurrency_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_PlotControlCaption(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeCaption As String = "")
        'If WhizGlobal.ParentTagID = 0 Then
        '    If Args.ControlName.ToUpper = "CONVERSIONRATE" Then
        '        Dim strSQL As String
        '        Dim ExpenseWorkFlow As String

        '        strSQL = "SELECT ExpenseWorkFlow FROM tbl_PM_CompanyInformation "
        '        ExpenseWorkFlow = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0")

        '        If ExpenseWorkFlow.ToUpper = "TRUE" Then
        '            Cancel = True
        '        End If

        '    End If
        'End If

    End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        'If WhizGlobal.ParentTagID = 0 Then
        '    If Args.ControlName.ToUpper = "CONVERSIONRATE" Then
        '        Dim strSQL As String
        '        Dim ExpenseWorkFlow As String

        '        strSQL = "SELECT ExpenseWorkFlow FROM tbl_PM_CompanyInformation "
        '        ExpenseWorkFlow = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0")

        '        If ExpenseWorkFlow.ToUpper = "TRUE" Then
        '            Cancel = True
        '        End If

        '    End If
        'End If
    End Sub
End Class


Public Class Currency_CommonPage
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
        MyBase.strListPage = "Currency_CommonList.aspx"
        MyBase.strFormPage = "Currency_CommonPage.aspx"


        MyBase.Page_Load(sender, e)



    End Sub

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cCurrency_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cCurrency_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cCurrency_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cCurrency_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function

    Protected Overloads Function InitSubTagCLSQL() As CommonEngine.CommonList.cSubTagCLSQL
        Return New cCurrency_CommonPageSubTagCLSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTag_PlotGrid(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cPlotGrid
        Return New cCurrencyPlotGrid(m_objSubTagGlobal)
    End Function


    Protected Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        'Dim strSQL As String
        'Dim ExpenseWorkFlow As String

        'If (WhizGlobal.ParentTagID = 0) And Args.SectionID = 2 Then
        '    strSQL = "SELECT ExpenseWorkFlow FROM tbl_PM_CompanyInformation "
        '    ExpenseWorkFlow = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0")

        '    If ExpenseWorkFlow.ToUpper = "FALSE" Then
        '        Cancel = True
        '    End If
        'End If

    End Sub
End Class

Public Class cCurrencyPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Sub New(ByVal objGlobal As WebPages.Template.IGlobal)
        MyBase.New(objGlobal)
    End Sub
End Class

