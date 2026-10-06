'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  PbNITE
' Module Name           :  PM_TaskStatusManagement.aspx
' Purpose               :  
' Description           :  
' Dependencies          :  None
' Author                :  PrakashR
' Reviewed              :  
' Tested                :  
' Created               :  
' Revisions             :  
'=====================================================================

#Region "Imports"
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
#End Region

Public Class PM_TaskStatusManagement
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load

        'Initialize the Global Objects
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

        Initialize()
    End Sub
    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region "Constants"

    '--- Constants for the Task Types
    Private Const TASK_TYPE_ASSIGNED As String = "O"
    Private Const TASK_TYPE_MPP As String = "M"
    Private Const TASK_TYPE_ISSUE As String = "B"
    Private Const TASK_TYPE_REVIEW As String = "R"
    'Intigrated by Harshk for sp4 issueid 219
    Private Const TASK_TYPE_HELPDESK As String = "H"
    'End Intigrated by Harshk for sp4 issueid 219

    Private Const OPERATION_VOID_TASKS As Integer = 1
    Private Const OPERATION_VALID_TASKS As Integer = 2
    Private Const OPERATION_BILLABEL_TASKS As Integer = 3
    Private Const OPERATION_NONBILLABEL_TASKS As Integer = 4
    Private Const OPERATION_ONHOLD_TASKS As Integer = 5
    Private Const OPERATION_REMOVE_ONHOLD_TASKS As Integer = 6
    Private Const OPERATION_REOPEN_TASKS As Integer = 7
    'Added by ArchanaN on 6-aug-2008 for Project Profitability
    Private Const OPERATION_ACCRUAL_PRORATA As Integer = 9
    Private Const OPERATION_ACCRUAL_ONCOMPLETION As Integer = 10
    'END OF Added by ArchanaN on 6-aug-2008 for Project Profitability
    Private Const OPERATION_SET_BASELINE As Integer = 11
    Private Const OPERATION_CLEAR_BASELINE As Integer = 12
    Private Const OPERATION_SAVE_PERCENTCOMPLETE As Integer = 13
    '--- Constants for Mode
    Private Const MODE_LIST As String = "List"
    Private Const MODE_SAVE As String = "Save"


#End Region


#Region "Member Variables"
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu    'This variable is used for plotting static menu. 
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid   'This variable is use to plotting grid.

    Private m_objGlobal As IGlobal
    Private m_objAccessRights As cAccessRights
    Protected m_lngTagId As Long = 0

    Private strMenu As String                           'stores the static menu string.
    Protected m_strTaskType As String                     'Stores the Task Type
    Protected m_dtFromDate As String                    'From Date
    Protected m_dtToDate As String                      'To Date
    Private m_intProjectID As Integer                   'Project ID
    Private m_intOperation As Integer                   'Operation To be Performed
    Private m_blnUseClientDateForDA As Boolean
    Private m_intParentTask_UID As Integer
    Protected m_intCount As Integer
    Private m_strMode As String                         'Mode

    Protected m_TaskIDs As String                         'list of TaskIDs
    Protected m_CheckedTaskIDs As String                         'list of TaskIDs
    'Intigrated by harshk for issueid 190
    Public m_CheckboxIDs As String
    Private m_intEmployeeID As Integer                  'Employee ID
    'End Intigrated by harshk for issueid 190

    Protected m_FilterDivStatus As Boolean = True  'Added by ShubhadaL
    Protected m_btRestrictDurationChange_M As Boolean 'Added by KapilK On 11-Sep-08
    Protected m_intMSPIntegrationMethod As Integer 'Added by KapilK On 11-Sep-08
    Protected m_strProjectStartDate As String
    Protected m_strProjectEndDate As String
    Protected m_strParentTask_UID As String = ""
