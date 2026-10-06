Public Class PM_ProjecPlanDeliverable
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

#Region " Initialized Variables "


    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    ' Added by MahendraV On 6:13 PM 6/29/2007 For WhizibleSEM 7
    ' Hide 'Save' link on its click for static menu (avoid duplicate entries)
    ' Start_MV_6/29/2007
    Dim m_blnIsTopMenu As Boolean = True 'Used for deciding Display Position
    ' End_MV_6/29/2007
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid

    Private m_intProjectID As Integer = 0
    Private strSQLQuery As String = ""
    Private m_intCount As Integer = 0
    Protected m_strWindowTitle As String = MyBase.GetResourceString("TITLE_TEMPLATE_TASKS")
    Protected m_strPageHeader As String = MyBase.GetResourceString("HEADING_PLAN_DELIVERABLE")

    Protected m_intTagId As String = ""
    Protected m_intDeliverableID As String = ""
    Protected m_intDeliverableTypeID As String = ""
    Protected m_strQueryString As String = ""
    Protected m_strMode As String = ""
    Protected m_intSelectedTemplateID As String = ""
    Protected m_intDateFormat As String = ""
    Protected m_strDateFormat As String = ""
    Protected m_intRevisionNo As Integer = 0
    Protected m_intSpecificationID As String = ""
    Protected m_dblTaskEffort As String = ""
    Protected m_strlblDocNo As String = ""
    Protected m_strlblTitle As String = ""
    Protected m_strlblStartDate As String = ""
    Protected m_strlblEarliestDate As String = ""
    Protected m_strlblLatestDate As String = ""
    Protected m_strlblLCE As String = ""
    Protected m_strFieldApplicable As String = ""
    Protected m_strFieldMandatory As String = ""
    Protected m_dblDeliverableLCE As Double = 0
    Protected m_dtStartDate As String = ""
    Protected m_dtEndDate As String = ""
    Protected m_strStudyTitle As String = ""
    ''Added By Usha Pandit on 22-Feb-2019 Purpose::Project Work field level changes 
    Protected m_strWorkHourMinute As String = ""
    ''End of Added By Usha Pandit on 22-Feb-2019 Purpose::Project Work field level changes 

    Protected m_strControlNames As String = ""
    Protected m_intRecordCount As Integer = 0
    Protected m_intProjectPhaseTaskTemplateID As String = ""
    Protected m_strParentURL As String = ""
    Protected m_strFromWhere As String = ""
    Protected m_strPagingAlphabet As String = ""
    Protected m_strSortBy As String = ""
    Protected m_strSortOrder As String = ""
    Protected m_strParentTagID As String = ""
    Protected m_strFromCL As String = ""

    Protected m_dblIncrementMinutes As Double = 0

    Protected m_dblProjectWorkHrs As Double = 0
    '==============================================================
    'Added By       :   HiteshS on 31st Jan.2005
    'IssueID        :   15430
    'Description    :   Variable to hold Assigned Task Hours for a Project
    '==============================================================
    Protected m_dblProjectAssignedTaskHrs As Double = 0
    '==============================================================
    'End Of Addition By HiteshS on 31st Jan.2005
    '==============================================================

    Protected m_strProjectEndDate As String = ""

    '==============================================================
    'Added By       :   NitinVS on 16 Feb 2005 
    'Description    :   Variable to hold Sub Task Applicable or not to implement Task level planning
    'version        :   PBNITE SP2 
    '==============================================================
    Protected m_IsSubTaskApplicable As Integer
    Protected intCompanyHrsPerDay As Double
    Protected m_dblHoursPerDay As Double
    Protected m_lngWeekDays As Double

    '==============================================================
    'End Of Addition By NitinVS on 16 Feb 2005 
    '==============================================================

    '==============================================================
    'Added By       :   NitinVS on 23 Mar 2005 
    'IssueID        :   16984 
    'Description    :   Project Start Date validation is not applicable to task for plan deliverable
    '                   Variable to hold Project Start Date 
    'version        :   PBNITE SP2 
    '==============================================================
    Protected m_strProjectStartDate As String
    '==============================================================
    'End Of Addition By NitinVS on 23 Mar 2005 issueID 16984
    '==============================================================
    'added by Harshk on 25/08/2005'
    Protected m_strDistributeWorkInAT_CorporateFlag As String
    Protected m_bitResourceValidation As Int16 = 1 'on 06/10/2005
    'End added by Harshk on 25/08/2005'
    ' Added by MahendraV On 10:38 AM 6/27/2007 To get server today date
    Protected m_strTodayDate As String
    ' End of additiion

    'Added by RuchiraC for Hexaware-RequestID-25641 on 05-Apr-10
    Protected TaskMandatoryArr As String = ""
    Protected ReviewTaskArr As String = ""
    'End of Addition by RuchiraC for Hexaware-RequestID-25641 on 05-Apr-10

    'Added by Usha Pandit on 05-April-2019 Purpose::Whizible 2 Work field change
    Protected m_RestrictByMinHours As String
    Protected m_ProjectID As String
    'End of Added by Usha Pandit on 05-April-2019 Purpose::Whizible 2 Work field change
#End Region

#Region " Page Load Functions "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        m_strWindowTitle = MyBase.GetResourceString("TITLE_TEMPLATE_TASKS")
        m_strPageHeader = MyBase.GetResourceString("HEADING_PLAN_DELIVERABLE")

        ''Added By Usha Pandit on 05-April-2019 Purpose::Whizible 2 Work field change
        Dim drCompany As IDataReader
        drCompany = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation", True)
        If drCompany.Read() Then
            m_RestrictByMinHours = CommonFunction.Data.CheckIsDBNull(drCompany("RestrictByMinHours"), "0")
        End If
        ''End of Added By Usha Pandit on 05-April-2019 Purpose::Whizible 2 Work field change


    End Sub
    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : the main function to initialize the page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ShamkantD
        ' Created               : August 25, 2004
        ' Revisions             :
        '=====================================================================
        Dim drTemplateRevision As IDataReader
        Dim drFieldLables As IDataReader
        Dim drSelectedDeliverable As IDataReader
        Dim drTemplate As IDataReader
        Dim drProjectInformation As IDataReader

        '==============================================================
        'Added By       :   NitinVS on 16 Feb 2005 
        'Description    :   Variable to hold Sub Task Applicable or not to implement Task level planning
        'version        :   PBNITE SP2 
        '==============================================================
        Dim ObjDr As IDataReader
        Dim strSQL As String
        Dim ApplyEffortDistribution As Boolean
        Dim HaveSubTaskTypes As Boolean
        ' Added By      : NitinVS on 17 Feb 2005 
        ' Issue ID      : 15415
        ' Description   : To Validate for 
        Dim HoursPerDay As Double
        '==============================================================
        ' End Addition By NitinVS on 15 Feb 2005 
        ' PBNITE SP2
        '==============================================================

        ' Added by NitinVS on 28 Feb 2005 
        Dim strQuery As String
        Dim drWork As IDataReader
        'End Addition By NitinVS on 28 Feb 2005 
        'added by Harshk on 25/08/2005 

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''m_strDistributeWorkInAT_CorporateFlag = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("select DistributeWorkInAT from tbl_PM_CompanyInformation", MyBase.UseSQL)), String)
        m_strDistributeWorkInAT_CorporateFlag = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_CompanyInformation_DistributeWorkInAT", MyBase.UseSQL)), String)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        'End added by Harshk on 25/08/2005 m_strDistributeWorkInAT_CorporateFlag
        m_intProjectID = ("" & CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectID")))
        m_ProjectID = m_intProjectID
        m_intTagId = ("" & CommonFunction.General.CheckIsNothing(Request.QueryString("MasterTagID")))
        m_intDeliverableID = ("" & CommonFunction.General.CheckIsNothing(Request.QueryString("DeliverableID")))
        m_intDeliverableTypeID = ("" & CommonFunction.General.CheckIsNothing(Request.QueryString("DeliverableTypeID")))
        m_strQueryString = ("" & CommonFunction.General.CheckIsNothing(Request.QueryString("OtherScheduleQueryString")))
        m_strMode = ("" & CommonFunction.General.CheckIsNothing(Request.QueryString("Mode")))
        m_intSpecificationID = ("" & CommonFunction.General.CheckIsNothing(Request.QueryString("SpecificationID")))
        m_dblTaskEffort = ("" & CommonFunction.General.CheckIsNothing(Request.QueryString("TaskEffort")))
        m_strFromWhere = ("" & CommonFunction.General.CheckIsNothing(Request.QueryString("FromWhere"), "PM"))
        m_strPagingAlphabet = ("" & CommonFunction.General.CheckIsNothing(Request.QueryString("PagingAlphabet")))
        m_strSortBy = ("" & CommonFunction.General.CheckIsNothing(Request.QueryString("SortBy")))
        m_strSortOrder = ("" & CommonFunction.General.CheckIsNothing(Request.QueryString("SortOrder")))
        'Modified By NitinVS on 28 Mar 2007 for WhizibleSEM SP 8 Regression Issue 12359 
        m_strParentTagID = ("" & CommonFunction.General.CheckIsNothing(Request.QueryString("ParentTagID"), "0"))
        If m_strParentTagID = "" Then
            m_strParentTagID = "0"
        End If

        m_strFromCL = ("" & CommonFunction.General.CheckIsNothing(Request.QueryString("FromCL"), "1"))
        If m_strFromCL = "" Then
            m_strFromCL = "1"
        End If

        'end Modification By NitinVS on 28 Mar 2007 for WhizibleSEM SP 8 Regression Issue 12359  

        If m_strMode = "" Then
            m_strMode = "List"
        End If

        If ("" & CommonFunction.General.CheckIsNothing(Request.QueryString("TemplateID"))) = "" Then
            m_intSelectedTemplateID = ""
        Else
            m_intSelectedTemplateID = Request.QueryString("TemplateID")
        End If

        If ("" & CommonFunction.General.CheckIsNothing(Request.QueryString("DateFormat"))) = "" Then
            m_intDateFormat = "1"
        Else
            m_intDateFormat = Request.QueryString("DateFormat")
        End If

        Select Case m_intDateFormat
            Case "1"
                m_strDateFormat = "dd-mm-yyyy"
            Case "2"
                m_strDateFormat = "mm-dd-yyyy"
            Case Else
                m_strDateFormat = "dd-mm-yyyy"
        End Select

        ' Modified By MahendraV On 7:29 PM 6/26/2007
        ' IssueID (14049) :Planned Deliverable : While creating Review through Planned Deliverable only Project resources are displayed in "Reviewer" combo ?
        ' Start_MV_6/26/2007
        ' strSQLQuery = "EXEC usp_Sel_ProjectResources_TaskAssignment_PlanDeliverable " & m_intProjectID

        '''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''m_strTodayDate = fixDateForDisplay(CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.GetDataScalar("SELECT GETDATE()", MyBase.UseSQL), Date)), m_strDateFormat)
        m_strTodayDate = fixDateForDisplay(CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.GetDataScalar("usp_SELECT_GETDATE", MyBase.UseSQL), Date)), m_strDateFormat)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        ' End_MV_6/26/2007
        'This gets the Revision No for the template selected
        If m_intSelectedTemplateID.Trim.ToString <> "" Then
            strSQLQuery = "EXEC usp_Get_TemplateName_Published " & m_intProjectID & "," & m_intSelectedTemplateID
            drTemplateRevision = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            If drTemplateRevision.Read Then
                m_intRevisionNo = CType(CommonFunctions.Data.CheckIsDBNull(drTemplateRevision("ProjectRevisionNo"), "0"), Integer)
            Else
                m_intRevisionNo = 0
            End If
        Else
            m_intRevisionNo = 0
        End If
        CommonFunctions.Data.DisposeDataReader(drTemplateRevision)

        'Added by ShamkantD on 13 Dec 2004
        drProjectInformation = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_Project " & m_intProjectID.ToString(), MyBase.UseSQL)
        If drProjectInformation.Read Then
            m_dblProjectWorkHrs = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drProjectInformation("EstimatedEfforts"), "0"), "0"), Double)
            m_strProjectEndDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drProjectInformation("ExpectedEndDate"), ""), "").ToString()
            '==============================================================
            'Added By       :   HiteshS on 31st Jan.2005
            'IssueID        :   15430
            'Description    :   Variable to hold Assigned Task Hours for a Project
            '==============================================================
            m_dblProjectAssignedTaskHrs = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drProjectInformation("AssignedTaskHours"), "0"), "0"), Double)
            '==============================================================
            'End Of Addition By HiteshS on 31st Jan.2005
            '==============================================================

            '==============================================================
            'Added By       :   NitinVS on 23 Mar 2005 
            'IssueID        :   16984 
            'Description    :   Project Start Date validation is not applicable to task for plan deliverable
            '                   Variable to hold Project Start Date 
            'version        :   PBNITE SP2 
            '==============================================================
            m_strProjectStartDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drProjectInformation("ExpectedStartDate"), ""), "").ToString()
            '==============================================================
            'End Of Addition By NitinVS on 23 Mar 2005 issueID 16984
            '==============================================================

        End If
        CommonFunction.Data.DisposeDataReader(drProjectInformation)
        'End of addition - ShamkantD on 13 Dec 2004

        ' Added By NitinVS on 28 Feb 2005 
        ' to alert the user for Maximum work hours per day for Organization Unit 
        'Get the WeekDays and Hours Per Day
        strQuery = "Exec usp_Get_ProjectLocationWorkingHours_Days " & m_intProjectID.ToString()
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                m_dblHoursPerDay = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("WorkingHours"), "0"), Double)
                m_lngWeekDays = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("WorkingDays"), "0"), Long)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)
        ' End Addition By NitinVS on 28 Feb 2005 


        '********** Get labels for all the fields ***********

        '''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQLQuery = "SELECT * FROM tbl_CNF_ScheduleFieldConfig WHERE ScheduleTypeID = " & m_intDeliverableTypeID
        strSQLQuery = "usp_sel_tbl_CNF_ScheduleFieldConfig_ScheduleTypeIDWise " & m_intDeliverableTypeID
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        drFieldLables = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        While drFieldLables.Read
            Select Case CType(CommonFunction.Data.CheckIsDBNull(drFieldLables("FieldName"), ""), String)
                Case "Document No"
                    m_strlblDocNo = CType(CommonFunction.Data.CheckIsDBNull(drFieldLables("Label"), ""), String)
                Case "Title"
                    m_strlblTitle = CType(CommonFunction.Data.CheckIsDBNull(drFieldLables("Label"), ""), String)
                Case "Scheduled Start Date"
                    m_strlblStartDate = CType(CommonFunction.Data.CheckIsDBNull(drFieldLables("Label"), ""), String)
                Case "Earliest Completion Date"
                    m_strlblEarliestDate = CType(CommonFunction.Data.CheckIsDBNull(drFieldLables("Label"), ""), String)
                Case "Latest Completion Date"
                    m_strlblLatestDate = CType(CommonFunction.Data.CheckIsDBNull(drFieldLables("Label"), ""), String)
                Case "Efforts"
                    m_strlblLCE = CType(CommonFunction.Data.CheckIsDBNull(drFieldLables("Label"), ""), String)
            End Select

            If CType(CommonFunction.Data.CheckIsDBNull(drFieldLables("Applicable"), ""), String).Trim = "True" Then
                m_strFieldApplicable = m_strFieldApplicable & CType(CommonFunction.Data.CheckIsDBNull(drFieldLables("FieldName"), ""), String) & ","
            End If

            If CType(CommonFunction.Data.CheckIsDBNull(drFieldLables("Mandatory"), ""), String).Trim = "True" Then
                m_strFieldMandatory = m_strFieldMandatory & CType(CommonFunction.Data.CheckIsDBNull(drFieldLables("FieldName"), ""), String) & ","
            End If
        End While
        CommonFunction.Data.DisposeDataReader(drFieldLables)

        'Retrieve the details of the selected Deliverable
        strSQLQuery = "EXEC usp_Sel_DeliverableDetails " & m_intProjectID & ", " & m_intDeliverableID & ", " & m_intDeliverableTypeID
        drSelectedDeliverable = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

        If drSelectedDeliverable.Read Then
            m_dblDeliverableLCE = CType(CommonFunction.Data.CheckIsDBNull(drSelectedDeliverable("DeliverableLCE"), "0"), Double)
            m_dtStartDate = CType(CommonFunction.Data.CheckIsDBNull(drSelectedDeliverable("ScheduledStartDate"), ""), String)
            m_dtEndDate = CType(CommonFunction.Data.CheckIsDBNull(drSelectedDeliverable("EarliestSchCompDate"), ""), String)
            m_strStudyTitle = CType(CommonFunction.Data.CheckIsDBNull(drSelectedDeliverable("StudyTitle"), ""), String)

            ''Added By Usha Pandit on 22-Feb-2019 Purpose::Project Work field level changes 
            m_strWorkHourMinute = CType(CommonFunction.Data.CheckIsDBNull(drSelectedDeliverable("WorkHourMinute"), ""), String)
            ''End of Added By Usha Pandit on 22-Feb-2019 Purpose::Project Work field level changes 
        End If
        CommonFunction.Data.DisposeDataReader(drSelectedDeliverable)

        If m_strMode = "Save" Then
            '==============================================================
            ' Project       :   PBNITE SP2
            'Added By       :   NitinVS on 16 Feb 2005
            'Description    :   To Implement task level Planning 
            '==============================================================

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSQL = "SELECT HaveSubTaskTypes FROM tbl_PM_Project WHERE ProjectID = " + CType(m_intProjectID, String)
            strSQL = "usp_sel_tbl_PM_Project_HaveSubTaskTypes " + CType(m_intProjectID, String)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            ObjDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

            If ObjDr.Read Then
                HaveSubTaskTypes = CType(CommonFunction.Data.CheckIsDBNull(ObjDr("HaveSubTaskTypes"), "False"), Boolean)
            End If

            'Added BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452
            CommonFunction.Data.DisposeDataReader(ObjDr)
            'End Addition By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452
            If HaveSubTaskTypes = True Then
                CreateTasks()
            Else
                CreateTaskWithoutSubTask()
            End If
            '==============================================================
            ' End Addition By NitinVS on 15 Feb 2005 
            '==============================================================

        End If

        '---------------------------------------------------------------------
        ' DRAW PAGE
        '---------------------------------------------------------------------
        DrawMenu(False)

        'added by SachinR   on 06 Nov 2004
        'Display the (* Mandatory) PageLegends 
        Dim strarrLegend() As String = {"Mandatory"}
        Dim strarrLegendImage() As String = {"<img src='../../images/star.gif'>"}
        CommonFunctions.General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, strarrLegendImage, strarrLegend) + vbCrLf)
        'addition end

        ShowPageHeader()

        '==============================================================
        ' Project       :   PBNITE SP2
        'Added By       :   NitinVS on 16 Feb 2005
        'Description    :   To Implement task level Planning 
        '==============================================================

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQL = "SELECT HaveSubTaskTypes FROM tbl_PM_Project WHERE ProjectID = " + CType(m_intProjectID, String)
        strSQL = "usp_sel_tbl_PM_Project_HaveSubTaskTypes " + CType(m_intProjectID, String)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        ObjDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        If ObjDr.Read Then
            HaveSubTaskTypes = CType(CommonFunction.Data.CheckIsDBNull(ObjDr("HaveSubTaskTypes"), "False"), Boolean)
        End If
        'Added BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452
        CommonFunction.Data.DisposeDataReader(ObjDr)
        'End Addition By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452

        'Added by HarshK for whiziblesem sp4 issueid 120,121 
        strSQL = "EXEC usp_Sel_Project_Resources_ExpectedDates_AsPer_Role " & m_intProjectID & ",0 "
        CommonFunction.HTMLControls.DrawComboBox("cboResourceStartDates", strSQL, 200, , , , , , , , True)
        strSQL = "EXEC usp_Sel_Project_Resources_ExpectedDates_AsPer_Role " & m_intProjectID & ",1 "
        CommonFunction.HTMLControls.DrawComboBox("cboResourceEndDates", strSQL, 200, , , , , , , , True)
        'END 'Added by HarshK for whiziblesem sp4 issueid 120,121 
        If HaveSubTaskTypes = True Then
            m_IsSubTaskApplicable = 1
            DrawGrid()
        Else
            m_IsSubTaskApplicable = 0
            DrawGridForTask()
        End If
        '==============================================================
        ' End Modification By NitinVS on 15 Feb 2005 
        '==============================================================



        ShowPageFooter()

        DrawMenu(False)

        '---------------------------------------------------------------------
        ' END - DRAW PAGE
        '---------------------------------------------------------------------
        'AddedBY HarshK for sp4 IssueID 120,121 on 06/10/2005

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''Dim strQuery2 As String = "select IsNull(ResourceValidation,0) from tbl_PM_Project WHERE ProjectID = " & m_intProjectID.ToString
        Dim strQuery2 As String = "usp_sel_tbl_PM_Project_ResourceValidation_IsNull " & m_intProjectID.ToString
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        If CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery2, MyBase.UseSQL), "True"), Boolean) = True Then
            m_bitResourceValidation = 1
        Else
            m_bitResourceValidation = 0
        End If
        'End AddedBY HarshK for sp4 IssueID 120,121 on 06/10/2005
    End Sub
