#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Public Class PM_TaskUpdation
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

#Region " Web Form Designer Generated Code "

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
        'This will initialize all the global objects.
        GetGlobalObject()

        m_blnUseClientDateForDA = CommonFunction.Application.UseClientDateForDA()
        'Added By ShubhadaL
        If (Request.Form("hidFilterDivStatus") & "") = "Open" Or (Request.Form("hidFilterDivStatus") & "") = "" Then
            m_FilterDivStatus = True
        Else
            m_FilterDivStatus = False
        End If
        'End Of Additon by ShubhadaL

        'This will strore the constructed menu string in a string variable.  

      

        'Display the Menu at Bottom
        
        DrawMenu()
        CommonFunctions.General.WriteHTML(strMenu)

        'Display the page caption.
        DrawPageCaption()
        'Display the Header if exist. 
        DrawHeader()

        'Response.Write("<DIV Id='PageDiv' Style='Width:100%;OverFlow:auto;Height=420px'>")


        '--- Display filters for selection
        DisplaySelectionHeader()

        '--- Display Grid with tasks for updation
        DisplayGrid()

        'HttpContext.Current.Response.Write("</DIV>")

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
        Dim drCompanyInformation As IDataReader
        Dim intFirstDay As Integer
        Dim dtFromDate As Date
        Dim drDates As IDataReader

        m_lngTagId = m_objGlobal.TagID
        m_strWindowTitle = MyBase.GetResourceString("HEADING_TASK_UPDATION")

        '--- Get the StartingDayOfWeek
        strSQLQuery = "EXEC usp_Sel_tbl_PM_CompanyInformation"
        drCompanyInformation = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If drCompanyInformation.Read Then
            intFirstDay = CType(CommonFunctions.Data.CheckIsDBNull(drCompanyInformation("StartingDayOfWeek"), "1"), Integer)
        End If
        CommonFunctions.Data.DisposeDataReader(drCompanyInformation)

        '--- Get the Mode
        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"))
        If m_strMode = "" Then
            m_strMode = MODE_LIST
        End If

        '--- Gets information from the Querystring
        '--- Task Type
        m_strTaskType = CommonFunctions.General.CheckIsNothing(Request.QueryString("TaskType"), TASK_TYPE_ASSIGNED)

        '--- If Mode is Save...update the IsTaskComplete field in the tbl_PM_ProjectTasks
        If m_strMode = MODE_SAVE Then

            ''Modified By PrashantD on 16 Sept 2005
            '' Purpose: Logic changed. TaskIDs are coming through form value rather than queryString
            ''          and with 4000 string breaks.

            ''strTaskIDs = CommonFunctions.General.CheckIsNothing(Request.QueryString("TaskIDs"), "")
            Dim Form_TaskIDs_Break As Integer = 0
            Dim LastTaskID As String
            strTaskIDs = ""
            While (Request.Form("strTaskIDs" + CStr(Form_TaskIDs_Break)) <> "")
                strTaskIDs = Request.Form("strTaskIDs" + CStr(Form_TaskIDs_Break))
                If strTaskIDs.LastIndexOf(",") <> strTaskIDs.Length - 1 Then
                    strTaskIDs = LastTaskID + strTaskIDs
                    LastTaskID = strTaskIDs.Substring(strTaskIDs.LastIndexOf(",") + 1)
                    strTaskIDs = strTaskIDs.Substring(0, strTaskIDs.LastIndexOf(",") + 1)
                Else
                    strTaskIDs = LastTaskID + Request.Form("strTaskIDs" + CStr(Form_TaskIDs_Break))
                End If
                Form_TaskIDs_Break += 1
                UpdateTasks(strTaskIDs)
            End While

            '''UpdateTasks(strTaskIDs)
            ''End of Modification By PrashantD on 16 Sept 2005

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
        'intigrated by harshk for sp4 issueid 190
        'Purpose - To Fetch EmployeeID from QueryString
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("EmployeeID")) <> "" Then
            m_intEmployeeID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("EmployeeID")), Integer)
        End If
        'End of Addition
        'end
        ' to solve the issue - When Date Range is given say 1-Jan to 31st May it still shows the Week 1-Jan to 7-Jan 
        ' after post back .
        If (Request.QueryString("Weekly") = "True" Or (Request.QueryString("Weekly") = "") And Request.QueryString("FromDate") = "" Or Request.QueryString("ToDate") = "") Then
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
                strSQLQuery = "EXEC usp_Get_WeekDates '" + FormatDateTime(dtFromDate, DateFormat.ShortDate).ToString + "'"
                drDates = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If drDates.Read Then
                    m_dtFromDate = CommonFunctions.Dates.GetDate(CType(drDates("StartDate"), Date))
                    m_dtToDate = CommonFunctions.Dates.GetDate(CDate(DateAdd("d", 6, CType(m_dtFromDate, Date))))
                End If
                CommonFunctions.Data.DisposeDataReader(drDates)
            End If
        End If

    End Sub

#End Region

#Region "Constants"

    '--- Constants for the Task Types
    Private Const TASK_TYPE_ASSIGNED As String = "O"
    Private Const TASK_TYPE_MPP As String = "M"
    Private Const TASK_TYPE_ISSUE As String = "B"
    Private Const TASK_TYPE_REVIEW As String = "R"

    'Intigrated by HarshK for sp4 issueid 219 on 13/09/2005 
    'Added By MrugajaB on 24th June 2005
    'This constant for tasks which are created through help desk
    Private Const TASK_TYPE_HELPDESK As String = "H"
    'End Addition
    'End Intigrated by HarshK for sp4 issueid 219 on 13/09/2005 

    'Added by MrugajaB on 5th April 2006 for WhizibleSEM 6.0 Issue ID.684
    'Purpose:For displaying all tasks irrispective of their tasktype
    Private Const TASK_TYPE_ALL As String = "A"
    'End Addition
    '--- Constants for Mode
    Private Const MODE_LIST As String = "List"
    Private Const MODE_SAVE As String = "Save"

#End Region

#Region "Member Variables"

    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu    'This variable is used for plotting static menu. 
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid   'This variable is use to plotting grid.
    Private m_objGlobal As WebPages.Template.IGlobal                    'This variable is of global object inteface. 
    Private m_objAccessRights As WebPages.Security.cAccessRights        'This variable is for access rights of page.
    Protected WithEvents frmTaskUpdation As System.Web.UI.HtmlControls.HtmlForm

    Private strMenu As String                           'stores the static menu string.
    Private m_strTaskType As String                     'Stores the Task Type
    Protected m_dtFromDate As String                    'From Date
    Protected m_dtToDate As String                      'To Date
    Private m_intProjectID As Integer                   'Project ID
    Protected m_strWindowTitle As String                'Page Title
    Protected m_lngTagId As Long = 0                    'Tag ID
    Private m_strMode As String                         'Mode
    Private m_intParentTask_UID As Integer
    Private m_intCount As Integer
    Private m_blnUseClientDateForDA As Boolean
    'Intigrated by HarshK on 09/09/05 for sp4 issueid 190
    Private m_intEmployeeID As Integer
    Public m_CheckboxIDs As String
    'END Intigrated by HarshK on 09/09/05 for sp4 issueid 190
    'Added By ShubhadaL
    Protected m_FilterDivStatus As Boolean = True 'm_FilterDivStatus=True means "Open" or m_FilterDivStatus = "Close"
    'End Of Additon by ShubhadaL
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

    Private Sub UpdateTasks(ByVal strTaskIDs As String)

        Dim strSQLQuery As String

        'Here the tasks in the table tbl_PM_ProjectTasks will get udpated
        'i.e Set the IsActiveFlag = 1
        If strTaskIDs <> "" Then
            strSQLQuery = "EXEC usp_Upd_AssignedTasks_Updation '" & Left(strTaskIDs, strTaskIDs.Length - 1) & "','" & m_strTaskType & "'"
            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, True)
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
        If m_objAccessRights.Add = True Or m_objAccessRights.Edit = True Then
            arrMenuList.Add(MyBase.GetResourceString("MENU_SAVE"))
            arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
            arrClientSideFunctionList.Add("Save_OnClick()")
        End If
        'Addtion ended
        arrMenuList.Add(MyBase.GetResourceString("MENU_PREVIOUS_WEEK"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_PREVIOUS_WEEK_TOOLTIP"))
        arrClientSideFunctionList.Add("PreviousWeek_OnClick()")

        arrMenuList.Add(MyBase.GetResourceString("MENU_NEXT_WEEK"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_NEXT_WEEK_TOOLTIP"))
        arrClientSideFunctionList.Add("NextWeek_OnClick()")

        'Intigrated by  HarshK for sp4 issueid 190 
        m_CheckboxIDs = ""
        arrMenuList.Add(MyBase.GetResourceString("MENU_SELECT_ALL"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_SELECT_ALL_TOOLTIP"))
        arrClientSideFunctionList.Add("SelectAll_OnClick()")

        arrMenuList.Add(MyBase.GetResourceString("MENU_CLEAR_ALL"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_CLEAR_ALL_TOOLTIP"))
        arrClientSideFunctionList.Add("ClearAll_OnClick()")
        'End Intigrated by  HarshK for sp4 issueid 190 

        arrMenuList.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        'Modified By VidyaJ - For IssueID - 492 - SP4
        arrClientSideFunctionList.Add("Help_OnClick('2172')")

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

        'Response.Write(PageCaption.GetPageCaptions(m_objGlobal, , , , True))
        'Response.Write("<BR>")

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
        m_objGrid = Nothing
        m_objGlobal = Nothing
        m_objAccessRights = Nothing

    End Sub


    Private Sub DisplaySelectionHeader()
        Dim blnIsChecked As Boolean
        Dim strSQLQuery As String
        Dim objDynamicLink As WebPages.UI.cDynamicLink

        '--- Query for displaying the Projects in Project combo
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

        'Modified by MrugajaB for Issue ID.686 on 18th Feb 2006
        'Purpose:SP which is used for displaying projects is changed

        'strSQLQuery = "EXEC usp_Sel_Project_For_DA_Active_InActive_Projects " + CType(Session("intUserID"), String) + ",NULL,NULL"
        'If m_strProjectFilters <> "" Then
        '    strSQLQuery = "EXEC usp_sel_Projects_forTaskStatusManagement " + CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        'Else
        '    strSQLQuery = "EXEC usp_sel_Projects_forTaskStatusManagement " + CType(Session("intUserID"), String)
        'End If

        strSQLQuery = "EXEC usp_Sel_AccessibleProjects_ForEmployee " + CType(Session("intUserID"), String) & ",0,0,0,0,'" & CType(Session("LoginType"), String) & "',0," & CType(Session("intLoginID"), Long) & ",2,1"

        'End Modification


        '--- Display the Page Caption
        CommonFunctions.General.WriteHTML("<TABLE width=99.9% CellSpacing=0 class='clsTable'><TR class=clsTRBlank><TD align='Right'><B>(<IMG src='../../Images/Star.gif' border=0> Mandatory)</B> </TD></TR></TABLE>")
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("HEADING_TASK_UPDATION"), , , True))
        CommonFunctions.General.WriteHTML("<BR>")

        'Added by ShubhadaL on 1 Feb,2006 
        'Purpose: Added a DIV section for all filters
        ' CommonFunctions.General.WriteHTML("<TABLE width=100% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:showHide_div()""><Img Border=0 id=imgShowHide Src='../../Images/minus.gif' title=''></IMG></A>&nbsp;&nbsp; " & MyBase.GetResourceString("TASK_FILTERS_DIV") & " </TD></TR></TABLE>")
        If m_FilterDivStatus = True Then
            CommonFunctions.General.WriteHTML("<input type=hidden name=hidFilterDivStatus id=hidFilterDivStatus value='Open' />")
            CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:showHide_div()""><Img Border=0 id=imgShowHide Src='../../Images/minus.gif' title=''></IMG></A>&nbsp;&nbsp; " & MyBase.GetResourceString("TASK_FILTERS_DIV") & " </TD></TR></TABLE>")
            CommonFunctions.General.WriteHTML("<DIV id='Show' name='Show' height=50   style=""overflow:auto;display:''"">")

        Else
            CommonFunctions.General.WriteHTML("<input type=hidden name=hidFilterDivStatus id=hidFilterDivStatus value='Close' />")
            CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:showHide_div()""><Img Border=0 id=imgShowHide Src='../../Images/plus.gif' title=''></IMG></A>&nbsp;&nbsp; " & MyBase.GetResourceString("TASK_FILTERS_DIV") & " </TD></TR></TABLE>")
            CommonFunctions.General.WriteHTML("<DIV id='Show' name='Show' height=50   style=""overflow:auto;display:'none'"">")
        End If


        'End of Addition by ShubhadaL on 1 Feb 2006

        '--- Display the Project combo, dates and option buttons for selection
        'Modified by ShraddhaM on Date 21 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")

        '--- Project Combo
        CommonFunctions.General.WriteHTML("<tr class='clsTREven' Width = '100%'>")
        'intigrated by harshk for sp4 issueid 190
        CommonFunctions.General.WriteHTML("<td align='Left' width=60%>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LABEL_SELECT_PROJECT"))
        ' CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("&nbsp;")
        'CommonFunctions.General.WriteHTML("<td align='Left'>")
        CommonFunctions.HTMLControls.DrawComboBox("cboProject", strSQLQuery, 320, CType(m_intProjectID, String), "")
        CommonFunctions.General.WriteHTML("</td>")
        'End 'intigrated by harshk for sp4 issueid 190
        ' CommonFunctions.General.WriteHTML("</tr>") 'Added by ShubhadaL
        'Integrated in Whiz2 by MrugajaB on 15th Dec 2005
        'Added by SandeepA on 17 Nov,2005 for IssueID-684 : Task Completion Status
        'Purpose : Check Task Filter.('Show ALL Tasks' or 'Show Tasks For Period')
        Dim blnChecked As Boolean
        Dim strTaskFilter As String
        'Check Task Filter
        'Modified by Manishk on 19th Feb 2006 For SP 6 IssueID 2176
        'strTaskFilter = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("optMainTaskFilter"), "1")
        strTaskFilter = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("optMainTaskFilter"), "2")
        'Modified by Manishk on 19th Feb 2006 For SP 6 IssueID 2176
        If strTaskFilter = "2" Then
            strTaskFilter = " NULL "
            blnChecked = False
        Else
            blnChecked = True
        End If
        'End of addition by SandepA on 17 Nov,2005 for IssueID-684
        'End Integration
        '      '******************************************************************************
        '      'Commented by Shubhadal on 2 Feb 2006
        '      '******************************************************************************
        '      'Date Filters
        '      CommonFunctions.General.WriteHTML("<td align='Left'>")

        '      'Integrated in Whiz2 by MrugajaB on 15th Dec 2005
        ''Added by SandeepA on 17 Nov,2005 for IssueID-684 : Task Completion Status
        '      'Purpose: Add SPAN tag so as to hide the FromDate and ToDate controls
        '      '******************************************************************************
        '      'Commented by Shubhadal
        '      '******************************************************************************
        '      'If strTaskFilter = " NULL " Then

        '      '    CommonFunctions.General.WriteHTML("<Span id=""FromDate"" name=""FromDate"" style=""visibility:visible"">")
        '      'Else
        '      '    CommonFunctions.General.WriteHTML("<Span id=""FromDate"" name=""FromDate"" style=""visibility:visible"">")
        '      'End If
        '      ''End of addition by SandeepA on 17 Nov,2005 for IssueID-684
        '      ''End Integration
        '      CommonFunctions.General.WriteHTML("<Span id=""FromDate"" name=""FromDate"" style=""visibility:visible"">")
        '      '******************************************************************************
        '      'End commenting by ShubhadaL
        '      '******************************************************************************

        '      CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LABEL_FROM_DATE"))

        '      CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , , m_dtFromDate, , "frmPM_TaskUpdation", returnHTML:=True, IsMandatory:=True))

        '      'Integrated in Whiz2 by MrugajaB on 15th Dec 2005
        '      'Added by SandeepA on 17 Nov,2005 for IssueID-684 : Task Completion Status
        '      'Purpose: End of SPAN tag

        '      CommonFunctions.General.WriteHTML("</Span>")
        '      'End of addition by SandeepA on 17 Nov,2005 for IssueID-684
        '      'End Integration  

        '      CommonFunctions.General.WriteHTML("</td>")
        '      CommonFunctions.General.WriteHTML("<td align='Left'>")

        '      'Integrated in Whiz2 by MrugajaB on 15th Dec 2005
        '      'Added by SandeepA on 17 Nov,2005 for IssueID-684 : Task Completion Status
        '      'Purpose: Add SPAN tag so as to hide the FromDate and ToDate controls
        '      '*********************************************************************
        '      'commented by ShubhadaL
        '      '*********************************************************************
        '      'If strTaskFilter = " NULL " Then
        '      '    CommonFunctions.General.WriteHTML("<Span id=""ToDate"" name=""ToDate"" style=""visibility:visible"">")
        '      'Else
        '      '    CommonFunctions.General.WriteHTML("<Span id=""ToDate"" name=""ToDate"" style=""visibility:visible"">")
        '      'End If
        '      'End of addition by SandeepA on 17 Nov,2005 for IssueID-684
        '      '**********************************************************************************
        '      'End of commenting by ShubhadaL
        '      '**********************************************************************************
        '      CommonFunctions.General.WriteHTML("<Span id=""ToDate"" name=""ToDate"" style=""visibility:visible"">")
        '      'End integration
        '      CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LABEL_TO_DATE"))

        '          CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , m_dtToDate, , "frmPM_TaskUpdation", returnHTML:=True, ISmandatory:=True))

        '      'Integrated in Whiz2 by MrugajaB on 15th Dec 2005
        '      'Added by SandeepA on 17 Nov,2005 for IssueID-684 : Task Completion Status
        '      'Purpose: End of SPAN Tag.
        '      CommonFunctions.General.WriteHTML("</Span>")
        '      'End of addition by SandeepA on 17 Nov,2005 for IssueID-684
        '      'End Integration
        '      CommonFunctions.General.WriteHTML("</td>")
        '      '************************************************************************************

        '      'Integrated in Whiz2 by MrugajaB on 15th Dec 2005
        '      'Added by SandeepA on 17 Nov,2005 for IssueID-684 : Task Completion Status
        '      CommonFunctions.General.WriteHTML("</Span>")
        '      'End of addition by SandeepA on 17 Nov,2005 for IssueID-684
        '      '************************************************************************************
        '  '******************************************************************************
        '      'End commenting by ShubhadaL on 2 Feb 2006
        '      '******************************************************************************
        'Intigrated by harshk for sp4 issueid 190
        'Purpose : Filter for Resource 
        Dim strQuery As String
        'Commented by ManishK on 22th Feb 06 for SP6 issueID 2374
        'CommonFunctions.General.WriteHTML("<tr class='clsTREven' width = '100%'>")
        'End of Commented by ManishK on 22th Feb 06 for SP6 issueID 2374
        strQuery = "EXEC usp_Sel_teammembers " & CType(m_intProjectID, String)
        CommonFunctions.General.WriteHTML("<td align='Left' width=7%>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LABEL_SELECT_RESOURCE"))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='Left'width=32%>")
        CommonFunctions.General.WriteHTML("&nbsp;")
        CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", strQuery, 210, CType(m_intEmployeeID, String), "", True)
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</TABLE>")
        'End of Addition
        'End 
        '--- Task Type filters
        'Integrated in Whiz2 by MrugajaB on 15th Dec 2005
        CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
        ''Added by Manishk on 22th feb 06 for SP6 IssueID 2374
        '        CommonFunctions.General.WriteHTML("<tr class='clsTREven' width = '100%'><td align='Left'> </tr>")
        CommonFunctions.General.WriteHTML("<tr class='clsTREven' width = '100%'> <td align='Left' colspan=4> </td> </tr>")
        ''End of Added by Manishk on 22th feb 06 for SP6 IssueID 2374
        CommonFunctions.General.WriteHTML("<tr class='clsTREven' width = '100%'><td align='Left'>")
        'Added By SandeepA on 17 Nov,2005 for IssueID-684 : Task Completion Status
        'Purpose: Plot the 'Show All Tasks' and 'Show Tasks For Period' option buttons
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optMainTaskFilter", "optAllTasks", , blnChecked, CStr("1"), , " language=Javascript OnClick=optTasks_OnClick(""ShowALL"") ", True))
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SHOW_ALL_TASKS"))
        CommonFunctions.General.WriteHTML("&nbsp;")
        If blnChecked = True Then
            blnChecked = False
        Else
            blnChecked = True
        End If
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optMainTaskFilter", "optTasksForTheWeek", , blnChecked, CStr("2"), , " language=JavaScript OnClick=optTasks_OnClick(""ShowWeekly"") ", True))
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SHOW_TASKS_FOR_PERIOD"))
        CommonFunctions.General.WriteHTML("</td>")
        '******************************************************************************
        'added by ShubhadaL on 2 Feb 2006 for proper alignment of Date controls
        '******************************************************************************
        'Date Filters
        CommonFunctions.General.WriteHTML("<td align='Left'>")

        'Integrated in Whiz2 by MrugajaB on 15th Dec 2005
        'Added by SandeepA on 17 Nov,2005 for IssueID-684 : Task Completion Status
        'Purpose: Add SPAN tag so as to hide the FromDate and ToDate controls
        '******************************************************************************
        'Commented by Shubhadal
        '******************************************************************************
        'If strTaskFilter = " NULL " Then

        '    CommonFunctions.General.WriteHTML("<Span id=""FromDate"" name=""FromDate"" style=""visibility:visible"">")
        'Else
        '    CommonFunctions.General.WriteHTML("<Span id=""FromDate"" name=""FromDate"" style=""visibility:visible"">")
        'End If
        ''End of addition by SandeepA on 17 Nov,2005 for IssueID-684
        ''End Integration
        CommonFunctions.General.WriteHTML("<Span id=""FromDate"" name=""FromDate"" style=""visibility:visible"">")
        '******************************************************************************
        'End commenting by ShubhadaL
        '******************************************************************************

        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LABEL_FROM_DATE"))
        'Commented & Added by ShubhadaL on 7 Feb 2006 to Hide * mark if ShowAll is clicked else show it.
        'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , , m_dtFromDate, , "frmPM_TaskUpdation", returnHTML:=True, IsMandatory:=True ))

        'Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4192
        '***** Modified by SandipL On 16 May 2006 for WhizEnggSP6 IssueID 3748
        'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , , CType(m_dtFromDate, Date).ToString, , "frmPM_TaskUpdation", returnHTML:=True, IsMandatory:=False))
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , , CType(m_dtFromDate, Date).ToString("dd-MMM-yyyy"), , "frmPM_TaskUpdation", returnHTML:=True, IsMandatory:=False))
        '***** End Modification by SandipL on 16 May 2006
        'End Integration

        CommonFunctions.General.WriteHTML("<IMG id=StarID name=idStarID display='none' src='../../Images/Star.gif' border=0>")
        'End addition by ShubhadaL on 7 Feb 2006

        'Integrated in Whiz2 by MrugajaB on 15th Dec 2005
        'Added by SandeepA on 17 Nov,2005 for IssueID-684 : Task Completion Status
        'Purpose: End of SPAN tag

        CommonFunctions.General.WriteHTML("</Span>")
        'End of addition by SandeepA on 17 Nov,2005 for IssueID-684
        'End Integration  

        CommonFunctions.General.WriteHTML("</td>")
        'CommonFunctions.General.WriteHTML("<td align='Left' 'Style = width=50%'>")
        CommonFunctions.General.WriteHTML("<td align='Left'>")

        'Integrated in Whiz2 by MrugajaB on 15th Dec 2005
        'Added by SandeepA on 17 Nov,2005 for IssueID-684 : Task Completion Status
        'Purpose: Add SPAN tag so as to hide the FromDate and ToDate controls
        '*********************************************************************
        'commented by ShubhadaL
        '*********************************************************************
        'If strTaskFilter = " NULL " Then
        '    CommonFunctions.General.WriteHTML("<Span id=""ToDate"" name=""ToDate"" style=""visibility:visible"">")
        'Else
        '    CommonFunctions.General.WriteHTML("<Span id=""ToDate"" name=""ToDate"" style=""visibility:visible"">")
        'End If
        'End of addition by SandeepA on 17 Nov,2005 for IssueID-684
        '**********************************************************************************
        'End of commenting by ShubhadaL
        '**********************************************************************************
        CommonFunctions.General.WriteHTML("<Span id=""ToDate"" name=""ToDate"" style=""visibility:visible"">")
        'End integration
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LABEL_TO_DATE"))
        'Commented & Added by ShubhadaL on 7 Feb 2006 to Hide * mark if ShowAll is clicked else show it.
        'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , m_dtToDate, , "frmPM_TaskUpdation", returnHTML:=True, ISmandatory:=True))

        'Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4192
        '***** Modified by SandipL On 16 May 2006 for WhizEnggSP6 IssueID 3748
        'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , CType(m_dtToDate, Date).ToString, , "frmPM_TaskUpdation", returnHTML:=True, ISmandatory:=False))
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , CType(m_dtToDate, Date).ToString("dd-MMM-yyyy"), , "frmPM_TaskUpdation", returnHTML:=True, ISmandatory:=False))
        '***** End Modification by SandipL on 16 May 2006
        'End Integration

        CommonFunctions.General.WriteHTML("<IMG id=StarIDTo name=idStarIDTo display='none' src='../../Images/Star.gif' border=0>")
        'End addition by ShubhadaL on 7 Feb 2006

        'Integrated in Whiz2 by MrugajaB on 15th Dec 2005
        'Added by SandeepA on 17 Nov,2005 for IssueID-684 : Task Completion Status
        'Purpose: End of SPAN Tag.
        CommonFunctions.General.WriteHTML("</Span>")
        'End of addition by SandeepA on 17 Nov,2005 for IssueID-684
        'End Integration
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td colspan=1></td>")
        '************************************************************************************

        'Integrated in Whiz2 by MrugajaB on 15th Dec 2005
        'Added by SandeepA on 17 Nov,2005 for IssueID-684 : Task Completion Status
        'commented by Shubhadal on 2 Feb 2006
        'CommonFunctions.General.WriteHTML("</Span>")
        'End of addition by SandeepA on 17 Nov,2005 for IssueID-684
        '************************************************************************************
        'End addition by ShubhadaL on 2 Feb 2006
        CommonFunctions.General.WriteHTML("</tr><tr class='clsTREven'><td colspan=3>")
        'End of Addition by SandeepA on 17 nov,2005 for IssueID-684
        'End Integration       
        ''Code Integrated by MrugajaB on 4th May,2005 for WhizibleSEM SP3 Task Progress feature
        '' Code added by SwapnilR on 20th April 2005
        '' Purpose : For project if the task progress is set then hiding assigned task option 
        'Dim strSQLPercent As String
        'Dim objDr As IDataReader
        'Dim ProgressEntry As String
        'Dim UsePercentProgress As Boolean
        'Dim flag As Integer

        'flag = 1

        'strSQLPercent = "SELECT * FROM tbl_PM_Project WHERE ProjectID = " + m_intProjectID.ToString
        'objDr = CommonFunction.Data.GetDataReader(strSQLPercent, True)
        'If objDr.Read Then
        '    ProgressEntry = CType(CommonFunction.Data.CheckIsDBNull(objDr("ProgressEntry"), ""), String)
        '    UsePercentProgress = CType(CommonFunction.Data.CheckIsDBNull(objDr("UsePercentProgress"), "false"), Boolean)
        'End If
        'strSQLPercent = Nothing
        'CommonFunction.Data.DisposeDataReader(objDr)
        '' End of code addition by SwapnilR on 20th April 2005
        ''End Integration

        If m_strTaskType = TASK_TYPE_ASSIGNED Then blnIsChecked = True Else blnIsChecked = False
        CommonFunctions.HTMLControls.DrawOptionButton("optTaskType", "optTaskType", , blnIsChecked, TASK_TYPE_ASSIGNED, , "")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("OPT_ASSIGNED_TASKS"))

        CommonFunctions.General.WriteHTML("&nbsp;")
        If m_strTaskType = TASK_TYPE_MPP Then blnIsChecked = True Else blnIsChecked = False
        CommonFunctions.HTMLControls.DrawOptionButton("optTaskType", "optTaskType", , blnIsChecked, TASK_TYPE_MPP, , "")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("OPT_MPP_TASKS"))

        CommonFunctions.General.WriteHTML("&nbsp;")
        If m_strTaskType = TASK_TYPE_ISSUE Then blnIsChecked = True Else blnIsChecked = False
        CommonFunctions.HTMLControls.DrawOptionButton("optTaskType", "optTaskType", , blnIsChecked, TASK_TYPE_ISSUE, , "")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("OPT_ISSUE_TASKS"))

        CommonFunctions.General.WriteHTML("&nbsp;")
        If m_strTaskType = TASK_TYPE_REVIEW Then blnIsChecked = True Else blnIsChecked = False
        CommonFunctions.HTMLControls.DrawOptionButton("optTaskType", "optTaskType", , blnIsChecked, TASK_TYPE_REVIEW, , "")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("OPT_REVIEW_TASKS"))

        'Intigrated by HarshK for sp4 issueid 219
        'Added by MrugajaB on 24th June 2005
        'Purpose:For displaying tasks created through help desk
        CommonFunctions.General.WriteHTML("&nbsp;")
        If m_strTaskType = TASK_TYPE_HELPDESK Then blnIsChecked = True Else blnIsChecked = False
        CommonFunctions.HTMLControls.DrawOptionButton("optTaskType", "optTaskType", , blnIsChecked, TASK_TYPE_HELPDESK, , "")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("OPT_HELP_TASKS"))
        'End Adddition
        'End Intigrated by HarshK for sp4 issueid 219

        'Added by MrugajaB on 5th April 2006 for WhizibleSEM 6.0 Issue ID.684
        'Purpose:For displaying all tasks irrispective of their tasktype
        CommonFunctions.General.WriteHTML("&nbsp;")
        If m_strTaskType = TASK_TYPE_ALL Then blnIsChecked = True Else blnIsChecked = False
        CommonFunctions.HTMLControls.DrawOptionButton("optTaskType", "optTaskType", , blnIsChecked, TASK_TYPE_ALL, , "")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("OPT_SHOW_ALL_TASKTYPES"))
        'End Addition

        CommonFunctions.General.WriteHTML("</td>")

        '--- Display the Show Link
        'Display the Show Link
        CommonFunctions.General.WriteHTML("<td align=center 'Style = Width = 50%'>")
        objDynamicLink = New WebPages.UI.cDynamicLink
        objDynamicLink.LinkName = MyBase.GetResourceString("LABEL_SHOW")
        objDynamicLink.Tooltip = MyBase.GetResourceString("LABEL_SHOW_TOOLTIP")
        objDynamicLink.FunctionName = "Show_OnClick()"
        objDynamicLink.ReturnHTML = True
        CommonFunctions.General.WriteHTML(" |<B>" + objDynamicLink.GetDynamicLink() + "</B>| ")
        objDynamicLink = Nothing
        CommonFunctions.General.WriteHTML("</td></tr></table>")


        'Added by ShubhadaL on 1 Feb,2006
        'Purpose: Added a DIV section for all filters
        CommonFunctions.General.WriteHTML("</DIV>")
        'End of Addition by ShubhadaL on 1 Feb2006


        CommonFunctions.General.WriteHTML("<BR>")

    End Sub

    Private Sub DisplayGrid()
        Dim strSQLQuery As String = ""
        Dim strWhereClause As String = ""

        'Integrated in Whiz2 by MrugajaB on 15th Dec 2005
        'Added by SandeepA on 17 Nov,2005 for IssueID-684 : task Complteion Status
        'Purpose: Check for the Task Filter and Build Grid SQL
        Dim strTaskFilter As String
        ' Retrieve the current Task filter value.
        'Modified by ManishK on 19th Feb 2006 For SP 6 issueID 2176
        '        strTaskFilter = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("optMainTaskFilter"), "1")
        strTaskFilter = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("optMainTaskFilter"), "2")
        'End of Modified by ManishK on 19th Feb 2006 For SP 6 issueID 2176
        If strTaskFilter = "2" Then
            strTaskFilter = " NULL "
        End If
        strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksForCompletion " & CType(m_intProjectID, String) & "," & CType(m_intEmployeeID, String) & " , '" & CType(m_dtFromDate, String) & "', '" & CType(m_dtToDate, String) & "','" & m_strTaskType & "'," & strTaskFilter
        'End of addition by SandeepA on 17 Nov,2005 for IssueID-684
        'End integration

        'Code Commented by SandeepA on 17 Nov,2005 for IssueID-684
        'Purpose of Comment: The Grid SQL is built above with Task Filters.
        ''intigrated by harshk for issueid 190
        'strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksForCompletion " & CType(m_intProjectID, String) & "," & CType(m_intEmployeeID, String) & " , '" & CType(m_dtFromDate, String) & "', '" & CType(m_dtToDate, String) & "','" & m_strTaskType & "'"
        ''End intigrated by harshk for issueid 190
        'End of Comment by SandeepA on 17 Nov,2005 for issueID-684



        'Modified by HarshK for sp4 issueid 642 on 24/10/2005
        Dim arrActualColumns() As String = {"TaskName", "EmployeeName", "StartDate", "EndDate", _
                                            "ActualStartDate", "PlannedWork", "ActualWork", "ActualPercentComplete", ""}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("HEADING_TASK_NAME"), MyBase.GetResourceString("HEADING_RESOURCE_NAME"), _
                                                 MyBase.GetResourceString("HEADING_START_DATE"), MyBase.GetResourceString("HEADING_END_DATE"), _
                                                 MyBase.GetResourceString("HEADING_ACTUAL_START_DATE"), _
                                                 MyBase.GetResourceString("HEADING_EFFORTS"), MyBase.GetResourceString("HEADING_ACTUAL_EFFORTS"), _
                                                 MyBase.GetResourceString("HEADING_ACTUAL_PERCENT_COMPLETE"), MyBase.GetResourceString("HEADING_IS_TASK_COMPLETE")}
        Dim arrstrTDStyle() As String = {"align='left' width=40%", "align='left' width=10%", "align='left' width=5%", _
                                         "align='left' width=5%", "align='left' width=5%", "align='right' width=5%", "align='right' width=5%", _
                                         "align='right' width=5%", "align='center' width=5%"}
        'Modified by HarshK for sp4 issueid 642 on 24/10/2005

        ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''End of Addition by Dhanashri S on 7 Oct 2015

        'Set the Advanced Grid Properties
        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .EmptyValueReplacement = "&nbsp;"
            .SQL = strSQLQuery
            .DIVID = "divList"
            .DIVHeight = 300
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = 8
            .TDStyleArray = arrstrTDStyle
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            ''End of Addition by Dhanashri S on 7 Oct 2015
            .DrawGrid()
        End With

    End Sub

#End Region

#Region "Constructor"
    Public Sub New()
        'This constructor initialize resources and also apply security settings.
        ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016
        MyBase.InitializeResources("AppResources.PM_TaskUpdation", "AppResources")
    End Sub
#End Region

#Region "Destructor"
    Protected Overrides Sub Finalize()
        'This will call base class destructor.
        MyBase.Finalize()
    End Sub
#End Region

#Region "Grid Events"

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint

        Dim strName As String
        Dim strAttributes As String
        Dim strTxtName As String

        If Args.ColumnName = MyBase.GetResourceString("HEADING_IS_TASK_COMPLETE") Then
            Cancel = True
            If m_strTaskType = TASK_TYPE_ASSIGNED Or m_strTaskType = TASK_TYPE_REVIEW Then
                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsTaskComplete"), "0"), Boolean) = True Then
                    strAttributes = " disabled checked"
                Else
                    strAttributes = ""
                End If

                'Modified By VidyaJ - IssueID - 190 - SP4
                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ParentTask_UID"), "0"), Integer) = 0 And m_intEmployeeID <> 0 Then
                    strAttributes = " disabled "
                End If
                'End Of Modifications

                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ParentTask_UID"), "0"), Integer) = 0 Then
                    m_intCount = 0
                    strName = "chk" + CType(m_intParentTask_UID, String) + "_" + CType(m_intCount, String)
                    strTxtName = "txt" + CType(m_intParentTask_UID, String) + "_" + CType(m_intCount, String)
                    Args.StringToBeInserted = "<td align='center' width=10%><input type='checkbox' id='" + strName + "' name='" + strName + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String) + "' " + strAttributes + " onclick='javascript:CheckChildTasks(" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String) + "," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("HasChildTasks"), "0"), String) + ")'><input type=hidden name='" + strTxtName + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsTaskComplete"), "0"), String) + "'></td>"
                Else
                    m_intCount = m_intCount + 1
                    strName = "chk" + CType(m_intParentTask_UID, String) + "_" + CType(m_intCount, String)
                    strTxtName = "txt" + CType(m_intParentTask_UID, String) + "_" + CType(m_intCount, String)
                    Args.StringToBeInserted = "<td align='center' width=10%><input type='checkbox' id='" + strName + "' name='" + strName + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String) + "' " + strAttributes + " onclick='javascript:CheckTask(" + CType(m_intParentTask_UID, String) + "," + CType(m_intCount, String) + ")'><input type=hidden name='" + strTxtName + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsTaskComplete"), "0"), String) + "'></td>"
                End If
            Else
                m_intCount = m_intCount + 1
                strName = "chk0_" + CType(m_intCount, String)
                Args.StringToBeInserted = "<td align='center' width=10%><input type='checkbox' id='" + strName + "' name='" + strName + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String) + "' onclick='javascript:CheckTask(" + CType(m_intParentTask_UID, String) + "," + CType(m_intCount, String) + ")'><input type=hidden name='" + strTxtName + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsTaskComplete"), "0"), String) + "'></td>"
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
                'added by harshk for sp4 issueid 642
            Case MyBase.GetResourceString("HEADING_ACTUAL_PERCENT_COMPLETE")
                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("HasChildTasks"), "0"), String) <> "0" Then
                    Cancel = True
                    Args.StringToBeInserted = "<TD align=right></TD>"
                End If
                'End added by harshk for sp4 issueid 642
        End Select

    End Sub

    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint

        If m_strTaskType = TASK_TYPE_ASSIGNED Or m_strTaskType = TASK_TYPE_REVIEW Then
            If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("HasChildTasks"), "0"), String) <> "0" Then
                m_intParentTask_UID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), Integer)
                Args.clsTR = "clsTRSectionHeader"
            End If
        End If

    End Sub

#End Region

End Class
