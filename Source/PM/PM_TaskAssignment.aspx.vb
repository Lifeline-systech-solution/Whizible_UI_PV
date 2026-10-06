'******************************************************************
'           CSPL Code Header
' Project Name     :    PBNIT Enterprise Version
' Module Name      :    Task Assignment.
' Purpose          :    This module is used to assign the Tasks to the Resources.
' Description      :    In this module two project level settings 'Use Activities' and 'Apply Effort Distribution'
'                       are used. When new Task is created and above both flags are false then internaly one Parent
'                       Task is created and for each resource one sub task is created, which has the ParentTask_UID
'                       equal to the Id of the Parent Task saved.
' Assumptions      :    <Assumptions>
' Dependencies     :    <Dependencies>
' Author           :    JayavantK
' Reviewed         :    
' Tested           :    
' Created          :    May 07, 2004s
' Revisions        :    
'******************************************************************
Imports System.Text

Public Class PM_TaskAssignment
    Inherits WebPages.Template.WhizTemplate

    Protected m_strGanttView As String       'Added By VijayD to refresh the Gatt page.
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

#Region " Constants Used in the Class "
    Protected Const PROJECT_SETTING_NORMAL As String = "Normal"
    Protected Const PROJECT_SETTING_ACTIVITY As String = "Activity"
    Protected Const PROJECT_SETTING_EFFORT_DISTRIBUTION As String = "Effort_Distribution"

    Private Const MODE_MODULE As String = "Module"
    Private Const MODE_SUBPROJECT As String = "SubProject"
    Private Const MODE_CHANGEMANAGEMENT As String = "CM"
    Private Const MODE_DELIVERABLE As String = "Deliverable"

    'Added by VidyaJ - DA Performance Issue - IssueID - 89 (SP4)
    Private Const MODE_PHASE As String = "Phase"
    Private Const MODE_MILESTONE As String = "Milestone"
    'End Of Addition - IssueID - 89 (SP4)





    Protected Const ACTION_SAVE As String = "Save"
    Protected Const ACTION_DISPLAY As String = "Display"
    Protected Const ACTION_DELETE_RESOURCES As String = "DeleteResources"
    Protected Const ACTION_CLOSE_WINDOW_TRAINING As String = "Close Window - Training"
    Protected Const ACTION_CLOSE_WINDOW_MITIGATION As String = "Close Window - Mitigation"
    Protected Const ACTION_CLOSE_WINDOW_REVIEW As String = "Close Window - Review"
    Protected Const ACTION_CLOSE_WINDOW_MODE As String = "Close Window - Mode"
    'Nikhil
    Protected Const ACTION_CLOSE_WINDOW_SUBPROJECT As String = "Close Window - SubProject"
    'Nikhil

    ' Added By NitinVS on 12 March 2005 for PBNITE SP2
    Protected Const ACTION_DELETE_DOCUMENT As String = "DeleteDocuments"
    ' End Addition By NitinVS on 12 March 2005 for PBNITE SP2
    ' Added By ManishK on 6th Feb 06 for WhizibleSem 6.0 Issue for WFH
    Private strLeaveOrWFH As String = ""
    Private strLeaveDays As String = ""
    Private strEmployeeName As String = ""
    'End of  Added By ManishK on 6th Feb 06 for WhizibleSem 6.0 Issue for WFH

    'Added by MrugajaB on 18th Sept 2006 for Whiziblesem SP7 Issue ID.6197
    Protected m_strToken As String
    'End Addition

    '' Protected m_strfromCmbTaskType As String


    Private Enum MenuIndex
        ' Added By NitinVS on 9 March 2005 PBNITE SP2
        ' To Upload Document form any Node 
        UPLOAD_DOCUMENT
        ATTACH_URL
        DELETE_DOCUMENT
        'End Adition By NitinVS on 9 March 2005 PBNITE SP2
        SHOW_BASELINE
        SEND_EMAIL
        SET_BASELINE
        CLEAR_BASELINE
        'ADD_RESOURCES
        ASSIGN_RESOURCES
        DELETE_RESOURCES
        SAVE
        BACK
        CLOSE
        'Added By VivekP  On 5 Jun 2005
        CLOSE_TIMESHEET
        'End Of Addition On 5 Jun 2005
        HELP


    End Enum
    ' Modified By NitinVS on 9 March 2005 PBNITE SP2
    ' To Upload Document form any Node 
    ' Added links Upload Document , Attach URL ,Delete Document  
    'Private Const MENUITEM_COUNT As Integer = 10
    Private Const MENUITEM_COUNT As Integer = 14
    'End Modification By NitinVS on 9 March 2005 PBNITE SP2
    'TODO

    Private Enum ControlIndex
        CTRL_INDEX_TASKTYPE
        CTRL_INDEX_PHASE
        CTRL_INDEX_MODULE
        CTRL_INDEX_SUBPROJECT
        CTRL_INDEX_MILESTONE
        CTRL_INDEX_CHANGEREQUEST
        CTRL_INDEX_FEATURE
        CTRL_INDEX_ESTIMATIONTYPE
    End Enum
#End Region

#Region " Class scope Variables Declarations "
    Private m_strNbyA As String = ""
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccessRights As WebPages.Security.cAccessRights
    'Menu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_arrMenuItem(MENUITEM_COUNT - 1) As String
    Private m_arrMenuTooltip(MENUITEM_COUNT - 1) As String
    Private m_arrClientSideFunctions(MENUITEM_COUNT - 1) As String

    '' ***************************************************************************/
    '' Integrated On 10-Feb-2006 By ParagD for Whiz 2   

    '' Added By ParagD On 11-Jan-2006
    '' Purpose : DSS - 289 => 
    '' When task details are modified and click on "SEND MAIL" link ,message contains as "NEW Task"
    '' and not "MODIFIED Task" 
    '' Changed from Private To Protected.
    '' Private m_strEmployeeId As String = ""
    Protected m_strEmployeeId As String = ""
    '' END : Added By ParagD On 11-Jan-2006

    '' Integrated On 10-Feb-2006 By ParagD for Whiz 2
    '' ***************************************************************************/

    'This flag is used to send the emails if task is assigned first time.
    Protected m_blnSendEmail As Boolean = False
    Protected m_strMode As String = ""
    Protected m_strAction As String = ""
    Protected m_lngTagId As Long = 0
    Private m_strPageTitle As String = ""
    Private m_lngProjectId As Long = 0
    'Protected m_strPageNumber As String = ""
    Private m_blnSendMail As Boolean = False
    Protected m_blnShowPopup As Boolean = False
    Protected m_sbValidationScript As New StringBuilder("")
    Protected m_sbClientSideScript As New StringBuilder("")

    'Project Settings Related variables
    Private m_lngProjectLocationID As Long = 0
    Protected m_strProjectStartDate As String = ""
    Protected m_strProjectEndDate As String = ""
    Private m_blnProjectActive As Boolean = False
    'Private m_blnAllowResourceAllocation As Boolean = False
    Private m_blnIsTaskComplete As Boolean = False

    'Task Details
    Protected m_strTaskIDList As String = ""
    Protected m_lngTaskId As Long = 0
    Private m_strTaskName As String = ""
    Private m_strTaskNotes As String = ""
    Private m_blnIsDeferredTask As Boolean = False
    Private m_strUserName As String = ""
    Protected m_lngReviewActionId As Long = 0
    Protected m_lngReviewStatisticsId As Long = 0
    Protected m_lngMitigationPlanId As Long = 0
    Protected m_lngRiskId As Long = 0
    Protected m_lngTrainingResourceId As Long = 0
    Protected m_lngTrainingId As Long = 0
    Private m_arrControlDetails(7, 1) As Boolean
    Private m_lngProjectEstimationTypeId As Long = 0
    Private m_blnBillable As Boolean = False
    Protected m_strCurrentWork As String = ""
    Private m_dblCurrentDuration As Double = 0
    Protected m_strCurrentStartDate As String = ""
    Protected m_strCurrentEndDate As String = ""
    Private m_strPriority As String = ""
    Private m_strTaskType As String = ""
    Private m_lngPhaseId As Long = 0
    Private m_strPhase As String = ""
    Private m_lngModuleId As Long = 0
    Private m_strModule As String = ""
    Private m_lngSubProjectId As Long = 0
    Private m_strSubProject As String = ""
    Private m_lngMilestoneId As Long = 0
    Private m_strMilestone As String = ""
    Private m_lngChangeRequestId As Long = 0
    Private m_lngProjectFeatureId As Long = 0
    Private m_lngDeliverableId As Long = 0
    Private m_strDeliverableId As String = ""
    Private m_strBaselineStartDate As String = ""
    Private m_strBaselineEndDate As String = ""
    Private m_strBaselineWork As String = ""
    Private m_dblBaselineDuration As Double = 0
    Protected m_strActualStartDate As String = ""
    Private m_strActualEndDate As String = ""
    Private m_strActualWork As String = ""
    Private m_dblActualDuration As Double = 0
    Protected m_strHolidays As String = ""
    Private m_lngFilterEmployeeId As Long = 0
    'Private m_blnVoid As Boolean = False
    Private m_blnOnHold As Boolean = False

    Protected m_strFilterQueryString As String = ""
    Protected m_blnHasResources As Boolean = False

    'Added by SidddharthS on  17 Feb 2005 for IssueID 16002
    'Purpose:To get the starting day of the week set at carporate level. 
    Protected m_strStartingDayOfWeek As String = ""
    'End addition.

    'LCE Related fields
    Private m_blnLCEProject As Boolean = False
    Private m_blnLCEDepartment As Boolean = False
    Private m_blnLCEDeptActivity As Boolean = False
    Private m_blnLCESystem As Boolean = False
    Protected m_dblTotalAllocatedTaskLCE As Double = 0
    Protected m_dblTotalLCE As Double = 0

    Protected m_dblHoursPerDay As Double = 0
    Protected m_lngWeekDays As Long = 0

    Protected m_strProjectSetting As String = ""
    Protected m_strLeaveMessage As String = ""

    Protected m_blnProjectOnHold As Boolean = False
    Protected m_strProjectOnHoldMessage As String = ""

    'Added by VidyaJ on  Jan 15, 2005
    'For IssueID - 15416
    Protected m_intBaselineNumber As Integer = 0, m_strBaselineMessage As String = ""
    Protected m_blnIsProjectCreationWorkflowReqd As Boolean = False
    Protected m_blnSave As Boolean = False
    Protected m_PKToken As String = ""
    'End of addition 

    'Code Added by VidyaJ on 10th Feb 2005 - For issueID - 15376
    Private m_strIssueIDs As String = ""

    ' Added By NitinVS on 19 March 2005 for PBNITE SP2
    Protected WithEvents m_objGridDocument As New WebPages.Template.GenericGrid
    ' End Addition By NitinVS on 19 March 2005 for PBNITE SP2

    ' Addded By NitinVS on 3 May 2005 for WhizibleSEM SP3 IssueID		: 17096 
    ' Page is not redirected to CL For Case 1 
    Protected m_HaveSubTaskTypes As Boolean
    Protected m_ApplyEffortDistribution As Boolean
    ' End Addition by NitinVS on  3 May 2005 for WhizibleSEM SP3 IssueID		: 17096 

    'Added by VivekP On 2 jun 2005
    Protected FromTimesheet As String
    Protected TempProjectId As Long
    'End Of addition On 2 jun 2005
    'addedBY HarshK for sp4 issueID 120,121 on 06/10/2005
    Protected m_bitResourceValidation As Int16 = 1
    'End addedBY HarshK for sp4 issueID 120,121 on 06/10/2005

    '' ***************************************************************************/
    '' Integrated On 10-Feb-2006 By ParagD for Whiz 2   

    '' Added By ParagD On 11-Jan-2006
    '' Purpose : DSS - 289 => 
    '' When task details are modified and click on "SEND MAIL" link ,message contains as "NEW Task"
    '' and not "MODIFIED Task" 
    '' Changed from Private To Protected.
    Protected blnIsNewTask As Boolean
    ''END: Added By ParagD On 11-Jan-2006

    '' Integrated On 10-Feb-2006 By ParagD for Whiz 2
    '' ***************************************************************************/

    'Added by SandipL for Custom Field Functionality on 20 Jan 2006
    Protected strDefaultScript As String 'Script to store values of custom fields from another Controls
    Protected strClientSideScript As String 'Validation script for custom fields
    Protected declarevariables As String = "" 'Custom Fields objects Declaration script
    Private m_strCurrentType As String = ""
    Protected m_blnShowDefaults As Boolean = False 'Show defaults in add new mode only? 
    Protected m_strCustomFieldList As String = ""
    Protected m_strEnableControlScript As String = ""
    'End addition by SandipL on 23 Jan 2006

    '' START : Integrated by ParagD On 14-Aug-2006 for whizible SP 7.2

    'Added by SavitaS on 24 Mar 2006 for TechUnified Issue ID-1257
    Protected m_DistributeWorkInAT As Boolean = False
    Protected m_objDistributeWorkInAT As Long = 0
    'End Addition by SavitaS 

    '' END : Integrated by ParagD On 14-Aug-2006 for whizible SP 7.2
    ' Addition By NitinVS on 10 DEC 2008 for Avoiding Post back for Task type 
    Protected CustomFieldsApplicable As String = ""
    ' End Addition By NitinVS on 10 DEC 2008 for Avoiding Post back for Task type 

    'Added by GokulP on 06 Jun 2009 for Checking whether Module is Baseline or not.
    Protected m_strModuleBaselineIDs As String = ""
    'End of Addition by GokulP on 06 Jun 2009 for Checking whether Module is Baseline or not.

    'Added by GokulP on 10 Oct 2009 for IssueID : 32455
    Private m_strTaskMaxEntryDate As String = ""
    'End of Addition by GokulP on 10 Oct 2009 for IssueID : 32455

    'Added by NitinC on 06 June 2011 for WhizibleSEM 10.0 for Agile Methodology
    Protected m_strWhichTask As String
    Protected m_strUserStoryID As String
    Protected m_StartDate As Date
    Protected m_EndDate As Date
    Protected m_Effort As Integer
    Protected m_InitialEstimate As Integer
    Protected m_UserStoryName As String
    Protected m_strValidDates As String = "true"
    Protected m_strValidEffort As String = "true"
    Protected m_DatesMsg As String
    Protected m_EffortMsg As String
    Protected m_strUserStory As String = ""
    Private m_strRelease As String = ""
    Private m_strIteration As String = ""
    Protected m_intFlag As String = "0"
    'Added by NitinC on 27 Dec 2011 For WhizibleSEM 11.0 Agile Module (Issue Fix 57667)
    Protected m_FromDailyProgress As String = ""
    Protected m_DailyProgressReleaseID As String = ""
    'End of Added by NitinC on 27 Dec 2011 For WhizibleSEM 11.0 Agile Module (Issue Fix 57667)

    'End - Added by NitinC on 06 June 2011 for WhizibleSEM 10.0 for Agile Methodology
    'Added By syamantak Chavan On 3/Jan/2012
    Private m_strRequestStageID As String = ""
    'End Added By syamantak Chavan On 3/Jan/2012
    Protected m_FromPage As String
    Protected m_FromWherePage As String

    ''Added By Aniruddh Gujar on 26-Apr-2018 Purpose::Whizible Agile Changes
    Private m_strStoryPoint As String = ""
    Private m_strUSStoryPoint As String
    ''End of Added By Aniruddh Gujar on 26-Apr-2018 Purpose::Whizible Agile Changes

    ''Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
    Protected m_RestrictByMinHours As String
    Dim m_strdispCurrentWork As String
    Dim m_strdispBaselineWork As String
    Dim m_strdispActualWork As String
    ''End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change

#End Region

#Region " Page or Class Related Events "

    Private Sub Page_InitComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.InitComplete

    End Sub
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim drWork As IDataReader
        Dim strQuery As String = ""
        Dim strTemp As String = ""
        Dim strsql As String = ""
        Dim dr As IDataReader 'SiddharthS 17 Feb
        'Dim strStartingDayOfWeek As String = "" 'SiddharthS 17 Feb
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        'When the Page is called from 'SubProject, Module or Change Management' pages,
        'the value of MasterTagId is the value of TagID of those pages.
        'But in Assigned Task page the MasterTagId of the Page is 1038.
        'This Id is required while building the Global object. 
        'The Global object is used for displaying the Page Caption, Header/Footer, Accessrights etc.
        If m_objGlobal.TagID <> 1038 Then
            m_objGlobal.TagID = 1038
        End If
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

        m_lngTagId = m_objGlobal.TagID

        ''Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
        Dim drCompany As IDataReader
        drCompany = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation", True)
        If drCompany.Read() Then
            m_RestrictByMinHours = CommonFunction.Data.CheckIsDBNull(drCompany("RestrictByMinHours"), "0")
        End If
        ''End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change

        'Added By VivekP On 2 Jun 2005
        FromTimesheet = Request.QueryString("FromTimesheet")
        If Request.QueryString("FromTimesheet") = "CreateTask" Then
            m_lngProjectId = CType(Request.QueryString("ProjectID"), Long)
            TempProjectId = CType(Request.QueryString("ProjectID"), Long)
            '    ''Added if condition by NitinC on 06 Sept 2011 for WhizibleSEM10.0 Show context menu with update and assign daily activity for assigned task
            'ElseIf Request.QueryString("AllProjectsView") = "Update" Then
            '    m_lngProjectId = CType(Request.QueryString("ProID"), Long)
            '    TempProjectId = CType(Request.QueryString("ProID"), Long)
            '    ''End of Added if condition by NitinC on 06 Sept 2011 for WhizibleSEM10.0 Show context menu with update and assign daily activity for assigned task

        Else
            m_lngProjectId = m_objGlobal.ProjectID
        End If
        'Added by NitinC on 27 Dec 2011 For WhizibleSEM 11.0 Agile Module (Issue Fix 57667)
        If CommonFunction.General.CheckIsNothing(Request.QueryString("From"), "") = "DailyProgress" Then
            m_FromDailyProgress = "1"
            If CommonFunction.General.CheckIsNothing(Request.QueryString("ReleaseID"), "") <> "" Then
                m_DailyProgressReleaseID = Request.QueryString("ReleaseID").ToString
            End If
        End If
        'End of Added by NitinC on 27 Dec 2011 For WhizibleSEM 11.0 Agile Module (Issue Fix 57667)
        ''Added by Nilesh g on 12/1/2015 for issue id 2783
        m_FromPage = CommonFunction.General.CheckIsNothing(Request.QueryString("From"), "")
        ''Endded by Nilesh g on 12/1/2015 for issue id 2783
        'Added by NitinC on 06 June 2011 for WhizibleSEM 10.0 for Agile Methodology
        If CommonFunction.General.CheckIsNothing(Request.QueryString("WhichTask"), "") = "S" Then
            m_strWhichTask = "1"
        Else
            m_strWhichTask = "0"
        End If
        If CommonFunction.General.CheckIsNothing(Request.QueryString("UserStoryID"), "") <> "" Then
            m_strUserStoryID = Request.QueryString("UserStoryID")
            '''Added by NitinC on 23 June 2011 for WhizibleSEM v10.0 (Agile Methodology)
            ''Dim strSQL1 As String

            '''Dim strMsg As String
            ''strSQL1 = "select StartDate,EndDate,InitialEstimate,UserStoryName from tbl_pm_ScrumUserStory where UserStoryID = " + m_strUserStoryID
            ''strSQL1 += " select Convert(int,Sum(Effort)) AS Effort from tbl_pm_scrumtask where userstoryid = " + m_strUserStoryID + " and AssignedTo is not null"
            ''Dim dsTaskValidate As DataSet = CommonFunction.Data.GetDataSet(strSQL1, "ScrumUserStory", , , CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
            ''m_StartDate = CType(dsTaskValidate.Tables(0).Rows(0)(0).ToString, Date)
            ''m_EndDate = CType(dsTaskValidate.Tables(0).Rows(0)(1).ToString, Date)
            ''m_InitialEstimate = CType(dsTaskValidate.Tables(0).Rows(0)(2).ToString, Integer)
            ''m_Effort = CType(dsTaskValidate.Tables(1).Rows(0)(0).ToString, Integer)
            ''m_UserStoryName = dsTaskValidate.Tables(0).Rows(0)(3).ToString
            ''If m_strCurrentStartDate <> "" Then
            ''    If Not (CType(m_strCurrentStartDate, Date) >= m_StartDate And CType(m_strCurrentEndDate, Date) <= m_EndDate) Then
            ''        m_strValidDates = "false"
            ''        m_DatesMsg = "Start Date and End Date should be between user story : " + m_UserStoryName + " dates\ni.e. Start Date : " + m_StartDate + " End Date : " + m_EndDate
            ''        'CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
            ''        'CommonFunctions.General.WriteHTML("alert('" & strMsg & "');" + vbCrLf)
            ''        'CommonFunctions.General.WriteHTML("return;")
            ''        'CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
            ''    End If
            ''    If (m_Effort + CType(m_strCurrentWork, Integer)) > m_InitialEstimate Then
            ''        m_strValidEffort = "false"
            ''        m_EffortMsg = "Your planned Estimate for this Task is : " + m_strCurrentWork + " hrs\nAnd till date you have estimated hours for all tasks under user story " + m_UserStoryName + " is : " + CType(m_Effort, String) + " hrs\nNow you have entered " + m_strCurrentWork + " hrs which will break your estimation. \nSystem will automatically increase your estimated hrs for user story.\nDo you want to save anyway?"
            ''        'CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
            ''        'CommonFunctions.General.WriteHTML("var cnf = confirm('" & strMsg & "');" + vbCrLf)
            ''        'CommonFunctions.General.WriteHTML("if (cnf == true){}")
            ''        'CommonFunctions.General.WriteHTML("if (cnf == false){return;}")
            ''        'CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
            ''    End If
            ''End If
            '''End : Added by NitinC on 23 June 2011 for WhizibleSEM v10.0 (Agile Methodology)
            'ElseIf (MyBase.FixString(MyBase.GetFormValue("cboUserStory"), 100, False, True) <> "") Then
            '    m_strUserStory = MyBase.FixString(MyBase.GetFormValue("cboUserStory"), 100, False, True)
        Else
            m_strUserStoryID = "NULL"
        End If

        m_intFlag = CType(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + m_lngProjectId.ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)

        'End - Added by NitinC on 06 June 2011 for WhizibleSEM 10.0 for Agile Methodology


        'End Of addition On 2 jun 2005
        m_strUserName = m_objGlobal.UserName
        m_strPageTitle = MyBase.GetResourceString("ASSIGNED_TASKS")
        m_strNbyA = MyBase.GetResourceString("NbyA")
        If HttpContext.Current.Request("Mode") = "New" Or HttpContext.Current.Request("Mode") = "ADD_NEW" Then
            m_blnShowDefaults = True
        End If

        'Added by SidddharthS on  17 Feb 2005 for IssueID 16002
        'Purpose:To get the starting day of the week set at carporate level. 

        ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 Performance Changeas
        ' Replaced select from tbl_PM_CompanyInformation with Application value 
        ' m_HaveSubTaskTypes and m_ApplyEffortDistribution are set in GetProjectSettingDetails method

        'strsql = "Select StartingDayOfWeek from tbl_PM_CompanyInformation"
        'm_strStartingDayOfWeek = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString()
        m_strStartingDayOfWeek = CommonFunction.Application.StartDayOfWeek.ToString()

        'Addition ends

        '''Addded By NitinVS on 3 May 2005 for WhizibleSEM SP3 IssueID		: 17096 
        ''strsql = " SELECT HaveSubTaskTypes FROM tbl_PM_Project Where ProjectID = " + m_lngProjectId.ToString()
        ''m_HaveSubTaskTypes = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "False"), Boolean)

        ''strsql = "SELECT ApplyEffortDistribution FROM tbl_PM_Project WHERE ProjectID = " + m_lngProjectId.ToString()
        ''m_ApplyEffortDistribution = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "False"), Boolean)

        ' End Addition By NitinVS on 3 May 2005 for WhizibleSEM SP3 IssueID		: 17096 

        ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 Performance Changes

        strQuery = "Exec usp_Sel_tbl_CNF_Project_Status " + m_lngProjectId.ToString()
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                m_blnProjectOnHold = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ProjectOnHold"), "False"), Boolean)
                m_strProjectOnHoldMessage = CommonFunctions.General.CheckIsNothing(drWork.Item("ProjectOnHoldMsg"), "")
                'Added by VidyaJ on  Jan 15, 2005
                'For IssueID - 15416
                m_intBaselineNumber = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drWork("BaselineNumber"), "0"), "0"), Integer)
                m_strBaselineMessage = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drWork("BaseLineMessage"), ""), ""), String)
                'End of addition 
            End If
        End If
        'Added by VidyaJ on  Jan 15, 2005
        'For IssueID - 15416
        'Get the status of 'Project creation workflow required' flag
        m_blnSave = True
        m_blnIsProjectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_PM_GetProjectCreationWorkflowReqd_Status " & CommonFunction.General.CheckIsNothing(m_lngProjectId, "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)

        If m_blnIsProjectCreationWorkflowReqd = True Then
            If m_strBaselineMessage <> "" Then
                CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
                CommonFunctions.General.WriteHTML("alert('" & m_strBaselineMessage & "');" + vbCrLf)
                CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
                m_blnSave = False
            End If
        End If
        If m_strProjectOnHoldMessage <> "" Then
            CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
            CommonFunctions.General.WriteHTML("alert('" & m_strProjectOnHoldMessage & "');" + vbCrLf)
            CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
            m_blnSave = False
        End If
        'End of addition 

        CommonFunctions.Data.DisposeDataReader(drWork)
        'Commented by VidyaJ on  Jan 15, 2005
        'For IssueID - 15416
        ' If m_blnProjectOnHold = False Then
        'Get the WeekDays and Hours Per Day
        strQuery = "Exec usp_Get_ProjectLocationWorkingHours_Days " & m_lngProjectId.ToString()
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                m_dblHoursPerDay = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("WorkingHours"), "0"), Double)
                m_lngWeekDays = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("WorkingDays"), "0"), Long)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)

        m_lngReviewActionId = CType("0" & CommonFunctions.General.CheckIsNothing(Request("ReviewActionID")), Long)
        m_lngReviewStatisticsId = CType("0" & CommonFunctions.General.CheckIsNothing(Request("ReviewStatisticsID")), Long)
        m_lngRiskId = CType("0" & CommonFunctions.General.CheckIsNothing(Request("RiskID")), Long)
        m_lngMitigationPlanId = CType("0" & CommonFunctions.General.CheckIsNothing(Request("MitigationPlanID")), Long)
        m_lngTrainingId = CType("0" & CommonFunctions.General.CheckIsNothing(Request("TrainingID")), Long)
        m_lngTrainingResourceId = CType("0" & CommonFunctions.General.CheckIsNothing(Request("TrainingResourceID")), Long)
        m_lngTaskId = CType("0" & CommonFunctions.General.CheckIsNothing(Request("TaskId")), Long)
        m_blnIsDeferredTask = False
        m_lngFilterEmployeeId = CType("0" & CommonFunctions.General.CheckIsNothing(Request("cboFilter_EmployeeID")), Long)

        ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 Performance Changeas
        'Moved the 
        Call GetProjectSettingsDetails()
        ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0Performance Changeas



        'm_blnProjectActive = PM_AssignedTaskList.IsProjectActive(m_lngProjectId)

        m_strMode = CommonFunctions.General.CheckIsNothing(Request("PageType"))
        If Not Page.IsPostBack And Not m_strProjectSetting = PROJECT_SETTING_NORMAL Then
            If m_lngReviewActionId > 0 Or m_lngMitigationPlanId > 0 Or _
                m_lngTrainingResourceId > 0 Or m_strMode <> "" Then
                'GetParentTaskID()
            End If
        ElseIf m_strProjectSetting = PROJECT_SETTING_NORMAL Then
            GetChildTaskID()
        End If

        m_strHolidays = ""
        strQuery = "EXEC usp_Sel_tbl_PM_Location_Holiday " & m_lngProjectLocationID.ToString()
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

        strQuery = "usp_Sel_tbl_PM_EmailMessages 20"
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                m_blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("SendMail"), "False"), Boolean)
                m_blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ShowPopup"), "False"), Boolean)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)

        m_strAction = Request("Action") & ""


        'Added by MrugajaB on 18th Sept 2006 for Whiziblesem Issue ID.6197
        m_strToken = ""

        If CType(m_lngTaskId, String) <> "0" Then
            If Request.QueryString("PkToken") Is Nothing Then
                m_strToken = Request.Form("txtHidToken").ToString
            Else
                m_strToken = Request.QueryString("PkToken").ToString
            End If
            'If Request.QueryString("fromCmbTaskType") Is Nothing Then
            '    m_strfromCmbTaskType = Request.Form("fromCmbTaskType").ToString
            'End If
        End If

        'Dim strTempToken As String
        'strTempToken = CommonFunctions.Security.Token.GetToken(CType(m_lngTaskId, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(m_lngTagId, String))

        If ((m_strToken = "") And (m_lngTaskId <> 0)) Or _
