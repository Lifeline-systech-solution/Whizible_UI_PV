#Region " Imports "
Imports System.Text
#End Region
Public Class Schedule_Timesheet
    Inherits WebPages.Template.WhizTemplate
#Region " Member variables "

    Protected m_SBHTML As StringBuilder
    Protected WithEvents m_objMenu As WebPage.Templates.StaticMenu
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccessRights As WebPages.Security.cAccessRights

    Protected m_blnRestrict_MPPTasks As Boolean
    Protected m_blnRestrict_AssignedTasks As Boolean

    Private dsDayHeader As DataSet

    Protected strSQL As String = ""
    Protected m_strSQL As String = ""
    Protected m_strMode As String = ""
    Protected m_strAction As String = ""
    Protected m_strUserName As String = ""
    Protected m_lngProjectID As Long = 0

    Private m_strSessionPostID As String = ""
    Private m_strSessionProjectID As String = ""
    Private m_strDefaultProjectID As String = ""
    Private m_strProjectFilters As String = ""
    Private m_strWhere As String = ""
    Private m_strReqStartDate As String = ""

    Public m_strSessionUserID As String = ""

    Protected drTask As IDataReader

    Private m_strSelectedTaskType As String = ""
    Private m_strPeriod As String = ""

    Protected m_strProjectID As String = ""
    Protected m_dtStartDateOfWeek As Date
    Protected m_dtEndDateOfWeek As Date

    Protected dsTask As DataSet
    Protected dsTemp As DataSet

    Protected m_intPageNumber As Integer = 0
    Protected m_intRowCount As Integer = 0
    Protected dblRatio As Double = 0.0

    Protected m_dblTotalWorkHours As Double = 24
    Protected m_strSelected As String = ""

#End Region
#Region "CONSTANTS"
    Private Const GENERAL_TASKS As String = "D"
    Private Const ASSIGNED_TASKS As String = "O"
    Private Const DEFECTS_ASSIGNED As String = "B"
    Private Const ALL_TASK_TYPES As String = "A"

    Private Const THIS_WEEK As String = "1"
    Private Const NEXT_WEEK As String = "3"
    Private Const m_strTaskFilter As String = "6"

    Protected Const PAGE_SIZE As Integer = 10
