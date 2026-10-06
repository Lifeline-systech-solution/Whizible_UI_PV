Imports CommonEngines.General.cEventHandlers
Public Class TestRunsQualityReport_CommonList
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
        MyBase.strListPage = "TestRunsQualityReport_CommonList.aspx"
        MyBase.strFormPage = "TestRunsQualityReport_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub
    Protected m_UseEditableDateControl As Boolean = CommonFunctions.General.GetFrameworkSettings("EDITABLE_DATE_CONTROL", "Enabled")
    Protected strInputdateFormat As String = CommonFunction.Application.InputeDateFormat
    Private m_strSessionProjectID As String
    Private m_TestSessionID As String
    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal global As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal global As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New TestRunsQualityReport_CommonList_PlotGrid(MyBase.m_objGlobal)
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
        Dim Flag As String

        m_strSessionProjectID = CType(Session("intProjectID"), String)
        If Not Request.QueryString("Flag") Is Nothing Then
            Flag = Request.QueryString("Flag").ToString
            If Flag = "Release" Then
                Flag = "1"
            ElseIf Flag = "Iteration" Then
                Flag = "2"
            ElseIf Flag = "Date" Then
                Flag = "3"
            ElseIf Flag = "Week" Then
                Flag = "4"
            End If
        Else
            Flag = ""
        End If
        If Not Request.QueryString("TestSession") Is Nothing Then
            m_TestSessionID = Request.QueryString("TestSession").ToString
        Else
            m_TestSessionID = ""
        End If
        strHtml = "<table class=clsTable CellSpacing=0 width=100%>"
        strHtml += "<tr class=clsTREven><td align=left><b>Test Runs</b> <i>by </i>"
        strHtml += CommonFunction.HTMLControls.DrawComboBox("cboType", "select '1','Release' UNION select '2','Iteration' UNION select '3','Date' UNION select '4','Week' ", 75, CommonFunctions.General.CheckIsNothing(CType(Flag, String), ""), "Onchange=javascript:ShowActivityView()", True, True)
        strHtml += "&nbsp;&nbsp;<i>For </i> <b>Test Session</b> "

        'Commented and Added by Chakshuta H on 8th-Aug-2016 
        'strHtml += CommonFunction.HTMLControls.DrawComboBox("cboTestSession", "select TestsessionID,Title from tbl_tcm_testsession Where ProjectID = " + m_strSessionProjectID + " Order By Title ", 170, CommonFunctions.General.CheckIsNothing(CType(m_TestSessionID, String), ""), "Onchange=javascript:ShowActivityView()", True, True)
        strHtml += CommonFunction.HTMLControls.DrawComboBox("cboTestSession", "usp_sel_tbl_tcm_testsession_TestsessionID_Title " + m_strSessionProjectID, 170, CommonFunctions.General.CheckIsNothing(CType(m_TestSessionID, String), ""), "Onchange=javascript:ShowActivityView()", True, True)
        'End Of Commented and Added by Chakshuta H on 8th-Aug-2016 
        'strHtml += "</tr>"
        'strHtml += "<tr class=clsTREven><td align=left>"
        If Request.QueryString("Flag") <> "Date" And Request.QueryString("Flag") <> "Week" Then
            If Request.QueryString("FromDate") <> "" Then
                strHtml += " From "
                strHtml += CommonFunction.HTMLControls.DrawDateControl("FromDate", "FromDate", , , , , "frmCommonList", , , , True, True, , True, True)
            Else
                strHtml += " From "
                strHtml += CommonFunction.HTMLControls.DrawDateControl("FromDate", "FromDate", , , , , "frmCommonList", , , , True, True, , True, True)
            End If

            If Request.QueryString("ToDate") <> "" Then
                strHtml += " To "
                strHtml += CommonFunction.HTMLControls.DrawDateControl("ToDate", "ToDate", , , , , "frmCommonList", , , , True, True, , True, True)
            Else
                strHtml += " To "
                strHtml += CommonFunction.HTMLControls.DrawDateControl("ToDate", "ToDate", , , , , "frmCommonList", , , , True, True, , True, True)
            End If

        Else
            If Request.QueryString("FromDate") <> "" Then
                strHtml += "From "
                strHtml += CommonFunction.HTMLControls.DrawDateControl("FromDate", "FromDate", , , Request.QueryString("FromDate").ToString, , "frmCommonList", , , , , True, , True, True)

            Else
                strHtml += "From "
                strHtml += CommonFunction.HTMLControls.DrawDateControl("FromDate", "FromDate", , , , , "frmCommonList", , , , , True, , True, True)

            End If

            If Request.QueryString("ToDate") <> "" Then
                strHtml += "To "
                strHtml += CommonFunction.HTMLControls.DrawDateControl("ToDate", "ToDate", , , Request.QueryString("ToDate").ToString, , "frmCommonList", , , , , True, , True, True)

            Else
                strHtml += "To "
                strHtml += CommonFunction.HTMLControls.DrawDateControl("ToDate", "ToDate", , , , , "frmCommonList", , , , , True, , True, True)

            End If

            strHtml += "&nbsp;<A HREF=""Javascript:ShowActivityView()"" Title=""Click to view Report"" >Show</A>"
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
        If Not Request.QueryString("TestSession") Is Nothing Then
            m_TestSessionID = Request.QueryString("TestSession").ToString    
        Else
            m_TestSessionID = ""
        End If
        If Request.QueryString("Flag") Is Nothing Then
            Cancel = True
        End If
        
        If Request.QueryString("Flag") = "Release" Then
            
            If Args.GraphTitle = "Test Runs by Release" And Request.QueryString("TestSession").ToString = "" Then
                Cancel = True
            End If
            If Args.GraphTitle = "Test Runs By Iteration" Then
                Cancel = True
            End If
            If Args.GraphTitle = "Test Runs By Date" Then
                Cancel = True
            End If
            If Args.GraphTitle = "Test Runs By Week" Then
                Cancel = True
            End If
            If Args.GraphTitle = "Test Runs by Release" Then
                If Request.QueryString("TestSession").ToString <> "" Then
                    Args.SQL = "Usp_Sel_TestRuns_Quality_Report " + m_strSessionProjectID.ToString + ",'Release','" + Request.QueryString("FromDate").ToString + "','" + Request.QueryString("ToDate").ToString + "'," + m_TestSessionID.ToString
                End If
            End If
        End If
        If Request.QueryString("Flag") = "Iteration" Then
            
            If Args.GraphTitle = "Test Runs By Iteration" And Request.QueryString("TestSession").ToString = "" Then
                Cancel = True
            End If
            If Args.GraphTitle = "Test Runs by Release" Then
                Cancel = True
            End If
            If Args.GraphTitle = "Test Runs By Date" Then
                Cancel = True
            End If
            If Args.GraphTitle = "Test Runs By Week" Then
                Cancel = True
            End If
            If Args.GraphTitle = "Test Runs By Iteration" Then
                 If Request.QueryString("TestSession").ToString <> "" Then
                Args.SQL = "Usp_Sel_TestRuns_Quality_Report " + m_strSessionProjectID.ToString + ",'Iteration','" + Request.QueryString("FromDate").ToString + "','" + Request.QueryString("ToDate").ToString + "'," + m_TestSessionID.ToString
                End If
            End If
        End If
        If Request.QueryString("Flag") = "Date" Then
            If Request.QueryString("FromDate") = "" Or Request.QueryString("ToDate") = "" Then
                If Args.GraphTitle = "Test Runs by Release" Then
                    Cancel = True
                End If
                If Args.GraphTitle = "Test Runs By Iteration" Then
                    Cancel = True
                End If
                If Args.GraphTitle = "Test Runs By Date" Then
                    Cancel = True
                End If
                If Args.GraphTitle = "Test Runs By Week" Then
                    Cancel = True
                End If

            End If
        End If
        If Request.QueryString("Flag") = "Week" Then
            If Request.QueryString("FromDate") = "" Or Request.QueryString("ToDate") = "" Then
                If Args.GraphTitle = "Test Runs by Release" Then
                    Cancel = True
                End If
                If Args.GraphTitle = "Test Runs By Iteration" Then
                    Cancel = True
                End If
                If Args.GraphTitle = "Test Runs By Date" Then
                    Cancel = True
                End If
                If Args.GraphTitle = "Test Runs By Week" Then
                    Cancel = True
                End If

            End If
        End If
        If Request.QueryString("Flag") = "Date" And Not Request.QueryString("FromDate") Is Nothing And Not Request.QueryString("ToDate") Is Nothing Then
            If Args.GraphTitle = "Test Runs by Release" Then
                Cancel = True
            End If
            If Args.GraphTitle = "Test Runs By Iteration" Then
                Cancel = True
            End If
            If Args.GraphTitle = "Test Runs By Week" Then
                Cancel = True
            End If
            'Modified i.e. added condition m_TestSessionID.ToString <> "" by NitinC on 03 Dec 2011 for WhizibleSEM 11.0 - Agile Module (Issue Fix : 57756)
            If Args.GraphTitle = "Test Runs By Date" And m_TestSessionID.ToString <> "" Then
                Args.SQL = "Usp_Sel_TestRuns_Quality_Report " + m_strSessionProjectID.ToString + ",'Date','" + Request.QueryString("FromDate").ToString + "','" + Request.QueryString("ToDate").ToString + "'," + m_TestSessionID.ToString
            End If
            'End of Modified by NitinC on 03 Dec 2011 for WhizibleSEM 11.0 - Agile Module (Issue Fix : 57756)
        End If
        If Request.QueryString("Flag") = "Week" And Not Request.QueryString("FromDate") Is Nothing And Not Request.QueryString("ToDate") Is Nothing Then
            If Args.GraphTitle = "Test Runs by Release" Then
                Cancel = True
            End If
            If Args.GraphTitle = "Test Runs By Iteration" Then
                Cancel = True
            End If
            If Args.GraphTitle = "Test Runs By Date" Then
                Cancel = True
            End If
            'Modified i.e. added condition m_TestSessionID.ToString <> "" by NitinC on 03 Dec 2011 for WhizibleSEM 11.0 - Agile Module (Issue Fix : 57756)
            If Args.GraphTitle = "Test Runs By Week" And m_TestSessionID.ToString <> "" Then
                Args.SQL = "Usp_Sel_TestRuns_Quality_Report " + m_strSessionProjectID.ToString + ",'Week','" + Request.QueryString("FromDate").ToString + "','" + Request.QueryString("ToDate").ToString + "'," + m_TestSessionID.ToString
            End If
            'End of Modified i.e. added condition m_TestSessionID.ToString <> "" by NitinC on 03 Dec 2011 for WhizibleSEM 11.0 - Agile Module (Issue Fix : 57756)
        End If
    End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub
End Class
Class TestRunsQualityReport_CommonList_PlotGrid
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