#End Region

#Region " Plots the Menu "
    Private Sub DrawMenu(Optional ByVal blnShowPaging As Boolean = True)
        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : To plot the Menu on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ShamkantD
        ' Created               : Aug 25, 2004
        ' Revisions             :
        '=====================================================================

        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML
        Dim objPaging As WebPage.Templates.Paging
        Dim strPagingHTML As String

        m_objMenu = New WebPages.Template.StaticMenu

        'arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CREATE_TASKS"))
        ' Added by MahendraV On 6:13 PM 6/29/2007 For WhizibleSEM 7
        ' Hide 'Save' link on its click for static menu (avoid duplicate entries)
        ' Start_MV_6/29/2007
        arrMenuCaptionsList.Add("" + MyBase.GetResourceString("MENU_CREATE_TASKS") + "")
        arrMenuCaptionsList.Add("" + MyBase.GetResourceString("MENU_CLOSE") + "")
        arrMenuCaptionsList.Add("" + MyBase.GetResourceString("MENU_HELP") + "")
        ' End_MV_6/29/2007
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CREATE_TASKS_TOOLTIP"))
        arrClientSideFunctionList.Add("CreateAssignedTasks_OnClick()")

        'arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
        arrClientSideFunctionList.Add("Close_OnClick()")

        'arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        arrClientSideFunctionList.Add("Help_OnClick('2133')")

        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)

        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu)
    End Sub
#End Region

