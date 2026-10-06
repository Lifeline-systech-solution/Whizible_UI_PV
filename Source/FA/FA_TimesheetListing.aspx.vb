Public Class FA_TimesheetListing
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

#Region " Constants Used in the Class "
    Protected Const MODE_TSLISTING As String = "Listing"
    Protected Const MODE_TSDETAILS As String = "Details"

    Private Const AUTHETICATE As String = "Authenticate"
    Private Const DECLINE As String = "Decline"

    Private Const TIMESHEET_ALL As String = "All"
    'Modified by VivekP On 3 August 2005 For WhizibleSEM Sp4 IssueID-87
    'Private Const TIMESHEET_CURRENT As String = "Current"
    Private Const TIMESHEET_CURRENT As String = "Ready for Approval"
    'End Of Modification by VivekP On 3 August 2005 For WhizibleSEM Sp4 IssueID-87

    Protected Const ACTION_DELETE As String = "Delete"
    Protected Const ACTION_AUTHENTICATE As String = "Authenticate"

    '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197	
    Protected m_PKToken_Edit As String
    '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197

    '' START : ParagD On 29-Sept-2006
    Dim m_strSQL, m_strTimesheetStatus_ApproveORReject, strTimesheetIDs As String
    '' END : ParagD On 29-Sept-2006

    ' Code added by SwapnilR on 25th Sept 2006
    ' Purpose : Adding security token for Show Report link
    Protected m_strUserID As String
    ' End of code addition by SwapnilR on 25th Sept 2006

    Private Enum MenuIndex
        AUTHENTICATE
        'Modified By vivekP On 2 August 2005 For SP4 WhizibleSEM IssueID-87
        REJECTFROMLIST
        SELECTALL
        CLEARALL
        DELETE
        SEND
        APPROVE
        REJECT
        VIEW_COMMENT
        BACK
        'End Of Modification On 2 August 2005 For Sp4 WhizibleSEM IssueID-87
        CLOSE
        HELP
    End Enum
    Private Const NUMBER_OF_MENUITEMS As Integer = 12
#End Region

