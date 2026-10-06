Partial Public Class RM_ProjectTaskDistribution
    Inherits WebPages.Template.WhizTemplate

#Region "Variables"
    Protected Const ACTION_VIEW_REPORT As String = "ViewReport"
    Protected m_strTempFromDate As String = ""
    Protected m_lngMasterTagId As Long = 0
    Protected m_strFileName As String
    Protected m_intShowMessage As Integer = 0
    Private WithEvents oRpt As AdHocReports.Report.AdHocReport
    Protected m_intOpenReportInSecurePage As Integer = 0
    Protected m_strReportDisclaimer As String = ""
    Dim lngProjectId As Long = 0
    Dim lngTimeFlagId As Long = 0
#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If UCase(Trim(Request.QueryString("Format") & "")) = "HTML" Then

            If Not CommonFunctions.General.GetApplicationKeySetting("WAF_OpenReportsInSecurePage") Is Nothing Then
                If CType(CommonFunctions.General.GetApplicationKeySetting("WAF_OpenReportsInSecurePage"), Boolean) Then

                    m_intOpenReportInSecurePage = 1

                End If

            End If

        End If
    End Sub

    Public Sub PageInit()
        ' Added By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        MyBase.ApplySecurity(True)
        ' End Added By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting

        Dim strMenu As String = ""
        Dim strQuery As String = ""
        Dim objGlobal As WebPages.Template.IGlobal

        Dim strAction As String = ""
        Dim intTemp As Integer = 0

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        objGlobal = MyBase.GlobalObject()


        lngProjectId = CType("0" & CommonFunctions.General.CheckIsNothing(Request.Form("cboProject"), CommonFunction.General.CheckIsNothing(Session("intProjectID"), "0")), Long)

        lngTimeFlagId = CType("0" & CommonFunctions.General.CheckIsNothing(Request.Form("cboTimeFlag"), "0"), Long)

        strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("Action"))
        If strAction = ACTION_VIEW_REPORT Then
            ShowReport()
        Else
            'Display the Menu
            strMenu = GetPageMenu()

            MyBase.InitializeResources("AppResources.PM_ResourceUtilization", "AppResources")
            CommonFunctions.General.WriteHTML(strMenu)
            CommonFunctions.General.WriteHTML("<BR>")

            'Display the Page Caption
            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Project Task Distribution", , , True))
            CommonFunctions.General.WriteHTML("<BR>")

            CommonFunctions.General.WriteHTML("<DIV Id='PageDiv' Style='width:100%'>")
            'Display the Page Controls
            CommonFunctions.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 width='99.9%' class='clsTable'>")
            CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
            CommonFunctions.General.WriteHTML("<td align=right>Project&nbsp;</td><td>")
            'Integrated By ChaitraliH On 21 May 09
            'Modified By VarunA on 25-Mar-2009 IssueID-28581
            'Purpose : To have the accessible project based on employee.
            'CommonFunctions.HTMLControls.DrawComboBox("cboProject", "Usp_Sel_tbl_PM_Project_ExceptGlobal", 300, lngProjectId.ToString(), , True, , , True)
            CommonFunctions.HTMLControls.DrawComboBox("cboProject", "Usp_Sel_tbl_PM_Project_ExceptGlobal " + CType(HttpContext.Current.Session("intUserID"), String) + "," + CType(Context.Session("LoginType"), String), 300, lngProjectId.ToString(), , True, , , True)
            'End By VarunA on 25-Mar-2009 IssueID-28581
            'End Of Integration By ChaitraliH On 21 May 09
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
            CommonFunctions.General.WriteHTML("<td align=right>Select Period&nbsp;</td><td>")
            CommonFunctions.HTMLControls.DrawComboBox("cboTimeFlag", "Usp_Sel_v_sel_ProjectDateRanges", 300, lngTimeFlagId.ToString(), , True, , , True)
            CommonFunctions.General.WriteHTML("</TD></tr>")
            CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
            CommonFunctions.General.WriteHTML("<td align=right>Type&nbsp;</td><td>")
            CommonFunctions.HTMLControls.DrawComboBox("cboReportType", "Usp_Sel_ReportType", , , , True, , , True)
            CommonFunctions.General.WriteHTML("</TD></tr>")
            CommonFunctions.General.WriteHTML("</TABLE>")

            CommonFunctions.General.WriteHTML("</DIV>")

            MyBase.InitializeResources("Resources.StandardMessages", "Resources")
            m_strReportDisclaimer = MyBase.GetResourceString("REPORT_DISCLAIMER") + ""

            Response.Write(m_strReportDisclaimer)

            CommonFunctions.General.WriteHTML("<BR>")
            CommonFunctions.General.WriteHTML(strMenu)
        End If

    End Sub

    Private Function GetPageMenu() As String
        '=====================================================================
        ' Procedure Name        : GetPageMenu
        ' Purpose               : To get the menu for the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : The menu string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : Resources.dll
        ' Author                : Rajanikant
        ' Created               : Apr 02,2004
        ' Revisions             :
        '=====================================================================
        Dim strReportType As String
        Dim intWorkType As Integer
        Dim lngReportID As Long
        Dim objMenu As New WebPages.Template.StaticMenu
        Dim intUBound As Integer

        ' get the submitted values
        strReportType = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("CboReportType"))
        If strReportType.ToLower = "details" Then
            lngReportID = 291
        Else
            lngReportID = 2528
        End If
        m_lngMasterTagId = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("MasterTagID"), "0"), Long)

        MyBase.InitializeResources("Resources.StandardMenu", "Resources")
        'integration by harshadad on 16092005 for issue id 266
        ' added by Harshada D on 05-08-2005 for show /hide EXCEL option according to web.config setting .
        Dim strExcel As String
        'here if this key WAF_CRW_FormatsToBeDisabled contain value "EXCEL" then excel option is drawn . 
        strExcel = CommonFunctions.General.GetApplicationKeySetting("WAF_CRW_FormatsToBeDisabled")
        '- removed option excel from  arrMenu,arrMenuToolTip ,arrClientSideFunction 
        If strExcel = "EXCEL" Then
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_PDF"), _
                                       MyBase.GetResourceString("MENU_HTML"), _
                                       MyBase.GetResourceString("MENU_RTF"), _
                                       MyBase.GetResourceString("MENU_CSV"), _
                                       MyBase.GetResourceString("MENU_Text"), _
                                       MyBase.GetResourceString("MENU_XML"), _
                                       MyBase.GetResourceString("MENU_HELP")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_PDF_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_HTML_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_RTF_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_CSV_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_Text_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_XML_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            Dim arrCSFunctions() As String = {"ViewReport_OnClick('PDF')", "ViewReport_OnClick('HTML')", _
                                              "ViewReport_OnClick('RTF')", _
                                              "ViewReport_OnClick('CSV')", "ViewReport_OnClick('TEXT')", _
                                              "ViewReport_OnClick('XML')", "Help_OnClick(" & m_lngMasterTagId.ToString() & ")"}
            GetPageMenu = objMenu.DrawMenuWithEvents(arrMenu, arrCSFunctions, arrMenuToolTip, True)
            ' clean up
            objMenu = Nothing
            arrMenu = Nothing : arrMenuToolTip = Nothing : arrCSFunctions = Nothing
        Else
            'end of addition by Harshada D on 05-08-2005 for show /hide EXCEL option according to web.config setting
            'end of integration by harshadad on 16092005 for issue id 266
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_PDF"), _
                                       MyBase.GetResourceString("MENU_HTML"), _
                                       MyBase.GetResourceString("MENU_RTF"), _
                                       MyBase.GetResourceString("MENU_EXCEL"), _
                                       MyBase.GetResourceString("MENU_CSV"), _
                                       MyBase.GetResourceString("MENU_Text"), _
                                       MyBase.GetResourceString("MENU_XML"), _
                                       MyBase.GetResourceString("MENU_HELP")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_PDF_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_HTML_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_RTF_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_EXCEL_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_CSV_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_Text_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_XML_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            Dim arrCSFunctions() As String = {"ViewReport_OnClick('PDF')", "ViewReport_OnClick('HTML')", _
                                              "ViewReport_OnClick('RTF')", "ViewReport_OnClick('EXCEL')", _
                                              "ViewReport_OnClick('CSV')", "ViewReport_OnClick('TEXT')", _
                                              "ViewReport_OnClick('XML')", "Help_OnClick(" & m_lngMasterTagId.ToString() & ")"}

            ' return the menu string
            GetPageMenu = objMenu.DrawMenuWithEvents(arrMenu, arrCSFunctions, arrMenuToolTip, True)

            ' clean up
            objMenu = Nothing
            arrMenu = Nothing : arrMenuToolTip = Nothing : arrCSFunctions = Nothing
            ' added by harshada d on 16092005 for issue id 266
        End If
        'end of modification by harshada d on 05-08-2005
    End Function


    Private Sub ShowReport()
        '=====================================================================
        ' Procedure Name        : ShowReport
        ' Purpose               : To generate the report 
        ' Description           : The report is generated and file is opened
        '                         from window_onload() event
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFucntions.dll,AdHocReports.dll
        ' Author                : Rajanikant
        ' Created               : Apr 02,2004
        ' Revisions             :
        '=====================================================================
        Dim strFilePath As String
        Dim strFormat As String
        Dim strSQL As String
        Dim dr As IDataReader
        Dim lngReportID As Long
        Dim strReportType As String

        strReportType = CommonFunctions.General.CheckIsNothing(Request.Form("CboReportType"))
        If strReportType.ToLower = "details" Then
            lngReportID = 291
            strSQL = "usp_CRW_Project_Tasks_report " + lngProjectId.ToString() + "," + lngTimeFlagId.ToString()
        Else
            lngReportID = 2528
            strSQL = "usp_CRW_Project_Tasks_DistributionSummary " + lngProjectId.ToString() + "," + lngTimeFlagId.ToString()
        End If

        ' we need pdf only
        strFormat = Request.QueryString("format").ToString


        '' SELECT THE APT SOURCE 
        'If lngProjectID = 0 And lngEmployeeID = 0 Then
        '    ' based on the selected option(Project/Employee) call the report
        '    If UCase(Trim(strGroupingBy & "")) = "PROJECT" Then
        '        strSQL = "EXEC usp_ProjectEmployeeUtilization '" & strFromDate & "','" & strToDate & "'," & strWeekDays & "," & intWorkType & "," & Session("intUserID").ToString & ",1"
        '        lngReportID = RES_UTILIZATION_BY_PROJECT
        '    Else
        '        strSQL = "EXEC usp_ProjectEmployeeUtilization '" & strFromDate & "','" & strToDate & "'," & strWeekDays & "," & intWorkType & "," & Session("intUserID").ToString & ",2"
        '        lngReportID = RES_UTILIZATION_BY_RESOURCE
        '    End If
        'ElseIf lngProjectID <> 0 Then
        '    ' report for a specific project
        '    strSQL = "EXEC usp_ProjectEmployeeUtilization '" & strFromDate & "','" & strToDate & "'," & strWeekDays & "," & intWorkType & "," & Session("intUserID").ToString & ",1" & "," & lngProjectID
        '    lngReportID = RES_UTILIZATION_BY_PROJECT
        'Else
        '    ' report for a specific resource
        '    strSQL = "EXEC usp_ProjectEmployeeUtilization '" & strFromDate & "','" & strToDate & "'," & strWeekDays & "," & intWorkType & "," & Session("intUserID").ToString & ",2" & ",NULL," & lngEmployeeID
        '    lngReportID = RES_UTILIZATION_BY_RESOURCE
        'End If

        dr = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If dr.Read Then

            ' The reports are created in the "Reports" folder
            strFilePath = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Reports/"))

            ' get a unique file name
            m_strFileName = CommonFunctions.FileDirectory.GetUniqueFileName.Trim

            ' add extn to file name based on format requested
            Select Case UCase(Trim(strFormat))
                Case "PDF" : m_strFileName += ".pdf"
                Case "HTML" : m_strFileName += ".htm"
                Case "RTF" : m_strFileName += ".rtf"
                Case "EXCEL" : m_strFileName += ".xls"
                Case "CSV" : m_strFileName += ".csv"
                Case "TEXT" : m_strFileName += ".txt"
                Case "XML" : m_strFileName += ".xml"
                Case Else : m_strFileName += ".pdf"
            End Select
            ' create object of Adhoc reports
            oRpt = New AdHocReports.Report.AdHocReport(lngReportID, strSQL, CommonFunctions.Application.ConnectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Attachments/Log/")))
            With oRpt
                .UseMSSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
                .DefaultLCID = CType(MyBase.DefaultUILCID, Integer)
                .LCID = MyBase.CurrentThreadUICultureID
                If CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCRW").Trim.ToUpper = "Y" Then
                    .UseHashTables = True
                Else
                    .UseHashTables = False
                End If
                .DateFormat = CType(CommonFunctions.Application.DateFormatID, Integer)
                .CompanyName = CommonFunctions.Application.CompanyName
                .GraphImageGenerationAbsolutePath = Server.MapPath("../../Images/")

                ' generate the report in requested format
                Select Case strFormat
                    Case "PDF" : .GenerateReport(AdHocReports.Format.PDF)
                    Case "HTML" : .GenerateReport(AdHocReports.Format.HTML)
                    Case "RTF" : .GenerateReport(AdHocReports.Format.RTF)
                    Case "EXCEL" : .GenerateReport(AdHocReports.Format.EXCEL)
                    Case "CSV" : .GenerateReport(AdHocReports.Format.CSV)
                    Case "TEXT" : .GenerateReport(AdHocReports.Format.TEXT)
                    Case "XML" : .GenerateReport(AdHocReports.Format.XML)
                    Case Else : .GenerateReport(AdHocReports.Format.PDF)
                End Select
            End With
            oRpt = Nothing
            'Added by PrashantD on 21 Aug 2007 for WhizFrameWork SP8
            m_strFileName = CommonFunctions.General.EncryptString(CommonFunctions.General.EncryptString(m_strFileName))
            Response.Redirect("../CRW/CRW_ReportExport.aspx?FileName=" + m_strFileName, True)
            'End of addition by PrashantD on 21 Aug 2007
        Else
            ' set the flag here to show the message that there is no data
            ' at the client side
            m_intShowMessage = 1
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Sub

End Class