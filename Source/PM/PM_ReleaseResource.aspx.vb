#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Public Class PM_ReleaseResource
    Inherits WebPages.Template.WhizTemplate

    '=====================================================================
    ' Page Name 	        :	
    ' Purpose				:	
    ' Description			:	
    ' Assumptions			:	
    ' Dependencies			:	
    ' Author				:	
    ' Created				:	
    ' Revisions				:	
    '=====================================================================

#Region "Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

#End Region

#Region "PageEvents"
    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load

        'Initialize the Global Objects
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

        '--- ProjectID

        m_lngProjectID = CInt(Session("intProjectID"))
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("UniqueID"), "") <> "" Then
            m_lngUniqueID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("UniqueID"), ""), Integer)
            'ElseIf CommonFunctions.General.CheckIsNothing(Request.Form("hidUniqueID"), "0") <> "0" Then
            '    m_lngUniqueID = CType(CommonFunctions.General.CheckIsNothing(Request.Form("hidUniqueID"), "0"), Integer)
        Else
            m_lngUniqueID = 0
        End If

        ' If CommonFunctions.General.CheckIsNothing(Request.Form("hidEmployeeID"), "") <> "" Then
        ' m_lngEmployeeID = CType(Request.Form("hidEmployeeID"), Integer)
        'Else

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''m_lngEmployeeID = CType(CommonFunctions.Data.GetDataScalar("Select EmployeeID From tbl_PM_ProjectEmployeeRole Where ProjectEmployeeRoleID = " & m_lngUniqueID, True), Integer)
        m_lngEmployeeID = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_ProjectEmployeeRole_EmployeeID_ProjectEmployeeRoleID " & m_lngUniqueID, True), Integer)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        'End If
        ' m_lngEmployeeID = 61
        'CommonFunctions.HTMLControls.DrawTextBox("hidEmployeeID", "hidEmployeeID", , , , m_lngEmployeeID.ToString, , , , , , True)
        'CommonFunctions.HTMLControls.DrawTextBox("hidUniqueID", "hidUniqueID", , , , m_lngUniqueID.ToString, , , , , , True)
        Initialize()
    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        : PageInit
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure construct the page
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        '######### Page Code starts here

        Dim objHeaderFooter As WebPages.Template.HeaderFooter
        Dim strSQLQuery As String
        'This will initialize all the global objects.
        GetGlobalObject()

        'Display the Menu at Bottom

        DrawMenu()
        CommonFunctions.General.WriteHTML(strMenu)

        'Moved code from PlotSkillsSection by PrashantD on 8 May 2007 for CleanUp Activity
        Dim strQuery As String
        Dim drWork As IDataReader
        strQuery = "Exec usp_Sel_GetProjectEmployeeWorkPeriod " & m_lngProjectID.ToString()
        strQuery &= ", " & m_lngUniqueID
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                blnHasEmpRecord = True
                m_lngEmployeeID = CType("0" & CommonFunctions.Data.CheckIsDBNull(drWork.Item("EmployeeID")).ToString(), Long)
                'Modified by PrashantD on 8 May 2007 for Cleanup Activity 
                m_strUserName = CommonFunctions.Data.CheckIsDBNull(drWork.Item("UserName1")).ToString()
                'End of modification by PrashantD on 8 May 2007 for CleanUp Activity
                m_strUserName = CommonFunctions.General.UnBuildQueryString(m_strUserName)
                m_intTotalDays = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("TotalDays"), "0").ToString(), Integer)
                'Added by PrashantD on 8 May 2007 for Cleanup Activity 
                m_strEmployeeName = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("EmployeeName")), String)
                'End of addition by PrashantD on 8 May 2007 for CleanUp Activity

            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)
        'End of Move code from PlotSkillsSection method


        'comment by PrashantD on 9 May 2007 for CleanUp Activity
        'strSQLQuery = "Select EmployeeName FROM tbl_PM_Employee Where EmployeeID = " & CType(m_lngEmployeeID, String)
        'm_strEmployeeName = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLQuery, True), ""), String)
        'End of Comment by PrashantD on 9 May 2007 for CleanUp Activity

        'Display the page caption.
        DrawPageCaption()
        'Display the Header if exist. 
        DrawHeader()

        '' Read Drop down values
        m_strTimesheetApprover = CommonFunctions.General.CheckIsNothing(Request.Form("cboTimesheetApprover"), "0")
        m_strExpenseApprover = CommonFunctions.General.CheckIsNothing(Request.Form("cboExpenseApprover"), "0")
        m_strnewTimesheetDefaultApprover = CommonFunctions.General.CheckIsNothing(Request.Form("cboTimesheetDefaultApprover"), "0")
        m_strnewExpenseDefaultApprover = CommonFunctions.General.CheckIsNothing(Request.Form("cboExpenseDefaultApprover"), "0")
        m_strnewDeliverableResponsiblePerson = CommonFunctions.General.CheckIsNothing(Request.Form("cboDeliverableResponsiblePerson"), "0")
        m_strnewIssueResponsiblePerson = CommonFunctions.General.CheckIsNothing(Request.Form("cboIssueResponsiblePerson"), "0")
        m_strnewResponsiblePersonForIssue = CommonFunctions.General.CheckIsNothing(Request.Form("cboResponsiblePersonForIssue"), "0")
        m_strnewResponsiblePersonForInvoice = CommonFunctions.General.CheckIsNothing(Request.Form("cboResponsiblePersonForInvoice"), "0")
        m_strnewMSPFileOwner = CommonFunctions.General.CheckIsNothing(Request.Form("cboMSPFileOwner"), "0")
        m_strnewPersonResponsibleForTimesheetblocking = CommonFunctions.General.CheckIsNothing(Request.Form("cboPersonResponsibleForTimesheetblocking"), "0")
        m_strnewRisksResponsiblePerson = CommonFunctions.General.CheckIsNothing(Request.Form("cboRisksResponsiblePerson"), "0")
        m_strnewIRApprover = CommonFunctions.General.CheckIsNothing(Request.Form("cboIRApprover"), "0")
        m_strnewInvoiceGenerator = CommonFunctions.General.CheckIsNothing(Request.Form("cboInvoiceGenerator"), "0")
        m_strnewTimesheetAuthenticator = CommonFunctions.General.CheckIsNothing(Request.Form("cboTimesheetAuthenticator"), "0")
        '' End of getting data from dropdowns

        '-------------Added By PurvaJ on 26 May 2008 Configurable Workflow release resource
        m_strnewWorkflowApprover = CommonFunctions.General.CheckIsNothing(Request.Form("cboEmployeeforworkflow"), "0")
        '-------------End Addtion PurvaJ

        '--- Get the Mode
        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"))
        If m_strMode = "" Then
            m_strMode = MODE_LIST
        End If

        '--- Gets information from the Querystring

        '--- If Mode is Save...update the IsTaskComplete field in the tbl_PM_ProjectTasks
        If m_strMode = MODE_SAVE Then
            ' Save Task Completion details
            UpdateTasksCompletion()
            ' Save Void Taskdetails
            UpdateTasksVoid()
            ' Save new Approvers
            UpdateApprovers()
            'Added by TruptiK 
            'Purpose:-to reject pending extend request before releasing resource
            UpdateRequests()
            'End
            UpdateSkills()
            '----- Added By PurvaJ on 26 May 2008 for Configurable workflow
            UpdateWorkflow()
            '----- End addtion PurvaJ
            ReleaseResource()

        End If

        If (Request.Form("hidTaskCompletionFilterDivStatus") & "") = "Open" Or (Request.Form("hidTaskCompletionFilterDivStatus") & "") = "" Then
            m_FilterTaskcompletionDivStatus = True
        Else
            m_FilterTaskcompletionDivStatus = False
        End If

        If (Request.Form("hidTaskVoidFilterDivStatus") & "") = "Open" Or (Request.Form("hidTaskVoidFilterDivStatus") & "") = "" Then
            m_FilterTaskvoidDivStatus = True
        Else
            m_FilterTaskvoidDivStatus = False
        End If
        If (Request.Form("hidApproverFilterDivStatus") & "") = "Open" Or (Request.Form("hidApproverFilterDivStatus") & "") = "" Then
            m_FilterApproverDivStatus = True
        Else
            m_FilterApproverDivStatus = False
        End If
        If (Request.Form("hidRequestFilterDivStatus") & "") = "Open" Or (Request.Form("hidRequestFilterDivStatus") & "") = "" Then
            m_filterrequestDivStatus = True
        Else
            m_filterrequestDivStatus = False
        End If

        If (Request.Form("hidSkillsFilterDivStatus") & "") = "Open" Or (Request.Form("hidSkillsFilterDivStatus") & "") = "" Then
            m_FilterSkillsDivStatus = True
        Else
            m_FilterSkillsDivStatus = False
        End If

        'Added by Bharat Tekade
        If (Request.Form("hidMPPTaaskDivStatus") & "") = "Open" Or (Request.Form("hidMPPTaaskDivStatus") & "") = "" Then
            m_MPPTaskDivStatus = True
        Else
            m_MPPTaskDivStatus = False
        End If

        'Ended by Bharat Tekade


        Response.Write("<DIV Id='PageDiv' Style='Width:100%;OverFlow:auto;Height=600px'>")
        'Response.Write("<DIV Id='Divlist1' Style='Width:100%;OverFlow:auto;Height=200px'>")
        If m_FilterTaskcompletionDivStatus = True Then
            CommonFunctions.General.WriteHTML("<input type=hidden name=hidTaskCompletionFilterDivStatus id=hidTaskCompletionFilterDivStatus value='Open' />")
            CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:TaskCompletion_div()""><Img Border=0 id=imgTaskCompletionShowHide Src='../../Images/minus.gif' title=''></A>&nbsp;&nbsp; " & MyBase.GetResourceString("TASK_COMPLETION_DIV") & " </TD></TR></TABLE>")
            CommonFunctions.General.WriteHTML("<DIV id='TaskCompletion' name='TaskCompletion' height=200px style=""overflow:auto;display:''"">")
        Else
            CommonFunctions.General.WriteHTML("<input type=hidden name=hidTaskCompletionFilterDivStatus id=hidTaskCompletionFilterDivStatus value='Close' />")
            CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:TaskCompletion_div()""><Img Border=0 id=imgTaskCompletionShowHide Src='../../Images/plus.gif' title=''></A>&nbsp;&nbsp; " & MyBase.GetResourceString("TASK_COMPLETION_DIV") & " </TD></TR></TABLE>")
            CommonFunctions.General.WriteHTML("<DIV id='TaskCompletion' name='TaskCompletion' height=200px style=""overflow:auto;display:'none'"">")
        End If

        Call DisplayTaskCompletionGrid()
        HttpContext.Current.Response.Write("</DIV>")

        If m_FilterTaskvoidDivStatus = True Then
            CommonFunctions.General.WriteHTML("<input type=hidden name=m_FilterTaskVoidDivStatus id=m_FilterTaskVoidDivStatus value='Open' />")
            CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:TaskVoid_div()""><Img Border=0 id=imgTaskVoidShowHide Src='../../Images/minus.gif' title=''></A>&nbsp;&nbsp; " & MyBase.GetResourceString("TASK_VOID_DIV") & " </TD></TR></TABLE>")
            CommonFunctions.General.WriteHTML("<DIV id='TaskVoid' name='TaskVoid' height=200px style=""overflow:auto;display:''"">")
        Else
            CommonFunctions.General.WriteHTML("<input type=hidden name=m_FilterTaskVoidDivStatus id=m_FilterTaskVoidDivStatus value='Close' />")
            CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:TaskVoid_div()""><Img Border=0 id=imgTaskVoidShowHide Src='../../Images/plus.gif' title=''></A>&nbsp;&nbsp; " & MyBase.GetResourceString("TASK_VOID_DIV") & " </TD></TR></TABLE>")
            CommonFunctions.General.WriteHTML("<DIV id='Void' name='Void' height=200px style=""overflow:auto;display:'none'"">")
        End If

        Call DisplayTasktobeVoidedGrid()
        HttpContext.Current.Response.Write("</DIV>")
        If m_FilterApproverDivStatus = True Then
            CommonFunctions.General.WriteHTML("<input type=hidden name=hidApproverFilterDivStatus id=hidFilterDivStatus value='Open' />")
            CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:Approver_div()""><Img Border=0 id=imgApproverShowHide Src='../../Images/minus.gif' title=''></A>&nbsp;&nbsp; " & MyBase.GetResourceString("APPROVER_DIV") & " </TD></TR></TABLE>")
            CommonFunctions.General.WriteHTML("<DIV id='Approver' name='Approver' height=200px style=""overflow:auto;display:''"">")
        Else
            CommonFunctions.General.WriteHTML("<input type=hidden name=hidApproverFilterDivStatus id=hidFilterDivStatus value='Close' />")
            CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:Approver_div()""><Img Border=0 id=imgApproverShowHide Src='../../Images/plus.gif' title=''></A>&nbsp;&nbsp; " & MyBase.GetResourceString("APPROVER_DIV") & " </TD></TR></TABLE>")
            CommonFunctions.General.WriteHTML("<DIV id='Approver' name='Approver' height=200px style=""overflow:auto;display:'none'"">")
        End If
        Call DisplayApproverGrid()

        ''commeted and added by RohiniK on 2 Sep 09 for Cancel Submitted Request while Releasing resource

        'HttpContext.Current.Response.Write("</DIV>")
        'Added by TruptiK on 2-Apr-09
        Dim ResourceAllocation As Boolean
        ResourceAllocation = CommonFunction.Application.AllowResourceAllocation
        If ResourceAllocation = True Then
            HttpContext.Current.Response.Write("</DIV>")
            Dim strReq As String = "Requests for Cancellation"
            If m_filterrequestDivStatus = True Then
                CommonFunctions.General.WriteHTML("<input type=hidden name=hidRequestFilterDivStatus id=hidFilterRequestDivStatus value='Open' />")
                CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:Request_div()""><Img Border=0 id=imgRequestShowHide Src='../../Images/minus.gif' title=''></A>&nbsp;&nbsp; " & strReq & " </TD></TR></TABLE>")
                CommonFunctions.General.WriteHTML("<DIV id='Request' name='Request' height=200px style=""overflow:auto;display:''"">")
            Else
                CommonFunctions.General.WriteHTML("<input type=hidden name=hidRequestFilterDivStatus id=hidFilterRequestDivStatus value='Close' />")
                CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:Request_div()""><Img Border=0 id=imgRequestShowHide Src='../../Images/plus.gif' title=''></A>&nbsp;&nbsp; " & strReq & " </TD></TR></TABLE>")
                CommonFunctions.General.WriteHTML("<DIV id='Request' name='Request' height=200px style=""overflow:auto;display:'none'"">")
            End If


            Call DisplayExtendRequestsGrid()

            HttpContext.Current.Response.Write("</DIV>")
        End If
        'End of addition by TruptiK
        ''End of commeted and addition by RohiniK on 2 Sep 09 for Cancel Submitted Request while Releasing resource


        If m_FilterSkillsDivStatus = True Then
            CommonFunctions.General.WriteHTML("<input type=hidden name=hidSkillsFilterDivStatus id=hidSkillsFilterDivStatus value='Open' />")
            CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:Skills_div()""><Img Border=0 id=imgSkillsShowHide Src='../../Images/minus.gif' title=''></A>&nbsp;&nbsp; " & MyBase.GetResourceString("UPDATE_SKILLS") & " </TD></TR></TABLE>")
            CommonFunctions.General.WriteHTML("<DIV id='Skills' name='Skills' height=200px style=""overflow:auto;display:''"">")
        Else
            CommonFunctions.General.WriteHTML("<input type=hidden name=hidSkillsFilterDivStatus id=hidSkillsFilterDivStatus value='Close' />")
            CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:Skills_div()""><Img Border=0 id=imgSkillsShowHide Src='../../Images/plus.gif' title=''></A>&nbsp;&nbsp; " & MyBase.GetResourceString("UPDATE_SKILLS") & " </TD></TR></TABLE>")
            CommonFunctions.General.WriteHTML("<DIV id='Skills' name='Skills' height=200px style=""overflow:auto;display:'none'"">")
        End If
        Call PlotSkillsSection()
        HttpContext.Current.Response.Write("</DIV>")

        'Added by Bharat Tekade
        Dim strMPPTask As String = "MPP Task Details"

        If m_MPPTaskDivStatus = True Then
            CommonFunctions.General.WriteHTML("<input type=hidden name=hidMPPTaaskDivStatus id=hidMPPTaaskDivStatus value='Open' />")
            CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:MPPTaskDetails_div()""><Img Border=0 id=imgMPPTaskShowHide Src='../../Images/minus.gif' title=''></A>&nbsp;&nbsp; " & strMPPTask & " </TD></TR></TABLE>")
            CommonFunctions.General.WriteHTML("<DIV id='MPPTask' name='MPPTask' height=200px style=""overflow:auto;display:''"">")
        Else
            CommonFunctions.General.WriteHTML("<input type=hidden name=hidMPPTaaskDivStatus id=hidMPPTaaskDivStatus value='Close' />")
            CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:MPPTaskDetails_div()""><Img Border=0 id=imgMPPTaskShowHide Src='../../Images/plus.gif' title=''></A>&nbsp;&nbsp; " & strMPPTask & " </TD></TR></TABLE>")
            CommonFunctions.General.WriteHTML("<DIV id='MPPTask' name='MPPTask' height=200px style=""overflow:auto;display:'none'"">")
        End If

        Call DisplayMPPTaskGrid()
        HttpContext.Current.Response.Write("</DIV>")

        'Ended by Bharat Tekade



        HttpContext.Current.Response.Write("</DIV>")
        objHeaderFooter = New WebPages.Template.HeaderFooter
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
        objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        objHeaderFooter = Nothing
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)
        DisposeObjects()
    End Sub

    Private Sub Initialize()
        '=====================================================================
        ' Function Name         : Initialize
        ' Purpose               : Initializes the varaibles used in the page.
        ' Description           : Also gets the various User Preferences from the Database and 
        '                         information from the Querystring
        ' Parameters Passed     : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : Priyanka
        ' Created               : 19th July 2004
        ' Revisions             : 
        '=====================================================================

        Dim strSQLQuery As String
        Dim strTaskIDs As String

        m_lngTagId = m_objGlobal.TagID
        m_strWindowTitle = MyBase.GetResourceString("HEADING_RELEASE_RESOURCE")


    End Sub