#End Region



    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        :   PageInit
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To draw all controls on the page
        ' Description           :   This is main procedure on this page which actually draw the page with its 
        '                           controls on it. This procedure is called from the HTML body tag of the page.
        '                           this procedure gives the call to other procedures and functions in the class.
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   PrakashR
        ' Created               :   
        ' Revisions             :   
        '=====================================================================
        Dim objHeaderFooter As WebPages.Template.HeaderFooter
        Call GetGlobalObject()

        'Added by ShubhadaL 

        If (Request.Form("hidFilterDivStatus") & "") = "Open" Or (Request.Form("hidFilterDivStatus") & "") = "" Then
            m_FilterDivStatus = True
        Else
            m_FilterDivStatus = False
        End If
        'End addition by ShubhadaL
        DrawMenu()
        CommonFunctions.General.WriteHTML(strMenu)
        'CommonFunctions.General.WriteHTML("<BR>")
        DrawHeader()


        Response.Write("<DIV Id='PageDiv' Style='width:100%;overflow:auto;height=420px'>")

        '--- Display filters for selection
        DisplaySelectionHeader()

        '--- Display Grid with tasks for updation
        'Response.Write("<DIV Id='PageDiv' Style='Width:100%;OverFlow:auto;Height=100px'>")
        DisplayGrid()
        Response.Write("</DIV>")

        'Display the Menu at the Bottom
        'CommonFunctions.General.WriteHTML("<BR>")
        'CommonFunctions.General.WriteHTML(strMenu)
        'CommonFunctions.General.WriteHTML("<BR>")
        'Display the Page Footer
        objHeaderFooter = New WebPages.Template.HeaderFooter
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
        objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        objHeaderFooter = Nothing
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)


    End Sub

    Private Sub Initialize()

        Dim strSQLQuery As String
        Dim dtFromDate As Date
        Dim drDates As IDataReader
        Dim strTaskIDs As String

        '--- Get the Mode
        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"))

        If m_strMode = "" Then
            m_strMode = MODE_LIST
        End If




        '--- From Date
        m_dtFromDate = Request.QueryString("FromDate")

        '--- To Date
        m_dtToDate = Request.QueryString("ToDate")

        '--- ProjectID
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID")) <> "" Then
            m_intProjectID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID")), Integer)
        Else
            m_intProjectID = CInt(Session("intProjectID"))
        End If

        'Intigrate by harshk for sp4 issueid 190
        'Purpose - To Fetch EmployeeID from QueryString
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("EmployeeID")) <> "" Then
            m_intEmployeeID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("EmployeeID")), Integer)
        End If
        'End 'Intigrate by harshk for sp4 issueid 190

        'Passing Operation as part of QueryString

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Operation")) <> "" Then
            m_intOperation = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("Operation")), Integer)
        Else
            m_intOperation = 1
        End If
        '--- Gets information from the Querystring
        '--- Task Type
        m_strTaskType = CommonFunctions.General.CheckIsNothing(Request.QueryString("TaskType"), TASK_TYPE_ASSIGNED)
        'Code added by KapilK on 11-09-08[To Read the project & company setting ]
        Dim drProjectCompanySetting As IDataReader

        drProjectCompanySetting = CommonFunctions.Data.GetDataReader("usp_sel_Project_CompanySetting " & m_intProjectID, True)

        While drProjectCompanySetting.Read
            m_btRestrictDurationChange_M = CommonFunctions.Data.CheckIsDBNull(drProjectCompanySetting("RestrictDurationChange_M"))
            m_intMSPIntegrationMethod = CType(CommonFunctions.Data.CheckIsDBNull(drProjectCompanySetting("MSPIntegrationMethod")), Integer)
            m_strProjectStartDate = CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drProjectCompanySetting("ProjectStartDate")), Date))
            m_strProjectEndDate = CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drProjectCompanySetting("ProjectEndDate")), Date))
        End While
        DisposeDataReader(drProjectCompanySetting)

        'End;Code added by KapilK on 11-09-08[To Read the project & company setting ]

        If m_strMode = MODE_SAVE Then
            ''Modified By PrashantD on 16 Sept 2005
            '' Purpose: Logic changed. TaskIDs are coming through form value rather than queryString
            ''          and with 4000 string breaks.

            ''strTaskIDs = CommonFunctions.General.CheckIsNothing(Request.QueryString("TaskIDs"), "")

            ' Modified by NitinVS on 10 July 2007 for WhizibleSEM 7 
            ' To Validate for Project Efforts validation for Reopend tasks. i.e. total of reopened tasks should not exceed balance hrs on project
            Dim strbalanceHrsMessage As String = ""
            If m_intOperation = OPERATION_VALID_TASKS Then


                Dim intTaskIDs_Break As Integer = 0
                Dim TaskID As String
                Dim strPreviousReopendEfforts As String = "0"

                strTaskIDs = ""
                Dim objDRValidateEffort As IDataReader
                Dim strProjectHrs As String = ""
                Dim strProjectAllocatedHrs As String = ""

                ' Get Project Balance hrs 
                objDRValidateEffort = CommonFunction.Data.GetDataReader("usp_Sel_PM_DepartmentBalanceLCE " + m_intProjectID.ToString(), MyBase.UseSQL)
                If objDRValidateEffort.Read() Then
                    strProjectHrs = CommonFunction.Data.CheckIsDBNull(objDRValidateEffort.Item("LCETotal"), "").ToString()
                    strProjectAllocatedHrs = CommonFunction.Data.CheckIsDBNull(objDRValidateEffort.Item("AllocatedLCETotal"), "").ToString()
                End If

                CommonFunction.Data.DisposeDataReader(objDRValidateEffort)

                While (Request.Form("strTaskIDs" + CStr(intTaskIDs_Break)) <> "")

                    strTaskIDs = Request.Form("strTaskIDs" + CStr(intTaskIDs_Break))
                    If strTaskIDs.LastIndexOf(",") <> strTaskIDs.Length - 1 Then
                        strTaskIDs = TaskID + strTaskIDs
                        TaskID = ""
                        TaskID = strTaskIDs.Substring(strTaskIDs.LastIndexOf(",") + 1)
                        strTaskIDs = strTaskIDs.Substring(0, strTaskIDs.LastIndexOf(",") + 1)
                    Else
                        strTaskIDs = TaskID + Request.Form("strTaskIDs" + CStr(intTaskIDs_Break))
                        TaskID = ""
                    End If
                    intTaskIDs_Break += 1

                    objDRValidateEffort = CommonFunction.Data.GetDataReader("usp_sel_ValidateReopendTasksEffors " + m_intProjectID.ToString() + "," + strProjectHrs + "," + strProjectAllocatedHrs + " , '" + strTaskIDs + "'," + strPreviousReopendEfforts, MyBase.UseSQL)

                    If objDRValidateEffort.Read() Then
                        strPreviousReopendEfforts = CommonFunction.Data.CheckIsDBNull(objDRValidateEffort.Item("ReopenedEffors"), "0").ToString()
                        strbalanceHrsMessage = CommonFunction.Data.CheckIsDBNull(objDRValidateEffort.Item("BalanceHrsMessage"), "").ToString()
                    End If

                    CommonFunction.Data.DisposeDataReader(objDRValidateEffort)

                    ' If Total Effors is exceed balance efforts alert and skip save. 
                    If strbalanceHrsMessage <> "" Then
                        Response.Write("<script language='javascript'>")
                        Response.Write(" alert(""" + strbalanceHrsMessage + """);")
                        Response.Write("</script>")
                        Exit While
                    End If
                    ' Validate for Efforts of reopend tasks to available efforts 

                End While

            End If

            ' If Mark as active efforts are not greater than project balance efforts then perform the action.
            If strbalanceHrsMessage = "" Then

                Dim Form_TaskIDs_Break As Integer = 0
                Dim LastTaskID As String
                strTaskIDs = ""
                While (Request.Form("strTaskIDs" + CStr(Form_TaskIDs_Break)) <> "")

                    strTaskIDs = Request.Form("strTaskIDs" + CStr(Form_TaskIDs_Break))
                    If strTaskIDs.LastIndexOf(",") <> strTaskIDs.Length - 1 Then
                        strTaskIDs = LastTaskID + strTaskIDs
                        LastTaskID = ""
                        LastTaskID = strTaskIDs.Substring(strTaskIDs.LastIndexOf(",") + 1)
                        strTaskIDs = strTaskIDs.Substring(0, strTaskIDs.LastIndexOf(",") + 1)
                    Else
                        strTaskIDs = LastTaskID + Request.Form("strTaskIDs" + CStr(Form_TaskIDs_Break))
                        LastTaskID = ""
                    End If
                    Form_TaskIDs_Break += 1
                    UpdateTasks(strTaskIDs)
                End While

                'UpdateTasks(strTaskIDs)
                ''End of Modification By PrashantD on 16 Sept 2005
            End If

            'End Modification By NitinVS on 10 july 2007 for WhizibleSEM 7 

            m_strMode = MODE_LIST
        End If

        ' to solve the issue - When Date Range is given say 1-Jan to 31st May it still shows the Week 1-Jan to 7-Jan 
        ' after post back .
        'Modified by Manishk on 23th Feb 06 For SP6 IssueID 2245
        'If (Request.QueryString("Weekly") = "True" Or (Request.QueryString("Weekly") = "") And Request.QueryString("FromDate") = "" And Request.QueryString("ToDate") = "") Then
        If (Request.QueryString("Weekly") = "True" Or (Request.QueryString("Weekly") = "") And Request.QueryString("FromDate") = "" Or Request.QueryString("ToDate") = "") Then
            'End of Modified by Manishk on 23th Feb 06 For SP6 IssueID 2245
            If Request.QueryString("FromDate") = "" Or Request.QueryString("FromDate") Is Nothing Then
                If m_blnUseClientDateForDA = True Then
                    dtFromDate = CType(Session("ClientDate"), Date)
                Else
                    dtFromDate = Now()
                End If

            Else
                dtFromDate = CType(m_dtFromDate, Date)
            End If

            'm_dtFromDate = CommonFunctions.Dates.GetDate(CDate(dtFromDate.AddDays((dtFromDate).DayOfWeek * (-1I) + intFirstDay)))
            'm_dtToDate = CommonFunctions.Dates.GetDate(CDate(DateAdd("d", 6, CType(m_dtFromDate, Date))))

            '--- Get the StartingDayOfWeek
            If dtFromDate.ToString <> "" Then
                ''Commented and Modified By Viraj Pansare on 17-nov-2015 Purpose: to change the date  format
                'strSQLQuery = "EXEC usp_Get_WeekDates '" + FormatDateTime(dtFromDate, DateFormat.ShortDate).ToString + "'"

                strSQLQuery = "EXEC usp_Get_WeekDates '" + Format(CType(FormatDateTime(dtFromDate, DateFormat.ShortDate), Date), "MM/dd/yyyy") + "'"

                ''End of Commented and Modified By Viraj Pansare on 17-nov-2015 Purpose: to change the date  format
                drDates = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If drDates.Read Then
                    'm_dtFromDate = CommonFunctions.Dates.GetDate(CType(drDates("StartDate"), Date))
                    m_dtFromDate = drDates.Item("StartDate").ToString()
                    m_dtFromDate = CommonFunctions.Dates.GetDate(CType(m_dtFromDate, Date))
                    m_dtToDate = CommonFunctions.Dates.GetDate(CDate(DateAdd("d", 6, CType(m_dtFromDate, Date))))
                End If
                CommonFunctions.Data.DisposeDataReader(drDates)
            End If


        End If

    End Sub

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        :  GetGlobalObject
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To get an instance of the global object
        ' Description           :  This sub-routine fills the global object and 
        '                          gets the Tag ID
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrakashR
        ' Created               :  
        ' Revisions             :  
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngTagId = m_objGlobal.TagID
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

        arrMenuList.Add(MyBase.GetResourceString("MENU_SAVE"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
        arrClientSideFunctionList.Add("Save_OnClick()")

        arrMenuList.Add(MyBase.GetResourceString("MENU_PREVIOUS_WEEK"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_PREVIOUS_WEEK_TOOLTIP"))
        arrClientSideFunctionList.Add("PreviousWeek_OnClick()")

        arrMenuList.Add(MyBase.GetResourceString("MENU_NEXT_WEEK"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_NEXT_WEEK_TOOLTIP"))
        arrClientSideFunctionList.Add("NextWeek_OnClick()")

        'Intigrated by Harshk for sp4 issueid 190
        m_CheckboxIDs = ""
        arrMenuList.Add(MyBase.GetResourceString("MENU_SELECT_ALL"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_SELECT_ALL_TOOLTIP"))
        arrClientSideFunctionList.Add("SelectAll_OnClick()")

        arrMenuList.Add(MyBase.GetResourceString("MENU_CLEAR_ALL"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_CLEAR_ALL_TOOLTIP"))
        arrClientSideFunctionList.Add("ClearAll_OnClick()")
        'End 'Intigrated by Harshk for sp4 issueid 190

        arrMenuList.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        'intigrated by harshk for sp4 issueid 219
        arrClientSideFunctionList.Add("Help_OnClick('TSM')")
        'End intigrated by harshk for sp4 issueid 219
        'Create the static menu.
        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipList), True)

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
        strReturn = objHeader.DrawHeaderFooter(m_objGlobal, True)
        If strReturn <> "" Then
            Response.Write(strReturn)
        End If
        objHeader = Nothing

    End Sub

    Private Sub DisplaySelectionHeader()
        Dim blnIsChecked As Boolean
        Dim strSQLQuery As String
        Dim objDynamicLink As WebPages.UI.cDynamicLink

        '--- Query for displaying the Projects in Project combo
        'Commented by MrugajaB on 29th May 2005
        'This sp will be replaced by another sp in which project combo will display only those projects 
        'for which logged in user has access to 'Task Status Management' node

        'Modified By VidyaJ - SP4 - IssueID - 362
        Dim intRoleLevel As Integer
        Dim m_strProjectFilters As String
        intRoleLevel = CType(CommonFunctions.General.CheckIsNothing(Session("intRoleLevel"), "0"), Integer)
        m_strProjectFilters = ""
        'If middle level then apply filter for Projects
        If intRoleLevel = 2 Then
            'Apply Role Access Filter for Project List
            m_strProjectFilters = ""
            Dim strFilter As String = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
            If strFilter <> "" Then
                m_strProjectFilters += strFilter
            End If

            Dim strRemove As String = "ProjectID IN"
            m_strProjectFilters = m_strProjectFilters.Remove(0, strRemove.Length)

            m_strProjectFilters = m_strProjectFilters.Replace("'", "")
        End If



        'strSQLQuery = "EXEC usp_Sel_Project_For_DA_Active_InActive_Projects " + CType(Session("intUserID"), String) + ",NULL,NULL"

        'Modified by MrugajaB for Issue ID.686 on 18th Feb 2006
        'Purpose:SP which is used for displaying projects is changed

        'Added by MrugajaB on 29th May 2005
        'If m_strProjectFilters <> "" Then
        'strSQLQuery = "EXEC usp_sel_Projects_forTaskStatusManagement " + CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        'Else
        '   strSQLQuery = "EXEC usp_sel_Projects_forTaskStatusManagement " + CType(Session("intUserID"), String)
        'End If

        'Comment and modification by SuchitraP on 16-Jan-2009 for IssueID : 26593
        'Purpose : To show only open projects in Project combo
        'strSQLQuery = "EXEC usp_Sel_AccessibleProjects_ForEmployee " + CType(Session("intUserID"), String) & ",0,0,0,0,'" & CType(Session("LoginType"), String) & "',0," & CType(Session("intLoginID"), Long) & ",1,1"
        strSQLQuery = "EXEC usp_Sel_AccessibleProjects_ForEmployee " + CType(Session("intUserID"), String) & ",0,0,0,0,'" & CType(Session("LoginType"), String) & "',0," & CType(Session("intLoginID"), Long) & ",1,0"
        'End of Comment and modification by SuchitraP on 16-Jan-2009

        'End Addition

        'End Modification

        '--- Display the Page Caption

        CommonFunctions.General.WriteHTML("<TABLE width=99.9% CellSpacing=0 class='clsTable'><TR class=clsTRBlank><TD align='Right'><B>(<IMG src='../../Images/Star.gif' border=0> Mandatory)</B> </TD></TR></TABLE>")
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("HEADING_TASK_STATUS_MANAGEMENT"), , , True))

        'Added by ShubhadaL on 2 Feb,2006 
        'Purpose: Added a DIV section for all filters
        'CommonFunctions.General.WriteHTML("<TABLE width=100% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:showHide_div()""><Img Border=0 id=imgShowHide Src='../../Images/minus.gif' title=''></A>&nbsp;&nbsp; " & MyBase.GetResourceString("TASK_FILTERS_DIV") & " </TD></TR></TABLE>")
        'CommonFunctions.General.WriteHTML("<DIV id='Show' name='Show' height=50 style=""overflow:auto;display:''"">")
        If m_FilterDivStatus = True Then
            CommonFunctions.General.WriteHTML("<input type=hidden name=hidFilterDivStatus id=hidFilterDivStatus value='Open' />")
            CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:showHide_div()""><Img Border=0 id=imgShowHide Src='../../Images/minus.gif' title=''></A>&nbsp;&nbsp; " & MyBase.GetResourceString("TASK_FILTERS_DIV") & " </TD></TR></TABLE>")
            CommonFunctions.General.WriteHTML("<DIV id='Show' name='Show' height=20 style=""overflow:auto;display:''"">")
        Else
            CommonFunctions.General.WriteHTML("<input type=hidden name=hidFilterDivStatus id=hidFilterDivStatus value='Close' />")
            'Modified by ShraddhaM on Date 21 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:showHide_div()""><Img Border=0 id=imgShowHide Src='../../Images/plus.gif' title=''></A>&nbsp;&nbsp; " & MyBase.GetResourceString("TASK_FILTERS_DIV") & " </TD></TR></TABLE>")
            CommonFunctions.General.WriteHTML("<DIV id='Show' name='Show' height=20 style=""overflow:auto;display:'none'"">")
        End If

        'End of Addition by ShubhadaL on 2 Feb 2006

        '--- Display the Project combo, dates 
        'Modified by ShraddhaM on Date 21 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")

        '--- Project Combo
        CommonFunctions.General.WriteHTML("<tr class='clsTREven' Width='100%'>")
        'modified by harshk for sp4 issueid 190
        CommonFunctions.General.WriteHTML("<td align='Left' width=60%>")
        'End 'modified by harshk for sp4 issueid 190
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LABEL_SELECT_PROJECT"))
        CommonFunctions.General.WriteHTML("&nbsp;&nbsp;")
        'CommonFunctions.General.WriteHTML("&nbsp;&nbsp;")
        'CommonFunctions.General.WriteHTML("</td>")
        'CommonFunctions.General.WriteHTML("<td align='Left'>")
        CommonFunctions.HTMLControls.DrawComboBox("cboProject", strSQLQuery, 320, CType(m_intProjectID, String), "")
        CommonFunctions.General.WriteHTML("</td>")
        'Commented by ManishK on 22th Feb 06 for SP6 issueID 2374
        'CommonFunctions.General.WriteHTML("</tr>")
        'End of Commented by ManishK on 22th Feb 06 for SP6 issueID 2374
        'Added by SandeepA on 18 Nov,2005 for IssueID-686 : Task Completion Status
        'Purpose : Check Task Filter.('Show ALL Tasks' or 'Show Tasks For Period')
        Dim blnChecked As Boolean
        Dim strTaskFilter As String
        'Check Task Filter
        ''Modified by Manishk on 16th Feb 2006 for WhizibleSem Sp6 IssueID =2171
        'strTaskFilter = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("optMainTaskFilter"), "1")
        strTaskFilter = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("optMainTaskFilter"), "2")
        ''End Of Modified by Manishk on 16th Feb 2006 for WhizibleSem Sp6 IssueID =2171
        If strTaskFilter = "2" Then
            strTaskFilter = " NULL "
            blnChecked = False
        Else
            blnChecked = True
        End If
        'End of addition by SandepA on 18 Nov,2005 for IssueID-686

        'Commented by ShubhadaL
        ''Date Filters
        'CommonFunctions.General.WriteHTML("<td align='Left'>")
        ''Added by SandeepA on 18 Nov,2005 for IssueID-686 : Task  Status
        ''Purpose: Add SPAN tag so as to hide the FromDate and ToDate controls
        ''******************************************************************************
        ''Commented by Shubhadal on 2 Feb 2006 to show date controls irrespective of radio button selected.
        ''******************************************************************************
        ''If strTaskFilter = " NULL " Then
        ''    CommonFunctions.General.WriteHTML("<Span id=""FromDate"" name=""FromDate"" style=""visibility:visible"">")
        ''Else
        ''    CommonFunctions.General.WriteHTML("<Span id=""FromDate"" name=""FromDate"" style=""visibility:hidden"">")
        ''End If
        '''End of addition by SandeepA on 18 Nov,2005 for IssueID-686
        ''******************************************************************************
        ''End commenting by ShubhadaL on 2 Feb 2006 to show date controls irrespective of radio button selected.
        ''******************************************************************************
        'CommonFunctions.General.WriteHTML("<Span id=""FromDate"" name=""FromDate"" style=""visibility:visible"">")
        'CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LABEL_FROM_DATE"))
        'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , , m_dtFromDate, , "frmPM_TaskStatusManagement", returnHTML:=True, IsMandatory:=True))
        ''Added by SandeepA on 18 Nov,2005 for IssueID-686 : Task Completion Status
        ''Purpose: End of SPAN tag


        'CommonFunctions.General.WriteHTML("</Span>")
        ''End of addition by SandeepA on 18 Nov,2005 for IssueID-686
        'CommonFunctions.General.WriteHTML("</td>")
        'CommonFunctions.General.WriteHTML("<td align='Left'>")
        ''******************************************************************************
        ''Commented by Shubhadal on 2 Feb 2006 to show date controls irrespective of radio button selected.
        ''******************************************************************************
        '''Added by SandeepA on 18 Nov,2005 for IssueID-686 : Task  Status
        '''Purpose: Add SPAN tag so as to hide the FromDate and ToDate controls
        ''If strTaskFilter = " NULL " Then
        ''    CommonFunctions.General.WriteHTML("<Span id=""ToDate"" name=""ToDate"" style=""visibility:visible"">")
        ''Else
        ''    CommonFunctions.General.WriteHTML("<Span id=""ToDate"" name=""ToDate"" style=""visibility:hidden"">")
        ''End If
        '''End of addition by SandeepA on 18 Nov,2005 for IssueID-686
        ''******************************************************************************
        ''End commenting by ShubhadaL on 2 Feb 2006
        ''******************************************************************************
        'CommonFunctions.General.WriteHTML("<Span id=""ToDate"" name=""ToDate"" style=""visibility:visible"">")
        'CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LABEL_TO_DATE"))
        'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , m_dtToDate, , "frmPM_TaskStatusManagement", returnHTML:=True, ISmandatory:=True))
        ''Added by SandeepA on 18 Nov,2005 for IssueID-686 : Task Status
        ''Purpose: End of SPAN Tag.
        'CommonFunctions.General.WriteHTML("</Span>")
        ''End of addition by SandeepA on 18 Nov,2005 for IssueID-686
        'CommonFunctions.General.WriteHTML("</td>")
        'CommonFunctions.General.WriteHTML("</tr>")
        ''CommonFunctions.General.WriteHTML("</TABLE>")
        'End commenting by SHubhadaL


        '--- Display the Operation and Task Type Filter
        'CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=100% class=clsTable>")

        'Displaying main Filter
        'Intigrated by harshk for sp4 issueid 190
        'Commented by ShubhadaL
        'CommonFunctions.General.WriteHTML("<td align='Left'>")
        'CommonFunctions.General.WriteHTML("Select Operation")
        'CommonFunctions.General.WriteHTML("&nbsp;")
        'CommonFunctions.HTMLControls.DrawComboBox("cboOperation", "usp_sel_operation_forTaskStatusManagement", , CType(m_intOperation, String), "", True)
        'CommonFunctions.General.WriteHTML("</td>")
        'strSQLQuery = "EXEC usp_Sel_teammembers " & CType(m_intProjectID, String)
        'CommonFunctions.General.WriteHTML("<td align='Left' colspan=2>")
        'CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LABEL_SELECT_RESOURCE"))
        'CommonFunctions.General.WriteHTML("&nbsp;")
        'CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", strSQLQuery, 200, CType(m_intEmployeeID, String), "", True)
        'CommonFunctions.General.WriteHTML("</td>")
        'End Intigrated by harshk for sp4 issueid 190
        'End by ShubhadaL


        'Added by ShubhadaL
        'Purpose
        'Commented by ManishK on 22th Feb 06 for SP6 issueID 2374
        'CommonFunctions.General.WriteHTML("<tr class='clsTREven' width = '100%'>")
        'End of Commented by ManishK on 22th Feb 06 for SP6 issueID 2374
        ' CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        strSQLQuery = "EXEC usp_Sel_teammembers " & CType(m_intProjectID, String)
        CommonFunctions.General.WriteHTML("<td align='Left' width=8%>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LABEL_SELECT_RESOURCE"))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='Left'width=32%>")
        CommonFunctions.General.WriteHTML("&nbsp;")
        CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", strSQLQuery, 210, CType(m_intEmployeeID, String), "", True)
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")

        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='Left' colspan=4>")
        'CommonFunctions.General.WriteHTML("&nbsp;")
        'Modified by Manishk on 22th Feb 2006 for The SP6 IssueID 2374
        'CommonFunctions.General.WriteHTML("Select Operation")
        CommonFunctions.General.WriteHTML("Action")
        'End of Modified by Manishk on 22th Feb 2006 for The SP6 IssueID 2374
        CommonFunctions.General.WriteHTML("&nbsp;")
        CommonFunctions.General.WriteHTML("&nbsp;&nbsp;")
        CommonFunctions.HTMLControls.DrawComboBox("cboOperation", "usp_sel_operation_forTaskStatusManagement", , CType(m_intOperation, String), "", True)
        ''Added By ManishK on 16th Feb 2006 for the WhizibleSem sp6 2178
        CommonFunctions.General.WriteHTML("<IMG id=Star name=Star display='none' src='../../Images/Star.gif' border=0>")
        ''End of Added By ManishK on 16th Feb 2006 for the WhizibleSem sp6 2178
        CommonFunctions.General.WriteHTML("</td>")
        'End by ShubhadaL
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</table>")

        'Added By SandeepA on 18 Nov,2005 for IssueID-686
        'Purpose: Plot the 'Show All Tasks' and 'Show Tasks For Period' option buttons
        CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
        CommonFunctions.General.WriteHTML("<tr class='clsTREven' width = '100%'><td align='Left' colspan=1>")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optMainTaskFilter", "optAllTasks", , blnChecked, CStr("1"), , " language=Javascript OnClick=optTasks_OnClick(""ShowALL"") ", True))
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SHOW_ALL_TASKS"))

        If blnChecked = False Then
            blnChecked = True
        Else
            blnChecked = False
        End If

        CommonFunctions.General.WriteHTML("&nbsp;")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optMainTaskFilter", "optTasksForTheWeek", , blnChecked, CStr("2"), , " language=JavaScript OnClick=optTasks_OnClick(""ShowWeekly"") ", True))
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SHOW_TASKS_FOR_PERIOD"))
        CommonFunctions.General.WriteHTML("</td>")
        'CommonFunctions.General.WriteHTML("</tr>")
        'End of Addition by SandeepA on 18 Nov,2005 for IssueID-686

        'Added by ShubhadaL

        'Date Filters
        CommonFunctions.General.WriteHTML("<td align='Left'>")
        'Added by SandeepA on 18 Nov,2005 for IssueID-686 : Task  Status
        'Purpose: Add SPAN tag so as to hide the FromDate and ToDate controls
        '******************************************************************************
        'Commented by Shubhadal on 2 Feb 2006 to show date controls irrespective of radio button selected.
        '******************************************************************************
        'If strTaskFilter = " NULL " Then
        '    CommonFunctions.General.WriteHTML("<Span id=""FromDate"" name=""FromDate"" style=""visibility:visible"">")
        'Else
        '    CommonFunctions.General.WriteHTML("<Span id=""FromDate"" name=""FromDate"" style=""visibility:hidden"">")
        'End If
        ''End of addition by SandeepA on 18 Nov,2005 for IssueID-686
        '******************************************************************************
        'End commenting by ShubhadaL on 2 Feb 2006 to show date controls irrespective of radio button selected.
        '******************************************************************************
        CommonFunctions.General.WriteHTML("<Span id=""FromDate"" name=""FromDate"" style=""visibility:visible"">")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LABEL_FROM_DATE"))
        'Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4192
        '***** Modified by SandipL On 16 May 2006 for WhizEnggSP6 IssueID 3748
        'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , 80, CType(m_dtFromDate, Date).ToString, , "frmPM_TaskStatusManagement", returnHTML:=True, IsMandatory:=False))
        'Commented And Added By Usha Pandit On 07.05.2020 For Invalid Date format related issue
        'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , 80, CType(m_dtFromDate, Date).ToString("dd-MMM-yyyy"), , "frmPM_TaskStatusManagement", returnHTML:=True, IsMandatory:=False))
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , 80, CommonFunctions.Dates.GetDate(CType(m_dtFromDate, Date)), , "frmPM_TaskStatusManagement", returnHTML:=True, IsMandatory:=False))
        'End Of Added By Usha Pandit On 07.05.2020 For Invalid Date format related issue
        '***** End Modification by SandipL on 16 May 2006
        'End Integration

        'Added by ShubhadaL on 7 Feb 2006 to Hide * mark if ShowAll is clicked else show it.
        CommonFunctions.General.WriteHTML("<IMG id=StarID name=idStarID display='none' src='../../Images/Star.gif' border=0>")
        'End addition by ShubhadaL on 7 Feb 2006
        'Added by SandeepA on 18 Nov,2005 for IssueID-686 : Task Completion Status
        'Purpose: End of SPAN tag

        CommonFunctions.General.WriteHTML("</Span>")
        'End of addition by SandeepA on 18 Nov,2005 for IssueID-686
        'Code addd by KapilK on 11-09-08 

        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        CommonFunction.HTMLControls.DrawTextBox("txtProjectStartDate", "txtProjectStartDate", , , , m_strProjectStartDate, , , , , , True, EnableHTMLEncode:=True)
        '''End of Modification by Dhanashri S on 7 Oct 2015

        'End;Code addd by KapilK on 11-09-08
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='Left'>")
        '******************************************************************************
        'Commented by Shubhadal on 2 Feb 2006 to show date controls irrespective of radio button selected.
        '******************************************************************************
        ''Added by SandeepA on 18 Nov,2005 for IssueID-686 : Task  Status
        ''Purpose: Add SPAN tag so as to hide the FromDate and ToDate controls
        'If strTaskFilter = " NULL " Then
        '    CommonFunctions.General.WriteHTML("<Span id=""ToDate"" name=""ToDate"" style=""visibility:visible"">")
        'Else
        '    CommonFunctions.General.WriteHTML("<Span id=""ToDate"" name=""ToDate"" style=""visibility:hidden"">")
        'End If
        ''End of addition by SandeepA on 18 Nov,2005 for IssueID-686
        '******************************************************************************
        'End commenting by ShubhadaL on 2 Feb 2006
        '******************************************************************************
        CommonFunctions.General.WriteHTML("<Span id=""ToDate"" name=""ToDate"" style=""visibility:visible"">")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LABEL_TO_DATE"))

        'Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4192
        '***** Modified by SandipL On 16 May 2006 for WhizEnggSP6 IssueID 3748
        'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , CType(m_dtToDate, Date).ToString, , "frmPM_TaskStatusManagement", returnHTML:=True, ISmandatory:=False))
        'Commented And Added By Usha Pandit On 07.05.2020 For Invalid Date format related issue
        'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , CType(m_dtToDate, Date).ToString("dd-MMM-yyyy"), , "frmPM_TaskStatusManagement", returnHTML:=True, ISmandatory:=False))
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , CommonFunctions.Dates.GetDate(CType(m_dtToDate, Date)), , "frmPM_TaskStatusManagement", returnHTML:=True, IsMandatory:=False))
        'End Of Added By Usha Pandit On 07.05.2020 For Invalid Date format related issue
        '***** End Modification by SandipL on 16 May 2006
        'End Integration
        'Added by ShubhadaL on 7 Feb 2006 to Hide * mark if ShowAll is clicked else show it.
        CommonFunctions.General.WriteHTML("<IMG id=StarIDTo name=idStarIDTo display='none' src='../../Images/Star.gif' border=0>")
        'End addition by ShubhadaL on 7 Feb 2006
        'Added by SandeepA on 18 Nov,2005 for IssueID-686 : Task Status
        'Purpose: End of SPAN Tag.
        CommonFunctions.General.WriteHTML("</Span>")
        'End of addition by SandeepA on 18 Nov,2005 for IssueID-686
        'Code addd by KapilK on 11-09-08 

        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        CommonFunction.HTMLControls.DrawTextBox("txtProjectEndDate", "txtProjectEndDate", , , , m_strProjectEndDate, , , , , , True, EnableHTMLEncode:=True)
        '''End of Modification by Dhanashri S on 7 Oct 2015 

        'End;Code addd by KapilK on 11-09-08
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td colspan=1></td>")
        CommonFunctions.General.WriteHTML("</tr>")
        'CommonFunctions.General.WriteHTML("</TABLE>")
        'End addition by ShubhadaL



        'CommonFunctions.General.WriteHTML("<tr class='clsTREven' width = '100%'>")'ShubhadaL
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        'Displaying Secondary Filter
        ' CommonFunctions.General.WriteHTML("<td nowrap>")'ShubhadaL
        CommonFunctions.General.WriteHTML("<td colspan = 3>")

        If m_strTaskType = TASK_TYPE_ASSIGNED Then blnIsChecked = True Else blnIsChecked = False
        CommonFunctions.HTMLControls.DrawOptionButton("optTaskType", "optTaskType", , blnIsChecked, TASK_TYPE_ASSIGNED, , "")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("OPT_ASSIGNED_TASKS"))


        If m_strTaskType = TASK_TYPE_MPP Then blnIsChecked = True Else blnIsChecked = False
        CommonFunctions.HTMLControls.DrawOptionButton("optTaskType", "optTaskType", , blnIsChecked, TASK_TYPE_MPP, , "")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("OPT_MPP_TASKS"))



        If m_strTaskType = TASK_TYPE_ISSUE Then blnIsChecked = True Else blnIsChecked = False
        CommonFunctions.HTMLControls.DrawOptionButton("optTaskType", "optTaskType", , blnIsChecked, TASK_TYPE_ISSUE, , "")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("OPT_ISSUE_TASKS"))



        If m_strTaskType = TASK_TYPE_REVIEW Then blnIsChecked = True Else blnIsChecked = False
        CommonFunctions.HTMLControls.DrawOptionButton("optTaskType", "optTaskType", , blnIsChecked, TASK_TYPE_REVIEW, , "")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("OPT_REVIEW_TASKS"))

        'Intigrated by HarshK for sp4 issueid 219
        If m_strTaskType = TASK_TYPE_HELPDESK Then blnIsChecked = True Else blnIsChecked = False
        CommonFunctions.HTMLControls.DrawOptionButton("optTaskType", "optTaskType", , blnIsChecked, TASK_TYPE_HELPDESK, , "")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("OPT_HELP_TASKS"))
        'End Intigrated by HarshK for sp4 issueid 219
        CommonFunctions.General.WriteHTML("</td>")

        '--- Display the Show Link
        'Display the Show Link
        'modified by harshk for sp4 issueid 190
        CommonFunctions.General.WriteHTML("<td align=center colspan=2>")
        'End 'modified by harshk for sp4 issueid 190
        objDynamicLink = New WebPages.UI.cDynamicLink
        objDynamicLink.LinkName = MyBase.GetResourceString("LABEL_SHOW")
        objDynamicLink.Tooltip = MyBase.GetResourceString("LABEL_SHOW_TOOLTIP")
        objDynamicLink.FunctionName = "Show_OnClick()"
        objDynamicLink.ReturnHTML = True
        CommonFunctions.General.WriteHTML(" |<B>" + objDynamicLink.GetDynamicLink() + "</B>| ")
        objDynamicLink = Nothing
        CommonFunctions.General.WriteHTML("</td></tr></table>")

        CommonFunctions.General.WriteHTML("<BR>")

        'Added By MrugajaB on 24th May 2005 for WhizibleSEM Issue ID.18507
        CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
        CommonFunctions.General.WriteHTML("<tr class='clsTREven' width = '100%'>")
        CommonFunctions.General.WriteHTML("<td>")
        CommonFunctions.General.WriteHTML("<B>Note :</B>")
        CommonFunctions.General.WriteHTML("Tasks which do not have status selected in the 'Action' combobox are displayed")
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML("</td></tr></table>")
        CommonFunctions.General.WriteHTML("<BR>")
        'End Addition

        'Added by ShubhadaL on 1 Feb,2006
        'Purpose: Added a DIV section for all filters
        CommonFunctions.General.WriteHTML("</DIV>")
        'End of Addition by ShubhadaL on 1 Feb2006

    End Sub

    Private Sub DisplayGrid()
        Dim strSQLQuery As String = ""
        Dim strWhereClause As String = ""

        'Mark task Onhold or Void
        'InProgress and YettoStart Tasks
        'If m_intOperation = OPERATION_ONHOLD_TASKS Or m_intOperation = OPERATION_VOID_TASKS Then
        'strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksFor_YetToStartandInProgress " & CType(m_intProjectID, String) & ", '" & CType(m_dtFromDate, String) & "', '" & CType(m_dtToDate, String) & "','" & m_strTaskType & "'"
        'End If

        'Mark Tasks Billable
        'InProgress , YettoStart and Completed Tasks
        'If m_intOperation = OPERATION_BILLABEL_TASKS Then
        'strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksFor_YetToStartInProgressandCompleted " & CType(m_intProjectID, String) & ", '" & CType(m_dtFromDate, String) & "', '" & CType(m_dtToDate, String) & "','" & m_strTaskType & "'"
        'End If

        'If m_intOperation = OPERATION_NONBILLABEL_TASKS Then
        'strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksFor_NonBillable " & CType(m_intProjectID, String) & ", '" & CType(m_dtFromDate, String) & "', '" & CType(m_dtToDate, String) & "','" & m_strTaskType & "'"
        'End If
        'Intigrated by harshk for sp4 issueid 190
        'If m_intOperation = OPERATION_NONBILLABEL_TASKS Or m_intOperation = OPERATION_BILLABEL_TASKS Then
        'strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksFor_TaskStatusManagement " & CType(m_intProjectID, String) & ", '" & CType(m_dtFromDate, String) & "', '" & CType(m_dtToDate, String) & "','" & m_strTaskType & "'," & m_intOperation

        'Added by SandeepA on 18 Nov,2005 for IssueID-686 : task  Status management changes
        'Purpose: Check for the Task Filter and Build Grid SQL
        Dim strTaskFilter As String
        ' Retrieve the current Task filter value.
        'Modified by ManishK on 19th Feb 2006 For SP 6 issueID 2176
        'strTaskFilter = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("optMainTaskFilter"), "1")
        strTaskFilter = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("optMainTaskFilter"), "2")
        'End Of Modified by ManishK on 19th Feb 2006 For SP 6 issueID 2176
        If strTaskFilter = "2" Then
            strTaskFilter = " NULL "
        End If
        'End of addition by SandeepA on 18 Nov,2005 for IssueID-686

        'Modified by SandeepA on 18 Nov,2005 for IssueID-686
        'Purpose: Added field 'strTaskFilter'
        'Added by TruptiK on 13-Aug-2008
        If m_intOperation = 8 Then
            strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksForCompletion " & CType(m_intProjectID, String) & "," & CType(m_intEmployeeID, String) & ", '" & CType(m_dtFromDate, String) & "', '" & CType(m_dtToDate, String) & "','" & m_strTaskType & "'," & strTaskFilter
        Else
            strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksFor_TaskStatusManagement " & CType(m_intProjectID, String) & "," & CType(m_intEmployeeID, String) & ", '" & CType(m_dtFromDate, String) & "', '" & CType(m_dtToDate, String) & "','" & m_strTaskType & "'," & m_intOperation & "," & strTaskFilter
        End If
        'End of addition by TruptiK
        'end of modification by SandeepA on 18 Nov,2005 for IssueID-686


        'End If
        'end
        'Reopen Tasks
        'Show Only Completed Tasks
        'If m_intOperation = OPERATION_REOPEN_TASKS Then
        'strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksFor_CompletedTasks " & CType(m_intProjectID, String) & ", '" & CType(m_dtFromDate, String) & "', '" & CType(m_dtToDate, String) & "','" & m_strTaskType & "'"
        'End If
        'Code added by KapilK on 08-09-08 [added Baseline Start & End Date ]

        Dim arrActualColumns() As String = {"TaskName", "EmployeeName", "StartDate", "EndDate", "BaselineStart", "BaselineEnd",
                                            "ActualStartDate", "ActualEndDate", "PlannedWork", "ActualWork", "ActualPercentComplete", ""}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("HEADING_TASK_NAME"), MyBase.GetResourceString("HEADING_RESOURCE_NAME"),
                                                 MyBase.GetResourceString("HEADING_START_DATE"), MyBase.GetResourceString("HEADING_END_DATE"), "Baseline Start Date", "Baseline End Date",
                                                 MyBase.GetResourceString("HEADING_ACTUAL_START_DATE"), MyBase.GetResourceString("HEADING_ACTUAL_END_DATE"),
                                                 MyBase.GetResourceString("HEADING_EFFORTS"), MyBase.GetResourceString("HEADING_ACTUAL_EFFORTS"), "Actual Percent Complete", "Select"}
        Dim arrstrTDStyle() As String = {"align='left' vAlign='center' width=40%", "align='left' vAlign='center' width=10%", "align='left' vAlign='center' width=5%",
                                         "align='left' vAlign='center' width=5%", "align='left' vAlign='center' width=5%", "align='left' vAlign='center' width=5%", "align='left' vAlign='center' width=5%", "align='left' vAlign='center' width=5%", "align='right' vAlign='center' width=5%",
                                         "align='right' vAlign='center' width=5%", "align='center' vAlign='center' width=5%", "align='center' vAlign='center' width=5%"}

        'Set the Advanced Grid Properties

        ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''End of Addition by Dhanashri S on 7 Oct 2015

        m_TaskIDs = ""
        m_CheckedTaskIDs = ""
        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .EmptyValueReplacement = "&nbsp;"
            .SQL = strSQLQuery
            .DIVID = "divList"
            ' Commented  by Viraj P on 17 Nov 2015
            '.DIVHeight = 290
            'End of Comment  by Viraj P on 17 Nov 2015
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = 11
            .TDStyleArray = arrstrTDStyle
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            ''End of Addition by Dhanashri S on 7 Oct 2015
            .DrawGrid()
        End With
    End Sub


#Region "General Functions and Procedures"

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

    Private Sub UpdateTasks(ByVal strTaskIDs As String)

        Dim strSQLQuery As String


        ''Added by ManishK on 16th Feb 2006 for whizibleSem SP6 IssuedID 2176

        Dim strTaskID As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("TaskID"), "")
        'Dim strSql As String = "SELECT ProjectID FROM tbl_PM_ProjectTasks WHERE TaskID = " + strTaskID
        Dim strSql As String = "usp_sel_tbl_PM_ProjectTasks_ProjectID " + strTaskID
        Dim strProjectID As String
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("TaskID"), "") <> "" Then
            strProjectID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSql, MyBase.UseSQL), ""), String)
        Else
            strProjectID = m_intProjectID.ToString
        End If

        ''End of Added by ManishK on 16th Feb 2006 for whizibleSem SP6 IssuedID 2176


        'Here the tasks in the table tbl_PM_ProjectTasks will get udpated
        'i.e Set the IsActiveFlag = 1
        If strTaskIDs <> "" Then
            'Modified By VidyaJ - Performance Issue - Tasks - 86
            'Added ProjectID parameter
            ''Modified by ManishK on 16th Feb 2006 for whizibleSem SP6 IssuedID 2176
            'strSQLQuery = "EXEC usp_Upd_AssignedTasks_TaskStatusManagement '" & Left(strTaskIDs, strTaskIDs.Length - 1) & "','" & m_strTaskType & "',NULL,NULL,NULL," & m_intOperation & "," & m_intProjectID
            'Code added by KapilK on 12-09-08 [For operation 13]
            If m_intOperation = 13 Then
                Call UpdateTaskActualPercent_Start_End_Date(strTaskIDs)
            Else
                'Added by TruptiK on 13-aug-2008
                If m_intOperation = 8 Then
                    strSQLQuery = "EXEC usp_Upd_AssignedTasks_Updation '" & Left(strTaskIDs, strTaskIDs.Length - 1) & "','" & m_strTaskType & "'"
                Else
                    strSQLQuery = "EXEC usp_Upd_AssignedTasks_TaskStatusManagement '" & Left(strTaskIDs, strTaskIDs.Length - 1) & "','" & m_strTaskType & "',NULL,NULL,NULL," & m_intOperation & "," & strProjectID
                End If
                'end of addition by TruptiK
                'strSQLQuery = "EXEC usp_Upd_AssignedTasks_TaskStatusManagement '" & Left(strTaskIDs, strTaskIDs.Length - 1) & "','" & m_strTaskType & "',NULL,NULL,NULL," & m_intOperation & "," & strProjectID
                ''End of Modified by ManishK on 16th Feb 2006 for whizibleSem SP6 IssuedID 2176
                CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, True)

                'Added by Nitinc on 28 June 2011 for WhizibleSEM v10.0 (Agile Methodology)
                Dim m_intFlag As Integer
                m_intFlag = CInt(CInt(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + strProjectID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))))
                If m_intFlag = 1 Then
                    Dim SQL As String
                    SQL = "EXEC Usp_Upd_UserStoryStatus '" & Left(strTaskIDs, strTaskIDs.Length - 1) & "'," & strProjectID & "," & m_intOperation
                    CommonFunctions.Data.InsertOrUpdateData(SQL, True)
                End If
                'End of Added by Nitinc on 28 June 2011 for WhizibleSEM v10.0 (Agile Methodology)

            End If

            ''--- Added BY purvaj on 3 Oct 2008 for Whiziblesem8.0 
            ''--- to update actual %complete for parentTasks
            'CommonFunction.Data.InsertOrUpdateData("usp_UPD_ActualPercentComplete_forParentTask '" + CommonFunction.General.CheckIsNothing(Request("hidParentTaskIDs"), "0") + "'", True)
            ''--- End addition Purvaj

        End If

    End Sub
    'Function added by KapilK on 12-09-08 
    Private Sub UpdateTaskActualPercent_Start_End_Date(ByVal strTaskIdList As String)
        Dim strQuery As String = ""
        Dim arrTaskId() As String
        Dim lngTaskId As Long
        Dim strActualPercentComplete As String
        Dim intCnt As Integer
        Dim strTaskList As String
        Dim strTaskActualStartDate As String
        Dim strTaskActualEndDate As String

        If strTaskIdList <> "" Then
            strTaskIdList = strTaskIdList.Substring(0, strTaskIdList.Length - 1)
            arrTaskId = strTaskIdList.Split(CType(",", Char))
            For intCnt = 0 To arrTaskId.Length - 1
                lngTaskId = CType(arrTaskId(intCnt), Long)
                strActualPercentComplete = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtActPer_" & lngTaskId.ToString()))

                'Added strActualPercentCompletetemp <> strActualPercentComplete condition
                If strActualPercentComplete <> "" Then
                    If m_intMSPIntegrationMethod <> 2 Then
                        If CInt(strActualPercentComplete) = 100 Then
                            strQuery = " EXEC usp_Upd_AssignedTasks_Updation  '" & lngTaskId.ToString() & "','" & m_strTaskType & "'"
                            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                        Else
                            strQuery = "UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " & FormatNumber(strActualPercentComplete, , , , TriState.False)
                            '-- ADded By PurvaJ on 18 Oct 2008 WhizibleSEM 8.0
                            strQuery &= ",ResourcePercentComplete = " & FormatNumber(strActualPercentComplete, , , , TriState.False)
                            '-- End addition PurvaJ
                            strQuery &= " WHERE TaskId = " & lngTaskId.ToString()
                            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                        End If
                    Else
                        If m_strTaskType = "O" Then
                            If CInt(strActualPercentComplete) = 100 Then
                                strQuery = " EXEC usp_Upd_AssignedTasks_Updation  '" & lngTaskId.ToString() & "','" & m_strTaskType & "'"
                                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                            Else
                                strQuery = "UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " & FormatNumber(strActualPercentComplete, , , , TriState.False)
                                '-- ADded By PurvaJ on 18 Oct 2008 WhizibleSEM 8.0
                                strQuery &= ",ResourcePercentComplete = " & FormatNumber(strActualPercentComplete, , , , TriState.False)
                                '-- End addition PurvaJ
                                strQuery &= " WHERE TaskId = " & lngTaskId.ToString()
                                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                            End If

                        ElseIf m_strTaskType = "M" Then
                            strTaskActualStartDate = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("ActStartDate_" & lngTaskId.ToString()))
                            strTaskActualEndDate = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("ActEndDate_" & lngTaskId.ToString()))

                            If CInt(strActualPercentComplete) = 100 Then
                                strQuery = "UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " & FormatNumber(strActualPercentComplete, , , , TriState.False)
                                '-- ADded By PurvaJ on 18 Oct 2008 WhizibleSEM 8.0
                                strQuery &= ",ResourcePercentComplete = " & FormatNumber(strActualPercentComplete, , , , TriState.False)
                                '-- End addition PurvaJ
                                strQuery &= ",ActualStartDate='" & strTaskActualStartDate & "',ActualEndDate='" & strTaskActualEndDate
                                strQuery &= "',IsTaskComplete=1 WHERE TaskId = " & lngTaskId.ToString()
                            Else
                                strQuery = "UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " & FormatNumber(strActualPercentComplete, , , , TriState.False)
                                '-- ADded By PurvaJ on 18 Oct 2008 WhizibleSEM 8.0
                                strQuery &= ",ResourcePercentComplete = " & FormatNumber(strActualPercentComplete, , , , TriState.False)
                                '-- End addition PurvaJ
                                strQuery &= ",ActualStartDate='" & strTaskActualStartDate
                                strQuery &= "' WHERE TaskId = " & lngTaskId.ToString()
                            End If

                            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

                        End If
                    End If
                End If
                'End Of Modifications
            Next
        End If
        '--- Added BY purvaj on 3 Oct 2008 for Whiziblesem8.0 
        '--- to update actual %complete for parentTasks
        CommonFunction.Data.InsertOrUpdateData("usp_UPD_ActualPercentComplete_forParentTask '" + CommonFunction.General.CheckIsNothing(Request("hidParentTaskIDs"), "0") + "'", True)
        '--- End addition Purvaj
    End Sub
    'End;Function added by KapilK on 12-09-08 
#End Region

    Public Sub New()
        ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016
        MyBase.InitializeResources("AppResources.PM_TaskStatusManagement", "AppResources")
    End Sub


#Region "Grid Events"

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        'Added by TruptiK on 13-Aug-2008
        If Args.ColumnName = "Actual End Date" Then
            If m_intOperation = 8 Then
                Cancel = True
            End If
        End If
        'Code commented & added By KapilK on 08-09-08 [Colindex removed and Column Name added in cond. ]
        'If Args.ColIndex = 8 Then
        If Args.ColumnName = "Actual Percent Complete" Then
            'If m_intOperation <> 8 Then
            If m_intOperation = 1 Or m_intOperation = 2 Or m_intOperation = 3 Or m_intOperation = 4 Or m_intOperation = 5 Or m_intOperation = 6 Or m_intOperation = 7 Or m_intOperation = 9 Or m_intOperation = 10 Or m_intOperation = 11 Or m_intOperation = 12 Then
                Cancel = True
            End If
        End If

        'End of addition by TruptiK
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Dim strName As String
        Dim strAttributes As String
        Dim strTxtName As String

        Dim strTxtActualPercent As String
        Dim strActStartDate As String
        Dim strActEndDate As String
        Dim strActualStartDateValue As String
        Dim strActualEndDateValue As String
        Dim strActStartDatetxt As String
        Dim strActEndDatetxt As String
 'Added by TruptiK on 30-Mar-09
        'Purpose:-TO give alert if work hours are exceeding parenttask work hours.
        Dim strTaskId1 As String
        Dim strtotalworkhrs As Double
        Dim childworkhrs As Double
        Dim strParentaskID As String
        Dim Parenttaskwork As Double
        Dim startDate As String
        Dim EndDate As String
        Dim PstartDate As String
        Dim PEndDate As String
        'End of addition by TruptiK on 30-Mar-09



        'If CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ParentTask_UID"), "0"), "0") <> "0" Then
        '    m_strParentTask_UID = m_strParentTask_UID + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0").ToString + ","
        'End If
 'Added by TruptiK on 30-Mar-09
        'Purpose:-TO give alert if work hours are exceeding parenttask work hours.
        If m_intOperation = 2 Then
            If Args.ColIndex = 9 Then
                'Work hours validation

                strTaskId1 = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0").ToString
                'Dim strsql As String = "select parenttask_uid from tbl_pm_projecttasks where taskid=" + strTaskId1
                Dim strsql As String = "usp_sel_tbl_PM_ProjectTasks_parenttask_uid " + strTaskId1
                strParentaskID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strsql, MyBase.UseSQL), "null"), String)

                'strsql = "SELECT work FROM tbl_PM_ProjectTasks WHERE taskid = isnull(" + strParentaskID + "," + strTaskId1 + ")"
                strsql = "usp_sel_tbl_PM_ProjectTasks_work_parenttaskid_TaskId " + strParentaskID + "," + strTaskId1
                Parenttaskwork = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strsql, MyBase.UseSQL), "0"), Double)
                'strsql = "SELECT sum(work) FROM tbl_PM_ProjectTasks WHERE isactive=1 and parenttask_uid = " + strParentaskID
                strsql = "usp_sel_tbl_PM_ProjectTasks_work_parenttask_uid " + strParentaskID
                strtotalworkhrs = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strsql, MyBase.UseSQL), "0"), Double)

                'Commented And Added By Usha Pandit On 23.07.2019 For Work Hour H:M Format
                'childworkhrs = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("PlannedWork"), "0"), Double)
                'Commented And Added By Usha Pandit On 11.03.2020 For crash Conversion from string to type Double is not valid
                'childworkhrs = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("PlannedWork"), "0:00") + "',2)", True)
                childworkhrs = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("PlannedWork"), "0:00").ToString() + "',2)", True)
                'End Of Added By Usha Pandit On 11.03.2020 For crash Conversion from string to type Double is not valid
                'End Of Added By Usha Pandit On 23.07.2019 For Work Hour H:M Format

                '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
                CommonFunctions.HTMLControls.DrawTextBox("hid_txttotalworkhrs _" + strTaskId1, "hid_totalworkhrs _" + strTaskId1, , , , Parenttaskwork.ToString, , , , , , IsHidden:=True, EnableHTMLEncode:=True)
                CommonFunctions.HTMLControls.DrawTextBox("hid_txtchildworkhrs _" + strTaskId1, "hid_childworkhrs _" + strTaskId1, , , , childworkhrs.ToString, , , , , , IsHidden:=True, EnableHTMLEncode:=True)
                CommonFunctions.HTMLControls.DrawTextBox("hid_txtchildwork _" + strTaskId1, "hid_childwork _" + strTaskId1, , , , strtotalworkhrs.ToString, , , , , , IsHidden:=True, EnableHTMLEncode:=True)
                '''End of Modification by Dhanashri S on 7 Oct 2015

                'Date validation

                'strsql = "select StartDate from tbl_pm_projecttasks where taskid=" + strTaskId1
                strsql = "usp_sel_tbl_PM_ProjectTasks_StartDate_TaskID " + strTaskId1
                startDate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strsql, MyBase.UseSQL), ""), String)
                'strsql = "select EndDate from tbl_pm_projecttasks where taskid=" + strTaskId1
                strsql = "usp_sel_tbl_PM_ProjectTasks_EndDate_TaskID " + strTaskId1
                EndDate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strsql, MyBase.UseSQL), ""), String)
                'strsql = "select StartDate from tbl_pm_projecttasks where taskid=" + strParentaskID
                strsql = "usp_sel_tbl_PM_ProjectTasks_StartDate_TaskID " + strParentaskID
                PstartDate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strsql, MyBase.UseSQL), ""), String)
                'strsql = "select EndDate from tbl_pm_projecttasks where taskid=" + strParentaskID
                strsql = "usp_sel_tbl_PM_ProjectTasks_EndDate_TaskID " + strParentaskID
                PEndDate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strsql, MyBase.UseSQL), ""), String)

                '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
                CommonFunction.HTMLControls.DrawTextBox("hid_txtTaskStartDate_" + strTaskId1, "hid_txtTaskStartDate_" + strTaskId1, , 200, , CDate(startDate).ToString("dd-MMM-yyyy"), , , , , , True, EnableHTMLEncode:=True)
                CommonFunction.HTMLControls.DrawTextBox("hid_txtTaskEndDate_" + strTaskId1, "hid_txtTaskEndDate_" + strTaskId1, , 200, , CDate(EndDate).ToString("dd-MMM-yyyy"), , , , , , True, EnableHTMLEncode:=True)
                '''End of Modification by Dhanashri S on 7 Oct 2015

                If PstartDate <> "" Then
                    '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
                    CommonFunction.HTMLControls.DrawTextBox("hid_txtPTaskStartDate_" + strTaskId1, "hid_txtPTaskStartDate_" + strTaskId1, , 200, , CDate(PstartDate).ToString("dd-MMM-yyyy"), , , , , , True, EnableHTMLEncode:=True)
                Else
                    CommonFunction.HTMLControls.DrawTextBox("hid_txtPTaskStartDate_" + strTaskId1, "hid_txtPTaskStartDate_" + strTaskId1, , 200, , PstartDate, , , , , , True, EnableHTMLEncode:=True)
                    '''End of Modification by Dhanashri S on 7 Oct 2015
                End If

                If PEndDate <> "" Then
                    '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
                    CommonFunction.HTMLControls.DrawTextBox("hid_txtPTaskEndDate_" + strTaskId1, "hid_txtPTaskEndDate_" + strTaskId1, , 200, , CDate(PEndDate).ToString("dd-MMM-yyyy"), , , , , , True, EnableHTMLEncode:=True)
                Else
                    CommonFunction.HTMLControls.DrawTextBox("hid_txtPTaskEndDate_" + strTaskId1, "hid_txtPTaskEndDate_" + strTaskId1, , 200, , PEndDate, , , , , , True, EnableHTMLEncode:=True)
                    '''End of Modification by Dhanashri S on 7 Oct 2015
                End If

                If strParentaskID <> "null" Then
                    '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
                    CommonFunctions.HTMLControls.DrawTextBox("hid_txtParenttaskID _" + strTaskId1, "hid_ParenttaskID _" + strTaskId1, , , , strParentaskID.ToString, , , , , , IsHidden:=True, EnableHTMLEncode:=True)
                    '''End of Modification by Dhanashri S on 7 Oct 2015
                End If

            End If
        End If

        'End of addition by TruptiK on 30-Mar-09
        '--- added By PUrvaj on 20 Oct 2008 for WhizibleSEM 8.0
        If Args.ColumnName.ToUpper = "TASK NAME" And m_intOperation <> 8 Then
            
            If CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ParentTask_UID"), "0"), "0") <> "0" Then
                Args.DataFieldValue = "--> " + Args.DataFieldValue.ToString
            Else
                If Args.DataReader("IsUserStoryTask").ToString.ToUpper = "TRUE" Then
                    Cancel = True
                    Args.StringToBeInserted += "<td  vAlign=top align='left' vAlign='center' width=40% title=""Task Name"">"
                    Args.StringToBeInserted += "<IMG src=""../../Images/Scrum/UserStory.gif""> " + Args.DataReader("TaskName") + "</a>"
                    Args.StringToBeInserted += "</td>"
                End If
            End If

        End If
        '--- End addition By Purvaj

        If Args.ColumnName = "Select" Then
            Cancel = True
            If m_strTaskType = TASK_TYPE_ASSIGNED Or m_strTaskType = TASK_TYPE_REVIEW Then
                'For If Task Staus is = 0

                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskStatus"), "0"), Boolean) = True Then
                    'Commented by MrugajaB
                    'Purpose: Parent wil not be checked unless all child tasks have same status
                    'strAttributes = " disabled checked"
                    strAttributes = " disabled"
                Else
                    strAttributes = ""
                End If

                'end of addition by TruptiK
                'Modified By VidyaJ - IssueID - 190 - SP4
                If m_intOperation = OPERATION_VOID_TASKS And CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ParentTask_UID"), "0"), Integer) = 0 And m_intEmployeeID <> 0 Then
                    strAttributes = " disabled "
                End If
                'End Of Modifications

                If m_intOperation = OPERATION_SAVE_PERCENTCOMPLETE And CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ActualPercentComplete"), "0"), Integer) = 100 Then
                    strAttributes = " disabled "
                End If

                'Code added By KapilK on 08-09-08 [added "OPERATION_SET_BASELINE" & "OPERATION_CLEAR_BASELINE" in cond. ]
                'Display Parent Tasks
                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ParentTask_UID"), "0"), Integer) = 0 Then
                    m_intCount = 0
                    strName = "chk" + CType(m_intParentTask_UID, String) + "_" + CType(m_intCount, String)
                    strTxtName = "txt" + CType(m_intParentTask_UID, String) + "_" + CType(m_intCount, String)
                    'For OPERATION_VOID_TASKS,OPERATION_VALID_TASKS,OPERATION_REOPEN_TASKS operations only show child Tasks
                    'Otherwise show only Parent Tasks
                    If m_intOperation = OPERATION_VOID_TASKS Or m_intOperation = OPERATION_VALID_TASKS Or m_intOperation = OPERATION_REOPEN_TASKS Or m_intOperation = OPERATION_ACCRUAL_PRORATA Or m_intOperation = OPERATION_ACCRUAL_ONCOMPLETION Or m_intOperation = OPERATION_SET_BASELINE Or m_intOperation = OPERATION_CLEAR_BASELINE Or m_intOperation = OPERATION_SAVE_PERCENTCOMPLETE Or m_intOperation = 8 Then
                        Args.StringToBeInserted = "<td align='center' width=10%><input type='checkbox' id='" + strName + "' name='" + strName + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String) + "' " + strAttributes + " onclick='javascript:CheckChildTasks(" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String) + "," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("HasChildTasks"), "0"), String) + ")'><input type=hidden name='" + strTxtName + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskStatus"), "0"), String) + "'></td>"
                    Else
                        Args.StringToBeInserted = "<td align='center' width=10%><input type='checkbox' id='" + strName + "' name='" + strName + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String) + "' onclick='javascript:CheckTask(" + CType(m_intParentTask_UID, String) + "," + CType(m_intCount, String) + ")'><input type=hidden name='" + strTxtName + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskStatus"), "0"), String) + "'></td>"
                    End If


                Else
                    'Display Child Tasks
                    If m_intOperation = OPERATION_VOID_TASKS Or m_intOperation = OPERATION_VALID_TASKS Or m_intOperation = OPERATION_REOPEN_TASKS Or m_intOperation = OPERATION_ACCRUAL_PRORATA Or m_intOperation = OPERATION_ACCRUAL_ONCOMPLETION Or m_intOperation = OPERATION_SET_BASELINE Or m_intOperation = OPERATION_CLEAR_BASELINE Or m_intOperation = OPERATION_SAVE_PERCENTCOMPLETE Or m_intOperation = 8 Then
                        m_intCount = m_intCount + 1
                        strName = "chk" + CType(m_intParentTask_UID, String) + "_" + CType(m_intCount, String)
                        strTxtName = "txt" + CType(m_intParentTask_UID, String) + "_" + CType(m_intCount, String)
                        '--- added By purvaj on 6 oct 2008 for whiziblesem8.0 issue fixes
                        '--- show check boxes disabled. set baseline , clear baseline can be done only for parent task
                        If m_intOperation = OPERATION_SET_BASELINE Or m_intOperation = OPERATION_CLEAR_BASELINE Then
                            Args.StringToBeInserted = "<td align='center' width=10%><input type='checkbox' id='" + strName + "' name='" + strName + "' disabled value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String) + "' " + strAttributes + " onclick='javascript:CheckTask(" + CType(m_intParentTask_UID, String) + "," + CType(m_intCount, String) + ")'><input type=hidden name='" + strTxtName + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskStatus"), "0"), String) + "'></td>"
                        Else
                            '-- end addition purvaj
                            Args.StringToBeInserted = "<td align='center' width=10%><input type='checkbox' id='" + strName + "' name='" + strName + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String) + "' " + strAttributes + " onclick='javascript:CheckTask(" + CType(m_intParentTask_UID, String) + "," + CType(m_intCount, String) + ")'><input type=hidden name='" + strTxtName + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskStatus"), "0"), String) + "'></td>"
                        End If

                        'Args.StringToBeInserted = "<td align='center' width=10%><input type='checkbox' id='" + strName + "' name='" + strName + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String) + "' " + strAttributes + " onclick='javascript:CheckTask(" + CType(m_intParentTask_UID, String) + "," + CType(m_intCount, String) + ")'><input type=hidden name='" + strTxtName + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskStatus"), "0"), String) + "'></td>"
                    Else
                        Args.StringToBeInserted = "<td align='center' width=10%></td>"
                    End If
                End If
            Else
                If m_intOperation = OPERATION_SAVE_PERCENTCOMPLETE And CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ActualPercentComplete"), "0"), Integer) = 100 Then
                    strAttributes = " disabled "
                End If

                m_intCount = m_intCount + 1
                strName = "chk0_" + CType(m_intCount, String)
                Args.StringToBeInserted = "<td align='center' width=10%><input type='checkbox' id='" + strName + "' name='" + strName + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String) + "' " + strAttributes + " onclick='javascript:CheckTask(" + CType(m_intParentTask_UID, String) + "," + CType(m_intCount, String) + ")'><input type=hidden name='" + strTxtName + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskStatus"), "0"), String) + "'></td>"
            End If
            'Intigrated by harshk for sp4 issueid 190
            'Purpose : To Store Checked Checkbox IDs into Global Variable
            If (m_CheckboxIDs <> "") Then
                m_CheckboxIDs &= "," + strName
            Else
                m_CheckboxIDs = strName
            End If
            'End Intigrated by harshk for sp4 issueid 190
        End If

        Select Case Args.ColumnName
            Case MyBase.GetResourceString("HEADING_START_DATE"), MyBase.GetResourceString("HEADING_END_DATE"), MyBase.GetResourceString("HEADING_ACTUAL_START_DATE"), MyBase.GetResourceString("HEADING_ACTUAL_END_DATE")
                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataFieldValue, ""), String) <> "" Then
                    Cancel = True
                    Args.StringToBeInserted = "<TD align=left valign=top>" + CType(CommonFunctions.Dates.CGetDate(CType(Args.DataFieldValue, Date)), String) + "</TD>"
                End If
        End Select
        'Added by TruptiK on 13-Aug-2008
        If Args.ColumnName = "Actual End Date" Then
            If m_intOperation = 8 Then
                Cancel = True
            End If
        End If
        'Code commented & added By KapilK on 08-09-08 [Colindex removed and Column Name added in cond. ]
        'If Args.ColIndex = 8 Then
        If Args.ColumnName = "Actual Percent Complete" Then
            'If m_intOperation <> 8 Then
            If m_intOperation = 1 Or m_intOperation = 2 Or m_intOperation = 3 Or m_intOperation = 4 Or m_intOperation = 5 Or m_intOperation = 6 Or m_intOperation = 7 Or m_intOperation = 9 Or m_intOperation = 10 Or m_intOperation = 11 Or m_intOperation = 12 Then
                Cancel = True
            End If
        End If
        'Code commented & added By KapilK on 08-09-08 [Colindex removed and Column Name added in cond. ]
        'If Args.ColIndex = 8 Then
        If Args.ColumnName = "Actual Percent Complete" Then
            If m_intOperation = 8 Then
                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("HasChildTasks"), "0"), String) <> "0" Then
                    Cancel = True
                    Args.StringToBeInserted = "<TD align=right></TD>"
                End If
            End If
        End If
        'End of addition by TruptiK
        If m_intOperation = 13 Then
            If m_strTaskType = TASK_TYPE_MPP Or m_strTaskType = TASK_TYPE_ASSIGNED Then
                If m_intOperation = OPERATION_SAVE_PERCENTCOMPLETE And CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ActualPercentComplete"), "0"), Integer) = 100 Then
                    strAttributes = " disabled "
                End If
                If Args.ColumnName = "Actual Percent Complete" Then

                    strTxtActualPercent = "txtActPer_" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0")
                    '--- added By Purvaj on 3 Oct 2008 for Whiziblesem8.0 do not show Actual % complete text box for parent task.
                    '--- Actual % Complete should always be calculated for Parent Task
                    If CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ParentTask_UID"), "0"), "0") <> "0" Then
                        '--- End addition Purvaj
                        Cancel = True
                        Args.StringToBeInserted = "<td align='center' width=10%><input type='Textbox' id='" + strTxtActualPercent + "' name='" + strTxtActualPercent + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ActualPercentComplete"), "0"), String) + "' " & strAttributes & "class='clsTextBox' style='width:40px  ; text-align:right' onblur='ActualPercentChange(" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0") & ")'></td>"
                    Else
                        '--- Actual % Complete should always be calculated for Parent Task
                        '                        If CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ParentTask_UID"), "0"), "0") = "0" Then
                        m_strParentTask_UID = m_strParentTask_UID + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0").ToString + ","
                        'End If
                        '--- End addition Purvaj
                    End If
                End If

                If m_intMSPIntegrationMethod = 2 And m_strTaskType = TASK_TYPE_MPP Then
                    If Args.ColumnName = "Actual Start Date" Then
                        Cancel = True
                        strActStartDate = "ActStartDate_" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0")

                        If (CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ActualStartDate"), "").ToString() <> "") Then
                            strActualStartDateValue = CommonFunctions.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ActualStartDate")), Date))
                        End If

                        strActStartDatetxt = "<td align='center' width=10%>" & CommonFunction.HTMLControls.DrawDateControl(strActStartDate, strActStartDate, , , strActualStartDateValue, , "frmPM_TaskStatusManagement", , , , , , , True)
                        If m_btRestrictDurationChange_M = True Then
                            strActStartDatetxt += "<input type='hidden' id='txtTaskStartDate_" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String) + "' name='txtTaskStartDate_" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String) + "' value='" + CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("StartDate")), Date)) + "'>"
                        End If
                        strActStartDatetxt += "</td>"

                        Args.StringToBeInserted = strActStartDatetxt
                    End If
                    If Args.ColumnName = "Actual End Date" Then
                        Cancel = True
                        strActEndDate = "ActEndDate_" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0")
                        If (CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ActualEndDate"), "").ToString() <> "") Then
                            strActualEndDateValue = CommonFunctions.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ActualEndDate")), Date))
                        End If

                        strActEndDatetxt = "<td align='center' width=10%>" & CommonFunction.HTMLControls.DrawDateControl(strActEndDate, strActEndDate, , , strActualEndDateValue, , "frmPM_TaskStatusManagement", , , , , , , True)
                        If m_btRestrictDurationChange_M = True Then
                            strActEndDatetxt += "<input type='hidden' id='txtTaskEndDate_" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String) + "' name='txtTaskEndDate_" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String) + "' value='" + CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EndDate")), Date)) + "'>"
                        End If
                        strActEndDatetxt += "</td>"
                        Args.StringToBeInserted = strActEndDatetxt
                    End If
                End If
            End If
        End If
    End Sub

    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint

        If m_strTaskType = TASK_TYPE_ASSIGNED Or m_strTaskType = TASK_TYPE_REVIEW Then
            If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("HasChildTasks"), "0"), String) <> "0" Or CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ParentTask_UID"), "0"), String) = "0" Then
                m_intParentTask_UID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), Integer)
                Args.clsTR = "clsTRSectionHeader"
            End If
        End If

    End Sub

    'Added By MrugajaB on 10th June 2005
    'Purpose: Displays caption 'No child tasks present for this task' when the task has no child tasks
    Private Sub m_objGrid_DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_AfterPrint
        'Intigrated by HarshK for sp4 issueid 219
        If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("HasChildTasks"), "0"), String) = "0" And CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ParentTask_UID"), "0"), String) = "0" And (m_strTaskType <> TASK_TYPE_ISSUE And m_strTaskType <> TASK_TYPE_MPP And m_strTaskType <> TASK_TYPE_HELPDESK) Then
            m_intParentTask_UID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), Integer)
            Args.StringToBeInserted = "<TR><TD class=clsTDODD align=left valign=top colspan=9><i>" + "No child tasks present for this task" + "</i></TD></TR>"
        End If
        'End 'Intigrated by HarshK for sp4 issueid 219
    End Sub
    'End Addition


#End Region

    ' Added BY NitinVS on 22 Mar 2007 for WhizibleSEM SP 8 Regression ISsue 11898 
    ' To validate for Edit access before showing save link 
    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        If Args.LinkName = MyBase.GetResourceString("MENU_SAVE") Then
            If m_objAccessRights.Edit = False Then Cancel = True
        End If
    End Sub

    ' End Addition BY NitinVS on 22 Mar 2007 for WhizibleSEM SP 8 Regression ISsue 11898 

    Private Sub m_objGrid_Footer_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_Footer) Handles m_objGrid.Footer_BeforePrint
        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        CommonFunction.HTMLControls.DrawTextBox("hidParentTaskIDs", "hidParentTaskIDs", , 200, , m_strParentTask_UID, , , , , , True, EnableHTMLEncode:=True)
        '''End of Modification by Dhanashri S on 7 Oct 2015
    End Sub
End Class
