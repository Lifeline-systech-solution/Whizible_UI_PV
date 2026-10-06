Imports CommonEngines.General.cEventHandlers
Public Class TestCasesbyUserStory_CommonList
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
        MyBase.strListPage = "TestCasesbyUserStory_CommonList.aspx"
        MyBase.strFormPage = "TestCasesbyUserStory_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub
    Private m_strSessionProjectID As String
    Private Iteration As String
    Private Release As String
    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal global As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal global As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New TestCasesbyUserStory_CommonList_PlotGrid(MyBase.m_objGlobal)
    End Function
    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = ReturnCodes.DO_NOTHING.ToString
    End Function


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

    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)
        Dim strHtml As String
        m_strSessionProjectID = CType(Session("intProjectID"), String)
        If Not Request.QueryString("ReleaseID") Is Nothing Then
            Release = Request.QueryString("ReleaseID").ToString
        Else
            Release = ""
        End If
        If Not Request.QueryString("IterationID") Is Nothing Then
            Iteration = Request.QueryString("IterationID").ToString
        Else
            Iteration = ""
        End If
        strHtml = "<table class=clsTable CellSpacing=0 width=100%>"
        strHtml += "<tr class=clsTREven><td align=left><b>Release </b>"
        'strHtml += CommonFunction.HTMLControls.DrawComboBox("ReleaseID", "select ReleaseID,ReleaseName from tbl_PM_ScrumRelease Where ProjectID=" + m_strSessionProjectID + " order by ReleaseName", 100, CommonFunctions.General.CheckIsNothing(CType(Release, String), ""), "onchange=javascript:GetIterations(this)", True, True)
        strHtml += CommonFunction.HTMLControls.DrawComboBox("ReleaseID", "usp_sel_tbl_PM_ScrumRelease_ReleaseID " + m_strSessionProjectID, 100, CommonFunctions.General.CheckIsNothing(CType(Release, String), ""), "onchange=javascript:GetIterations(this)", True, True)
        strHtml += "&nbsp;&nbsp;<b>Iteration</b> "
        If Release = "" Then
            strHtml += CommonFunction.HTMLControls.DrawComboBox("IterationID", "select ''", 170, CommonFunctions.General.CheckIsNothing(CType(Iteration, String), ""), "onchange=javascript:ShowGraph()", True, True)
        Else
            'strHtml += CommonFunction.HTMLControls.DrawComboBox("IterationID", "select IterationID,IterationName from tbl_PM_Scrumiteration WITH(NOLOCK) where ReleaseID=" + Release, 170, CommonFunctions.General.CheckIsNothing(CType(Iteration, String), ""), "onchange=javascript:ShowGraph()", True, True)
            strHtml += CommonFunction.HTMLControls.DrawComboBox("IterationID", "usp_sel_tbl_PM_ScrumRelease_IterationID " + Release, 170, CommonFunctions.General.CheckIsNothing(CType(Iteration, String), ""), "onchange=javascript:ShowGraph()", True, True)
        End If
        strHtml += "</td>"
        strHtml += "</tr>"
        strHtml += "</table><br>"
        CommonFunction.General.WriteHTML(strHtml)
    End Sub

    'Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        Cancel = True
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

    Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        m_strSessionProjectID = CType(Session("intProjectID"), String)
        If Not Request.QueryString("IterationID") Is Nothing Then
            Iteration = Request.QueryString("IterationID").ToString
        Else
            Iteration = ""
        End If
        If Request.QueryString("IterationID") Is Nothing Then
            If Args.GraphTitle = "Test Cases by User Story" Then
                Cancel = True
            End If
        End If
        If Not Request.QueryString("IterationID") Is Nothing Then    
            If Args.GraphTitle = "Test Cases by User Story" Then
                Args.SQL = "Usp_Sel_TestCases_ByUserStory_Report " + m_strSessionProjectID.ToString + "," + Request.QueryString("IterationID").ToString
            End If
        End If
    End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub
End Class
Class TestCasesbyUserStory_CommonList_PlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid

    Sub New(ByVal objGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(objGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)

        Cancel = True
    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Cancel = True
    End Sub
    'Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub
    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Cancel = True
    End Sub
    'Protected Overrides Sub After_GridDataRowTR_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

End Class