#End Region

#Region "Constants"

    '--- Constants for Mode
    Private Const MODE_LIST As String = "List"
    Private Const MODE_SAVE As String = "Save"

#End Region

#Region "Member Variables"

    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu    'This variable is used for plotting static menu. 
    Private WithEvents m_objTaskCompletionGrid As New WebPages.Template.GenericGrid   'This variable is use to plotting grid.
    Private WithEvents m_objTaskVoidGrid As New WebPages.Template.GenericGrid   'This variable is use to plotting grid.
    Private WithEvents m_objSkillsGrid As New WebPages.Template.GenericGrid   'This variable is use to plotting grid.
    'Added By BharatT
    Private WithEvents m_objMPPGrid As New WebPages.Template.GenericGrid   'This variable is use to plotting MPP TASK in grid.
    'Ended By BharatT

    'Added by TruptiK on 24-Feb-09
    'Before releasing resource reject extend booking request.
    Private WithEvents m_objExtendRequestsGrid As New WebPages.Template.GenericGrid
    'End of addition by TruptiK on 24-Feb-09
    Private m_objGlobal As WebPages.Template.IGlobal                    'This variable is of global object inteface. 
    Private m_objAccessRights As WebPages.Security.cAccessRights        'This variable is for access rights of page.
    Protected WithEvents frmTaskUpdation As System.Web.UI.HtmlControls.HtmlForm

    Private strMenu As String                           'stores the static menu string.
    Protected m_lngProjectID As Long                   'Project ID
    Protected m_strWindowTitle As String                'Page Title
    Protected m_lngTagId As Long = 0                    'Tag ID
    Private m_strMode As String                         'Mode
    Private m_intCount As Integer
    Protected m_lngEmployeeID As Long = 0
    Private m_strEmployeeName As String

    Protected m_strTimesheetApprover As String
    Protected m_strExpenseApprover As String
    Protected m_strnewTimesheetDefaultApprover As String
    Protected m_strnewExpenseDefaultApprover As String
    Protected m_strIssue As String
    Protected m_strnewDeliverableResponsiblePerson As String
    Protected m_strnewIssueResponsiblePerson As String
    Protected m_strnewResponsiblePersonForIssue As String
    Protected m_strnewResponsiblePersonForInvoice As String
    Protected m_strnewMSPFileOwner As String
    Protected m_strnewRisksResponsiblePerson As String
    Protected m_strnewPersonResponsibleForTimesheetblocking As String
    Protected m_lngUniqueID As Long
    'Added by TruptiK on 4-July-2007
    'Purpose:-To check whether resource is IRApprover or IRGenerator before releasing.
    Protected m_strnewIRApprover As String
    Protected m_strnewInvoiceGenerator As String
    Protected m_strnewTimesheetAuthenticator As String
    Protected countofIRApprovers As Integer
    Protected countofInvoiceGenerators As Integer
    Protected m_StrIRApprover As String
    Protected m_strInvoiceGenerator As String
    Protected m_TimesheetAuthenticator As String
    'End of addition by TruptiK on 4-July-2007
    Protected m_FilterTaskcompletionDivStatus As Boolean = True
    Protected m_FilterTaskvoidDivStatus As Boolean = True
    Protected m_FilterApproverDivStatus As Boolean = True
    Protected m_FilterSkillsDivStatus As Boolean = True
    Protected m_filterrequestDivStatus As Boolean = True

    'Added by bharat tekade
    Protected m_MPPTaskDivStatus As Boolean = True
    'Ended by bharat tekade


    Private m_strStartDate As String = ""
    Private m_intYearsToBeShown As Integer = 0
    Private m_intMonthsToBeShown As Integer = 0
    Private m_strUserName As String = ""
    Private m_intTotalDays As Integer = 0
    Private m_intEmployeeYears As Integer = 0
    Private m_intEmployeeMonths As Integer = 0
    Private m_intEmployeeDays As Integer = 0

    'Added by PrashantD on 8 May 2007 for CleanUp Activity
    Private blnHasEmpRecord As Boolean = False
    'End of addition by PrashantD on 8 May 2007
    '---------- Added By PurvaJ on 26 May 2008 Configurable workflow RElease resource
    Private m_strnewWorkflowApprover As String = ""

    '---------- End addtion PurvaJ