((m_lngTaskId <> 0) And (CommonFunctions.Security.Token.ValidateToken(CType(m_lngTaskId, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(m_lngTagId, String), m_strToken) = False)) Then
            Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Task Assignment", m_lngTagId, 0, "Task ID", CType(m_lngTaskId, String))
            'Token is Invalid now redirect to the Invalid Access Page
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If
        'End Addition

        'Validate the LCE (Wrok Hours). If not valid then m_strAction is Set to ACTION_DISPLAY
        Call GetValuesToValidateLCE()


        'Code Modified by SandipL to avoid re-Saving of Task on each TaskType Change Event
        If HttpContext.Current.Request("TaskTypeID") Is Nothing Then
            If m_strAction = ACTION_SAVE Then
                GetFormValues()
                SaveTaskDetails()
                ''Added by Nilesh g on 12/1/2015 for issue id 2783
                If m_FromPage = "DailyProgress" Then
                    Response.Write("<script type=""text/javascript"" language='javascript''>")
                    'Response.Write("window.parent.frames['infragisticsTree'].document.location.href = window.parent.frames['infragisticsTree'].document.location.href;")
                    Response.Write("window.opener.location.href=window.opener.location.href;")
                    Response.Write("</script>")
                End If
                ''Added by Nilesh g on 12/1/2015 for issue id 2783

            ElseIf m_strAction = ACTION_DELETE_RESOURCES Then
                DeleteAssignedResources()
                ' Added By NitinVS on 12 March 2005 for PBNITE SP2
            ElseIf m_strAction = ACTION_DELETE_DOCUMENT Then
                Dim strDocumentIDList As String
                strDocumentIDList = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkDeleteDocument")).Trim()
                CommonFunction.ProjectDocument.DeleteDocument(m_lngProjectId.ToString.Trim, strDocumentIDList, "A", MyBase.UseSQL)
                ' End Addition  By NitinVS on 12 March 2005 for PBNITE SP2
            End If
        End If
        'End Modification by SandipL

        InitiateControlArray()
        GetTaskDetails()


        Call InitPageMenu()
        ''  Added by Yogesh J on 01-Feb-2016 to generate Token
        m_PKToken = CommonFunctions.Security.Token.GetToken(CType(m_lngTaskId, String) + CType(Session("intUserID"), String) + "0" + "0")
        ''End of addition by Yogesh J on 01-Feb-2016 to generate Token
        ' End If
        '
        ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 Performance Changeas

        'm_bitResourceValidation is set in GetProjectSettingsDeatils method 
        ''added by HarshK for sp4 IssueID 120,121 on 06/10/2005
        'Dim strQuery2 As String = "select IsNull(ResourceValidation,0) from tbl_PM_Project WHERE ProjectID = " & m_lngProjectId.ToString
        'If CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery2, MyBase.UseSQL), "True"), Boolean) = True Then
        '    m_bitResourceValidation = 1
        'Else
        '    m_bitResourceValidation = 0
        'End If
        ''End added by HarshK for sp4 IssueID 120,121 on 06/10/2005

        ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0Performance Changeas
        ' Addition By NitinVS on 10 DEC 2008 for Avoiding Post back for Task type 

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''CustomFieldsApplicable = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(" If exists ( SELECT  ProjectID  FROM tbl_PM_CustomFields_Master WHERE entityName ='Task' AND ProjectId = " + m_lngProjectId.ToString() + " ) SELECT 1 ELSE SELECT 0 ", MyBase.UseSQL), "0").ToString
        CustomFieldsApplicable = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_ProjectID_tbl_PM_CustomFields_Master " + m_lngProjectId.ToString(), MyBase.UseSQL), "0").ToString
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        ' End Addition By NitinVS on 10 DEC 2008 for Avoiding Post back for Task type 
        ' ''Added  By Shamkant s 31/12/2015
        'If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
        '    Response.Write(vbCrLf + "<script>")
        '    Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
        '    If strRedirectToPage.Trim = "" Then
        '        Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
        '    Else
        '        Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
        '    End If
        '    Response.Write(vbCrLf + "</script>")
        'End If
        ''Ended By Shamkant s 31/12/2015
    End Sub

    ''Added by Yogesh J on 29-Jan-2016 for to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken(EmployeeID As String, EmployeeList As String, FromDate As String, ToDate As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(EmployeeList, String) + CType(FromDate, String) + CType(ToDate, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of addition by Yogesh J on 29-Jan-2016
    ''Added by Yogesh J on 01-Feb-2016 for to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_UploadDoc(UniqueID As String, EmployeeID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(UniqueID, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of addition by Yogesh J on 01-Feb-2016

    ''Added by Yogesh J on 29-Jan-2016 for to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateAssignResourcesToken(ParentTaskID As String, TaskID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(ParentTaskID, String) + CType(TaskID, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of addition by Yogesh J on 29-Jan-2016
    ''Added By Aniruddh Gujar on 08-Jun-2018 Purpose::To validate Task Efforts with Sprint
    <System.Web.Services.WebMethod()>
    Public Shared Function CheckIterationEfforts(ByVal strUserStoryID As String, ByVal strEfforts As String, ByVal strTaskID As String)
        Try
            If strUserStoryID = "" Then
                strUserStoryID = "NULL"
            End If

            If strTaskID = "" Then
                strTaskID = "NULL"
            End If

            'Commented and Added by Usha Pandit on 20-March-2019 Purpose::Whizible 2 Work field change
            'Dim strSql As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_TaskEffortsWithIteration " & strUserStoryID & "," & strEfforts & "," & strTaskID & "", True), "0")
            Dim fltEfforts As Decimal

            fltEfforts = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strEfforts + "',2)", True)

            Dim strSql As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_TaskEffortsWithIteration " & strUserStoryID & "," & fltEfforts & "," & strTaskID & "", True), "0")
            'End of Added by Usha Pandit on 20-March-2019 Purpose::Whizible 2 Work field change
            Return strSql
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function CheckIterationDates(ByVal strUserStoryID As String, ByVal strStartDate As String, ByVal strEndDate As String)
        Try
            If strUserStoryID = "" Then
                strUserStoryID = "NULL"
            End If
            Dim strSql As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_TaskPeriodFallsBetweenIteration " & strUserStoryID & ",'" & strStartDate & "','" & strEndDate & "'", True), "0")
            Return strSql
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of Added By Aniruddh Gujar on 08-Jun-2018 Purpose::To validate Task Efforts with Sprint

    ''Added By Usha Pandit On 24.07.2019 For getting Active/InActive Status of the Task
    <System.Web.Services.WebMethod>
    Public Shared Function IsActiveTask(TaskID As String) As String
        Try
            Dim strQuery As String = ""
            Dim lnActiveTask As Long = 0

            strQuery = "usp_chk_tbl_PM_ProjectTasks_IsActive_TaskID " & TaskID

            lnActiveTask = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, True), "0"), Long)

            Return lnActiveTask
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End Of Added By Usha Pandit On 24.07.2019 For getting Active/InActive Status of the Task

    ''Added By Usha Pandit on 29-April-2020 Purpose::Whizible 2 Work field change
    <System.Web.Services.WebMethod()>
    Public Shared Function getDecimalHours(ByVal HMHours As String) As String
        Try
            Dim fltHours As Decimal

            fltHours = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + HMHours + "',2)", True)

            Return fltHours.ToString()

        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function getHMHours(ByVal DecimalHours As String) As String
        Try
            Dim HMHours As String

            HMHours = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + DecimalHours + "',1)", True)

            Return HMHours

        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of Added By Usha Pandit on 29-April-2020 Purpose::Whizible 2 Work field change


    Public Sub New()
        'MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.InitializeResources("AppResources.PM_TaskAssignment", "AppResources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "PM_TaskAssignment : " & UserInput & " " & Cause
        Throw ex
    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objGrid = Nothing
        m_objMenu = Nothing
        m_objAccessRights = Nothing
        m_objGlobal = Nothing
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
#End Region

