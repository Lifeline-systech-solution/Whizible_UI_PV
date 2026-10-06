Imports CommonEngines.General.cEventHandlers
Public Class cPaymentMode_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cPaymentMode_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cPaymentMode_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


End Class
Public Class cPaymentMode_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_PlotControlCaption(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeCaption As String = "")
        If WhizGlobal.ParentTagID = 0 Then
            If Args.ControlName.ToUpper = "PAIDBYSELF" Then
                Dim strSQL As String
                Dim ExpenseWorkFlow As String
                ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                ''strSQL = "SELECT ExpenseWorkFlow FROM tbl_PM_CompanyInformation "
                strSQL = "usp_sel_ExpenseWorkFlow_tbl_PM_CompanyInformation "
                ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                ExpenseWorkFlow = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0")

                If ExpenseWorkFlow.ToUpper = "FALSE" Then
                    Cancel = True
                End If

            End If
        End If
    End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        If WhizGlobal.ParentTagID = 0 Then
            If Args.ControlName.ToUpper = "PAIDBYSELF" Then
                Dim strSQL As String
                Dim ExpenseWorkFlow As String

                ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                ''strSQL = "SELECT ExpenseWorkFlow FROM tbl_PM_CompanyInformation "
                strSQL = "usp_sel_ExpenseWorkFlow_tbl_PM_CompanyInformation "
                ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                ExpenseWorkFlow = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0")

                If ExpenseWorkFlow.ToUpper = "FALSE" Then
                    Cancel = True
                End If

            End If
        End If
        ' End Addition By NitinVS on 24 May 2005 for Expense Workflow Implementation 

    End Sub
End Class


Public Class PaymentMode_CommonPage
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
        MyBase.strListPage = "PaymentMode_CommonList.aspx"
        MyBase.strFormPage = "PaymentMode_CommonPage.aspx"


        MyBase.Page_Load(sender, e)



    End Sub

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cPaymentMode_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cPaymentMode_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cPaymentMode_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cPaymentMode_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function

    Protected Overloads Function InitSubTagCLSQL() As CommonEngine.CommonList.cSubTagCLSQL
        Return New cPaymentMode_CommonPageSubTagCLSQL(MyBase.m_objGlobal)
    End Function
End Class
