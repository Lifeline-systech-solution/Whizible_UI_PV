'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  PbNITE
' Module Name           :  PM_CopyTask.aspx
' Purpose               :  To copy Task from Existing Module , Milestone , Sub Project , and Tasks
' Description           :  As Above
' Dependencies          :  None
' Author                :  NitinVS
' Reviewed              :  
' Tested                :  
' Created               :  6 May 2005 
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

Public Class PM_CopyTask
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

#Region "Member Variables"
    Private m_objGlobal As IGlobal
    Private m_objAccessRights As cAccessRights
    Protected m_lngTagId As Long = 0

    Protected m_ProjectID As String
    Protected m_ParentTagId As Long
    Protected m_UniqueID As Long
    Protected m_UniqueID_New As Long
    Protected m_Mode As String
    Protected m_FromDate As String
    Protected m_ToDate As String
    Protected m_QueryString As String
    'Menu
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_arrMenuItem(MENUITEM_COUNT - 1) As String
    Private m_arrMenuTooltip(MENUITEM_COUNT - 1) As String
    Private m_arrClientSideFunctions(MENUITEM_COUNT - 1) As String

    Protected strComboName As String
    Protected strComboSource As String
    Protected strPrimaryKey As String

    Protected CurrentSession As String

    Protected m_HaveSubTaskTypes As Boolean
    Protected m_applyEffrortDistribution As Boolean

    Protected m_strProjectStartDate As String
    Protected m_strProjectEndDate As String
    Protected m_dblTotalAllocatedTaskLCE As Double
    Protected m_dblTotalLCE As Double

    Protected m_strHolidays As String = ""
    Protected m_dblHoursPerDay As Double = 0
    Protected m_lngWeekDays As Long = 0
    Protected m_strStartingDayOfWeek As String = ""

    Protected strSelectedTask As String

    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid

    Protected strAttributeStatus As String
    Protected strAttributeStatusback As String

    Protected m_intDateFormat As String

    Protected m_strDateFormat As String

    Protected m_teammember As String = ""
    Protected strEmployee As String = ""
    Protected strLeaveFromDate As String = ""
    Protected strLeaveToDate As String = ""
    Protected strEmployeeID As String
    Protected strSession As String

    Protected CopyFromID As String
    Protected strModuleNmae As String
    'AddedBy HarshK for sp4 issueID 120,121 on 06/10/2005
    Protected m_bitResourceValidation As Int16 = 1
    'End AddedBy HarshK for sp4 issueID 120,121 on 06/10/2005

    ''Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change
    Dim m_Effort As String
    Dim m_insEffort As String
    Protected m_RestrictByMinHours As String

    ''End of Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change
#End Region

#Region "Constants Used in the Class"
    Public Const MENUITEM_COUNT As Long = 11
    Public Const MODE_ADD_NEW As String = "ADD_NEW"
    Public Const MODE_EDIT As String = "EDIT"
    Public Const MODE_TASK As String = "TASK"
    Public Const MODE_BACK As String = "BACK"
    Public Const MODE_GET_TASK As String = "GET_TASK"
    Public Const MODE_LIST_TASK As String = "LIST_TASK"
    Public Const MODE_CONFIGURE_ATTRIBUTES As String = "CONFIGURE_ATTRIBUTES"
    Public Const MODE_CREATE_TASK As String = "CREATE_TASK"
    Public Const MODE_CREAT_TASK_WITH_BASELINE As String = "CREATE_TASK_WITH_BASELINE"
#End Region


    Private Enum MenuIndex
        NEXT_PAGE
        BACK
        BACK_ON_GRID
        BACK_ON_LIST
        GET_TASK
        CREATE_TASK
        'CREATE_TASK_WITH_BASELINE
        CONFIGURE_ATTRIBUTES
        SELECT_ALL
        CLEAR_ALL
        CLOSE
        HELP
    End Enum