#End Region

#Region "General Functions"

    Private Function GetArray(ByVal arrList As ArrayList) As String()
        '=====================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : Generic function to get the array from the ArrayList.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AmitD
        ' Created               : Jul 10, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
    Private Sub UpdateTasksCompletion()
        'get the list of all ID's
        Dim strTaskIDs As String
        Dim arrTaskIDList() As String
        Dim strTaskID As String
        Dim strSQL As String
        Dim i As Integer
        strTaskIDs = MyBase.GetFormValue("chkTaskcomplete") + ""

        ' Insert data in User Access table.
        If strTaskIDs <> "" Then
            arrTaskIDList = Split(strTaskIDs, ",")

            For i = 0 To arrTaskIDList.Length - 1
                strTaskID = CType(arrTaskIDList(i), String)

                strSQL = "usp_Upd_AssignedTasks_Updation_ReleaseResource 1," + m_lngProjectID.ToString + "," + m_lngEmployeeID.ToString + ",'" + Session("strUserName").ToString + "'," + strTaskID.ToString

                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
            Next
        End If
    End Sub
    Private Sub UpdateTasksVoid()
        'get the list of all ID's
        Dim strTaskIDs As String
        Dim arrTaskIDList() As String
        Dim strTaskID As String
        Dim strSQL As String
        Dim i As Integer
        strTaskIDs = MyBase.GetFormValue("chkTaskvoid") + ""

        ' Insert data in User Access table.
        If strTaskIDs <> "" Then
            arrTaskIDList = Split(strTaskIDs, ",")

            For i = 0 To arrTaskIDList.Length - 1
                strTaskID = CType(arrTaskIDList(i), String)

                strSQL = "usp_Upd_AssignedTasks_Updation_ReleaseResource 2," + m_lngProjectID.ToString + "," + m_lngEmployeeID.ToString + ",'" + Session("strUserName").ToString + "'," + strTaskID.ToString

                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
            Next
        End If
    End Sub
    'Added by TruptiK on 6-Apr-09 
    'Purpose:-to reject pending extend request before releasing resource
    Private Sub UpdateRequests()
        'get the list of all ID's
        Dim strRequestIDs As String
        Dim arrRequestList() As String
        Dim strRequestID As String
        Dim strSQL As String
        Dim i As Integer
        strRequestIDs = MyBase.GetFormValue("chkRequest") + ""

        ' Insert data in User Access table.
        If strRequestIDs <> "" Then
            arrRequestList = Split(strRequestIDs, ",")

            For i = 0 To arrRequestList.Length - 1
                strRequestID = CType(arrRequestList(i), String)

                strSQL = "usp_Upd_AssignedRequest_Updation " + strRequestID.ToString

                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
            Next
        End If
    End Sub
    '----------- Added By PurvaJ on 26 May 2008 Configurable workflwo release resource
    Private Sub UpdateWorkflow()
        Dim strSQL As String = "usp_UPD_Workflow_ReleaseProjectResource " + m_lngEmployeeID.ToString + "," + m_strnewWorkflowApprover.ToString + "," + m_lngProjectID.ToString + ",'" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "") + "'"
        CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

    End Sub
    'End of addition by TruptiK
    '----------- End addition PurvaJ

    Private Sub UpdateApprovers()
        'get the list of all ID's
        Dim arrTaskIDList() As String
        Dim strTaskID As String
        Dim strSQL As String
        Dim strQuery1 As String
        Dim strQuery2 As String
        Dim i As Integer
        strQuery1 = "Exec usp_EmployeeCount " & CType(m_lngProjectID, String) & "," & CType(m_lngEmployeeID, String) & "," & 1
        countofInvoiceGenerators = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery1, MyBase.UseSQL), "0"), Integer)
        strQuery2 = "Exec usp_EmployeeCount " & CType(m_lngProjectID, String) & "," & CType(m_lngEmployeeID, String) & "," & 2
        countofIRApprovers = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery2, MyBase.UseSQL), "0"), Integer)

        strSQL = "usp_Upd_AssignedTasks_Updation_ReleaseResource 3," + m_lngProjectID.ToString + "," + m_lngEmployeeID.ToString + ",'" + Session("strUserName").ToString + "',NULL"
        If m_strTimesheetApprover <> "" And m_strTimesheetApprover <> "0" Then
            strSQL = strSQL & "," & m_strTimesheetApprover.ToString
        Else
            strSQL = strSQL & ",NULL"
        End If
        If m_strnewTimesheetDefaultApprover <> "" And m_strnewTimesheetDefaultApprover <> "0" Then
            strSQL = strSQL & "," & m_strnewTimesheetDefaultApprover.ToString
        Else
            strSQL = strSQL & ",NULL"
        End If

        If m_strExpenseApprover <> "" And m_strExpenseApprover <> "0" Then
            strSQL = strSQL & "," & m_strExpenseApprover.ToString
        Else
            strSQL = strSQL & ",NULL"
        End If

        If m_strnewExpenseDefaultApprover <> "" And m_strnewExpenseDefaultApprover <> "0" Then
            strSQL = strSQL & "," & m_strnewExpenseDefaultApprover.ToString
        Else
            strSQL = strSQL & ",NULL"
        End If

        If m_strnewDeliverableResponsiblePerson <> "" And m_strnewDeliverableResponsiblePerson <> "0" Then
            strSQL = strSQL & "," & m_strnewDeliverableResponsiblePerson.ToString
        Else
            strSQL = strSQL & ",NULL"
        End If
        If m_strnewIssueResponsiblePerson <> "" And m_strnewIssueResponsiblePerson <> "0" Then
            strSQL = strSQL & "," & m_strnewIssueResponsiblePerson.ToString
        Else
            strSQL = strSQL & ",NULL"
        End If
        If m_strnewResponsiblePersonForIssue <> "" And m_strnewResponsiblePersonForIssue <> "0" Then
            strSQL = strSQL & "," & m_strnewResponsiblePersonForIssue.ToString
        Else
            strSQL = strSQL & ",NULL"
        End If
        If m_strnewResponsiblePersonForInvoice <> "" And m_strnewResponsiblePersonForInvoice <> "0" Then
            strSQL = strSQL & "," & m_strnewResponsiblePersonForInvoice.ToString
        Else
            strSQL = strSQL & ",NULL"
        End If
        If m_strnewMSPFileOwner <> "" And m_strnewMSPFileOwner <> "0" Then
            strSQL = strSQL & "," & m_strnewMSPFileOwner.ToString
        Else
            strSQL = strSQL & ",NULL"
        End If

        If m_strnewRisksResponsiblePerson <> "" And m_strnewRisksResponsiblePerson <> "0" Then
            strSQL = strSQL & "," & m_strnewRisksResponsiblePerson.ToString
        Else
            strSQL = strSQL & ",NULL"
        End If


        If m_strnewPersonResponsibleForTimesheetblocking <> "" And m_strnewPersonResponsibleForTimesheetblocking <> "0" Then
            strSQL = strSQL & "," & m_strnewPersonResponsibleForTimesheetblocking.ToString
        Else
            strSQL = strSQL & ",NULL"
        End If
        'Added by TruptiK on 4-July-2007
        'Purpose:-To check whether resource is IRApprover or IRGenerator before releasing.
        If m_strnewIRApprover <> "" And m_strnewIRApprover <> "0" Then
            strSQL = strSQL & "," & m_strnewIRApprover.ToString
        Else
            strSQL = strSQL & ",NULL"
        End If
        If m_strnewInvoiceGenerator <> "" And m_strnewInvoiceGenerator <> "0" Then
            strSQL = strSQL & "," & m_strnewInvoiceGenerator.ToString
        Else
            strSQL = strSQL & ",NULL"
        End If

        If m_strnewTimesheetAuthenticator <> "" And m_strnewTimesheetAuthenticator <> "0" Then
            strSQL = strSQL & "," & m_strnewTimesheetAuthenticator.ToString
        Else
            strSQL = strSQL & ",NULL"
        End If
        'If countofIRApprovers <> "0" And countofIRApprovers <> "" Then
        strSQL = strSQL & "," & countofIRApprovers & "," & countofInvoiceGenerators
        'Else
        'strSQL = strSQL & ",NULL"
        'End If
        'If countofInvoiceGenerators <> "0" And countofInvoiceGenerators <> "" Then
        'strSQL = strSQL & "," & countofInvoiceGenerators.ToString  '& "," & countofInvoiceGenerators
        'Else
        '    strSQL = strSQL & ",NULL"
        'End If
        CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
        'End of addition by TruptiK

    End Sub

    Public Sub PlotSkillsSection()
        Dim drWork As IDataReader
        Dim strQuery As String = ""

        Dim blnHasSkills As Boolean = False
        Dim objHeader As New WebPages.Template.HeaderFooter

        Dim strMenu As String
        Dim strCaption As String = ""

        'Get the Related Information
        GetProjectDetails()



        strQuery = "Exec usp_Sel_tbl_PM_ProjectTools " & m_lngProjectID.ToString()
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                blnHasSkills = True
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)

        GetYearsMonthsAndDays()
        If m_intEmployeeDays > 0 Then
            m_intEmployeeMonths = m_intEmployeeMonths + 1
        End If

        If m_intEmployeeMonths >= 12 Then
            m_intEmployeeYears = m_intEmployeeYears + 1
        End If

        'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txthidEmployeeId", "txthidEmployeeId", , , , m_lngEmployeeID.ToString(), , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding

        If blnHasEmpRecord = True And blnHasSkills = True Then
            'Display Page Caption
            CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
            CommonFunctions.General.WriteHTML("<tr class='clsTRGroupHeader'>")
            CommonFunctions.General.WriteHTML("<td align='Left' width=80%>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("RELEASEPAGE_HEADER").ToString)
            CommonFunctions.General.WriteHTML("</td></tr></table>")

            CommonFunctions.General.WriteHTML("<br>")

            'Display page body
            Display_Skills()
        Else
            Display_NoRecords(blnHasEmpRecord, blnHasSkills)
            CommonFunctions.General.WriteHTML("<br>")
        End If

        'Hidden Controls
        'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txthidAction", "txthidAction", , , , , , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
    End Sub

    Private Sub GetProjectDetails()
        Dim drWork As IDataReader
        Dim strQuery As String = ""
        Dim lngTempUsed As Long = 0

        m_intYearsToBeShown = 0
        m_intMonthsToBeShown = 0

        strQuery = "Exec usp_Sel_tbl_PM_Project_ActualStartDate " & m_lngProjectID.ToString()
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                m_strStartDate = CommonFunctions.Data.CheckIsDBNull(drWork.Item("ActualStartDate")).ToString()
                If ("" & m_strStartDate).Trim() <> "" Then
                    lngTempUsed = DateDiff(DateInterval.Month, CType(m_strStartDate, Date), Now)
                    m_intYearsToBeShown = CType(lngTempUsed / 12, Integer)
                    If lngTempUsed >= 11 Then
                        m_intYearsToBeShown += 1
                    End If
                    If m_intYearsToBeShown = 0 Then
                        lngTempUsed = DateDiff(DateInterval.Day, CType(m_strStartDate, Date), Now())
                        m_intMonthsToBeShown = CType(lngTempUsed / 30, Integer)

                        If m_intMonthsToBeShown < 11 Then
                            m_intMonthsToBeShown += 1
                        End If

                    Else
                        m_intMonthsToBeShown = 11
                    End If
                End If '
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)
    End Sub

    Private Sub Display_NoRecords(ByVal blnHasEmpRecord As Boolean, ByVal blnHasSkills As Boolean)
        CommonFunctions.General.WriteHTML("<DIV id=divList style='overflow:auto;width:100%'>")
        CommonFunctions.General.WriteHTML("<TABLE class=clsTable width='99.9%'>")
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD align='center'><BR>")
        If blnHasEmpRecord = False Then
            CommonFunctions.General.WriteHTML("<B>" & MyBase.GetResourceString("NO_RESOURCES_ASSIGNED") & "</B>")
            CommonFunctions.General.WriteHTML("<script>if(confirm('" & MyBase.GetResourceString("ADD_RESOURCES") & "')){")
            CommonFunctions.General.WriteHTML("window.location.href = ""../PM/PM_ProjectResources.aspx?FromWhere=PM&MasterTagID=38"";")
            CommonFunctions.General.WriteHTML("}</script>")
            'm_strClientSideScript &= "window.location.href = '../PM/ProjectResources.asp?FromWhere=PM&MasterTagID=" & m_lngTagId.ToString() & "'"
        ElseIf blnHasSkills = False Then
            'Added By VarunA on 31-Aug-2009 RequestID-22669
            'Purpose : It was showing wrong message.
            'CommonFunctions.General.WriteHTML("<B>" & MyBase.GetResourceString("NO_DEVELOPMENT_TOOL_ASSIGNED") & "</B><BR>")
            'CommonFunctions.General.WriteHTML(MyBase.GetResourceString("IF_TOOLS_USED"))
            'CommonFunctions.General.WriteHTML("<script>if(confirm('" & MyBase.GetResourceString("ADD_TOOLS") & "')){")
            CommonFunctions.General.WriteHTML("<B>No skills are recorded against in this project.</B><BR>")
            CommonFunctions.General.WriteHTML("please ensure that skills are added to the project first, and then follow the closure process. Or else, the skill set of the employees will not get updated.")
            CommonFunctions.General.WriteHTML("<script>if(confirm('Please add the skills used in the project.')){")
            'End By VarunA on 31-Aug-2009 RequestID-22669
            CommonFunctions.General.WriteHTML("window.location.href = ""../General/CommonList.aspx?FromWhere=PM&MasterTagID=35"";}</script>")
            'm_strClientSideScript &= "window.location.href = '../General/CommonList.asp?FromWhere=PM&MasterTagID=35'"
        End If
        CommonFunctions.General.WriteHTML("</TD></TR></TABLE></DIV>")
    End Sub

    Private Sub GetProjectExperienceDetails(ByVal lngEmployeeId As Long, ByVal lngToolId As Long)
        Dim strQuery As String
        Dim drWork As IDataReader

        strQuery = "Exec usp_Sel_tbl_PM_EmployeeSkillMatrix_Detail " & m_lngProjectID.ToString()
        strQuery &= ", " & lngEmployeeId.ToString()
        strQuery &= ", " & lngToolId.ToString()
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                m_intEmployeeYears = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("YearsOfExperience"), "0").ToString(), Integer)
                m_intEmployeeMonths = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("MonthsOfExperience"), "0").ToString(), Integer)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)
    End Sub

    Private Sub GetYearsMonthsAndDays()
        Dim intDays As Integer

        intDays = m_intTotalDays
        m_intEmployeeYears = CType(intDays / 365, Integer)
        intDays = intDays Mod 365

        If intDays = 365 Then
            m_intEmployeeMonths = 12
            m_intEmployeeDays = 0
        ElseIf intDays >= 334 Then
            m_intEmployeeMonths = 11
            m_intEmployeeDays = intDays - 334
        ElseIf intDays >= 304 Then
            m_intEmployeeMonths = 10
            m_intEmployeeDays = intDays - 304
        ElseIf intDays >= 273 Then
            m_intEmployeeMonths = 9
            m_intEmployeeDays = intDays - 273
        ElseIf intDays >= 243 Then
            m_intEmployeeMonths = 8
            m_intEmployeeDays = intDays - 243
        ElseIf intDays >= 212 Then
            m_intEmployeeMonths = 7
            m_intEmployeeDays = intDays - 212
        ElseIf intDays >= 181 Then
            m_intEmployeeMonths = 6
            m_intEmployeeDays = intDays - 181
        ElseIf intDays >= 151 Then
            m_intEmployeeMonths = 5
            m_intEmployeeDays = intDays - 151
        ElseIf intDays >= 120 Then
            m_intEmployeeMonths = 4
            m_intEmployeeDays = intDays - 120
        ElseIf intDays >= 90 Then
            m_intEmployeeMonths = 3
            m_intEmployeeDays = intDays - 90
        ElseIf intDays >= 59 Then
            m_intEmployeeMonths = 2
            m_intEmployeeDays = intDays - 59
        ElseIf intDays >= 31 Then
            m_intEmployeeMonths = 1
            m_intEmployeeDays = intDays - 31
        Else
            m_intEmployeeMonths = 0
            m_intEmployeeDays = intDays
        End If
    End Sub

    Private Sub Display_Skills()
        'Grid Related Variables
        Dim intTotalColumns As Integer = 2
        Dim arrActualColumns(intTotalColumns - 1) As String
        Dim arrUserFriendlyColumn(intTotalColumns - 1) As String
        Dim arrTDStyle(intTotalColumns - 1) As String
        Dim intIndex As Integer = 0
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'Display the List of the Skills
        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("SKILL")
        arrActualColumns(intIndex) = "Description"
        arrTDStyle(intIndex) = "align=left"
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("EXPERIENCE")
        arrActualColumns(intIndex) = "ToolID"
        arrTDStyle(intIndex) = "align='center'"
        intIndex += 1

        'Set the Grid Properties
        With m_objSkillsGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            .PrimaryKey = "ToolID"
            .SQL = "Exec usp_Sel_tbl_PM_ProjectTools " & m_lngProjectID.ToString()
            .UseSQL = MyBase.UseSQL
            .DIVID = "divList"
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = intTotalColumns
            .returnHTML = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
    End Sub

    Private Sub UpdateSkills()
        Dim strQuery As String = ""
        Dim strToolIds As String = ""
        Dim arrToolId() As String
        Dim intCnt As Integer = 0
        Dim intYrs As Integer = 0
        Dim intMnths As Integer = 0

        m_lngEmployeeID = CType("0" & MyBase.FixString(MyBase.GetFormValue("txthidEmployeeId"), 0, True, True), Long)
        strToolIds = "" & MyBase.FixString(MyBase.GetFormValue("txthidToolId"), 0, False, False)
        If strToolIds.Trim() <> "" Then
            arrToolId = strToolIds.Split(CType(",", Char))
            For intCnt = 0 To arrToolId.Length - 1
                intYrs = CType("0" & MyBase.FixString(MyBase.GetFormValue("cboYRow_" & arrToolId(intCnt).ToString()), 0, True, False), Integer)
                intMnths = CType("0" & MyBase.FixString(MyBase.GetFormValue("cboMRow_" & arrToolId(intCnt).ToString()), 0, True, False), Integer)
                strQuery = "Exec usp_Ins_tbl_PM_EmployeeSkillMatrix_Detail " & m_lngProjectID.ToString()
                strQuery &= ", " & m_lngEmployeeID.ToString()
                strQuery &= ", " & arrToolId(intCnt).ToString()
                strQuery &= ", " & intYrs.ToString()
                strQuery &= ", " & intMnths.ToString() & ",0"
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            Next
        End If
    End Sub

    Private Sub ReleaseResource()
        Dim strQuery As String = ""
        Dim drEmail As IDataReader
        Dim blnSendEMail As Boolean = False
        Dim blnShowPopup As Boolean = False
        Dim strToEmailID As String = ""
        Dim strCCToEmailID As String = ""
        Dim strFromEmailID As String = ""
        Dim strSubject As String = ""
        Dim strEmailMessage As String = ""

        Dim strSQL As String
        Dim intResult As Integer
        Dim objTemplate As WebPages.Template.WhizTemplate
        strSQL = "Usp_Sel_Isallowedtoreleaseresource_ReleaseResource " + m_lngUniqueID.ToString
        intResult = CType(CommonFunctions.Data.GetDataScalar(strSQL, True), Integer)

        If intResult = 1 Then
            CommonFunction.General.WriteHTML("<Script>")
            CommonFunction.General.WriteHTML("alert(" + Chr(34) + MyBase.GetResourceString("RESOURCES_CANNOT_RELEASE") + Chr(34) + ");")
            CommonFunction.General.WriteHTML("</Script>")
        Else
            CommonFunction.General.WriteHTML("<Script>")
            strQuery = "Exec usp_Upd_tbl_PM_ProjectEmployeeRole '" & m_lngUniqueID.ToString()
            strQuery &= "', '" & CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) & "'"
            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            'Send Emails to all the Released resources
            strQuery = "usp_Sel_tbl_PM_EmailMessages 16"
            drEmail = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drEmail) <> "" Then
                If drEmail.Read() Then
                    blnSendEMail = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("SendMail"), "False"), Boolean)
                    blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("ShowPopup"), "False"), Boolean)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drEmail)
            If blnSendEMail = True Then
                If blnShowPopup = True Then
                    CommonFunction.General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=16&ProjectEmployeeRoleId=" & m_lngUniqueID.ToString() & "', '', 'resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');")
                Else
                    CommonFunction.EmailMessages.PMMessages.GetEmailMessage_16(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, m_lngUniqueID.ToString())
                    CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                End If
            End If
            CommonFunction.General.WriteHTML("alert(" + Chr(34) + MyBase.GetResourceString("RESOURCES_RELEASE_SUCCESS") + Chr(34) + ");")
            CommonFunction.General.WriteHTML("window.opener.location=window.opener.location;")
            CommonFunction.General.WriteHTML("window.close();")
            CommonFunction.General.WriteHTML("</Script>")
        End If
    End Sub