#Region " Class scope Variables Declarations "

    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccessRights As WebPages.Security.cAccessRights
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    'Menu
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_arrMenuItem(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrMenuTooltip(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrClientSideFunctions(NUMBER_OF_MENUITEMS - 1) As String

    Protected m_strPageTitle As String = ""
    Private m_strFromWhere As String = ""   'Has value when called from 'Invoice Generation'.
    Private m_strHelpId As String = ""
    Private m_strMode As String = ""
    Private m_strAction As String = ""
    Protected m_lngTagId As Long = 0
    Private m_lngProjectId As Long = 0
    Private m_blnSubProjectLevelInvoicing As Boolean = False
    Private m_strSubProjectCaption As String = ""
    'Modified by VivekP On 9 August 2005 For WhizibleSEM SP4 IssueID-87
    'For Mode TSListing
    Protected m_strTimeSheetAllOrCurrent As String = TIMESHEET_CURRENT
    Protected strProjectID As String
    'End Of modification On 9 August 2005 For WhizibleSEM SP4 IssueID-87
    Private m_blnHasTimeSheet As Boolean = False

    'For Mode TSDetails
    Private m_blnShowSendMenuItem As Boolean = False
    Protected m_lngTimesheetNo As Long = 0
    Private m_strFromDate As String = ""
    Private m_strToDate As String = ""
    Private m_strProjectName As String = ""
    Private m_strEmployeeName As String = ""
    Private m_strEntryDate As String = ""
    Private m_dblGroupTotal As Double = -1
    'Added By Usha Pandit On 07.12.2020 For getting work hours in decimal from HH:MM format
    Private m_dblGrandTotal As Double = 0
    'End Of Added By Usha Pandit On 07.12.2020 For getting work hours in decimal from HH:MM format
    'Added by VivekP On 2 August 2005 For WhizibleSEM SP4 IssueID-87
    Protected strRejectedStatus As String = ""
    Protected strAllTimesheet As String = ""
    Private strFromDate As String
    Private strToDate As String
    Private strTimesheetStatus As String
    Protected strTimeSheetList As String
    'End Of Addition By VivekP On August 2005 For WhizibleSEM SP4 IssueID-87

    ''Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
    Protected m_strEmployeeID As String
    Protected m_strFlag As String
    Protected m_blnValidate As Boolean = "True"
    ''End of Addition by Dhanashri S on 11 Aug 2016
#End Region

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load


        ''Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
        If Not Request.QueryString("EmployeeID") Is Nothing Then
            m_strEmployeeID = Request.QueryString("EmployeeID").ToString
        End If

        If Not Request.QueryString("Flag") Is Nothing Then
            m_strFlag = Request.QueryString("Flag").ToString
        End If

        ''End of Addition by Dhanashri S on 11 Aug 2016

        ''Added by Yogesh J on on 29 Jan 2016 to validate Token
        If Request.QueryString("concatedlist") IsNot Nothing And Request.QueryString("Token") IsNot Nothing And Request.QueryString("Mode") = "ApproveOrReject" Then

            If (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(Request.QueryString("concatedlist"), String) + CType(0, String) + CType(0, String), Request.QueryString("Token")) = False) Then
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If

        End If
        '  End of addition by Yogesh J on 29-Jan-2016 to generate Token
        ''Added by Shamkant S on 17 Feb 2016 to validate Token
        If Request.QueryString("TimesheetNo_PK") IsNot Nothing And Request.QueryString("Token") IsNot Nothing And Request.QueryString("Mode") = "ApproveOrReject" Then

            If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("TimesheetNo_PK"), String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String), Request.QueryString("Token")) = False) Then
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If
        ''End of addition by Shamkant  S on on 17 Feb 2016 to validate Token

        ''Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
        If (m_strFlag = "FromWeeklyStatusReport") Then
            If (Request.QueryString("TimeSheetNo") <> "") Then
                If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("TimeSheetNo"), String) + CType(m_strEmployeeID, String) + CType(0, String) + CType(42, String), Request.QueryString("PKToken")) = False)) Then
                    m_blnValidate = "False"
                End If
            End If
            If (m_blnValidate = "False") Then
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If
        ''End of Addition by Dhanashri S on 11 Aug 2016

        m_strFromWhere = CommonFunctions.General.CheckIsNothing(Request.QueryString("FromWhere")).Trim()
        'If m_strFromWhere = "FA" Then
        '    m_strHelpId = "349"
        'Else
        '    m_strHelpId = "TL"
        'End If
        m_strHelpId = "TL"

        ' Code added by SwapnilR on 25th Sept 2006
        ' Purpose : Adding security token for Show Report link
        m_strUserID = CType(HttpContext.Current.Session("intUserID"), String)
        ' End of code addition by SwapnilR on 25th Sept 2006

        'Initialize the Global Objects
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngTagId = m_objGlobal.TagID
        m_lngProjectId = m_objGlobal.ProjectID
        InitPageMenu()

        'Modified by VivekP on 3 August 2005 For WhiZIbleSEM SP4 IssueID-87
        'm_strTimeSheetAllOrCurrent = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("optStyle")).Trim()
        'If m_strTimeSheetAllOrCurrent = "" Then m_strTimeSheetAllOrCurrent = TIMESHEET_CURRENT
        If Request.QueryString("NumberClick") = "NumberClick" Then
            m_strTimeSheetAllOrCurrent = Request.QueryString("TimeSheetAllOrCurrent")
        Else
            m_strTimeSheetAllOrCurrent = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboStatus")).Trim()
        End If

        If Request.QueryString("NumberClick") = "NumberClick" Then
            strProjectID = Request.QueryString("ProjectID")
        Else
            strProjectID = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboProjectName")).Trim()
        End If

        If Request.QueryString("BACK") = "BACK" Then
            m_strTimeSheetAllOrCurrent = Request.QueryString("TimeSheetAllOrCurrent")
        End If
        If Request.QueryString("BACK") = "BACK" Then
            strProjectID = Request.QueryString("ProjectID")
        End If
        'If Request.QueryString("AfterReject") = "AfterReject" Then
        '    m_strTimeSheetAllOrCurrent = TIMESHEET_CURRENT
        'End If

        strFromDate = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("FromDate")).Trim()
        strToDate = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("ToDate")).Trim()
        'If m_strTimeSheetAllOrCurrent = "" Then m_strTimeSheetAllOrCurrent = TIMESHEET_CURRENT
        'End Of Modification by VivekP on 3 August 2005 For WhiZIbleSEM SP4 IssueID-87
        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode")).Trim()
        If m_strMode = "" Then m_strMode = MODE_TSLISTING

        If m_strMode = MODE_TSLISTING Then
            m_strPageTitle = MyBase.GetResourceString("TIMESHEET_LISTING")
            m_strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("Action")).Trim()

            '' START : Added By ParagD 03-Oct-2006
            m_PKToken_Edit = CommonFunctions.Security.Token.GetToken(m_lngProjectId.ToString + CType(Session("intUserID"), String) + "0" + "42")

            If (Trim(m_PKToken_Edit & "") = "" And CommonFunctions.Security.Token.ValidateToken(m_lngProjectId.ToString + CType(Session("intUserID"), String) + "0" + "42", m_PKToken_Edit) = False) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Project Timesheet Easy Edit", 0, 0, "Timesheet No", "0")
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
            '' END : Added By ParagD 03-Oct-2006    

            If m_strAction = ACTION_AUTHENTICATE Then
                Authenticate_Timesheet()
            ElseIf m_strAction = ACTION_DELETE Then
                Delete_Timesheets()
                'Modified by VivekP on 3 August 2005 For WhiZIbleSEM SP4 IssueID-87
            ElseIf m_strAction = "RejectTimesheet" Then
                Call Reject_Timesheet()
                Response.Write("<Script language='javascript'>")
                CommonFunctions.General.WriteHTML("var parent=window.opener.opener;" + vbCrLf)
                CommonFunctions.General.WriteHTML("if(parent!=null){" + vbCrLf)
                CommonFunctions.General.WriteHTML("window.opener.opener.location.href=window.opener.opener.location.href;" + vbCrLf)
                Response.Write("window.opener.close();")
                Response.Write("window.close();")
                CommonFunctions.General.WriteHTML("}else{" + vbCrLf)
                Response.Write("window.opener.location.href=window.opener.location.href;")
                Response.Write("window.close();")
                CommonFunctions.General.WriteHTML("}" + vbCrLf)
                Response.Write("</Script>")
                'End Of Modification by VivekP on 3 August 2005 For WhiZIbleSEM SP4 IssueID-87
            End If
        ElseIf m_strMode = MODE_TSDETAILS Then
            m_strPageTitle = MyBase.GetResourceString("TIMESHEET_DETAILS")
            m_lngTimesheetNo = CType(CommonFunctions.General.CheckIsNothing("0" & Request.QueryString("TimeSheetNo"), "0"), Long)

            ' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
            If Trim(Request.QueryString("PKToken") & "") <> "" Then
                m_PKToken_Edit = Trim(Request.QueryString("PKToken") & "")
            Else
                m_PKToken_Edit = Request.Form("txtPKToken").ToString
            End If
            ' END : Added by ParagD 14-Sept-2006 : Security Issue 6197  

            m_strFromDate = CommonFunctions.General.CheckIsNothing(Request.QueryString("FromDate")).Trim()
            m_strToDate = CommonFunctions.General.CheckIsNothing(Request.QueryString("ToDate")).Trim()
            m_strProjectName = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectName")).Trim()
            strTimesheetStatus = CommonFunctions.General.CheckIsNothing(Request.QueryString("TimesheetStatus")).Trim()
            'Modified by VivekP on 3 August 2005 For WhiZIbleSEM SP4 IssueID-87
            If Request.QueryString("AuthenticateDetail") = "AuthenticateDetail" Then
                Authenticate_Timesheet()
            End If
        ElseIf m_strMode = "ApproveOrReject" Then
            m_strPageTitle = MyBase.GetResourceString("TIMESHEET_DETAILS")
            'Modified by VivekP on 3 August 2005 For WhiZIbleSEM SP4 IssueID-87
        End If
    End Sub
    Public Sub PageInit()
        Dim strMenu As String = ""
        Dim drTempWork As IDataReader
        Dim strQuery As String = ""

        'Get the Invoicing Details
        strQuery = "Exec usp_Sel_tbl_PM_CompanyInformation"
        drTempWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drTempWork) <> "" Then
            If drTempWork.Read() Then
                m_blnSubProjectLevelInvoicing = CType(CommonFunctions.Data.CheckIsDBNull(drTempWork.Item("SubProjectLevelInvoiceing"), "False"), Boolean)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drTempWork)

        If m_blnSubProjectLevelInvoicing = True Then
            m_strSubProjectCaption = MyBase.GetResourceString("WORK_ORDER")
            'Get the Sub Project name
            strQuery = "Exec usp_Sel_tbl_UI_TagMaster 661"
            drTempWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drTempWork) <> "" Then
                If drTempWork.Read() Then
                    m_strSubProjectCaption = drTempWork.Item("TagDescription").ToString().Trim()
                    If UCase(Right(m_strSubProjectCaption, 1)) = "S" Then
                        m_strSubProjectCaption = Left(m_strSubProjectCaption, Len(m_strSubProjectCaption) - 1)
                    End If
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drTempWork)
        End If

        If m_strMode = MODE_TSLISTING Then
            'Test whether records are there or not. This is required to hide menu items.
            strQuery = BuildTimeSheetQuery()
            drTempWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drTempWork) <> "" Then
                If drTempWork.Read() Then
                    m_blnHasTimeSheet = True
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drTempWork)
        ElseIf m_strMode = MODE_TSDETAILS Then
            If m_strFromDate = "" And m_strToDate = "" And m_lngTimesheetNo <> 0 Then
                '''' START : Added By ParagD On 14-Sept-2006 : Security Issue 6197   
                If (Trim(m_PKToken_Edit & "") = "" And CommonFunctions.Security.Token.ValidateToken(m_lngTimesheetNo.ToString + CType(Session("intUserID"), String) + "0" + "42", m_PKToken_Edit) = False) Then
                    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Project Timesheet Easy Edit", 0, 0, "Timesheet No", m_lngTimesheetNo.ToString)
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
                '''' END : Added By ParagD On 14-Sept-2006 : Security Issue 6197
                GetProjectDetails()
            End If
        End If

        'Modified By VivekP On 8 August 2005 For WhizibleSEM sp4 IssueID-87
        'Display the Menu
        If Request.QueryString("Mode") <> "ApproveOrReject" Then

            '''' START : Added By ParagD On 14-Sept-2006 : Security Issue 6197   
            ''Added And Commented By Vidya J ON 1 Feb 2016
            ' If m_strFromDate <> "FA" And CommonFunction.General.CheckIsNothing(m_lngTimesheetNo.ToString, "0") <> "0" Then

            ''  If (Trim(m_PKToken_Edit & "") = "" And CommonFunctions.Security.Token.ValidateToken(m_lngTimesheetNo.ToString + CType(Session("intUserID"), String) + "0" + "42", m_PKToken_Edit) = False) Then
            If m_strFromDate <> "FA" And CommonFunction.General.CheckIsNothing(m_lngTimesheetNo.ToString, "0") <> "0" And Trim(m_PKToken_Edit & "") <> "" Then
                If (CommonFunctions.Security.Token.ValidateToken(m_lngTimesheetNo.ToString + CType(Session("intUserID"), String) + "0" + "42", m_PKToken_Edit) = False) Then
                    ''End Of Added And Commented By Vidya J ON 1 Feb 2016
                    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Project Timesheet Easy Edit", 0, 0, "Timesheet No", m_lngTimesheetNo.ToString)
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
            End If
            '''' END : Added By ParagD On 14-Sept-2006 : Security Issue 6197

            strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
            CommonFunctions.General.WriteHTML(strMenu)
            Response.Write("<TABLE CellSpacing=0 width='99.9%' height = '10' class=clsTable><TR class=clsTRBlank><TD><TD></TR></TABLE>")
            'End Of Modification By VivekP On 8 August 2005 For WhizibleSEM sp4 IssueID-87
        End If

        'CommonFunctions.General.WriteHTML("<BR>")


        If m_strMode = MODE_TSLISTING Then
            'Display Page Caption
            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("TIMESHEET_LISTING"), , , True))

            'Code Commented By VivekP On 3 August 2005 For WhizibleSEM SP4 IssueID-87
            'Display the Page Body
            'If m_strTimeSheetAllOrCurrent = TIMESHEET_CURRENT Then
            '    CommonFunctions.HTMLControls.DrawOptionButton("optStyle", "optStyle", , True, TIMESHEET_CURRENT, , "OnClick=optType_OnClick()")
            '    CommonFunctions.General.WriteHTML("<Font Face=Verdana Size=1>" & MyBase.GetResourceString("TIMESHEETS_TOBE_AUTHENTICATED") & "</Font>")
            '    CommonFunctions.HTMLControls.DrawOptionButton("optStyle", "optStyle", , , TIMESHEET_ALL, , "OnClick=optType_OnClick()")
            '    CommonFunctions.General.WriteHTML("<Font Face=Verdana Size=1>" & MyBase.GetResourceString("ALL_TIMESHEETS") & "</Font>")
            'Else
            '    CommonFunctions.HTMLControls.DrawOptionButton("optStyle", "optStyle", , , TIMESHEET_CURRENT, , "OnClick=optType_OnClick()")
            '    CommonFunctions.General.WriteHTML("<Font Face=Verdana Size=1>" & MyBase.GetResourceString("TIMESHEETS_TOBE_AUTHENTICATED") & "</Font>")
            '    CommonFunctions.HTMLControls.DrawOptionButton("optStyle", "optStyle", , True, TIMESHEET_ALL, , "OnClick=optType_OnClick()")
            '    CommonFunctions.General.WriteHTML("<Font Face=Verdana Size=1>" & MyBase.GetResourceString("ALL_TIMESHEETS") & "</Font>")
            'End If
            'Code Commenting Ends By VivekP On 3 August 2005 For WhizibleSEM SP4 IssueID-87

            'Added By VivekP On 3 August 2005 For WhizibleSEM SP4 IssueID-87
            Response.Write("<TABLE CellSpacing=0 width='99.9%' height = '10' class=clsTable><TR class=clsTRBlank><TD><TD></TR></TABLE>")
            Dim objHeader As New WebPage.Templates.HeaderFooter
            Dim intRoleLevel As Integer

            'Code modified by Padmnabh A -- Only projects for which logged in user is has "timesheet authetication ID" will be listed in project name drop down for Issue ID.677
            'objHeader.HeaderFooter = "Timesheet Status&nbsp;" + CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "SELECT 'Ready for Approval' UNION SELECT 'Approved Timesheet' UNION SELECT 'Rejected Timesheet'", , m_strTimeSheetAllOrCurrent, "OnChange=status_OnChange()", True, True, ) + "&nbsp;&nbsp;&nbsp;&nbsp;" + "Project Name&nbsp;" + CommonFunctions.HTMLControls.DrawComboBox("cboProjectName", "usp_Sel_Project_For_DA_Active_InActive_Projects " + CType(Session("intUserID"), String), 400, strProjectID, "OnChange=project_OnChange()", True, True, ) + "<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;From Date&nbsp;" + CommonFunctions.HTMLControls.DrawDateControl("FromDate", "FromDate", , , strFromDate, , "frmTimesheetListing", , , , , , , True) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To Date&nbsp;" + CommonFunctions.HTMLControls.DrawDateControl("ToDate", "ToDate", , , strToDate, , "frmTimesheetListing", , , , , , , True) + "&nbsp;&nbsp;" + "<A STYLE=TEXT-DECORATION:NONE Href ='JavaScript:Show_OnClick()'><U>Show</U></A>"
            'Commented and Modified by JyotiG
            'Start_JG_11783_20-Mar-2007
            'Issue :PT: Billing > Project Timesheet: Formatting Issues
            'objHeader.HeaderFooter = "Timesheet Status&nbsp;" + CommonFunctions.HTMLControls.DrawComboBox("cboStatus",  "SELECT 'Ready for Approval' UNION SELECT 'Approved Timesheet' UNION SELECT 'Rejected Timesheet'", , m_strTimeSheetAllOrCurrent, "OnChange=status_OnChange()", True, True,  ) + "&nbsp;&nbsp;&nbsp;&nbsp;" + "Project Name&nbsp;" + CommonFunctions.HTMLControls.DrawComboBox("cboProjectName", "usp_sel_FA_ProjectForTimeSheetListing " + CType(Session("intUserID"), String), 400, strProjectID, "OnChange=project_OnChange()", True, True, ) + "<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;From Date&nbsp;" + CommonFunctions.HTMLControls.DrawDateControl("FromDate", "FromDate", , , strFromDate, , "frmTimesheetListing", , , , , , , True) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To Date&nbsp;" + CommonFunctions.HTMLControls.DrawDateControl("ToDate", "ToDate", , , strToDate, , "frmTimesheetListing", , , , , , , True) + "&nbsp;&nbsp;" + "<A STYLE=TEXT-DECORATION:NONE Href ='JavaScript:Show_OnClick()'><U>Show</U></A>"
            objHeader.HeaderFooter = "Timesheet Status&nbsp;" + CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "SELECT 'Ready for Approval' UNION SELECT 'Approved Timesheet' UNION SELECT 'Rejected Timesheet'", , m_strTimeSheetAllOrCurrent, "OnChange=status_OnChange()", True, True, ) + "&nbsp;&nbsp;&nbsp;&nbsp;" + "Project Name&nbsp;" + CommonFunctions.HTMLControls.DrawComboBox("cboProjectName", "usp_sel_FA_ProjectForTimeSheetListing " + CType(Session("intUserID"), String), , strProjectID, "OnChange=project_OnChange()", True, True, ) + "<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;From Date&nbsp;" + CommonFunctions.HTMLControls.DrawDateControl("FromDate", "FromDate", , , strFromDate, , "frmTimesheetListing", , , , , , , True) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To Date&nbsp;" + CommonFunctions.HTMLControls.DrawDateControl("ToDate", "ToDate", , , strToDate, , "frmTimesheetListing", , , , , , , True) + "&nbsp;&nbsp;" + "<A STYLE=TEXT-DECORATION:NONE Href ='JavaScript:Show_OnClick()'><U>Show</U></A>"
            'End_JG_11783_20-Mar-2007
            'Code modification by Padmnabh A Ends 

            'Response.Write("<font size='2'>Timesheet Status&nbsp;</font>" + CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "SELECT 'Ready for Approval' UNION SELECT 'Approved Timesheet' UNION SELECT 'Rejected Timesheet'", , m_strTimeSheetAllOrCurrent, "OnChange=status_OnChange()", True, True, ) + "&nbsp;&nbsp;&nbsp;&nbsp;")
            'Response.Write("<font size='2'>From Date&nbsp;</font>" + CommonFunctions.HTMLControls.DrawDateControl("FromDate", "FromDate", , , strFromDate, , "frmTimesheetListing", , , , , , , True) + "&nbsp;&nbsp;&nbsp;&nbsp;")
            'Response.Write("<font size='2'>To Date&nbsp;</font>" + CommonFunctions.HTMLControls.DrawDateControl("ToDate", "ToDate", , , strToDate, , "frmTimesheetListing", , , , , , , True) + "&nbsp;&nbsp;")
            'Response.Write("<A STYLE=TEXT-DECORATION:NONE Href ='JavaScript:Show_OnClick()'><U>Show</U></A>")
            objHeader.DrawHeaderFooter()
            Response.Write("<TABLE CellSpacing=0 width='99.9%' height = '10' class=clsTable><TR class=clsTRBlank><TD><TD></TR></TABLE>")
            objHeader = Nothing
            'End Of Addition By VivekP On 3 August 2005 For WhizibleSEM SP4 IssueID-87

            'Display the Timesheet List
            Display_TimesheetList()

        ElseIf m_strMode = MODE_TSDETAILS Then
            'Display the Project Details as a Page Header
            CommonFunctions.General.WriteHTML("<TABLE class=clsTable cellspacing=0 cellpadding=0 width='99.9%'>")
            CommonFunctions.General.WriteHTML("<TR class='clsTRColumnHeader'>")

            CommonFunctions.General.WriteHTML("<TD>")
            CommonFunctions.General.WriteHTML("ID")
            CommonFunctions.General.WriteHTML("</TD>")


            CommonFunctions.General.WriteHTML("<TD>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("PROJECT_NAME"))
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("<TD>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("FROM_DATE"))
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("TO_DATE"))
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("TODAY"))
            CommonFunctions.General.WriteHTML("</TD>")
            'Commented by JyotiG
            'Start_JG_11780_20-Mar-2007
            'Issue :PT: Billing > Timesheet Listing > Billing Information: Select any filter Site or Resource: Invalid Access UI is displayed.
            'Same code is added after Status field
            ''' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197 
            'Response.Write("<TD>")
            'CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_Edit, , , , , , , , , , , , True, )
            'Response.Write("</TD>")
            ''' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197  
            'End_JG_11780_20-Mar-2007
            'Code Added By VivekP On 5 August 2005 For SP4 WhizibleSEM IssueID-87
            CommonFunctions.General.WriteHTML("<TD>")
            CommonFunctions.General.WriteHTML("Status")
            CommonFunctions.General.WriteHTML("</TD>")
            'End Of Addition by vivekP on 5 August 2005 For SP4 WhizibleSEM IssueID-87

            'Added by JyotiG
            'Start_JG_11780_20-Mar-2007
            'Issue :PT: Billing > Timesheet Listing > Billing Information: Select any filter Site or Resource: Invalid Access UI is displayed.
            '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197 
            Response.Write("<TD>")
            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_Edit, , , , , , , , , , , , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            Response.Write("</TD>")
            'End_JG_11780_20-Mar-2007
            '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197  

            CommonFunctions.General.WriteHTML("</TR>")



            CommonFunctions.General.WriteHTML("<TR class='clsTROdd'>")
            CommonFunctions.General.WriteHTML("<TD>")
            CommonFunctions.General.WriteHTML(m_lngTimesheetNo.ToString())
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD>")
            CommonFunctions.General.WriteHTML(Server.HtmlEncode(m_strProjectName))
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD>")
            CommonFunctions.General.WriteHTML(Server.HtmlEncode(CommonFunctions.Dates.CGetDate(CType(m_strFromDate, Date))))
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD>")
            CommonFunctions.General.WriteHTML(Server.HtmlEncode(CommonFunctions.Dates.CGetDate(CType(m_strToDate, Date))))
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD>")
            CommonFunctions.General.WriteHTML(Server.HtmlEncode(CommonFunctions.Dates.CGetDate(Now())))
            CommonFunctions.General.WriteHTML("</TD>")

            'Code Added By VivekP On 5 August 2005 For SP4 WhizibleSEM IssueID-87
            'If Request.QueryString("ToReject") = "ToReject" Then
            '    Call Reject_Timesheet()
            '    Response.Write("<Script language='javascript'>")
            '    Response.Write("window.opener.location.href=window.opener.location.href;")
            '    Response.Write("</Script>")
            'End If
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            ''Dim strcomment As String = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT comments FROM tbl_PM_TimeSheetInvoice WHERE  TimeSheetNo=" + m_lngTimesheetNo.ToString, MyBase.UseSQL), ""), String)
            Dim strcomment As String = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_TimeSheetInvoice_comments " + m_lngTimesheetNo.ToString, MyBase.UseSQL), ""), String)
            ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            CommonFunctions.General.WriteHTML("<TD>")
            CommonFunctions.General.WriteHTML(Server.HtmlEncode(Trim(strTimesheetStatus)))
            CommonFunctions.General.WriteHTML("</TD>")

            'End Of Addition by vivekP on 5 August 2005 For SP4 WhizibleSEM IssueID-87

            CommonFunctions.General.WriteHTML("</TR>")
            CommonFunctions.General.WriteHTML("</TABLE>")
            CommonFunctions.General.WriteHTML("<BR>")

            CommonFunctions.General.WriteHTML("<DIV id=PageDiv style='overflow:auto;width:100%'>")

            'Display the Timesheet Details List
            Display_TimesheetDetailsList()

            ' Display the Text area of comments
            'Code Comemnted by VivekP On 11 August 2005 IssueID-87
            'Display_ControlForComments()
            'Code commenting Ends by VivekP On 11 August 2005 IssueID-87

            CommonFunctions.General.WriteHTML("</DIV>")
        End If

        'Code Added By VivekP On 8 August 2005 For WhizibleSEM Sp4 IssueID-87
        If Request.QueryString("Mode") <> "ApproveOrReject" Then
            'Display the Menu at the Bottom
            CommonFunctions.General.WriteHTML("<BR>")
            CommonFunctions.General.WriteHTML(strMenu)
            'CommonFunctions.General.WriteHTML("<BR>") Commented By Vaijat K ON 03/12/2015
        End If
        If Request.QueryString("ToApprove") = "ToApprove" Then
            Call PlotGridApprovedOrReject()
        End If
        If Request.QueryString("ToReject") = "ToReject" Then
            Call PlotGridApprovedOrReject()
        End If
        'End Of Addition By VivekP On 8 August 2005 For WhizibleSEM Sp4 IssueID-87

    End Sub

    Public Sub New()
        'Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.InitializeResources("AppResources.FA_TimesheetListing", "AppResources")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "FA_TimesheetListing : " & UserInput & " " & Cause
        Throw ex
    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objGrid = Nothing
        m_objMenu = Nothing
        m_objAccessRights = Nothing
        m_objGlobal = Nothing
    End Sub

    Private Sub InitPageMenu()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        m_arrMenuItem(MenuIndex.AUTHENTICATE) = MyBase.GetResourceString("MENU_AUTHENTICATE")
        m_arrMenuTooltip(MenuIndex.AUTHENTICATE) = MyBase.GetResourceString("MENU_AUTHENTICATE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.AUTHENTICATE) = "Authenticate_OnClick()"

        'Code Added By vivekP On 2 August 2005 For WhizibleSEM SP4 IssueID-87
        MyBase.InitializeResources("AppResources.FA_TimesheetListing", "AppResources")

        m_arrMenuItem(MenuIndex.REJECTFROMLIST) = MyBase.GetResourceString("REJECT")
        m_arrMenuTooltip(MenuIndex.REJECTFROMLIST) = MyBase.GetResourceString("REJECT")
        m_arrClientSideFunctions(MenuIndex.REJECTFROMLIST) = "RejectFromList_OnClick()"


        m_arrMenuItem(MenuIndex.SELECTALL) = "Select All"
        m_arrMenuTooltip(MenuIndex.SELECTALL) = "Select All"
        m_arrClientSideFunctions(MenuIndex.SELECTALL) = "SelectAll_OnClick('frmTimesheetListing', 'chkAuthenticate')"

        m_arrMenuItem(MenuIndex.CLEARALL) = "Clear All"
        m_arrMenuTooltip(MenuIndex.CLEARALL) = "Clear All"
        m_arrClientSideFunctions(MenuIndex.CLEARALL) = "ClearAll_OnClick('frmTimesheetListing', 'chkAuthenticate')"


        m_arrMenuItem(MenuIndex.BACK) = "Back"
        m_arrMenuTooltip(MenuIndex.BACK) = "Back"
        m_arrClientSideFunctions(MenuIndex.BACK) = "Back_OnClick()"


        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        'End Of addition by VivekP On 2 August 2005 For SP4 WhizibleSEM IssueID-87


        m_arrMenuItem(MenuIndex.DELETE) = MyBase.GetResourceString("MENU_DELETE")
        m_arrMenuTooltip(MenuIndex.DELETE) = MyBase.GetResourceString("MENU_DELETE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.DELETE) = "Delete_OnClick()"



        m_arrMenuItem(MenuIndex.SEND) = MyBase.GetResourceString("MENU_SEND")
        m_arrMenuTooltip(MenuIndex.SEND) = MyBase.GetResourceString("MENU_SEND_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SEND) = "Send_OnClick()"

        'Code Added By vivekP On 2 August 2005 For WhizibleSEM SP4 IssueID-87
        MyBase.InitializeResources("AppResources.FA_TimesheetListing", "AppResources")

        m_arrMenuItem(MenuIndex.REJECT) = MyBase.GetResourceString("REJECT")
        m_arrMenuTooltip(MenuIndex.REJECT) = MyBase.GetResourceString("REJECT")
        m_arrClientSideFunctions(MenuIndex.REJECT) = "Reject_OnClick()"
        'End Of addition by VivekP On 2 August 2005 For SP4 WhizibleSEM IssueID-87

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")


        m_arrMenuItem(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE")
        m_arrMenuTooltip(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CLOSE) = "Close_OnClick()"

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick('" & m_strHelpId & "')"

        MyBase.InitializeResources("AppResources.FA_TimesheetListing", "AppResources")

        m_arrMenuItem(MenuIndex.APPROVE) = MyBase.GetResourceString("APPROVE")
        m_arrMenuTooltip(MenuIndex.APPROVE) = MyBase.GetResourceString("APPROVE")
        m_arrClientSideFunctions(MenuIndex.APPROVE) = "AuthenticateDetailPage_OnClick()"

        m_arrMenuItem(MenuIndex.VIEW_COMMENT) = MyBase.GetResourceString("VIEW_COMMENT")
        m_arrMenuTooltip(MenuIndex.VIEW_COMMENT) = MyBase.GetResourceString("VIEW_COMMENT")
        m_arrClientSideFunctions(MenuIndex.VIEW_COMMENT) = "View_Comment_OnClick()"

    End Sub
    Private Sub Reject_Timesheet()
        'Created By - vivekP IssueID-87
        'Created on - 2 August 2005 
        'Purpose - For WhizibleSEM SP4
        Dim strTimeSheetsNos As String
        Dim intCount As Integer
        Dim arrTimesheetNo() As String
        Dim strcomment As String = ""
        Dim stremployeename As String
        strTimeSheetsNos = Request.QueryString("TimesheetList").ToString

        strTimesheetIDs = ""
        If strTimeSheetsNos <> "" Then
            arrTimesheetNo = strTimeSheetsNos.Split(CType(",", Char))
            For intCount = 0 To arrTimesheetNo.Length - 2

                strcomment = MyBase.FixString(MyBase.GetFormValue("Comment" + arrTimesheetNo(intCount).ToString()), 0, False, False)

                Dim stRejectSQL As String = ""
                Dim strMailTo As String = ""
                Dim strFromMail As String = ""
                Dim strSubject As String = ""
                Dim strMessage As String = ""
                Dim drEmailMessage As IDataReader
                Dim strCCToEmailID As String = ""
                Dim blnSendEmail As Boolean

                Dim blnShowPopup As Boolean


                Dim drTSAuthenticatedBy As IDataReader
                Dim drReciever As IDataReader

                drTSAuthenticatedBy = CommonFunction.Data.GetDataReader("EXEC usp_Sel_TimeSheetAuthenticationType " + arrTimesheetNo(intCount).ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                If drTSAuthenticatedBy.Read Then

                    If drTSAuthenticatedBy("AuthenticatedBy").ToString = "C" Then
                        ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                        ''stremployeename = CType(CommonFunctions.Data.GetDataScalar("SELECT CustomerName FROM tbl_PM_Customer WHERE Customer=(SELECT CustomerID FROM tbl_PM_Project WHERE ProjectID=(SELECT ProjectID FROM tbl_PM_TimesheetInvoice WHERE TimesheetNo=" + arrTimesheetNo(intCount).ToString() + "))", True), String)
                        stremployeename = CType(CommonFunctions.Data.GetDataScalar("usp_sel_CustomerName_tbl_PM_Customer " + arrTimesheetNo(intCount).ToString() + "))", True), String)
                        ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                        drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 5", MyBase.UseSQL)
                        If drEmailMessage.Read Then
                            blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                            blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                        End If
                        CommonFunction.Data.DisposeDataReader(drEmailMessage)
                        If blnSendEmail = True And blnShowPopup = True Then
                            Response.Write("<Script language='javascript'>")
                            CommonFunctions.General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=5&TimeSheetID=" + arrTimesheetNo(intCount).ToString() + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')" + vbCrLf)
                            Response.Write("</Script>")
                        End If

                        If blnSendEmail = True And blnShowPopup = False Then
                            CommonFunction.EmailMessages.FAMessages.GetEmailMessage_5(strFromMail, strMailTo, strCCToEmailID, strSubject, strMessage, CType(arrTimesheetNo(intCount), Long))
                            CommonFunction.Emails.AppSendEmail(strMailTo, strFromMail, strSubject, strMessage)
                        End If



                    Else
                        ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                        ''stremployeename = CType(CommonFunctions.Data.GetDataScalar("SELECT EmployeeName FROM tbl_PM_Employee WHERE EmployeeID=" + CType(Session("intUserID"), String), True), String)
                        stremployeename = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Employee_EmployeeName " + CType(Session("intUserID"), String), True), String)
                        ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                        drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 442", MyBase.UseSQL)
                        If drEmailMessage.Read Then
                            blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                            blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                        End If
                        CommonFunction.Data.DisposeDataReader(drEmailMessage)
                        If blnSendEmail = True And blnShowPopup = True Then
                            Response.Write("<Script language='javascript'>")
                            CommonFunctions.General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=442&TimeSheetID=" + arrTimesheetNo(intCount).ToString() + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')" + vbCrLf)
                            Response.Write("</Script>")
                        End If

                        If blnSendEmail = True And blnShowPopup = False Then
                            CommonFunction.EmailMessages.FAMessages.GetEmailMessage_442(strFromMail, strMailTo, strCCToEmailID, strSubject, strMessage, CType(arrTimesheetNo(intCount), Long))
                            CommonFunction.Emails.AppSendEmailWithCC(strMailTo, strFromMail, strCCToEmailID, strSubject, strMessage)
                        End If

                    End If

                End If
                CommonFunction.Data.DisposeDataReader(drTSAuthenticatedBy)
                'Integrated by Truptik on 19-May-09
                'Added by SonalD on 11th April 2009 For IssueID 30031
                'Purpose : To replace single quote by double quote
                stremployeename = Replace(stremployeename, "'", "''")
                'End of addition by SonalD on 11th April 2009 For IssueID 30031
                'End of integration by TruptiK
                stRejectSQL = "usp_Upd_tbl_PM_TimeSheetInvoice_For_Rejection " + arrTimesheetNo(intCount).ToString() + ",'" + strcomment + "','" + stremployeename + "'"
                CommonFunctions.Data.InsertOrUpdateData(stRejectSQL, MyBase.UseSQL)
            Next
        End If
      
    End Sub

#Region " Procedures/Functions Specific to Timesheet Listing Mode "
    Private Sub Display_TimesheetList()
        Dim strQuery As String = ""
        Dim intColumnCount As Integer = 12
        Dim arrActualColumns(intColumnCount - 1) As String
        Dim arrUserFriendlyColumn(intColumnCount - 1) As String
        Dim arrRowLink() As String = {"Number_OnClick(TimeSheetNo)", ""}
        Dim arrCheckboxId(intColumnCount - 1) As String
        Dim arrTDStyle(intColumnCount - 1) As String
        Dim intIndex As Integer = 0
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'Column-1 Timesheet No
        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("TIMESHEET_NO")
        arrActualColumns(intIndex) = "TimeSheetNo"
        arrCheckboxId(intIndex) = ""
        arrTDStyle(intIndex) = "align='left' width='7%'"
        intIndex += 1
        'Column-2 Sub Project Name
        arrUserFriendlyColumn(intIndex) = m_strSubProjectCaption
        arrActualColumns(intIndex) = "SubProjectName"
        arrCheckboxId(intIndex) = ""
        arrTDStyle(intIndex) = "align='left' width='10%'"
        intIndex += 1
        'Column-3 Created Date
        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("DATE")
        arrActualColumns(intIndex) = "CreatedDate1"
        arrCheckboxId(intIndex) = ""
        arrTDStyle(intIndex) = "align=left nowrap width='18%'"
        intIndex += 1
        'Column-4 Project Name
        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("PROJECT")
        arrActualColumns(intIndex) = "ProjectName"
        arrCheckboxId(intIndex) = ""
        arrTDStyle(intIndex) = "align='left' align='15%'"
        intIndex += 1
        'Column-5 From Date
        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("FROM_DATE")
        arrActualColumns(intIndex) = "FromDate"
        arrCheckboxId(intIndex) = ""
        arrTDStyle(intIndex) = "align=center nowrap width='10%'"
        intIndex += 1
        'Column-6 To Date
        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("TO_DATE")
        arrActualColumns(intIndex) = "ToDate"
        arrCheckboxId(intIndex) = ""
        arrTDStyle(intIndex) = "align=center nowrap width='10%'"
        intIndex += 1
        'Column-7 Timesheet Hours
        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("TIMESHEET_HRS")
        arrActualColumns(intIndex) = "TotalTimeSheetHours"
        arrCheckboxId(intIndex) = ""
        arrTDStyle(intIndex) = "align=right width='8%'"
        intIndex += 1
        'Column-8 Invoice No
        'Commented by PrashantSJ on 21st Aug 2007
        'Purpose: no use of this field and which is never been updated
        'arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("INVOICE_NO")
        'arrActualColumns(intIndex) = "InvoiceNo"
        'arrCheckboxId(intIndex) = ""
        'arrTDStyle(intIndex) = "align=right width='8%'"
        'intIndex += 1
        'End of comment by PrashantSJ on 21st Aug 2007

        'Added By  VivekP On 2 August 2005 for SP4 WhizibleSEM IssueID-87
        arrUserFriendlyColumn(intIndex) = "Status"
        arrActualColumns(intIndex) = "TimesheetStatus"
        arrCheckboxId(intIndex) = ""
        arrTDStyle(intIndex) = "align='left' width='8%'"
        intIndex += 1
        'End OF Addition By  VivekP On 2 August 2005 for SP4 WhizibleSEM IssueID-87

        ' Code added by SwapnilR on 8 Dec 2004
        'Column - 9 Billing Report
        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("BILLING_INFO")
        arrActualColumns(intIndex) = ""
        arrCheckboxId(intIndex) = ""
        arrTDStyle(intIndex) = "align='left' align='15%'"
        intIndex += 1
        ' Column - 10 Printing Report
        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("REPORT")
        arrActualColumns(intIndex) = ""
        arrCheckboxId(intIndex) = ""
        arrTDStyle(intIndex) = "align='left' align='15%'"
        intIndex += 1
        ' End of code addtion by SwapnilR 
        'Modified by VivekP On 2 August 2005 for SP4 WhizibleSEM IssueID-87
        'Column-11 AUTHENTICATE
        arrUserFriendlyColumn(intIndex) = "Select"
        arrActualColumns(intIndex) = ""
        arrCheckboxId(intIndex) = "chkAuthenticate"
        arrTDStyle(intIndex) = "align='center' width='8%'"
        intIndex += 1
        'End Of Modification  by VivekP On 2 August 2005 for SP4 WhizibleSEM IssueID-87
        'Column-12 DELETE

        'Code Commented by VivekP On 2 August 2005 for SP4 WhizibleSEM IssueID-87

        'arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("DELETE")
        'arrActualColumns(intIndex) = ""
        'arrCheckboxId(intIndex) = "chkDelete"
        'arrTDStyle(intIndex) = "align='center' width='8%'"
        'intIndex += 1

        'Code commenting End by VivekP On 2 August 2005 for SP4 WhizibleSEM IssueID-87

        'Get the Query to plot the Grid
        strQuery = BuildTimeSheetQuery()

        'Set the Grid Properties
        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .RowLinkArray = arrRowLink
            .CheckBoxIDArray = arrCheckboxId
            .TDStyleArray = arrTDStyle
            .PrimaryKey = "TimeSheetNo"
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "PageDiv"
            .DIVHeight = 230            
            .DIVStyle = "overflow:auto;width:100%"
            .NoOfDataColumns = intColumnCount - 3
            .EmptyValueReplacement = "&nbsp;"
            .returnHTML = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
    End Sub
    Private Sub PlotGridApprovedOrReject()
        'Created by VivekP IssueID-87
        'Created On 8 August 2005 
        'Purpose-For WhizibleSEM SP4
        Dim strTimeSheetsNos As String
        Dim arrTimesheetNo As String()
        Dim intCount As Integer
        Dim strQuery As String
        Dim strMenu As String = ""
        Dim drTimesheet As IDataReader
        Dim intRowCount As Integer = 0
        Dim strTrClass As String
        Dim strTimesheetNo As String
        Dim strFromDateAppR As String
        Dim strToDateAppR As String
        Dim strProjectName As String
        Dim arrMenuItem() As String
        Dim arrMenuTooltip() As String
        Dim arrClientSideFunctions() As String
        Dim strComments As String = ""

        If Request.QueryString("FromDetail") = "FromDetail" Then
            strTimeSheetsNos = Request.QueryString("TimesheetNo_PK") + ","
            strTimeSheetList = Request.QueryString("TimesheetNo_PK") + ","
        Else
            strTimeSheetsNos = Request.QueryString("concatedlist")
            strTimeSheetList = Request.QueryString("concatedlist")
        End If

        If strTimeSheetsNos = "" Then
            strTimeSheetsNos = ""
        End If

        Dim objMenu As New WebPages.Template.StaticMenu

        If Request.QueryString("ToApprove") = "ToApprove" Then
            strComments = "Approved On " + CommonFunction.Dates.GetDate(Now())
            arrMenuItem = New String() {"Approve", "Close", "?"}
            arrMenuTooltip = New String() {"Approve", "Close", "?"}
            arrClientSideFunctions = New String() {"FinalAuthenticate_OnClick()", "Close_OnClick()", "Help_OnClick('" & m_strHelpId & "')"}
        End If
        If Request.QueryString("ToReject") = "ToReject" Then
            arrMenuItem = New String() {"Reject", "Close", "?"}
            arrMenuTooltip = New String() {"Reject", "Close", "?"}
            arrClientSideFunctions = New String() {"FinalReject_OnClick()", "Close_OnClick()", "Help_OnClick('" & m_strHelpId & "')"}
        End If
        'strTimeSheetsNos = MyBase.FixString(MyBase.GetFormValue("chkAuthenticate"), 0, False, False)
        arrTimesheetNo = strTimeSheetsNos.Split(CType(",", Char))

        'Response.Write("<TITLE>Timesheet Details</TITLE>")

        'Write page legend
        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}



        strMenu = objMenu.DrawMenu(arrMenuItem, arrClientSideFunctions, arrMenuTooltip, True)
        CommonFunctions.General.WriteHTML(strMenu)
        Response.Write(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend, True))

        'Response.Write("<TABLE CellSpacing=0 width='100%' height = '10' class=clsTable><TR class=clsTRBlank><TD><TD></TR></TABLE>")

        CommonFunction.General.WriteHTML("<DIV ID='DIVLIST' STYLE='OVERFLOW:auto;WIDTH:100%;HEIGHT=430px'>")

        CommonFunction.General.WriteHTML("<TABLE name=TimesheetListTable id=EmployeeListTable CellSpacing=0 Class=clsTable Width='99.9%' >")


        ' Plot the Header Row 

        CommonFunction.General.WriteHTML("<TR class=clsTRPageCaption>")

        ' Timesheet No
        CommonFunction.General.WriteHTML("<TD align ='Left'>")

        CommonFunction.General.WriteHTML("Timesheet No")

        CommonFunction.General.WriteHTML("</TD>")

        ' Project Name
        CommonFunction.General.WriteHTML("<TD align ='Left'>")

        CommonFunction.General.WriteHTML("Project Name")

        CommonFunction.General.WriteHTML("</TD>")


        'From Date
        CommonFunction.General.WriteHTML("<TD align ='Left'>")

        CommonFunction.General.WriteHTML("From Date")

        CommonFunction.General.WriteHTML("</TD>")




        'To Date
        CommonFunction.General.WriteHTML("<TD align ='Left'>")

        CommonFunction.General.WriteHTML("To Date")

        CommonFunction.General.WriteHTML("</TD>")

        ' Comments
        CommonFunction.General.WriteHTML("<TD align ='Left'>")

        CommonFunction.General.WriteHTML("Comments")

        CommonFunction.General.WriteHTML("</TD>")

        '' START : Added By ParagD on 3-Oct-2006 : Security Issue 6197
        If Request.QueryString("FromDetail") = "FromDetail" Then
            m_PKToken_Edit = CommonFunctions.Security.Token.GetToken(strTimeSheetsNos.ToString + CType(Session("intUserID"), String) + "0" + "42")
        Else
            m_PKToken_Edit = CommonFunctions.Security.Token.GetToken(m_lngProjectId.ToString + CType(Session("intUserID"), String) + "0" + "42")
        End If

        If Request.QueryString("FromDetail") = "FromDetail" Then
            If (Trim(m_PKToken_Edit & "") = "" And CommonFunctions.Security.Token.ValidateToken(strTimeSheetsNos.ToString + CType(Session("intUserID"), String) + "0" + "42", m_PKToken_Edit) = False) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Project Timesheet Easy Edit", 0, 0, "Timesheet No", m_lngProjectId.ToString)
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        Else
            If (Trim(m_PKToken_Edit & "") = "" And CommonFunctions.Security.Token.ValidateToken(m_lngProjectId.ToString + CType(Session("intUserID"), String) + "0" + "42", m_PKToken_Edit) = False) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Project Timesheet Easy Edit", 0, 0, "Timesheet No", strTimesheetNo)
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If
  
        Response.Write("<TD>")
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding


        CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_Edit, , , , , , , , , , , , True, EnableHTMLEncode:=True)


        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        Response.Write("</TD>")
        '' END : Added By ParagD On 03-Oct-2006 : Security Issue 6197


        CommonFunction.General.WriteHTML("</TR>")

        For intCount = 0 To arrTimesheetNo.Length - 1
            strQuery = "usp_sel_tbl_PM_TimeSheetInvoiceForApproveOrReject  '" & arrTimesheetNo(intCount).ToString() & "'"
            drTimesheet = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)

            If intRowCount Mod 2 = 0 Then
                strTrClass = "clsTROdd"
            Else
                strTrClass = "clsTREven"
            End If

            If drTimesheet.Read Then

                strTimesheetNo = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drTimesheet("TimesheetNo"), ""), "")
                strFromDateAppR = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drTimesheet("FromDate"), ""), "")
                strToDateAppR = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drTimesheet("ToDate"), ""), "")
                strProjectName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drTimesheet("ProjectName"), ""), "")



                CommonFunction.General.WriteHTML("<TR class='" + strTrClass + "'>")

                ' Timesheet No
                CommonFunction.General.WriteHTML("<TD align ='Left'>")

                CommonFunction.General.WriteHTML(strTimesheetNo)

                CommonFunction.General.WriteHTML("</TD>")


                ' Project Name
                CommonFunction.General.WriteHTML("<TD align ='Left'>")

                CommonFunction.General.WriteHTML(strProjectName)

                CommonFunction.General.WriteHTML("</TD>")

                ' From date
                CommonFunction.General.WriteHTML("<TD align ='Left'>")

                CommonFunction.General.WriteHTML(CommonFunctions.Dates.GetDate(CType(strFromDateAppR, Date)))

                CommonFunction.General.WriteHTML("</TD>")

                ' To date
                CommonFunction.General.WriteHTML("<TD align ='Left'>")

                CommonFunction.General.WriteHTML(CommonFunctions.Dates.GetDate(CType(strToDateAppR, Date)))

                CommonFunction.General.WriteHTML("</TD>")



                ' Start Date
                CommonFunction.General.WriteHTML("<TD align ='Left'>")
                ''Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'Response.Write(CommonFunction.HTMLControls.DrawTextArea("Comment" + arrTimesheetNo(intCount).ToString(), "Comment" + arrTimesheetNo(intCount).ToString(), "Comment", , "opentextdialog", "frmTimesheetListing", , , 295, 50, , strComments, , , , , , , , True, True, , ))
                Response.Write(CommonFunction.HTMLControls.DrawTextArea("Comment" + arrTimesheetNo(intCount).ToString(), "Comment" + arrTimesheetNo(intCount).ToString(), "Comment", , "opentextdialog", "frmTimesheetListing", , , 295, 50, , strComments, , , , , , , , True, True, , , EnableHTMLEncode:=True))
                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                CommonFunction.General.WriteHTML("</TD>")

                CommonFunction.General.WriteHTML("</TR>")
            End If
            intRowCount += 1
        Next

        CommonFunction.General.WriteHTML("</TABLE>")
        CommonFunction.General.WriteHTML("</DIV>")

        Response.Write("<TABLE CellSpacing=0 width='99.9%' height = '10' class=clsTable><TR class=clsTRBlank><TD><TD></TR></TABLE>")
        strMenu = objMenu.DrawMenu(arrMenuItem, arrClientSideFunctions, arrMenuTooltip, True)
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.Data.DisposeDataReader(drTimesheet)
    End Sub

    Private Function BuildTimeSheetQuery() As String
        '==================================================================================
        ' Procedure Name	:	BuildTimeSheetQuery
        ' Purpose			:	This procedure build the Query to get the Timesheets List
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Jayavant
        ' Created			:	16-Mar-2004
        ' Revisions			:	
        '==================================================================================
        Dim strCurrentOrAll As String = ""  'If Current then has value "1" else "0"
        Dim strQuery As String = ""

        'Modified by VivekP On 3 August 2005 For WhizibleSEM SP4 IssueID-87
        Dim strDate As String = ""
        Dim strDateval As String = ""
        'If m_strTimeSheetAllOrCurrent = TIMESHEET_CURRENT Then
        '    strCurrentOrAll = "1"
        'Else
        '    strCurrentOrAll = "0"
        '    strAllTimesheet = "YES"
        'End If
        If m_strTimeSheetAllOrCurrent = TIMESHEET_CURRENT Then
            strCurrentOrAll = "1"
        End If
        If m_strTimeSheetAllOrCurrent = "Approved Timesheet" Then
            strCurrentOrAll = "0"
            strAllTimesheet = "YES"
        End If
        If m_strTimeSheetAllOrCurrent = "Rejected Timesheet" Then
            strCurrentOrAll = "2"
            strAllTimesheet = "YES"
            strRejectedStatus = "RejectedTimesheet"
        End If
        If m_strTimeSheetAllOrCurrent = "" Then
            strCurrentOrAll = "3"
            strAllTimesheet = "YES"
        End If
        If strProjectID = "" Then
            strProjectID = "NULL"
        End If
        If strFromDate <> "" Then
            strDate = ",NULL,NULL,'" + strFromDate + "','" + strToDate + "'," + strProjectID
            strDateval = ",'" + strFromDate + "','" + strToDate + "'," + strProjectID
        Else
            strDate = ",NULL,NULL,NULL,NULL," + strProjectID
            strDateval = ",NULL,NULL," + strProjectID
        End If



        If m_objGlobal.LoginType = "E" Then
            If strDate <> "" Then
                strQuery = "usp_Sel_tbl_PM_TimeSheetInvoice " & strCurrentOrAll & strDate & "," & CType(Session("intUserID"), String)
            Else
                strQuery = "usp_Sel_tbl_PM_TimeSheetInvoice " & strCurrentOrAll & strDate & "," & CType(Session("intUserID"), String)
            End If
            'End Of Modification by VivekP On 3 August 2005 For WhizibleSEM SP4 IssueID-87
        ElseIf m_objGlobal.IsCustomerCreated = False Then
            If strDateval <> "" Then
                strQuery = "EXEC usp_Sel_CustomerTimeSheets " & strCurrentOrAll & "," & m_objGlobal.UserID.ToString() & ", 0, NULL" & strDateval
            Else
                strQuery = "EXEC usp_Sel_CustomerTimeSheets " & strCurrentOrAll & "," & m_objGlobal.UserID.ToString() & ", 0, NULL" & strDateval
            End If
        Else
            If strDateval <> "" Then
                strQuery = "EXEC usp_Sel_CustomerTimeSheets " & strCurrentOrAll & "," & m_objGlobal.UserID.ToString() & ", 1, " & Session.Item("CustomerCreatedLoginID").ToString() & strDateval
            Else
                strQuery = "EXEC usp_Sel_CustomerTimeSheets " & strCurrentOrAll & "," & m_objGlobal.UserID.ToString() & ", 1, " & Session.Item("CustomerCreatedLoginID").ToString() & strDateval
            End If
        End If

        Return (strQuery)
    End Function

    Private Sub Authenticate_Timesheet()
        '==================================================================================
        ' Procedure Name	:	Authenticate_Timesheet
        ' Purpose			:	This procedure Autheticate the Selected Timesheets.
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Jayavant
        ' Created			:	16-Mar-2004
        ' Revisions			:	
        '==================================================================================
        Dim strQuery As String = ""
        Dim strTimeSheetsNos As String = ""
        Dim arrTimesheetNo() As String
        Dim intCount As Integer = 0
        Dim stremployeename As String
        'Modified by VivekP On 3 August 2005 For WhizibleSEm SP4 IssueID-87
        Dim strcomment As String = ""
        If Request.QueryString("DetailAuhenticate") = "DetailAuhenticate" Then
            strTimeSheetsNos = Request.QueryString("TimeSheetNo") + ","
            'Response.Write("<Script language='javascript'>" + vbCrLf)
            'CommonFunctions.General.WriteHTML("var openerpath=window.opener.location.href;" + vbCrLf)
            'CommonFunctions.General.WriteHTML("window.opener.location.href=openerpath+'&AfterReject=AfterReject';" + vbCrLf)
            'CommonFunctions.General.WriteHTML("window.close();")
            'Response.Write("</Script>")
        Else
            'strTimeSheetsNos = MyBase.FixString(MyBase.GetFormValue("chkAuthenticate"), 0, False, False)
            strTimeSheetsNos = Request.QueryString("TimesheetList").ToString
        End If

        '' START : ParagD On 29-Sept-2006
        If strTimeSheetsNos <> "" Then
            arrTimesheetNo = strTimeSheetsNos.Split(CType(",", Char))
            For intCount = 0 To arrTimesheetNo.Length - 2
                m_strTimesheetStatus_ApproveORReject = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("select TimesheetStatus From v_tbl_PM_TimeSheetInvoice Where TimeSheetNo=" & arrTimesheetNo(intCount).ToString(), MyBase.UseSQL), ""), String)

                If m_strTimesheetStatus_ApproveORReject.ToUpper <> "APPROVED" And m_strTimesheetStatus_ApproveORReject.ToUpper <> "REJECTED" Then

                    ''strTimeSheetsNos = MyBase.FixString(MyBase.GetFormValue("chkAuthenticate"), 0, False, False)
                    'If strTimeSheetsNos <> "" Then
                    '    arrTimesheetNo = strTimeSheetsNos.Split(CType(",", Char))
                    '    For intCount = 0 To arrTimesheetNo.Length - 2

                    strcomment = MyBase.FixString(MyBase.GetFormValue("Comment" + arrTimesheetNo(intCount).ToString()), 0, False, False)


                    Dim strMailTo As String = ""
                    Dim strFromMail As String = ""
                    Dim strSubject As String = ""
                    Dim strMessage As String = ""
                    Dim drEmailMessage As IDataReader
                    Dim strCCToEmailID As String = ""
                    Dim blnSendEmail As Boolean

                    Dim blnShowPopup As Boolean


                    Dim drTSAuthenticatedBy As IDataReader
                    Dim drReciever As IDataReader

                    drTSAuthenticatedBy = CommonFunction.Data.GetDataReader("EXEC usp_Sel_TimeSheetAuthenticationType " + arrTimesheetNo(intCount).ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    If drTSAuthenticatedBy.Read Then

                        If drTSAuthenticatedBy("AuthenticatedBy").ToString = "C" Then

                            stremployeename = CType(CommonFunctions.Data.GetDataScalar("SELECT CustomerName FROM tbl_PM_Customer WHERE Customer=(SELECT CustomerID FROM tbl_PM_Project WHERE ProjectID=(SELECT ProjectID FROM tbl_PM_TimesheetInvoice WHERE TimesheetNo=" + arrTimesheetNo(intCount).ToString() + "))", True), String)

                            drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 4", MyBase.UseSQL)
                            If drEmailMessage.Read Then
                                blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                                blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                            End If
                            CommonFunction.Data.DisposeDataReader(drEmailMessage)
                            If blnSendEmail = True And blnShowPopup = True Then
                                Response.Write("<Script language='javascript'>")
                                CommonFunctions.General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=4&TimeSheetID=" + arrTimesheetNo(intCount).ToString() + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')" + vbCrLf)
                                Response.Write("</Script>")
                            End If

                            If blnSendEmail = True And blnShowPopup = False Then
                                CommonFunction.EmailMessages.FAMessages.GetEmailMessage_4(strFromMail, strMailTo, strCCToEmailID, strSubject, strMessage, CType(arrTimesheetNo(intCount), Long))
                                CommonFunction.Emails.AppSendEmail(strMailTo, strFromMail, strSubject, strMessage)
                            End If

                        Else
                            stremployeename = CType(CommonFunctions.Data.GetDataScalar("SELECT EmployeeName FROM tbl_PM_Employee WHERE EmployeeID=" + CType(Session("intUserID"), String), True), String)
                            SendMailToCustomer(CType(arrTimesheetNo(intCount), Long))
                        End If

                    End If
                    CommonFunctions.Data.DisposeDataReader(drTSAuthenticatedBy)
                    ' Modified by Nitinvs on 30 Jun 2009 to handle single quote 
                    strQuery = "usp_Upd_tbl_PM_TimeSheetInvoice '" & arrTimesheetNo(intCount).ToString() & "','" & strcomment & "','" + CommonFunction.General.BuildQueryString(stremployeename) + "'"
                    ' end Modification by NitinVs on 30 jun 2009 to Handle single quote 
                    CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                Else
                    strTimesheetIDs = strTimesheetIDs & arrTimesheetNo(intCount).ToString() & ","
                End If
            Next
        End If
        If strTimesheetIDs <> "" Then
            Response.Write(" <SCRIPT> alert('" + " These Timesheets : " + Left(strTimesheetIDs, strTimesheetIDs.Length - 1) + " are already " + " Approved ! ""'); </SCRIPT>")
        End If
        strTimesheetIDs = ""
        '' END : ParagD On 29-Sept-2006 


        If Request.QueryString("FinalApproved") = "FinalApproved" Then
            'Response.Write("<Script language='javascript'>" + vbCrLf)
            'CommonFunctions.General.WriteHTML("var parent=window.opener.opener;" + vbCrLf)
            'CommonFunctions.General.WriteHTML("if(parent!=null){" + vbCrLf)
            'CommonFunctions.General.WriteHTML("window.opener.opener.location.href=window.opener.opener.location.href;" + vbCrLf)
            'CommonFunctions.General.WriteHTML("}" + vbCrLf)
            'CommonFunctions.General.WriteHTML("var openerpath=window.opener.location.href;" + vbCrLf)
            'CommonFunctions.General.WriteHTML("window.opener.location.href=openerpath;" + vbCrLf)
            'CommonFunctions.General.WriteHTML("window.close();")
            'Response.Write("</Script>")
            Response.Write("<Script language='javascript'>")
            CommonFunctions.General.WriteHTML("var parent=window.opener.opener;" + vbCrLf)
            CommonFunctions.General.WriteHTML("if(parent!=null){" + vbCrLf)
            CommonFunctions.General.WriteHTML("window.opener.opener.location.href=window.opener.opener.location.href;" + vbCrLf)
            Response.Write("window.opener.close();")
            Response.Write("window.close();")
            CommonFunctions.General.WriteHTML("}else{" + vbCrLf)
            Response.Write("window.opener.location.href=window.opener.location.href;")
            Response.Write("window.close();")
            CommonFunctions.General.WriteHTML("}" + vbCrLf)
            Response.Write("</Script>")
        End If

        'End Of Modification By VivekP 3 August 2005 For WhizibleSEm SP4 IssueID-87
    End Sub

    Private Sub Delete_Timesheets()
        '==================================================================================
        ' Procedure Name	:	Delete_Timesheets
        ' Purpose			:	This procedure delete the Selected Timesheets from the Database.
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Jayavant
        ' Created			:	16-Mar-2004
        ' Revisions			:	
        '==================================================================================
        Dim strQuery As String = ""
        Dim strTimeSheetsNos As String = ""
        Dim arrTimesheetNo() As String
        Dim intCount As Integer = 0

        strTimeSheetsNos = MyBase.FixString(MyBase.GetFormValue("chkDelete"), 0, False, False)
        If strTimeSheetsNos <> "" Then
            arrTimesheetNo = strTimeSheetsNos.Split(CType(",", Char))
            For intCount = 0 To arrTimesheetNo.Length - 1
                strQuery = "Exec usp_DeleteTimeSheet " & arrTimesheetNo(intCount).ToString()
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            Next
        End If
    End Sub

    Private Sub SendMailToCustomer(ByVal lngTimeSheetId As Long)
        '==================================================================================
        ' Procedure Name	:	SendMailToCustomer
        ' Purpose			:	This procedure Send the EMail to the Customer.
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Jayavant
        ' Created			:	16-Mar-2004
        ' Revisions			:	
        '==================================================================================
        Dim strMailTo As String = ""
        Dim strFromMail As String = ""
        Dim strSubject As String = ""
        Dim strMessage As String = ""
        Dim strCCEamilID As String = ""

        'Modified  By VivekP On 2 August 2005 For WhizibleSEM SP4 IssueID-87
        Dim drEmailMessage As IDataReader
        Dim blnSendEmail As Boolean
        Dim blnShowPopup As Boolean
        drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 6", MyBase.UseSQL)
        If drEmailMessage.Read Then
            blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
            blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
        End If
        CommonFunction.Data.DisposeDataReader(drEmailMessage)
        If blnSendEmail = True And blnShowPopup = True Then
            Response.Write("<Script language='javascript'>")
            'Response.Write("window.open('../General/SendEmail.aspx?MessageID=6&TimeSheetID=" + lngTimeSheetId.ToString + "', , 'resizable=no,scrollbars=no,toolbar=no,statusbar=no,left='+(window.screen.width - 600)/2,+'top='+(window.screen.height - 500)/2,+'width=600,height=500');")

            CommonFunctions.General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=6&TimeSheetID=" + lngTimeSheetId.ToString + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')" + vbCrLf)
            'Response.Write("window.open('../General/SendEmail.aspx?MessageID=6&TimeSheetID=" + lngTimeSheetId.ToString + "');")
            Response.Write("</Script>")
        End If

        If blnSendEmail = True And blnShowPopup = False Then
            CommonFunction.EmailMessages.FAMessages.GetEmailMessage_6(strFromMail, strMailTo, strCCEamilID, strSubject, strMessage, lngTimeSheetId)
            CommonFunction.Emails.AppSendEmail(strMailTo, strFromMail, strSubject, strMessage)
        End If
        'End Of Modification  By vivekP On 2 August 2005 For WhizibleSEM SP4  IssueID-87
    End Sub