#Region " Generic Functions "
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
        ' Author                : ShamkantD
        ' Created               : Aug 25, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements
    End Function

    ''Added By Dipali  V On 29th April 2020 For Convert Decimal to HH:MM
    <System.Web.Services.WebMethod()>
    Public Shared Function ConvertDecimalToHourViceVersa(ByVal WorkHrs As String, ByVal Flag As String) As String
        Try
            Dim fltHours As String

            fltHours = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + WorkHrs + "', '" + Flag + "')", True)

            Return fltHours.ToString()

        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of Added By Usha Pandit on 05-April-2019 Purpose::Whizible 2 Work field change

    ''Added By Usha Pandit on 05-April-2019 Purpose::Whizible 2 Work field change
    <System.Web.Services.WebMethod()>
    Public Shared Function getDecimalHours(ByVal HMHours As String) As String
        Try
            Dim fltHours As Decimal

            ''Added By Usha Pandit on 15-Mar-2019 Purpose::Project Work field level changes 
            If HMHours = "0" Or HMHours = "" Then
                HMHours = "00:00"
            End If

            If HMHours.IndexOf(":") = HMHours.Length - 1 Then
                HMHours = HMHours + "00"
            End If

            Dim strDecimal As String = ""
            Dim strBeforeDecimal As String = ""
            strBeforeDecimal = HMHours.Substring(0, HMHours.IndexOf(":"))
            strDecimal = HMHours.Substring(HMHours.IndexOf(":") + 1, 2)
            HMHours = strBeforeDecimal + ":" + strDecimal
            ''End of Added By Usha Pandit on 15-Mar-2019 Purpose::Project Work field level changes 

            fltHours = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + HMHours + "', 2)", True)

            Return fltHours.ToString()

        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of Added By Usha Pandit on 05-April-2019 Purpose::Whizible 2 Work field change





    Function fixDateForSave(ByVal strInDate As String, ByVal format As String) As String
        Dim d As String, m As String, y As String
        Dim dtDate As Date
        Dim strDate As String = CommonFunction.General.CheckIsNothing(strInDate, "").ToString.Trim
        Dim strDay As String = "0"
        Dim strMonth As String = "0"
        Dim strCMonth As String = ""
        Dim strYear As String = ""
        Dim intPosSep As Integer = 0
        Dim strOutDate As String = ""
        Dim strMonthname(11) As String
        strMonthname(0) = "Jan" : strMonthname(1) = "Feb" : strMonthname(2) = "Mar"
        strMonthname(3) = "Apr" : strMonthname(4) = "May" : strMonthname(5) = "Jun"
        strMonthname(6) = "Jul" : strMonthname(7) = "Aug" : strMonthname(8) = "Sep"
        strMonthname(9) = "Oct" : strMonthname(10) = "Nov" : strMonthname(11) = "Dec"


        strInDate = CommonFunction.General.CheckIsNothing(strInDate, "").ToString.Trim
        format = CommonFunction.General.CheckIsNothing(format, "DD/MM/YYYY").ToString.ToUpper.Trim

        If strInDate = "" Then
            fixDateForSave = ""
            Exit Function
        End If

        If Replace(format, "-", "/") = "DD/MM/YYYY" Then
            strDate = Replace(strDate, "-", "/")
            intPosSep = strDate.IndexOf("/")

            strDay = Mid(strDate, 1, intPosSep)
            strDate = Mid(strDate, intPosSep + 2, (strDate.Length - (intPosSep + 1)))

            intPosSep = strDate.IndexOf("/")
            strMonth = Mid(strDate, 1, intPosSep)
            strYear = Mid(strDate, intPosSep + 2, (strDate.Length - (intPosSep + 1)))
        End If

        If Replace(format, "-", "/") = "MM/DD/YYYY" Then
            strDate = Replace(strDate, "-", "/")

            intPosSep = strDate.IndexOf("/")
            strMonth = Mid(strDate, 1, intPosSep)

            strDate = Mid(strDate, intPosSep + 2, (strDate.Length - (intPosSep + 1)))

            intPosSep = strDate.IndexOf("/")
            strDay = Mid(strDate, 1, intPosSep)

            strYear = Mid(strDate, intPosSep + 2, (strDate.Length - (intPosSep + 1)))
        End If

        strCMonth = strMonthname(CType(CommonFunction.General.CheckIsNothing(strMonth, "1"), Integer) - 1)
        strDate = strDay & "-" & strCMonth & "-" & strYear

        strOutDate = strDate
        Return CommonFunction.General.CheckIsNothing(strOutDate, "")

    End Function

    Function fixDateForDisplay(ByVal strInDate As String, ByVal format As String) As String
        Dim d As String, m As String, y As String
        Dim strDate As Date

        If strInDate = "" Then
            fixDateForDisplay = ""
            Exit Function
        End If

        strDate = CType(strInDate, Date)

        d = CType(DatePart("D", strDate), String)
        m = CType(DatePart("M", strDate), String)
        y = CType(DatePart("YYYY", strDate), String)

        If Len(d) < 2 Then d = "0" & d
        If Len(m) < 2 Then m = "0" & m

        Select Case format
            Case "yyyy/mm/dd"
                fixDateForDisplay = y & "/" & m & "/" & d
            Case "yy/mm/dd"
                fixDateForDisplay = Right(y, 2) & "/" & m & "/" & d
            Case "dd/mm/yy"
                fixDateForDisplay = d & "/" & m & "/" & Right(y, 2)
            Case "dd/mm/yyyy"
                fixDateForDisplay = d & "/" & m & "/" & y
            Case "yyyy-mm-dd"
                fixDateForDisplay = y & "-" & m & "-" & d
            Case "yy-mm-dd"
                fixDateForDisplay = Right(y, 2) & "-" & m & "-" & d
            Case "dd-mm-yy"
                fixDateForDisplay = d & "-" & m & "-" & Right(y, 2)
            Case "dd-mm-yyyy"
                fixDateForDisplay = d & "-" & m & "-" & y
            Case "mm-dd-yyyy"
                fixDateForDisplay = m & "-" & d & "-" & y
            Case "ddmmyyyy"
                fixDateForDisplay = d & m & y
            Case "ddmmyy"
                fixDateForDisplay = d & m & Right(y, 2)
            Case "mmddyy"
                fixDateForDisplay = m & d & Right(y, 2)
            Case "mmddyyyy"
                fixDateForDisplay = m & d & y
            Case "yyyymmdd"
                fixDateForDisplay = y & m & d
            Case "yymmdd"
                fixDateForDisplay = Right(y, 2) & m & d
            Case "yyyy"
                fixDateForDisplay = y
            Case "Short"
                fixDateForDisplay = FormatDateTime(strDate, vbShortDate)
            Case "Long"
                fixDateForDisplay = FormatDateTime(strDate, vbLongDate)
            Case "dd-Month-yyyy"
                m = MonthName(CType(m, Integer), True)
                fixDateForDisplay = d & "-" & m & "-" & y
            Case "dd-Month-yy"
                m = MonthName(CType(m, Integer), True)
                fixDateForDisplay = d & "-" & m & "-" & Right(y, 2)
            Case "DayName"
                fixDateForDisplay = WeekdayName(Weekday(strDate), False)
            Case "DayNameAbbr"
                fixDateForDisplay = WeekdayName(Weekday(strDate), True)
            Case Else
                fixDateForDisplay = d & "/" & m & "/" & y
        End Select

    End Function
    Private Sub CreateTasks()
        Dim strSelectedResources As String
        Dim dblEffort As String
        Dim dblRevieweeEffort As String
        Dim intCnt As Integer
        Dim intTotalCnt As Integer
        Dim dtStDt As String
        Dim dtEndDt As String
        Dim strFromEmailID As String
        Dim strToMailID As String
        Dim strCCToMailID As String
        Dim strSubject As String, strMessage As String
        Dim strToEmailID As String, strCCToEmailID As String, strEmailMessage As String
        Dim drResources As IDataReader
        Dim strEmpListSQL As String
        Dim drEmailMessage As IDataReader, blnSendEmail As Boolean, blnShowPopup As Boolean
        Dim strParentTaskIDs As String, strEmployeeID As String
        Dim drCreateTasksOutput As IDataReader
        Dim intEstimationTypeID As String, intPhaseID As String
        Dim intModuleID As String, intSubProjectID As String
        Dim intMilestoneID As String, intChangeRequestID As String
        Dim intProjectFeatureID As String
        Dim strTaskNotes As String, strPriority As String
        'Modified By                     MahendraV on 2:38 PM 6/11/2007
        'Description                     To Hold the value of Is Fast Track Review
        '==============================================================
        Dim blnIsFTR As Boolean
        Dim blnIsOffline As Boolean
        '==============================================================
        'End of Modification By MahendraV on 6/11/2007
        '==============================================================

        strSQLQuery = "SELECT DISTINCT ProjectPhaseTaskTemplateID FROM tbl_PM_Project_PhaseTask_Template WHERE TemplateId = " & m_intSelectedTemplateID & " AND ProjectID = " & m_intProjectID
        'MODIFIED BY VidyaJ on 26th May 2005
        m_intProjectPhaseTaskTemplateID = m_intSelectedTemplateID 'CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "").ToString

        strSQLQuery = "DELETE FROM tbl_PM_Tasks_For_Deliverable WHERE ProjectID = " & m_intProjectID
        CommonFunction.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL)

        strSQLQuery = " INSERT INTO tbl_PM_Tasks_For_Deliverable( "
        'Modified By                     MahendraV on 2:38 PM 6/11/2007
        'Description                     To Hold the value of Is Fast Track Review
        '==============================================================
        strSQLQuery += "ProjectID,TemplateID,RevisionNo,PhaseTaskID,PhaseTaskName,ActivityID,ActivityTitle,Effort,RevieweeEffort,RoleID,"
        strSQLQuery += "RoleDescription,ResourceID,ActivityOrderNo,PhaseTaskOrderNo,Duration,TaskTypeID,ReviewActivity,ReviewID,"
        strSQLQuery += "PercentageEffortDistribution,ProjectPhaseTaskActivityID,StartDate,EndDate,IsMandatory,TaskNotes,Priority,"
        strSQLQuery += "ProjectEstimationTypeID,PhaseID,ModuleID,SubProjectID,MilestoneID,ChangeRequestID,ProjectFeatureID "
        '==============================================================
        'End of Modification By MahendraV on 6/11/2007
        '==============================================================
        '
        'Added By Amit J On   22/6/2007 for WhizibleSEM9 SP1 HotFix 9.0.026 
        strSQLQuery += ", ReviewTask, ReviewTypeId)"
        'End Of Addition By AmitJ
        strSQLQuery += " EXEC usp_Sel_Deliverable_Template_Role_Resource "

        strSQLQuery += m_intProjectID & ", " & m_intSelectedTemplateID & ", " & m_intDeliverableID & ", " & m_intDeliverableTypeID & "," & m_intRevisionNo
        CommonFunction.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL)

        'Get the effort and the resources changed by the user
        If HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID").Length > 0 Then
            For intCnt = 0 To HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID").Length - 1
                If HttpContext.Current.Request.Form.GetValues("txtReviewActivity")(intCnt) = "True" Then
                    strSelectedResources = HttpContext.Current.Request.Form("cboReviewer" & HttpContext.Current.Request.Form.GetValues("txtProjectPhaseTaskActivityID")(intCnt))
                    strSelectedResources += "," & HttpContext.Current.Request.Form("cboReviewee" & HttpContext.Current.Request.Form.GetValues("txtProjectPhaseTaskActivityID")(intCnt))

                    dblEffort = HttpContext.Current.Request.Form("txtReviewerEffort" & HttpContext.Current.Request.Form.GetValues("txtProjectPhaseTaskActivityID")(intCnt))
                    dblRevieweeEffort = HttpContext.Current.Request.Form("txtRevieweeEffort" & HttpContext.Current.Request.Form.GetValues("txtProjectPhaseTaskActivityID")(intCnt))

                    If dblEffort = "" Then
                        dblEffort = "0"
                    End If
                    If dblRevieweeEffort = "" Then
                        dblRevieweeEffort = "0"
                    End If
                Else
                    strSelectedResources = HttpContext.Current.Request.Form("cboResource" & HttpContext.Current.Request.Form.GetValues("txtProjectPhaseTaskActivityID")(intCnt))
                    dblEffort = HttpContext.Current.Request.Form("txtEffort" & HttpContext.Current.Request.Form.GetValues("txtProjectPhaseTaskActivityID")(intCnt))
                    dblRevieweeEffort = "0"
                End If

                dtStDt = Request("txtStartDate" & HttpContext.Current.Request.Form.GetValues("txtProjectPhaseTaskActivityID")(intCnt))
                dtEndDt = Request("txtEndDate" & HttpContext.Current.Request.Form.GetValues("txtProjectPhaseTaskActivityID")(intCnt))
                dtStDt = fixDateForSave(dtStDt, m_strDateFormat)
                dtEndDt = fixDateForSave(dtEndDt, m_strDateFormat)

                strPriority = Request("txtPriority" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))
                intEstimationTypeID = Request("txtEstimationTypeID" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))
                intPhaseID = Request("txtPhaseID" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))
                intModuleID = Request("txtModuleID" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))
                intSubProjectID = Request("txtSubProjectID" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))
                intMilestoneID = Request("txtMilestoneID" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))
                intChangeRequestID = Request("txtChangeRequestID" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))
                intProjectFeatureID = Request("txtFeatureID" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))

                '==============================================================
                'Modified By                     MahendraV on PM 2:38 PM 6/11/2007
                'Description                     To Hold the value of Is Fast Track Review
                '==============================================================
                If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("IsFTR" & HttpContext.Current.Request.Form.GetValues("txtProjectPhaseTaskActivityID")(intCnt))) <> "" Then
                    blnIsFTR = True
                Else
                    blnIsFTR = False
                End If
                If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("IsOffline" & HttpContext.Current.Request.Form.GetValues("txtProjectPhaseTaskActivityID")(intCnt))) <> "" Then
                    blnIsOffline = True
                Else
                    blnIsOffline = False
                End If
                '==============================================================
                'End of Modification By MahendraV on  6/11/2007
                '==============================================================

                strTaskNotes = Request("txtPhaseTaskNotes" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))

                strSQLQuery = "UPDATE tbl_PM_Tasks_For_Deliverable SET Effort = " & dblEffort & " , RevieweeEffort = " & dblRevieweeEffort
                strSQLQuery = strSQLQuery & ", ResourceID = '" & strSelectedResources & "'"
                'Allows the user to specify the Start and End Date for the Task to be created
                strSQLQuery &= " , StartDate = '" & dtStDt & "'"
                strSQLQuery &= " , EndDate = '" & dtEndDt & "'"
                strSQLQuery &= " , Priority = '" & strPriority & "'"
                strSQLQuery &= IIf(intEstimationTypeID.Trim <> "", " , ProjectEstimationTypeID = " & intEstimationTypeID, "").ToString()
                strSQLQuery &= IIf(intPhaseID.Trim <> "", " , PhaseID = " & intPhaseID, "").ToString()
                strSQLQuery &= IIf(intModuleID.Trim <> "", " , ModuleID = " & intModuleID, "").ToString()
                strSQLQuery &= IIf(intSubProjectID.Trim <> "", " , SubProjectID = " & intSubProjectID, "").ToString()
                strSQLQuery &= IIf(intMilestoneID.Trim <> "", " , MilestoneID = " & intMilestoneID, "").ToString()
                strSQLQuery &= IIf(intChangeRequestID.Trim <> "", " , ChangeRequestID = " & intChangeRequestID, "").ToString()
                strSQLQuery &= IIf(intProjectFeatureID.Trim <> "", " , ProjectFeatureID = " & intProjectFeatureID, "").ToString()
                strSQLQuery &= " , TaskNotes = '" & strTaskNotes & "'"

                '==============================================================
                'Modified By                     MahendraV on PM 2:44 PM 6/11/2007
                'Description                     To Hold the value of Is Fast Track Review
                '==============================================================
                If blnIsFTR = True Then
                    strSQLQuery &= " , IsFastTrackReview = 1 "
                Else
                    strSQLQuery &= " , IsFastTrackReview = 0 "
                End If
                If blnIsOffline = True Then
                    strSQLQuery &= " , IsOfflineReview = 1 "
                Else
                    strSQLQuery &= " , IsOfflineReview = 0 "
                End If
                '==============================================================
                'End of Modification By MahendraV on 6/11/2007
                '==============================================================


                strSQLQuery &= " WHERE ProjectID = " & m_intProjectID & " AND TemplateID = " & m_intProjectPhaseTaskTemplateID
                strSQLQuery &= " AND PhaseTaskID = " & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt)
                strSQLQuery &= " AND ActivityID = " & HttpContext.Current.Request.Form.GetValues("txtActivityID")(intCnt)
                strSQLQuery &= " AND ProjectPhaseTaskActivityID = " & HttpContext.Current.Request.Form.GetValues("txtProjectPhaseTaskActivityID")(intCnt)

                CommonFunction.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL)
            Next
        Else
            If HttpContext.Current.Request.Form("txtReviewActivity") = "True" Then
                strSelectedResources = HttpContext.Current.Request.Form("cboReviewer" & HttpContext.Current.Request.Form("txtProjectPhaseTaskActivityID"))
                strSelectedResources = strSelectedResources & "," & HttpContext.Current.Request.Form("cboReviewee" & HttpContext.Current.Request.Form("txtProjectPhaseTaskActivityID"))

                dblEffort = HttpContext.Current.Request.Form("txtReviewerEffort" & HttpContext.Current.Request.Form("txtProjectPhaseTaskActivityID"))
                dblRevieweeEffort = HttpContext.Current.Request.Form("txtRevieweeEffort" & HttpContext.Current.Request.Form("txtProjectPhaseTaskActivityID"))
            Else
                strSelectedResources = HttpContext.Current.Request.Form("cboResource" & HttpContext.Current.Request.Form("txtProjectPhaseTaskActivityID"))
                dblEffort = HttpContext.Current.Request.Form("txtEffort" & HttpContext.Current.Request.Form("txtProjectPhaseTaskActivityID"))
                dblRevieweeEffort = "0"
            End If

            strSQLQuery = "UPDATE tbl_PM_Tasks_For_Deliverable SET Effort = " & dblEffort & " , RevieweeEffort = " & dblRevieweeEffort
            strSQLQuery = strSQLQuery & ", ResourceID = '" & strSelectedResources & "'"

            '==============================================================
            'Modified By                     MahendraV on PM 2:44 PM 6/11/2007
            'Description                     To Hold the value of Is Fast Track Review
            '==============================================================
            If blnIsFTR = True Then
                strSQLQuery &= " , IsFastTrackReview = 1 "
            Else
                strSQLQuery &= " , IsFastTrackReview = 0 "
            End If
            If blnIsOffline = True Then
                strSQLQuery &= " , IsOfflineReview = 1 "
            Else
                strSQLQuery &= " , IsOfflineReview = 0 "
            End If
            '==============================================================
            'End of Modification By MahendraV on 6/11/2007
            '==============================================================
            'Allows the user to specify the Start and End Date for the Task to be created
            strSQLQuery &= " , StartDate = '" & fixDateForSave(HttpContext.Current.Request.Form("txtStartDate" & HttpContext.Current.Request.Form("txtProjectPhaseTaskActivityID")), m_strDateFormat) & "'"
            strSQLQuery &= " , EndDate = '" & fixDateForSave(HttpContext.Current.Request.Form("txtEndDate" & HttpContext.Current.Request.Form("txtProjectPhaseTaskActivityID")), m_strDateFormat) & "'"

            strSQLQuery &= " WHERE ProjectID = " & m_intProjectID & " AND TemplateID = " & m_intProjectPhaseTaskTemplateID
            strSQLQuery &= " AND PhaseTaskID = " & HttpContext.Current.Request.Form("txtPhaseTaskID")
            strSQLQuery &= " AND ActivityID = " & HttpContext.Current.Request.Form("txtActivityID")
            strSQLQuery &= " AND ProjectPhaseTaskActivityID = " & HttpContext.Current.Request.Form("txtProjectPhaseTaskActivityID")

            CommonFunction.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL)
        End If

        'Added by ShamkantD on 3 Dec 2004
        'Modification done for Issue ID: 14155 (Plan Deliverables - Tasks with 0 efforts should not be created)
        'Tasks with 0 efforts should not be created
        'Also, Tasks for which no resources are selected also should not be generated
        strSQLQuery = "DELETE FROM tbl_PM_Tasks_For_Deliverable WHERE ProjectID = " & m_intProjectID _
            & " AND (Effort = 0 OR ISNULL(ResourceID, '') = '')"
        CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
        'End of addition - ShamkantD on 3 Dec 2004

        If m_dblTaskEffort.Trim = "" Then
            m_dblTaskEffort = "0"
        End If

        strSQLQuery = "EXEC usp_Ins_Create_Tasks_For_Deliverable " & m_intProjectID & "," & Request.Form("cboTemplate") & "," & m_intRevisionNo
        strSQLQuery &= ", " & m_intDeliverableID & "," & m_intDeliverableTypeID
        strSQLQuery &= ",'" & HttpContext.Current.Session("strUserName").ToString & "'," & m_dblTaskEffort

        drCreateTasksOutput = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        strEmpListSQL = ""
        While drCreateTasksOutput.Read
            If drCreateTasksOutput.GetName(0).ToString.Trim.ToUpper = "RESOURCELISTSQL" Then
                strEmpListSQL = CType(CommonFunction.Data.CheckIsDBNull(drCreateTasksOutput("ResourceListSQL"), ""), String)
                Exit While
            End If
            drCreateTasksOutput.NextResult()
        End While

        CommonFunction.Data.DisposeDataReader(drCreateTasksOutput)

        strSQLQuery = "EXEC usp_upd_tbl_PM_OtherSchedules_TemplateRevision " & m_intDeliverableID & "," & m_intDeliverableTypeID
        strSQLQuery = strSQLQuery & "," & m_intProjectPhaseTaskTemplateID & "," & m_intRevisionNo
        CommonFunction.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL)

        'Send email to the resources for generated tasks

        If strEmpListSQL.Trim <> "" Then
            drResources = CommonFunction.Data.GetDataReader(strEmpListSQL, MyBase.UseSQL)
        End If

        drEmailMessage = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_EmailMessages 79", MyBase.UseSQL)

        If drEmailMessage.Read Then
            blnSendEmail = CType(CommonFunctions.Data.CheckIsDBNull(drEmailMessage("SendMail"), "0"), Boolean)
            blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(drEmailMessage("ShowPopup"), "0"), Boolean)
        End If

        If blnSendEmail Then
            If blnShowPopup Then
                While drResources.Read
                    strEmployeeID = CType(CommonFunctions.Data.CheckIsDBNull(drResources("EmployeeID"), ""), String)
                    strParentTaskIDs = CType(CommonFunctions.Data.CheckIsDBNull(drResources("ParentTaskID"), ""), String)

                    CommonFunction.General.WriteHTML("<script language=javascript>")
                    'Added & commented by dipali V On New Mail Pop
                    'CommonFunction.General.WriteHTML("window.open (""../General/SendEmail.aspx?MessageID=79&EmployeeID=" & strEmployeeID & "&ParentTaskID=" & strParentTaskIDs & "&Title=" & m_strStudyTitle & """, ""_blank"", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                    CommonFunction.General.WriteHTML("window.open (""../NewAPI/Email/SendEmail.aspx?MessageID=79&EmployeeID=" & strEmployeeID & "&ProjectID=" & m_intProjectID & "&ParentTaskID=" & strParentTaskIDs & "&Title=" & m_strStudyTitle & """, ""_blank"", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                    'End of Added & commented by dipali V On New Mail Pop_Up
                    CommonFunction.General.WriteHTML("</script>")
                End While
            Else
                While drResources.Read
                    strEmployeeID = CType(CommonFunctions.Data.CheckIsDBNull(drResources("EmployeeID"), ""), String)
                    strParentTaskIDs = CType(CommonFunctions.Data.CheckIsDBNull(drResources("ParentTaskID"), ""), String)

                    'silent mail
                    CommonFunction.EmailMessages.PMMessages.GetEmailMessage_79(strEmployeeID, strParentTaskIDs, strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, m_strStudyTitle)
                    CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                End While
            End If
        End If

        '' START : Commented & Modified By ParagD On 12-Sept-2006
        '' Purpose : WhizibleSEM SP7 Issue : Refresh Parent page.

        m_strParentURL = "CommonPage.aspx?" &
        "ScheduleID_PK=" & m_intDeliverableID.Trim &
        "&MasterTagID=" & m_intTagId.Trim &
        "&FromWhere=" & m_strFromWhere.Trim &
        "&PagingAlphabet=" & m_strPagingAlphabet.Trim &
        "&SortBy=" & m_strSortBy.Trim &
        "&SortOrder=" & m_strSortOrder.Trim &
        "&ParentTagID=" & m_strParentTagID.Trim &
        "&FromCL=" & m_strFromCL.Trim & ""

        CommonFunction.General.WriteHTML("<script language=""javascript"">")
        CommonFunction.General.WriteHTML("alert(""Selected Tasks successfully created for the Deliverable"");")
        CommonFunction.General.WriteHTML("window.close();")
        CommonFunction.General.WriteHTML("refreshParent('frmCommonPage','CommonPage.aspx', '" + m_strParentURL + "' ,true);")

        ''Added by PrashantSJ on 14th July 2009 Purpose: to refersh deliverable planning Gantt chart page
        CommonFunction.General.WriteHTML("refreshParent('frmWBS_GanttChartView','WBS_GanttChartView.aspx', '../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038' ,true);")
        ''End of addition by PrashantSJ on 14th July 2009 Purpose: to refersh deliverable planning Gantt chart page

        '' END : Commented & Modified By ParagD On 12-Sept-2006

        CommonFunction.General.WriteHTML("</script>")

        CommonFunctions.Data.DisposeDataReader(drEmailMessage)
        CommonFunction.Data.DisposeDataReader(drResources)

    End Sub

    Private Sub CreateTaskWithoutSubTask()
        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : To Save the Task for main task only 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : 16 Feb 2005 
        ' Revisions             : By NitinVS on 3 Oct 2006 for WhizibleSEM 7.0 IssueID 6452
        '                         Replaced strSQLQuery With String Builder 
        '=====================================================================
        Dim strSelectedResources As String
        Dim dblEffort As String
        Dim dblRevieweeEffort As String
        Dim intCnt As Integer
        Dim intTotalCnt As Integer
        Dim dtStDt As String
        Dim dtEndDt As String
        Dim strFromEmailID As String
        Dim strToMailID As String
        Dim strCCToMailID As String
        Dim strSubject As String, strMessage As String
        Dim strToEmailID As String, strCCToEmailID As String, strEmailMessage As String
        Dim drResources As IDataReader
        Dim strEmpListSQL As String
        Dim drEmailMessage As IDataReader, blnSendEmail As Boolean, blnShowPopup As Boolean
        Dim strParentTaskIDs As String, strEmployeeID As String
        Dim drCreateTasksOutput As IDataReader
        Dim intEstimationTypeID As String, intPhaseID As String
        Dim intModuleID As String, intSubProjectID As String
        Dim intMilestoneID As String, intChangeRequestID As String
        Dim intProjectFeatureID As String
        Dim strTaskNotes As String, strPriority As String
        Dim objDr As IDataReader
        Dim StrSQL As String
        Dim intApplyEffortDistribution As Boolean
        Dim sbSQL As New System.Text.StringBuilder

        'Modified By                     MahendraV on 3:15 PM 6/6/2007
        'Description                     To Hold the value of Is Fast Track Review
        '==============================================================
        Dim blnIsFTR As Boolean
        Dim blnIsOffline As Boolean
        '==============================================================
        'End of Modification By MahendraV on 3:15 PM 6/6/2007
        '==============================================================


        'Modified By VidyaJ - 26th May 2005
        'strSQLQuery = "SELECT DISTINCT ProjectPhaseTaskTemplateID FROM tbl_PM_Project_PhaseTask_Template WHERE TemplateId = " & m_intSelectedTemplateID & " AND ProjectID = " & m_intProjectID
        m_intProjectPhaseTaskTemplateID = m_intSelectedTemplateID 'CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "").ToString
        strSQLQuery = ""
        strSQLQuery = "DELETE FROM tbl_PM_Tasks_For_Deliverable WHERE ProjectID = " & m_intProjectID
        CommonFunction.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL)
        sbSQL.Length = 0

        sbSQL.Append(" INSERT INTO tbl_PM_Tasks_For_Deliverable ")
        sbSQL.Append(" ( ProjectID, TemplateID, RevisionNo, PhaseTaskID, PhaseTaskName, ")
        sbSQL.Append(" Effort , RoleID,	RoleDescription , ResourceID , PhaseTaskOrderNo	, ")
        sbSQL.Append(" Duration , TaskTypeID	, PercentageEffortDistribution	, StartDate , EndDate , ")
        sbSQL.Append("IsMandatory , TaskNotes	, Priority , ProjectEstimationTypeID , PhaseID , ")
        sbSQL.Append(" ModuleID , SubProjectID , MilestoneID , ChangeRequestID , ProjectFeatureID ")

        'Added By MahendraV On  3:18 PM 6/6/2007 for Review information
        sbSQL.Append(", ReviewTask, ReviewTypeId)")
        'End Of Addition By MahendraV

        sbSQL.Append(" EXEC usp_Sel_Deliverable_Template_Role_Resource_Tasks ")
        sbSQL.Append(m_intProjectID & ", " & m_intSelectedTemplateID & ", " & m_intDeliverableID & ", " & m_intDeliverableTypeID & "," & m_intRevisionNo)
        CommonFunction.Data.GetDataScalar(sbSQL.ToString, MyBase.UseSQL)

        'Get the effort and the resources changed by the user
        If HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID").Length > 0 Then
            For intCnt = 0 To HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID").Length - 1

                strSelectedResources = HttpContext.Current.Request.Form("cboResource" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))

                '==============================================================
                'Modified By                     MahendraV on PM 6/6/2007
                'Description                     reviewee and reviewer id should be given in order to create tasks for them if task is review task
                '==============================================================
                'strSelectedResources = HttpContext.Current.Request.Form("cboResource" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))
                If HttpContext.Current.Request.Form.GetValues("txtReviewTask")(intCnt) = "True" Then
                    strSelectedResources = HttpContext.Current.Request.Form("cboReviewer" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))
                    strSelectedResources += ", " + HttpContext.Current.Request.Form("cboReviewee" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))
                Else
                    strSelectedResources = HttpContext.Current.Request.Form("cboResource" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))
                End If
                '==============================================================
                'End of Modification By MahendraV on PM 6/6/2007
                '==============================================================

                ''Commented Added By Usha Pandit on 05-April-2019 Purpose::Whizible 2 Work field change

                'dblEffort = HttpContext.Current.Request.Form("txtEffort" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))
                Dim HMHours As String = HttpContext.Current.Request.Form("txtEffort" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))
                ''HMHours = Convert.ToDecimal(HMHours) 
                If HMHours <> "" And Not HMHours Is Nothing Then
                    If HMHours.IndexOf(":") = -1 Then
                        HMHours = HMHours + ":00"
                    Else

                    End If
                End If
                dblEffort = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + HMHours + "',2)", True)

                    ''End of Added By Usha Pandit on 05-April-2019 Purpose::Whizible 2 Work field change

                    dblRevieweeEffort = "0"

                dtStDt = Request("txtStartDate" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))
                dtEndDt = Request("txtEndDate" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))
                dtStDt = fixDateForSave(dtStDt, m_strDateFormat)
                dtEndDt = fixDateForSave(dtEndDt, m_strDateFormat)

                strPriority = Request("txtPriority" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))
                intEstimationTypeID = Request("txtEstimationTypeID" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))
                intPhaseID = Request("txtPhaseID" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))
                intModuleID = Request("txtModuleID" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))
                intSubProjectID = Request("txtSubProjectID" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))
                intMilestoneID = Request("txtMilestoneID" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))
                intChangeRequestID = Request("txtChangeRequestID" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))
                intProjectFeatureID = Request("txtFeatureID" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))
                '==============================================================
                'Modified By                     MahendraV on PM 6/6/2007
                'Description                     To Hold the value of Is Fast Track Review
                '==============================================================
                If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("IsFTR" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))) <> "" Then
                    blnIsFTR = True
                Else
                    blnIsFTR = False
                End If
                If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("IsOffline" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))) <> "" Then
                    blnIsOffline = True
                Else
                    blnIsOffline = False
                End If
                '==============================================================
                'End of Modification By MahendraV on  6/6/2007
                '==============================================================


                strTaskNotes = Request("txtPhaseTaskNotes" & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))

                sbSQL.Length = 0

                sbSQL.Append("UPDATE tbl_PM_Tasks_For_Deliverable SET Effort = " & dblEffort)
                sbSQL.Append(", ResourceID = '" & strSelectedResources & "'")
                'Allows the user to specify the Start and End Date for the Task to be created
                sbSQL.Append(" , StartDate = '" & dtStDt & "'")
                sbSQL.Append(" , EndDate = '" & dtEndDt & "'")
                sbSQL.Append(" , Priority = '" & strPriority & "'")
                sbSQL.Append(IIf(intEstimationTypeID.Trim <> "", " , ProjectEstimationTypeID = " & intEstimationTypeID, "").ToString())
                sbSQL.Append(IIf(intPhaseID.Trim <> "", " , PhaseID = " & intPhaseID, "").ToString())
                sbSQL.Append(IIf(intModuleID.Trim <> "", " , ModuleID = " & intModuleID, "").ToString())
                sbSQL.Append(IIf(intSubProjectID.Trim <> "", " , SubProjectID = " & intSubProjectID, "").ToString())
                sbSQL.Append(IIf(intMilestoneID.Trim <> "", " , MilestoneID = " & intMilestoneID, "").ToString())
                sbSQL.Append(IIf(intChangeRequestID.Trim <> "", " , ChangeRequestID = " & intChangeRequestID, "").ToString())
                sbSQL.Append(IIf(intProjectFeatureID.Trim <> "", " , ProjectFeatureID = " & intProjectFeatureID, "").ToString())
                sbSQL.Append(" , TaskNotes = '" & strTaskNotes & "'")

                '==============================================================
                'Modified By                     MahendraV on PM 6/6/2007
                'Description                     To Hold the value of Is Fast Track Review
                '==============================================================
                If blnIsFTR = True Then
                    sbSQL.Append(" , IsFastTrackReview = 1 ")
                Else
                    sbSQL.Append(" , IsFastTrackReview = 0 ")
                End If
                If blnIsOffline = True Then
                    sbSQL.Append(" , IsOfflineReview = 1 ")
                Else
                    sbSQL.Append(" , IsOfflineReview = 0 ")
                End If
                '==============================================================
                'End of Modification By MahendraV on  6/6/2007
                '==============================================================


                sbSQL.Append(" WHERE ProjectID = " & m_intProjectID & " AND TemplateID = " & m_intProjectPhaseTaskTemplateID)
                sbSQL.Append(" AND PhaseTaskID = " & HttpContext.Current.Request.Form.GetValues("txtPhaseTaskID")(intCnt))

                CommonFunction.Data.GetDataScalar(sbSQL.ToString, MyBase.UseSQL)
            Next
        Else
            strSelectedResources = HttpContext.Current.Request.Form("cboResource" & HttpContext.Current.Request.Form("txtProjectPhaseTaskActivityID"))
            dblEffort = HttpContext.Current.Request.Form("txtEffort" & HttpContext.Current.Request.Form("txtProjectPhaseTaskActivityID"))
            dblRevieweeEffort = "0"

            sbSQL.Length = 0
            sbSQL.Append("UPDATE tbl_PM_Tasks_For_Deliverable SET Effort = " & dblEffort)
            sbSQL.Append(", ResourceID = '" & strSelectedResources & "'")

            'Allows the user to specify the Start and End Date for the Task to be created
            sbSQL.Append(" , StartDate = '" & fixDateForSave(HttpContext.Current.Request.Form("txtStartDate" & HttpContext.Current.Request.Form("txtProjectPhaseTaskActivityID")), m_strDateFormat) & "'")
            sbSQL.Append(" , EndDate = '" & fixDateForSave(HttpContext.Current.Request.Form("txtEndDate" & HttpContext.Current.Request.Form("txtProjectPhaseTaskActivityID")), m_strDateFormat) & "'")
            sbSQL.Append(" WHERE ProjectID = " & m_intProjectID & " AND TemplateID = " & m_intProjectPhaseTaskTemplateID)
            sbSQL.Append(" AND PhaseTaskID = " & HttpContext.Current.Request.Form("txtPhaseTaskID"))

            CommonFunction.Data.GetDataScalar(sbSQL.ToString, MyBase.UseSQL)
        End If

        'Added by ShamkantD on 3 Dec 2004
        'Modification done for Issue ID: 14155 (Plan Deliverables - Tasks with 0 efforts should not be created)
        'Tasks with 0 efforts should not be created
        'Also, Tasks for which no resources are selected also should not be generated
        sbSQL.Length = 0
        sbSQL.Append("DELETE FROM tbl_PM_Tasks_For_Deliverable WHERE ProjectID = " & m_intProjectID _
            & " AND (Effort = 0 OR ISNULL(ResourceID, '') = '')")
        CommonFunction.Data.InsertOrUpdateData(sbSQL.ToString, MyBase.UseSQL)
        'End of addition - ShamkantD on 3 Dec 2004

        If m_dblTaskEffort.Trim = "" Then
            m_dblTaskEffort = "0"
        End If

        StrSQL = "SELECT ApplyEffortDistribution FROM tbl_PM_Project WHERE ProjectID = " + CType(m_intProjectID, String)
        objDr = CommonFunction.Data.GetDataReader(StrSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        If objDr.Read Then
            intApplyEffortDistribution = CType(CommonFunction.Data.CheckIsDBNull(objDr("ApplyEffortDistribution"), "False"), Boolean)
        End If

        'Added BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452
        CommonFunction.Data.DisposeDataReader(objDr)
        'End Addition By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452

        If intApplyEffortDistribution = True Then
            sbSQL.Length = 0
            sbSQL.Append("EXEC usp_Ins_Create_Tasks_For_Deliverable_Task_With_Effort_Distribution " & m_intProjectID & "," & Request.Form("cboTemplate") & "," & m_intRevisionNo)
            sbSQL.Append(", " & m_intDeliverableID & "," & m_intDeliverableTypeID)
            sbSQL.Append(",'" & HttpContext.Current.Session("strUserName").ToString & "'," & m_dblTaskEffort)
        Else
            sbSQL.Length = 0
            sbSQL.Append("EXEC usp_Ins_Create_Tasks_For_Deliverable_Task_Without_Effort_Distribution " & m_intProjectID & "," & Request.Form("cboTemplate") & "," & m_intRevisionNo)
            sbSQL.Append(", " & m_intDeliverableID & "," & m_intDeliverableTypeID)
            sbSQL.Append(",'" & HttpContext.Current.Session("strUserName").ToString & "'," & m_dblTaskEffort)

        End If

        'Modified by ShamkantD on 15 Dec 2004
        'Commented as no longer required
        'If m_intDeliverableTypeID.Trim = "4" Then
        '    sbSQL.Append ( "," & m_intSpecificationID)
        'Else
        '    sbSQL.Append ( ",NULL")
        'End If

        sbSQL.Append(",NULL")
        'End of modification - ShamkantD on 15 Dec 2004

        drCreateTasksOutput = CommonFunction.Data.GetDataReader(sbSQL.ToString, MyBase.UseSQL)
        strEmpListSQL = ""
        While drCreateTasksOutput.Read
            If drCreateTasksOutput.GetName(0).ToString.Trim.ToUpper = "RESOURCELISTSQL" Then
                strEmpListSQL = CType(CommonFunction.Data.CheckIsDBNull(drCreateTasksOutput("ResourceListSQL"), ""), String)
                Exit While
            End If
            drCreateTasksOutput.NextResult()
        End While

        CommonFunction.Data.DisposeDataReader(drCreateTasksOutput)
        sbSQL.Length = 0
        sbSQL.Append("EXEC usp_upd_tbl_PM_OtherSchedules_TemplateRevision " & m_intDeliverableID & "," & m_intDeliverableTypeID)
        sbSQL.Append("," & m_intProjectPhaseTaskTemplateID & "," & m_intRevisionNo)
        CommonFunction.Data.GetDataScalar(sbSQL.ToString, MyBase.UseSQL)

        'Send email to the resources for generated tasks

        If strEmpListSQL.Trim <> "" Then
            drResources = CommonFunction.Data.GetDataReader(strEmpListSQL, MyBase.UseSQL)
        End If

        drEmailMessage = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_EmailMessages 79", MyBase.UseSQL)

        If drEmailMessage.Read Then
            blnSendEmail = CType(CommonFunctions.Data.CheckIsDBNull(drEmailMessage("SendMail"), "0"), Boolean)
            blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(drEmailMessage("ShowPopup"), "0"), Boolean)
        End If

        If blnSendEmail Then
            If blnShowPopup Then
                While drResources.Read
                    strEmployeeID = CType(CommonFunctions.Data.CheckIsDBNull(drResources("EmployeeID"), ""), String)
                    strParentTaskIDs = CType(CommonFunctions.Data.CheckIsDBNull(drResources("ParentTaskID"), ""), String)

                    CommonFunction.General.WriteHTML("<script language=javascript>")
                    ''CommonFunction.General.WriteHTML("window.open (""../General/SendEmail.aspx?MessageID=79&EmployeeID=" & strEmployeeID & "&ParentTaskID=" & strParentTaskIDs & "&Title=" & m_strStudyTitle & """, ""_blank"", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                    'Added & commented by dipali V On New Mail Pop
                    'CommonFunction.General.WriteHTML("window.open (""../General/SendEmail.aspx?MessageID=79&EmployeeID=" & strEmployeeID & "&ParentTaskID=" & strParentTaskIDs & "&Title=" & m_strStudyTitle & """, ""_blank"", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                    CommonFunction.General.WriteHTML("window.open (""../NewAPI/Email/SendEmail.aspx?MessageID=79&EmployeeID=" & strEmployeeID & "&ProjectID=" & m_intProjectID & "&ParentTaskID=" & strParentTaskIDs & "&Title=" & m_strStudyTitle & """, ""_blank"", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                    'End of Added & commented by dipali V On New Mail Pop_Up
                    CommonFunction.General.WriteHTML("</script>")
                End While
            Else
                While drResources.Read
                    strEmployeeID = CType(CommonFunctions.Data.CheckIsDBNull(drResources("EmployeeID"), ""), String)
                    strParentTaskIDs = CType(CommonFunctions.Data.CheckIsDBNull(drResources("ParentTaskID"), ""), String)

                    'silent mail
                    CommonFunction.EmailMessages.PMMessages.GetEmailMessage_79(strEmployeeID, strParentTaskIDs, strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, m_strStudyTitle)
                    CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                End While
            End If
        End If

        '' START : Commented & Modified By ParagD On 12-Sept-2006
        '' Purpose : WhizibleSEM SP7 Issue : Refresh Parent page.

        m_strParentURL = "CommonPage.aspx?" &
        "ScheduleID_PK=" & m_intDeliverableID.Trim &
        "&MasterTagID=" & m_intTagId.Trim &
        "&FromWhere=" & m_strFromWhere.Trim &
        "&PagingAlphabet=" & m_strPagingAlphabet.Trim &
        "&SortBy=" & m_strSortBy.Trim &
        "&SortOrder=" & m_strSortOrder.Trim &
        "&ParentTagID=" & m_strParentTagID.Trim &
        "&FromCL=" & m_strFromCL.Trim & ""

        CommonFunction.General.WriteHTML("<script language=""javascript"">")
        '' CommonFunction.General.WriteHTML("alert(""Selected Tasks successfully created for the Deliverable"");")
        CommonFunction.General.WriteHTML("alertify.set('notifier', 'position', 'top-right');")
        CommonFunction.General.WriteHTML("alertify.notify(""Efforts cannot be zero For mandatory task"", 'error', 25);")
        ''CommonFunction.General.WriteHTML("alert(""Selected Tasks successfully created for the Deliverable"");")
        CommonFunction.General.WriteHTML("window.close();")

        '' CommonFunction.General.WriteHTML("window.opener.location.href = " & m_strParentURL & ";")
        CommonFunction.General.WriteHTML("refreshParent('frmCommonPage','CommonPage.aspx', '" + m_strParentURL + "' ,true);")

        '' END : Modified By ParagD On 12-Sept-2006   
        ''Added by PrashantSJ on 14th July 2009 Purpose: to refersh deliverable planning Gantt chart page
        CommonFunction.General.WriteHTML("refreshParent('frmWBS_GanttChartView','WBS_GanttChartView.aspx', '../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038' ,true);")
        ''End of addition by PrashantSJ on 14th July 2009 Purpose: to refersh deliverable planning Gantt chart page
        CommonFunction.General.WriteHTML("</script>")


        CommonFunctions.Data.DisposeDataReader(drEmailMessage)
        CommonFunction.Data.DisposeDataReader(drResources)
        sbSQL = Nothing
    End Sub


#End Region

#Region " Grid Plotting "
    Private Sub DrawGrid()
        '=====================================================================
        ' Procedure Name        : DrawGrid()	
        ' Purpose               : Plots the grid on the page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ShamkantD
        ' Created               : Aug 25,20004
        ' Revisions             : BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452
        '                         Replaced call for WriteHTML with sbHTML                   
        '=====================================================================
        Dim drTemplateData As IDataReader
        Dim drPhaseTaskEfort As IDataReader
        Dim drCompanyInfo As IDataReader

        Dim intPrevPhaseTaskID As Integer
        Dim intPhaseTaskID As Integer
        'Added By MahendraV ON 6:40 PM 6/6/2007 for Review Activity
        ' Start_MV_ 6/6/2007
        Dim intProjectPhaseTaskActivityID As Integer
        ' End_MV_ 6/6/2007
        Dim intEvenOddCount As Integer
        Dim dblPhaseTaskEffort As Double
        Dim dblEffort As Double
        Dim dblDifference As Double
        Dim decdblEffort As Double
        Dim intQutient As Double

        Dim strActivityList As String
        Dim strClass As String
        Dim dtmStartDate As String
        Dim dtmEndDate As String
        Dim drTemplate As IDataReader
        Dim lngPhaseTaskID As Long

        'Added BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452
        Dim sbHTML As New System.Text.StringBuilder
        'End Addition By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452

        'Get the project phasetask template id
        If m_intSelectedTemplateID.Trim <> "" Then
            ' strSQLQuery = "SELECT DISTINCT ProjectPhaseTaskTemplateID FROM tbl_PM_Project_PhaseTask_Template WHERE TemplateId = " & m_intSelectedTemplateID & " AND ProjectID = " & m_intProjectID
            'Modified By VidyaJ on 26th May 2005 
            m_intProjectPhaseTaskTemplateID = m_intSelectedTemplateID 'CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "").ToString

            If Len(m_intSelectedTemplateID) <> 0 Then
                strSQLQuery = "EXEC usp_Sel_Deliverable_Template_PhaseTasks " & m_intProjectID & ", " & m_intSelectedTemplateID
                drTemplate = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

                'If drTemplate.Read Then
                sbHTML.Append("<br><DIV id='DivList' style='Overflow:auto;width=100%;Height:350'>")
                sbHTML.Append("<TABLE class='clsTable'cellpadding=0 cellspacing=0 width='100%' id=""TasksTable"" name=""TasksTable"">")
                sbHTML.Append("<TR class='clsTRSectionHeader'>")
                sbHTML.Append("<Td width='25%' valign=""top"" align=""left"">" & MyBase.GetResourceString("COL_ACTIVITY") & "</Td>")
                'Commented by SachinR   on 06 Nov 2004
                'sbHTML.append("<Td width='5%' valign=""top"" align=""left"">" & MyBase.GetResourceString("COL_IS_MANDATORY") & "</Td>")
                'end of comment
                sbHTML.Append("<Td width='10%' valign=""top"" align=""left"">" & MyBase.GetResourceString("COL_DURATION_DAYS") & "</Td>")
                ''Commented and Added By Usha Pandit on 08-April-2019 Purpose::Whizible 2 Work field change
                'sbHTML.Append("<Td width='10%' valign=""top"" align=""left"">" & MyBase.GetResourceString("COL_EFFORT_HRS") & "</Td>")
                sbHTML.Append("<Td width='10%' valign=""top"" align=""left"">" & " Work (H:M) " & "</Td>")
                ''End of Added By Usha Pandit on 08-April-2019 Purpose::Whizible 2 Work field change
                sbHTML.Append("<Td width='10%' valign=""top"" align=""left"">" & MyBase.GetResourceString("COL_START_DATE") & "</Td>")
                sbHTML.Append("<Td width='10%' valign=""top"" align=""left"">" & MyBase.GetResourceString("COL_END_DATE") & "</Td>")
                sbHTML.Append("<Td width='25%' valign=""top"" align=""left"">" & MyBase.GetResourceString("COL_ROLE") & "</Td>")
                sbHTML.Append("<Td width='25%' valign=""top"" align=""left"">" & MyBase.GetResourceString("COL_RESOURCE") & "</Td>")
                'Modified by SachinR    on 04 Nov 2004
                'sbHTML.append("<Td width='10%' valign=""top"" align=""left"">" & MyBase.GetResourceString("COL_RESOURCE_LOADING") & "</Td>")
                'modification end
                sbHTML.Append("</TR>")

                strSQLQuery = "EXEC usp_Sel_Deliverable_Template_Role_Resource " & m_intProjectID & ", " & m_intSelectedTemplateID & ", " & m_intDeliverableID & ", " & m_intDeliverableTypeID & "," & m_intRevisionNo
                drTemplateData = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                intPrevPhaseTaskID = 0
                m_intRecordCount = 0

                'Added by ShamkantD on 3 Dec 2004

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''strSQLQuery = "SELECT MinHoursForDAEntry FROM tbl_PM_CompanyInformation"
                strSQLQuery = "usp_sel_tbl_PM_CompanyInformation_MinHoursForDAEntry"
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                m_dblIncrementMinutes = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL), "0"), "0"), Double)
                If m_dblIncrementMinutes = 0 Then m_dblIncrementMinutes = 0.5
                'End of addition - ShamkantD on 3 Dec 2004

                'strSQLQuery = "SELECT * FROM tbl_PM_CompanyInformation"
                'drCompanyInfo = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                'If drCompanyInfo.Read Then
                '    m_dblIncrementMinutes = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("IncrementMinutes"), "0"), Double)
                'End If
                'CommonFunction.Data.DisposeDataReader(drCompanyInfo)

                While drTemplateData.Read
                    m_intRecordCount += 1
                    intPhaseTaskID = CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), "0"), Integer)
                    'Added By MahendraV ON 6:40 PM 6/6/2007 for Review activity either it is offline or fast treck
                    ' Start_MV_ 6/6/2007
                    intProjectPhaseTaskActivityID = CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), "0"), Integer)
                    ' End_MV_ 6/6/2007
                    'Commented & Added by AmitJ for WhizSEM9 HotFix 9.0.026  
                    'TaskMandatoryArr = TaskMandatoryArr + CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), "0"), String)  + "," + CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("IsMandatory"), "0"), String) + ","
                    If CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("IsMandatory"), "0"), String) = "True" Then
                        TaskMandatoryArr = TaskMandatoryArr + CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), "0"), String) + ","  '+ CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("IsMandatory"), "0"), String) + ","
                        If CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ReviewTask"), "False"), String) = "False" Then
                            'ReviewTaskArr = ReviewTaskArr + CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), "0"), String) + "," + CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ReviewTask"), "False"), String) + ","
                            ReviewTaskArr = ReviewTaskArr + CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), "0"), String) + ","
                        End If
                    End If
                    'End of Addition by AmitJ for for WhizSEM9 HotFix 9.0.026  
                    If intPhaseTaskID <> intPrevPhaseTaskID Then
                        If intPhaseTaskID <> 0 Then

                            intPrevPhaseTaskID = intPhaseTaskID
                            intEvenOddCount = 1

                            'Get the Effort of the PhaseTask, this will be used to calculate the effort for the activities

                            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                            'drPhaseTaskEfort = CommonFunction.Data.GetDataReader("SELECT Effort FROM tbl_PM_Project_PhaseTask_Template_Effort WHERE ProjectID = " & m_intProjectID & " AND PhaseTaskID = " & intPhaseTaskID & " AND TemplateID = " & m_intProjectPhaseTaskTemplateID, MyBase.UseSQL)
                            drPhaseTaskEfort = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_Project_PhaseTask_Template_Effort_Effort " & m_intProjectID & "," & intPhaseTaskID & "," & m_intProjectPhaseTaskTemplateID, MyBase.UseSQL)
                            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                            If drPhaseTaskEfort.Read Then
                                If CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PercentageEffortDistribution"), ""), String).Trim = "True" Then
                                    dblPhaseTaskEffort = ((m_dblDeliverableLCE * CType(CommonFunction.Data.CheckIsDBNull(drPhaseTaskEfort("Effort"), "0"), Double)) / 100)
                                Else
                                    dblPhaseTaskEffort = CType(CommonFunction.Data.CheckIsDBNull(drPhaseTaskEfort("Effort"), "0"), Double)
                                End If
                            Else
                                dblPhaseTaskEffort = 0
                            End If

                            CommonFunction.Data.DisposeDataReader(drPhaseTaskEfort)
                            strActivityList = ""
                            sbHTML.Append("<TR class='clsTROdd'>")
                            'Show phase task name
                            sbHTML.Append("<TD valign=""top"" align=""left"" colspan=7>")
                            sbHTML.Append(MyBase.GetResourceString("CAP_PHASE_TASK") & "&nbsp;" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskName"), ""), String) & " (" & MyBase.GetResourceString("CAP_EFFORT") & CType(dblPhaseTaskEffort, String) & " hrs)")



                            'added by SachinR   on 06 Nov 2004
                            'to show * if mandatory
                            If CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("IsMandatory"), "0"), Boolean) = True Then
                                sbHTML.Append(CommonFunction.HTMLControls.DrawImage("../../Images/Star.gif", , , , , , , True))
                            End If
                            'modification end
                            sbHTML.Append("&nbsp;&nbsp;<A Href=""javascript:GetTaskDetails(" & intPhaseTaskID & ")"">" & MyBase.GetResourceString("LINK_GET_TASK_DETAILS") & "</A>")

                            sbHTML.Append("<input type=hidden id=txtPhaseTaskName" & intPhaseTaskID & " name=txtPhaseTaskName" & intPhaseTaskID & " value = """ & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskName"), ""), String) & """>")
                            sbHTML.Append("<input type=hidden id=txtPhaseTaskNotes" & intPhaseTaskID & " name=txtPhaseTaskNotes" & intPhaseTaskID & " value="""">")
                            sbHTML.Append("<input type=hidden id=txtPriority" & intPhaseTaskID & " name=txtPriority" & intPhaseTaskID & " value="""">")
                            sbHTML.Append("<input type=hidden id=txtEstimationTypeID" & intPhaseTaskID & " name=txtEstimationTypeID" & intPhaseTaskID & " value="""">")
                            sbHTML.Append("<input type=hidden id=txtPhaseID" & intPhaseTaskID & " name=txtPhaseID" & intPhaseTaskID & " value="""">")
                            sbHTML.Append("<input type=hidden id=txtModuleID" & intPhaseTaskID & " name=txtModuleID" & intPhaseTaskID & " value="""">")
                            sbHTML.Append("<input type=hidden id=txtSubProjectID" & intPhaseTaskID & " name=txtSubProjectID" & intPhaseTaskID & " value="""">")
                            sbHTML.Append("<input type=hidden id=txtMilestoneID" & intPhaseTaskID & " name=txtMilestoneID" & intPhaseTaskID & " value="""">")
                            sbHTML.Append("<input type=hidden id=txtChangeRequestID" & intPhaseTaskID & " name=txtChangeRequestID" & intPhaseTaskID & " value="""">")
                            sbHTML.Append("<input type=hidden id=txtFeatureID" & intPhaseTaskID & " name=txtFeatureID" & intPhaseTaskID & " value="""">")

                            sbHTML.Append("</TD>")
                            sbHTML.Append("</TR>")
                        End If
                    End If

                    If (intEvenOddCount Mod 2) = 0 Then
                        strClass = "clsTREven"
                    Else
                        strClass = "clsTROdd"
                    End If

                    'Calculate the Effort in hrs.
                    If CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PercentageEffortDistribution"), ""), String).Trim = "True" Then
                        dblEffort = ((dblPhaseTaskEffort * CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("Effort"), "0"), Double)) / 100)
                        'dblEffort = dblPhaseTaskEffort
                    Else
                        dblEffort = CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("Effort"), "0"), Double)
                    End If

                    If dblEffort > 0 Then
                        'Round off the task efforts based on the Minimum Chargable Activity Time 

                        'Get the number that needs to be added to Effort to make it in the multiple of 
                        'Minimum Chargable Activity Time:
                        'If the effort is 32.86 and Minimum Chargable Activity Time is 0.25, 
                        'to make it in the multiple of 0.25, following steps are needed:
                        'Decimal part of = 0.86
                        '0.86 is greater than 0.25, so...
                        'Decimal part of Quotient = 0.86 / 0.25, which is 3; add 1 to it, which equal to 4
                        'Multiply 0.25 with 4 which equals to 1
                        'Get the difference between 1 and 0.86, which is 0.14. This is the number that 
                        'needs to be added to the original effort so that it will become the multiple 
                        'of 0.25.
                        dblDifference = 0.0

                        'Get the decimal part of the Efforts

                        'Check if the effort is in the multiple of Minimum Chargable Activity
                        dblDifference = (dblEffort - (Fix(dblEffort / m_dblIncrementMinutes) * m_dblIncrementMinutes))

                        If dblDifference > 0 Then
                            decdblEffort = dblEffort - Fix(dblEffort)
                            If decdblEffort > 0 Then
                                'If the decimal part is less than Minimum Chargable Activity Time, simply
                                'get the difference between decimal part and Minimum Chargable Activity Time
                                If decdblEffort < m_dblIncrementMinutes Then
                                    dblDifference = m_dblIncrementMinutes - decdblEffort
                                ElseIf decdblEffort > m_dblIncrementMinutes Then
                                    'Else, if the decimal part is greater than Minimum Chargable Activity Time...
                                    'Get the decimal part of the quotient part of effort / Minimum Chargable Activity Time
                                    intQutient = Fix(dblEffort / m_dblIncrementMinutes)
                                    'Add one to the quotient and multiply it by Minimum Chargable Activity Time to
                                    'get the difference that needs to be added to effort in order to round it off
                                    'in the multiples of Minimum Chargable Activity Time.
                                    dblDifference = (m_dblIncrementMinutes * (intQutient + 1)) - dblEffort
                                End If

                                'Add the difference to the effort to round it off.
                                dblEffort = dblEffort + dblDifference
                            End If
                        End If
                    End If

                    If CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("StartDate"), ""), String) <> "" Then
                        dtmStartDate = CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("StartDate"), ""), String)
                    Else
                        dtmStartDate = ""
                    End If

                    If CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("StartDate"), ""), String) <> "" Then
                        dtmEndDate = CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("EndDate"), ""), String)
                    Else
                        dtmEndDate = ""
                    End If
                    '--------------------------------------------------------------
                    sbHTML.Append("<TR class='clsTREven'>")
                    sbHTML.Append("<TD valign=""top"" align=""left"">" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ActivityTitle"), ""), String))
                    'added by SachinR   on 06 Nov 2004
                    'to show * if mandatory
                    If CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("IsMandatory"), "0"), Boolean) = True Then
                        sbHTML.Append(CommonFunction.HTMLControls.DrawImage("../../Images/Star.gif", , , , , , , True))
                    End If
                    'modification end

                    sbHTML.Append("<input type=hidden name=txtPhaseTaskID value=" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String) & ">")
                    sbHTML.Append("<input type=hidden name=txtActivityID value=" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ActivityID"), ""), String) & ">")
                    sbHTML.Append("<input type=hidden name=txtProjectPhaseTaskActivityID value=" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String) & ">")
                    sbHTML.Append("<input type=hidden name=txtActivityTitle value=""" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ActivityTitle"), ""), String) & """>")
                    sbHTML.Append("<input type=hidden name=txtReviewActivity value=""" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ReviewActivity"), "False"), String) & """>")
                    sbHTML.Append("<input type=hidden name=txtPhaseTaskTitle value=""" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskName"), ""), String) & """>")
                    'Added By MahendraV ON 6:40 PM 6/6/2007
                    ' Start_MV_ 6/6/2007
                    If CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ReviewActivity"), ""), String).Trim = "True" Then
                        sbHTML.Append("<BR> <Table class='clsTable'cellpadding=0 cellspacing=0 ><tr class='clsTREven'><td>Is Fast Track Review </td><TD>")
                        sbHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("IsFTR" & intProjectPhaseTaskActivityID, "IsFTR" & intProjectPhaseTaskActivityID, , , intProjectPhaseTaskActivityID.ToString, , "OnClick='FTR_Check(" & intProjectPhaseTaskActivityID & ")'", True))
                        sbHTML.Append("</TD></TR><TR class='clsTREven'><td> Is Offline Review </td><TD>")
                        sbHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("IsOffline" & intProjectPhaseTaskActivityID, "IsOffline" & intProjectPhaseTaskActivityID, , , intProjectPhaseTaskActivityID.ToString, , "OnClick='Offline_Check(" & intProjectPhaseTaskActivityID & ")'", True))
                        sbHTML.Append("</TD></TR></Table>")
                    End If
                    'End_MV_ 6/6/2007
                    sbHTML.Append("</TD>")

                    'modified by SachinR    on 06 Nov 2004
                    'commented to remove mandatory col.
                    'sbHTML.append("<TD valign=""top"" align=""left"">")
                    'If CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("IsMandatory"), ""), String).Trim = "True" Then
                    '    sbHTML.append("Yes")
                    'Else
                    '    sbHTML.append("No")
                    'End If
                    'sbHTML.append("</TD>")
                    'modification end

                    sbHTML.Append("<TD valign=""top"" align=""right"">" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("Duration"), ""), String))

                    'Added by ShamkantD on 6 Dec 2004
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtDuration" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String), "txtDuration" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String), value:=CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("Duration"), ""), String), IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    sbHTML.Append("</TD>")
                    'End of addition - ShamkantD on 6 Dec 2004

                    sbHTML.Append("<TD valign=""top"" align=""left"">")

                    If CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ReviewActivity"), ""), String).Trim <> "True" Then
                        If CommonFunction.General.CheckIsNothing(dblEffort, "").ToString <> "" Then
                            ''Commented and added by Nilesh g on 15/1/2016 for add id for textbox
                            '''  sbHTML.Append("<input type=text class=""clsTextbox"" style='TEXT-ALIGN: right' size=""12"" maxlength=8 name=""txtEffort" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String) & """ value=" & FormatNumber(dblEffort, 2) & ">")
                            'sbHTML.Append("<input type=text class=""clsTextbox"" style='TEXT-ALIGN: right' size=""12"" maxlength=8 id=""txtEffort"" name=""txtEffort" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String) & """ value=" & FormatNumber(dblEffort, 2) & ">")
                            sbHTML.Append("<input type=text class=""clsTextbox"" style='TEXT-ALIGN: right' size=""12"" maxlength=8 id=""txtEffort"" autocomplete=""off"" name=""txtEffort" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String) & """ value=" & FormatNumber(dblEffort, 2) & ">")
                        Else
                            ''Commented and added by Nilesh g on 15/1/2016 for add id for textbox
                            '' sbHTML.Append("<input type=text class=""clsTextbox"" style='TEXT-ALIGN: right' size=""12"" maxlength=8 name=""txtEffort" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String) & """ value=" & dblEffort & ">")
                            'sbHTML.Append("<input type=text class=""clsTextbox"" style='TEXT-ALIGN: right' size=""12"" maxlength=8 id=""txtEffort"" name=""txtEffort" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String) & """ value=" & dblEffort & ">")
                            sbHTML.Append("<input type=text class=""clsTextbox"" style='TEXT-ALIGN: right' size=""12"" maxlength=8 id=""txtEffort""  autocomplete=""off""  name=""txtEffort" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String) & """ value=" & dblEffort & ">")
                            ''end of Commented and added by Nilesh g on 15/1/2016 for add id for textbox
                        End If
                    Else
                        'sbHTML.append("Reviewer&nbsp;Effort<br><input type=text class=""clsTextbox"" style='TEXT-ALIGN: right' size=""12"" maxlength=8 name=""txtReviewerEffort" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String) & """ value=" & FormatNumber(dblEffort, 2) & ">")
                        'sbHTML.append("Reviewee&nbsp;Effort<br><input type=text class=""clsTextbox"" style='TEXT-ALIGN: right' size=""12"" maxlength=8 name=""txtRevieweeEffort" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String) & """ value=" & FormatNumber(dblEffort, 2) & ">")
                        'sbHTML.Append("<input type=text class=""clsTextbox"" style='TEXT-ALIGN: right' size=""12"" maxlength=8 name=""txtReviewerEffort" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String) & """ value=" & FormatNumber(dblEffort, 2) & ">")
                        sbHTML.Append("<input type=text class=""clsTextbox"" autocomplete=""off""  style='TEXT-ALIGN: right' size=""12"" maxlength=8 name=""txtReviewerEffort" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String) & """ value=" & FormatNumber(dblEffort, 2) & ">")
                    End If

                    sbHTML.Append("</TD>")

                    sbHTML.Append("<TD valign = ""top"" align=""left"">")
                    sbHTML.Append("<div Class='input-group'>")
                    sbHTML.Append("<input size=""14"" type=text class=""clsTextbox"" autocomplete=""off""  onclick=""showdatepicker('txtStartDate" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String) & "','" & m_strDateFormat.ToString() & "')"" style='TEXT-ALIGN: right' name=txtStartDate" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String) & " id=txtStartDate" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String) & " value=" & FormatNumber(dblEffort, 2) & ">")
                    sbHTML.Append("<span Class='input-group-btn'>")
                    sbHTML.Append("<button class='btn btncalendar' type='button'   onclick=""showdatepicker('txtStartDate" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String) & "','" & m_strDateFormat.ToString() & "')""><i class='fas fa-calendar-alt'></i></button>")
                    sbHTML.Append("</span>")
                    sbHTML.Append("</div>")
                    sbHTML.Append("</TD>")

                    sbHTML.Append("<TD valign = ""top"" align=""left"">")
                    sbHTML.Append("<div Class='input-group'>")
                    sbHTML.Append("<input size=""14"" type=text class=""clsTextbox"" autocomplete=""off""  onclick=""showdatepicker('txtEndDate" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String) & "','" & m_strDateFormat.ToString() & "')"" style='TEXT-ALIGN: right' name=txtEndDate" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String) & " id=txtEndDate" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String) & " value=" & FormatNumber(dblEffort, 2) & ">")
                    sbHTML.Append("<span Class='input-group-btn'>")
                    sbHTML.Append("<button class='btn btncalendar' type='button' onclick=""showdatepicker('txtEndDate" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String) & "','" & m_strDateFormat.ToString() & "')""><i class='fas fa-calendar-alt'></i></button>")
                    sbHTML.Append("</span>")
                    sbHTML.Append("</div>")
                    sbHTML.Append("</TD>")


                    sbHTML.Append("<TD valign=""top"" align=""left"">" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("RoleDescription"), ""), String) & "</TD>")


                    sbHTML.Append("<TD valign=""top"" align=""left"">")

                    If CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ReviewActivity"), ""), String).Trim <> "True" Then

                        'Added by SachinR   on 04 Nov 2004
                        'get the list of resources who has given access to the DeliverableType while adding deliverable 
                        'type for the project in Deliverable Settings 
                        Dim strResourceIDs As String
                        If CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ResourceID"), ""), String) = "" Then
                            strSQLQuery = "usp_Sel_tbl_PM_DeliverableType_RoleMapping " + m_intProjectID.ToString + "," + m_intDeliverableTypeID.Trim
                            strResourceIDs = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL), "").ToString
                            If strResourceIDs.StartsWith(",") = False Then strResourceIDs = "," + strResourceIDs
                            If strResourceIDs.EndsWith(",") = False Then strResourceIDs += ","
                        Else
                            strResourceIDs = CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ResourceID"), ""), String)
                            If strResourceIDs.StartsWith(",") = False Then strResourceIDs = "," + strResourceIDs
                            If strResourceIDs.EndsWith(",") = False Then strResourceIDs += ","
                        End If
                        'addition end

                        strSQLQuery = "EXEC usp_Sel_Project_Resources_AsPer_Role " & m_intProjectID & ", " & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("RoleID"), ""), String)
                        'Added BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452
                        ' Replaced Draw Combo box with draw List Box 
                        'CommonFunction.HTMLControls.DrawComboBox("cboResource" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String), strSQLQuery, 200, strResourceIDs, "style='height=' multiple")
                        sbHTML.Append(CommonFunction.HTMLControls.DrawListBox("cboResource" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String), strSQLQuery, 200, , strResourceIDs, , , True))

                        'End Addition By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452
                        If m_strControlNames = "" Then
                            m_strControlNames = CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("RoleID"), ""), String) & "," & "cboResource" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String)
                        Else
                            m_strControlNames = m_strControlNames & "|" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("RoleID"), ""), String) & "," & "cboResource" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String)
                        End If
                    Else
                        ' Modified By MahendraV On 7:29 PM 6/26/2007
                        ' IssueID (14049) :Planned Deliverable : While creating Review through Planned Deliverable only Project resources are displayed in "Reviewer" combo ?
                        ' Start_MV_6/26/2007
                        'strSQLQuery = "EXEC usp_Sel_ProjectResources_TaskAssignment_PlanDeliverable " & m_intProjectID
                        strSQLQuery = "EXEC usp_sel_tbl_PM_RowWiseExternalApprovers " & m_intProjectID
                        ' End_MV_6/26/2007
                        sbHTML.Append(MyBase.GetResourceString("CAP_REVIEWER") & "&nbsp;<br>")

                        'Comment and modification by SuchitraP on 8-Apr-2009 for IssueID : 29972
                        'Purpose : To segregate the project and non project resources.
                        Dim GroupingColName As CommonFunctions.HTMLControls.WAF_DropDown = New CommonFunctions.HTMLControls.WAF_DropDown
                        GroupingColName.DropdownGroupingColumn = "IsExternal"
                        GroupingColName.WidthInPixel = 200
                        GroupingColName.ReturnHTML = True
                        GroupingColName.ToBeInserted = ""
                        GroupingColName.MatchFieldID = CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ResourceID"), ""), String)

                        'sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboReviewer" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String), strSQLQuery, 200, CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ResourceID"), ""), String), "", , True))
                        sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboReviewer" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String), strSQLQuery, GroupingColName))
                        'End of comment and modification by SuchitraP on 8-Apr-2009

                        ' Start_MV_6/26/2007
                        strSQLQuery = "EXEC usp_Sel_ProjectResources_TaskAssignment_PlanDeliverable " & m_intProjectID
                        ' End_MV_6/26/2007
                        sbHTML.Append("<br>" & MyBase.GetResourceString("CAP_REVIEWEE") & "&nbsp;<br>")
                        sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboReviewee" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String), strSQLQuery, 200, CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ResourceID"), ""), String), "", , True))
                    End If

                    'Modified by SachinR    on 04 Nov 2004
                    'sbHTML.append("</TD>")
                    'sbHTML.append("<TD valign=""top"" align=""center"">")
                    'sbHTML.append("<A Href=""javascript:ResourceLoading(" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ProjectPhaseTaskActivityID"), ""), String) & ",'" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ReviewActivity"), ""), String) & "')"">" & MyBase.GetResourceString("LINK_RESOURCE_LOADING") & "</A>")
                    'sbHTML.append("</TD>")
                    'modification end

                    sbHTML.Append("</TR>")

                    '--------------------------------------------------------------
                End While
                If m_intRecordCount = 0 Then
                    m_intRecordCount = 0
                    sbHTML.Append("<TR class='clsTROdd'><Td align=""center"" colspan=9>There are no items to show in this view. </TD></TR>")
                End If
                sbHTML.Append("</TABLE>")
                sbHTML.Append("<br></DIV>")

                CommonFunctions.General.WriteHTML(sbHTML.ToString)

            Else
                m_intRecordCount = 0
            End If
            CommonFunction.Data.DisposeDataReader(drTemplate)
            CommonFunction.Data.DisposeDataReader(drTemplateData)
        End If

        sbHTML = Nothing

    End Sub

    Private Sub DrawGridForTask()
        '=====================================================================
        ' Procedure Name        : DrawGridForTask()	
        ' Purpose               : Plots the grid on the page When ‘Apply Sub Task ’ or ‘Apply Effort Distribution’.
        '                         are not checked or only one of them is checked in Project Settings 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS 
        ' Created               : Feb 11 ,2005
        ' Revisions             : NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452
        '                            Replaced CommonFunctions.General.WriteHTML with string builder 
        '=====================================================================
        Dim drTemplateData As IDataReader
        Dim drPhaseTaskEfort As IDataReader
        Dim drCompanyInfo As IDataReader

        Dim intPrevPhaseTaskID As Integer
        Dim intPhaseTaskID As Integer
        Dim intEvenOddCount As Integer
        Dim dblPhaseTaskEffort As Double
        Dim dblEffort As Double
        Dim dblDifference As Double
        Dim decdblEffort As Double
        Dim intQutient As Double

        '        Dim strActivityList As String
        Dim strClass As String
        Dim dtmStartDate As String
        Dim dtmEndDate As String
        Dim drTemplate As IDataReader
        Dim lngPhaseTaskID As Long
        'Added BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452
        Dim sbHTML As New System.Text.StringBuilder
        'End Addition By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452

        'Get the project phasetask template id
        If m_intSelectedTemplateID.Trim <> "" Then
            'strSQLQuery = "SELECT DISTINCT ProjectPhaseTaskTemplateID FROM tbl_PM_Project_PhaseTask_Template WHERE TemplateId = " & m_intSelectedTemplateID & " AND ProjectID = " & m_intProjectID
            'MODIFIED BY VidyaJ on 26th May 2005
            m_intProjectPhaseTaskTemplateID = m_intSelectedTemplateID  'CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "").ToString

            'Get the project phasetask template id
            If m_intSelectedTemplateID.Trim <> "" Then
                'strSQLQuery = "SELECT DISTINCT ProjectPhaseTaskTemplateID FROM tbl_PM_Project_PhaseTask_Template WHERE TemplateId = " & m_intSelectedTemplateID & " AND ProjectID = " & m_intProjectID
                m_intProjectPhaseTaskTemplateID = m_intSelectedTemplateID 'CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "").ToString

                'If drTemplate.Read Then
                sbHTML.Append("<br><DIV id='DivList' style='Overflow:auto;width=100%;Height:230'>")
                sbHTML.Append("<TABLE class='clsTable'cellpadding=0 cellspacing=0 width='100%' id=""TasksTable"" name=""TasksTable"">")
                sbHTML.Append("<TR class='clsTRSectionHeader'>")

                sbHTML.Append("<Td width='30%' valign=""top"" align=""left"">" & MyBase.GetResourceString("COL_TASK") & "</Td>")
                'Commented by SachinR   on 06 Nov 2004
                'sbHTML.Append("<Td width='5%' valign=""top"" align=""left"">" & MyBase.GetResourceString("COL_IS_MANDATORY") & "</Td>")
                'end of comment

                sbHTML.Append("<Td width='10%' valign=""top"" align=""left"">" & MyBase.GetResourceString("COL_DURATION_DAYS") & "</Td>")
                ''Commented and Added By Usha Pandit on 08-April-2019 Purpose::Whizible 2 Work field change
                'sbHTML.Append("<Td width='10%' valign=""top"" align=""left"">" & MyBase.GetResourceString("COL_EFFORT_HRS") & "</Td>")
                sbHTML.Append("<Td width='10%' valign=""top"" align=""left"">" & " Work (H:M) " & "</Td>")
                ''End of Added By Usha Pandit on 08-April-2019 Purpose::Whizible 2 Work field change

                sbHTML.Append("<Td width='10%' valign=""top"" align=""left"">" & MyBase.GetResourceString("COL_START_DATE") & "</Td>")
                sbHTML.Append("<Td width='10%' valign=""top"" align=""left"">" & MyBase.GetResourceString("COL_END_DATE") & "</Td>")
                sbHTML.Append("<Td width='15%' valign=""top"" align=""left"">" & MyBase.GetResourceString("COL_ROLE") & "</Td>")
                sbHTML.Append("<Td width='15%' valign=""top"" align=""left"">" & MyBase.GetResourceString("COL_RESOURCE") & "</Td>")
                'Modified by SachinR    on 04 Nov 2004
                'sbHTML.Append("<Td width='10%' valign=""top"" align=""left"">" & MyBase.GetResourceString("COL_RESOURCE_LOADING") & "</Td>")
                'modification end
                sbHTML.Append("</TR>")

                strSQLQuery = "EXEC usp_Sel_Deliverable_Template_Role_Resource_Tasks " & m_intProjectID & ", " & m_intSelectedTemplateID & ", " & m_intDeliverableID & ", " & m_intDeliverableTypeID & "," & m_intRevisionNo
                drTemplateData = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                intPrevPhaseTaskID = 0
                m_intRecordCount = 0

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''strSQLQuery = "SELECT MinHoursForDAEntry FROM tbl_PM_CompanyInformation"
                strSQLQuery = "usp_sel_tbl_PM_CompanyInformation_MinHoursForDAEntry"
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016


                m_dblIncrementMinutes = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL), "0"), "0"), Double)
                If m_dblIncrementMinutes = 0 Then m_dblIncrementMinutes = 0.5

                While drTemplateData.Read
                    m_intRecordCount += 1
                    intPhaseTaskID = CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), "0"), Integer)
                    If intPhaseTaskID <> intPrevPhaseTaskID Then
                        If intPhaseTaskID <> 0 Then

                            intPrevPhaseTaskID = intPhaseTaskID
                            intEvenOddCount = 1

                            'Get the Effort of the PhaseTask, this will be used to calculate the effort for the activities

                            '''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                            ''drPhaseTaskEfort = CommonFunction.Data.GetDataReader("SELECT Effort FROM tbl_PM_Project_PhaseTask_Template_Effort WHERE ProjectID = " & m_intProjectID & " AND PhaseTaskID = " & intPhaseTaskID & " AND TemplateID = " & m_intProjectPhaseTaskTemplateID, MyBase.UseSQL)
                            drPhaseTaskEfort = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_Project_PhaseTask_Template_Effort_Effort " & m_intProjectID & "," & intPhaseTaskID & "," & m_intProjectPhaseTaskTemplateID, MyBase.UseSQL)
                            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016


                            If drPhaseTaskEfort.Read Then
                                If CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PercentageEffortDistribution"), ""), String).Trim = "True" Then
                                    dblPhaseTaskEffort = ((m_dblDeliverableLCE * CType(CommonFunction.Data.CheckIsDBNull(drPhaseTaskEfort("Effort"), "0"), Double)) / 100)
                                Else
                                    dblPhaseTaskEffort = CType(CommonFunction.Data.CheckIsDBNull(drPhaseTaskEfort("Effort"), "0"), Double)
                                End If
                            Else
                                dblPhaseTaskEffort = 0
                            End If

                            CommonFunction.Data.DisposeDataReader(drPhaseTaskEfort)

                            sbHTML.Append("<TR class='clsTREven'>")
                            'Show phase task name
                            sbHTML.Append("<TD valign=""top"" align=""left"" >")
                            sbHTML.Append(CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskName"), ""), String))
                            'added by SachinR   on 06 Nov 2004
                            'to show * if mandatory

                            'Added by RuchiraC for Hexaware-RequestID-25641 on 05-Apr-10
                            TaskMandatoryArr = TaskMandatoryArr + CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), "0"), String) + "," + CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("IsMandatory"), "0"), String) + ","
                            ReviewTaskArr = ReviewTaskArr + CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), "0"), String) + "," + CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ReviewTask"), "False"), String) + ","
                            'End of Addition by RuchiraC for Hexaware-RequestID-25641 on 05-Apr-10
                            If CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("IsMandatory"), "0"), Boolean) = True Then
                                sbHTML.Append(CommonFunction.HTMLControls.DrawImage("../../Images/Star.gif", , , , , , , True))
                            End If
                            'modification end
                            'sbHTML.Append("</TD>")
                            'sbHTML.Append("<TD valign=""top"" align=""left"" >")
                            sbHTML.Append(" <BR><A Href=""javascript:GetTaskDetails(" & intPhaseTaskID & ")"">" & MyBase.GetResourceString("LINK_GET_TASK_DETAILS") & "</A>")

                            'sbHTML.Append("<input type=hidden id=txtPhaseTaskID name=txtPhaseTaskID value=" & intPhaseTaskID.ToString & ">")
                            sbHTML.Append("<input type=hidden id=txtPhaseTaskName" & intPhaseTaskID & " name=txtPhaseTaskName" & intPhaseTaskID & " value = """ & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskName"), ""), String) & """>")
                            sbHTML.Append("<input type=hidden id=txtPhaseTaskNotes" & intPhaseTaskID & " name=txtPhaseTaskNotes" & intPhaseTaskID & " value="""">")
                            sbHTML.Append("<input type=hidden id=txtPriority" & intPhaseTaskID & " name=txtPriority" & intPhaseTaskID & " value="""">")
                            sbHTML.Append("<input type=hidden id=txtEstimationTypeID" & intPhaseTaskID & " name=txtEstimationTypeID" & intPhaseTaskID & " value="""">")
                            sbHTML.Append("<input type=hidden id=txtPhaseID" & intPhaseTaskID & " name=txtPhaseID" & intPhaseTaskID & " value="""">")
                            sbHTML.Append("<input type=hidden id=txtModuleID" & intPhaseTaskID & " name=txtModuleID" & intPhaseTaskID & " value="""">")
                            sbHTML.Append("<input type=hidden id=txtSubProjectID" & intPhaseTaskID & " name=txtSubProjectID" & intPhaseTaskID & " value="""">")
                            sbHTML.Append("<input type=hidden id=txtMilestoneID" & intPhaseTaskID & " name=txtMilestoneID" & intPhaseTaskID & " value="""">")
                            sbHTML.Append("<input type=hidden id=txtChangeRequestID" & intPhaseTaskID & " name=txtChangeRequestID" & intPhaseTaskID & " value="""">")
                            sbHTML.Append("<input type=hidden id=txtFeatureID" & intPhaseTaskID & " name=txtFeatureID" & intPhaseTaskID & " value="""">")

                            'sbHTML.Append("</TD>")
                            'sbHTML.Append("</TR>")
                            'Added By MahendraV ON 2:49 PM 6/11/2007
                            ' Start_MV_6/6/2007
                            If CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ReviewTask"), ""), String).Trim = "True" Then
                                sbHTML.Append("<BR> <Table class='clsTable'cellpadding=0 cellspacing=0 ><tr class='clsTREven'><td>Is Fast Track Review </td><TD>")
                                sbHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("IsFTR" & intPhaseTaskID, "IsFTR" & intPhaseTaskID, , , intPhaseTaskID.ToString, , "OnClick='FTR_Check(" & intPhaseTaskID & ")'", True))
                                sbHTML.Append("</TD></TR><TR class='clsTREven'><td> Is Offline Review </td><TD>")
                                sbHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("IsOffline" & intPhaseTaskID, "IsOffline" & intPhaseTaskID, , , intPhaseTaskID.ToString, , "OnClick='Offline_Check(" & intPhaseTaskID & ")'", True))
                                sbHTML.Append("</TD></TR></Table>")
                            End If
                            'End_MV_6/11/2007

                            If (intEvenOddCount Mod 2) = 0 Then
                                strClass = "clsTREven"
                            Else
                                strClass = "clsTROdd"
                            End If

                            '                            sbHTML.Append("<TR class='clsTROdd'>")

                            If dblPhaseTaskEffort > 0 Then
                                'Round off the task efforts based on the Minimum Chargable Activity Time 

                                'Get the number that needs to be added to Effort to make it in the multiple of 
                                'Minimum Chargable Activity Time:
                                'If the effort is 32.86 and Minimum Chargable Activity Time is 0.25, 
                                'to make it in the multiple of 0.25, following steps are needed:
                                'Decimal part of = 0.86
                                '0.86 is greater than 0.25, so...
                                'Decimal part of Quotient = 0.86 / 0.25, which is 3; add 1 to it, which equal to 4
                                'Multiply 0.25 with 4 which equals to 1
                                'Get the difference between 1 and 0.86, which is 0.14. This is the number that 
                                'needs to be added to the original effort so that it will become the multiple 
                                'of 0.25.
                                dblDifference = 0.0

                                'Get the decimal part of the Efforts

                                'Check if the effort is in the multiple of Minimum Chargable Activity
                                dblDifference = (dblPhaseTaskEffort - (Fix(dblPhaseTaskEffort / m_dblIncrementMinutes) * m_dblIncrementMinutes))

                                If dblDifference > 0 Then
                                    decdblEffort = dblPhaseTaskEffort - Fix(dblPhaseTaskEffort)
                                    If decdblEffort > 0 Then
                                        'If the decimal part is less than Minimum Chargable Activity Time, simply
                                        'get the difference between decimal part and Minimum Chargable Activity Time
                                        If decdblEffort < m_dblIncrementMinutes Then
                                            dblDifference = m_dblIncrementMinutes - decdblEffort
                                        ElseIf decdblEffort > m_dblIncrementMinutes Then
                                            'Else, if the decimal part is greater than Minimum Chargable Activity Time...
                                            'Get the decimal part of the quotient part of effort / Minimum Chargable Activity Time
                                            intQutient = Fix(dblPhaseTaskEffort / m_dblIncrementMinutes)
                                            'Add one to the quotient and multiply it by Minimum Chargable Activity Time to
                                            'get the difference that needs to be added to effort in order to round it off
                                            'in the multiples of Minimum Chargable Activity Time.
                                            dblDifference = (m_dblIncrementMinutes * (intQutient + 1)) - dblPhaseTaskEffort
                                        End If

                                        'Add the difference to the effort to round it off.
                                        dblPhaseTaskEffort = dblPhaseTaskEffort + dblDifference
                                    End If
                                End If
                            End If

                            If CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("StartDate"), ""), String) <> "" Then
                                dtmStartDate = CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("StartDate"), ""), String)
                            Else
                                dtmStartDate = ""
                            End If

                            If CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("StartDate"), ""), String) <> "" Then
                                dtmEndDate = CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("EndDate"), ""), String)
                            Else
                                dtmEndDate = ""
                            End If




                            sbHTML.Append("<input type=hidden name=txtPhaseTaskID value=" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String) & ">")
                            sbHTML.Append("<input type=hidden name=txtPhaseTaskTitle value=""" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskName"), ""), String) & """>")
                            sbHTML.Append("</TD>")
                        End If
                    End If

                    sbHTML.Append("<TD valign=""top"" align=""right"">" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("Duration"), ""), String))

                    'Added by ShamkantD on 6 Dec 2004
                    CommonFunction.HTMLControls.DrawTextBox("txtDuration" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String), "txtDuration" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String), value:=CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("Duration"), ""), String), IsHidden:=True)
                    sbHTML.Append("</TD>")
                    'End of addition - ShamkantD on 6 Dec 2004

                    sbHTML.Append("<TD valign=""top"" align=""left"">")

                    If CommonFunction.General.CheckIsNothing(dblEffort, "").ToString <> "" Then
                        ''Commented and added by Nilesh g on 15/1/2016 for add id for textbox
                        '' sbHTML.Append("<input type=text class=""clsTextbox"" style='TEXT-ALIGN: right' size=""12"" maxlength=8 name=""txtEffort" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String) & """ value=" & FormatNumber(dblPhaseTaskEffort, 2) & ">")
                        ''Commented and Added by Usha Pandit on 05-April-2019 Purpose::Whizible 2 Work field change
                        'sbHTML.Append("<input type=text class=""clsTextbox"" style='TEXT-ALIGN: right' size=""12"" maxlength=8 id=""txtEffort"" name=""txtEffort" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String) & """ value=" & FormatNumber(dblPhaseTaskEffort, 2) & ">")
                        Dim HMPhaseTaskEffort As String = ""


                        HMPhaseTaskEffort = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + dblPhaseTaskEffort.ToString() + "',1)", True)


                        sbHTML.Append("<input type=text class=""clsTextbox"" style='TEXT-ALIGN: right' size=""12"" maxlength=8 id=""txtEffort""  autocomplete=""off""  name=""txtEffort" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String) & """ value=" & HMPhaseTaskEffort & ">")
                        ''End of Added by Usha Pandit on 05-April-2019 Purpose::Whizible 2 Work field change
                    Else
                        ''Commented and added by Nilesh g on 15/1/2016 for add id for textbox
                        ''sbHTML.Append("<input type=text class=""clsTextbox"" style='TEXT-ALIGN: right' size=""12"" maxlength=8 name=""txtEffort" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String) & """ value=" & dblPhaseTaskEffort & ">")
                        ''Commented and Added by Usha Pandit on 05-April-2019 Purpose::Whizible 2 Work field change
                        'sbHTML.Append("<input type=text class=""clsTextbox"" style='TEXT-ALIGN: right' size=""12"" maxlength=8 id=""txtEffort"" name=""txtEffort" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String) & """ value=" & dblPhaseTaskEffort & ">")
                        Dim HMPhaseTaskEffort As String = ""

                        HMPhaseTaskEffort = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + dblPhaseTaskEffort.ToString() + "',1)", True)

                        sbHTML.Append("<input type=text class=""clsTextbox"" style='TEXT-ALIGN: right' size=""12"" maxlength=8 id=""txtEffort""  autocomplete=""off""   name=""txtEffort" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String) & """ value=" & HMPhaseTaskEffort & ">")
                        ''End of Added by Usha Pandit on 05-April-2019 Purpose::Whizible 2 Work field change
                        ''end of Commented and added by Nilesh g on 15/1/2016 for add id for textbox
                    End If

                    sbHTML.Append("</TD>")
                    'sbHTML.Append("<TD valign=""top"" align=""left""><input size=""14"" type=text class=""clsTextbox"" style='TEXT-ALIGN: right' name=txtStartDate" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String) & " value=" & fixDateForDisplay(dtmStartDate, m_strDateFormat) & ">&nbsp;</TD>")
                    'sbHTML.Append("<TD valign=""top"" align=""left""><input size=""14"" type=text class=""clsTextbox"" style='TEXT-ALIGN: right' name=txtEndDate" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String) & " value=" & fixDateForDisplay(dtmEndDate, m_strDateFormat) & ">&nbsp;</TD>")

                    sbHTML.Append("<TD valign = ""top"" align=""left"">")
                    sbHTML.Append("<div Class='input-group'>")
                    sbHTML.Append("<input size=""14"" type=text class=""clsTextbox""  autocomplete=""off""  onclick=""showdatepicker('txtStartDate" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String) & "','" & m_strDateFormat.ToString() & "')"" style='TEXT-ALIGN: right' name=txtStartDate" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String) & " id=txtStartDate" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String) & " value=" & fixDateForDisplay(dtmStartDate, m_strDateFormat) & ">")
                    sbHTML.Append("<span Class='input-group-btn'>")
                    sbHTML.Append("<button class='btn btncalendar' type='button' onclick=""showdatepicker('txtStartDate" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String) & "','" & m_strDateFormat.ToString() & "')""><i class='fas fa-calendar-alt'></i></button>")
                    sbHTML.Append("</span>")
                    sbHTML.Append("</div>")
                    sbHTML.Append("</TD>")

                    sbHTML.Append("<TD valign = ""top"" align=""left"">")
                    sbHTML.Append("<div Class='input-group'>")
                    sbHTML.Append("<input size=""14"" type=text class=""clsTextbox"" autocomplete=""off""   onclick=""showdatepicker('txtEndDate" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String) & "','" & m_strDateFormat.ToString() & "')"" style='TEXT-ALIGN: right' name=txtEndDate" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String) & " id=txtEndDate" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String) & " value=" & fixDateForDisplay(dtmEndDate, m_strDateFormat) & ">")
                    sbHTML.Append("<span Class='input-group-btn'>")
                    sbHTML.Append("<button class='btn btncalendar' type='button' onclick=""showdatepicker('txtEndDate" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String) & "','" & m_strDateFormat.ToString() & "')""><i class='fas fa-calendar-alt'></i></button>")
                    sbHTML.Append("</span>")
                    sbHTML.Append("</div>")
                    sbHTML.Append("</TD>")

                    sbHTML.Append("<TD valign=""top"" align=""left"">" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("RoleDescription"), ""), String) & "</TD>")
                    sbHTML.Append("<TD valign=""top"" align=""left"">")



                    'Dim strResourceIDs As String
                    'If CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ResourceID"), ""), String) = "" Then
                    '    strSQLQuery = "usp_Sel_tbl_PM_DeliverableType_RoleMapping " + m_intProjectID.ToString + "," + m_intDeliverableTypeID.Trim
                    '    strResourceIDs = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL), "").ToString
                    '    If strResourceIDs.StartsWith(",") = False Then strResourceIDs = "," + strResourceIDs
                    '    If strResourceIDs.EndsWith(",") = False Then strResourceIDs += ","
                    'Else
                    '    strResourceIDs = CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ResourceID"), ""), String)
                    '    If strResourceIDs.StartsWith(",") = False Then strResourceIDs = "," + strResourceIDs
                    '    If strResourceIDs.EndsWith(",") = False Then strResourceIDs += ","
                    'End If
                    ''addition end

                    'strSQLQuery = "EXEC usp_Sel_Project_Resources_AsPer_Role " & m_intProjectID & ", " & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("RoleID"), ""), String)

                    ''Modified BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452
                    '' Replaced draw Combo with draw list box 

                    ''CommonFunction.HTMLControls.DrawComboBox("cboResource" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String), strSQLQuery, 200, strResourceIDs, "style='height=' multiple")
                    'sbHTML.Append(CommonFunction.HTMLControls.DrawListBox("cboResource" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String), strSQLQuery, 200, , strResourceIDs, , , True))

                    ''End Modification By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452

                    'If m_strControlNames = "" Then
                    '    m_strControlNames = CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("RoleID"), ""), String) & "," & "cboResource" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String)
                    'Else
                    '    m_strControlNames = m_strControlNames & "|" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("RoleID"), ""), String) & "," & "cboResource" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String)
                    'End If
                    'sbHTML.Append("</TD>")
                    'sbHTML.Append("</TR>")
                    '---------------------------------------------------------
                    'Integration starts: SP8 Upgrade: Hexaware code integration
                    '
                    'Modified on : 30 th Jan 2007
                    'Modified by : ArchanaN
                    '---------------------------------------------------------

                    '==============================================================
                    'Modified By                       MahendraV on 6:52 PM 6/6/2007
                    'Description                       To display Reviwer And Reviewee Drop Down in case of Review Task
                    '==============================================================
                    CommonFunction.General.WriteHTML("<input type=hidden name=txtReviewTask value=""" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ReviewTask"), "False"), String).Trim & """>")
                    If CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ReviewTask"), ""), String).Trim <> "True" Then
                        'Integration Ends

                        Dim strResourceIDs As String
                        If CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ResourceID"), ""), String) = "" Then
                            strSQLQuery = "usp_Sel_tbl_PM_DeliverableType_RoleMapping " + m_intProjectID.ToString + "," + m_intDeliverableTypeID.Trim
                            strResourceIDs = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL), "").ToString
                            If strResourceIDs.StartsWith(",") = False Then strResourceIDs = "," + strResourceIDs
                            If strResourceIDs.EndsWith(",") = False Then strResourceIDs += ","
                        Else
                            strResourceIDs = CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ResourceID"), ""), String)
                            If strResourceIDs.StartsWith(",") = False Then strResourceIDs = "," + strResourceIDs
                            If strResourceIDs.EndsWith(",") = False Then strResourceIDs += ","
                        End If
                        'addition end

                        strSQLQuery = "EXEC usp_Sel_Project_Resources_AsPer_Role " & m_intProjectID & ", " & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("RoleID"), ""), String)
                        sbHTML.Append(CommonFunction.HTMLControls.DrawListBox("cboResource" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String), strSQLQuery, 200, , strResourceIDs, , , True))

                        If m_strControlNames = "" Then
                            m_strControlNames = CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("RoleID"), ""), String) & "," & "cboResource" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String)
                        Else
                            m_strControlNames = m_strControlNames & "|" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("RoleID"), ""), String) & "," & "cboResource" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String)
                        End If
                    Else



                        ' Modified By MahendraV On 7:29 PM 6/26/2007
                        ' IssueID (14049) :Planned Deliverable : While creating Review through Planned Deliverable only Project resources are displayed in "Reviewer" combo ?
                        ' Start_MV_6/26/2007
                        ' strSQLQuery = "EXEC usp_Sel_ProjectResources_TaskAssignment_PlanDeliverable " & m_intProjectID
                        strSQLQuery = "EXEC usp_sel_tbl_PM_RowWiseExternalApprovers " & m_intProjectID
                        ' End_MV_6/26/2007

                        sbHTML.Append(MyBase.GetResourceString("CAP_REVIEWER") & "&nbsp;<br>")

                        'Comment and modification by SuchitraP on 8-Apr-2009 for IssueID : 29972
                        'Purpose : To segregate the project and non project resources.
                        Dim GroupingColName As CommonFunctions.HTMLControls.WAF_DropDown = New CommonFunctions.HTMLControls.WAF_DropDown
                        GroupingColName.DropdownGroupingColumn = "IsExternal"
                        GroupingColName.WidthInPixel = 200
                        GroupingColName.ReturnHTML = True
                        GroupingColName.ToBeInserted = ""
                        GroupingColName.MatchFieldID = CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ResourceID"), ""), String)

                        'sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboReviewer" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String), strSQLQuery, 200, CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ResourceID"), ""), String), "", , True))
                        sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboReviewer" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String), strSQLQuery, GroupingColName))
                        'End of comment and modification by SuchitraP on 8-Apr-2009

                        'sbHTML.Append(CommonFunction.HTMLControls.DrawListBox("cboReviewer" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String), strSQLQuery, 200, , , , , True))
                        ' Start_MV_6/26/2007
                        strSQLQuery = "EXEC usp_Sel_ProjectResources_TaskAssignment_PlanDeliverable " & m_intProjectID
                        ' End_MV_6/26/2007
                        sbHTML.Append("<br>" & MyBase.GetResourceString("CAP_REVIEWEE") & "&nbsp;<br>")
                        sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboReviewee" & CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("PhaseTaskID"), ""), String), strSQLQuery, 200, CType(CommonFunction.Data.CheckIsDBNull(drTemplateData("ResourceID"), ""), String), "", , True))

                    End If
                    '==============================================================
                    'End by MahendraV on 6:52 PM 6/6/2007
                    '==============================================================
                    'Integration Ends
                    sbHTML.Append("</TD>")
                    sbHTML.Append("</TR>")

                End While
                If m_intRecordCount = 0 Then
                    m_intRecordCount = 0
                    sbHTML.Append("<TR class='clsTROdd'><Td align=""center"" colspan=9>There are no items to show in this view. </TD></TR>")
                End If
                sbHTML.Append("</TABLE>")
                sbHTML.Append("<br></DIV>")
            Else
                m_intRecordCount = 0
            End If
            CommonFunction.Data.DisposeDataReader(drTemplate)
            CommonFunction.Data.DisposeDataReader(drTemplateData)
        End If

        'Added BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452

        CommonFunction.General.WriteHTML(sbHTML.ToString)
        sbHTML = Nothing

        'End Addition By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452

    End Sub

    ' End Addition By nitinVS on 18 Feb 2005 
    ' PBNITE SP2

