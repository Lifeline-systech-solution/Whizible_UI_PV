Imports CommonFunctions

Public Class IB_IssueAssignment
    Inherits WebPages.Template.WhizTemplate

    Protected CONST_SHOW_ASSIGNED As String = "ASSIGNED"
    Protected CONST_SHOW_ALL As String = "ALL"
    Protected CONST_ACTION_SAVE As String = "SAVE"
    Protected CONST_ACTION_REOPEN As String = "REOPEN"

    Protected m_strWindowTitle As String
    Protected m_strMode As String
    Protected m_strAction As String
    Protected m_lngIssueID As Long
    Protected m_strAlphabet As String
    Private m_lngUserID As Long
    Private m_strFixInDays As String
    Private m_strDueDate As String
    Private m_lngProjectID As Long
    Private m_strReportedDate As String
    Private m_dblDuration As Double
    Private m_strAssignedToIDList As String
    Private m_strOldAssignedToIDList As String
    'added by SachinR   On 02 Jul 2004
    'to implement the type-role based security for issue
    Private m_strType As String
    'addition end
    'added by Harshk on 11/10/2005'
    Protected m_bitResourceValidation As Int16 = 1
    'End added by Harshk on 11/10/2005'
    '***** Added by SandipL on 6 Dec 2005 -- Editable Date Control Issue
    Protected m_blnDateEditable As Boolean
    '***** End addition by SandipL
    'Added By PrashantD on 16 Dec 2005 IssueID 295 DSS
    'Purpose: Store EmployeeIDs whos Task is completed, to avoid from setting task InActive
    Private arrEmployeeID_TaskComplete As New System.Collections.ArrayList
    'Added by SavitaS on 20 Sept 2006 for Security Issue 6197
    Protected m_strIssueID As String
    Protected m_PKToken As String
    Protected m_PKTokenEmployee As String
    'End of Added by SavitaS on 20 Sept 2006 for Security Issue 6197
    'Added by PrashantD on 18 April 2007 for IssueID 11616
    Dim blnIsResourceReleased As Boolean
    'End of addition by PrashantD on 28 April 2007

    ' Added by NitinVS on 11 July 2007 To Validte for Project Efforts
    Protected m_ProjectEfforts As String = "0"
    Protected m_ProjectAllocatedEfforts As String = "0"
    Protected m_ProjectBalanceEfforts As String = "0"
    Protected m_IssueEfforts As String = "0"
    ''Added By Nilesh g on 28/3/2016 for PKToken Generation
    Protected mStrProjectID As String = ""
    Protected mStrFixInDays As String = ""
    Protected mStrFROMWHERE As String = ""
    Protected PKtokenShowAssignResource As String = ""
    Protected mStrPkTokenShowAssignResource As String = ""
    ''END OF Added By Nilesh g on 28/3/2016 for PKToken Generation
    ' End Addition by NitinVS on 11 July 2007 To Validte for Project Efforts
    'Added by Sagar N. on 04-March-2019 Purpose::Whizible 2 Work field change
    Protected m_RestrictByMinHours As String

    'End of adding by Sagar N on 04-March-2019 Purpose::Whizible 2 Work field change


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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'set the window title 
        m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_ISSUE")

        ' Added by SavitaS 20 Sept 2006 for Security Issue 6197
        'If Request.QueryString("PKToken") <> "" Then
        '    m_strIssueID = Request.QueryString("IssueID")
        '    m_PKToken = Request.QueryString("PKToken")
        'Else
        '    m_strIssueID = Request.QueryString("IssueID")
        '    m_PKToken = CommonFunctions.Security.Token.GetToken(m_strIssueID.ToString + CType(Session("intUserID"), String) + "0" + "0")
        'End If
        If Not Request.QueryString("ProjectId") Is Nothing Then
            mStrProjectID = Request.QueryString("ProjectId").ToString
        End If

        If Not Request.QueryString("FixInDays") Is Nothing Then
            mStrFixInDays = Request.QueryString("FixInDays").ToString
        End If
        If Not Request.QueryString("FROMWHERE") Is Nothing Then
            mStrFROMWHERE = Request.QueryString("FROMWHERE").ToString
        Else
            mStrFROMWHERE = ""
        End If
        If Not Request.QueryString("PkTokenShowAssignResource") Is Nothing Then
            mStrPkTokenShowAssignResource = Request.QueryString("PkTokenShowAssignResource").ToString
        Else
            mStrPkTokenShowAssignResource = ""
        End If
        If Not Request.QueryString("IssueID") Is Nothing Then
            m_strIssueID = Request.QueryString("IssueID").ToString
        Else
            m_strIssueID = "0"
        End If

        If Not Request.QueryString("Alphabet") Is Nothing Then
            m_strAlphabet = Request.QueryString("Alphabet").ToString
        Else
            m_strAlphabet = ""
        End If


        If CType(m_PKToken, String) <> "0" Then
            If Request.QueryString("PKToken") Is Nothing Then
                m_PKToken = Request.Form("txtPkToken").ToString
            Else
                m_PKToken = Request.QueryString("PKToken").ToString
            End If
        End If

        ''Commented and Added By Nilesh g on 28/3/2016 for PKToken Generation

        '        If ((m_PKToken = "") And (m_strIssueID.ToString <> "0")) Or _
        '((m_strIssueID.ToString <> "0") And (CommonFunctions.Security.Token.ValidateToken(CType(m_strIssueID, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String), m_PKToken) = False)) Then
        '            Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue : Issue Assignment", 0, 0, "Issue ID", CType(m_strIssueID, String))
        '            'Token is Invalid now redirect to the Invalid Access Page
        '            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '        End If

        ' End of Added by SavitaS 20 Sept 2006 for Security Issue 6197
        If Request.QueryString("ProjectId") <> "" And Request.QueryString("PKToken") <> "" Then

            If CommonFunctions.Security.Token.ValidateToken(CType(m_strIssueID, String) + CType(Session("intUserID"), String) + CType(mStrProjectID, String) + CType(0, String) + CType(0, String), m_PKToken) = False Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue : Issue Assignment", 0, 0, "Issue ID", CType(m_strIssueID, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")

            End If
        Else
            If ((m_PKToken <> "") And (m_strIssueID.ToString <> "0") And (mStrFROMWHERE = "Issue")) Then
                If CommonFunctions.Security.Token.ValidateToken(CType(m_strIssueID, String) + CType(mStrFixInDays, String) + CType(0, String) + CType(0, String), m_PKToken) = False Then
                    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue : Issue Assignment", 0, 0, "Issue ID", CType(m_strIssueID, String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")

                End If

                'If ((m_PKToken = "") And (m_strIssueID.ToString <> "0")) And (CommonFunctions.Security.Token.ValidateToken(CType(m_strIssueID, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String), m_PKToken) = False) Then
                '    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue : Issue Assignment", 0, 0, "Issue ID", CType(m_strIssueID, String))
                '    'Token is Invalid now redirect to the Invalid Access Page
                '    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If

        If (Request.QueryString("PkTokenShowAssignResource") <> "" And Request.QueryString("Alphabet") <> "" And Request.QueryString("IssueID") <> "") Then
            If CommonFunctions.Security.Token.ValidateToken(CType(m_strIssueID, String) + CType(m_strAlphabet, String) + CType(0, String) + CType(0, String), mStrPkTokenShowAssignResource) = False Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue : Issue Assignment", 0, 0, "Issue ID", CType(m_strIssueID, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")

            End If
        End If
        ''end of Commented and Added By Nilesh g on 28/3/2016 for PKToken Generation
        'Added By VarunA on 9-Sep-2008
        'Purpose : To mark the task as void, which is created when the project is ON HOLD and the Assign Issue to Responsible Person is checked
        Dim strProjectHoldSQL As String = ""
        Dim strProjectStatus As String
        If m_strIssueID <> "" Then
            strProjectHoldSQL = "EXEC usp_sel_ProjectIssue_Status " & m_strIssueID.ToString()
            strProjectStatus = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strProjectHoldSQL, MyBase.UseSQL), "0")
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txtProjectStatus", "txtProjectStatus", value:=strProjectStatus, IsHidden:=True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15

        End If
        'End By VarunA on 9-Sep-2008
        ''ADDED BY NILESH G ON 18/8/2016 pURPOSE :pK TOKEN ISSUE
        m_PKToken = CommonFunctions.Security.Token.GetToken(m_strIssueID.ToString + CType(Session("intUserID"), String) + "0" + "0")

        ''END OF ADDED BY NILESH G ON 18/8/2016 pURPOSE :pK TOKEN ISSUE
        'This code is added here to get the projectlevel settings and transfer page
        'if Apply subTaskType flag is on.
        Dim strSQL As String
        Dim objDr As IDataReader
        If Not IsPostBack Then

            m_lngIssueID = CType(Request.QueryString("IssueID"), Long)
            m_strFixInDays = Request.QueryString("FixInDays") + ""

            'get the details of issue and list of assigned resource IDs
            Call getIssueDetails(m_lngIssueID)

            'Added by SachinR   On  26 May 2004
            'Based on the status of the two flags, ApplySubTaskType,ApplyEffortDistribution as project level
            'issue assignment is done.If Apply SubTaskType is On then call page IB_AssignIssueWithActivity else
            'continue with this page
            Dim blnIsSubTask As Boolean
            'Dim blnApplyEffortDistribution As Boolean
            strSQL = "usp_sel_tbl_pm_ProjectTask_TaskDetails " + m_lngProjectID.ToString + ",NULL,NULL,2"
            objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
            If objDr.Read Then
                blnIsSubTask = CType(Data.CheckIsDBNull(objDr("HaveSubTaskTypes"), "0"), Boolean)
                'blnApplyEffortDistribution = CType(Data.CheckIsDBNull(objDr("ApplyEffortDistribution"), "0"), Boolean)
            End If
            Data.DisposeDataReader(objDr)
            If blnIsSubTask = True Then
                'tansfer control to another page
                'Modified by SavitaS 20 Sept 2006 for Security Issue 6197
                'Server.Transfer("IB_IssueAssignmentWithActivity.aspx?IssueID=" + m_lngIssueID.ToString + "&FixInDays=" + m_strFixInDays.Trim)
                Server.Transfer("IB_IssueAssignmentWithActivity.aspx?IssueID=" + m_lngIssueID.ToString + "&PKToken=" + m_PKToken + "&FixInDays=" + m_strFixInDays.Trim)
                'End of Modified by SavitaS 20 Sept 2006 for Security Issue 6197
            End If
            'addition end
        End If

        ''Added By Sagar Nipane on 04-March-2019 Purpose::Whizible 2 Work field change
        Dim drCompany As IDataReader
        drCompany = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation", True)
        If drCompany.Read() Then
            m_RestrictByMinHours = CommonFunction.Data.CheckIsDBNull(drCompany("RestrictByMinHours"), "0")
        End If
        ''End of Added By Sagar Nipane on 04-March-2019 Purpose::Whizible 2 Work field change
    End Sub
    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        'initialize the resource file for send Email page.
        MyBase.InitializeResources("AppResources.IB_IssueAssignment", "AppResources")
    End Sub

    '=====================================================================
    ' Procedure Name		:	PageInit
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the page
    ' Description			:	This is main procedure on this page which actually draw the page with its 
    '                           controls on it. This procedure is called from the HTML bady tag of the page.
    '                           this procedure gives the call to other procedures and functions in the class.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 13 2004
    ' Revisions				:	
    '=====================================================================
    Public Sub PageInit()
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim objHeader As WebPage.Templates.HeaderFooter
        Dim strSQL As String
        Dim objPaging As WebPage.Templates.Paging
        Dim strPagingHTML As String
        Dim blnShowTimesheetMenu As Boolean = False
        Dim objDr As IDataReader

        '***** Code added by SandipL on 6 Dec 2005 -- To handle conditinal Editable Date Control
        m_blnDateEditable = CommonFunctions.General.GetFrameworkSettings("EDITABLE_DATE_CONTROL", "Enabled")
        '***** End addition by SandipL on 6 Dec
        'get the values from the query string
        m_strMode = Request.QueryString("Mode") + ""
        If m_strMode = "" Then m_strMode = CONST_SHOW_ASSIGNED
        m_strAction = Request.QueryString("Action") + ""
        m_strAlphabet = Request.QueryString("Alphabet") + ""
        If m_strAlphabet = "" Then m_strAlphabet = "-1"
        m_lngIssueID = CType(Request.QueryString("IssueID"), Long)
        m_lngUserID = CType(Session("intUserID"), Long)
        m_strFixInDays = Request.QueryString("FixInDays") + ""
        If m_strFixInDays = "" Then m_strFixInDays = "0"
        ''Added By Nilesh g on 29/3/2016 for PKtoken Generation
        PKtokenShowAssignResource = CommonFunctions.Security.Token.GetToken(CType(m_lngIssueID, String) + CType(m_strAlphabet, String) + "0" + "0")
        ''End of Added By Nilesh g on 29/3/2016 for PKtoken Generation
        If IsPostBack Then
            'if page is posted back then get the values form the hidden controls

            m_strAssignedToIDList = MyBase.GetFormValue("txtCurrentIDList") + ""
            m_strOldAssignedToIDList = MyBase.GetFormValue("txtOldAssignedToIDList") + ""

            If MyBase.GetFormValue("txtDuration") <> "" Then
                m_dblDuration = CType(MyBase.GetFormValue("txtDuration"), Double)
            End If
            m_lngProjectID = CType(MyBase.GetFormValue("txtProjectID"), Long)
            m_strDueDate = MyBase.GetFormValue("txtDueDate") + ""
            m_strReportedDate = MyBase.GetFormValue("txtReportedDate") + ""

            'added by SachinR   on 02 Jul 2004
            'to implement type-role security
            m_strType = MyBase.GetFormValue("txtType") + ""
            'addition end

        Else
            'get the details of issue and list of assigned resource IDs
            Call getIssueDetails(m_lngIssueID)

        End If

        'added by harshk on 22/08/05 for date validation(start & end date between project date) for SP4 issueID 120,121 
        DrawHiddenCombo()
        'end harshk on 22/08/05 for SP4 issueID 120,121 

        If Not IsPostBack Then

            'Added by SachinR   On  26 May 2004
            'Based on the status of the two flags, ApplySubTaskType,ApplyEffortDistribution as project level
            'issue assignment is done.If Apply SubTaskType is On then call page IB_AssignIssueWithActivity else
            'continue with this page
            Dim blnIsSubTask As Boolean
            'Dim blnApplyEffortDistribution As Boolean
            strSQL = "usp_sel_tbl_pm_ProjectTask_TaskDetails " + m_lngProjectID.ToString + ",NULL,NULL,2"
            objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
            If objDr.Read Then
                blnIsSubTask = CType(Data.CheckIsDBNull(objDr("HaveSubTaskTypes"), "0"), Boolean)
                'blnApplyEffortDistribution = CType(Data.CheckIsDBNull(objDr("ApplyEffortDistribution"), "0"), Boolean)
            End If
            Data.DisposeDataReader(objDr)
            If blnIsSubTask = True Then
                'tansfer control to another page
                Server.Transfer("IB_IssueAssignmentWithActivity.aspx?IssueID=" + m_lngIssueID.ToString + "&FixInDays=" + m_strFixInDays.Trim, True)
            End If
            'addition end
        End If

        'check if there is any timesheet entry for the  issue
        strSQL = "usp_Sel_tbl_PM_DailyActivity_For_Issue " + m_lngIssueID.ToString
        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDr.Read Then
            blnShowTimesheetMenu = True
        End If
        Data.DisposeDataReader(objDr)

        If m_strDueDate.Trim = "" Then
            If m_strFixInDays <> "" Then
                If IsNumeric(m_strFixInDays) Then
                    If m_strReportedDate <> "" Then
                        m_strDueDate = CommonFunction.Dates.GetDate(CType(DateAdd(DateInterval.Day, CType(m_strFixInDays, Integer), CType(m_strReportedDate.Trim, Date)), Date))
                    Else
                        m_strDueDate = CommonFunction.Dates.GetDate(CType(DateAdd(DateInterval.Day, CType(m_strFixInDays, Integer), Date.Now()), Date))
                    End If
                End If
            End If
        End If

        Call getAssignedResourceIDList(m_lngIssueID)

        If Not IsPostBack Then
            'if no resources assigned then default show all resources
            If m_strAssignedToIDList = "," Then
                m_strMode = CONST_SHOW_ALL
            End If
        End If

        Select Case m_strMode.ToUpper
            Case CONST_SHOW_ASSIGNED, CONST_SHOW_ALL

                If m_strAction <> "" Then
                    'update the database based on the action
                    Call performAction()
                    Call getAssignedResourceIDList(m_lngIssueID)
                End If

                'initialize the resource file for standard menu.
                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("Save_OnClick()")
                If m_strMode.ToUpper = CONST_SHOW_ASSIGNED Then
                    arrMenu.Add(MyBase.GetResourceString("MENU_SHOW_ALL_RESOURCES")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SHOW_ALL_RESOURCES_TOOLTIP")) : arrClientSideFunctions.Add("ShowAll_OnClick()")
                Else
                    arrMenu.Add(MyBase.GetResourceString("MENU_SHOW_ASSIGNED")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SHOW_ASSIGNED_TOOLTIP")) : arrClientSideFunctions.Add("ShowAssignedTo_OnClick()")
                End If
                If blnShowTimesheetMenu = True Then
                    arrMenu.Add(MyBase.GetResourceString("MENU_TIMESHEET_DEAILS")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_TIMESHEET_DEAILS_TOOLTIP")) : arrClientSideFunctions.Add("ShowTimesheet_OnClick()")
                End If
                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('EmpSelect')")

                'copy all the element to string array
                Dim arrstrMenu(arrMenu.Count - 1) As String
                Dim arrstrMenuToolTip(arrMenuToolTip.Count - 1) As String
                Dim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1) As String
                arrMenu.CopyTo(arrstrMenu)
                arrMenuToolTip.CopyTo(arrstrMenuToolTip)
                arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
                arrMenu = Nothing
                arrMenuToolTip = Nothing
                arrClientSideFunctions = Nothing

                'create the pagin links
                'plot the grid for the list of assigned resources
                strSQL = "usp_Sel_IB_IssueEntry_EmployeeList_PagingAlphabet 'AssignTo'," + m_lngProjectID.ToString + ",NULL"
                If m_strMode = CONST_SHOW_ASSIGNED Then
                    strSQL += ", 'AND E.EmployeeID IN (0" + m_strAssignedToIDList.Trim + "0)'"
                Else
                    strSQL += ",Null"
                End If
                'Added by PrashantD on 12 March 2007 for IssueID 11393
                strSQL += ",NULL,'" + CommonFunction.General.BuildQueryString(m_strType) + "'," + m_lngIssueID.ToString
                'End of addition by PrashantD on 12 March 2007
                'display the paging links on the menu bar
                objPaging = New WebPage.Templates.Paging
                strPagingHTML = objPaging.DrawPaging(m_strAlphabet, strSQL, MyBase.GetResourceString("PAGING_SELECT"), "Paging_OnClick", "UserName", True)
                objPaging = Nothing

                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True, strPagingHTML)
                'draw upper menu
                General.WriteHTML(strMenu)
                'create lower menu without paging
                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)

                'Display the (* Mandatory) PageLegends 
                Dim strarrLegend() As String = {"Mandatory"}
                Dim strarrLegendImage() As String = {"<img src='../../images/star.gif'>"}
                General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, strarrLegendImage, strarrLegend) + vbCrLf)

                'initialize the resource file for issue assignment page.
                MyBase.InitializeResources("AppResources.IB_IssueAssignment", "AppResources")

                'draw page caption 
                WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_ISSUE"))
                General.WriteHTML("<BR>")

                ''draw page description
                'objHeader = New WebPage.Templates.HeaderFooter
                'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_ISSUE") + ""
                'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
                'General.WriteHTML("<BR>")
                'objHeader = Nothing

                'plot the screen to show only assigned resources to the issue
                Call plotScreenForResources(m_lngIssueID)

            Case Else
                General.WriteHTML("<div id='DivList'></Div>")
        End Select

        'plot the lower menu
        General.WriteHTML("<BR>")
        General.WriteHTML(strMenu)

        ' Added By NitinVS on 12 July 2007 for WhizibleSEM 7 To validate for Project Efforts 
        Call GetProjectEffortDetails()
        ' Added By NitinVS on 12 July 2007 for WhizibleSEM 7 To validate for Project Efforts 
    End Sub

    '=====================================================================
    ' Procedure Name		:	plotScreenForResources
    ' Parameters Passed		:	lngIssueID - Long
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the controls to show list of assigned resources only.
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 13 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotScreenForResources(ByVal lngIssueID As Long)
        Dim strSQL As String
        Dim strCurrentEmpIDList As String
        Dim objdr As IDataReader
        Dim objDrIssue As IDataReader
        Dim blnIsTaskComplete As Boolean
        Dim strFilter As String
        Dim strOldAssignedToIdList As String
        Dim objLink As WebPage.UI.cDynamicLink
        Dim lngEmployeeID As Long
        Dim strUserName As String
        Dim strLocation As String
        Dim strDesignation As String
        Dim strStartDate As String
        Dim strEndDate As String
        Dim dblWorkHrs As Double
        Dim lngTaskID As Double
        Dim blnIssueAssigned As Boolean
        Dim intRowCount As Integer

        'Added By Sagar N on 07-Mar-2019 Purpose :: Work Field Level changes
        Dim strWorkHrs As String
        'End of Added By Sagar N on 07-Mar-2019 Purpose :: Work Field Level changes

        '--- Addded By purvaj on 7 Nov 2008 for whiziblesem 8.0
        '--- added for validation current hours should not be less than actual work hours
        Dim dblActualWorkHrs As Double
        '--- end addition purvaj
        'Added by TruptiK on 25-Mar-09
        Dim strActualstartDate As String
        'end of addition by TruptiK
        'get the filter string if spacified
        strFilter = MyBase.GetFormValue("txtFilter") + ""

        strOldAssignedToIdList = m_strAssignedToIDList
        strCurrentEmpIDList = ","

        'plot the filter textbox
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        General.WriteHTML("<Table class='clsTable' cellspacing=0 cellpadding=0 width=99.9% >")

        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align='right' width=30% nowrap >" + MyBase.GetResourceString("CAP_SHOW_NAMES") + "&nbsp;</TD>")
        General.WriteHTML("<TD align='left' width=10% colspan=2>")
        'Modified by PrahantD on 12 March 2007 for IssueID 11369 
        'General.WriteHTML(HTMLControls.DrawTextBox("txtFilter", "txtFilter", , 50, , strFilter.Trim, , , , , , , , True))
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        General.WriteHTML(HTMLControls.DrawTextBox("txtFilter", "txtFilter", , 50, , Request.Form("txtFilter") + "", , , , , , , , True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:06/10/15

        'End of modification by PrashantD on 12 March 2007

        'display links
        objLink = New WebPage.UI.cDynamicLink
        objLink.ReturnHTML = True
        objLink.LinkName = MyBase.GetResourceString("LINK_SHOW") + ""
        objLink.Tooltip = MyBase.GetResourceString("LINK_SHOW_TOOLTIP") + ""
        objLink.FunctionName = "Show_OnClick()"
        General.WriteHTML(" | <B>" + objLink.GetDynamicLink() + "</B> | ")
        objLink.LinkName = MyBase.GetResourceString("LINK_CLEAR") + ""
        objLink.Tooltip = MyBase.GetResourceString("LINK_CLEAR_TOOLTIP") + ""
        objLink.FunctionName = "Clear_OnClick()"
        General.WriteHTML("<B>" + objLink.GetDynamicLink() + "</B> | ")
        General.WriteHTML("</TD>")
        General.WriteHTML("<TD align='left' width=30% >   </TD>")
        General.WriteHTML("</TR>")

        'display due date textbox
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='right' >" + MyBase.GetResourceString("CAP_DUE_DATE") + "&nbsp;</TD>")
        General.WriteHTML("<TD align='left' >")
        m_strDueDate = Dates.GetDate(CType(m_strDueDate.Trim, Date))
        General.WriteHTML(HTMLControls.DrawDateControl("txtDueDate", "txtDueDate", , , m_strDueDate.Trim, "callcalendarLocal", "frmIssueAssignment", , , , , , , True, True) + "</TD>")

        'Commented & Added By Sagar N on 07-Mar-2019 Purpose :: Work Field Level changes
        'General.WriteHTML("<TD align='right' width=15% >" + MyBase.GetResourceString("CAP_WORK_HRS") + " <B>:</B></TD>")
        'General.WriteHTML("<TD id='tdDuration' align='left'><B> " + Math.Round(m_dblDuration, 2).ToString + "</B></TD>")
        General.WriteHTML("<TD align='right' width=15% >Work (H:M) <B>: </B></TD>")

        strWorkHrs = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + Math.Round(m_dblDuration, 2).ToString + "',1)", True)
        General.WriteHTML("<TD id='tdDuration' align='left'><B> " + strWorkHrs + "</B></TD>")
        strWorkHrs = ""
        'End of Commented & Added By Sagar N on 07-Mar-2019 Purpose :: Work Field Level changes

        'Added by SavitaS on 20 Sept 2006
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        General.WriteHTML(HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken, , , , , , , , , , , , True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:06/10/15
        'End Addition by SvaitaS

        General.WriteHTML("</TR>")

        General.WriteHTML("</Table>")
        General.WriteHTML("<BR>")

        'plot the grid for the list of assigned resources
        strSQL = "usp_Sel_IB_IssueEntry_EmployeeList 'AssignTo'," + m_lngProjectID.ToString + ",NULL"

        If m_strMode = CONST_SHOW_ASSIGNED Then
            strSQL += ", 'AND E.EmployeeID IN (0" + m_strAssignedToIDList.Trim + "0)'"
        Else
            strSQL += ",Null"
        End If

        If strFilter <> "" Then
            strSQL += ",'" + General.BuildQueryString(strFilter.Trim) + "'"
        Else
            strSQL += ",'" + General.BuildQueryString(m_strAlphabet.Trim) + "'"
        End If

        'added by SachinR   on 02 jul 2004
        'This is to implement Role based issue security. Here issue type is taken from the database
        'and passed to the SP to check which employee has access to the type based on its Project Role
        'so that only those employee will be listed to assign
        If m_strType <> "" Then
            strSQL += ",'" + CommonFunction.General.BuildQueryString(m_strType.Trim) + "'"
        Else
            strSQL += ",NULL"
        End If
        'addition end

        'plot the column headers
        General.WriteHTML("<Div id='DivList' width=100% style='Overflow: auto;' height=90% >")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        General.WriteHTML("<Table class='clsTable' cellspacing=0 cellpadding=0 width=99.9% >")

        General.WriteHTML("<TR class='clsTRColumnHeader'>")
        General.WriteHTML("<TD>" + MyBase.GetResourceString("COL_USER_NAME") + "</TD>")
        'Commented and modified by GaneshD on 16 Sep 2009
        'General.WriteHTML("<TD>" + MyBase.GetResourceString("COL_LOCATION") + "</TD>")
        'General.WriteHTML("<TD>" + MyBase.GetResourceString("COL_DESIGNATION") + "</TD>")
        General.WriteHTML("<TD>Organization Unit</TD>")
        General.WriteHTML("<TD>Role</TD>")
        ' End of modification by GnaeshD on 16 Sep 2009
        General.WriteHTML("<TD>" + MyBase.GetResourceString("COL_SHOW_SCHEDULE") + "</TD>")
        General.WriteHTML("<TD>" + MyBase.GetResourceString("COL_ASSIGN") + "</TD>")
        General.WriteHTML("<TD>" + MyBase.GetResourceString("COL_START_DATE") + "</TD>")
        General.WriteHTML("<TD>" + MyBase.GetResourceString("COL_END_DATE") + "</TD>")
        'Commented & Added By Sagar N on 07-Mar-2019 Purpose :: Work Field Level changes
        'General.WriteHTML("<TD>" + MyBase.GetResourceString("COL_WORKHRS") + "</TD>")
        General.WriteHTML("<TD> Work (H:M)</TD>")
        'End of Commented & Added By Sagar N on 07-Mar-2019 Purpose :: Work Field Level changes
        General.WriteHTML("<TD>" + MyBase.GetResourceString("COL_REOPEN") + "</TD>")
        General.WriteHTML("</TR>")

        intRowCount = 0
        'Added by PrashantD on 12 March 2007 on IssueID 11393,11616
        strSQL += ",'" + Session("LoginType").ToString + "','Edit'," + m_lngIssueID.ToString + ",1"
        'End of addition by PrashantD on 12 March 2007
        'open the datareader and get data
        objdr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        While objdr.Read
            intRowCount += 1

            lngEmployeeID = CType(objdr("EmployeeID"), Long)
            strCurrentEmpIDList += lngEmployeeID.ToString + ","
            strUserName = objdr("UserName").ToString + ""
            strLocation = objdr("Location").ToString + ""
            strDesignation = objdr("RoleDescription").ToString + ""
            m_PKTokenEmployee = CommonFunctions.Security.Token.GetToken(lngEmployeeID.ToString + CType(Session("intUserID"), String) + "0" + "0")
            strStartDate = ""
            strEndDate = ""
            dblWorkHrs = 0
            lngTaskID = 0
            blnIsTaskComplete = False
            blnIssueAssigned = False

            'Added By AratiS on 11-Mar-2010 for RequestID-25281 of DSS
            'actualworkhrs of previous resource should get cleared, it should not transfer to new resource while assigning on issue.
            strActualstartDate = ""
            dblActualWorkHrs = "0"
            'End:Added By AratiS on 11-Mar-2010 for RequestID-25281 of DSS

            'if task is already assigned to the resource
            If InStr(1, strOldAssignedToIdList.Trim, "," + lngEmployeeID.ToString + ",") <> 0 Then

                blnIssueAssigned = True

                strSQL = "usp_Sel_tbl_PM_ProjectTasks_IssueTasks " + lngIssueID.ToString + "," + lngEmployeeID.ToString
                objDrIssue = Data.GetDataReader(strSQL, MyBase.UseSQL)
                If objDrIssue.Read Then
                    lngTaskID = CType(objDrIssue("TaskID"), Long)

                    strStartDate = Dates.GetDate(CType(objDrIssue("StartDate").ToString + "", Date))
                    strEndDate = Dates.GetDate(CType(Data.CheckIsDBNull(objDrIssue("EndDate"), "").ToString, Date))
                    If Not IsDBNull(objDrIssue("Work")) Then
                        dblWorkHrs = CType(objDrIssue("Work"), Double)
                    End If

                    dblActualWorkHrs = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDrIssue("Actualwork"), 0), 0)
                    strActualstartDate = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDrIssue("ActualStartDate"), ""), ""), String)
                    blnIsTaskComplete = CType(Data.CheckIsDBNull(objDrIssue("IsTaskComplete"), "0"), Boolean)
                    'Added by PrashantD on 12 April 2007 for IssueID 11616
                    'Purpose : Is Resorce released or not
                    If Not IsDBNull(objDrIssue("ReleaseDate")) Then
                        blnIsResourceReleased = True
                    Else
                        blnIsResourceReleased = False
                    End If
                    'End of addition by PrashantD on 12 April 2007
                End If
                Data.DisposeDataReader(objDrIssue)

            End If

            '****************************************************************************************
            If intRowCount Mod 2 = 0 Then
                General.WriteHTML("<TR class='clsTREven'>")
            Else
                General.WriteHTML("<TR class='clsTROdd'>")
            End If

            General.WriteHTML("<TD align='left'>" + strUserName.Trim + "</TD>")
            General.WriteHTML("<TD align='left'>" + strLocation.Trim + "</TD>")
            General.WriteHTML("<TD align='left'>" + strDesignation.Trim + "</TD>")
            objLink.LinkName = MyBase.GetResourceString("LINK_SHOW_SCHEDULE_LINK") + ""
            objLink.Tooltip = MyBase.GetResourceString("LINK_SHOW_SCHEDULE_LINK_TOOLTIP") + ""
            objLink.FunctionName = "ShowSchedule_OnClick('" + lngEmployeeID.ToString + "','" + strStartDate.Trim + "','" + strEndDate.Trim + "','" + m_PKTokenEmployee.ToString + "')"
            General.WriteHTML("<TD align='center'>" + objLink.GetDynamicLink() + "</TD>")
            General.WriteHTML("<TD align='center'>")
            If blnIsTaskComplete Then
                General.WriteHTML(MyBase.GetResourceString("CAP_TASK_COMPLETE"))
            Else
                General.WriteHTML(HTMLControls.DrawCheckBox("chkAssignTo", "chkAssignTo", , blnIssueAssigned, lngEmployeeID.ToString, , "onclick='javascript:chkAssignTo_OnClick(this)'", True))
            End If
            General.WriteHTML("</TD>")

            If blnIsTaskComplete Then
                General.WriteHTML("<TD align='left'>")
                General.WriteHTML(strStartDate.Trim + "</TD>")
                General.WriteHTML("<TD align='left'>")
                General.WriteHTML(strEndDate.Trim + "</TD>")
                General.WriteHTML("<TD align='left'>")
                ''Added By Sagar Nipane on 07-March-2019 Purpose::Project Work field level changes 
                'General.WriteHTML(dblWorkHrs.ToString + "</TD>")
                strWorkHrs = dblWorkHrs.ToString
                If strWorkHrs = 0 Or strWorkHrs = "" Then
                    strWorkHrs = "00.00"
                End If
                strWorkHrs = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + dblWorkHrs + "',1)", True)

                General.WriteHTML(strWorkHrs.ToString + "</TD>")
                ''End of Added By Sagar Nipane on 07-March-2019 Purpose::Project Work field level changes
            Else
                General.WriteHTML("<TD align='left' >")
                General.WriteHTML(HTMLControls.DrawDateControl("txtStartDate" + lngEmployeeID.ToString, "txtStartDate" + lngEmployeeID.ToString, , , strStartDate.Trim, "callcalendarLocal", "frmIssueAssignment", , , , , , , True) + "</TD>")
                General.WriteHTML("<TD align='left' >")
                General.WriteHTML(HTMLControls.DrawDateControl("txtEndDate" + lngEmployeeID.ToString, "txtEndDate" + lngEmployeeID.ToString, , , strEndDate.Trim, "callcalendarLocal", "frmIssueAssignment", , , , , , , True) + "</TD>")
                General.WriteHTML("<TD align='left' >")

                ''Added By Sagar Nipane on 01-March-2019 Purpose::Project Work field level changes 

                strWorkHrs = dblWorkHrs.ToString
                If strWorkHrs = 0 Or strWorkHrs = "" Then
                    strWorkHrs = "00.00"
                End If
                strWorkHrs = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strWorkHrs + "',1)", True)


                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                'General.WriteHTML(HTMLControls.DrawTextBox("txtWorkHrs" + lngEmployeeID.ToString, "txtWorkHrs" + lngEmployeeID.ToString, , 50, 20, dblWorkHrs.ToString, "right", , Not blnIssueAssigned, , , , " onblur='javascript:WorkHrs_OnBlur(this," + lngEmployeeID.ToString + ")' onfocus='javascript:WorkHrs_OnFocus(this)'", True, EnableHTMLEncode:=True) + "</TD>")
                General.WriteHTML(HTMLControls.DrawTextBox("txtWorkHrs" + lngEmployeeID.ToString, "txtWorkHrs" + lngEmployeeID.ToString, , 50, 20, strWorkHrs.ToString, "right", , Not blnIssueAssigned, , , , " onblur='javascript:WorkHrs_OnBlur(this," + lngEmployeeID.ToString + ")' onfocus='javascript:WorkHrs_OnFocus(this)'", True, EnableHTMLEncode:=True) + "</TD>")
                'ended by Yogesh J for HTML encoding Date:06/10/15

                'End of Added By Sagar Nipane on 01-March-2019 Purpose::Project Work field level changes
            End If
            'Modified if stmt by PrashantD on 12 April 2007 for IssueID 11616
            'Purpose : if  Resorce released do not plot reopen link
            'If blnIsTaskComplete Then
            If blnIsTaskComplete And blnIsResourceReleased = False Then
                General.WriteHTML("<TD align='left'>")
                objLink.LinkName = MyBase.GetResourceString("LINK_REOPEN") + ""
                objLink.Tooltip = MyBase.GetResourceString("LINK_REOPEN_TOOLTIP") + ""
                objLink.FunctionName = "ReOpenTask_OnClick('" + lngTaskID.ToString + "')"
                General.WriteHTML(objLink.GetDynamicLink())
                'General.WriteHTML("</TD>")
            Else
                General.WriteHTML("<TD align='left'>")
                General.WriteHTML(MyBase.GetResourceString("CAP_NA") + "")

            End If

            '--- added By PurvaJ on 7 Nov 2008 for Whiziblesem8.0
            '--- for validation - Current work hours  should not be less than actual work hours
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunction.HTMLControls.DrawTextBox("hid_txtActualHours" + lngEmployeeID.ToString, "hid_txtActualHours" + lngEmployeeID.ToString, , 200, , dblActualWorkHrs.ToString, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
            'Added by TruptiK on 20-MAy-09
            'Purpose:-To add validation for actualstartdate of resource.
            If strActualstartDate <> "" Then
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                CommonFunction.HTMLControls.DrawTextBox("hid_txtActualstartDate" + lngEmployeeID.ToString, "hid_txtActualstartDate" + lngEmployeeID.ToString, , 200, , (CDate(strActualstartDate).ToString("dd-MMM-yyyy")), , , , , , True, EnableHTMLEncode:=True)
            Else
                CommonFunction.HTMLControls.DrawTextBox("hid_txtActualstartDate" + lngEmployeeID.ToString, "hid_txtActualstartDate" + lngEmployeeID.ToString, , 200, , strActualstartDate, , , , , , True, EnableHTMLEncode:=True)
                'ended by Yogesh J for HTML encoding Date:06/10/15
            End If
            'End of addition by TruptiK
            '--- End addition purvaJ
            General.WriteHTML("</TD>")


            General.WriteHTML("</TR>")
            '****************************************************************************************
        End While
        Data.DisposeDataReader(objdr)
        objLink = Nothing

        'if no record found then display the message
        If intRowCount <= 0 Then
            General.WriteHTML("<TR class='clsTREven'")
            General.WriteHTML("<TD align='center' colspan=9 >" + MyBase.GetResourceString("NO_DATA") + "</TD>")
            General.WriteHTML("</TR>")
        End If

        'end of table
        General.WriteHTML("</Table>")
        General.WriteHTML("</Div>")

        'keep values in the hidden controls
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        General.WriteHTML(HTMLControls.DrawTextBox("txtDuration", "txtDuration", , , , m_dblDuration.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtRowCount", "txtRowCount", , , , intRowCount.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtCurrentIDList", "txtCurrentIDList", , , , m_strAssignedToIDList.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtOldAssignedToIDList", "txtOldAssignedToIDList", , , , strOldAssignedToIdList.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:06/10/15
        '***** Code modified by SandipL on 2 dec 2005 -IssueID 672

        'General.WriteHTML(HTMLControls.DrawTextBox("txtReportedDate", "txtReportedDate", , , , CommonFunction.Dates.GetDate(CType(m_strReportedDate.Trim, Date)), , , , , , True, , True))
        General.WriteHTML(HTMLControls.DrawDateControl("txtReportedDate", "txtReportedDate", , , CommonFunction.Dates.GetDate(CType(m_strReportedDate.Trim, Date)), , , , , , , , , , , , , True))
        '***** End Modification by SandipL on 2 Dec 2005
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        General.WriteHTML(HTMLControls.DrawTextBox("txtProjectID", "txtProjectID", , , , m_lngProjectID.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:06/10/15
        'added by SachinR   on 02 jul 2004
        'to implement type-role security
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        General.WriteHTML(HTMLControls.DrawTextBox("txtType", "txtType", , , , m_strType.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:06/10/15
        'addition end
    End Sub

    '=====================================================================
    ' Procedure Name		:	getIssueDetails
    ' Parameters Passed		:	lngIssueID - Long
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To get the details of the issue into global variables.
    ' Description			:	This procedure gets the details of the given issue id from the 
    '                           data base and store them in the global variables.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 13 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub getIssueDetails(ByVal lngIssueID As Long)
        Dim strSQL As String
        Dim objDR As IDataReader

        m_strType = ""

        strSQL = "usp_Sel_tbl_IB_Issue " + lngIssueID.ToString
        objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDR.Read Then
            m_lngProjectID = CType(objDR("ProjectID"), Long)
            m_strDueDate = Data.CheckIsDBNull(objDR("DueDate"), "").ToString + ""
            m_strReportedDate = Data.CheckIsDBNull(objDR("ReportedDate"), "").ToString + ""
            If IsDate(m_strDueDate) = True Then
                m_strDueDate = Dates.GetDate(Date.Parse(m_strDueDate.Trim))
            End If
            If IsDate(m_strReportedDate) = True Then
                m_strReportedDate = Dates.GetDate(Date.Parse(m_strReportedDate.Trim))
            End If

            'added by SachinR   on 02 jul 2004
            'get the type of issue to implement role-type issue security
            m_strType = Data.CheckIsDBNull(objDR("Type"), "").ToString + ""
            'addition end

        End If
        Data.DisposeDataReader(objDR)
    End Sub

    '=====================================================================
    ' Procedure Name		:	getAssignedResourceIDList
    ' Parameters Passed		:	lngIssueID - Long
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To get the quama seperated list of resource IDs who are assigned to the issue.
    ' Description			:	This procedure gets the quama seperated list of resource IDs who are 
    '                           assigned to the issue and alse count the total duration by taking the sum
    '                           of work for all the resources.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 13 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub getAssignedResourceIDList(ByVal lngissueID As Long)
        Dim strSQL As String
        Dim objDR As IDataReader

        m_strAssignedToIDList = ","
        m_dblDuration = 0

        strSQL = "usp_Sel_tbl_PM_ProjectTasks_IssueTasks " + lngissueID.ToString
        objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
        While objDR.Read
            'create the quama seperated list of IDs
            m_strAssignedToIDList += objDR("EmployeeID").ToString + ","

            'make the total of work (duration)
            If Not IsDBNull(objDR("Work")) Then
                m_dblDuration += CType(objDR("Work"), Double)
            End If
            'Added By PrashantD on 16 Dec 2005  IssueID 295 DSS
            'Purpose: Storing EmployeeIDs, those tasks are completed.
            If Not IsDBNull(objDR("IsTaskComplete")) Then
                If CType(objDR("IsTaskComplete"), Boolean) = True Then
                    arrEmployeeID_TaskComplete.Add(objDR("EmployeeID").ToString)
                End If

            End If


        End While
        Data.DisposeDataReader(objDR)

    End Sub

    '=====================================================================
    ' Procedure Name		:	performAction
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To update the data base based on the action given.
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 14 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performAction()
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim lngTaskID As Long
        Dim strUserName As String
        Dim dblDuration As Double
        Dim strDueDate As String
        Dim strOldAssignToIDList As String
        Dim strAssignToIDList As String
        Dim arrIDList() As String
        Dim dblTaskduration As Double
        Dim strStartDate As String
        Dim strEndDate As String
        Dim strSendMailTo As String
        Dim blnSendMail As Boolean
        Dim blnShowPopUp As Boolean
        Dim strFromEmailID As String
        Dim strToEmailID As String
        Dim strCCToEmailID As String
        Dim strSubject As String
        Dim strEmailMessage As String
        Dim lngAssignTo As Long

        Select Case m_strAction
            Case CONST_ACTION_REOPEN
                'reOpen the task
                If Request.QueryString("TaskID") <> "" Then

                    lngTaskID = CType(Request.QueryString("TaskID"), Long)

                    strsql = "usp_Upd_ProjectTaskComplete " + lngTaskID.ToString + ",0"
                    Data.InsertOrUpdateData(strsql, MyBase.UseSQL)
                End If

            Case CONST_ACTION_SAVE
                'update the due date and duration in the issue table
                strSQL = "usp_Upd_tbl_IB_Issue_DueDateAndDuration " + m_lngIssueID.ToString
                strUserName = CommonFunctions.General.BuildQueryString(Session("strUserName").ToString + "")

                If MyBase.GetFormValue("txtDuration") <> "" Then
                    dblDuration = CType(MyBase.GetFormValue("txtDuration"), Double)
                    strSQL += "," + dblDuration.ToString
                Else
                    dblDuration = 0
                    strSQL += ",NULL"
                End If
                If MyBase.GetFormValue("txtDueDate") <> "" Then
                    strDueDate = MyBase.GetFormValue("txtDueDate")
                    strSQL += ",'" + strDueDate.Trim + "'"
                Else
                    strDueDate = ""
                    strSQL += ",NULL"
                End If
                strSQL += ",'" + strUserName.Trim + "'"
                'execute the query and update the database
                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                'assign the task to selected resources
                strSendMailTo = ""
                strOldAssignToIDList = MyBase.GetFormValue("txtOldAssignedToIDList") + ""
                'Modified By VarunA on 2-Dec-2008 For DSS RequestID-10554
                'Purpose : To have employee name checked when the filter is applied.
                'strAssignToIDList = MyBase.GetFormValue("chkAssignTo") + ""
                strAssignToIDList = MyBase.GetFormValue("txtCurrentIDList") + ""
                'End By VarunA on 2-Dec-2008
                If strAssignToIDList <> "" Then
                    arrIDList = Split(strAssignToIDList, ",")
                    Dim i As Integer
                    For i = 0 To arrIDList.Length - 1

                        If arrIDList(i).Trim <> "" Then
                            'get the start date,End date and work hours for the resource
                            strStartDate = MyBase.GetFormValue("txtStartDate" + arrIDList(i).Trim) + ""
                            strEndDate = MyBase.GetFormValue("txtEndDate" + arrIDList(i).Trim) + ""
                            'Added By VarunA on 2-Dec-2008 For DSS RequestID-10554
                            'Purpose : To have the filtered employee value to persist.
                            If strStartDate = "" Or strEndDate = "" Then
                                'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                                'strStartDate = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("SELECT REPLACE(CONVERT(VARCHAR(11),StartDate,106),' ','-') FROM tbl_PM_ProjectTasks WHERE ProjectID=" + m_lngProjectID.ToString + " AND EmployeeID=" + arrIDList(i).Trim + " AND OtherTaskID=" + m_lngIssueID.ToString, MyBase.UseSQL), ""), String)
                                strStartDate = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_ProjectTasks_StartDate " + m_lngProjectID.ToString + "," + arrIDList(i).Trim + "," + m_lngIssueID.ToString, MyBase.UseSQL), ""), String)
                                'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query

                                'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                                'strEndDate = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("SELECT REPLACE(CONVERT(VARCHAR(11),EndDate,106),' ','-') FROM tbl_PM_ProjectTasks WHERE ProjectID=" + m_lngProjectID.ToString + " AND EmployeeID=" + arrIDList(i).Trim + " AND OtherTaskID=" + m_lngIssueID.ToString, MyBase.UseSQL), ""), String)
                                strEndDate = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_ProjectTasks_EndDate  " + m_lngProjectID.ToString + "," + arrIDList(i).Trim + "," + m_lngIssueID.ToString, MyBase.UseSQL), ""), String)
                                'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                            End If
                            'End By VarunA on 2-Dec-2008 For DSS

                            ''Added By Sagar Nipane on 01-March-2019 Purpose::Project Work field level changes 
                            Dim strWorkHrs As String
                            strWorkHrs = MyBase.GetFormValue("txtWorkHrs" + arrIDList(i).Trim)
                            If strWorkHrs = "0" Or strWorkHrs = "" Then
                                strWorkHrs = "00:00"
                            End If

                            If strWorkHrs.IndexOf(":") = strWorkHrs.Length - 1 Then
                                strWorkHrs = strWorkHrs + "00"
                            End If
                            strWorkHrs = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strWorkHrs + "',2)", True)
                            'If MyBase.GetFormValue("txtWorkHrs" + arrIDList(i).Trim) <> "" Then
                            '    dblTaskduration = CType(MyBase.GetFormValue("txtWorkHrs" + arrIDList(i).Trim), Double)
                            'Else
                            '    dblTaskduration = 0
                            'End If
                            If strWorkHrs <> "" Then
                                dblTaskduration = CType(strWorkHrs.Trim(), Double)
                            Else
                                dblTaskduration = 0
                            End If

                            'End of Added By Sagar Nipane on 01-March-2019 Purpose::Project Work field level changes
                            'Added By VarunA on 2-Dec-2008 For DSS RequestID-10554
                            'Purpose : To have the filtered employee value to persist.
                            If dblTaskduration = 0 Then
                                'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                                'dblTaskduration = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("SELECT [Work] FROM tbl_PM_ProjectTasks WHERE ProjectID=" + m_lngProjectID.ToString + " AND EmployeeID=" + arrIDList(i).Trim + " AND OtherTaskID=" + m_lngIssueID.ToString, MyBase.UseSQL), ""), Double)
                                dblTaskduration = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_ProjectTasks_Work_ProjectID " + m_lngProjectID.ToString + "," + arrIDList(i).Trim + "," + m_lngIssueID.ToString, MyBase.UseSQL), ""), Double)
                                'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                            End If
                            'End By VarunA on 2-Dec-2008 For DSS
                            strSQL = "usp_Ins_IB_AssignIssueToEmployee " + m_lngIssueID.ToString + "," + m_lngProjectID.ToString + "," + arrIDList(i).Trim
                            strSQL += "," + dblTaskduration.ToString
                            If strStartDate <> "" Then
                                strSQL += ",'" + strStartDate.Trim + "'"
                            Else
                                strSQL += ",NULL"
                            End If
                            If strEndDate <> "" Then
                                strSQL += ",'" + strEndDate.Trim + "'"
                            Else
                                strSQL += ",NULL"
                            End If
                            'Modified by NitinVS on 31 July 2007 for WhizibleSEM 7 
                            ' if the task is created as void do not added the resource in the list 
                            Dim IsTaskVoid As String = ""
                            IsTaskVoid = General.CheckIsNothing(Data.CheckIsDBNull(Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), "0")

                            'if id exists in the previous list then remove it as this list will be used
                            'after to delete the entries for the remaining ID's
                            If InStr(1, strOldAssignToIDList.Trim, "," + arrIDList(i).Trim + ",") <> 0 Then
                                strOldAssignToIDList = strOldAssignToIDList.Replace("," + arrIDList(i).Trim + ",", ",")
                            ElseIf IsTaskVoid <> "0" Then
                                strSendMailTo += arrIDList(i).Trim + ","
                            End If
                        End If
                        ' end Modification by NitinVS on on 31 July 2007 for WhizibleSEM 7 
                    Next
                    arrIDList = Nothing

                    ' Delete the Issue Task.
                    ' NOTE: If DA is filled against the task, the task will be made inactive.
                    If strOldAssignToIDList <> "" Or strOldAssignToIDList <> "," Then
                        arrIDList = Split(strOldAssignToIDList, ",")
                        Dim j As Integer
                        For j = 0 To arrIDList.Length - 1
                            If arrIDList(j).Trim <> "" Then
                                'Added If Block by PrashantD on 16 Dec 2005 for IssueID 295 DSS
                                'Purpose: If Task is completed then checkbox is not appeared on page.
                                '           So it's status should not be changed. Tasks which are active and display on page 
                                '           as not completed, are applicable for changing status.

                                If Not arrEmployeeID_TaskComplete.Contains(arrIDList(j).Trim) Then
                                    strSQL = "usp_Del_tbl_PM_ProjectTasks_IssueTasks " + m_lngIssueID.ToString + "," + m_lngProjectID.ToString + "," + arrIDList(j).Trim
                                    Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                                End If


                            End If
                        Next
                    End If

                    'If any new assignment is made, mail has to be sent to the resource(s).
                    If strSendMailTo <> "" And strSendMailTo <> "," Then

                        ' Retrieve the details of the message to be sent to the Resource.
                        strSQL = "usp_Sel_tbl_PM_EmailMessages 14"
                        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
                        If objDr.Read Then
                            blnSendMail = CType(Data.CheckIsDBNull(objDr("SendMail"), "0"), Boolean)
                            blnShowPopUp = CType(Data.CheckIsDBNull(objDr("ShowPopup"), "0"), Boolean)
                        Else
                            blnSendMail = False
                            blnShowPopUp = False
                        End If
                        Data.DisposeDataReader(objDr)

                        ' Check if the mail has to be sent.
                        If blnSendMail = True Then
                            'Added by GokulP on 18 May 2010 for Issue Assignment and Mail Placeholder replacement problem
                            Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_14(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, m_lngIssueID, strSendMailTo)
                            If Not strEmailMessage.Contains("<TASK_NAME>") Then
                                'End of Addition by GokulP on 18 May 2010 for Issue Assignment and Mail Placeholder replacement problem
                                ' Check if a popup message has to be shown.
                                If blnShowPopUp = True Then
                                    'write client side script to display the message window
                                    General.WriteHTML("<Script language=javascript>")
                                    General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=14&IssueID=" + m_lngIssueID.ToString + "&EmployeeIDList=" + strSendMailTo.Trim + "','','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');")
                                    General.WriteHTML("</Script>")
                                Else
                                    'send email silently
                                    Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_14(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, m_lngIssueID, strSendMailTo)
                                    Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                                End If
                                'Added by GokulP on 18 May 2010 for Issue Assignment and Mail Placeholder replacement problem
                            End If
                            'End of Addition by GokulP on 18 May 2010 for Issue Assignment and Mail Placeholder replacement problem
                        End If

                        strSQL = "usp_Sel_tbl_IB_Issue " + m_lngIssueID.ToString
                        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
                        If objDr.Read Then
                            lngAssignTo = CType(Data.CheckIsDBNull(objDr("AssignTo"), "0"), Long)
                        End If
                        Data.DisposeDataReader(objDr)

                        'write the value of lngAssignTo to the parent's control
                        General.WriteHTML("<Script language=javascript>")
                        General.WriteHTML("try {")
                        General.WriteHTML("if(opener.frmIssue.AssignTo.value=='') {")
                        General.WriteHTML("opener.frmIssue.AssignTo.value=" + lngAssignTo.ToString + "; }")
                        General.WriteHTML(" else { ")
                        General.WriteHTML("opener.frmIssue.txtOldAssignTo.value =" + lngAssignTo.ToString + "; }")
                        General.WriteHTML(" } catch(e){ }")
                        General.WriteHTML(" window.close(); ")
                        General.WriteHTML("</Script>")

                    End If
                End If

            Case Else
        End Select
    End Sub
    'added BY HarshK for SP4 IssueID 120,121 
    Private Sub DrawHiddenCombo()
        Dim strQuery As String
        strQuery = "Exec usp_Sel_tbl_PM_Project_GetExpectedDates " & m_lngProjectID.ToString
        General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboProjectDates", strQuery, 250, , , True, True, , , , True))
        '-----------------------------------------------
        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'strQuery = "select IsNull(ResourceValidation,0) from tbl_PM_Project WHERE ProjectID = " & m_lngProjectID.ToString
        strQuery = "usp_sel_tbl_PM_Project_ResourceValidation_PID " & m_lngProjectID.ToString
        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        If CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "True"), Boolean) = True Then
            m_bitResourceValidation = 1
        Else
            m_bitResourceValidation = 0
        End If
        '------------------------------------------------
        strQuery = "usp_Sel_Project_Resources_ExpectedDates_AsPer_Role " & m_lngProjectID.ToString & ",0"
        General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboResourceSDT", strQuery, 250, , , True, True, , , , True))

        strQuery = "usp_Sel_Project_Resources_ExpectedDates_AsPer_Role " & m_lngProjectID.ToString & ",1"
        General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboResourceEDT", strQuery, 250, , , True, True, , , , True))


    End Sub

    ' Added by NitinVS on 11 July 2007 To Validte for Project Efforts
    Private Sub GetProjectEffortDetails()
        Dim strQuery As String
        strQuery = "usp_Sel_PM_DepartmentBalanceLCE " + m_lngProjectID.ToString()
        Dim objDRProjectEfforts As IDataReader
        objDRProjectEfforts = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If objDRProjectEfforts.Read() Then
            m_ProjectEfforts = CommonFunction.Data.CheckIsDBNull(objDRProjectEfforts.Item("LCETotal"), "0").ToString()
            m_ProjectAllocatedEfforts = CommonFunction.Data.CheckIsDBNull(objDRProjectEfforts.Item("AllocatedLCETotal"), "0").ToString()

            If m_ProjectEfforts <> "" And m_ProjectAllocatedEfforts <> "" Then
                m_ProjectBalanceEfforts = CType(CType(m_ProjectEfforts, Double) - CType(m_ProjectAllocatedEfforts, Double), String)
            End If

        End If
        CommonFunction.Data.DisposeDataReader(objDRProjectEfforts)

        ' Get the Alloready Allocated Task Efforts for The Issue m_lngIssueID
        strQuery = " usp_sel_IssueTaskEforts " + m_lngProjectID.ToString() + ", " + m_lngIssueID.ToString()
        objDRProjectEfforts = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If objDRProjectEfforts.Read Then
            m_IssueEfforts = CType(CommonFunction.Data.CheckIsDBNull(objDRProjectEfforts.Item("Work"), "0"), String)
        Else
            m_IssueEfforts = "0"
        End If
        CommonFunction.Data.DisposeDataReader(objDRProjectEfforts)
    End Sub
    ' End Addition by NitinVS on 11 July 2007 To Validte for Project Efforts

    'End added BY HarshK for SP4 IssueID 120,121 
    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
End Class