#Region " Menu Initialization "
    Private Sub InitPageMenu()
        '====================================================================
        ' Procedure Name        : InitPageMenu
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure initializes the arrays used to plot the menu links.
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : JayavantK
        ' Created               : April 30, 2004
        ' Revisions             :
        '=====================================================================
        Dim strMenu As String

        MyBase.InitializeResources("AppResources.PM_CopyTask", "AppResources")


        ' Next

        m_arrMenuItem(MenuIndex.NEXT_PAGE) = MyBase.GetResourceString("MENU_NEXT_PAGE")
        m_arrMenuTooltip(MenuIndex.NEXT_PAGE) = MyBase.GetResourceString("MENU_NEXT_PAGE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.NEXT_PAGE) = "Next_OnClick()"


        ' Back 


        m_arrMenuItem(MenuIndex.BACK) = MyBase.GetResourceString("MENU_BACK")
        m_arrMenuTooltip(MenuIndex.BACK) = MyBase.GetResourceString("MENU_BACK_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.BACK) = "Back_OnClick()"

        m_arrMenuItem(MenuIndex.BACK_ON_GRID) = MyBase.GetResourceString("MENU_BACK")
        m_arrMenuTooltip(MenuIndex.BACK_ON_GRID) = "Back to grid"
        m_arrClientSideFunctions(MenuIndex.BACK_ON_GRID) = "Back_OnClickGRID()"

        m_arrMenuItem(MenuIndex.BACK_ON_LIST) = MyBase.GetResourceString("MENU_BACK")
        m_arrMenuTooltip(MenuIndex.BACK_ON_LIST) = "Back to list"
        m_arrClientSideFunctions(MenuIndex.BACK_ON_LIST) = "Back_OnClickLIST()"



        ' Get Task Details
        m_arrMenuItem(MenuIndex.GET_TASK) = MyBase.GetResourceString("MENU_GET_TASK")
        m_arrMenuTooltip(MenuIndex.GET_TASK) = MyBase.GetResourceString("MENU_GET_TASK_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.GET_TASK) = "GetTaskDetails_OnClick()"


        ' Create Tasks With out Baseline 

        m_arrMenuItem(MenuIndex.CREATE_TASK) = MyBase.GetResourceString("MENU_CREATE_TASK")
        m_arrMenuTooltip(MenuIndex.CREATE_TASK) = MyBase.GetResourceString("MENU_CREATE_TASK_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CREATE_TASK) = "Create_Task()"

        ' Create Tasks With Baseline 

        'm_arrMenuItem(MenuIndex.CREATE_TASK_WITH_BASELINE) = MyBase.GetResourceString("MENU_CREATE_TASK_WITH_BASELINE")
        'm_arrMenuTooltip(MenuIndex.CREATE_TASK_WITH_BASELINE) = MyBase.GetResourceString("MENU_CREATE_TASK_WITH_BASELINE_TOOLTIP")
        'm_arrClientSideFunctions(MenuIndex.CREATE_TASK_WITH_BASELINE) = "Create_Task(1)"

        ' Configure Attributes 

        'm_arrMenuItem(MenuIndex.CONFIGURE_ATTRIBUTES) = MyBase.GetResourceString("MENU_CONFIGURE_ATTRIBUTES")
        'm_arrMenuTooltip(MenuIndex.CONFIGURE_ATTRIBUTES) = MyBase.GetResourceString("MENU_CONFIGURE_ATTRIBUTES")
        'm_arrClientSideFunctions(MenuIndex.CONFIGURE_ATTRIBUTES) = "configure_Attribte()"
        m_arrMenuItem(MenuIndex.CONFIGURE_ATTRIBUTES) = MyBase.GetResourceString("MENU_NEXT_PAGE")
        m_arrMenuTooltip(MenuIndex.CONFIGURE_ATTRIBUTES) = MyBase.GetResourceString("MENU_NEXT_PAGE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CONFIGURE_ATTRIBUTES) = "configure_Attribte()"


        ' Select All 

        m_arrMenuItem(MenuIndex.SELECT_ALL) = MyBase.GetResourceString("MENU_SELECTALL")
        m_arrMenuTooltip(MenuIndex.SELECT_ALL) = MyBase.GetResourceString("MENU_SELECTALL_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SELECT_ALL) = "SelectAll_OnClick('frmPM_CopyTask', 'chkSelect')"

        ' Clear All 

        m_arrMenuItem(MenuIndex.CLEAR_ALL) = MyBase.GetResourceString("MENU_CLEARALL")
        m_arrMenuTooltip(MenuIndex.CLEAR_ALL) = MyBase.GetResourceString("MENU_CLEARALL_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CLEAR_ALL) = "ClearAll_OnClick('frmPM_CopyTask', 'chkSelect')"


        ' Close

        m_arrMenuItem(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE")
        m_arrMenuTooltip(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CLOSE) = "Close_OnClick()"

        ' Help 

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        'arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrMenuTooltip(MenuIndex.HELP) = "Help"

        'modified by harshada d for whiziblesem 6 help ids updations on 3 April 2006
        'm_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick(" & m_lngTagId.ToString() & ")"
        m_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick('PM_COPYTASK')"
        'end of modification by harshada d for whiziblesem 6 help ids updations on 3 April 2006

        m_objMenu = New WebPages.Template.StaticMenu

        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)

        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

    End Sub

#End Region


#Region "Functions and Sub-Procedures"

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


        ' Draw Menu 
        Call InitPageMenu()

        ' Draw Page Header 
        'Call Draw_Page_Header()

        Call Draw_Filter()

        If m_Mode = MODE_GET_TASK Or m_Mode = "ADD_NEW" Then
            Call DrawTaskGrid()
        End If
        


        If m_Mode = MODE_LIST_TASK Then
            If Request.QueryString("MODE_LIST") <> "BACKLIST" Then
                Call Save_TaskData()
            End If
            Call DrawTaskList()
        End If

        If m_Mode = MODE_CONFIGURE_ATTRIBUTES Then
            Call DrawAttributeSelectionGrid()
        End If

        CommonFunction.General.WriteHTML("</DIV>")
        ' Draw Menu 

        If m_Mode = MODE_GET_TASK Or m_Mode = "ADD_NEW" Then
            'Call Draw_Note()
        End If

        Call InitPageMenu()

        If m_Mode = MODE_CREATE_TASK Or m_Mode = MODE_CREAT_TASK_WITH_BASELINE Then
            Call Create_Task()
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
        'Modified By NitinVS on 25 Apr 2007 for WhizibleSEM SP 8 regression Fixes IssueID 12073 
        ' To Follow the access rights for assigned task page 
        m_objGlobal.TagID = 1038
        ' End Modification By NitinVS on 25 Apr 2007 for WhizibleSEM SP 8 regression Fixes IssueID 12073 

        m_objAccessRights = New cAccessRights(m_objGlobal)

        m_objAccessRights.GetAccess()
        m_lngTagId = m_objGlobal.TagID
    End Sub

    Protected Sub Draw_Page_Header()
        '====================================================================
        ' Procedure Name        :  Draw_Page_Header
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To Draw the Page Header 
        ' Description           :  This sub-routine Draws the Page Header Details 
        '                          gets the Tag ID
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrakashR
        ' Created               :  
        ' Revisions             :  
        '=====================================================================
        Dim m_strWindowTitle As String
        ' Modified By MahendraV On 7:47 PM 5/8/2007
        ' Purpose       : for displaying title of page 'PM_CopyTask'
        ' Added code    : m_Mode = MODE_GET_TASK Or
        
            m_strWindowTitle = "Copy Tasks "



        CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)

    End Sub

    Public Sub getQueryStringParameters()
        '====================================================================
        ' Procedure Name        :  getQueryStringParameters
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To Store the QureyString Parameters
        ' Description           :  This sub-routine stores teh QueryString Parameters
        '                          
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  NitinVS 
        ' Created               :  7 May 2005 
        ' Revisions             :  
        '=====================================================================
        'If Request.QueryString("MODE_SESSION") <> "" Then
        '    Session("MODE_SESSION") = CommonFunctions.General.CheckIsNothing(Request.QueryString("MODE_SESSION"), "")
        'End If

        m_Mode = CommonFunctions.General.CheckIsNothing(Request.QueryString("MODE"), "")

        If m_Mode = MODE_GET_TASK Then
            Session("MODE_SESSION") = "MODE_EDIT"
            strSession = "MODE_EDIT"
        End If

        If m_Mode = MODE_ADD_NEW Then
            Session("MODE_SESSION") = "MODE_NEW"
            strSession = "MODE_NEW"
        End If

        If Not Request.QueryString("UNIQUEID") Is Nothing And Request.QueryString("UNIQUEID") <> "" Then
            m_UniqueID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("UNIQUEID"), "0"), Long)
        Else
            m_UniqueID = 0
        End If

        m_UniqueID_New = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("UNIQUEID_NEW"), "0"), Long)

        m_ParentTagId = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("PARENT_TAGID"), "0"), Long)

        m_ProjectID = m_objGlobal.ProjectID.ToString

        m_FromDate = CommonFunctions.General.CheckIsNothing(Request.QueryString("FROMDATE"), "")

        m_ToDate = CommonFunctions.General.CheckIsNothing(Request.QueryString("TODATE"), "")

        m_QueryString = "?MODE=" + m_Mode + "&PARENT_TAGID=" + m_ParentTagId.ToString + "&UNIQUEID=" + m_UniqueID.ToString + "&FROMDATE=" + m_FromDate + "&TODATE=" + m_ToDate + "&UNIQUEID_NEW=" + m_UniqueID_New.ToString

        CurrentSession = HttpContext.Current.Session.SessionID

        strAttributeStatus = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ATTRIBUTE_STATUS"), "")

    End Sub

    Private Sub Draw_Filter()
        '====================================================================
        ' Procedure Name        :  Draw_Filter
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To Draw the Filter based on the mode 
        ' Description           :  This sub-routine Draws the filter section based on the mode 
        '                          SP usp_get_Filter_for_Task_CopyFunctionality gets the Source for Combo and name of the Combo
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  NitinVS 
        ' Created               :  7 May 2005 
        ' Revisions             :  
        '=====================================================================

        Dim strSQL As String
        Dim objDr As IDataReader
        Dim strModuleNmae As String
        Dim strSQLTo As String
        Dim objdrTo As IDataReader
        Dim strCopyTo As String

        strSQL = "usp_get_Filter_for_Task_CopyFunctionality " + m_ParentTagId.ToString + " , " + m_ProjectID

        'If m_UniqueID <> 0 Then
        '    strSQL += " , " + m_UniqueID.ToString
        'End If

        objDr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        If objDr.Read Then

            strComboName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("ComboTitle"), ""), "")

            strComboSource = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("ComboSource"), ""), "")

            strPrimaryKey = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("PrimaryKey"), ""), "")



        End If

        CommonFunction.Data.DisposeDataReader(objDr)

        strSQL = strComboSource
        objDr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If Request.QueryString("Combo") <> "" Then
            CopyFromID = Request.QueryString("Combo")
        Else
            CopyFromID = "NULL"
        End If
        Dim str As String
        ' While objDr.Read
        If m_Mode = MODE_LIST_TASK And Not (Request.QueryString("MODE_LIST") = "BACKLIST") Then
            If strPrimaryKey = "ModuleID" Or Not Request.QueryString("MODE_LIST") = "BACKLIST" Then
                'strModuleNmae = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("ModuleName"), ""), "")

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''Session("strModuleNmae") = CType(CommonFunction.Data.GetDataScalar("SELECT ModuleName FROM tbl_PM_Module WHERE  ProjectID=" + m_ProjectID + " And ModuleID=" + CopyFromID, MyBase.UseSQL), String)
                Session("strModuleNmae") = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_Module_ModuleName " + m_ProjectID + "," + CopyFromID, MyBase.UseSQL), String)
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            End If
            If strPrimaryKey = "SubProjectID" Then
                'strModuleNmae = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("SubProjectName"), ""), "")

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''Session("strModuleNmae") = CType(CommonFunction.Data.GetDataScalar("SELECT SubProjectname FROM tbl_PM_SubProject WHERE  ProjectID=" + m_ProjectID + " And SubProjectID=" + CopyFromID, MyBase.UseSQL), String)
                Session("strModuleNmae") = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_SubProject_SubProjectname " + m_ProjectID + "," + CopyFromID, MyBase.UseSQL), String)
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            End If
            If strPrimaryKey = "MilestoneID" Then
                'strModuleNmae = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("Milestone"), ""), "")

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''Session("strModuleNmae") = CType(CommonFunction.Data.GetDataScalar("SELECT Milestone FROM tbl_PM_Milestones WHERE  ProjectID=" + m_ProjectID + " And MilestoneID=" + CopyFromID, MyBase.UseSQL), String)
                Session("strModuleNmae") = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_Milestones_MilestoneName " + m_ProjectID + "," + CopyFromID, MyBase.UseSQL), String)
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            End If
            If strPrimaryKey = "DeliverableID" Then
                'strModuleNmae = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("Title"), ""), "")

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''Session("strModuleNmae") = CType(CommonFunction.Data.GetDataScalar("SELECT Title FROM tbl_PM_OtherSchedules WHERE  ProjectID=" + m_ProjectID + " And ScheduleID=" + CopyFromID, MyBase.UseSQL), String)
                Session("strModuleNmae") = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_OtherSchedules_TitleName " + m_ProjectID + "," + CopyFromID, MyBase.UseSQL), String)
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
            End If
        End If

        If m_Mode = "ADD_NEW" Then
            If strPrimaryKey = "ModuleID" Or Not Request.QueryString("MODE_LIST") = "BACKLIST" Then
                'strModuleNmae = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("ModuleName"), ""), "")

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''Session("strModuleNmae") = CType(CommonFunction.Data.GetDataScalar("SELECT ModuleName FROM tbl_PM_Module WHERE  ProjectID=" + m_ProjectID + " And ModuleID=" + m_UniqueID.ToString, MyBase.UseSQL), String)
                Session("strModuleNmae") = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_Module_ModuleName " + m_ProjectID + "," + m_UniqueID.ToString, MyBase.UseSQL), String)
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            End If
            If strPrimaryKey = "SubProjectID" Then
                'strModuleNmae = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("SubProjectName"), ""), "")

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                'Session("strModuleNmae") = CType(CommonFunction.Data.GetDataScalar("SELECT SubProjectname FROM tbl_PM_SubProject WHERE  ProjectID=" + m_ProjectID + " And SubProjectID=" + m_UniqueID.ToString, MyBase.UseSQL), String)
                Session("strModuleNmae") = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_SubProject_SubProjectname " + m_ProjectID + "," + m_UniqueID.ToString, MyBase.UseSQL), String)

                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            End If
            If strPrimaryKey = "MilestoneID" Then
                'strModuleNmae = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("Milestone"), ""), "")

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''Session("strModuleNmae") = CType(CommonFunction.Data.GetDataScalar("SELECT Milestone FROM tbl_PM_Milestones WHERE  ProjectID=" + m_ProjectID + " And MilestoneID=" + m_UniqueID.ToString, MyBase.UseSQL), String)
                Session("strModuleNmae") = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_Milestones_MilestoneName " + m_ProjectID + "," + m_UniqueID.ToString, MyBase.UseSQL), String)

                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
            End If
            If strPrimaryKey = "DeliverableID" Then
                'strModuleNmae = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDr("Title"), ""), "")

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''Session("strModuleNmae") = CType(CommonFunction.Data.GetDataScalar("SELECT Title FROM tbl_PM_OtherSchedules WHERE  ProjectID=" + m_ProjectID + " And ScheduleID=" + m_UniqueID.ToString, MyBase.UseSQL), String)
                Session("strModuleNmae") = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_OtherSchedules_TitleName " + m_ProjectID + "," + m_UniqueID.ToString, MyBase.UseSQL), String)

                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            End If
        End If


        strModuleNmae = CType(Session("strModuleNmae"), String)
        'End While
        'Added by SavitaS for Sierra IssueID 1512 on 27 June 2006
        CommonFunction.Data.DisposeDataReader(objDr)
        'End of Added by SavitaS for Sierra IssueID 1512 on 26 June 2006
        If strModuleNmae <> "" Then
            Session("strModuleNmaeNew") = strModuleNmae
        End If

        If strPrimaryKey = "ModuleID" Then
            strSQLTo = "SELECT ModuleName FROM tbl_PM_Module WHERE ProjectID =" + m_ProjectID + "  AND ModuleID =" + Request.QueryString("UNIQUEID_NEW").ToString
            objdrTo = CommonFunction.Data.GetDataReader(strSQLTo, MyBase.UseSQL)
            If objdrTo.Read Then
                strCopyTo = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objdrTo("ModuleName"), ""), "")
            End If
        End If
        If strPrimaryKey = "SubProjectID" Then
            strSQLTo = "SELECT SubProjectName FROM tbl_PM_SubProject WHERE ProjectID =" + m_ProjectID + "  AND SubProjectID =" + Request.QueryString("UNIQUEID_NEW").ToString
            objdrTo = CommonFunction.Data.GetDataReader(strSQLTo, MyBase.UseSQL)
            If objdrTo.Read Then
                strCopyTo = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objdrTo("SubProjectName"), ""), "")
            End If
        End If
        If strPrimaryKey = "MilestoneID" Then
            strSQLTo = "SELECT MileStone FROM tbl_PM_MileStones WHERE ProjectID =" + m_ProjectID + "  AND MilestoneID =" + Request.QueryString("UNIQUEID_NEW").ToString
            objdrTo = CommonFunction.Data.GetDataReader(strSQLTo, MyBase.UseSQL)
            If objdrTo.Read Then
                strCopyTo = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objdrTo("MileStone"), ""), "")
            End If
        End If

        If strPrimaryKey = "DeliverableID" Then
            strSQLTo = "SELECT Title FROM tbl_PM_OtherSchedules WHERE ProjectID =" + m_ProjectID + "  AND ScheduleID =" + Request.QueryString("UNIQUEID_NEW").ToString
            objdrTo = CommonFunction.Data.GetDataReader(strSQLTo, MyBase.UseSQL)
            If objdrTo.Read Then
                strCopyTo = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objdrTo("Title"), ""), "")
            End If
        End If


        CommonFunction.General.WriteHTML("<DIV ID=PageDiv style='overflow:auto;width:100%;height:390'>")

        CommonFunction.General.WriteHTML("<TABLE CellSpacing=0 Class=clsTable Width='99.9%'>  ")


        'CommonFunction.General.WriteHTML("</TD>")

        'CommonFunction.General.WriteHTML("<TD colspan=3 align = left >")
        CommonFunction.General.WriteHTML("<TR class=clsTRPageCaption><TD align=Left>Copy Tasks</TD><TD align=Right></TD></TR>")
        CommonFunction.General.WriteHTML("</TABLE>")
        CommonFunction.General.WriteHTML("<BR>")
        CommonFunction.General.WriteHTML("<TABLE CellSpacing=0 Class=clsTable Width='99.9%'>  ")
        If Not (m_Mode = MODE_GET_TASK Or m_Mode = MODE_TASK) Then
            ' If Not (m_Mode = MODE_EDIT Or m_Mode = MODE_TASK) Then

            CommonFunction.HTMLControls.DrawComboBox("cboFilter", strComboSource, , m_UniqueID.ToString, "onChange=GetTaskDetails_OnClick(this.value)", True, , , , , True)
            'CommonFunction.General.WriteHTML("&nbsp;&nbsp;" + strModuleNmae)
            'CommonFunction.General.WriteHTML("<TR class=clsTRPageCaption><TD align=Left>Copy Task</TD><TD align=Right>" + strComboName + ":" + strModuleNmae)
            'CommonFunction.General.WriteHTML("<TR class=clsTRPageCaption><TD align=Left>Copy Task</TD><TD align=Right></TD></TR>")
            CommonFunction.General.WriteHTML("<TR class=clsTROdd><TD align=Left>Copy From&nbsp;&nbsp;:&nbsp;" + CType(Session("strModuleNmaeNew"), String) + "</TD><TD align=Right></TD></TR>")
            CommonFunction.General.WriteHTML("<TR class=clsTROdd><TD align=Left>Copy To&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;" + strCopyTo + "</TD><TD align=Right></TD></TR>")
        Else

            CommonFunction.General.WriteHTML("<TR class='clsTROdd'>")
            CommonFunction.General.WriteHTML("<TD align=left valign=top>")
            'CommonFunction.General.WriteHTML(strComboName)
            CommonFunction.General.WriteHTML("Copy From&nbsp;&nbsp;:&nbsp;")
            CommonFunction.HTMLControls.DrawComboBox("cboFilter", strComboSource, 200, m_UniqueID.ToString, "onChange=GetTaskDetails_OnClick(this.value)", True)
            CommonFunction.General.WriteHTML("</TD>&nbsp;<TD></TD></TR>")
            CommonFunction.General.WriteHTML("<TR class=clsTROdd><TD align=Left>Copy To&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;" + strCopyTo + "</TD><TD align=Right></TD></TR>")

        End If

        'CommonFunction.General.WriteHTML("</TD></TR>")
        'CommonFunction.General.WriteHTML("</TD><TD>&nbsp;</TD><TD>&nbsp;</TD></TR>")

        'If m_Mode = MODE_EDIT Then
        'If m_Mode = MODE_GET_TASK Then
        '    CommonFunction.General.WriteHTML("<TR class='clsTREven'>")

        '    CommonFunction.General.WriteHTML("<TD align=middle valign=top colspan='2'>")

        '    CommonFunction.General.WriteHTML(MyBase.GetResourceString("LABEL_FILTER") + "&nbsp;&nbsp;" + MyBase.GetResourceString("LABEL_FROM_DATE"))

        '    'CommonFunction.General.WriteHTML("</TD>")

        '    'CommonFunction.General.WriteHTML("<TD colspan=3 align = left >")

        '    CommonFunction.HTMLControls.DrawDateControl("txtFromDateFilter", "txtFromDateFilter", , , m_FromDate, , "frmPM_CopyTask")

        '    'CommonFunction.General.WriteHTML("</TD>")

        '    'CommonFunction.General.WriteHTML("</TR>")


        '    'CommonFunction.General.WriteHTML("<TR class='clsTREven'>")

        '    'CommonFunction.General.WriteHTML("<TD align=right valign=top>")

        '    CommonFunction.General.WriteHTML("&nbsp;&nbsp;" + MyBase.GetResourceString("LABEL_TO_DATE"))

        '    'CommonFunction.General.WriteHTML("</TD>")
        '    'CommonFunction.General.WriteHTML("<TD>")
        '    'CommonFunction.General.WriteHTML("<TD colspan=3 align = left >")

        '    CommonFunction.HTMLControls.DrawDateControl("txtToDateFilter", "txtToDateFilter", , , m_ToDate, , "frmPM_CopyTask")


        '    CommonFunction.General.WriteHTML("<A href='javascript:GetTaskDetails_OnClick()'>Get Task Details</A>")


        '    CommonFunction.General.WriteHTML("</TD>")
        '    'CommonFunction.General.WriteHTML("<TD>&nbsp;</TD>")
        '    CommonFunction.General.WriteHTML("</TR>")

        'End If


        CommonFunction.General.WriteHTML("</TABLE>")
        CommonFunctions.Data.DisposeDataReader(objdrTo)

    End Sub

    Private Sub DrawTaskGrid()
        '====================================================================
        ' Procedure Name        :  DrawTaskGrid
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To Draw the Task Grid based on the select 
        ' Description           :  This sub-routine Draws the filter section based on the mode 
        '                          SP usp_get_Filter_for_Task_CopyFunctionality gets the Source for Combo and name of the Combo
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  NitinVS 
        ' Created               :  7 May 2005 
        ' Revisions             :  
        '=====================================================================
        Dim strSqlTask As String

        Dim objDRTask As IDataReader
        Dim intRowCount As Long = 0
        Dim strTrClass As String

        Dim strTaskName As String
        Dim strTaskId As String
        Dim strParentTask_UID As String
        Dim strStartDate As String
        Dim strEndDate As String
        Dim strEffort As String
        Dim strResource As String
        Dim strtasktype As String
        Dim StrTaskTypeID As String
        Dim strSubTaskType As String
        Dim strSubTaskTypeID As String
        Dim strPriority As String
        Dim strModule As String
        Dim strModuleID As String
        Dim strMileStoneID As String
        Dim strMileStone As String
        Dim strSubProjectID As String
        Dim strSubProject As String
        Dim strDeliverableID As String
        Dim strDeliverableTypeID As String
        Dim strActive As String
        Dim strBillableYN As String
        'integration done by SuchitraP on 25-Jun-2007
        'added by Christinat on 19/06/2007 for RequestID : 7548
        Dim strPhaseID As String
        Dim strPhase As String
        'End of addition by ChristinaT
        'end of integration done by SuchitraP on 25-Jun-2007

        Dim strSqlSubTaskType As String

        'Added By VivekP On 20 May 2005
        Dim teammemberssql As String = ""
        Dim drteammember As IDataReader
        Dim drLeaveQuery As IDataReader
        Dim strTemp As String = ""
        Dim strTempName As String = ""
        Dim strLeaveQuery As String = ""
        teammemberssql = "EXEC usp_Sel_teammembers " & m_ProjectID.ToString()
        drteammember = CommonFunction.Data.GetDataReader(teammemberssql, MyBase.UseSQL)
        While drteammember.Read
            strTemp = drteammember.Item("EmployeeID").ToString()
            'modified by harshada d for whiziblesem SP7.3 for issue id 4518
            'strLeaveQuery = " SELECT EmployeeName,* FROM tbl_PM_EmployeeLeaveDetails   INNER JOIN tbl_PM_Employee ON tbl_PM_Employee.EmployeeID = tbl_PM_EmployeeLeaveDetails.EmployeeID  WHERE tbl_PM_EmployeeLeaveDetails.EmployeeID =" + strTemp + "  AND  LeaveStatusID = (SELECT LeaveStatusID FROM tbl_PM_LeaveStatusMaster WHERE LeaveStatus = 'Approved')"
            'Commented and Modified by SavitaS for Sierra IssueID 1512 on 26 June 2006
            'strLeaveQuery = " SELECT tbl_PM_Employee.EmployeeName,tbl_PM_EmployeeLeaveDetails.EmployeeID,tbl_PM_EmployeeLeaveDetails.FromDate,tbl_PM_EmployeeLeaveDetails.ToDate FROM tbl_PM_EmployeeLeaveDetails   INNER JOIN tbl_PM_Employee ON tbl_PM_Employee.EmployeeID = tbl_PM_EmployeeLeaveDetails.EmployeeID  WHERE tbl_PM_EmployeeLeaveDetails.EmployeeID =" + strTemp + "  AND  LeaveStatusID = (SELECT LeaveStatusID FROM tbl_PM_LeaveStatusMaster WHERE LeaveStatus = 'Approved')"
            strLeaveQuery = "Exec usp_Sel_EmployeeLeaveDetails " & strTemp
            'End Modification by SavitaS

            drLeaveQuery = CommonFunction.Data.GetDataReader(strLeaveQuery, MyBase.UseSQL)
            '' Commented & Modfied By ParagD On 10-July-2006
            '' Purpose : Sierra 1512 - Page crash when click on "Inherit Task" link.

            ''While drLeaveQuery.Read
            ''    strEmployeeID &= strEmployee & drLeaveQuery.Item("EmployeeID").ToString() & ","
            ''    strEmployee &= strEmployee & drLeaveQuery.Item("EmployeeName").ToString() & ","
            ''    strLeaveFromDate &= strLeaveFromDate & drLeaveQuery.Item("FromDate").ToString() & ","
            ''    strLeaveToDate &= strLeaveToDate & drLeaveQuery.Item("ToDate").ToString() & ","
            ''End While

            While drLeaveQuery.Read
                strEmployeeID = strEmployeeID & drLeaveQuery.Item("EmployeeID").ToString() & ","
                strEmployee = strEmployee & drLeaveQuery.Item("EmployeeName").ToString() & ","
                strLeaveFromDate = strLeaveFromDate & drLeaveQuery.Item("FromDate").ToString() & ","
                strLeaveToDate = strLeaveToDate & drLeaveQuery.Item("ToDate").ToString() & ","
            End While
            '' END : Commented & Modfied By ParagD On 10-July-2006

            If strTemp <> "" Then
                m_teammember &= strTemp & ","
            End If
            'Added by SavitaS on 02 MAy 2006 for Sierra IssueID 1512
            CommonFunctions.Data.DisposeDataReader(drLeaveQuery)
        End While
        'Added by SavitaS on 02 MAy 2006 for Sierra IssueID 1512
        CommonFunctions.Data.DisposeDataReader(drteammember)
        'End Of addition By VivekP On 20 May 2005

        strSqlTask = "usp_sel_Task_Details_CopyFunctionality " + m_ProjectID.ToString + " , " + strPrimaryKey

        strSqlTask += " , " + m_UniqueID.ToString

        strSqlTask += " , " + m_UniqueID_New.ToString

        If m_FromDate <> "" Then

            strSqlTask += " , '" + m_FromDate + "'"

            If m_ToDate <> "" Then
                strSqlTask += " , '" + m_ToDate + "'"
            End If

        End If
        '================
        If Request.QueryString("MODE_GRID") = "BACKGRID" Then
            strSqlTask += ",null,null,'" + CurrentSession + "'"
        End If
        '==================

        objDRTask = CommonFunction.Data.GetDataReader(strSqlTask, MyBase.UseSQL)

        CommonFunction.General.WriteHTML("<DIV name=TaskDIV id=TaskDIV width=100% height=230 overflow=auto>" + vbCrLf)

        'CommonFunction.General.WriteHTML("<TABLE name=TaskTable id=TaskTable CellSpacing=0 Class=clsTable Width='100%' >")

        ' Draw The Messgae for Date Format 
        'CommonFunction.General.WriteHTML("<TR class='clsTREven'>")

        'CommonFunction.General.WriteHTML("<TD align=middle valign=top colspan='2'>")

        'CommonFunction.General.WriteHTML(" Selected Date Format  ")

        'CommonFunction.General.WriteHTML("</TD>")

        'CommonFunction.General.WriteHTML("<TD colspan=6 align = left >")

        'CommonFunction.General.WriteHTML(m_strDateFormat)

        'CommonFunction.General.WriteHTML("</TD>")
        'CommonFunction.General.WriteHTML("<TD>&nbsp;</TD>")
        'CommonFunction.General.WriteHTML("</TR>")

        'CommonFunction.General.WriteHTML("<I> ")
        CommonFunctions.General.WriteHTML("<TABLE class=clsTable width=""99.9%"" style=""WIDTH: 100%"">")
        CommonFunction.General.WriteHTML("<tr class='clsTROdd'><td align=right valign=top colspan='2'>")
        CommonFunction.General.WriteHTML("Selected Date Format :&nbsp;" + m_strDateFormat + "&nbsp;&nbsp;&nbsp;&nbsp;")
        CommonFunction.General.WriteHTML("</td></tr>")
        CommonFunction.General.WriteHTML("</table>")
        'CommonFunction.General.WriteHTML("</I> ")

        'CommonFunction.General.WriteHTML("</TABLE>")

        CommonFunction.General.WriteHTML("<TABLE name=TaskTable id=TaskTable CellSpacing=0 Class=clsTable Width='99.9%' >")


        ' Plot the Header Row 

        CommonFunction.General.WriteHTML("<TR class=clsTRPageCaption>")

        ' Task Name 
        CommonFunction.General.WriteHTML("<TD align ='Left'>")

        CommonFunction.General.WriteHTML(MyBase.GetResourceString("COL_TASK_NAME"))

        CommonFunction.General.WriteHTML("</TD>")

        ' Resource 
        CommonFunction.General.WriteHTML("<TD align ='Left'>")

        CommonFunction.General.WriteHTML(MyBase.GetResourceString("COL_TASK_RESOURCE"))

        CommonFunction.General.WriteHTML("</TD>")

        ' Activity 
        ' Applicable for CASE 3 Tasks Only 
        If m_applyEffrortDistribution = True And m_HaveSubTaskTypes = True Then

            CommonFunction.General.WriteHTML("<TD align ='Left'>")

            CommonFunction.General.WriteHTML(MyBase.GetResourceString("COL_TASK_ACTIVITY"))

            CommonFunction.General.WriteHTML("</TD>")

        End If


        ' Start Date 
        CommonFunction.General.WriteHTML("<TD align ='Left'>")

        CommonFunction.General.WriteHTML(MyBase.GetResourceString("COL_TASK_START_DATE"))

        CommonFunction.General.WriteHTML("</TD>")

        ' End Date 

        CommonFunction.General.WriteHTML("<TD align ='Left'>")

        CommonFunction.General.WriteHTML(MyBase.GetResourceString("COL_TASK_END_DATE"))

        CommonFunction.General.WriteHTML("</TD>")

        ' Effort 
        CommonFunction.General.WriteHTML("<TD align ='Right'>")

        ''Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change

        '' CommonFunction.General.WriteHTML(MyBase.GetResourceString("COL_TASK_EFFORT"))
        CommonFunction.General.WriteHTML("Work (H:M)")
        ''End of Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change

        CommonFunction.General.WriteHTML("</TD>")



        ' Select 
        CommonFunction.General.WriteHTML("<TD align ='Left'>")

        CommonFunction.General.WriteHTML(MyBase.GetResourceString("COL_SELECT"))

        CommonFunction.General.WriteHTML("</TD>")

        CommonFunction.General.WriteHTML("</TR>")

        ' Draw the Input Screen for Tasks
        'added by Harshk for issueid 120,121 on 08/09/05 (for resource date validation)
        Dim strSQL As String
        strSQL = "EXEC usp_Sel_Project_Resources_ExpectedDates_AsPer_Role " & m_ProjectID.ToString() & ",0 "
        CommonFunction.HTMLControls.DrawComboBox("cboResourceStartDates", strSQL, 200, , , , , , , , True)
        strSQL = "EXEC usp_Sel_Project_Resources_ExpectedDates_AsPer_Role " & m_ProjectID.ToString() & ",1 "
        CommonFunction.HTMLControls.DrawComboBox("cboResourceEndDates", strSQL, 200, , , , , , , , True)
        'end by Harshk for issueid 120,121
        While objDRTask.Read

            If intRowCount Mod 2 = 0 Then
                strTrClass = "clsTROdd"
            Else
                strTrClass = "clsTREven"
            End If

            ' Get the Values stored in the Local Variables
            strTaskName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("TaskName"), ""), "")
            strResource = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("EmployeeID"), ""), "")
            StrTaskTypeID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("TaskTypeID"), ""), "")
            strtasktype = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("TaskType"), ""), "")
            strSubTaskTypeID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("SubTasktypes"), ""), "")
            strSubTaskType = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("SubTasktype"), ""), "")

            If Request.QueryString("MODE_GRID") = "BACKGRID" Then
                strEffort = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("Effort"), ""), "")
            Else
                strEffort = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("Work"), ""), "")
            End If

            strStartDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("StartDate"), ""), "")
            strEndDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("EndDate"), ""), "")
            strParentTask_UID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("ParentTask_UID"), ""), "")
            strTaskId = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("TaskID"), ""), "")
            strPriority = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("Priority"), ""), "")
            strModuleID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("ModuleID"), ""), "")
            strModule = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("Module"), ""), "")
            strMileStoneID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("MileStoneID"), ""), "")
            strMileStone = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("MileStone"), ""), "")
            strSubProjectID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("SubProjectID"), ""), "")
            strSubProject = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("SubProject"), ""), "")
            strDeliverableID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("DeliverableID"), ""), "")
            strBillableYN = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("BillableYN"), ""), "")
            'integration done by SuchitraP on 25-Jun-2007
            'added by ChristinaT on 19/06/2007 for RequestID : 7548
            strPhaseID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("PhaseID"), ""), "")
            strPhase = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("Phase"), ""), "")
            'End of addition by ChristinaT
            'end of integration done by SuchitraP on 25-Jun-2007
            If Request.QueryString("MODE_GRID") = "BACKGRID" Then
                strDeliverableTypeID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("DeliverableType"), ""), "")
            Else
                strDeliverableTypeID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("DeliverableTypeID"), ""), "")
            End If

            If Request.QueryString("MODE_GRID") = "BACKGRID" Then
                strActive = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDRTask("Active"), ""), "")
            End If

            CommonFunction.General.WriteHTML("<TR class='" + strTrClass + "'>")

            ' Task Name 

            CommonFunction.General.WriteHTML("<TD align ='Left'>")

            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.HTMLControls.DrawTextBox("txtTaskName", "txtTaskName", , 200, 205, strTaskName, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

            CommonFunction.General.WriteHTML("</TD>")

            ' Resource 

            CommonFunction.General.WriteHTML("<TD align ='Left'>")

            'CommonFunction.HTMLControls.DrawComboBox("cboResource", "EXEC usp_Sel_teammembers " & m_ProjectID.ToString(), 100, strResource)
            CommonFunction.HTMLControls.DrawComboBox("cboResource", "EXEC usp_Sel_ProjectResources_TaskAssignment " & m_ProjectID.ToString(), 100, strResource)

            CommonFunction.General.WriteHTML("</TD>")

            ' Activity 
            ' Applicable for CASE 3 Tasks Only 
            If m_applyEffrortDistribution = True And m_HaveSubTaskTypes = True Then

                CommonFunction.General.WriteHTML("<TD align ='Left'>")

                ' The TaskTypeId is stored in the hidden text box 
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                CommonFunction.HTMLControls.DrawTextBox("txtSubTaskTypeID", "txtSubTaskTypeID", , 100, , strSubTaskTypeID, DisplayNone:=True, EnableHTMLEncode:=True)
                CommonFunction.HTMLControls.DrawTextBox("txtSubTaskType", "txtSubTaskType", , 100, , strSubTaskType, DisplayNone:=True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                CommonFunction.General.WriteHTML(strSubTaskType)

                CommonFunction.General.WriteHTML("</TD>")

            End If




            ' Start Date 
            If strStartDate <> "" Then
                strStartDate = CommonFunction.Dates.GetDate(CType(strStartDate, Date))
            End If
            CommonFunction.General.WriteHTML("<TD align ='Left'>")

            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.HTMLControls.DrawTextBox("txtFromDate", "txtFromDate", , 80, , fixDateForDisplay(strStartDate, m_strDateFormat), EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding


            CommonFunction.General.WriteHTML("</TD>")

            ' End Date 


            If strEndDate <> "" Then
                strEndDate = CommonFunction.Dates.GetDate(CType(strEndDate, Date))
            End If
            CommonFunction.General.WriteHTML("<TD align ='Left'>")

            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.HTMLControls.DrawTextBox("txtToDate", "txtToDate", , 80, , fixDateForDisplay(strEndDate, m_strDateFormat), EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

            CommonFunction.General.WriteHTML("</TD>")

            ' Effort 

            CommonFunction.General.WriteHTML("<TD align ='Right'>")

            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

            ''Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change
            '' CommonFunction.HTMLControls.DrawTextBox("txtEffort", "txtEffort", , 50, 10, strEffort, "Right", EnableHTMLEncode:=True)

            m_Effort = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strEffort + "',1)", True)

            CommonFunction.HTMLControls.DrawTextBox("txtEffort", "txtEffort", , 50, 10, m_Effort, "Right", EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txthidEffort", "txthidEffort", , 50, 10, strEffort, "Right", , , , , True, EnableHTMLEncode:=True)
            '' End of Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change

            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

            CommonFunction.General.WriteHTML("</TD>")

            ' Select 
            CommonFunction.General.WriteHTML("<TD align ='Center'>")

            If strActive = "1" Then
                CommonFunction.HTMLControls.DrawCheckBox("chkSelect", "chkSelect" + intRowCount.ToString, , True, intRowCount.ToString)
            Else
                CommonFunction.HTMLControls.DrawCheckBox("chkSelect", "chkSelect" + intRowCount.ToString, , , intRowCount.ToString)
            End If

            CommonFunction.General.WriteHTML("</TD>")

            CommonFunction.General.WriteHTML("</TR>")

            ' Plot hidden Controls 
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.HTMLControls.DrawTextBox("txtParentTask_UID", "txtParentTask_UID", , , , strParentTask_UID, DisplayNone:=True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtTaskID", "txtTaskID", , , , strTaskId, DisplayNone:=True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtTaskTypeID", "txtTaskTypeID", , , , StrTaskTypeID, DisplayNone:=True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtTaskType", "txtTaskType", , , , strtasktype, DisplayNone:=True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtPriority", "txtPriority", , , , strPriority, DisplayNone:=True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtModuleID", "txtModuleID", , , , strModuleID, DisplayNone:=True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtModule", "txtModule", , , , strModule, DisplayNone:=True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtMileStoneID", "txtMileStoneID", , , , strMileStoneID, DisplayNone:=True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtMileStone", "txtMileStone", , , , strMileStone, DisplayNone:=True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtSubProjectID", "txtSubProjectID", , , , strSubProjectID, DisplayNone:=True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtSubProject", "txtSubProject", , , , strSubProject, DisplayNone:=True, EnableHTMLEncode:=True)

            'integration done by SuchitraP on 25-Jun-2007
            'added by ChristinaT on 19/06/2007 for RequestID : 7548
            CommonFunction.HTMLControls.DrawTextBox("txtPhaseID", "txtPhaseID", , , , strPhaseID, DisplayNone:=True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtPhase", "txtPhase", , , , strPhase, DisplayNone:=True, EnableHTMLEncode:=True)
            'end of addition by ChristinaT
            'end of integration done by SuchitraP on 25-Jun-2007
            CommonFunction.HTMLControls.DrawTextBox("txtDeliverableID", "txtDeliverableID", , , , strDeliverableID, DisplayNone:=True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtDeliverableType", "txtDeliverabletype", , , , strDeliverableTypeID, DisplayNone:=True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtBillableYN", "txtBillableYN", , , , strBillableYN, DisplayNone:=True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

            intRowCount += 1

        End While

        If intRowCount = 0 Then
            CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
            CommonFunction.General.WriteHTML("<TD align=middle valign=top colspan='7'>")
            CommonFunction.General.WriteHTML("There is no items in this view.")
            CommonFunction.General.WriteHTML("</TD></TR>")
        End If

        CommonFunction.General.WriteHTML(" </TABLE> ")

        CommonFunction.General.WriteHTML(" </DIV> ")

        CommonFunction.Data.DisposeDataReader(objDRTask)
        strAttributeStatusback = Request.QueryString("ATTRIBUTE_STATUS_BACK1")
    End Sub
    Private Sub Save_TaskData()
        '====================================================================
        ' Procedure Name        :  DrawTaskList
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To Draw the Task List 
        ' Description           :  This sub-routine Draws the List of the Task Selected by the User in previous screen.
        '                          First all form variables are stored in 'tbl_PM_CopyTask' and then the Grid is Shown 
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  NitinVS 
        ' Created               :  7 May 2005 
        ' Revisions             :  
        '=====================================================================

        Dim strSQLTask As String
        Dim intCnt As Integer

        Dim TaskID As Integer
        Dim ParentTask_UID As Integer
        Dim TaskName As String
        Dim ProjectID As Integer
        Dim EmployeeID As Integer
        Dim TasktypeID As Integer
        Dim TaskType As String
        Dim SubTaskTypes As Integer
        Dim SubTaskType As String
        Dim StartDate As String
        Dim EndDate As String
        Dim Effort As Double
        Dim Priority As String
        Dim ModuleID As Integer
        Dim MileStoneID As Integer
        Dim SubProjectID As Integer
        Dim DeliverableID As Integer
        Dim PhaseID As Integer
        Dim TagID As Integer
        Dim SessionID As Integer

        'integrated by harshada d for whiziblesem SP7.3 issue ID 4518
        'Added by SavitaS on 13 July 2006 for DSS IssueID 2228
        Dim strSQL As String
        strSQL = "DELETE FROM tbl_PM_CopyTask WHERE PROJECTID=" + m_ProjectID.ToString
        CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
        'End Addition by SavitaS on 13 July 2006 for DSS IssueID 2228

        ' Store the Form Values in tbl_PM_CopyTask 

        ' Get the Record numbers selected by the user 
        strSelectedTask = HttpContext.Current.Request.QueryString("SELECTEDTASK")

        'Added by VarunA on 11-July-2007 Whizible Regression Development And Release 
        'Purpose : Get the Record numbers selected by the user 
        strSelectedTask = strSelectedTask + ","
        'End By VarunA on 11-July-2007

        If HttpContext.Current.Request.Form.GetValues("txtTaskID").Length > 0 Then
            For intCnt = 0 To HttpContext.Current.Request.Form.GetValues("txtTaskID").Length - 1

                strSQLTask = "  usp_INS_tbl_PM_CopyTask "

                ' TaskID
                If HttpContext.Current.Request.Form.GetValues("txtTaskID")(intCnt) <> "" Then

                    strSQLTask += HttpContext.Current.Request.Form.GetValues("txtTaskID")(intCnt)
                Else
                    strSQLTask += "Null "
                End If

                ' ParentTask_UID
                If HttpContext.Current.Request.Form.GetValues("txtParentTask_UID")(intCnt) <> "" Then
                    strSQLTask += " , " + HttpContext.Current.Request.Form.GetValues("txtParentTask_UID")(intCnt)
                Else
                    strSQLTask += " , Null "
                End If

                ' TaskName
                If HttpContext.Current.Request.Form.GetValues("txtTaskName")(intCnt) <> "" Then
                    strSQLTask += " , '" + CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.Form.GetValues("txtTaskName")(intCnt)) + "'"
                Else
                    strSQLTask += ", Null "
                End If

                'ProjectID 
                strSQLTask += " , " + m_ProjectID.ToString

                'EmployeeID
                If HttpContext.Current.Request.Form.GetValues("cboResource")(intCnt) <> "" Then
                    strSQLTask += " , " + HttpContext.Current.Request.Form.GetValues("cboResource")(intCnt)
                Else
                    strSQLTask += ", Null "
                End If

                ' TaskTypeID 
                If HttpContext.Current.Request.Form.GetValues("txtTaskTypeID")(intCnt) <> "" Then
                    strSQLTask += " , " + HttpContext.Current.Request.Form.GetValues("txtTaskTypeID")(intCnt)
                Else
                    strSQLTask += ", Null "
                End If

                ' TaskType 
                If HttpContext.Current.Request.Form.GetValues("txtTaskType")(intCnt) <> "" Then
                    strSQLTask += " , " + "'" + CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.Form.GetValues("txtTaskType")(intCnt)) + "'"
                Else
                    strSQLTask += ", Null "
                End If

                If m_applyEffrortDistribution = True And m_HaveSubTaskTypes = True Then

                    ' SubTaskTypeID 
                    If HttpContext.Current.Request.Form.GetValues("txtSubTaskTypeID")(intCnt) <> "" Then
                        strSQLTask += " , " + HttpContext.Current.Request.Form.GetValues("txtSubTaskTypeID")(intCnt)
                    Else
                        strSQLTask += ", Null "
                    End If


                    ' SubTaskType
                    If HttpContext.Current.Request.Form.GetValues("txtSubTaskType")(intCnt) <> "" Then
                        strSQLTask += " , " + "'" + CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.Form.GetValues("txtSubTaskType")(intCnt)) + "'"
                    Else
                        strSQLTask += ", Null "
                    End If

                Else
                    strSQLTask += " , Null , Null "
                End If

                ' From Date 

                If HttpContext.Current.Request.Form.GetValues("txtFromDate")(intCnt) <> "" Then
                    strSQLTask += " , '" + fixDateForSave(HttpContext.Current.Request.Form.GetValues("txtFromDate")(intCnt), m_strDateFormat) + "'"
                Else
                    strSQLTask += ", Null "
                End If

                ' To Date

                If HttpContext.Current.Request.Form.GetValues("txtToDate")(intCnt) <> "" Then
                    strSQLTask += " , '" + fixDateForSave(HttpContext.Current.Request.Form.GetValues("txtToDate")(intCnt), m_strDateFormat) + "'"
                Else
                    strSQLTask += ", Null "
                End If

                ' Effort 

                If HttpContext.Current.Request.Form.GetValues("txtEffort")(intCnt) <> "" Then
                    ''Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change

                    ''strSQLTask += " , '" + HttpContext.Current.Request.Form.GetValues("txtEffort")(intCnt) + "'"
                    m_insEffort = HttpContext.Current.Request.Form.GetValues("txtEffort")(intCnt)
                    If m_insEffort.IndexOf(".") = m_insEffort.Length - 1 Then
                        m_insEffort = m_insEffort + "00"
                    End If

                    strSQLTask += " , '" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + m_insEffort + "',2)", True) + "'"
                    ''End Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change
                Else
                    strSQLTask += ", Null "
                End If

                If HttpContext.Current.Request.Form.GetValues("txtBillableYN")(intCnt) = "False" Then
                    strSQLTask += ",0"
                Else
                    strSQLTask += ",1"
                End If


                'Priority 
                If HttpContext.Current.Request.Form.GetValues("txtPriority")(intCnt) <> "" Then
                    strSQLTask += " , " + "'" + CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.Form.GetValues("txtPriority")(intCnt)) + "'"
                Else
                    strSQLTask += ", Null "
                End If

                ' ModuleID 
                If HttpContext.Current.Request.Form.GetValues("txtModuleID")(intCnt) <> "" Then
                    strSQLTask += " , " + HttpContext.Current.Request.Form.GetValues("txtModuleID")(intCnt)
                Else
                    strSQLTask += ", Null "
                End If

                ' Module 
                If HttpContext.Current.Request.Form.GetValues("txtModule")(intCnt) <> "" Then
                    strSQLTask += " ,'" + CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.Form.GetValues("txtModule")(intCnt)) + "'"
                Else
                    strSQLTask += ", Null "
                End If

                ' MileStoneID 
                If HttpContext.Current.Request.Form.GetValues("txtMileStoneID")(intCnt) <> "" Then
                    strSQLTask += " , " + HttpContext.Current.Request.Form.GetValues("txtMileStoneID")(intCnt)
                Else
                    strSQLTask += ", Null "
                End If

                ' MileStone 
                If HttpContext.Current.Request.Form.GetValues("txtMileStone")(intCnt) <> "" Then
                    strSQLTask += " , " + "'" + CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.Form.GetValues("txtMileStone")(intCnt)) + "'"
                Else
                    strSQLTask += ", Null "
                End If

                ' SubOProject 
                If HttpContext.Current.Request.Form.GetValues("txtSubProjectID")(intCnt) <> "" Then
                    strSQLTask += " , " + HttpContext.Current.Request.Form.GetValues("txtSubProjectID")(intCnt)
                Else
                    strSQLTask += ", Null "
                End If

                ' SubProject 
                If HttpContext.Current.Request.Form.GetValues("txtSubProject")(intCnt) <> "" Then
                    strSQLTask += " , " + "'" + CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.Form.GetValues("txtSubProject")(intCnt)) + "'"
                Else
                    strSQLTask += ", Null "
                End If
                'integration done by SuchitraP on 25-Jun-2007
                'added by ChristinaT on 19/06/2007 for RequestID : 7548
                ' PhaseID 
                If HttpContext.Current.Request.Form.GetValues("txtPhaseID")(intCnt) <> "" Then
                    strSQLTask += " , " + HttpContext.Current.Request.Form.GetValues("txtPhaseID")(intCnt)
                Else
                    strSQLTask += ", Null "
                End If

                ' Phase
                If HttpContext.Current.Request.Form.GetValues("txtPhase")(intCnt) <> "" Then
                    strSQLTask += " , " + "'" + CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.Form.GetValues("txtPhase")(intCnt)) + "'"
                Else
                    strSQLTask += ", Null "
                End If
                'end of addition by Christinat
                'end of integration done by SuchitraP on 25-Jun-2007

                ' Deliverable 
                If HttpContext.Current.Request.Form.GetValues("txtDeliverableID")(intCnt) <> "" Then
                    strSQLTask += " , " + HttpContext.Current.Request.Form.GetValues("txtDeliverableID")(intCnt)
                Else
                    strSQLTask += ", Null "
                End If

                ' Deliverable Type 

                If HttpContext.Current.Request.Form.GetValues("txtDeliverableType")(intCnt) <> "" Then
                    strSQLTask += " , " + HttpContext.Current.Request.Form.GetValues("txtDeliverableType")(intCnt)
                Else
                    strSQLTask += ", Null "
                End If

                ' TagID 

                strSQLTask += " , " + m_ParentTagId.ToString

                ' SessionID 
                strSQLTask += " , '" + CurrentSession + "'"

                ' Active

                'Modified By VarunA on 11-July-2007 Whizible Regression Development and Release
                'Purpose : To have those records which are selected
                'If strSelectedTask.IndexOf(intCnt.ToString) >= 0 Then
                If strSelectedTask.IndexOf("," + intCnt.ToString + ",") >= 0 Then
                    'End By VarunA on 11-July-2007
                    strSQLTask += " , 1 "
                Else
                    strSQLTask += ", 0 "
                End If

                ' Execute The Insert SP for tbl_PM_CopyTask  which will Store the Tsk Details in Intermediate Table 
                ' tbl_PM_Copy_Task    

                CommonFunction.Data.InsertOrUpdateData(strSQLTask, MyBase.UseSQL)


            Next

            'Modified By VarunA on 11-July-2007 Whizible Regression Development and Release
            strSelectedTask = strSelectedTask.Remove(strSelectedTask.Length - 1, 1)
            'End by VarunA on 11-July-2007

        End If





    End Sub
    Private Sub DrawTaskList()
        '====================================================================
        ' Procedure Name        : DrawTaskList
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedures assigns values to the Grid object, which display the list of 
        '                         Requests.  
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NitinVS
        ' Created               : May , 10 2005 
        ' Revisions             :
        '=====================================================================

        Dim strQuery As String = ""
        Dim strWhereClause As String = ""
        Dim intColumnsToShow As Integer = 6
        Dim arrActualColumns() As String = {"TaskName", "EmployeeName", "SubTaskType", "StartDate", "EndDate", "Effort"}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("COL_TASK_NAME"),
                                                 MyBase.GetResourceString("COL_TASK_RESOURCE"),
                                                 MyBase.GetResourceString("COL_TASK_ACTIVITY"),
                                                 MyBase.GetResourceString("COL_TASK_START_DATE"),
                                                 MyBase.GetResourceString("COL_TASK_END_DATE"),
                                                                  "Work (H:M)"}
        Dim arrRowLink() As String = {"", "", "", "", "", ""}
        Dim arrstrTDStyle() As String = {"align='left'", "align='left'", "align='left'", "align='left'", "align='left'", "align='Right' "}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        ' Get the Tasks for Current Project , Tag , SessionID and New UniqueID 
        strQuery = "Exec usp_Sel_tbl_PM_CopyTask_for_Copy_Functinality " + m_ProjectID.ToString
        strQuery += " , " + m_ParentTagId.ToString
        strQuery += " , '" + CurrentSession + "'"
        strQuery += " , '" + strPrimaryKey + "'"
        strQuery += " , " + m_UniqueID_New.ToString
        CommonFunction.General.WriteHTML("<BR>")
        CommonFunction.General.WriteHTML("<TABLE CellSpacing=0 Class=clsTable Width='99.9%'>")
        CommonFunction.General.WriteHTML("<TR class='clsTROdd'>")
        CommonFunction.General.WriteHTML("<TD align=left valign=top colspan='2'>")
        CommonFunction.General.WriteHTML(" Following Tasks are selected - ")
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR>")
        CommonFunction.General.WriteHTML("</TABLE>")
        'Set the Advanced Grid Properties
        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .RowLinkArray = arrRowLink
            '.PrimaryKey = "TaskID"
            .EmptyValueReplacement = "&nbsp;"
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "divList"
            .DIVHeight = 450
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = intColumnsToShow
            '.ClientSideSortFunctionName = "Sort_OnClick"
            .TDStyleArray = arrstrTDStyle
            .ColNameToolTipOnEachRow = True
            .returnHTML = True
            'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
        If Request.QueryString("MODE_LIST") = "BACKLIST" Then
            strAttributeStatusback = Request.QueryString("ATTRIBUTE_STATUS_BACK")
        End If
        If Request.QueryString("MODE_LIST_GRID") = "BACKLIST" Then
            strAttributeStatusback = Request.QueryString("ATTRIBUTE_STATUS_BACK1")
        End If

    End Sub

    Private Sub set_variables()
        Dim strSql As String
        Dim objDrProject As IDataReader
        Dim m_lngProjectLocationID As Long
        Dim drWork As IDataReader
        Dim strTemp As String

        'Added By VivekP On 19 May 2005 for holiday validation

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSql = "SELECT LocationID FROM tbl_PM_Project WHERE ProjectID =  " + m_ProjectID.ToString
        strSql = "usp_sel_tbl_PM_Project_LocationID  " + m_ProjectID.ToString
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        m_lngProjectLocationID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSql, MyBase.UseSQL), "False"), Long)
        m_strHolidays = ""
        strSql = "EXEC usp_Sel_tbl_PM_Location_Holiday " & m_lngProjectLocationID.ToString()
        drWork = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            While drWork.Read()
                strTemp = drWork.Item("HolidayDate").ToString()
                If strTemp <> "" Then
                    m_strHolidays &= CommonFunctions.Dates.GetDate(CType(strTemp, Date)) & ","
                End If
            End While
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)

        strSql = "Exec usp_Get_ProjectLocationWorkingHours_Days " & m_ProjectID.ToString()
        drWork = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                m_dblHoursPerDay = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("WorkingHours"), "0"), Double)
                m_lngWeekDays = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("WorkingDays"), "0"), Long)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSql = "Select StartingDayOfWeek from tbl_PM_CompanyInformation"
        strSql = "usp_sel_tbl_PM_CompanyInformation_StartingDayofweek"
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        m_strStartingDayOfWeek = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString()

        'End of Addition By VivekP On 19 May 2005 For holiday validation

        ' Have sub Task Types 

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSql = "SELECT HaveSubTaskTypes FROM tbl_PM_Project WHERE ProjectID =  " + m_ProjectID.ToString
        strSql = "usp_sel_tbl_PM_Project_HaveSubTaskTypes  " + m_ProjectID.ToString
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        m_HaveSubTaskTypes = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSql, MyBase.UseSQL), "False"), Boolean)

        ' Apply Effort Distribution 

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        'strSql = "SELECT ApplyEffortDistribution FROM tbl_PM_Project WHERE ProjectID =  " + m_ProjectID.ToString
        strSql = "usp_sel_tbl_PM_Project_ApplyEffortDistribution  " + m_ProjectID.ToString
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        m_applyEffrortDistribution = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSql, MyBase.UseSQL), "False"), Boolean)

        ' Project Start Date

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSql = "SELECT ExpectedStartDate FROM tbl_PM_Project WHERE ProjectID =  " + m_ProjectID.ToString
        strSql = "usp_sel_tbl_PM_Project_Changeallocation_ExpectedStartDate  " + m_ProjectID.ToString
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        m_strProjectStartDate = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSql, MyBase.UseSQL), ""), String)
        If m_strProjectStartDate <> "" Then m_strProjectStartDate = CommonFunctions.Dates.GetDate(CType(m_strProjectStartDate, Date))

        ' Project End Date

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSql = "SELECT ExpectedEndDate FROM tbl_PM_Project WHERE ProjectID =  " + m_ProjectID.ToString
        strSql = "usp_sel_tbl_PM_project_ChangeAllocationType_expectedenddate " + m_ProjectID.ToString
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        m_strProjectEndDate = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSql, MyBase.UseSQL), ""), String)
        If m_strProjectEndDate <> "" Then m_strProjectEndDate = CommonFunctions.Dates.GetDate(CType(m_strProjectEndDate, Date))

        ' Project LCE 
        strSql = "EXEC usp_Sel_PM_DepartmentBalanceLCE " & m_ProjectID.ToString() & ", NULL"

        objDrProject = CommonFunction.Data.GetDataReader(strSql, MyBase.UseSQL)

        If objDrProject.Read() Then


            m_dblTotalAllocatedTaskLCE = CType(CommonFunctions.Data.CheckIsDBNull(objDrProject.Item("AllocatedLCETotal"), "0"), Double)
            m_dblTotalLCE = CType(CommonFunctions.Data.CheckIsDBNull(objDrProject.Item("LCETotal"), "0"), Double)
        Else
            m_dblTotalAllocatedTaskLCE = 0
            m_dblTotalLCE = 0
        End If

        CommonFunction.Data.DisposeDataReader(objDrProject)

        ' Date Format for Displaying Date
        m_intDateFormat = "1"

        Select Case m_intDateFormat
            Case "1"
                m_strDateFormat = "dd-mm-yyyy"
            Case "2"
                m_strDateFormat = "mm-dd-yyyy"
            Case Else
                m_strDateFormat = "dd-mm-yyyy"
        End Select

        'AddedBY harshK for sp4 issueID 120,121

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''Dim strQuery2 As String = "select IsNull(ResourceValidation,0) from tbl_PM_Project WHERE ProjectID = " & m_ProjectID
        Dim strQuery2 As String = "usp_sel_tbl_PM_Project_ResourceValidation_IsNull " & m_ProjectID
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        If CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery2, MyBase.UseSQL), "True"), Boolean) = True Then
            m_bitResourceValidation = 1
        Else
            m_bitResourceValidation = 0
        End If
        'End AddedBY harshK for sp4 issueID 120,121
    End Sub

    Private Sub DrawAttributeSelectionGrid()
        '====================================================================
        ' Procedure Name        : DrawAttributeSelectionGrid
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedures Draws the attribute selection Grid 
        '                         Requests.  
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NitinVS
        ' Created               : May , 10 2005 
        ' Revisions             :
        '=====================================================================
        Dim DefaultAttributeSelect As Boolean = True
        Dim isDisabled As Boolean = False
        Dim AttributeStatus() As String
        Dim drProjectType As IDataReader
        Dim strProjectType As String
        Dim IsModuleName As Boolean = False
        Dim IsSubProjectName As Boolean = False
        Dim IsMilestoneName As Boolean = False
        'integration done by SuchitraP on 25-Jun-2007
        'Added by Christinat on 19/06/2007 for RequestID : 7548
        Dim IsPhase As Boolean = False
        'End of addition by christinaT
        'enf of integration done by SuchitraP on 25-Jun-2007

        strProjectType = "SELECT ProjectTypeID FROM tbl_PM_Project WHERE ProjectID=" + m_ProjectID.ToString
        drProjectType = CommonFunctions.Data.GetDataReader("usp_Sel_Get_Task_Attributes " & CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strProjectType, MyBase.UseSQL), ""), String), MyBase.UseSQL)
        While drProjectType.Read

            If CType(CommonFunctions.Data.CheckIsDBNull(drProjectType.Item("Attributes"), ""), String) = "Module" Then
                IsModuleName = CType(CommonFunctions.Data.CheckIsDBNull(drProjectType.Item("Mandatory"), ""), Boolean)
            End If

            If CType(CommonFunctions.Data.CheckIsDBNull(drProjectType.Item("Attributes"), ""), String) = "Sub Project" Then
                IsSubProjectName = CType(CommonFunctions.Data.CheckIsDBNull(drProjectType.Item("Mandatory"), ""), Boolean)
            End If

            If CType(CommonFunctions.Data.CheckIsDBNull(drProjectType.Item("Attributes"), ""), String) = "Milestone" Then
                IsMilestoneName = CType(CommonFunctions.Data.CheckIsDBNull(drProjectType.Item("Mandatory"), ""), Boolean)
            End If
            'integration done by SuchitraP on 25-Jun-2007
            'Added by Christinat on 19/06/2007 for RequestID : 7548  
            If CType(CommonFunctions.Data.CheckIsDBNull(drProjectType.Item("Attributes"), ""), String) = "Phase" Then
                IsPhase = CType(CommonFunctions.Data.CheckIsDBNull(drProjectType.Item("Mandatory"), ""), Boolean)
            End If
            'End of addition by christinaT
            'end of integration done by SuchitraP on 25-Jun-2007
        End While
        CommonFunction.Data.DisposeDataReader(drProjectType)
        If Request.QueryString("ATTRIBUTE_STATUS_BACK1") <> "" Then
            strAttributeStatusback = Request.QueryString("ATTRIBUTE_STATUS_BACK1")
            AttributeStatus = strAttributeStatusback.Split(CType(",", Char))
        End If

        'If (IsModuleName = True Or IsSubProjectName = True Or IsMilestoneName = True) And m_ParentTagId <> CommonFunction.Constants.APP_TAG_MODULES Then
        CommonFunction.General.WriteHTML("<TABLE CellSpacing=0 Class=clsTable Width='99.9%'>  ")
        CommonFunction.General.WriteHTML("<TR class=clsTROdd><TD align=right><I><Strong>Note</Strong>&nbsp;:&nbsp;The mandatory task attributes are disabled.</I></TD></TR></TABLE>")
        'End If

        CommonFunction.General.WriteHTML("<TABLE Class= clsTable Width='99.9%'>")
        CommonFunction.General.WriteHTML("<TR class='clsTRPageCaption'>")

        CommonFunction.General.WriteHTML("<TD align='left' colspan=2>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("SELECT_ATTRIBUTE_LABLE"))
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR>")
        ' Module 

        ' if the Tasks are Copied for Module then Module is Mandatory hence made it selected and disabled 

        If m_ParentTagId = CommonFunction.Constants.APP_TAG_MODULES Then
            isDisabled = True
        End If

        If isDisabled = False Then
            CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
            CommonFunction.General.WriteHTML("<TD align='right' >")
        End If

        If Request.QueryString("ATTRIBUTE_STATUS_BACK1") <> "" Then
            'CommonFunction.HTMLControls.DrawCheckBox("chkModule", "chkModule", , CType(AttributeStatus(0), Boolean), "Module", isDisabled, )
            CommonFunction.HTMLControls.DrawCheckBox("chkModule", "chkModule", , CType(AttributeStatus(0), Boolean), "Module", IsModuleName, , , , , , isDisabled)
        Else
            'CommonFunction.HTMLControls.DrawCheckBox("chkModule", "chkModule", , DefaultAttributeSelect, "Module", isDisabled, )
            CommonFunction.HTMLControls.DrawCheckBox("chkModule", "chkModule", , DefaultAttributeSelect, "Module", IsModuleName, , , , , , isDisabled)

        End If
        If isDisabled = False Then
            CommonFunction.General.WriteHTML("</TD>")


            CommonFunction.General.WriteHTML("<TD align='left' >")
            CommonFunction.General.WriteHTML(MyBase.GetResourceString("ATTRBITE_MODULE"))
            CommonFunction.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("</TR>")
        End If
        ' Restore Disabled Status 
        isDisabled = False

        ' MileStone 
        If m_ParentTagId = CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS Then
            isDisabled = True
        End If
        If isDisabled = False Then
            CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
            CommonFunction.General.WriteHTML("<TD align='right' >")
        End If
        If Request.QueryString("ATTRIBUTE_STATUS_BACK1") <> "" Then
            'CommonFunction.HTMLControls.DrawCheckBox("chkMileStone", "chkMileStone", , CType(AttributeStatus(1), Boolean), "Milestone", isDisabled, )
            CommonFunction.HTMLControls.DrawCheckBox("chkMileStone", "chkMileStone", , CType(AttributeStatus(1), Boolean), "Milestone", IsMilestoneName, , , , , , isDisabled)
        Else
            'CommonFunction.HTMLControls.DrawCheckBox("chkMileStone", "chkMileStone", , DefaultAttributeSelect, "Milestone", isDisabled, )
            CommonFunction.HTMLControls.DrawCheckBox("chkMileStone", "chkMileStone", , DefaultAttributeSelect, "Milestone", IsMilestoneName, , , , , , isDisabled)
        End If
        If isDisabled = False Then
            CommonFunction.General.WriteHTML("</TD>")


            CommonFunction.General.WriteHTML("<TD align='left' >")
            CommonFunction.General.WriteHTML(MyBase.GetResourceString("ATTRBITE_MILESTONE"))
            CommonFunction.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("</TR>")
        End If

        ' Restore Disabled Status 
        isDisabled = False

        ' Sub Project  
        If m_ParentTagId = CommonFunction.Constants.APP_TAG_SUB_PROJECTS Then
            isDisabled = True
        End If
        If isDisabled = False Then
            CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
            CommonFunction.General.WriteHTML("<TD align='right' >")
        End If
        If Request.QueryString("ATTRIBUTE_STATUS_BACK1") <> "" Then
            'CommonFunction.HTMLControls.DrawCheckBox("chkSubProject", "chkSubProject", , CType(AttributeStatus(2), Boolean), "SubProject", isDisabled, )
            CommonFunction.HTMLControls.DrawCheckBox("chkSubProject", "chkSubProject", , CType(AttributeStatus(2), Boolean), "SubProject", IsSubProjectName, , , , , , isDisabled)
        Else
            'CommonFunction.HTMLControls.DrawCheckBox("chkSubProject", "chkSubProject", , DefaultAttributeSelect, "SubProject", isDisabled, )
            CommonFunction.HTMLControls.DrawCheckBox("chkSubProject", "chkSubProject", , DefaultAttributeSelect, "SubProject", IsSubProjectName, , , , , , isDisabled)
        End If

        If isDisabled = False Then
            CommonFunction.General.WriteHTML("</TD>")


            CommonFunction.General.WriteHTML("<TD align='left' >")
            CommonFunction.General.WriteHTML(MyBase.GetResourceString("ATTRBITE_SUBPROJECT"))
            CommonFunction.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("</TR>")
        End If

        ' Restore Disabled Status 
        isDisabled = False
        ' Deliverable
        If m_ParentTagId = CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE Then
            isDisabled = True
        End If
        If isDisabled = False Then
            CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
            CommonFunction.General.WriteHTML("<TD align='right' >")
        End If
        If Request.QueryString("ATTRIBUTE_STATUS_BACK1") <> "" Then
            'CommonFunction.HTMLControls.DrawCheckBox("chkDeliverable", "chkDeliverable", , CType(AttributeStatus(3), Boolean), "Deliverable", isDisabled, )
            CommonFunction.HTMLControls.DrawCheckBox("chkDeliverable", "chkDeliverable", , CType(AttributeStatus(3), Boolean), "Deliverable", , , , , , , isDisabled)
        Else
            'CommonFunction.HTMLControls.DrawCheckBox("chkDeliverable", "chkDeliverable", , DefaultAttributeSelect, "Deliverable", isDisabled, )
            CommonFunction.HTMLControls.DrawCheckBox("chkDeliverable", "chkDeliverable", , DefaultAttributeSelect, "Deliverable", , , , , , , isDisabled)
        End If
        If isDisabled = False Then
            CommonFunction.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("<TD align='left' >")
            CommonFunction.General.WriteHTML(MyBase.GetResourceString("ATTRBITE_DELIVERABLE"))
            CommonFunction.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("</TR>")
        End If

        ' Restore Disabled Status 
        isDisabled = False
        'integration done by SuchitraP on 25-Jun-2007
        'Added by Christinat on 19/06/2007 for RequestID : 7548  
        'Phase

        'Code commented by SuchitraP on 26-Jun-2007
        'Purpose:To show phase attribute in retained attribute list.
        'If m_ParentTagId = CommonFunction.Constants.APP_TAG_SUB_PROJECTS Then
        '    isDisabled = True
        'End If
        'End of comment by SuchitraP on 26-Jun-2007

        If isDisabled = False Then
            CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
            CommonFunction.General.WriteHTML("<TD align='right' >")
        End If
        If Request.QueryString("ATTRIBUTE_STATUS_BACK1") <> "" Then
            CommonFunction.HTMLControls.DrawCheckBox("chkPhase", "chkPhase", , CType(AttributeStatus(4), Boolean), "Phase", IsPhase, , , , , , isDisabled)
        Else
            CommonFunction.HTMLControls.DrawCheckBox("chkPhase", "chkPhase", , DefaultAttributeSelect, "Phase", IsPhase, , , , , , isDisabled)
        End If

        If isDisabled = False Then
            CommonFunction.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("<TD align='left' >")
            CommonFunction.General.WriteHTML("Phase")
            CommonFunction.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("</TR>")
        End If

        ' Restore Disabled Status 
        isDisabled = False

        'end of addition by ChristinaT
        'end of integration done by SuchitraP on 25-Jun-2007

        'Added by SandipL on 30 Jan 2006 for Task Custom Fields Functionality
        ' Uncomment the commented part if custom fields R to be retained through UI
        'Dim m_strCustomFieldList As String = ""
        'Dim strSQLForCustom As String
        'Dim drCustomAccess As IDataReader
        'Get Accesible CustomFieldIDs List
        'strSQLForCustom = "Exec usp_sel_tbl_PM_RoleCustomFieldSecurity " + m_objGlobal.ProjectID.ToString + "," + m_objGlobal.RoleID.ToString + "," + m_objGlobal.UserID.ToString + ",'Task'"
        'drCustomAccess = CommonFunction.Data.GetDataReader(strSQLForCustom, MyBase.UseSQL)
        'CommonFunction.General.WriteHTML("<TR class='clsTRPageCaption'>")

        'CommonFunction.General.WriteHTML("<TD align='left' colspan=2>")
        'CommonFunction.General.WriteHTML(MyBase.GetResourceString("SELECT_CUSTOMFIELDS_RETAINED"))
        'CommonFunction.General.WriteHTML("</TD>")
        'CommonFunction.General.WriteHTML("</TR>")
        'Commented by TruptiK on 4-Dec-08
        'Purpose:-For whiziblesem8 issueid:-24247
        'While drCustomAccess.Read

        '    Dim strFieldName As String = CType(CommonFunction.General.CheckIsNothing(drCustomAccess("DatabaseFieldName")), String)
        '    Dim strFieldCaption As String = CType(CommonFunction.General.CheckIsNothing(drCustomAccess("UserGivenCaption")), String)
        '    CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
        '    CommonFunction.General.WriteHTML("<TD align='right' >")
        '    CommonFunction.HTMLControls.DrawCheckBox("chkCustomFields", "chkCustomFields", , True, strFieldName, , , , , , , True)
        '    'CommonFunction.HTMLControls.DrawCheckBox("chkCustomFields", "chkCustomFields", , True, strFieldName)
        '    CommonFunction.General.WriteHTML("</TD>")
        '    CommonFunction.General.WriteHTML("<TD align='left' >")
        '    'CommonFunction.General.WriteHTML(strFieldCaption)
        '    CommonFunction.General.WriteHTML("</TD>")
        '    CommonFunction.General.WriteHTML("</TR>")
        'End While
        'End of commented by TruptiK
        'CommonFunction.Data.DisposeDataReader(drCustomAccess)
        'End addition by SandipL on 30 Jan 2006 

        'Added By VijayD On 26 May 2009
        'Purpose: To validate Task assignment for baseline
        Dim dtrCopyTask_Data As IDataReader

        Dim strTaskIDs As String = ""
        Dim strProjectIDs As String = ""
        Dim strEmployeeIDs As String = ""
        Dim strStartDates As String = ""
        Dim strEndDates As String = ""
        Dim strEfforts As String = ""
        Dim strModuleIDs As String = ""
        Dim strMileStoneIDs As String = ""
        Dim strSubProjectIDs As String = ""
        Dim strDeliverableIDs As String = ""
        Dim strPhaseIds As String = ""
        Dim strSQLCreateTask As String = ""

        strSQLCreateTask = "EXEC usp_Sel_tbl_PM_ProjectTask_for_Copy_Task_Functionality " + m_ProjectID.ToString
        strSQLCreateTask += " , " + m_ParentTagId.ToString
        strSQLCreateTask += " , '" + CurrentSession + "'"
        strSQLCreateTask += ", '" + strPrimaryKey + "'"
        strSQLCreateTask += " , " + m_UniqueID_New.ToString
        dtrCopyTask_Data = CommonFunction.Data.GetDataReader(strSQLCreateTask, MyBase.UseSQL)
        While dtrCopyTask_Data.Read
            strTaskIDs = CType(CommonFunction.General.CheckIsNothing(dtrCopyTask_Data("TaskIDs")), String)
            strProjectIDs = CType(CommonFunction.General.CheckIsNothing(dtrCopyTask_Data("ProjectIDs")), String)
            strStartDates = CType(CommonFunction.General.CheckIsNothing(dtrCopyTask_Data("StartDates")), String)
            strEndDates = CType(CommonFunction.General.CheckIsNothing(dtrCopyTask_Data("EndDates")), String)
            strEfforts = CType(CommonFunction.General.CheckIsNothing(dtrCopyTask_Data("Efforts")), String)
            strModuleIDs = CType(CommonFunction.General.CheckIsNothing(dtrCopyTask_Data("ModuleIDs")), String)
            strSubProjectIDs = CType(CommonFunction.General.CheckIsNothing(dtrCopyTask_Data("SubProjectIDs")), String)
            strDeliverableIDs = CType(CommonFunction.General.CheckIsNothing(dtrCopyTask_Data("DeliverableIDs")), String)
            'strPhaseIds = CType(CommonFunction.General.CheckIsNothing(dtrCopyTask_Data("PhaseIds")), String)
            strMileStoneIDs = CType(CommonFunction.General.CheckIsNothing(dtrCopyTask_Data("MileStoneIDs")), String)
        End While
        CommonFunction.Data.DisposeDataReader(dtrCopyTask_Data)

        CommonFunction.General.WriteHTML("<Tr>")
        CommonFunction.General.WriteHTML("<Td>")

        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunction.HTMLControls.DrawTextBox("txtTaskID", "txtTaskID", , 20, , strTaskIDs, , , , , , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtFromDate", "txtFromDate", , 20, , strStartDates, , , , , , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtToDate", "txtToDate", , 20, , strEndDates, , , , , , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtModuleID", "txtModuleID", , 20, , strModuleIDs, , , , , , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtSubProjectID", "txtSubProjectID", , 20, , strSubProjectIDs, , , , , , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtMileStoneID", "txtMileStoneID", , 20, , strMileStoneIDs, , , , , , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtEffort", "txtEffort", , 20, , strEfforts, , , , , , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtDeliverableIDs", "txtDeliverableIDs", , 20, , strDeliverableIDs, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

        CommonFunction.General.WriteHTML("</Td>")
        CommonFunction.General.WriteHTML("</Tr>")

        'End Addition By VijayD On 26 May 2009


        CommonFunction.General.WriteHTML("</TABLE>")

    End Sub

    Private Sub Create_Task()
        '====================================================================
        ' Procedure Name        : Create_Task
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedures will create actual tasks for Copied Tasks 
        '                         Requests.  
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NitinVS
        ' Created               : May , 10 2005 
        ' Revisions             :
        '=====================================================================

        Dim AttributeStatus() As String
        Dim strSQLCreateTask As String

        AttributeStatus = strAttributeStatus.Split(CType(",", Char))

        strSQLCreateTask = "EXEC usp_ins_tbl_PM_ProjectTask_for_Copy_Task_Functionality " + m_ProjectID.ToString
        strSQLCreateTask += " , " + m_ParentTagId.ToString
        strSQLCreateTask += " , '" + CurrentSession + "'"
        strSQLCreateTask += ", '" + strPrimaryKey + "'"
        strSQLCreateTask += " , " + m_UniqueID_New.ToString
        strSQLCreateTask += " , " + AttributeStatus(0)  ' whether ModuleID is stored
        strSQLCreateTask += " , " + AttributeStatus(1)  ' whether MileStoneID is stored
        strSQLCreateTask += " , " + AttributeStatus(2)  ' whether SubProjectID is stored
        strSQLCreateTask += " , " + AttributeStatus(3)  ' whether DeliverableID is stored
        'integration done by SuchitraP on 25-Jun-2007
        'added by ChristinaT on 19/06/2007 for request Id :7548
        strSQLCreateTask += " , " + AttributeStatus(4)  ' whether PhaseID is stored
        'end of addition by ChristinaT
        'integration done by SuchitraP on 25-Jun-2007

        ' If m_Mode = MODE_CREATE_TASK Then
        If m_Mode = MODE_CREATE_TASK Then
            strSQLCreateTask += " , 0" ' Without BasleLine 
        Else
            strSQLCreateTask += " , 1 " ' With BasleLine 
        End If

        ' Username To Be stored as Created By 
        strSQLCreateTask += " , '" + CType(General.BuildQueryString(CommonFunction.General.CheckIsNothing(MyBase.Session("strUserName"), "")), String) + "'"
        'Added by SandipL on 30 Jan 2006 For Custom Fields functionality
        strSQLCreateTask += " , '" + CType(HttpContext.Current.Request("chkCustomFields"), String) + "'"
        'End addition by SandipL  on 30 Jan 2006 
        CommonFunction.Data.InsertOrUpdateData(strSQLCreateTask, MyBase.UseSQL)

        ' Close the Window  

        CommonFunction.General.WriteHTML("<SCRIPT language='javascript'>" + vbCrLf)
        Dim strScript As String
        If CType(Session("MODE_SESSION"), String) = "MODE_EDIT" Then

            'When tasks from a milestone are copied, the milestone itself gets duplicated
            'CommonFunction.General.WriteHTML(" window.opener.location.reload(true); " + vbCrLf) 

            '' START : Modified By SnehalV 5-Oct-2006 for SP7 BFT Integration Issues
            '' CommonFunctions.General.WriteHTML("window.opener.location.href =""../General/CommonList.aspx?FromWhere=PM&MasterTagId=34"";")

            ''Commented and Modified By Aniruddh Gujar on 18-Aug-2014 Purpose::Page Crash Copy Task
            ''CommonFunctions.General.WriteHTML("refreshParent('frmCommonPage','CommonPage.aspx','CommonPage.aspx?FocusOn=SUBTAG');")
            If (m_ParentTagId = "661") Then
                CommonFunctions.General.WriteHTML("refreshParent('frmCommonPage','SubProject_CommonPage.aspx','SubProject_CommonPage.aspx?FocusOn=SUBTAG');")
            Else
                CommonFunctions.General.WriteHTML("refreshParent('frmCommonPage','CommonPage.aspx','CommonPage.aspx?FocusOn=SUBTAG');")
            End If
            ''End of Commented and Modified By Aniruddh Gujar on 18-Aug-2014 Purpose::Page Crash Copy Task

            '' END : Modified By SnehalV 5-Oct-2006 for SP7 BFT Integration Issues
            '' CommonFunction.General.WriteHTML(" window.close(); " + vbCrLf)
        Else
            'CommonFunction.General.WriteHTML("window.close(); " + vbCrLf)
            'strScript += "window.opener.document.forms['frmCommonList'].action = 'CommonList.aspx?Mode=&FromWhere=PM&MasterTagID=454';" + vbCrLf
            'strScript += "window.opener.document.forms['frmCommonList'].submit();" + vbCrLf
            'CommonFunction.General.WriteHTML(strScript)
            'CommonFunctions.General.WriteHTML("refreshParent('frmCommonPage','CommonPage.aspx','CommonPage.aspx?FocusOn=SUBTAG');")
            'CommonFunction.General.WriteHTML("objfrm = GetFormReference('frmCommonList');")
            'CommonFunction.General.WriteHTML("objfrm.action=""Commonlist.aspx?Mode=&ModuleId=165&MasterTagID=454&FromWhere=PM&PagingAlphabet=-1&ParentTagID=0"";")
            'CommonFunction.General.WriteHTML("objfrm.submit();")
        End If
        'CommonFunction.General.WriteHTML("opener.opener.location.reload();")
        ' CommonFunction.General.WriteHTML(" window.close(); " + vbCrLf)
        CommonFunction.General.WriteHTML("</SCRIPT>" + vbCrLf)
        Session.Remove("strModuleNmaeNew")
    End Sub
    Private Sub Draw_Note()
        ' CommonFunction.General.WriteHTML("<div>")
        CommonFunction.General.WriteHTML("<I> ")
        CommonFunctions.General.WriteHTML("<TABLE class=clsTable width=""99.9%"" style=""WIDTH: 100%"">")
        CommonFunction.General.WriteHTML("<tr class='clsTROdd'><td>")
        CommonFunction.General.WriteHTML("<EM><STRONG>Note : </STRONG>Selected Date Format -</EM>" + m_strDateFormat)
        CommonFunction.General.WriteHTML("</td></tr>")
        CommonFunction.General.WriteHTML("</table>")
        CommonFunction.General.WriteHTML("</I> ")
        ' CommonFunction.General.WriteHTML("</div>")
        'CommonFunction.General.WriteHTML("<TABLE name=TaskTable id=TaskTable CellSpacing=0 Class=clsTable Width='100%' >")

        '' Draw The Messgae for Date Format 
        'CommonFunction.General.WriteHTML("<TR class='clsTREven'>")

        'CommonFunction.General.WriteHTML("<TD align=middle valign=top colspan='2'>")

        'CommonFunction.General.WriteHTML(" Selected Date Format  ")

        ''CommonFunction.General.WriteHTML("</TD>")

        ''CommonFunction.General.WriteHTML("<TD colspan=6 align = left >")

        'CommonFunction.General.WriteHTML(m_strDateFormat)

        'CommonFunction.General.WriteHTML("</TD>")
        ''CommonFunction.General.WriteHTML("<TD>&nbsp;</TD>")
        'CommonFunction.General.WriteHTML("</TR>")

        'CommonFunction.General.WriteHTML("</TABLE>")

    End Sub

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
#End Region

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub

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

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print

        'Modified By NitinVS on 25 Apr 2007 for WhizibleSEM SP 8 regression Fixes IssueID 12073 
        ' To Follow the access rights for assigned task page 
        If Args.MenuColIndex <> 9 And Args.MenuColIndex <> 10 And m_objAccessRights.Add = False Then
            Cancel = True
        End If
        'End Modification By NitinVS on 25 Apr 2007 for WhizibleSEM SP 8 regression Fixes IssueID 12073 

        Select Case Args.MenuColIndex

            Case MenuIndex.NEXT_PAGE

                If m_Mode = MODE_CONFIGURE_ATTRIBUTES Then
                    Cancel = True
                End If
                If m_Mode = MODE_LIST_TASK Then
                    Cancel = True
                End If

                If m_Mode = MODE_EDIT Then
                    Cancel = True
                End If



            Case MenuIndex.SELECT_ALL, MenuIndex.CLEAR_ALL

                If m_Mode = MODE_CONFIGURE_ATTRIBUTES Then
                    Cancel = True
                End If

                If m_Mode = MODE_LIST_TASK Then
                    Cancel = True
                End If

                If m_Mode = MODE_EDIT Then
                    Cancel = True
                End If

                'TODO
            Case MenuIndex.BACK
                'If m_Mode = MODE_ADD_NEW Or m_Mode = MODE_EDIT Or m_Mode = MODE_BACK Then
                'Cancel = True
                'End If

                If Not (m_Mode = MODE_GET_TASK) Then
                    Cancel = True
                End If

                If m_Mode = MODE_ADD_NEW Then
                    Cancel = True
                End If

                If CType(Session("MODE_SESSION"), String) = "MODE_NEW" Then
                    Cancel = True
                End If
                Cancel = True
            Case MenuIndex.BACK_ON_GRID
                If Not (m_Mode = MODE_LIST_TASK) Then
                    Cancel = True
                End If



            Case MenuIndex.BACK_ON_LIST

                If Not (m_Mode = MODE_CONFIGURE_ATTRIBUTES) Then
                    Cancel = True
                End If

            Case MenuIndex.CREATE_TASK ', MenuIndex.CREATE_TASK_WITH_BASELINE

                If m_Mode <> MODE_CONFIGURE_ATTRIBUTES Then
                    Cancel = True
                End If

            Case MenuIndex.CONFIGURE_ATTRIBUTES

                If m_Mode <> MODE_LIST_TASK Then
                    Cancel = True
                End If

            Case MenuIndex.GET_TASK

                If m_Mode = MODE_EDIT Then
                    Cancel = True
                End If
                If m_Mode = MODE_ADD_NEW Then
                    Cancel = True
                End If

                If Not (m_Mode = MODE_ADD_NEW Or m_Mode = MODE_EDIT Or m_Mode = MODE_TASK) Then
                    Cancel = True
                End If

        End Select

    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        If Args.ColumnName.ToString = MyBase.GetResourceString("COL_TASK_ACTIVITY") Then
            If Not (m_HaveSubTaskTypes = True And m_applyEffrortDistribution = True) Then
                Cancel = True
            End If
        End If


    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.ColumnName.ToString = MyBase.GetResourceString("COL_TASK_ACTIVITY") Then
            If Not (m_HaveSubTaskTypes = True And m_applyEffrortDistribution = True) Then
                Cancel = True
            End If
        End If
    End Sub

    Private Sub m_objMenu_Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_Menu) Handles m_objMenu.Initialize

    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        ' Get Global Object 
        Call GetGlobalObject()

        ' get the Query String Parameters 
        Call getQueryStringParameters()

        ' Initialise the varialbes 
        Call set_variables()
        ''Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change

        Dim drCompany As IDataReader
        drCompany = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation", True)
        If drCompany.Read() Then
            m_RestrictByMinHours = CommonFunction.Data.CheckIsDBNull(drCompany("RestrictByMinHours"), "0")
        End If
        ''End Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change
    End Sub
End Class
