Imports CommonEngines.General.cEventHandlers
Public Class View_TestDetails_CommonList
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
        MyBase.strListPage = "View_TestDetails_CommonList.aspx"
        MyBase.strFormPage = "View_TestDetails_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New CView_TestDetails_CommonList_PlotGrid(MyBase.m_objGlobal)
    End Function


    Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter)
        Dim strbuildtable As String
        Dim strSQL As String
        Dim objdr As IDataReader
        Dim intTestSetID As Integer
        Dim strTestSetName As String
        Dim strTestGroup As String
        Dim strTestType As String

        intTestSetID = CInt(HttpContext.Current.Request.QueryString("TestSetID"))
        ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
        ''strSQL = "Select distinct TestSetName,TestType,TestGroup From V_tbl_TCM_DisplayTestCaseDetails Where TestSetID=" + CStr(intTestSetID)
        strSQL = "usp_sel_V_tbl_TCM_DisplayTestCaseDetails_TestSetName " + CStr(intTestSetID)
        objdr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objdr.Read Then
            strTestSetName = CommonFunctions.General.CheckIsNothing(objdr.Item("TestSetName"))
            strTestType = CommonFunctions.General.CheckIsNothing(objdr.Item("TestType"))
            strTestGroup = CommonFunctions.General.CheckIsNothing(objdr.Item("TestGroup"))
        End If
        CommonFunction.Data.DisposeDataReader(objdr)
        strbuildtable = "<table class=clsTable style=' font-size: 11px;'>"
        strbuildtable += "<tr><td><b>Test Set Name:  </b></td>"
        strbuildtable += "<td>" + strTestSetName + "</td></tr><br>"
        strbuildtable += "<tr><td><b>Test Group   : </b></td>"
        strbuildtable += "<td>" + strTestGroup + "</td></tr><br>"
        strbuildtable += "<tr><td><b>Test Type    : </b></td>"
        strbuildtable += "<td>" + strTestType + "</td></tr><br>"
        strbuildtable += "</table><br>"

        Args.HeaderFooter = strbuildtable
    End Sub

   
 
    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        If Args.HTMLLegend.ToUpper = "RED COLOR INDICATES APPLIED FILTER" Then
            Cancel = True
        End If
    End Sub

   

    Protected Overrides Function InitDynamicFilters() As CommonEngine.CommonList.cDynamicFilters
        Return New CView_TestDetails_CommonList_DynamicFilters(MyBase.m_objGlobal)
    End Function
End Class
Public Class CView_TestDetails_CommonList_PlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

End Class
Public Class CView_TestDetails_CommonList_DynamicFilters
    Inherits CommonEngine.CommonList.cDynamicFilters
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


    Protected Overrides Sub Before_Filter_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim intTestSetID As Integer
        intTestSetID = CInt(HttpContext.Current.Request.QueryString("TestSetID"))

        Args.SQL = "exec usp_sel_tbl_tcm_TestSection " + CStr(intTestSetID)

    End Sub
End Class

