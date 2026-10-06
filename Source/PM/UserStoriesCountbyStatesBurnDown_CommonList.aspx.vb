Imports CommonEngines.General.cEventHandlers
Public Class UserStoriesCountbyStatesBurnDown_CommonList
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
        MyBase.strListPage = "UserStoriesCountbyStatesBurnDown_CommonList.aspx"
        MyBase.strFormPage = "UserStoriesCountbyStatesBurnDown_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub
    Protected m_UseEditableDateControl As Boolean = CommonFunctions.General.GetFrameworkSettings("EDITABLE_DATE_CONTROL", "Enabled")
    Protected strInputdateFormat As String = CommonFunction.Application.InputeDateFormat
    Private m_strSessionProjectID As String

    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal global As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal global As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function
  
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


        If Not Request.QueryString("Flag") Is Nothing Then
            Flag = Request.QueryString("Flag").ToString
            If Flag = "Date" Then
                Flag = "1"
            ElseIf Flag = "Week" Then
                Flag = "2"
            End If
        Else
            Flag = ""
        End If
        strHtml = "<table class=clsTable CellSpacing=0 width=100%>"
        strHtml += "<tr class=clsTREven><td align=left width=30%><b>User Stories Count </b> <i>by </i>"
        strHtml += CommonFunction.HTMLControls.DrawComboBox("cboType", "select '1','Date' UNION select '2','Week' ", 75, CommonFunctions.General.CheckIsNothing(CType(Flag, String), ""), "Onchange=javascript:ShowActivityView('Type')", True, True)

        If Request.QueryString("FromDate") <> "" Then
            strHtml += " From "
            strHtml += CommonFunction.HTMLControls.DrawDateControl("FromDate", "FromDate", , , Request.QueryString("FromDate").ToString, , "frmCommonList", , , , , True, , True, True)
        Else
            strHtml += " From "
            strHtml += CommonFunction.HTMLControls.DrawDateControl("FromDate", "FromDate", , , , , "frmCommonList", , , , , True, , True, True)
        End If

        If Request.QueryString("ToDate") <> "" Then
            strHtml += " To "
            strHtml += CommonFunction.HTMLControls.DrawDateControl("ToDate", "ToDate", , , Request.QueryString("ToDate").ToString, , "frmCommonList", , , , , True, , True, True)
        Else
            strHtml += " To "
            strHtml += CommonFunction.HTMLControls.DrawDateControl("ToDate", "ToDate", , , , , "frmCommonList", , , , , True, , True, True)
        End If
        strHtml += "&nbsp;<A HREF=""Javascript:ShowActivityView('Show')"" Title=""Click to view Report"" >Show</A>"
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
        If Request.QueryString("FromDate") = "" Or Request.QueryString("ToDate") = "" Then
            If Args.GraphTitle = "User Stories Count by Date" Then
                Cancel = True
            End If
            If Args.GraphTitle = "User Stories Count by Week" Then
                Cancel = True
            End If
        End If
        If Request.QueryString("Flag") = "Date" Then

            If Not Request.QueryString("FromDate") Is Nothing And Not Request.QueryString("ToDate") Is Nothing Then
                If Args.GraphTitle = "User Stories Count by Week" Then
                    Cancel = True
                End If
                If Args.GraphTitle = "User Stories Count by Date" Then
                    'Args.ChartAreaColor = "AliceBlue"
                    'Args.ChartBackColor = "SlateGray"
                    'Args.LegendCaptionColor = "Blue"
                    Args.SQL = "Usp_Sel_UserStoriesCountByStatus_Report " + m_strSessionProjectID.ToString + ",'" + Request.QueryString("FromDate").ToString + "','" + Request.QueryString("ToDate").ToString + "','Date'"
                End If
            End If
        End If
        If Request.QueryString("Flag") = "Week" Then

            If Not Request.QueryString("FromDate") Is Nothing And Not Request.QueryString("ToDate") Is Nothing Then
                If Args.GraphTitle = "User Stories Count by Date" Then
                    Cancel = True
                End If
                If Args.GraphTitle = "User Stories Count by Week" Then
                    Args.SQL = "Usp_Sel_UserStoriesCountByStatus_Report " + m_strSessionProjectID.ToString + ",'" + Request.QueryString("FromDate").ToString + "','" + Request.QueryString("ToDate").ToString + "','Week'"
                End If
            End If
        End If
    End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub
End Class