#End Region

#Region " Procedure/Functions Specific to Timesheet Details Mode "
    Private Sub GetProjectDetails()
        '==================================================================================
        ' Procedure Name	:	GetProjectDetails
        ' Purpose			:	This procedure Fetches the Details from the Database. These Details are 
        '                       shown as the Header for the Timesheet Details.
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Jayavant
        ' Created			:	16-Mar-2004
        ' Revisions			:	
        '==================================================================================
        Dim strQuery As String = ""
        Dim drTimeSheet As IDataReader
        Dim lngProjectId As Long = 0

        'Modified By VivekP On  5 August 2005 For WhizibleSEM SP4 IssueID-87
        'strQuery = "Select FromDate,ToDate,ProjectID From tbl_PM_TimeSheetInvoice Where TimeSheetNo=" & m_lngTimesheetNo.ToString()
        strQuery = "Select FromDate,ToDate,ProjectID ,TimesheetStatus From v_tbl_PM_TimeSheetInvoice Where TimeSheetNo=" & m_lngTimesheetNo.ToString()

        drTimeSheet = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drTimeSheet) <> "" Then
            If drTimeSheet.Read() Then
                m_strFromDate = drTimeSheet.Item("FromDate").ToString()
                m_strFromDate = CommonFunctions.General.UnBuildQueryString(m_strFromDate)
                m_strToDate = drTimeSheet.Item("ToDate").ToString()
                m_strToDate = CommonFunctions.General.UnBuildQueryString(m_strToDate)
                lngProjectId = CType(CommonFunctions.Data.CheckIsDBNull(drTimeSheet.Item("ProjectID"), "0"), Long)
                strTimesheetStatus = drTimeSheet.Item("TimesheetStatus").ToString()
                strTimesheetStatus = CommonFunctions.General.UnBuildQueryString(strTimesheetStatus)
                If strTimesheetStatus.ToUpper = "RE-GENERATED" Then
                    strTimesheetStatus = "Rejected"
                End If
            End If
        End If
        'End  Of Modification By VivekP On 5 August 2005 For WhizibleSEM SP4 IssueID-87
        CommonFunctions.Data.DisposeDataReader(drTimeSheet)
        If m_strProjectName = "" Then
            strQuery = "Select ProjectName From tbl_PM_Project Where ProjectID=" & lngProjectId.ToString()
            m_strProjectName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL))
        End If
        CommonFunctions.Data.DisposeDataReader(drTimeSheet)
    End Sub

    Private Sub Display_TimesheetDetailsList()
        '==================================================================================
        ' Procedure Name	:	Display_TimesheetDetailsList
        ' Purpose			:	This procedure Assign properties to the Grid object.
        '                       The Grid is used to display the details of Timesheet.
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Jayavant
        ' Created			:	16-Mar-2004
        ' Revisions			:	
        '==================================================================================
        Dim drTempWork As IDataReader
        Dim strQuery As String = ""
        Dim strSubProjectName As String = ""

        'Grid Related Variables
        Dim intColumnCount As Integer = 5
        'Modified By VivekP On 12 August 2005 For WhizibleSEM Sp4 IssueID-87
        Dim arrUserFriendlyFieldNames() As String = {"Employee Name/Date", _
                                                     "Employee Name/Date", _
                                                     MyBase.GetResourceString("TASK_NAME"), _
                                                     MyBase.GetResourceString("DESCRIPTION"), _
                                                     MyBase.GetResourceString("HOURS")}
        'End Of Modification by VivekP On 12 August 2005 For WhizibleSEM Sp4 IssueID-87
        Dim arrActualFieldNames() As String = {"EmployeeName", "EntryDate", "Task", "Description", "Duration"}
        Dim arrSummaryFunctions() As String = {"", "", "", "", "SUM"}
        Dim arrGroupOnColumns() As String = {"1", "", "", "", ""}
        Dim arrGroupSummaryFunctions() As String = {"", "", "", "", "SUM"}
        Dim arrTDStyle() As String = {"", "align=left nowrap width=20%", "align=left width=35%", _
                                      "align=left width=38%", "align=center width=7%"}

        If m_blnSubProjectLevelInvoicing = True Then
            'Get the Sub Project name
            strQuery = "Exec usp_Sel_tbl_PM_TimeSheetInvoice NULL, NULL, " & m_lngTimesheetNo.ToString()
            drTempWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drTempWork) <> "" Then
                If drTempWork.Read() Then
                    strSubProjectName = drTempWork.Item("SubProjectName").ToString().Trim()
                    strSubProjectName = CommonFunctions.General.UnBuildQueryString(strSubProjectName)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drTempWork)
            CommonFunctions.General.WriteHTML("<TABLE class=clsTable cellspacing=0 cellpadding=0 width='99.9%'>")
            CommonFunctions.General.WriteHTML("<TR class='clsTROdd'>")
            CommonFunctions.General.WriteHTML("<TD>")
            CommonFunctions.General.WriteHTML(Server.HtmlEncode(m_strSubProjectCaption) & " : ")
            If strSubProjectName <> "" Then
                CommonFunctions.General.WriteHTML("<B>" & Server.HtmlEncode(strSubProjectName) & "</B>")
            Else
                CommonFunctions.General.WriteHTML(MyBase.GetResourceString("NBYA"))
            End If
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR></TABLE>")
            CommonFunctions.General.WriteHTML("<br>")
        End If
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'Build the Query for Grid
        strQuery = "usp_Sel_TimeSheetForGivenTimeSheetNo " & m_lngTimesheetNo.ToString()
        With m_objGrid
            .ActualColumnArray = arrActualFieldNames
            .UserFriendlyColumnArray = arrUserFriendlyFieldNames
            .GroupOnColumn = arrGroupOnColumns
            .GroupSummaryFunc = arrGroupSummaryFunctions
            .SummaryFunctions = arrSummaryFunctions
            .ShowSummaryFunctions = True
            .TDStyleArray = arrTDStyle
            .PrimaryKey = "TimeSheetID"
            .NoOfDataColumns = intColumnCount
            .DIVID = "divList"
            .DIVStyle = "scrollbars:none;width:100%"
            .DIVHeight = 350
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
    End Sub

    Private Sub Display_ControlForComments()
        Dim strFromCustomer As String = ""

        strFromCustomer = CommonFunctions.General.CheckIsNothing(Request.QueryString("FromCustomer"))
        If strFromCustomer = "1" Then
            m_blnShowSendMenuItem = True

            CommonFunctions.General.WriteHTML("<BR>")
            m_objMenu = Nothing
            m_objMenu = New WebPages.Template.StaticMenu
            CommonFunctions.General.WriteHTML(m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True))
            CommonFunctions.General.WriteHTML("<BR>")

            CommonFunctions.General.WriteHTML("<TABLE class=clsTable cellspacing=0 cellpadding=0 width='99.9%'>")
            CommonFunctions.General.WriteHTML("<TR class='clsTRColumnHeader' align=center>")
            CommonFunctions.General.WriteHTML("<TD colspan=2>")
            CommonFunctions.HTMLControls.DrawOptionButton("optAuthenticate", "optAuthenticate", , True, AUTHETICATE)
            CommonFunctions.General.WriteHTML("<Font Face=Verdana Size=1>" & MyBase.GetResourceString("AUTHENTICATE") & "</Font>")
            CommonFunctions.HTMLControls.DrawOptionButton("optAuthenticate", "optAuthenticate", , , DECLINE)
            CommonFunctions.General.WriteHTML("<Font Face=Verdana Size=1>" & MyBase.GetResourceString("DECLINE") & "</Font>")
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")
            CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
            CommonFunctions.General.WriteHTML("<TD align=left valign=Top>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("COMMENT"))
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD align='center'>")
            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("txtareaAuthenticate", "txtareaAuthenticate", maxLength:=200, widthInPixel:=420, heightInPixel:=100))
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("txtareaAuthenticate", "txtareaAuthenticate", maxLength:=200, widthInPixel:=420, heightInPixel:=100, EnableHTMLEncode:=True))
            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")
            CommonFunctions.General.WriteHTML("</TABLE>")
        Else
            m_blnShowSendMenuItem = False
        End If
    End Sub