#End Region

#Region " Constructor "
    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PM_PlanDeliverable", "AppResources")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
#End Region

#Region "Show Page Header"
    Private Sub ShowPageHeader()
        '=====================================================================
        ' Procedure Name        : ShowPageHeader()	
        ' Purpose               : Draw HTML for page header part
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ShamkantD
        ' Created               : August 26, 2004
        ' Revisions             : NitinVS on 29 Sep 2006 for WhizibleSEM SP7 IssueID 6452
        '                         Replaced Commonfunctions.general.writeHTML With sbHTML 
        '=====================================================================
        Dim strdtStartDate As String = ""
        Dim strdtEndDate As String = ""
        'Added BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452
        Dim sbHTML As New System.Text.StringBuilder
        'End Addition By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452

        If m_dtStartDate.Trim <> "" Then
            strdtStartDate = Format(CType(m_dtStartDate, Date), "dd-MMM-yyyy")
        End If
        If m_dtEndDate.Trim <> "" Then
            strdtEndDate = Format(CType(m_dtEndDate, Date), "dd-MMM-yyyy")
        End If

        sbHTML.Append("<TABLE class=clsTABLE width='100%'>")
        sbHTML.Append("<TR class='clsTRPageCaption'><TD>" & m_strPageHeader & "</TD></TR>")
        sbHTML.Append("</TABLE>")
        ' sbHTML.Append("<table id="" cellspacing='0' width='100%' class='clsTable'><tbody><tr class='clsTRBlank'><td align='right'><b>(<img src='../../images/star.gif'> Note : )</b></td></tr></tbody></table>")

        sbHTML.Append("<br><DIV id='DivMain' style='Overflow:auto;width:100%;Height:100%'>")

        sbHTML.Append("<TABLE class=clsTable width=""100%"" style=""WIDTH: 100%"">")
        sbHTML.Append("<TR class='clsTROdd'>")
        sbHTML.Append("<Td width=""40%"" valign=""top"" align=""left"" colspan=3><b>" & m_strlblTitle & "</b>&nbsp;:&nbsp;" & m_strStudyTitle)
        sbHTML.Append("</Td>")
        sbHTML.Append("</TR>")
        sbHTML.Append("<TR class='clsTROdd'>")
        sbHTML.Append("<Td width='30%' valign=""top"" align=""left""><b>" & m_strlblStartDate & "</b>&nbsp;:&nbsp;" & strdtStartDate)
        sbHTML.Append("</Td>")
        sbHTML.Append("<Td width='30%' valign=""top"" align=""left""><b>" & m_strlblEarliestDate & "</b>&nbsp;:&nbsp;" & strdtEndDate)
        sbHTML.Append("</Td>")

        ''Commented and Added By Usha Pandit on 22-Feb-2019 Purpose::Project Work field level changes 

        'sbHTML.Append("<Td width='30%' valign=""top"" align=""left"">" & m_strlblLCE & "&nbsp;:&nbsp;" & FormatNumber(m_dblDeliverableLCE, 2))
        sbHTML.Append("<Td width='30%' valign=""top"" align=""left""><b>" & " Work (H:M) " & "</b>&nbsp;:&nbsp;" & m_strWorkHourMinute)

        ''End of Added By Usha Pandit on 22-Feb-2019 Purpose::Project Work field level changes 

        sbHTML.Append("</Td>")
        sbHTML.Append("</TR>")
        'Added BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452

        sbHTML.Append("<TR class='clsTROdd'>")
        sbHTML.Append("<Td width=""40%"" valign=""top"" align=""left"" colspan=3><b> Distribute Work In Assigned Tasks : </b>" + IIf(m_strDistributeWorkInAT_CorporateFlag = "True", "Yes", "No").ToString)
        sbHTML.Append("</Td>")
        sbHTML.Append("</TR>")

        'End Addition By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452

        sbHTML.Append("</TABLE>")
        sbHTML.Append("<TABLE class=clsTable width=""100%"" style=""WIDTH: 100%"">")
        sbHTML.Append("<TR class='clsTROdd'>")
        sbHTML.Append("<Td width='60%' valign=""top"" align=""left""><b>" & MyBase.GetResourceString("CAP_SELECTED_TEMPLATE") & "</b>&nbsp;")
        ''Added & Commented by Dipali V On 12nd Nov 2019 For Add Placeholder 
        ' strSQLQuery = "EXEC usp_Get_TemplateName_Published " & m_intProjectID
        strSQLQuery = "EXEC usp_Whizible2_Get_TemplateName_Published " & m_intProjectID
        '' End of  Added & Commented by Dipali V On 12nd Nov 2019 For Add Placeholder 
        sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTemplate", strSQLQuery, 280, CType(m_intSelectedTemplateID, String), "onchange=""javascript:Template_OnChange()""", False, True))
        sbHTML.Append(CommonFunction.HTMLControls.DrawImage("../../Images/Star.gif", , , , , , , True))
        sbHTML.Append("</Td>")

        sbHTML.Append("<Td width='40%' valign=""top"" align=""left"" style='background-color:red'><b>" & MyBase.GetResourceString("CAP_SELECTED_DATE_FORMAT") & "</b>&nbsp;")
        sbHTML.Append(m_strDateFormat.ToString())

        'strSQLQuery = "EXEC usp_Sel_GetDateFormats"
        'CommonFunctions.HTMLControls.DrawComboBox("cboDateFormat", strSQLQuery, 100, CType(m_intDateFormat, String), "onchange=DateFormat_OnChange()", True)
        'sbHTML.append("</Td>")

        sbHTML.Append("</TR>")
        sbHTML.Append("</TABLE>")

        'Modified by SachinR   on 06 Nov 2004
        'sbHTML.append("<TABLE class=clsTable width=""100%"" style=""WIDTH: 100%"">")
        'sbHTML.append("<TR class='clsTRSectionHeader'>")
        'sbHTML.append("<Td width='40%' valign=top align=left colspan=2>" & MyBase.GetResourceString("CAP_PHASE_TASKS_ACTIVITIES_FOR_TEMPLATE") & "</Td>")
        'sbHTML.append("</TR>")
        'sbHTML.append("</TABLE>")
        'Modification end

        CommonFunction.General.WriteHTML(sbHTML.ToString)
        sbHTML = Nothing

    End Sub
#End Region

#Region "Show Page Footer"
    Private Sub ShowPageFooter()
        '=====================================================================
        ' Procedure Name        : ShowPageFooter()	
        ' Purpose               : Draw HTML for page footer part
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ShamkantD
        ' Created               : August 26, 2004
        ' Revisions             : NitinVS on 28 Feb 2005 
        ' Purpose               : To Display the details of Task created based on the status of Is sub task applicable 
        '                       : NitinVS on 29 Sep 2006 for WhizibleSEM 7.0 IssueID 6452 
        '                         Replaced calls for Commonfunction.general.writehtml with sbHTML                    
        '=====================================================================
        'Added BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452
        Dim sbHTML As New System.Text.StringBuilder
        'End Addition By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452
        sbHTML.Append("<input type=hidden id=""txtRecordCount"" name=""txtRecordCount"" value=" & m_intRecordCount & ">")
        sbHTML.Append("<input type=""hidden"" ID=""txtControlNames"" Name=""txtControlNames"" value=" & m_strControlNames & ">")

        'Added by ShamkantD on 4 Dec 2004
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtIncrementMinutes", "txtIncrementMinutes", value:=m_dblIncrementMinutes.ToString(), IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        'End of addition - ShamkantD on 4 Dec 2004

        ' Added By NitinVS on 28 Feb 2005 
        ' Added Notes about Task Creation Process 
        If m_intSelectedTemplateID.Trim = "" Then
            sbHTML.Append("<br><DIV id='DivList' style='Overflow:visible;width=100%;Height:100%'>")
            sbHTML.Append("</div>")
        End If

        sbHTML.Append("<I> ")
        sbHTML.Append("<TABLE class=""clsTable notebox"" style=""WIDTH: 100%"">")
        sbHTML.Append("<tr class='clsTROdd'><td style='background: #e7edf0!important;font-size: 12px!important;padding: 12px!important;
    border-radius: 4px!important;'>")
        sbHTML.Append("<EM><STRONG>Note : </STRONG> " + MyBase.GetResourceString("NOTE_1") + "</EM> ")
        sbHTML.Append("<BR> " + MyBase.GetResourceString("NOTE_2"))
        sbHTML.Append("</td></tr></table>")
        sbHTML.Append("</I> ")
        sbHTML.Append("</div>")


        CommonFunction.General.WriteHTML(sbHTML.ToString)
        sbHTML = Nothing
    End Sub
#End Region

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        ' Added by MahendraV On 6:13 PM 6/29/2007 For WhizibleSEM 7
        ' Hide 'Save' link on its click for static menu (avoid duplicate entries)
        ' Start_MV_6/29/2007
        If Args.FunctionName = "CreateAssignedTasks_OnClick()" Then
            If m_blnIsTopMenu = True Then
                Args.OtherProperties = "id='MENU_CREATE_TASKSUP'" 'Top Menu link
                m_blnIsTopMenu = False
            Else
                Args.OtherProperties = "id='MENU_CREATE_TASKSDN'" 'Bottom Menu link 
            End If
        Else
            Args.OtherProperties = ""
        End If
        ' End_MV_6/29/2007
    End Sub

    Private Sub m_objMenu_Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_Menu) Handles m_objMenu.Initialize
        ' Added by MahendraV On 6:13 PM 6/29/2007 For WhizibleSEM 7
        ' Hide 'Save' link on its click for static menu (avoid duplicate entries)
        ' Start_MV_6/29/2007
        Args.LinkSeperator = ""
        ' End_MV_6/29/2007
    End Sub
End Class