#Region " Common Functions or Procedures "
    Private Sub InitPageMenu()

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        m_arrMenuItem(MenuIndex.SHOW_BASELINE) = MyBase.GetResourceString("MENU_PM_SHOWBASELINE")
        m_arrMenuTooltip(MenuIndex.SHOW_BASELINE) = MyBase.GetResourceString("MENU_PM_SHOWBASELINE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SHOW_BASELINE) = "ShowBaseline_OnClick()"

        m_arrMenuItem(MenuIndex.SEND_EMAIL) = MyBase.GetResourceString("MENU_SEND_EMAIL")
        m_arrMenuTooltip(MenuIndex.SEND_EMAIL) = MyBase.GetResourceString("MENU_SEND_EMAIL_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SEND_EMAIL) = "SendEmail_OnClick()"

        m_arrMenuItem(MenuIndex.SET_BASELINE) = MyBase.GetResourceString("MENU_PM_SET_BASELINE")
        m_arrMenuTooltip(MenuIndex.SET_BASELINE) = MyBase.GetResourceString("MENU_PM_SET_BASELINE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SET_BASELINE) = "SetAsBaseline_OnClick()"

        m_arrMenuItem(MenuIndex.CLEAR_BASELINE) = MyBase.GetResourceString("MENU_PM_CLEAR_BASELINE")
        m_arrMenuTooltip(MenuIndex.CLEAR_BASELINE) = MyBase.GetResourceString("MENU_PM_CLEAR_BASELINE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CLEAR_BASELINE) = "ClearBaseline_OnClick()"

        'm_arrMenuItem(MenuIndex.ADD_RESOURCES) = MyBase.GetResourceString("MENU_ADD_RESOURCES")
        'm_arrMenuTooltip(MenuIndex.ADD_RESOURCES) = MyBase.GetResourceString("MENU_ADD_RESOURCES_TOOLTIP")
        'm_arrClientSideFunctions(MenuIndex.ADD_RESOURCES) = "AddResources_OnClick()"

        m_arrMenuItem(MenuIndex.ASSIGN_RESOURCES) = MyBase.GetResourceString("MENU_ASSIGN_RESOURCES")
        m_arrMenuTooltip(MenuIndex.ASSIGN_RESOURCES) = MyBase.GetResourceString("MENU_ASSIGN_RESOURCES_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.ASSIGN_RESOURCES) = "AssignResources_OnClick(" & m_lngTaskId.ToString() & ", 0)"

        m_arrMenuItem(MenuIndex.DELETE_RESOURCES) = MyBase.GetResourceString("MENU_DELETE_RESOURCES")
        m_arrMenuTooltip(MenuIndex.DELETE_RESOURCES) = MyBase.GetResourceString("MENU_DELETE_RESOURCES_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.DELETE_RESOURCES) = "DeleteResources_OnClick()"

        m_arrMenuItem(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE")
        m_arrMenuTooltip(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SAVE) = "Save_OnClick()"

        m_arrMenuItem(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE")
        m_arrMenuTooltip(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CLOSE) = "Close_OnClick()"

        'TODO
        ' Added By NitinVS on 9 March 2005 PBNITE SP2
        ' To Upload Document form any Node 
        m_arrMenuItem(MenuIndex.UPLOAD_DOCUMENT) = MyBase.GetResourceString("MENU_UPLOAD_DOCUMENT")
        m_arrMenuTooltip(MenuIndex.UPLOAD_DOCUMENT) = MyBase.GetResourceString("MENU_UPLOAD_DOCUMENT_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.UPLOAD_DOCUMENT) = "UploadDoc_OnClick()"

        m_arrMenuItem(MenuIndex.ATTACH_URL) = MyBase.GetResourceString("MENU_ATTACH_URL")
        m_arrMenuTooltip(MenuIndex.ATTACH_URL) = MyBase.GetResourceString("MENU_ATTACH_URL_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.ATTACH_URL) = "AttachURL_OnClick()"

        'Commented by PrajaktaR on 3 June 2005 for IssueID 19208
        'If m_objAccessRights.Delete = True Then

        m_arrMenuItem(MenuIndex.DELETE_DOCUMENT) = MyBase.GetResourceString("MENU_DELETE") + " Document"
        m_arrMenuTooltip(MenuIndex.DELETE_DOCUMENT) = MyBase.GetResourceString("MENU_DELETE_TOOLTIP") + " Document"
        m_arrClientSideFunctions(MenuIndex.DELETE_DOCUMENT) = "DeleteDocument_OnClick()"

        'End If
        'End Addition By NitinVS on 9 March 2005 PBNITE SP2
        'Commented by PrajaktaR on 3 June 2005 for IssueID 19208

        m_arrMenuItem(MenuIndex.BACK) = MyBase.GetResourceString("MENU_BACK")
        m_arrMenuTooltip(MenuIndex.BACK) = MyBase.GetResourceString("MENU_BACK_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.BACK) = "Back_OnClick()"

        'Added By VivekP On 5 Jun 2005 
        m_arrMenuItem(MenuIndex.CLOSE_TIMESHEET) = "Close"
        m_arrMenuTooltip(MenuIndex.CLOSE_TIMESHEET) = "Close"
        m_arrClientSideFunctions(MenuIndex.CLOSE_TIMESHEET) = "CloseTimesheet_OnClick()"
        'End Of addition On 5 Jun 2005

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick(" & m_lngTagId & ")"

        MyBase.InitializeResources("AppResources.PM_TaskAssignment", "AppResources")
    End Sub

    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub

    Private Sub WritePageLegend()
        Dim arrLegends(0) As String
        Dim arrLegendImg(0) As String
        arrLegends(0) = "&nbsp;" & MyBase.GetResourceString("MANDATORY")
        arrLegendImg(0) = CommonFunctions.HTMLControls.DrawMandatoryImage(, True)
        CommonFunctions.General.WriteHTML(WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImg, arrLegends, True))
    End Sub

    Public Sub WritePage()
        'If m_blnProjectOnHold = False Then
        Dim strMenu As String

        m_strGanttView = CommonFunction.General.CheckIsNothing(Request.QueryString("GanttChartType"), "1")
        'Dim objHeaderFooter As WebPages.Template.HeaderFooter

        '' START : Integrated by ParagD On 14-Aug-2006 for whizible SP 7.2
        'Added by SavitaS on 24 Mar 2006 for TechUnified Issue ID-1257
        'Dim strSQL As String
        'Dim dr As IDataReader

        ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 Performance Changeas

        'strSQL = "select DistributeWorkInAT from tbl_PM_CompanyInformation"
        'dr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        'If dr.Read Then
        '    m_DistributeWorkInAT = CType(CommonFunctions.Data.CheckIsDBNull(dr("DistributeWorkInAT"), "0"), Long)
        'End If
        'CommonFunctions.Data.DisposeDataReader(dr)
        m_DistributeWorkInAT = CommonFunction.Application.DistributeWorkInAT

        ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 Performance Changeas

        'End of Added by SavitaS on 24 Mar 2006 for TechUnified Issue ID-1257
        '' END : Integrated by ParagD On 14-Aug-2006 for whizible SP 7.2

        'Display the Menu
        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
        CommonFunctions.General.WriteHTML(strMenu)

        'Display The Legend 
        WritePageLegend()

        'Display Page Caption
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, , , , True))
        CommonFunctions.General.WriteHTML("<br>")

        'Display Page Header
        'objHeaderFooter = New WebPages.Template.HeaderFooter
        'objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        'objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        'objHeaderFooter = Nothing
        CommonFunctions.General.WriteHTML("<br>")
        'Display Page Body
        Display_TaskDetails()

        'Display Page Footer
        'objHeaderFooter = New WebPages.Template.HeaderFooter
        'objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
        'objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        'objHeaderFooter = Nothing

        'Display Menu at Footer
        CommonFunctions.General.WriteHTML(strMenu)

        'Store the Filter Values in hidden controls
        Call Store_FilterValues()
        ' End If
    End Sub
#End Region

    Private Sub Display_TaskDetails()
        Dim sbHTML As New StringBuilder("")
        Dim objHREF As New WebPages.UI.cDynamicLink
        Dim strQuery As String
        Dim intColumnNumber As Integer
        Dim objSectionTitle As WebPages.Template.SectionTitle
        Dim strToBeInserted As String = ""
        'added by harshk for sp4 issueid 120,121 
        Dim strQuery2 As String
        ' end added by harshk for sp4 issueid 120,121 
        sbHTML.Append("<DIV ID=PageDiv style='overflow:auto;width:100%;height:460px'>") '390
        sbHTML.Append("<TABLE CellSpacing=0 Class=clsTable Width='99.9%'>")

        ' Task Name.
        sbHTML.Append("<TR class='clsTREven'><TD align=right valign=top>")
        sbHTML.Append(MyBase.GetResourceString("TASK_NAME"))
        sbHTML.Append("</TD><TD colspan=3>")

        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtTaskName", "txtTaskName", , 375, 255, m_strTaskName, returnHTML:=True, IsMandatory:=True, EnableHTMLEncode:=True))
        '''End of Modification by Dhanashri S on 7 Oct 2015 

        sbHTML.Append("</TD></TR>")

        ' Task Notes.
        sbHTML.Append("<TR class='clsTREven'><TD align=right valign=top>")
        sbHTML.Append(MyBase.GetResourceString("TASK_NOTES"))
        sbHTML.Append("</TD><TD colspan=3>")
        'Modified By ShraddhaM on 27 July 2006
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'sbHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtTaskNotes", "txtTaskNotes", , , , "frmTaskAssignment", , , 375, 70, 2000, value:=m_strTaskNotes, returnHTML:=True, Wrap:="Soft"))
        sbHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtTaskNotes", "txtTaskNotes", , , , "frmTaskAssignment", , , 375, 70, 2000, value:=m_strTaskNotes, returnHTML:=True, Wrap:="Soft", EnableHTMLEncode:=True))
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        sbHTML.Append("</TD>")
        ' Modified By MahendraV on 11:48 AM 5/11/2007 ,To remove additional <TD>
        'Added by MrugajaB on 18th Sept 2006 for whiziblesem SP7 issue ID.6197
        'Purpose:Hidden variable that will store value of token that is passed in edit mode from Task List Page

        'sbHTML.Append("<TD align='left'>")

        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txthidToken", "txthidToken", value:=m_strToken, returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True))
        '''End of Modification by Dhanashri S on 7 Oct 2015

        sbHTML.Append("</TR>")
        'End Addition

        If m_strProjectSetting = PROJECT_SETTING_NORMAL Then
            If m_blnIsDeferredTask = True Then
                If m_lngTaskId > 0 Then
                    sbHTML.Append("<TR class='clsTREven'><TD></TD><TD colspan=3>")
                    objHREF = New WebPages.UI.cDynamicLink
                    objHREF.OtherProperties = "Id=hrefToggleResource"
                    objHREF.FunctionName = "ToggleResourceList_OnClick()"
                    objHREF.LinkName = MyBase.GetResourceString("ASSIGN_TASK_TO_RESOURCES")
                    objHREF.ReturnHTML = True
                    sbHTML.Append(objHREF.GetDynamicLink())
                    objHREF = Nothing
                    sbHTML.Append("</TD></TR>")
                End If
            End If

            sbHTML.Append("<TR id=rowResource class='clsTREven'")
            If m_blnIsDeferredTask = True Then
                sbHTML.Append("style='display:none'")
                m_strEmployeeId = ""
            End If
            sbHTML.Append("><TD align=right valign=top>")
            sbHTML.Append(MyBase.GetResourceString("RESOURCES"))
            sbHTML.Append("</TD><TD colspan=3>")

            If m_lngTaskId > 0 Then
                If m_blnIsDeferredTask = True And m_strEmployeeId = "" Then
                    strQuery = "EXEC usp_Sel_CurrentTeamMembers " & m_lngProjectId.ToString()
                    sbHTML.Append(CommonFunctions.HTMLControls.DrawListBox("cboResourceEndDatecboEmployee", strQuery, 250, 150, m_strEmployeeId, ReturnAsHTML:=True, IsMandatory:=True))

                    '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
                    sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txthidIsDeferredTask", "txthidIsDeferredTask", value:="1", IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    '''End of Modification by Dhanashri S on 7 Oct 2015 

                    'added by harshk on 22/08/05 for sp4 IssueID 120,121 
                    'Modified by TruptiK on 21-Nov-2007
                    'Purpose:-RequestID 9909
                    strQuery2 = "EXEC usp_Sel_CurrentTeamMembers_ExpectedDate  " & m_lngProjectId.ToString() & ",0"
                    sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboResourceStartDate", strQuery2, 250, , , True, True, , , , True))
                    strQuery2 = "EXEC usp_Sel_CurrentTeamMembers_ExpectedDate  " & m_lngProjectId.ToString() & ",1"
                    sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("", strQuery2, 250, , , True, True, , , , True))
                    'end added by harshk on 22/08/05 for sp4 IssueID 120,121 

                Else
                    strQuery = "EXEC usp_Sel_teammembers " & m_lngProjectId.ToString() & "," & m_lngTaskId.ToString()
                    sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", strQuery, 250, m_strEmployeeId, "disabled", True, returnASHTML:=True, IsMandatory:=True))
                    'Added by SandipL on 2 Feb 2006 for Task Custom field Functionality
                    m_strEnableControlScript += " objcboEmployee = GetObjectReference('frmTaskAssignment','cboEmployee'); " + vbCrLf
                    m_strEnableControlScript += "if (objcboEmployee!=null) {objcboEmployee.disabled=false;}" + vbCrLf
                    'End addition by SandipL
                    'added by harshk on 22/08/2005 for sp4 IssueID 120,121 
                    'Modified by TruptiK on 21-Nov-2007
                    'Purpose:-RequestID 9909
                    'strQuery2 = "EXEC usp_Sel_TeamMembers_ExpectedDate  " & m_lngProjectId.ToString() & ",0"
                    strQuery2 = "EXEC usp_Sel_TeamMembers_ExpectedDate  " & m_lngProjectId.ToString() & ",0" & "," & m_lngTaskId.ToString()
                    sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboResourceStartDate", strQuery2, 250, , , True, True, , , , True))
                    'strQuery2 = "EXEC usp_Sel_TeamMembers_ExpectedDate  " & m_lngProjectId.ToString() & ",1"
                    strQuery2 = "EXEC usp_Sel_TeamMembers_ExpectedDate  " & m_lngProjectId.ToString() & ",1" & "," & m_lngTaskId.ToString()
                    'End of modification by TruptiK on 21-Nov-2007
                    sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboResourceEndDate", strQuery2, 250, , , True, True, , , , True))
                    'end added by harshk on 22/08/2005 for sp4 IssueID 120,121 
                End If
            ElseIf m_lngReviewActionId > 0 Or m_lngMitigationPlanId > 0 Or m_lngTrainingResourceId > 0 Then
                If m_strEmployeeId <> "" Then
                    strToBeInserted = "disabled"
                    'Added by SandipL on 2 Feb 2006 for Task Custom field Functionality
                    m_strEnableControlScript += " objcboEmployee = GetObjectReference('frmTaskAssignment','cboEmployee'); " + vbCrLf
                    m_strEnableControlScript += "if (objcboEmployee!=null) {objcboEmployee.disabled=false;}" + vbCrLf
                    'End addition by SandipL
                Else
                    strToBeInserted = ""
                End If
                strQuery = "EXEC usp_Sel_CurrentTeamMembers " & m_lngProjectId.ToString()
                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", strQuery, 250, m_strEmployeeId, strToBeInserted, True, returnASHTML:=True, IsMandatory:=True))
                'added by harshk on 22/08/05  for sp4 IssueID 120,121 
                strQuery2 = "EXEC usp_Sel_CurrentTeamMembers_ExpectedDate  " & m_lngProjectId.ToString() & ",0"
                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboResourceStartDate", strQuery2, 250, , , True, True, , , , True))
                strQuery2 = "EXEC usp_Sel_CurrentTeamMembers_ExpectedDate  " & m_lngProjectId.ToString() & ",1"
                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboResourceEndDate", strQuery2, 250, , , True, True, , , , True))
                'end added by harshk on 22/08/05  for sp4 IssueID 120,121 
            Else
                strQuery = "EXEC usp_Sel_CurrentTeamMembers " & m_lngProjectId.ToString()
                If (Not HttpContext.Current.Request("TaskTypeID") Is Nothing) Then
                    Dim strEmployeeList As String = CType(HttpContext.Current.Request("cboEmployee"), String)
                    If strEmployeeList Is Nothing Then
                        strEmployeeList = ""
                    End If
                    sbHTML.Append(CommonFunctions.HTMLControls.DrawListBox("cboEmployee", strQuery, 250, 150, strEmployeeList, returnASHTML:=True, IsMandatory:=True))
                Else
                    sbHTML.Append(CommonFunctions.HTMLControls.DrawListBox("cboEmployee", strQuery, 250, 150, m_strEmployeeId, returnASHTML:=True, IsMandatory:=True))
                End If
                'added by harshk on 22/08/05 for sp4 IssueID 120,121 
                strQuery2 = "EXEC usp_Sel_CurrentTeamMembers_ExpectedDate  " & m_lngProjectId.ToString() & ",0"
                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboResourceStartDate", strQuery2, 250, , , True, True, , , , True))
                strQuery2 = "EXEC usp_Sel_CurrentTeamMembers_ExpectedDate  " & m_lngProjectId.ToString() & ",1"
                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboResourceEndDate", strQuery2, 250, , , True, True, , , , True))
                'end added by harshk on 22/08/05 for sp4 IssueID 120,121 
            End If
            objHREF = New WebPages.UI.cDynamicLink
            objHREF.FunctionName = "ShowSchedule_OnClick()"
            objHREF.LinkName = MyBase.GetResourceString("SHOW_SCHEDULE")
            objHREF.ReturnHTML = True
            sbHTML.Append(objHREF.GetDynamicLink())
            objHREF = Nothing
            sbHTML.Append("</TD></TR>")
        End If

        ' ESTIMATION TYPE.
        '-----------------
        ' If the control must be displayed, then...
        If m_arrControlDetails(ControlIndex.CTRL_INDEX_ESTIMATIONTYPE, 0) = True Then
            sbHTML.Append("<TR class='clsTREven'>")
            ' Display the control.
            sbHTML.Append("<TD align=right valign=top>")
            sbHTML.Append(MyBase.GetResourceString("ESTIMATION_TYPE"))
            sbHTML.Append("</TD><TD valign=top>")
            If m_lngTaskId > 0 Then
                strQuery = "Exec usp_Sel_tbl_PM_Project_EstimationTypes NULL, " & m_lngProjectId.ToString()
                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProjectEstimationTypeID", strQuery, 250, m_lngProjectEstimationTypeId.ToString(), "disabled", True, True))
                'Added by SandipL on 2 Feb 2006 for Task Custom field Functionality
                m_strEnableControlScript += " objcboProjectEstimationTypeID = GetObjectReference('frmTaskAssignment','cboProjectEstimationTypeID'); " + vbCrLf
                m_strEnableControlScript += "if (objcboProjectEstimationTypeID!=null) {objcboProjectEstimationTypeID.disabled=false;}" + vbCrLf
                'End addition by SandipL

            Else
                strQuery = "Exec usp_Sel_tbl_PM_Project_EstimationTypes NULL, " & m_lngProjectId.ToString()
                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProjectEstimationTypeID", strQuery, 250, m_lngProjectEstimationTypeId.ToString(), "OnChange='javascript:cboProjectEstimationTypeID_OnChange()'", True, True))
            End If
            If m_lngTaskId = 0 Then

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                'strQuery = "SELECT ProjectEstimationTypeID, EstimationTypeHours "
                'strQuery &= "FROM tbl_PM_Project_EstimationTypes WHERE ProjectID = " & m_lngProjectId.ToString()
                'strQuery &= "ORDER BY EstimationTypeName"

                strQuery = "usp_sel_tbl_PM_Project_EstimationTypes_ProjectEstimationTypeID_EstimationTypeHours " & m_lngProjectId.ToString()
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProjectEstimationTypeHours", strQuery, 250, m_lngProjectEstimationTypeId.ToString(), "style='display:none'", True, True, , m_arrControlDetails(ControlIndex.CTRL_INDEX_ESTIMATIONTYPE, 1)))
            End If

            If m_arrControlDetails(ControlIndex.CTRL_INDEX_ESTIMATIONTYPE, 1) = True Then
                ' Build the client side validation script. 
                m_sbValidationScript.Append("objControl = GetObjectReference('frmTaskAssignment','cboProjectEstimationTypeID');" & vbCrLf)
                m_sbValidationScript.Append("if(disallowBlank(objControl, """ & MyBase.GetResourceString("SELECT_ESTIMATION_TYPE") & """))")
                m_sbValidationScript.Append("	return false;" & vbCrLf)
            End If
            sbHTML.Append("</TD><TD colspan=2></TD></TR>")
        End If

        ' Work (hrs) and Billable?.								
        sbHTML.Append("<TR class=clsTREven><TD align=right valign=top>")

        ''Commented and Modified By Usha Pandit on 07-Mar-2019 Purpose::Whizible 2 Work field change
        'sbHTML.Append(MyBase.GetResourceString("WORK_HRS"))
        sbHTML.Append("Work (H:M)")
        ''End of Commented and Modified By Usha Pandit on 07-Mar-2019 Purpose::Whizible 2 Work field change

        sbHTML.Append("</TD><TD valign=top>")

        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        ''Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
        'sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtCurrentWork", "txtCurrentWork", , 70, 6, m_strCurrentWork, "Right", returnHTML:=True, IsMandatory:=True, EnableHTMLEncode:=True))
        If m_strCurrentWork <> "" Then
            ''Added By Ankush T on 15-mar-2019 Purpose::Whizible 2 Work field change
            If m_strCurrentWork.Contains(":") Then
                m_strdispCurrentWork = m_strCurrentWork
            ElseIf IsNumeric(m_strCurrentWork) = True Then
                m_strdispCurrentWork = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + m_strCurrentWork + "',1)", True)
            Else
                m_strdispCurrentWork = m_strCurrentWork
            End If
            ''Endo of Added By Ankush T on 15-mar-2019 Purpose::Whizible 2 Work field change
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtCurrentWork", "txtCurrentWork", , 70, 6, m_strdispCurrentWork, "Right", , , , , , "placeholder='00:00'", returnHTML:=True, IsMandatory:=True, EnableHTMLEncode:=True))
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txthidCurrentWork", "txthidCurrentWork", , 70, 6, m_strCurrentWork, "Right", , , , , True, , returnHTML:=True, EnableHTMLEncode:=True))
        Else
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtCurrentWork", "txtCurrentWork", , 70, 6, m_strCurrentWork, "Right", , , , , , "placeholder='00:00'", returnHTML:=True, IsMandatory:=True, EnableHTMLEncode:=True))
        End If

        ''End of Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change

        '''End of Modification by Dhanashri S on 7 Oct 2015

        sbHTML.Append("</TD>")
        sbHTML.Append("<TD align=right valign=top>")
        sbHTML.Append(MyBase.GetResourceString("BILLABLE"))
        sbHTML.Append("</TD><TD >")
        sbHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkBillable", "chkBillable", , m_blnBillable, "ON", returnHTML:=True))
        sbHTML.Append("</TD></TR>")

        ' Start Date and End Date.
        sbHTML.Append("<TR class='clsTREven'><TD align=right valign=top>")
        sbHTML.Append(MyBase.GetResourceString("STARTDATE"))
        sbHTML.Append("</TD><TD valign=top>")
        sbHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtCurrentStartDate", "txtCurrentStartDate", , 80, m_strCurrentStartDate, , "frmTaskAssignment", returnHTML:=True, IsMandatory:=True))
        sbHTML.Append("</TD>")
        sbHTML.Append("<TD align=right valign=top>")
        sbHTML.Append(MyBase.GetResourceString("ENDDATE"))
        sbHTML.Append("</TD><TD valign=top>")
        sbHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtCurrentEndDate", "txtCurrentEndDate", , 80, m_strCurrentEndDate, , "frmTaskAssignment", returnHTML:=True, IsMandatory:=True))
        sbHTML.Append("</TD></TR>")

        ' Priority.
        sbHTML.Append("<TR class='clsTREven'><TD align=right valign=top>")
        sbHTML.Append(MyBase.GetResourceString("PRIORITY"))
        sbHTML.Append("</TD><TD valign=top>")
        strQuery = "EXEC usp_Sel_tbl_IB_Priorities"
        sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPriority", strQuery, 150, m_strPriority, , True, returnAsHTML:=True, IsMandatory:=True))

        'Display the Deliverable control.
        sbHTML.Append("</TD><TD align=right valign=top>")
        sbHTML.Append(MyBase.GetResourceString("DELIVERABLE"))
        sbHTML.Append("</TD><TD valign=top>")
        'strQuery = "Exec usp_Sel_tbl_PM_OtherSchedules_FillCombo " & m_lngProjectId.ToString()
        'Modified by NikhatM on 24 Feb 2005 for issue id 15377 , deliverable id for add ntask should be disabled 
        'sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDeliverableID", strQuery, 250, m_lngDeliverableId.ToString(), , True, True))

        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDeliverableID", "txtDeliverableID", , 200, , m_strDeliverableId, , , True, True, , , , True, EnableHTMLEncode:=True))
        '''End of Modification by Dhanashri S on 7 Oct 2015 

        'Added by SandipL on 2 Feb 2006 for Task Custom field Functionality
        m_strEnableControlScript += " objtxtDeliverableID = GetObjectReference('frmTaskAssignment','txtDeliverableID'); " + vbCrLf
        m_strEnableControlScript += "if (objtxtDeliverableID!=null) {objtxtDeliverableID.disabled=false;}" + vbCrLf
        'End addition by SandipL

        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHidDeliverableID", "txtHidDeliverableID", , , , m_lngDeliverableId.ToString(), , , , , , True, , True, EnableHTMLEncode:=True))
        '''End of Modification by Dhanashri S on 7 Oct 2015

        sbHTML.Append("&nbsp;" & CommonFunctions.HTMLControls.DrawImage("../../images/dblclick.gif", "imgValidationRules", , "JavaScript:SelectDeliverable()", 12, 12, , True))
        'Modification ends
        '-------------------------------------------------
        'Added By Syamantak Chavan on 3/Jan/2012 for Whiz 11.0
        Dim drDeliverableStageDetails As IDataReader
        Dim strRequestStage As String = ""
        Dim blnIsCurrentStage As Boolean
        Dim strRequestStageID As String = ""

        drDeliverableStageDetails = CommonFunction.Data.GetDataReader("usp_Get_WorkflowEntity_Details 0," + m_lngDeliverableId.ToString() + ",2133 ", True)
        While drDeliverableStageDetails.Read
            blnIsCurrentStage = CType(CommonFunction.Data.CheckIsDBNull(drDeliverableStageDetails("IsCurrentStage"), False), Boolean)
            If blnIsCurrentStage = True Then
                strRequestStage = CommonFunction.Data.CheckIsDBNull(drDeliverableStageDetails("RequestStage"), "")
                strRequestStageID = CommonFunction.Data.CheckIsDBNull(drDeliverableStageDetails("StageID"), "")
            End If
        End While
        CommonFunction.Data.DisposeDataReader(drDeliverableStageDetails)

        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHidDeliverableStageID", "txtHidDeliverableStageID", , , , strRequestStageID.ToString(), , , , , , True, , True, EnableHTMLEncode:=True))
        '''End of Modification by Dhanashri S on 7 Oct 2015

        'End Added By Syamantak Chavan on 3/Jan/2012 for Whiz 11.0

        '----------------------------------------------------
        '--- Added By purvaj on 23 Apr 2009 task validation done against deliverable baseline efforts and dates.

        '---- Added By purvaj on 23 Apr 2009 task validation done against deliverable baseline efforts and dates.
        Dim dr As IDataReader
        Dim strBaselinestartdate As String = ""
        Dim strBaselineenddate As String = ""
        Dim strBaselinework As String = ""
        Dim strPlannedTaskEfforts As String = ""
        dr = CommonFunction.Data.GetDataReader("usp_sel_DeliverableDetails_Taskvalidation " + m_lngDeliverableId.ToString + "," + m_lngTaskId.ToString + "," + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0").ToString, True)
        While dr.Read()
            strBaselinestartdate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("BaselineStartDate"), ""), "")
            'If strBaselinestartdate <> "" Then
            '    strBaselinestartdate = CommonFunction.Dates.CGetDate(strBaselinestartdate)
            'End If
            strBaselineenddate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("BaselineEndDate"), ""), "")
            'If strBaselineenddate <> "" Then
            '    strBaselineenddate = CommonFunction.Dates.CGetDate(strBaselineenddate)
            'End If
            strBaselinework = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("BaselineWork"), "0"), "0")
            strPlannedTaskEfforts = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("PlannedTasksEfforts"), "0"), "0")
        End While
        CommonFunction.Data.DisposeDataReader(dr)
        '---- End addition purvaj

        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtdelBasalinestartDate", "txtdelBasalinestartDate", , 200, , strBaselinestartdate, , , , True, , True, , True, EnableHTMLEncode:=True))
        sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtdelBaselineenddate", "txtdelBaselineenddate", , 200, , strBaselineenddate, , , , True, , True, , True, EnableHTMLEncode:=True))
        sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtdelBaselinework", "txtdelBaselinework", , 200, , strBaselinework, , , , True, , True, , True, EnableHTMLEncode:=True))
        sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtdelPlannedTaskEfforts", "txtdelPlannedTaskEfforts", , 200, , strPlannedTaskEfforts, , , , True, , True, , True, EnableHTMLEncode:=True))
        '''End of Modification by Dhanashri S on 7 Oct 2015

        '--- End addition purvaj
        'Code added by yogeshJ on 19 January 2005
        'This is to persist the value of deliverable field while Adding task to FTR 
        If m_lngTaskId = 0 And m_lngReviewActionId > 0 Then
            sbHTML.Append("&nbsp;<script>")
            sbHTML.Append("frmTaskAssignment.txtDeliverableID.value = opener.frmCommonPage.NonDatabase2.value;")
            sbHTML.Append("frmTaskAssignment.txtHidDeliverableID.value = opener.frmCommonPage.DeliverableID.value;")
            sbHTML.Append("</script>")
        End If
        'Addition ends
        'Added by HarshK for sp4 issueid 200 (showing deliverable of parent page)
        If m_lngTaskId = 0 And m_strMode = MODE_CHANGEMANAGEMENT Then
            sbHTML.Append("&nbsp;<script>")
            sbHTML.Append("frmTaskAssignment.txtDeliverableID.value = opener.frmCommonPage.NonDatabase1.value;")
            sbHTML.Append("frmTaskAssignment.txtHidDeliverableID.value = opener.frmCommonPage.DeliverableID.value;")
            sbHTML.Append("</script>")
        End If
        'End Added by HarshK for sp4 issueid 200
        sbHTML.Append("</TD></TR>")


        intColumnNumber = 0

        ' TASK TYPE.						
        '-----------
        ' If the control must be displayed, then...
        If m_arrControlDetails(ControlIndex.CTRL_INDEX_TASKTYPE, 0) = True Then
            'If first column of New Row then insert the Row tag.
            If intColumnNumber = 0 Then
                sbHTML.Append("<TR class='clsTREven'>")
            End If

            ' Display the control.
            sbHTML.Append("<TD align=right valign=top>")
            sbHTML.Append(MyBase.GetResourceString("TASKTYPE"))
            sbHTML.Append("</TD><TD >")
            strQuery = "EXEC usp_Sel_tbl_PM_Project_TaskTypes_Names " & m_lngProjectId.ToString()
            ' sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTaskType", strQuery, 250, m_strTaskType, , True, returnAsHTML:=True, IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_TASKTYPE, 1)))
            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTaskType", strQuery, 250, m_strTaskType, " onChange=TaskTypeID_OnChange(value)", True, returnAsHTML:=True, IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_TASKTYPE, 1)))
            ' If the control should be mandatory, then...
            If m_arrControlDetails(ControlIndex.CTRL_INDEX_TASKTYPE, 1) = True Then
                ' Build the client side validation script.
                m_sbValidationScript.Append("objControl = GetObjectReference('frmTaskAssignment','cboTaskType');" & vbCrLf)
                m_sbValidationScript.Append("if(disallowBlank(objControl, """ & MyBase.GetResourceString("SELECT_TASK_TYPE") & """))")
                m_sbValidationScript.Append("	return false;" & vbCrLf)
            End If
            sbHTML.Append("</TD>")

            ' Increment the column number. 
            intColumnNumber = (intColumnNumber + 1) Mod 2

            ' After displaying 2 columns end tag of row.
            If intColumnNumber = 0 Then
                sbHTML.Append("</TR>")
            End If
        End If
        ' PHASE.
        '-------
        ' If the control must be displayed, then...
        If m_arrControlDetails(ControlIndex.CTRL_INDEX_PHASE, 0) = True Then
            'If first column of New Row then insert the Row tag.
            If intColumnNumber = 0 Then
                sbHTML.Append("<TR class='clsTREven'>")
            End If

            ' Display the control.
            sbHTML.Append("<TD align=right valign=top>")
            sbHTML.Append(MyBase.GetResourceString("PHASE"))
            sbHTML.Append("</TD><TD valign=top>")
            strQuery = "Exec usp_PRS_GetProjectPhasesForSQA " & m_lngProjectId.ToString()
            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPhaseID", strQuery, 250, m_lngPhaseId.ToString(), , True, True, IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_PHASE, 1)))

            '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txthidPhase", "txthidPhase", value:=m_strPhase, returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True))
            '''End of Modification by Dhanashri S on 7 Oct 2015 

            ' If the control should be mandatory, then...
            If m_arrControlDetails(ControlIndex.CTRL_INDEX_PHASE, 1) = True Then
                ' Build the client side validation script.
                m_sbValidationScript.Append("objControl = GetObjectReference('frmTaskAssignment','cboPhaseID');" & vbCrLf)
                m_sbValidationScript.Append("if(disallowBlank(objControl, """ & MyBase.GetResourceString("SELECT_PHASE") & """))")
                m_sbValidationScript.Append("	return false;" & vbCrLf)
            End If
            sbHTML.Append("</TD>")

            ' Increment the column number. 
            intColumnNumber = (intColumnNumber + 1) Mod 2

            ' After displaying 2 columns end tag of row.
            If intColumnNumber = 0 Then
                sbHTML.Append("</TR>")
            End If
        End If
        ' MODULE.
        '-------
        ' If the control must be displayed, then...
        If m_arrControlDetails(ControlIndex.CTRL_INDEX_MODULE, 0) = True Then
            'If first column of New Row then insert the Row tag.
            If intColumnNumber = 0 Then
                sbHTML.Append("<TR class='clsTREven'>")
            End If

            ' Display the control.
            sbHTML.Append("<TD align=right valign=top>")
            sbHTML.Append(MyBase.GetResourceString("MODULE"))
            sbHTML.Append("</TD><TD valign=top>")
            ' Added By Mahendra On 11:48 AM 5/11/2007  for Module closure impact in Task Creation.
            ' strQuery = "Exec usp_Sel_tbl_PM_Module " & m_lngProjectId.ToString() & ", NULL, 'A'"
            ' Start_MV_5/11/2007
            If m_lngTaskId > 0 Then
                strQuery = "Exec usp_Sel_tbl_PM_Module " & m_lngProjectId.ToString() & ", " & m_lngModuleId.ToString() & ", 'A'," & m_lngTaskId.ToString()

            Else

                strQuery = "Exec usp_Sel_tbl_PM_Module " & m_lngProjectId.ToString() & ", NULL, 'A',NULL"

            End If
            ' End_MV_5/11/2007
            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboModuleID", strQuery, 250, m_lngModuleId.ToString(), , True, True, IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_MODULE, 1)))

            '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txthidModule", "txthidModule", value:=m_strModule, returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True))
            '''End of Modification by Dhanashri S on 7 Oct 2015

            'Added by GokulP on 06 Jun 2009 for Checking whether Module is Baseline or not.
            Dim drModuleBaseline As IDataReader
            Dim m_strModuleBaselineSQL As String = ""
            m_strModuleBaselineSQL = "Usp_Sel_Baseline_List " & m_lngProjectId.ToString() & ",'MODULE'"
            drModuleBaseline = CommonFunctions.Data.GetDataReader(m_strModuleBaselineSQL, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drModuleBaseline) <> "" Then
                If (drModuleBaseline.Read()) Then
                    m_strModuleBaselineIDs = CType(CommonFunctions.Data.CheckIsDBNull(drModuleBaseline.Item("BaselineIDs"), ""), String)
                    If m_strModuleBaselineIDs.Trim = "" Then
                        m_strModuleBaselineIDs = ""
                    End If
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drModuleBaseline)
            'End of Addition by GokulP on 06 Jun 2009 for Checking whether Module is Baseline or not.

            '---- Added By GokulP on 05 Jun 2009 task validation done against Module baseline efforts and dates.

            '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHidModuleID", "txtHidModuleID", , , , m_lngModuleId.ToString(), , , , , , True, , True, EnableHTMLEncode:=True))
            '''End of Modification by Dhanashri S on 7 Oct 2015

            Dim drModule As IDataReader
            Dim strModuleBaselinestartdate As String = ""
            Dim strModuleBaselineenddate As String = ""
            Dim strModuleBaselinework As String = ""
            Dim strPlannedTaskEfforts_Check As String = ""

            drModule = CommonFunction.Data.GetDataReader("usp_sel_ModuleDetails_Taskvalidation " + m_lngModuleId.ToString + "," + m_lngTaskId.ToString + "," + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0").ToString, True)

            While drModule.Read()
                strModuleBaselinestartdate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drModule("BaselineStartDate"), ""), "")
                strModuleBaselineenddate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drModule("BaselineEndDate"), ""), "")
                strModuleBaselinework = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drModule("BaselineWork"), "0"), "0")
                strPlannedTaskEfforts_Check = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drModule("PlannedTasksEfforts"), "0"), "0")
            End While

            CommonFunction.Data.DisposeDataReader(drModule)

            '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtModBasalinestartDate", "txtModBasalinestartDate", , 200, , strModuleBaselinestartdate, , , , True, , True, , True, EnableHTMLEncode:=True))
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtModBaselineenddate", "txtModBaselineenddate", , 200, , strModuleBaselineenddate, , , , True, , True, , True, EnableHTMLEncode:=True))
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtModBaselinework", "txtModBaselinework", , 200, , strModuleBaselinework, , , , True, , True, , True, EnableHTMLEncode:=True))
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtModPlannedTaskEfforts", "txtModPlannedTaskEfforts", , 200, , strPlannedTaskEfforts_Check, , , , True, , True, , True, EnableHTMLEncode:=True))
            '''End of Modification by Dhanashri S on 7 Oct 2015 

            '--- End of addition by GokulP on 05 Jun 2009 task validation done against Module baseline efforts and dates.


            ' If the control should be mandatory, then...
            If m_arrControlDetails(ControlIndex.CTRL_INDEX_MODULE, 1) = True Then
                ' Build the client side validation script.
                m_sbValidationScript.Append("objControl = GetObjectReference('frmTaskAssignment','cboModuleID');" & vbCrLf)
                m_sbValidationScript.Append("if(disallowBlank(objControl, """ & MyBase.GetResourceString("SELECT_MODULE") & """))")
                m_sbValidationScript.Append("	return false;" & vbCrLf)
            End If
            sbHTML.Append("</TD>")

            ' Increment the column number. 
            intColumnNumber = (intColumnNumber + 1) Mod 2

            ' After displaying 2 columns end tag of row.
            If intColumnNumber = 0 Then
                sbHTML.Append("</TR>")
            End If
        End If

        ' SUB PROJECT.
        '-------
        ' If the control must be displayed, then...
        If m_arrControlDetails(ControlIndex.CTRL_INDEX_SUBPROJECT, 0) = True Then
            'If first column of New Row then insert the Row tag.
            If intColumnNumber = 0 Then
                sbHTML.Append("<TR class='clsTREven'>")
            End If

            ' Display the control.
            sbHTML.Append("<TD align=right valign=top>")
            sbHTML.Append(MyBase.GetResourceString("SUBPROJECT"))
            sbHTML.Append("</TD><TD valign=top>")
            ' Added By Mahendra On 12:52 PM 5/14/2007 for SubProject closure impact in Task Creation.
            '  strQuery = "Exec usp_Sel_tbl_PM_SubProject " & m_lngProjectId.ToString() & ", NULL, 'T'"
            ' Start_MV_5/14/2007
            If m_lngTaskId > 0 Then
                strQuery = "Exec usp_Sel_tbl_PM_SubProject " & m_lngProjectId.ToString() & ",NULL,'T'," & m_lngTaskId.ToString()
            Else
                strQuery = "Exec usp_Sel_tbl_PM_SubProject " & m_lngProjectId.ToString() & ", NULL, 'T',NULL"
            End If
            ' End_MV_5/14/2007
            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSubProjectID", strQuery, 250, m_lngSubProjectId.ToString(), , True, True, IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_SUBPROJECT, 1)))

            '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txthidSubProject", "txthidSubProject", value:=m_strSubProject, returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True))
            '''End of Modification by Dhanashri S on 7 Oct 2015 


            ' If the control should be mandatory, then...
            If m_arrControlDetails(ControlIndex.CTRL_INDEX_SUBPROJECT, 1) = True Then
                ' Build the client side validation script.
                m_sbValidationScript.Append("objControl = GetObjectReference('frmTaskAssignment','cboSubProjectID');" & vbCrLf)
                m_sbValidationScript.Append("if(disallowBlank(objControl, """ & MyBase.GetResourceString("SELECT_SUBPROJECT") & """))")
                m_sbValidationScript.Append("	return false;" & vbCrLf)
            End If
            sbHTML.Append("</TD>")

            ' Increment the column number. 
            intColumnNumber = (intColumnNumber + 1) Mod 2

            ' After displaying 2 columns end tag of row.
            If intColumnNumber = 0 Then
                sbHTML.Append("</TR>")
            End If
        End If

        ' MILESTONE.
        '-------
        ' If the control must be displayed, then...
        If m_arrControlDetails(ControlIndex.CTRL_INDEX_MILESTONE, 0) = True Then
            'If first column of New Row then insert the Row tag.
            If intColumnNumber = 0 Then
                sbHTML.Append("<TR class='clsTREven'>")
            End If

            ' Display the control.
            sbHTML.Append("<TD align=right valign=top>")
            sbHTML.Append(MyBase.GetResourceString("MILESTONE"))
            sbHTML.Append("</TD><TD valign=top>")

            ' Added By Mahendra On 5:23 PM 5/15/2007 for SubProject closure impact in Task Creation.
            '   strQuery = "Exec usp_Sel_tbl_PM_Milestones " & m_lngProjectId.ToString() & ", 'T'"
            ' Start_MV_5/15/2007
            If m_lngTaskId > 0 Then
                strQuery = "Exec usp_Sel_tbl_PM_Milestones " & m_lngProjectId.ToString() & ",'T'," & m_lngTaskId.ToString()
            Else
                strQuery = "Exec usp_Sel_tbl_PM_Milestones " & m_lngProjectId.ToString() & ",'T',NULL"
            End If
            ' End_MV_5/15/2007

            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboMilestoneID", strQuery, 250, m_lngMilestoneId.ToString(), , True, True, IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_MILESTONE, 1)))

            '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txthidMilestone", "txthidMilestone", value:=m_strMilestone, returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True))
            '''End of Modification by Dhanashri S on 7 Oct 2015 

            ' If the control should be mandatory, then...
            If m_arrControlDetails(ControlIndex.CTRL_INDEX_MILESTONE, 1) = True Then
                ' Build the client side validation script.
                m_sbValidationScript.Append("objControl = GetObjectReference('frmTaskAssignment','cboMilestoneID');" & vbCrLf)
                m_sbValidationScript.Append("if(disallowBlank(objControl, """ & MyBase.GetResourceString("SELECT_MILESTONE") & """))")
                m_sbValidationScript.Append("	return false;" & vbCrLf)
            End If
            sbHTML.Append("</TD>")

            ' Increment the column number. 
            intColumnNumber = (intColumnNumber + 1) Mod 2

            ' After displaying 2 columns end tag of row.
            If intColumnNumber = 0 Then
                sbHTML.Append("</TR>")
            End If
        End If

        ' CHANGE REQUEST.
        '-------
        ' If the control must be displayed, then...
        If m_arrControlDetails(ControlIndex.CTRL_INDEX_CHANGEREQUEST, 0) = True Then
            'If first column of New Row then insert the Row tag.
            If intColumnNumber = 0 Then
                sbHTML.Append("<TR class='clsTREven'>")
            End If

            ' Display the control.
            sbHTML.Append("<TD align=right valign=top>")
            sbHTML.Append(MyBase.GetResourceString("CHANGEREQUEST"))
            sbHTML.Append("</TD><TD valign=top>")
            strQuery = "Exec usp_Sel_tbl_PM_ChangeRequest_Master " & m_lngProjectId.ToString()
            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboChangeRequestID", strQuery, 250, m_lngChangeRequestId.ToString(), , True, True, IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_CHANGEREQUEST, 1)))

            ' If the control should be mandatory, then...
            If m_arrControlDetails(ControlIndex.CTRL_INDEX_CHANGEREQUEST, 1) = True Then
                ' Build the client side validation script.
                m_sbValidationScript.Append("objControl = GetObjectReference('frmTaskAssignment','cboChangeRequestID');" & vbCrLf)
                m_sbValidationScript.Append("if(disallowBlank(objControl, """ & MyBase.GetResourceString("SELECT_CHANGE_REQUEST") & """))")
                m_sbValidationScript.Append("	return false;" & vbCrLf)
            End If
            sbHTML.Append("</TD>")

            ' Increment the column number. 
            intColumnNumber = (intColumnNumber + 1) Mod 2

            ' After displaying 2 columns end tag of row.
            If intColumnNumber = 0 Then
                sbHTML.Append("</TR>")
            End If
        End If

        '================================================================================================'
        'Added by NitinC on 19 August 2011 for WhizibleSEM v10.0 (Agile Methodology)'
        '================================================================================================'
        'CONTROLS WILL DISPLAY ONLY WHEN THE PROJECT HAS SCRUM PRACTICE
        'Dim m_intFlag As Integer
        'm_intFlag = CInt(CInt(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + m_lngProjectId.ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))))
        If m_intFlag = "1" And CommonFunction.General.CheckIsNothing(Request.QueryString("UserStoryID"), "") = "" Then

            ' USER STORIES.
            '-------

            'If first column of New Row then insert the Row tag.
            If intColumnNumber = 0 Then
                sbHTML.Append("<TR class='clsTREven'>")
            End If

            ' Display the control.
            If m_lngTaskId > 0 Then
                Dim sqlstr As String
                Dim drUS As IDataReader

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                'sqlstr = "SELECT tbl_PM_ScrumUserStory.UserStoryID,UserStoryName,tbl_PM_ScrumRelease.ReleaseName,tbl_PM_ScrumIteration.IterationName "
                'sqlstr += "FROM tbl_PM_ScrumUserStory WITH(NOLOCK) "
                'sqlstr += "INNER JOIN tbl_PM_ScrumRelease  WITH(NOLOCK) ON tbl_PM_ScrumUserStory.ReleaseID = tbl_PM_ScrumRelease.ReleaseID "
                'sqlstr += "INNER JOIN tbl_PM_ScrumIteration WITH(NOLOCK) ON tbl_PM_ScrumUserStory.IterationID = tbl_PM_ScrumIteration.IterationID "
                'sqlstr += "INNER JOIN tbl_PM_ScrumTask WITH(NOLOCK) ON tbl_PM_ScrumUserStory.UserStoryID = tbl_PM_ScrumTask.UserStoryID "
                'sqlstr += "WHERE TaskID = " + CType(m_lngTaskId, String)

                sqlstr = "usp_sel_tbl_PM_ScrumUserStory_IterationName_ReleaseName " + CType(m_lngTaskId, String)
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                drUS = CommonFunctions.Data.GetDataReader(sqlstr, MyBase.UseSQL)
                If drUS.Read() Then
                    m_strUserStory = Trim(drUS.Item("UserStoryID").ToString())
                    m_strRelease = Trim(drUS.Item("ReleaseName").ToString())
                    m_strIteration = Trim(drUS.Item("IterationName").ToString())
                    ''Added By Aniruddh Gujar on 26-Apr-2018 Purpose::Whizible Agile Changes 
                    m_strStoryPoint = Trim(drUS.Item("StoryPoints").ToString())
                    m_strUSStoryPoint = Trim(drUS.Item("InitialEstimate").ToString())
                    ''End of Added By Aniruddh Gujar on 26-Apr-2018 Purpose::Whizible Agile Changes 
                End If
            End If
            sbHTML.Append("<TD align=right valign=top>")
            sbHTML.Append("User Story")
            sbHTML.Append("</TD><TD >")
            'Modified By syamantak Chavan On 6 Jan 2012 for Whizible 11.0 Issue
            'strQuery = "EXEC Usp_Sel_Scrum_UserStories 'cboUserStory'," & m_lngProjectId.ToString()

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strQuery = "SELECT UserStoryID,UserStoryName FROM tbl_PM_ScrumUserStory WITH(NOLOCK) WHERE ProjectID =" & m_lngProjectId.ToString() & " AND ReleaseID IS NOT NULL AND (IsUserStoryComplete = 0 or  IsUserStoryComplete is null)"
            strQuery = "usp_sel_tbl_PM_ScrumUserStory " & m_lngProjectId.ToString()
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            'End Modified By syamantak Chavan On 6 Jan 2012 for Whizible 11.0 Issue
            ' sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTaskType", strQuery, 250, m_strTaskType, , True, returnAsHTML:=True, IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_TASKTYPE, 1)))
            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboUserStory", strQuery, 250, m_strUserStory, " onChange=UserStoryID_OnChange(value)", True, ReturnAsHTML:=True, IsMandatory:=True))

            ' Build the client side validation script.
            m_sbValidationScript.Append("objControl = GetObjectReference('frmTaskAssignment','cboUserStory');" & vbCrLf)
            m_sbValidationScript.Append("if(disallowBlank(objControl, ""Please select user story!""))")
            m_sbValidationScript.Append("	return false;" & vbCrLf)

            sbHTML.Append("</TD>")

            ' Increment the column number. 
            intColumnNumber = (intColumnNumber + 1) Mod 2

            ' After displaying 2 columns end tag of row.
            If intColumnNumber = 0 Then
                sbHTML.Append("</TR>")
            End If


            'RELEASE AND ITERATION TEXT BOX
            '--------------
            sbHTML.Append("<TR class=clsTREven><TD align=right valign=top>")
            sbHTML.Append("Release")
            sbHTML.Append("</TD><TD valign=top>")
            '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRelease", "txtRelease", "clsTextBoxReadOnly", 200, , m_strRelease, "left", , , True, returnHTML:=True, IsMandatory:=False, EnableHTMLEncode:=True))
            '''End of Modification by Dhanashri S on 7 Oct 2015 
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD align=right valign=top>")
            ''Commented and Modified By Aniruddh Gujar on 26-Apr-2018 Purpose::Whizible Agile Changes
            ''sbHTML.Append("Iteration")
            sbHTML.Append("Sprint")
            ''ENd of Commented and Modified By Aniruddh Gujar on 26-Apr-2018 Purpose::Whizible Agile Changes
            sbHTML.Append("</TD><TD valign=top>")
            '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtIteration", "txtIteration", "clsTextBoxReadOnly", 200, , m_strIteration, "left", , , True, returnHTML:=True, IsMandatory:=False, EnableHTMLEncode:=True))
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHdnIsStoryComplete", "txtHdnIsStoryComplete", value:="0", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True))
            '''End of Modification by Dhanashri S on 7 Oct 2015 
            sbHTML.Append("</TD></TR>")

            ''Added By Aniruddh Gujar on 26-Apr-2018 Purpose::Whizible Agile Changes 
            sbHTML.Append("<TR class=clsTREven><TD align=right valign=top>")
            sbHTML.Append("Story Point")
            sbHTML.Append("</TD><TD valign=top>")
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoint", "txtStoryPoint", , 200, , m_strStoryPoint, "left", , , , returnHTML:=True, IsMandatory:=False, EnableHTMLEncode:=True))
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD valign=top>")
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("hdnUSStoryPoint", "hdnUSStoryPoint", , 200, , m_strUSStoryPoint, "left", , , True, returnHTML:=True, IsHidden:=True, IsMandatory:=False, EnableHTMLEncode:=True))
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD valign=top></td>")
            sbHTML.Append("</TR>")

            m_sbValidationScript.Append("objControl = GetObjectReference('frmTaskAssignment','txtStoryPoint');" & vbCrLf)
            m_sbValidationScript.Append("var objUSStoryPoint;" & vbCrLf)
            m_sbValidationScript.Append("objUSStoryPoint = GetObjectReference('frmTaskAssignment','hdnUSStoryPoint');" & vbCrLf)
            m_sbValidationScript.Append("if((parseInt(objControl.value - 0)) > (parseInt(objUSStoryPoint.value - 0))){")
            'Commented And Added By Usha Pandit On 16.07.2020 For giving correct story point count
            'm_sbValidationScript.Append("alert('Story Point should not exceed User story remaining story point(' + ((parseInt(objUSStoryPoint.value - 0))) + ').')" & vbCrLf)
            m_sbValidationScript.Append("var objhdnUSStoryPoint = GetObjectReference('frmTaskAssignment', 'hdnUSStoryPoint');" & vbCrLf)
            m_sbValidationScript.Append("alert('Story Point should not exceed User story remaining story point(' + ((parseInt(objUSStoryPoint.value - objhdnUSStoryPoint.value))) + ').')" & vbCrLf)
            'End Of Added By Usha Pandit On 16.07.2020 For giving correct story point count
            m_sbValidationScript.Append("	return false;}" & vbCrLf)
            ''End of Added By Aniruddh Gujar on 26-Apr-2018 Purpose::Whizible Agile Changes 
        End If 'END IF CONDITION FOR CHECK FLAG FOR SCRUM PRACTICE
        '================================================================================================'
        'End Addition
        '================================================================================================'

        

        ' FEATURE.
        '-------
        ' If the control must be displayed, then...
        If m_arrControlDetails(ControlIndex.CTRL_INDEX_FEATURE, 0) = True Then
            'If first column of New Row then insert the Row tag.
            If intColumnNumber = 0 Then
                sbHTML.Append("<TR class='clsTREven'>")
            End If

            ' Display the control.
            sbHTML.Append("<TD align=right valign=top>")
            sbHTML.Append(MyBase.GetResourceString("FEATURE"))
            sbHTML.Append("</TD><TD valign=top>")
            strQuery = "Exec usp_Sel_tbl_PM_Project_Features NULL, " & m_lngProjectId.ToString()
            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProjectFeatureID", strQuery, 250, m_lngProjectFeatureId.ToString(), , True, True, IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_FEATURE, 1)))

            ' If the control should be mandatory, then...
            If m_arrControlDetails(ControlIndex.CTRL_INDEX_FEATURE, 1) = True Then
                ' Build the client side validation script.
                m_sbValidationScript.Append("objControl = GetObjectReference('frmTaskAssignment','cboProjectFeatureID');" & vbCrLf)
                m_sbValidationScript.Append("if(disallowBlank(objControl, """ & MyBase.GetResourceString("SELECT_FEATURE") & """))")
                m_sbValidationScript.Append("	return false;" & vbCrLf)
            End If
            sbHTML.Append("</TD>")

            ' Increment the column number. 
            intColumnNumber = (intColumnNumber + 1) Mod 2

            ' After displaying 2 columns end tag of row.
            If intColumnNumber = 0 Then
                sbHTML.Append("</TR>")
            End If
        End If

        If intColumnNumber = 1 Then
            sbHTML.Append("<TD colspan=2></TD></TR>")
        End If

        'On Hold
        If m_lngTaskId > 0 Then
            'On Hold Option buttons
            sbHTML.Append("<TR class='clsTREven'>")
            sbHTML.Append("</TD><TD align=right valign=center>")
            sbHTML.Append(MyBase.GetResourceString("ONHOLD"))
            sbHTML.Append("</TD><TD>")
            sbHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkOnHold", "chkOnHold", , m_blnOnHold, "ON", returnHTML:=True))
            sbHTML.Append("</TD>")
            'Void Option buttons
            sbHTML.Append("<TD align=right valign=center>")
            'sbHTML.Append(MyBase.GetResourceString("VOID"))
            sbHTML.Append("</TD><TD>")
            'sbHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkVoid", "chkVoid", , m_blnVoid, "ON", returnHTML:=True))
            sbHTML.Append("</TD></TR>")
        End If
        sbHTML.Append("</TABLE>")

        'Hidden Controls

        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txthidBaselineStartDate", "txthidBaselineStartDate", value:=m_strBaselineStartDate, returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True))
        sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txthidBaselineEndDate", "txthidBaselineEndDate", value:=m_strBaselineEndDate, returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True))

        ''Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
        'sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txthidBaselineWork", "txthidBaselineWork", value:=m_strBaselineWork, returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True))
        If m_strBaselineWork <> "" Then
            ''Added By Ankush T on 15-mar-2019 Purpose::Whizible 2 Work field change
            If m_strBaselineWork.Contains(":") Then
                m_strdispBaselineWork = m_strBaselineWork
            Else
                m_strdispBaselineWork = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + m_strBaselineWork + "',1)", True)
            End If
            ''End of Added By Ankush T on 15-mar-2019 Purpose::Whizible 2 Work field change
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txthidBaselineWork", "txthidBaselineWork", value:=m_strdispBaselineWork, returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True))
        Else
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txthidBaselineWork", "txthidBaselineWork", value:=m_strBaselineWork, returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True))
        End If

        ''End of Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change

        '''End of Modification by Dhanashri S on 7 Oct 2015

        If m_lngTaskId > 0 Then
            sbHTML.Append("<BR><TABLE cellspacing=0; cellpadding=0 class=clsGridTable width='99.9%'>")
            sbHTML.Append("<TR class='clsTRColumnHeader'>")
            sbHTML.Append("<TD>&nbsp;</TD>")
            sbHTML.Append("<TD align=center valign=top style='width:20%'>")
            sbHTML.Append(MyBase.GetResourceString("STARTDATE"))
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD align=center valign=top style='width:20%'>")
            sbHTML.Append(MyBase.GetResourceString("ENDDATE"))
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD align=right valign=top style='width:20%'>")
            sbHTML.Append(MyBase.GetResourceString("DURATION") & "(" & MyBase.GetResourceString("DAYS") & ")")
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD align=right valign=top style='width:20%'>")

            'Commented and Modified By Usha Pandit on 07-Mar-2019 Purpose::Whizible 2 Work field change
            'sbHTML.Append(MyBase.GetResourceString("WORK_HRS"))
            sbHTML.Append("Work (H:M)")
            ''End of Commented and Modified By Usha Pandit  on 07-Mar-2019 Purpose::Whizible 2 Work field change

            sbHTML.Append("</TD>")
            sbHTML.Append("</TR>")

            sbHTML.Append("<TR class='clsTREven'>")
            sbHTML.Append("<TD align=right><B>")
            sbHTML.Append(MyBase.GetResourceString("CURRENT"))
            sbHTML.Append("</B></TD>")
            sbHTML.Append("<TD align=center valign=top>")
            If m_strCurrentStartDate.ToString() <> "" Then

                sbHTML.Append(CommonFunctions.Dates.CGetDate(CType(m_strCurrentStartDate, Date)))
              
            Else
                sbHTML.Append(m_strNbyA)
            End If
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD align=center valign=top>")
            If m_strCurrentEndDate.ToString() <> "" Then
                sbHTML.Append(CommonFunctions.Dates.CGetDate(CType(m_strCurrentEndDate, Date)))
            Else
                sbHTML.Append(m_strNbyA)
            End If
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD align=right valign=top>")
            If m_dblCurrentDuration > 0 Then
                sbHTML.Append(FormatNumber(m_dblCurrentDuration, 1))
            Else
                sbHTML.Append(m_strNbyA)
            End If
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD align=right valign=top>")
            If m_strCurrentWork <> "" Then
                ''Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                'sbHTML.Append(FormatNumber(m_strCurrentWork, 2))

                ''Added By Ankush T on 15-mar-2019 Purpose::Whizible 2 Work field change
                If m_strCurrentWork.Contains(":") Then
                    m_strdispCurrentWork = m_strCurrentWork

                ElseIf IsNumeric(m_strCurrentWork) = True Then
                    m_strdispCurrentWork = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + m_strCurrentWork + "',1)", True)
                Else
                    m_strdispCurrentWork = m_strCurrentWork
                End If
                ''End of Added By Ankush T on 15-mar-2019 Purpose::Whizible 2 Work field change
                sbHTML.Append(m_strdispCurrentWork)
                ''End of Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
            Else
                sbHTML.Append(m_strNbyA)
            End If
            sbHTML.Append("</TD>")
            sbHTML.Append("</TR>")

            sbHTML.Append("<TR class='clsTREven'>")
            sbHTML.Append("<TD align=right><B>")
            sbHTML.Append(MyBase.GetResourceString("BASELINE"))
            sbHTML.Append("</B></TD>")
            sbHTML.Append("<TD align=center valign=top>")
            If m_strBaselineStartDate.ToString() <> "" Then
                sbHTML.Append(CommonFunctions.Dates.CGetDate(CType(m_strBaselineStartDate, Date)))
            Else
                sbHTML.Append(m_strNbyA)
            End If

            sbHTML.Append("</TD>")
            sbHTML.Append("<TD align=center valign=top>")
            If m_strBaselineEndDate.ToString() <> "" Then
                sbHTML.Append(CommonFunctions.Dates.CGetDate(CType(m_strBaselineEndDate, Date)))
            Else
                sbHTML.Append(m_strNbyA)
            End If

            sbHTML.Append("</TD>")
            sbHTML.Append("<TD align=right valign=top>")
            If m_dblBaselineDuration > 0 Then
                sbHTML.Append(FormatNumber(m_dblBaselineDuration, 1))
            Else
                sbHTML.Append(m_strNbyA)
            End If
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD align=right valign=top>")
            If m_strBaselineWork <> "" Then
                ''Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                'sbHTML.Append(FormatNumber(m_strBaselineWork, 2))
                ''Added By Ankush T on 15-mar-2019 Purpose::Whizible 2 Work field change
                If m_strBaselineWork.Contains(":") Then
                    m_strdispBaselineWork = m_strBaselineWork

                Else
                    m_strdispBaselineWork = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + m_strBaselineWork + "',1)", True)

                End If
                ''End of Added By Ankush T on 15-mar-2019 Purpose::Whizible 2 Work field change

                sbHTML.Append(m_strdispBaselineWork)
                ''End of Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
            Else
                sbHTML.Append(m_strNbyA)
            End If
            sbHTML.Append("</TD>")
            sbHTML.Append("</TR>")

            sbHTML.Append("<TR class='clsTREven'>")
            sbHTML.Append("<TD align=right><B>")
            sbHTML.Append(MyBase.GetResourceString("ACTUAL"))
            sbHTML.Append("</B></TD>")
            sbHTML.Append("<TD align=center valign=top>")
            If m_strActualStartDate.ToString() <> "" Then
                sbHTML.Append(CommonFunctions.Dates.CGetDate(CType(m_strActualStartDate, Date)))
            Else
                sbHTML.Append(m_strNbyA)
            End If
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD align=center valign=top>")
            If m_strActualEndDate.ToString() <> "" Then
                sbHTML.Append(CommonFunctions.Dates.CGetDate(CType(m_strActualEndDate, Date)))
            Else
                sbHTML.Append(m_strNbyA)
            End If

            sbHTML.Append("</TD>")
            sbHTML.Append("<TD align=right valign=top>")
            If m_dblActualDuration > 0 Then
                sbHTML.Append(FormatNumber(m_dblActualDuration, 1))
            Else
                sbHTML.Append(m_strNbyA)
            End If
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD align=right valign=top>")
            If m_strActualWork <> "" Then
                ''Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                'sbHTML.Append(FormatNumber(m_strActualWork, 2))
                m_strdispActualWork = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + m_strActualWork + "',1)", True)
                sbHTML.Append(m_strdispActualWork)
                ''End of Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
            Else
                sbHTML.Append(m_strNbyA)
            End If
            sbHTML.Append("</TD>")
            sbHTML.Append("</TR>")

            sbHTML.Append("</TABLE>")

        End If
        CommonFunctions.General.WriteHTML(sbHTML.ToString())

        'Code added by SandipL for Custom Fields Functionality
        'If m_lngTaskId > 0 Then
        Dim ObjCustomFieldsSection As New WebPage.Templates.SectionTitle
        With ObjCustomFieldsSection
            Response.Write(.GetSectionTitle(MyBase.GetResourceString("CUSTOMFIELDS"), "DivCustomFieldsSection", "HideShowCustomFieldsSection"))

            'Write ClientsideScript in order to show hide the section
            Response.Write("<SCRIPT Language=javascript>")
            Response.Write(.ClientsideScript)
            Response.Write("</SCRIPT>")
        End With
        Response.Write("<DIV id=DivCustomFieldsSection width='100%' style='overflow:auto'>")
        'plot all custom fields, if any
        'Call PlotCustomFields()

        ' Code added by SwapnilR on 7th Nov 2006 for Whiziblesem SP8 Issue ID.7167
        ' Purpose : If page is called for copy task then task id will be set to the copied task
        '           and the default values w.r.t. task will be displayed for that respective 
        '           variables are set to values of the copied task
        Dim strTaskID As String
        Dim strDummyTask As String
        Dim blnDummyDefaultValue As Boolean
        strTaskID = CommonFunction.General.CheckIsNothing(Request.QueryString("CopyTask"), "")
        If strTaskID <> "" Then
            strDummyTask = strTaskID
            blnDummyDefaultValue = False
        Else
            strDummyTask = m_lngTaskId.ToString()
            blnDummyDefaultValue = m_blnShowDefaults
        End If
        ' End of code addition by SwapnilR on 7th Nov 2006 for Whiziblesem SP8 Issue ID.7167
        Dim objCustomFields As New PM_CustomFields
        With objCustomFields
            .EntityName = "Task"
            .FormName = "frmTaskAssignment"
            .PrimaryKey = "TaskID"
            .PrimaryTable = "tbl_PM_ProjectTasks"
            .TypeID = m_strCurrentType
            ' Code added by SwapnilR on 7th Nov 2006 for Whiziblesem SP8 Issue ID.7167
            .IsAddNewMode = blnDummyDefaultValue
            .PrimaryKeyValue = CType(strDummyTask, Long)
            ' End of code addition by SwapnilR on 7th Nov 2006
            .QueryStringForTypeChange = "TaskTypeID"
            .m_lngProjectId = m_lngProjectId
            .PlotCustomFields()
            declarevariables = .VariableDeclarationScript
            strClientSideScript = .ValidationScript
            strDefaultScript = .DefaultValueScript
            m_strCustomFieldList = .AccesibleCustomFields
        End With

        Response.Write("</DIV>")
        '  End If
        'End addition by SandipL

        If Not m_strProjectSetting = PROJECT_SETTING_NORMAL Then
            'To Display the Resources List
            If m_lngTaskId > 0 Then
                objSectionTitle = New WebPages.Template.SectionTitle
                CommonFunctions.General.WriteHTML("<BR>")
                objSectionTitle.GetSectionTitle(MyBase.GetResourceString("RESOURCES"), "", "")
                objSectionTitle = Nothing

                Call DisplayResourcesList()

                ' Added By NitinVS on 10 March 2005 for PBNITE SP2
                ' To show the details of Documents uploaded 
                objSectionTitle = New WebPages.Template.SectionTitle
                CommonFunctions.General.WriteHTML("<BR>")
                objSectionTitle.GetSectionTitle("Document(s)", "", "")
                objSectionTitle = Nothing
                Call DisplayDocumentList()
                ' End Addition By NitinVS on 10 MArch 2005 for PBNITE SP2

            End If
            'Added By NitinVS on 12 Apr 2005 for PBNITE SP2 To Show Documents Grid for CASE 3 
        Else
            If m_lngTaskId > 0 Then
                objSectionTitle = New WebPages.Template.SectionTitle
                CommonFunctions.General.WriteHTML("<BR>")
                objSectionTitle.GetSectionTitle("Document(s)", "", "")
                objSectionTitle = Nothing
                Call DisplayDocumentList()
            End If
            ' End Addition By NitinVS on 10 MArch 2005 for PBNITE SP2
        End If



        CommonFunctions.General.WriteHTML("</DIV>")
        '--- added By PurvaJ on 7 Nov 2008 for Whiziblesem 8.0
        '--- validation : Current Work hours should not be less than actual work hours.

        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        CommonFunction.HTMLControls.DrawTextBox("hid_txtActualWork", "hid_txtActualWork", , 200, , m_strActualWork.ToString, , , , , , True, EnableHTMLEncode:=True)
        Dim strPlannedWork As String
        strPlannedWork = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_PlannedWorkHours_ChildTasks " + m_lngTaskId.ToString, True), "0"), "0")
        CommonFunction.HTMLControls.DrawTextBox("hid_txtPlannedWork", "hid_txtPlannedWork", , 200, , strPlannedWork.ToString, , , , , , True, EnableHTMLEncode:=True)
        '''End of Modification by Dhanashri S on 7 Oct 2015 

        '--- end addition purvaj
        'Added by TruptiK on 24-Mar-09
        '--- validation : Current Date should not be less than actual date.
        'CommonFunction.HTMLControls.DrawTextBox("hid_txtActualWork", "hid_txtActualWork", , 200, , m_strActualWork.ToString, , , , , , True)
        Dim TaskEndDate As String
        Dim TaskStartDate As String
        'Added by TruptiK on 13-Apr-09
        Dim ModeCopy As String
        'End of addition by TruptiK on 13-Apr-09 
        TaskEndDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_TaskEndDate_ChildTasks " + m_lngTaskId.ToString, True), ""), "")
        TaskStartDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_TaskStartDate_ChildTasks " + m_lngTaskId.ToString, True), ""), "")
        If TaskEndDate <> "" Then

            '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
            CommonFunction.HTMLControls.DrawTextBox("hid_txtTaskEndDate", "hid_txtTaskEndDate", , 200, , CDate(TaskEndDate).ToString("dd-MMM-yyyy"), , , , , , True, EnableHTMLEncode:=True)
        Else
            CommonFunction.HTMLControls.DrawTextBox("hid_txtTaskEndDate", "hid_txtTaskEndDate", , 200, , TaskEndDate, , , , , , True, EnableHTMLEncode:=True)
        End If
        If TaskStartDate <> "" Then
            CommonFunction.HTMLControls.DrawTextBox("hid_txtTaskStartDate", "hid_txtTaskStartDate", , 200, , CDate(TaskStartDate).ToString("dd-MMM-yyyy"), , , , , , True, EnableHTMLEncode:=True)
        Else
            CommonFunction.HTMLControls.DrawTextBox("hid_txtTaskStartDate", "hid_txtTaskStartDate", , 200, , TaskStartDate, , , , , , True, EnableHTMLEncode:=True)
        End If
        'Added by TruptiK on 13-Apr-09
        ModeCopy = CommonFunction.General.CheckIsNothing(Request.QueryString("CopyTask"))
        If ModeCopy = "" Then
            If m_strActualStartDate <> "" Then
                CommonFunction.HTMLControls.DrawTextBox("hid_txtActualStartDate", "hid_txtActualStartDate", , 200, , CDate(m_strActualStartDate).ToString("dd-MMM-yyyy"), , , , , , True, EnableHTMLEncode:=True)
            Else
                CommonFunction.HTMLControls.DrawTextBox("hid_txtActualStartDate", "hid_txtActualStartDate", , 200, , m_strActualStartDate, , , , , , True, EnableHTMLEncode:=True)
            End If
            'Added by GokulP on 08 Oct 2009 for IssueID : 32455
            If m_strTaskMaxEntryDate <> "" Then
                CommonFunction.HTMLControls.DrawTextBox("hid_txtActualEndDate", "hid_txtActualEndDate", , 200, , CDate(m_strTaskMaxEntryDate).ToString("dd-MMM-yyyy"), , , , , , True, EnableHTMLEncode:=True)
            Else
                CommonFunction.HTMLControls.DrawTextBox("hid_txtActualEndDate", "hid_txtActualEndDate", , 200, , m_strTaskMaxEntryDate, , , , , , True, EnableHTMLEncode:=True)
            End If
            'End of Addition by GokulP on 08 Oct 2009 for IssueID : 32455
        Else
            CommonFunction.HTMLControls.DrawTextBox("hid_txtActualStartDate", "hid_txtActualStartDate", , 200, , "0", , , , , , True, EnableHTMLEncode:=True)
            'Added by GokulP on 08 Oct 2009 for IssueID : 32455
            CommonFunction.HTMLControls.DrawTextBox("hid_txtActualEndDate", "hid_txtActualEndDate", , 200, , "0", , , , , , True, EnableHTMLEncode:=True)
            '''End of Modification by Dhanashri S on 7 Oct 2015 

            'End of Addition by GokulP on 08 Oct 2009 for IssueID : 32455
        End If
        'End of Addition by TruptiK on 24-Mar-09
    End Sub

    Private Sub DisplayResourcesList()
        Dim strQuery As String = ""
        'Modified by nitinvs on 25 May 2007 for WhizibleSEM 7 Performance changes
        ' Reading SubTaskType from source changed actualcolumn name from SubTaskTypes to Activity which has the subTaskType 
        'Added one parameter for ActualWork in each of the grid parameters by DipaliS for IssueId 13468
        Dim arrActualColumns() As String = {"UserName", "Activity", "Work", "StartDate", "EndDate", "ActualWork", ""}
        'Commented and Modified By Usha Pandit  on 07-Mar-2019 Purpose::Whizible 2 Work field change
        'Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("RESOURCE"), _
        '                                         MyBase.GetResourceString("ACTIVITY"), _
        '                                         MyBase.GetResourceString("WORK_HRS"), _
        '                                         MyBase.GetResourceString("STARTDATE"), _
        '                                         MyBase.GetResourceString("ENDDATE"), _
        '                                        MyBase.GetResourceString("ACTUALWORK"), _
        '                                         MyBase.GetResourceString("DELETE")}

        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("RESOURCE"), _
                                               MyBase.GetResourceString("ACTIVITY"), _
                                              "Work (H:M)", _
                                               MyBase.GetResourceString("STARTDATE"), _
                                               MyBase.GetResourceString("ENDDATE"), _
                                              "Actual Work (H:M)", _
                                               MyBase.GetResourceString("DELETE")}

        ''End of Commented and Modified By Usha Pandit  on 07-Mar-2019 Purpose::Whizible 2 Work field change

        Dim arrCheckBoxId() As String = {"", "", "", "", "", "", "chkDelete"}
        Dim arrRowLink() As String = {"AssignResources_OnClick(TaskID,EmployeeID)"}
        Dim arrTDStyle() As String = {"align='left' nowrap", "align='left'", "align='right'", _
                                      "align='center' nowrap", "align='center' nowrap", "align='right'"}

        ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''End of Addition by Dhanashri S on 7 Oct 2015

        strQuery = "EXEC usp_Sel_tbl_PM_AssignedTaskResources " & m_lngProjectId.ToString()
        strQuery &= ", " & m_lngTaskId.ToString() & ", NULL"
        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .CheckBoxIDArray = arrCheckBoxId
            .RowLinkArray = arrRowLink
            .TDStyleArray = arrTDStyle
            .EmptyValueReplacement = "&nbsp;"
            .PrimaryKey = "TaskID"
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            'Commented and Added by ShraddhaM on 4,Sep 2007
            'the Document upload details available in Assigned Task Page moves up and down when the Resource data is scrolled
            '.DIVID = "DivList"
            .DIVID = "DivList1"
            'End of addition by ShraddhaM
            .DIVHeight = 120
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = 6
            .returnHTML = True
            ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            ''End of Addition by Dhanashri S on 7 Oct 2015
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
    End Sub

    Private Sub DisplayDocumentList()

        '=====================================================================
        ' Procedure Name		:	DisplayDocumentList
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To Show the list of documents uploaded with the task
        ' Description			:	Same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	NitinVS
        ' Created				:	Mar 10 2005
        ' Revisions				:	
        '=====================================================================
        Dim arrlstColHeader As Collections.ArrayList
        Dim arrlstAN As Collections.ArrayList
        Dim arrlstRowLink As Collections.ArrayList
        Dim arrlstTDStyle As Collections.ArrayList
        Dim arrlstCheckBox As Collections.ArrayList
        Dim strSQL As String
        Dim intRowCount As Integer
        Dim m_strRoleID As String

        ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''End of Addition by Dhanashri S on 7 Oct 2015

        m_strRoleID = Session("intPostID").ToString + ""

        arrlstColHeader = New Collections.ArrayList
        arrlstAN = New Collections.ArrayList
        arrlstRowLink = New Collections.ArrayList
        arrlstTDStyle = New Collections.ArrayList
        arrlstCheckBox = New Collections.ArrayList

        ' Set the Resource file to PM_Documents
        MyBase.InitializeResources("AppResources.PM_ProjectDocuments", "AppResources")

        'create the list of columns
        arrlstColHeader.Add(MyBase.GetResourceString("CAP_CATEGORY")) : arrlstColHeader.Add("Document Sub Category") : arrlstColHeader.Add(MyBase.GetResourceString("COL_DOCUMENT_NAME")) : arrlstColHeader.Add(MyBase.GetResourceString("COL_UPLOAD_DATE")) : arrlstColHeader.Add(MyBase.GetResourceString("COL_SIZE")) : arrlstColHeader.Add(MyBase.GetResourceString("COL_LAST_MODIFIED")) : arrlstColHeader.Add(MyBase.GetResourceString("COL_REVIEW")) : arrlstColHeader.Add(MyBase.GetResourceString("COL_HISTORY"))
        arrlstAN.Add("Category") : arrlstAN.Add("SubCategory") : arrlstAN.Add("FileName") : arrlstAN.Add("UploadedDate") : arrlstAN.Add("FileSize") : arrlstAN.Add("UpdatedDate") : arrlstAN.Add(MyBase.GetResourceString("LINK_REVIEW")) : arrlstAN.Add(MyBase.GetResourceString("LINK_HISTORY"))
        arrlstRowLink.Add("") : arrlstRowLink.Add("") : arrlstRowLink.Add("Document_OnClick(DocumentID)") : arrlstRowLink.Add("") : arrlstRowLink.Add("") : arrlstRowLink.Add("") : arrlstRowLink.Add("Review_OnClick(DocumentID)") : arrlstRowLink.Add("History_OnClick(DocumentID,DocumentRefID)")
        arrlstCheckBox.Add("") : arrlstCheckBox.Add("") : arrlstCheckBox.Add("") : arrlstCheckBox.Add("") : arrlstCheckBox.Add("") : arrlstCheckBox.Add("") : arrlstCheckBox.Add("") : arrlstCheckBox.Add("")
        arrlstTDStyle.Add("align='left'") : arrlstTDStyle.Add("align='left'") : arrlstTDStyle.Add("align='left'") : arrlstTDStyle.Add("align='left'") : arrlstTDStyle.Add("align='left'") : arrlstTDStyle.Add("align='Left'") : arrlstTDStyle.Add("align='left'") : arrlstTDStyle.Add("align='left'") : arrlstTDStyle.Add("align='left'")

        'set the delete column of the grid if user has delete access

        If m_objAccessRights.Delete = True Then
            arrlstColHeader.Add(MyBase.GetResourceString("COL_DELETE"))
            arrlstAN.Add("")
            arrlstRowLink.Add("")
            arrlstTDStyle.Add("align='center'")
            arrlstCheckBox.Add("chkDeleteDocument")
        End If

        Dim arrColHeader(arrlstColHeader.Count) As String
        Dim arrAN(arrlstAN.Count) As String
        Dim arrRowLink(arrlstRowLink.Count) As String
        Dim arrCheckBox(arrlstCheckBox.Count) As String
        Dim arrTDStyle(arrlstTDStyle.Count) As String
        Dim arrGroupOn() As String = {"1"}

        arrlstColHeader.CopyTo(arrColHeader)
        arrlstAN.CopyTo(arrAN)
        arrlstRowLink.CopyTo(arrRowLink)
        arrlstCheckBox.CopyTo(arrCheckBox)
        arrlstTDStyle.CopyTo(arrTDStyle)

        arrlstColHeader = Nothing
        arrlstAN = Nothing
        arrlstRowLink = Nothing
        arrlstTDStyle = Nothing
        arrlstCheckBox = Nothing

        strSQL = "usp_sel_tbl_PM_ProjectDocuments_for_Assigned_Task " + m_lngProjectId.ToString.Trim + "," + m_lngTaskId.ToString + " , " + m_strRoleID.Trim

        'create Grid object and set the properties
        m_objGridDocument = New WebPage.Templates.GenericGrid
        With m_objGridDocument
            .ActualColumnArray = arrAN
            .UserFriendlyColumnArray = arrColHeader
            .RowLinkArray = arrRowLink
            .CheckBoxIDArray = arrCheckBox
            .GroupOnColumn = arrGroupOn
            .TDStyleArray = arrTDStyle
            .PrimaryKey = "DocumentID"
            'Commented and Added by ShraddhaM on 4,Sep 2007
            'the Document upload details available in Assigned Task Page moves up and down when the Resource data is scrolled
            '.DIVID = "DivList"
            .DIVID = "DivList2"
            'End of comment and addition by ShraddhaM on 4,Sep 2007
            'Commented and Added by Viraj
            ' .DIVHeight = 150
            'End of Comment  by Viraj P on 17 Nov 2015
            .DIVStyle = "overflow:auto width:100%;"
            .NoOfDataColumns = 8
            .PrinterFriendlyVersion = False
            .VerticalDisplay = False
            .ColNameToolTipOnEachRow = True
            .returnHTML = False
            .ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = ""
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            ''End of Addition by Dhanashri S on 7 Oct 2015
            .DrawGrid()
        End With
        intRowCount = m_objGridDocument.NoOfRows
        m_objGridDocument = Nothing

        'save the record count in the hidden control
        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txthdRowCount", "txthdRowCount", , , , intRowCount.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        '''End of Modification by Dhanashri S on 7 Oct 2015 

        MyBase.InitializeResources("AppResources.PM_TaskAssignment", "AppResources")

    End Sub



#Region " Database Related Functions Or Procedures "
    Private Sub GetTaskDetails()
        Dim strQuery As String
        Dim drWork As IDataReader
        Dim lngCReviewTypeId As Long = 0
        Dim lngToolsId As Long = 0
        Dim lngTempID As Long = 0

        ' Code added by SwapnilR on 7th Nov 2006  for Whiziblesem SP8 Issue ID.7167
        ' Purpose : If page is called for copy task then Task Id will be w.r.t. 
        '           copied task. By setting this variable to TaskID variable, all 
        '           default values of the task will be selected.
        Dim strTaskID As String
        Dim strDummyTask As String
        strTaskID = CommonFunction.General.CheckIsNothing(Request.QueryString("CopyTask"), "")
        If strTaskID <> "" Then
            strDummyTask = strTaskID
        Else
            strDummyTask = m_lngTaskId.ToString()
        End If
        ' End of code addition by SwapnilR on 7th Nov 2006

        ' Code added by SwapnilR on 7th Nov 2006  for Whiziblesem SP8 Issue ID.7167
        ' Purpose : Instead of m_lngTaskID, strDummayTaskID will be passed.
        '           Change due to copy task functionality
        If CType(strDummyTask, Integer) > 0 Then
            strQuery = "Exec usp_Sel_tbl_PM_ProjectTasks_TaskAssignment " & strDummyTask.ToString()
            ' End of code modification by SwapnilR on 7th Nov 2007
            strQuery &= "," & m_lngProjectId.ToString()

            drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                If drWork.Read() Then
                    m_strEmployeeId = CommonFunctions.Data.CheckIsDBNull(drWork.Item("EmployeeID")).ToString()
                    m_strUserName = Trim(drWork.Item("UserName").ToString())
                    m_strUserName = CommonFunctions.General.UnBuildQueryString(m_strUserName)
                    m_strTaskName = Trim(drWork.Item("TaskName").ToString())
                    m_strTaskName = CommonFunctions.General.UnBuildQueryString(m_strTaskName)
                    m_strTaskNotes = Trim(drWork.Item("TaskNotes").ToString())
                    m_strTaskNotes = CommonFunctions.General.UnBuildQueryString(m_strTaskNotes)
                    m_strTaskType = Trim(drWork.Item("ModuleName").ToString())

                    '' START : ParagD On 23-Aug-2006
                    ''m_strTaskType = CommonFunctions.General.UnBuildQueryString(m_strTaskType)
                    '' END : ParagD On 23-Aug-2006

                    m_strCurrentStartDate = drWork.Item("StartDate").ToString()
                    If m_strCurrentStartDate <> "" Then
                        m_strCurrentStartDate = CommonFunctions.Dates.GetDate(CType(m_strCurrentStartDate, Date))
                    End If

                    m_strBaselineStartDate = drWork.Item("BaselineStart").ToString()
                    If m_strBaselineStartDate <> "" Then
                        m_strBaselineStartDate = CommonFunctions.Dates.GetDate(CType(m_strBaselineStartDate, Date))
                    End If


                    m_strActualStartDate = drWork.Item("ActualStartDate").ToString()
                    If m_strActualStartDate <> "" Then
                        m_strActualStartDate = CommonFunctions.Dates.GetDate(CType(m_strActualStartDate, Date))
                    End If

                    m_strCurrentEndDate = drWork.Item("EndDate").ToString()
                    If m_strCurrentEndDate <> "" Then
                        m_strCurrentEndDate = CommonFunctions.Dates.GetDate(CType(m_strCurrentEndDate, Date))
                    End If

                    m_strBaselineEndDate = drWork.Item("BaselineEnd").ToString()
                    If m_strBaselineEndDate <> "" Then
                        m_strBaselineEndDate = CommonFunctions.Dates.GetDate(CType(m_strBaselineEndDate, Date))
                    End If

                    m_strActualEndDate = drWork.Item("ActualEndDate").ToString()
                    If m_strActualEndDate <> "" Then
                        m_strActualEndDate = CommonFunctions.Dates.GetDate(CType(m_strActualEndDate, Date))
                    End If

                    'Added by GokulP on 10 Oct 2009 for IssueID : 32455
                    m_strTaskMaxEntryDate = drWork.Item("DAMaxEntryDate").ToString()
                    If m_strTaskMaxEntryDate <> "" Then
                        m_strTaskMaxEntryDate = CommonFunctions.Dates.GetDate(CType(m_strTaskMaxEntryDate, Date))
                    End If
                    'End of Addition by GokulP on 10 Oct 2009 for IssueID : 32455

                    m_dblCurrentDuration = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("Duration"), "0"), Double)
                    m_dblBaselineDuration = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("BaselineDuration"), "0"), Double)
                    m_dblActualDuration = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ActualDuration"), "0"), Double)
                    m_strCurrentWork = CommonFunctions.Data.CheckIsDBNull(drWork.Item("Work"), "").ToString()
                    m_strBaselineWork = CommonFunctions.Data.CheckIsDBNull(drWork.Item("BaselineWork"), "").ToString()
                    m_strActualWork = CommonFunctions.Data.CheckIsDBNull(drWork.Item("ActualWork"), "").ToString()
                    m_strPriority = Trim(drWork.Item("Priority").ToString())
                    m_strPriority = CommonFunctions.General.UnBuildQueryString(m_strPriority)
                    m_lngPhaseId = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("PhaseID"), "0"), Long)
                    m_strPhase = Trim(drWork.Item("Phase").ToString())
                    m_strPhase = CommonFunctions.General.UnBuildQueryString(m_strPhase)
                    m_lngModuleId = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ModuleID"), "0"), Long)
                    m_strModule = Trim(drWork.Item("Module").ToString())
                    m_strModule = CommonFunctions.General.UnBuildQueryString(m_strModule)
                    m_lngSubProjectId = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("SubProjectID"), "0"), Long)
                    m_strSubProject = Trim(drWork.Item("SubProject").ToString())
                    m_strSubProject = CommonFunctions.General.UnBuildQueryString(m_strSubProject)
                    m_lngMilestoneId = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("MilestoneID"), "0"), Long)
                    m_strMilestone = Trim(drWork.Item("Milestone").ToString())
                    m_strMilestone = CommonFunctions.General.UnBuildQueryString(m_strMilestone)
                    m_lngChangeRequestId = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ChangeRequestID"), "0"), Long)
                    m_lngProjectFeatureId = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ProjectFeatureID"), "0"), Long)
                    m_lngDeliverableId = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("DeliverableID"), "0"), Long)
                    m_strDeliverableId = GetDeliverableName(m_lngDeliverableId)
                    m_lngProjectEstimationTypeId = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ProjectEstimationTypeID"), "0"), Long)
                    m_blnIsDeferredTask = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("IsDeferredTask"), "False"), Boolean)
                    m_blnBillable = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("BillableYN"), "False"), Boolean)
                    m_blnIsTaskComplete = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("IsTaskComplete"), "False"), Boolean)
                    'm_blnVoid = Not CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("IsActive"), "False"), Boolean)
                    m_blnOnHold = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("TaskOnHold"), "False"), Boolean)

                    'Added by SandipL

                    m_strCurrentType = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("TaskTypeID"), "0"), String)
                    'End addition by SandipL

                    'Get the Actual Work

                    ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                    'strQuery = "SELECT Isnull(SUM(ActualWork),0) as ActualWork FROM tbl_PM_ProjectTasks WHERE ParentTask_UID = " & m_lngTaskId.ToString()
                    strQuery = "usp_sel_tbl_PM_ProjectTasks_SUM_ActualWork " & m_lngTaskId.ToString()
                    '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                    ' Modified By NitinVS on 3 May 2005 for WhizibleSEM SP3 IssueID 17096
                    ' For case 1 we are getting the details for the child task 
                    If m_HaveSubTaskTypes = False And m_ApplyEffortDistribution = False Then
                        ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                        strQuery = "usp_sel_tbl_PM_ProjectTasks_SUM_ActualWork_TaskID " & m_lngTaskId.ToString()
                        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
                    End If
                    ' End Modification By NitinVS on  3 May 2005 for WhizibleSEM SP3 IssueID 17096

                    m_strActualWork = CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL).ToString()
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drWork)
        ElseIf m_lngReviewActionId > 0 Then
            m_strCurrentStartDate = CommonFunctions.Dates.GetDate(Now())
            m_strCurrentEndDate = CommonFunctions.Dates.GetDate(Now())

            strQuery = "Exec usp_Sel_tbl_PM_ReviewActions " & m_lngReviewActionId.ToString()
            drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                If drWork.Read() Then
                    m_strTaskName = Trim(drWork.Item("PReviewCause").ToString())
                    m_strTaskName = CommonFunctions.General.UnBuildQueryString(m_strTaskName)
                    m_strTaskNotes = Trim(drWork.Item("Action").ToString())
                    m_strTaskNotes = CommonFunctions.General.UnBuildQueryString(m_strTaskNotes)
                    m_lngReviewStatisticsId = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ReviewStatisticsID"), "0"), Long)
                    m_strCurrentWork = CommonFunctions.Data.CheckIsDBNull(drWork.Item("WorkInHours"), "").ToString()
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drWork)
            If m_lngReviewStatisticsId > 0 Then
                'Added by SatyanarayanaA on 13-Jan-2006 for Reviewee ID by using Action ID(Second Parameter)
                strQuery = "Exec usp_Sel_tbl_PM_ReviewStatistics " & m_lngReviewStatisticsId.ToString() & "," & m_lngReviewActionId.ToString()
                'Ended by SatyanarayanaA on 13-Jan-2006 for Reviewee ID by using Action ID(Second Parameter)
                drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                    If drWork.Read() Then
                        lngCReviewTypeId = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("CReviewTypeID"), "0"), Long)
                        m_strEmployeeId = CommonFunctions.Data.CheckIsDBNull(drWork.Item("EmployeeID"), "").ToString()


                        m_strPhase = Trim(drWork.Item("ProjectPhase").ToString())
                        m_strPhase = CommonFunctions.General.UnBuildQueryString(m_strPhase)
                        m_lngModuleId = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ModuleID"), "0"), Long)
                        'Code Added By VidyaJ on 10th Feb 2004 - For IssueID - 15376
                        m_strIssueIDs = CommonFunctions.Data.CheckIsDBNull(drWork.Item("IssueIds"), "").ToString()
                        'End Of addition
                    End If
                End If
                CommonFunctions.Data.DisposeDataReader(drWork)
                If m_strPhase <> "" Then
                    strQuery = "SELECT ProjectPhaseID FROM tbl_IB_Project_Phases "
                    strQuery &= "WHERE ProjectID = " & m_lngProjectId.ToString()
                    strQuery &= " AND Phase = '" & CommonFunctions.General.BuildQueryString(m_strPhase) & "'"
                    m_lngPhaseId = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Long)
                End If
            End If
            m_blnBillable = False
            If lngCReviewTypeId > 0 Then
                strQuery = "Exec usp_Sel_tbl_PM_CorporateReviewTypes " & lngCReviewTypeId.ToString()
                drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                    If drWork.Read() Then
                        m_strTaskType = Trim(drWork.Item("TaskType").ToString())
                        m_strTaskType = CommonFunctions.General.UnBuildQueryString(m_strTaskType)
                    End If
                End If
                CommonFunctions.Data.DisposeDataReader(drWork)
            End If
            If m_strTaskType = "" Then
                strQuery = "Exec usp_Sel_tbl_PM_Project_TaskTypes_Names " & m_lngProjectId.ToString() & ", 1"
                drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                    If drWork.Read() Then
                        m_strTaskType = Trim(drWork.Item("TaskType").ToString())
                        m_strTaskType = CommonFunctions.General.UnBuildQueryString(m_strTaskType)
                    End If
                End If
                CommonFunctions.Data.DisposeDataReader(drWork)
            End If
        ElseIf m_lngMitigationPlanId > 0 Then
            strQuery = "Exec usp_Sel_tbl_PM_MitigationPlans " & m_lngProjectId.ToString()
            strQuery &= ", " & m_lngRiskId.ToString() & ", " & m_lngMitigationPlanId.ToString()
            drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                If drWork.Read() Then
                    m_strUserName = Trim(drWork.Item("Responsibility").ToString())
                    m_strUserName = CommonFunctions.General.UnBuildQueryString(m_strUserName)
                    m_strTaskName = "Mitigation Plan ID : " & Trim(drWork.Item("MitigationPlanID").ToString())
                    m_strTaskName &= " [Risk ID : " & Trim(drWork.Item("RiskID").ToString()) & "]-->"
                    m_strTaskName = CommonFunctions.General.UnBuildQueryString(m_strTaskName)
                    m_strTaskNotes = Trim(drWork.Item("Action").ToString())
                    m_strTaskNotes = CommonFunctions.General.UnBuildQueryString(m_strTaskNotes)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drWork)

            If m_strUserName <> "" Then
                strQuery = "SELECT EmployeeID FROM tbl_PM_Employee WHERE UserName = '"
                strQuery &= CommonFunctions.General.BuildQueryString(m_strUserName) & "'"
                m_strEmployeeId = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL)).ToString()
            End If

            strQuery = "Exec usp_Sel_tbl_PM_Risks " & m_lngProjectId.ToString() & ", " & m_lngRiskId.ToString()
            drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                If drWork.Read() Then
                    m_strTaskName = Trim(drWork.Item("Description").ToString())
                    m_strTaskName = CommonFunctions.General.UnBuildQueryString(m_strTaskName)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drWork)
        ElseIf m_lngTrainingResourceId > 0 Then
            ''Commented And Added By Vaijat K ON 18/08/2016
            ''m_strTaskName = "[" & MyBase.GetResourceString("TRAINING_ID") & " : " & m_lngTrainingId & "] "
            m_strTaskName = "" & MyBase.GetResourceString("TRAINING_ID") & " " & m_lngTrainingId & " "
            ''End of Addition by Vaijat K

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strQuery = "SELECT * FROM tbl_PRS_Training_Needs WHERE TrainingID = " & m_lngTrainingId.ToString()
            strQuery = "usp_sel_tbl_PRS_Training_Needs " & m_lngTrainingId.ToString()
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                If drWork.Read() Then
                    lngToolsId = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ToolID"), "0"), Long)
                    m_strTaskNotes = Trim(drWork.Item("TrainingArea").ToString())
                    m_strTaskNotes = CommonFunctions.General.UnBuildQueryString(m_strTaskNotes)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drWork)

            strQuery = "Exec usp_Sel_tbl_PM_Training_Resources " & m_lngTrainingId.ToString()
            strQuery &= ", " & m_lngTrainingResourceId.ToString()
            drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                If drWork.Read() Then
                    m_strEmployeeId = CommonFunctions.Data.CheckIsDBNull(drWork.Item("EmployeeID"), "").ToString()
                    m_strCurrentStartDate = drWork.Item("StartDate").ToString()
                    If m_strCurrentStartDate <> "" Then
                        m_strCurrentStartDate = CommonFunctions.Dates.GetDate(CType(m_strCurrentStartDate, Date))
                    End If
                    m_strCurrentEndDate = drWork.Item("EndDate").ToString()
                    If m_strCurrentEndDate <> "" Then
                        m_strCurrentEndDate = CommonFunctions.Dates.GetDate(CType(m_strCurrentEndDate, Date))
                    End If
                    m_strCurrentWork = CommonFunctions.Data.CheckIsDBNull(drWork.Item("Hours"), "").ToString()
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drWork)

            strQuery = "Exec usp_Sel_tbl_PM_Tools " & lngToolsId.ToString()
            drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                If drWork.Read() Then
                    m_strTaskName &= MyBase.GetResourceString("TRAINING_ON") & " " & CommonFunctions.General.UnBuildQueryString(drWork.Item("Description").ToString())
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drWork)
        Else
            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 Performance Changeas
            ' m_blnBillable is set in GetProjectSettingDetails 
            '' Line Commented By NitinVS on 24 November 2004 
            ''to Make billable check Box Checked or Unchecked based on 
            ''whether the Project is billable or not in Add new Mode
            ''m_blnBillable = True
            'strQuery = "SELECT Billable FROM tbl_PM_Project WHERE ProjectID =" & m_lngProjectId.ToString()
            'drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            'If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            '    If drWork.Read() Then
            '        m_blnBillable = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("Billable"), "False"), Boolean)
            '    End If
            'End If
            'CommonFunctions.Data.DisposeDataReader(drWork)
            '' End of Additon By NitinVS on 24 November 2004 

            ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0Performance Changeas

            m_strCurrentStartDate = CommonFunctions.Dates.GetDate(Now())
            m_strEmployeeId = m_lngFilterEmployeeId.ToString()
            strQuery = "Exec usp_Sel_tbl_PM_Project_TaskTypes_Names " & m_lngProjectId.ToString() & ", 1"
            drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                If drWork.Read() Then
                    m_strTaskType = drWork.Item("TaskType").ToString()
                    m_strTaskType = CommonFunctions.General.UnBuildQueryString(m_strTaskType)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drWork)
            If Request.QueryString("Type") = "Deferred" Then
                m_blnIsDeferredTask = True
            End If
        End If


        'Code added by SandipL on 23 Jan 2006 --For Task Custom Fields if Task type changes Apply new security for new TaskType
        If (Not HttpContext.Current.Request("TaskTypeID") Is Nothing) Then
            'Dim strSQLQuery As String = "Select ProjectTaskTypeID From tbl_PM_Project_TaskTypes where TaskTypeID = (Select TaskTypeID from tbl_PM_TaskTypes Where TaskType='" & HttpContext.Current.Request("TaskTypeID") & "') And ProjectID = " & CType(HttpContext.Current.Session("intProjectID"), String)
            'Dim strSQLQuery As String = "Select TaskTypeID from tbl_PM_TaskTypes Where TaskType='" & CommonFunctions.General.BuildQueryString(HttpContext.Current.Request("TaskTypeID")) & "' "
            'm_strCurrentType = CType(CommonFunctions.Data.GetDataScalar(strSQLQuery, True), String)

            '' START : ParagD On 23-Aug-2006
            m_strTaskType = CommonFunctions.General.BuildQueryString(HttpContext.Current.Request("TaskTypeID"))
            '' END : ParagD On 23-Aug-2006

            If m_strTaskType = "" Then
                m_strTaskType = ""
                m_strCurrentType = ""
            End If

            'm_strEmployeeId = CommonFunctions.Data.CheckIsDBNull(drWork.Item("EmployeeID")).ToString()
            ' m_strUserName = Trim(drWork.Item("UserName").ToString())
            'm_strUserName = CommonFunctions.General.UnBuildQueryString(m_strUserName)
            m_strTaskName = HttpContext.Current.Request("txtTaskName")
            m_strTaskName = CommonFunctions.General.UnBuildQueryString(m_strTaskName)
            m_strTaskNotes = HttpContext.Current.Request("txtTaskNotes")
            m_strTaskNotes = CommonFunctions.General.UnBuildQueryString(m_strTaskNotes)
            'm_strTaskType = Trim(drWork.Item("ModuleName").ToString())
            m_strTaskType = CommonFunctions.General.UnBuildQueryString(m_strTaskType)
            m_strCurrentStartDate = HttpContext.Current.Request("txtCurrentStartDate")
            'If m_strCurrentStartDate <> "" Then
            '    m_strCurrentStartDate = CommonFunctions.Dates.GetDate(CType(m_strCurrentStartDate, Date))
            'End If

            m_strBaselineStartDate = HttpContext.Current.Request("txthidBaselineStartDate")
            'If m_strBaselineStartDate <> "" Then
            '    m_strBaselineStartDate = CommonFunctions.Dates.GetDate(CType(m_strBaselineStartDate, Date))
            'End If

            'm_strActualStartDate = HttpContext.Current.Request("txtTaskName")
            'If m_strActualStartDate <> "" Then
            '    m_strActualStartDate = CommonFunctions.Dates.GetDate(CType(m_strActualStartDate, Date))
            'End If

            m_strCurrentEndDate = HttpContext.Current.Request("txtCurrentEndDate")
            'If m_strCurrentEndDate <> "" Then
            '    m_strCurrentEndDate = CommonFunctions.Dates.GetDate(CType(m_strCurrentEndDate, Date))
            'End If

            m_strBaselineEndDate = HttpContext.Current.Request("txthidBaselineEndDate")
            'If m_strBaselineEndDate <> "" Then
            '    m_strBaselineEndDate = CommonFunctions.Dates.GetDate(CType(m_strBaselineEndDate, Date))
            'End If

            'm_strActualEndDate = HttpContext.Current.Request("txtTaskName")
            'If m_strActualEndDate <> "" Then
            '    m_strActualEndDate = CommonFunctions.Dates.GetDate(CType(m_strActualEndDate, Date))
            'End If

            'm_dblCurrentDuration = CType(HttpContext.Current.Request("txtTaskName"), Double)
            'm_dblBaselineDuration = CType(HttpContext.Current.Request("txtTaskName"), Double)
            'm_dblActualDuration = CType(CommonFunctions.Data.CheckIsDBNull(HttpContext.Current.Request("txtTaskName"), "0"), Double)
            m_strCurrentWork = CommonFunctions.Data.CheckIsDBNull(HttpContext.Current.Request("txtCurrentWork"), "").ToString()
            m_strBaselineWork = CommonFunctions.Data.CheckIsDBNull(HttpContext.Current.Request("txthidBaselineWork"), "").ToString()
            'm_strActualWork = CommonFunctions.Data.CheckIsDBNull(HttpContext.Current.Request("txtTaskName"), "").ToString()

            'Commented And Added By Usha Pandit On 10.07.2020 For checking Priority is set or not set
            'm_strPriority = Trim(HttpContext.Current.Request("cboPriority").ToString())
            m_strPriority = Trim(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("cboPriority"), "").ToString())
            'End Of Added By Usha Pandit On 10.07.2020 For checking Priority is set or not set
            m_strPriority = CommonFunctions.General.UnBuildQueryString(m_strPriority)
            If HttpContext.Current.Request("cboPhaseID") <> "" Then
                m_lngPhaseId = CType(HttpContext.Current.Request("cboPhaseID"), Long)
            Else
                m_lngPhaseId = 0
            End If
            m_strPhase = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("txthidPhase"), "")
            m_strPhase = CommonFunctions.General.UnBuildQueryString(m_strPhase)
            If HttpContext.Current.Request("cboModuleID") <> "" Then
                m_lngModuleId = CType(CommonFunctions.Data.CheckIsDBNull(HttpContext.Current.Request("cboModuleID"), "0"), Long)
            Else
                m_lngModuleId = 0
            End If
            m_strModule = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("txthidModule"), "")
            m_strModule = CommonFunctions.General.UnBuildQueryString(m_strModule)
            If HttpContext.Current.Request("cboSubProjectID") <> "" Then
                m_lngSubProjectId = CType(CommonFunctions.Data.CheckIsDBNull(HttpContext.Current.Request("cboSubProjectID"), "0"), Long)
                m_strSubProject = CommonFunction.General.CheckIsNothing(Trim(HttpContext.Current.Request("txthidSubProject").ToString()), "")
                m_strSubProject = CommonFunctions.General.UnBuildQueryString(m_strSubProject)
            Else
                m_lngSubProjectId = 0
                m_strSubProject = ""
            End If
            If HttpContext.Current.Request("cboMilestoneID") <> "" Then
                m_lngMilestoneId = CType(CommonFunctions.Data.CheckIsDBNull(HttpContext.Current.Request("cboMilestoneID"), "0"), Long)
                m_strMilestone = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("txthidMilestone"), "")
                m_strMilestone = CommonFunctions.General.UnBuildQueryString(m_strMilestone)
            Else
                m_lngMilestoneId = 0
                m_strMilestone = ""
            End If
            If HttpContext.Current.Request("cboChangeRequestID") <> "" Then
                m_lngChangeRequestId = CType(CommonFunctions.Data.CheckIsDBNull(HttpContext.Current.Request("cboChangeRequestID"), "0"), Long)
            Else
                m_lngChangeRequestId = 0
            End If
            If HttpContext.Current.Request("cboProjectFeatureID") <> "" Then
                m_lngProjectFeatureId = CType(CommonFunctions.Data.CheckIsDBNull(HttpContext.Current.Request("cboProjectFeatureID"), "0"), Long)
            Else
                m_lngProjectFeatureId = 0
            End If
            If HttpContext.Current.Request("txtHidDeliverableID") <> "" Then
                m_lngDeliverableId = CType(CommonFunctions.Data.CheckIsDBNull(HttpContext.Current.Request("txtHidDeliverableID"), "0"), Long)
                m_strDeliverableId = GetDeliverableName(m_lngDeliverableId)
            Else
                m_lngDeliverableId = 0
                m_strDeliverableId = ""
            End If
            If HttpContext.Current.Request("cboProjectEstimationTypeID") <> "" Then
                m_lngProjectEstimationTypeId = CType(CommonFunctions.Data.CheckIsDBNull(HttpContext.Current.Request("cboProjectEstimationTypeID"), "0"), Long)
            Else
                m_lngProjectEstimationTypeId = 0
            End If
            'm_blnIsDeferredTask = CType(CommonFunctions.Data.CheckIsDBNull(HttpContext.Current.Request("txtTaskName"), "False"), Boolean)

            If HttpContext.Current.Request("chkBillable") = "ON" Or HttpContext.Current.Request("chkBillable") = "TRUE" Then
                m_blnBillable = True
            Else
                m_blnBillable = False
            End If
            'm_blnIsTaskComplete = CType(CommonFunctions.Data.CheckIsDBNull(HttpContext.Current.Request("txtTaskName"), "False"), Boolean)
            'm_blnVoid = Not CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("IsActive"), "False"), Boolean)
            'm_blnOnHold = CType(CommonFunctions.Data.CheckIsDBNull(HttpContext.Current.Request("txtTaskName"), "False"), Boolean)



            ' m_strActualWork = CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL).ToString()


        End If
        If (m_strTaskType <> "" And Not m_strTaskType Is Nothing) Then

            '' START : ParagD On 23-Aug-2006

            ''Dim strSQLQuery As String = "Select TaskTypeID from tbl_PM_TaskTypes Where TaskType='" & CommonFunctions.General.BuildQueryString(m_strTaskType) & "' "
            Dim strSQLQuery As String = "usp_sel_tbl_PM_TaskTypes_TaskTypeWise_TaskTypeID '" & CommonFunctions.General.BuildQueryString(m_strTaskType) & "' "


            '' END : ParagD On 23-Aug-2006

            m_strCurrentType = CType(CommonFunctions.Data.GetDataScalar(strSQLQuery, True), String)
        End If
        'End addition by SandipL on 23 Jan 2006 
        'The Changes made for Mode
        If Not Page.IsPostBack And m_strMode <> "" And m_lngTaskId = 0 Then
            lngTempID = CType(CommonFunctions.General.CheckIsNothing("0" & Request.QueryString("ForeignKeyValue"), "0"), Long)
            If m_strMode = MODE_MODULE Then
                m_lngModuleId = lngTempID
            ElseIf m_strMode = MODE_SUBPROJECT Then
                m_lngSubProjectId = lngTempID
            ElseIf m_strMode = MODE_CHANGEMANAGEMENT Then
                m_lngChangeRequestId = lngTempID
            ElseIf m_strMode = MODE_DELIVERABLE Then
                m_lngDeliverableId = lngTempID
                'Added By VidyaJ - DA Performance Issue - IssueID - 89 (SP4)
                m_strDeliverableId = GetDeliverableName(m_lngDeliverableId)
            ElseIf m_strMode = MODE_PHASE Then
                m_lngPhaseId = lngTempID
            ElseIf m_strMode = MODE_MILESTONE Then
                m_lngMilestoneId = lngTempID
                'End Of Addition - IssueID - 89 (SP4) 
            End If
        End If

        'For Add New Mode If resource Id is passed then assign the value to the ResourceID Variable
        lngTempID = CType(CommonFunctions.General.CheckIsNothing("0" & Request.QueryString("ResourceID"), "0"), Long)
        If lngTempID > 0 Then
            m_strEmployeeId = lngTempID.ToString()
        End If

        ' Code added by SwapnilR on 7th Nov 2006  for Whiziblesem SP8 Issue ID.7167
        ' Purpose : If page is called for CopyTask then employeeid will be null
        If strTaskID <> "" Then
            m_strEmployeeId = ""
            m_strBaselineStartDate = ""
            m_strBaselineEndDate = ""
            m_strBaselineWork = ""
        End If
        ' End of code addition by SwapnilR on 7th Nov 2006

        'Get LCE Information
        Call GetLCERelatedInformation()
    End Sub

    Private Sub GetFormValues()
        Dim intLength As Integer
        Dim m_MinHoursForDAEntry As Double

        m_strEmployeeId = MyBase.FixString(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboEmployee")), 0, False, True)
        intLength = m_strEmployeeId.Split(CType(",", Char)).Length

        m_strTaskName = MyBase.FixString(MyBase.GetFormValue("txtTaskName"), 255, False, True)
        m_strTaskName = CommonFunctions.General.UnBuildQueryString(m_strTaskName)
        m_strTaskNotes = MyBase.FixString(MyBase.GetFormValue("txtTaskNotes"), 2000, False, False)
        m_strTaskNotes = CommonFunctions.General.UnBuildQueryString(m_strTaskNotes)
        m_strTaskType = MyBase.FixString(MyBase.GetFormValue("cboTaskType"), 100, False, True)
        m_strTaskType = CommonFunctions.General.UnBuildQueryString(m_strTaskType)
        m_strCurrentStartDate = MyBase.FixString(MyBase.GetFormValue("txtCurrentStartDate"), 0, False, True)
        m_strCurrentEndDate = MyBase.FixString(MyBase.GetFormValue("txtCurrentEndDate"), 0, False, True)
        'm_strCurrentWork = MyBase.FixString(MyBase.GetFormValue("txtCurrentWork"), 0, True, True)
        m_strCurrentWork = MyBase.GetFormValue("txtCurrentWork")

        ''Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
        'If m_strCurrentWork.IndexOf(":") = m_strCurrentWork.Length - 1 Then
        '    m_strCurrentWork = m_strCurrentWork + "00"
        'End If

        'Dim strInd As String = m_strCurrentWork.IndexOf(":")
        'If strInd = -1 Then
        '    m_strCurrentWork = m_strCurrentWork + ":00"
        'End If
        'Dim strDecimal As String = ""
        'Dim strBeforeDecimal As String = ""
        'strBeforeDecimal = m_strCurrentWork.Substring(0, m_strCurrentWork.IndexOf(":"))
        'strDecimal = m_strCurrentWork.Substring(m_strCurrentWork.IndexOf(":") + 1, 2)
        'm_strCurrentWork = strBeforeDecimal + ":" + strDecimal
        If m_strCurrentWork.Contains(":") Then
            m_strCurrentWork = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + m_strCurrentWork + "',2)", True)
        Else
            m_strCurrentWork = m_strCurrentWork
        End If
        ''End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change

        ''Added by NitinC on 19 August 2011 for WhizibleSEM v10.0 (Agile Methodology)
        'Added By Bharat T on 13th-Oct-2015
        If MyBase.GetFormValue("cboUserStory") <> "" Then
            m_strUserStory = MyBase.FixString(MyBase.GetFormValue("cboUserStory"), 100, False, True)
        Else
            m_strUserStory = ""
        End If
        'End of Added By Bharat T on 13th-Oct-2015
        m_strRelease = MyBase.GetFormValue("txtRelease")
        m_strIteration = MyBase.GetFormValue("txtIteration")
        ''End Addition

        'Added By Syamantak Chavan On 3/Jan/2011
        m_strRequestStageID = MyBase.GetFormValue("txtHidDeliverableStageID")
        'End Added By Syamantak Chavan On 3/Jan/2011

        ''Added By Aniruddh Gujar on 26-Apr-2018 Purpose::Whizible Agile Changes
        m_strStoryPoint = MyBase.FixString(MyBase.GetFormValue("txtStoryPoint"), 0, True, True)
        ''End of Added By Aniruddh Gujar on 26-Apr-2018 Purpose::Whizible Agile Changes

        ''Added by NitinC on 23 June 2011 for WhizibleSEM v10.0 (Agile Methodology)
        'Dim strSQL1 As String

        ''Dim strMsg As String
        'strSQL1 = "select StartDate,EndDate,InitialEstimate,UserStoryName from tbl_pm_ScrumUserStory where UserStoryID = " + m_strUserStoryID
        'strSQL1 += " select Convert(int,Sum(Effort)) AS Effort from tbl_pm_scrumtask where userstoryid = " + m_strUserStoryID + " and AssignedTo is not null"
        'Dim dsTaskValidate As DataSet = CommonFunction.Data.GetDataSet(strSQL1, "ScrumUserStory", , , CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        'm_StartDate = CType(dsTaskValidate.Tables(0).Rows(0)(0).ToString, Date)
        'm_EndDate = CType(dsTaskValidate.Tables(0).Rows(0)(1).ToString, Date)
        'm_InitialEstimate = CType(dsTaskValidate.Tables(0).Rows(0)(2).ToString, Integer)
        'm_Effort = CType(dsTaskValidate.Tables(1).Rows(0)(0).ToString, Integer)
        'm_UserStoryName = dsTaskValidate.Tables(0).Rows(0)(3).ToString
        'If m_strCurrentStartDate <> "" Then
        '    If Not (CType(m_strCurrentStartDate, Date) >= m_StartDate And CType(m_strCurrentEndDate, Date) <= m_EndDate) Then
        '        m_strValidDates = "false"
        '        m_DatesMsg = "Start Date and End Date should be between user story : " + m_UserStoryName + " dates\ni.e. Start Date : " + m_StartDate + " End Date : " + m_EndDate
        '        'CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
        '        'CommonFunctions.General.WriteHTML("alert('" & strMsg & "');" + vbCrLf)
        '        'CommonFunctions.General.WriteHTML("return;")
        '        'CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
        '    End If
        '    If (m_Effort + CType(m_strCurrentWork, Integer)) > m_InitialEstimate Then
        '        m_strValidEffort = "false"
        '        m_EffortMsg = "Your planned Estimate for this Task is : " + m_strCurrentWork + " hrs\nAnd till date you have estimated hours for all tasks under user story " + m_UserStoryName + " is : " + CType(m_Effort, String) + " hrs\nNow you have entered " + m_strCurrentWork + " hrs which will break your estimation. \nSystem will automatically increase your estimated hrs for user story.\nDo you want to save anyway?"
        '        'CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
        '        'CommonFunctions.General.WriteHTML("var cnf = confirm('" & strMsg & "');" + vbCrLf)
        '        'CommonFunctions.General.WriteHTML("if (cnf == true){}")
        '        'CommonFunctions.General.WriteHTML("if (cnf == false){return;}")
        '        'CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
        '    End If
        'End If
        ''End : Added by NitinC on 23 June 2011 for WhizibleSEM v10.0 (Agile Methodology)

        ' Modified By NitinVS on 22 Feb 2005 
        ' Uncommented the Code for Distributing the Work Hours based on DistributeWorkInAT Flag

        'If the Work (hrs) must be distributed among the resources.        

        ''' START : Integrated by ParagD On 14-Aug-2006 for whizible SP 7.2
        ''Added by SavitaS on 24 Mar 2006 for TechUnified Issue ID-1257
        'Dim strSQLDistributeWorkInAT As String
        'Dim drDistributeWorkInAT As IDataReader

        'strSQLDistributeWorkInAT = "select DistributeWorkInAT from tbl_PM_CompanyInformation"
        'drDistributeWorkInAT = CommonFunctions.Data.GetDataReader(strSQLDistributeWorkInAT, MyBase.UseSQL)
        'If drDistributeWorkInAT.Read Then
        '    m_objDistributeWorkInAT = CType(CommonFunctions.Data.CheckIsDBNull(drDistributeWorkInAT("DistributeWorkInAT"), "0"), Long)
        'End If
        'CommonFunctions.Data.DisposeDataReader(drDistributeWorkInAT)

        'If CommonFunctions.Application.DistributeWorkInAT = True Then
        'If m_objDistributeWorkInAT <> 0 Then
        If CommonFunction.Application.DistributeWorkInAT = True Then
            'End of :Added by SavitaS on 24 Mar 2006 for TechUnified Issue ID-1257
            '' END : Integrated by ParagD On 14-Aug-2006 for whizible SP 7.2

            ' Work per resource = Work (hrs) specified / Number of resources.
            If m_strCurrentWork <> "" And intLength > 1 Then
                m_strCurrentWork = FormatNumber(CType(m_strCurrentWork, Double) / intLength, 2, TriState.False)
                ' Modified By NitinVS on 22 Feb 2005 
                ' If the Work Hours is not in multiple of Minimum task hours then Convert it to multiple of Min Task hours 
                m_MinHoursForDAEntry = CommonFunction.Application.MinHoursForDAEntry
                If CType(m_strCurrentWork, Double) Mod m_MinHoursForDAEntry <> 0 Then
                    'Added By Dipali  V On 15th Dec 2021 For Converstion ISsue
                    If m_MinHoursForDAEntry <> 0.016 Then
                        'End of Added By Dipali  V On 15th Dec 2021 For Converstion ISsue
                        m_strCurrentWork = CType(CType(m_strCurrentWork, Double) - CType(m_strCurrentWork, Double) Mod m_MinHoursForDAEntry, String)
                    End If
                End If
                ' End Modification By NitinVS on 22 Feb 2005 
            End If
        End If

        ' end Uncommenting  BY NitinVS on 22 Feb 205 

        m_strBaselineStartDate = MyBase.FixString(MyBase.GetFormValue("txthidBaselineStartDate"), 0, False, False)
        m_strBaselineEndDate = MyBase.FixString(MyBase.GetFormValue("txthidBaselineEndDate"), 0, False, False)

        ''Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
        'm_strBaselineWork = MyBase.FixString(MyBase.GetFormValue("txthidBaselineWork"), 0, True, False)
        'Dim strBaselinework As String = MyBase.GetFormValue("txthidBaselineWork")
        'If strBaselinework.IndexOf(":") = strBaselinework.Length - 1 Then
        '    strBaselinework = strBaselinework + "00"
        'End If

        'Dim strInd1 As String = strBaselinework.IndexOf(":")
        'If strInd1 = -1 Then
        '    strBaselinework = strBaselinework + ":00"
        'End If

        'strBeforeDecimal = strBaselinework.Substring(0, strBaselinework.IndexOf(":"))
        'strDecimal = strBaselinework.Substring(strBaselinework.IndexOf(":") + 1, 2)
        'strBaselinework = strBeforeDecimal + ":" + strDecimal

        If MyBase.GetFormValue("txthidBaselineWork") <> "" Then
            'm_strBaselineWork = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + MyBase.GetFormValue("txthidBaselineWork") + "',2)", True)
            If MyBase.GetFormValue("txthidBaselineWork").Contains(":") Then
                m_strBaselineWork = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + MyBase.GetFormValue("txthidBaselineWork") + "',2)", True)
            Else
                m_strBaselineWork = MyBase.GetFormValue("txthidBaselineWork")

            End If
            m_strBaselineWork = MyBase.FixString(m_strBaselineWork, 0, True, False)
        Else
            m_strBaselineWork = MyBase.FixString(MyBase.GetFormValue("txthidBaselineWork"), 0, True, False)
        End If
        ''End of Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change

        ' If the Work (hrs) must be distributed among the resources.
        If CommonFunctions.Application.DistributeWorkInAT = True Then
            ' Work per resource = baseline Work (hrs) specified / Number of resources.
            If m_strBaselineWork <> "" And intLength > 1 Then
                m_strBaselineWork = FormatNumber(CType(m_strBaselineWork, Double) / intLength, 2, TriState.False)

                ' Modified By NitinVS on 22 Feb 2005 
                ' If the Work Hours is not in multiple of Minimum task hours then Convert it to multiple of Min Task hours 
                m_MinHoursForDAEntry = CommonFunction.Application.MinHoursForDAEntry
                If CType(m_strBaselineWork, Double) Mod m_MinHoursForDAEntry <> 0 Then
                    'Added By Dipali  V On 15th Dec 2021 For Converstion ISsue
                    If m_MinHoursForDAEntry <> 0.016 Then
                        'End of Added By Dipali  V On 15th Dec 2021 For Converstion ISsue
                        m_strBaselineWork = CType(CType(m_strBaselineWork, Double) - CType(m_strBaselineWork, Double) Mod m_MinHoursForDAEntry, String)
                    End If
                End If
                    ' End Modification By NitinVS on 22 Feb 2005 
                End If
        End If

        m_strPriority = MyBase.FixString(MyBase.GetFormValue("cboPriority"), 0, False, True)
        m_strPriority = CommonFunctions.General.UnBuildQueryString(m_strPriority)
        If MyBase.GetFormValue("chkBillable").ToString().ToUpper() = "ON" Then
            m_blnBillable = True
        Else
            m_blnBillable = False
        End If

        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboPhaseID")) <> "" Then
            m_lngPhaseId = CType("0" & MyBase.FixString(MyBase.GetFormValue("cboPhaseID"), 0, False, False), Long)
            m_strPhase = MyBase.FixString(MyBase.GetFormValue("txthidPhase"), 0, False, True)
            m_strPhase = CommonFunctions.General.UnBuildQueryString(m_strPhase)
        End If
        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboModuleID")) <> "" Then
            m_lngModuleId = CType("0" & MyBase.FixString(MyBase.GetFormValue("cboModuleID"), 0, False, False), Long)
            m_strModule = MyBase.FixString(MyBase.GetFormValue("txthidModule"), 0, False, True)
            m_strModule = CommonFunctions.General.UnBuildQueryString(m_strModule)
        End If
        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboSubProjectID")) <> "" Then
            m_lngSubProjectId = CType("0" & MyBase.FixString(MyBase.GetFormValue("cboSubProjectID"), 0, False, False), Long)
            m_strSubProject = MyBase.FixString(MyBase.GetFormValue("txthidSubProject"), 0, False, True)
            m_strSubProject = CommonFunctions.General.UnBuildQueryString(m_strSubProject)
        End If
        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboMilestoneID")) <> "" Then
            m_lngMilestoneId = CType("0" & MyBase.FixString(MyBase.GetFormValue("cboMilestoneID"), 0, False, False), Long)
            m_strMilestone = MyBase.FixString(MyBase.GetFormValue("txthidMilestone"), 0, False, True)
            m_strMilestone = CommonFunctions.General.UnBuildQueryString(m_strMilestone)
        End If
        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboChangeRequestID")) <> "" Then
            m_lngChangeRequestId = CType("0" & MyBase.FixString(MyBase.GetFormValue("cboChangeRequestID"), 0, False, False), Long)
        End If
        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboProjectFeatureID")) <> "" Then
            m_lngProjectFeatureId = CType("0" & MyBase.FixString(MyBase.GetFormValue("cboProjectFeatureID"), 0, False, False), Long)
        End If
        'If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboDeliverableID")) <> "" Then
        '    m_lngDeliverableId = CType("0" & MyBase.FixString(MyBase.GetFormValue("cboDeliverableID"), 0, False, False), Long)
        'End If
        If CommonFunctions.General.CheckIsNothing(Request.Form("txtHidDeliverableID")) <> "" Then
            m_lngDeliverableId = CType("0" & Request.Form("txtHidDeliverableID"), Long)
            m_strDeliverableId = GetDeliverableName(m_lngDeliverableId)
        End If
        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboProjectEstimationTypeID")) <> "" Then
            m_lngProjectEstimationTypeId = CType("0" & MyBase.FixString(MyBase.GetFormValue("cboProjectEstimationTypeID"), 0, False, False), Long)
        End If

        'If MyBase.GetFormValue("chkVoid").ToString().ToUpper() = "ON" Then
        '    m_blnVoid = True
        'Else
        '    m_blnVoid = False
        'End If
        If MyBase.GetFormValue("chkOnHold").ToString().ToUpper() = "ON" Then
            m_blnOnHold = True
        Else
            m_blnOnHold = False
        End If
    End Sub

    Private Sub SaveTaskDetails()

        '' ***************************************************************************/
        '' Integrated On 10-Feb-2006 By ParagD for Whiz 2   

        '' Added By ParagD On 11-Jan-2006
        '' Purpose : DSS - 289 => 
        '' When task details are modified and click on "SEND MAIL" link ,message contains as "NEW Task"
        '' and not "MODIFIED Task" 
        '' commented & shifted to declaration part.
        '' Dim blnIsNewTask As Boolean
        '' END : Added By ParagD On 11-Jan-2006

        '' Integrated On 10-Feb-2006 By ParagD for Whiz 2
        '' ***************************************************************************/

        Dim arrEmpId() As String
        Dim intCtr As Integer
        Dim intNumberOfEmployees As Integer = 0
        Dim dblTempWork As Double = 0
        Dim drReview As IDataReader

        Dim strQuery As String = ""
        Dim strQuery_1 As String = ""
        Dim strQuery_2 As String = ""
        'Email Related Variables
        Dim strFromEmailId, strToEmailId, strCCToEmailId, strSubject, strEmailMessage As String
        Dim lngTaskTypeID As Long = 0
        Dim strTempQuery As String = ""

        Dim strEmployeeNames As String = ""
        Dim strTempName As String = ""



        'Save Parent Task
        '----------------------
        ' SQL QUERY : PART 1
        '----------------------
        If m_lngTaskId > 0 Then
            If m_strProjectSetting = PROJECT_SETTING_NORMAL Then
                strQuery_1 = "Exec usp_Ins_tbl_PM_ProjectAssignedSubTasks NULL, " & m_strEmployeeId & "," & m_lngTaskId.ToString()
            Else
                strQuery_1 = "Exec usp_Ins_tbl_PM_ProjectAssignedTasks " & m_lngTaskId.ToString()
            End If
            blnIsNewTask = False
        Else
            strQuery_1 = "Exec usp_Ins_tbl_PM_ProjectAssignedTasks NULL"
            blnIsNewTask = True
        End If
        strQuery_2 &= ", " & m_lngProjectId.ToString()
        '----------------------
        ' SQL QUERY : PART 2
        '----------------------
        strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(m_strTaskName) & "'"
        strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(m_strCurrentStartDate) & "'"
        strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(m_strCurrentEndDate) & "'"


        'Work
        strQuery_2 &= ", [WORK], 'O'"


        If m_blnBillable = True Then
            strQuery_2 &= ", 1"
        Else
            strQuery_2 &= ", 0"
        End If
        strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(m_strTaskNotes) & "'"
        strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(m_strTaskType) & "'"
        If m_strBaselineStartDate <> "" Then
            strQuery_2 &= ", '" & m_strBaselineStartDate.ToString() & "'"
        Else
            strQuery_2 &= ", NULL"
        End If
        If m_strBaselineEndDate <> "" Then
            strQuery_2 &= ", '" & m_strBaselineEndDate.ToString() & "'"
        Else
            strQuery_2 &= ", NULL"
        End If
        If m_strBaselineWork <> "" Then
            strQuery_2 &= ", " & FormatNumber(m_strBaselineWork, , , , TriState.False)
        Else
            strQuery_2 &= ", NULL"
        End If
        strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(m_strPriority) & "'"

        If m_lngPhaseId > 0 Then
            strQuery_2 &= ", " & m_lngPhaseId.ToString() & ", '" & CommonFunctions.General.BuildQueryString(m_strPhase) & "'"
        Else
            strQuery_2 &= ", NULL, NULL"
        End If
        If m_lngModuleId > 0 Then
            strQuery_2 &= ", " & m_lngModuleId.ToString() & ", '" & CommonFunctions.General.BuildQueryString(m_strModule) & "'"
        Else
            strQuery_2 &= ", NULL, NULL"
        End If
        If m_lngSubProjectId > 0 Then
            strQuery_2 &= ", " & m_lngSubProjectId.ToString() & ", '" & CommonFunctions.General.BuildQueryString(m_strSubProject) & "'"
        Else
            strQuery_2 &= ", NULL, NULL"
        End If
        If m_lngMilestoneId > 0 Then
            strQuery_2 &= ", " & m_lngMilestoneId.ToString() & ", '" & CommonFunctions.General.BuildQueryString(m_strMilestone) & "'"
        Else
            strQuery_2 &= ", NULL, NULL"
        End If

        'ReviewActionId
        If m_lngReviewActionId > 0 Then
            strQuery_2 &= "," & m_lngReviewActionId.ToString()
        Else
            strQuery_2 &= ", NULL"
        End If

        If m_lngChangeRequestId > 0 Then
            strQuery_2 &= ", " & m_lngChangeRequestId.ToString()
        Else
            strQuery_2 &= ", NULL"
        End If
        If m_lngProjectFeatureId > 0 Then
            strQuery_2 &= ", " & m_lngProjectFeatureId.ToString()
        Else
            strQuery_2 &= ", NULL"
        End If
        If m_lngProjectEstimationTypeId > 0 Then
            strQuery_2 &= ", " & m_lngProjectEstimationTypeId.ToString()
        Else
            strQuery_2 &= ", NULL"
        End If
        'Deliverable ID
        If m_lngDeliverableId > 0 Then
            strQuery_2 &= ", " & m_lngDeliverableId.ToString()
        Else
            strQuery_2 &= ", NULL"
        End If

        'Mitigation Plans
        If m_lngMitigationPlanId > 0 Then
            strQuery_2 &= "," & m_lngMitigationPlanId.ToString()
        Else
            strQuery_2 &= ", NULL"
        End If
        'Training Plans
        If m_lngTrainingResourceId > 0 Then
            strQuery_2 &= "," & m_lngTrainingResourceId.ToString()
        Else
            strQuery_2 &= ", NULL"
        End If
        'Training ID
        strQuery_2 &= "," & m_lngTrainingId.ToString()

        'Void and On Hold
        'If m_blnVoid = True Then
        '    strQuery_2 &= ", 0"
        'Else
        strQuery_2 &= ", 1"
        'End If

        If m_blnOnHold = True Then
            strQuery_2 &= ", 1"
        Else
            strQuery_2 &= ", 0"
        End If
        strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(m_strUserName) & "'"

        'Added by NitinC on 06 June 2011 for WhizibleSEM 10.0 for Agile Methodology
        ''Commented and Added by Dhanashri S on 3 Dec 2015 for IssueID:2572
        ''If CommonFunction.General.CheckIsNothing(Request.QueryString("WhichTask"), "") = "S" Or m_strUserStory <> "" Then
        If CommonFunction.General.CheckIsNothing(Request.QueryString("WhichTask"), "") = "S" Or CommonFunction.General.CheckIsNothing(Request.QueryString("UserStoryID"), "") <> "" Or m_strUserStory <> "" Then
            ''End of Comment and Addition by Dhanashri S on 3 Dec 2015
            strQuery_2 &= ", 1"
        Else
            strQuery_2 &= ", 0"
        End If
        If CommonFunction.General.CheckIsNothing(Request.QueryString("UserStoryID"), "") <> "" Then
            strQuery_2 &= ", " & Request.QueryString("UserStoryID")
        ElseIf m_strUserStory <> "" Then
            strQuery_2 &= ", " & m_strUserStory
        Else
            strQuery_2 &= ", NULL"
        End If
        'End of - Added by NitinC on 06 June 2011 for WhizibleSEM 10.0 for Agile Methodology
        
        '---------------------------------------------------------------------------------
        'Added By Syamantak Chavan on 3/Jan/2012 for Whizible 11.0
        If CommonFunction.General.CheckIsNothing(Request.QueryString("PageType"), "") = "Deliverable" Then
            If m_strRequestStageID <> "" Then
                strQuery_2 &= ", '" & m_strRequestStageID.ToString & "'"
            Else
                strQuery_2 &= ", NULL"
            End If
        End If
        'Added By Syamantak Chavan on 3/Jan/2012 for Whizible 11.0
        '---------------------------------------------------------------------------------

        ''Added By Aniruddh Gujar on 26-Apr-2018 Purpose::Whizible Agile Changes
        If m_strStoryPoint <> "" Then
            If m_strStoryPoint > 0 Then
                strQuery_2 &= ", " & m_strStoryPoint.ToString()
            Else
                strQuery_2 &= ", NULL"
            End If
        Else
            strQuery_2 &= ", NULL"
        End If
        ''End of Added By Aniruddh Gujar on 26-Apr-2018 Purpose::Whizible Agile Changes

        dblTempWork = CType(m_strCurrentWork, Double)
        strTempQuery = strQuery_2
        strTempQuery = Replace(strTempQuery, "[WORK]", FormatNumber(dblTempWork, , , , TriState.False))
        strQuery = strQuery_1 & strTempQuery

        If Not m_strProjectSetting = PROJECT_SETTING_NORMAL Then
            m_lngTaskId = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Long)
            m_strTaskIDList = m_lngTaskId.ToString() & ", "
            'Insert the SubTasks for each Resource when new Task is created
        ElseIf m_strProjectSetting = PROJECT_SETTING_NORMAL Then
            If blnIsNewTask = True Then
                arrEmpId = m_strEmployeeId.Split(CType(",", Char))
                intNumberOfEmployees = arrEmpId.Length()
                strQuery_2 = strTempQuery
                strTempQuery = strQuery
                strEmployeeNames = ""
                For intCtr = 0 To intNumberOfEmployees - 1
                    ''Commented by ManishK on 7th Feb 2006 for SP 6 WFH/ Leave Confirm box
                    ''Check if there is any leave(s) between the start date and end date
                    'strTempName = CheckLeaves(CType(arrEmpId(intCtr), Long), m_strCurrentStartDate, m_strCurrentEndDate)
                    'If strTempName <> "" Then strEmployeeNames &= strTempName & ", "
                    ''End of Commented by ManishK on 7th Feb 2006 for SP 6 WFH/ Leave Confirm box

                    'Insert the Parent Task 
                    m_lngTaskId = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strTempQuery, MyBase.UseSQL), "0"), Long)

                    'Insert the Child Tasks for each employee
                    strQuery_1 = "Exec usp_Ins_tbl_PM_ProjectAssignedSubTasks " & m_lngTaskId.ToString()
                    strQuery_1 &= ", " & arrEmpId(intCtr)
                    strQuery_1 &= ", NULL"
                    strQuery = strQuery_1 & strQuery_2
                    m_strTaskIDList &= CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL)) & ", "
                Next
                ''Commented by ManishK on 7th Feb 2006 for SP 6 WFH/ Leave Confirm box
                'If strEmployeeNames <> "" Then
                '    strEmployeeNames = strEmployeeNames.Trim()
                '    strEmployeeNames = Left(strEmployeeNames, strEmployeeNames.Length - 1)
                '    m_strLeaveMessage = MyBase.GetResourceString("LEAVES_IN_BETWEEN")
                '    '"Following resources have leave(s) between task start date and end date,\n"
                '    m_strLeaveMessage &= strEmployeeNames
                'End If
                ''End of Commented by ManishK on 7th Feb 2006 for SP 6 WFH/ Leave Confirm box
            Else
                ''Commented by ManishK on 7th Feb 2006 for SP 6 WFH/ Leave Confirm box
                'Check if there is any leave(s) between the start date and end date
                'strTempName = CheckLeaves(CType(m_strEmployeeId, Long), m_strCurrentStartDate, m_strCurrentEndDate)
                'If strTempName <> "" Then
                '    m_strLeaveMessage = MyBase.GetResourceString("RESOURCE_HAS_LEAVES")
                '    m_strLeaveMessage = m_strLeaveMessage.Replace("<=>", strTempName)

                '    'Added By ManishK on 6th Feb 06 for WhizibleSem 6.0 Issue for WFH
                '    m_strLeaveMessage = m_strLeaveMessage.Replace("<==>", strFromDate)
                '    m_strLeaveMessage = m_strLeaveMessage.Replace("<>", strToDate)
                '    'End of Added By ManishK on 6th Feb 06 for WhizibleSem 6.0 Issue for WFH
                'End If
                ''End of Commented by ManishK on 7th Feb 2006 for SP 6 WFH/ Leave Confirm box
                m_lngTaskId = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Long)
            End If
        End If
        If m_strTaskIDList <> "" Then m_strTaskIDList = Left(m_strTaskIDList, InStrRev(m_strTaskIDList, ",") - 1)

        If m_strProjectSetting = PROJECT_SETTING_NORMAL Then
            If Trim(m_strTaskIDList) <> "" And m_strEmployeeId <> "" Then
                If blnIsNewTask = True Or MyBase.GetFormValue("txthidIsDeferredTask") = "1" Then
                    If m_blnSendMail = True Then
                        m_blnSendEmail = True
                        If m_blnShowPopup = False Then
                            'Added by vivekP On 3 jun 2005
                            CommonFunction.EmailMessages.PMMessages.GetEmailMessage_20(strFromEmailId, strToEmailId, strCCToEmailId, strSubject, strEmailMessage, m_strTaskIDList, CType(m_lngProjectId, String))
                            'End Of addition by vivekP on 3 jun 2005
                            CommonFunction.Emails.AppSendEmailWithCC(strToEmailId, strCCToEmailId, strFromEmailId, strSubject, strEmailMessage)
                        End If
                    End If
                End If
            End If
        End If

        If m_lngReviewActionId > 0 Then
            If m_lngTaskId > 0 Then
                If blnIsNewTask = True Then
                    If Not m_strProjectSetting = PROJECT_SETTING_NORMAL Then
                        Dim lngEmployeeId As Long = 0

                        strQuery = "Exec usp_Sel_tbl_PM_ReviewStatistics " & m_lngReviewStatisticsId.ToString()
                        drReview = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                        If CommonFunctions.General.CheckIsNothing(drReview) <> "" Then
                            If drReview.Read() Then
                                lngEmployeeId = CType(CommonFunctions.Data.CheckIsDBNull(drReview.Item("EmployeeID"), "0"), Long)
                            End If
                        End If
                        CommonFunctions.Data.DisposeDataReader(drReview)
                        If lngEmployeeId <> 0 Then
                            'Get the Task Type Id 
                            '''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                            'strQuery = "SELECT TaskTypeID FROM tbl_PM_TaskTypes WHERE TaskType = '"
                            'strQuery &= CommonFunctions.General.BuildQueryString(m_strTaskType) & "'"

                            strQuery = "usp_sel_tbl_PM_TaskTypes_TaskTypeWise_TaskTypeID '" & CommonFunctions.General.BuildQueryString(m_strTaskType) & "'"
                            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                            lngTaskTypeID = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Long)

                            strQuery = "EXEC usp_Ins_tbl_PM_AssignedTaskResources " & lngEmployeeId.ToString()
                            strQuery &= ", " & m_lngTaskId.ToString()
                            strQuery &= ", " & m_lngProjectId.ToString()
                            strQuery &= ", " & lngTaskTypeID & ", NULL"
                            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strUserName) & "' "
                            strQuery &= ", " & m_strCurrentWork
                            strQuery &= ", 'INSERT'"
                            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                        End If
                    End If
                End If
                ''Added By Usha Pandit On 06.07.2020 For getting correct Task Id if Review Task is added
                If m_lngReviewActionId > 0 Then
                    GetChildTaskID()
                End If
                ''End Of Added By Usha Pandit On 06.07.2020 For getting correct Task Id if Review Task is added
                strQuery = "UPDATE tbl_PM_ReviewActions SET TaskID = " & m_lngTaskId.ToString()
                strQuery &= " , WorkInHours = " & dblTempWork.ToString()
                strQuery &= " WHERE ReviewActionID = " & m_lngReviewActionId.ToString()
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            End If
            ' Set Active List to action list.
            Session("PM_Review_ActiveList") = "A"
            If m_strProjectSetting = PROJECT_SETTING_NORMAL Then
                m_strAction = ACTION_CLOSE_WINDOW_REVIEW
            End If
        End If

        If m_lngMitigationPlanId > 0 Then
            'If m_lngTaskId > 0 And blnIsNewTask = True Then
            If m_lngTaskId > 0 Then
                strQuery = "UPDATE tbl_PM_MitigationPlans SET TaskID = " & m_lngTaskId.ToString()
                strQuery &= " , Responsibility = (SELECT UserName FROM tbl_PM_Employee WHERE EmployeeID = " & m_strEmployeeId & ")"
                strQuery &= " WHERE MitigationPlanID = " & m_lngMitigationPlanId.ToString()
                'Modified BY NitinVS on 20 Apr 2007 for WhizibleSEM SP 8 Regression Fixes IssueID 12466
                ' If Task is already mapped to the Mitigation plan no need to update 
                strQuery &= " AND TaskID IS Null "
                'End Modification BY NitinVS on 20 Apr 2007 for WhizibleSEM SP 8 Regression Fixes IssueID 12466

                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            End If
            If m_strProjectSetting = PROJECT_SETTING_NORMAL Then
                m_strAction = ACTION_CLOSE_WINDOW_MITIGATION
            End If
        End If

        If m_lngTrainingResourceId > 0 Then
            'If m_lngTaskId > 0 And blnIsNewTask = True Then
            If m_lngTaskId > 0 Then
                'Modified By VarunA on 28-Feb-2008 IssueID-19003
                'Purpose : To persist the data while editing in the training plan, as TaskID used to change by Child TaskID
                'strQuery = "UPDATE tbl_PM_Training_Resources SET TaskID = " & m_lngTaskId.ToString() 
                strQuery = "UPDATE tbl_PM_Training_Resources SET TaskID = ISNULL(TaskID," & m_lngTaskId.ToString() + ")"
                'End By VarunA on 28-Feb-2008
                strQuery &= " , StartDate = '" & m_strCurrentStartDate & "'"
                strQuery &= " , EndDate = '" & m_strCurrentEndDate & "'"
                strQuery &= " , Hours = " & dblTempWork.ToString()
                strQuery &= " WHERE TrainingResourceID = " & m_lngTrainingResourceId.ToString()
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

                strQuery = "UPDATE tbl_PRS_Training_Needs SET TaskID = " & m_lngTaskId.ToString()
                strQuery &= " WHERE TrainingID = " & m_lngTrainingId.ToString()
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            End If
            If m_strProjectSetting = PROJECT_SETTING_NORMAL Then
                m_strAction = ACTION_CLOSE_WINDOW_TRAINING
            End If
        End If
        'Nikhil
        'If m_strMode <> "" Then
        '    If m_strProjectSetting = PROJECT_SETTING_NORMAL Then
        '        m_strAction = ACTION_CLOSE_WINDOW_MODE
        '    End If
        'End If
        If m_strMode <> "" And m_strMode = MODE_SUBPROJECT Then
            If m_strProjectSetting = PROJECT_SETTING_NORMAL Then
                m_strAction = ACTION_CLOSE_WINDOW_SUBPROJECT
            End If
        ElseIf m_strMode <> "" Then
            If m_strProjectSetting = PROJECT_SETTING_NORMAL Then
                m_strAction = ACTION_CLOSE_WINDOW_MODE
            End If
        End If
        'Nikhil
        'Code added by SandipL on 24 Jan 2006 for Task Custom Fields Functionality
        Dim strTypeInaccessibleCustomFieldList As String
        m_strCustomFieldList = HttpContext.Current.Request.Form("CustomFieldList")
        strTypeInaccessibleCustomFieldList = HttpContext.Current.Request.Form("TypeInaccessibleCustomFieldList")
        If m_strCustomFieldList <> "" Then
            Dim arrCustomFields() As String = Split(m_strCustomFieldList, ",")
            Dim intCount As Integer

            If m_lngTaskId > 0 Then
                strQuery = " Update tbl_PM_ProjectTasks set "
                For intCount = 0 To arrCustomFields.Length - 1
                    If HttpContext.Current.Request.Form("Dummy" + arrCustomFields(intCount)) Is Nothing Then
                        If InStr(1, arrCustomFields(intCount), "CustomFieldDate") > 0 And HttpContext.Current.Request.Form(arrCustomFields(intCount)) = "" Then
                            strQuery = strQuery & arrCustomFields(intCount) & "=NULL,"
                        Else
                            strQuery = strQuery & arrCustomFields(intCount) & "='" & CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.Form(arrCustomFields(intCount))) + "',"
                        End If
                    Else
                        If InStr(1, arrCustomFields(intCount), "CustomFieldDate") > 0 And HttpContext.Current.Request.Form("Dummy" + arrCustomFields(intCount)) = "" Then
                            strQuery = strQuery & arrCustomFields(intCount) & "=NULL,"
                        Else
                            strQuery = strQuery & arrCustomFields(intCount) & "='" & CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.Form("Dummy" + arrCustomFields(intCount))) + "',"
                        End If
                    End If
                Next
                If strTypeInaccessibleCustomFieldList <> "" Then
                    Dim arrInaccessibleCustomFields() As String = Split(strTypeInaccessibleCustomFieldList, ",")
                    For intCount = 0 To arrInaccessibleCustomFields.Length - 1
                        strQuery = strQuery & arrInaccessibleCustomFields(intCount) & "=NULL,"
                    Next
                End If
                strQuery = strQuery.Substring(0, strQuery.Length - 1)
                If (m_strTaskIDList <> "" And Not m_strTaskIDList Is Nothing) Then
                    strQuery = strQuery + " where TaskID IN (" & m_strTaskIDList & ") OR TaskID IN (Select ParentTask_UID From tbl_PM_ProjectTasks Where TaskID IN (" & m_strTaskIDList & ")) OR ParentTask_UID  IN (" & m_strTaskIDList & ")"
                Else
                    strQuery = strQuery + " where TaskID = " & m_lngTaskId & " OR TaskID = (Select ParentTask_UID From tbl_PM_ProjectTasks Where TaskID = " & m_lngTaskId & ") OR ParentTask_UID = " & m_lngTaskId
                End If

                CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
            End If
        End If
        'End addition by SandipL on 24 Jan 2006


        'Modified by MrugajaB on 22nd Sept 2006 for Whiziblesem SP7 Issue ID.6197
        'This code is especially written for case 2 and 3 projects where links other than save link do not get token when called through module, phase etc

        If (m_strAction = "Save") And (m_strToken = "") And (m_lngTaskId > 0) Then
            m_strToken = CommonFunctions.Security.Token.GetToken(CType(m_lngTaskId, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(m_lngTagId, String))
        End If
        'End Modification
    End Sub

    Private Sub GetProjectSettingsDetails()
        '====================================================================
        ' Procedure Name       : GetProjectSettingsDetails
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : This procedure gets the Project settings information from the database.
        ' Description          : The UseActivities and ApplyEffortDistribution flags are used while assigning the
        '                        Tasks to the resources and while distributing the work hours between them.
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : May 03, 2004
        ' Revisions            : 
        '=====================================================================
        Dim strQuery As String = ""
        Dim drProjectSettings As IDataReader
        Dim blnUseActivities As Boolean = False
        Dim blnApplyEffortDistribution As Boolean = False

        'Modified BY NitinVS on 21 May 2007 for WhizibleSEM 7.0 
        ' Changed select to SP 
        strQuery = "usp_sel_tbl_PM_Project_TaskCaseStructure " & m_lngProjectId.ToString()

        drProjectSettings = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If drProjectSettings.Read() Then
            blnUseActivities = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("HaveSubTaskTypes"), "False"), Boolean)
            blnApplyEffortDistribution = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ApplyEffortDistribution"), "False"), Boolean)
            m_lngProjectLocationID = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("LocationID"), "0"), Long)
            m_strProjectStartDate = CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ExpectedStartDate"), "").ToString()
            m_strProjectEndDate = CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ExpectedEndDate"), "").ToString()
            If m_strProjectStartDate <> "" Then m_strProjectStartDate = CommonFunctions.Dates.GetDate(CType(m_strProjectStartDate, Date))
            If m_strProjectEndDate <> "" Then m_strProjectEndDate = CommonFunctions.Dates.GetDate(CType(m_strProjectEndDate, Date))
            m_HaveSubTaskTypes = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("HaveSubTaskTypes"), "False"), Boolean)
            m_ApplyEffortDistribution = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ApplyEffortDistribution"), "False"), Boolean)
            m_bitResourceValidation = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ResourceValidation"), "False"), Short)
            ' True is treated as -1 
            If m_bitResourceValidation = -1 Then
                m_bitResourceValidation = 1
            End If
            m_blnBillable = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("Billable"), "False"), Boolean)
            m_blnProjectActive = Not (CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("Over"), "False"), Boolean))
        End If
        CommonFunctions.Data.DisposeDataReader(drProjectSettings)

        'Depending upon the Project Level Settings and the Page Called from set the value
        If blnApplyEffortDistribution = False And blnUseActivities = False Then
            m_strProjectSetting = PROJECT_SETTING_NORMAL
        ElseIf blnUseActivities = True Then
            m_strProjectSetting = PROJECT_SETTING_ACTIVITY
        ElseIf blnApplyEffortDistribution = True Then
            m_strProjectSetting = PROJECT_SETTING_EFFORT_DISTRIBUTION
        End If
        If m_lngReviewActionId > 0 Or m_lngMitigationPlanId > 0 Or m_lngTrainingResourceId > 0 Then
            m_strProjectSetting = PROJECT_SETTING_NORMAL
        End If
    End Sub

    Private Sub DeleteAssignedResources()
        '====================================================================
        ' Procedure Name       : DeleteAssignedResources
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : Deletes the Selected Resources/Activities
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : May 10, 2004
        ' Revisions            : Modified by Santosh Pawar on 30-Nov-2004
        '						 Purpose: To Void Tasks one by one and allow trigger to execute. 
        '						          other wise trigger execution will be only once for multiple task update.
        '=====================================================================
        Dim strResourceList As String = ""
        Dim strQuery As String = ""
        Dim strResourceListArray() As String
        Dim intCounter As Integer


        strResourceList = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkDelete")).Trim()

        'Commented By VidyaJ - DA Performance Issue - 89 (SP4)

        'If strResourceList <> "" Then
        '    strResourceListArray = Split(strResourceList, ",")
        '    For intCounter = 0 To strResourceListArray.Length - 1
        '        strQuery = "UPDATE tbl_PM_ProjectTasks SET IsActive = 0,ActualEndDate=GetDate() "
        '        strQuery &= "WHERE TaskID IN (" & strResourceListArray(intCounter) & ")"
        '        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        '    Next
        'End If
        If strResourceList <> "" Then
            strQuery = " EXEC usp_upd_UpdateTaskStatus '" & CommonFunctions.General.BuildQueryString(strResourceList) & "',0," & m_lngProjectId.ToString()
            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        End If
        'End Of Modifications

    End Sub

    Private Sub GetLCERelatedInformation()
        '====================================================================
        ' Procedure Name       : GetLCERelatedInformation
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : This procedure fetch the LCE related information from the database.
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : May 10, 2004
        ' Revisions            : 
        '=====================================================================
        Dim drLCE As IDataReader
        Dim strQuery As String = ""

        strQuery = "EXEC usp_Sel_tbl_PM_LCEDistribution_Configuration " & m_lngProjectId.ToString()
        drLCE = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drLCE) <> "" Then
            If drLCE.Read() Then
                m_blnLCEProject = CType(CommonFunctions.Data.CheckIsDBNull(drLCE.Item("LCE_Project"), "False"), Boolean)
                m_blnLCEDepartment = CType(CommonFunctions.Data.CheckIsDBNull(drLCE.Item("LCE_Department"), "False"), Boolean)
                m_blnLCEDeptActivity = CType(CommonFunctions.Data.CheckIsDBNull(drLCE.Item("LCE_DepartmentActivity"), "False"), Boolean)
                m_blnLCESystem = CType(CommonFunctions.Data.CheckIsDBNull(drLCE.Item("LCE_System"), "False"), Boolean)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drLCE)
    End Sub

    Private Sub GetValuesToValidateLCE()
        '====================================================================
        ' Procedure Name       : ValidateLCE
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : This procedure validates the LCE using some configuration information.
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : May 10, 2004
        ' Revisions            : 
        '=====================================================================
        Dim drLCE As IDataReader
        Dim strQuery As String = ""
        Dim blnAllowLCEDistribution As Boolean = False
        Dim strMsg As String = ""

        'strQuery = "SELECT AllowLCEDistribution FROM tbl_PM_CompanyInformation"
        'drLCE = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        'If CommonFunctions.General.CheckIsNothing(drLCE) <> "" Then
        '    If drLCE.Read() Then
        '        blnAllowLCEDistribution = CType(CommonFunctions.Data.CheckIsDBNull(drLCE.Item("AllowLCEDistribution"), "False"), Boolean)
        '    End If
        'End If
        'CommonFunctions.Data.DisposeDataReader(drLCE)

        If blnAllowLCEDistribution = False Then
            m_blnLCEProject = True
            m_blnLCEDepartment = False
            m_blnLCEDeptActivity = False
            m_blnLCESystem = False
        End If

        If m_blnLCEProject = False And m_blnLCEDepartment = False And m_blnLCEDeptActivity = False And m_blnLCESystem = False Then
            strMsg = MyBase.GetResourceString("NO_LCE_VALIDATION_CONFIGURATION")
            strMsg = Replace(strMsg, "<=>", "LCE")
            m_sbClientSideScript.Append("alert('" & strMsg & "');")
            m_strAction = ACTION_DISPLAY
        Else
            If blnAllowLCEDistribution = True Then
                strQuery = "EXEC usp_Sel_PM_DepartmentBalanceLCE " & m_lngProjectId.ToString()
                strQuery &= ", " ' & strDepartment
            Else
                strQuery = "EXEC usp_Sel_PM_DepartmentBalanceLCE " & m_lngProjectId.ToString() & ", NULL"
            End If
            If m_lngTaskId > 0 Then
                strQuery &= ", " & m_lngTaskId.ToString()
            Else
                strQuery &= ", NULL"
            End If
            drLCE = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drLCE) <> "" Then
                If drLCE.Read() Then
                    'Trupti 19-May-09
                    m_dblTotalAllocatedTaskLCE = CType(CommonFunctions.Data.CheckIsDBNull(drLCE.Item("AllocatedLCETotal"), "0"), Double)
                    'end
                    m_dblTotalLCE = CType(CommonFunctions.Data.CheckIsDBNull(drLCE.Item("LCETotal"), "0"), Double)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drLCE)
            'If CDbl(CDbl("0" & m_strCurrentWork) + dblTotalAllocatedTaskLCE) > CDbl(dblTotalLCE) Then
            '    If m_blnLCEDepartment = True Then
            '        strMsg = MyBase.GetResourceString("ASSIGNEDTASKS_WORKHOURS_NOT_MORE_THAN_DEPARTMENT_WORKHOURS")
            '        strMsg = Replace(strMsg, "<=>", "LCE")
            '        m_sbClientSideScript.Append("alert('" & strMsg & "');")
            '    ElseIf m_blnLCEProject = True Then
            '        strMsg = MyBase.GetResourceString("ASSIGNEDTASKS_WORKHOURS_NOT_MORE_THAN_PROJECT_WORKHOURS")
            '        strMsg = Replace(strMsg, "<=>", "LCE")
            '        m_sbClientSideScript.Append("alert('" & strMsg & "');")
            '    End If
            '    m_strAction = ACTION_DISPLAY
            'End If
        End If
    End Sub

    Private Sub GetParentTaskID()
        '====================================================================
        ' Procedure Name       : GetParentTaskID
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : Get the Parent Task Id from the SubTask ID
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : May 21, 2004
        ' Revisions            : 
        '=====================================================================
        Dim strQuery As String = ""
        Dim lngTempID As Long = 0

        strQuery = "Exec usp_Sel_GetParentTaskID " & m_lngTaskId.ToString()
        lngTempID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Long)
        If lngTempID <> 0 Then m_lngTaskId = lngTempID
    End Sub

    Private Sub GetChildTaskID()
        '====================================================================
        ' Procedure Name       : GetChildTaskID
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : Get the Child Task Id from the ParentTaskID
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : August 10, 2004
        ' Revisions            : 
        '=====================================================================
        Dim strQuery As String = ""
        Dim lngTempID As Long = 0

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strQuery = "SELECT TaskID FROM tbl_PM_ProjectTasks WHERE IsActive=1 AND ParentTask_UID = " & m_lngTaskId.ToString()
        strQuery = "usp_sel_tbl_PM_ProjectTasks_IsActive_TaskID " & m_lngTaskId.ToString()
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        lngTempID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Long)
        If lngTempID <> 0 Then m_lngTaskId = lngTempID
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
        Dim strWFHDays As String = ""
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
            End If
        End While
        CommonFunctions.Data.DisposeDataReader(drLeave)
        strReturn = strTemp
        'strReturn = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), ""), "")
        Return strReturn

    End Function

    Private Function GetDeliverableName(ByVal lngDeliverableID As Long) As String
        '====================================================================
        ' Procedure Name       : GetDeliverableName
        ' Parameters Passed    : lngDeliverableID is the Unique ID of the Deliverable.
        ' Returns              : The Title of the Deliverable
        ' Parameters Affected  : None
        ' Purpose              : Get the name of the deliverable
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : September 21, 2004
        ' Revisions            : 
        '=====================================================================
        Dim strQuery As String = ""
        Dim strReturn As String = ""
        ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
        If lngDeliverableID <> 0 Then

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strQuery = "SELECT Title FROM tbl_PM_OtherSchedules WHERE ScheduleID = " & lngDeliverableID.ToString()
            strQuery = "usp_sel_tbl_PM_OtherSchedules_Title_ScheduleID " & lngDeliverableID.ToString()
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            strReturn = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "")
        End If
        ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

        Return strReturn
    End Function
#End Region

    Private Sub InitiateControlArray()
        Dim strQuery As String
        Dim drWork As IDataReader

        strQuery = "Exec usp_Sel_tbl_PRS_ProjectTypes NULL, " & m_lngProjectId.ToString()
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                m_arrControlDetails(ControlIndex.CTRL_INDEX_TASKTYPE, 0) = True
                m_arrControlDetails(ControlIndex.CTRL_INDEX_TASKTYPE, 1) = True
                m_arrControlDetails(ControlIndex.CTRL_INDEX_PHASE, 0) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ShowPhaseInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_PHASE, 1) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("PhaseMandatoryInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_MODULE, 0) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ShowModuleInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_MODULE, 1) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ModuleMandatoryInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_SUBPROJECT, 0) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ShowSubProjectInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_SUBPROJECT, 1) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("SubProjectMandatoryInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_MILESTONE, 0) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ShowMilestoneInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_MILESTONE, 1) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("MilestoneMandatoryInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_CHANGEREQUEST, 0) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ShowChangeRequestInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_CHANGEREQUEST, 1) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ChangeRequestMandatoryInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_FEATURE, 0) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ShowFeatureInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_FEATURE, 1) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("FeatureMandatoryInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_ESTIMATIONTYPE, 0) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ShowEstimationTypeInAT"), "False"), Boolean)
                m_arrControlDetails(ControlIndex.CTRL_INDEX_ESTIMATIONTYPE, 1) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("EstimationTypeMandatoryInAT"), "False"), Boolean)
            Else
                m_arrControlDetails(ControlIndex.CTRL_INDEX_TASKTYPE, 0) = True
                m_arrControlDetails(ControlIndex.CTRL_INDEX_TASKTYPE, 1) = True
                m_arrControlDetails(ControlIndex.CTRL_INDEX_PHASE, 0) = True
                m_arrControlDetails(ControlIndex.CTRL_INDEX_PHASE, 1) = False
                m_arrControlDetails(ControlIndex.CTRL_INDEX_MODULE, 0) = True
                m_arrControlDetails(ControlIndex.CTRL_INDEX_MODULE, 1) = False
                m_arrControlDetails(ControlIndex.CTRL_INDEX_SUBPROJECT, 0) = True
                m_arrControlDetails(ControlIndex.CTRL_INDEX_SUBPROJECT, 1) = False
                m_arrControlDetails(ControlIndex.CTRL_INDEX_MILESTONE, 0) = True
                m_arrControlDetails(ControlIndex.CTRL_INDEX_MILESTONE, 1) = False
                m_arrControlDetails(ControlIndex.CTRL_INDEX_CHANGEREQUEST, 0) = True
                m_arrControlDetails(ControlIndex.CTRL_INDEX_CHANGEREQUEST, 1) = False
                m_arrControlDetails(ControlIndex.CTRL_INDEX_FEATURE, 0) = False
                m_arrControlDetails(ControlIndex.CTRL_INDEX_FEATURE, 1) = False
                m_arrControlDetails(ControlIndex.CTRL_INDEX_ESTIMATIONTYPE, 0) = False
                m_arrControlDetails(ControlIndex.CTRL_INDEX_ESTIMATIONTYPE, 1) = False
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)
    End Sub

    Private Sub Store_FilterValues()
        '====================================================================
        ' Procedure Name       : Store_FilterValues
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : This Procedure stores the filter values in the hidden controls so that those 
        '                        should persist between the submit.
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : May 06, 2004
        ' Revisions            : 
        '=====================================================================
        Dim strFilterValue As String = ""

        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode

        m_strFilterQueryString = ""
        'Hidden Fields
        strFilterValue = CommonFunctions.General.CheckIsNothing(Request("optTasks"))
        CommonFunctions.HTMLControls.DrawTextBox("optTasks", "optTasks", , , , strFilterValue, , , , , , True, EnableHTMLEncode:=True)
        If strFilterValue <> "" Then m_strFilterQueryString &= "&optTasks=" & Server.UrlEncode(strFilterValue)

        strFilterValue = CommonFunctions.General.CheckIsNothing(Request("optStatus"))
        CommonFunctions.HTMLControls.DrawTextBox("optStatus", "optStatus", , , , strFilterValue, , , , , , True, EnableHTMLEncode:=True)
        If strFilterValue <> "" Then m_strFilterQueryString &= "&optStatus=" & Server.UrlEncode(strFilterValue)

        CommonFunctions.HTMLControls.DrawTextBox("cboFilter_EmployeeID", "cboFilter_EmployeeID", , , , m_lngFilterEmployeeId.ToString(), , , , , , True, EnableHTMLEncode:=True)
        If m_lngFilterEmployeeId > 0 Then m_strFilterQueryString &= "&cboFilter_EmployeeID=" & Server.UrlEncode(m_lngFilterEmployeeId.ToString())

        strFilterValue = CommonFunctions.General.CheckIsNothing(Request("cboFilter_DepartmentID"))
        CommonFunctions.HTMLControls.DrawTextBox("cboFilter_DepartmentID", "cboFilter_DepartmentID", , , , strFilterValue, , , , , , True, EnableHTMLEncode:=True)
        If strFilterValue <> "" Then m_strFilterQueryString &= "&cboFilter_DepartmentID=" & Server.UrlEncode(strFilterValue)

        strFilterValue = CommonFunctions.General.CheckIsNothing(Request("cboFilter_DeliverableID"))
        CommonFunctions.HTMLControls.DrawTextBox("cboFilter_DeliverableID", "cboFilter_DeliverableID", , , , strFilterValue, , , , , , True, EnableHTMLEncode:=True)
        If strFilterValue <> "" Then m_strFilterQueryString &= "&cboFilter_DeliverableID=" & Server.UrlEncode(strFilterValue)

        strFilterValue = CommonFunctions.General.CheckIsNothing(Request("cboFilter_GroupID"))
        CommonFunctions.HTMLControls.DrawTextBox("cboFilter_GroupID", "cboFilter_GroupID", , , , strFilterValue, , , , , , True, EnableHTMLEncode:=True)
        If strFilterValue <> "" Then m_strFilterQueryString &= "&cboFilter_GroupID=" & Server.UrlEncode(strFilterValue)

        strFilterValue = CommonFunctions.General.CheckIsNothing(Request("cboFilter_IsTaskCompleted"))
        CommonFunctions.HTMLControls.DrawTextBox("cboFilter_IsTaskCompleted", "cboFilter_IsTaskCompleted", , , , strFilterValue, , , , , , True, EnableHTMLEncode:=True)
        If strFilterValue <> "" Then m_strFilterQueryString &= "&cboFilter_IsTaskCompleted=" & Server.UrlEncode(strFilterValue)

        strFilterValue = CommonFunctions.General.CheckIsNothing(Request("txthidSortBy"))
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortBy", "txthidSortBy", , , , strFilterValue, , , , , , True, EnableHTMLEncode:=True)
        If strFilterValue <> "" Then m_strFilterQueryString &= "&txthidSortBy=" & Server.UrlEncode(strFilterValue)

        strFilterValue = CommonFunctions.General.CheckIsNothing(Request("txthidSortOrder"))
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortOrder", "txthidSortOrder", , , , strFilterValue, , , , , , True, EnableHTMLEncode:=True)
        If strFilterValue <> "" Then m_strFilterQueryString &= "&txthidSortOrder=" & Server.UrlEncode(strFilterValue)

        strFilterValue = CommonFunctions.General.CheckIsNothing(Request("PageNumber"))
        strFilterValue = CommonFunctions.General.UnBuildQueryString(strFilterValue)
        CommonFunctions.HTMLControls.DrawTextBox("PageNumber", "PageNumber", , , , strFilterValue, , , , , , True, EnableHTMLEncode:=True)
        If strFilterValue <> "" Then m_strFilterQueryString &= "&PageNumber=" & Server.UrlEncode(strFilterValue)

        strFilterValue = CommonFunctions.General.CheckIsNothing(Request("PageType"))
        CommonFunctions.HTMLControls.DrawTextBox("PageType", "PageType", , , , strFilterValue, , , , , , True, EnableHTMLEncode:=True)
        If strFilterValue <> "" Then m_strFilterQueryString &= "&PageType=" & Server.UrlEncode(strFilterValue)

        strFilterValue = CommonFunctions.General.CheckIsNothing(Request("ReviewActionID"))
        CommonFunctions.HTMLControls.DrawTextBox("ReviewActionID", "ReviewActionID", , , , strFilterValue, , , , , , True, EnableHTMLEncode:=True)
        If strFilterValue <> "" Then m_strFilterQueryString &= "&ReviewActionID=" & Server.UrlEncode(strFilterValue)

        strFilterValue = CommonFunctions.General.CheckIsNothing(Request("ReviewStatisticsID"))
        CommonFunctions.HTMLControls.DrawTextBox("ReviewStatisticsID", "ReviewStatisticsID", , , , strFilterValue, , , , , , True, EnableHTMLEncode:=True)
        If strFilterValue <> "" Then m_strFilterQueryString &= "&ReviewStatisticsID=" & Server.UrlEncode(strFilterValue)

        strFilterValue = CommonFunctions.General.CheckIsNothing(Request("RiskID"))
        CommonFunctions.HTMLControls.DrawTextBox("RiskID", "RiskID", , , , strFilterValue, , , , , , True, EnableHTMLEncode:=True)
        If strFilterValue <> "" Then m_strFilterQueryString &= "&RiskID=" & Server.UrlEncode(strFilterValue)

        strFilterValue = CommonFunctions.General.CheckIsNothing(Request("MitigationPlanID"))
        CommonFunctions.HTMLControls.DrawTextBox("MitigationPlanID", "MitigationPlanID", , , , strFilterValue, , , , , , True, EnableHTMLEncode:=True)
        If strFilterValue <> "" Then m_strFilterQueryString &= "&MitigationPlanID=" & Server.UrlEncode(strFilterValue)

        strFilterValue = CommonFunctions.General.CheckIsNothing(Request("TrainingID"))
        CommonFunctions.HTMLControls.DrawTextBox("TrainingID", "TrainingID", , , , strFilterValue, , , , , , True, EnableHTMLEncode:=True)
        If strFilterValue <> "" Then m_strFilterQueryString &= "&TrainingID=" & Server.UrlEncode(strFilterValue)

        strFilterValue = CommonFunctions.General.CheckIsNothing(Request("TrainingResourceID"))
        CommonFunctions.HTMLControls.DrawTextBox("TrainingResourceID", "TrainingResourceID", , , , strFilterValue, , , , , , True, EnableHTMLEncode:=True)
        If strFilterValue <> "" Then m_strFilterQueryString &= "&TrainingResourceID=" & Server.UrlEncode(strFilterValue)
        If m_strFilterQueryString <> "" Then
            m_strFilterQueryString = Server.UrlEncode(m_strFilterQueryString)
        End If

        '''End of Modification by Dhanashri S on 7 Oct 2015 
    End Sub

#Region " Menu or Grid Objects Event Handlers "
    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print

        Select Case Args.MenuColIndex
            'Case MenuIndex.ADD_RESOURCES
            '    If m_strProjectSetting = PROJECT_SETTING_NORMAL Then Cancel = True
            '    If m_blnIsTaskComplete = True Then Cancel = True
            '    If m_blnAllowResourceAllocation = True Then
            '        If m_objAccessRights.Add = False Or m_blnProjectActive = False Then Cancel = True
            '    Else
            '        Cancel = True
            '    End If

            Case MenuIndex.ASSIGN_RESOURCES
                If m_strProjectSetting = PROJECT_SETTING_NORMAL Then Cancel = True
                If m_blnIsTaskComplete = True Then Cancel = True
                If m_lngTaskId = 0 Then
                    Cancel = True
                Else
                    If m_objAccessRights.Edit = False Or m_blnProjectActive = False Then Cancel = True
                End If
                'Added by VidyaJ on  Jan 15, 2005
                'For IssueID - 15416
                If m_blnSave = False Then Cancel = True

            Case MenuIndex.BACK
                If m_lngReviewActionId > 0 Or m_lngMitigationPlanId > 0 Or m_lngTrainingResourceId > 0 Or m_strMode <> "" Then Cancel = True

                'Added By VivekP On 2 jun 2005
                If Request.QueryString("FromTimesheet") = "CreateTask" Then
                    Cancel = True
                End If
                'End Of addition on 2 jun 2005

            Case MenuIndex.CLEAR_BASELINE
                If m_blnIsTaskComplete = True Then Cancel = True
                If m_lngTaskId = 0 Then
                    Cancel = True
                Else
                    If m_blnProjectActive = False Then Cancel = True

                    'Modified By NitinVS on 20 Mar 2007 for WhizibleSEM SP 8 Regression Issue 11873 
                    ' Added Condition for m_objAccessRights.Edit = False 

                    If m_objAccessRights.Edit = False Then Cancel = True

                    'End Modified By NitinVS on 20 Mar 2007 for WhizibleSEM SP 8 Regression Issue 11873 

                End If
                'Added by VidyaJ on  Jan 15, 2005
                'For IssueID - 15416
                If m_blnSave = False Then Cancel = True

            Case MenuIndex.CLOSE
                If Not (m_lngReviewActionId > 0 Or m_lngMitigationPlanId > 0 Or m_lngTrainingResourceId > 0 Or m_strMode <> "") Then Cancel = True
                If Not m_strProjectSetting = PROJECT_SETTING_NORMAL Then
                    Args.FunctionName = "CloseWindow_OnClick()"
                End If

            Case MenuIndex.DELETE_RESOURCES
                If m_strProjectSetting = PROJECT_SETTING_NORMAL Then Cancel = True
                If m_blnIsTaskComplete = True Then Cancel = True
                If m_lngTaskId = 0 Then
                    Cancel = True
                Else
                    If m_objAccessRights.Edit = False Or m_blnProjectActive = False Then Cancel = True
                End If
                'Added by VidyaJ on  Jan 15, 2005
                'For IssueID - 15416
                If m_blnSave = False Then Cancel = True
            Case MenuIndex.HELP

            Case MenuIndex.SAVE
                ' Modified By NitinVS on 21 Mar 2007 for whizibleSEM SP 8 regression ISsue 11160 
                ' SAve link to be shown for Copy Task for Completed Tasks 
                'If m_blnIsTaskComplete = True Then Cancel = True
                If m_blnIsTaskComplete = True And CommonFunction.General.CheckIsNothing(Request.QueryString("CopyTask"), "") = "" Then Cancel = True
                ' End Modification By NitinVS on 21 Mar 2007 for whizibleSEM SP 8 regression ISsue 11160  
                If m_lngTaskId = 0 Then
                    If m_blnProjectActive = False Then Cancel = True
                Else
                    If m_objAccessRights.Edit = False Or m_blnProjectActive = False Then Cancel = True
                End If
                'Added by VidyaJ on  Jan 15, 2005
                'For IssueID - 15416

                If m_blnSave = False Then Cancel = True

                ' Added BY NitinVS on 21 Mar 2007 for WhizibleSEM SP 8 Regression Issue 
                If (HttpContext.Current.Request("Mode") = "New" Or _
                    HttpContext.Current.Request("Mode") = "ADD_NEW") And _
                    m_objAccessRights.Add = False Then Cancel = True
                ' End Addition By  NitinVS on 21 Mar 2007 for WhizibleSEM SP 8 Regression Issue 
            Case MenuIndex.SEND_EMAIL
                If Not m_strProjectSetting = PROJECT_SETTING_NORMAL Then Cancel = True
                If m_blnIsTaskComplete = True Then Cancel = True
                If m_lngTaskId = 0 Then Cancel = True
                If m_blnIsDeferredTask = True Then Cancel = True
                If Not (m_blnSendMail = True And m_blnShowPopup = True) Then Cancel = True
                If m_objAccessRights.Edit = False Then Cancel = True
                'Added by VidyaJ on  Jan 15, 2005
                'For IssueID - 15416
                If m_blnSave = False Then Cancel = True
            Case MenuIndex.SET_BASELINE
                If m_blnIsTaskComplete = True Then Cancel = True
                If m_lngTaskId = 0 Then
                    Cancel = True
                Else
                    If m_blnProjectActive = False Then Cancel = True
                End If
                'Added by VidyaJ on  Jan 15, 2005
                'For IssueID - 15416
                If m_blnSave = False Then Cancel = True

                'Modified By NitinVS on 20 Mar 2007 for WhizibleSEM SP 8 Regression Issue 11873 
                ' Added Condition for m_objAccessRights.Edit = False 

                If m_objAccessRights.Edit = False Then Cancel = True

                'End Modified By NitinVS on 20 Mar 2007 for WhizibleSEM SP 8 Regression Issue 11873 

            Case MenuIndex.SHOW_BASELINE
                If m_blnIsTaskComplete = True Then Cancel = True
                If m_lngTaskId = 0 Then Cancel = True
                'Added by VidyaJ on  Jan 15, 2005
                'For IssueID - 15416
                If m_blnSave = False Then Cancel = True

                ' Added By NitinVS on 01-Apr-2005 for PBNITE SP2 IssueID = 17160 
            Case MenuIndex.UPLOAD_DOCUMENT
                If m_lngTaskId = 0 Then Cancel = True
            Case MenuIndex.ATTACH_URL
                If m_lngTaskId = 0 Then Cancel = True
            Case MenuIndex.DELETE_DOCUMENT
                'Modified by PrajaktaR on 3 June 2005 for Aspire IssueID 19208
                If m_objAccessRights.Edit = False Or m_blnProjectActive = False Then Cancel = True
                'If m_objAccessRights.Delete = True Then
                If m_lngTaskId = 0 Then Cancel = True
                'End Addition By NitinVS on 01-Apr-2005 for PBNITE SP2 IssueID = 17160
                'End If
                'Added by VivekP On 7 Jun 2005
            Case MenuIndex.CLOSE_TIMESHEET
                'If Request.QueryString("FromTimesheet") <> "CreateTask" Or (m_HaveSubTaskTypes = False And m_ApplyEffortDistribution = False) Then
                '    Cancel = True
                'End If
                If Request.QueryString("FromTimesheet") <> "CreateTask" Then
                    Cancel = True
                End If
                'End Of Modification On 7 Jun 2005 By VivekP
        End Select
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint

        Dim strQuery As String = ""
        Dim drSubTask As IDataReader
        Dim strDataFieldValue As String = ""
        Dim strValues As String = ""
        Dim blnTaskWorkStarted As Boolean
        Dim blnTaskCompleted As Boolean

        Select Case Args.ColIndex
            Case 0
                'Do not show link on the resource name when the Task is completed.
                blnTaskCompleted = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsTaskComplete"), "False"), Boolean)
                If blnTaskCompleted = True Then
                    Args.EnableLink = False
                End If

                ' Added By NitinVS on 20 Mar 2006 for WhizibleSEM SP 8 Regression Issue 12054 
                ' Not to show link when edit access is not available 
                If m_objAccessRights.Edit = False Or m_blnProjectActive = False Then Args.EnableLink = False
                'End Addition By NitinVS on 20 Mar 2006 for WhizibleSEM SP 8 Regression Issue 12054  
            Case 1
                m_blnHasResources = True
                If m_strProjectSetting = PROJECT_SETTING_ACTIVITY Then
                    'commented By NitinVS on 25 May 2007 for whizibleSEM 7 
                    'strDataFieldValue = CommonFunctions.General.CheckIsNothing(Args.DataFieldValue).Trim()
                    'If strDataFieldValue <> "" Then
                    '    strQuery = "EXEC USP_Sel_tbl_PM_SubTaskTypes '" & CommonFunctions.General.BuildQueryString(strDataFieldValue) & "'"
                    '    drSubTask = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                    '    While drSubTask.Read()
                    '        strValues &= drSubTask.Item("SubTaskType").ToString() & ", "
                    '    End While
                    '    CommonFunctions.Data.DisposeDataReader(drSubTask)
                    '    strValues = strValues.Trim()
                    '    If strValues <> "" Then       'To Remove Last comma 
                    '        strValues = Left(strValues, Len(strValues) - 1)
                    '    End If
                    '    Args.DataFieldValue = strValues
                    'End If
                    ' end commenting By NitinVS on 25 May 2007 for whizibleSEM 7 
                Else
                    Cancel = True
                End If
                'Case 5
            Case 6
                'Commented By VidyaJ - For IssueID - 86 - SP4
                ''Diable the delete checkbox when the Task is completed.
                'blnTaskWorkStarted = CType(IIf(CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ActualWork"), "0"), Integer) = 0, False, True), Boolean)
                'If blnTaskWorkStarted = True Then
                '    Args.IsCheckBoxDisabled = True
                'End If

                ''Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
            Case 2
                Cancel = True
                m_strdispCurrentWork = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + Args.DataReader("Work").ToString() + "',1)", True)
                Args.StringToBeInserted = "<td valign='top' align='right'>" + m_strdispCurrentWork + "</td>"
            Case 5
                Cancel = True
                m_strdispActualWork = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + Args.DataReader("ActualWork").ToString() + "',1)", True)
                Args.StringToBeInserted = "<td valign='top' align='right'>" + m_strdispActualWork + "</td>"
                ''End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change

        End Select
    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        Select Case Args.ColIndex
            Case 1
                If m_strProjectSetting = PROJECT_SETTING_EFFORT_DISTRIBUTION Then Cancel = True
        End Select
    End Sub

#End Region
    ' Added By NitinVS on 19 March 2005 for PBNITE SP2
    ' To Open url and Remove the Review and Show history Link
    Private Sub m_objGridDocument_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGridDocument.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "FILENAME" Then
            Dim DocumentID As String
            DocumentID = Args.DataReader("DocumentID").ToString

            If CType(Args.DataReader("IsURL"), Boolean) = True Then
                Args.EnableLink = False
                Args.ApplyHTMLEncode = False
                Args.DataFieldValue = "<A href = '" + Args.DataReader("FileName").ToString + "' target=_new > " + Args.DataReader("FileName").ToString + " </A>"
            End If
        End If

        If Args.ColumnName.ToUpper = "REVIEW" Or Args.ColumnName.ToUpper = "HISTORY" Then
            If CType(Args.DataReader("IsURL"), Boolean) = True Then
                Args.EnableLink = False
                Args.DataFieldValue = ""
            End If
        End If

    End Sub
    ' End Addition By NitinVS on 19 March 2005 for PBNITE SP2
    ''Added by ManishK on 7th Feb 2006 for WhizibleSem sp 6 WFH confirm box issue foe Employee leaves
    Protected Sub XMLHTTP_GetLeaves()
        Dim blnIsNewTask As Boolean
        Dim arrEmpId() As String
        Dim intCtr As Integer
        Dim intNumberOfEmployees As Integer = 0
        Dim dblTempWork As Double = 0
        Dim strEmployeeNames As String
        Dim strTempName As String
        Dim strEmployeeId As String
        Dim strCurrentStartDate As String
        Dim strCurrentEndDate As String
        Dim strLeaveMessage As String

        MyBase.InitializeResources("AppResources.PM_TaskAssignment", "AppResources")
        If m_lngTaskId > 0 Then
            blnIsNewTask = False
        Else
            blnIsNewTask = True
        End If

        strCurrentStartDate = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("FromDate"), "")
        strCurrentEndDate = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("ToDate"), "")
        strEmployeeId = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("EmployeeIDs"), "")

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("FromWhere"), "").ToUpper = "XMLHTTP" Then
            If m_strProjectSetting = PROJECT_SETTING_NORMAL Then
                If blnIsNewTask = True Then
                    arrEmpId = strEmployeeId.Split(CType(",", Char))
                    intNumberOfEmployees = arrEmpId.Length()
                    strEmployeeNames = ""
                    For intCtr = 0 To intNumberOfEmployees - 1
                        If arrEmpId(intCtr) <> "" Then
                            'Check if there is any leave(s) between the start date and end date
                            strTempName = CheckLeaves(CType(arrEmpId(intCtr), Long), strCurrentStartDate, strCurrentEndDate)
                            If strTempName <> "" Then strEmployeeNames &= strTempName + "<==>"
                        End If
                    Next
                    strLeaveMessage = strEmployeeNames
                Else
                    'Check if there is any leave(s) between the start date and end date
                    strTempName = CheckLeaves(CType(strEmployeeId, Long), strCurrentStartDate, strCurrentEndDate)
                    strLeaveMessage = strTempName
                End If
            End If
            Response.Clear()
            Response.Write(strLeaveMessage)
        End If
    End Sub
    ''End of Added by ManishK on 7th Feb 2006 for WhizibleSem sp 6 WFH confirm box issue foe Employee leaves

End Class
'Code added by SandipL on 24 Jan 2006
'Purpose :- General Class  for Ploting Custom Fields of Entities like Task,Deliverable,Reviews etc
Public Class PM_CustomFields
    Inherits WebPages.Template.WhizTemplate
#Region " Variable Declaration "
    Private m_strCustomFieldList As String 'Stores Accesible Custom Fields
    Private m_strFormName As String        'FormName on which CustomFields are to be plotted
    Public m_lngProjectId As Long
    Public m_lngRoleId As Long
    Public m_lngUserId As Long
    Private m_strTypeInaccessibleCustomFieldList As String
    Private m_strEntityName As String = "Task" 'can be Delivarble,Review etc
    Private m_intMaxRows As Integer
    Private m_intMaxCols As Integer
    Private m_strCurrentType As String = ""    'TypeID of Deliverable or Review
    Protected declarevariables As String = ""
    Private ArrCtlAttr(20) As String            'array to store Properties of Custom Fields such as name,caption,ht etc
    Private arrEventHandlers(30, 3) As String
    Private strFieldValue As String = ""
    Private strDummyFieldValue As String = ""
    Private m_strPrimaryKey As String           'can have value TaskID,ScheduleID,ReviewID etc
    Private m_strPrimaryTable As String         'Table From which Custom field Values  to be retrived
    Private m_strPrimaryKeyID As Long
    Private strEventHandlers As String
    Protected strDefaultScript As String
    Protected strClientSideScript As String
    Private m_blnShowDefaults As Boolean = False 'Show defaults ?
    Public IsAddNewMode As Boolean
    Public QueryStringForTypeChange As String 'Query string Passed to URL for Type change e.g "TaskTypeID"
    'Commented and Added By Bharat T on 9th-Oct-2015
    'Private arrValidationMessages(30) As String
    Private arrValidationMessages(50) As String
    'End of Commented and Added By Bharat T on 9th-Oct-2015


#End Region

    Public Property EntityName() As String
        Get
            Return m_strEntityName
        End Get
        Set(ByVal Value As String)
            m_strEntityName = Value
        End Set
    End Property
    Public Property PrimaryKey() As String
        Get
            Return m_strPrimaryKey
        End Get
        Set(ByVal Value As String)
            m_strPrimaryKey = Value
        End Set
    End Property
    Public Property PrimaryKeyValue() As Long
        Get
            Return m_strPrimaryKeyID
        End Get
        Set(ByVal Value As Long)
            m_strPrimaryKeyID = Value
        End Set
    End Property
    Public Property TypeID() As String
        Get
            Return m_strCurrentType
        End Get
        Set(ByVal Value As String)
            m_strCurrentType = Value
        End Set
    End Property
    Public Property PrimaryTable() As String
        Get
            Return m_strPrimaryTable
        End Get
        Set(ByVal Value As String)
            m_strPrimaryTable = Value
        End Set
    End Property
    Public ReadOnly Property VariableDeclarationScript() As String
        Get
            Return declarevariables
        End Get
    End Property
    Public ReadOnly Property ValidationScript() As String
        Get
            Return strClientSideScript
        End Get
    End Property
    Public ReadOnly Property AccesibleCustomFields() As String
        Get
            Return m_strCustomFieldList
        End Get
    End Property
    Public ReadOnly Property DefaultValueScript() As String
        Get
            Return strDefaultScript
        End Get
    End Property
    Public Property FormName() As String
        Get
            Return m_strFormName
        End Get
        Set(ByVal Value As String)
            m_strFormName = Value
        End Set
    End Property

    Private Sub DrawControl(ByRef ArrCtlAttr() As String)
        '==================================================================================
        ' Procedure Name		:	DrawControl
        ' Parameters Passed		:	arrCtlAttr : This array contains the attributes of the control to be drawn.
        ' Returns				:	No return Value.
        ' Parameters Affected	:	arrCtlAttr :- The array gets modified.
        ' Purpose				:	To actually draw the control as per the specifications in the array.
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	SandipL
        ' Created				:	20 Jan 2006
        ' Revisions				:	
        '==================================================================================		

        Dim strToBeInserted As String = ""
        Dim strProperty As String
        Dim intCtr As Integer
        Dim strControlCaption As String
        Dim strControlName As String
        Dim strControlValue As String = ""
        Dim SQLQuey As String
        Dim intControlWidth, intControlHeight, intControlMaxLength As Integer
        Dim blnReadOnly As Boolean = False
        Dim blnIsMandatory As Boolean = False
        Dim blnIsDisabled As Boolean = False
        strControlCaption = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION)
        ' If the default values have to be shown, then... (When the page is loaded for the first time.)
        '        If (IsAddNewMode = True And HttpContext.Current.Request(QueryStringForTypeChange) Is Nothing) Then
        If (IsAddNewMode = True) Then
            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE)
        End If

        If Not ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) Is Nothing Then
            strControlValue = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE)

            'If strControlValue = "" And Not HttpContext.Current.Request(QueryStringForTypeChange) Is Nothing Then
            '    If Not ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) Is Nothing Then
            '        strControlValue = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE)
            '    End If
            'End If

        Else
            strControlValue = ""
        End If

        'Control Name
        strControlName = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)

        ' control width 
        If Trim(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH)) <> "" Then
            intControlWidth = CType(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH), Integer)
        End If

        'Cotrol Height
        If Trim(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_HEIGHT)) <> "" Then
            intControlHeight = CType(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_HEIGHT), Integer)
        End If

        ' Read Only
        If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "True" Then
            blnReadOnly = True
            strToBeInserted = strToBeInserted & " disabled "
            blnIsDisabled = True
        Else
            blnReadOnly = False
            blnIsDisabled = False
        End If

        ' additional information.
        If Trim(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_OTHER_INFO)) <> "" Then
            strToBeInserted = strToBeInserted + Trim(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_OTHER_INFO)) + " "
        End If

        ' maxlength 
        If Trim(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) <> "" Then
            intControlMaxLength = CType(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH), Integer)
            'strToBeInserted = strToBeInserted + " maxlength=" + Trim(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) + " "
        End If

        ' mandatory 
        If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "True" Then
            blnIsMandatory = True
        Else
            blnIsMandatory = False
        End If


        ' Depending on the control type, draw the control.
        Select Case ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)

            Case CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString  ' Draw the text box.

                HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawTextBox(strControlName, strControlName, , intControlWidth, intControlMaxLength, strControlValue, , , , blnReadOnly, "", , strToBeInserted, , blnIsMandatory))

            Case CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                SQLQuey = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SQL_QUERY)
                HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawComboBox(strControlName, SQLQuey, intControlWidth, strControlValue, strToBeInserted, True, , , blnIsMandatory))

            Case CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_AREA.ToString  ' Draw the text area.

                'Modified By ShraddhaM on 27 July 2006
                'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, strControlCaption, , , m_strFormName, , , intControlWidth, intControlHeight, intControlMaxLength, strControlValue, , , , blnReadOnly, "", , strToBeInserted, , blnIsMandatory, Wrap:="Soft"))
                HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, strControlCaption, , , m_strFormName, , , intControlWidth, intControlHeight, intControlMaxLength, strControlValue, , , , blnReadOnly, "", , strToBeInserted, , blnIsMandatory, Wrap:="Soft", EnableHTMLEncode:=True))
                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            Case CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString  ' Draw the date field.
                If Not ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) Is Nothing Then
                    If Not IsDate(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE).Trim) Then
                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) = ""
                    End If
                Else
                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) = ""
                End If

                If strControlValue <> "" And strControlValue <> "0" Then
                    HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, CommonFunction.Dates.GetDate(CType(strControlValue, Date)), , m_strFormName, , , , blnIsDisabled, blnReadOnly, "", , blnIsMandatory, , strToBeInserted))
                Else
                    HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, , , m_strFormName, , , , blnIsDisabled, blnReadOnly, "", , blnIsMandatory, , strToBeInserted))
                End If

            Case Else
                HttpContext.Current.Response.Write("&nbsp;")

        End Select
        'Commented and added by Bharat T on 13th-Oct-2015
        'Dim arrtemp(30) As String
        Dim arrtemp(50) As String
        'End of Commented and added by Bharat T on 13th-Oct-2015
        arrValidationMessages.CopyTo(arrtemp, 0)

        'Generate the client side validation scripts for the control.		
        Call GenerateValidationScript(ArrCtlAttr, arrtemp)
        'HttpContext.Current.Response.Write(ArrCtlAttr(ATTR_CONTROL_NAME) + ArrCtlAttr(ATTR_READ_ONLY))

        ' If the control is disabled, then enable it before submitting.
        'If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "True" Then
        '    If InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME).ToString.Trim, "Keywords") <> 0 Then
        '        strEnableControlsScript = "var obj" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + "= GetObjectReference('frmTaskAssignment','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + "',1);" + vbCrLf
        '        For intCtr = 0 To 4
        '            strEnableControlsScript = strEnableControlsScript + "obj" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + "(" + intCtr.ToString + ").disabled = false;" + vbCrLf
        '        Next
        '    Else
        '        strEnableControlsScript = strEnableControlsScript + "obj" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + ".disabled = false;" + vbCrLf
        '    End If
        'End If

    End Sub 'Draw the control 
    Private Sub GenerateValidationScript(ByRef arrCtlAttr() As String, ByVal arrValidations() As String)
        '==================================================================================
        ' Procedure Name		:	GenerateValidationScript
        ' Parameters Passed		:	arrCtlAttr : This array contains all the attributes of the control to be drawn.
        '							arrValidationMessages : The array containing the validation messages.
        ' Returns				:	No Return Value
        ' Parameters Affected	:	arrCtlAttr [if the Not blank validation rule is set, then the Show As Mandatofy flag is set.]
        ' Purpose				:	To generate the client side validation script depending on the validation rules set for that control.
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	SandipL
        ' Created				:	20 Jan 2006
        ' Revisions				:	
        '==================================================================================

        Dim strValidation As String = ""
        Dim intCtr As Integer = 0
        Dim arrRules As String()
        Dim intValidationID As Integer
        Dim strCaption As String
        ' Get the validation rule IDs in an array.
        strValidation = ""

        arrRules = Split(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES).Trim, ",")
        strCaption = arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION)
        If InStr(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), "Keywords") <> 0 Then
            Exit Sub
        End If

        ' For each validation rule to be applied, generate the client side validation script.
        For intCtr = LBound(arrRules) To UBound(arrRules)
            If arrRules(intCtr) <> "" Then
                intValidationID = CType(arrRules(intCtr), Integer)
                'If IsNumeric(intValidationID) Then
                intValidationID = CInt(intValidationID)
                arrValidations(intValidationID) = Replace(arrValidations(intValidationID), "<ID>", strCaption)
                'End If
            End If

            Dim blnLoopcheck As Boolean = False
            Dim strControlName As String = arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
            Dim strMinValue As String = arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MIN_VALUE)
            Dim strMaxValue As String = arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_VALUE)

            Select Case intValidationID.ToString

                Case "1" ' Not Blank.														

                    strValidation = strValidation + "if(disallowBlank(obj" + arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + ",'" + CommonFunction.General.FormatString(arrValidations(1), False) + "',false)){" + vbCrLf
                    arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "True"
                    blnLoopcheck = True
                Case "2" ' Valid Date.				

                    If InStr(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION), "'") > 0 Then
                        strValidation = strValidation + "if(!isDate(obj" + strControlName + ",""" + arrValidations(2) + """,false){" + vbCrLf
                    Else
                        strValidation = strValidation + "if(!isDate(obj" + strControlName + ",'" + arrValidations(2) + "',false){" + vbCrLf
                    End If

                    strValidation = strValidation + "if(!isDate(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(2), False) + "',false){" + vbCrLf
                    If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
                        strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                    End If
                    strValidation = strValidation + "return;" + vbCrLf
                    strValidation = strValidation + "}}}" + vbCrLf

                Case "3" ' Numeric Data.
                    strValidation = strValidation + "if(disallowNonNumeric(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(3), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True
                Case "9" ' Only Alphabets.
                    strValidation = strValidation + "if(disallowNonAlphabets(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(9), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True
                Case "12" ' Max Length
                    'If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE).ToString.ToUpper = "APP_CONTROL_TYPE_TEXT_AREA" Then
                    If Trim(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) <> "" And Trim(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) <> "0" Then
                        strValidation = strValidation + "if(disallowMaxlengthViolation(obj" + strControlName + "," + arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(12), "<LENGTH>", arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)), False) + "',false)){" + vbCrLf
                        strValidation = strValidation + "	obj" + strControlName + ".value = Left(Trim(obj" + strControlName + ".value), " + arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) + ");" + vbCrLf
                        blnLoopcheck = True
                    End If

                    'End If

                Case "13" ' Positive Numeric Data.				
                    strValidation = strValidation + "if (disallowNegativeNumeric(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(13), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True
                Case "14" ' Check Duplication.
                    ' Not Processed !!

                Case "15" ' Restrict Special characters.
                    strValidation = strValidation + "if(disallowSpecialCharacters(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(15), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True

                Case "16" ' Minimum Value Check.
                    strValidation = strValidation + "if(disallowMinValueViolation(obj" + strControlName + ", " + strMinValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(16), "<VALUE>", strMinValue), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True

                Case "17" ' Maximum Value Check.
                    strValidation = strValidation + "if(disallowMaxValueViolation(obj" + strControlName + ", " + strMaxValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(17), "<VALUE>", strMaxValue), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True
                Case "18" ' Value Range.

                    strValidation = strValidation + "if(disallowValueRangeViolation(obj" + strControlName + ", " + strMinValue + ", " + strMaxValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(18), "<RANGE>", strMinValue + " - " + strMaxValue), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True

                Case Else
            End Select
            If blnLoopcheck = True Then

                If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
                    strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                End If
                strValidation = strValidation + "return false;" + vbCrLf
                strValidation = strValidation + "}" + vbCrLf
            End If
        Next

        ' if the control is editable, only then apply the validation rules.
        If Right(strValidation, 2) = ";;" Then
            strValidation = Left(strValidation, Len(strValidation) - 1)
        End If
        If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
            strClientSideScript = strClientSideScript + strValidation
        ElseIf UCase(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)) = "SUMMARY" Or UCase(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)) = "REPORTEDBY" Or UCase(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)) = "DESCRIPTION" Then
            strClientSideScript = strClientSideScript + strValidation
        End If

    End Sub
    Private Sub GetValidationRules()
        '==================================================================================
        ' Procedure Name		:	GetValidationRules
        ' Parameters Passed		:	To get all the validation messages in an array
        ' Returns				:	none
        ' Parameters Affected	:	none
        ' Purpose				:	
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	SandipL
        ' Created				:	20 Jan 2006
        ' Revisions				:	
        '==================================================================================		

        Dim drValidationRules As IDataReader

        ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

        ' Retrieve all the validation messages.
        '  drValidationRules = CommonFunction.Data.GetDataReader("SELECT * FROM tbl_UI_Validation ORDER BY ValidationID", MyBase.UseSQL)
        drValidationRules = CommonFunction.Data.GetDataReader("usp_SEL_tbl_UI_Validation ", MyBase.UseSQL)

        ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

        'Save all these validation messages in array
        Do While drValidationRules.Read
            arrValidationMessages(CType(drValidationRules("ValidationID"), Integer)) = drValidationRules("ValidationMessage").ToString.Trim
        Loop

        'Dispose data reader
        CommonFunction.Data.DisposeDataReader(drValidationRules)
    End Sub 'Get all validation rules and generate array
    Private Sub ClearAttributes(ByRef arrCtlAttr As String())
        '==================================================================================
        ' Procedure Name		:	IsValidField
        ' Parameters Passed		:	arrCtlAttr : This array has to be re-initialised for each control
        ' Returns				:	No return Value.
        ' Parameters Affected	:	arrCtlAttr :- The array gets reinitialised.
        ' Purpose				:	
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	SandipL
        ' Created				:	19 Jan 2006
        ' Revisions				:	
        '==================================================================================		

        Dim intCtr As Integer

        For intCtr = 0 To 14
            arrCtlAttr(intCtr) = ""
        Next

        arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False"

    End Sub 'Clear control Atributes
    Public Sub PlotCustomFields(Optional ByVal UserID As Integer = 0, Optional ByVal LoginType As String = "")
        '==================================================================================
        ' Procedure Name		:	PlotCustomFields
        ' Parameters Passed		:	To plot custom fields for Tasks
        ' Returns				:	none
        ' Parameters Affected	:	none
        ' Purpose				:	
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	SandipL
        ' Created				:	20 Jan 2006
        ' Revisions				:	
        '==================================================================================

        Dim strSQLQuery As String, intRow, intCol, intNextCellNumber As Integer
        Dim intCurrentCellRow, intCurrentCellCol, intRecordCellNumber, intRecordRow, intRecordCol, intCurrentCellNumber As Integer
        Dim intDestinationIndex, intSourceIndex As Integer
        Dim drLayout As IDataReader
        Dim drCustomAccess As IDataReader
        Dim strSQLForCustom As String
        Dim strCustomFieldIDs() As String
        Dim intCount As Integer
        Dim intCorporateRoleLevel As Integer
        'Declare variables needed for security
        m_lngRoleId = CType(HttpContext.Current.Session("intPostID"), Integer)

        If Not m_lngProjectId > 0 Then
            m_lngProjectId = CType(HttpContext.Current.Session("intProjectID"), Integer)
        Else
            '''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("select ISNULL([Level],0) from  tbl_PM_Role where RoleID = (select PostId from tbl_PM_Employee where EmployeeID=" & CType(Session("intUserID"), String) & ")", MyBase.UseSQL), Integer)
            intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Role_Level_EmployeeID " & CType(Session("intUserID"), String), MyBase.UseSQL), Integer)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
            If intCorporateRoleLevel <> 1 And intCorporateRoleLevel <> 2 And m_lngProjectId <> 0 Then
                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                'm_lngRoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select ISnull(Role,0) from tbl_PM_ProjectEmployeeRole where ProjectID=" & CType(m_lngProjectId, String) & " And EmployeeID=" & CType(Session("intUserID"), String), MyBase.UseSQL), "0"), Long)
                m_lngRoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_ProjectEmployeeRole_Role " & CType(m_lngProjectId, String) & "," & CType(Session("intUserID"), String), MyBase.UseSQL), "0"), Long)
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
            End If
        End If
        If Not m_lngRoleId > 0 Then
            m_lngRoleId = CType(HttpContext.Current.Session("intPostID"), Integer)
        End If


        m_lngUserId = CType(HttpContext.Current.Session("intUserID"), Integer)

        If UserID = 0 Then
            UserID = CType(HttpContext.Current.Session("intUserID"), Integer)
        End If
        If LoginType = "" Then
            LoginType = Session("LoginType").ToString()
        End If

        'Added By Amol Changle On: 22 Jul 2009
        'Purpose: For Entity "Help-Desk" ProjectID is considered to be 0.
        'Modified By Syamantak Chavan on 21 Sept 2011 For Custom Field addition in whizible 10.0
        If m_strEntityName.ToLower() = "help-desk" Then 'Or m_strEntityName.ToLower() = "sub projects" Or m_strEntityName.ToLower() = "projects" Or m_strEntityName.ToLower() = "resource master" Or m_strEntityName.ToLower() = "global project" Then 'Modified by NitinC on 14 April 2011 for WhizibleSEM 10.0
            m_lngProjectId = 0
        End If
        'End Addition

        m_strCustomFieldList = ""
        m_strTypeInaccessibleCustomFieldList = ""

        MyBase.InitializeResources("AppResources.PM_TaskAssignment", "AppResources")
        'Get Accesible CustomFieldIDs List
        strSQLForCustom = "Exec usp_sel_tbl_PM_RoleCustomFieldSecurity " + m_lngProjectId.ToString + "," + m_lngRoleId.ToString + "," + UserID.ToString
        If (m_strEntityName <> "" Or Not m_strEntityName Is Nothing) Then
            strSQLForCustom = strSQLForCustom + ",'" + m_strEntityName + "'"
        End If

        'Added By Amol Changle On: 19 Aug 2009
        'Purpose: To handle Login Type specific issues
        strSQLForCustom += ",'" + LoginType + "'"
        'End Addition

        drCustomAccess = CommonFunction.Data.GetDataReader(strSQLForCustom, MyBase.UseSQL)
        While drCustomAccess.Read
            ReDim Preserve strCustomFieldIDs(intCount)
            strCustomFieldIDs(intCount) = CType(CommonFunction.General.CheckIsNothing(drCustomAccess("CustomFieldID")), String)
            intCount += 1
        End While
        CommonFunction.Data.DisposeDataReader(drCustomAccess)


        ' Get the layout ID for the person who has currently logged in, if the Layout is role-specific.
        'strSQLQuery = "SELECT 'MaxRows' = ISNull(MAX(RowNumber),0), 'MaxCols' = IsNull(MAX(ColumnNumber),0) FROM tbl_PM_CustomFields_Master WHERE ProjectID = " + m_lngProjectId.ToString + " AND Active = 1"

        If m_strCurrentType Is Nothing OrElse m_strCurrentType = "" Then
            m_strCurrentType = "NULL"
        End If

        strSQLQuery = "usp_Sel_tbl_PM_CustomFields_Master_MaxRows " + m_lngProjectId.ToString + "," + m_strCurrentType

        If (m_strEntityName <> "" Or Not m_strEntityName Is Nothing) Then
            'strSQLQuery = strSQLQuery + " And EntityName = '" & m_strEntityName & "'"
            strSQLQuery = strSQLQuery + " ,'" & m_strEntityName & "'"
        Else
            'strSQLQuery = strSQLQuery + " And EntityName = 'Task'"
            strSQLQuery = strSQLQuery + ",'Task'"
        End If
        strSQLQuery = strSQLQuery + ",1," + UserID.ToString()


        'Added By Amol Changle On: 19 Aug 2009
        'Purpose: To handle Login Type specific issues
        strSQLQuery += ",'" + LoginType + "'"
        'End Addition

        'usp_Sel_tbl_PM_CustomFields_Master_MaxRows

        drLayout = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If drLayout.Read Then
            m_intMaxRows = CType(drLayout("MaxRows"), Integer)
            m_intMaxCols = CType(drLayout("MaxCols"), Integer)
        End If
        CommonFunction.Data.DisposeDataReader(drLayout)

        'Start Plotting of Custom Fields
        'Modified by ShraddhaM on Date 21 June,2006 for WhizibleSEM Issue ID.4168
        HttpContext.Current.Response.Write("<TABLE width=99.9% cellSpacing=0 class=clsTable >")
        strSQLQuery = "usp_Sel_tbl_PM_CustomFields_Master " + m_lngProjectId.ToString + ", NULL, 1"


        If IsNothing(m_strCurrentType) = True Then m_strCurrentType = ""

        If m_strCurrentType.Trim <> "" Then strSQLQuery = strSQLQuery + ",'" + m_strCurrentType + "'"
        If m_strEntityName.Trim <> "" Then strSQLQuery = strSQLQuery + ",'" + m_strEntityName + "'"

        'Added by ShraddhaM
        strSQLQuery = strSQLQuery + "," + UserID.ToString()
        'Ended by ShraddhaM

        'Added By Amol Changle On: 19 Aug 2009
        'Purpose: To handle Login Type specific issues
        strSQLQuery += ",'" + LoginType + "'"
        'End Addition


        drLayout = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        Call GetValidationRules()

        If drLayout.Read Then
            For intRow = 1 To m_intMaxRows
                'declarevariables = declarevariables + "var obj" + drLayout("DatabaseFieldName").ToString.Trim + "= GetObjectReference('" & m_strFormName & "','" + drLayout("DatabaseFieldName").ToString.Trim + "');" + vbCrLf

                'Added By Amol Changle On: 22 Jul 2009
                'Purpose: Not to render blank rows
                If CommonFunctions.Data.CheckIsDBNull(drLayout("RowNumber")) = intRow.ToString() Then
                    'End Addition
                    HttpContext.Current.Response.Write("<TR class=clsTREven >")
                    For intCol = 1 To m_intMaxCols
                        intCurrentCellNumber = (intRow * m_intMaxCols) + intCol
                        intNextCellNumber = (CType(drLayout("RowNumber"), Integer) * m_intMaxCols) + CType(drLayout("ColumnNumber"), Integer)

                        If intCurrentCellNumber < intNextCellNumber Then
                            HttpContext.Current.Response.Write("<td valign=top align=right colspan=2 >&nbsp;</td>")
                        ElseIf intCurrentCellNumber >= intNextCellNumber Then
                            declarevariables = declarevariables + "var obj" + drLayout("DatabaseFieldName").ToString.Trim + "= GetObjectReference('" & m_strFormName & "','" + drLayout("DatabaseFieldName").ToString.Trim + "');" + vbCrLf
                            'HttpContext.Current.Response.Write("<td valign=top align=right style='width:10%'>")
                            HttpContext.Current.Response.Write("<td valign=top align=right width='5%'>")
                            'get value form form
                            'If m_blnShowFormContents = True Then


                            If Not HttpContext.Current.Request.Form(drLayout("DatabaseFieldName").ToString) Is Nothing Then
                                strFieldValue = HttpContext.Current.Request.Form(drLayout("DatabaseFieldName").ToString)

                                'Modified by NitinVS on 2 May 2007 for WhizibleSEM SP 8 Regression Fixes 
                                ' Added checkisdbNull to get strDummyFieldValue and strFieldValue
                                'Save Database value also

                                If m_strPrimaryKeyID > 0 Then
                                    'If Not rsIssueDetails.EOF Then
                                    Dim strSQL As String = " Select " & drLayout("DatabaseFieldName").ToString & " From " & m_strPrimaryTable & " where " & m_strPrimaryKey & " = " & m_strPrimaryKeyID
                                    strDummyFieldValue = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "").ToString
                                    'End If
                                Else
                                    strDummyFieldValue = ""
                                End If

                            Else
                                If m_strPrimaryKeyID > 0 Then
                                    'If Not rsIssueDetails.EOF Then
                                    Dim strSQL As String = " Select " & drLayout("DatabaseFieldName").ToString & " From " & m_strPrimaryTable & " where " & m_strPrimaryKey & " = " & m_strPrimaryKeyID
                                    strFieldValue = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "").ToString
                                    'End If
                                Else
                                    strFieldValue = ""
                                End If
                                strDummyFieldValue = strFieldValue
                            End If

                            'End Modification by NitinVS on 2 May 2007 for WhizibleSEM SP 8 Regression Fixes  

                            ' Retrieve the attributes of the control to be displayed.
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) = drLayout("DatabaseFieldName").ToString
                            'Modified By VarunA on 27-Sep-2008
                            'Purpose : Security Issue
                            'ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION) = CommonFunction.Data.CheckIsDBNull(drLayout("UserGivenCaption"), "").ToString
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION) = CommonFunction.Data.CheckIsDBNull(Server.HtmlEncode(drLayout("UserGivenCaption")), "").ToString
                            'End By VarunA on 27-Sep-2008
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) = strFieldValue
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_HEIGHT) = CommonFunction.Data.CheckIsDBNull(drLayout("ControlHeight"), "0").ToString
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH) = CommonFunction.Data.CheckIsDBNull(drLayout("ControlWidth"), "0").ToString
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) = CommonFunction.Data.CheckIsDBNull(drLayout("DefaultValue"), "").ToString
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = CommonFunction.Data.CheckIsDBNull(drLayout("MaxLength"), "0").ToString
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = CommonFunction.Data.CheckIsDBNull(drLayout("ValidationRules"), "").ToString
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MIN_VALUE) = CommonFunction.Data.CheckIsDBNull(drLayout("MinValue"), "0").ToString
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_VALUE) = CommonFunction.Data.CheckIsDBNull(drLayout("MaxValue"), "0").ToString
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False"
                            If (drLayout("DataType").ToString = "1") Then
                                If InStr(1, "," + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), ",3,") = 0 Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "3,"
                                End If
                            End If

                            ' Set the control type depending on the name of the custom field to be displayed.
                            ' For Text Area custom fields...

                            If InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), "CustomFieldTextArea") > 0 Then

                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_AREA.ToString

                                ' Set the maxlengths of the textareas.
                                'If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) = "CustomFieldTextArea3" Then

                                If Not IsNumeric(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) Or ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "0" Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "3800"
                                ElseIf CInt(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) > 3800 Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "3800"
                                End If

                                If InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), "12,") = 0 Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "12,"
                                End If
                                'End If

                                intDestinationIndex = 27 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldTextArea") + 1, 1))
                                arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
                                arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)

                                ' For Text Box custom fields...
                            ElseIf InStr(drLayout("DatabaseFieldName").ToString, "CustomFieldText", CompareMethod.Text) > 0 Then

                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString

                                ' Set the maxlengths of the textboxes.
                                If Not IsNumeric(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) Or ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "0" Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
                                ElseIf CInt(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) > 100 Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
                                End If

                                If InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), "12,") = 0 Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "12,"
                                End If

                                ' If the date validation rule is applied on the text box control, then the control is to be transformed to a date control.
                                If InStr(1, "," + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), ",2,") <> 0 Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH) = "80"
                                End If

                                intDestinationIndex = 0 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldText") + 1, 2))
                                arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
                                arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)

                                ' For Combo Box custom fields...									
                            ElseIf InStr(drLayout("DatabaseFieldName").ToString.Trim, "CustomFieldCombo", CompareMethod.Text) > 0 Then

                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_PM_CustomFields_Details '" + CommonFunction.General.BuildQueryString(drLayout("DatabaseFieldName").ToString.Trim) + "', " + m_lngProjectId.ToString
                                ''Added By Amol Changle On: 21 Jul 2009
                                ''Purpose: To select field details Entity Specific
                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SQL_QUERY) += ",1,'" + m_strEntityName + "'"
                                ''End Addition

                                ' Set the maxlengths of the combobox.
                                'If Not IsNumeric(ArrCtlAttr(ATTR_MAX_LENGTH)) Then
                                'ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
                                'ElseIf CInt(ArrCtlAttr(ATTR_MAX_LENGTH)) > 100 Then
                                '    ArrCtlAttr(ATTR_MAX_LENGTH) = 100
                                'End If
                                'If InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), "12,") = 0 Then
                                '    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "12,"
                                'End If

                                intDestinationIndex = 10 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldCombo") + 1, 2))
                                arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
                                arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)

                                ' For Date Control custom fields...								
                            ElseIf InStr(drLayout("DatabaseFieldName").ToString.Trim, "CustomFieldDate") > 0 Then

                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString
                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH) = "80"

                                intDestinationIndex = 20 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldDate") + 1, 1))
                                arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
                                arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)



                            End If

                            ' If the not blank validation rule has been set for a control, then, the show as mandatory flag must be shown.
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "False"
                            If InStr("," + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES).ToString.Trim, ",1,") <> 0 Then
                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "True"
                            End If

                            ' If the default value is to be retrieved from one of the common fields or custom fields, then...
                            If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) <> "" And CommonFunction.Data.CheckIsDBNull(drLayout("DefaultType"), "").ToString.Trim = "F" Then

                                ' If the default value is to be retrieved from one of the CUSTOM fields, then the OnChange Event must be written.
                                If InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE).ToString, "CustomField") <> 0 And (ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) <> ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)) Then

                                    ' Get the index of the custom fields.
                                    If InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE).ToString, "CustomFieldTextArea") <> 0 Then
                                        ' Text Area Range	: 26 - 28.
                                        intSourceIndex = 27 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), Len("CustomFieldTextArea") + 1, 1))
                                    ElseIf InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE).ToString, "CustomFieldText") <> 0 Then
                                        ' Text box Range	: 1 - 10.
                                        intSourceIndex = 0 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), Len("CustomFieldText") + 1, 2))
                                    ElseIf InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), "CustomFieldCombo") <> 0 Then
                                        ' Combo box Range	: 11 - 20.
                                        intSourceIndex = 10 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), Len("CustomFieldCombo") + 1, 2))
                                    ElseIf InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), "CustomFieldDate") <> 0 Then
                                        ' Date control Range: 21 - 25.
                                        intSourceIndex = 20 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), Len("CustomFieldDate") + 1, 1))
                                    End If

                                    strEventHandlers = ""
                                    strEventHandlers = strEventHandlers + "		var objSource = GetObjectReference('" & m_strFormName & "','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) + "');" + vbCrLf
                                    strEventHandlers = strEventHandlers + "		var objDestination = GetObjectReference('" & m_strFormName & "','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + "');" + vbCrLf
                                    strEventHandlers = strEventHandlers + "		If (Trim(objDestination.value) == """")" + vbCrLf + "{"

                                    If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) <> CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString Then
                                        strEventHandlers = strEventHandlers + "		objDestination.value = objSource.value;" + vbCrLf
                                    Else
                                        strEventHandlers = strEventHandlers + "		objDestination.value = funcGetDate(objSource.value);" + vbCrLf
                                    End If

                                    strEventHandlers = strEventHandlers + "}" + vbCrLf

                                    arrEventHandlers(intSourceIndex, 2) = arrEventHandlers(intSourceIndex, 2) + strEventHandlers

                                End If

                                strDefaultScript = strDefaultScript + "var objSource = GetObjectReference('" & m_strFormName & "','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) + "');" + vbCrLf
                                strDefaultScript = strDefaultScript + "var objDestination = GetObjectReference('" & m_strFormName & "','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + "');" + vbCrLf
                                strDefaultScript = strDefaultScript + "if ((objSource!=null)&&(objDestination!=null)){" + vbCrLf
                                strDefaultScript = strDefaultScript + "if(Trim(objDestination.value) == """")" + vbCrLf

                                'If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) <> CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString Then
                                strDefaultScript = strDefaultScript + "	objDestination.value = objSource.value;" + vbCrLf
                                'Else
                                '    strDefaultScript = strDefaultScript + "	objDestination.value = funcGetDate(objSource.value);" + vbCrLf
                                'End If

                                strDefaultScript = strDefaultScript + "}" + vbCrLf
                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) = ""

                                ' For Numweric custom fields...
                            ElseIf InStr(drLayout("DatabaseFieldName").ToString, "CustomFieldNumeric", CompareMethod.Text) > 0 Then

                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString

                                ' Set the maxlengths of the textboxes.
                                If Not IsNumeric(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) Or ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "0" Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
                                ElseIf CInt(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) > 100 Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
                                End If

                                If InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), "3,") = 0 Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "12,"
                                End If


                                'intDestinationIndex = 0 + CInt(Mid(ArrCtlAttr(Customer.CCommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldText") + 1, 2))
                                intDestinationIndex = 20 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldNumeric") + 1, 2))
                                arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
                                arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)


                            End If

                            HttpContext.Current.Response.Write(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION))

                            HttpContext.Current.Response.Write("</td>")
                            HttpContext.Current.Response.Write("<td valign=top style='width:15%'>")


                            'HttpContext.Current.Response.Write("<td valign=top bgcolor=green >")
                            Dim blnShowControl As Boolean = False
                            Dim intCounter As Integer

                            intCounter = 0
                            'If length of array is greater than 0 that means security is explicitly set
                            'In that case check if it is accessible ,if yes then show the control, 
                            'otherwise show it as not applicable
                            If intCount > 0 Then

                                While intCounter < intCount
                                    'Check if the current Custom Field ID is in the array
                                    If strCustomFieldIDs(intCounter).ToLower.Trim = _
                                                CType(CommonFunction.General.CheckIsNothing(drLayout("UniqueId")), String).ToLower.Trim Then
                                        blnShowControl = True
                                        Exit While
                                    End If

                                    intCounter = intCounter + 1

                                End While

                            Else
                            End If

                            If drLayout("IsCustomFieldAssigned").ToString = "1" And blnShowControl = True Then
                                m_strCustomFieldList = m_strCustomFieldList + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + ","
                                Call DrawControl(ArrCtlAttr)
                                Call ClearAttributes(ArrCtlAttr)
                            Else

                                If IsAddNewMode = True Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE)
                                End If

                                'The Custom Field is not defied for the Current Type
                                HttpContext.Current.Response.Write("( " + MyBase.GetResourceString("NbyA") + " )")

                                'Do not save value if the Custom Field is not applicable
                                If drLayout("IsCustomFieldAssigned").ToString <> "1" And blnShowControl = True Then
                                    m_strTypeInaccessibleCustomFieldList = m_strTypeInaccessibleCustomFieldList + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + ","

                                    '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
                                    CommonFunction.HTMLControls.DrawTextBox("Dummy" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), , , , strDummyFieldValue, IsHidden:=True, EnableHTMLEncode:=True)
                                Else
                                    CommonFunction.HTMLControls.DrawTextBox("Dummy" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), , , , , IsHidden:=True, EnableHTMLEncode:=True)
                                End If
                                CommonFunction.HTMLControls.DrawTextBox(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), , , , ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE), IsHidden:=True, EnableHTMLEncode:=True)
                                '''End of Modification by Dhanashri S on 7 Oct 2015 

                                ' reset value of inactive custom fields before saving.
                                strClientSideScript = strClientSideScript + vbCrLf + "obj" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + ".value = """";" + vbCrLf
                            End If
                            HttpContext.Current.Response.Write("</TD>")
                            If Not drLayout.Read() Then
                                Dim i As Integer
                                For i = intCol To m_intMaxCols - 1
                                    HttpContext.Current.Response.Write("<td valign=top align=right colspan=2>&nbsp;</td>")
                                Next
                                Exit For
                            End If
                        Else
                            HttpContext.Current.Response.Write("<td valign=top align=right colspan=2 style='width:20%'>&nbsp;</td>")
                            'HttpContext.Current.Response.Write("<td valign=top align=right colspan=2 >&nbsp;</td>")
                            If Not drLayout.Read() Then
                                Dim i As Integer
                                For i = intCol To m_intMaxCols - 1
                                    HttpContext.Current.Response.Write("<td valign=top align=right colspan=2>&nbsp;</td>")
                                Next
                                Exit For
                            End If
                        End If
                    Next
                    HttpContext.Current.Response.Write("</TR>")
                End If
            Next
            If m_strCustomFieldList <> "" Then
                m_strCustomFieldList = m_strCustomFieldList.Substring(0, m_strCustomFieldList.Length - 1)
            End If
            If m_strTypeInaccessibleCustomFieldList <> "" Then
                m_strTypeInaccessibleCustomFieldList = m_strTypeInaccessibleCustomFieldList.Substring(0, m_strTypeInaccessibleCustomFieldList.Length - 1)
            End If
            HttpContext.Current.Response.Write("<SCRIPT language=javaScript>" + vbCrLf)
            CommonFunction.Data.DisposeDataReader(drLayout)

            Dim intCtr As Integer
            ' Loop through the array to check if any event handlers need to be printed.
            For intCtr = LBound(arrEventHandlers) To UBound(arrEventHandlers)

                ' If the control name is present and the event handler is present, then print it.
                ' arrEventHandlers(intCtr, 0) -> Custom Field Name.
                ' arrEventHandlers(intCtr, 1) -> Custom Field Control Type.
                ' arrEventHandlers(intCtr, 2) -> Custom Field Event Handler script.
                If arrEventHandlers(intCtr, 0) <> "" And arrEventHandlers(intCtr, 2) <> "" Then
                    If arrEventHandlers(intCtr, 1) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString Then
                        HttpContext.Current.Response.Write("	function " + arrEventHandlers(intCtr, 0) + "_OnPropertyChange(){" + vbCrLf)
                    Else
                        HttpContext.Current.Response.Write("	function " + arrEventHandlers(intCtr, 0) + "_OnChange(){" + vbCrLf)
                    End If
                    HttpContext.Current.Response.Write(arrEventHandlers(intCtr, 2))
                    HttpContext.Current.Response.Write("}" + vbCrLf)
                End If
            Next
            HttpContext.Current.Response.Write("</SCRIPT>" + vbCrLf)
        Else
            HttpContext.Current.Response.Write("<tr class=clsTREven>")
            HttpContext.Current.Response.Write("<td align=center valign=center>")
            HttpContext.Current.Response.Write("<b>" + MyBase.GetResourceString("NOCUSTOMFIELDS") + "</b>")

            HttpContext.Current.Response.Write("</td>")
            HttpContext.Current.Response.Write("</tr>")
        End If
        CommonFunction.Data.DisposeDataReader(drLayout)
        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        CommonFunctions.HTMLControls.DrawTextBox("CustomFieldList", "CustomFieldList", , , , m_strCustomFieldList, IsHidden:=True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("TypeInaccessibleCustomFieldList", "TypeInaccessibleCustomFieldList", , , , m_strTypeInaccessibleCustomFieldList, IsHidden:=True, EnableHTMLEncode:=True)
        '''End of Modification by Dhanashri S on 7 Oct 2015 
        HttpContext.Current.Response.Write("</TABLE>")

    End Sub 'Plot all custom fields for Issue


    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub



End Class
'End addition by SandipL on 24 Jan 2006