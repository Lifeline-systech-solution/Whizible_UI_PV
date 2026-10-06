Imports CommonFunctions


Public Class IB_IssueAssignmentWithActivity
    Inherits WebPages.Template.WhizTemplate

    Protected Const CONST_SHOW_ASSIGNED As String = "ASSIGNED"
    Protected Const CONST_SHOW_ALL As String = "ALL"
    Protected Const CONST_ACTION_SAVE As String = "SAVE"
    Protected Const CONST_ACTION_REOPEN As String = "REOPEN"
    Protected Const CONST_ACTION_ADDNEW As String = "ADDNEW"
    Protected Const CONST_ACTION_CANCEL As String = "CANCEL"
    Protected Const CONST_ACTION_DELETE As String = "DELETE"

    'there constants are used as index for the array, so that no need to check the index
    'for the column each time
    Private Const EMPID As Integer = 0
    Private Const ACTIVITY As Integer = 1
    Private Const STARTDATE As Integer = 2
    Private Const ENDDATE As Integer = 3
    Private Const WORKHRS As Integer = 4
    Private Const TASKID As Integer = 5

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
    'Private m_strOldAssignedToIDList As String
    Private m_lngTaskTypeID As Long
    Private m_strTaskType As String
    Private m_intNewRows As Integer
    Private m_intRowCount As Integer
    Private m_arrResourcesInfo(0, 0) As String
    'added by SachinR   on 02 Jul 2004
    'to implement Type-role security for issue
    Private m_strType As String
    'addition end
    'added by Harshk on 11/10/2005'
    Protected m_bitResourceValidation As Int16 = 1
    'End added by Harshk on 11/10/2005'
    'Added by SavitaS on 20 Sept 2006 for Security Issue 6197
    Protected m_strIssueID As String
    Protected m_PKToken As String

    ''Added by Dhanashri S on 1 Sept 2016 for pktoken
    Protected m_PKTokenEmployee As String
    ''End of Addition by Dhanashri S on 1 Sept 2016

    'End of Added by SavitaS on 20 Sept 2006 for Security Issue 6197

    ' Added by NitinVS on 11 July 2007 To Validte for Project Efforts
    Protected m_ProjectEfforts As String = "0"
    Protected m_ProjectAllocatedEfforts As String = "0"
    Protected m_ProjectBalanceEfforts As String = "0"
    Protected m_IssueEfforts As String = "0"
    'End Addition by NitinVS on 11 July 2007 To Validte for Project Efforts

    'Added By Sagar N on 14-Mar-2019 Purpose :: Work Field Level changes
    Dim strWorkHrs As String
    Protected m_RestrictByMinHours As String
    'End of Added By Sagar N on 14-Mar-2019 Purpose :: Work Field Level changes

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
    ' Created				:	May 25 2004
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

        ' Added by SavitaS 20 Sept 2006 for Security Issue 6197     

        If Not Request.QueryString("IssueID") Is Nothing Then
            m_strIssueID = Request.QueryString("IssueID").ToString
        Else
            m_strIssueID = "0"
        End If

        If CType(m_PKToken, String) <> "0" Then
            If Request.QueryString("PKToken") Is Nothing Then
                m_PKToken = Request.Form("txtPkToken").ToString
            Else
                m_PKToken = Request.QueryString("PKToken").ToString
            End If
        End If

        If ((m_PKToken = "") And (m_strIssueID.ToString <> "0")) Or _
