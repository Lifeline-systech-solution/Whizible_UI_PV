Public Class DB_ProjectDB
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

#Region " Class scope Variables Declarations "
    Private WithEvents m_objTimesheetGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objReleasesGrid As New WebPages.Template.GenericGrid
    Private m_objTeamMemersGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objTS_To_AutheticateGrid As New WebPages.Template.GenericGrid
    'Menu
    Private m_objMenu As New WebPages.Template.StaticMenu
    Private m_arrMenuItem(1) As String
    Private m_arrMenuTooltip(1) As String
    Private m_arrClientSideFunctions(1) As String

    Protected m_strFromWhere As String = ""
    'Project Details
    Private m_lngProjectId As Long = 0
    Protected m_strProjectName As String = ""
    Private m_strDuration As String = ""
    Private m_strStartDate As String = ""
    Private m_strEndDate As String = ""
#End Region

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        ''Added By Vaijat K ON 19/04/2017 For Unauthenticated user can view this page.
        Dim strUserID As String = Session("intUserID").ToString()
        ''End Added By Vaijat K ON 19/04/2017 For Unauthenticated user can view this page.
        'Initiate the Menu items arrays. Used to plot the menu.
        InitPageMenu()

        m_strFromWhere = CommonFunctions.General.CheckIsNothing(Request.QueryString("FromWhere"))
        m_lngProjectId = CType("0" & CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID"), "0"), Long)
    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objMenu = Nothing
        m_objReleasesGrid = Nothing
        m_objTeamMemersGrid = Nothing
        m_objTimesheetGrid = Nothing
    End Sub

    Public Sub New()
        ' MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "DB_ProjectDB : " & UserInput & " " & Cause
        Throw ex
    End Sub

    Private Sub InitPageMenu()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        m_arrMenuItem(0) = MyBase.GetResourceString("MENU_CLOSE")
        m_arrMenuTooltip(0) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        m_arrClientSideFunctions(0) = "Close_OnClick()"

        m_arrMenuItem(1) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(1) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrClientSideFunctions(1) = "Help_OnClick('PROJECTDB')"

        MyBase.InitializeResources("AppResources.DB_ProjectDB", "AppResources")
    End Sub

    Public Sub PageInit()
        Dim strMenu As String = ""
        Dim strTemp As String = ""

        'Display the Menu
        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

        CommonFunctions.General.WriteHTML("<DIV Id='PageDiv' Style='Overflow:auto;width:100%'>")
        'Display the Project Details as a Page Header
        GetProjectDetails()
        strTemp = MyBase.GetResourceString("PROJECT_NAME") & " : "
        strTemp &= Server.HtmlEncode(m_strProjectName)
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, strTemp, , , True))
        CommonFunctions.General.WriteHTML("<BR>")
        Display_ProjectDetails()
        CommonFunctions.General.WriteHTML("<BR>")

        'Display the Lists.
        strTemp = MyBase.GetResourceString("WEEKLY_STATUS_REPORTS")
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, strTemp, , , True))
        CommonFunctions.General.WriteHTML("<BR>")
        Display_WeeklyStatusReports_And_Timesheet_List()
        CommonFunctions.General.WriteHTML("<BR>")

        strTemp = MyBase.GetResourceString("LAST_5_RELEASES")
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, strTemp, , , True))
        CommonFunctions.General.WriteHTML("<BR>")
        Display_Releases_List()
        CommonFunctions.General.WriteHTML("<BR>")

        strTemp = MyBase.GetResourceString("TEAM_MEMBERS")
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, strTemp, , , True))
        CommonFunctions.General.WriteHTML("<BR>")
        Display_TeamMembers_List()

        'Code Commented By VivekP On 19 August 2005 For WhizibleSEM Sp4 IssueID-87
        'strTemp = MyBase.GetResourceString("TIMESHEETS_TO_BE_AUTHENTICATED")
        'CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, strTemp, , , True))
        'CommonFunctions.General.WriteHTML("<BR>")
        'Display_Timesheets_ToBe_Authenticated()
        'Code Commenting Ends By VivekP On 19 August 2005 For WhizibleSEM Sp4 IssueID-87

        CommonFunctions.General.WriteHTML("</DIV>")

        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")
    End Sub

