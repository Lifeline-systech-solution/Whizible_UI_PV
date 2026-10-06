Public Class PM_ResourceUtilization
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Protected Const ACTION_VIEW_REPORT As String = "ViewReport"
    Private Const BY_PROJECT As String = "Project"
    Private Const BY_EMPLOYEE As String = "Employee"
    Private Const WORK_BILLABLE As String = "Billable"
    Private Const WORK_NONBILLABLE As String = "NonBillable"
    Private Const WORK_BOTH As String = "Both"

    Protected m_strTempFromDate As String = ""
    Protected m_lngMasterTagId As Long = 0
    Protected m_strFileName As String
    Protected m_intShowMessage As Integer = 0
    Private WithEvents oRpt As AdHocReports.Report.AdHocReport
    Const RES_UTILIZATION_BY_PROJECT As Long = 1001
    Const RES_UTILIZATION_BY_RESOURCE As Long = 1002
    'Added by MahendraV On 10:37 AM 5/24/2007 for List of Reports modified for HTML Report Issue
    'Start_MV_5/24/2007
    Protected m_intOpenReportInSecurePage As Integer = 0
    'End_MV_5/24/2007

    ' Added BY NitinVS on 4 July 2007 for WhizbleSEM 7 
    'Declare in the class level declaration.
    Protected m_strReportDisclaimer As String = ""
    'End addition NitinVS on 4 July 2007 for WhizbleSEM 7 

    Public Sub PageInit()
        Dim strMenu As String = ""
        Dim strQuery As String = ""
        Dim objGlobal As WebPages.Template.IGlobal

        Dim strAction As String = ""
        Dim intTemp As Integer = 0

        Dim lngProjectId As Long = 0
        Dim lngResourceId As Long = 0
        Dim strByWhat As String = BY_PROJECT
        Dim strWork As String = WORK_BOTH
        Dim strWeekDays As String = "6"
        Dim strFromDate As String = ""
        Dim strToDate As String = ""

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        objGlobal = MyBase.GlobalObject()

        strByWhat = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("optByWhat"))
        strByWhat = CommonFunctions.General.UnBuildQueryString(strByWhat)
        strWork = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("optWork"))
        strWork = CommonFunctions.General.UnBuildQueryString(strWork)
        strWeekDays = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("optWeekDays"))
        strFromDate = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtFromDate"))
        strToDate = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtToDate"))
        If strFromDate = "" Then
            intTemp = Weekday(Now(), CType(2, Microsoft.VisualBasic.FirstDayOfWeek))
            intTemp = intTemp - 6
            m_strTempFromDate = CommonFunctions.Dates.GetDate(Now().AddDays((-1) * intTemp))
            strFromDate = m_strTempFromDate
            strToDate = CommonFunctions.Dates.GetDate(CDate(strFromDate).AddDays(5))
        End If
        If strByWhat.Trim() = "" Then strByWhat = BY_PROJECT
        If strWork.Trim() = "" Then strWork = WORK_BOTH
        If strWeekDays.Trim() = "" Then strWeekDays = "6"

        If strByWhat = BY_PROJECT Then
            lngProjectId = CType("0" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboProject"), CommonFunction.General.CheckIsNothing(Session("intProjectID"), "0")), Long)
        Else            'By Employee
            lngResourceId = CType("0" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboEmployee"), "0"), Long)
        End If

        strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("Action"))
        If strAction = ACTION_VIEW_REPORT Then
            ShowReport()
            'Addition by SuchitraP on 8-Jan-2009 for IssueID:26382
            'Purpose:Same page was opened in new window if no data was present for the report
            If m_intShowMessage = 1 Then
                Exit Sub
            End If
            'End of addition by SuchitraP on 8-Jan-2009
        End If

        'Display the Menu
        strMenu = GetPageMenu()

        MyBase.InitializeResources("AppResources.PM_ResourceUtilization", "AppResources")
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

        'Display the Page Caption
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("RESOURCE_UTILIZATION"), , , True))
        CommonFunctions.General.WriteHTML("<BR>")

        CommonFunctions.General.WriteHTML("<DIV Id='PageDiv' Style='width:100%'>")
        'Display the Page Controls
        CommonFunctions.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 width='99.9%' class='clsTable'>")
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD>")
        CommonFunctions.HTMLControls.DrawOptionButton("optByWhat", "optByWhat", , (strByWhat = BY_PROJECT), BY_PROJECT, , "OnClick='ByWhat_OnClick()'", False)
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("PROJECT"))
        CommonFunctions.General.WriteHTML("</TD><TD>")
        'Code commented and added by SandipL on 10 Feb 2006 for proper Project display of Middle level resources
        'If objGlobal.RoleLevel = CommonFunctions.Constants.ACCESS_LEVEL_HIGH Then
        '    strQuery = "EXEC usp_Sel_tbl_PM_Project_To_Fill_Combo"
        'Else
        '    strQuery = "EXEC usp_Sel_Project_For_DA " & objGlobal.UserID.ToString()
        'End If
        strQuery = "usp_Sel_AccessibleProjects_ForEmployee " & objGlobal.UserID.ToString()
        'End Modification by SandipL on 10 Feb 2006
        If strByWhat = BY_PROJECT Then
            CommonFunctions.HTMLControls.DrawComboBox("cboProject", strQuery, , lngProjectId.ToString(), , True)
        Else
            CommonFunctions.HTMLControls.DrawComboBox("cboProject", strQuery, , , "disabled", True)
        End If
        CommonFunctions.General.WriteHTML("</TD><TD>")
        CommonFunctions.HTMLControls.DrawOptionButton("optWork", "optWork", , (strWork = WORK_BILLABLE), WORK_BILLABLE)
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("BILLABLE_WORK"))
        CommonFunctions.General.WriteHTML("</TD><TD>")
        CommonFunctions.HTMLControls.DrawOptionButton("optWeekDays", "optWeekDays", , (strWeekDays = "5"), "5", , "onclick='WeekDays_OnClick()'")
        CommonFunctions.General.WriteHTML(Replace(MyBase.GetResourceString("DAY_WEEK"), "<=>", "5"))
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")

        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD>")
        CommonFunctions.HTMLControls.DrawOptionButton("optByWhat", "optByWhat", , (strByWhat = BY_EMPLOYEE), BY_EMPLOYEE, , "OnClick='ByWhat_OnClick()'", False)
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("RESOURCE"))
        CommonFunctions.General.WriteHTML("</TD><TD>")
        strQuery = "EXEC usp_Sel_tbl_PM_Employee"
        If strByWhat = BY_EMPLOYEE Then
            CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", strQuery, 100, lngResourceId.ToString(), , True)
        Else
            CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", strQuery, 100, , "disabled", True)
        End If
        CommonFunctions.General.WriteHTML("</TD><TD>")
        CommonFunctions.HTMLControls.DrawOptionButton("optWork", "optWork", , (strWork = WORK_NONBILLABLE), WORK_NONBILLABLE)
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("NON_BILLABLE_WORK"))
        CommonFunctions.General.WriteHTML("</TD><TD>")
        CommonFunctions.HTMLControls.DrawOptionButton("optWeekDays", "optWeekDays", , (strWeekDays = "6"), "6", , "onclick='WeekDays_OnClick()'")
        CommonFunctions.General.WriteHTML(Replace(MyBase.GetResourceString("DAY_WEEK"), "<=>", "6"))
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")

        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD>")
        CommonFunctions.General.WriteHTML("</TD><TD>")
        CommonFunctions.General.WriteHTML("</TD><TD>")
        CommonFunctions.HTMLControls.DrawOptionButton("optWork", "optWork", , (strWork = WORK_BOTH), WORK_BOTH)
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("BOTH"))
        CommonFunctions.General.WriteHTML("</TD><TD>")
        CommonFunctions.HTMLControls.DrawOptionButton("optWeekDays", "optWeekDays", , (strWeekDays = "7"), "7", , "onclick='WeekDays_OnClick()'")
        CommonFunctions.General.WriteHTML(Replace(MyBase.GetResourceString("DAY_WEEK"), "<=>", "7"))
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")

        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD colspan=2 align=center>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("FROM_DATE"))
        CommonFunctions.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , , strFromDate, , "frmResourceUtilization")
        CommonFunctions.General.WriteHTML("</TD><TD colspan=2 align=center>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("TO_DATE"))
        CommonFunctions.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , strToDate, , "frmResourceUtilization")
        CommonFunctions.General.WriteHTML("</TD></TR>")

        CommonFunctions.General.WriteHTML("</TABLE>")

        CommonFunctions.General.WriteHTML("</DIV>")


        'Added By NitinVS on 4 July 2007 for WhizibleSEM 7 
        ' To show the disclaimer
        'Dim strBaseResourceName As String = MyBase.ResourceName
        'Dim strBaseResourceAssemblyName As String = MyBase.ResourceAssemblyName
        MyBase.InitializeResources("Resources.StandardMessages", "Resources")
        m_strReportDisclaimer = MyBase.GetResourceString("REPORT_DISCLAIMER") + ""
        'Reset the resources.
        'MyBase.InitializeResources(strBaseResourceName, strBaseResourceAssemblyName)
        Response.Write(m_strReportDisclaimer)
        'End Addition By NitinVS on 4 July 2007 for WhizibleSEM 7 
        'Display the Menu at bottom
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)
    End Sub

    Public Sub New()
        ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016
        MyBase.InitializeResources("AppResources.PM_ResourceUtilization", "AppResources")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub


    'Private Function DisplayPageMenu() As String
    '    Dim strMenu As String = ""
    '    Dim arrMenuItem(1) As String
    '    Dim arrMenuTooltip(1) As String
    '    Dim arrClientSideFunctions(1) As String
    '    Dim objMenu As New WebPages.Template.StaticMenu

    '    MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

    '    arrMenuItem(0) = MyBase.GetResourceString("MENU_VIEW_REPORT")
    '    arrMenuTooltip(0) = MyBase.GetResourceString("MENU_VIEW_REPORT_TOOLTIP")
    '    arrClientSideFunctions(0) = "ViewReport_OnClick()"

    '    m_lngMasterTagId = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("MasterTagID"), "0"), Long)
    '    arrMenuItem(1) = MyBase.GetResourceString("MENU_HELP")
    '    arrMenuTooltip(1) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
    '    arrClientSideFunctions(1) = "Help_OnClick(" & m_lngMasterTagId.ToString() & ")"

    '    MyBase.InitializeResources("AppResources.PM_ResourceUtilization", "AppResources")

    '    strMenu = objMenu.DrawMenuWithEvents(arrMenuItem, arrClientSideFunctions, arrMenuTooltip, True)
    '    Return strMenu
    'End Function

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
        Dim strGroupingBy As String
        Dim intWorkType As Integer
        Dim lngReportID As Long
        Dim objMenu As New WebPages.Template.StaticMenu
        Dim intUBound As Integer

        ' get the submitted values
        strGroupingBy = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("optByWhat"))
        If UCase(Trim(strGroupingBy & "")) = "PROJECT" Or UCase(Trim(strGroupingBy & "")) = "" Then
            lngReportID = RES_UTILIZATION_BY_PROJECT
        Else
            lngReportID = RES_UTILIZATION_BY_RESOURCE
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
        Dim strFromDate As String
        Dim strToDate As String
        Dim strWeekDays As String
        Dim lngProjectID As Long
        Dim lngEmployeeID As Long
        Dim strWork As String
        Dim strGroupingBy As String
        Dim intWorkType As Integer

        ' get the submitted values
        strGroupingBy = Request.Form("optByWhat").ToString
        strFromDate = Request.Form("txtFromDate").ToString
        strToDate = Request.Form("txtToDate").ToString
        strWeekDays = Request.Form("optWeekDays").ToString
        If Trim(Request.Form("cboProject").ToString & "") <> "" Then
            lngProjectID = CType(Request("cboProject"), Long)
        Else
            lngProjectID = 0
        End If
        If Trim(Request.Form("cboEmployee").ToString & "") <> "" Then
            lngEmployeeID = CType(Request.Form("cboEmployee"), Long)
        Else
            lngEmployeeID = 0
        End If

        ' get the work type
        strWork = Request.Form("optWork")
        Select Case UCase(Trim(strWork & ""))
            Case "BOTH" : intWorkType = 0
            Case "BILLABLE" : intWorkType = 1
            Case "NONBILLABLE" : intWorkType = 2
            Case Else : intWorkType = 0
        End Select

        ' we need pdf only
        strFormat = Request.QueryString("format").ToString


        ' SELECT THE APT SOURCE 
        If lngProjectID = 0 And lngEmployeeID = 0 Then
            ' based on the selected option(Project/Employee) call the report
            If UCase(Trim(strGroupingBy & "")) = "PROJECT" Then
                strSQL = "EXEC usp_ProjectEmployeeUtilization '" & strFromDate & "','" & strToDate & "'," & strWeekDays & "," & intWorkType & "," & Session("intUserID").ToString & ",1"
                lngReportID = RES_UTILIZATION_BY_PROJECT
            Else
                strSQL = "EXEC usp_ProjectEmployeeUtilization '" & strFromDate & "','" & strToDate & "'," & strWeekDays & "," & intWorkType & "," & Session("intUserID").ToString & ",2"
                lngReportID = RES_UTILIZATION_BY_RESOURCE
            End If
        ElseIf lngProjectID <> 0 Then
            ' report for a specific project
            strSQL = "EXEC usp_ProjectEmployeeUtilization '" & strFromDate & "','" & strToDate & "'," & strWeekDays & "," & intWorkType & "," & Session("intUserID").ToString & ",1" & "," & lngProjectID
            lngReportID = RES_UTILIZATION_BY_PROJECT
        Else
            ' report for a specific resource
            strSQL = "EXEC usp_ProjectEmployeeUtilization '" & strFromDate & "','" & strToDate & "'," & strWeekDays & "," & intWorkType & "," & Session("intUserID").ToString & ",2" & ",NULL," & lngEmployeeID
            lngReportID = RES_UTILIZATION_BY_RESOURCE
        End If

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


