Public Class TCM_ShowReport
    Inherits WebPages.Template.WhizTemplate

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
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Protected intTestSessionID As Integer
    Protected intMasterTagID As Integer
    Private strMode As String
    Protected intReportID As Integer
    Protected m_strTestSession As String
    Protected m_strTestSet As String
    Protected m_strTestResult As String
    Protected m_strTestSet_TS As String
    Protected m_strTestRevision_TS As String
    'Added By VarunA on 24-July-2007 Whizible 7.0 Development & Release
    Protected m_strTestSessionStatus As String
    Protected m_strTestSessionType As String
    'End By VarunA on 24-July-2007

    Private WithEvents oRpt As AdHocReports.Report.AdHocReport
    Protected m_intShowMessage As Integer = 0
    Protected m_strFileName As String
    Protected strFormat As String
    Protected strType As String

    ' Added BY NitinVS on 4 July 2007 for WhizbleSEM 7 
    'Declare in the class level declaration.
    Protected m_strReportDisclaimer As String = ""
    'End addition NitinVS on 4 July 2007 for WhizbleSEM 7 
    'Added By VarunA on 19-July-2007 For Whizible 7.0 Development & Release
    'Purpose : To persist the value of checkbox
    Dim blnNegativeChk As Boolean = False
    Dim intNegativeChk As Integer
    Dim blnPositiveChk As Boolean = False
    Dim intPositiveChk As Integer
    'End by VarunA on 19-July-2007
    'Added By VarunA on 24-July-2007 For Whizible 7.0 Development & Release
    'Purpose : To persist the value of checkbox
    Dim blnOpenSessionChk As Boolean = False
    Dim intOpenSessionChk As Integer
    Dim blnClosedSessionChk As Boolean = False
    Dim intClosedSessionChk As Integer
    Dim strTestSessionSummary As String = ""
    Dim blnOpenSessionDisable As Boolean = False
    Dim blnCloseSessionDisable As Boolean = False
    'End by VarunA on 24-July-2007

    ''Added by NitinC on 15 September 2011 For WhizibleSEM 10.0 [Agile Methodology]
    Protected m_strUserStoryID As String
    ''End of Added by NitinC on 15 September 2011 For WhizibleSEM 10.0 [Agile Methodology]


    Protected Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        '' Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.ApplySecurity(True)
        ''End Of Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection

        '==============================================================================================
        'Page added By ShraddhaM on 4,June 2007
        
        'Purpose : To Display Show Report UI Page in Test Session Page from Project Module
        '==============================================================================================

        'Added by VarunA on 19-July-2007 For Whizible 7.0 Development & Release
        'Purpose : To persist the value of checkbox
        intNegativeChk = CType(HttpContext.Current.Request.Form("chkAllNegativeResponse"), Integer)
        intPositiveChk = CType(HttpContext.Current.Request.Form("chkAllPositiveResponse"), Integer)
        If intNegativeChk = 2 Then
            blnNegativeChk = True
        End If
        If intPositiveChk = 1 Then
            blnPositiveChk = True
        End If
        'End By VarunA on 19-July-2007

        'Added by VarunA on 24-July-2007 For Whizible 7.0 Development & Release
        'Purpose : To persist the value of checkbox
        intOpenSessionChk = CType(HttpContext.Current.Request.Form("chkAllOpenSessions"), Integer)
        intClosedSessionChk = CType(HttpContext.Current.Request.Form("chkAllClosedSessions"), Integer)
        strTestSessionSummary = CType(HttpContext.Current.Request.Form("cboTestSession_Summary"), String)
        If intOpenSessionChk = 1 Then
            blnOpenSessionChk = True
        End If
        If intClosedSessionChk = 2 Then
            blnClosedSessionChk = True
        End If
        If strTestSessionSummary <> "" Then
            blnOpenSessionDisable = True
            blnCloseSessionDisable = True
        End If
        'End By VarunA on 24-July-2007
        ''Added  By Shamkant s 31/12/2015
        If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
            Response.Write(vbCrLf + "<script>")
            Response.Write(vbCrLf + "		if (window.opener == null)")
            Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
            If strRedirectToPage.Trim = "" Then
                Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
            Else
                Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
            End If
            Response.Write(vbCrLf + "</script>")
        End If
        'Ended By Shamkant s 31/12/2015
    End Sub
    Protected Sub WritePage()

        intTestSessionID = CType(Request.QueryString("UniqueID"), Integer)
        intMasterTagID = CType(Request.QueryString("MasterTagID"), Integer)
        strMode = Request.QueryString("Mode")
        intReportID = CType(Request.QueryString("ReportID"), Integer)
        strFormat = Request.QueryString("Format")
        strType = Request.QueryString("Type")
        'Added by AbhijeetC 0n 25 th June  2007
        If (intMasterTagID = 0) Then
            intMasterTagID = 3654
        End If
        'End of addition by AbhijeetC on 25 th June 2007

        If strType Is Nothing Then
            strType = "1"
        End If


        If strMode = "VIEW" Then
            ShowReport()
            'Addition by SuchitraP on 8-Jan-2009 for IssueID:26492
            'Purpose:same page was opened in new window.
            If m_intShowMessage = 1 Then
                Exit Sub
            End If
            'End of addition by SuchitraP on 8-Jan-2009 
        End If


        Dim strMenu As String
        'Dim intReportID As Integer

        ''Commented and Added by NitinC on 15 September 2011 For WhizibleSEM 10.0 [Agile Methodology]
       
        'Dim arrMenu() As String = {"PDF", "HTML", "RTF", "EXCEL", "CSV", "TEXT", "XML", "?"}
        'Dim arrMenuToolTip() As String = {"PDF OutPut", "HTML OutPut", "RTF OutPut", "EXCEL OutPut", "CSV OutPut", "TEXT OutPut", "XML OutPut", "Help"}
        'Dim arrCSFunction() As String = {"ViewReport_OnClick('PDF')", "ViewReport_OnClick('HTML')", "ViewReport_OnClick('RTF')", "ViewReport_OnClick('EXCEL')", "ViewReport_OnClick('CSV')", "ViewReport_OnClick('TEXT')", "ViewReport_OnClick('XML')", "Help_OnClick('CRW_HELP_2038')"}
        'strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
        If intMasterTagID = 9023 Or intMasterTagID = 9024 Or intMasterTagID = 9025 Then
            Dim arrMenu() As String = {"PDF", "HTML", "RTF", "EXCEL", "CSV", "TEXT", "XML", "Back", "?"}
            Dim arrMenuToolTip() As String = {"PDF OutPut", "HTML OutPut", "RTF OutPut", "EXCEL OutPut", "CSV OutPut", "TEXT OutPut", "XML OutPut", "Back To Previouse Page", "Help"}
            Dim arrCSFunction() As String = {"ViewReport_OnClick('PDF')", "ViewReport_OnClick('HTML')", "ViewReport_OnClick('RTF')", "ViewReport_OnClick('EXCEL')", "ViewReport_OnClick('CSV')", "ViewReport_OnClick('TEXT')", "ViewReport_OnClick('XML')", "Back_OnClick()", "Help_OnClick('CRW_HELP_2038')"}
            strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
        Else
            Dim arrMenu() As String = {"PDF", "HTML", "RTF", "EXCEL", "CSV", "TEXT", "XML", "?"}
            Dim arrMenuToolTip() As String = {"PDF OutPut", "HTML OutPut", "RTF OutPut", "EXCEL OutPut", "CSV OutPut", "TEXT OutPut", "XML OutPut", "Help"}
            Dim arrCSFunction() As String = {"ViewReport_OnClick('PDF')", "ViewReport_OnClick('HTML')", "ViewReport_OnClick('RTF')", "ViewReport_OnClick('EXCEL')", "ViewReport_OnClick('CSV')", "ViewReport_OnClick('TEXT')", "ViewReport_OnClick('XML')", "Help_OnClick('CRW_HELP_2038')"}
            strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
        End If
        

        ''End of Commented and Added by NitinC on 15 September 2011 For WhizibleSEM 10.0 [Agile Methodology]
        'Top Menu
        Response.Write(strMenu)

        Response.Write("<div id=divList style='overflow:auto'>")

        If intMasterTagID = 3654 Then
            ShowSessionReport()
        ElseIf intMasterTagID = 3664 Then
            WriteReport_ForTestSet()
        ElseIf intMasterTagID = 3824 Then
            WriteReport_ForTestCasesDetails()
        ElseIf intMasterTagID = 3823 Then
            WriteReport_ForTestSet()
        ElseIf intMasterTagID = 3822 Then
            WriteReport_ForTestSessionDetails()
            ''Added by NitinC on 15 September 2011 For WhizibleSEM 10.0 [Agile Methodology]
        ElseIf intMasterTagID = 9023 Then
            WriteReport_ForUserStoryTestCasesDetails()
        ElseIf intMasterTagID = 9024 Then
            WriteReport_ForUserStoryTestSet()
        ElseIf intMasterTagID = 9025 Then
            WriteReport_ForUserStoryTestSessionDetails()
        End If
        ''End of Added by NitinC on 15 September 2011 For WhizibleSEM 10.0 [Agile Methodology]

        'Added By NitinVS on 4 July 2007 for WhizibleSEM 7 
        ' To show the disclaimer
        'Dim strBaseResourceName As String = MyBase.ResourceName
        'Dim strBaseResourceAssemblyName As String = MyBase.ResourceAssemblyName
        MyBase.InitializeResources("Resources.StandardMessages", "Resources")
        m_strReportDisclaimer = MyBase.GetResourceString("REPORT_DISCLAIMER") + ""
        'Reset the resources.
        'MyBase.InitializeResources(strBaseResourceName, strBaseResourceAssemblyName)
        Response.Write(m_strReportDisclaimer)
        Response.Write("<br>")
        'End Addition By NitinVS on 4 July 2007 for WhizibleSEM 7 

        Response.Write(strMenu)


    End Sub
    'Added by abhijeetc on 21 June 2007
    Protected Sub ShowSessionReport()
        Dim strSQL As String
        ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
        ''strSQL = " SELECT TestSessionId,Title FROM tbl_TCM_TestSession WHERE ProjectID = " & CType(Session("intProjectID"), String) & " AND TestSessionID = " & intTestSessionID & " Order By Title"
        strSQL = "usp_sel_tbl_TCM_TestSession_TestSessionId " & CType(Session("intProjectID"), String) & "," & intTestSessionID

        With Response

            .Write("<TABLE class=clsTable width ='99.9%'><TR class = clsTRPageCaption><TD>Test Session Details</TD></TR></TABLE>")
            .Write("<BR>")

            .Write("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0 align = center>" & vbCrLf)
            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> Test Session </TD>")
            .Write("<TD align = left>")
            CommonFunctions.HTMLControls.DrawComboBox("cboTestSession2", strSQL)
            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven align = center>")
            .Write("<TD align = Right> Summary/Details </TD>")
            .Write("<TD align = left>")
            CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", "usp_sel_TCMReport_Type", , strType, InsertBlankRow:=True)
            .Write("</TD")
            .Write("</TR>")
            .Write("</Table>")
            .Write("</Div>")

        End With

    End Sub
    'End of Addition By AbhijeetC On 21 June 2007

    'Added by AbhijeetC on 19 June 2007
    Protected Sub WriteReport_ForTestSessionDetails()
        Dim strSession As String
        Dim strStatus As String
        Dim strSessionType As String
        ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
        ''strSession = " SELECT TestSessionId,Title FROM tbl_TCM_TestSession WHERE ProjectID = " & CType(Session("intProjectID"), String)
        strSession = "usp_sel_tbl_TCM_TestSession_Title " & CType(Session("intProjectID"), String)

        ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
        ''strStatus = " SELECT TestStatusID,TestStatus FROM tbl_TCM_TestStatus ORDER BY TestStatus "
        strStatus = "usp_sel_tbl_TCM_TestStatus_TestStatusID"

        'Commented By VarunA on 25-July-2007 Whizible 7.0 Development & Release
        'Pupose : To have those session Type depending on test session
        'strSessionType = " SELECT SessionTypeID,SessionType FROM tbl_TCM_SessionTypeMaster WHERE ProjectID=" & CType(Session("intProjectID"), String) & " ORDER BY SessionType"
        'End By VarunA on 25-July-2007

        'Modified By VarunA on 23-July-2007 Whizible 7.0 Development & Release
        'Purpose : To persist the value of combo
        m_strTestSession = CommonFunction.General.CheckIsNothing(Request.Form("cboTestSession_Summary"), "0")
        m_strTestSessionStatus = CommonFunction.General.CheckIsNothing(Request.Form("cboTestSessionStatus"), "0")
        m_strTestSessionType = CommonFunction.General.CheckIsNothing(Request.Form("cboTestSessionType"), "0")
        If m_strTestSession = "" Then
            m_strTestSession = "0"
        End If
        ''Added by NitinC on 15 September 2011 For WhizibleSEM 10.0 [Agile Methodology]
        m_strUserStoryID = CommonFunction.General.CheckIsNothing(Request.Form("cboUserStory"), "0")
        If m_strUserStoryID = "" Then
            m_strUserStoryID = "0"
        End If
        ''End of Added by NitinC on 15 September 2011 For WhizibleSEM 10.0 [Agile Methodology]

        'End By VarunA on 23-July-2007

        With Response

            .Write("<TABLE class=clsTable width ='99.9%'><TR class = clsTRPageCaption><TD>Test Session Details</TD></TR></TABLE>")
            .Write("<BR>")

            .Write("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0 align = center>" & vbCrLf)

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> Test Session </TD>")
            .Write("<TD align = left>")
            'Modified By VarunA on 23-July-2007 Whizible 7.0 Development & Release
            'Purpose : To persist the value of combo
            'CommonFunctions.HTMLControls.DrawComboBox("cboTestSession_Summary", strSession, ComboWidthInPixel:=200,InsertBlankRow:=True)
            CommonFunctions.HTMLControls.DrawComboBox("cboTestSession_Summary", strSession, ComboWidthInPixel:=200, matchfieldID:=m_strTestSession, TobeInserted:="OnChange=Filter_Session_change(" & intReportID & "," & intMasterTagID & ")", InsertBlankRow:=True)
            'End By VarunA on 23-July-2007
            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> All Open Sessions </TD>")
            .Write("<TD align = left>")
            'Added by VarunA on 24-July-2007 For Whizible 7.0 Development & Release
            'Purpose : To persist the value of checkbox
            'CommonFunctions.HTMLControls.DrawCheckBox("chkAllOpenSessions", "chkAllOpenSessions", value:="1", ToBeInserted:="onclick='OpenSessionCheckBox_OnClick()'")
            CommonFunctions.HTMLControls.DrawCheckBox("chkAllOpenSessions", "chkAllOpenSessions", , blnOpenSessionChk, value:="1", IsDisabled:=blnOpenSessionDisable, ToBeInserted:="onclick='OpenSessionCheckBox_OnClick()'")
            'End By VarunA on 24-July-2007
            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> All Closed Sessions </TD>")
            .Write("<TD align = left>")
            'Added by VarunA on 24-July-2007 For Whizible 7.0 Development & Release
            'Purpose : To persist the value of checkbox
            'CommonFunctions.HTMLControls.DrawCheckBox("chkAllClosedSessions", "chkAllClosedSessions", value:="2", ToBeInserted:="onclick='ClosedSessionCheckBox_OnClick()'")
            CommonFunctions.HTMLControls.DrawCheckBox("chkAllClosedSessions", "chkAllClosedSessions", , blnClosedSessionChk, value:="2", IsDisabled:=blnCloseSessionDisable, ToBeInserted:="onclick='ClosedSessionCheckBox_OnClick()'")
            'End By VarunA on 24-July-2007
            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> Test Session Status </TD>")
            .Write("<TD align = left>")
            'Modified By VarunA on 24-July-2007 Whizible 7.0 Development & Release
            'Purpose : To persist the value of combo
            'CommonFunctions.HTMLControls.DrawComboBox("cboTestSessionStatus", strStatus, ComboWidthInPixel:=200, InsertBlankRow:=True)
            CommonFunctions.HTMLControls.DrawComboBox("cboTestSessionStatus", strStatus, ComboWidthInPixel:=200, matchfieldID:=m_strTestSessionStatus, InsertBlankRow:=True)
            'End By VarunA on 24-July-2007
            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> Test Session Type </TD>")
            .Write("<TD align = left>")
            'Modified By VarunA on 24-July-2007 Whizible 7.0 Development & Release
            'Purpose : To persist the value of combo
            'CommonFunctions.HTMLControls.DrawComboBox("cboTestSessionType", strSessionType, ComboWidthInPixel:=200, InsertBlankRow:=True)
            CommonFunctions.HTMLControls.DrawComboBox("cboTestSessionType", "usp_sel_RPT_TCM_FillTestSessionType " + CType(Session("intProjectID"), String) + "," + m_strTestSession, ComboWidthInPixel:=200, matchfieldID:=m_strTestSessionType, InsertBlankRow:=True)
            'End By VarunA on 24-July-2007
            .Write("</TD>")
            .Write("</TR>")

            .Write("</Table>")
            .Write("</Div>")
        End With



    End Sub
    Protected Sub WriteReport_ForTestCasesDetails()
        Dim strSession As String
        Dim strTestSet As String
        Dim strResult As String
        Dim flag As Boolean


        
        m_strTestSession = CommonFunction.General.CheckIsNothing(Request.Form("cboTestSession_TestCases"), "0")

        m_strTestSet = CommonFunction.General.CheckIsNothing(Request.Form("cboTestSet_TestCases"), "0")

        m_strTestResult = CommonFunction.General.CheckIsNothing(Request.Form("cboTestCaseResult"), "0")

        ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
        ''strResult = "SELECT TestResultID,TestResult FROM tbl_tcM_TestResultMaster ORDER BY TestResult"
        strResult = "usp_sel_tbl_tcM_TestResultMaster_TestResultID"

        'Added By VarunA on 25-July-2007 Whizible 7.0 Development & Release
        'Purpose : To have those test set which depend on test session
        If m_strTestSession = "" Then
            m_strTestSession = "0"
        End If
        'End By VarunA on 25-July-2007

        If (m_strTestResult = "NULL" Or m_strTestResult = "0" Or m_strTestResult = "") Then
            flag = False
        Else
            flag = True

        End If

        With Response

            .Write("<TABLE class=clsTable width ='99.9%'><TR class = clsTRPageCaption><TD>Test Case Details Report</TD></TR></TABLE>")
            .Write("<BR>")

            .Write("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0 align = center>" & vbCrLf)

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> Test Session </TD>")
            .Write("<TD align = left>")


            CommonFunctions.HTMLControls.DrawComboBox("cboTestSession_TestCases", "usp_sel_RPT_TCM_FillTestSessionCombo " + CType(Session("intProjectID"), String), ComboWidthInPixel:=200, matchfieldID:=m_strTestSession, IsMandatory:=True, TobeInserted:="OnChange=Filter_change(" & intReportID & "," & intMasterTagID & ")", InsertBlankRow:=True)
            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> Test Set </TD>")
            .Write("<TD align = left>")
            CommonFunction.HTMLControls.DrawComboBox("cboTestSet_TestCases", "usp_sel_RPT_TCM_FillTestSetCombo " + m_strTestSession, 200, m_strTestSet, InsertBlankRow:=True)
            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> Test Case Result </TD>")
            .Write("<TD align = left>")
            CommonFunctions.HTMLControls.DrawComboBox("cboTestCaseResult", strResult, ComboWidthInPixel:=200, MatchfieldID:=m_strTestResult, TobeInserted:="OnChange=Enable_Disable_CheckBox()", InsertBlankRow:=True)
            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> All Negative Response </TD>")
            .Write("<TD align = left>")
            'Modified By VarunA on 19-July-2007 For Whizible 7.0 Development & Release
            'CommonFunctions.HTMLControls.DrawCheckBox("chkAllNegativeResponse", "chkAllNegativeResponse", value:="2", Isdisabled:=flag, ToBeInserted:="onclick='NegativeResponseCheckBox_OnClick()'")
            CommonFunctions.HTMLControls.DrawCheckBox("chkAllNegativeResponse", "chkAllNegativeResponse", , blnNegativeChk, value:="2", Isdisabled:=flag, ToBeInserted:="onclick='NegativeResponseCheckBox_OnClick()'")
            'End By VarunA on 19-July-2007
            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> All Positive Response </TD>")
            .Write("<TD align = left>")
            'Modified by VarunA on 19-July-2007 For Whizible 7.0 Development & Release
            'CommonFunctions.HTMLControls.DrawCheckBox("chkAllPositiveResponse", "chkAllPositiveResponse", value:="1", Isdisabled:=flag, ToBeInserted:="onclick='PositiveResponseCheckBox_OnClick()'")
            CommonFunctions.HTMLControls.DrawCheckBox("chkAllPositiveResponse", "chkAllPositiveResponse", , blnPositiveChk, value:="1", Isdisabled:=flag, ToBeInserted:="onclick='PositiveResponseCheckBox_OnClick()'")
            'End by VarunA on 19-July-2007
            .Write("</TD>")
            .Write("</TR>")
            .Write("</Table>")
            .Write("</Div>")


        End With
        

    End Sub

    'End of Addition by AbhijeetC on 19 June 2007

    'Added by AbhijeetC on 22 June 2007

    Protected Sub WriteReport_ForTestSet()
        Dim strTestSet As String
        Dim strRevision As String

        m_strTestSet_TS = CommonFunction.General.CheckIsNothing(Request.Form("cboTestSet_TS"), "0")
        m_strTestRevision_TS = CommonFunction.General.CheckIsNothing(Request.Form("cboTestRevision_TS"), "0")

        'm_strTestRevision_TS = CType(CommonFunction.General.CheckIsNothing(Request.Form("cboTestRevision_TS"), "NULL"), String)
        
        ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
        ''strTestSet = "SELECT ProjectTestSetID,TestSetName FROM tbl_TCM_ProjectTestSet where projectID= " & CType(Session("intProjectID"), String)
        strTestSet = "usp_sel_tbl_TCM_ProjectTestSet_TestSetName " & CType(Session("intProjectID"), String)

        ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
        ''strRevision = "SELECT RevisionNo FROM tbl_TCM_ProjectTestSet_Published where CorporateTestSetID=" & m_strTestSet_TS
        strRevision = "usp_sel_tbl_TCM_ProjectTestSet_Published_RevisionNo " & m_strTestSet_TS

        With Response

            .Write("<TABLE class=clsTable width ='99.9%'><TR class = clsTRPageCaption><TD>Test Set Report</TD></TR></TABLE>")
            .Write("<BR>")

            .Write("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0 align = center>" & vbCrLf)

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> Test Set </TD>")
            .Write("<TD align = left>")
            CommonFunctions.HTMLControls.DrawComboBox("cboTestSet_TS", strTestSet, ComboWidthInPixel:=200, MatchFieldID:=m_strTestSet_TS, Ismandatory:=True, TobeInserted:="OnChange=Filter_change(" & intReportID & "," & intMasterTagID & ")", InsertBlankRow:=True)
            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> Test Revision </TD>")
            .Write("<TD align = left>")
            'Modified By VarunA on 27-July-2007 Whizible 7.0 Development & Release
            'Purpose : When no test set is selected then no revision should be shown.
            'CommonFunctions.HTMLControls.DrawComboBox("cboTestRevision_TS", strRevision, ComboWidthInPixel:=200, MatchFieldID:=m_strTestRevision_TS, InsertBlankRow:=True)
            If m_strTestSet_TS <> "" Then
                CommonFunctions.HTMLControls.DrawComboBox("cboTestRevision_TS", strRevision, ComboWidthInPixel:=200, MatchFieldID:=m_strTestRevision_TS, InsertBlankRow:=True)
            Else
                CommonFunctions.HTMLControls.DrawComboBox("cboTestRevision_TS", "SELECT '',''", ComboWidthInPixel:=200, MatchFieldID:=m_strTestRevision_TS, InsertBlankRow:=True)
            End If
            'End By VarunA on 27-July-2007
            .Write("</TD>")
            .Write("</TR>")

            .Write("</Table>")
            .Write("</Div>")


        End With
    End Sub

    'End of Addition by AbhijeetC on 22 June 2007

    Private Sub ShowReport()
        Dim strFilePath As String
        Dim strQuery As String
        Dim dr As IDataReader
        'Added by AbhijeetC 0n 26 June 2007

        If intReportID = 2084 Then
            strQuery = InitializeSQLForTestSetReport()
        ElseIf intReportID = 2083 Then
            strQuery = InitializeSQLForSummaryReport()
        ElseIf intReportID = 2086 Then
            strQuery = InitializeSQLForTestCaseReport()
        End If



        'End of addition by AbhijeetC on 26 June 2007

        If intReportID = 2038 Then 'Without Test Case Details
            strQuery = " usp_RPT_TestSession_Details " + CType(intTestSessionID, String)
        End If
        If intReportID = 2057 Then 'With Test Case Details
            strQuery = " usp_RPT_TestSession_Details_ForTestCaseDetails " + CType(intTestSessionID, String)
        End If

        dr = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
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
            oRpt = New AdHocReports.Report.AdHocReport(intReportID, strQuery, CommonFunctions.Application.ConnectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Attachments/Log/")))
            With oRpt
                .UseMSSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
                .DefaultLCID = CType(MyBase.DefaultUILCID, Integer)
                .LCID = MyBase.CurrentThreadUICultureID
                'If CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCRW").Trim.ToUpper = "Y" Then
                .UseHashTables = True
                'Else
                '    .UseHashTables = False
                'End If
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
            m_intShowMessage = 1
        End If


        CommonFunctions.Data.DisposeDataReader(dr)
    End Sub

    Private Function InitializeSQLForTestSetReport() As String
        Dim strTestSet As String
        Dim strTestSetRevision As String
        Dim strTestSetUserStory As String
        Dim strQuery As String

        strTestSet = CType(CommonFunction.General.CheckIsNothing(Request.Form("cboTestSet_TS"), "NULL"), String)
        strTestSetRevision = CType(CommonFunction.General.CheckIsNothing(Request.Form("cboTestRevision_TS"), "NULL"), String)
        'Added By Rutuja D on 23 Dec 2021 For Report Header Missing
        strTestSetUserStory = CType(CommonFunction.General.CheckIsNothing(Request.Form("cboUserStory"), "NULL"), String)
        'End of Added By Rutuja D on 23 Dec 2021 For Report Header Missing

        If strTestSet = "" Then
            strTestSet = "NULL"
        End If
        If strTestSetRevision = "" Then
            strTestSetRevision = "NULL"
        End If

        'Commented & Added By Rutuja D on 23 Dec 2021 For Report Header Missing
        'strQuery = "usp_RPT_TCM_TestSetReport " + strTestSet + "," + strTestSetRevision
        strQuery = "usp_RPT_TCM_TestSetReport " + strTestSet + "," + strTestSetRevision + "," + strTestSetUserStory
        'End of Commented & Added By Rutuja D on 23 Dec 2021 For Report Header Missing

        InitializeSQLForTestSetReport = strQuery
    End Function

    Private Function InitializeSQLForTestCaseReport() As String
        Dim strNegativeResponse As String
        Dim strPositiveResponse As String

        Dim strTestSession As String
        Dim strTestSet As String
        Dim strTestCaseResult As String
        Dim strPassFailStatus As String
        Dim strQuery As String

        strTestSession = CType(CommonFunction.General.CheckIsNothing(Request.Form("cboTestSession_TestCases"), "NULL"), String)

        strTestSet = CType(CommonFunction.General.CheckIsNothing(Request.Form("cboTestSet_TestCases"), "NULL"), String)
        strTestCaseResult = CType(CommonFunction.General.CheckIsNothing(Request.Form("cboTestCaseResult"), "NULL"), String)

        strNegativeResponse = CType(CommonFunction.General.CheckIsNothing(Request.Form("chkAllNegativeResponse"), "NULL"), String)
        strPositiveResponse = CType(CommonFunction.General.CheckIsNothing(Request.Form("chkAllPositiveResponse"), "NULL"), String)

        If strTestSession = "" Then
            strTestSession = "NULL"
        End If
        If strTestSet = "" Then
            strTestSet = "NULL"
        End If
        If strTestCaseResult = "" Then
            strTestCaseResult = "NULL"
        End If
        If strNegativeResponse = "" Then
            strNegativeResponse = "NULL"
        End If
        If strPositiveResponse = "" Then
            strPositiveResponse = "NULL"
        End If

        If strNegativeResponse = "NULL" And strPositiveResponse = "NULL" Then
            strPassFailStatus = "NULL"
        ElseIf strNegativeResponse = "NULL" Then
            strPassFailStatus = strPositiveResponse
        ElseIf strPositiveResponse = "NULL" Then
            strPassFailStatus = strNegativeResponse

        End If

        strQuery = "usp_CRW_TCM_TestCaseDetailsReport " + CType(Session("intProjectID"), String) + "," _
                        + strTestSession & "," + strTestSet + "," + strPassFailStatus + "," + strTestCaseResult

        InitializeSQLForTestCaseReport = strQuery
    End Function
    Private Function InitializeSQLForSummaryReport() As String
        'Added By VarunA on 25-July-2007 Whizible 7.0 Development & Release
        'Purpose : To have the value of checkbox
        Dim strAllOpenCloseSessions As String = "NULL"
        Dim intOpenSessionChk As Integer
        Dim intClosedSessionChk As Integer
        'End By VarunA on 25-July-2007

        Dim strTestSession As String
        Dim strTestSessionStatus As String
        Dim strTestSessionType As String
        Dim strResult As String
        Dim strQuery As String

        strTestSession = CType(CommonFunction.General.CheckIsNothing(Request.Form("cboTestSession_Summary"), "NULL"), String)

        strTestSessionStatus = CType(CommonFunction.General.CheckIsNothing(Request.Form("cboTestSessionStatus"), "NULL"), String)
        strTestSessionType = CType(CommonFunction.General.CheckIsNothing(Request.Form("cboTestSessionType"), "NULL"), String)

        'Modified By VarunA on 25-July-2007 Whizible 7.0 Development & Release
        'Purpose : To have the value of checkbox
        'strAllOpenSessions = CType(CommonFunction.General.CheckIsNothing(Request.Form("chkAllOpenSessions"), "NULL"), String)
        intOpenSessionChk = CType(HttpContext.Current.Request.Form("chkAllOpenSessions"), Integer)
        'strAllCloseSessions = CType(CommonFunction.General.CheckIsNothing(Request.Form("chkAllClosedSessions"), "NULL"), String)
        intClosedSessionChk = CType(HttpContext.Current.Request.Form("chkAllClosedSessions"), Integer)
        'End By VarunA on 25-July-2007



        If strTestSession = "" Then
            strTestSession = "NULL"
        End If
        If strTestSessionStatus = "" Then
            strTestSessionStatus = "NULL"
        End If
        If strTestSessionType = "" Then
            strTestSessionType = "NULL"
        End If

        'Modified By VarunA on 25-July-2007 Whizible 7.0 Development & Release
        'Purpose : To have the correct value of session
        'If strAllOpenSessions = "" Then
        '    strAllOpenSessions = "NULL"
        'End If
        'If strAllCloseSessions = "" Then
        '    strAllCloseSessions = "NULL"
        'End If
        If intOpenSessionChk = 1 Then
            strAllOpenCloseSessions = "0"
        End If
        If intClosedSessionChk = 2 Then
            strAllOpenCloseSessions = "1"
        End If
        'End By VarunA on 25-July-2007 

        'Added By Usha Pandit On 09.07.2020 For getting User Story Id
        m_strUserStoryID = CommonFunction.General.CheckIsNothing(Request.Form("cboUserStory"), "0")
        'End Of Added By Usha Pandit On 09.07.2020 For getting User Story Id

        strQuery = "usp_CRW_TCM_TestSessionSummaryReport " + CType(Session("intProjectID"), String) + "," + strTestSession & ","
        'Modified By VarunA on 25-July-2007 Whizible 7.0 Development & Release
        'strQuery += "NULL," + strTestSessionStatus + "," + strTestSessionType
        strQuery += strAllOpenCloseSessions + "," + strTestSessionStatus + "," + strTestSessionType
        'End By VarunA on 25-July-2007 
        'Added By Usha Pandit On 09.07.2020 For getting User Story Id
        If m_strUserStoryID = "" Or m_strUserStoryID = "0" Or m_strUserStoryID = Nothing Then

        Else
            strQuery += "," + m_strUserStoryID
        End If
        'End Of Added By Usha Pandit On 09.07.2020 For getting User Story Id

        InitializeSQLForSummaryReport = strQuery
    End Function

    ''Added by NitinC on 15 September 2011 For WhizibleSEM 10.0 [Agile Methodology]

    Protected Sub WriteReport_ForUserStoryTestCasesDetails()
        Dim strSession As String
        Dim strTestSet As String
        Dim strResult As String
        Dim flag As Boolean



        m_strTestSession = CommonFunction.General.CheckIsNothing(Request.Form("cboTestSession_TestCases"), "0")

        m_strTestSet = CommonFunction.General.CheckIsNothing(Request.Form("cboTestSet_TestCases"), "0")

        m_strTestResult = CommonFunction.General.CheckIsNothing(Request.Form("cboTestCaseResult"), "0")

        m_strUserStoryID = CommonFunction.General.CheckIsNothing(Request.Form("cboUserStory"), "0")

        ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
        ''strResult = "SELECT TestResultID,TestResult FROM tbl_tcM_TestResultMaster ORDER BY TestResult"
        strResult = "usp_sel_tbl_tcM_TestResultMaster_TestResultID"


        'Added By VarunA on 25-July-2007 Whizible 7.0 Development & Release
        'Purpose : To have those test set which depend on test session
        If m_strTestSession = "" Then
            m_strTestSession = "0"
        End If
        'End By VarunA on 25-July-2007
        'Added by NitinC on 10 Jan 2011 for WhizibleSEM 11.0 -Agile Module (Issue Fix :58421)
        If m_strUserStoryID = "" Then
            m_strUserStoryID = "0"
        End If
        'End of Added by NitinC on 10 Jan 2011 for WhizibleSEM 11.0 -Agile Module (Issue Fix :58421)
        If (m_strTestResult = "NULL" Or m_strTestResult = "0" Or m_strTestResult = "") Then
            flag = False
        Else
            flag = True

        End If

        With Response

            .Write("<TABLE class=clsTable width ='99.9%'><TR class = clsTRPageCaption><TD>Test Case Details Report</TD></TR></TABLE>")
            .Write("<BR>")

            .Write("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0 align = center>" & vbCrLf)

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> User Story </TD>")
            .Write("<TD align = left>")
            ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
            ''CommonFunctions.HTMLControls.DrawComboBox("cboUserStory", "SELECT UserStoryID,UserStoryName FROM d_tbl_PM_ScrumUserStory WITH(NOLOCK) where IterationID is not null AND ProjectId = " + CType(Session("intProjectID"), String), ComboWidthInPixel:=200, MatchFieldID:=m_strUserStoryID, IsMandatory:=True, ToBeInserted:="OnChange=Filter_change(" & intReportID & "," & intMasterTagID & ")", InsertBlankRow:=True)
            CommonFunctions.HTMLControls.DrawComboBox("cboUserStory", "usp_sel_d_tbl_PM_ScrumUserStory_UserStoryID " + CType(Session("intProjectID"), String), ComboWidthInPixel:=200, MatchFieldID:=m_strUserStoryID, IsMandatory:=True, ToBeInserted:="OnChange=Filter_change(" & intReportID & "," & intMasterTagID & ")", InsertBlankRow:=True)
            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> Test Session </TD>")
            .Write("<TD align = left>")


            CommonFunctions.HTMLControls.DrawComboBox("cboTestSession_TestCases", "usp_sel_RPT_TCM_Scrum_FillTestSessionCombo " + CType(Session("intProjectID"), String) + "," + m_strUserStoryID, ComboWidthInPixel:=200, MatchFieldID:=m_strTestSession, IsMandatory:=True, ToBeInserted:="OnChange=Filter_change(" & intReportID & "," & intMasterTagID & ")", InsertBlankRow:=True)
            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> Test Set </TD>")
            .Write("<TD align = left>")
            CommonFunction.HTMLControls.DrawComboBox("cboTestSet_TestCases", "usp_sel_RPT_TCM_FillTestSetCombo " + m_strTestSession, 200, m_strTestSet, InsertBlankRow:=True)
            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> Test Case Result </TD>")
            .Write("<TD align = left>")
            CommonFunctions.HTMLControls.DrawComboBox("cboTestCaseResult", strResult, ComboWidthInPixel:=200, MatchFieldID:=m_strTestResult, ToBeInserted:="OnChange=Enable_Disable_CheckBox()", InsertBlankRow:=True)
            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> All Negative Response </TD>")
            .Write("<TD align = left>")
            'Modified By VarunA on 19-July-2007 For Whizible 7.0 Development & Release
            'CommonFunctions.HTMLControls.DrawCheckBox("chkAllNegativeResponse", "chkAllNegativeResponse", value:="2", Isdisabled:=flag, ToBeInserted:="onclick='NegativeResponseCheckBox_OnClick()'")
            CommonFunctions.HTMLControls.DrawCheckBox("chkAllNegativeResponse", "chkAllNegativeResponse", , blnNegativeChk, value:="2", IsDisabled:=flag, ToBeInserted:="onclick='NegativeResponseCheckBox_OnClick()'")
            'End By VarunA on 19-July-2007
            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> All Positive Response </TD>")
            .Write("<TD align = left>")
            'Modified by VarunA on 19-July-2007 For Whizible 7.0 Development & Release
            'CommonFunctions.HTMLControls.DrawCheckBox("chkAllPositiveResponse", "chkAllPositiveResponse", value:="1", Isdisabled:=flag, ToBeInserted:="onclick='PositiveResponseCheckBox_OnClick()'")
            CommonFunctions.HTMLControls.DrawCheckBox("chkAllPositiveResponse", "chkAllPositiveResponse", , blnPositiveChk, value:="1", IsDisabled:=flag, ToBeInserted:="onclick='PositiveResponseCheckBox_OnClick()'")
            'End by VarunA on 19-July-2007
            .Write("</TD>")
            .Write("</TR>")
            .Write("</Table>")
            .Write("</Div>")


        End With


    End Sub

    Protected Sub WriteReport_ForUserStoryTestSet()
        Dim strTestSet As String
        Dim strRevision As String

        m_strTestSet_TS = CommonFunction.General.CheckIsNothing(Request.Form("cboTestSet_TS"), "0")
        m_strTestRevision_TS = CommonFunction.General.CheckIsNothing(Request.Form("cboTestRevision_TS"), "0")

        'm_strTestRevision_TS = CType(CommonFunction.General.CheckIsNothing(Request.Form("cboTestRevision_TS"), "NULL"), String)

        m_strUserStoryID = CommonFunction.General.CheckIsNothing(Request.Form("cboUserStory"), "0")
        If m_strUserStoryID = "" Then
            m_strUserStoryID = "0"
        End If

        ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
        ''strTestSet = "SELECT ProjectTestSetID,TestSetName FROM tbl_TCM_ProjectTestSet where projectID= " & CType(Session("intProjectID"), String)
        strTestSet = "usp_sel_tbl_TCM_ProjectTestSet_TestSetName " & CType(Session("intProjectID"), String)

        ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
        ''strRevision = "SELECT RevisionNo FROM tbl_TCM_ProjectTestSet_Published where CorporateTestSetID=" & m_strTestSet_TS
        strRevision = "usp_sel_tbl_TCM_ProjectTestSet_Published_RevisionNo " & m_strTestSet_TS

        With Response

            .Write("<TABLE class=clsTable width ='99.9%'><TR class = clsTRPageCaption><TD>Test Set Report</TD></TR></TABLE>")
            .Write("<BR>")

            .Write("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0 align = center>" & vbCrLf)

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> User Story </TD>")
            .Write("<TD align = left>")
            ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
            ''CommonFunctions.HTMLControls.DrawComboBox("cboUserStory", "SELECT UserStoryID,UserStoryName FROM d_tbl_PM_ScrumUserStory WITH(NOLOCK) where IterationID is not null AND ProjectId = " + CType(Session("intProjectID"), String), ComboWidthInPixel:=200, MatchFieldID:=m_strUserStoryID, IsMandatory:=True, ToBeInserted:="OnChange=Filter_change(" & intReportID & "," & intMasterTagID & ")", InsertBlankRow:=True)
            CommonFunctions.HTMLControls.DrawComboBox("cboUserStory", "usp_sel_d_tbl_PM_ScrumUserStory_UserStoryID " + CType(Session("intProjectID"), String), ComboWidthInPixel:=200, MatchFieldID:=m_strUserStoryID, IsMandatory:=True, ToBeInserted:="OnChange=Filter_change(" & intReportID & "," & intMasterTagID & ")", InsertBlankRow:=True)

            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> Test Set </TD>")
            .Write("<TD align = left>")
            CommonFunctions.HTMLControls.DrawComboBox("cboTestSet_TS", "usp_sel_RPT_TCM_Scrum_FillTestSessionCombo " + CType(Session("intProjectID"), String) + "," + m_strUserStoryID + ",'UserStoryTestSet'", ComboWidthInPixel:=200, MatchFieldID:=m_strTestSet_TS, IsMandatory:=True, ToBeInserted:="OnChange=Filter_change(" & intReportID & "," & intMasterTagID & ")", InsertBlankRow:=True)
            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> Test Revision </TD>")
            .Write("<TD align = left>")
            'Modified By VarunA on 27-July-2007 Whizible 7.0 Development & Release
            'Purpose : When no test set is selected then no revision should be shown.
            'CommonFunctions.HTMLControls.DrawComboBox("cboTestRevision_TS", strRevision, ComboWidthInPixel:=200, MatchFieldID:=m_strTestRevision_TS, InsertBlankRow:=True)
            If m_strTestSet_TS <> "" Then
                CommonFunctions.HTMLControls.DrawComboBox("cboTestRevision_TS", strRevision, ComboWidthInPixel:=200, MatchFieldID:=m_strTestRevision_TS, InsertBlankRow:=True)
            Else
                CommonFunctions.HTMLControls.DrawComboBox("cboTestRevision_TS", "SELECT '',''", ComboWidthInPixel:=200, MatchFieldID:=m_strTestRevision_TS, InsertBlankRow:=True)
            End If
            'End By VarunA on 27-July-2007
            .Write("</TD>")
            .Write("</TR>")

            .Write("</Table>")
            .Write("</Div>")


        End With
    End Sub

    Protected Sub WriteReport_ForUserStoryTestSessionDetails()
        Dim strSession As String
        Dim strStatus As String
        Dim strSessionType As String
        ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
        ''strSession = " SELECT TestSessionId,Title FROM tbl_TCM_TestSession WHERE ProjectID = " & CType(Session("intProjectID"), String)
        strSession = "usp_sel_tbl_TCM_TestSession_Title " & CType(Session("intProjectID"), String)

        ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
        ''strStatus = " SELECT TestStatusID,TestStatus FROM tbl_TCM_TestStatus ORDER BY TestStatus "
        strStatus = "usp_sel_tbl_TCM_TestStatus_TestStatusID"

        'Commented By VarunA on 25-July-2007 Whizible 7.0 Development & Release
        'Pupose : To have those session Type depending on test session
        'strSessionType = " SELECT SessionTypeID,SessionType FROM tbl_TCM_SessionTypeMaster WHERE ProjectID=" & CType(Session("intProjectID"), String) & " ORDER BY SessionType"
        'End By VarunA on 25-July-2007

        'Modified By VarunA on 23-July-2007 Whizible 7.0 Development & Release
        'Purpose : To persist the value of combo
        m_strTestSession = CommonFunction.General.CheckIsNothing(Request.Form("cboTestSession_Summary"), "0")
        m_strTestSessionStatus = CommonFunction.General.CheckIsNothing(Request.Form("cboTestSessionStatus"), "0")
        m_strTestSessionType = CommonFunction.General.CheckIsNothing(Request.Form("cboTestSessionType"), "0")


        If m_strTestSession = "" Then
            m_strTestSession = "0"
        End If
        ''Added by NitinC on 15 September 2011 For WhizibleSEM 10.0 [Agile Methodology]
        m_strUserStoryID = CommonFunction.General.CheckIsNothing(Request.Form("cboUserStory"), "0")
        If m_strUserStoryID = "" Then
            m_strUserStoryID = "0"
        End If
        ''End of Added by NitinC on 15 September 2011 For WhizibleSEM 10.0 [Agile Methodology]

        'End By VarunA on 23-July-2007

        With Response

            .Write("<TABLE class=clsTable width ='99.9%'><TR class = clsTRPageCaption><TD>Test Session Details</TD></TR></TABLE>")
            .Write("<BR>")

            .Write("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0 align = center>" & vbCrLf)

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> User Story </TD>")
            .Write("<TD align = left>")
            ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
            ''CommonFunctions.HTMLControls.DrawComboBox("cboUserStory", "SELECT UserStoryID,UserStoryName FROM d_tbl_PM_ScrumUserStory WITH(NOLOCK) where IterationID is not null AND ProjectId = " + CType(Session("intProjectID"), String), ComboWidthInPixel:=200, MatchFieldID:=m_strUserStoryID, IsMandatory:=True, ToBeInserted:="OnChange=Filter_change(" & intReportID & "," & intMasterTagID & ")", InsertBlankRow:=True)
            CommonFunctions.HTMLControls.DrawComboBox("cboUserStory", "usp_sel_d_tbl_PM_ScrumUserStory_UserStoryID " + CType(Session("intProjectID"), String), ComboWidthInPixel:=200, MatchFieldID:=m_strUserStoryID, IsMandatory:=True, ToBeInserted:="OnChange=Filter_change(" & intReportID & "," & intMasterTagID & ")", InsertBlankRow:=True)

            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> Test Session </TD>")
            .Write("<TD align = left>")
            'Modified By VarunA on 23-July-2007 Whizible 7.0 Development & Release
            'Purpose : To persist the value of combo
            'CommonFunctions.HTMLControls.DrawComboBox("cboTestSession_Summary", strSession, ComboWidthInPixel:=200,InsertBlankRow:=True)
            CommonFunctions.HTMLControls.DrawComboBox("cboTestSession_Summary", "usp_sel_RPT_TCM_Scrum_FillTestSessionCombo " + CType(Session("intProjectID"), String) + "," + m_strUserStoryID, ComboWidthInPixel:=200, MatchFieldID:=m_strTestSession, ToBeInserted:="OnChange=Filter_Session_change(" & intReportID & "," & intMasterTagID & ")", InsertBlankRow:=True)
            'End By VarunA on 23-July-2007
            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> All Open Sessions </TD>")
            .Write("<TD align = left>")
            'Added by VarunA on 24-July-2007 For Whizible 7.0 Development & Release
            'Purpose : To persist the value of checkbox
            'CommonFunctions.HTMLControls.DrawCheckBox("chkAllOpenSessions", "chkAllOpenSessions", value:="1", ToBeInserted:="onclick='OpenSessionCheckBox_OnClick()'")
            CommonFunctions.HTMLControls.DrawCheckBox("chkAllOpenSessions", "chkAllOpenSessions", , blnOpenSessionChk, value:="1", IsDisabled:=blnOpenSessionDisable, ToBeInserted:="onclick='OpenSessionCheckBox_OnClick()'")
            'End By VarunA on 24-July-2007
            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> All Closed Sessions </TD>")
            .Write("<TD align = left>")
            'Added by VarunA on 24-July-2007 For Whizible 7.0 Development & Release
            'Purpose : To persist the value of checkbox
            'CommonFunctions.HTMLControls.DrawCheckBox("chkAllClosedSessions", "chkAllClosedSessions", value:="2", ToBeInserted:="onclick='ClosedSessionCheckBox_OnClick()'")
            CommonFunctions.HTMLControls.DrawCheckBox("chkAllClosedSessions", "chkAllClosedSessions", , blnClosedSessionChk, value:="2", IsDisabled:=blnCloseSessionDisable, ToBeInserted:="onclick='ClosedSessionCheckBox_OnClick()'")
            'End By VarunA on 24-July-2007
            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> Test Session Status </TD>")
            .Write("<TD align = left>")
            'Modified By VarunA on 24-July-2007 Whizible 7.0 Development & Release
            'Purpose : To persist the value of combo
            'CommonFunctions.HTMLControls.DrawComboBox("cboTestSessionStatus", strStatus, ComboWidthInPixel:=200, InsertBlankRow:=True)
            CommonFunctions.HTMLControls.DrawComboBox("cboTestSessionStatus", strStatus, ComboWidthInPixel:=200, MatchFieldID:=m_strTestSessionStatus, InsertBlankRow:=True)
            'End By VarunA on 24-July-2007
            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven align = Right>")
            .Write("<TD> Test Session Type </TD>")
            .Write("<TD align = left>")
            'Modified By VarunA on 24-July-2007 Whizible 7.0 Development & Release
            'Purpose : To persist the value of combo
            'CommonFunctions.HTMLControls.DrawComboBox("cboTestSessionType", strSessionType, ComboWidthInPixel:=200, InsertBlankRow:=True)
            CommonFunctions.HTMLControls.DrawComboBox("cboTestSessionType", "usp_sel_RPT_TCM_FillTestSessionType " + CType(Session("intProjectID"), String) + "," + m_strTestSession, ComboWidthInPixel:=200, MatchFieldID:=m_strTestSessionType, InsertBlankRow:=True)
            'End By VarunA on 24-July-2007
            .Write("</TD>")
            .Write("</TR>")

            .Write("</Table>")
            .Write("</Div>")
        End With



    End Sub
    ''End of Added by NitinC on 15 September 2011 For WhizibleSEM 10.0 [Agile Methodology]

    Private Sub oRpt_Control_BeforePlot(ByRef Cancel As Boolean, ByRef Args As AdHocReports.WAF_Control) Handles oRpt.Control_BeforePlot

    End Sub
End Class
