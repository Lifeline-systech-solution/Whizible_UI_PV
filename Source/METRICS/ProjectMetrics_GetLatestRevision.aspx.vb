Imports PbNIT
Partial Public Class ProjectMetrics_GetLatestRevision
    Inherits WebPages.Template.WhizTemplate

    Protected m_strFrom As String = ""
    Protected m_strAction As String = ""
    Protected strMenu As String = ""
    Protected MetricProjectMappingID As Integer = 0
    Protected strReason As String = ""
    Protected dtFromDate As String = ""


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ''Added by Yogesh Jalamkar on 10-OCT-2016 Purpose:Sql injection and Cross Site Scripting
        MyBase.ApplySecurity(True)
        ''End of addition by Yogesh Jalamkar on 10-OCT-2016 
    End Sub

    Protected Sub InitPage()
        InitVariables()
        If m_strAction = "REGENERATE" Then
            PerformAction()
        ElseIf m_strAction = "PUBLISH" Then
            PerformPublishAction()
        Else
            DrawPage()
        End If

    End Sub
    Private Sub InitVariables()
        m_strFrom = CommonFunction.General.CheckIsNothing(Request.QueryString("From"), "")
        MetricProjectMappingID = CInt(CommonFunction.General.CheckIsNothing(Request.QueryString("MetricProjectMappingID"), "0"))
        m_strAction = CommonFunction.General.CheckIsNothing(Request.QueryString("Action"), "")
        strReason = CommonFunction.General.CheckIsNothing(Request.Form("txtReason"), "")
        dtFromDate = CommonFunction.General.CheckIsNothing(Request.Form("dtFromDate"), "")
    End Sub
    Private Sub DrawPage()
        strMenu = GetMenu()
        CommonFunction.General.WriteHTML(strMenu.ToString)

        If m_strFrom = "GETLATEST" Then
            CommonFunction.General.WriteHTML("<BR><TABLE cellspacing=0 cellpadding=0 border=0 class='clsTable' width='99.9%'>")
            CommonFunction.General.WriteHTML("<TR class='clsTRPageHeader'>")
            CommonFunction.General.WriteHTML("<TD align='left'>Get Latest revision and Regenerate Metric Data")
            CommonFunction.General.WriteHTML("</TD></TR></TABLE><BR>")

            CommonFunction.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 border=0 class='clsTable'>")
            CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
            CommonFunction.General.WriteHTML("<TD align='right'>Re-Generate Data From Date</TD>")
            CommonFunction.General.WriteHTML("<TD align='left'>")
            CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawDateControl("dtFromDate", "dtFromDate", , , , , "frmMetricRevision", , , , , , , True))
            'Commented and added by Yogesh J for HTML encoding Date:07/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidTodaydt", "txthidTodaydt", , , , CDate(CommonFunctions.Data.GetDataScalar("Select getdate()", MyBase.UseSQL)).ToString("dd-MMM-yyyy"), , , , , , True, EnableHTMLEncode:=True)
            CommonFunctions.HTMLControls.DrawTextBox("txtPrjFreezdt", "txtPrjFreezdt", , , , CDate(CommonFunctions.Data.GetDataScalar("usp_Sel_Project_FreezedDate " & CommonFunctions.General.CheckIsNothing(Session("intProjectID"), "0") & ",1" _
                    , MyBase.UseSQL)).ToString("dd-MMM-yyyy"), , , , , , True, EnableHTMLEncode:=True)
            CommonFunctions.HTMLControls.DrawTextBox("txtPrjStartdt", "txtPrjStartdt", , , , CDate(CommonFunctions.Data.GetDataScalar("usp_Sel_Project_FreezedDate " & CommonFunctions.General.CheckIsNothing(Session("intProjectID"), "0") & ",0" _
                    , MyBase.UseSQL)).ToString("dd-MMM-yyyy"), , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:07/10/15
            CommonFunction.General.WriteHTML("</TD></TR>")
            CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
            CommonFunction.General.WriteHTML("<TD align='right'>Reason</TD>")
            CommonFunction.General.WriteHTML("<TD align='left'>")
            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextArea("txtReason", "txtReason", "Reason", , , "frmMetricRevision", , , 200, 80, 100, , , , , , , , , True))
            CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextArea("txtReason", "txtReason", "Reason", , , "frmMetricRevision", , , 200, 80, 100, , , , , , , , , True, EnableHTMLEncode:=True))
            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            CommonFunction.General.WriteHTML("</TD></TR></TABLE>")
        Else
            CommonFunction.General.WriteHTML("<BR><TABLE cellspacing=0 cellpadding=0 border=0 class='clsTable' width='99.9%'>")
            CommonFunction.General.WriteHTML("<TR class='clsTRPageHeader'>")
            CommonFunction.General.WriteHTML("<TD align='left'>Publish revision and Regenerate Metric Data")
            CommonFunction.General.WriteHTML("</TD></TR></TABLE><BR>")

            CommonFunction.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 border=0 class='clsTable'>")
            CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
            CommonFunction.General.WriteHTML("<TD align='right'>Re-Generate Data From Date</TD>")
            CommonFunction.General.WriteHTML("<TD align='left'>")
            CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawDateControl("dtFromDate", "dtFromDate", , , , , "frmMetricRevision", , , , , , , True))
            'Commented and added by Yogesh J for HTML encoding Date:07/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidTodaydt", "txthidTodaydt", , , , CDate(CommonFunctions.Data.GetDataScalar("Select getdate()", MyBase.UseSQL)).ToString("dd-MMM-yyyy"), , , , , , True, EnableHTMLEncode:=True)
            CommonFunctions.HTMLControls.DrawTextBox("txtPrjFreezdt", "txtPrjFreezdt", , , , CDate(CommonFunctions.Data.GetDataScalar("usp_Sel_Project_FreezedDate " & CommonFunctions.General.CheckIsNothing(Session("intProjectID"), "0") & ",1" _
                    , MyBase.UseSQL)).ToString("dd-MMM-yyyy"), , , , , , True, EnableHTMLEncode:=True)
            CommonFunctions.HTMLControls.DrawTextBox("txtPrjStartdt", "txtPrjStartdt", , , , CDate(CommonFunctions.Data.GetDataScalar("usp_Sel_Project_FreezedDate " & CommonFunctions.General.CheckIsNothing(Session("intProjectID"), "0") & ",0" _
                    , MyBase.UseSQL)).ToString("dd-MMM-yyyy"), , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:07/10/15
            CommonFunction.General.WriteHTML("</TD></TR>")
            CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
            CommonFunction.General.WriteHTML("<TD align='right'>Reason</TD>")
            CommonFunction.General.WriteHTML("<TD align='left'>")
            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextArea("txtReason", "txtReason", "Reason", , , "frmMetricRevision", , , 200, 80, 100, , , , , , , , , True))
            CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextArea("txtReason", "txtReason", "Reason", , , "frmMetricRevision", , , 200, 80, 100, , , , , , , , , True, EnableHTMLEncode:=True))
            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            CommonFunction.General.WriteHTML("</TD></TR></TABLE>")
        End If

    End Sub

    Private Function GetMenu() As String
        '=====================================================================
        ' Procedure Name        : GetMenu()	
        ' Purpose               : To get the menu for current mode
        ' Description           : same as above
        ' Parameters Passed     : 
        ' Returns               : string of menu
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        '=====================================================================
        Dim strPaging As String = ""
        Dim strSQL As String = ""
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")

        If UCase(Trim(m_strFrom & "")) = "GETLATEST" Then
            Dim arrMenu() As String = {"Regenerate", "Close", "?"}
            Dim arrMenuToolTip() As String = {"Regenerate", "Close", "Help"}
            Dim arrCSFunction() As String = {"Regenerate_OnClick()", "Close_OnClick()", "Help_OnClick(MetricRevision)"}
            Return WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip, True, strPaging)
        ElseIf UCase(Trim(m_strFrom & "")) = "PUBLISH" Then
            Dim arrMenu() As String = {"Publish & Regenerate", "Close", "?"}
            Dim arrMenuToolTip() As String = {"Publish & Regenerate", "Close", "Help"}
            Dim arrCSFunction() As String = {"RegeneratePublish_OnClick()", "Close_OnClick()", "Help_OnClick(MetricRevision)"}
            Return WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip, True, strPaging)
        Else
            Dim arrMenu() As String = {"Close", "?"}
            Dim arrMenuToolTip() As String = {"Close", "Help"}
            Dim arrCSFunction() As String = {"Close_OnClick()", "Help_OnClick(MetricRevision)"}

            Return WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip, True)

        End If


    End Function

    Protected Sub PerformAction()
        Dim strSQL As String = ""
        strSQL = "usp_MET_Regenerate_ProjectMetricsData " + MetricProjectMappingID.ToString + ",'" + CommonFunction.General.CheckIsNothing(Session("strUserName"), "") + "',"
        strSQL = strSQL + "'" + strReason + "','" + dtFromDate + "'"

        CommonFunction.Data.InsertOrUpdateData(strSQL, True)
        CommonFunction.General.WriteHTML("<script language=javascript>")
        CommonFunction.General.WriteHTML("window.opener.location.href='../METRICS/MB_ProjectMeasurement_CommonPage.aspx?MasterTagID=2506&FromWhere=PM';")
        CommonFunction.General.WriteHTML("window.close();")
        CommonFunction.General.WriteHTML("</script>")

    End Sub
    Protected Sub PerformPublishAction()
        Dim strSQL As String = ""
        strSQL = "usp_MET_Regenerate_ProjectMetricsData_Publish " + MetricProjectMappingID.ToString + ",'" + CommonFunction.General.CheckIsNothing(Session("strUserName"), "") + "',"
        strSQL = strSQL + "'" + strReason + "','" + dtFromDate + "'"

        CommonFunction.Data.InsertOrUpdateData(strSQL, True)
        CommonFunction.General.WriteHTML("<script language=javascript>")
        CommonFunction.General.WriteHTML("window.opener.location.href='../METRICS/MB_ProjectMeasurement_CommonPage.aspx?MasterTagID=2506&FromWhere=PM';")
        CommonFunction.General.WriteHTML("window.close();")
        CommonFunction.General.WriteHTML("</script>")

    End Sub
End Class