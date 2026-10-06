Imports System.Text
Imports Whizible
Public Class QuickTask
    Inherits WebPages.Template.WhizTemplate
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_strPageTitle As String = ""
    Private sbHTML As New System.Text.StringBuilder
    Private m_objGlobal As WebPages.Template.IGlobal
    Protected strClass As String = "clsTREven"
    'Commented And Added By Usha Pandit On 24.08.2020 For gettingCreateTasks_OnClick billable check access
    'Private m_blnBillable As Boolean = False
    Protected m_blnBillable As Boolean = False
    'End Of Added By Usha Pandit On 24.08.2020 For getting billable check access
    Private m_strTaskName As String = ""
    Private m_strTaskNotes As String = ""
    Protected m_lngProjectId As Long = 0
    Protected m_strEmployeeId As String = ""
    Protected m_strAction As String
    Protected CustomFieldsApplicable As String = ""
    Protected FromTimesheet As String
    Protected strProjectID As String
    Protected TotalRowCount As Integer

    Protected m_PhaseMandatory, m_MilestoneMandatory, m_ModuleMandatory, m_SubProjectMandatory, m_ChangeRequestMandatory, m_FeatureMandatory, m_EstimationTypeMandatory As String

    Protected m_arrControlDetails(7, 1) As Boolean
    Protected m_strHolidays As String = ""
    'Project Settings Related variables
    Private m_lngProjectLocationID As Long = 0
    Protected m_strProjectStartDate As String = ""
    Protected m_strProjectEndDate As String = ""
    Private m_blnProjectActive As Boolean = False
    'Private m_blnAllowResourceAllocation As Boolean = False

    Protected m_HaveSubTaskTypes As Boolean
    Protected m_ApplyEffortDistribution As Boolean

    Private m_blnIsTaskComplete As Boolean = False
    Protected m_bitResourceValidation As Int16 = 1
    Protected m_strProjectSetting As String = ""

    'Task Details
    Protected m_strTaskIDList As String = ""
    Protected m_lngReviewActionId As Long = 0
    Protected m_lngReviewStatisticsId As Long = 0
    Protected m_lngMitigationPlanId As Long = 0
    Protected m_lngTrainingResourceId As Long = 0
    Protected m_dblHoursPerDay As Double = 0
    Protected m_lngWeekDays As Long = 0

    Protected m_lngTaskId As Long = 0
    Protected m_intFlag As String = "0"
    Protected m_strUserStory As String = ""
    Private m_strRelease As String = ""
    Private m_strIteration As String = ""
    Protected m_strUserStoryID As String

    Protected strCustomFieldScripts As String
    Protected m_rowID As String

    Private arrValidationMessages(50) As String

    Protected strSQLQuery As String
    Protected drCustomField As IDataReader
    Protected strClientSideScript As String 'Validation script for custom fields
    Protected declarevariables As String = "" 'Custom Fields objects Declaration script
    Protected m_strCustomFieldList As String = ""
    Private m_strTypeInaccessibleCustomFieldList As String
    Protected m_strTaskTypeID As String
    Public m_lngRoleId As Long
    Protected m_strBaselineMessage As String = "" 'Added By Dipali V On 8th April 2020 For Get alert MSG
    Protected m_blnIsProjectCreationWorkflowReqd As String = "" 'Added By Dipali V On 8th April 2020 For check WF applied or not
    Protected m_DefualtTaskType As String = "" 'Added By Dipali V On 8th April 2020 For Task Type get default
    Private m_strUserName As String = ""

    ''Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change
    Dim m_intWorkhrs As String
    Dim m_Workhrs As String
    Protected m_RestrictByMinHours As String

    ''End of Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change

#Region " Constants Used in the Class "
    Protected Const PROJECT_SETTING_NORMAL As String = "Normal"
    Protected Const PROJECT_SETTING_ACTIVITY As String = "Activity"
    Protected Const PROJECT_SETTING_EFFORT_DISTRIBUTION As String = "Effort_Distribution"