#Region " Display the Lists"
    Private Sub Display_WeeklyStatusReports_And_Timesheet_List()
        Dim strQuery As String = ""
        'Modified By VivekP On 16 Sep 2005 For WhizibleSEM SP4
        Dim arrActualColumns() As String = {"InvoiceNo", "TimeSheetNo", "CreatedDate", "FromDate", "ToDate", "TotalTimeSheetHours", "TimesheetStatus"}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("TIMESHEET_WSR_AND_INVOICES"), _
                                                 "ID", MyBase.GetResourceString("DATE"), _
                                                 MyBase.GetResourceString("FROM_DATE"), _
                                                 MyBase.GetResourceString("TO_DATE"), _
                                                 MyBase.GetResourceString("TIMESHEET_HOURS"), "Status"}
        Dim arrTDStyle() As String = {"Align=Center", "Align=Center width='10'", "", "", "", "align='center'"}
        'End Of Modification By VivekP On 16 Sep 2005 For WhizibleSEM SP4
        strQuery = "EXEC usp_GetLastFiveTimeSheets " & m_lngProjectId.ToString()
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'Set the Grid Properties
        With m_objTimesheetGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            .PrimaryKey = "TimeSheetNo"
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "divList1"
            .DIVHeight = 110
            .DIVStyle = "overflow:auto;width:100%"
            'Modified By VivekP On 16 Sep 2005 For WhizibleSEM SP4
            .NoOfDataColumns = 7
            'End Of Modification By VivekP On 16 Sep 2005 For WhizibleSEM SP4
            .EmptyValueReplacement = "&nbsp;"
            .returnHTML = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With

    End Sub

    Private Sub Display_Releases_List()
        Dim strQuery As String = ""
        Dim arrActualColumns() As String = {"ReleaseID", "Subject", "ReleaseDate"}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("RELEASE_ID"), _
                                                 MyBase.GetResourceString("SUBJECT"), _
                                                 MyBase.GetResourceString("RELEASE_DATE")}
        Dim arrRowLink() As String = {"ShowRelease_OnClick(ReleaseID)"}
        Dim arrTDStyle() As String = {"align=center width='15%'", "width='60%'", "nowrap"}

        strQuery = "EXEC usp_Sel_LastFiveReleases " & m_lngProjectId.ToString()
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'Set the Grid Properties
        With m_objReleasesGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .RowLinkArray = arrRowLink
            .TDStyleArray = arrTDStyle
            .PrimaryKey = "ReleaseID"
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "divList2"
            .DIVHeight = 110
            .DIVStyle = "overflow:auto;width:100%"
            .NoOfDataColumns = 3
            .EmptyValueReplacement = "&nbsp;"
            .returnHTML = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
    End Sub

    Private Sub Display_TeamMembers_List()
        Dim strQuery As String = ""
        Dim arrActualColumns() As String = {"UserName", "RoleDescription", "Phone", "EmailID"}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("NAME"), _
                                                 MyBase.GetResourceString("ROLE"), _
                                                 MyBase.GetResourceString("PHONE"), _
                                                 MyBase.GetResourceString("EMAIL")}
        Dim arrTDStyle() As String = {"width='40%'", "width='25%'", "width='15%'", "width='20%'"}

        strQuery = "EXEC usp_Sel_CurrentTeamMembers " & m_lngProjectId.ToString()
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'Set the Grid Properties
        With m_objTeamMemersGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "divList3"
            .DIVHeight = 110
            .DIVStyle = "overflow:auto;width:100%"
            .NoOfDataColumns = 4
            .EmptyValueReplacement = "&nbsp;"
            .returnHTML = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
    End Sub

    Private Sub Display_Timesheets_ToBe_Authenticated()
        Dim strQuery As String = ""
        Dim arrActualColumns() As String = {"TimeSheetNo", "CreatedDate", "FromDate", "ToDate", "TotalTimeSheetHours"}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("TIMESHEET_ID"), _
                                                 MyBase.GetResourceString("GENERATED_DATE"), _
                                                 MyBase.GetResourceString("FROM_DATE"), _
                                                 MyBase.GetResourceString("TO_DATE"), _
                                                 MyBase.GetResourceString("HOURS")}
        Dim arrRowLink() As String = {"ShowTimesheetToAuthenticate_OnClick(TimeSheetNo)"}
        Dim arrTDStyle() As String = {"align='left'", "align='left' nowrap", "align='left' nowrap", "align='left' nowrap", "align=right"}

        strQuery = "EXEC usp_Get_CustomersTimeSheet_ForProject " & m_lngProjectId.ToString()
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'Set the Grid Properties
        With m_objTS_To_AutheticateGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .RowLinkArray = arrRowLink
            .TDStyleArray = arrTDStyle
            .PrimaryKey = "TimeSheetNo"
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "divList3"
            .DIVHeight = 110
            .DIVStyle = "overflow:auto;width:100%"
            .NoOfDataColumns = 5
            .EmptyValueReplacement = "&nbsp;"
            .returnHTML = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
    End Sub