#End Region

#Region " Menu and Grid Event Handler Procedures "
    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        Select Case Args.MenuColIndex
            Case MenuIndex.AUTHENTICATE
                If m_strMode = MODE_TSLISTING Then
                    If m_blnHasTimeSheet = True Then
                        If m_strTimeSheetAllOrCurrent = TIMESHEET_CURRENT Then
                            'Modified By VivekP On 8 August 2005 For WhizibleSEM SP4 IssueID-87
                            ' If m_objAccessRights.Add = False Then Cancel = True
                        Else
                            'Cancel = True
                        End If
                    Else
                        'Cancel = True
                        'End Of Modification by vivekP On 8 August For WhizibleSEM SP4 IssueID-87
                    End If
                ElseIf m_strMode = MODE_TSDETAILS Then
                    Cancel = True
                End If



            Case MenuIndex.DELETE
                If m_strMode = MODE_TSLISTING Then
                    If m_blnHasTimeSheet = True Then
                        If m_objAccessRights.Delete = False Then Cancel = True
                    Else
                        Cancel = True
                    End If
                ElseIf m_strMode = MODE_TSDETAILS Then
                    Cancel = True
                End If
                'Code Added by VivekP On 2 August 2005 For SP4 WhizibleSEM IssueID-87
                Cancel = True
                'End Of Addition By VivekP On 2 August 2005 For SP4 WhizibleSEM IssueID-87

            Case MenuIndex.SEND
                If m_strMode = MODE_TSLISTING Then
                    Cancel = True
                ElseIf m_strMode = MODE_TSDETAILS Then
                    If m_blnShowSendMenuItem = False Then Cancel = True
                End If
                'Code Added by VivekP On 2 August 2005 For SP4 WhizibleSEM IssueID-87
                Cancel = True
                'End Of Addition By VivekP On 2 August 2005 For SP4 WhizibleSEM IssueID-87

            Case MenuIndex.CLOSE
                If m_strMode = MODE_TSLISTING Then
                    Cancel = True
                ElseIf m_strMode = MODE_TSDETAILS Then
                    'Commented  by Vivek On 5 August 2005 For WhizibleSEM SP4 IssueID-87
                    'If Request.QueryString("FromCustomer") = "" Then
                    '    Cancel = True
                    'End If
                    If Request.QueryString("ProjectName") = "" Then
                        Cancel = True
                    End If
                    'If m_blnShowSendMenuItem = True Then Cancel = True
                    'End Of Commenting by Vivek On 5 August 2005 For WhizibleSEM SP4 IssueID-87
                End If

            Case MenuIndex.HELP
                'Commented  by Vivek On 5 August 2005 For WhizibleSEM SP4 IssueID-87
                'If m_blnShowSendMenuItem = True Then Cancel = True
                'End Of Commenting by Vivek On 5 August 2005 For WhizibleSEM SP4 IssueID-87

                'Code Added by VivekP On 2 August 2005 For SP4 WhizibleSEM IssueID-87
            Case MenuIndex.REJECTFROMLIST
                If m_strMode = MODE_TSDETAILS Then
                    Cancel = True
                End If
            Case MenuIndex.BACK
                If m_strMode <> MODE_TSDETAILS Then
                    Cancel = True
                End If
                If Request.QueryString("FromCustomer") <> "" Then
                    Cancel = True
                End If
                If Request.QueryString("ProjectName") <> "" Then
                    Cancel = True
                End If

                If Request.QueryString("From") = "WeeklyStatusReport" Then
                    Cancel = True
                End If

            Case MenuIndex.REJECT
                If m_strMode <> MODE_TSDETAILS Then
                    Cancel = True
                End If
                'If Request.QueryString("AllTimesheet") = "YES" Then
                '    Cancel = True
                'End If

                '' START : Modified By ParagD On 26-Sept-2006
                If strTimesheetStatus <> "Sent For Approval" Then
                    Dim blnIsInvoiceExists_ForProjectTimesheet As String = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_IsInvoiceExists_ForProjectTimesheet " & m_lngTimesheetNo.ToString, MyBase.UseSQL), ""), String)
                    If (blnIsInvoiceExists_ForProjectTimesheet = "1" Or strTimesheetStatus = "Rejected") Then
                        Cancel = True
                    End If
                    '' END : Modified By ParagD On 26-Sept-2006
                End If
                'If Request.QueryString("ProjectName") <> "" Then
                '    Cancel = True
                'End If
                'If Request.QueryString("FromCustomer") <> "" Then
                '    Cancel = True
                'End If
                If Request.QueryString("From") = "WeeklyStatusReport" Then
                    Cancel = True
                End If
            Case MenuIndex.APPROVE
                If m_strMode <> MODE_TSDETAILS Then
                    Cancel = True
                End If
                'If Request.QueryString("ProjectName") <> "" Then
                '    Cancel = True
                'End If
                'If Request.QueryString("FromCustomer") <> "" Then
                '    Cancel = True
                'End If
                'If Request.QueryString("AllTimesheet") = "YES" Then
                '    Cancel = True
                'End If
                If strTimesheetStatus <> "Sent For Approval" Then
                    '' START : Modified By ParagD On 29-Sept-2006
                    Dim blnIsInvoiceExists_ForProjectTimesheet As String = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_IsInvoiceExists_ForProjectTimesheet " & m_lngTimesheetNo.ToString, MyBase.UseSQL), ""), String)
                    If (blnIsInvoiceExists_ForProjectTimesheet = "1" Or (strTimesheetStatus = "Approved" Or strTimesheetStatus = "Rejected")) Then
                        Cancel = True
                    End If
                    '' END : Modified By ParagD On 29-Sept-2006
                End If
                If Request.QueryString("From") = "WeeklyStatusReport" Then
                    Cancel = True
                End If
            Case MenuIndex.VIEW_COMMENT
                If m_strMode <> MODE_TSDETAILS Then
                    Cancel = True
                End If
                'If Request.QueryString("AllTimesheet") = "YES" Then
                '    Cancel = True
                'End If
                'If Request.QueryString("strRejectedStatus") <> "RejectedTimesheet" Then
                '    Cancel = True
                'End If
                If strTimesheetStatus = "Rejected" Or strTimesheetStatus = "Approved" Then
                Else
                    Cancel = True
                End If
            Case MenuIndex.SELECTALL
                If m_strMode = MODE_TSDETAILS Then
                    Cancel = True
                End If
            Case MenuIndex.CLEARALL
                If m_strMode = MODE_TSDETAILS Then
                    Cancel = True
                End If
                'Code Addiition Ends by VivekP On 2 August 2005 For SP4 WhizibleSEM IssueID-87

        End Select

        If Args.MenuColIndex = MenuIndex.HELP Or Args.MenuColIndex = MenuIndex.CLOSE Then
            'Code Commented By VivekP On 5 August 2005 For WhizibleSEM SP4 IssueID-87
            'If m_blnShowSendMenuItem = False Then
            '    If Args.MenuColIndex = MenuIndex.SEND Then Cancel = True
            'Else
            '    If Args.MenuColIndex = MenuIndex.HELP Then Cancel = True
            'End If
            'Code Coomenting End By VivekP On 5 August 2005 For WhizibleSEM SP4 IssueID-87
            Return
        End If
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint

        ' Code added by SwapnilR on 25th Sept 2006
        ' Purpose : Adding security token for Show Report link
        Dim strTokenID As String
        ' End of code addition by SwapnilR on 25th Sept 2006

        'Code Added by VivekP On 8 August 2005 For WhizibleSEM SP4 IssueID-87
        If Args.ColumnName = "Select" Then
            If Args.DataReader("Authenticated").ToString.Trim <> "N" Then
                '' START : Modified By ParagD On 26-Sept-2006
                Dim blnIsInvoiceExists_ForProjectTimesheet As String = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_IsInvoiceExists_ForProjectTimesheet " & Args.DataReader("TimeSheetNo").ToString, MyBase.UseSQL), ""), String)
                If (blnIsInvoiceExists_ForProjectTimesheet = "1" Or Args.DataReader("Authenticated").ToString.Trim = "R") Then
                    Cancel = True
                    Args.StringToBeInserted += "<TD align=center align='center' width='8%'><Input type=checkbox name='chkAuthenticate' id='chkAuthenticate' class='clsCheckBox' disabled></td>"
                End If
                '' END : Modified By ParagD On 26-Sept-2006
            End If
            ''Integrated By PrashantSJ on 07 Feb 2007
            ''Purpose: To Check whether selected timesheet is being invoiceid and depends on that we can reject or approve the timesheet
            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtHidStatus" + Args.DataReader("TimeSheetNo").ToString, "txtHidStatus" + Args.DataReader("TimeSheetNo").ToString, , , , Args.DataReader("TimeSheetStatus").ToString, , , , , , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            ''End of Integration by PrashantSJ on 07 Feb 2007
        End If
        'End Of Addition By VivekP On 8 August 2005 For WhizibleSEM SP4 IssueID-87

        ' Code Added by SwapnilR On 8 Dec 2004
        If Args.ColumnName = MyBase.GetResourceString("BILLING_INFO") Then
            ' Code added by SwapnilR on 25th Sept 2006
            ' Purpose : Adding security token for Show Report Link 
            strTokenID = CommonFunctions.Security.Token.GetToken(Args.DataReader("TimeSheetNo").ToString + m_strUserID + "0" + "42")
            Cancel = True
            'Args.StringToBeInserted += "<TD><a href = '../PM/PM_ResourceBillingInfoReport.aspx?TimesheetID=" + Args.DataReader("TimeSheetNo").ToString + "&TagID=42&ParentTagID=0&UserID=" + m_strUserID + "&PKToken=" + strTokenID + "'>" + MyBase.GetResourceString("BILLING_INFO") + "</a></TD>"
            'If Condition Added By AmitJ For Ascendum IssueId 2747=> Print Report in Timesheet Listing
            'Purpose:Show Billing Info Link only for those timesheets which have sites.
            If m_objGlobal.LoginType = "E" Then
                If Args.DataReader("SiteID").ToString.Trim <> "0" Then
                    'End Of Addition By AmitJ
                    'Args.StringToBeInserted += "<TD><a href = '../PM/PM_ResourceBillingInfoReport.aspx?TimesheetID=" + Args.DataReader("TimeSheetNo").ToString + "&TagID=42&ParentTagID=0&UserID=" + m_strUserID + "&PKToken=" + strTokenID + "'>" + MyBase.GetResourceString("BILLING_INFO") + "</a></TD>"
                    Args.StringToBeInserted += "<TD><a href = '../PM/PM_ResourceBillingInfo.aspx?TimesheetID=" + Args.DataReader("TimeSheetNo").ToString + "&TagID=42&ParentTagID=0&UserID=" + m_strUserID + "&PKToken=" + strTokenID + "'>" + MyBase.GetResourceString("BILLING_INFO") + "</a></TD>"

                    ' End of code addition by SwapnilR on 25th Sept 2006
                Else
                    'Added By AmitJ For Ascendum IssueId 2747=> Print Report in Timesheet Listing
                    'Purpose:Show Billing Info Link only for those timesheets which have sites.
                    Args.StringToBeInserted += "<TD align=center > - </TD>"
                    'End Of Addition By AmitJ
                End If
            Else
                Args.StringToBeInserted += "<TD align=center > - </TD>"
            End If

        End If
        If Args.ColumnName = MyBase.GetResourceString("REPORT") Then
            Cancel = True
            strTokenID = CommonFunctions.Security.Token.GetToken(Args.DataReader("TimeSheetNo").ToString + m_strUserID + "0" + "42")
            'Args.StringToBeInserted += "<td><a href = 'Javascript:Show_Report(""" + Args.DataReader("TimeSheetNo").ToString + """,""" + m_strUserID + """,""" + strTokenID + """)'>" + MyBase.GetResourceString("REPORT") + " </a></td>"
            'If Condition Added By AmitJ For Ascendum IssueId 2747=> Print Report in Timesheet Listing
            'Purpose:Show Billing Info Link only for those timesheets which have sites.
            If m_objGlobal.LoginType = "E" Then
                If Args.DataReader("SiteID").ToString.Trim <> "0" Then
                    'End Of Addition By AmitJ
                    ' Code added by SwapnilR on 25th Sept 2006
                    ' Purpose : Adding security token for Show Report Link 
                    strTokenID = CommonFunctions.Security.Token.GetToken(Args.DataReader("TimeSheetNo").ToString + m_strUserID + "0" + "42")
                    Args.StringToBeInserted += "<td><a href = 'Javascript:Show_Report(""" + Args.DataReader("TimeSheetNo").ToString + """,""" + m_strUserID + """,""" + strTokenID + """)'>" + MyBase.GetResourceString("REPORT") + " </a></td>"
                    ' End of code addition by SwapnilR on 25th Sept 2006
                Else
                    'Added By AmitJ For Ascendum IssueId 2747=> Print Report in Timesheet Listing
                    'Purpose:Show Billing Info Link only for those timesheets which have sites.
                    Args.StringToBeInserted += "<TD align=center> - </TD>"
                    'End Of Addition By AmitJ
                End If
            Else
                Args.StringToBeInserted += "<TD align=center> - </TD>"
            End If

        End If
        ' End of code addtion by SwapnilR

        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197 
        If Args.ColIndex = 0 Then
            m_PKToken_Edit = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("TimeSheetNo"), String) + Session("intUserID").ToString + "0" + "42")
            Args.StringToBeInserted = "<TD vAlign=top>" _
                                        & "<A href=""JavaScript:Number_OnClick(" & Args.DataReader("TimeSheetNo").ToString & ",'" & CommonFunctions.General.CheckIsNothing(m_PKToken_Edit) & "')"">" & Args.DataReader("TimeSheetNo").ToString & "</A></TD>"
            Cancel = True
        End If
        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197

        If m_strMode = MODE_TSLISTING Then
            Select Case Args.ColIndex
                Case 2
                    Args.ShowTimeWithDate = True
                Case 4
                    Args.ShowTimeWithDate = False
                Case 5
                    Args.ShowTimeWithDate = False
            End Select
            If m_blnSubProjectLevelInvoicing = False And Args.ColIndex = 1 Then Cancel = True 'Sub Project 
            'Code Commented By VivekP On 8 August 2005 For WhizibleSEM Sp4 IssueID-87
            'If m_strTimeSheetAllOrCurrent = TIMESHEET_CURRENT Then
            '    If Args.ColIndex = 7 Then Cancel = True ' Invoice No
            '    If m_objAccessRights.Add = False And Args.ColIndex = 8 Then Cancel = True ' Authentication Checkbox
            'Else
            'If Args.ColIndex = 10 Then Cancel = True ' Authentication Checkbox
            'End If
            'If m_objAccessRights.Delete = False And Args.ColIndex = 11 Then Cancel = True 'Delete Checkbox
            'Code Commenting Ends By VivekP On 8 August 2005 For WhizibleSEM Sp4 IssueID-87

        ElseIf m_strMode = MODE_TSDETAILS Then
            If Args.ColIndex = 0 Then
                If m_strEmployeeName <> Args.DataReader("EmployeeName").ToString.Trim Then
                    'Args.StringToBeInserted = "<TR class='clsTRSectionHeader'><TD align='left' colspan=4>" + Args.DataReader("EmployeeName").ToString + "</FONT></TD></TR>"
                    Args.StringToBeInserted = "<TD align='left' colspan=4>" + Args.DataReader("EmployeeName").ToString + "</FONT></TD>"
                    m_strEmployeeName = "" & Args.DataReader("EmployeeName").ToString().Trim()
                Else
                    Args.StringToBeInserted = ""
                End If
                'Determine stylesheet for row
                If Args.NoOfRowsPrinted Mod 2 = 0 Then
                    'While cancelling TD, TR will also get cancelled. hence add <TR>, grid class will close it.
                    Args.StringToBeInserted &= "<TR class='clsTREven'>"
                Else
                    Args.StringToBeInserted &= "<TR class='clsTROdd'>"
                End If
                Cancel = True

            ElseIf Args.ColIndex = 1 Then
                If m_strEntryDate <> Args.DataReader("EntryDate").ToString.Trim Then
                    m_strEntryDate = Args.DataReader("EntryDate").ToString().Trim()
                Else
                    Args.StringToBeInserted = "<TD align='left'></TD>"
                    Cancel = True
                End If
            End If
        End If
    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        If m_strMode = MODE_TSLISTING Then
            If m_blnSubProjectLevelInvoicing = False And Args.ColIndex = 1 Then Cancel = True 'Sub Project 
            'Code Commenting by VivekP On 8 August 2005 For WhizibleSEM Sp4 IssueID-87
            'If m_strTimeSheetAllOrCurrent = TIMESHEET_CURRENT Then
            '    If Args.ColIndex = 7 Then Cancel = True ' Invoice No
            '    If m_objAccessRights.Add = False And Args.ColIndex = 8 Then Cancel = True ' Authentication Checkbox
            'Else
            '    If Args.ColIndex = 10 Then Cancel = True ' Authentication Checkbox
            'End If
            'If m_objAccessRights.Delete = False And Args.ColIndex = 11 Then Cancel = True 'Delete Checkbox
            'End Of Commenting by VivekP On 8 August 2005 For WhizibleSEM Sp4 IssueID-87
        ElseIf m_strMode = MODE_TSDETAILS Then
            If Args.ColIndex = 1 Then
                Cancel = True
            End If
        End If
    End Sub

    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint
        'Modified By VivekP On 19 August 2005 For WhizibleSEM Sp4 IssueID-87
        'If m_strMode = MODE_TSDETAILS Then
        '    'Check for Group Value
        '    If m_strEmployeeName <> Args.DataReader("EmployeeName").ToString.Trim Then
        '        If m_dblGroupTotal >= 0 Then
        '            Args.StringToBeInserted = "<TR><TD colspan=4><HR></TD></TR><tr class='clsTRSectionHeader'><td align=left colspan=3><FONT color=blue>" & MyBase.GetResourceString("TOTAL")
        '            Args.StringToBeInserted &= " " & m_strEmployeeName & "</Font></td>"
        '            Args.StringToBeInserted &= " <td align=center>" & FormatNumber(m_dblGroupTotal, 2)
        '            Args.StringToBeInserted &= "</td></tr><TR><TD colspan=4><HR></TD></TR>"
        '            m_dblGroupTotal = 0
        '            m_dblGroupTotal += CType(Args.DataReader("Duration"), Double)
        '        Else
        '            m_dblGroupTotal = CType(Args.DataReader("Duration"), Double)
        '        End If
        '    Else
        '        'update GroupTotal
        '        m_dblGroupTotal += CType(Args.DataReader("Duration"), Double)
        '    End If
        'End If
        If m_strMode = MODE_TSDETAILS Then
            'Check for Group Value
            If m_strEmployeeName <> Args.DataReader("EmployeeName").ToString.Trim Then
                If m_dblGroupTotal >= 0 Then
                    Args.StringToBeInserted = "<tr class='clsTRSectionHeader'><td align=left colspan=3><FONT color=blue>" & MyBase.GetResourceString("TOTAL") & "&nbsp;for&nbsp;"
                    Args.StringToBeInserted &= " " & m_strEmployeeName & "</Font></td>"
                    'Commented And Added By Usha Pandit On 07.12.2020 For getting work hours in decimal from HH:MM format
                    'Args.StringToBeInserted &= " <td align=center>" & FormatNumber(m_dblGroupTotal, 2)
                    Args.StringToBeInserted &= " <td align=center>" & CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + FormatNumber(m_dblGroupTotal, 2) + "',1)", True)
                    'End Of Added By Usha Pandit On 07.12.2020 For getting work hours in decimal from HH:MM format
                    Args.StringToBeInserted &= "</td></tr>"
                    m_dblGroupTotal = 0
                    'Commented And Added By Usha Pandit On 07.12.2020 For getting work hours in decimal from HH:MM format
                    'm_dblGroupTotal += CType(Args.DataReader("Duration"), Double)
                    m_dblGroupTotal += CType(CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + Args.DataReader("Duration") + "',2)", True), Double)
                    'End Of Added By Usha Pandit On 07.12.2020 For getting work hours in decimal from HH:MM format
                Else
                    'Commented And Added By Usha Pandit On 07.12.2020 For getting work hours in decimal from HH:MM format
                    'm_dblGroupTotal = CType(Args.DataReader("Duration"), Double)
                    If m_dblGroupTotal = -1 Then
                        m_dblGroupTotal = 0
                    End If
                    m_dblGroupTotal += CType(CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + Args.DataReader("Duration") + "',2)", True), Double)
                    'End Of Added By Usha Pandit On 07.12.2020 For getting work hours in decimal from HH:MM format
                End If
            Else
                'update GroupTotal
                'Commented And Added By Usha Pandit On 07.12.2020 For getting work hours in decimal from HH:MM format
                'm_dblGroupTotal += CType(Args.DataReader("Duration"), Double)
                m_dblGroupTotal += CType(CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + Args.DataReader("Duration") + "',2)", True), Double)
                'End Of Added By Usha Pandit On 07.12.2020 For getting work hours in decimal from HH:MM format
            End If
            'Added By Usha Pandit On 07.12.2020 For getting work hours in decimal from HH:MM format
            m_dblGrandTotal += CType(CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + Args.DataReader("Duration") + "',2)", True), Double)
            'End Of Added By Usha Pandit On 07.12.2020 For getting work hours in decimal from HH:MM format
        End If
        'End OF Modification By VivekP On 19 August 2005 For WhizibleSEM Sp4 IssueID-87
    End Sub

    Private Sub m_objGrid_SummaryFunctionsTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTD) Handles m_objGrid.SummaryFunctionsTD_BeforePrint
        'Modified By VivekP On 19 August 2005 For WhizibleSEM Sp4 IssueID-87
        'If m_strMode = MODE_TSDETAILS Then
        '    If Args.ColIndex = 0 Then
        '        Args.StringToBeInserted = "<tr class='clsTRSectionHeader'><TD align='left'><FONT color=blue>"
        '        Args.StringToBeInserted &= MyBase.GetResourceString("GRAND_TOTAL") & "</Font></TD>"
        '        Cancel = True
        '    ElseIf Args.ColIndex = 1 Then
        '        Cancel = True
        '    ElseIf Args.ColIndex = 4 Then
        '        Args.StringToBeInserted = "<TD align='center'>" & FormatNumber(Args.SummaryValue, 2) & "</td></tr>"
        '        Args.StringToBeInserted &= "<TR><TD colspan=4><HR></TD></TR>"
        '        Cancel = True
        '    End If
        'End If
        If m_strMode = MODE_TSDETAILS Then
            If Args.ColIndex = 0 Then
                Args.StringToBeInserted = "<TD align='left'><FONT color=blue>"
                Args.StringToBeInserted &= MyBase.GetResourceString("GRAND_TOTAL") & "</Font></TD>"
                Cancel = True
            ElseIf Args.ColIndex = 1 Then
                Cancel = True
            ElseIf Args.ColIndex = 4 Then
                'Commented And Added By Usha Pandit On 07.12.2020 For getting work hours in decimal from HH:MM format
                'Args.StringToBeInserted = "<TD align='center'>" & FormatNumber(Args.SummaryValue, 2) & "</td></tr>"
                Args.StringToBeInserted = "<TD align='center'>" & CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + FormatNumber(m_dblGrandTotal, 2) + "',1)", True) & "</td></tr>"
                'End Of Added By Usha Pandit On 07.12.2020 For getting work hours in decimal from HH:MM format
                'Args.StringToBeInserted &= "<TR><TD colspan=4></TD></TR>"
                Cancel = True
            End If
        End If
        'End OF Modification By VivekP On 19 August 2005 For WhizibleSEM Sp4 IssueID-87
    End Sub

    Private Sub m_objGrid_SummaryFunctionsTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTR) Handles m_objGrid.SummaryFunctionsTR_BeforePrint
        'Modified By VivekP On 19 August 2005 For WhizibleSEM Sp4 IssueID-87
        'If m_strMode = MODE_TSDETAILS Then
        '    Args.StringToBeInserted = "<TR><TD colspan=4><HR></TD></TR><tr class='clsTRSectionHeader'><td align=left colspan=3><FONT color=blue>" & MyBase.GetResourceString("TOTAL")
        '    Args.StringToBeInserted &= " " & m_strEmployeeName & "</Font></td>"
        '    Args.StringToBeInserted &= " <td align=center>" & FormatNumber(m_dblGroupTotal, 2)
        '    Args.StringToBeInserted &= "</td></tr><TR><TD colspan=4><HR></TD></TR>"
        '    Args.StringToBeInserted &= "<TR><TD colspan=4><HR></TD></TR>"
        '    m_dblGroupTotal = 0
        'End If
        If m_strMode = MODE_TSDETAILS Then
            Args.StringToBeInserted = "<tr class='clsTRSectionHeader'><td align=left colspan=3><FONT color=blue>" & MyBase.GetResourceString("TOTAL") & "&nbsp;for&nbsp;"
            Args.StringToBeInserted &= " " & m_strEmployeeName & "</Font></td>"
            'Commented And Added By Usha Pandit On 07.12.2020 For getting work hours in decimal from HH:MM format
            'Args.StringToBeInserted &= " <td align=center>" & FormatNumber(m_dblGroupTotal, 2)
            Args.StringToBeInserted &= " <td align=center>" & CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + FormatNumber(m_dblGroupTotal, 2) + "',1)", True)
            'End Of Added By Usha Pandit On 07.12.2020 For getting work hours in decimal from HH:MM format
            Args.StringToBeInserted &= "</td></tr>"
            m_dblGroupTotal = 0
        End If
        'End OF Modification By VivekP On 19 August 2005 For WhizibleSEM Sp4 IssueID-87
    End Sub
    ''Added by Yogesh J on 02-Feb-2016 for to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_RejectFromList_OnClick(concatedlist As String, EmployeeID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(concatedlist, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    ''End of addition by Yogesh J on 02-Feb-2016
    ''Added by Shamkant S on 17-Feb-2016 for to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function Token_Reject_OnClick(TimesheetNo_PK As String, EmployeeID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(TimesheetNo_PK, String) + CType(+EmployeeID, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    ''End of addition by  Shamkant S on 17-Feb-2016
#End Region
End Class