((m_strIssueID.ToString <> "0") And (CommonFunctions.Security.Token.ValidateToken(CType(m_strIssueID, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String), m_PKToken) = False)) Then
            Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue : Issue Assignment with Activity", 0, 0, "Issue ID", CType(m_strIssueID, String))
            'Token is Invalid now redirect to the Invalid Access Page
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If
        ' End of Added by SavitaS 20 Sept 2006 for Security Issue 6197

        ''Added by Dhanashri S on 1 Sept 2016 For MasterCard PKToken
        ''ADDED BY NILESH G ON 18/8/2016 pURPOSE :pK TOKEN ISSUE
        m_PKToken = CommonFunctions.Security.Token.GetToken(m_strIssueID.ToString + CType(Session("intUserID"), String) + "0" + "0")
        ''END OF ADDED BY NILESH G ON 18/8/2016 pURPOSE :pK TOKEN ISSUE
        ''End of Addition by Dhanashri S on 1 Sept 2016

  
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

        'TODO : get from the querystring, hardcoded for testing
        'm_lngIssueID = 2114
        'm_lngUserID = 61

        If IsPostBack Then
            'if page is posted back then get the values form the hidden controls

            m_strAssignedToIDList = MyBase.GetFormValue("txtCurrentIDList") + ""
            'm_strOldAssignedToIDList = MyBase.GetFormValue("txtOldAssignedToIDList") + ""

            If MyBase.GetFormValue("txtDuration") <> "" Then
                m_dblDuration = CType(MyBase.GetFormValue("txtDuration"), Double)
            End If
            m_lngProjectID = CType(MyBase.GetFormValue("txtProjectID"), Long)
            m_strDueDate = MyBase.GetFormValue("txtDueDate") + ""
            m_strReportedDate = MyBase.GetFormValue("txtReportedDate") + ""
            m_lngTaskTypeID = CType(MyBase.GetFormValue("txtTaskTypeID"), Long)
            m_strTaskType = MyBase.GetFormValue("txtTaskType") + ""

            'get the total no of rows in the table and no of new tasks in that
            m_intRowCount = CType(MyBase.GetFormValue("txtRowCount"), Integer)
            m_intNewRows = CType(MyBase.GetFormValue("txtNewRows"), Integer)

            'added by SachinR   on 02 Jul 2004
            'to implement type-role security
            m_strType = MyBase.GetFormValue("txtType") + ""
            'addition end

        Else
            'get the details of issue and list of assigned resource IDs
            Call getIssueDetails(m_lngIssueID)
            m_intNewRows = 0

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

        'Call getAssignedResourceIDList(m_lngIssueID)

        'Added By VarunA on 9-Sep-2008
        'Purpose : To mark the task as void, which is created when the project is ON HOLD and the Assign Issue to Responsible Person is checked
        Dim strProjectHoldSQL As String = ""
        Dim strProjectStatus As String
        If m_lngIssueID.ToString() <> "" Then
            strProjectHoldSQL = "EXEC usp_sel_ProjectIssue_Status " & m_lngIssueID.ToString()
            strProjectStatus = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strProjectHoldSQL, MyBase.UseSQL), "0")
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txtProjectStatus", "txtProjectStatus", value:=strProjectStatus, IsHidden:=True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        End If
        'End By VarunA on 9-Sep-2008

        If m_strAction <> "" Then
            'update the database based on the action
            Call performAction()
        End If
        Call getAssignedResourceIDList(m_lngIssueID)

        'get the values of the new records in the array to persist those values
        'reinitialize the array
        ReDim m_arrResourcesInfo(m_intNewRows - 1, 5)
        Dim intRowCntr As Integer = 0
        Dim intArrayCntr As Integer = 0
        Dim dblNewDuration As Double
        dblNewDuration = 0

        For intRowCntr = 1 To m_intRowCount
            If m_strAction = CONST_ACTION_CANCEL Then
                'check that row is not canceled and its a new row
                If MyBase.GetFormValue("txtTaskID" + intRowCntr.ToString) = "" Then
                    If MyBase.GetFormValue("chkCancel" + intRowCntr.ToString) = "" Then
                        m_arrResourcesInfo(intArrayCntr, EMPID) = MyBase.GetFormValue("cboEmployee" + intRowCntr.ToString) + ""
                        m_arrResourcesInfo(intArrayCntr, ACTIVITY) = MyBase.GetFormValue("cboActivity" + intRowCntr.ToString) + ""
                        m_arrResourcesInfo(intArrayCntr, STARTDATE) = MyBase.GetFormValue("txtStartDate" + intRowCntr.ToString) + ""
                        m_arrResourcesInfo(intArrayCntr, ENDDATE) = MyBase.GetFormValue("txtEndDate" + intRowCntr.ToString) + ""
                        m_arrResourcesInfo(intArrayCntr, WORKHRS) = MyBase.GetFormValue("txtWorkHrs" + intRowCntr.ToString) + ""
                        m_arrResourcesInfo(intArrayCntr, TASKID) = MyBase.GetFormValue("txtTaskID" + intRowCntr.ToString) + ""
                        'added by SachinR   On 04 Jun 2004
                        ''Commented & Added By Sagar Nipane on 14-March-2019 Purpose::Whizible 2 Work field change
                        'If m_arrResourcesInfo(intArrayCntr, WORKHRS) <> "" Then
                        '    dblNewDuration += CType(m_arrResourcesInfo(intArrayCntr, WORKHRS), Double)
                        'End If

                        strWorkHrs = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + m_arrResourcesInfo(intArrayCntr, WORKHRS).ToString + "',2)", True)
                        If m_arrResourcesInfo(intArrayCntr, WORKHRS) <> "" Then
                            dblNewDuration += CType(strWorkHrs, Double)
                        End If
                        strWorkHrs = ""

                        ''End of commented & Added By Sagar Nipane on 14-March-2019 Purpose::Whizible 2 Work field change

                        'end addition
                        intArrayCntr += 1
                    Else
                        m_intNewRows -= 1
                        m_intRowCount -= 1
                    End If
                End If
            Else
                'store values only if it is new task
                If MyBase.GetFormValue("txtTaskID" + intRowCntr.ToString) = "" Then
                    m_arrResourcesInfo(intArrayCntr, EMPID) = MyBase.GetFormValue("cboEmployee" + intRowCntr.ToString) + ""
                    m_arrResourcesInfo(intArrayCntr, ACTIVITY) = MyBase.GetFormValue("cboActivity" + intRowCntr.ToString) + ""
                    m_arrResourcesInfo(intArrayCntr, STARTDATE) = MyBase.GetFormValue("txtStartDate" + intRowCntr.ToString) + ""
                    m_arrResourcesInfo(intArrayCntr, ENDDATE) = MyBase.GetFormValue("txtEndDate" + intRowCntr.ToString) + ""
                    m_arrResourcesInfo(intArrayCntr, WORKHRS) = MyBase.GetFormValue("txtWorkHrs" + intRowCntr.ToString) + ""
                    m_arrResourcesInfo(intArrayCntr, TASKID) = MyBase.GetFormValue("txtTaskID" + intRowCntr.ToString) + ""
                    'added by SachinR   On 04 Jun 2004

                    ''Commented & Added By Sagar Nipane on 14-March-2019 Purpose::Whizible 2 Work field change

                    'If m_arrResourcesInfo(intArrayCntr, WORKHRS) <> "" Then
                    '    dblNewDuration += CType(m_arrResourcesInfo(intArrayCntr, WORKHRS), Double)
                    'End If
                    Dim strabcd As String = m_arrResourcesInfo(intArrayCntr, WORKHRS).ToString
                    strWorkHrs = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + m_arrResourcesInfo(intArrayCntr, WORKHRS).ToString + "',2)", True)
                    If m_arrResourcesInfo(intArrayCntr, WORKHRS) <> "" Then
                        dblNewDuration += CType(strWorkHrs, Double)
                    End If
                    strWorkHrs = ""

                    ''End of commented & Added By Sagar Nipane on 14-March-2019 Purpose::Whizible 2 Work field change
                    'end addition 
                    intArrayCntr += 1
                End If
            End If
        Next

        m_dblDuration += dblNewDuration

        'initialize the resource file for standard menu.
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        arrMenu = New System.Collections.ArrayList
        arrMenuToolTip = New System.Collections.ArrayList
        arrClientSideFunctions = New System.Collections.ArrayList

        If blnShowTimesheetMenu = True Then
            arrMenu.Add(MyBase.GetResourceString("MENU_TIMESHEET_DEAILS")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_TIMESHEET_DEAILS_TOOLTIP")) : arrClientSideFunctions.Add("ShowTimesheet_OnClick()")
        End If
        arrMenu.Add(MyBase.GetResourceString("MENU_ADDNEW")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_ADDNEW_TOOLTIP")) : arrClientSideFunctions.Add("AddNew_OnClick()")
        arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("Save_OnClick()")
        arrMenu.Add(MyBase.GetResourceString("MENU_CANCEL")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CANCEL_TOOLTIP")) : arrClientSideFunctions.Add("Cancel_OnClick()")
        arrMenu.Add(MyBase.GetResourceString("MENU_DELETE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_DELETE_TOOLTIP")) : arrClientSideFunctions.Add("Delete_OnClick()")
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

        ''create the pagin links
        ''plot the grid for the list of assigned resources
        'strSQL = "usp_Sel_IB_IssueEntry_EmployeeList_PagingAlphabet 'AssignTo'," + m_lngProjectID.ToString + ",NULL"
        'If m_strMode = CONST_SHOW_ASSIGNED Then
        '    strSQL += ", 'AND E.EmployeeID IN (0" + m_strAssignedToIDList.Trim + "0)'"
        'Else
        '    strSQL += ",Null"
        'End If
        ''display the paging links on the menu bar
        'objPaging = New WebPage.Templates.Paging
        'strPagingHTML = objPaging.DrawPaging(m_strAlphabet, strSQL, MyBase.GetResourceString("PAGING_SELECT"), "Paging_OnClick", "UserName", True)
        'objPaging = Nothing

        strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
        'draw upper menu
        General.WriteHTML(strMenu)
        General.WriteHTML("<BR>")
        'create lower menu without paging
        strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)

        ''Display the (* Mandatory) PageLegends 
        'Dim strarrLegend() As String = {"Mandatory"}
        'Dim strarrLegendImage() As String = {"<img src='../../images/star.gif'>"}
        'General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, strarrLegendImage, strarrLegend) + vbCrLf)

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

        'plot the lower menu
        General.WriteHTML("<BR>")
        General.WriteHTML(strMenu)
        'added by harshK for sp4 issueid 120,121
        DrawHiddenCombo()
        'End added by harshK for sp4 issueid 120,121

        ' Added By NitinVS on 12 July 2007 for WhizibleSEM 7 To validate for Project Efforts 
        Call GetProjectEffortDetails()
        ' Added By NitinVS on 12 July 2007 for WhizibleSEM 7 To validate for Project Efforts 

        ''Added By Sagar Nipane on 04-March-2019 Purpose::Whizible 2 Work field change
        Dim drCompany As IDataReader
        drCompany = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation", True)
        If drCompany.Read() Then
            m_RestrictByMinHours = CommonFunction.Data.CheckIsDBNull(drCompany("RestrictByMinHours"), "0")
        End If
        ''End of Added By Sagar Nipane on 04-March-2019 Purpose::Whizible 2 Work field change
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
    ' Created				:	May 25 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotScreenForResources(ByVal lngIssueID As Long)
        Dim strSQL As String
        'Dim strCurrentEmpIDList As String
        Dim objdr As IDataReader
        'Dim objDrIssue As IDataReader
        Dim blnIsTaskComplete As Boolean
        'Dim strFilter As String
        'Dim strOldAssignedToIdList As String
        Dim objLink As WebPage.UI.cDynamicLink
        Dim lngEmployeeID As Long
        Dim strUserName As String
        Dim strLocation As String
        Dim strDesignation As String
        Dim strStartDate As String
        Dim strEndDate As String
        Dim dblWorkHrs As Double
        Dim lngTaskID As Double
        'Dim blnIssueAssigned As Boolean
        Dim intRowCount As Integer
        Dim objDrInfo As IDataReader

        Dim strSubTaskTypes As String
        Dim strActivityName As String

        '--- Addded By purvaj on 7 Nov 2008 for whiziblesem 8.0
        '--- added for validation current hours should not be less than actual work hours
        Dim dblActualWorkHrs As Double
        '--- end addition purvaj
  'Added by TruptiK on 25 Mar 09
        Dim stractualStartDate As String
        'End of addition by Truptik

        ''Integrated by AmitJ for whizible SP 7.2 Issue ID 2326
        ''Code added by SwatiC on 16 June 2006 for Sierra IssueID : 2326
        ''Purpose : To disallow Delete task if dailyactivity is field against it(Issue Assignment Page).
        'Dim dblAllowDelete As Double = 0.0
        ''End of code addition By SwatiC on 16 June 2006 for Sierra IssueID : 2326
        ''End OF integration By AmitJ

        'plot the filter textbox
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        General.WriteHTML("<Table class='clsTable' cellspacing=0 cellpadding=0 width=99.9% >")
        objLink = New WebPage.UI.cDynamicLink
        objLink.ReturnHTML = True

        'display due date textbox
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='right' >" + MyBase.GetResourceString("CAP_DUE_DATE") + "&nbsp;</TD>")
        General.WriteHTML("<TD align='left' >")
        m_strDueDate = Dates.GetDate(CType(m_strDueDate.Trim, Date))
        General.WriteHTML(HTMLControls.DrawDateControl("txtDueDate", "txtDueDate", , , m_strDueDate.Trim, , "frmIB_IssueAssignmentWithActivity", , , , , , , True, True) + "</TD>")

        'Commented & Added By Sagar N on 07-Mar-2019 Purpose :: Work Field Level changes
        'General.WriteHTML("<TD align='right' width=15% >" + MyBase.GetResourceString("CAP_WORK_HRS") + " <B>:</B></TD>")
        'General.WriteHTML("<TD id='tdDuration' align='left'><B> " + Math.Round(m_dblDuration, 2).ToString + "</B></TD>")

        General.WriteHTML("<TD align='right' width=15% >Work (H:M) <B>:</B></TD>")

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

        'plot the column headers
        General.WriteHTML("<Div id='DivList' width=100% style='Overflow: auto; Width:100%;' height=90% >")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        General.WriteHTML("<Table class='clsTable' cellspacing=0 cellpadding=0 width=99.9% >")

        General.WriteHTML("<TR class='clsTRColumnHeader'>")
        General.WriteHTML("<TD align=left >" + MyBase.GetResourceString("COL_USER_NAME") + "</TD>")
        General.WriteHTML("<TD align=left >" + MyBase.GetResourceString("COL_ACTIVITY") + "</TD>")
        'Commented and modified by GaneshD on 22 Sep 2009
        'General.WriteHTML("<TD>" + MyBase.GetResourceString("COL_LOCATION") + "</TD>")
        'General.WriteHTML("<TD>" + MyBase.GetResourceString("COL_DESIGNATION") + "</TD>")
        General.WriteHTML("<TD>Organization Unit</TD>")
        General.WriteHTML("<TD>Role</TD>")
        ' End of modification by GnaeshD on 22 Sep 2009
        General.WriteHTML("<TD align=left >" + MyBase.GetResourceString("COL_SHOW_SCHEDULE") + "</TD>")
        General.WriteHTML("<TD align=left >" + MyBase.GetResourceString("COL_START_DATE") + "</TD>")
        General.WriteHTML("<TD align=left >" + MyBase.GetResourceString("COL_END_DATE") + "</TD>")
        'Commented & Added By Sagar N on 14-March-2019 Purpose:: Work Field Level  Changes
        'General.WriteHTML("<TD align=left >" + MyBase.GetResourceString("COL_WORKHRS") + "</TD>")
        General.WriteHTML("<TD align=left > Work (H:M) </TD>")
        'Commented & Added By Sagar N on 14-March-2019 Purpose:: Work Field Level  Changes
        General.WriteHTML("<TD align=left >" + MyBase.GetResourceString("COL_REOPEN") + "</TD>")
        General.WriteHTML("<TD align=left >" + MyBase.GetResourceString("COL_CANCEL") + "</TD>")
        General.WriteHTML("<TD align=left >" + MyBase.GetResourceString("COL_DELETE") + "</TD>")
        General.WriteHTML("</TR>")

        intRowCount = 0
        'open the datareader and get data
        strSQL = "usp_Sel_tbl_PM_ProjectTasks_IssueTasks " + m_lngIssueID.ToString
        objdr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        While objdr.Read
            intRowCount += 1

            lngEmployeeID = CType(objdr("EmployeeID"), Long)
            'strCurrentEmpIDList += lngEmployeeID.ToString + ","
            strSubTaskTypes = Data.CheckIsDBNull(objdr("SubTaskTypes"), "").ToString
            ''Added by Dhanashri S on 1 Sept 2016 for Pktoken
            m_PKTokenEmployee = CommonFunctions.Security.Token.GetToken(lngEmployeeID.ToString + CType(Session("intUserID"), String) + "0" + "0")
            ''End of Addition by Dhanashri S on 1 Sept 2016
            strStartDate = Dates.GetDate(CType(objdr("StartDate").ToString + "", Date))
            strEndDate = Dates.GetDate(CType(objdr("EndDate").ToString + "", Date))
            dblWorkHrs = CType(Data.CheckIsDBNull(objdr("Work"), "0"), Double)
            lngTaskID = CType(Data.CheckIsDBNull(objdr("TaskID"), "0"), Long)
            blnIsTaskComplete = CType(Data.CheckIsDBNull(objdr("IsTaskComplete"), "0"), Boolean)
            strActivityName = ""

            dblActualWorkHrs = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objdr("Actualwork"), 0), 0)
			stractualStartDate = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objdr("actualStartDate"), ""), ""), String)
            If strSubTaskTypes <> "" Then
                strSQL = "usp_sel_SubTaskType_ForIssue " + m_lngTaskTypeID.ToString + "," + strSubTaskTypes.Trim
                objDrInfo = Data.GetDataReader(strSQL, MyBase.UseSQL)
                If objDrInfo.Read Then
                    strActivityName = Data.CheckIsDBNull(objDrInfo("SubTaskType"), "").ToString
                End If
                Data.DisposeDataReader(objDrInfo)
            End If

            strUserName = ""
            strLocation = ""
            strDesignation = ""
            'get the details of the employee
            strSQL = "usp_Sel_IB_IssueEntry_EmployeeList 'AssignTo'," + m_lngProjectID.ToString + ",NULL"
            strSQL += ", 'AND E.EmployeeID IN (" + lngEmployeeID.ToString + ")'"
            objDrInfo = Data.GetDataReader(strSQL, MyBase.UseSQL)
            If objDrInfo.Read Then
                strUserName = objDrInfo("UserName").ToString + ""
                strLocation = objDrInfo("Location").ToString + ""
                strDesignation = objDrInfo("RoleDescription").ToString + ""
            End If
            Data.DisposeDataReader(objDrInfo)

            '****************************************************************************************
            If intRowCount Mod 2 = 0 Then
                General.WriteHTML("<TR class='clsTREven'>")
            Else
                General.WriteHTML("<TR class='clsTROdd'>")
            End If

            General.WriteHTML("<TD align='left' id='tdEmployee" + intRowCount.ToString + "' >" + strUserName.Trim)
            General.WriteHTML("</TD>")

            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            General.WriteHTML(HTMLControls.DrawTextBox("txtTaskID" + intRowCount.ToString, "txtTaskID" + intRowCount.ToString, , , , lngTaskID.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
            General.WriteHTML(HTMLControls.DrawTextBox("cboEmployee" + intRowCount.ToString, "cboEmployee" + intRowCount.ToString, , , , lngEmployeeID.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
            'ended by Yogesh J for HTML encoding Date:06/10/15
            'display the list of activities or selected activity for the assigned task
            General.WriteHTML("<TD align='left' id='tdActivity" + intRowCount.ToString + "' >")
            General.WriteHTML(strActivityName.Trim)
            General.WriteHTML("</TD>")
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            General.WriteHTML(HTMLControls.DrawTextBox("cboActivity" + intRowCount.ToString, "cboActivity" + intRowCount.ToString, , , , strSubTaskTypes.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            'ended by Yogesh J for HTML encoding Date:06/10/15
            General.WriteHTML("<TD align='left'>" + strLocation.Trim + "</TD>")
            General.WriteHTML("<TD align='left'>" + strDesignation.Trim + "</TD>")
            objLink.LinkName = MyBase.GetResourceString("LINK_SHOW_SCHEDULE_LINK") + ""
            objLink.Tooltip = MyBase.GetResourceString("LINK_SHOW_SCHEDULE_LINK_TOOLTIP") + ""
            objLink.FunctionName = "ShowSchedule_OnClick('" + intRowCount.ToString + "','" + strStartDate.Trim + "','" + strEndDate.Trim + "')"
            General.WriteHTML("<TD align='center'>" + objLink.GetDynamicLink() + "</TD>")

            If blnIsTaskComplete Then
                General.WriteHTML("<TD align='left'>")
                General.WriteHTML(strStartDate.Trim)
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                General.WriteHTML(HTMLControls.DrawTextBox("txtStartDate" + intRowCount.ToString, "txtStartDate" + intRowCount.ToString, , , , strStartDate.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:06/10/15
                General.WriteHTML("</TD>")
                General.WriteHTML("<TD align='left'>")
                General.WriteHTML(strEndDate.Trim)
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                General.WriteHTML(HTMLControls.DrawTextBox("txtEndDate" + intRowCount.ToString, "txtEndDate" + intRowCount.ToString, , , , strEndDate.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:06/10/15
                General.WriteHTML("</TD>")
                General.WriteHTML("<TD align='left'>")

                ''Commented and Added By Sagar Nipane on 07-March-2019 Purpose::Project Work field level changes 
                'General.WriteHTML(dblWorkHrs.ToString)

                strWorkHrs = dblWorkHrs.ToString
                If strWorkHrs = 0 Or strWorkHrs = "" Then
                    strWorkHrs = "00.00"
                End If
                strWorkHrs = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + dblWorkHrs + "',1)", True)

                General.WriteHTML(strWorkHrs.ToString + "</TD>")
                ''End of Added By Sagar Nipane on 07-March-2019 Purpose::Project Work field level changes


                'Code Added By VidyaJ on 11th July 2005 - For Nucleus IssueID - 19865 
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                General.WriteHTML(HTMLControls.DrawTextBox("txtWorkHrs" + intRowCount.ToString, "txtWorkHrs" + intRowCount.ToString, , 50, , dblWorkHrs.ToString, "right", , , , , True, , , , , , True, EnableHTMLEncode:=True) + "</TD>")
                'ended by Yogesh J for HTML encoding Date:06/10/15
                'End Of addition By VidyaJ on 11th July 2005 - For Nucleus IssueID - 19865
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                General.WriteHTML(HTMLControls.DrawTextBox("txtTaskComplete" + intRowCount.ToString, "txtTaskComplete" + intRowCount.ToString, , , , "1", , , , , , True, , True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:06/10/15
                General.WriteHTML("</TD>")
            Else
                General.WriteHTML("<TD align='left'>")
                General.WriteHTML(HTMLControls.DrawDateControl("txtStartDate" + intRowCount.ToString, "txtStartDate" + intRowCount.ToString, , , strStartDate.Trim, , "frmIB_IssueAssignmentWithActivity", , , , , , , True) + "</TD>")
                General.WriteHTML("<TD align='left'>")
                General.WriteHTML(HTMLControls.DrawDateControl("txtEndDate" + intRowCount.ToString, "txtEndDate" + intRowCount.ToString, , , strEndDate.Trim, , "frmIB_IssueAssignmentWithActivity", , , , , , , True) + "</TD>")
                General.WriteHTML("<TD align='left'>")
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15

                ''Commented and Added By Sagar Nipane on 01-March-2019 Purpose::Project Work field level changes 
                'General.WriteHTML(HTMLControls.DrawTextBox("txtWorkHrs" + intRowCount.ToString, "txtWorkHrs" + intRowCount.ToString, , 50, , dblWorkHrs.ToString, "right", , , , , , " onblur='javascript:WorkHrs_OnBlur(this," + intRowCount.ToString + ")' onfocus='javascript:WorkHrs_OnFocus(this)'", True, EnableHTMLEncode:=True) + "</TD>")

                strWorkHrs = dblWorkHrs.ToString
                If strWorkHrs = 0 Or strWorkHrs = "" Then
                    strWorkHrs = "00.00"
                End If
                strWorkHrs = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strWorkHrs + "',1)", True)

                General.WriteHTML(HTMLControls.DrawTextBox("txtWorkHrs" + intRowCount.ToString, "txtWorkHrs" + intRowCount.ToString, , 50, , strWorkHrs.ToString, "right", , , , , , " onblur='javascript:WorkHrs_OnBlur(this," + intRowCount.ToString + ")' onfocus='javascript:WorkHrs_OnFocus(this)'", True, EnableHTMLEncode:=True) + "</TD>")

                ''End of Added By Sagar Nipane on 07-March-2019 Purpose::Project Work field level changes

                General.WriteHTML(HTMLControls.DrawTextBox("txtTaskComplete" + intRowCount.ToString, "txtTaskComplete" + intRowCount.ToString, , , , "1", , , , , , True, , True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:06/10/15
            End If

            If blnIsTaskComplete Then
                General.WriteHTML("<TD align='left'>")
                objLink.LinkName = MyBase.GetResourceString("LINK_REOPEN") + ""
                objLink.Tooltip = MyBase.GetResourceString("LINK_REOPEN_TOOLTIP") + ""
                objLink.FunctionName = "ReOpenTask_OnClick('" + intRowCount.ToString + "')"
                General.WriteHTML(objLink.GetDynamicLink())
                '                General.WriteHTML("</TD>")
            Else
                General.WriteHTML("<TD align='left'>")
                General.WriteHTML(MyBase.GetResourceString("CAP_NA") + "")

            End If
            '--- added By PurvaJ on 7 Nov 2008 for Whiziblesem8.0
            '--- for validation - Current work hours  should not be less than actual work hours
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunction.HTMLControls.DrawTextBox("hid_txtActualHours" + intRowCount.ToString, "hid_txtActualHours" + intRowCount.ToString, , 200, , dblActualWorkHrs.ToString, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
            General.WriteHTML("</TD>")
            '--- End addition purvaJ
   'Added by TruptiK on 25 Mar 09
            If stractualStartDate <> "" Then
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                CommonFunction.HTMLControls.DrawTextBox("hid_txtactualStartDate" + intRowCount.ToString, "hid_txtactualStartDate" + intRowCount.ToString, , 200, , (CDate(stractualStartDate).ToString("dd-MMM-yyyy")), , , , , , True, EnableHTMLEncode:=True)
            Else
                CommonFunction.HTMLControls.DrawTextBox("hid_txtactualStartDate" + intRowCount.ToString, "hid_txtactualStartDate" + intRowCount.ToString, , 200, , stractualStartDate, , , , , , True, EnableHTMLEncode:=True)
                'ended by Yogesh J for HTML encoding Date:06/10/15
            End If
            'End of addition by Trupitk

            'diplay cancel checkbox, as hidden 
            General.WriteHTML("<TD align=center >")
            General.WriteHTML(HTMLControls.DrawCheckBox("chkCancel" + intRowCount.ToString, "chkCancel" + intRowCount.ToString, , , "1", , , True, , , , True))
            General.WriteHTML("</TD>")

            General.WriteHTML("<TD align=center >")

            '''Integrated by AmitJ for whizible SP 7.2 Issue ID 
            '''General.WriteHTML(HTMLControls.DrawCheckBox("chkDelete" + intRowCount.ToString, "chkDelete" + intRowCount.ToString, , , "1", , , True))
            '''Code added by SwatiC on 16 June 2006 for Sierra IssueID : 2326
            '''Purpose : To disallow Delete task if dailyactivity is field against it(Issue Assignment Page).

            ''strSQL = " EXEC usp_Allow_Inactive_Issue_Task " + CType(lngTaskID, String) + "," + m_lngIssueID.ToString
            ''dblAllowDelete = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), Double)
            '''drDAEntry = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

            ''If dblAllowDelete = 0.0 Then
            ''    General.WriteHTML(HTMLControls.DrawCheckBox("chkDelete" + intRowCount.ToString, "chkDelete" + intRowCount.ToString, , , "1", , , True))
            ''Else
            ''    General.WriteHTML(HTMLControls.DrawCheckBox("chkDelete" + intRowCount.ToString, "chkDelete" + intRowCount.ToString, , , "1", True, , True))
            ''End If
            '''General.WriteHTML(HTMLControls.DrawCheckBox("chkDelete" + intRowCount.ToString, "chkDelete" + intRowCount.ToString, , , "1", , , True))
            '''End of code addition By SwatiC on 16 June 2006 for Sierra IssueID : 2326
            '''End OF integration By AmitJ



            General.WriteHTML(HTMLControls.DrawCheckBox("chkDelete" + intRowCount.ToString, "chkDelete" + intRowCount.ToString, , , "1", , , True))
            General.WriteHTML("</TD>")

            General.WriteHTML("</TR>")
            '****************************************************************************************
        End While
        Data.DisposeDataReader(objdr)


        'display newly added but not saved row here, with the values in the array
        Dim intNewRow As Integer
        intNewRow = 0
        While intNewRow < m_intNewRows

            intRowCount += 1

            lngTaskID = 0
            lngEmployeeID = 0
            If m_arrResourcesInfo(intNewRow, EMPID) <> "" Then
                lngEmployeeID = CType(m_arrResourcesInfo(intNewRow, EMPID), Long)
            End If
            strSubTaskTypes = m_arrResourcesInfo(intNewRow, ACTIVITY) + ""
            strStartDate = m_arrResourcesInfo(intNewRow, STARTDATE) + ""
            strEndDate = m_arrResourcesInfo(intNewRow, ENDDATE) + ""
            dblWorkHrs = 0

            ''Commented & Added By Sagar Nipane on 14-March-2019 Purpose::Whizible 2 Work field change

            'If m_arrResourcesInfo(intNewRow, WORKHRS) <> "" Then
            '    dblWorkHrs = CType(m_arrResourcesInfo(intNewRow, WORKHRS), Double)
            'End If

            strWorkHrs = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + m_arrResourcesInfo(intNewRow, WORKHRS).ToString + "',2)", True)
            If m_arrResourcesInfo(intNewRow, WORKHRS) <> "" Then
                dblWorkHrs += CType(strWorkHrs, Double)
            End If
            strWorkHrs = ""

            ''End of Commented & Added By Sagar Nipane on 14-March-2019 Purpose::Whizible 2 Work field change

            If intRowCount Mod 2 = 0 Then
                General.WriteHTML("<TR class='clsTREven'>")
            Else
                General.WriteHTML("<TR class='clsTROdd'>")
            End If

            General.WriteHTML("<TD align='left' id='tdEmployee" + intRowCount.ToString + "' >")
            strSQL = "usp_Sel_ProjectResources_TaskAssignment " + m_lngProjectID.ToString

            'added by SachinR   on 02 jul 2004
            'This is to implement Role based issue security. Here issue type is taken from the database
            'and passed to the SP to check which employee has access to the type based on its Project Role
            'so that only those employee will be listed to assign
            If m_strType <> "" Then
                strSQL += ",'" + m_strType.Trim + "'"
            End If
            'addition end

            General.WriteHTML(HTMLControls.DrawComboBox("cboEmployee" + intRowCount.ToString, strSQL, 100, lngEmployeeID.ToString, "onchange='javascript:Employee_OnChange(" + intRowCount.ToString + ")'", True, True))

            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            General.WriteHTML(HTMLControls.DrawTextBox("txtTaskID" + intRowCount.ToString, "txtTaskID" + intRowCount.ToString, , , , , , , , , , True, , True, EnableHTMLEncode:=True))
            'ended by Yogesh J for HTML encoding Date:06/10/15
            General.WriteHTML("</TD>")

            'display the list of activities or selected activity for the assigned task
            General.WriteHTML("<TD align='left' id='tdActivity" + intRowCount.ToString + "' >")
            strSQL = "usp_sel_SubTaskType_ForIssue " + m_lngTaskTypeID.ToString + ",NULL," + m_lngProjectID.ToString
            General.WriteHTML(HTMLControls.DrawComboBox("cboActivity" + intRowCount.ToString, strSQL, 100, strSubTaskTypes.Trim, , True, True))
            General.WriteHTML("</TD>")

            'if employee selected then display its designation and location
            strLocation = ""
            strDesignation = ""

            If lngEmployeeID > 0 Then
                strSQL = "usp_Sel_IB_IssueEntry_EmployeeList 'AssignTo'," + m_lngProjectID.ToString + ",NULL"
                strSQL += ", 'AND E.EmployeeID IN (" + lngEmployeeID.ToString + ")'"
                objDrInfo = Data.GetDataReader(strSQL, MyBase.UseSQL)
                If objDrInfo.Read Then
                    strLocation = objDrInfo("Location").ToString + ""
                    strDesignation = objDrInfo("RoleDescription").ToString + ""
                End If
                Data.DisposeDataReader(objDrInfo)
            End If

            General.WriteHTML("<TD align='left'>" + strLocation.Trim + "</TD>")
            General.WriteHTML("<TD align='left'>" + strDesignation.Trim + "</TD>")
            objLink.LinkName = MyBase.GetResourceString("LINK_SHOW_SCHEDULE_LINK") + ""
            objLink.Tooltip = MyBase.GetResourceString("LINK_SHOW_SCHEDULE_LINK_TOOLTIP") + ""
            objLink.FunctionName = "ShowSchedule_OnClick('" + intRowCount.ToString + "','" + strStartDate.Trim + "','" + strEndDate.Trim + "')"
            General.WriteHTML("<TD align='center'>" + objLink.GetDynamicLink() + "</TD>")

            General.WriteHTML("<TD align='left'>")
            General.WriteHTML(HTMLControls.DrawDateControl("txtStartDate" + intRowCount.ToString, "txtStartDate" + intRowCount.ToString, , , strStartDate.Trim, , "frmIB_IssueAssignmentWithActivity", , , , , , , True) + "</TD>")
            General.WriteHTML("<TD align='left'>")
            General.WriteHTML(HTMLControls.DrawDateControl("txtEndDate" + intRowCount.ToString, "txtEndDate" + intRowCount.ToString, , , strEndDate.Trim, , "frmIB_IssueAssignmentWithActivity", , , , , , , True) + "</TD>")
            General.WriteHTML("<TD align='left'>")
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15

            ''Commented and Added By Sagar Nipane on 01-March-2019 Purpose::Project Work field level changes 

            'General.WriteHTML(HTMLControls.DrawTextBox("txtWorkHrs" + intRowCount.ToString, "txtWorkHrs" + intRowCount.ToString, , 50, , dblWorkHrs.ToString, "right", , , , , , " onblur='javascript:WorkHrs_OnBlur(this," + intRowCount.ToString + ")' onfocus='javascript:WorkHrs_OnFocus(this)'", True, EnableHTMLEncode:=True) + "</TD>")

            strWorkHrs = dblWorkHrs.ToString
            If strWorkHrs = 0 Or strWorkHrs = "" Then
                strWorkHrs = "00.00"
            End If
            strWorkHrs = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strWorkHrs + "',1)", True)

            General.WriteHTML(HTMLControls.DrawTextBox("txtWorkHrs" + intRowCount.ToString, "txtWorkHrs" + intRowCount.ToString, , 50, , strWorkHrs.ToString, "right", , , , , , " onblur='javascript:WorkHrs_OnBlur(this," + intRowCount.ToString + ")' onfocus='javascript:WorkHrs_OnFocus(this)'", True, EnableHTMLEncode:=True) + "</TD>")

            'End of Added By Sagar Nipane on 01-March-2019 Purpose::Project Work field level changes

            General.WriteHTML(HTMLControls.DrawTextBox("txtTaskComplete" + intRowCount.ToString, "txtTaskComplete" + intRowCount.ToString, , , , "1", , , , , , True, , True, EnableHTMLEncode:=True))
            'ended by Yogesh J for HTML encoding Date:06/10/15
            General.WriteHTML("<TD align='left'>")
            General.WriteHTML(MyBase.GetResourceString("CAP_NA") + "")
            General.WriteHTML("</TD>")

            'diplay cancel checkbox 
            General.WriteHTML("<TD align=center >")
            General.WriteHTML(HTMLControls.DrawCheckBox("chkCancel" + intRowCount.ToString, "chkCancel" + intRowCount.ToString, , , "1", , , True))
            General.WriteHTML("</TD>")

            General.WriteHTML("<TD align=center >")
            General.WriteHTML(HTMLControls.DrawCheckBox("chkDelete" + intRowCount.ToString, "chkDelete" + intRowCount.ToString, , , "1", , , True, , , , True))
            General.WriteHTML("</TD>")

            General.WriteHTML("</TR>")
            intNewRow += 1
        End While

        'if add new row action is given then add new row 
        If m_strAction = CONST_ACTION_ADDNEW Then
            intRowCount += 1
            intNewRow += 1

            lngTaskID = 0
            lngEmployeeID = 0
            strSubTaskTypes = ""
            strStartDate = m_strReportedDate.Trim
            strEndDate = m_strDueDate.Trim
            dblWorkHrs = 0
            strLocation = ""
            strDesignation = ""

            If intRowCount Mod 2 = 0 Then
                General.WriteHTML("<TR class='clsTREven'>")
            Else
                General.WriteHTML("<TR class='clsTROdd'>")
            End If

            General.WriteHTML("<TD align='left' id='tdEmployee" + intRowCount.ToString + "' >")
            strSQL = "usp_Sel_ProjectResources_TaskAssignment " + m_lngProjectID.ToString
            'added by SachinR   on 02 jul 2004
            'This is to implement Role based issue security. Here issue type is taken from the database
            'and passed to the SP to check which employee has access to the type based on its Project Role
            'so that only those employee will be listed to assign
            If m_strType <> "" Then
                strSQL += ",'" + m_strType.Trim + "'"
            End If
            'addition end
            General.WriteHTML(HTMLControls.DrawComboBox("cboEmployee" + intRowCount.ToString, strSQL, 100, , "onchange='javascript:Employee_OnChange(" + intRowCount.ToString + ")'", True, True))

            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            General.WriteHTML(HTMLControls.DrawTextBox("txtTaskID" + intRowCount.ToString, "txtTaskID" + intRowCount.ToString, , , , , , , , , , True, , True, EnableHTMLEncode:=True))
            'ended by Yogesh J for HTML encoding Date:06/10/15
            General.WriteHTML("</TD>")

            'display the list of activities or selected activity for the assigned task
            General.WriteHTML("<TD align='left' id='tdActivity" + intRowCount.ToString + "' >")
            strSQL = "usp_sel_SubTaskType_ForIssue " + m_lngTaskTypeID.ToString + ",NULL," + m_lngProjectID.ToString
            General.WriteHTML(HTMLControls.DrawComboBox("cboActivity" + intRowCount.ToString, strSQL, 100, , , True, True))
            General.WriteHTML("</TD>")

            General.WriteHTML("<TD align='left'>" + strLocation.Trim + "</TD>")
            General.WriteHTML("<TD align='left'>" + strDesignation.Trim + "</TD>")
            objLink.LinkName = MyBase.GetResourceString("LINK_SHOW_SCHEDULE_LINK") + ""
            objLink.Tooltip = MyBase.GetResourceString("LINK_SHOW_SCHEDULE_LINK_TOOLTIP") + ""
            objLink.FunctionName = "ShowSchedule_OnClick('" + intRowCount.ToString + "','" + strStartDate.Trim + "','" + strEndDate.Trim + "')"
            General.WriteHTML("<TD align='center'>" + objLink.GetDynamicLink() + "</TD>")

            General.WriteHTML("<TD align='left'>")
            General.WriteHTML(HTMLControls.DrawDateControl("txtStartDate" + intRowCount.ToString, "txtStartDate" + intRowCount.ToString, , , strStartDate.Trim, , "frmIB_IssueAssignmentWithActivity", , , , , , , True) + "</TD>")
            General.WriteHTML("<TD align='left'>")
            General.WriteHTML(HTMLControls.DrawDateControl("txtEndDate" + intRowCount.ToString, "txtEndDate" + intRowCount.ToString, , , strEndDate.Trim, , "frmIB_IssueAssignmentWithActivity", , , , , , , True) + "</TD>")
            General.WriteHTML("<TD align='left'>")

            'Commented and added by Yogesh J for HTML encoding Date:06/10/15

            ''Commented and Added By Sagar Nipane on 01-March-2019 Purpose::Project Work field level changes 
            'General.WriteHTML(HTMLControls.DrawTextBox("txtWorkHrs" + intRowCount.ToString, "txtWorkHrs" + intRowCount.ToString, , 50, , , "right", , , , , , " onblur='javascript:WorkHrs_OnBlur(this," + intRowCount.ToString + ")' onfocus='javascript:WorkHrs_OnFocus(this)'", True, EnableHTMLEncode:=True) + "</TD>")

            strWorkHrs = dblWorkHrs.ToString
            If strWorkHrs = 0 Or strWorkHrs = "" Then
                strWorkHrs = "00.00"
            End If
            strWorkHrs = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strWorkHrs + "',1)", True)

            General.WriteHTML(HTMLControls.DrawTextBox("txtWorkHrs" + intRowCount.ToString, "txtWorkHrs" + intRowCount.ToString, , 50, , strWorkHrs, "right", , , , , , " onblur='javascript:WorkHrs_OnBlur(this," + intRowCount.ToString + ")' onfocus='javascript:WorkHrs_OnFocus(this)'", True, EnableHTMLEncode:=True) + "</TD>")

            ''End of Added By Sagar Nipane on 01-March-2019 Purpose::Project Work field level changes 

            General.WriteHTML(HTMLControls.DrawTextBox("txtTaskComplete" + intRowCount.ToString, "txtTaskComplete" + intRowCount.ToString, , , , "1", , , , , , True, , True, EnableHTMLEncode:=True))
            'ended by Yogesh J for HTML encoding Date:06/10/15
            General.WriteHTML("<TD align='left'>")
            General.WriteHTML(MyBase.GetResourceString("CAP_NA") + "")
            General.WriteHTML("</TD>")

            'diplay cancel checkbox 
            General.WriteHTML("<TD align=center >")
            General.WriteHTML(HTMLControls.DrawCheckBox("chkCancel" + intRowCount.ToString, "chkCancel" + intRowCount.ToString, , , "1", , , True))
            General.WriteHTML("</TD>")

            General.WriteHTML("<TD align=center >")
            General.WriteHTML(HTMLControls.DrawCheckBox("chkDelete" + intRowCount.ToString, "chkDelete" + intRowCount.ToString, , , "1", , , True, , , , True))
            General.WriteHTML("</TD>")

            General.WriteHTML("</TR>")

        End If

        'if no record found then display the message
        If intRowCount <= 0 Then
            General.WriteHTML("<TR class='clsTREven'")
            General.WriteHTML("<TD align='center' colspan=9 >" + MyBase.GetResourceString("NO_DATA") + "</TD>")
            General.WriteHTML("</TR>")
        End If

        objLink = Nothing
        'end of table
        General.WriteHTML("</Table>")
        General.WriteHTML("</Div>")

        'keep values in the hidden controls

        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        General.WriteHTML(HTMLControls.DrawTextBox("txtDuration", "txtDuration", , , , m_dblDuration.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtRowCount", "txtRowCount", , , , intRowCount.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtNewRows", "txtNewRows", , , , intNewRow.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtCurrentIDList", "txtCurrentIDList", , , , m_strAssignedToIDList.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        'General.WriteHTML(HTMLControls.DrawTextBox("txtOldAssignedToIDList", "txtOldAssignedToIDList", , , , strOldAssignedToIdList.Trim, , , , , , True, , True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtReportedDate", "txtReportedDate", , , , m_strReportedDate.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtProjectID", "txtProjectID", , , , m_lngProjectID.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtTaskTypeID", "txtTaskTypeID", , , , m_lngTaskTypeID.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtTaskType", "txtTaskType", , , , m_strTaskType.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        'added by SachinR   on 02 Jul 2004
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
    ' Created				:	May 25 2004
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

            'added by SachinR   On 02 Jul 2004
            'to implement type-role security for issue
            m_strType = Data.CheckIsDBNull(objDR("Type"), "").ToString + ""
            'addition end
        End If
        Data.DisposeDataReader(objDR)

        'get the taskID and tasktype
        m_lngTaskTypeID = 0
        m_strTaskType = ""
        strSQL = "usp_sel_TaskType_ForIssue " + lngIssueID.ToString + ""
        objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDR.Read Then
            m_lngTaskTypeID = CType(Data.CheckIsDBNull(objDR("TaskTypeID"), "0"), Long)
            m_strTaskType = Data.CheckIsDBNull(objDR("TaskType"), "").ToString
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
    ' Created				:	May 25 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub getAssignedResourceIDList(ByVal lngissueID As Long)
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim dblDuration As Double

        m_strAssignedToIDList = ","
        m_dblDuration = 0
        dblDuration = 0

        strSQL = "usp_Sel_tbl_PM_ProjectTasks_IssueTasks " + lngissueID.ToString
        objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
        While objDR.Read
            'create the quama seperated list of IDs
            m_strAssignedToIDList += objDR("EmployeeID").ToString + ","

            'make the total of work (duration)
            If m_dblDuration <= 0 Then
                If Not IsDBNull(objDR("Work")) Then
                    dblDuration += CType(objDR("Work"), Double)
                End If
            End If
        End While
        Data.DisposeDataReader(objDR)

        ''get duration first from the control on the page, this is not for the first time
        'If MyBase.GetFormValue("txtDuration") <> "" Then
        '    m_dblDuration = CType(MyBase.GetFormValue("txtDuration"), Double)
        'Else
        m_dblDuration = dblDuration
        'End If

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
    ' Created				:	May 27 2004
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
        Dim strTaskTypeID As String
        Dim strSubTaskTypes As String
        Dim strEmployeeID As String
        Dim i As Integer

        Select Case m_strAction

            Case CONST_ACTION_REOPEN
                'reOpen the task
                If Request.QueryString("TaskID") <> "" Then

                    lngTaskID = CType(Request.QueryString("TaskID"), Long)

                    strSQL = "usp_Upd_ProjectTaskComplete " + lngTaskID.ToString + ",0"
                    Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
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

                For i = 1 To m_intRowCount

                    'get the start date,End date and work hours for the resource
                    strStartDate = MyBase.GetFormValue("txtStartDate" + i.ToString) + ""
                    strEndDate = MyBase.GetFormValue("txtEndDate" + i.ToString) + ""

                    ''Commented and Added By Sagar Nipane on 01-March-2019 Purpose::Project Work field level changes 

                    'If MyBase.GetFormValue("txtWorkHrs" + i.ToString) <> "" Then
                    '    dblTaskduration = CType(MyBase.GetFormValue("txtWorkHrs" + i.ToString), Double)
                    'Else
                    '    dblTaskduration = 0
                    'End If

                    Dim strWorkHrs As String
                    strWorkHrs = MyBase.GetFormValue("txtWorkHrs" + i.ToString.Trim)
                    If strWorkHrs = "0" Or strWorkHrs = "" Then
                        strWorkHrs = "00:00"
                    End If

                    If strWorkHrs.IndexOf(":") = strWorkHrs.Length - 1 Then
                        strWorkHrs = strWorkHrs + "00"
                    End If

                    strWorkHrs = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strWorkHrs + "',2)", True)

                    If strWorkHrs <> "" Then
                        dblTaskduration = CType(strWorkHrs.Trim(), Double)
                    Else
                        dblTaskduration = 0
                    End If


                    ''End of Added By Sagar Nipane on 01-March-2019 Purpose::Project Work field level changes 

                   
                    strSubTaskTypes = MyBase.GetFormValue("cboActivity" + i.ToString) + ""
                    strEmployeeID = MyBase.GetFormValue("cboEmployee" + i.ToString) + ""

                    strSQL = "usp_Ins_IB_AssignIssueToEmployee " + m_lngIssueID.ToString + "," + m_lngProjectID.ToString + "," + strEmployeeID.Trim
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
                    'insert TaskTypeID and Activity(subTaskType) ID
                    If m_lngTaskTypeID > 0 Then
                        strSQL += "," + m_lngTaskTypeID.ToString
                    Else
                        strSQL += ",NULL"
                    End If
                    If strSubTaskTypes <> "" Then
                        strSQL += ",'" + strSubTaskTypes + "'"
                    Else
                        strSQL += ",NULL"
                    End If

                    'Modified by NitinVS on 31 July 2007 for WhizibleSEM 7 
                    ' if the task is created as void do not added the resource in the list 
                    Dim IsTaskVoid As String = ""
                    IsTaskVoid = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), "0")

                    'if task ID is not present then it is new resource, store its ID to send mail
                    If MyBase.GetFormValue("txtTaskID" + i.ToString) = "" And IsTaskVoid <> "0" Then
                        strSendMailTo += strEmployeeID.Trim + ","
                    End If

                Next

                m_intNewRows = 0
                m_intRowCount = 0

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
                'End If

            Case CONST_ACTION_DELETE

                Dim strTaskIDList As String
                'create the list of taskids selected for delete, this list will be passed to 
                'SP and IsActive for all these tasks will be set to 0
                strTaskIDList = ""
                For i = 1 To m_intRowCount
                    If MyBase.GetFormValue("chkDelete" + i.ToString) <> "" Then
                        strTaskIDList += MyBase.GetFormValue("txtTaskID" + i.ToString) + ","
                    End If
                Next

                If strTaskIDList <> "" Then
                    'remove the last , from the list
                    strTaskIDList = strTaskIDList.Substring(0, strTaskIDList.LastIndexOf(","c))

                    'Modified By VidyaJ - DA Performance Issue - 89 (SP4)   
                    '  strSQL = "usp_upd_tbl_PM_ProjectTasks_forDelete " + m_lngProjectID.ToString + "," + m_lngIssueID.ToString
                    ' strSQL += ",'" + strTaskIDList.Trim + "'"
                    strSQL = " Exec usp_Upd_UpdateTaskStatus  " + "'" + strTaskIDList.Trim + "',0," + m_lngProjectID.ToString
                    Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                End If

            Case Else
        End Select
    End Sub

    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        'initialize the resource file for send Email page.
        MyBase.InitializeResources("AppResources.IB_IssueAssignment", "AppResources")
    End Sub

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'set the window title 
        m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_ISSUE")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
    'added BY HarshK for SP4 IssueID 120,121 
    Private Sub DrawHiddenCombo()
        Dim strQuery As String
        '-----------------------------------------------
        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'strQuery = "select IsNull(ResourceValidation,0) from tbl_PM_Project WHERE ProjectID = " & m_lngProjectID.ToString
        strQuery = "usp_sel_tbl_PM_Project_ResourceValidation_ProjectID " & m_lngProjectID.ToString
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
    'End added BY HarshK for SP4 IssueID 120,121 

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
        'Added by GaneshD on 17 Sep 2009 for cleanup activity
        CommonFunction.Data.DisposeDataReader(objDRProjectEfforts)
        ' End of addition by Ganeshd
    End Sub
    ' End Addition by NitinVS on 11 July 2007 To Validte for Project Efforts
End Class