#End Region

    Private Sub Display_ProjectDetails()
        '==================================================================================
        ' Procedure Name	:	Display_ProjectDetails
        ' Purpose			:	This procedure shows the Project Details.
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Jayavant
        ' Created			:	19-Mar-2004
        ' Revisions			:	
        '==================================================================================
        CommonFunctions.General.WriteHTML("<TABLE class=clsTable cellspacing=0 cellpadding=0 width='99.9%'>")
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("DURATION"))
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("<TD>")
        CommonFunctions.General.WriteHTML(Server.HtmlEncode(m_strDuration))
        CommonFunctions.General.WriteHTML(" " & MyBase.GetResourceString("DAYS"))
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("<TD>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("START_DATE"))
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("<TD>")
        If m_strStartDate <> "" Then
            CommonFunctions.General.WriteHTML(Server.HtmlEncode(CommonFunctions.Dates.CGetDate(CType(m_strStartDate, Date))))
        End If
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("<TD>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("END_DATE"))
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("<TD>")
        If m_strEndDate <> "" Then
            CommonFunctions.General.WriteHTML(Server.HtmlEncode(CommonFunctions.Dates.CGetDate(CType(m_strEndDate, Date))))
        End If
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")
    End Sub

    Private Sub GetProjectDetails()
        '==================================================================================
        ' Procedure Name	:	GetProjectDetails
        ' Purpose			:	This procedure Fetches the Details from the Database. These Details are 
        '                       shown as the Header for the Timesheet Details.
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Jayavant
        ' Created			:	19-Mar-2004
        ' Revisions			:	
        '==================================================================================
        Dim strQuery As String = ""
        Dim drTimeSheet As IDataReader

        strQuery = "EXEC usp_Sel_tbl_PM_Project " & m_lngProjectId.ToString()
        drTimeSheet = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drTimeSheet) <> "" Then
            If drTimeSheet.Read() Then
                m_strProjectName = drTimeSheet.Item("ProjectName").ToString()
                m_strProjectName = CommonFunctions.General.UnBuildQueryString(m_strProjectName)
                m_strDuration = drTimeSheet.Item("ExpectedDuration").ToString()
                m_strDuration = CommonFunctions.General.UnBuildQueryString(m_strDuration)
                m_strStartDate = drTimeSheet.Item("ExpectedStartDate").ToString()
                m_strStartDate = CommonFunctions.General.UnBuildQueryString(m_strStartDate)
                m_strEndDate = drTimeSheet.Item("ExpectedEndDate").ToString()
                m_strEndDate = CommonFunctions.General.UnBuildQueryString(m_strEndDate)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drTimeSheet)
    End Sub

