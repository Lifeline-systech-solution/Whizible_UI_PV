Imports System.Text
Imports Whizible

Public Class TimesheetConfiguration
    Inherits WebPages.Template.WhizTemplate
    Private sbHTML As New System.Text.StringBuilder
    Private m_strUserName As String = ""
    Protected strMenu As String
    Protected m_strAction As String
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        Dim StrSql As String = "usp_Ins_tbl_CNF_NG2_TimesheetConfigurationSettings_defaultValues '" & HttpContext.Current.Session("strUserName") & "'"
        CommonFunctions.Data.InsertOrUpdateData(StrSql, True)
    End Sub
    Public Sub PageInit()

        Dim strUserID As String = Session("intUserID").ToString()

        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If
        If m_strAction.ToUpper = "SAVE" Then
            SaveData()
        End If


        WriteMenu()
        DrawPage()


    End Sub
    Private Sub DrawPage()

        Response.Write("<DIV ID='PageDiv' Style='OVERFLOW:auto'>")

        DrawUIControls()
        Response.Write("</DIV>")
    End Sub

    Private Sub SaveData()

        'Procedure Name         : SaveData()
        ' Parameters Passed		:	
        ' Returns				:	
        ' Parameters Affected	:	None
        ' Purpose				:	Saving data
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	tejal eshmukh 
        ' Created				:	15/7/2017
        ' Revisions				:	
        '=====================================================================

        Dim ISAlert As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkAlert"), "")


        Dim IsSystem As String = HttpContext.Current.Request.Form("Alert_Section")

        If IsSystem = "" Or IsSystem Is Nothing Then
            IsSystem = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("Alert_Section"))
        End If

        Dim SetTimer As String = CType(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.Form("txtSetTimer")), String)
        Dim ISEnforcedTimesheet As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkEnforcedTime"))
        Dim NumOfNotification As String = CType(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.Form("txtNotication")), String)
        Dim HourNotification As String = CType(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.Form("txtTimer")), String)
        Dim TaskFillingDeadLine As String = CType(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.Form("txtTaskDeadline")), String)

        Dim Previous_CurrentDay = HttpContext.Current.Request.Form("EnforceTimesheet_Section")
        If Previous_CurrentDay = "" Or Previous_CurrentDay Is Nothing Then
            Previous_CurrentDay = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("EnforceTimesheet_Section"))
        End If

        Dim TimesheetDay_Week = HttpContext.Current.Request.Form("view_Section") '
        If TimesheetDay_Week = "" Or TimesheetDay_Week Is Nothing Then
            TimesheetDay_Week = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("view_Section"))
        End If

        Dim RoleBase_Employee = HttpContext.Current.Request.Form("Exculding_Section") '
        If RoleBase_Employee = "" Or RoleBase_Employee Is Nothing Then
            RoleBase_Employee = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("Exculding_Section"))
        End If

        Dim IsAttendance As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkAttendance"), "")
        Dim LocationCheck As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkLocation"), "")
        Dim ISResourceOnsite As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkOnsiteResource"), "")
        Dim ISExcludingHoliday As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkExculdHoliday"), "")
        Dim ISDayWise_WeekWise As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDayWeek"), "")
        Dim ISAllowByPassing As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkAllowByPass"), "")

        Dim m_RepoeringMgr As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("chkReportMgr"), "")
        Dim m_ProjectMgr As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("chkReportPm"), "")


        Dim m_Admin As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("chkReportAdmin"), "")

        Dim ISActiveDirectoryCheck As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkActiveDirectory"), "")

        ''Added by Yogesh Jalamkar on 22-Aug-2017 purpose: To configure timesheet backward days
        Dim TimesheetBackwardDays As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtbackwardDay"), "")
        ''end of addition by Yogesh Jalamkar
        ''Added by YOgesh Jalamkar on 01-SEP-2017 Purpose: allow Bypass for Role/Employee Specific
        Dim IsRoleBypass As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("Exculding_BypassSection"), "1")

        ''End of addition by Yogesh Jalamkar on 01-SEP-2017

        ''Added by Yogesh Jalamkar on 04-SEP-2017 Purpose: To check pending TS for different shift
        Dim t_IsEnableDifferentShift As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chk_IsEnableDifferentShift"), "")
        Dim t_ShiftStartTime As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtshiftStartTime"), "")
        Dim t_ShiftEndTime As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtshiftEndTime"), "")
        Dim t_BackTSDaysForShift As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtBackTSDaysForShift"), "")
        ''End of addition by Yogesh Jalamkar on 04-SEP-2017
        '***********************
        If IsSystem = "" Then
            IsSystem = 5 'by default value 1

        End If

        If SetTimer = "" Then
            SetTimer = 5
        End If

        If ISEnforcedTimesheet = "" Then
            ISEnforcedTimesheet = 0
        End If

        If NumOfNotification = "" Then
            NumOfNotification = 1 'by default value 1
        End If

        If HourNotification = "" Then
            HourNotification = 1
        End If

        If TaskFillingDeadLine = "" Then
            TaskFillingDeadLine = 0
        End If

        If Previous_CurrentDay = "" Then
            Previous_CurrentDay = 1 'by default selection
        End If

        If TimesheetDay_Week = "" Then
            TimesheetDay_Week = 1 ''by default selection
        End If

        If RoleBase_Employee = "" Then
            RoleBase_Employee = 1 'by default selection
        End If

        If IsAttendance = "" Then
            IsAttendance = 0
        End If

        If LocationCheck = "" Then
            LocationCheck = 0
        End If

        If ISExcludingHoliday = "" Then
            ISExcludingHoliday = 0
        End If

        If ISResourceOnsite = "" Then
            ISResourceOnsite = 0
        End If

        If ISDayWise_WeekWise = "" Then
            ISDayWise_WeekWise = 0
        End If
        If ISAllowByPassing = "" Then
            ISAllowByPassing = 0

        End If
        If m_RepoeringMgr.ToUpper() = "FALSE" Then
            m_RepoeringMgr = "NULL"
        End If

        If m_ProjectMgr.ToUpper() = "FALSE" Then
            m_ProjectMgr = "NULL"
        End If

        If m_Admin.ToUpper() = "FALSE" Then
            m_Admin = "NULL"
        End If

        '*****

        If Request.QueryString("Alert") = True Then
            ISAlert = 1
        Else
            ISAlert = 0
        End If

        If Request.QueryString("Enforced") = True Then
            ISEnforcedTimesheet = 1
        Else
            ISEnforcedTimesheet = 0
        End If


        If Request.QueryString("CheckAllowByPass") = True Then
            ISAllowByPassing = 1
        Else
            ISAllowByPassing = 0
        End If

        If Request.QueryString("CheckAttendance") = True Then
            IsAttendance = 1
        Else
            IsAttendance = 0
        End If

        If Request.QueryString("CheckLocation") = True Then
            LocationCheck = 1
        Else
            LocationCheck = 0
        End If

        If Request.QueryString("Onsiteresource") = True Then
            ISResourceOnsite = 1
        Else
            ISResourceOnsite = 0
        End If

        If Request.QueryString("CheckHoliday") = True Then
            ISExcludingHoliday = 1
        Else
            ISExcludingHoliday = 0
        End If

        If Request.QueryString("CheckDayWeek") = True Then
            ISDayWise_WeekWise = 1
        Else
            ISDayWise_WeekWise = 0
        End If

        If Request.QueryString("ActiveDirectoryCheck") = True Then
            ISActiveDirectoryCheck = 1
        Else
            ISActiveDirectoryCheck = 0
        End If

        If Request.QueryString("EnableDifferentShift") = True Then
            t_IsEnableDifferentShift = 1
        Else
            t_IsEnableDifferentShift = 0
        End If
    
        If t_BackTSDaysForShift = "" Then
            t_BackTSDaysForShift = "null"
        End If
        '***
        ' ISEnforcedTimesheet = 1
        Dim StrSql As String = "Usp_Ins_upd_tbl_CNF_NG2_TimesheetConfigurationSettings " & ISAlert & "," & IsSystem & "," & SetTimer & "," & ISEnforcedTimesheet & "," & NumOfNotification & "," & HourNotification & ",'" & TaskFillingDeadLine & "'," & Previous_CurrentDay & "," & TimesheetDay_Week & "," & RoleBase_Employee & "," & IsAttendance & "," & LocationCheck & "," & ISResourceOnsite & "," & ISExcludingHoliday & "," & ISDayWise_WeekWise & "," & ISAllowByPassing & ",'" & HttpContext.Current.Session("strUserName") & "','" & HttpContext.Current.Session("strUserName") & "'," & m_RepoeringMgr & "," & m_ProjectMgr & "," & m_Admin & "," & ISActiveDirectoryCheck & "," & TimesheetBackwardDays & "," & IsRoleBypass & "," & t_IsEnableDifferentShift & ",'" & t_ShiftStartTime & "','" & t_ShiftEndTime & "'," & t_BackTSDaysForShift
        CommonFunctions.Data.InsertOrUpdateData(StrSql, True)


    End Sub
    Protected Sub WriteMenu()

        'Procedure Name         : WriteMenu()
        ' Parameters Passed		:	
        ' Returns				:	
        ' Parameters Affected	:	None
        ' Purpose				:	to plot Menu(Link)
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	tejal eshmukh 
        ' Created				:	15/7/2017
        ' Revisions				:	
        '=====================================================================
        Dim arrMenu() As String
        Dim arrMenuToolTip() As String
        Dim arrCSFunction() As String
        Dim sbSTRHTML As New System.Text.StringBuilder


        Dim m_arrMenu() As String = {"Save", "Show History"}
        Dim m_arrMenuToolTip() As String = {"Save", "Show History"}
        Dim m_arrCSFunction() As String = {"Save_OnClick();", "ShowHistory_OnClick();"}

        arrMenu = m_arrMenu
        arrMenuToolTip = m_arrMenuToolTip
        arrCSFunction = m_arrCSFunction


        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip, True)

        CommonFunction.General.WriteHTML(strMenu)
        CommonFunction.General.WriteHTML("</BR>")
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Timesheet Utility Configuration", , , True))

        sbSTRHTML.Append("</BR>")


        CommonFunction.General.WriteHTML(sbSTRHTML.ToString())

    End Sub

    
    Private Sub DrawUIControls()
        '=====================================================================
        'Procedure Name : DrawUIControls()
        ' Parameters Passed		:	
        ' Returns				:	
        ' Parameters Affected	:	None
        ' Purpose				:	Draw controls
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	tejal eshmukh 
        ' Created				:	15/7/2017
        ' Revisions				:	
        '=====================================================================

        Dim t_ISAlert As Boolean
        Dim t_IsSystem_Resource As Integer
        Dim t_SetTimer As String
        Dim t_ISEnforcedTimesheet As Boolean
        Dim t_NumOfNotification As String
        Dim t_HourNotification As String
        Dim t_TaskFillingDeadLine As String
        Dim t_Previous_CurrentDay As Integer
        Dim t_TimesheetDay_Week As String
        Dim t_RoleBase_Employee As Integer
        Dim t_IsAttendance As Boolean
        Dim t_LocationCheck As Boolean
        Dim t_ISResourceOnsite As Boolean
        Dim t_ISExcludingHoliday As Boolean
        Dim t_ISDayWise_WeekWise As Integer
        Dim t_ISAllowByPassing As Boolean
        Dim t_IsRoleBypass As Integer
        Dim t_RsourceType As String
        ''Added by Yogesh Jalamkar on 04-SEP-2017 Purpose: To check pending TS for different shift
        Dim t_IsEnableDifferentShift As Boolean
        Dim t_ShiftStartTime As String
        Dim t_ShiftEndTime As String
        Dim t_BackTSDaysForShift As String
        ''End of addition by Yogesh Jalamkar on 04-SEP-2017
        Dim Str As String = ""
        Dim RM As Integer = 0
        Dim PM As Integer = 0
        Dim AD As Integer = 0
        Dim intRowCount As Integer = 0
        Dim t_TimesheetbackwardDay As Integer
        Dim t_ISActiveDirectoryValidationEnabled As Boolean
        Dim IsLDAPEnabled As String = ""
        Str = "EXEC usp_sel_tbl_CNF_NG2_TimesheetConfigurationSettings"

        Dim readFeild As IDataReader
        readFeild = CommonFunctions.Data.GetDataReader(Str, True)
        IsLDAPEnabled = ConfigurationManager.AppSettings("AuthenticationType")

        If readFeild.Read Then

            t_ISAlert = readFeild("ISAlert")
            t_IsSystem_Resource = CommonFunctions.Data.CheckIsDBNull(readFeild("IsSystem_Resource"), "")
            t_SetTimer = CommonFunctions.Data.CheckIsDBNull(readFeild("SetTimer").ToString, "")
            t_ISEnforcedTimesheet = CommonFunctions.Data.CheckIsDBNull(readFeild("ISEnforcedTimesheet"), 0)
            t_NumOfNotification = CommonFunctions.Data.CheckIsDBNull(readFeild("NumOfNotification").ToString, 0)
            t_HourNotification = CommonFunctions.Data.CheckIsDBNull(readFeild("HourNotification").ToString, 30)
            t_TaskFillingDeadLine = CommonFunctions.Data.CheckIsDBNull(readFeild("TaskFillingDeadLine").ToString, 0)
            t_Previous_CurrentDay = CommonFunctions.Data.CheckIsDBNull(readFeild("Previous_CurrentDay"), 0)
            t_TimesheetDay_Week = CommonFunctions.Data.CheckIsDBNull(readFeild("TimesheetDay_Week"), 0)
            t_RoleBase_Employee = CommonFunctions.Data.CheckIsDBNull(readFeild("RoleBase_Employee"), 0)
            t_IsAttendance = CommonFunctions.Data.CheckIsDBNull(readFeild("IsAttendance"), 0)
            t_LocationCheck = CommonFunctions.Data.CheckIsDBNull(readFeild("LocationCheck"), 0)
            t_ISResourceOnsite = CommonFunctions.Data.CheckIsDBNull(readFeild("ISResourceOnsite"), 0)
            t_ISExcludingHoliday = CommonFunctions.Data.CheckIsDBNull(readFeild("ISExcludingHoliday"), 0)
            t_ISDayWise_WeekWise = CommonFunctions.Data.CheckIsDBNull(readFeild("ISDayWise_WeekWise"), 0)

            t_ISAllowByPassing = CommonFunctions.Data.CheckIsDBNull(readFeild("ISAllowByPassing"), 0)
            t_RsourceType = CommonFunctions.Data.CheckIsDBNull(readFeild("ResourceType"), 0)
            t_IsRoleBypass = CommonFunctions.Data.CheckIsDBNull(readFeild("IsRoleBypass"), 0)

            t_ISActiveDirectoryValidationEnabled = CommonFunctions.Data.CheckIsDBNull(readFeild("IsActiveDirectoryValidationEnabled"), 0)
            t_TimesheetbackwardDay = CommonFunctions.Data.CheckIsDBNull(readFeild("TimesheetBackWardDays"), 0)
            ''Added by Yogesh Jalamkar on 04-SEP-2017 Purpose: To check pending TS for different shift
            t_IsEnableDifferentShift = CommonFunctions.Data.CheckIsDBNull(readFeild("IsEnableDifferentShift"), 0)
            t_ShiftStartTime = CommonFunctions.Data.CheckIsDBNull(readFeild("ShiftStartTime"), "")
            t_ShiftEndTime = CommonFunctions.Data.CheckIsDBNull(readFeild("ShiftEndTime"), "")
            t_BackTSDaysForShift = CommonFunctions.Data.CheckIsDBNull(readFeild("BackTSDaysForShift"), 1)
            ''End of addition by Yogesh Jalamkar
            'Dim strArray() As String = t_RsourceType.Split(",")
            'For intRowCount = 0 To strArray.Length - 1
            RM = 0
            PM = 0
            AD = 0
            If t_RsourceType.Contains("1") Then
                RM = 1
            End If
            If t_RsourceType.Contains("2") Then
                PM = 2
            End If
            If t_RsourceType.Contains("3") Then
                AD = 3
            End If
            'Next

        End If



        Dim t_AlertCheck As String



        sbHTML.Append("<TABLE style='' id='tblTimesheetExe' class=clsTable' width='100%'>")
        sbHTML.Append("<TR class='clsTRSectionHeader'><TD colspan='4' style='text-align:left !important;'><strong>Task Notification Alert </strong></TD></TR>")
        If t_ISAlert = True Then

            sbHTML.Append("<TR class='clsTREven'><TD colspan='4'><Input type=checkbox name='chkAlert'  id='chkAlert' checked value='1'>&nbsp;&nbsp;&nbsp;Enable Alert") '1st TR<TD></TD>
        Else
            sbHTML.Append("<TR class='clsTREven'><TD colspan='4'><Input type=checkbox name='chkAlert'  id='chkAlert' value='0'>&nbsp;&nbsp;&nbsp;Enable Alert") '1st TR
        End If

        sbHTML.Append("</TD></TR>")

        sbHTML.Append("<TR class='clsTREven'><TD colspan='1'>")
        If t_IsSystem_Resource = 1 Then
            sbHTML.Append("<Input type='radio' value='1' name='Alert_Section' id='Alert_Sys' onclick='SystemResource_onChange(this)' checked>&nbsp;&nbsp;&nbsp;System Specific") '<TD></TD>
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD colspan='1'>")
            sbHTML.Append("<Input type='radio' value='2' name='Alert_Section' id='Alert_Resource' onclick='SystemResource_onChange(this)'>&nbsp;&nbsp;&nbsp;Resource Specific</TD></TR>")
        ElseIf t_IsSystem_Resource = 2 Then
            sbHTML.Append("<Input type='radio' name='Alert_Section' value='1' id='Alert_Sys' onclick='SystemResource_onChange(this)'>&nbsp;&nbsp;&nbsp;System Specific") '<TD></TD>
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD colspan='1'>")
            sbHTML.Append("<Input type='radio' value='2' name='Alert_Section' id='Alert_Resource' onclick='SystemResource_onChange(this)' checked='checked'>&nbsp;&nbsp;&nbsp;Resource Specific</TD></TR>") '2n TR<TD></TD>
        Else
            sbHTML.Append("<Input type='radio' name='Alert_Section' value='1' id='Alert_Sys' onclick='SystemResource_onChange(this)' checked='checked'>&nbsp;&nbsp;&nbsp;System Specific") '<TD>System</TD>
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD colspan='1'>")
            sbHTML.Append("<Input type='radio' value='2' name='Alert_Section' id='Alert_Resource' onclick='SystemResource_onChange(this)'>&nbsp;&nbsp;&nbsp;Resource Specific</TD></TR>") '2n TR<TD></TD>
        End If
        If t_SetTimer = "" Or t_SetTimer = 0 Then
            ''Modified by Yogesh on 31-AUg-2017 Purpose: Default value should br 15
            't_SetTimer = 1
            t_SetTimer = 5  ''
            ''End of modification by Yogesh Jalamkar
        End If
        sbHTML.Append("<TR class='clsTREven'><TD colspan='4'>Set timer between two alerts (System Specific) &nbsp;&nbsp;&nbsp;") '
        sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtSetTimer", "txtSetTimer", , 98, , t_SetTimer, , , , , , , , True, EnableHTMLEncode:=True))
        'sbHTML.Append("</TD>") '3rd Tr
        sbHTML.Append("&nbsp;&nbsp;Mins&nbsp;&nbsp;&nbsp;")
        sbHTML.Append("<span id='SpnSetTimer' style='font-size:11px;color:red'></TD></TR>")
        sbHTML.Append("<TR><TD style='font-style:italic !important; font-size:12px' colspan='4'>Note: Task Notification Alert can be configured for Resources if Resource Specific.</TD></TR>")

        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        sbHTML.Append("<TR class='clsTRSectionHeader'><TD colspan='4' style='text-align:left !important;'><strong>To Enforce Timesheet Entry Daily&nbsp;[Display full screen]</strong></TD></TR>")

        If t_ISEnforcedTimesheet = True Then
            sbHTML.Append("<TR class='clsTREven'><TD colspan='1' style='margin-left:5%'><Input type=checkbox name='chkEnforcedTime' value='1' id='chkEnforcedTime' checked  onclick='AlertSecction_Disable(this)' >&nbsp;&nbsp;&nbsp;Enforce Timesheet Entry</TD>") '4th TR
        Else
            sbHTML.Append("<TR class='clsTREven'><TD colspan='1' style='margin-left:5%'><Input type=checkbox name='chkEnforcedTime' value='0' id='chkEnforcedTime' onclick='AlertSecction_Disable(this)'>&nbsp;&nbsp;&nbsp;Enforce Timesheet Entry</TD>") '4th TR
        End If
        sbHTML.Append("<TD  colspan='3'style='font-style:italic !important; font-size:12px;color:red'><span id='SpnNotificationNote' style='display:none'>Note:If we select Enforce Timesheet Entry then Task Notification Alert  notification will be disable </span></TD></TR>")
        sbHTML.Append("<TR class='clsTREven'><TD clospan='1' nowrap align='right'>Number of Notification &nbsp;&nbsp;&nbsp;") '</TD><TD
        sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtNotication", "txtNotication", , 98, , t_NumOfNotification, , , , , , , , True, EnableHTMLEncode:=True))
        'sbHTML.Append("</TD><TD>Timer&nbsp;[Mins]&nbsp;&nbsp;&nbsp;")
        sbHTML.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD><TD colspan='3' style='font-style:italic !important; nowrap font-size:12px'>Note: Notification before blocking the screen</TD>")

        sbHTML.Append("</TR>") '5th Tr 
        sbHTML.Append("<TR><TD colspan='1' align='right' nowrap><span id='SpnNumOfNotification' style='font-size:11px;color:red'></TD></TR>")

        sbHTML.Append("<TR class='clsTREven'><TD  colspan='1' nowrap align='right' id='tdTimer'>Timer&nbsp;&nbsp;&nbsp;")
        sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtTimer", "txtTimer", , 98, , t_HourNotification, , , , , , , , True, EnableHTMLEncode:=True))
        sbHTML.Append("&nbsp Mins</TD><TD colspan='3' nowrap style='font-style:italic !important; font-size:12px'>Note:Time between two notifications</TD></TR>")
        sbHTML.Append("<TR><td colspan='1' nowrap align='right'><span id='SpnHourNotification' style='font-size:12px;color:red'></TD></TR>")


        sbHTML.Append("<TR><TD colspan='4'></TD></TR>")
        '**
        If t_Previous_CurrentDay = 1 Then
            sbHTML.Append("<TR class='clsTREven'><TD colspan='2'><Input type='radio' name='EnforceTimesheet_Section' value='1' id='Sel_Pevious' onclick='' checked >&nbsp;&nbsp;&nbsp;Check Previous Day (Tasks of previous day where DA not filled.)</TD>")
            sbHTML.Append("<TD colspan='2' style='text-align: right important;'><Input type='radio' value='2' name='EnforceTimesheet_Section' id='Sel_Current' onclick=''>&nbsp;&nbsp;&nbsp;Check Current Day</TD></TR>") '6th TR
        ElseIf t_Previous_CurrentDay = 2 Then
            sbHTML.Append("<TR class='clsTREven'><TD style='text-align: right important;'><Input type='radio' name='EnforceTimesheet_Section' value='1' id='Sel_Pevious' onclick='')'>&nbsp;&nbsp;&nbsp;Check Previous Day</TD>")
            sbHTML.Append("<TD style='text-align: right important;'><Input type='radio' value='2' name='EnforceTimesheet_Section' id='Sel_Current' onclick='' checked>&nbsp;&nbsp;&nbsp;Check Current Day</TD></TR>") '6th TR
        Else
            sbHTML.Append("<TR class='clsTREven'><TD style='text-align: right important;'><Input type='radio' name='EnforceTimesheet_Section' value='1' id='Sel_Pevious' onclick='' checked >&nbsp;&nbsp;&nbsp;Check Previous Day</TD>")
            sbHTML.Append("<TD style='text-align: right important;'><Input type='radio' value='2' name='EnforceTimesheet_Section' id='Sel_Current' onclick=''>&nbsp;&nbsp;&nbsp;Check Current Day</TD></TR>") '6th TR
        End If
        '**
        sbHTML.Append("<TR class='clsTREven'><TD colspan='4'>Time to notify alert&nbsp;&nbsp;&nbsp;") '</TD><TD>
        sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtTaskDeadline", "txtTaskDeadline", , 98, , t_TaskFillingDeadLine, , , , , , , , True, EnableHTMLEncode:=True))
        sbHTML.Append("&nbsp;&nbsp;&nbsp;24 hours format (Alert in a Day)</TD></TR>") '7th Tr
        sbHTML.Append("<TR><TD><span id='SpnTaskDeadline' style='font-size:11px;color:red' ></TD></TR>")

        ''Added by Yogesh Jalamkar on 22-Aug-2017 purpose: To configure timesheet backward days
        sbHTML.Append("<TR><TD colspan='4'><hr/></TD></TR>")
        sbHTML.Append("<TR class='clsTREven'><TD colspan='4'>Check daily activity for backward days</TD></TR>") '10 nth TR
        sbHTML.Append("<TR class='clsTREven'><TD>Backward Days &nbsp;&nbsp;&nbsp;") '</TD><TD
        sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtbackwardDay", "txtbackwardDay", , 98, , t_TimesheetbackwardDay, , , , True, , , , True, EnableHTMLEncode:=True))
        sbHTML.Append("</TD>")
        sbHTML.Append("<TR><TD><span id='SpntxtbackwardDay' style='font-size:11px;color:red'></TD></TR>")
        ''End of addition by Yogesh Jalamkar



        ''Added by Yogesh Jalamkar on 04-SEP-2017 Purpose: To check pending TS for different shift

        If t_IsEnableDifferentShift = True Then
            sbHTML.Append("<TR class='clsTREven'><TD colspan = '4' style='margin-left:5%'><Input type=checkbox name='chk_IsEnableDifferentShift' value='1' id='chk_IsEnableDifferentShift' onclick='AllowShift_Checked(this)' checked>&nbsp;&nbsp;&nbsp;Allow Different Shift&nbsp;(Check TS Entry for specific shift)</td></TR>") '8th TR
        Else
            sbHTML.Append("<TR class='clsTREven'><TD colspan = '4' style='margin-left:5%'><Input type=checkbox name='chk_IsEnableDifferentShift' value='0' id='chk_IsEnableDifferentShift' onclick='AllowShift_Checked(this)'>&nbsp;&nbsp;&nbsp;Allow Different Shift&nbsp;(Check TS Entry for specific shift)</td></TR>") '8th TR
        End If
        sbHTML.Append("<TR class='clsTREven'>")
        sbHTML.Append("<TD colspan='1'>Shift Start Time&nbsp;&nbsp;&nbsp;") '</TD><TD>
        sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtshiftStartTime", "txtshiftStartTime", , 98, , t_ShiftStartTime, , , , , , , , True, EnableHTMLEncode:=True))
        sbHTML.Append("</TD>")
        sbHTML.Append("<TD colspan='3' nowrap>Shift End Time&nbsp;&nbsp;&nbsp;") '</TD><TD>
        sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtshiftEndTime", "txtshiftEndTime", , 98, , t_ShiftEndTime, , , , , , , , True, EnableHTMLEncode:=True))
        sbHTML.Append("&nbsp;&nbsp;&nbsp;24 hours format </TD></TR>") '7th Tr
        sbHTML.Append("<TR><TD colspan='1'><span id='SpntxtshifStartTime' style='font-size:11px;color:red' ></TD><TD colspan='3'><span id='SpntxtshiftEndTime' style='font-size:11px;color:red' ></TD></TR>")
        sbHTML.Append("<TR class='clsTREven'>")
        sbHTML.Append("<TD colspan='4'>Check TS entry for back Days&nbsp;&nbsp;&nbsp;") '</TD><TD>
        sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtBackTSDaysForShift", "txtBackTSDaysForShift", , 98, , t_BackTSDaysForShift, , , , , , , , True, EnableHTMLEncode:=True))
        sbHTML.Append("</TD>")
        sbHTML.Append("</TR>")
        sbHTML.Append("<TR><TD colspan='4'><span id='SpntxtBackTSDaysForShift' style='font-size:11px;color:red'></TD></TR>")


        ''End of addition by Yogesh Jalamkar on 04-SEP-2017 

        sbHTML.Append("<TR><TD colspan='4'><hr /></TD></TR>")
        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        If t_ISAllowByPassing = True Then
            sbHTML.Append("<TR class='clsTREven'><TD colspan = '4' style='margin-left:5%'><Input type=checkbox name='chkAllowByPass' value='1' id='chkAllowByPass' onclick='AllowPass_Checked(this)' checked>&nbsp;&nbsp;&nbsp;Allow Bypassing&nbsp;(Will allow resource to bypass the entry for a day.)</td></TR>") '8th TR
        Else
            sbHTML.Append("<TR class='clsTREven'><TD colspan = '4' style='margin-left:5%'><Input type=checkbox name='chkAllowByPass' value='0' id='chkAllowByPass' onclick='AllowPass_Checked(this)'>&nbsp;&nbsp;&nbsp;Allow Bypassing&nbsp;[Timesheet Entry] (Will allow resource to bypass the entry for a day.)</td></TR>") '8th TR
        End If

        '******

        ''Added by Yogesh Jalamkar on 01-SEP-2017 Purpose:To exclude Role/Employee from by Pass Option
        If t_IsRoleBypass = 1 Then

            sbHTML.Append("<TR class='clsTREven'><TD colspan='2' title='Exculde Role' style='margin-left:5%'><Input type='checkbox' name='Exculding_BypassSection' value='1' id='Sel_ByPassRole' onclick='BypassRoleEmployee_onChange(this)' checked>&nbsp;&nbsp;&nbsp;&nbspRole Specific &nbsp;&nbsp;&nbsp;&nbsp;<a href=""javascript:ByPassFlag_OnClick('Role')"" id='linkBypassRole' style='text-decoration:underline !important;'>Select Role</a></TD>")

            sbHTML.Append("<TD colspan='2' title='Exculde Employee'><Input type='checkbox' name='Exculding_BypassSection' value='0' id='Sel_BypassEmployee' onclick='BypassRoleEmployee_onChange(this)'>&nbsp;&nbsp;&nbsp;&nbspEmployee Specific&nbsp;&nbsp;&nbsp;&nbsp;<a href=""#"" id='linkBypassEmp' style='text-decoration:underline !important;'>Select Employee</a></TD>")


        ElseIf t_IsRoleBypass = 0 Then
            sbHTML.Append("<TR class='clsTREven'><TD colspan='2' title='Exculde Role' style='margin-left:5%'><Input type='checkbox' name='Exculding_BypassSection' value='1' id='Sel_ByPassRole' onclick='BypassRoleEmployee_onChange(this)' >&nbsp;&nbsp;&nbsp;&nbspRole Specific &nbsp;&nbsp;&nbsp;&nbsp;<a href=""#"" id='linkBypassRole' style='text-decoration:underline !important;'>Select Role</a></TD>")

            sbHTML.Append("<TD colspan='2' title='Exculde Employee'><Input type='checkbox' name='Exculding_BypassSection' value='0' id='Sel_BypassEmployee' onclick='BypassRoleEmployee_onChange(this)' checked>&nbsp;&nbsp;&nbsp;&nbspEmployee Specific&nbsp;&nbsp;&nbsp;&nbsp;<a href=""javascript:ByPassFlag_OnClick('Emp')"" id='linkBypassEmp' style='text-decoration:underline !important;'>Select Employee</a></TD>")

        Else

            sbHTML.Append("<TR class='clsTREven'><TD colspan='2' title='Exculde Role' style='margin-left:5%'><Input type='checkbox' name='Exculding_BypassSection' value='1' id='Sel_ByPassRole' onclick='BypassRoleEmployee_onChange(this)' >&nbsp;&nbsp;&nbsp;&nbspRole Specific &nbsp;&nbsp;&nbsp;&nbsp;<a href=""javascript:ByPassFlag_OnClick('Role')"" id='linkBypassRole' style='text-decoration:underline !important;'>Select Role</a></TD>")

            sbHTML.Append("<TD colspan='2' title='Exculde Employee'><Input type='checkbox' name='Exculding_BypassSection' value='0' id='Sel_BypassEmployee' onclick='BypassRoleEmployee_onChange(this)'>&nbsp;&nbsp;&nbsp;&nbspEmployee Specific&nbsp;&nbsp;&nbsp;&nbsp;<a href=""javascript:ByPassFlag_OnClick('Emp')"" id='linkBypassEmp' style='text-decoration:underline !important;'>Select Employee</a></TD>")

        End If
        ''End of addition by Yogesh Jalamkar
        If RM = 1 Then
            sbHTML.Append("<TR class='clsTREven'><TD width='30%' title='Email to Resource Reporting Manager' style='margin-left:5%'><Input type=checkbox name='chkReportMgr'  id='chkReportMgr' value='1' checked>&nbsp;&nbsp;&nbsp;Reporting Manager</TD>")
        Else
            sbHTML.Append("<TR class='clsTREven'><TD width='30%' title='Email to Resource Reporting Manager' style='margin-left:5%'><Input type=checkbox name='chkReportMgr'  id='chkReportMgr' value='0'>&nbsp;&nbsp;&nbsp;Reporting Manager</TD>")
        End If

        If PM = 2 Then
            sbHTML.Append("<TD title='Email to Project Manager'><Input type=checkbox name='chkReportPm' id='chkReportPm' value='2' checked>&nbsp;&nbsp;&nbsp;&nbsp;Project Manager</TD>")
        Else
            sbHTML.Append("<TD title='Email to Project Manager'><Input type=checkbox name='chkReportPm' id='chkReportPm' value='0'>&nbsp;&nbsp;&nbsp;Project Manager</TD>")
        End If

        If AD = 3 Then
            sbHTML.Append("<TD width='40%' title='Email to System Administrator'><Input type=checkbox name='chkReportAdmin' id='chkReportAdmin' value='3' checked>&nbsp;&nbsp;&nbsp;Administrator </TD></TR>") '9th TR
        Else
            sbHTML.Append("<TD width='40%' title='Email to System Administrator'><Input type=checkbox name='chkReportAdmin' id='chkReportAdmin' value='0'>&nbsp;&nbsp;&nbsp;Administrator</TD></TR>") '9th TR
        End If
        sbHTML.Append("<TR><TD style='font-style:italic !important; font-size:12px' colspan='4'>Note:Email Notification will be send to selected roles if resource bypass the entry.</TD></TR>")
        '******
        sbHTML.Append("<TR><TD colspan='4'><hr /></TD></TR>")
        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        sbHTML.Append("<TR class='clsTREven'><TD colspan='4'>Timesheet View</TD></TR>") '10 nth TR

        If t_TimesheetDay_Week = 1 Then
            sbHTML.Append("<TR class='clsTREven'><TD title='Timesheet Day view'><Input type='radio' name='view_Section' value='1' id='Sel_Day' onclick='' checked>&nbsp;&nbsp;&nbsp;Daily</TD>")
            sbHTML.Append("<TD  title='Timesheet Week view'><Input type='radio' name='view_Section' value='2' id='Sel_Week' onclick='')'>&nbsp;&nbsp;&nbsp;Weekly</TD></TR>") '11 th TR
        ElseIf t_TimesheetDay_Week = 2 Then
            sbHTML.Append("<TR class='clsTREven'><TD title='Timesheet Day view'><Input type='radio' name='view_Section' value='1' id='Sel_Day' onclick=''>&nbsp;&nbsp;&nbsp;Daily</TD>")
            sbHTML.Append("<TD title='Timesheet Week view'><Input type='radio' name='view_Section' value='2' id='Sel_Week' onclick='' checked>&nbsp;&nbsp;&nbsp;Weekly</TD></TR>") '11 th TR
        Else
            sbHTML.Append("<TR class='clsTREven'><TD  colspan='2' title='Timesheet Day view'><Input type='radio' name='view_Section' value='1' id='Sel_Day' onclick='' checked>&nbsp;&nbsp;&nbsp;Daily</TD>")
            sbHTML.Append("<TD colspan='2' title='Timesheet Week view'><Input type='radio'name='view_Section' value='2' id='Sel_Week' onclick=''>&nbsp;&nbsp;&nbsp;Weekly</TD></TR>") '11 th TR
        End If
        sbHTML.Append("<TR><TD colspan='4'><hr/></TD></TR>")
        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

        sbHTML.Append("<TR class='clsTREven'><TD colspan='4'>Exclusion (Selected Roles/Employees will be excluded for enforcing timesheet)</TD></TR>") '10 nth TR

        If t_RoleBase_Employee = 1 Then

            sbHTML.Append("<TR class='clsTREven'><TD colspan='2' title='Exculde Role' style='margin-left:5%'><Input type='checkbox' name='Exculding_Section' value='1' id='Sel_Role' onclick='RoleEmployee_onChange(this)' checked>&nbsp;&nbsp;&nbsp;&nbspRole Specific &nbsp;&nbsp;&nbsp;&nbsp;<a href=""javascript:Flag_OnClick('Role')"" id='linkRole' style='text-decoration:underline !important;'>Select Role</a></TD>")

            sbHTML.Append("<TD colspan='2' title='Exculde Employee'><Input type='checkbox' name='Exculding_Section' value='2' id='Sel_Employee' onclick='RoleEmployee_onChange(this)'>&nbsp;&nbsp;&nbsp;&nbspEmployee Specific&nbsp;&nbsp;&nbsp;&nbsp;<a href=""#"" id='linkEmp' style='text-decoration:underline !important;'>Select Employee</a></TD>")


        ElseIf t_RoleBase_Employee = 2 Then
            sbHTML.Append("<TR class='clsTREven'><TD colspan='2' title='Exculde Role' style='margin-left:5%'><Input type='checkbox' name='Exculding_Section' value='1' id='Sel_Role' onclick='RoleEmployee_onChange(this)'>&nbsp;&nbsp;&nbsp;&nbspRole Specific &nbsp;&nbsp;&nbsp;&nbsp;<a href=""#"" id='linkRole' style='text-decoration:underline !important;'>Select Role</a></td>")

            sbHTML.Append("<TD colspan='2' title='Exculde Employee'><Input type='checkbox' name='Exculding_Section' value='2' id='Sel_Employee' onclick='RoleEmployee_onChange(this)' checked>&nbsp;&nbsp;&nbsp;&nbspEmployee Specific&nbsp;&nbsp;&nbsp;&nbsp; <a href=""javascript:Flag_OnClick('Emp')"" id='linkEmp' style='text-decoration:underline !important;'>Select Employee</a></TD></TR>") '13 th TR

        Else

            sbHTML.Append("<TR colspan='2' class='clsTREven'><TD title='Exculde Role'><Input type='checkbox' name='Exculding_Section' value='1' id='Sel_Role' onclick='RoleEmployee_onChange(this)'>&nbsp;&nbsp;&nbsp;&nbspRole Specific &nbsp;&nbsp;&nbsp;&nbsp;<a href=""javascript:Flag_OnClick('Role')"" id='linkRole'>Select Role</a></TD>")

            sbHTML.Append("<TD colspan='2' title='Exculde Employee'><Input type='checkbox' name='Exculding_Section' value='2' id='Sel_Employee' onclick='RoleEmployee_onChange(this)'>&nbsp;&nbsp;&nbsp;&nbspEmployee Specific&nbsp;&nbsp;&nbsp;&nbsp;<a href=""javascript:Flag_OnClick('Emp')"" id='linkEmp'>Select Employee</a></TD></TR>")

        End If

     

        sbHTML.Append("<TR class='clsTRSectionHeader'><TD colspan='4' style='text-align:left !important;'><strong>Active Directory Check </strong></TD></TR>")
        If IsLDAPEnabled = "N" Then

            sbHTML.Append("<TR class='clsTREven'><TD colspan='1' nowrap><Input type=checkbox name='chkActiveDirectory'  id='chkActiveDirectory' disabled value='1'>&nbsp;&nbsp;&nbsp;Enable Active Directory Validation ") '1st TR<TD></TD>
            sbHTML.Append("</TD><TD colspan='3' nowrap style='font-style:italic !important;color:red; font-size:12px'>Note:LDAP is not enable for the site</TD></TR>")

        Else
        If t_ISActiveDirectoryValidationEnabled = True Then
                sbHTML.Append("<TR class='clsTREven'><TD colspan='4'><Input type=checkbox name='chkActiveDirectory'  id='chkActiveDirectory' checked value='1'>&nbsp;&nbsp;&nbsp;Enable Active Directory Validation <TD></TR>") '1st TR<TD></TD>
        Else
                sbHTML.Append("<TR class='clsTREven'><TD colspan='4'><Input type=checkbox name='chkActiveDirectory'  id='chkActiveDirectory' value='0'>&nbsp;&nbsp;&nbsp;Enable Active Directory Validation <TD></TR>") '1st TR
        End If
        End If
    

        ''sbHTML.Append("<TR><TD colspan='4'></TD></TR>")
        '' '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        ''sbHTML.Append("<TR class='clsTRSectionHeader'><TD colspan='4' style='text-align:left !important;'><strong>Attendance</strong></TD></TR>") '14 nth TR
        ''sbHTML.Append("</TABLE>")

        ''sbHTML.Append("<TABLE id='tblAttendance' style='border:1px solid black' >")


        ' '' Dim WorkinOptionCheck As Boolean

        ' '' WorkinOptionCheck = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_pm_Companyinformation_AttendanceCheck ", True), "0")

        ' ''If WorkinOptionCheck = 1 Then
        ' ''    sbHTML.Append("<TR class='clsTREven'><TD><Input type=checkbox name='chkAttendance' value='1' id='chkAttendance' checked></TD><TD>Attendance</TD></TR>")
        ' ''Else
        ' ''    sbHTML.Append("<TR class='clsTREven'><TD><Input type=checkbox name='chkAttendance' value='0' id='chkAttendance'></TD><TD>Attendance </TD></TR>")
        ' ''End If


        ''If t_IsAttendance = True Then
        ''    sbHTML.Append("<TR class='clsTREven'><TD><Input type=checkbox name='chkAttendance' value='1' id='chkAttendance' checked></TD><TD>Attendance</TD></TR>")
        ''Else
        ''    sbHTML.Append("<TR class='clsTREven'><TD><Input type=checkbox name='chkAttendance' value='0' id='chkAttendance'></TD><TD>Attendance </TD></TR>")
        ''End If

        ''If t_LocationCheck = True Then
        ''    sbHTML.Append("<TR class='clsTREven'><TD><Input type=checkbox name='chkLocation' value='1' id='chkLocation' checked></TD><TD>Location Specific</TD></TR>")
        ''Else
        ''    sbHTML.Append("<TR class='clsTREven'><TD><Input type=checkbox name='chkLocation' value='0' id='chkLocation'></TD><TD>Location Specific </TD></TR>")
        ''End If

        ''If t_ISResourceOnsite = True Then
        ''    sbHTML.Append("<TR class='clsTREven'><TD><Input type=checkbox name='chkOnsiteResource' value='1' id='chkOnsiteResource' checked></TD><TD>Resource Onsite </TD></TR>")
        ''Else
        ''    sbHTML.Append("<TR class='clsTREven'><TD><Input type=checkbox name='chkOnsiteResource' value='0' id='chkOnsiteResource'></TD><TD>Resource Onsite </TD></TR>")
        ''End If

        ''If t_ISExcludingHoliday = True Then
        ''    sbHTML.Append("<TR class='clsTREven'><TD><Input type=checkbox name='chkExculdHoliday' value='1' id='chkExculdHoliday' checked></TD><TD>Exculding Holiday</TD></TR>")
        ''Else
        ''    sbHTML.Append("<TR class='clsTREven'><TD><Input type=checkbox name='chkExculdHoliday' value='0' id='chkExculdHoliday'></TD><TD>Exculding Holiday</TD></TR>")
        ''    'sbHTML.Append("<TR class='clsTREven'><TD><Input type=checkbox name='chkExculdHoliday' value='0' id='chkExculdHoliday></TD><TD>Exculding Holiday</TD></TR>")
        ''End If
        ''If t_ISDayWise_WeekWise = True Then
        ''    sbHTML.Append("<TR class='clsTREven'><TD><Input type=checkbox name='chkDayWeek' value='1' id='chkDayWeek' checked></TD><TD>Day/Week Wise</TD></TR>")
        ''Else
        ''    sbHTML.Append("<TR class='clsTREven'><TD><Input type=checkbox name='chkDayWeek' value='0' id='chkDayWeek'></TD><TD>Day/Week Wise</TD></TR>")
        ''End If
        sbHTML.Append("</TABLE>")


        Response.Write(sbHTML.ToString())
    End Sub


End Class