#End Region

#Region "Functions & Procedures"

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        : GetGlobalObject
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Get the global object and assign it to variable
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
    End Sub

    Private Sub DrawMenu()
        '====================================================================
        ' Procedure Name        : DrawMenu
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the menu
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================

        Dim arrMenuList As New ArrayList
        Dim arrMenuToolTipList As New ArrayList
        Dim arrClientSideFunctionList As New ArrayList
        Dim strGrid As String
        'PrachiK
        'Modified By PrachiK on 15 Feb 2005 for Issue ID=15509. 
        'Purpose: Do not allow user to save changes who is having just "View" Access
        'If m_objAccessRights.Add = True Or m_objAccessRights.Edit = True Then
        arrMenuList.Add(MyBase.GetResourceString("MENU_SAVE"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
        arrClientSideFunctionList.Add("Save_OnClick()")
        'End If
        'Addtion ended

        'Intigrated by  HarshK for sp4 issueid 190 

        arrMenuList.Add(MyBase.GetResourceString("MENU_SELECT_ALL"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_SELECT_ALL_TOOLTIP"))
        arrClientSideFunctionList.Add("SelectAll_OnClick()")

        arrMenuList.Add(MyBase.GetResourceString("MENU_CLEAR_ALL"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_CLEAR_ALL_TOOLTIP"))
        arrClientSideFunctionList.Add("ClearAll_OnClick()")

        arrMenuList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
        arrClientSideFunctionList.Add("Close_OnClick()")

        arrMenuList.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        'Modified By VidyaJ - For IssueID - 492 - SP4
        arrClientSideFunctionList.Add("Help_OnClick('1019')")

        'Create the static menu.
        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipList), True)

    End Sub

    Private Sub DrawPageCaption()
        '====================================================================
        ' Procedure Name        : DrawPageCaption
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page caption thr' global object
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Response.Write("<BR>")
        Response.Write(PageCaption.GetPageCaptions(m_objGlobal, MyBase.GetResourceString("HEADING_RELEASE_RESOURCE"), MyBase.GetResourceString("HEADING_RESOURCE_NAME") & " : " + m_strUserName + " - " + m_strEmployeeName, , True))
        Response.Write("<BR>")

    End Sub

    Private Sub DrawHeader()
        '====================================================================
        ' Procedure Name        : DrawHeader
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page Header thr' global object
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Dim objHeader As HeaderFooter
        Dim strReturn As String
        objHeader = New HeaderFooter
        objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        strReturn = MyBase.GetResourceString("RELEASE_RESOURCE_CAPTION")
        If strReturn <> "" Then
            CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
            CommonFunctions.General.WriteHTML("<tr class='clsTRGroupHeader'>")
            CommonFunctions.General.WriteHTML("<td align='Left' width=80%>")
            CommonFunctions.General.WriteHTML(strReturn)
            CommonFunctions.General.WriteHTML("</td></tr></table>")
        End If
        objHeader = Nothing
        Response.Write("<BR>")
    End Sub

    Private Sub DisposeObjects()
        '====================================================================
        ' Procedure Name        : DisposeObjects
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Dispose all the objects
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        m_objMenu = Nothing
        m_objTaskCompletionGrid = Nothing
        m_objTaskVoidGrid = Nothing
        m_objMPPGrid = Nothing
        m_objSkillsGrid = Nothing
        m_objGlobal = Nothing
        m_objAccessRights = Nothing

    End Sub

    Private Sub DisplayTaskCompletionGrid()
        Dim strSQLQuery As String = ""
        Dim strWhereClause As String = ""

        strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksForCompletion_ReleaseResource " & CType(m_lngProjectID, String) & "," & CType(m_lngEmployeeID, String)

        'Modified by HarshK for sp4 issueid 642 on 24/10/2005
        Dim arrActualColumns() As String = {"TaskName", "StartDate", "EndDate", _
                                            "ActualStartDate", "PlannedWork", "ActualWork", "ActualPercentComplete", ""}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("HEADING_TASK_NAME"), _
                                                 MyBase.GetResourceString("HEADING_START_DATE"), MyBase.GetResourceString("HEADING_END_DATE"), _
                                                 MyBase.GetResourceString("HEADING_ACTUAL_START_DATE"), _
                                                 MyBase.GetResourceString("HEADING_EFFORTS"), MyBase.GetResourceString("HEADING_ACTUAL_EFFORTS"), _
                                                 MyBase.GetResourceString("HEADING_ACTUAL_PERCENT_COMPLETE"), MyBase.GetResourceString("HEADING_IS_TASK_COMPLETE")}
        Dim arrstrTDStyle() As String = {"align='left' width=40%", "align='left' width=5%", _
                                         "align='left' width=5%", "align='left' width=5%", "align='right' width=5%", "align='right' width=5%", _
                                         "align='right' width=5%", "align='center' width=5%"}
        Dim arrstrCheckboxID() As String = {"", "", "", "", "", "", "", "chkTaskcomplete"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        With m_objTaskCompletionGrid
            .ColNameToolTipOnEachRow = True
            .ActualColumnArray = arrActualColumns
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .NoOfDataColumns = arrUserFriendlyColumn.GetLength(0) - 1
            .PrimaryKey = "TaskID"
            .CheckBoxIDArray = arrstrCheckboxID
            .ColumnHeaderAlignment = "left"
            .SQL = strSQLQuery
            .DIVHeight = 0
            .DIVID = "divList1"
            .UseSQL = True
            .TDStyleArray = arrstrTDStyle
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

    End Sub

    'Added by BharatTekade
    Private Sub DisplayMPPTaskGrid()
        Dim strSQLQuery As String = ""
        Dim strWhereClause As String = ""
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        strSQLQuery = "EXEC usp_Sel_MPPTask_tbl_PM_ProjectTasks " & CType(m_lngProjectID, String) & "," & CType(m_lngEmployeeID, String)

        'Modified by BHARAT for sp4 issueid 642 on 31/03/2014
        Dim arrActualColumns() As String = {"TaskName", "UserName", "StartDate", "EndDate"}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("HEADING_TASK_NAME"), _
                                                 MyBase.GetResourceString("HEADING_USER_NAME"), _
                                                 MyBase.GetResourceString("HEADING_START_DATE"), _
                                                 MyBase.GetResourceString("HEADING_END_DATE")}

        Dim arrstrTDStyle() As String = {"align='left' width=40%", "align='left' width=5%", _
                                         "align='left' width=5%", "align='left' width=5%"}
        Dim arrstrCheckboxID() As String = {"", "", "", ""}

        With m_objMPPGrid
            .ColNameToolTipOnEachRow = True
            .ActualColumnArray = arrActualColumns
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .NoOfDataColumns = 4
            .PrimaryKey = "TaskID"
            '.CheckBoxIDArray = arrstrCheckboxID
            .ColumnHeaderAlignment = "left"
            .SQL = strSQLQuery
            .DIVHeight = 0
            .DIVID = "divList2"
            .UseSQL = True
            .TDStyleArray = arrstrTDStyle
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

    End Sub
    'End Bharat Tekade


    Private Sub DisplayTasktobeVoidedGrid()
        Dim strSQLQuery As String = ""
        Dim strWhereClause As String = ""
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksForVoiding_ReleaseResource " & CType(m_lngProjectID, String) & "," & CType(m_lngEmployeeID, String)

        'Modified by HarshK for sp4 issueid 642 on 24/10/2005
        Dim arrActualColumns() As String = {"TaskName", "StartDate", "EndDate", _
                                            "ActualStartDate", "PlannedWork", "ActualWork", "ActualPercentComplete", ""}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("HEADING_TASK_NAME"), _
                                                 MyBase.GetResourceString("HEADING_START_DATE"), MyBase.GetResourceString("HEADING_END_DATE"), _
                                                 MyBase.GetResourceString("HEADING_ACTUAL_START_DATE"), _
                                                 MyBase.GetResourceString("HEADING_EFFORTS"), MyBase.GetResourceString("HEADING_ACTUAL_EFFORTS"), _
                                                 MyBase.GetResourceString("HEADING_ACTUAL_PERCENT_COMPLETE"), MyBase.GetResourceString("HEADING_IS_TASK_VOID")}
        Dim arrstrTDStyle() As String = {"align='left' width=40%", "align='left' width=5%", _
                                         "align='left' width=5%", "align='left' width=5%", "align='right' width=5%", "align='right' width=5%", _
                                         "align='right' width=5%", "align='center' width=5%"}
        Dim arrstrCheckboxID() As String = {"", "", "", "", "", "", "", "chkTaskvoid"}

        With m_objTaskVoidGrid
            .ColNameToolTipOnEachRow = True
            .ActualColumnArray = arrActualColumns
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .NoOfDataColumns = arrUserFriendlyColumn.GetLength(0) - 1
            .PrimaryKey = "TaskID"
            .CheckBoxIDArray = arrstrCheckboxID
            .ColumnHeaderAlignment = "left"
            .SQL = strSQLQuery
            .DIVHeight = 0
            .DIVID = "divList2"
            .UseSQL = True
            .TDStyleArray = arrstrTDStyle
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

    End Sub
    'Added by TruptiK on 6-Apr-09 
    'Purpose:-to reject pending extend request before releasing resource
    Private Sub DisplayExtendRequestsGrid()
        Dim strSQLQuery As String = ""
        Dim strWhereClause As String = ""
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        strSQLQuery = "EXEC usp_sel_resource_request " & CType(m_lngProjectID, String) & "," & CType(m_lngEmployeeID, String)

        'Modified by SanaS on 15-Oct-2009
        'Actual Field Workhours changed to TotalRequested Hrs
        Dim arrActualColumns() As String = {"RequestID", "fromdate", "todate", _
                                            "TotalRequestedHrs", "RequestType", "status"}
        'End Modification by SanaS on 15-Oct-2009
        Dim arrUserFriendlyColumn() As String = {("Request ID"), _
                                                 MyBase.GetResourceString("HEADING_START_DATE"), MyBase.GetResourceString("HEADING_END_DATE"), _
                                                ("Work Hours"), _
                                                ("Request Type"), ("Status"), _
                                                    MyBase.GetResourceString("HEADING_IS_TASK_COMPLETE")}

        Dim arrstrTDStyle() As String = {"align='left' width=15%", "align='left' width=15%", _
                                 "align='left' width=15%", "align='left' width=15%", "align='left' width=15%", "align='left' width=15%", "align='center' width=10%"}

        Dim arrstrCheckboxID() As String = {"", "", "", "", "", "", "chkRequest"}

        With m_objExtendRequestsGrid
            .ColNameToolTipOnEachRow = True
            .ActualColumnArray = arrActualColumns
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .NoOfDataColumns = arrUserFriendlyColumn.GetLength(0) - 1
            .PrimaryKey = "RequestID"
            .CheckBoxIDArray = arrstrCheckboxID
            '.ColumnHeaderAlignment = "left"
            .SQL = strSQLQuery
            .DIVHeight = 0
            .DIVID = "divList1"
            .UseSQL = True
            .TDStyleArray = arrstrTDStyle
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

    End Sub
    'End of addition by TruptiK
    Private Sub DisplayApproverGrid()
        '-- Calculate Allowable Lower limit
        Dim drApprover As IDataReader
        Dim strSQLQuery As String
        Dim m_TimesheetApprovee As String
        Dim m_ExpenseApprovee As String

        Dim m_strDeliverableList As String
        Dim m_strIssueList As String
        Dim m_ResponsiblePersonForIssue As String
        Dim m_ResponsiblePersonForInvoice As String
        Dim m_MSPFileOwner As String
        Dim m_strRisksList As String
        Dim m_PersonResponsibleForTimesheetblocking As String
        Dim m_strTimesheetDefaultApprover As String
        Dim m_strExpenseDefaultApprover As String
        'Added by TruptiK on 3-July-2007
        'Purpose:-To check whether resource is IRApprover or IRGenerator before releasing.
        'Dim m_StrIRApprover As String
        'Dim m_strInvoiceGenerator As String
        'End of addition by TruptiK

        '------ Added By PurvaJ on 26 May 2008 Configurable Workflow release resource
        Dim m_strWorkflowApprover As String = ""
        m_strWorkflowApprover = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_IsWorkflowApprover " + CType(m_lngEmployeeID, String) + "," + CommonFunction.General.CheckIsNothing(Session("intProjectID"), "0").ToString, True), "0"), "0")
        '------ End addtion PurvaJ

        strSQLQuery = "Exec Usp_Sel_TimesheetandExpenseApproveelist_ReleaseResource " & CType(m_lngProjectID, String) & "," & CType(m_lngEmployeeID, String)
        drApprover = CommonFunctions.Data.GetDataReader(strSQLQuery, True)
        If drApprover.Read Then
            m_TimesheetApprovee = CType(CommonFunctions.Data.CheckIsDBNull(drApprover("TimesheetApproveelist"), ""), String)
            m_ExpenseApprovee = CType(CommonFunctions.Data.CheckIsDBNull(drApprover("ExpenseApproveelist"), ""), String)
            m_strDeliverableList = CType(CommonFunctions.Data.CheckIsDBNull(drApprover("DeliverableList"), ""), String)
            m_strIssueList = CType(CommonFunctions.Data.CheckIsDBNull(drApprover("IssueList"), ""), String)
            m_ResponsiblePersonForIssue = CType(CommonFunctions.Data.CheckIsDBNull(drApprover("ResponsiblePersonForIssue"), ""), String)
            m_ResponsiblePersonForInvoice = CType(CommonFunctions.Data.CheckIsDBNull(drApprover("ResponsiblePersonForInvoice"), ""), String)
            m_MSPFileOwner = CType(CommonFunctions.Data.CheckIsDBNull(drApprover("MSPFileOwner"), ""), String)
            m_strRisksList = CType(CommonFunctions.Data.CheckIsDBNull(drApprover("RisksList"), ""), String)
            m_PersonResponsibleForTimesheetblocking = CType(CommonFunctions.Data.CheckIsDBNull(drApprover("PersonResponsibleForTimesheetblocking"), ""), String)
            m_strTimesheetDefaultApprover = CType(CommonFunctions.Data.CheckIsDBNull(drApprover("TimesheetDefaultApprover"), ""), String)
            m_strExpenseDefaultApprover = CType(CommonFunctions.Data.CheckIsDBNull(drApprover("ExpenseDefaultApprover"), ""), String)
            'Added by TruptiK on 3-July-2007
            'Purpose:-To check whether resource is IRApprover or IRGenerator before releasing.
            m_StrIRApprover = CType(CommonFunctions.Data.CheckIsDBNull(drApprover("IRApprover"), ""), String)
            m_strInvoiceGenerator = CType(CommonFunctions.Data.CheckIsDBNull(drApprover("InvoiceGenerator"), ""), String)
            m_TimesheetAuthenticator = CType(CommonFunctions.Data.CheckIsDBNull(drApprover("TimesheetAuthentication"), ""), String)
            'End of addition by TruptiK on 3-July-2007
        End If
        CommonFunctions.Data.DisposeDataReader(drApprover)

        strSQLQuery = "EXEC usp_Sel_TeamMembers_ReleaseResource " & CType(m_lngProjectID, String) & "," & CType(m_lngEmployeeID, String)
        If m_TimesheetApprovee <> "" Then
            '--- Timesheet Approver Table
            CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td align='Left' width=80%>")
            CommonFunctions.General.WriteHTML(m_strEmployeeName.ToString & MyBase.GetResourceString("TIMESHEET_F") & m_TimesheetApprovee.ToString & MyBase.GetResourceString("TIMESHEET_L"))
            CommonFunctions.General.WriteHTML("</td>")

            CommonFunctions.General.WriteHTML("<td align='Left' width=20%>")
            'Modified by PurvaJ on 12 Nov 2008 for Whiziblesem 8.0 to display middle level and high level resources also
            ' strSQLQuery replaced with usp_Sel_Approvers_List
            'CommonFunctions.General.WriteHTML(strWriteHTML.ToString)
            Dim GroupingColNameTImesheet As CommonFunctions.HTMLControls.WAF_DropDown = New CommonFunctions.HTMLControls.WAF_DropDown
            GroupingColNameTImesheet.DropdownGroupingColumn = "IsExternal"
            GroupingColNameTImesheet.WidthInPixel = 200
            GroupingColNameTImesheet.InsertBlankRow = True
            GroupingColNameTImesheet.IsMandatory = True
            GroupingColNameTImesheet.MatchFieldID = CType(m_strTimesheetApprover, String)

            'CommonFunctions.HTMLControls.DrawComboBox("cboTimesheetApprover", "usp_Sel_Approvers_List " & CType(m_lngProjectID, String) & "," & CType(m_lngEmployeeID, String), 200, CType(m_strTimesheetApprover, String), "", True)
            CommonFunctions.HTMLControls.DrawComboBox("cboTimesheetApprover", "usp_Sel_Approvers_List " & CType(m_lngProjectID, String) & "," & CType(m_lngEmployeeID, String), GroupingColNameTImesheet)
            '--- End modification PurvaJ

            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr></table>")
            CommonFunctions.General.WriteHTML("<br>")
        End If

        If m_strTimesheetDefaultApprover = "1" Then
            '--- Timesheet Approver Table
            CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td align='Left' width=80%>")
            CommonFunctions.General.WriteHTML(m_strEmployeeName.ToString & MyBase.GetResourceString("TIMESHEETDEFAULTAPPROVER"))
            CommonFunctions.General.WriteHTML("</td>")

            CommonFunctions.General.WriteHTML("<td align='Left' width=20%>")
            CommonFunctions.HTMLControls.DrawComboBox("cboTimesheetDefaultApprover", strSQLQuery, 200, CType(m_strnewTimesheetDefaultApprover, String), "", True)
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr></table>")
            CommonFunctions.General.WriteHTML("<br>")
        End If

        If m_ExpenseApprovee <> "" Then
            '--- Expense Approver Table
            CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td align='Left' width=80%>")
            CommonFunctions.General.WriteHTML(m_strEmployeeName.ToString & MyBase.GetResourceString("EXPENSE_F") & m_ExpenseApprovee.ToString & MyBase.GetResourceString("EXPENSE_L"))
            CommonFunctions.General.WriteHTML("</td>")

            CommonFunctions.General.WriteHTML("<td align='Left' width=20%>")
            'Modified by PurvaJ on 12 Nov 2008 for Whiziblesem 8.0 to display middle level and high level resources also
            ' strSQLQuery replaced with usp_Sel_Approvers_List
            Dim GroupingColNameExpense As CommonFunctions.HTMLControls.WAF_DropDown = New CommonFunctions.HTMLControls.WAF_DropDown
            GroupingColNameExpense.DropdownGroupingColumn = "IsExternal"
            GroupingColNameExpense.WidthInPixel = 200
            GroupingColNameExpense.InsertBlankRow = True
            GroupingColNameExpense.IsMandatory = True
            GroupingColNameExpense.MatchFieldID = CType(m_strExpenseApprover, String)

            'CommonFunctions.HTMLControls.DrawComboBox("cboExpenseApprover", "usp_Sel_Approvers_List " & CType(m_lngProjectID, String) & "," & CType(m_lngEmployeeID, String), 200, CType(m_strExpenseApprover, String), "", True)
            CommonFunctions.HTMLControls.DrawComboBox("cboExpenseApprover", "usp_Sel_Approvers_List " & CType(m_lngProjectID, String) & "," & CType(m_lngEmployeeID, String), GroupingColNameExpense)
            '--- End modification PurvaJ


            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr></table>")
            CommonFunctions.General.WriteHTML("<br>")
        End If

        If m_strExpenseDefaultApprover = "1" Then
            '--- Expense Approver Table
            CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td align='Left' width=80%>")
            CommonFunctions.General.WriteHTML(m_strEmployeeName.ToString & MyBase.GetResourceString("EXPENSEDEFAULTAPPROVER"))
            CommonFunctions.General.WriteHTML("</td>")

            CommonFunctions.General.WriteHTML("<td align='Left' width=20%>")
            CommonFunctions.HTMLControls.DrawComboBox("cboExpenseDefaultApprover", strSQLQuery, 200, CType(m_strnewExpenseDefaultApprover, String), "", True)
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr></table>")
            CommonFunctions.General.WriteHTML("<br>")
        End If
        'Added by TruptiK on 3-July-2007
        'Purpose:-To check whether resource is IRApprover or IRGenerator before releasing.
        Dim StrSqlquery1 As String
        Dim strQuery2 As String
        StrSqlquery1 = "Exec usp_Sel_tbl_PM_Role_RFIApprover " & CType(m_lngProjectID, String) '& "," & CType(m_lngEmployeeID, String)
        strQuery2 = "Exec usp_EmployeeCount " & CType(m_lngProjectID, String) & "," & CType(m_lngEmployeeID, String) & "," & 2
        countofIRApprovers = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery2, MyBase.UseSQL), "0"), Integer)
        If m_StrIRApprover = "1" And countofIRApprovers = 0 Then
            CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td align='Left' width=80%>")
            CommonFunctions.General.WriteHTML(m_strEmployeeName.ToString & MyBase.GetResourceString("IRAPPROVER"))
            CommonFunctions.General.WriteHTML("</td>")

            CommonFunctions.General.WriteHTML("<td align='Left' width=20%>")
            CommonFunctions.HTMLControls.DrawComboBox("cboIRApprover", StrSqlquery1, 200, CType(m_strnewIRApprover, String), "", True)
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr></table>")
            CommonFunctions.General.WriteHTML("<br>")
        ElseIf m_StrIRApprover = "1" And countofIRApprovers <> 0 Then
            CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td align='Left' width=80%>")
            CommonFunctions.General.WriteHTML(m_strEmployeeName.ToString & MyBase.GetResourceString("IRAPPROVER1"))
            CommonFunctions.General.WriteHTML("</td>")
        End If
        StrSqlquery1 = ""
        strQuery2 = ""
        StrSqlquery1 = "Exec USP_SEL_PM_ACCOUNTPERSONLIST " & CType(m_lngProjectID, String) '& "," & CType(m_lngEmployeeID, String)
        strQuery2 = "Exec usp_EmployeeCount " & CType(m_lngProjectID, String) & "," & CType(m_lngEmployeeID, String) & "," & 1
        countofInvoiceGenerators = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery2, MyBase.UseSQL), "0"), Integer)
        If m_strInvoiceGenerator = "1" And countofInvoiceGenerators = 0 Then
            CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td align='Left' width=80%>")
            CommonFunctions.General.WriteHTML(m_strEmployeeName.ToString & MyBase.GetResourceString("INVOICEGENERATION"))
            CommonFunctions.General.WriteHTML("</td>")

            CommonFunctions.General.WriteHTML("<td align='Left' width=20%>")
            CommonFunctions.HTMLControls.DrawComboBox("cboInvoiceGenerator", StrSqlquery1, 200, CType(m_strnewInvoiceGenerator, String), "", True)
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr></table>")
            CommonFunctions.General.WriteHTML("<br>")

        ElseIf m_strInvoiceGenerator = "1" And countofInvoiceGenerators <> 0 Then
            CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td align='Left' width=80%>")
            CommonFunctions.General.WriteHTML(m_strEmployeeName.ToString & MyBase.GetResourceString("INVOICEGENERATION1"))
            CommonFunctions.General.WriteHTML("</td>")
        End If
        StrSqlquery1 = ""
        StrSqlquery1 = "Exec usp_Sel_ProjectTimesheetApprovers " & CType(m_lngProjectID, String) & "," & CType(m_lngEmployeeID, String)
        If m_TimesheetAuthenticator = "1" Then
            CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td align='Left' width=80%>")
            CommonFunctions.General.WriteHTML(m_strEmployeeName.ToString & MyBase.GetResourceString("TIMESHEETAUTHENTICATOR"))
            CommonFunctions.General.WriteHTML("</td>")

            CommonFunctions.General.WriteHTML("<td align='Left' width=20%>")
            CommonFunctions.HTMLControls.DrawComboBox("cboTimesheetAuthenticator", StrSqlquery1, 200, CType(m_strnewTimesheetAuthenticator, String), "", True)
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr></table>")
            CommonFunctions.General.WriteHTML("<br>")
        End If
        'End of addition by TruptiK

        ' Deliverable Responsible Person
        If m_strDeliverableList <> "" And m_strDeliverableList <> "0" Then
            CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td align='Left' width=80%>")
            CommonFunctions.General.WriteHTML(m_strEmployeeName.ToString & MyBase.GetResourceString("DELIVERABLE_F") & m_strDeliverableList.ToString & MyBase.GetResourceString("DELIVERABLE_L"))
            CommonFunctions.General.WriteHTML("</td>")

            CommonFunctions.General.WriteHTML("<td align='Left' width=20%>")
            CommonFunctions.HTMLControls.DrawComboBox("cboDeliverableResponsiblePerson", strSQLQuery, 200, CType(m_strnewDeliverableResponsiblePerson, String), "", True)
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr></table>")
            CommonFunctions.General.WriteHTML("<br>")
        End If

        ' Issue Responsible Person
        If m_strIssueList <> "" And m_strIssueList <> "0" Then
            CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td align='Left' width=80%>")
            CommonFunctions.General.WriteHTML(m_strEmployeeName.ToString & MyBase.GetResourceString("ISSUE_F") & m_strIssueList.ToString & MyBase.GetResourceString("ISSUE_L"))
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("<td align='Left' width=20%>")
            CommonFunctions.HTMLControls.DrawComboBox("cboIssueResponsiblePerson", strSQLQuery, 200, CType(m_strnewIssueResponsiblePerson, String), "", True)
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr></table>")
            CommonFunctions.General.WriteHTML("<br>")
        End If

        ' Risks Responsible Person
        If m_strRisksList <> "" And m_strRisksList <> "0" Then
            CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td align='Left' width=80%>")
            CommonFunctions.General.WriteHTML(m_strEmployeeName.ToString & MyBase.GetResourceString("RISKS_F") & m_strRisksList.ToString & MyBase.GetResourceString("RISKS_L"))
            CommonFunctions.General.WriteHTML("</td>")

            CommonFunctions.General.WriteHTML("<td align='Left' width=20%>")
            CommonFunctions.HTMLControls.DrawComboBox("cboRisksResponsiblePerson", strSQLQuery, 200, CType(m_strnewRisksResponsiblePerson, String), "", True)
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr></table>")
            CommonFunctions.General.WriteHTML("<br>")
        End If

        ' Responsible Person for Issue --> Project Settings
        If m_ResponsiblePersonForIssue = "1" Then
            CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td align='Left' width=80%>")
            CommonFunctions.General.WriteHTML(m_strEmployeeName.ToString & MyBase.GetResourceString("PERSONRESPONSIBLEISSUE"))
            CommonFunctions.General.WriteHTML("</td>")

            CommonFunctions.General.WriteHTML("<td align='Left' width=20%>")
            CommonFunctions.HTMLControls.DrawComboBox("cboResponsiblePersonForIssue", strSQLQuery, 200, CType(m_strnewResponsiblePersonForIssue, String), "", True)
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr></table>")
            CommonFunctions.General.WriteHTML("<br>")
        End If

        ' Responsible Person for Issue --> Project Settings
        If m_ResponsiblePersonForInvoice = "1" Then
            CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td align='Left' width=80%>")
            CommonFunctions.General.WriteHTML(m_strEmployeeName.ToString & MyBase.GetResourceString("PERSONRESPONSIBLEINVOICE"))
            CommonFunctions.General.WriteHTML("</td>")

            CommonFunctions.General.WriteHTML("<td align='Left' width=20%>")
            CommonFunctions.HTMLControls.DrawComboBox("cboResponsiblePersonForInvoice", strSQLQuery, 200, CType(m_strnewResponsiblePersonForInvoice, String), "", True)
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr></table>")
            CommonFunctions.General.WriteHTML("<br>")
        End If
        ' MSP File Owner --> Project Settings
        If m_MSPFileOwner = "1" Then
            CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td align='Left' width=80%>")
            CommonFunctions.General.WriteHTML(m_strEmployeeName.ToString & MyBase.GetResourceString("MSPFILEOWNER"))
            CommonFunctions.General.WriteHTML("</td>")

            CommonFunctions.General.WriteHTML("<td align='Left' width=20%>")
            CommonFunctions.HTMLControls.DrawComboBox("cboMSPFileOwner", strSQLQuery, 200, CType(m_strnewMSPFileOwner, String), "", True)
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr></table>")
        End If

        ' Responsible Person for Timesheetblocking --> Project Settings
        If m_PersonResponsibleForTimesheetblocking = "1" Then
            CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td align='Left' width=80%>")
            CommonFunctions.General.WriteHTML(m_strEmployeeName.ToString & MyBase.GetResourceString("PERSONRESPONSIBLEFORTIMESHEETBLOCKING"))
            CommonFunctions.General.WriteHTML("</td>")

            CommonFunctions.General.WriteHTML("<td align='Left' width=20%>")
            CommonFunctions.HTMLControls.DrawComboBox("cboPersonResponsibleForTimesheetblocking", strSQLQuery, 200, CType(m_strnewPersonResponsibleForTimesheetblocking, String), "", True)
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr></table>")
        End If

        '----------- added By PurvaJ on 23 May 2008 Configurable workflow handover responsibilities
        If m_strWorkflowApprover = "1" Then

            Dim GroupingColWorkflow As CommonFunctions.HTMLControls.WAF_DropDown = New CommonFunctions.HTMLControls.WAF_DropDown
            GroupingColWorkflow.DropdownGroupingColumn = "IsExternal"
            GroupingColWorkflow.WidthInPixel = 200
            GroupingColWorkflow.InsertBlankRow = True
            GroupingColWorkflow.IsMandatory = True
            'GroupingColWorkflow.MatchFieldID = CType(m_strTimesheetApprover, String)


            CommonFunctions.General.WriteHTML("<TABLE ID='workflow' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td align='Left' width=80%>")
            CommonFunctions.General.WriteHTML(m_strEmployeeName.ToString + " is resposible for workflow approvals. Select the new approver")
            CommonFunctions.General.WriteHTML("</td>")

            CommonFunctions.General.WriteHTML("<td align='Left' width=20%>")
            CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawComboBox("cboEmployeeforworkflow", "usp_Sel_Approvers_List " & CType(m_lngProjectID, String) & "," & CType(m_lngEmployeeID, String), GroupingColWorkflow)) ', "usp_sel_Employee_ReleaseProjectResource " + Session("intProjectID").ToString + "," + m_lngEmployeeID.ToString, 200, , , True, True))
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr></table>")
            CommonFunctions.General.WriteHTML("<br>")
        End If
        '-------------- End addition PurvaJ

    End Sub