#End Region

    Protected Enum ControlIndex
        CTRL_INDEX_TASKTYPE
        CTRL_INDEX_PHASE
        CTRL_INDEX_MODULE
        CTRL_INDEX_SUBPROJECT
        CTRL_INDEX_MILESTONE
        CTRL_INDEX_CHANGEREQUEST
        CTRL_INDEX_FEATURE
        CTRL_INDEX_ESTIMATIONTYPE
    End Enum
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        Dim drWork As IDataReader
        Dim strQuery As String = ""
        Dim strTemp As String = ""
        Dim strsql As String = ""
        Dim dr As IDataReader

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()

        m_strUserName = m_objGlobal.UserName
        'Added By Dipali V On 8th April 2020 For If Project WF not apply then alert should come
        m_lngProjectId = CType(Session("intProjectID"), Long)
        m_blnIsProjectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_PM_GetProjectCreationWorkflowReqd_Status " & CommonFunction.General.CheckIsNothing(m_lngProjectId, "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)
        If m_blnIsProjectCreationWorkflowReqd = True Then
            'If m_blnIsProjectCreationWorkflowReqd = False Then
            strQuery = "Exec usp_Sel_tbl_CNF_Project_Status " + m_lngProjectId.ToString()
            drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                If drWork.Read() Then
                    m_strBaselineMessage = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drWork("BaseLineMessage"), ""), ""), String)
                    'End of addition 
                End If
            End If
        End If
        'End of Added by Dipali V On 8th April 2020 for if Project WF not apply then alert should come
        'Added By Dipali V On 8th April 2020 For Task Type get default
        'm_DefualtTaskType = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_tbl_PM_Project_TaskTypes_Names " & CommonFunction.General.CheckIsNothing(m_lngProjectId, "0").ToString() & ",1", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), String)), ""), ""), String)
        strQuery = "Exec usp_Sel_tbl_PM_Project_TaskTypes_Names " + m_lngProjectId.ToString() + ",1"
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                m_DefualtTaskType = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drWork("TaskType"), ""), ""), String)
                'End of addition 
            End If
        End If
        'End of  Added By Dipali V On 8th April 2020 For Task Type get default

        m_strPageTitle = MyBase.GetResourceString("ASSIGNED_TASKS")
        ' m_lngProjectId = CType(Request.QueryString("ProjectID"), Long)
        m_lngProjectId = CType(Session("intProjectID"), Long)
        FromTimesheet = Request.QueryString("FromTimesheet")

        m_strAction = CommonFunction.General.CheckIsNothing(Request.QueryString("Action"), "")
        m_strTaskTypeID = CommonFunction.General.CheckIsNothing(Request.QueryString("TaskTypeID"), "")

        If m_strAction = "DrawCustomField" Then
            DrawCustomFields(Request.QueryString("RowID"))
        ElseIf m_strAction = "GetAccessToCustomField" Then
            'Dim drCustomField1 As IDataReader
            'Dim drRoleAccess As IDataReader
            Dim intCorporateRoleLevel As Integer
            Dim strFieldAccess As String = ""
            Dim dsRoleAccess As System.Data.DataSet
            Dim dsCustomField As System.Data.DataSet

            Dim Flag As Boolean = False

            If Not m_lngProjectId > 0 Then
                m_lngProjectId = CType(HttpContext.Current.Session("intProjectID"), Integer)
            Else
                ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                ''intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("Select ISNULL([Level], 0) from  tbl_PM_Role where RoleID = (Select PostId from tbl_PM_Employee where EmployeeID=" & CType(Session("intUserID"), String) & ")", MyBase.UseSQL), Integer)
                intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("usp_sel_Level_tbl_PM_Role " & CType(Session("intUserID"), String), MyBase.UseSQL), Integer)
                ''End of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                If intCorporateRoleLevel <> 1 And intCorporateRoleLevel <> 2 And m_lngProjectId <> 0 Then
                    ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                    '' m_lngRoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select ISnull(Role, 0) from tbl_PM_ProjectEmployeeRole where ProjectID=" & CType(m_lngProjectId, String) & " And EmployeeID=" & CType(Session("intUserID"), String), MyBase.UseSQL), "0"), Long)
                    m_lngRoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_Role_tbl_PM_ProjectEmployeeRole " & CType(m_lngProjectId, String) & "," & CType(Session("intUserID"), String), MyBase.UseSQL), "0"), Long)
                    ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                End If
            End If
            If Not m_lngRoleId > 0 Then
                m_lngRoleId = CType(HttpContext.Current.Session("intPostID"), Integer)
            End If

            If (m_strTaskTypeID <> "" And Not m_strTaskTypeID Is Nothing) Then

                '' START : ParagD On 23-Aug-2006
                ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                '' Dim strSQLQuery As String = "Select TaskTypeID from tbl_PM_TaskTypes Where TaskType='" & CommonFunctions.General.BuildQueryString(m_strTaskTypeID) & "' "
                Dim strSQLQuery As String = "usp_sel_TaskTypeID_tbl_PM_TaskTypes '" & CommonFunctions.General.BuildQueryString(m_strTaskTypeID) & "'"
                ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                '' END : ParagD On 23-Aug-2006

                m_strTaskTypeID = CType(CommonFunctions.Data.GetDataScalar(strSQLQuery, True), String)
            End If

            strSQLQuery = "usp_sel_tbl_PM_RoleCustomFieldSecurity " & CType(HttpContext.Current.Session("intProjectID"), Long) & "," & m_lngRoleId & "," & CType(HttpContext.Current.Session("intUserID"), Long) & ",'Task','E'"
            'drRoleAccess = CommonFunction.Data.GetDataReader(strSQLQuery, True)
            dsRoleAccess = CommonFunction.Data.GetDataSet(strSQLQuery, "CustomRoleAccess", , , MyBase.UseSQL)

            strSQLQuery = "usp_Sel_tbl_PM_CustomFields_Master " & HttpContext.Current.Session("intProjectID") & ",NULL,1,'" & m_strTaskTypeID & "','Task'," & CType(HttpContext.Current.Session("intUserID"), Integer) & ",'E'"
            'drCustomField1 = CommonFunction.Data.GetDataReader(strSQLQuery, True)
            dsCustomField = CommonFunction.Data.GetDataSet(strSQLQuery, "CustomField", , , MyBase.UseSQL)

            For Each drCustomField1 As DataRow In dsCustomField.Tables(0).Rows
                Flag = False

                For Each drRoleAccess As DataRow In dsRoleAccess.Tables(0).Rows
                    If CommonFunction.Data.CheckIsDBNull(drCustomField1("DatabaseFieldName"), "") = CommonFunction.Data.CheckIsDBNull(drRoleAccess("DatabaseFieldName"), "") Then
                        strFieldAccess += CommonFunction.Data.CheckIsDBNull(drCustomField1("DatabaseFieldName"), "") & "#" & CommonFunction.Data.CheckIsDBNull(drCustomField1("IsCustomFieldAssigned"), "0") & "#1" & ","
                        Flag = True
                    End If
                Next
                If Flag = False Then
                    strFieldAccess += CommonFunction.Data.CheckIsDBNull(drCustomField1("DatabaseFieldName"), "") & "#" & CommonFunction.Data.CheckIsDBNull(drCustomField1("IsCustomFieldAssigned"), "0") & "#0" & ","
                End If
            Next
            If strFieldAccess <> "" Then
                strFieldAccess = strFieldAccess.Substring(0, strFieldAccess.Length - 1)
            End If
            Response.Clear()
            Response.ContentType = "text/html"
            Response.Write(strFieldAccess)
            Response.End()
        Else
            If CommonFunction.General.CheckIsNothing(Request.QueryString("UserStoryID"), "") <> "" Then
                m_strUserStoryID = Request.QueryString("UserStoryID")
            Else
                m_strUserStoryID = "NULL"
            End If

            InitiateControlArray()

            'Task Details
            Call GetProjectSettingsDetails()

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

            strQuery = "Exec usp_Get_ProjectLocationWorkingHours_Days " & m_lngProjectId.ToString()
            drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                If drWork.Read() Then
                    m_dblHoursPerDay = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("WorkingHours"), "0"), Double)
                    m_lngWeekDays = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("WorkingDays"), "0"), Long)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drWork)

            'Check wheather agile project or not
            m_intFlag = CType(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + m_lngProjectId.ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)
        End If
        ''Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change

        Dim drCompany As IDataReader
        drCompany = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation", True)
        If drCompany.Read() Then
            m_RestrictByMinHours = CommonFunction.Data.CheckIsDBNull(drCompany("RestrictByMinHours"), "0")
        End If
        ''End Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change
    End Sub
    Protected Sub InitiateControlArray()
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

                m_PhaseMandatory = CommonFunctions.Data.CheckIsDBNull(drWork.Item("PhaseMandatoryInAT"), 0)
                m_ModuleMandatory = CommonFunctions.Data.CheckIsDBNull(drWork.Item("ModuleMandatoryInAT"), 0)
                m_MilestoneMandatory = CommonFunctions.Data.CheckIsDBNull(drWork.Item("MilestoneMandatoryInAT"), 0)
                m_SubProjectMandatory = CommonFunctions.Data.CheckIsDBNull(drWork.Item("SubProjectMandatoryInAT"), 0)
                m_ChangeRequestMandatory = CommonFunctions.Data.CheckIsDBNull(drWork.Item("ChangeRequestMandatoryInAT"), 0)
                m_FeatureMandatory = CommonFunctions.Data.CheckIsDBNull(drWork.Item("FeatureMandatoryInAT"), 0)
                m_EstimationTypeMandatory = CommonFunctions.Data.CheckIsDBNull(drWork.Item("EstimationTypeMandatoryInAT"), 0)
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
        ' Author                : PrasannaP
        ' Created               : Feb 18, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
    Private Sub InitPageMenu()

        'Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        'Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        'Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        'Dim strMenu As String
        'arrMenuCaptionsList.Add("Create Tasks")
        'arrMenuToolTipsList.Add("Create Tasks")
        'arrClientSideFunctionList.Add("CreateTasks_OnClick()")

        'strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)
        ''Setting the objects to nothing
        'arrMenuCaptionsList = Nothing
        'arrClientSideFunctionList = Nothing
        'arrMenuToolTipsList = Nothing
        'Commented And Added By Usha Pandit On 13.05.2020 For not allowing to create tasks for closed projects
        'CommonFunctions.General.WriteHTML("<table width=100% class='clsTable topInnerMenu' cellspacing='0' cellpadding='0'><tbody><tr class='clsTRMenu'><td></td><td align='Right'><ul class='responsive_clsTRMenu' style='margin-top: 0%; display: block;'><li style='float: left;'><a id='CreateTaskID' title='Create Tasks' class='Menu' onmouseover=this.style.backgroundColor='#FFD695' onmouseout=this.style.backgroundColor='' onclick='Javascript:CreateTasks_OnClick()'>Create Tasks</a></li></ul></td><div class='menu_arrow_img' style='display: none;'><img title='Expand' src='../General/responsive/images/downarrow.png'></div><ul class='additional_clsTRMenu' style='display: none; position: absolute; z-index: 999;'></ul></tr></tbody></table>")        
		If m_blnProjectActive = True Then
            CommonFunctions.General.WriteHTML("<table width=100% class='clsTable topInnerMenu' cellspacing='0' cellpadding='0'><tbody><tr class='clsTRMenu'><td></td><td align='Right'><ul class='responsive_clsTRMenu' style='margin-top: 0%; display: block;'><li style='float: left;'><a id='CreateTaskID' title='Create Tasks' class='Menu' onmouseover=this.style.backgroundColor='#FFD695' onmouseout=this.style.backgroundColor='' onclick='Javascript:CreateTasks_OnClick()'>Create Tasks</a></li></ul></td><div class='menu_arrow_img' style='display: none;'><img title='Expand' src='../General/responsive/images/downarrow.png'></div><ul class='additional_clsTRMenu' style='display: none; position: absolute; z-index: 999;'></ul></tr></tbody></table>")
        End If
        'End Of Added By Usha Pandit On 13.05.2020 For not allowing to create tasks for closed projects
    End Sub
    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub
    Private Sub WritePageLegend()
        Dim arrLegends(0) As String
        Dim arrLegendImg(0) As String
        arrLegends(0) = "&nbsp;Mandatory"
        arrLegendImg(0) = CommonFunctions.HTMLControls.DrawMandatoryImage(, True)
        CommonFunctions.General.WriteHTML(WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImg, arrLegends, True))
    End Sub
    Private Sub Display_TaskDetails()
        sbHTML.Append("<DIV ID=PageDiv style='overflow:auto;width:100%;'>") '390
        sbHTML.Append("<TABLE CellSpacing=0 cellpadding=0 Class=clsTable Width='99.9%'>")

        ' Page Name
        sbHTML.Append("<TR class='clsTRPageCaption'><TD align=left >")
        sbHTML.Append("<B>Bulk Task Creation</B>")
        sbHTML.Append("</TD></TR></TABLE><br>")

        sbHTML.Append("<table id=tblDisclaimer class=clsTable width=99.9% ><tr class=clsTRPageHeader><td align=left><b>Note:</b> </td></tr>")
        sbHTML.Append("<tr class=clsTRPageHeader><td align=left>1. Maximum 10 entries can be added. </td></tr>")
        sbHTML.Append("<tr class=clsTRPageHeader><td align=left>2. By default tasks will be baseline. </td></tr>")
        sbHTML.Append("<tr class=clsTRPageHeader><td align=left>3. Validations will be shown after click on red cross sign. </td></tr></table><br>")
        ' CommonFunctions.General.WriteHTML(sbHTML.ToString())
        sbHTML.Append("<div ID=divTblGrid style='overflow:auto;width:100%;height:100%'>")
        sbHTML.Append("<Table name='QTasks' id='QTasks'   class='clsGridTable' width=99.9% cellspacing=1 cellpadding=0><THead class='clsTRColumnHeader'>" + vbCrLf)
        sbHTML.Append("<TH class='FixedTD' align='Left' nowrap ></TH>")
        sbHTML.Append("<TH class='FixedTD' align='Left' nowrap >Copy Task</TH>")
        sbHTML.Append("<TH class='FixedTD' align='Left' nowrap >Validations</TH>")
        sbHTML.Append("<TH class='FixedTD' align='Left' nowrap >Task Name</TH>")
        sbHTML.Append("<TH class='FixedTD' align='Left' >Task Note</TH>")
        sbHTML.Append("<TH class='FixedTD' align='Left' nowrap >Resource</TH>")
        ''Added By Ankush Toraskar on 04-Mar-2019 Purpose::Whizible 2 Work field change
        ''sbHTML.Append("<TH class='FixedTD' align='Left' nowrap >Work(Hrs)</TH>")
        sbHTML.Append("<TH class='FixedTD' align='Left' nowrap >Work(H:M)</TH>")
        ''End of Added By Ankush Toraskar on 04-Mar-2019 Purpose::Whizible 2 Work field change
        sbHTML.Append("<TH class='FixedTD' align='Left' nowrap >IsBillable</TH>")
        sbHTML.Append("<TH class='FixedTD' align='Right' >Start Date</TH>")
        sbHTML.Append("<TH class='FixedTD' align='Right' >End Date</TH>")
        sbHTML.Append("<TH class='FixedTD' align='Right' >Task Type</TH>")
        sbHTML.Append("<TH class='FixedTD' align='Right' >Priority</TH>")
        sbHTML.Append("<TH class='FixedTD' align='Right' >Deliverable</TH>")
        sbHTML.Append("<TH class='FixedTD' align='Right' >Phase</TH>")
        sbHTML.Append("<TH class='FixedTD' align='Right' >Module</TH>")
        sbHTML.Append("<TH class='FixedTD' align='Right' >Sub Project</TH>")
        sbHTML.Append("<TH class='FixedTD' align='Right' >Milestone</TH>")
        'Added By Usha Pandit On 04.08.2020 for plotting Feature and Estimation Type fields
        sbHTML.Append("<TH class='FixedTD' align='Right' >Feature</TH>")
        sbHTML.Append("<TH class='FixedTD' align='Right' >Estimation Type</TH>")
        'End Of Added By Usha Pandit On 04.08.2020 for plotting Feature and Estimation Type fields
        sbHTML.Append("<TH class='FixedTD' align='Right' >Change Request</TH>")
        'Only for agile project
        If m_intFlag = "1" Then
            sbHTML.Append("<TH class='FixedTD' align='Right' >User Story</TH>")
            'Commented And Added By Usha Pandit On 29.01.2021 For correct heading sequence for Release and Iteration
            'sbHTML.Append("<TH class='FixedTD' align='Right' >Release</TH>")
            'sbHTML.Append("<TH class='FixedTD' align='Right' >Iteration</TH>")
            'Commented and added by Chetan M on 11 June 2021 for Change caption Iteration to Sprint
            'sbHTML.Append("<TH class='FixedTD' align='Right' >Iteration</TH>")
            sbHTML.Append("<TH class='FixedTD' align='Right' >Sprint</TH>")
            'End of Commented and added by Chetan M on 11 June 2021 for Change caption Iteration to Sprint
            sbHTML.Append("<TH class='FixedTD' align='Right' >Release</TH>")
            'End Of Added By Usha Pandit On 29.01.2021 For correct heading sequence for Release and Iteration
        End If

        'Custom Field
        Dim strUserGivenCaption As String

        strSQLQuery = "usp_Sel_tbl_PM_CustomFields_Master " & HttpContext.Current.Session("intProjectID") & ",NULL,1,'strType','Task'," & CType(HttpContext.Current.Session("intUserID"), Integer) & ",'E'"
        drCustomField = CommonFunction.Data.GetDataReader(strSQLQuery, True)

        While drCustomField.Read
            strUserGivenCaption = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("UserGivenCaption"), ""), "")
            sbHTML.Append("<TH class='FixedTD' align='Right' >" & strUserGivenCaption & "</TH>")
        End While
        'Custom Field

        sbHTML.Append("</THEAD>")
        sbHTML.Append("<tBody>")
        sbHTML.Append(DrawFilledDATasks())


        sbHTML.Append("</TABLE></DIV></DIV> ")
        CommonFunctions.General.WriteHTML(sbHTML.ToString())

    End Sub
    Protected Function DrawFilledDATasks() As String
        Dim strQuery As String

        sbHTML.Append("<TR>")
        'sbHTML.Append("<TD><A href='Javascript:createNewRow()'><Img Border=0 id=tdShowHide Src='../../Images/right.gif' title='Click here to add new record'></A></TD>")

        'Commented And Added By Usha Pandit On 13.05.2020 For not allowing to create tasks for closed projects
        'sbHTML.Append("<TD><A href='Javascript:CreateRowForResource()'" + vbCrLf)
        'sbHTML.Append("style='color:blue;' ><Img Border=0 id=tdShowHide Src='../../Images/Home/AddSection.gif' title='Add New Task'></A></TD>" + vbCrLf)

        sbHTML.Append("<TD>")
        If m_blnProjectActive = True Then
            sbHTML.Append("<A href ='Javascript:CreateRowForResource()'" + vbCrLf)
            sbHTML.Append("style='color:blue;' ><Img Border=0 id=tdShowHide Src='../../Images/Home/AddSection.gif' title='Add New Task'></A>" + vbCrLf)
        End If
        sbHTML.Append("</TD>")
        'End Of Added By Usha Pandit On 13.05.2020 For not allowing to create tasks for closed projects

        sbHTML.Append("<TD></TD>")
        sbHTML.Append("<TD></TD>")
        sbHTML.Append("<TD></TD>")
        sbHTML.Append("<TD></TD>")
        sbHTML.Append("<TD></TD>")
        sbHTML.Append("<TD></TD>")
        sbHTML.Append("<TD></TD>")
        sbHTML.Append("<TD></TD>")
        sbHTML.Append("<TD></TD>")
        sbHTML.Append("<TD></TD>")
        sbHTML.Append("<TD></TD>")
        sbHTML.Append("<TD></TD>")
        sbHTML.Append("<TD></TD>")
        sbHTML.Append("<TD></TD>")
        sbHTML.Append("<TD></TD>")
        sbHTML.Append("<TD></TD>")
        sbHTML.Append("<TD></TD>")
        If m_intFlag = "1" Then
            sbHTML.Append("<TD></TD>")
            sbHTML.Append("<TD></TD>")
            sbHTML.Append("<TD></TD>")
        End If

        'Custom Field
        strSQLQuery = "usp_Sel_tbl_PM_CustomFields_Master " & HttpContext.Current.Session("intProjectID") & ",NULL,1,'strType','Task'," & CType(HttpContext.Current.Session("intUserID"), Integer) & ",'E'"
        drCustomField = CommonFunction.Data.GetDataReader(strSQLQuery, True)

        While drCustomField.Read
            sbHTML.Append("<TD></TD>")
        End While
        'Custom Field

        sbHTML.Append("</TR>")
        sbHTML.Append("</tbody>")
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        'sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtHidRC", "txtHidRC", , , , 0, , , , , , True, , True))
        'sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtHidMaxNum", "txtHidMaxNum", , , , 0, , , , , , True, , True))
        sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtHidRC", "txtHidRC", , , , 0, , , , , , True, , True, EnableHTMLEncode:=True))
        sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtHidMaxNum", "txtHidMaxNum", , , , 0, , , , , , True, , True, EnableHTMLEncode:=True))
        ''end of Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        sbHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("dtCurrentDate", "dtCurrentDate", , , CommonFunction.Dates.GetDate(Date.Today), , , , , , , , , , , , , True, 0))

    End Function
    Public Sub WritePage()
        ''Display the Menu
        Call InitPageMenu()
        '' Display The Legend 
        WritePageLegend()
        'Display Page Caption
        'CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, , , , True))
        'CommonFunctions.General.WriteHTML("<br>")

        Dim strProjectID As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0")
        Dim strUserID As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0")
        Dim strProjectTypeID As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectTypeID"), "0")

        'Display Page Header
        'objHeaderFooter = New WebPages.Template.HeaderFooter
        'objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        'objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        'objHeaderFooter = Nothing

        'Display Page Body
        ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        '' CustomFieldsApplicable = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(" If exists ( SELECT  ProjectID  FROM tbl_PM_CustomFields_Master WHERE entityName ='Task' AND ProjectId = " + m_lngProjectId.ToString() + " ) SELECT 1 ELSE SELECT 0 ", MyBase.UseSQL), "0").ToString
        CustomFieldsApplicable = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(" usp_sel_ProjectID_tbl_PM_CustomFields_Master " + m_lngProjectId.ToString() + " ", MyBase.UseSQL), "0").ToString
        ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        If m_strAction.ToString = "Validate" Then
            Call ValidateTask()
        End If

        If m_strAction.ToString = "CreateTask" Then
            '  Call CreateTask()
            Call SaveTask()
        End If

        If m_strAction.ToString = "GetMaxNumber" Then
            Dim strSQL As String
            Dim strResult As String

            strSQL = "usp_sel_MaxNumber_tbl_PM_TMS_ProjectTasks "
            strResult = CommonFunction.Data.GetDataScalar(strSQL, True)
            Response.Clear()
            Response.Write(strResult)
            Response.End()
        End If

        Display_TaskDetails()


    End Sub
    Public Sub ValidateTask()

        Dim strTaskID, strTaskName, strStartDate, strEndDate, strWork, strTaskNotes, strDeliverableID, strResourceID, strBillable, strModuleID, strSubProjectID, strMilestoneID, strChangeRequestID, strPriority, strTaskTypes, strPhaseID, strSQL As String
        'Added By Usha Pandit On 04.08.2020 For Responsible Person filter crash for milestone
        Dim strFeatureID, strEstimationTypeID As String
        'End Of Added By Usha Pandit On 04.08.2020 For Responsible Person filter crash for milestone
        Dim strHoliday, strLeave, strUserStoryID As String
        TotalRowCount = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtHidRC"), "0")
        Dim sbSQL As New System.Text.StringBuilder
        Dim strProjectID As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0")
        Dim strUserID As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0")
        Dim strProjectTypeID As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectTypeID"), "0")
        Dim intCount As String = CommonFunction.General.CheckIsNothing(Request.QueryString("RowNumber"), "0")
        Dim strMaxNumber As String = CommonFunction.General.CheckIsNothing(Request.QueryString("MaxNumber"), "0")
        Dim strIsFirst As String = CommonFunction.General.CheckIsNothing(Request.QueryString("IsFirst"), "0")
        ' Dim intCount As Integer
        Dim strImageDelete As String
        Dim strSQLQuery As String
        Dim strResult As String

        If intCount > 0 Then
            If strIsFirst = "1" Then
                sbSQL.Append("EXEC usp_del_tbl_PM_TMS_ProjectTasks " + strProjectID + ",NULL," + strUserID + vbCrLf)
            End If
            'intCount = 1
            'For intCount = 0 To TotalRowCount - 1
            'While intCount <= TotalRowCount

            'strImageDelete = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("imgDelete_" & intCount), "")
            strImageDelete = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ImgDelete"), "")

            If strImageDelete <> "" Then


                'strTaskName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtTaskName" & intCount), "")
                'strStartDate = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtStartDate" & intCount), "")
                'strEndDate = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtEndDate" & intCount), "")
                'strWork = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtWorkHrs" & intCount), "")
                'strTaskNotes = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtTaskNotes" & intCount), "")
                'strDeliverableID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtDeliverableID" & intCount), "")
                'strResourceID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboResource" & intCount), "")
                'strBillable = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkBillable" & intCount), "")
                'strModuleID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboModuleID" & intCount), "")
                'strSubProjectID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboSubProjectID" & intCount), "")
                'strMilestoneID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboMilestoneID" & intCount), "")
                'strChangeRequestID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboChangeRequestID" & intCount), "")
                'strPriority = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboPriority" & intCount), "")
                'strTaskTypes = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboTaskType" & intCount), "")
                'strPhaseID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboPhaseID" & intCount), "")

                strTaskName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TaskName"), "")
                strStartDate = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("StartDate"), "")
                strEndDate = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EndDate"), "")
                strWork = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("WorkHrs"), "")
                strTaskNotes = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TaskNote"), "")
                strDeliverableID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("DeliverableID"), "")
                strResourceID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Resource"), "")
                strBillable = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Billable"), "")
                strModuleID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ModuleID"), "")
                strSubProjectID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SubProjectID"), "")
                strMilestoneID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MilestoneID"), "")
                'Added By Usha Pandit On 04.08.2020 for plotting Feature And Estimation Type fields
                strFeatureID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FeatureID"), "")
                strEstimationTypeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EstimationTypeID"), "")
                'End Of Added By Usha Pandit On 04.08.2020 for plotting Feature And Estimation Type fields
                strChangeRequestID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ChangeRequestID"), "")
                strPriority = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Priority"), "")
                strTaskTypes = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TaskType"), "")
                strPhaseID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PhaseID"), "")
                strUserStoryID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UserStoryID"), "")

                strHoliday = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Holiday"), "")
                strLeave = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Leave"), "")

                ''Added By Ankush Toraskar on 04-Mar-2019 Purpose::Whizible 2 Work field change
                If strWork = "" Then
                    m_Workhrs = ""
                Else
                    'If strWork.IndexOf(":") = strWork.Length - 1 Then
                    '    strWork = strWork + "00"
                    'End If
                    m_Workhrs = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strWork + "',2)", True)
                End If
                ''End of Added By Ankush Toraskar on 04-Mar-2019 Purpose::Whizible 2 Work field change

                sbSQL.Append("EXEC usp_ins_tbl_PM_TMS_ProjectTasks " + strProjectID + "," + strProjectTypeID + "," + strUserID)

                If strTaskName = "" Then
                    sbSQL.Append(",NULL")
                Else
                    'Modified by RathinP on 17-Jun-2013 to handle Single Quote
                    sbSQL.Append(",'" + CommonFunction.General.BuildQueryString(strTaskName) + "'")
                    'End by RathinP on 17-Jun-2013 to handle Single Quote
                End If

                If strTaskNotes = "" Then
                    sbSQL.Append(",NULL")
                Else
                    'Commented And Added By Usha Pandit On 05.08.2020 for escaping quotes
                    'sbSQL.Append(",'" + strTaskNotes + "'")
                    sbSQL.Append(",'" + strTaskNotes.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'")
                    'End Of Added By Usha Pandit On 05.08.2020 for escaping quotes
                End If


                If strDeliverableID = "" Then
                    sbSQL.Append(",NULL")
                Else
                    sbSQL.Append("," + strDeliverableID)
                End If


                If strResourceID = "" Then
                    sbSQL.Append(",NULL")
                Else
                    sbSQL.Append("," + strResourceID)
                End If

                ''Added By Ankush Toraskar on 04-Mar-2019 Purpose::Whizible 2 Work field change

                'If strWork = "" Then
                '    sbSQL.Append(",NULL")
                'Else
                '    sbSQL.Append(",'" + strWork + "'")
                'End If

                If m_Workhrs = "" Then
                    sbSQL.Append(",NULL")
                Else
                    sbSQL.Append(",'" + m_Workhrs + "'")
                End If
                ''End of Added By Ankush Toraskar on 04-Mar-2019 Purpose::Whizible 2 Work field change

                If strStartDate = "" Then
                    sbSQL.Append(",NULL")
                Else
                    sbSQL.Append(",'" + strStartDate + "'")
                End If

                If strEndDate = "" Then
                    sbSQL.Append(",NULL")
                Else
                    sbSQL.Append(",'" + strEndDate + "'")
                End If

                'change REQUESTID 
                If strChangeRequestID = "" Then
                    sbSQL.Append(",NULL")
                Else
                    sbSQL.Append("," + strChangeRequestID)
                End If


                If strBillable = "" Then
                    sbSQL.Append(",0")
                Else
                    If strBillable = "ON" Then
                        sbSQL.Append(",1")
                    End If

                End If

                If strModuleID = "" Then
                    sbSQL.Append(",NULL")
                Else
                    sbSQL.Append("," + strModuleID)
                End If

                If strSubProjectID = "" Then
                    sbSQL.Append(",NULL")
                Else
                    sbSQL.Append("," + strSubProjectID)
                End If

                If strMilestoneID = "" Then
                    sbSQL.Append(",NULL")
                Else
                    sbSQL.Append("," + strMilestoneID)
                End If

                If strPriority = "" Then
                    sbSQL.Append(",NULL")
                Else
                    'Commented And Added By Usha Pandit On 05.08.2020 for escaping quotes
                    'sbSQL.Append(",'" + strPriority + "'")
                    sbSQL.Append(",'" + strPriority.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'")
                    'End Of Added By Usha Pandit On 05.08.2020 for escaping quotes
                End If

                If strTaskTypes = "" Then
                    sbSQL.Append(",NULL")
                Else
                    sbSQL.Append(",'" + strTaskTypes + "'")
                End If

                If strPhaseID = "" Then
                    sbSQL.Append(",NULL")
                Else
                    sbSQL.Append("," + strPhaseID)
                End If

                If strHoliday.ToUpper = "TRUE" Then
                    sbSQL.Append(",1")
                Else
                    sbSQL.Append(",0")
                End If

                If strLeave.ToUpper = "TRUE" Then
                    sbSQL.Append(",1")
                Else
                    sbSQL.Append(",0")
                End If

                If strUserStoryID = "" Then
                    sbSQL.Append(",NULL")
                Else
                    sbSQL.Append("," + strUserStoryID)
                End If

                'Added By Usha Pandit On 04.08.2020 for plotting Feature and Estimation Type fields
                If strFeatureID = "" Then
                    sbSQL.Append(",NULL")
                Else
                    sbSQL.Append("," + strFeatureID)
                End If

                If strEstimationTypeID = "" Then
                    sbSQL.Append(",NULL")
                Else
                    sbSQL.Append("," + strEstimationTypeID)
                End If
                'End Of Added By Usha Pandit On 04.08.2020 for plotting Feature and Estimation Type fields

                sbSQL.Append(vbCrLf)
            End If
            'intCount = intCount + 1

            'End While
            If sbSQL.Length > 0 Then
                sbSQL.Append("EXEC usp_ins_TMS_TaskValidation " + strProjectID + "," + strProjectTypeID + "," + strUserID)

                If m_PhaseMandatory = "True" Then
                    sbSQL.Append(",1")
                Else
                    sbSQL.Append(",0")
                End If

                If m_ModuleMandatory = "True" Then
                    sbSQL.Append(",1")
                Else
                    sbSQL.Append(",0")
                End If

                If m_MilestoneMandatory = "True" Then
                    sbSQL.Append(",1")
                Else
                    sbSQL.Append(",0")
                End If

                If m_SubProjectMandatory = "True" Then
                    sbSQL.Append(",1")
                Else
                    sbSQL.Append(",0")
                End If

                If m_ChangeRequestMandatory = "True" Then
                    sbSQL.Append(",1")
                Else
                    sbSQL.Append(",0")
                End If

                If m_FeatureMandatory = "True" Then
                    sbSQL.Append(",1")
                Else
                    sbSQL.Append(",0")
                End If

                If m_EstimationTypeMandatory = "True" Then
                    sbSQL.Append(",1")
                Else
                    sbSQL.Append(",0")
                End If

                CommonFunction.Data.InsertOrUpdateData(sbSQL.ToString, MyBase.UseSQL)


            End If

            strSQLQuery = "usp_check_IsTaskValid " & strProjectID & "," & strUserID & "," & strMaxNumber
            If strImageDelete <> "" Then
                strResult = CommonFunction.Data.GetDataScalar(strSQLQuery, True)
                Response.Clear()
                Response.Write(strResult)
                Response.End()
            Else
                Response.Clear()
                Response.Write("0")
                Response.End()
            End If


            'Response.Write("<script type=text/javascript>")
            'Response.Write("window.open('../PM/QuickTask_Validate_CommonList.aspx?MasterTagID=20176&FromWhere=PM', '', 'resizable=yes,scrollbars=no,left=' + (window.screen.width - 1000)/2 + ',top=' + (window.screen.height - 800)/2 + ',width=1000,height=800')")
            'Response.Write("</script>")
        End If

    End Sub

    Public Sub SaveTask()
        '  Dim strRowCount As Integer = Convert.toInt(Request.QueryString("RowCount"))

        '  Dim strRowCount As Integer = Convert.ToInt64(Request.QueryString("RowCount"))
        TotalRowCount = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtHidRC"), "0")
        'Dim strRowCount As String = CommonFunction.General.CheckIsNothing(Request.QueryString("RowCount"), "0")
        Dim i As Integer
        Dim strSQL As String
        Dim strProjectID As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0")



        Dim sbSQL As New System.Text.StringBuilder
        Dim strPhaseName As String = ""
        Dim strModuleName As String = ""
        Dim strSubProjectName As String = ""
        Dim strMilestoneName As String = ""
        Dim strQuery_2 As String
        Dim strQuery_1 As String
        Dim strTempQuery As String

        Dim strTaskName, strStartDate, strEndDate, strWork, strTaskNotes, strDeliverableID, strResourceID, strBillable, strModuleID, strSubProjectID, strMilestoneID, strChangeRequestID, strPriority, strTaskTypes, strPhaseID As String
        'Added By Usha Pandit On 04.08.2020 For Responsible Person filter crash for milestone
        Dim strFeatureID, strEstimationTypeID As String
        'End Of Added By Usha Pandit On 04.08.2020 For Responsible Person filter crash for milestone
        For i = 1 To TotalRowCount
            sbSQL.Clear()
            strTaskName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtTaskName" & i), "")
            strStartDate = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtStartDate" & i), "")
            strEndDate = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtEndDate" & i), "")
            strWork = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtWorkHrs" & i), "")
            strTaskNotes = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtTaskNotes" & i), "")
            strDeliverableID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtHidDeliverableID" & i), "")
            strResourceID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboResource" & i), "")
            strBillable = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkBillable" & i), "")
            strModuleID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboModuleID" & i), "")
            strSubProjectID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboSubProjectID" & i), "")
            strMilestoneID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboMilestoneID" & i), "")
            'Added By Usha Pandit On 04.08.2020 for plotting Feature And Estimation Type fields
            strFeatureID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboFeatureID" & i), "")
            strEstimationTypeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboEstimationTypeID" & i), "")
            'End Of Added By Usha Pandit On 04.08.2020 for plotting Feature And Estimation Type fields
            strChangeRequestID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboChangeRequestID" & i), "")
            strPriority = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboPriority" & i), "")
            strTaskTypes = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboTaskType" & i), "")
            strPhaseID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboPhaseID" & i), "")
            m_strUserStory = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboUserStory" & i), "")

            ''Added By Ankush Toraskar on 04-Mar-2019 Purpose::Whizible 2 Work field change
            If strWork = "" Then
                m_intWorkhrs = ""
            Else
                'If strWork.IndexOf(":") = strWork.Length - 1 Then
                '    strWork = strWork + "00"
                'End If
                m_intWorkhrs = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strWork + "',2)", True)
            End If
            ''End of Added By Ankush Toraskar on 04-Mar-2019 Purpose::Whizible 2 Work field change

            If strResourceID <> "" Then
                'For Phase,Subproject,milestone,Module Name
                If strPhaseID = "" Then
                    strPhaseID = "NULL"
                End If
                If strModuleID = "" Then
                    strModuleID = "NULL"
                End If
                If strSubProjectID = "" Then
                    strSubProjectID = "NULL"
                End If
                If strMilestoneID = "" Then
                    strMilestoneID = "NULL"
                End If
                strSQL = "EXEC usp_sel_PhaseName " & strPhaseID & "," & strModuleID & "," & strSubProjectID & "," & strMilestoneID
                Dim drNames As IDataReader = CommonFunction.Data.GetDataReader(strSQL, True)

                If drNames.Read Then
                    strPhaseName = CommonFunction.Data.CheckIsDBNull(drNames("Phase"), "")
                    strModuleName = CommonFunction.Data.CheckIsDBNull(drNames("Module"), "")
                    strSubProjectName = CommonFunction.Data.CheckIsDBNull(drNames("Subproject"), "")
                    strMilestoneName = CommonFunction.Data.CheckIsDBNull(drNames("Milestone"), "")

                End If

                'For Phase,Subproject,milestone,Module Name
                strQuery_2 = ""
                strQuery_1 = "EXEC usp_Ins_tbl_PM_ProjectAssignedTasks NULL ," & strProjectID

                If strTaskName = "" Then
                    strQuery_2 &= ",null"
                Else
                    'Modified by RathinP on 17-Jun-2013 to handle Single Quote
                    strQuery_2 &= ",'" + CommonFunction.General.BuildQueryString(strTaskName) + "'"
                    'End by RathinP on 17-Jun-2013 to handle Single Quote
                End If

                If strStartDate = "" Then
                    strQuery_2 &= ",null"
                Else
                    strQuery_2 &= ",'" + strStartDate + "'"
                End If

                If strEndDate = "" Then
                    strQuery_2 &= ",null"
                Else
                    strQuery_2 &= ",'" + strEndDate + "'"
                End If

                ''Added By Ankush Toraskar on 04-Mar-2019 Purpose::Whizible 2 Work field change

                'If strWork = "" Then
                '    strQuery_2 &= ",null"
                'Else
                '    strQuery_2 &= ",'" + strWork + "'"
                'End If
                If m_intWorkhrs = "" Then
                    strQuery_2 &= ",null"
                Else
                    strQuery_2 &= ",'" + m_intWorkhrs + "'"
                End If
                ''End of Added By Ankush Toraskar on 04-Mar-2019 Purpose::Whizible 2 Work field change

                '----------'
                strQuery_2 &= ",'O'"
                '---------'
                If strBillable = "" Then
                    strQuery_2 &= ",0"
                Else
                    If strBillable = "ON" Then
                        strQuery_2 &= ",1"
                    End If

                End If

                If strTaskNotes = "" Then
                    strQuery_2 &= ",null"
                Else
                    'Commented And Added By Usha Pandit On 05.08.2020 for escaping quotes
                    'strQuery_2 &= ",'" + strTaskNotes + "'"
                    strQuery_2 &= ",'" + strTaskNotes.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'"
                    'End Of Added By Usha Pandit On 05.08.2020 for escaping quotes
                End If

                If strTaskTypes = "" Then
                    strQuery_2 &= ",null"
                Else
                    strQuery_2 &= ",'" + strTaskTypes + "'"
                End If

                '--------------Baseline section----------------------'
                'By default baseline task
                If strStartDate = "" Then
                    strQuery_2 &= ",null"
                Else
                    strQuery_2 &= ",'" + strStartDate + "'"
                End If

                If strEndDate = "" Then
                    strQuery_2 &= ",null"
                Else
                    strQuery_2 &= ",'" + strEndDate + "'"
                End If

                ''Added By Ankush Toraskar on 04-Mar-2019 Purpose::Whizible 2 Work field change

                'If strWork = "" Then
                '    strQuery_2 &= ",null"
                'Else
                '    strQuery_2 &= ",'" + strWork + "'"
                'End If
                If m_intWorkhrs = "" Then
                    strQuery_2 &= ",null"
                Else
                    strQuery_2 &= ",'" + m_intWorkhrs + "'"
                End If
                ''End of Added By Ankush Toraskar on 04-Mar-2019 Purpose::Whizible 2 Work field change

                '--------------Baseline section----------------------'

                If strPriority = "" Then
                    strQuery_2 &= ",null"
                Else
                    'Commented And Added By Usha Pandit On 05.08.2020 for escaping quotes
                    'strQuery_2 &= ",'" + strPriority + "'"
                    strQuery_2 &= ",'" + strPriority.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'"
                    'End Of Added By Usha Pandit On 05.08.2020 for escaping quotes
                End If


                If strPhaseID = "" Then
                    strQuery_2 &= ",null"
                Else
                    strQuery_2 &= "," + strPhaseID
                End If

                If strPhaseName = "" Then
                    strQuery_2 &= ",null"
                Else
                    strQuery_2 &= ",'" + strPhaseName + "'"
                End If

                If strModuleID = "" Then
                    strQuery_2 &= ",null"
                Else
                    strQuery_2 &= "," + strModuleID
                End If

                If strModuleName = "" Then
                    strQuery_2 &= ",null"
                Else
                    strQuery_2 &= ",'" + strModuleName + "'"
                End If

                If strSubProjectID = "" Then
                    strQuery_2 &= ",null"
                Else
                    strQuery_2 &= "," + strSubProjectID
                End If

                If strSubProjectName = "" Then
                    strQuery_2 &= ",null"
                Else
                    strQuery_2 &= ",'" + strSubProjectName + "'"
                End If

                If strMilestoneID = "" Then
                    strQuery_2 &= ",null"
                Else
                    strQuery_2 &= "," + strMilestoneID
                End If

                If strMilestoneName = "" Then
                    strQuery_2 &= ",null"
                Else
                    strQuery_2 &= ",'" + strMilestoneName + "'"
                End If
                '------------------'
                strQuery_2 &= ",null"
                '------------------'

                If strChangeRequestID = "" Then
                    strQuery_2 &= ",null"
                Else
                    strQuery_2 &= "," + strChangeRequestID
                End If

                '------------------'

                'Commented And Added By Usha Pandit On 04.08.2020 For plotting Feature and Estimation Type fields
                'strQuery_2 &= ",null"
                'strQuery_2 &= ",null"

                If strFeatureID = "" Then
                    strQuery_2 &= ",null"
                Else
                    strQuery_2 &= "," + strFeatureID
                End If

                If strEstimationTypeID = "" Then
                    strQuery_2 &= ",null"
                Else
                    strQuery_2 &= "," + strEstimationTypeID
                End If

                'End Of Added By Usha Pandit On 04.08.2020 For plotting Feature and Estimation Type fields
                '------------------'

                If strDeliverableID = "" Then
                    strQuery_2 &= ",null"
                Else
                    strQuery_2 &= "," + strDeliverableID
                End If


                '------------------'

                strQuery_2 &= ",null,null,0,1,0"

                strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(m_strUserName) & "'"

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
                '---------------------------
                strQuery_2 &= ",NULL"
                '------------------'
                strTempQuery = strQuery_2
                strSQL = strQuery_1 & strTempQuery

                ' If m_strProjectSetting = PROJECT_SETTING_NORMAL Then
                strQuery_2 = strTempQuery
                strTempQuery = strSQL
                m_lngTaskId = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strTempQuery, MyBase.UseSQL), "0"), Long)

                'Insert the Child Tasks for each employee
                strQuery_1 = "Exec usp_Ins_tbl_PM_ProjectAssignedSubTasks " & m_lngTaskId.ToString()
                strQuery_1 &= ", " & strResourceID
                strQuery_1 &= ", NULL," & strProjectID
                strSQL = strQuery_1 & strQuery_2

                'm_strTaskIDList &= CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL)) & ", "
                m_strTaskIDList = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL))
                'Else
                '    m_lngTaskId = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), Long)
                '    m_strTaskIDList = m_lngTaskId.ToString() & ", "
                'End If

                'Added By Bharat Tekade on 1st-Mar-2016 to indicate whether task is created from bulk task page
                Dim strBulkTaskQuery As String
                strBulkTaskQuery = " UPDATE tbl_PM_ProjectTasks SET IsBulkTask=1 WHERE TaskID IN (" & m_lngTaskId & "," & m_strTaskIDList & ")"
                CommonFunctions.Data.InsertOrUpdateData(strBulkTaskQuery, MyBase.UseSQL)
                'End of Added By Bharat Tekade on 1st-Mar-2016 to indicate whether task is created from bulk task page

                'Code Added By Bharat T on 21st-Jan-2016 for Custom Field Saving functionality

                Dim strTypeInaccessibleCustomFieldList As String
                m_strCustomFieldList = HttpContext.Current.Request.Form("CustomFieldList" & i)
                strTypeInaccessibleCustomFieldList = HttpContext.Current.Request.Form("TypeInaccessibleCustomFieldList" & i)


                'If m_strTaskIDList <> "" Then
                '    m_strTaskIDList = m_strTaskIDList.Substring(0, m_strTaskIDList.Length - 2)
                'End If

                If m_strCustomFieldList <> "" Then
                    Dim arrCustomFields() As String = Split(m_strCustomFieldList, ",")
                    Dim intCount As Integer
                    Dim strQuery As String

                    If m_lngTaskId > 0 Then
                        strQuery = " Update tbl_PM_ProjectTasks set "
                        For intCount = 0 To arrCustomFields.Length - 1
                            If HttpContext.Current.Request.Form("Dummy" + arrCustomFields(intCount)) Is Nothing Then
                                If InStr(1, arrCustomFields(intCount), "CustomFieldDate") > 0 And HttpContext.Current.Request.Form(arrCustomFields(intCount) & i) = "" Then
                                    strQuery = strQuery & arrCustomFields(intCount) & "=NULL,"
                                Else
                                    If Not HttpContext.Current.Request.Form(arrCustomFields(intCount) & i) Is Nothing Then
                                        strQuery = strQuery & arrCustomFields(intCount) & "='" & CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.Form(arrCustomFields(intCount) & i)) + "',"
                                    Else
                                        strQuery = strQuery & arrCustomFields(intCount) & "=NULL,"
                                    End If
                                End If
                            Else
                                If InStr(1, arrCustomFields(intCount), "CustomFieldDate") > 0 And HttpContext.Current.Request.Form("Dummy" + arrCustomFields(intCount) & i) = "" Then
                                    strQuery = strQuery & arrCustomFields(intCount) & "=NULL,"
                                Else
                                    strQuery = strQuery & arrCustomFields(intCount) & "='" & CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.Form("Dummy" + arrCustomFields(intCount) & i)) + "',"
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
                End If  'm_strCustomFieldList <>''
            End If  ' strResourceID <> ''
            'End of Code Added By Bharat T on 21st-Jan-2016 for Custom Field Saving functionality

        Next
        If TotalRowCount <> "0" Then
            Response.Write("<script type=text/javascript>")
            Response.Write(" alert('Tasks are created successfully.'); ")
            Response.Write(" </script>")
        End If
    End Sub
    '<System.Web.Services.WebMethod> _
    Public Sub DrawCustomFields(ByVal RowID As String)

        Dim strSQLQuery As String
        Dim drCustomField As IDataReader

        Dim strControlName, SQLQuey, intControlWidth, strControlValue, strToBeInserted As String
        Dim blnIsMandatory As Boolean
        Dim intControlMaxLength As Integer
        Dim intControlMinValue As Integer
        Dim intControlMaxValue As Integer
        Dim intControlHeight As Integer
        Dim strControlCaption As String
        Dim strControlValidationRules As String

        Dim strDataType As String

        'Dim strCustomFieldTD As System.Text.StringBuilder
        Dim strCustomFieldTD As StringBuilder = New StringBuilder()
        Dim strControlValidations As New StringBuilder("")
        Dim arrtemp(50) As String



        strSQLQuery = "usp_Sel_tbl_PM_CustomFields_Master " & HttpContext.Current.Session("intProjectID") & ",NULL,1,'strType','Task'," & CType(HttpContext.Current.Session("intUserID"), Integer) & ",'E'"
        drCustomField = CommonFunction.Data.GetDataReader(strSQLQuery, True)


        Call GetValidationRules()
        arrValidationMessages.CopyTo(arrtemp, 0)

        While drCustomField.Read
            strControlName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DatabaseFieldName"), ""), "")
            intControlWidth = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("ControlWidth"), ""), "")
            strControlCaption = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("UserGivenCaption"), ""), "")
            strControlValue = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DefaultValue"), ""), "")
            'strToBeInserted = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DatabaseFieldName"), ""), "")
            'blnIsMandatory = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DatabaseFieldName"), ""), "")
            intControlMaxLength = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("MaxLength"), "0"), "0")
            intControlHeight = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("ControlHeight"), "0"), "0")

            intControlMinValue = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("MinValue"), "0"), "0")
            intControlMaxValue = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("MaxValue"), "0"), "0")
            strDataType = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DataType"), "0"), "0")

            strControlValidationRules = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("ValidationRules"), ""), "")
            strToBeInserted = "disabled"
            SQLQuey = "Exec usp_Sel_tbl_PM_CustomFields_Details  " & strControlName & "," & HttpContext.Current.Session("intProjectID") & ",1,'Task'"
            blnIsMandatory = False

            If InStr("," + strControlValidationRules.ToString.Trim, ",1,") <> 0 Then
                blnIsMandatory = True
            End If

            If Not IsNumeric(intControlMaxLength) Or intControlMaxLength = "0" Then
                intControlMaxLength = "100"
            ElseIf InStr(drCustomField("DatabaseFieldName").ToString.Trim, "CustomFieldTextArea") > 0 Then
                If (intControlMaxLength > "3800") Then
                    intControlMaxLength = "3800"
                End If
            Else
                If (intControlMaxLength > "100") Then
                    intControlMaxLength = "100"
                End If
            End If


            If intControlWidth = "" Then
                intControlWidth = "130"
            End If

            m_strCustomFieldList = m_strCustomFieldList + strControlName + ","

            strControlName += RowID
            If InStr(drCustomField("DatabaseFieldName").ToString.Trim, "CustomFieldCombo", CompareMethod.Text) > 0 Then
                strCustomFieldTD.Append("  ")
                strCustomFieldTD.Append("<td>" + CommonFunction.HTMLControls.DrawComboBox(strControlName, SQLQuey, intControlWidth, strControlValue, "disabled ", True, True, , blnIsMandatory) + "</td>")

                declarevariables = declarevariables + "var obj" + strControlName.ToString.Trim + "= GetObjectReference('frmQuickTask','" + strControlName.ToString.Trim + "');" + vbCrLf

            ElseIf InStr(drCustomField("DatabaseFieldName").ToString, "CustomFieldText", CompareMethod.Text) > 0 Then
                ''strCustomFieldTD.Append("<td>" + CommonFunction.HTMLControls.DrawTextBox(strControlName, strControlName, , intControlWidth, intControlMaxLength, strControlValue, , , , False, "", , strToBeInserted, True, blnIsMandatory) + "</td>")
                strCustomFieldTD.Append("<td>" + CommonFunction.HTMLControls.DrawTextBox(strControlName, strControlName, , intControlWidth, intControlMaxLength, strControlValue, , , , False, "", , strToBeInserted, True, blnIsMandatory, EnableHTMLEncode:=True) + "</td>")
                declarevariables = declarevariables + "var obj" + strControlName.ToString.Trim + "= GetObjectReference('frmQuickTask','" + strControlName.ToString.Trim + "');" + vbCrLf

            ElseIf InStr(drCustomField("DatabaseFieldName").ToString.Trim, "CustomFieldTextArea") > 0 Then
                ''strCustomFieldTD.Append("<td>" + CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, strControlCaption, , , "frmQuickTask", , , intControlWidth, intControlHeight, intControlMaxLength, strControlValue, , , , "false", "", , "disabled", False, blnIsMandatory, Wrap:="Soft") + "</td>")
                strCustomFieldTD.Append("<td>" + CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, strControlCaption, , , "frmQuickTask", , , intControlWidth, intControlHeight, intControlMaxLength, strControlValue, , , , "false", "", , "disabled", False, blnIsMandatory, Wrap:="Soft", EnableHTMLEncode:=True) + "</td>")
                declarevariables = declarevariables + "var obj" + strControlName.ToString.Trim + "= GetObjectReference('frmQuickTask','" + strControlName.ToString.Trim + "');" + vbCrLf

            ElseIf InStr(drCustomField("DatabaseFieldName").ToString.Trim, "CustomFieldDate") > 0 Then
                If strControlValue <> "" And strControlValue <> "0" Then
                    strCustomFieldTD.Append("<td>" + CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, CommonFunction.Dates.GetDate(CType(strControlValue, Date)), , "frmQuickTask", , , , False, False, "", True, blnIsMandatory, , strToBeInserted) + "</td>")
                Else
                    strCustomFieldTD.Append("<td>" + CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, , , "frmQuickTask", , , , False, False, "", True, blnIsMandatory, , "disabled") + "</td>")
                End If
                declarevariables = declarevariables + "var obj" + strControlName.ToString.Trim + "= GetObjectReference('frmQuickTask','" + strControlName.ToString.Trim + "');" + vbCrLf

            End If

            If (strDataType = "1") Then
                If InStr(1, "," + strControlValidationRules, ",3,") = 0 Then
                    strControlValidationRules = strControlValidationRules + "3,"
                End If
            End If

            Call GenerateValidationScript(strControlValidationRules, strControlName, strControlCaption, intControlMinValue, intControlMaxValue, intControlMaxLength, strControlValidations, arrtemp)
        End While

        If m_strCustomFieldList <> "" Then
            m_strCustomFieldList = m_strCustomFieldList.Substring(0, m_strCustomFieldList.Length - 1)
        End If

        strCustomFieldTD.Append(CommonFunctions.HTMLControls.DrawTextBox("CustomFieldList" + RowID, "CustomFieldList" + RowID, , , , m_strCustomFieldList, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
        strCustomFieldTD.Append(CommonFunctions.HTMLControls.DrawTextBox("TypeInaccessibleCustomFieldList" + RowID, "TypeInaccessibleCustomFieldList" + RowID, , , , m_strTypeInaccessibleCustomFieldList, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))

        Response.Clear()
        Response.ContentType = "text/html"        
        Response.Write(strCustomFieldTD.ToString + vbCrLf + " #### " + vbCrLf + declarevariables + vbCrLf + strClientSideScript)
        Response.End()
        'Return ""

    End Sub
    Private Sub GenerateValidationScript(ByVal strControlValidationRules As String, ByVal strControlName1 As String, ByVal strControlCaption As String, ByVal intControlMinValue As String, ByVal intControlMaxValue As String, ByVal intControlMaxLength As Integer, ByRef strControlValidations As StringBuilder, ByVal arrValidations() As String)
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

        arrRules = Split(strControlValidationRules, ",")
        strCaption = strControlCaption
        If InStr(strControlName1, "Keywords") <> 0 Then
            Exit Sub
        End If

        ' For each validation rule to be applied, generate the client side validation script.
        For intCtr = LBound(arrRules) To UBound(arrRules)
            If arrRules(intCtr) <> "" Then
                intValidationID = CType(arrRules(intCtr), Integer)
                'If IsNumeric(intValidationID) Then
                intValidationID = CInt(intValidationID)
                arrValidations(intValidationID) = arrValidationMessages(intValidationID)
                arrValidations(intValidationID) = Replace(arrValidations(intValidationID), "<ID>", strCaption)
                'End If
            Else
                intValidationID = 0
            End If

            Dim blnLoopcheck As Boolean = False
            Dim strControlName As String = strControlName1
            Dim strMinValue As String = intControlMinValue
            Dim strMaxValue As String = intControlMaxValue
            If (CType(intValidationID, String) <> "" And CType(intValidationID, String) <> "0") Then
                strValidation = strValidation + "if(obj" + strControlName + " != null) " + vbCrLf
                strValidation = strValidation + "{ " + vbCrLf
            End If

            Select Case intValidationID.ToString

                Case "1" ' Not Blank.														
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    strValidation = strValidation + "       if(disallowBlank(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(1), False) + "',false)){" + vbCrLf
                    'arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "True"
                    blnLoopcheck = True
                Case "2" ' Valid Date.				
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    If InStr(strControlCaption, "'") > 0 Then
                        strValidation = strValidation + "   if(!isDate(obj" + strControlName + ",""" + arrValidations(2) + """,false){" + vbCrLf
                    Else
                        strValidation = strValidation + "   if(!isDate(obj" + strControlName + ",'" + arrValidations(2) + "',false){" + vbCrLf
                    End If

                    strValidation = strValidation + "       if(!isDate(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(2), False) + "',false){" + vbCrLf
                    'If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
                    '    strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                    'End If
                    strValidation = strValidation + "       return;" + vbCrLf
                    strValidation = strValidation + "   }}}" + vbCrLf

                Case "3" ' Numeric Data.
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    strValidation = strValidation + "       if(disallowNonNumeric(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(3), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True
                Case "9" ' Only Alphabets.
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    strValidation = strValidation + "       if(disallowNonAlphabets(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(9), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True
                Case "12" ' Max Length
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    'If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE).ToString.ToUpper = "APP_CONTROL_TYPE_TEXT_AREA" Then
                    If Trim(intControlMaxLength) <> "" And Trim(intControlMaxLength) <> "0" Then
                        strValidation = strValidation + "   if(disallowMaxlengthViolation(obj" + strControlName + "," + CType(intControlMaxLength, String) + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(12), "<LENGTH>", intControlMaxLength), False) + "',false)){" + vbCrLf
                        strValidation = strValidation + "	obj" + strControlName + ".value = Left(Trim(obj" + strControlName + ".value), " + CType(intControlMaxLength, String) + ");" + vbCrLf
                        blnLoopcheck = True
                    End If

                    'End If

                Case "13" ' Positive Numeric Data.	
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    strValidation = strValidation + "       if (disallowNegativeNumeric(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(13), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True
                Case "14" ' Check Duplication.
                    ' Not Processed !!

                Case "15" ' Restrict Special characters.
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    strValidation = strValidation + "       if(disallowSpecialCharacters(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(15), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True

                Case "16" ' Minimum Value Check.
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    strValidation = strValidation + "       if(disallowMinValueViolation(obj" + strControlName + ", " + strMinValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(16), "<VALUE>", strMinValue), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True

                Case "17" ' Maximum Value Check.
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    strValidation = strValidation + "       if(disallowMaxValueViolation(obj" + strControlName + ", " + strMaxValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(17), "<VALUE>", strMaxValue), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True
                Case "18" ' Value Range.
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    strValidation = strValidation + "       if(disallowValueRangeViolation(obj" + strControlName + ", " + strMinValue + ", " + strMaxValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(18), "<RANGE>", strMinValue + " - " + strMaxValue), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True

                Case Else
            End Select
            If blnLoopcheck = True Then

                'If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
                '    strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                'End If
                strValidation = strValidation + "	        setFocus(obj" + strControlName + ");" + vbCrLf
                strValidation = strValidation + "           return false;" + vbCrLf
                strValidation = strValidation + "       }" + vbCrLf
                strValidation = strValidation + "   } " + vbCrLf
                strValidation = strValidation + "} " + vbCrLf
            End If
        Next

        ' if the control is editable, only then apply the validation rules.
        If Right(strValidation, 2) = ";;" Then
            strValidation = Left(strValidation, Len(strValidation) - 1)
        End If
        'If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
        '    strClientSideScript = strClientSideScript + strValidation
        'Else
        If UCase(strControlName1) = "SUMMARY" Or UCase(strControlName1) = "REPORTEDBY" Or UCase(strControlName1) = "DESCRIPTION" Then
            strClientSideScript = strClientSideScript + strValidation
        Else
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


End Class