#Region "events"

    Private Sub oRpt_Section_BeforePrint(ByVal sender As Object, ByVal e As System.EventArgs, ByVal Report As DataDynamics.ActiveReports.ActiveReport) Handles oRpt.Section_BeforePrint
        Dim section As DataDynamics.ActiveReports.Section
        Dim i As Integer
        Static blnLinePrinted As Boolean = False
        Static intPageNumber As Integer = 0
        section = CType(sender, DataDynamics.ActiveReports.Section)

        ' for each page reset the flag
        If Report.PageNumber <> intPageNumber Then blnLinePrinted = False

        ' for page footer section remove the unwanted lines
        If UCase(Trim(section.Name & "")) = "PAGEFOOTER" Then
            For i = 0 To section.Controls.Count - 1
                If UCase(Trim(section.Controls(i).GetType.ToString & "")) = "DATADYNAMICS.ACTIVEREPORTS.LINE" Then
                    If Not blnLinePrinted Then
                        section.Controls(i).Visible = True
                    Else
                        section.Controls(i).Visible = False
                    End If
                    blnLinePrinted = True
                End If
            Next
        End If
    End Sub
#End Region

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Added by MahendraV On 10:37 AM 5/24/2007 for List of Reports modified for HTML Report Issue
        'Start_MV_5/24/2007
        If UCase(Trim(Request.QueryString("Format") & "")) = "HTML" Then

            If Not CommonFunctions.General.GetApplicationKeySetting("WAF_OpenReportsInSecurePage") Is Nothing Then
                If CType(CommonFunctions.General.GetApplicationKeySetting("WAF_OpenReportsInSecurePage"), Boolean) Then

                    m_intOpenReportInSecurePage = 1

                End If

            End If

        End If
        'End_MV_5/24/2007
    End Sub
End Class