#Region " Grid Event Handlers "
    Private Sub m_objReleasesGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objReleasesGrid.DataRowTD_BeforePrint
        If Args.ColIndex = 2 Then
            Args.ShowTimeWithDate = True
        End If
    End Sub

    Private Sub m_objTimesheetGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objTimesheetGrid.DataRowTD_BeforePrint
        Select Case Args.ColIndex
            Case 0
                Dim strQuery As String = ""
                Dim lngTimesheetNo As Long = 0
                Dim lngInvoiceNo As Long = 0
                Dim objLink As WebPages.UI.cDynamicLink
                Dim strFromDate As String = ""
                Dim strToDate As String = ""
                Dim strHTML As String = ""
                'Added By VivekP On 11 August 2005 For WhizibleSEM SP4 IssueID-87
                Dim strTimesheetStatus As String
                'End Of Addition by vivekP On 11 August 2005 For WhizibleSEM SP4 IssueID-87

                lngTimesheetNo = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("TimesheetNO"), "0"), Long)
                lngInvoiceNo = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("InvoiceNo"), "0"), Long)

                'Weekly Status Report
                strQuery = "EXEC usp_Sel_tbl_PM_WSROtherAttributesTimeSheetNo " & lngTimesheetNo.ToString()
                If CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL)) <> "" Then
                    objLink = New WebPages.UI.cDynamicLink
                    objLink.FunctionName = "WSR_OnClick(" & lngTimesheetNo.ToString() & ")"
                    objLink.LinkName = "<img Border=0 src=../../Images/StatusReport.gif></img>"
                    objLink.ReturnHTML = True
                    objLink.Tooltip = MyBase.GetResourceString("WEEKLY_STATUS_REPORT")
                    strHTML &= objLink.GetDynamicLink()
                    strHTML &= "&nbsp;"
                    objLink = Nothing
                End If
                'Timesheet
                strFromDate = Args.DataReader.Item("FromDate").ToString()
                strToDate = Args.DataReader.Item("ToDate").ToString()
                'Added By VivekP On 11 August 2005 For WhizibleSEM SP4 IssueID-87
                strTimesheetStatus = Args.DataReader.Item("TimesheetStatus").ToString()
                'End Of Addition by vivekP On 11 August 2005 For WhizibleSEM SP4 IssueID-87
                objLink = New WebPages.UI.cDynamicLink

                '' START : Commented and Modified By ParagD On 25-Sept-2006 : Security Issue 6197
                Dim strPKTokenForTimesheetID As String
                strPKTokenForTimesheetID = CommonFunctions.Security.Token.GetToken(lngTimesheetNo.ToString + Session("intUserID").ToString + "0" + "42")
                '' objLink.FunctionName = "ShowTimesheet_OnClick(" & lngTimesheetNo.ToString() & ",'" & strFromDate & "','" & strToDate & "','" & strTimesheetStatus & "')"
                objLink.FunctionName = "ShowTimesheet_OnClick(" & lngTimesheetNo.ToString() & ",'" & strFromDate & "','" & strToDate & "','" & strTimesheetStatus & "','" & strPKTokenForTimesheetID & "')"
                '' END : Commented and Modified By ParagD On 25-Sept-2006 : Security Issue 6197

                objLink.LinkName = "<img Border=0 src=../../Images/TimeSheet.gif></img>"
                objLink.ReturnHTML = True
                objLink.Tooltip = MyBase.GetResourceString("TIMESHEET")
                strHTML &= objLink.GetDynamicLink()
                strHTML &= "&nbsp;"
                objLink = Nothing
                'Invoice
                If lngInvoiceNo > 0 Then
                    'Temporary Commented By VarunA on 15-Oct-2007 RequestID-9417 Thesys
                    'Purpose : we are not showing invoice with the project timesheet.
                    'objLink = New WebPages.UI.cDynamicLink
                    'objLink.FunctionName = "ShowInvoice_OnClick(" & lngInvoiceNo.ToString() & ")"
                    'objLink.LinkName = "<img Border=0 src=../../Images/Invoice.gif></img>"
                    'objLink.ReturnHTML = True
                    'objLink.Tooltip = MyBase.GetResourceString("INVOICE")
                    'strHTML &= objLink.GetDynamicLink()
                    'strHTML &= "&nbsp;"
                    'objLink = Nothing
                    'End By VarunA on 15-Oct-2007
                End If
                Args.DataFieldValue = strHTML
                Args.ApplyHTMLEncode = False

            Case 1
                Args.ApplyHTMLEncode = True
                Args.ShowTimeWithDate = True

            Case 2
                Args.ShowTimeWithDate = False

            Case 3
                Args.ShowTimeWithDate = False
        End Select
    End Sub
#End Region

    Private Sub m_objTS_To_AutheticateGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objTS_To_AutheticateGrid.DataRowTD_BeforePrint
        Select Case Args.ColIndex
            Case 1
                Args.ShowTimeWithDate = True

            Case 2
                Args.ShowTimeWithDate = False

            Case 3
                Args.ShowTimeWithDate = False

            Case 4

        End Select
    End Sub
End Class
