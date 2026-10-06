Imports CommonFunctions

Public Class PM_AssignTaskResources
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


    Protected Const CONST_MODE_SUBTASK As String = "APPLYSUBTASK"
    Protected Const CONST_MODE_EFFORTS As String = "DISTRIBUTEEFFORTS"
    Protected Const CONST_SUBMODE_NEW As String = "NEW"
    Protected Const CONST_SUBMODE_EDIT As String = "EDIT"
    Protected Const CONST_ACTION_SAVE As String = "SAVE"
    Protected Const CONST_ACTION_ADDNEW As String = "ADDNEW"
    Protected Const CONST_ACTION_SENDMAIL As String = "SENDMAIL"
    Protected Const CONST_ACTION_CANCEL As String = "CANCEL"

    'Constants used for the array
    Private Const EMPLOYEEID As Integer = 1
    Private Const SUBTASKID As Integer = 2
    Private Const PLANNEDLCE As Integer = 3
    Private Const STARTDATE As Integer = 4
    Private Const ENDDATE As Integer = 5
    Private Const TASKID As Integer = 6
    'added by SachinR   on 15 Oct 2004
    'Issue ID - 12281
    Private Const SUBTASKTYPE As Integer = 7
    'addition end

    Protected m_strMode As String
    Protected m_strSubMode As String
    Protected m_strWindowTitle As String
    Protected m_strResourceID As String
    Private m_strAction As String
    Private m_strProjectID As String
    Private m_strParentTaskID As String
    Private m_strTaskID As String
    Private m_strTaskName As String
    Private m_strTaskType As String
    Private m_strTaskStartDate As String
    Private m_strTaskEndDate As String
    Private m_dblTaskHrs As Double
    Private m_blnIsSubTask As Boolean
    Private m_blnApplyEffortDistribution As Boolean
    Private m_strTaskTypeID As String
    Private m_strWorkHrs As String
    Private m_strStartdate As String
    Private m_strEndDate As String
    'Private m_strSubTaskType As String
    Private m_strSubTaskTypeID As String
    Private m_dblTotalWork As Double
    Private m_dblTaskWork As Double
    Private m_dblBalenceWork As Double
    Private m_strEmployeeIDList As String
    Private m_strDepartmentID As String
    Private m_dblInActiveTaskActuals As Double

    Protected m_dblMinHoursForDA As Double
    Private m_strInsertedTaskIDs As String
    Private m_strUpdatedTaskIDs As String
    Private m_intRowCount As Integer
    Private m_intNewTasks As Integer
    Private m_arrTaskInformation(0, 0) As String
    Private m_blnLCEProject As Boolean
    Private m_blnLCEDepartment As Boolean
    Private m_blnLCEDeptActivity As Boolean
    Private m_blnLCESystem As Boolean

    'Added By JayavantK, On 17-Aug-2004
    Protected m_strHolidays As String = ""
    Protected m_lngWeekDays As Long = 0
    Protected m_dblHoursPerDay As Double = 0

    'Code Added by SantoshK on 1st Feb 2005
    'IssueID 15152
    Protected m_ParentTaskStartDate As Date
    Protected m_strParentTaskStartDate As String
    Protected m_ParentTaskEndDate As Date
    Protected m_strParentTaskEndDate As String
    'Addition Ends

    'Added by VivekP On 2 jun 2005
    Protected FromTimesheet As String
    Protected TempProjectId As String
    'End Of addition On 2 jun 2005
    'AddedBy harshK for sp4 issueid 120,121 on 06/10/2005
    Protected m_bitResourceValidation As Integer = 1
    Protected m_LocationId As Long
    'End Addition
    'Added by MonikaI on 10th Oct 2006 IssueID : 6932
    Protected strDateFormat As String
    'End of addition by MonikaI
    'Added by MrugajaB on 21st Sept 2006 for Whiziblesem SP7 Issue ID.6197
    Protected m_strToken As String
    Protected m_lngTagID As Long
    'End Addition

    Protected m_ActualWork As Double
    ''Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
    Protected m_RestrictByMinHours As String
    Dim m_strdispCurrentWork As String
    Dim m_strdispBaselineWork As String
    Dim m_strdispActualWork As String
    ''End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
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
    ' Created				:	May 03 2004
    ' Revisions				:	
    '=====================================================================
    Public Sub PageInit()
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim objGlobal As WebPages.Template.IGlobal
        Dim objAccess As WebPage.Templates.AccessRights
        Dim blnEditAccess As Boolean
        Dim intRowCntr As Integer
        Dim intArrayCntr As Integer
        m_strEmployeeIDList = ""
        'Added by TruptiK on 9-Apr-09
        'Purpose:-To REMOVE save link if project is onhold.
        Dim strOnhold As String
        strSQL = "usp_Sel_tbl_CNF_Project_Status " & Session("intProjectID").ToString
        strOnhold = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "")
        'End of addition by TruptiK
        'Modified By NitinVS on 22 Mar 2007 for WhizibleSEM 7.0 
        ' Taking InputDateFormat from Commonfunction.application
        ''Added by MonikaI on 10th Oct 2006 IssueID : 6932
        'Dim drCompany As IDataReader
        'drCompany = Data.GetDataReader("SELECT InputDateFormat FROM tbl_PM_CompanyInformation", MyBase.UseSQL)
        'If drCompany.Read Then
        '    strDateFormat = "'" + CType(Data.CheckIsDBNull(drCompany("InputDateFormat"), "DD/MM/YYYY"), String) + "'"
        'End If
        'End of addition by MonikaI

        strDateFormat = CommonFunction.Application.InputeDateFormat

        'End Modification By NitinVS on 22 Mar 2007 for WhizibleSEM 7.0 

        'get values from the query string and session
        m_strMode = Request.QueryString("Mode") + ""
        If m_strMode = "" Then m_strMode = CONST_MODE_SUBTASK
        m_strAction = Request.QueryString("Action") + ""
        m_strResourceID = Request.QueryString("ResourceID") + ""
        If Request.QueryString("TaskID") <> "" Then
            m_strTaskID = Request.QueryString("TaskID") + ""
        Else
            m_strTaskID = MyBase.GetFormValue("txtTaskID") + ""
        End If
        'Added by vivekP on 3 jun 2005
        FromTimesheet = Request.QueryString("FromTimesheet")
        If Request.QueryString("FromTimesheet") = "CreateTask" Then
            m_strProjectID = CType(Request.QueryString("ProjectID"), String)
            TempProjectId = CType(Request.QueryString("ProjectID"), String)
        Else
            m_strProjectID = Session("intProjectID").ToString + ""
        End If
        'm_strProjectID = Session("intProjectID").ToString + ""
        'End of Addition on 3 jun 2005

        If m_strResourceID = "" Then
            m_strSubMode = CONST_SUBMODE_NEW
        Else
            m_strSubMode = CONST_SUBMODE_EDIT
        End If


        m_dblMinHoursForDA = CommonFunction.Application.MinHoursForDAEntry

        ' Added By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
        strSQL = "usp_sel_tbl_PM_Project_TaskCaseStructure " + m_strProjectID.ToString()
        objDR = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDR.Read() Then
            m_LocationId = CType(CommonFunction.Data.CheckIsDBNull(objDR("LocationID"), "0"), Long)
            m_bitResourceValidation = CType(CommonFunction.Data.CheckIsDBNull(objDR("ResourceValidation"), "0"), Integer)
            ' True is treated as -1 
            If m_bitResourceValidation = -1 Then
                m_bitResourceValidation = 1
            End If
        End If
        CommonFunction.Data.DisposeDataReader(objDR)
        ' End Addition By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

        'Added By JayavantK, On 17-Aug-2004
        'Get the List of Holidays
        GetHolidays(CType(m_strProjectID, Long))
        'Get the Details at location like weekdays etc.
        GetLocationDetails()
        'End Addition



        'Added by MrugajaB on 21st Sept 2006 for Whiziblesem Issue ID.6197
        Dim m_strParentTaskForToken As String
        m_strToken = ""

        m_strParentTaskForToken = Request.QueryString("ParentTaskID") + ""

        If m_strParentTaskForToken = "" Then
            m_strParentTaskForToken = MyBase.GetFormValue("txtParentTaskID") & ""
        End If
        If CType(m_strParentTaskForToken, String) <> "0" Then
            If Request.QueryString("PkToken") Is Nothing Then
                m_strToken = HttpContext.Current.Request.Form("txtHidToken").ToString
                'm_strToken = MyBase.GetFormValue("txtHaveSubTaskType").ToString
            Else
                m_strToken = Request.QueryString("PkToken").ToString
            End If
        End If

        If m_strParentTaskForToken = "" Then
            If HttpContext.Current.Request.Form("txtHidToken") Is Nothing Then
            Else
                m_strToken = HttpContext.Current.Request.Form("txtHidToken").ToString
            End If
        End If

        'Added by MrugajaB on 21st Sept 2006 for Whiziblesem Issue ID.6197
        'm_lngTagID = objGlobal.TagID
        If m_lngTagID = 0 Then m_lngTagID = 1038

        Dim strTempToken As String
        strTempToken = CommonFunctions.Security.Token.GetToken(CType(m_strParentTaskForToken, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(m_lngTagID, String))


        If ((m_strToken = "") And (m_strTaskID <> "0")) Or _
((m_strTaskID <> "0") And (CommonFunctions.Security.Token.ValidateToken(m_strParentTaskForToken + CType(Session("intUserID"), String) + CType(0, String) + CType(1038, String), m_strToken) = False)) Then
            Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Task Assignment", m_lngTagID, 0, "Task ID", m_strTaskID)
            'Token is Invalid now redirect to the Invalid Access Page
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If
        'End Addition

        'Added by Yogesh J on  02-FEB-2016 to validate Token
        'If Request.QueryString("TaskID") <> "" And Request.QueryString("PKToken") <> "" And Request.QueryString("ParentTaskID") <> "" Then

        '    If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("TaskID"), String) + CType(Session("intUserID"), String) + CType(0, String) + CType(m_lngTagID, String), Request.QueryString("PKToken")) = False) Then
        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Task Assignment", m_lngTagID, 0, "Task ID", m_strTaskID)
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    End If


        'End If
        ''End of addition by Yogesh J on 02-FEB-2016 to validate Token

        ''Added by Dhanashri S on 1 April 2016
        If (Request.QueryString("PKAssignResourcesToken") <> "" And Request.QueryString("ParentTaskID") <> "" And Request.QueryString("TaskID") <> "") Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ParentTaskID"), String) + CType(Request.QueryString("TaskID"), String) + "0" + "0", Request.QueryString("PKAssignResourcesToken")) = False) Then

                'Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("Year"), String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If
        ''End of Addition by Dhanashri S on 1 April 2016


        If Not IsPostBack Then
            m_blnApplyEffortDistribution = False
            m_blnIsSubTask = False
            'get the information about the project
            strSQL = "usp_sel_tbl_pm_ProjectTask_TaskDetails " + m_strProjectID.Trim + ",NULL,NULL,2"
            objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
            If objDR.Read Then
                m_blnIsSubTask = CType(Data.CheckIsDBNull(objDR("HaveSubTaskTypes"), "0"), Boolean)
                m_blnApplyEffortDistribution = CType(Data.CheckIsDBNull(objDR("ApplyEffortDistribution"), "0"), Boolean)
            End If
            Data.DisposeDataReader(objDR)

            'check for the two flags HaveSubTaskType and ApplyEffortDistribution and set the mode
            'of the page accordingly
            If m_blnIsSubTask = True Then
                m_strMode = CONST_MODE_SUBTASK
            Else
                If m_blnApplyEffortDistribution = True Then
                    m_strMode = CONST_MODE_EFFORTS
                Else
                    m_strMode = CONST_MODE_SUBTASK
                End If
            End If

            'get the details of the task
            Call getTaskDetails()

        Else

            If MyBase.GetFormValue("txtHaveSubTaskType") <> "" Then
                m_blnIsSubTask = CType(General.CheckIsNothing(MyBase.GetFormValue("txtHaveSubTaskType"), "0"), Boolean)
            Else
                m_blnIsSubTask = False
            End If
            If MyBase.GetFormValue("txtApplyEffortDistribution") <> "" Then
                m_blnApplyEffortDistribution = CType(General.CheckIsNothing(MyBase.GetFormValue("txtApplyEffortDistribution"), "0"), Boolean)
            Else
                m_blnApplyEffortDistribution = False
            End If
            m_strTaskName = MyBase.GetFormValue("txtTaskName", False) + ""
            m_strParentTaskID = MyBase.GetFormValue("txtParentTaskID") + ""
            m_strTaskType = MyBase.GetFormValue("txtTaskType", False) + ""
            m_strTaskTypeID = MyBase.GetFormValue("txtTaskTypeID") + ""
            m_strTaskStartDate = MyBase.GetFormValue("txtTaskStartDate") + ""
            m_strTaskEndDate = MyBase.GetFormValue("txtTaskEndDate") + ""
            m_dblTaskHrs = CType(MyBase.GetFormValue("txtTaskHrs"), Double)
            m_dblInActiveTaskActuals = CType(MyBase.GetFormValue("txtInActiveActualHrs"), Double)
            m_strEmployeeIDList = MyBase.GetFormValue("txtEmployeeIDList") + ""
            If MyBase.GetFormValue("txtBalenceWork") <> "" Then
                m_dblBalenceWork = CType(MyBase.GetFormValue("txtBalenceWork"), Double)
            End If
            m_strDepartmentID = MyBase.GetFormValue("txtDepartmentID") + ""
            m_dblTaskWork = CType(MyBase.GetFormValue("txtTaskWork"), Double)
        End If

        'get the access settings for the user
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        objGlobal = MyBase.GlobalObject
        objAccess = New WebPage.Templates.AccessRights
        objAccess.GetAccess(objGlobal)

        blnEditAccess = objAccess.Edit


        objAccess = Nothing

        Select Case m_strMode.ToUpper
            Case CONST_MODE_EFFORTS

                If m_strAction <> "" Then
                    Call performActionForEffortDistribution()
                End If

                'get the list of the employees already selected
                m_strEmployeeIDList = ""
                strSQL = "usp_Sel_tbl_PM_AssignedTaskResources " + m_strProjectID.Trim + "," + m_strParentTaskID.Trim + ",NULL"
                objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
                While objDR.Read
                    m_strEmployeeIDList += "," + Data.CheckIsDBNull(objDR("EmployeeID"), "").ToString
                End While
                Data.DisposeDataReader(objDR)
                If m_strEmployeeIDList <> "" Then m_strEmployeeIDList += ","


                'initialize the resource file for standard menu.
                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                'if page is in edit mode then only show send mail menu
                If m_strSubMode = CONST_SUBMODE_EDIT Then
                    arrMenu.Add(MyBase.GetResourceString("MENU_SEND_EMAIL")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SEND_EMAIL_TOOLTIP")) : arrClientSideFunctions.Add("SendMail_OnClick(" + m_strTaskID + "," + m_strResourceID + ")")
                End If
                'Modified by TruptiK on 9-Apr-09
                'Purpose:-To REMOVE save link if project is onhold.
                If strOnhold <> "1" Then
                    arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("Save_OnClick()")
                End If
                'End of modifucation by TruptiK
                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('386')")

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

                MyBase.InitializeResources("AppResources.PM_AssignTaskResources", "AppResources")

                'draw upper menu
                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
                General.WriteHTML(strMenu)

                'Display the (* Mandatory) PageLegends 
                Dim strarrLegend() As String = {"Mandatory"}
                Dim strarrLegendImage() As String = {"<img src='../../images/star.gif'>"}
                General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, strarrLegendImage, strarrLegend) + vbCrLf)

                'draw page caption 
                WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_ASSIGNRESOURCE"))
                General.WriteHTML("<BR>")

                General.WriteHTML("<Div id='PageDiv' width=100% height=90% style='overflow:auto;'>")
                If m_strAction = "" Then
                    Call plotAssignResourceScreenForEffortDitribution()
                End If
                General.WriteHTML("</Div>")

                General.WriteHTML("<BR>")
                General.WriteHTML(strMenu)

            Case CONST_MODE_SUBTASK

                'get the min hours that can be entered in the daily activity
                m_strInsertedTaskIDs = ""
                m_strUpdatedTaskIDs = ""

                'get the total no of rows in the table and no of new tasks in that
                m_intRowCount = CType(MyBase.GetFormValue("txtRowCount"), Integer)
                m_intNewTasks = CType(MyBase.GetFormValue("txtNewTask"), Integer)

                'create array to store the new tasks information
                ReDim m_arrTaskInformation(m_intNewTasks, 7)
                intRowCntr = 0

                For intRowCntr = 1 To m_intRowCount
                    If m_strAction = CONST_ACTION_CANCEL Then
                        'check that row is not canceled and its a new row
                        If MyBase.GetFormValue("txtTaskID" + intRowCntr.ToString) = "" Then

                            If MyBase.GetFormValue("chkCancel" + intRowCntr.ToString) = "" Then
                                If MyBase.GetFormValue("cboEmployee" + intRowCntr.ToString) <> "" Then
                                    m_arrTaskInformation(intArrayCntr, EMPLOYEEID) = MyBase.GetFormValue("cboEmployee" + intRowCntr.ToString) + ""
                                Else
                                    m_arrTaskInformation(intArrayCntr, EMPLOYEEID) = "0"
                                End If

                                If MyBase.GetFormValue("cboSubTaskType" + intRowCntr.ToString) <> "" Then
                                    m_arrTaskInformation(intArrayCntr, SUBTASKID) = MyBase.GetFormValue("cboSubTaskType" + intRowCntr.ToString) + ""
                                Else
                                    m_arrTaskInformation(intArrayCntr, SUBTASKID) = "0"
                                End If

                                m_arrTaskInformation(intArrayCntr, PLANNEDLCE) = MyBase.GetFormValue("txtLCE" + intRowCntr.ToString) + ""
                                m_arrTaskInformation(intArrayCntr, STARTDATE) = MyBase.GetFormValue("txtStartDate" + intRowCntr.ToString) + ""
                                m_arrTaskInformation(intArrayCntr, ENDDATE) = MyBase.GetFormValue("txtEndDate" + intRowCntr.ToString) + ""
                                m_arrTaskInformation(intArrayCntr, TASKID) = MyBase.GetFormValue("txtTaskID" + intRowCntr.ToString) + ""
                                'added by SachinR   on 15 Oct 2004
                                'Issue ID - 12281
                                m_arrTaskInformation(intArrayCntr, SUBTASKTYPE) = MyBase.GetFormValue("txtSubTaskType" + intRowCntr.ToString) + ""
                                'addition end
                                intArrayCntr += 1
                            Else
                                m_intNewTasks -= 1
                            End If

                        End If
                    Else

                        If MyBase.GetFormValue("txtTaskID" + intRowCntr.ToString) = "" Then

                            If MyBase.GetFormValue("cboEmployee" + intRowCntr.ToString) <> "" Then
                                m_arrTaskInformation(intArrayCntr, EMPLOYEEID) = MyBase.GetFormValue("cboEmployee" + intRowCntr.ToString) + ""
                            Else
                                m_arrTaskInformation(intArrayCntr, EMPLOYEEID) = "0"
                            End If

                            If MyBase.GetFormValue("cboSubTaskType" + intRowCntr.ToString) <> "" Then
                                m_arrTaskInformation(intArrayCntr, SUBTASKID) = MyBase.GetFormValue("cboSubTaskType" + intRowCntr.ToString) + ""
                            Else
                                m_arrTaskInformation(intArrayCntr, SUBTASKID) = "0"
                            End If

                            m_arrTaskInformation(intArrayCntr, PLANNEDLCE) = MyBase.GetFormValue("txtLCE" + intRowCntr.ToString) + ""
                            m_arrTaskInformation(intArrayCntr, STARTDATE) = MyBase.GetFormValue("txtStartDate" + intRowCntr.ToString) + ""
                            m_arrTaskInformation(intArrayCntr, ENDDATE) = MyBase.GetFormValue("txtEndDate" + intRowCntr.ToString) + ""
                            m_arrTaskInformation(intArrayCntr, TASKID) = MyBase.GetFormValue("txtTaskID" + intRowCntr.ToString) + ""
                            'added by SachinR   on 15 Oct 2004
                            'Issue ID - 12281
                            m_arrTaskInformation(intArrayCntr, SUBTASKTYPE) = MyBase.GetFormValue("txtSubTaskType" + intRowCntr.ToString) + ""
                            'addition end
                            intArrayCntr += 1

                        End If
                    End If
                Next

                'Retrieve the LCE Distribution Configuration Information
                strSQL = "usp_Sel_tbl_PM_LCEDistribution_Configuration " + m_strProjectID.Trim
                objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
                If objDR.Read Then
                    m_blnLCEProject = CType(Data.CheckIsDBNull(objDR("LCE_Project"), "0"), Boolean)
                    m_blnLCEDepartment = CType(Data.CheckIsDBNull(objDR("LCE_Department"), "0"), Boolean)
                    m_blnLCEDeptActivity = CType(Data.CheckIsDBNull(objDR("LCE_DepartmentActivity"), "0"), Boolean)
                    m_blnLCESystem = CType(Data.CheckIsDBNull(objDR("LCE_System"), "0"), Boolean)
                End If
                Data.DisposeDataReader(objDR)

                If m_strAction = CONST_ACTION_SAVE Then
                    Call performActionForSubTask()
                End If

                'get the list of the employees already selected
                m_strEmployeeIDList = ""
                strSQL = "usp_Sel_TeamMembers_TaskAssignment " + m_strProjectID.Trim
                ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
                ' Added Parameter for AllowDeferredTaskCreation for Performance 
                strSQL += ", Null, " + IIf(CommonFunction.Application.AllowDeferredTaskCreation, 1, 0).ToString()
                ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

                objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
                While objDR.Read
                    m_strEmployeeIDList += "," + Data.CheckIsDBNull(objDR("EmployeeID"), "").ToString
                End While
                Data.DisposeDataReader(objDR)
                If m_strEmployeeIDList <> "" Then m_strEmployeeIDList += ","

                'initialize the resource file for standard menu.
                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                arrMenu.Add(MyBase.GetResourceString("MENU_ADDNEW")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_ADDNEW_TOOLTIP")) : arrClientSideFunctions.Add("AddNew_OnClick()")
                'Modified by TruptiK on 9-Apr-09
                'Purpose:-To REMOVE save link if project is onhold.
                If strOnhold <> "1" Then
                    arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("SaveRows_OnClick()")
                End If
                'End of modification by TruptiK
                arrMenu.Add(MyBase.GetResourceString("MENU_CANCEL")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CANCEL_TOOLTIP")) : arrClientSideFunctions.Add("Cancel_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('386')")

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

                MyBase.InitializeResources("AppResources.PM_AssignTaskResources", "AppResources")

                'draw upper menu
                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
                General.WriteHTML(strMenu)

                'Display the (* Mandatory) PageLegends 
                Dim strarrLegend() As String = {"Mandatory"}
                Dim strarrLegendImage() As String = {"<img src='../../images/star.gif'>"}
                General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, strarrLegendImage, strarrLegend) + vbCrLf)

                'draw page caption 
                WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_ASSIGNRESOURCE"))
                General.WriteHTML("<BR>")

                General.WriteHTML("<Div id='PageDiv' width=100% height=90% style='overflow:auto;'>")
                Call plotAssignResourceScreenForSubTask()
                General.WriteHTML("</Div>")

                General.WriteHTML("<BR>")
                General.WriteHTML(strMenu)

        End Select

        'keep the data in the hidden controls
        If m_blnIsSubTask = True Then
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML(HTMLControls.DrawTextBox("txtHaveSubTaskType", "txtHaveSubTaskType", , , , "1", , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        End If
        If m_blnApplyEffortDistribution = True Then
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML(HTMLControls.DrawTextBox("txtApplyEffortDistribution", "txtApplyEffortDistribution", , , , "1", , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        End If

        'Added by MrugajaB on 18th Sept 2006 for whiziblesem SP7 issue ID.6197
        'Purpose:Hidden variable that will store value of token that is passed in edit mode from Assigned Tasks Page
        General.WriteHTML("<TD align='left'>")
        General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txthidToken", "txthidToken", value:=m_strToken, returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True))
        General.WriteHTML("</TD></TR>")
        'End Addition

        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        General.WriteHTML(HTMLControls.DrawTextBox("txtTaskID", "txtTaskID", , , , m_strTaskID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtTaskName", "txtTaskName", , , , m_strTaskName, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtTaskType", "txtTaskType", , , , m_strTaskType, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtTaskStartDate", "txtTaskStartDate", , , , m_strTaskStartDate, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtTaskEndDate", "txtTaskEndDate", , , , m_strTaskEndDate, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtTaskHrs", "txtTaskHrs", , , , m_dblTaskHrs.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtInActiveActualHrs", "txtInActiveActualHrs", , , , m_dblInActiveTaskActuals.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtTaskWork", "txtTaskWork", , , , m_dblTaskWork.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtBalenceWork", "txtBalenceWork", , , , m_dblBalenceWork.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtTaskTypeID", "txtTaskTypeID", , , , m_strTaskTypeID, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtEmployeeIDList", "txtEmployeeIDList", , , , m_strEmployeeIDList.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtDepartmentID", "txtDepartmentID", , , , m_strDepartmentID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtParentTaskID", "txtParentTaskID", , , , m_strParentTaskID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtMinHrs", "txtMinHrs", , , , m_dblMinHoursForDA.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        'added by harshk on 22/08/05 for whiziblesem Sp4 IssueID 120,121 

        DrawHiddenEmployee()
        ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
        ' Combined the selects related to project Moved at GetLocationDetails ()

        'Dim strQuery2 As String = "select IsNull(ResourceValidation,0) from tbl_PM_Project WHERE ProjectID = " & m_strProjectID
        'If CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery2, MyBase.UseSQL), "True"), Boolean) = True Then
        '    m_bitResourceValidation = 1
        'Else
        '    m_bitResourceValidation = 0
        'End If
        ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
        'end added by harshk on 22/08/05 for whiziblesem Sp4 IssueID 120,121 
        '--- addded By purvaJ on 18 nov 2008 Whiziblesem 8.0
        '--- Current should be greater than actual entered
        m_ActualWork = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_ActualWorkHours " + m_strTaskID.ToString + "," + m_strProjectID.ToString, True), "0"), "0")
        '--- added By PurvaJ on 7 Nov 2008 for Whiziblesem 8.0
        '--- validation : Current Work hours should not be less than actual work hours.
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunction.HTMLControls.DrawTextBox("hid_txtActualWork", "hid_txtActualWork", , 200, , m_ActualWork.ToString, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        '--- end addition purvaj

        '--- end addition purvaj
        'Added by TruptiK on 24-Mar-09
        Dim ActualStartdate As String

        ActualStartdate = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_ActualStartdate " + m_strTaskID.ToString + "," + m_strProjectID.ToString, True), ""), ""), String)
        If ActualStartdate <> "" Then
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.HTMLControls.DrawTextBox("hid_txtActualStartdate", "hid_txtActualStartdate", , 200, , (CDate(ActualStartdate).ToString("dd-MMM-yyyy")), , , , , , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        Else
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.HTMLControls.DrawTextBox("hid_txtActualStartdate", "hid_txtActualStartdate", , 200, , ActualStartdate, , , , , , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        End If

        'End of addition by TruptiK

    End Sub

    '=====================================================================
    ' Procedure Name		:	plotAssignResourceScreenForEffortDitribution
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the page for the resource assignment.
    ' Description			:	This procedure will plot the controls for the assign resource mode when Apply Subtask type 
    '                           flag is checked in the project settings for the current project.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	May 03 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotAssignResourceScreenForEffortDitribution()
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim strResourceName As String = ""
        Dim blnIsReadonly As Boolean = False
        'Added by Harshk for sp4 IssueID 120,121 
        Dim strEmployeeID As String
        'End Added by Harshk for sp4 IssueID 120,121 
        'if page is in edit mode then get the details of the record
        m_strSubTaskTypeID = ""
        m_strStartdate = ""
        m_strEndDate = ""
        m_strWorkHrs = ""
        strResourceName = ""
        If m_strSubMode = CONST_SUBMODE_EDIT Then
            blnIsReadonly = True

            strSQL = "usp_Sel_tbl_PM_AssignedTaskResources " + m_strProjectID.Trim + "," + m_strTaskID.Trim + "," + m_strResourceID.Trim
            objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
            If objDr.Read Then
                strResourceName = Data.CheckIsDBNull(objDr("UserName"), "").ToString
                m_strWorkHrs = Data.CheckIsDBNull(objDr("Work"), "0").ToString
                m_strStartdate = Data.CheckIsDBNull(objDr("StartDate"), "").ToString
                m_strEndDate = Data.CheckIsDBNull(objDr("EndDate"), "").ToString
                m_strSubTaskTypeID = Data.CheckIsDBNull(objDr("SubTaskTypes"), "").ToString
                If m_strStartdate <> "" Then
                    m_strStartdate = Dates.GetDate(CType(m_strStartdate, Date))
                End If
                If m_strEndDate <> "" Then
                    m_strEndDate = Dates.GetDate(CType(m_strEndDate, Date))
                End If
                'Added by Harshk for sp4 IssueID 120,121 
                strEmployeeID = Data.CheckIsDBNull(objDr("EmployeeID"), "").ToString
                'End Added by Harshk for sp4 IssueID 120,121 
            End If
            Data.DisposeDataReader(objDr)
            'added by harshk on 22/08/2005 for whiziblesem Sp4 IssueID 120,121 
            strSQL = "usp_Sel_TeamMembers_TaskAssignment_ExpectedDate " + m_strProjectID.Trim
            If m_strTaskID <> "" Then
                strSQL += " , " + m_strTaskID + ",0"
            Else
                strSQL += " ,Null,0"
            End If
            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
            ' Added Parameter for AllowDeferredTaskCreation
            strSQL += " , " + IIf(CommonFunction.Application.AllowDeferredTaskCreation, "1", "0").ToString
            ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

            General.WriteHTML(HTMLControls.DrawComboBox("cboResourceStartDate", strSQL, 120, strEmployeeID, , True, True, , , , True))
            strSQL = "usp_Sel_TeamMembers_TaskAssignment_ExpectedDate " + m_strProjectID.Trim
            If m_strTaskID <> "" Then
                strSQL += " , " + m_strTaskID + ",1"
            Else
                strSQL += " ,Null,1"
            End If
            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
            ' Added Parameter for AllowDeferredTaskCreation
            strSQL += " , " + IIf(CommonFunction.Application.AllowDeferredTaskCreation, "1", "0").ToString
            ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

            General.WriteHTML(HTMLControls.DrawComboBox("cboResourceEndDate", strSQL, 120, strEmployeeID, , True, True, , , , True))
            'end eddition harshk on 22/08/2005 for whiziblesem Sp4 IssueID 120,121 
            'issue 11255
            'added by   SachinR     On 05 jun 2004
            'purpose    To apply the stat date end date of the parent task in the add new mode
        Else
            m_strStartdate = m_strTaskStartDate.Trim + ""
            m_strEndDate = m_strTaskEndDate.Trim + ""
            'end addition
        End If

        General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0>")

        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align=right>" + MyBase.GetResourceString("CAP_TASKNAME") + "</TD>")
        General.WriteHTML("<TD align=left>" + m_strTaskName.Trim + "</TD>")
        General.WriteHTML("</TR>")

        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align=right>" + MyBase.GetResourceString("CAP_TASKTYPE") + "</TD>")
        General.WriteHTML("<TD align=left>" + m_strTaskType.Trim + "</TD>")
        General.WriteHTML("</TR>")

        'display resource list combo
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align=right>" + MyBase.GetResourceString("CAP_RESOURCE") + "</TD>")
        General.WriteHTML("<TD align=left>")
        If m_strSubMode = CONST_SUBMODE_NEW Then

            strSQL = "usp_Sel_TeamMembers_TaskAssignment " + m_strProjectID.Trim
            ' Added By NitinVS on 3 May 2005 for WhizibleSEM SP3 IssueID 14579 
            If m_strTaskID <> "" Then
                strSQL += " , " + m_strTaskID
            Else
                strSQL += ", Null "
            End If

            ' End Addition By NitinVS on 3 May 2005 for WhizibleSEM SP3 IssueID 14579 
            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
            ' Added Parameter for AllowDeferredTaskCreation for Performance 
            strSQL += " , " + IIf(CommonFunction.Application.AllowDeferredTaskCreation, 1, 0).ToString()
            ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

            General.WriteHTML(HTMLControls.DrawComboBox("cboResource", strSQL, 200, m_strResourceID, , True, True, , True))
            'added by harshk on 01/08/2005 for whiziblesem Sp4 IssueID 120,121 
            strSQL = "usp_Sel_TeamMembers_TaskAssignment_ExpectedDate " + m_strProjectID.Trim
            If m_strTaskID <> "" Then
                strSQL += " , " + m_strTaskID + ",0"
            Else
                strSQL += " ,Null,0"
            End If
            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
            ' Added Parameter for AllowDeferredTaskCreation
            strSQL += " , " + IIf(CommonFunction.Application.AllowDeferredTaskCreation, "1", "0").ToString
            ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

            General.WriteHTML(HTMLControls.DrawComboBox("cboResourceStartDate", strSQL, 120, , , True, True, , , , True))
            strSQL = "usp_Sel_TeamMembers_TaskAssignment_ExpectedDate " + m_strProjectID.Trim
            If m_strTaskID <> "" Then
                strSQL += " , " + m_strTaskID + ",1"
            Else
                strSQL += " ,Null,1"
            End If
            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
            ' Added Parameter for AllowDeferredTaskCreation
            strSQL += " , " + IIf(CommonFunction.Application.AllowDeferredTaskCreation, "1", "0").ToString
            ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

            General.WriteHTML(HTMLControls.DrawComboBox("cboResourceEndDate", strSQL, 120, , , True, True, , , , True))
            'end eddition harshk on 01/08/2005 for whiziblesem Sp4 IssueID 120,121 

        Else
            General.WriteHTML(strResourceName.Trim)
        End If

        ' Added BY NitinVS on 23 Mar 2007 for WhizibleSEM SP 8 regression Issue 12059 
        ' show Resource schedule link in case 2 
        General.WriteHTML("<a href='javascript:ShowSchedule_OnClick()' >Show Schedule</a> ")
        ' End Addition  BY NitinVS on 23 Mar 2007 for WhizibleSEM SP 8 regression Issue 12059 

        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")

        If m_blnIsSubTask = True Then
            General.WriteHTML("<TR class='clsTREven'>")
            General.WriteHTML("<TD align=right>" + MyBase.GetResourceString("CAP_SUBTASKTYPE") + "</TD>")
            General.WriteHTML("<TD align=left>")
            strSQL = "usp_Sel_tbl_PM_Project_SubTaskTypes " + m_strProjectID.Trim + "," + m_strTaskTypeID.Trim
            General.WriteHTML(HTMLControls.DrawComboBox("cboSubTaskTypes", strSQL, 200, m_strSubTaskTypeID, , True, True))
            General.WriteHTML("</TD>")
            General.WriteHTML("</TR>")
        End If

        'display work hours text box
        General.WriteHTML("<TR class='clsTREven'>")
        'Commented and Modified By Usha Pandit  on 07-Mar-2019 Purpose::Whizible 2 Work field change
        'General.WriteHTML("<TD align=right>" + MyBase.GetResourceString("CAP_WORKHRS") + "</TD>")
        General.WriteHTML("<TD align=right>" + "Work (H:M)" + "</TD>")
        ''End of Commented and Modified By Usha Pandit  on 07-Mar-2019 Purpose::Whizible 2 Work field change
        General.WriteHTML("<TD align=left>")
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

        ''Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
        ''General.WriteHTML(HTMLControls.DrawTextBox("txtWorkHrs", "txtWorkHrs", , 80, 8, m_strWorkHrs, "right", , , , , , , True, True, EnableHTMLEncode:=True))
        If m_strWorkHrs <> "" Then
            m_strdispCurrentWork = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + m_strWorkHrs + "',1)", True)
            General.WriteHTML(HTMLControls.DrawTextBox("txtWorkHrs", "txtWorkHrs", , 80, 8, m_strdispCurrentWork, "right", , , , , , , True, True, EnableHTMLEncode:=True))
            General.WriteHTML(HTMLControls.DrawTextBox("txthidWorkHrs", "txthidWorkHrs", , 80, 8, m_strWorkHrs, "right", , , , , True, , True, , EnableHTMLEncode:=True))
        Else
            General.WriteHTML(HTMLControls.DrawTextBox("txtWorkHrs", "txtWorkHrs", , 80, 8, m_strWorkHrs, "right", , , , , , , True, True, EnableHTMLEncode:=True))
        End If

        ''End of Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change

        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")

        'display start date
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align=right>" + MyBase.GetResourceString("CAP_STARTDATE") + "</TD>")
        General.WriteHTML("<TD align=left>")
        General.WriteHTML(HTMLControls.DrawDateControl("txtStartDate", "txtStartDate", , 80, m_strStartdate.Trim, , "frmPM_AssignTaskResources", , , , , , , True, True))
        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")

        'display end date
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align=right>" + MyBase.GetResourceString("CAP_ENDDATE") + "</TD>")
        General.WriteHTML("<TD align=left>")
        General.WriteHTML(HTMLControls.DrawDateControl("txtEndDate", "txtEndDate", , 80, m_strEndDate.Trim, , "frmPM_AssignTaskResources", , , , , , , True, True))
        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")

        General.WriteHTML("</Table>")

    End Sub

    '=====================================================================
    ' Procedure Name		:	getTaskDetails
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To get the details about the task.
    ' Description			:	Same as above.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	May 03 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub getTaskDetails()
        Dim strSQL As String
        Dim objDr As IDataReader

        'Parent Task Start Date and End Date
        Dim objParentDr As IDataReader

        ' Modified By   : NitinVS on 2 May 2005 for WhizibleSEM SP3 
        ' IssueID       : 12793
        ' Reason        : In Edit Mode ParentTaskID is Available In txtParentTaskID 

        'added by SachinR   on 15 Oct 2004
        Dim strParentTaskID As String

        If MyBase.GetFormValue("txtParentTaskID") <> "" Then
            strParentTaskID = MyBase.GetFormValue("txtParentTaskID") + ""
        Else
            strParentTaskID = Request.QueryString("ParentTaskID") + ""
        End If
        ' End Modification By NitinVS on 2 May 2005 for WhizibleSEM SP3 for IssueID : 12793


        If strParentTaskID <> "" Then
            'Code Added by santoshK on 1st Feb 2005
            'Take the StartDate and End date of parent task

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''objParentDr = Data.GetDataReader("SELECT Startdate,EndDate FROM tbl_PM_ProjectTasks Where TaskID = " & strParentTaskID, MyBase.UseSQL)
            objParentDr = Data.GetDataReader("usp_sel_tbl_PM_ProjectTasks_Startdate_EndDate " & strParentTaskID, MyBase.UseSQL)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            If objParentDr.Read Then
                m_ParentTaskStartDate = CType(objParentDr("StartDate"), Date)
                m_strParentTaskStartDate = Dates.GetDate(CType(objParentDr("StartDate"), Date))
                m_ParentTaskEndDate = CType(objParentDr("EndDate"), Date)
                m_strParentTaskEndDate = Dates.GetDate(CType(objParentDr("EndDate"), Date))
            End If
            Data.DisposeDataReader(objParentDr)
        End If
        'Addition Ends - 1st Feb 2005


        strSQL = "usp_sel_tbl_pm_ProjectTask_TaskDetails " + m_strProjectID.Trim


        If strParentTaskID <> "" Then
            If m_strTaskID <> "" Then
                strSQL += "," + m_strTaskID
            End If
            strSQL += "," + strParentTaskID.Trim
        Else
            strSQL += "," + m_strTaskID.Trim
        End If
        'addition end
        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDr.Read Then
            m_strTaskName = Data.CheckIsDBNull(objDr("TaskName"), "").ToString
            m_strTaskType = Data.CheckIsDBNull(objDr("ModuleName"), "").ToString
            m_strTaskTypeID = Data.CheckIsDBNull(objDr("TaskTypeID"), "NULL").ToString
            m_strTaskStartDate = Data.CheckIsDBNull(objDr("StartDate"), "").ToString
            m_strTaskEndDate = Data.CheckIsDBNull(objDr("EndDate"), "").ToString
            m_dblTaskHrs = CType(Data.CheckIsDBNull(objDr("Work"), "0"), Double)
            If m_strTaskStartDate <> "" Then
                m_strTaskStartDate = Dates.GetDate(CType(m_strTaskStartDate, Date))
            End If
            If m_strTaskEndDate <> "" Then
                m_strTaskEndDate = Dates.GetDate(CType(m_strTaskEndDate, Date))
            End If
            'if task dont have parent task then make parent task ID and task ID same
            m_strParentTaskID = Data.CheckIsDBNull(objDr("ParentTask_UID"), "").ToString
            If m_strParentTaskID = "" Then m_strParentTaskID = m_strTaskID
            m_strDepartmentID = Data.CheckIsDBNull(objDr("DepartmentID"), "").ToString

        Else
            m_strTaskName = ""
            m_strTaskType = ""
            m_strTaskTypeID = "NULL"
            m_strTaskStartDate = ""
            m_strTaskEndDate = ""
            m_dblTaskHrs = 0
            m_strParentTaskID = "0"
            m_strDepartmentID = ""
        End If
        Data.DisposeDataReader(objDr)

        If m_strMode = CONST_MODE_EFFORTS Then
            'get the total work of all the resources assigned to the task
            m_dblTotalWork = 0
            strSQL = "usp_sel_tbl_pm_ProjectTask_TaskDetails NULL,"
            If m_strResourceID <> "" Then
                strSQL += m_strTaskID.Trim
            Else
                strSQL += "NULL"
            End If
            strSQL += "," + m_strParentTaskID.Trim + ",3"
            objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
            If objDr.Read Then
                m_dblTotalWork = CType(Data.CheckIsDBNull(objDr("TotalWork"), "0"), Double)
            End If
            Data.DisposeDataReader(objDr)

            'get the total work for the task
            m_dblTaskWork = 0
            strSQL = "usp_sel_tbl_pm_ProjectTask_TaskDetails NULL,NULL," + m_strParentTaskID.Trim + ",4"
            objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
            If objDr.Read Then
                m_dblTaskWork = CType(Data.CheckIsDBNull(objDr("TaskWork"), "0"), Double)
            End If
            Data.DisposeDataReader(objDr)

            'calculate the balence work
            m_dblBalenceWork = Math.Abs(m_dblTaskWork - m_dblTotalWork)

            'added by SachinR   on 06 May 2004
        ElseIf m_strMode = CONST_MODE_SUBTASK Then

            strSQL = "usp_Sel_PM_Task_Total_Balance_LCE " + m_strProjectID.Trim + "," + m_strParentTaskID.Trim
            objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
            If objDr.Read Then
                m_dblTaskWork = CType(Data.CheckIsDBNull(objDr("TaskTotalLCE"), "0"), Double)
                m_dblBalenceWork = CType(Data.CheckIsDBNull(objDr("TaskBalanceLCE"), "0"), Double)
                m_dblTotalWork = CType(Data.CheckIsDBNull(objDr("TaskAllocatedLCE"), "0"), Double)
                m_dblInActiveTaskActuals = CType(Data.CheckIsDBNull(objDr("InActiveTaskActuals"), "0"), Double)
            Else
                m_dblTaskWork = 0
                m_dblBalenceWork = 0
                m_dblTotalWork = 0
            End If
            Data.DisposeDataReader(objDr)
            'adition end
        End If

    End Sub

    '=====================================================================
    ' Procedure Name		:	performActionForEffortDistribution
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To update the project task table. 
    ' Description			:	Here new record will be inserted in the ProjectTasks table if it is add new mode
    '                           else esting record will be updated for new values. After updation send mail action 
    '                           is taken.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	May 04 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performActionForEffortDistribution()
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim blnSendMail As Boolean
        Dim blnShowPopUp As Boolean
        Dim strFromEmailID As String
        Dim strToEmailID As String
        Dim strCCToEmailID As String
        Dim strSubject As String
        Dim strEmailMessage As String
        'Added By JayavantK, On 17-Aug-2004
        Dim strTempName As String = ""
        Dim strLeaveMessage As String = ""
        'End Addition


        'get the data from the controls on the form 
        m_strWorkHrs = MyBase.GetFormValue("txtWorkHrs") + ""
        ''Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
        m_strWorkHrs = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + m_strWorkHrs + "',2)", True)
        ''End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change

        m_strStartdate = MyBase.GetFormValue("txtStartDate") + ""
        m_strEndDate = MyBase.GetFormValue("txtEndDate") + ""
        m_strSubTaskTypeID = ""
        If m_blnIsSubTask = True And MyBase.GetFormValue("cboSubTaskType") <> "" Then
            m_strSubTaskTypeID = "'" + MyBase.GetFormValue("cboSubTaskType") + "'"
        End If
        If m_strSubTaskTypeID = "" Then m_strSubTaskTypeID = "NULL"
        If m_strTaskTypeID = "" Then m_strTaskTypeID = "NULL"

        Select Case m_strAction.ToUpper

            Case CONST_ACTION_SAVE

                If m_strSubMode = CONST_SUBMODE_NEW Then
                    'add new mode
                    m_strResourceID = MyBase.GetFormValue("cboResource") + ""

                    strSQL = "usp_Ins_tbl_PM_AssignedTaskResources " + m_strResourceID.Trim
                    strSQL += "," + m_strTaskID.Trim
                    strSQL += "," + m_strProjectID.Trim
                    strSQL += "," + m_strTaskTypeID
                    strSQL += "," + m_strSubTaskTypeID
                    strSQL += ",'" + General.BuildQueryString(Session("strUserName").ToString) + "'"
                    strSQL += "," + m_strWorkHrs.Trim
                    strSQL += ",'INSERT'"
                    strSQL += ",NULL"
                    strSQL += ",'" + m_strStartdate.Trim + "'"
                    strSQL += ",'" + m_strEndDate.Trim + "'"

                    'update the database
                    m_strTaskID = Data.GetDataScalar(strSQL, MyBase.UseSQL).ToString + ""

                Else
                    'edit mode
                    strSQL = "usp_Ins_tbl_PM_AssignedTaskResources " + m_strResourceID.Trim
                    strSQL += "," + m_strTaskID.Trim
                    strSQL += "," + m_strProjectID.Trim
                    strSQL += "," + m_strTaskTypeID
                    strSQL += "," + m_strSubTaskTypeID
                    strSQL += ",'" + General.BuildQueryString(Session("strUserName").ToString) + "'"
                    strSQL += "," + m_strWorkHrs.Trim
                    strSQL += ",'UPDATE'"
                    strSQL += ",NULL"
                    strSQL += ",'" + m_strStartdate.Trim + "'"
                    strSQL += ",'" + m_strEndDate.Trim + "'"

                    'update the database
                    Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                End If

                ''Commented By ManishK on 08th Feb 2006 For WhizibleSem SP6 Leave and WFH Confirm box customization
                'Added By JayavantK, On 17-Aug-2004
                ''Check if there is any leave(s) between the start date and end date
                'strTempName = CheckLeaves(CType(m_strResourceID, Long), m_strStartdate, m_strEndDate)
                'If strTempName <> "" Then
                '    strLeaveMessage = MyBase.GetResourceString("MSG_RESOURCE_HAS_LEAVES")
                '    strLeaveMessage = strLeaveMessage.Replace("<=>", strTempName)
                'End If
                ''End Addition
                ''End Of Commented By ManishK on 08th Feb 2006 For WhizibleSem SP6 Leave and WFH Confirm box customization

                'get the settings for sending the mail
                blnSendMail = False
                blnShowPopUp = False
                strSQL = "usp_Sel_tbl_PM_EmailMessages 20"
                objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
                If objDr.Read Then
                    blnSendMail = CType(Data.CheckIsDBNull(objDr("SendMail"), "0"), Boolean)
                    blnShowPopUp = CType(Data.CheckIsDBNull(objDr("ShowPopup"), "0"), Boolean)
                End If
                Data.DisposeDataReader(objDr)

                If m_strSubMode = CONST_SUBMODE_NEW Then
                    If blnSendMail Then
                        If blnShowPopUp = False Then
                            'modified by vivekP On 3 Jun 2005
                            Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_20(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, m_strTaskID, m_strProjectID)
                            'End Of Modification 
                            Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                        Else
                            'write client side script to display the message window
                            General.WriteHTML("<Script language=javascript>")
                            'Modified By VivekP On 3 Jun 2005
                            If Request.QueryString("FromTimesheet") <> "CreateTask" Then
                                General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=20&TaskID=" + m_strTaskID.ToString + "&EmployeeID=" + m_strResourceID.Trim + "','','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');")
                            Else
                                General.WriteHTML("window.open('../General/SendEmail.aspx?ProjectID=" + m_strProjectID + "&MessageID=20&TaskID=" + m_strTaskID.ToString + "&EmployeeID=" + m_strResourceID.Trim + "','','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');")
                            End If
                            General.WriteHTML("</Script>")
                        End If
                    End If
                Else
                    If blnSendMail Then
                        If blnShowPopUp = False Then
                            'Modified by VivekP On 3 Jun 2005
                            Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_202(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CType(m_strTaskID, Long), CType(m_strResourceID, Long), m_strProjectID)
                            'End Of modification On 3 jun 2005
                            Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                        Else
                            'write client side script to display the message window
                            General.WriteHTML("<Script language=javascript>")
                            'Modified By VivekP On 3 Jun 2005
                            If Request.QueryString("FromTimesheet") <> "CreateTask" Then
                                General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=202&TaskID=" + m_strTaskID.ToString + "&EmployeeID=" + m_strResourceID.Trim + "','','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');")
                            Else
                                General.WriteHTML("window.open('../General/SendEmail.aspx?ProjectID=" + m_strProjectID + "&MessageID=202&TaskID=" + m_strTaskID.ToString + "&EmployeeID=" + m_strResourceID.Trim + "','','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');")
                            End If
                            'End of Modification on 3 Jun 2005
                            General.WriteHTML("</Script>")
                        End If
                    End If
                End If

                'get the latest updated details of the task
                Call getTaskDetails()
                m_strSubMode = CONST_SUBMODE_EDIT

                'here refresh the parent page
                General.WriteHTML("<Script language=javascript>")
                'Modified by    SachinR     On 07 Jun 2004
                'To add new parameter in the querystring of parent page to avoid the setting focus
                'on the cotrol on the parent page.
                'Modified By VivekP On 3 jun 2005
                If Request.QueryString("FromTimesheet") <> "CreateTask" Then
                    'Modified by MrugajaB on 21st Sept 2006 for Whiziblesem SP7 Issue ID.6197
                    'General.WriteHTML("opener.document.forms[0].action='PM_TaskAssignment.aspx?Mode=Edit&MasterTagID=1038&Focus=NO&TaskID=" + m_strParentTaskID.Trim + "';")
                    General.WriteHTML("opener.document.forms[0].action='PM_TaskAssignment.aspx?Mode=Edit&MasterTagID=1038&Action=NOACTION&Focus=NO&PKToken=" + m_strToken + "&TaskID=" + m_strParentTaskID.Trim + "';")
                    'End Modification
                Else
                    General.WriteHTML("opener.document.forms[0].action='PM_TaskAssignment.aspx?FromTimesheet=CreateTask&ProjectID=" + m_strProjectID + "&Mode=Edit&MasterTagID=1038&Focus=NO&TaskID=" + m_strParentTaskID.Trim + "';")
                End If
                'End Of Modification On 3 jun 2005
                'end modification
                General.WriteHTML("opener.document.forms[0].submit();")
                'General.WriteHTML("window.focus();")
                General.WriteHTML("window.close();")



                'Added By JayavantK, On 17-Aug-2004
                If strLeaveMessage <> "" Then
                    General.WriteHTML("alert('" & strLeaveMessage & "');")
                End If
                'End Addition
                General.WriteHTML("</Script>")

                General.WriteHTML(CommonFunction.General.GetRefreshParentParentScript("frmGanttChartView", "GanttChartView.aspx", "../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038", False, True))
                General.WriteHTML(CommonFunction.General.GetRefreshParentParentScript("frmWBS_GanttChartView", "WBS_GanttChartView.aspx", "../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038", True))

        End Select
    End Sub

    '=====================================================================
    ' Procedure Name		:	plotAssignResourceScreenForSubTask
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the controls for the resource assignment screen. 
    ' Description			:	This procedure will plot the screen for resource assignment when ApplySubTaskType
    '                           flag is on in project settings. 
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	May 06 2004
    ' Revisions				:	
    ' Modified By           :   SachinR ( Issue 11336 )
    ' Modified On           :   03 Jun 2004
    ' Purpose               :   To add control for the update flag for the row, added onChange event for 
    '                           all the controls in the edit mode
    '=====================================================================
    Private Sub plotAssignResourceScreenForSubTask()
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim objDrSubTask As IDataReader
        Dim intRowCount As Integer
        Dim intNewTask As Integer
        Dim strStartDate As String
        Dim strEndDate As String
        Dim strSubTaskTypeID As String
        Dim strLCE As String
        ''Added By Usha Pandit on 20-March-2019 Purpose::Whizible 2 Work field change 
        Dim strHMLCE As String
        ''End of Added By Usha Pandit on 20-March-2019 Purpose::Whizible 2 Work field change 
        Dim strTaskID As String
        Dim strAllocatedLCE As String
        Dim strBalenceLCE As String
        Dim strAllowableLCE As String
        Dim strEmployeeID As String
        Dim strEmployeeName As String
        Dim strSubTaskType As String
        ' Added By JayavantK on 17-Sep-2004
        Dim blnIsTaskComplete As Boolean = False
        'End Addition
        '-- Added By purvaj on 19 nov 2008 for whiziblsem 8.0 
        '--Planned hours can be reduced less than actual hours filled
        Dim strActualWork As String
        '-- End adition purvaJ
        '-- Added By TruptiK on 25 Mar 09 for whiziblsem 7.2
        '--Planned hours can be reduced less than actual hours filled
        Dim strActualStartDate As String
        '-- End addition TruptiK


        'display taskdetails
        General.WriteHTML("<Table class='clsTable' cellspacing=0 cellpadding=0 width=99.9%>")
        General.WriteHTML("<TR class='clsTRSectionHeader'>")
        General.WriteHTML("<TD width=50% align=left>" + MyBase.GetResourceString("CAP_TASKNAME") + " : " + Server.HtmlEncode(m_strTaskName.Trim) + "</TD>")
        General.WriteHTML("<TD width=50% align=left>" + MyBase.GetResourceString("CAP_TASKTYPE") + " : " + Server.HtmlEncode(m_strTaskType.Trim) + "</TD>")
        General.WriteHTML("</TR>")
        General.WriteHTML("<TR class='clsTRSectionHeader' >")

        ''Commented and Added by Usha Pandit on 15-April-2019 Purpose::Whizible 2 Work field change
        'General.WriteHTML("<TD width=50% align=left>" + MyBase.GetResourceString("CAP_TASKLCE") + " : " + m_dblTaskWork.ToString + "</TD>")
        'General.WriteHTML("<TD width=50% align=left>" + MyBase.GetResourceString("CAP_TASKBALENCE") + " : " + m_dblBalenceWork.ToString + "</TD>")

        Dim HMTaskWork As String = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + m_dblTaskWork.ToString() + "',1)", True)
        Dim HMBalenceWork As String = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + m_dblBalenceWork.ToString() + "',1)", True)

        General.WriteHTML("<TD width=50% align=left>" + "Task Work (H:M)" + " : " + HMTaskWork + "</TD>")
        General.WriteHTML("<TD width=50% align=left>" + "Task Balance Work (H:M)" + " : " + HMBalenceWork + "</TD>")
        ''End of Added by Usha Pandit on 15-April-2019 Purpose::Whizible 2 Work field change

        General.WriteHTML("</TR>")

        'modified by SachinR    on 20 may 2004
        'issue 11191 resolved, task start date and end date is shown
        General.WriteHTML("<TR class='clsTRSectionHeader' >")
        General.WriteHTML("<TD width=50% align=left>" + MyBase.GetResourceString("CAP_STARTDATE") + " : " + m_strTaskStartDate.Trim + "</TD>")
        General.WriteHTML("<TD width=50% align=left>" + MyBase.GetResourceString("CAP_ENDDATE") + " : " + m_strTaskEndDate.Trim + "</TD>")
        General.WriteHTML("</TR>")
        'modification end

        ''************************************************************************************
        ''This code is commented as it is not needed for this build (as per discussion with Sachhit)
        ''************************************************************************************
        ''display resource type selection
        'General.WriteHTML("<TR class='clsTROdd'>")
        'General.WriteHTML("<TD align=left >")
        'General.WriteHTML(HTMLControls.DrawOptionButton("optResourceType", "optResourceType", , True, "1", , , True))
        'General.WriteHTML("&nbsp;" + MyBase.GetResourceString("CAP_PROJECT_RESOURCE") + "</TD>")
        'General.WriteHTML("<TD align=left >")
        'General.WriteHTML(HTMLControls.DrawOptionButton("optResourceType", "optResourceType", , True, "2", , , True))
        'General.WriteHTML("&nbsp;" + MyBase.GetResourceString("CAP_RESOURCE_GROUP") + "</TD>")
        'General.WriteHTML("<TD align=left colspan=2 >")
        'General.WriteHTML(HTMLControls.DrawComboBox("cboResourceType", strSQL, 150, , , True, True, , , , True))
        'General.WriteHTML("</TD>")
        'General.WriteHTML("</TR>")
        ''************************************************************************************
        General.WriteHTML("</Table>")
        General.WriteHTML("<BR>")

        'plot the outer div
        General.WriteHTML("<Div id='PageDiv' width=100% height=90% style='overflow:auto;'>")
        'display column headers
        General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0 >")
        General.WriteHTML("<TR class='clsTRColumnHeader'>")
        General.WriteHTML("<TD align=center>" + MyBase.GetResourceString("COL_RESOURCE") + "</TD>")
        General.WriteHTML("<TD align=center>" + MyBase.GetResourceString("COL_RESOURCE_LOADING") + "</TD>")
        General.WriteHTML("<TD align=center>" + MyBase.GetResourceString("COL_ACTIVITY") + "</TD>")
        'General.WriteHTML("<TD align=center>" + MyBase.GetResourceString("COL_ACTIVITY_BALENCE") + "</TD>")
        ''Commented and Added by Usha Pandit on 15-April-2019 Purpose::Whizible 2 Work field change
        'General.WriteHTML("<TD align=center>" + MyBase.GetResourceString("COL_PLANNEDLCE") + "</TD>")
        General.WriteHTML("<TD align=center>" + "Work (H:M)" + "</TD>")
        ''End of Added by Usha Pandit on 15-April-2019 Purpose::Whizible 2 Work field change

        General.WriteHTML("<TD align=center>" + MyBase.GetResourceString("COL_STARTDATE") + "</TD>")
        General.WriteHTML("<TD align=center>" + MyBase.GetResourceString("COL_ENDDATE") + "</TD>")
        General.WriteHTML("<TD align=center>" + MyBase.GetResourceString("COL_CANCEL") + "</TD>")
        General.WriteHTML("</TR>")

        intRowCount = 0

        strSQL = "usp_Sel_tbl_PM_TaskResourceAllocation_Case3 " + m_strProjectID.Trim + "," + m_strParentTaskID.Trim + "," + m_strTaskTypeID.Trim
        If m_strResourceID <> "" Then
            strSQL += "," + m_strResourceID.Trim
        Else
            strSQL += ",NULL"
        End If
        'as departmentID is not in use 
        'If m_strDepartmentID <> "" Then
        '    strSQL += "," + m_strDepartmentID.Trim
        'Else
        strSQL += ",NULL"
        'End If

        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        While objDr.Read
            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
            ' ISTaskcomplete is fetched through the usp_Sel_tbl_PM_TaskResourceAllocation sp itself
            ' Added By JayavantK on 17-Sep-2004
            'blnIsTaskComplete = IsTaskComplete(CType(Data.CheckIsDBNull(objDr("TaskID"), "").ToString, Long))
            'End Addition
            blnIsTaskComplete = CType(Data.CheckIsDBNull(objDr("IsTaskComplete"), "0"), Boolean)
            ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

            intRowCount += 1

            strStartDate = Data.CheckIsDBNull(objDr("StartDate"), "").ToString
            If strStartDate <> "" Then
                strStartDate = Dates.GetDate(CType(strStartDate, Date))
            End If
            strEndDate = Data.CheckIsDBNull(objDr("EndDate"), "").ToString
            If strEndDate <> "" Then
                strEndDate = Dates.GetDate(CType(strEndDate, Date))
            End If
            strSubTaskTypeID = Data.CheckIsDBNull(objDr("SubTaskTypeID"), "").ToString
            strSubTaskType = Data.CheckIsDBNull(objDr("SubTaskType"), "").ToString
            strLCE = Data.CheckIsDBNull(objDr("LCE"), "0").ToString
            ''Added By Usha Pandit on 20-March-2019 Purpose::Whizible 2 Work field change 
            strHMLCE = Data.CheckIsDBNull(objDr("HMLCE"), "0").ToString
            ''End of Added By Usha Pandit on 20-March-2019 Purpose::Whizible 2 Work field change 
            strTaskID = Data.CheckIsDBNull(objDr("TaskID"), "").ToString
            strAllocatedLCE = Data.CheckIsDBNull(objDr("AllocatedLCE"), "").ToString
            strBalenceLCE = Data.CheckIsDBNull(objDr("BalanceLCE"), "").ToString
            strAllowableLCE = Data.CheckIsDBNull(objDr("AllowableLCE"), "").ToString
            strEmployeeID = Data.CheckIsDBNull(objDr("EmployeeID"), "").ToString
            strEmployeeName = Data.CheckIsDBNull(objDr("EmployeeName"), "").ToString
            strActualWork = Data.CheckIsDBNull(objDr("ActualWork"), "").ToString
            strActualStartDate = Data.CheckIsDBNull(objDr("ActualStartDate"), "").ToString

            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
            ' Commented the usp_Sel_PM_AssignResources_BalanceLCE call as it is no more shown

            ''if subtask is selected then display the LCE
            'If strSubTaskTypeID <> "" Then
            '    strSQL = "usp_Sel_PM_AssignResources_BalanceLCE " + m_strProjectID.Trim
            '    'If m_strDepartmentID <> "" Then
            '    '    strSQL += "," + m_strDepartmentID.Trim
            '    'Else
            '    strSQL += ",NULL"
            '    'End If
            '    strSQL += "," + m_strParentTaskID.Trim + "," + strSubTaskTypeID.Trim
            '    objDrSubTask = Data.GetDataReader(strSQL, MyBase.UseSQL)
            '    If objDrSubTask.Read Then
            '        strAllowableLCE = Data.CheckIsDBNull(objDrSubTask("BalanceLCE"), "0").ToString
            '    End If
            '    Data.DisposeDataReader(objDrSubTask)
            'End If

            ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

            If intRowCount Mod 2 = 0 Then
                General.WriteHTML("<TR class='clsTREven'>")
            Else
                General.WriteHTML("<TR class='clsTROdd'>")
            End If

            'display data in the columns

            'display employee name and store the empID in the hidden control
            General.WriteHTML("<TD align=left>" + strEmployeeName.Trim)
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML(HTMLControls.DrawTextBox("txtEmployeeID" + intRowCount.ToString, "txtEmployeeID" + intRowCount.ToString, , , , strEmployeeID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            'addedby harshk  for whiziblesem Sp4 IssueID 120,121 
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML(HTMLControls.DrawTextBox("hdnEmployeeName" + intRowCount.ToString, "hdnEmployeeName" + intRowCount.ToString, , , , strEmployeeName, , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            'End addedby harshk  for whiziblesem Sp4 IssueID 120,121 
            General.WriteHTML("</TD>")

            '**************** 07 May 2004
            'display link for resource loading
            General.WriteHTML("<TD align=center>")
            General.WriteHTML("<A href=javascript:ResourceLoading_OnClick(" + intRowCount.ToString + ") >" + MyBase.GetResourceString("LINK_RESOURCE_LOADING") + "</A>")
            General.WriteHTML("</TD>")

            'display activity name
            General.WriteHTML("<TD align=left >" + strSubTaskType.Trim)
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML(HTMLControls.DrawTextBox("txtSubTaskType" + intRowCount.ToString, "txtSubTaskType" + intRowCount.ToString, , , , strSubTaskType.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            'here combo name is used to text box for getting the values while saving data
            'same name,like combo, is used to get the subtasktype ID
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML(HTMLControls.DrawTextBox("cboSubTaskType" + intRowCount.ToString, "cboSubTaskType" + intRowCount.ToString, , , , strSubTaskTypeID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML("</TD>")

            'General.WriteHTML("<TD align=right >" + strAllowableLCE.Trim)
            'General.WriteHTML("</TD>")

            'display LCE text box
            General.WriteHTML("<TD align=center>")
            ' Added By JayavantK on 17-Sep-2004
            'General.WriteHTML(HTMLControls.DrawTextBox("txtLCE" + intRowCount.ToString, "txtLCE" + intRowCount.ToString, , 50, 8, strLCE.Trim, "right", , , , , , "onchange='javascript:Data_OnChange(" + intRowCount.ToString + ")'", True))
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            ''Commented and Added By Usha Pandit on 20-March-2019 Purpose::Whizible 2 Work field change 
            'General.WriteHTML(HTMLControls.DrawTextBox("txtLCE" + intRowCount.ToString, "txtLCE" + intRowCount.ToString, , 50, 8, strLCE.Trim, "right", , blnIsTaskComplete, , , , "onblur='javascript:Data_OnChange(" + intRowCount.ToString + ")'", True, EnableHTMLEncode:=True))
            General.WriteHTML(HTMLControls.DrawTextBox("txtLCE" + intRowCount.ToString, "txtLCE" + intRowCount.ToString, , 50, 8, strHMLCE.Trim, "right", , blnIsTaskComplete, , , , "onblur='javascript:Data_OnChange(" + intRowCount.ToString + ")'", True, EnableHTMLEncode:=True))
            ''End of Added By Usha Pandit on 20-March-2019 Purpose::Whizible 2 Work field change 

            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            'End Addition
            General.WriteHTML("</TD>")

            'display startdate 
            General.WriteHTML("<TD align=center>")
            ' Added By JayavantK on 17-Sep-2004
            'General.WriteHTML(HTMLControls.DrawDateControl("txtStartDate" + intRowCount.ToString, "txtStartDate" + intRowCount.ToString, , , strStartDate.Trim, , "frmPM_AssignTaskResources", , , , , , , True, , , "onchange='javascript:Data_OnChange(" + intRowCount.ToString + ")'"))
            General.WriteHTML(HTMLControls.DrawDateControl("txtStartDate" + intRowCount.ToString, "txtStartDate" + intRowCount.ToString, , , strStartDate.Trim, , "frmPM_AssignTaskResources", , , , blnIsTaskComplete, , , True, , , "onblur='javascript:Data_OnChange1(" + intRowCount.ToString + ")'"))
            'End Addition
            General.WriteHTML("</TD>")

            'display end date
            General.WriteHTML("<TD align=center>")
            ' Added By JayavantK on 17-Sep-2004
            'General.WriteHTML(HTMLControls.DrawDateControl("txtEndDate" + intRowCount.ToString, "txtEndDate" + intRowCount.ToString, , , strEndDate.Trim, , "frmPM_AssignTaskResources", , , , , , , True, , , "onchange='javascript:Data_OnChange(" + intRowCount.ToString + ")'"))
            General.WriteHTML(HTMLControls.DrawDateControl("txtEndDate" + intRowCount.ToString, "txtEndDate" + intRowCount.ToString, , , strEndDate.Trim, , "frmPM_AssignTaskResources", , , , blnIsTaskComplete, , , True, , , "onblur='javascript:Data_OnChange1(" + intRowCount.ToString + ")'"))
            'End Addition
            General.WriteHTML("</TD>")

            General.WriteHTML("<TD align=center>")
            General.WriteHTML(HTMLControls.DrawCheckBox("chkCancel" + intRowCount.ToString, "chkCancel" + intRowCount.ToString, , , strTaskID.Trim, , , True, , , , True))

            'plot the hidden controls with values
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML(HTMLControls.DrawTextBox("txtAllocatedLCE" + intRowCount.ToString, "txtAllocatedLCE" + intRowCount.ToString, , , , strAllocatedLCE.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            General.WriteHTML(HTMLControls.DrawTextBox("txtTaskID" + intRowCount.ToString, "txtTaskID" + intRowCount.ToString, , , , strTaskID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))

            ' Commented By NitinVS on 25 MAy 2007 for WhizbleSEM 7 
            'General.WriteHTML(HTMLControls.DrawTextBox("txtBalenceLCE" + intRowCount.ToString, "txtBalenceLCE" + intRowCount.ToString, , , , m_dblBalenceWork.ToString, , , , , , True, , True))
            ' End Commented By NitinVS on 25 MAy 2007 for WhizbleSEM 7 
            General.WriteHTML(HTMLControls.DrawTextBox("txtCurrentLCE" + intRowCount.ToString, "txtCurrentLCE" + intRowCount.ToString, , , , strLCE.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            'added By   SachinR On 03 Jun 2004 ( Issue ID 11336)
            General.WriteHTML(HTMLControls.DrawTextBox("txtDataChanged" + intRowCount.ToString, "txtDataChanged" + intRowCount.ToString, , , , "0", , , , , , True, , True, EnableHTMLEncode:=True))
            '-- Added By purvaj on 19 nov 2008 for whiziblsem 8.0 
            '--Planned hours can be reduced less than actual hours filled
            General.WriteHTML(HTMLControls.DrawTextBox("txtHidActualHours" + intRowCount.ToString, "txtHidActualHours" + intRowCount.ToString, , , , strActualWork.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            '-- End adition purvaj
            'Added By TruptiK on 25 Mar 09 for whiziblsem 7.2
            If strActualStartDate <> "" Then
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                General.WriteHTML(HTMLControls.DrawTextBox("txtHidActualStartDate" + intRowCount.ToString, "txtHidActualStartDate" + intRowCount.ToString, , , , (CDate(strActualStartDate).ToString("dd-MMM-yyyy")), , , , , , True, , True, EnableHTMLEncode:=True))
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            Else
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                General.WriteHTML(HTMLControls.DrawTextBox("txtHidActualStartDate" + intRowCount.ToString, "txtHidActualStartDate" + intRowCount.ToString, , , , strActualStartDate, , , , , , True, , True, EnableHTMLEncode:=True))
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            End If
            'End addition TruptiK
            'end addition
            General.WriteHTML("</TD>")

            General.WriteHTML("</TR>")
        End While
        Data.DisposeDataReader(objDr)

        intNewTask = 0

        While intNewTask < m_intNewTasks

            intRowCount += 1

            strTaskID = ""
            strEmployeeID = m_arrTaskInformation(intNewTask, EMPLOYEEID) + ""
            strSubTaskTypeID = m_arrTaskInformation(intNewTask, SUBTASKID) + ""
            'added by SachinR   on 15 Oct 2004
            'Issue ID - 12281
            strSubTaskType = m_arrTaskInformation(intNewTask, SUBTASKTYPE) + ""
            'addition end
            strAllowableLCE = ""
            strBalenceLCE = ""
            strLCE = m_arrTaskInformation(intNewTask, PLANNEDLCE) + ""
            strStartDate = m_arrTaskInformation(intNewTask, STARTDATE) + ""
            strEndDate = m_arrTaskInformation(intNewTask, ENDDATE) + ""
            strAllocatedLCE = ""

            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
            ' Commented the usp_Sel_PM_AssignResources_BalanceLCE call as it is no more shown

            ''if subtask is selected then display the LCE
            'If strSubTaskTypeID <> "" And strSubTaskTypeID <> "0" Then
            '    strSQL = "usp_Sel_PM_AssignResources_BalanceLCE " + m_strProjectID.Trim
            '    'If m_strDepartmentID <> "" Then
            '    '    strSQL += "," + m_strDepartmentID.Trim
            '    'Else
            '    strSQL += ",NULL"
            '    'End If
            '    strSQL += "," + m_strParentTaskID.Trim + "," + strSubTaskTypeID.Trim
            '    objDrSubTask = Data.GetDataReader(strSQL, MyBase.UseSQL)
            '    If objDrSubTask.Read Then
            '        strBalenceLCE = Data.CheckIsDBNull(objDrSubTask("BalanceLCE"), "0").ToString
            '    End If
            '    Data.DisposeDataReader(objDrSubTask)
            'End If
            ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

            If intRowCount Mod 2 = 0 Then
                General.WriteHTML("<TR class='clsTREven'>")
            Else
                General.WriteHTML("<TR class='clsTROdd'>")
            End If

            'display data in the columns

            'display employee name and store the empID in the hidden control
            General.WriteHTML("<TD align=center>")
            strSQL = "usp_Sel_ProjectResources_TaskAssignment " + m_strProjectID.Trim
            General.WriteHTML(HTMLControls.DrawComboBox("cboEmployee" + intRowCount.ToString, strSQL, 120, strEmployeeID.Trim, " onchange=Employee_OnChnage(" + intRowCount.ToString + ")", True, True))
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML(HTMLControls.DrawTextBox("txtEmployeeID" + intRowCount.ToString, "txtEmployeeID" + intRowCount.ToString, , , , strEmployeeID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML("</TD>")

            'display link for resource loading
            General.WriteHTML("<TD align=center>")
            General.WriteHTML("<A href=javascript:ResourceLoading_OnClick(" + intRowCount.ToString + ") >" + MyBase.GetResourceString("LINK_RESOURCE_LOADING") + "</A>")
            General.WriteHTML("</TD>")

            'display activity name
            General.WriteHTML("<TD align=center>")
            strSQL = "usp_Sel_tbl_PM_Project_SubTasks " + m_strProjectID.Trim + "," + m_strParentTaskID.Trim + "," + m_strTaskTypeID.Trim
            If strEmployeeID.Trim <> "" Then
                strSQL += "," + strEmployeeID.Trim
            Else
                strSQL += ",NULL"
            End If
            'If m_strDepartmentID <> "" Then
            '    strSQL += "," + m_strDepartmentID.Trim
            'Else
            strSQL += ",NULL"
            'End If
            General.WriteHTML(HTMLControls.DrawComboBox("cboSubTaskType" + intRowCount.ToString, strSQL, 130, strSubTaskTypeID.Trim, " onchange=SubTask_OnChnage(" + intRowCount.ToString + ")", True, True))
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML(HTMLControls.DrawTextBox("txtSubTaskType" + intRowCount.ToString, "txtSubTaskType" + intRowCount.ToString, , , , strSubTaskType.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML("</TD>")

            'General.WriteHTML("<TD align=right >" + strBalenceLCE.Trim)
            'General.WriteHTML("</TD>")

            'display LCE text box
            General.WriteHTML("<TD align=center>")
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

            ''Commented and Added By Usha Pandit on 20-March-2019 Purpose::Whizible 2 Work field change 
            General.WriteHTML(HTMLControls.DrawTextBox("txtLCE" + intRowCount.ToString, "txtLCE" + intRowCount.ToString, , 50, 8, strLCE.Trim, "right", , , , , , , True, EnableHTMLEncode:=True))
            'Dim strDecLCE As String = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strLCE + "',1)", True)
            'General.WriteHTML(HTMLControls.DrawTextBox("txtLCE" + intRowCount.ToString, "txtLCE" + intRowCount.ToString, , 50, 8, strDecLCE, "right", , , , , , , True, EnableHTMLEncode:=True))
            ''End of Added By Usha Pandit on 20-March-2019 Purpose::Whizible 2 Work field change 

            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML("</TD>")

            'display startdate 
            General.WriteHTML("<TD align=center>")
            General.WriteHTML(HTMLControls.DrawDateControl("txtStartDate" + intRowCount.ToString, "txtStartDate" + intRowCount.ToString, , , strStartDate.Trim, , "frmPM_AssignTaskResources", , , , , , , True))
            General.WriteHTML("</TD>")

            'display end date
            General.WriteHTML("<TD align=center>")
            General.WriteHTML(HTMLControls.DrawDateControl("txtEndDate" + intRowCount.ToString, "txtEndDate" + intRowCount.ToString, , , strEndDate.Trim, , "frmPM_AssignTaskResources", , , , , , , True))
            General.WriteHTML("</TD>")

            General.WriteHTML("<TD align=center>")
            General.WriteHTML(HTMLControls.DrawCheckBox("chkCancel" + intRowCount.ToString, "chkCancel" + intRowCount.ToString, , , "1", , , True))

            'plot the hidden controls with values
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML(HTMLControls.DrawTextBox("txtAllocatedLCE" + intRowCount.ToString, "txtAllocatedLCE" + intRowCount.ToString, , , , strAllocatedLCE.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            General.WriteHTML(HTMLControls.DrawTextBox("txtTaskID" + intRowCount.ToString, "txtTaskID" + intRowCount.ToString, , , , strTaskID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            ' Commented By NitinVS on 25 MAy 2007 for WhizbleSEM 7 
            ' General.WriteHTML(HTMLControls.DrawTextBox("txtBalenceLCE" + intRowCount.ToString, "txtBalenceLCE" + intRowCount.ToString, , , , strBalenceLCE.Trim, , , , , , True, , True))
            ' End Commented By NitinVS on 25 MAy 2007 for WhizbleSEM 7 
            General.WriteHTML(HTMLControls.DrawTextBox("txtCurrentLCE" + intRowCount.ToString, "txtCurrentLCE" + intRowCount.ToString, , , , "0", , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
           
            General.WriteHTML("</TD>")

            General.WriteHTML("</TR>")
            intNewTask += 1
        End While

        'add new row 
        If m_strAction = CONST_ACTION_ADDNEW Then

            intRowCount += 1
            intNewTask += 1

            strTaskID = ""
            strEmployeeID = ""
            strSubTaskTypeID = ""
            strAllowableLCE = ""
            strBalenceLCE = ""
            strLCE = ""
            strStartDate = m_strTaskStartDate.Trim + ""
            strEndDate = m_strTaskEndDate.Trim + ""
            strAllocatedLCE = ""

            If intRowCount Mod 2 = 0 Then
                General.WriteHTML("<TR class='clsTREven'>")
            Else
                General.WriteHTML("<TR class='clsTROdd'>")
            End If

            'display data in the columns

            'display employee name and store the empID in the hidden control
            General.WriteHTML("<TD align=center>")
            strSQL = "usp_Sel_ProjectResources_TaskAssignment " + m_strProjectID.Trim
            General.WriteHTML(HTMLControls.DrawComboBox("cboEmployee" + intRowCount.ToString, strSQL, 120, strEmployeeID.Trim, " onchange=Employee_OnChnage(" + intRowCount.ToString + ")", True, True))
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML(HTMLControls.DrawTextBox("txtEmployeeID" + intRowCount.ToString, "txtEmployeeID" + intRowCount.ToString, , , , strEmployeeID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML("</TD>")

            'display link for resource loading
            General.WriteHTML("<TD align=center>")
            General.WriteHTML("<A href=javascript:ResourceLoading_OnClick(" + intRowCount.ToString + ") >" + MyBase.GetResourceString("LINK_RESOURCE_LOADING") + "</A>")
            General.WriteHTML("</TD>")

            'display activity name
            General.WriteHTML("<TD align=center>")
            strSQL = "usp_Sel_tbl_PM_Project_SubTasks " + m_strProjectID.Trim + "," + m_strParentTaskID.Trim + "," + m_strTaskTypeID.Trim
            If strEmployeeID <> "" Then
                strSQL += "," + strEmployeeID.Trim
            Else
                strSQL += ",NULL"
            End If
            'If m_strDepartmentID <> "" Then
            '    strSQL += "," + m_strDepartmentID.Trim
            'Else
            strSQL += ",NULL"
            'End If
            General.WriteHTML(HTMLControls.DrawComboBox("cboSubTaskType" + intRowCount.ToString, strSQL, 130, strSubTaskTypeID.Trim, " onchange=SubTask_OnChnage(" + intRowCount.ToString + ")", True, True))
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML(HTMLControls.DrawTextBox("txtSubTaskType" + intRowCount.ToString, "txtSubTaskType" + intRowCount.ToString, , , , strSubTaskTypeID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML("</TD>")

            'General.WriteHTML("<TD align=right >" + strBalenceLCE.Trim)
            'General.WriteHTML("</TD>")

            'display LCE text box
            General.WriteHTML("<TD align=center>")
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML(HTMLControls.DrawTextBox("txtLCE" + intRowCount.ToString, "txtLCE" + intRowCount.ToString, , 50, 8, strLCE.Trim, "right", , , , , , , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML("</TD>")

            'display startdate 
            General.WriteHTML("<TD align=center>")
            General.WriteHTML(HTMLControls.DrawDateControl("txtStartDate" + intRowCount.ToString, "txtStartDate" + intRowCount.ToString, , , strStartDate.Trim, , "frmPM_AssignTaskResources", , , , , , , True))
            General.WriteHTML("</TD>")

            'display end date
            General.WriteHTML("<TD align=center>")
            General.WriteHTML(HTMLControls.DrawDateControl("txtEndDate" + intRowCount.ToString, "txtEndDate" + intRowCount.ToString, , , strEndDate.Trim, , "frmPM_AssignTaskResources", , , , , , , True))
            General.WriteHTML("</TD>")

            General.WriteHTML("<TD align=center>")
            General.WriteHTML(HTMLControls.DrawCheckBox("chkCancel" + intRowCount.ToString, "chkCancel" + intRowCount.ToString, , , "1", , , True))

            'plot the hidden controls with values
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            General.WriteHTML(HTMLControls.DrawTextBox("txtAllocatedLCE" + intRowCount.ToString, "txtAllocatedLCE" + intRowCount.ToString, , , , strAllocatedLCE.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            General.WriteHTML(HTMLControls.DrawTextBox("txtTaskID" + intRowCount.ToString, "txtTaskID" + intRowCount.ToString, , , , strTaskID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            General.WriteHTML(HTMLControls.DrawTextBox("txtBalenceLCE" + intRowCount.ToString, "txtBalenceLCE" + intRowCount.ToString, , , , strBalenceLCE.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
            General.WriteHTML(HTMLControls.DrawTextBox("txtCurrentLCE" + intRowCount.ToString, "txtCurrentLCE" + intRowCount.ToString, , , , "0", , , , , , True, , True, EnableHTMLEncode:=True))
            'Added by TruptiK for whiziblesem 7.2
            General.WriteHTML(HTMLControls.DrawTextBox("txtHidActualStartDate" + intRowCount.ToString, "txtHidActualStartDate" + intRowCount.ToString, , , , "", , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            'End of addition by TruptiK
            General.WriteHTML("</TD>")

            General.WriteHTML("</TR>")
        End If

        General.WriteHTML("</Table>")
        General.WriteHTML("</Div>")

        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        General.WriteHTML(HTMLControls.DrawTextBox("txtRowCount", "txtRowCount", , , , intRowCount.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtNewTask", "txtNewTask", , , , intNewTask.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
    End Sub

    '=====================================================================
    ' Procedure Name		:	performActionForSubTask
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To update the database for task assignment.
    ' Description			:	This procedure will update the database for the task updation. Here records will be 
    '                           inserted for new assignments and updated for the old assignment if any needs to be updated. 
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	May 10 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performActionForSubTask()
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim strTaskID As String
        Dim strResourceID As String
        Dim strSubTaskTypeID As String
        Dim strLCE As String
        Dim strStartDate As String
        Dim strEndDate As String
        Dim strUserName As String
        Dim strSubTaskType As String
        Dim intCnt As Integer
        Dim strTaskIDList As String
        Dim blnIsInserted As Boolean
        Dim blnSendMail As Boolean
        Dim blnShowPopup As Boolean
        Dim strInsertedEmployeeIDList As String
        Dim strUpdatedEmployeeIDList As String
        Dim arrEmployeeIDs() As String
        Dim arrTaskID() As String
        Dim strFromEmailID As String
        Dim strToEmailID As String
        Dim strCCToEmailID As String
        Dim strSubject As String
        Dim strEmailMessage As String

        'Added By JayavantK, On 17-Aug-2004
        Dim strTempName As String = ""
        Dim strEmployeeNames As String = ""
        Dim strLeaveMessage As String = ""
        'End Addition

        Select Case m_strAction
            Case CONST_ACTION_SAVE

                strInsertedEmployeeIDList = ""
                strUpdatedEmployeeIDList = ""
                strTaskIDList = ""
                strUserName = General.BuildQueryString(Session("strUserName").ToString + "")
                For intCnt = 1 To m_intRowCount

                    blnIsInserted = False
                    strTaskID = MyBase.GetFormValue("txtTaskID" + intCnt.ToString) + ""
                    strResourceID = MyBase.GetFormValue("txtEmployeeID" + intCnt.ToString) + ""
                    strSubTaskTypeID = MyBase.GetFormValue("cboSubTaskType" + intCnt.ToString) + ""
                    strSubTaskType = MyBase.GetFormValue("txtSubTaskType" + intCnt.ToString) + ""
                    strLCE = MyBase.GetFormValue("txtLCE" + intCnt.ToString) + ""
                    strStartDate = MyBase.GetFormValue("txtStartDate" + intCnt.ToString) + ""
                    strEndDate = MyBase.GetFormValue("txtEndDate" + intCnt.ToString) + ""

                    ''Commented By ManishK on 08th Feb 2006 For WhizibleSem SP6 Leave and WFH Confirm box customization
                    ''Added By JayavantK, On 17-Aug-2004
                    ''Check if there is any leave(s) between the start date and end date
                    'strTempName = CheckLeaves(CType(strResourceID, Long), strStartDate, strEndDate)
                    'If strTempName <> "" Then
                    '    strTempName = strTempName & " - " & strSubTaskType & " - " & strStartDate & " To " & strEndDate & "\n"
                    '    strEmployeeNames &= strTempName
                    'End If
                    ''End Addition
                    ''End of Commented By ManishK on 08th Feb 2006 For WhizibleSem SP6 Leave and WFH Confirm box customization

                    If strTaskID = "" Or strTaskID = "0" Then
                        'insert new record
                        blnIsInserted = True

                        'create list of ID for deletion
                        strTaskIDList += m_strParentTaskID.Trim + ","

                        strSQL = "usp_Ins_tbl_PM_ProjectTask_Resources  "
                        strSQL += m_strParentTaskID.Trim
                        strSQL += ",'" + General.BuildQueryString(m_strTaskName.Trim) + "-" + General.BuildQueryString(strSubTaskType.Trim) + "'"
                        strSQL += "," + strResourceID.Trim
                        strSQL += "," + m_strProjectID.Trim
                        strSQL += "," + m_strTaskTypeID.Trim
                        strSQL += "," + strSubTaskTypeID.Trim
                        strSQL += ",'" + strUserName.Trim + "'"
                        ''Commented and Added by Usha Pandit on 05-April-2019 Purpose::Whizible 2 Work field change
                        'strSQL += ",'" + strLCE.Trim + "'"
                        Dim strDecLCE As String = ""
                        strDecLCE = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strLCE + "',2)", True)
                        strSQL += ",'" + strDecLCE + "'"
                        ''End of Added by Usha Pandit on 05-April-2019 Purpose::Whizible 2 Work field change

                        strSQL += ",'" + strStartDate.Trim + "'"
                        strSQL += ",'" + strEndDate.Trim + "'"
                        strSQL += ",NULL"

                        'execute the SP and update the database 
                        strTaskID = Data.GetDataScalar(strSQL, MyBase.UseSQL).ToString + ""

                        If m_strInsertedTaskIDs.IndexOf(strTaskID.Trim) <= 0 Then
                            m_strInsertedTaskIDs += "," + strTaskID.Trim
                            strInsertedEmployeeIDList += "," + strResourceID.Trim
                        End If

                    Else

                        'added by SachinR   On 03 Jun 2004 ( Issue 11336)
                        'added this external condition for checking the data update flag for the row
                        If MyBase.GetFormValue("txtDataChanged" + intCnt.ToString) = "1" Then
                            'create list of ID for deletion
                            strTaskIDList += strTaskID.Trim + ","

                            strSQL = "usp_Ins_tbl_PM_ProjectTask_Resources  "
                            strSQL += m_strParentTaskID.Trim
                            strSQL += ",'" + CommonFunctions.General.BuildQueryString(m_strTaskName.Trim) + "-" + CommonFunctions.General.BuildQueryString(strSubTaskType.Trim) + "'"
                            strSQL += "," + strResourceID.Trim
                            strSQL += "," + m_strProjectID.Trim
                            strSQL += "," + m_strTaskTypeID.Trim
                            strSQL += "," + strSubTaskTypeID.Trim
                            strSQL += ",'" + strUserName.Trim + "'"

                            'strSQL += "," + strLCE.Trim
                            Dim strDecLCE As String = ""
                            strDecLCE = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strLCE + "',2)", True)
                            strSQL += "," + strDecLCE

                            strSQL += ",'" + strStartDate.Trim + "'"
                            strSQL += ",'" + strEndDate.Trim + "'"
                            strSQL += "," + strTaskID.Trim

                            'execute the SP and update the database 
                            strTaskID = Data.GetDataScalar(strSQL, MyBase.UseSQL).ToString + ""

                            If strTaskID <> "" And strTaskID <> "0" Then
                                If m_strUpdatedTaskIDs.IndexOf(strTaskID.Trim) <= 0 Then
                                    m_strUpdatedTaskIDs += "," + strTaskID.Trim
                                    strUpdatedEmployeeIDList += "," + strResourceID.Trim
                                End If
                            End If

                        End If
                    End If

                Next

                'Delete the tasks which already exists but now need to be deleted
                'this code is commented in the original code also
                'If strTaskIDList <> "" Then
                'strSQL = "DELETE FROM tbl_PM_ProjectTasks WHERE ParentTask_UID = " + m_strParentTaskID.Trim + " And TaskID Not In (" + strTaskIDList.Trim + ")"
                'strSQL += " And ProjectID=" + m_strProjectID.Trim
                'Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                'End If

                'here refresh the parent page
                General.WriteHTML("<Script language=javascript>")
                'Modified by    SachinR     On 07 Jun 2004
                'To add new parameter in the querystring of parent page to avoid the setting focus
                'on the cotrol on the parent page.
                'Modified By ViveP On 3 Jun 2005
                If Request.QueryString("FromTimesheet") <> "CreateTask" Then
                    General.WriteHTML("opener.document.forms[0].action='PM_TaskAssignment.aspx?Mode=Edit&MasterTagID=1038&Focus=NO&PKToken=" + m_strToken + "&TaskID=" + m_strParentTaskID.Trim + "';")
                Else
                    General.WriteHTML("opener.document.forms[0].action='PM_TaskAssignment.aspx?FromTimesheet=CreateTask&ProjectID=" + m_strProjectID + "&Mode=Edit&MasterTagID=1038&Focus=NO&TaskID=" + m_strParentTaskID.Trim + "';")
                End If
                'End Of Modification On 4 Jun 2005
                'end modification
                General.WriteHTML("opener.document.forms[0].submit();")
                General.WriteHTML("window.top.focus();")


                'Added By JayavantK, On 17-Aug-2004
                If strEmployeeNames <> "" Then
                    strEmployeeNames = strEmployeeNames.Trim()
                    strLeaveMessage = MyBase.GetResourceString("MSG_LEAVES_IN_BETWEEN_DATES")
                    strLeaveMessage &= strEmployeeNames
                    General.WriteHTML("alert('" & strLeaveMessage & "');")
                End If
                'End Addition

                General.WriteHTML("</Script>")

                General.WriteHTML(CommonFunction.General.GetRefreshParentParentScript("frmGanttChartView", "GanttChartView.aspx", "../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038", False))
                General.WriteHTML(CommonFunction.General.GetRefreshParentParentScript("frmWBS_GanttChartView", "WBS_GanttChartView.aspx", "../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038", False))
                'send mail to the selected employees
                If m_strInsertedTaskIDs <> "" Then
                    'send mail all resources for whome new tasks are created
                    blnSendMail = False
                    blnShowPopup = False

                    'get the settings for the msg 20
                    strSQL = "usp_Sel_tbl_PM_EmailMessages 20," + m_strProjectID.Trim
                    objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
                    If objDr.Read Then
                        blnSendMail = CType(Data.CheckIsDBNull(objDr("SendMail"), "0"), Boolean)
                        blnShowPopup = CType(Data.CheckIsDBNull(objDr("ShowPopup"), "0"), Boolean)
                    End If
                    Data.DisposeDataReader(objDr)

                    If blnSendMail = True Then
                        If blnShowPopup = False Then
                            CommonFunction.EmailMessages.PMMessages.GetEmailMessage_20(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, m_strInsertedTaskIDs, m_strProjectID)
                            CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                        Else
                            'write client side script to display the message window
                            General.WriteHTML("<Script language=javascript>")
                            'Modified By VivekP On 3 Jun 2005
                            If Request.QueryString("FromTimesheet") <> "CreateTask" Then
                                General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=20&TaskID=" + m_strInsertedTaskIDs.ToString + "&EmployeeIDList=" + strInsertedEmployeeIDList.Trim + "','','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');")
                            Else
                                General.WriteHTML("window.open('../General/SendEmail.aspx?ProjectID=" + m_strProjectID + "&MessageID=20&TaskID=" + m_strInsertedTaskIDs.ToString + "&EmployeeIDList=" + strInsertedEmployeeIDList.Trim + "','','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');")
                            End If
                            'End Of MidiFication On 3 jun 2005
                            General.WriteHTML("</Script>")
                        End If
                    End If
                End If

                'send mail to the selected employees
                If strUpdatedEmployeeIDList <> "" Then
                    'send mail all resources for whome tasks is updated
                    blnSendMail = False
                    blnShowPopup = False

                    'get the settings for the msg 20
                    strSQL = "usp_Sel_tbl_PM_EmailMessages 202," + m_strProjectID.Trim
                    objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
                    If objDr.Read Then
                        blnSendMail = CType(Data.CheckIsDBNull(objDr("SendMail"), "0"), Boolean)
                        blnShowPopup = CType(Data.CheckIsDBNull(objDr("ShowPopup"), "0"), Boolean)
                    End If
                    Data.DisposeDataReader(objDr)

                    If blnSendMail = True Then
                        Dim i As Integer
                        arrTaskID = Split(m_strUpdatedTaskIDs, ",")
                        arrEmployeeIDs = Split(strUpdatedEmployeeIDList, ",")

                        For i = 0 To arrTaskID.Length - 1
                            If arrTaskID(i) <> "" And arrEmployeeIDs(i) <> "" Then
                                If blnShowPopup = False Then
                                    CommonFunction.EmailMessages.PMMessages.GetEmailMessage_202(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CType(arrTaskID(i), Long), CType(arrEmployeeIDs(i), Long), m_strProjectID)
                                    CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                                Else
                                    'write client side script to display the message window
                                    General.WriteHTML("<Script language=javascript>")
                                    'Modified By VivekP On 3 Jun 2005
                                    If Request.QueryString("FromTimesheet") <> "CreateTask" Then
                                        General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=202&TaskID=" + arrTaskID(i).Trim + "&EmployeeID=" + arrEmployeeIDs(i).Trim + "','','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');")
                                    Else
                                        General.WriteHTML("window.open('../General/SendEmail.aspx?ProjectID=" + m_strProjectID + "&MessageID=202&TaskID=" + arrTaskID(i).Trim + "&EmployeeID=" + arrEmployeeIDs(i).Trim + "','','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');")
                                    End If
                                    'end Of modification on 3 jun 2005
                                    General.WriteHTML("</Script>")
                                End If
                            End If
                        Next
                    End If

                End If

                'reset the row counters 
                m_intRowCount = 0
                m_intNewTasks = 0

                'get the updated values for the task
                getTaskDetails()
        End Select

    End Sub

    Public Sub GetHolidays(ByVal lngProjectID As Long)
        '=====================================================================
        ' Procedure Name		:	GetHolidays
        ' Parameters Passed		:	lngProjectID - Unique Identifier of the Project.
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To fetch the holidays list from database.
        ' Description			:	This procedure get the list of holidays at the given Project's location.
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	JayavantK
        ' Created				:	Aug 17 2004
        ' Revisions				:	
        '=====================================================================
        ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
        ' LocationID is captured in PageInit 
        Dim strQuery As String = ""
        Dim drWork As IDataReader
        Dim strTemp As String = ""
        'Dim lngLocationID As Long = 0

        'strQuery = "SELECT LocationID FROM tbl_PM_Project WHERE ProjectID = " & lngProjectID.ToString()
        'lngLocationID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Long)

        m_strHolidays = ""
        'strQuery = "EXEC usp_Sel_tbl_PM_Location_Holiday " & lngLocationID.ToString()
        strQuery = "EXEC usp_Sel_tbl_PM_Location_Holiday " & m_LocationId.ToString()

        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            While drWork.Read()
                strTemp = drWork.Item("HolidayDate").ToString()
                If strTemp <> "" Then
                    m_strHolidays &= CommonFunctions.Dates.GetDate(CType(strTemp, Date)) & ","
                End If
            End While
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)
        ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

    End Sub

    Private Sub GetLocationDetails()
        '=====================================================================
        ' Procedure Name		:	GetLocationDetails
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To fetch the week days value from database.
        ' Description			:	This procedure get the value of weekdays at the given Project's location.
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	JayavantK
        ' Created				:	Aug 17 2004
        ' Revisions				:	
        '=====================================================================

        Dim strQuery As String = ""
        Dim drWork As IDataReader

        'Get the WeekDays and Hours Per Day
        strQuery = "Exec usp_Get_ProjectLocationWorkingHours_Days " & m_strProjectID
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                m_dblHoursPerDay = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("WorkingHours"), "0"), Double)
                m_lngWeekDays = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("WorkingDays"), "0"), Long)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)
    End Sub

    Private Function CheckLeaves(ByVal lngEmployeeID As Long, ByVal strStartDate As String, _
                                 ByVal strEndDate As String) As String
        '====================================================================
        ' Procedure Name       : CheckLeaves
        ' Parameters Passed    : EmployeeId - The Resources unique id
        '                       strStartDate - The Tasks Start date
        '                       strEndDate - The Tasks End date
        ' Returns              : The Name of the Employee if there is leave in between the start date and end date
        ' Parameters Affected  : None
        ' Purpose              : This function checks whether there is any leave in between the task start date 
        '                        and end date of the resource.
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : August 10, 2004
        ' Revisions            : 
        '=====================================================================


        Dim strReturn As String = ""
        Dim strQuery As String = ""
        ''Added by ManishK on 6th Feb 2006 for WFH Issue 
        Dim drLeave As IDataReader
        Dim strTemp As String = ""
        Dim strLeaveOrWFH As String = ""
        Dim strEmployeeName As String = ""
        Dim strLeaveDays As String = ""
        Dim strWFHDays As String = ""
        Dim strLeaves As String = ""
        Dim strWFH As String = ""
        Dim strLeaveMessage As String = ""
        Dim strWFHMessage As String = ""

        MyBase.InitializeResources("AppResources.PM_TaskAssignment", "AppResources")
        ''End Added by ManishK on 6th Feb 2006 for WFH Issue 
        strQuery = "Exec usp_Sel_tbl_PM_EmployeeLeaveDetails_ForGivenDates " & lngEmployeeID.ToString()
        strQuery &= ", '" & strStartDate & "'"
        strQuery &= ", '" & strEndDate & "'"
        ''Added by ManishK on 6th Feb 2006 for WFH Issue 
        drLeave = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        While drLeave.Read
            strEmployeeName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drLeave("EmployeeName"), ""), "")
            If strEmployeeName <> "" Then

                strLeaveDays = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drLeave("LeaveDays"), ""), "")
                strWFHDays = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drLeave("WFHDays"), ""), "")
                If strLeaveDays <> "" Then
                    strLeaveMessage = strEmployeeName + " " + MyBase.GetResourceString("CONFIRM_LEAVES") + " " + strLeaveDays.Remove(0, 1) + " "
                End If
                If strWFHDays <> "" Then
                    strWFHMessage = strEmployeeName + " " + MyBase.GetResourceString("CONFIRM_WFH") + " " + strWFHDays.Remove(0, 1)
                End If
                strTemp = strLeaveMessage + " <==> " + strWFHMessage
                'strLeaveDays = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drLeave("LeaveDays"), ""), "")
                'strWFHDays = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drLeave("WFHDays"), ""), "")
                ''strTemp = strEmployeeName + " is on Leave(s) on " + strLeaveDays + "\n " + " " + " <==> " + strEmployeeName + " is on WFH(s) on " + strWFHDays + "\n "
                'strTemp = strEmployeeName + " " + MyBase.GetResourceString("CONFIRM_LEAVES") + " " + strLeaveDays.Remove(0, 1) + " " + " <==> " + strEmployeeName + " " + MyBase.GetResourceString("CONFIRM_WFH") + " " + strWFHDays.Remove(0, 1)
            End If
        End While
        CommonFunctions.Data.DisposeDataReader(drLeave)
        strReturn = strTemp
        ''End of        ''Added by ManishK on 6th Feb 2006 for WFH Issue 
        'strReturn = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), ""), "")
        Return strReturn

    End Function

    Private Function IsTaskComplete(ByVal lngTaskID As Long) As Boolean
        '====================================================================
        ' Procedure Name       : IsTaskComplete
        ' Parameters Passed    : lngTaskID - The unique id of the assigned task.
        ' Returns              : True when the assigned task to the resource is completed, else false.
        ' Parameters Affected  : None
        ' Purpose              : This function checks whether the task assigned to the resource is completed or not.
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : September 17, 2004
        ' Revisions            : 
        '=====================================================================
        Dim strQuery As String = ""
        Dim blnReturn As Boolean = False

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strQuery = "SELECT IsTaskComplete FROM tbl_PM_ProjectTasks WHERE TaskID = " & lngTaskID.ToString()
        strQuery = "usp_sel_tbl_PM_ProjectTasks_IsTaskComplete " & lngTaskID.ToString()
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        blnReturn = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "False"), Boolean)
        Return blnReturn
    End Function

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PM_AssignTaskResources", "AppResources")
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'set the window title
        m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_ASSIGNRESOURCE") + ""
        ''Added By Usha Pandit on 06-March-2019 Purpose::Whizible 2 Work field change
        Dim drCompany As IDataReader
        drCompany = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation", True)
        If drCompany.Read() Then
            m_RestrictByMinHours = CommonFunction.Data.CheckIsDBNull(drCompany("RestrictByMinHours"), "0")
        End If
        drCompany.Close()
        drCompany.Dispose()

        ''End of Added By Usha Pandit on 06-March-2019 Purpose::Whizible 2 Work field change
    End Sub
    ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
    ' added Parameter for ShowEvenReleaseFromProject
    'addedby harshk on 22/08/2005 for whiziblesem Sp4 IssueID 120,121 
    Private Sub DrawHiddenEmployee()
        Dim strQuery As String
        'Dim drResourceDate As IDataReader
        strQuery = "usp_Sel_ProjectResources_TaskAssignment_ExpectedDate " + m_strProjectID.Trim + ",0"

        'drResourceDate = CommonFunction
        General.WriteHTML(HTMLControls.DrawComboBox("cboEmployeeStartDate", strQuery, 120, , , True, True, , , , True))
        strQuery = "usp_Sel_ProjectResources_TaskAssignment_ExpectedDate " + m_strProjectID.Trim + ",1"

        General.WriteHTML(HTMLControls.DrawComboBox("cboEmployeeEndDate", strQuery, 120, , , True, True, , , , True))
    End Sub
    'End addedby harshk on 22/08/2005 for whiziblesem Sp4 IssueID 120,121 
    ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

    ''Added by ManishK on 8th Feb 2006 for WhizibleSem sp 6 WFH confirm box issue foe Employee leaves
    Protected Sub XMLHTTP_GetLeaves()

        Dim arrEmpId() As String
        Dim intCnt As Integer
        Dim intNumberOfEmployees As Integer = 0
        Dim strEmployeeNames As String
        Dim strTempName As String
        Dim strEmployeeId As String
        Dim strLeaveMessage As String

        MyBase.InitializeResources("AppResources.PM_AssignTaskResources", "AppResources")
        strEmployeeId = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("EmployeeIDs"), "")

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("FromWhere"), "").ToUpper = "XMLHTTP" Then
            arrEmpId = strEmployeeId.Split(CType(";", Char))
            intNumberOfEmployees = arrEmpId.Length()
            For intCnt = 0 To intNumberOfEmployees - 1
                If arrEmpId(intCnt) <> "" Then
                    Dim strEmpList As String() = arrEmpId(intCnt).Split(CType(":", Char))
                    'Check if there is any leave(s) between the start date and end date
                    strTempName = CheckLeaves(CType(strEmpList(0), Long), strEmpList(1).ToString, strEmpList(2).ToString)
                    strEmployeeNames += strTempName + "<=>"
                End If
            Next
            strLeaveMessage = strEmployeeNames
            Response.Clear()
            Response.Write(strLeaveMessage)
        End If
    End Sub
    ''End Added by ManishK on 8th Feb 2006 for WhizibleSem sp 6 WFH confirm box issue foe Employee leaves

End Class