#End Region
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

        'Put user code to initialize the page here
    End Sub
    Protected Sub PageInit()
        '====================================================================
        ' Procedure Name    :      PageInit
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To init page details
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Sept 08, 2008
        ' Revisions         :
        '=====================================================================
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting


        GetGlobalObject()

        GetTagAccessRights()

        InitializeVariables()


        PerformAction()


        GetDatabaseValues()

        DrawHiddenFields()

        Response.Write("<div Id=divPage Style='OVERFLOW:auto; width:100%;'>")
        ''''Master 
        DrawMenu()

        GetPageLegend()

        DrawFilters()




        ' DrawPageCaption()

        DrawCurrentFilters()

        DrawSelect()


        DrawPage()

        Response.Write("</div>")
        ''DrawMenu()

        DisposeNotUsedObjects()
    End Sub
    Private Sub DrawCurrentFilters()
        '====================================================================
        ' Procedure Name    :      DrawCurrentFilters
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To get current filters
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Jan 21, 2009
        ' Revisions         :
        '=====================================================================
        m_SBHTML = New StringBuilder
        m_SBHTML.Append("<table id='tblFilter'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>")
        m_SBHTML.Append("<tr class=clsTRBlank>")

        m_SBHTML.Append("<td class='clsTDBlankNew'  align='left' valign='bottom' >")
        m_SBHTML.Append("<b>Applied Filters :</b>")
        m_SBHTML.Append("&nbsp;<label id='lblFilter' ></label>")
        m_SBHTML.Append("&nbsp;<a href='javascript:applyFilter(1)' ><Img Border=0 style='text-decoration:none;'  src='../../Images/cssImages/Link images/Clearfilter.gif' alt='Clear Filter' /></a>")
        m_SBHTML.Append("</td>")

        m_SBHTML.Append("</tr>")
        m_SBHTML.Append("</table>")
        m_SBHTML.Append("<br>")

        Response.Write(m_SBHTML.ToString)
        m_SBHTML = Nothing
    End Sub
    Private Sub DrawSelect()
        '====================================================================
        ' Procedure Name    :      DrawSelect
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To get Select all,none record table
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Jan 21, 2009
        ' Revisions         :
        '=====================================================================
        m_SBHTML = New StringBuilder
        m_SBHTML.Append("<table id='tblSelect'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>")
        m_SBHTML.Append("<tr class=clsTRBlank>")

        m_SBHTML.Append("<td class='clsTDBlank'  align='left' valign='bottom' >")
        m_SBHTML.Append("Select:&nbsp;")
        m_SBHTML.Append("<a  href='javascript:SelectAll_OnClick(""frmScheduleTS"",""chkSelect"")'><font color='blue'>All</font></a>,")
        m_SBHTML.Append("<a  href='javascript:ClearAll_OnClick(""frmScheduleTS"",""chkSelect"")'><font color='blue'>None</font></a>")
        m_SBHTML.Append("</td>")


        m_SBHTML.Append("<td class='clsTDBlank'  align='center' valign='bottom' >")
        m_SBHTML.Append("<img border=0 valign='bottom' src='../../Images/InitiativeRed.gif' title='Not Started Task' />&nbsp;Not Started Task &nbsp;")
        m_SBHTML.Append("<img border=0 valign='bottom' src='../../Images/InitiativeYellow.gif' title='Inprogress Task' />&nbsp;Inprogress Task &nbsp;")
        m_SBHTML.Append("<img border=0 valign='bottom' src='../../Images/InitiativeGreen.gif' title='Completed Task' />&nbsp;Completed Task &nbsp;")
        m_SBHTML.Append("</td>")

        m_SBHTML.Append("<td class='clsTDBlank'  align='center' valign='bottom' >")
        strSQL = "usp_Sel_AllTaskOrScheduleTask "
        m_SBHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboSelected", strSQL, 125, m_strSelected, "onchange=Selection_OnClick(this)", , True))
        m_SBHTML.Append("</td>")

        m_SBHTML.Append(GetPagingString())

        m_SBHTML.Append("</tr>")
        m_SBHTML.Append("</table>")
        m_SBHTML.Append("<br>")

        Response.Write(m_SBHTML.ToString)
        m_SBHTML = Nothing
    End Sub
    Private Sub DrawPageCaption()
        '====================================================================
        ' Procedure Name    :      DrawPageCaption
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw Page caption.
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Sept 08, 2008
        ' Revisions         :
        '=====================================================================
        m_SBHTML = New StringBuilder


        m_SBHTML.Append(WebPages.Template.PageCaption.GetPageCaptions(, "Schedule Timesheet", , , True))
        m_SBHTML.Append("<br>")
        Response.Write(m_SBHTML.ToString)

        m_SBHTML = Nothing

    End Sub
    Protected Sub DrawPage()
        '====================================================================
        ' Procedure Name    :      DrawPage
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw detail page with calender and calender details view.
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Jan 21, 2009
        ' Revisions         :
        '=====================================================================
        m_SBHTML = New StringBuilder
        Dim strTitle As New System.Text.StringBuilder
        Dim strTaskStartDate As String = ""
        Dim strTaskEndDate As String = ""
        Dim strTaskIDList As String = ""
        Dim strProjectName As String = ""
        Dim strTaskID As String = ""
        Dim blnIsTaskComplete As Boolean
        Dim strPostEndDate As String = ""

        m_SBHTML.Append("<table cellpadding=0 cellspacing=1 class='clsGridTable' width=99.9% >")
        m_SBHTML.Append("<tr class='clsTRBlank' valign='top'>")

        m_SBHTML.Append("<td align='center' valign='bottom' class='clsTDBlankNew'>")
        m_SBHTML.Append("Select")
        m_SBHTML.Append("</td>")


        m_SBHTML.Append("<td align='left' valign='bottom' class='clsTDBlankNew'>")
        m_SBHTML.Append("Task Name")
        m_SBHTML.Append("</td>")

        m_SBHTML.Append("<td align='left' valign='bottom' class='clsTDBlankNew'>")
        m_SBHTML.Append("Task Status")
        m_SBHTML.Append("</td>")

        m_SBHTML.Append("<td align='right' valign='bottom' class='clsTDBlankNew'>")
        m_SBHTML.Append("Allocated Work (Hrs)")
        m_SBHTML.Append("</td>")

        m_SBHTML.Append("<td align='right' valign='bottom' class='clsTDBlankNew'>")
        m_SBHTML.Append("Post Effort On Working Day")
        m_SBHTML.Append("</td>")

        m_SBHTML.Append("<td align='left' valign='bottom' class='clsTDBlankNew'>")
        m_SBHTML.Append("Post Till Date")
        m_SBHTML.Append("</td>")

        m_SBHTML.Append("<td align='left' valign='bottom' class='clsTDBlankNew'>")
        m_SBHTML.Append("Close Task After End Date")
        m_SBHTML.Append("</td>")

        m_SBHTML.Append("<td align='left' valign='bottom' class='clsTDBlankNew'>")
        m_SBHTML.Append("Actual Start Date")
        m_SBHTML.Append("</td>")

        m_SBHTML.Append("<td align='left' valign='bottom' class='clsTDBlankNew'>")
        m_SBHTML.Append("Actual End Date")
        m_SBHTML.Append("</td>")

        m_SBHTML.Append("<td align='right' valign='bottom' class='clsTDBlankNew'>")
        m_SBHTML.Append("Actual Work(Hrs)")
        m_SBHTML.Append("</td>")

        m_SBHTML.Append("<td align='right' valign='bottom' class='clsTDBlankNew'>")
        m_SBHTML.Append("Remaining Work(Hrs)")
        m_SBHTML.Append("</td>")
        
        m_SBHTML.Append("</tr>")

        For Each drRow As DataRow In dsTask.Tables(0).Rows
            strTaskID = CType(CommonFunction.Data.CheckIsDBNull(drRow("TaskID")), String)
            blnIsTaskComplete = CType(CommonFunction.Data.CheckIsDBNull(drRow("IsTaskComplete"), "0"), Boolean)

            strTitle.Append("[Project : " + CType(CommonFunction.Data.CheckIsDBNull(drRow("ProjectName")), String).Replace("\'", "/'/g") + "]")
            strTitle.Append(vbCrLf & "[Task : " + CommonFunction.Data.CheckIsDBNull(drRow("TaskName")).ToString.Replace("\'", "/'/g") + "]")

            strTaskStartDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drRow("StartDate")), Date))
            strTaskEndDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drRow("EndDate")), Date))
            strPostEndDate = CType(CommonFunction.Data.CheckIsDBNull(drRow("PostEndDate")), String)

            If strPostEndDate = "" Then
                strPostEndDate = strTaskEndDate
            Else
                strPostEndDate = CommonFunction.Dates.GetDate(CType(strPostEndDate, Date))
            End If

            If strTaskStartDate <> "" Then strTitle.Append(vbCrLf & "Start Date" & vbTab & vbTab & " = " & CDate(strTaskStartDate).ToString("dd-MMM-yyyy"))
            If strTaskEndDate <> "" Then strTitle.Append(vbCrLf & "End Date" & vbTab & vbTab & " = " & CDate(strTaskEndDate).ToString("dd-MMM-yyyy"))

            If strProjectName <> CType(CommonFunction.Data.CheckIsDBNull(drRow("ProjectName")), String) Then
                m_SBHTML.Append("<tr class='clsTRGroupHeader'>")
                m_SBHTML.Append("<td  align='left' colspan='13' class='clsTDBlankNew'>")
                m_SBHTML.Append(CType(CommonFunction.Data.CheckIsDBNull(drRow("ProjectName")), String))
                m_SBHTML.Append("</td>")
                m_SBHTML.Append("</tr>")
            End If

            m_SBHTML.Append("<tr class='clsTRBlank'>")
            ''Select
            m_SBHTML.Append("<td class='clsTDBlank' align='center'>")
            m_SBHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , CType(CommonFunction.Data.CheckIsDBNull(drRow("ScheduleTaskID"), "0"), Boolean), strTaskID, blnIsTaskComplete, "onclick=SelectOnClick(this,0) ", True))
            m_SBHTML.Append("</td>")

            ''Task Name
            m_SBHTML.Append("<td title ='" & CommonFunction.General.FormatString(Server.HtmlEncode(strTitle.ToString)) & "' class='clsTDBlank' align='left'>")
            m_SBHTML.Append(CommonFunction.Data.CheckIsDBNull(drRow("TaskName")).ToString)
            m_SBHTML.Append("</td>")
            ''Status
            m_SBHTML.Append("<td class='clsTDBlank' align='center'>")
            If CType(CommonFunction.Data.CheckIsDBNull(drRow("ActualStartDate")), String) <> "" And Not blnIsTaskComplete Then
                m_SBHTML.Append("<img border=0 src='../../Images/InitiativeYellow.gif' title='Inprogress Task' />")
            ElseIf CType(CommonFunction.Data.CheckIsDBNull(drRow("ActualStartDate")), String) = "" Then
                m_SBHTML.Append("<img border=0 src='../../Images/InitiativeRed.gif' title='Not Started Task' />")
            ElseIf CType(CommonFunction.Data.CheckIsDBNull(drRow("IsTaskComplete"), "0"), Boolean) Then
                m_SBHTML.Append("<img border=0 src='../../Images/InitiativeGreen.gif' title='Completed Task' />")
            End If
            m_SBHTML.Append("</td>")

            ''Alocated Work (Hrs)
            m_SBHTML.Append("<td id='tdAW_" + strTaskID + "' class='clsTDBlank' align='right'>")
            m_SBHTML.Append(FormatNumber(CommonFunction.Data.CheckIsDBNull(drRow("Work")), 2))
            m_SBHTML.Append("</td>")

            ''Post effort on working day
            m_SBHTML.Append("<td class='clsTDBlank' align='center'>")
            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            m_SBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPostHrs" + strTaskID, "txtPostHrs" + strTaskID, , 50, , FormatNumber(CommonFunction.Data.CheckIsDBNull(drRow("PostWorkHrs")), 2), "right", , IIf(CType(CommonFunction.Data.CheckIsDBNull(drRow("ScheduleTaskID"), "0"), Boolean), False, True), , , , , True, True, EnableHTMLEncode:=True))
            'ended by Yogesh J for HTML encoding Date:05/10/15
            m_SBHTML.Append("</td>")

            ''Post effort on working day
            m_SBHTML.Append("<td class='clsTDBlank' align='center'>")
            m_SBHTML.Append(CommonFunction.HTMLControls.DrawDateControl("dtEndDate" + strTaskID, "dtEndDate" + strTaskID, , , strPostEndDate, , "frmScheduleTS", , , , , , , True, True))
            m_SBHTML.Append("</td>")

            'm_SBHTML.Append("<td class='clsTDBlank' align='center'>")
            'm_SBHTML.Append(CommonFunction.HTMLControls.DrawDateControl("dtPostDate", "dtPostDate", , , , , "frmScheduleTS", , , , , , , True))
            'm_SBHTML.Append("</td>")

            ''Close Task After End Date
            m_SBHTML.Append("<td class='clsTDBlank' align='center'>")
            m_SBHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkIsTaskComplete" + strTaskID, "chkIsTaskComplete" + strTaskID, , CType(CommonFunction.Data.CheckIsDBNull(drRow("STIsTaskComplete"), "0"), Boolean), strTaskID, IIf(CType(CommonFunction.Data.CheckIsDBNull(drRow("ScheduleTaskID"), "0"), Boolean), False, True), , True))
            m_SBHTML.Append("</td>")

            ''Actual Start Date
            m_SBHTML.Append("<td class='clsTDBlank' align='center'>")
            If CType(CommonFunction.Data.CheckIsDBNull(drRow("ActualStartDate")), String) <> "" Then
                m_SBHTML.Append(CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drRow("ActualStartDate")), Date)))
            Else
                m_SBHTML.Append("&nbsp;")
            End If
            m_SBHTML.Append("</td>")

            ''Actual End Date
            m_SBHTML.Append("<td class='clsTDBlank' align='center'>")
            If CType(CommonFunction.Data.CheckIsDBNull(drRow("ActualEndDate")), String) <> "" Then
                m_SBHTML.Append(CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drRow("ActualEndDate")), Date)))
            Else
                m_SBHTML.Append("&nbsp;")
            End If
            m_SBHTML.Append("</td>")

            ''Actual Work
            m_SBHTML.Append("<td class='clsTDBlank' align='right'>")
            m_SBHTML.Append(FormatNumber(CommonFunction.Data.CheckIsDBNull(drRow("ActualWork")), 2))
            m_SBHTML.Append("</td>")

            ''Remaining Work
            m_SBHTML.Append("<td id='tdBE' class='clsTDBlank' align='right'>")
            m_SBHTML.Append(FormatNumber(CommonFunction.Data.CheckIsDBNull(drRow("BalanceEfforts")), 2))
            m_SBHTML.Append("</td>")



            m_SBHTML.Append("</tr>")

            strProjectName = CType(CommonFunction.Data.CheckIsDBNull(drRow("ProjectName")), String)
            strTitle.Remove(0, strTitle.Length)

            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            m_SBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtHidTSD" + strTaskID, "txtHidTSD" + strTaskID, , , , CType(CommonFunction.Data.CheckIsDBNull(drRow("StartDate")), String), , , , , , True, , True, EnableHTMLEncode:=True))
            m_SBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtHidTED" + strTaskID, "txtHidTED" + strTaskID, , , , CType(CommonFunction.Data.CheckIsDBNull(drRow("EndDate")), String), , , , , , True, , True, EnableHTMLEncode:=True))
            m_SBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtHidWT" + strTaskID, "txtHidWT" + strTaskID, , , , CType(CommonFunction.Data.CheckIsDBNull(drRow("WhichTask")), String), , , , , , True, , True, EnableHTMLEncode:=True))
            'ended by Yogesh J for HTML encoding Date:05/10/15
            If Not blnIsTaskComplete Then
                strTaskIDList += strTaskID + ","
            End If
        Next

        If strTaskIDList <> "" Then
            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            m_SBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtHidTaskIDs", "txtHidTaskIDs", , , , strTaskIDList.Substring(0, strTaskIDList.Length - 1), , , , , , True, , True, EnableHTMLEncode:=True))
            'ended by Yogesh J for HTML encoding Date:05/10/15
        End If

        If dsTask.Tables(0).Rows.Count = 0 Then
            m_SBHTML.Append("<tr class='clsTRBlank'>")
            m_SBHTML.Append("<td class='clsTDBlank' align='center' colspan='13'>")
            m_SBHTML.Append("There are no item to show in this view.")
            m_SBHTML.Append("</td>")
            m_SBHTML.Append("</tr>")
        End If
        m_SBHTML.Append("</table>")

        Response.Write(m_SBHTML.ToString)

        m_SBHTML = Nothing
        strTitle = Nothing

    End Sub


    Private Sub GetPageLegend()

        m_SBHTML = New StringBuilder

        m_SBHTML.Append("<table id='tblPL00' CellSpacing=0 width='99.9%' class=clsTable>")
        m_SBHTML.Append("<tr class=clsTRBlank>")
        m_SBHTML.Append("<td align='left' valign='top' class='clsTDBlank' >")
        m_SBHTML.Append("<font color='blue'><b><i>Note</i></b></font> : Schedule timesheet is not applicable for non-working day (<font color='red'>Holiday, leave or Weekend</font>). ")
        m_SBHTML.Append("</td>")
        m_SBHTML.Append("<td align='Right' valign='top' >")
        m_SBHTML.Append("<B>(<img src='../../images/star.gif'> Mandatory)</B>")
        m_SBHTML.Append("</td>")
        m_SBHTML.Append("</tr>")
        m_SBHTML.Append("</table>")
        m_SBHTML.Append("<hr style='color:lightblue;height:1px;'/>")

        Response.Write(m_SBHTML.ToString)

        m_SBHTML = Nothing
    End Sub


    Protected Sub InitializeVariables()
        '====================================================================
        ' Procedure Name    :      InitializeVariables
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To init page varaibles
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Sept 08, 2008
        ' Revisions         :
        '=====================================================================

        Dim intRoleLevel As Integer
        Dim strFilter As String

        m_blnRestrict_MPPTasks = CommonFunctions.Application.RestrictDurationChange_M
        m_blnRestrict_AssignedTasks = CommonFunctions.Application.RestrictDurationChange_O

        m_strAction = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("Action"), ""), String)

        m_strSessionUserID = CType(Session("intUserID"), String)
        m_strSessionPostID = CType(Session("intPostID"), String)

        m_strUserName = CommonFunction.General.CheckIsNothing(Session("strUserName"))
        '-----Project Filter---------

        intRoleLevel = CType(CommonFunctions.General.CheckIsNothing(Session("intRoleLevel"), "0"), Integer)
        If intRoleLevel = 2 Then
            m_strProjectFilters = ""
            strFilter = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
            If strFilter <> "" Then
                m_strProjectFilters += strFilter
            End If
            Dim strRemove As String = "ProjectID IN"
            m_strProjectFilters = m_strProjectFilters.Remove(0, strRemove.Length)
            m_strProjectFilters = m_strProjectFilters.Replace("'", "")
            m_strProjectFilters = m_strProjectFilters.Trim
        End If

        m_strSessionProjectID = CStr(CommonFunctions.General.CheckIsNothing(Session("intProjectID"), "0"))


        m_strSelectedTaskType = CommonFunction.General.CheckIsNothing(Request.Form("cboTaskTypeFilter"), CStr(ASSIGNED_TASKS))
        m_strPeriod = CommonFunction.General.CheckIsNothing(Request.Form("cboPeriod"), CStr(THIS_WEEK))
        m_strProjectID = CommonFunction.General.CheckIsNothing(Request.Form("cboProject"), "")

        If m_strProjectID <> "" And m_strProjectID <> "0" Then
            m_strProjectFilters = m_strProjectID
        End If

        If Not Request.QueryString("PageNumber") Is Nothing Then
            m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("txtPageNumber")) <> "" Then
            m_intPageNumber = CType(Request.Form("txtPageNumber"), Integer)
        Else
            m_intPageNumber = 1
        End If

        m_strSelected = CommonFunction.General.CheckIsNothing(Request.Form("cboSelected"))

    End Sub
    Protected Sub DrawFilters()
        '=====================================================================
        ' Procedure Name        : DrawFilters()	
        ' Purpose               : Function To draw filter
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : PrashantSJ
        ' Created               : Jan 25, 2009
        ' Revisions             :
        '=====================================================================
        m_SBHTML = New StringBuilder

        m_SBHTML.Append("<div id='divFilter' class='ContextMenu' style='display:none;' >")
        m_SBHTML.Append("<table   class='clsTable'>")
        m_SBHTML.Append("<tr class='clsTRPageFilters'>")
        m_SBHTML.Append("<td align=right noWrap>")
        m_SBHTML.Append("Project Name")
        m_SBHTML.Append("</td>")
        m_SBHTML.Append("<td align=left title='Search Project'>")


        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        m_SBHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtProject", "txtProject", , 300, , , , , , , , , "onkeyup=Project_OnKeyUp(this,event)", True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:05/10/15
        m_SBHTML.Append("</td>")
        m_SBHTML.Append("<tr class='clsTRPageFilters'>")
        m_SBHTML.Append("<td align=right noWrap>")
        m_SBHTML.Append("</td>")
        m_SBHTML.Append("<td align=left>")
        m_SBHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Sel_AccessibleProjects_ForEmployee " & m_strSessionUserID & ",1,1", 300, m_strProjectID, , True, True))
        m_SBHTML.Append("</td>")
        m_SBHTML.Append("</tr>")

        m_SBHTML.Append("<tr class='clsTRPageFilters'>")
        m_SBHTML.Append("<td align=right noWrap>")
        m_SBHTML.Append("Task Type")
        m_SBHTML.Append("</td>")
        m_SBHTML.Append("<td align=left>")
        m_SBHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboTaskTypeFilter", "usp_Get_TaskFilter_ScheduleTS 'TT'", 200, m_strSelectedTaskType, , , True))
        m_SBHTML.Append("</td>")
        m_SBHTML.Append("</tr>")

        m_SBHTML.Append("<tr class='clsTRPageFilters'>")
        m_SBHTML.Append("<td align=right noWrap>")
        m_SBHTML.Append("Period")
        m_SBHTML.Append("</td>")
        m_SBHTML.Append("<td align=left>")
        m_SBHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboPeriod", "usp_Get_TaskFilter_ScheduleTS ", 200, m_strPeriod, , , True))
        m_SBHTML.Append("</td>")
        m_SBHTML.Append("</tr>")

        m_SBHTML.Append("<tr class='clsTRPageFilters'>")
        m_SBHTML.Append("<td>&nbsp;")
        m_SBHTML.Append("</td>")
        m_SBHTML.Append("<td colspan='2'  style='text-align:center;' >")
        m_SBHTML.Append("<a style='text-align:center' class='clsHrefButton' style='border-style:outset;border-color:white;border-width:thin;' href='javascript:applyFilter(0)' >Apply</a>")
        m_SBHTML.Append("&nbsp;&nbsp;<a style='text-align:center' class='clsHrefButton' style='border-style:outset;border-color:white;border-width:thin;' href='javascript:Filter_OnClick(1)' >Cancel</a>")
        m_SBHTML.Append("&nbsp;&nbsp;<a style='text-align:center' class='clsHrefButton' style='border-style:outset;border-color:white;border-width:thin;' href='javascript:applyFilter(1)' >Clear</a>")
        m_SBHTML.Append("</td>")

        m_SBHTML.Append("</tr>")
        m_SBHTML.Append("</table>")
        m_SBHTML.Append("</div>")

        Response.Write(m_SBHTML.ToString)
        m_SBHTML = Nothing

    End Sub
    Private Sub GetDatabaseValues()
        '====================================================================
        ' Procedure Name    :      GetDatabaseValues
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To get database values (e.g. after SAVE)
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Jan 21, 2009
        ' Revisions         :
        '=====================================================================

        m_strSQL = "usp_Sel_ScheduleTimesheet_StartEndDates " & m_strPeriod
        drTask = CommonFunction.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

        If drTask.Read Then
            m_dtStartDateOfWeek = CType(CommonFunction.Data.CheckIsDBNull(drTask("StartDate")), Date)
            m_dtEndDateOfWeek = CType(CommonFunction.Data.CheckIsDBNull(drTask("EndDate")), Date)
        End If

        CommonFunction.Data.DisposeDataReader(drTask)

        strSQL = "usp_Sel_tbl_PM_ScheduleTasks_WeeklyView " & m_strSessionUserID & ",'" & CommonFunction.Dates.GetDate(m_dtStartDateOfWeek) & "','" & CommonFunction.Dates.GetDate(m_dtEndDateOfWeek) & "'"
        If m_strSelectedTaskType = ALL_TASK_TYPES Or m_strSelectedTaskType = "" Then
            strSQL = strSQL + ",NULL"
        Else
            strSQL = strSQL + ",'" & m_strSelectedTaskType & "'"
        End If
        strSQL = strSQL + "," & m_strTaskFilter & ",'" & m_strProjectFilters & "'"

        If m_strSelected = "1" Then
            strSQL = strSQL + ",1"
        End If

        ''  dsTask = CommonFunction.Data.GetDataSet(strSQL, "TASK", , , MyBase.UseSQL)

        dsTemp = CommonFunction.Data.GetDataSet(strSQL, "TEMP", , , MyBase.UseSQL)


        m_intRowCount = dsTemp.Tables(0).Rows.Count
       

        ''  If m_intRowCount < PAGE_SIZE Then : m_intPageNumber = 0 : End If

        Dim intStartRecord As Integer = 0

        intStartRecord = ((m_intPageNumber - 1) * PAGE_SIZE)


        If m_intPageNumber = -1 Then
            dsTask = CommonFunction.Data.GetDataSet(strSQL, "TASK", , , MyBase.UseSQL)
        Else
            dsTask = CommonFunction.Data.GetDataSet(strSQL, "TASK", intStartRecord, PAGE_SIZE, MyBase.UseSQL)
        End If



    End Sub
    Protected Sub DrawHiddenFields()
        '====================================================================
        ' Procedure Name    :      DrawHiddenFields
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw Hidden data fields.
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Sept 08, 2008
        ' Revisions         :
        '=====================================================================


        'Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtItems", "txtItems", , , , , IsHidden:=True, returnHTML:=True))
        'Response.Write(CommonFunctions.HTMLControls.DrawDateControl("dtProjectStartDate", "dtProjectStartDate", , , m_strProjectStartDate, , "frmRoleRate", , , , , , , True, , , , True))
        'Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cmbSiteCurrency", "usp_sel_ProjectSiteCurrency" + " " + m_lngProjectID.ToString, , , , True, True, , , , True))
    End Sub
    Protected Sub DrawMenu()
        '====================================================================
        ' Procedure Name    :      DrawMenu
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw menu  details.
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Sept 08, 2008
        ' Revisions         :
        '=====================================================================
        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips
        m_SBHTML = New StringBuilder


        ArrMenuCaptionsList.Add("<Img Border=0 id=imgFilter src='../../Images/cssImages/Link images/Filter.gif'>")
        ArrMenuToolTipsList.Add("Filter")
        ArrClientSideFunctionsList.Add("Filter_OnClick(1,event)")

        If m_objAccessRights.Edit Or m_objAccessRights.Add Then
            ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/Save.gif'>&nbsp;Save")
            ArrMenuToolTipsList.Add("Schedule Timesheet")
            ArrClientSideFunctionsList.Add("Save_OnClick()")
        End If


        'ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/Delete.gif'>&nbsp;Delete")
        'ArrMenuToolTipsList.Add("Delete")
        'ArrClientSideFunctionsList.Add("Delete_OnClick()")

        ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>&nbsp;")
        ArrMenuToolTipsList.Add("Help")
        ArrClientSideFunctionsList.Add("Help_OnClick('3976')")

        Dim ArrMenuCaptions(ArrMenuCaptionsList.Count - 1) As String
        ArrMenuCaptionsList.ToArray.CopyTo(ArrMenuCaptions, 0)
        ArrMenuCaptionsList = Nothing

        'Convert arraylist to array - Client side functions
        Dim ArrClientSideFunctions(ArrClientSideFunctionsList.Count - 1) As String
        ArrClientSideFunctionsList.ToArray.CopyTo(ArrClientSideFunctions, 0)
        ArrClientSideFunctionsList = Nothing

        'Convert arraylist to array - Menu tooltips
        Dim ArrMenuToolTips(ArrMenuToolTipsList.Count - 1) As String
        ArrMenuToolTipsList.ToArray.CopyTo(ArrMenuToolTips, 0)
        ArrMenuToolTipsList = Nothing

        m_objMenu = New WebPage.Templates.StaticMenu
        m_SBHTML.Append(m_objMenu.DrawMenuWithEvents(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True))

        Response.Write(m_SBHTML.ToString)
        m_SBHTML = Nothing
    End Sub
    '=====================================================================
    ' Procedure Name        : GetGlobalObject()	
    ' Purpose               : Function To Fill Global Object
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : July 29, 2004
    ' Revisions             :
    '=====================================================================

    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject
    End Sub
    '=====================================================================
    ' Procedure Name        : GetTagAccessRights()	
    ' Purpose               : Function To Get access rights for selected TAG
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : PrashantSJ
    ' Created               : July 3, 2007
    ' Revisions             :
    '=====================================================================
    Private Sub GetTagAccessRights()
        m_objGlobal.TagID = 3976
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

    End Sub
    Private Sub DisposeNotUsedObjects()
        '=====================================================================
        ' Function  Name		:	DisposeNotUsedObjects
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To destroy not used objects
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	Oct 09 2007
        ' Revisions				:	
        '=====================================================================
        dsTask = Nothing
    End Sub
    Protected Function GetPagingString() As String
        Dim strPaging As New StringBuilder

        strPaging.Append("<TD align='right' valign='bottom'  class='clsTDBlank'>")
        If m_intRowCount > 0 Then

            dblRatio = m_intRowCount / PAGE_SIZE

            If System.Math.Ceiling(dblRatio) < m_intPageNumber Then
                m_intPageNumber = 1
            End If

            strPaging.Append("&nbsp;&nbsp;&nbsp;&nbsp;<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage()"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">")
            strPaging.Append("<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>")
            strPaging.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">")
            strPaging.Append("<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>")

            If m_intPageNumber = -1 Or dblRatio = 0 Then


                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strPaging.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True))
            Else
                strPaging.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
            End If

            strPaging.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage()"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">")
            strPaging.Append("<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>")
            strPaging.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage()"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">")
            strPaging.Append("<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> ")
            '''strPaging.Append("<input type=hidden id=hidNoOfPages value=" + (Math.Ceiling(m_intIssueCountForAppliedQuery / 20)).ToString + ">"))



            strPaging.Append(" of " + Math.Ceiling(dblRatio).ToString)
            'strPaging.Append("|<A href='javascript:Page_Onclick(""-1"")' TITLE='Show All Records'><B>All</B> </A>")

            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            strPaging.Append(CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , Math.Ceiling(dblRatio).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True))
            'ended by Yogesh J for HTML encoding Date:05/10/15
        End If

        strPaging.Append("</td>")

        Return strPaging.ToString

        strPaging = Nothing

    End Function
    Private Sub PerformAction()
        '=====================================================================
        ' Procedure Name        : PerformAction
        ' Purpose               : To Process save / delete action
        ' Returns               : None
        ' Author                : PrashantSJ
        ' Created               : 17th Feb 2009
        ' Revisions             :
        '====================================================================
        Dim strSelectedItems As String = ""
        Dim arrSelectedItems() As String
        Dim i As Integer = 0, strPostHrs As String = "", strIsTaskComplete As String = ""
        Dim strPostHrsList As String = ""
        Dim strIsTaskCompleteList As String = ""
        Dim strPostEndDateList As String = ""
        Dim strAllTaskIDs As String = ""
        Dim strPostEndDate As String = ""

        strSelectedItems = CommonFunction.General.CheckIsNothing(Request.Form("chkSelect"))
     

        Select Case m_strAction.ToUpper
            Case "SAVE"

                If strSelectedItems <> "" Then

                    arrSelectedItems = strSelectedItems.Split(","c)
                    For i = 0 To arrSelectedItems.Length - 1
                        strPostHrs = CommonFunction.General.CheckIsNothing(Request.Form("txtPostHrs" + arrSelectedItems(i)))
                        strIsTaskComplete = CommonFunction.General.CheckIsNothing(Request.Form("chkIsTaskComplete" + arrSelectedItems(i)))
                        strPostEndDate = CommonFunction.Dates.GetDate(CType(CommonFunction.General.CheckIsNothing(Request.Form("dtEndDate" + arrSelectedItems(i))), Date))

                        strPostHrsList += strPostHrs + ","
                        strPostEndDateList += strPostEndDate + ","

                        If strIsTaskComplete <> "" Then
                            strIsTaskCompleteList += "1" + ","
                        Else
                            strIsTaskCompleteList += "0" + ","
                        End If

                    Next
                End If

                strAllTaskIDs = CommonFunction.General.CheckIsNothing(Request.Form("txtHidTaskIDs"))

                m_strSQL = "usp_Ins_Upd_tbl_PM_ScheduleTasks "

                If strSelectedItems <> "" Then
                    m_strSQL += "'" + strSelectedItems + "'"
                    m_strSQL += ",'" + strPostHrsList.Substring(0, strPostHrsList.Length - 1) + "'"
                    m_strSQL += ",'" + strIsTaskCompleteList.Substring(0, strIsTaskCompleteList.Length - 1) + "'"
                    m_strSQL += ",'" + strPostEndDateList.Substring(0, strPostEndDateList.Length - 1) + "'"

                Else
                    m_strSQL += "NULL,NULL,NULL"
                End If

                If strAllTaskIDs <> "" Then
                    m_strSQL += ",'" + strAllTaskIDs + "'"
                Else
                    m_strSQL += ",NULL"
                End If

                m_strSQL += "," + m_strSessionUserID
                m_strSQL += ",N'" + m_strUserName + "'"

                Try
                    CommonFunction.Data.InsertOrUpdateData(m_strSQL, MyBase.UseSQL)
                Catch ex As Exception

                End Try
            Case "DELETE"
        End Select

    End Sub

End Class