#End Region

#Region "Constructor"
    Public Sub New()
        'This constructor initialize resources and also apply security settings.
        ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016
        MyBase.InitializeResources("AppResources.PM_ReleaseResource", "AppResources")
    End Sub
#End Region

#Region "Destructor"
    Protected Overrides Sub Finalize()
        'This will call base class destructor.
        MyBase.Finalize()
    End Sub
#End Region

#Region "Grid Events"





#End Region

    Private Sub m_objSkillsGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objSkillsGrid.DataRowTD_BeforePrint
        Dim lngToolId As Long = 0

        lngToolId = CType("0" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("ToolID")).ToString(), Long)
        Select Case Args.ColIndex
            Case 0
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted = CommonFunctions.HTMLControls.DrawTextBox("txthidToolId", "txthidToolId", , , , lngToolId.ToString(), IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True)
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding

            Case 1
                Dim intCtr As Integer

                GetProjectExperienceDetails(m_lngEmployeeID, lngToolId)

                Args.StringToBeInserted = "<TD align=center noWrap>"
                If m_intYearsToBeShown > 0 Then
                    Args.StringToBeInserted &= "<SELECT name='cboYRow_" & lngToolId.ToString() & "' class=clsCombobox>"
                    For intCtr = 0 To m_intYearsToBeShown
                        Args.StringToBeInserted &= "<OPTION value='" & intCtr & "'"
                        If m_intEmployeeYears = intCtr Then Args.StringToBeInserted &= "selected"
                        Args.StringToBeInserted &= ">" & intCtr & "</OPTION>"
                    Next
                    Args.StringToBeInserted &= "</SELECT>"
                    ' Modified By	            : MahendraV on 6:08 PM 4/27/2007 for WhizibleSEM SP 8 
                    ' IssueID                   : 12554.
                    ' Issue Description         : Resource Skill Updation-On Release Resource Page years and months are not specified --> Project --> Resource Management --> Resource.
                    ' Change                    : 1)GetResourceString("YEARS") To GetResourceString("YEAR").
                    '                           : 2)GetResourceString("MONTHS") To GetResourceString("MONTH")

                    Args.StringToBeInserted &= "&nbsp;" & MyBase.GetResourceString("YEAR") & "&nbsp;"
                End If
                If m_intMonthsToBeShown > 0 Then
                    Args.StringToBeInserted &= "<SELECT name='cboMRow_" & lngToolId.ToString() & "' class=clsCombobox>"
                    For intCtr = 0 To m_intMonthsToBeShown
                        Args.StringToBeInserted &= "<OPTION value='" & intCtr & "'"
                        If m_intEmployeeMonths = intCtr Then Args.StringToBeInserted &= "selected"
                        Args.StringToBeInserted &= ">" & intCtr & "</OPTION>"
                    Next
                    Args.StringToBeInserted &= "</SELECT>"
                    Args.StringToBeInserted &= "&nbsp;" & MyBase.GetResourceString("MONTH") & "&nbsp;"
                End If
                Args.StringToBeInserted &= "</TD>"
                Cancel = True
        End Select
    End Sub
End Class
