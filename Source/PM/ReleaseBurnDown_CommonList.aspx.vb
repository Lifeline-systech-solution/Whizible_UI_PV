Imports CommonEngines.General.cEventHandlers
Public Class ReleaseBurnDown_CommonList
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
        MyBase.strListPage = "ReleaseBurnDown_CommonList.aspx"
        MyBase.strFormPage = "ReleaseBurnDown_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub
    Private m_strSessionProjectID As String
    Private m_ReleaseID As String
    Private m_Type As String

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = ReturnCodes.DO_NOTHING.ToString
    End Function

    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)
        Dim strHtml As String
        m_strSessionProjectID = CType(Session("intProjectID"), String)
        If Not Request.QueryString("ReleaseID") Is Nothing Then
            m_ReleaseID = Request.QueryString("ReleaseID").ToString
        Else
            m_ReleaseID = ""
        End If
        If Not Request.QueryString("Type") Is Nothing Then
            m_Type = Request.QueryString("Type").ToString
        Else
            m_Type = ""
        End If
        strHtml = "<table class=clsTable CellSpacing=0 width=100%>"
        strHtml += "<tr class=clsTREven><td align=center width=50%><b>Release </b>"
        'strHtml += CommonFunction.HTMLControls.DrawComboBox("cboRelease", "select ReleaseID,ReleaseName from tbl_PM_ScrumRelease Where ProjectID=" + m_strSessionProjectID.ToString + " order by ReleaseName", 170, CommonFunctions.General.CheckIsNothing(CType(m_ReleaseID, String), ""), "onchange=javascript:ShowReport()", True, True)
        strHtml += CommonFunction.HTMLControls.DrawComboBox("cboRelease", "usp_sel_tbl_PM_ScrumRelease_ReleaseID " + m_strSessionProjectID.ToString, 170, CommonFunctions.General.CheckIsNothing(CType(m_ReleaseID, String), ""), "onchange=javascript:ShowReport()", True, True)
        strHtml += "</td>"
        strHtml += "<td align=left width=50%><b>Graph Type </b>"
        strHtml += CommonFunction.HTMLControls.DrawComboBox("cboGraphtype", "select '1','Line' UNION select '2','Column'", 70, CommonFunctions.General.CheckIsNothing(CType(m_Type, String), ""), "onchange=javascript:ShowReport()", True, True)
        strHtml += "</td>"
        strHtml += "</tr>"
        strHtml += "</table><br>"
        CommonFunction.General.WriteHTML(strHtml)
    End Sub
    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        Cancel = True
    End Sub
    Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

        If Request.QueryString("ReleaseID") = "" And Request.QueryString("Type") = "" Then
            If Args.GraphTitle = "Release Burn Down Column Graph" Or Args.GraphTitle = "Release Burn Down Line Graph" Then
                Cancel = True
            End If
        End If
        If Not Request.QueryString("ReleaseID") Is Nothing And Request.QueryString("Type") = "1" Then
            If Args.GraphTitle = "Release Burn Down Line Graph" Then
                Args.SQL = "Usp_Sel_ReleaseBurnDown " + Request.QueryString("ReleaseID").ToString + ",'Release'"
            ElseIf Args.GraphTitle = "Release Burn Down Column Graph" Then
                Cancel = True
            End If
        End If
        If Not Request.QueryString("ReleaseID") Is Nothing And Request.QueryString("Type") = "2" Then
            If Args.GraphTitle = "Release Burn Down Column Graph" Then
                Args.SQL = "Usp_Sel_ReleaseBurnDown " + Request.QueryString("ReleaseID").ToString + ",'Release'"
            ElseIf Args.GraphTitle = "Release Burn Down Line Graph" Then
                Cancel = True
            End If
        End If
        If Not Request.QueryString("ReleaseID") Is Nothing And Request.QueryString("Type") = "" Then
            If Args.GraphTitle = "Release Burn Down Column Graph" Then
                Args.SQL = "Usp_Sel_ReleaseBurnDown " + Request.QueryString("ReleaseID").ToString + ",'Release'"
            ElseIf Args.GraphTitle = "Release Burn Down Line Graph" Then
                Cancel = True
            End If
        End If
    End Sub
End Class
