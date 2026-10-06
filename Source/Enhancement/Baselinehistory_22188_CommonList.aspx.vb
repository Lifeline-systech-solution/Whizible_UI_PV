Imports CommonEngines.General.cEventHandlers
Imports Whizible
Public Class Baselinehistory_22188_CommonList
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
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "Baselinehistory_22188_CommonList.aspx"
        MyBase.strFormPage = "EffortsSplit_OSCombination_CommonList_20177_CommonList.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal global As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal global As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = ReturnCodes.DO_NOTHING.ToString
    'End Function
    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal Whizglobal As WebPages.Template.IGlobal)
        If Args.LinkName.ToUpper = "BACK" Then
            Cancel = True
        End If
    End Sub

    'Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    'End Sub

    'Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

    'End Sub

    'Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter)

    'End Sub

    'Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends)

    'End Sub

    'Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)

    'End Sub

    'Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        If Args.HTMLLegend.ToUpper = "RED COLOR INDICATES APPLIED FILTER" Then
            Cancel = True
        End If
        If MyBase.m_objGlobal.ParentTagID <> 0 Then
            Cancel = True
        End If
    End Sub

    'Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal global As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub


    'Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotGraph(ByVal Args As CommonEngines.EventHandlers.WAF_Graph, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataHeader(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub
    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New Baseline_Filter_CommonListSQL(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New Baseline_CLPlotGrid(MyBase.m_objGlobal)
    End Function
End Class
Public Class Baseline_Filter_CommonListSQL
    Inherits CommonEngine.CommonList.cCLSQL

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Sub Initialize_GridSQL(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGridSQL, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strProjectID As String
        'strUniqueID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Uniqueid"), "")
        strProjectID = CommonFunction.General.CheckIsNothing(CStr(HttpContext.Current.Session("intProjectID")), "0")

        If strProjectID <> "" Then
            Args.GridSQL = "Usp_sel_tbl_OS_PM_baselinehistory " & strProjectID.ToString & ""
        End If


    End Sub
    'Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
    '    '''''    Dim strLoginType As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("LoginType"), "E")
    '    '''''    Dim strUserID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0")
    '    '''''    Dim strIsFilterApplied As String
    '    '''''    strIsFilterApplied = Convert.ToString(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_UI_EmployeeFilterSettings_WPBN_OSCombination '" + strLoginType + "'," + strUserID + ",3814", True))
    '    '''''    If strIsFilterApplied = "0" Then
    '    '''''        GetPageSpecificFilters += " AND 1=2 "
    '    '''''    End If
    '    Dim strIsFilterApplied As String
    '    strIsFilterApplied = Convert.ToString(CommonFunctions.Data.GetDataScalar("Select MIN(OverallScheduleID) from tbl_OS_PM_baselinehistory where ProjectID=  " + CommonFunction.General.CheckIsNothing(CStr(HttpContext.Current.Session("intProjectID")), "0") + "", True))

    '    'GetPageSpecificFilters &= " and ProjectID = " + CommonFunction.General.CheckIsNothing(CStr(HttpContext.Current.Session("intProjectID")), "0")
    '    'Commented By Chakshuta H on 13th-Jan-2016 Purpose:To Remove the filter of showing latest records 
    '    If Not strIsFilterApplied Is Nothing And strIsFilterApplied <> "" Then
    '        'GetPageSpecificFilters += "AND (OverallScheduleID = " + strIsFilterApplied + ")"
    '        'GetPageSpecificFilters += "AND (OverallScheduleID = " + strIsFilterApplied + ")"
    '        GetPageSpecificFilters += "AND (OverallScheduleID is null)"
    '        'GetPageSpecificFilters += "	AND CounterNo IN (Select distinct CounterNo from tbl_WPBN_PM_OverallSchedule_History )" + vbCrLf

    '    End If
    '    'End Of Comment By Chakshuta H on 13th-Jan-2016 Purpose:To Remove the filter of showing latest records 
    '    GetPageSpecificFilters += "and ProjectID = " + CommonFunction.General.CheckIsNothing(CStr(HttpContext.Current.Session("intProjectID")), "0")
    '    GetPageSpecificFilters += " ORDER BY v_tbl_OS_PM_baselinehistory.OverallScheduleMasterID"
    '    'GetPageSpecificFilters &= " AND ProjectID is  NULL "
    'End Function
End Class
Public Class Baseline_CLPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Private WithEvents Snapshot As New WebPages.Template.GenericGrid
    Public Sub New(ByVal whizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(whizGlobal)
    End Sub
    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.DataField.ToLower = "os" Then
            Cancel = True
        End If
        If Args.DataField.ToLower = "baselinestartdate" Then
            Cancel = True
        End If
        If Args.DataField.ToLower = "baselineenddate" Then
            Cancel = True
        End If
        If Args.DataField.ToLower = "baselineefforts" Then
            Cancel = True
        End If
        If Args.DataField.ToLower = "actualworkingdays" Then
            Cancel = True
        End If
        If Args.DataField.ToLower = "totalworkingdays" Then
            Cancel = True
        End If
        If Args.DataField.ToLower = "actualstartdate" Then
            Cancel = True
        End If
        If Args.DataField.ToLower = "actualenddate" Then
            Cancel = True
        End If
        If Args.DataField.ToLower = "actualefforts" Then
            Cancel = True
        End If
        If Args.DataField.ToLower = "currentstartdate" Then
            Cancel = True
        End If
        If Args.DataField.ToLower = "currentenddate" Then
            Cancel = True
        End If
        If Args.DataField.ToLower = "currentefforts" Then
            Cancel = True
        End If
        If Args.DataField.ToLower = "currentduration" Then
            Cancel = True
        End If
        If Args.DataField.ToLower = "schedulevariance" Then
            Cancel = True
        End If
        If Args.DataField.ToLower = "effortvariance" Then
            Cancel = True
        End If
        If Args.ColumnName.ToUpper = "EFFORTVARIANCE" Then
            Cancel = True
        End If
        If Args.ColumnName.ToUpper = "BASELINESTARTDATE" Then
            Cancel = True
        End If
    End Sub
    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Added By VarunA on 23-May-2007 For Service Level Aggrement
        If Args.ColumnName.ToUpper = "DELETE" Then
            Args.ColumnName = "Delete"
        End If
        If Args.ColumnName.ToUpper = "EFFORT VARIANCE" Then
            Cancel = True

        End If
        If Args.ColumnName.ToUpper = "SCHEDULE VARIANCE" Then
            Cancel = True

        End If
        If Args.ColumnName.ToUpper = "BASELINE START DATE" Then
            Cancel = True

        End If
        If Args.ColumnName.ToUpper = "BASELINE END DATE" Then
            Cancel = True

        End If
        If Args.ColumnName.ToUpper = "BASELINE EFFORTS" Then
            Cancel = True

        End If
        If Args.ColumnName.ToUpper = "TOTAL WORKING DAYS" Then
            Cancel = True

        End If
        If Args.ColumnName.ToUpper = "TOTAL DURATION (DAYS)" Then
            Cancel = True

        End If
        If Args.ColumnName.ToUpper = "ACTUAL WORKING DAYS" Then
            Cancel = True

        End If
        If Args.ColumnName.ToUpper = "ACTUAL START DATE" Then
            Cancel = True

        End If
        If Args.ColumnName.ToUpper = "ACTUAL END DATE" Then
            Cancel = True

        End If
        If Args.ColumnName.ToUpper = "ACTUAL EFFORTS" Then
            Cancel = True

        End If
        If Args.ColumnName.ToUpper = "CURRENT START DATE" Then
            Cancel = True
        End If
        If Args.ColumnName.ToUpper = "CURRENT END DATE" Then
            Cancel = True
        End If
        If Args.ColumnName.ToUpper = "CURRENT EFFORTS" Then
            Cancel = True
        End If
        If Args.ColumnName.ToUpper = "CURRENT DURATION" Then
            Cancel = True
        End If
        If Args.ColumnName.ToUpper = "OS" Then
            Cancel = True

        End If
        ''End By VarunA on 23-May-2007
    End Sub

End Class