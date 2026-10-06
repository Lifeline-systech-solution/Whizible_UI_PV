Public Class PM_TimeSheet
    Inherits WebPage.Templates.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents frmTimeSheet As System.Web.UI.HtmlControls.HtmlForm

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object
    
    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private m_LoginId As Long 'Login Id
    Private m_LoginType As String 'Login type
    Private m_RoleId As Long 'Role Id
    Private m_RoleLevel As Integer 'Role level
    Protected m_ProjectId As Long 'Project Id
    Private m_UserId As Long 'User Id
    Private m_UserName As String 'User Name
    Private m_CultureId As Long 'Culture Id
    Protected m_FromWhere As String 'From where ?

    Private m_blnAddAccess As Boolean = False 'user has Add Access ?
    Private m_blnDeleteAccess As Boolean = False 'User has Delete Access ?
    Private m_blnEditAccess As Boolean = False 'User has Edit Access ?

    Private m_blnTaskGridDataPresent As Boolean = False
    Private m_blnGenerateTimeSheetGridDataPresent As Boolean = False

    Protected strOrderByField As String = "" 'Order by field name
    Protected strAscOrDesc As String = "" 'Sorting Order 

    Private intNumTodayDate As Integer
    Private dtFirstDayOfWeek As Date 'First day current week
    Private dtLastDayOfWeek As Date 'Last day of current week

    Private strFromDate As String = "" 'From Date
    Private strToDate As String = "" 'To Date
    Private intWSRTimeSheetNo As Integer ' WSR Timesheet number
    Protected intTimeSheetNo As Integer 'Timesheet number
    Private intSubProjectID As Integer 'SubProject Id
    Private strTask As String = ""
    Private intDuration As Double

    Private strMode As String = ""
    Protected strTimeSheetID As String = ""
    Private strStatus As String = ""

    Private blnGenerateInvoice As Boolean = False 'Generate Invoice ?
    Private blnSubProjectLevelInvoiceing As Boolean = False 'SubProject level invoicing ?
    Private blnAllowTimesheetManipulation As Boolean = CommonFunction.Application.AllowTimesheetManipulation 'Allow Timesheet manipulation ?

    Private strDescription As String = ""

    Private blnNoData As Boolean = False 'No data found ?

    Private m_strUserName As String = ""
    Private m_strEntryDate As String = ""
    Private m_strTimeSheetIDList As String = ""

    'Added By VivekP On 16 Sep 2005 Fro WhizibleSEM SP4
    Private m_GroupTotal As Double = 0
    'Added By Usha Pandit On 20.11.2020 For getting work hours in HH:MM to decimal format
    Private m_GrandTotal As Double = 0
    'End Of Added By Usha Pandit On 20.11.2020 For getting work hours in HH:MM to decimal format
    Private m_intGroupNumber As Integer = -1
    'End OF addition On 16 Sep 2005 Fro WhizibleSEM SP4


    Private strSubProjectCaption As String = ""

    'Modified By VivekP on 2 August 2005 For SP4 WhizibleSEM -change variables from private to protected IssueID-87
    Protected blnSendEmail As Boolean = False
    Protected blnShowPopup As Boolean = False
    Protected blnAuthenticateFlag As Boolean = False 'To indicate Timesheet is Authenticated IssueID-87
    'End OF Modification On 2 August 2005 For SP4 WhizibleSEM

    Private m_blnTimeSheetAuthenticated As Boolean = False
    Private m_blnTImeSheetReadyForAuthentication As Boolean = False

    Private WithEvents objTaskListGrid As New WebPage.Templates.GenericGrid
    Private WithEvents objGenerateTimeSheetGrid As New WebPage.Templates.GenericGrid
    Private WithEvents objResourcesGrid As New WebPage.Templates.GenericGrid
    ' Code added by SwapnilR on 1st Dec 2004
    Private WithEvents objDAResourceGrid As New WebPage.Templates.GenericGrid
    ' End of code addtion

    ' Code added by SwapnilR on 17th Feb 2005
    ' Purpose : To show List of all employee's who entered daily activity
    '           after closing of the project
    Private WithEvents objDAExceedGrid As New WebPage.Templates.GenericGrid
    Protected intDAExceedStatusFlag As Integer
    ' End of code addtion by SwapnilR on 17th Feb 2005

    'Added by VivekP on 1 August 2005 For SP4 WhizibleSEM IssueID-87
    Protected strEntryDateName As String
    Protected strEmployeeName As String
    Protected intTaskDuration As Double
    Protected intDurationNew As Double
    Protected intSumDurationOld As Double
    Dim blnInitialGrid As Boolean = False
    Dim blnTaskListGridData As Boolean
    Protected strFromDateVal As String
    Protected strToDateVal As String
    Protected dateCount As Integer = 0
    Private IsFreezed As Boolean
    Private ReadyToAuthenticate As String
    Private Authenticated As String
    Private strMenu As String
    Protected ApproverName As String = ""
    Protected ReGernerateCount As Integer
    Protected GernerateCount As Integer
    Protected blnIsCheckedSatus As Boolean = False
    Public mblnDACount As Integer = 0
    'End Of Addition By VivekP On 1 August 2005 IssueID-87

    Private WithEvents objMenu As New WebPage.Templates.StaticMenu
    'added by HarshK for sp4 issueid 561
    Protected m_strOverlapValidation As String = "0"
    'End added by HarshK for sp4 issueid 561

    '' START : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
    Protected m_strToken_ViewAndGenerate As String
    Protected m_strTimeSheetNo As String
    'Added By JyotiG
    'Date : 26-Oct-2006
    'Issue ID : 7128
    'Start
    Protected m_strAuthenticatedBy As String
    Protected m_PKToken As String = ""
    'End
    '' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197 

    'added by harshada d for Whiziblesem SP7 for IssueID 4557 for DA Easy Entry on 28 Jun 2006
    '''''''Added by PrashantD for EasyEdit on 19 May 1006
    ''''''Protected blnIsWSRMenu_ON As Boolean = False
    ''''''Protected blnIsDeleteMenu_ON As Boolean = False
    ''''''Protected blnIsEditTask As Boolean = False
    'End of addition by PrashantD
    ' end of addition by harshada d for Whiziblesem SP7 for IssueID 4557 for DA Easy Entry 28 Jun 2006
    Public Sub BuildPage()
        '=====================================================================
        ' Procedure Name        : CreateGlobalObject()	
        ' Purpose               : Main procedure to build the page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 20, 2004
        ' Revisions             :
        '=====================================================================

        Call CreateGlobalObject()

        Call SetVariables()

        ' Code added by SwapnilR on 17th Feb 2005

        Dim strQueryDAExceed As String = "usp_DailyActivityCheck " & m_ProjectId.ToString

        Dim drDAExceed As IDataReader
        drDAExceed = CommonFunction.Data.GetDataReader(strQueryDAExceed, MyBase.UseSQL)
        If drDAExceed.Read Then
            intDAExceedStatusFlag = CType(drDAExceed("EntryFound"), Integer)
        End If
        CommonFunction.Data.DisposeDataReader(drDAExceed)
        strQueryDAExceed = Nothing
        ' End of code addition by SwapnilR on 17th Feb 2005

        'Added by vivekP On 2 August 2005 For SP4 WhizibleSEM IssueID-87
        Call DateValidation()
        'End Of addition On 2 August 2005 For SP4 WhizibleSEM IssueID-87

        'Added by VivekP On 2 August 2005 For SP4 WhizibleSEM  IssueID-87
        If Request.QueryString("Mode") = "Authenticate" Then
            Call AuthenticateTimeSheet()
        End If
        'End Of Addition on 2 August 2005 For SP4 WhizibleSEM






        If strMode.ToUpper <> "FREEZETIMESHEET" And strMode.ToUpper <> "REGENERATE" Then
            'End Addition by DipaliS


            'Modified By VivekP On 4 August 2005 For SP4 WhizibleSEM IssueID-87
            If strMode.ToUpper <> "GENERATE" And strMode.ToUpper <> "STILLGENERATE" Then

                'ReadyToAuthenticate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT ReadyToAuthenticate FROM tbl_PM_TimeSheetInvoice WHERE TimesheetNo=" + intTimeSheetNo.ToString, MyBase.UseSQL), ""), String)
                ReadyToAuthenticate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_TimeSheetInvoice_ReadyToAuthenticate " + intTimeSheetNo.ToString, MyBase.UseSQL), ""), String)
                GenerateTopMenu()
                Response.Write(strMenu)

                Call GeneratePageCaption()

                Call GeneratePageHeader()

                '' START : Added By ParagD On 14-Sept-2006 : Security Issue 6197  
                If intTimeSheetNo.ToString = "0" Then
                    If (Trim(m_strToken_ViewAndGenerate & "") = "" And CommonFunctions.Security.Token.ValidateToken(Session("intProjectID").ToString + m_UserId.ToString + "0" + "1049", m_strToken_ViewAndGenerate) = False) Then
                        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Project Timesheet : Generate", 1049, 0, "Timesheet No", "0")
                        'Token is Invalid now redirect to the Invalid Access Page
                        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                    End If
                ElseIf (Trim(m_strToken_ViewAndGenerate & "") = "" And CommonFunctions.Security.Token.ValidateToken(intTimeSheetNo.ToString + m_UserId.ToString + "0" + "1049", m_strToken_ViewAndGenerate) = False) Then
                    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Project Timesheet : Generate", 1049, 0, "Timesheet No", intTimeSheetNo.ToString)
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
                '' END : Added By ParagD On 14-Sept-2006 : Security Issue 6197 

            End If
            'End Of Modification By VivekP On 4 August 2005 For SP4 WhizibleSEM IssueID-87


        End If


        Select Case strMode.ToUpper

            ' Code added by SwapnilR on 17th Feb 2005
            Case "DAEXCEED"
                Call PloatDAExceedEmployeeList()
                ' End of code added by SwapnilR on 17th Feb 2005

            Case "GENERATE"
                Call CheckPendingTimesheet()
                Call GenerateTimeSheet()

                'Code added by VidyaJ on 22nd July 2004
            Case "SHOWPENDINGRESOURCES"

                Call PlotPendingVerificationResources()

            Case "STILLGENERATE"
                Call GenerateTimeSheet()
                strMode = "Generate"

            Case "SHOW"
                Call ShowTimeSheet()
            Case "DELETE"
                Call DeleteTimeSheet()
                Call ShowTimeSheet()
            Case "EDIT"
                'Modified By VivekP On 16 Sep 2005 For WhizibleSEM SP4

                Response.Write("<TABLE cellspacing=0 Width='99.9%' class=clsTable ><TR class=clsTREven><TD align=Left>Description</TD><TD Align=Left>Actual Work(hrs)</TD></TR>" & vbCrLf)
                strTask = ""

                Dim strQuery As String = "usp_Sel_tbl_PM_TimeSheet " & strTimeSheetID

                Dim drEditTimeSheet As IDataReader
                drEditTimeSheet = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)
                If drEditTimeSheet.Read Then
                    strDescription = drEditTimeSheet("Description").ToString
                    intDuration = CType(drEditTimeSheet("Duration"), Double)
                    intTaskDuration = CType(drEditTimeSheet("Duration"), Double)
                End If
                CommonFunction.Data.DisposeDataReader(drEditTimeSheet)
                strQuery = Nothing

                strQuery = "usp_sel_tbl_PM_Timesheet_DurationCheck " + strTimeSheetID + "," + intTimeSheetNo.ToString
                drEditTimeSheet = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)
                If drEditTimeSheet.Read Then
                    intSumDurationOld = CType(drEditTimeSheet("Duration"), Double)
                    strEntryDateName = CommonFunctions.Dates.GetDate(CType(drEditTimeSheet("EntryDate"), Date))
                    'Commented and Added by Chakshuta H on 8th-Aug-2016 
                    'strEmployeeName = CType(CommonFunctions.Data.GetDataScalar("SELECT EmployeeName From tbl_PM_Employee WHERE EmployeeID=" + CType(drEditTimeSheet("EmployeeID"), String), True), String)
                    strEmployeeName = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Employee_EmployeeName " + CType(drEditTimeSheet("EmployeeID"), String), True), String)
                    'End Of Commented and Added by Chakshuta H on 8th-Aug-2016 
                End If
                CommonFunction.Data.DisposeDataReader(drEditTimeSheet)
                strQuery = Nothing

                'Description Text Box
                'modified by HarshK for sp4 issueid 562
                'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'Response.Write("<TR class=clsTREven><TD widht=50%>" + CommonFunction.HTMLControls.DrawTextArea("txtTask", "txtTask", "Task Description", FormName:="frmTimeSheet", widthInPixel:=350, value:=strDescription, returnHTML:=True, IsMandatory:=True) + "</TD>")
                Response.Write("<TR class=clsTREven><TD widht=50%>" + CommonFunction.HTMLControls.DrawTextArea("txtTask", "txtTask", "Task Description", FormName:="frmTimeSheet", widthInPixel:=350, value:=strDescription, returnHTML:=True, IsMandatory:=True, EnableHTMLEncode:=True) + "</TD>")
                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'End modified by HarshK for sp4 issueid 562

                'Hours Text Box
                'Commented And Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
                'Response.Write("<TD>" + CommonFunction.HTMLControls.DrawComboBox("cboHours", "usp_sel_GetActualHrs " + CommonFunction.Application.MinHoursForDAEntry.ToString, 60, FormatNumber(intDuration, 2), , , True))
                Response.Write("<TD>" + CommonFunction.HTMLControls.DrawComboBox("cboHours", "usp_sel_GetActualHHMMHrs " + CommonFunction.Application.MinHoursForDAEntry.ToString, 60, FormatNumber(intDuration, 2), , , True))
                'End Of Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
                'End Of Modification  On 16 Sep 2005 For WhizibleSEM SP4

                Response.Write("</TABLE>" & vbCrLf)

                Response.Write("<TABLE WIDTH='99.9%'><TR class=clsTREven><TD ALIGN=CENTER><Input type = Button style='width:50px' class=ButtonStyle name=cmdSave Value=Save onclick=javascript:Save_OnClick()></TD></TR></TABLE>" + vbCrLf)

                Call ShowTimeSheet()
                'Call ShowTaskList()

            Case "SAVE"
                'Commented And Modified By JyotiG
                'Purpose : single quote get duplicated after Save Operation
                'Start
                'Dim strUpdateQuery As String = "usp_Upd_tbl_PM_TimeSheet " + strTimeSheetID + ",'" + CommonFunction.General.BuildQueryString(strTask) + "'," + intDuration.ToString
                Dim strUpdateQuery As String = "usp_Upd_tbl_PM_TimeSheet " + strTimeSheetID + ",'" + (strTask) + "'," + intDuration.ToString
                'End
                CommonFunction.Data.InsertOrUpdateData(strUpdateQuery, MyBase.UseSQL)
                strDescription = ""
                intDuration = 0

                Call ShowTimeSheet()

            Case "AUTHENTICATE"
                Call AuthenticateTimeSheet()
                Call ShowTimeSheet()

            Case "REGENERATE"

                'Code Added By DipaliS 5 Oct 2004
                'Purpose : To Reset the flag for freeze when TimeSheet is regenerated.
                Dim strSQL As String = "Usp_Upd_tbl_PM_Timesheet_IsFreezed " + intTimeSheetNo.ToString + "," + m_ProjectId.ToString + ",0"
                CommonFunction.Data.InsertOrUpdateData(strsql, MyBase.UseSQL)

                'Modified By VivekP On 9 August 2005 For WhizibleSEM Sp4 IssueID-87
                'Response.Write(GenerateTopMenu())
                Call RegenerateTimeSheet()
                'ReadyToAuthenticate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT ReadyToAuthenticate FROM tbl_PM_TimeSheetInvoice WHERE TimesheetNo=" + intTimeSheetNo.ToString, MyBase.UseSQL), ""), String)
                ReadyToAuthenticate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_TimeSheetInvoice_ReadyToAuthenticate " + intTimeSheetNo.ToString, MyBase.UseSQL), ""), String)
                GenerateTopMenu()
                Response.Write(strMenu)

                'End Of Modofication By VivekP On 9 August 2005 For WhizibleSEM Sp4 IssueID-87

                Call GeneratePageCaption()

                Call GeneratePageHeader()
                Call ShowTimeSheet()
                'End Addition by DipaliS





            Case "VIEW"
                'Modified By VivekP On 9 August 2005 For WhizibleSEM Sp4 IssueID-87
                'Response.Write(GenerateTopMenu())
                'GenerateTopMenu()
                'Response.Write(strMenu)
                'End Of Modofication By VivekP On 9 August 2005 For WhizibleSEM Sp4 IssueID-87
                Call ShowTaskList()


            Case "FMAUTHENTICATE"
                '    CommonFunction.Data.InsertOrUpdateData("usp_Upd_tbl_PM_TimeSheetInvoiceAuthenticate " + intTimeSheetNo.ToString, MyBase.UseSQL)

                '    Call ShowTimeSheet()

                '    If blnGenerateInvoice Then
                '        CommonFunction.Data.InsertOrUpdateData("usp_ins_tbl_PM_Invoice " + intTimeSheetNo.ToString, MyBase.UseSQL)
                '    End If

                '    Call SendMailToCustomer(intTimeSheetNo)

            Case "WSRENTRY"
                'Modified By VidyaJ - For IssueID - 165 - SP4
                'If Not MyBase.GetFormValue("chkWSR") Is Nothing And MyBase.GetFormValue("chkWSR") <> "" Then
                If Not MyBase.GetFormValue("chkWSR") Is Nothing Then
                    'Dim strSQL As String = "EXEC usp_Upd_tbl_PM_TimeSheet_ForWSEntry " + intTimeSheetNo.ToString + ",'" + MyBase.GetFormValue("chkWSR").ToString + "'"
                    Dim strSQL As String
                    If MyBase.GetFormValue("chkWSR") <> "" Then

                        strSQL = "UPDATE tbl_PM_TimeSheet SET WeeklyStatusEntry = 1 WHERE TimeSheetID IN(" + MyBase.GetFormValue("chkWSR") + "); Update tbl_PM_TimeSheet SET WeeklyStatusEntry=0 WHERE TimeSheetID NOT IN(" + MyBase.GetFormValue("chkWSR") + ") And TimeSheetNo=" + intTimeSheetNo.ToString

                        CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                    Else
                        'Update WeeklyStatusEntry for all tasks
                        'strSQL = "UPDATE tbl_PM_TimeSheet SET WeeklyStatusEntry = 0 WHERE  TimeSheetNo=" + intTimeSheetNo.ToString
                        strSQL = "usp_upd_tbl_PM_TimeSheetInvoice_WeeklyStatusEntry " + intTimeSheetNo.ToString
                        CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                    End If
                    strSQL = Nothing

                End If
                Call ShowTimeSheet()

                'Case "StatusChange"
                '    Dim strUpdQuery As String = "usp_Upd_tbl_PM_TimeSheet_ForStatusChange " + strTimeSheetID + ",'" + strStatus & "'"
                '    CommonFunction.Data.InsertOrUpdateData(strUpdQuery, MyBase.UseSQL)
                '    strUpdQuery = Nothing
                'Code Added By DipaliS 5 Oct 2004
                'Purpose    :   To Update the Isfreezed flag in Tbl_PM_Timesheet for given TimeSheetNo
            Case "FREEZETIMESHEET"
                Dim strSQL As String = "Usp_Upd_tbl_PM_Timesheet_IsFreezed " + intTimeSheetNo.ToString + "," + m_ProjectId.ToString
                CommonFunction.Data.InsertOrUpdateData(strsql, MyBase.UseSQL)

                'Modified By VivekP On 9 August 2005 For WhizibleSEM Sp4 IssueID-87
                'Commented and Added By Chakshuta H on 8th-Aug-2016 
                'ReadyToAuthenticate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT ReadyToAuthenticate FROM tbl_PM_TimeSheetInvoice WHERE TimesheetNo=" + intTimeSheetNo.ToString, MyBase.UseSQL), ""), String)
                ReadyToAuthenticate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_TimeSheetInvoice_ReadyToAuthenticate " + intTimeSheetNo.ToString, MyBase.UseSQL), ""), String)
                'ENd Of Commented and Added By Chakshuta H on 8th-Aug-2016 
                GenerateTopMenu()
                Response.Write(strMenu)

                'End Of Modofication By VivekP On 9 August 2005 For WhizibleSEM Sp4 IssueID-87

                Call GeneratePageCaption()

                Call ShowTimeSheet()
                'End Addition By DipaliS
            Case Else
                strDescription = ""
                intDuration = 0
        End Select




        If Not blnAllowTimesheetManipulation Then Exit Sub

        'Modified By VivekP On 9 August 2005 For WhizibleSEM Sp4 IssueID-87
        'If m_blnTimeSheetAuthenticated Then Exit Sub
        'Response.Write(GenerateBottomMenu())
        If strMode.ToUpper = "ADD_NEW" Then
            Response.Write("<DIV style='Height:400;Width:100%'></DIV>")
        End If
        'GenerateTopMenu()
        Response.Write(strMenu)
        'End Of Modofication By VivekP On 9 August 2005 For WhizibleSEM Sp4 IssueID-87




        'Initialize resource file 
        MyBase.InitializeResources("AppResources.PM_TimeSheet", "AppResources")
    End Sub

    Private Sub RegenerateTimeSheet()
        'If m_blnTimeSheetAuthenticated And m_RoleId <> CommonFunction.Constants.ROLE_FINANCE_MANAGER And m_RoleId <> CommonFunction.Constants.ROLE_CHIEF_FINANCE_OFFICER Then
        '    Response.Write("<script language=javascript>")
        '    Response.Write("alert(""Timesheet can't be re-generated as it has been authenticated"");")
        '    Response.Write("</script>")
        '    Call ShowTimeSheet()
        '    Exit Sub
        'End If

        Dim strSQL As String

        'Code added by DipaliS 14 Oct 2004
        'Remove the entries from the intermediate table for site calendar
        'Commented and Added by Chakshuta H on 8th-Aug-2016 
        'strSQL = "DELETE FROM tbl_PM_SiteCal_Intermediate WHERE TimeSheetNo=" + intTimeSheetNo.ToString
        strSQL = "usp_del_tbl_PM_SiteCal_Intermediate_TimeSheetNo " + intTimeSheetNo.ToString
        'End Of Commented and Added by Chakshuta H on 8th-Aug-2016 
        CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
        'End addition by DipalIS

        'Modified By VivekP VivekP On 12 Aug 2005 IssueID-87
        Dim stremployeename As String
        'Commented and Added by Chakshuta H on 8th-Aug-2016 
        'stremployeename = CType(CommonFunctions.Data.GetDataScalar("SELECT EmployeeName FROM tbl_PM_Employee WHERE EmployeeID=" + CType(Session("intUserID"), String), True), String)
        stremployeename = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Employee_EmployeeName " + CType(Session("intUserID"), String), True), String)
        'ENd Of Commented and Added by Chakshuta H on 8th-Aug-2016 

        'Modified By nitinVS on 16 Apr 2007 for WhizibleSEM SP 8 regression Issue 13026 
        'Commented and Added by Chakshuta H on 8th-Aug-2016 
        'GernerateCount = CType(CommonFunction.Data.GetDataScalar("SELECT Count(TimesheetID) FROM tbl_PM_TimeSheet WHERE TimeSheetNo=" + intTimeSheetNo.ToString, MyBase.UseSQL), Integer)
        GernerateCount = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_TimeSheet_TimesheetID " + intTimeSheetNo.ToString, MyBase.UseSQL), Integer)
        'End Of Commented and Added by Chakshuta H on 8th-Aug-2016 
        strSQL = "usp_ReGenerateTimeSheet '" + strFromDate + "'," + "'" + strToDate + "'," + m_ProjectId.ToString + "," + intTimeSheetNo.ToString + ",'" + CommonFunction.General.BuildQueryString(stremployeename) + "'"
        'End Of Modification By VivekP VivekP On 12 Aug 2005 IssueID-87
        'Modified By nitinVS on 16 Apr 2007 for WhizibleSEM SP 8 regression Issue 13026 
        If blnSubProjectLevelInvoiceing Then
            If intSubProjectID <> 0 Then
                strSQL = strSQL + "," + intSubProjectID.ToString
            End If
        End If

        Dim drTimeSheet As IDataReader
        drTimeSheet = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        'Get newly generated timesheet number
        If drTimeSheet.Read Then
            intTimeSheetNo = CType(drTimeSheet("TimeSheetNo"), Integer)
        End If

        CommonFunction.Data.DisposeDataReader(drTimeSheet)

        'Added By VivekP On 12 August 2005 For WhizibleSEM SP4 IssueID-87
        'Commented and Added by Chakshuta H on 8th-Aug-2016 
        'ReGernerateCount = CType(CommonFunction.Data.GetDataScalar("SELECT Count(TimesheetID) FROM tbl_PM_TimeSheet WHERE TimeSheetNo=" + intTimeSheetNo.ToString, MyBase.UseSQL), Integer)
        ReGernerateCount = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_TimeSheet_TimesheetID " + intTimeSheetNo.ToString, MyBase.UseSQL), Integer)
        'End Of Commented and Added by Chakshuta H on 8th-Aug-2016 
        Dim extraTask As Integer = ReGernerateCount - GernerateCount
        If (extraTask > 0) Then
            Response.Write("<script language='javascript'>")
            Response.Write("alert('" + extraTask.ToString + " more tasks will be added in the timesheet.')")
            Response.Write("</script>")
        End If
        'End OF Addition By VivekP On 12 August 2005 For WhizibleSEM SP4 IssueID-87

        'Show newly generted timesheet
        'Call ShowTimeSheet()

    End Sub

    Private Sub AuthenticateTimeSheet()
        '=====================================================================
        ' Procedure Name        : AuthenticateTimeSheet()	
        ' Purpose               : to authenticate specified timesheet
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 20, 2004
        ' Revisions             :
        '=====================================================================

        'Added by DipaliS 14 Oct 2004
        'Purpose    :   Add the entries to Resource TimeSheet Details if there is no entry
        Dim strSQLTM As String
        Dim drRT As IDataReader
        'Commented and Added by Chakshuta H on 8th-Aug-2016 
        'strSQLTM = "Delete from tbl_PM_SiteResourceTimesheet where TimeSheetID=" + CType(intTimeSheetNo, String)
        strSQLTM = "usp_del_tbl_PM_SiteResourceTimesheet_TimeSheetID " + CType(intTimeSheetNo, String)
        'End Of Commented and Added by Chakshuta H on 8th-Aug-2016 
        CommonFunction.Data.InsertOrUpdateData(strSQLTM, MyBase.UseSQL)

        'Check if Enries are there in the Site Resource TimeSheet
        'Commented and Added by Chakshuta H on 8th-Aug-2016 
        'strSQLTM = "Select * from tbl_PM_SiteResourceTimesheet where TimeSheetID=" + CType(intTimeSheetNo, String)
        strSQLTM = "usp_sel_tbl_PM_SiteResourceTimesheet_TimeSheetID " + CType(intTimeSheetNo, String)
        'End Of Commented and Added by Chakshuta H on 8th-Aug-2016 
        drRT = CommonFunction.Data.GetDataReader(strSQLTM, MyBase.UseSQL)
        'If no record then insert all the entries
        If Not drRT.Read Then
            strSQLTM = "Exec usp_Sel_GetSiteResourceTimesheet " + CType(m_ProjectId, String) + "," + CType(intTimeSheetNo, String)
            drRT = CommonFunction.Data.GetDataReader(strSQLTM, MyBase.UseSQL)
            While drRT.Read
                'Modified By nitinVS on 16 Apr 2007 for WhizibleSEM SP 8 regression Issue 13026 
                ' Handled single quote in employeeName 
                'Commented and Modified By JyotiG
                'Start_JG_12775_10-Apr-2007
                'strSQLTM = "usp_Ins_tbl_PM_SiteResourceTimesheet " + CType(intTimeSheetNo, String) + "," + CType(CommonFunction.Data.CheckIsDBNull(drRT("SiteID")), String) + ",'" + CType(CommonFunction.Data.CheckIsDBNull(drRT("Name")), String) + "'," + CType(CommonFunction.Data.CheckIsDBNull(drRT("EmployeeID")), String) + ",'" + CType(CommonFunction.Data.CheckIsDBNull(drRT("EmployeeName")), String) + "','" + CType(CommonFunction.Data.CheckIsDBNull(drRT("Date")), String) + "'," + CType(CommonFunction.Data.CheckIsDBNull(drRT("NormalHours")), String) + "," + CType(CommonFunction.Data.CheckIsDBNull(drRT("ExtraHours")), String) + "," + CType(CommonFunction.Data.CheckIsDBNull(drRT("NonBillableHours")), String)
                strSQLTM = "usp_Ins_tbl_PM_SiteResourceTimesheet " + CType(intTimeSheetNo, String) + "," + CType(CommonFunction.Data.CheckIsDBNull(drRT("SiteID")), String) + ",'" + CommonFunction.General.BuildQueryString(CType(CommonFunction.Data.CheckIsDBNull(drRT("Name")), String)) + "'," + CType(CommonFunction.Data.CheckIsDBNull(drRT("EmployeeID")), String) + ",'" + CommonFunction.General.BuildQueryString(CType(CommonFunction.Data.CheckIsDBNull(drRT("EmployeeName")), String)) + "','" + CType(CommonFunction.Data.CheckIsDBNull(drRT("Date")), String) + "'," + CType(CommonFunction.Data.CheckIsDBNull(drRT("NormalHours")), String) + "," + CType(CommonFunction.Data.CheckIsDBNull(drRT("ExtraHours")), String) + "," + CType(CommonFunction.Data.CheckIsDBNull(drRT("NonBillableHours")), String)
                'End_JG_12775_10-Apr-2007
                'End Modification By NitinVS on 16 Apr 2007 for WhizibleSEM SP 8 regression Issue 13026 

                CommonFunction.Data.InsertOrUpdateData(strSQLTM, MyBase.UseSQL)
            End While
            CommonFunction.Data.DisposeDataReader(drRT)
        End If

        CommonFunction.Data.DisposeDataReader(drRT)

        ''Added by PrashantSJ on 11th Dec 2008 : 
        ''Purpose: To updat the accrued site resource timesheet data for project profitability
        strSQLTM = "Exec usp_Sel_AccruedGetSiteResourceTimesheet " + CType(intTimeSheetNo, String)
        CommonFunction.Data.InsertOrUpdateData(strSQLTM, MyBase.UseSQL)
        ''End of addition byu PrashantSJ on 11th Dec 2008

        'End addition by DipaliS

        Dim strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage As String
        Dim drTimeSheet As IDataReader
        'Modified  By VivekP On 2 August 2005 For WhizibleSEm SP4 IssueID-87
        Dim strEmployeeName As String
        'Dim drTSAuthenticatedBy As IDataReader
        'drTSAuthenticatedBy = CommonFunction.Data.GetDataReader("EXEC usp_Sel_TimeSheetAuthenticationType " + intTimeSheetNo.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        ' If drTSAuthenticatedBy.Read Then

        'If drTSAuthenticatedBy("AuthenticatedBy").ToString = "C" Then
        'strEmployeeName = CType(CommonFunctions.Data.GetDataScalar("SELECT CustomerName FROM tbl_PM_Customer WHERE Customer=(SELECT CustomerID FROM tbl_PM_Project WHERE ProjectID=(SELECT ProjectID FROM tbl_PM_TimesheetInvoice WHERE TimesheetNo=" + CType(intTimeSheetNo, String) + "))", True), String)
        'Else
        'Commented and Added by Chakshuta H on 8th-Aug-2016 
        'strEmployeeName = CType(CommonFunctions.Data.GetDataScalar("SELECT EmployeeName FROM tbl_PM_Employee WHERE EmployeeID=" + CType(Session("intUserID"), String), True), String)
        strEmployeeName = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Employee_EmployeeName " + CType(Session("intUserID"), String), True), String)
        'End of Commented and Added by Chakshuta H on 8th-Aug-2016 
        'End If

        ' End If
        ' CommonFunctions.Data.DisposeDataReader(drTSAuthenticatedBy)

        'Modified By nitinVS on 16 Apr 2007 for WhizibleSEM SP 8 regression Issue 13026 
        Dim strUpdateQuery As String = "usp_upd_tbl_PM_TimeSheetInvoice_ForReadyToAuthenticate " + intTimeSheetNo.ToString + ",'" + CommonFunction.General.BuildQueryString(strEmployeeName) + "'"
        'End Modified By nitinVS on 16 Apr 2007 for WhizibleSEM SP 8 regression Issue 13026 

        CommonFunction.Data.InsertOrUpdateData(strUpdateQuery, MyBase.UseSQL)

        strDescription = ""
        intDuration = 0

        Dim strSQL As String = "EXEC usp_Sel_TimeSheetForGivenTimeSheetNo " + intTimeSheetNo.ToString
        drTimeSheet = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        If drTimeSheet.Read Then
            If blnSendEmail = True And blnShowPopup = False Then
                Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_3(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, intTimeSheetNo)
                Call CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
            End If
        End If

        blnAuthenticateFlag = True
        CommonFunctions.Data.DisposeDataReader(drTimeSheet)
        'End Of addition on 2 August 2005 For WhizibleSEm SP4

    End Sub

    Private Sub DeleteTimeSheet()
        '=====================================================================
        ' Procedure Name        : DeleteTimeSheet()	
        ' Purpose               : to delete specified timesheet
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 25, 2004
        ' Revisions             :
        '=====================================================================

        If MyBase.GetFormValue("chkDelete") Is Nothing Or MyBase.GetFormValue("chkDelete") = "" Then Exit Sub
        Dim TimeSheetIDs() As String, strDeleteQuery As String, inti As Integer
        TimeSheetIDs = Split(MyBase.GetFormValue("chkDelete"), ",")

        For inti = 0 To TimeSheetIDs.Length - 1
            strTimeSheetID = TimeSheetIDs(inti)
            strDeleteQuery = "usp_Del_tbl_PM_TimeSheet_ForTimeSheetID " & strTimeSheetID
            CommonFunction.Data.InsertOrUpdateData(strDeleteQuery, MyBase.UseSQL)
        Next

        strDescription = ""
        intDuration = 0
    End Sub

    Private Function GenerateBottomMenu() As String
        '=====================================================================
        ' function Name         : GenerateBottomMenu()	
        ' Purpose               : To generate bottom menu
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 23, 2004
        ' Revisions             :
        '=====================================================================

        Dim ArrTopMenuCaptionsList As New ArrayList
        Dim ArrTopMenuToolTipsList As New ArrayList
        Dim ArrTopMenuFunctionsList As New ArrayList

        'Added By VivekP On 5 August 2005 For WhizibleSEM SP4 IssueID-87
        'Commented and Added by Chakshuta H on 8th-Aug-2016 
        'IsFreezed = CType(CommonFunctions.Data.GetDataScalar("SELECT IsFreezed FROM Tbl_PM_TimeSheet WHERE TimesheetNo=" + intTimeSheetNo.ToString, MyBase.UseSQL), Boolean)
        IsFreezed = CType(CommonFunctions.Data.GetDataScalar("usp_sel_Tbl_PM_TimeSheet_IsFreezed " + intTimeSheetNo.ToString, MyBase.UseSQL), Boolean)

        'ReadyToAuthenticate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT ReadyToAuthenticate FROM tbl_PM_TimeSheetInvoice WHERE TimesheetNo=" + intTimeSheetNo.ToString, MyBase.UseSQL), ""), String)
        ReadyToAuthenticate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_TimeSheetInvoice_ReadyToAuthenticate " + intTimeSheetNo.ToString, MyBase.UseSQL), ""), String)
        'Authenticated = CType(CommonFunctions.Data.GetDataScalar("SELECT Authenticated FROM tbl_PM_TimeSheetInvoice WHERE TimesheetNo=" + intTimeSheetNo.ToString, MyBase.UseSQL), String)
        Authenticated = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_TimeSheetInvoice_Authenticated " + intTimeSheetNo.ToString, MyBase.UseSQL), String)
        'End Of Commented and Added by Chakshuta H on 8th-Aug-2016 
        'End Of addition By VivekP On 5 August For WhizibleSEM SP4 IssueID-87



        'hide the menu
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        'If strMode.ToUpper = "GENERATE" Or strMode.ToUpper = "SHOW" Or strMode.ToUpper = "WSRENTRY" Or strMode.ToUpper = "SAVE" Or strMode.ToUpper = "EDIT" Then

        'Code added by SwapnilR on 17th Feb 2005
        If strMode.ToUpper = "DAEXCEED" Then
            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_BACK"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_BACK_TOOLTIP"))
            ArrTopMenuFunctionsList.Add("Back_OnClick()")


            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
            ArrTopMenuFunctionsList.Add("Help_OnClick('TS')")
            ' End of code addition by SwapnilR on 17th Feb 2005

        ElseIf strMode.ToUpper <> "VIEW" And strMode.ToUpper <> "ADD_NEW" And strMode.ToUpper <> "SHOWPENDINGRESOURCES" Then

            'Initialize resource file 

            If m_blnEditAccess = True Then
                'Select all
                ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SELECTALL"))
                ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SELECTALL_TOOLTIP"))
                ArrTopMenuFunctionsList.Add("SelectAll_OnClick('frmTimeSheet', 'chkWSR')")

                'Clear
                ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLEARALL"))
                ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLEARALL_TOOLTIP"))
                ArrTopMenuFunctionsList.Add("ClearAll_OnClick('frmTimeSheet', 'chkWSR')")

            End If

            'Initialize resource file 
            MyBase.InitializeResources("AppResources.PM_TimeSheet", "AppResources")
            If m_blnEditAccess = True Then
                'Update WSR
                ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_UPDATEWSR"))
                ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_UPDATEWSR_TOOLTIP"))
                ArrTopMenuFunctionsList.Add("UpdateWSR()")
            End If
            ''WSR Attachment
            'ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_WSRATTACHMENT"))
            'ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_WSRATTACHMENT_TOOLTIP"))
            'ArrTopMenuFunctionsList.Add("WSRAttachment_OnClick()")


            'Initialize resource file 
            MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

            'Delete
            If m_blnEditAccess = True Then
                ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_DELETE"))
                ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DELETE_TOOLTIP"))
                ArrTopMenuFunctionsList.Add("Delete_OnClick()")
            End If
            'Initialize resource file 
            MyBase.InitializeResources("AppResources.PM_TimeSheet", "AppResources")

            'Re-Generate
            If m_blnEditAccess = True Then
                ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_REGENERATE"))
                ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_REGENERATE_TOOLTIP"))
                ArrTopMenuFunctionsList.Add("ReGenerate_OnClick()")
            End If

            'Modified By VivekP On 5 August 2005 For WhizibleSEM Sp4 IssueID-87
            If ReadyToAuthenticate <> "Y" And Authenticated <> "R" Then
                'Authenticate
                If m_blnEditAccess = True Then
                    ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_AUTHENTICATE"))
                    ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_AUTHENTICATE_TOOLTIP"))
                    ArrTopMenuFunctionsList.Add("Authenticate_OnClick()")
                End If
            End If
            'End Of Modification By VivekP On 5 August 2005 For WhizibleSEM SP4 IssueID-87

            'generate WSR
            If m_blnEditAccess = True Then
                ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_WSR"))
                ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_WSR_TOOLTIP"))
                ArrTopMenuFunctionsList.Add("GenerateWSR()")
            End If

        ElseIf strMode.ToUpper = "VIEW" Or strMode.ToUpper = "ADD_NEW" Or strMode.ToUpper = "SHOWPENDINGRESOURCES" Then

            If strMode.ToUpper = "ADD_NEW" Then
                Response.Write("<DIV style='Height:450;Width:100%'></DIV>")
            End If

            'Commented and Added by Chakshuta H on 8th-Aug-2016 
            'ReadyToAuthenticate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT ReadyToAuthenticate FROM tbl_PM_TimeSheetInvoice WHERE TimesheetNo=" + intTimeSheetNo.ToString, MyBase.UseSQL), ""), String)
            ReadyToAuthenticate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_TimeSheetInvoice_ReadyToAuthenticate " + intTimeSheetNo.ToString, MyBase.UseSQL), ""), String)
            'End Of Commented and Added by Chakshuta H on 8th-Aug-2016 
            Return (GenerateTopMenu())
        End If

        Dim ArrTopMenuCaptions(ArrTopMenuCaptionsList.Count - 1) As String
        ArrTopMenuCaptionsList.ToArray.CopyTo(ArrTopMenuCaptions, 0)
        ArrTopMenuCaptionsList = Nothing

        Dim ArrTopMenuToolTips(ArrTopMenuToolTipsList.Count - 1) As String
        ArrTopMenuToolTipsList.ToArray.CopyTo(ArrTopMenuToolTips, 0)
        ArrTopMenuToolTipsList = Nothing

        Dim ArrTopMenuFunctions(ArrTopMenuFunctionsList.Count - 1) As String
        ArrTopMenuFunctionsList.ToArray.CopyTo(ArrTopMenuFunctions, 0)
        ArrTopMenuFunctionsList = Nothing

        'Generate menu string and return
        'SMR
        Return objMenu.DrawMenuWithEvents(ArrTopMenuCaptions, ArrTopMenuFunctions, ArrTopMenuToolTips, True)
        'Return "<BR>" + objMenu.DrawMenuWithEvents(ArrTopMenuCaptions, ArrTopMenuFunctions, ArrTopMenuToolTips, True)
        'Return "<BR>" + WebPage.Templates.StaticMenu.DrawMenu(ArrTopMenuCaptions, ArrTopMenuFunctions, ArrTopMenuToolTips, True)
        objMenu = Nothing

    End Function

    Private Function GenerateTopMenu() As String
        '=====================================================================
        ' function Name         : GenerateTopMenu()	
        ' Purpose               : To generate top menu
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 23, 2004
        ' Revisions             :
        '=====================================================================


        Dim ArrTopMenuCaptionsList As New ArrayList
        Dim ArrTopMenuToolTipsList As New ArrayList
        Dim ArrTopMenuFunctionsList As New ArrayList




        'Added By VivekP On 5 August 2005 For WhizibleSEM SP4 IssueID-87
        '=================================================================================================
        'Commented and Added by Chakshuta H on 8th-Aug-2016 
        'IsFreezed = CType(CommonFunctions.Data.GetDataScalar("SELECT IsFreezed FROM Tbl_PM_TimeSheet WHERE TimesheetNo=" + intTimeSheetNo.ToString, MyBase.UseSQL), Boolean)
        'ReadyToAuthenticate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT ReadyToAuthenticate FROM tbl_PM_TimeSheetInvoice WHERE TimesheetNo=" + intTimeSheetNo.ToString, MyBase.UseSQL), ""), String)
        'Authenticated = CType(CommonFunctions.Data.GetDataScalar("SELECT Authenticated FROM tbl_PM_TimeSheetInvoice WHERE TimesheetNo=" + intTimeSheetNo.ToString, MyBase.UseSQL), String)
        IsFreezed = CType(CommonFunctions.Data.GetDataScalar("usp_sel_Tbl_PM_TimeSheet_IsFreezed " + intTimeSheetNo.ToString, MyBase.UseSQL), Boolean)
        ReadyToAuthenticate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_TimeSheetInvoice_ReadyToAuthenticate " + intTimeSheetNo.ToString, MyBase.UseSQL), ""), String)
        Authenticated = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_TimeSheetInvoice_Authenticated " + intTimeSheetNo.ToString, MyBase.UseSQL), String)

        'End Of Commented and Added by Chakshuta H on 8th-Aug-2016 


        If Not m_blnTimeSheetAuthenticated Then
            'hide the menu
            MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
            'If strMode.ToUpper = "GENERATE" Or strMode.ToUpper = "SHOW" Or strMode.ToUpper = "WSRENTRY" Or strMode.ToUpper = "SAVE" Or strMode.ToUpper = "EDIT" Then

            'Code added by SwapnilR on 17th Feb 2005
            If strMode.ToUpper = "DAEXCEED" Then
                ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_BACK"))
                ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_BACK_TOOLTIP"))
                ArrTopMenuFunctionsList.Add("Back_OnClick()")


                ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
                ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
                ArrTopMenuFunctionsList.Add("Help_OnClick('TS')")
                ' End of code addition by SwapnilR on 17th Feb 2005

            ElseIf strMode.ToUpper <> "VIEW" And strMode.ToUpper <> "ADD_NEW" And strMode.ToUpper <> "SHOWPENDINGRESOURCES" Then

                'Initialize resource file 


                'Select all
                'ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SELECTALL"))
                'ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SELECTALL_TOOLTIP"))
                'ArrTopMenuFunctionsList.Add("SelectAll_OnClick('frmTimeSheet', 'chkWSR')")

                ''Clear
                'ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLEARALL"))
                'ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLEARALL_TOOLTIP"))
                'ArrTopMenuFunctionsList.Add("ClearAll_OnClick('frmTimeSheet', 'chkWSR')")

                'Initialize resource file 
                MyBase.InitializeResources("AppResources.PM_TimeSheet", "AppResources")

                ' added by harshada d for Whiziblesem SP7 for IssueID 4557 for DA Easy Entry on 28 Jun 2006
                'Added by PrashantD for EasyEdit
                'Added By JyotiG
                'Start_JG_11765_21-Mar-2007
                If m_blnEditAccess = True Then
                    ArrTopMenuCaptionsList.Add("Easy Edit")
                    ArrTopMenuToolTipsList.Add("Easy Edit")
                    ArrTopMenuFunctionsList.Add("EasyEdit_onClick()")
                End If
                'End_JG_11765_21-Mar-2007
                'End of addition
                ' end of addition by harshada d for Whiziblesem SP7 for IssueID 4557 for DA Easy Entry 28 Jun 2006

                'Update WSR
                If m_blnEditAccess = True Then
                    ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_UPDATEWSR"))
                    ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_UPDATEWSR_TOOLTIP"))
                    ArrTopMenuFunctionsList.Add("UpdateWSR()")
                End If
                ''WSR Attachment
                'ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_WSRATTACHMENT"))
                'ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_WSRATTACHMENT_TOOLTIP"))
                'ArrTopMenuFunctionsList.Add("WSRAttachment_OnClick()")


                ''Initialize resource file 
                'MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                ''Delete
                'ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_DELETE"))
                'ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DELETE_TOOLTIP"))
                'ArrTopMenuFunctionsList.Add("Delete_OnClick()")

                'Initialize resource file 
                MyBase.InitializeResources("AppResources.PM_TimeSheet", "AppResources")

                'Re-Generate
                If m_blnEditAccess = True Then
                    ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_REGENERATE"))
                    ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_REGENERATE_TOOLTIP"))
                    ArrTopMenuFunctionsList.Add("ReGenerate_OnClick()")
                End If

                'Modified By VivekP On 5 August 2005 For WhizibleSEM Sp4 IssueID-87
                If ReadyToAuthenticate <> "Y" Then
                    'If Request.QueryString("Mode") = "Authenticate" Then
                    'Authenticate
                    If m_blnEditAccess = True Then
                        ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_AUTHENTICATE"))
                        ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_AUTHENTICATE_TOOLTIP"))
                        ArrTopMenuFunctionsList.Add("Authenticate_OnClick()")
                    End If
                    'End If
                End If
                'End Of Modification By VivekP On 5 August 2005 For WhizibleSEM SP4 IssueID-87

                'generate WSR
                If m_blnEditAccess = True Then
                    ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_WSR"))
                    ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_WSR_TOOLTIP"))
                    ArrTopMenuFunctionsList.Add("GenerateWSR()")
                End If


            End If
        End If
        'End Of addition By VivekP On 5 August For WhizibleSEM SP4 IssueID-87
        '==================================================================================================



        'Initialize resource file 
        MyBase.InitializeResources("AppResources.PM_TimeSheet", "AppResources")

        ' Code added by SwapnilR on 17th Feb 2005
        If strMode.ToUpper <> "DAEXCEED" Then
            ' End of code addition by SwapnilR on 17th Feb 2005


            'Added the Add Condition by DipaliS 7 Oct 2004
            'Purpose : the Generate link is visible even after timesheet is generated
            If strMode.ToUpper <> "SHOW" And strMode.ToUpper <> "WSRENTRY" And strMode.ToUpper <> "AUTHENTICATE" And strMode.ToUpper <> "SHOWPENDINGRESOURCES" And strMode.ToUpper <> "STILLGENERATE" And strMode.ToUpper <> "FREEZETIMESHEET" And strMode.ToUpper <> "REGENERATE" Then
                'Added By VivekP On 5 August 2005 For WhizibleSEM SP4 IssueID-87
                If Request.QueryString("TimeSheetNo") = "" Then
                    ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_GENERATETIMESHEET"))
                    ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_GENERATETIMESHEET_TOOLTIP"))
                    ArrTopMenuFunctionsList.Add("Generate_OnClick('" & strFromDate & "','" & strToDate & "')")
                End If
                If Request.QueryString("TimeSheetNo") = "0" Then
                    ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_GENERATETIMESHEET"))
                    ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_GENERATETIMESHEET_TOOLTIP"))
                    ArrTopMenuFunctionsList.Add("Generate_OnClick('" & strFromDate & "','" & strToDate & "')")
                End If
                'End Of Modification By VivekP On 5 August 2005 For WhizibleSEM SP4 IssueID-87


            End If

            'Code Added By VidyaJ on 22nd July 2004
            'The AND Condition added by DipaliS 
            If strMode.ToUpper = "SHOWPENDINGRESOURCES" And strMode.ToUpper <> "STILLGENERATE" And strMode.ToUpper <> "FREEZETIMESHEET" And strMode.ToUpper <> "REGENERATE" Then
                ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_GENERATETIMESHEET"))
                ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_GENERATETIMESHEET_TOOLTIP"))
                ArrTopMenuFunctionsList.Add("StillGenerate_OnClick('" & strFromDate & "','" & strToDate & "')")
            End If

            If m_blnTImeSheetReadyForAuthentication And Not m_blnTimeSheetAuthenticated Then
                ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SENDMAIL"))
                ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SENDMAIL_TOOLTIP"))
                ArrTopMenuFunctionsList.Add("SendMail_OnClick()")
            End If

            If (strMode.ToUpper <> "SHOWPENDINGRESOURCES" And CType(Request.QueryString("TimesheetNo"), Integer) = 0) Then
                ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_VIEWTASKLIST"))
                ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_VIEWTASKLIST_TOOLTIP"))
                ArrTopMenuFunctionsList.Add("View_OnClick()")
            End If

            If strMode.ToUpper = "STILLGENERATE" Or strMode.ToUpper = "VIEW" Or CType(Request.QueryString("TimesheetNo"), String) <> "" Then

                'Freeze Project Timesheet
                'TO DO: Get strings from resources
                'Added By DipaliS 5 Oct 2004
                'Purpose    :   To Toggle the links depenging upon the flag for IsFreezed
                Dim strSQLSite As String
                Dim blnShow As Boolean = False
                'Commented and Added by Chakshuta H on 8th-Aug-2016 
                'strSQLSite = "Select Top 1 IsNull(IsFreezed,0) From Tbl_PM_TimeSheet Where TimeSheetNo=" + intTimeSheetNo.ToString
                strSQLSite = "usp_sel_Tbl_PM_TimeSheet_IsFreezed_TimeSheetNo " + intTimeSheetNo.ToString
                'End Of Commented and Added by Chakshuta H on 8th-Aug-2016 
                blnShow = CType(CommonFunction.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQLSite, MyBase.UseSQL), "0"), Boolean)
                'End Addition by DipaliS

                'Code Added by DipaliS 5 Oct 2004
                'Purpose: Show only when the timesheet is not freezed
                If blnShow = False And strMode.ToUpper <> "FREEZETIMESHEET" Then
                    'End Addition by DipaliS

                    ArrTopMenuCaptionsList.Add("Freeze Timesheet")
                    ArrTopMenuToolTipsList.Add("Freeze Timesheet")
                    ArrTopMenuFunctionsList.Add("FreezeProjectTimesheet()")

                End If


                'View Site Calendar
                'TO DO: Get strings from resources
                ArrTopMenuCaptionsList.Add("View Site Calendar")
                ArrTopMenuToolTipsList.Add("View Site Calendar")
                'Code Commented By DipaliS 5 Oct 2004 and added the following
                'ArrTopMenuFunctionsList.Add("ViewSiteCalendar()")

                ArrTopMenuFunctionsList.Add("ViewSiteCalendar(" + CType(strFromDate, Date).Year.ToString + "," + CType(strFromDate, Date).Month.ToString + ")")

                'End Addition by DipaliS


                'Update resource efforts
                'TO DO: Update resource efforts

                'Code Added by DipaliS 5 Oct 2004
                'Purpose: Show only when the timesheet is freezed
                If blnShow = True Then
                    'End Addition by DipaliS

                    ArrTopMenuCaptionsList.Add("Update Resource Efforts")
                    ArrTopMenuToolTipsList.Add("Update Resource Efforts")
                    ArrTopMenuFunctionsList.Add("UpdateResourceEfforts()")


                    'Code Added by DipaliS
                End If
                'End Addition by DipaliS



            End If
            ' Code added by SwapnilR on 17th Feb 2005
        End If
        ' End of code addition by SwapnilR on 17th Feb 2005




        If Not m_blnTimeSheetAuthenticated Then
            'hide the menu
            MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
            'If strMode.ToUpper = "GENERATE" Or strMode.ToUpper = "SHOW" Or strMode.ToUpper = "WSRENTRY" Or strMode.ToUpper = "SAVE" Or strMode.ToUpper = "EDIT" Then

            'Code added by SwapnilR on 17th Feb 2005
            If strMode.ToUpper = "DAEXCEED" Then

            ElseIf strMode.ToUpper <> "VIEW" And strMode.ToUpper <> "ADD_NEW" And strMode.ToUpper <> "SHOWPENDINGRESOURCES" Then
                'Delete
                If m_blnEditAccess = True Then
                    ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_DELETE"))
                    ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DELETE_TOOLTIP"))
                    ArrTopMenuFunctionsList.Add("Delete_OnClick()")
                    'Initialize resource file 
                End If
                If m_blnEditAccess = True Then
                    'Select all
                    ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SELECTALL"))
                    ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SELECTALL_TOOLTIP"))
                    ArrTopMenuFunctionsList.Add("SelectAll_OnClick('frmTimeSheet', 'chkWSR')")
                    'Clear
                    ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLEARALL"))
                    ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLEARALL_TOOLTIP"))
                    ArrTopMenuFunctionsList.Add("ClearAll_OnClick('frmTimeSheet', 'chkWSR')")
                End If
            End If
        End If


        'Initialize resource file 
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        'Show History
        If intTimeSheetNo > 0 Then
            ArrTopMenuCaptionsList.Add("Show History")
            ArrTopMenuToolTipsList.Add("Show History")
            ArrTopMenuFunctionsList.Add("ShowHistory_OnClick()")
        End If

        ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_BACK"))
        ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_BACK_TOOLTIP"))
        ArrTopMenuFunctionsList.Add("Back_OnClick()")


        ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        ArrTopMenuFunctionsList.Add("Help_OnClick('TS')")


        Dim ArrTopMenuCaptions(ArrTopMenuCaptionsList.Count - 1) As String
        ArrTopMenuCaptionsList.ToArray.CopyTo(ArrTopMenuCaptions, 0)
        ArrTopMenuCaptionsList = Nothing

        Dim ArrTopMenuToolTips(ArrTopMenuToolTipsList.Count - 1) As String
        ArrTopMenuToolTipsList.ToArray.CopyTo(ArrTopMenuToolTips, 0)
        ArrTopMenuToolTipsList = Nothing

        Dim ArrTopMenuFunctions(ArrTopMenuFunctionsList.Count - 1) As String
        ArrTopMenuFunctionsList.ToArray.CopyTo(ArrTopMenuFunctions, 0)
        ArrTopMenuFunctionsList = Nothing

        'Generate menu string and return
        'Return WebPage.Templates.StaticMenu.DrawMenu(ArrTopMenuCaptions, ArrTopMenuFunctions, ArrTopMenuToolTips, True) + "<TABLE CellSpacing=0 width='100%' height = '10' class=clsTable><TR class=clsTRBlank><TD><TD></TR></TABLE>"
        'Return 
        'Added By Vidya J on 17-11-2015
        ' strMenu = objMenu.DrawMenuWithEvents(ArrTopMenuCaptions, ArrTopMenuFunctions, ArrTopMenuToolTips, True) + "<TABLE CellSpacing=0 width='99.9%' height = '10' class=clsTable><TR class=clsTRBlank><TD><TD></TR></TABLE>"
        strMenu = objMenu.DrawMenuWithEvents(ArrTopMenuCaptions, ArrTopMenuFunctions, ArrTopMenuToolTips, True) + "<TABLE CellSpacing=0 width='99.9%' height = '0' class=clsTable><TR class=clsTRBlank><TD><TD></TR></TABLE>"
        'End of Added By Vidya J on 17-11-2015
        'objMenu = Nothing

    End Function

    Private Sub GeneratePageHeader()
        '=====================================================================
        ' Procedure Name        : GeneratePageHeader()	
        ' Purpose               : to generate page header
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 23, 2004
        ' Revisions             :
        '=====================================================================
        'Initialize resource file 
        Dim strHTML As String
        MyBase.InitializeResources("AppResources.PM_TimeSheet", "AppResources")

        Dim objHeader As New WebPage.Templates.HeaderFooter

        'Code modified by VidyaJ on 22nd July 2004
        If strMode.ToUpper = "SHOWPENDINGRESOURCES" Then
            'RESOURCE
            strHTML = MyBase.GetResourceString("PENDING_MESSAGE") + " <BR> " + MyBase.GetResourceString("FROMDATE") + " : " + strFromDate + " &nbsp;&nbsp;&nbsp;" + MyBase.GetResourceString("TODATE") + ":" + strToDate
            objHeader.HeaderFooter = strHTML 'MyBase.GetResourceString("PAGEHEADER") + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + MyBase.GetResourceString("FROMDATE") + "&nbsp;" + CommonFunction.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , , CommonFunction.Dates.GetDate(CType(strFromDate, Date)), formname:="frmTimeSheet", returnHTML:=True) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + MyBase.GetResourceString("TODATE") + "&nbsp;" + CommonFunction.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , CommonFunction.Dates.GetDate(CType(strToDate, Date)), formname:="frmTimeSheet", returnHTML:=True)
        Else
            'Added By VivekP On 16 Sep 2005 For WhizibleSEM SP4
            If CType(intTimeSheetNo, String) = "0" Then
                objHeader.HeaderFooter = MyBase.GetResourceString("PAGEHEADER") + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + MyBase.GetResourceString("FROMDATE") + "&nbsp;" + CommonFunction.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , , CommonFunction.Dates.GetDate(CType(strFromDate, Date)), formname:="frmTimeSheet", returnHTML:=True) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + MyBase.GetResourceString("TODATE") + "&nbsp;" + CommonFunction.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , CommonFunction.Dates.GetDate(CType(strToDate, Date)), formname:="frmTimeSheet", returnHTML:=True)
            Else
                objHeader.HeaderFooter = "Project Timesheet for the period&nbsp;:&nbsp;" + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + MyBase.GetResourceString("FROMDATE") + "&nbsp;:&nbsp;" + CommonFunction.Dates.GetDate(CType(strFromDate, Date)) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + MyBase.GetResourceString("TODATE") + "&nbsp;:&nbsp;" + CommonFunction.Dates.GetDate(CType(strToDate, Date))
            End If
            'End Of Addition  On 16 Sep 2005 For WhizibleSEM SP4
        End If
        objHeader.DrawHeaderFooter()
        objHeader = Nothing


        '''' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197 
        'Added By Vidya J on 17-11-2015
        ''Response.Write("<TABLE CellSpacing=0 width='100%' height = '10' class=clsTable><TR class=clsTRBlank><TD><TD></TR></TABLE>")
        Response.Write("<TABLE id=tbltm CellSpacing=0 width='99.9%'  class=clsTable><TR class=clsTRBlank><TD>")
        'Added By Vidya J on 17-11-2015
        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_strToken_ViewAndGenerate, , , , , , , , , , , , True, , EnableHTMLEncode:=True)
        '''End of Modification by Dhanashri S on 7 Oct 2015 

        Response.Write("<TD></TR></TABLE>")
        '''' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197  


    End Sub

    Private Sub GeneratePageCaption()
        '=====================================================================
        ' Procedure Name        : GeneratePageCaption()	
        ' Purpose               : to generate page caption
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 23, 2004
        ' Revisions             :
        '=====================================================================

        'Initialize resource file 
        MyBase.InitializeResources("AppResources.PM_TimeSheet", "AppResources")


        'Added By VivekP On 11 August 2005 For WhizibleSEM Sp4 IssueID-87
        ' Get the person (CUSTOMER/INTERNAL) who is responsible for authenticating the timesheet.
        Dim drTSAuthenticatedBy As IDataReader
        Dim drReciever As IDataReader
        Dim strApproverName As String = ""
        Dim count As Integer = 0
        Dim intc As Integer = 0

        drTSAuthenticatedBy = CommonFunction.Data.GetDataReader("EXEC usp_Sel_TimeSheetAuthenticationType " + intTimeSheetNo.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        If drTSAuthenticatedBy.Read Then
            'Added By JyotiG 
            'Issue ID : 7128
            'Date : 26-Oct-2006
            'Start
            m_strAuthenticatedBy = CType(CommonFunctions.Data.CheckIsDBNull(drTSAuthenticatedBy("AuthenticatedBy"), "I"), String)
            'End of modification by JyotiG
            If drTSAuthenticatedBy("AuthenticatedBy").ToString = "C" Then
                ' Get the email id's from project customer contact table to send the mail.
                drReciever = CommonFunction.Data.GetDataReader("EXEC usp_Sel_CustomerEmailIDForTimeSheet " + CType(Session("intProjectID"), String), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                Do While drReciever.Read
                    If count = 0 Then
                        ApproverName = ApproverName + drReciever("EmployeeName").ToString
                    Else
                        If intc = 0 Then
                            ApproverName = ApproverName + ";" + drReciever("EmployeeName").ToString + ";"
                        Else
                            ApproverName = ApproverName + drReciever("EmployeeName").ToString + ";"
                        End If
                        intc = intc + 1
                    End If
                    count = count + 1
                Loop
                strApproverName = "     Customer : " + ApproverName
                CommonFunction.Data.DisposeDataReader(drReciever)
            Else
                ' Get the email id of the Internal person responsible for authenticating the time sheet.
                drReciever = CommonFunction.Data.GetDataReader("EXEC usp_Sel_InternalAuthenticatorForTimeSheet " + intTimeSheetNo.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                Do While drReciever.Read
                    If count = 0 Then
                        ApproverName = ApproverName + drReciever("EmployeeName").ToString
                    Else
                        ApproverName = ApproverName + drReciever("EmployeeName").ToString + ";"
                    End If
                    count = count + 1

                Loop
                strApproverName = "     Approver : " + ApproverName
                CommonFunction.Data.DisposeDataReader(drReciever)
            End If

        End If
        CommonFunction.Data.DisposeDataReader(drTSAuthenticatedBy)
        'End Of Addition By VivekP On 11 August 2005 For WhizibleSEM Sp4 IssueID-87

        'Added By VivekP On 1 August 2005 IssueID-87
        Dim IsFreezed As Boolean
        Dim ReadyToAuthenticate As String
        Dim Authenticated As String
        Dim ID As String = ""
        If intTimeSheetNo.ToString <> "" Then
            ID = " ID : " + intTimeSheetNo.ToString + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
        End If
        'Commented and Added by Chakshuta H on 8th-Aug-2016 
        'IsFreezed = CType(CommonFunctions.Data.GetDataScalar("SELECT IsFreezed FROM Tbl_PM_TimeSheet WHERE TimesheetNo=" + intTimeSheetNo.ToString, MyBase.UseSQL), Boolean)
        'ReadyToAuthenticate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT ReadyToAuthenticate FROM tbl_PM_TimeSheetInvoice WHERE TimesheetNo=" + intTimeSheetNo.ToString, MyBase.UseSQL), ""), String)
        'Authenticated = CType(CommonFunctions.Data.GetDataScalar("SELECT Authenticated FROM tbl_PM_TimeSheetInvoice WHERE TimesheetNo=" + intTimeSheetNo.ToString, MyBase.UseSQL), String)
        IsFreezed = CType(CommonFunctions.Data.GetDataScalar("usp_sel_Tbl_PM_TimeSheet_IsFreezed " + intTimeSheetNo.ToString, MyBase.UseSQL), Boolean)
        ReadyToAuthenticate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_TimeSheetInvoice_ReadyToAuthenticate " + intTimeSheetNo.ToString, MyBase.UseSQL), ""), String)
        Authenticated = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_TimeSheetInvoice_Authenticated " + intTimeSheetNo.ToString, MyBase.UseSQL), String)

        'End Of Commented and Added by Chakshuta H on 8th-Aug-2016 

        If Authenticated = "G" Then
            Response.Write(WebPage.Templates.PageCaption.GetPageCaptions(, "Timesheet" + ID, MyBase.GetResourceString("STATUS") + " : " + "Re-Generated", , True) + vbCrLf)
        ElseIf Authenticated = "R" Then
            Response.Write(WebPage.Templates.PageCaption.GetPageCaptions(, "Timesheet" + ID + "  " + strApproverName, MyBase.GetResourceString("STATUS") + " : " + MyBase.GetResourceString("REJECTED"), , True) + vbCrLf)
        ElseIf Authenticated = "N" Then
            If ReadyToAuthenticate = "" Then
                If IsFreezed = False Then
                    Response.Write(WebPage.Templates.PageCaption.GetPageCaptions(, "Timesheet" + ID, MyBase.GetResourceString("STATUS") + " : " + MyBase.GetResourceString("GENERATED"), , True) + vbCrLf)
                Else
                    Response.Write(WebPage.Templates.PageCaption.GetPageCaptions(, "Timesheet" + ID, MyBase.GetResourceString("STATUS") + " : " + MyBase.GetResourceString("FREEZED"), , True) + vbCrLf)
                End If
            Else
                Response.Write(WebPage.Templates.PageCaption.GetPageCaptions(, "Timesheet" + ID + "  " + strApproverName, MyBase.GetResourceString("STATUS") + " : " + MyBase.GetResourceString("SENT_FOR_APPROVAL"), , True) + vbCrLf)
            End If
        Else
            If Authenticated Is Nothing Then
                Response.Write(WebPage.Templates.PageCaption.GetPageCaptions(, "Timesheet", , , True) + vbCrLf)
            Else
                Response.Write(WebPage.Templates.PageCaption.GetPageCaptions(, "Timesheet" + ID + "  " + strApproverName, MyBase.GetResourceString("STATUS") + " : " + MyBase.GetResourceString("APPROVED"), , True) + vbCrLf)
            End If

        End If
        'End Of Addition on 1 august 2005

        'Response.Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGECAPTION"), , , True) + vbCrLf)

        Response.Write("<TABLE CellSpacing=0 width='99.9%' height = '10' class=clsTable><TR class=clsTRBlank><TD><TD></TR></TABLE>")
    End Sub

    Private Sub ShowTaskList()
        '=====================================================================
        ' Procedure Name        : ShowTaskList()	
        ' Purpose               : Show Task List
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 20, 2004
        ' Revisions             :
        '=====================================================================

        Dim strSQL As String

        ' pickup the data from dailyactivity table and show. 
        strSQL = "usp_ViewTimeSheet " + "'" + strFromDate + "'" + "," + "'" + strToDate + "'" + "," + m_ProjectId.ToString

        If blnSubProjectLevelInvoiceing Then
            If intSubProjectID <> 0 Then
                strSQL = strSQL + ", " + intSubProjectID.ToString
            End If
        End If

        Dim drTaskList As IDataReader
        drTaskList = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If drTaskList.Read Then
            blnNoData = False
        Else
            blnNoData = True
        End If
        CommonFunction.Data.DisposeDataReader(drTaskList)
        'Show the task List
        Call PlotTaskListGrid(strSQL)


        'Added by VivekP On 5 August 2005 For WhizibleSEM SP4 IssueID-87
        If blnNoData = True Then
            Call ShowMessagesForNodata()
        End If
        'End Of Addition On 5 August 2005 For WhizibleSEM SP4

        strSQL = Nothing
    End Sub
    Private Sub PloatDAExceedEmployeeList()
        '=====================================================================
        ' Procedure Name        : PloatDAExceedEmployeeList()	
        ' Purpose               : To plot list of the employee's who entered their daily
        '                         activity after project closing
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SwapnilR 
        ' Created               : 17th Feb 2005
        ' Revisions             :
        '=====================================================================
        Dim strHTML As String
        Dim ArrActualFieldNames_ExceededDA() As String = {"EmployeeName"}
        Dim ArrUserFriendlyFieldNames_ExceededDA() As String = {MyBase.GetResourceString("EMPLOYEENAME")}
        Dim ArrTDStyle_ExceededDA() As String = {"align=left width=25%"}
        Dim strSQL_ExceededDA As String
        Dim objHeader_DAExceed As New WebPage.Templates.HeaderFooter

        ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''End of Addition by Dhanashri S on 7 Oct 2015

        strHTML = "List of employees who entered daily activity after closing of the project <br> Due to which project timesheet is not generated. "
        objHeader_DAExceed.HeaderFooter = strHTML
        objHeader_DAExceed.DrawHeaderFooter()
        objHeader_DAExceed = Nothing

        strSQL_ExceededDA = " Exec usp_CheckDailyActivityAfterClosingProject " & m_ProjectId

        With objDAExceedGrid
            .ActualColumnArray = ArrActualFieldNames_ExceededDA
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames_ExceededDA
            .TDStyleArray = ArrTDStyle_ExceededDA
            .NoOfDataColumns = 1
            .DIVID = "DivResources"
            .DIVStyle = "Overflow:auto;width:100%"
            'Commented by Yogesh J on 02-Dec-2015
            '  .DIVHeight = 450
            'End of Comment by Yogesh J on 02-Dec-2015
            .SQL = strSQL_ExceededDA
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            ''End of Addition by Dhanashri S on 7 Oct 2015
            .DrawGrid()
        End With

    End Sub
    Private Sub PlotPendingVerificationResources()
        '=====================================================================
        ' Procedure Name        : PlotPendingVerificationResources()	
        ' Purpose               : To plot Resources who's tasks are not verified
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VidyaJ
        ' Created               : July 22, 2004
        ' Revisions             :
        '=====================================================================

        Dim ArrActualFieldNames() As String = {"EmployeeName", "FromDate", "ToDate", "Status"}
        Dim ArrUserFriendlyFieldNames() As String = {MyBase.GetResourceString("EMPLOYEENAME"), MyBase.GetResourceString("FROMDATE"), MyBase.GetResourceString("TODATE"), MyBase.GetResourceString("STATUS")}
        Dim ArrTDStyle() As String = {"align=left width=25%", "align=left width=25%", "align=left width=25%", "align=left width=25%"}
        Dim strSQL As String
        Dim objHeader As New WebPage.Templates.HeaderFooter
        Dim strHTML As String
        ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''End of Addition by Dhanashri S on 7 Oct 2015

        strSQL = " Exec usp_Sel_CheckPendingTimesheetResources " & m_ProjectId & ",'" & strFromDate & "','" & strToDate & "'"

        With objResourcesGrid
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .TDStyleArray = ArrTDStyle
            .NoOfDataColumns = 4
            .DIVID = "DivResources"
            .DIVStyle = "Overflow:auto;width:100%"
            .DIVHeight = 180
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            ''End of Addition by Dhanashri S on 7 Oct 2015
            .DrawGrid()
        End With

        Dim ArrActualFieldNames_DA() As String = {"EmployeeName"}
        Dim ArrUserFriendlyFieldNames_DA() As String = {MyBase.GetResourceString("EMPLOYEENAME")}
        Dim ArrTDStyle_DA() As String = {"align=left width=25%"}
        Dim strSQL_DA As String


        'Response.Write("List of employees who not entered their daily activity")
        strHTML = MyBase.GetResourceString("UNFILLEDDA") + " <br>" + MyBase.GetResourceString("FROMDATE") + " : " + strFromDate + " &nbsp;&nbsp;&nbsp;" + MyBase.GetResourceString("TODATE") + ":" + strToDate
        objHeader.HeaderFooter = strHTML
        objHeader.DrawHeaderFooter()
        objHeader = Nothing

        ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
        Dim arrIgnoreHTMLEncode_DAResourceGrid() As String = {"0"}
        ''End of Addition by Dhanashri S on 7 Oct 2015
        strSQL_DA = " Exec usp_EmployeenotFilledDA " & m_ProjectId & ",'" & strFromDate & "','" & strToDate & "'"


        With objDAResourceGrid
            .ActualColumnArray = ArrActualFieldNames_DA
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames_DA
            .TDStyleArray = ArrTDStyle_DA
            .NoOfDataColumns = 1
            .DIVID = "DivResources"
            .DIVStyle = "Overflow:auto;width:100%"
            .DIVHeight = 210
            .SQL = strSQL_DA
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode_DAResourceGrid
            ''End of Addition by Dhanashri S on 7 Oct 2015
            .DrawGrid()
        End With
        ' Add code here to show the employee who not generated timesheet
        ' Code added by SwapnilR on 17th Feb 2005
        ' Purpose : To show List of all employee's who entered daily activity
        '           after closing of the project



        ' End of code addition by SwapnilR on 17th Feb 2005
    End Sub

    Private Sub PlotTaskListGrid(ByVal GridSQL As String)
        '=====================================================================
        ' Procedure Name        : PlotTaskListGrid()	
        ' Purpose               : TO plot task list grid (Mode=view)
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 20, 2004
        ' Revisions             :
        '=====================================================================

        'Modified By VidyaJ on 8th June 2005
        'Initialize resource file 
        MyBase.InitializeResources("AppResources.PM_TimeSheet", "AppResources")


        Dim ArrActualFieldNames() As String = {"EmployeeName", "EntryDate", "Task", "Description", "Duration"}
        Dim ArrUserFriendlyFieldNames() As String = {MyBase.GetResourceString("EMPLOYEENAME"), MyBase.GetResourceString("DATE"), MyBase.GetResourceString("TASKNAME"), MyBase.GetResourceString("DESCRIPTION"), MyBase.GetResourceString("ACTUALWORKHRS")}
        Dim ArrSummaryFunctions() As String = {"", "", "", "", "SUM"}
        Dim ArrGroupSummaryFunctions() As String = {"", "", "", "", "SUM"}
        Dim ArrTDStyle() As String = {"align=left width=10%", "align=centre width=10%", "align=left width=37%", "align=left width=37%", "align=right width=5%"}

        ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''End of Addition by Dhanashri S on 7 Oct 2015

        'Code Added by VivekP On 16 Sep 2005 For WhizibleSEM SP4
        Dim dr As IDataReader
        dr = CommonFunctions.Data.GetDataReader(GridSQL, True)
        If dr.Read Then
            blnTaskListGridData = True
        End If
        CommonFunction.Data.DisposeDataReader(dr)
        'End of Addition by VivekP On 16 Sep 2005 For WhizibleSEM SP4

        With objTaskListGrid
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .TDStyleArray = ArrTDStyle
            .NoOfDataColumns = 5
            .DIVID = "DivTaskList"
            .DIVStyle = "Overflow:auto;width:100%"
            'Commented by Yogesh J on 03-Dec-2015
            ' .DIVHeight = 450
            'End of Comment by Yogesh J on 03-Dec-2015
            .SQL = GridSQL
            .ShowSummaryFunctions = True
            .GroupSummaryFunc = ArrGroupSummaryFunctions
            .SummaryFunctions = ArrSummaryFunctions
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            ''End of Addition by Dhanashri S on 7 Oct 2015
            .DrawGrid()
        End With
    End Sub
    'Code Added By VidyaJ on 22nd July 2004
    Private Sub CheckPendingTimesheet()
        '=====================================================================
        ' Procedure Name        : CheckPendingTimesheet()
        ' Purpose               : Check if all resource timesheets are verified
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VidyaJ
        ' Created               : July 22, 2004
        ' Revisions             :
        '=====================================================================

        Dim drTImeSheet As IDataReader
        Dim blnTimesheetWorkFlow As Boolean
        Dim blnAllVerified As Boolean
        Dim strSQL As String


        'Check if Timesheet Flow is enabled
        strSQL = " Exec  usp_sel_tbl_PM_CompanyInformation "
        drTImeSheet = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If drTImeSheet.Read Then
            blnTimesheetWorkFlow = CType(drTImeSheet("TimesheetWorkFlow"), Boolean)
        End If
        CommonFunction.Data.DisposeDataReader(drTImeSheet)

        blnAllVerified = True
        If blnTimesheetWorkFlow = True Then

            'Check that all Daily activity entries for the project between given dates are verified
            strSQL = "EXEC usp_Sel_CheckDAForProjectTimesheet " & m_ProjectId & ",'" & strFromDate & "','" & strToDate & "'"
            drTImeSheet = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
            If drTImeSheet.Read Then
                blnAllVerified = CType(drTImeSheet("AllVerified"), Boolean)
            End If
            CommonFunction.Data.DisposeDataReader(drTImeSheet)
            If blnAllVerified = False Then
                Response.Redirect("PM_Timesheet.aspx?Mode=ShowPendingResources&StartDate=" & strFromDate & "&EndDate=" & strToDate)
            End If
        End If


    End Sub
    Private Sub GenerateTimeSheet()
        '=====================================================================
        ' Procedure Name        : GenerateTimeSheet()
        ' Purpose               : TO generate a timesheet
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 20, 2004
        ' Revisions             :
        '=====================================================================

        Dim DAPresentForPeriod, strSQL As String, drTImeSheet As IDataReader


        'Check for Daily activity entries for the period
        DAPresentForPeriod = CommonFunction.Data.GetDataScalar("EXEC usp_Sel_CheckDailyActivity_For_Given_Date '" + strFromDate + "','" + strToDate + "'," + m_ProjectId.ToString, MyBase.UseSQL).ToString()

        If DAPresentForPeriod.ToUpper = "ND" Then
            blnNoData = True
        Else
            blnNoData = False
        End If

        DAPresentForPeriod = Nothing

        'Modified By VivekP On 19 sep 2005 For WhizibleSEm SP4
        Dim stremployeename As String
        'Commented and Added by Chakshuta H on 8th-Aug-2016 
        'stremployeename = CType(CommonFunctions.Data.GetDataScalar("SELECT EmployeeName FROM tbl_PM_Employee WHERE EmployeeID=" + CType(Session("intUserID"), String), True), String)
        stremployeename = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Employee_EmployeeName " + CType(Session("intUserID"), String), True), String)
        'End Of Commented and Added by Chakshuta H on 8th-Aug-2016 

        'Modified By nitinVS on 16 Apr 2007 for WhizibleSEM SP 8 regression Issue 13026 
        'If entries are present
        If Not blnNoData Then
            strSQL = "usp_GenerateTimeSheet '" + strFromDate + "','" + strToDate + "'," + m_ProjectId.ToString + ", 0,'" + CommonFunction.General.BuildQueryString(stremployeename) + "'"
            'End Modified By nitinVS on 16 Apr 2007 for WhizibleSEM SP 8 regression Issue 13026 

            If blnSubProjectLevelInvoiceing Then
                If intSubProjectID <> 0 Then
                    strSQL += "," + intSubProjectID.ToString
                End If
            End If
            'End Of Modification on  19 sep 2005 For WhizibleSEm SP4

            drTImeSheet = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

            'Get newly generated timesheet number

            If drTImeSheet.Read Then
                intTimeSheetNo = CType(drTImeSheet("TimeSheetNo"), Integer)
                'stremployeename = CType(CommonFunctions.Data.GetDataScalar("SELECT EmployeeName FROM tbl_PM_Employee WHERE EmployeeID=" + CType(Session("intUserID"), String), True), String)
                'CommonFunctions.Data.InsertOrUpdateData("UPDATE tbl_PM_TimesheetInvoice SET ModifiedBy='" + stremployeename + "' WHERE Timesheetno=" + intTimeSheetNo.ToString, True)
            End If
            CommonFunction.Data.DisposeDataReader(drTImeSheet)
        End If


        'Added By VivekP On 4 August 2005 For WhizibleSEM Sp4 IssueID-87

        'Commented and Added by Chakshuta H on 8th-Aug-2016 
        'ReadyToAuthenticate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT ReadyToAuthenticate FROM tbl_PM_TimeSheetInvoice WHERE TimesheetNo=" + intTimeSheetNo.ToString, MyBase.UseSQL), ""), String)
        ReadyToAuthenticate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_TimeSheetInvoice_ReadyToAuthenticate " + intTimeSheetNo.ToString, MyBase.UseSQL), ""), String)
        'End Of Commented and Added by Chakshuta H on 8th-Aug-2016 

        GenerateTopMenu()
        Response.Write(strMenu)

        Call GeneratePageCaption()

        Call GeneratePageHeader()

        'End Of Addition By VivekP On 4 August 2005 For WhizibleSEM Sp4 IssueID-87


        'Show newly generted timesheet
        Call ShowTimeSheet()

        'Added by VivekP On 5 August 2005 For WhizibleSEM SP4 IssueID-87
        If blnNoData = True Then
            Call ShowMessagesForNodata()
        End If
        'End Of Addition On 5 August 2005 For WhizibleSEM SP4

        strDescription = ""
        intDuration = 0




    End Sub
    Private Sub ShowMessagesForNodata()
        'Created By vievkP
        'Created On 5 August 2005
        'Purpose-For WhizibleSEM SP4
        Response.Write("<script language='javascript'>")
        Response.Write("alert('There are no tasks to show for this current period.')")
        Response.Write("</script>")
        'Response.Write("<TABLE  Width='100%' cellspacing=0 class=clsTable><TR class=clsTRPageHeader><TD align=center>There are no tasks to show for this current period.</TD></TR></TABLE>")
        'Response.Write("<TABLE CellSpacing=0 width='100%' height = '10' class=clsTable><TR class=clsTRBlank><TD><TD></TR></TABLE>")
    End Sub


    Private Sub PlotGenerateTimeSheetGrid(ByVal GridSQL As String)
        '=====================================================================
        ' Procedure Name        : PlotTaskListGrid()	
        ' Purpose               : TO plot task list grid (Mode=view)
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 20, 2004
        ' Revisions             :
        '=====================================================================

        Dim ArrActualFieldNames() As String = {"EmployeeName", "EntryDate", "Task", "Description", "Duration"}
        Dim ArrUserFriendlyFieldNames() As String = {MyBase.GetResourceString("EMPLOYEENAME"), MyBase.GetResourceString("DATE"), MyBase.GetResourceString("TASKNAME"), MyBase.GetResourceString("DESCRIPTION"), MyBase.GetResourceString("ACTUALWORKHRS"), MyBase.GetResourceString("WSR"), MyBase.GetResourceString("DELETE")}
        Dim ArrSummaryFunctions() As String = {"", "", "", "", "SUM", "", ""}
        Dim ArrGroupSummaryFunctions() As String = {"", "", "", "", "SUM", "", ""}
        Dim ArrTDStyle() As String = {"align=left width=10%", "align=centre width=10%", "align=left width=32%", "align=left width=32%", "align=right width=5%", "align=centre width=5%", "align=centre width=5%"}
        Dim ArrIgnoreHTMLEncode() As String = {"1", "", "", "", "", "1", ""}
        Dim ArrDelete() As String = {"", "", "", "", "", "chkDelete"}

        Dim ArrLinks() As String = {"", "", "EditTask(TimeSheetID,{}" + intTimeSheetNo.ToString}

        'Code Added by DipaliS 7 Oct 2004
        'Purpose: When timesheet is freezed, the task cannot be edited
        'When TimeSheet is freezed
        Dim strSQLSite As String
        'Modified by VivekP On 11 August 2005 For WhizibleSEM SP4 IssueID-87
        Dim blnShow As String = ""
        'Commented and Added by Chakshuta H on 8th-Aug-2016 
        'strSQLSite = "Select ReadyToAuthenticate From Tbl_PM_TimeSheetInvoice Where TimeSheetNo=" + intTimeSheetNo.ToString
        strSQLSite = "usp_sel_tbl_PM_TimeSheetInvoice_ReadyToAuthenticate " + intTimeSheetNo.ToString
        'End Of Commented and Added by Chakshuta H on 8th-Aug-2016 
        blnShow = CType(CommonFunction.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQLSite, MyBase.UseSQL), "0"), String)
        If blnShow = "Y" Then
            ArrLinks(2) = ""
            ArrUserFriendlyFieldNames(6) = ""
            ArrDelete(5) = ""
        End If
        'If m_blnAddAccess = False And m_blnEditAccess = False Then
        '    ArrLinks(2) = ""
        'End If
        If m_blnEditAccess = False Then
            ArrUserFriendlyFieldNames(6) = ""
            ArrDelete(5) = ""
            ArrLinks(2) = ""
        End If
        'End Of Modification by VivekP On 11 August 2005 For WhizibleSEM SP4 IssueID-87
        'End addition by DipaliS


        With objGenerateTimeSheetGrid
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .TDStyleArray = ArrTDStyle
            .IgnoreHTMLEncode = ArrIgnoreHTMLEncode
            .CheckBoxIDArray() = ArrDelete
            .RowLinkArray = ArrLinks
            .PrimaryKey = "TimeSheetID"
            .NoOfDataColumns = 5
            .DIVID = "DivTimeSheet"
            .DIVStyle = "Overflow:scroll;width=100%"

            If Not m_blnTimeSheetAuthenticated Then
                If strMode.ToUpper = "EDIT" Then
                    '.DIVHeight = 335
                    '.DIVHeight = 310
                    .DIVHeight = 320
                Else
                    '.DIVHeight = 415
                    .DIVHeight = 395
                End If
            Else
                .DIVHeight = 435
                '.DIVHeight = 410
            End If
            .SQL = GridSQL
            .ShowSummaryFunctions = True
            .GroupSummaryFunc = ArrGroupSummaryFunctions
            .SummaryFunctions = ArrSummaryFunctions
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            .DrawGrid()
            'Modified by VivekP On 11 August 2005 For WhizibleSEM SP4 IssueID-87
            mblnDACount = objGenerateTimeSheetGrid.NoOfRows
        End With

    End Sub

    Private Sub SendMailToCustomer(ByVal intTimeSheetNo As Integer)
        '=====================================================================
        ' Procedure Name        : SendMailToCustomer()	
        ' Purpose               : to send mail to customer
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 25, 2004
        ' Revisions             :
        '=====================================================================

        Dim drCustomerEmail, drsEmailMessage, drProject, drMailSendTo As IDataReader

        Dim strMessage As String = "" 'mail messsage
        Dim strCustomerName As String = "" 'name of the customer
        Dim strMailTo As String = "" ' mail to
        Dim strFromMail As String = "" 'mail from 
        Dim strSubject As String = "" 'mail subject
        Dim strProjectName As String = "" 'Project name
        Dim strProjectManager As String = "" 'Project Manager
        Dim strPersonName As String = "" 'Contact person

        'GetCompany Email ID
        'strFromMail = funcGetCompanyMailID()

        'strMailTo=rsCustomerEmail(0)

        drProject = CommonFunction.Data.GetDataReader("EXEC usp_Sel_ProjectNameFromTimeSheet " + intTimeSheetNo.ToString, MyBase.UseSQL)
        If drProject.Read Then
            strProjectName = drProject(0).ToString
            strProjectManager = drProject(1).ToString
        End If
        CommonFunction.Data.DisposeDataReader(drProject)

        'get the email id's from project customer contact table to send the mail
        drMailSendTo = CommonFunction.Data.GetDataReader("EXEC usp_Sel_CustomerEmailIDForTimeSheet " + intTimeSheetNo.ToString, MyBase.UseSQL)
        Do While drMailSendTo.Read

            strMailTo = drMailSendTo("EmailID").ToString
            strPersonName = drMailSendTo("ContactPerson").ToString

            'Get the email message and subject from table 
            Dim drEmailMessages As IDataReader

            drEmailMessages = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_EmailMessages 2", MyBase.UseSQL)
            If drEmailMessages.Read Then
                strMessage = drEmailMessages("BODY").ToString
                strSubject = drEmailMessages("Subject").ToString
            End If
            CommonFunction.Data.DisposeDataReader(drEmailMessages)

            'replace PROJECT_NAME with real project name
            strSubject = Replace(strSubject, "<PROJECT_NAME>", strProjectName)

            'construct real message by replacing place holders
            strMessage = Replace(strMessage, "<NAME>", strPersonName)
            strMessage = Replace(strMessage, "<SITE NAME>", "http://" + Request.ServerVariables("SERVER_NAME"))
            strMessage = Replace(strMessage, "<SENDER_NAME>", strProjectManager)

            'Send mail
            Call CommonFunction.Emails.AppSendEmail(strMailTo, strFromMail, strSubject, strMessage)
        Loop

        CommonFunction.Data.DisposeDataReader(drMailSendTo)
    End Sub

    Private Sub ShowTimeSheet()
        '=====================================================================
        ' Procedure Name        : ShowTimeSheet()	
        ' Purpose               : to show specified timesheet
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 25, 2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String

        strSQL = "EXEC usp_Sel_TimeSheetForGivenTimeSheetNo " + intTimeSheetNo.ToString

        Call PlotGenerateTimeSheetGrid(strSQL)
    End Sub

    Private Sub SetVariables()
        '=====================================================================
        ' Procedure Name        : SetVariables()	
        ' Purpose               : Set variable values (QueryString and form references)
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 20, 2004
        ' Revisions             :
        '=====================================================================

        Dim strSQL As String, drCompanyInformation As IDataReader

        blnSubProjectLevelInvoiceing = CommonFunction.Application.SubProjectLevelInvoiceing


        ' If Sub Proect level timesheet generation and invoiceing is applicable, then...
        If blnSubProjectLevelInvoiceing Then
            ' Get the caption to be displayed.
            Dim drTagMaster As IDataReader
            Dim strSQLQuery As String = "Exec usp_Sel_tbl_UI_TagMaster 1049"
            drTagMaster = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            If drTagMaster.Read Then
                strSubProjectCaption = drTagMaster("TagDescription").ToString.Trim
            Else
                strSubProjectCaption = "Work Order"
            End If

            CommonFunction.Data.DisposeDataReader(drTagMaster)
            strSQLQuery = Nothing

        End If

        blnNoData = False

        Dim drEmailMessage As IDataReader
        drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 3", MyBase.UseSQL)
        If drEmailMessage.Read Then
            blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
            blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
        End If
        CommonFunction.Data.DisposeDataReader(drEmailMessage)

        'Get The Order By field
        If Not Request.QueryString("OrderBy") Is Nothing Then
            If Request.QueryString("OrderBy") <> "" Then
                strOrderByField = Request("OrderBy")
            Else
                strOrderByField = "timesheetno"
            End If
        End If

        'Get Asc Or Desc
        If Not Request.QueryString("ASCDESC") Is Nothing Then
            If Request.QueryString("ASCDESC") <> "" Then
                strAscOrDesc = Request.QueryString("ASCDESC")
            Else
                strAscOrDesc = "DESC"
            End If
        End If

        'Period
        intNumTodayDate = Weekday(Now(), Microsoft.VisualBasic.FirstDayOfWeek.Monday)
        dtFirstDayOfWeek = CDate(DateAdd(DateInterval.Day, (intNumTodayDate - 6), Now()))
        dtLastDayOfWeek = DateAdd(DateInterval.Day, 5, Now())
        dtFirstDayOfWeek = dtFirstDayOfWeek
        dtLastDayOfWeek = dtLastDayOfWeek



        'Code Added By VidyaJ on 22nd July 2004
        strFromDate = Request.QueryString("StartDate")
        strToDate = Request.QueryString("EndDate")

        'From Date
        If Not MyBase.GetFormValue("txtFromDate") Is Nothing Then
            If MyBase.GetFormValue("txtFromDate") <> "" Then
                strFromDate = MyBase.GetFormValue("txtFromDate")
            End If
        End If

        'To Date
        If Not MyBase.GetFormValue("txtToDate") Is Nothing Then
            If MyBase.GetFormValue("txtToDate") <> "" Then
                strToDate = MyBase.GetFormValue("txtToDate")
            End If
        End If


        'WSR Timesheet Number
        If Not MyBase.GetFormValue("WSRTimeSheetNo") Is Nothing Then
            If MyBase.GetFormValue("WSRTimeSheetNo") <> "" Then
                intWSRTimeSheetNo = CType(MyBase.GetFormValue("WSRTimeSheetNo"), Integer)
            End If
        End If

        'SubProject Id
        If Not MyBase.GetFormValue("cboSubProjectID") Is Nothing Then
            If MyBase.GetFormValue("cboSubProjectID") <> "" Then
                intSubProjectID = CType(MyBase.GetFormValue("cboSubProjectID"), Integer)
            End If
        End If

        'Task
        If Not MyBase.GetFormValue("txtTask") Is Nothing Then
            If MyBase.GetFormValue("txtTask") <> "" Then
                strTask = MyBase.GetFormValue("txtTask")
            End If
        End If

        'Task
        If Not MyBase.GetFormValue("cboHours") Is Nothing Then
            If MyBase.GetFormValue("cboHours") <> "" Then
                intDuration = CType(MyBase.GetFormValue("cboHours"), Double)
            End If
        End If

        'Mode
        If Not Request.QueryString("Mode") Is Nothing Then
            If Request.QueryString("Mode") <> "" Then
                strMode = Request.QueryString("Mode")
            Else
                strMode = "Show"
            End If
        Else
            strMode = "Show"
        End If

        'TimeSheet Id
        If Not Request.QueryString("TimeSheetID") Is Nothing Then
            If Request.QueryString("TimeSheetID") <> "" Then
                strTimeSheetID = Request.QueryString("TimeSheetID")
            End If
        End If

        'Status
        If Not MyBase.GetFormValue("cboStatus") Is Nothing Then
            If MyBase.GetFormValue("cboStatus") <> "" Then
                strStatus = MyBase.GetFormValue("cboStatus").ToString
            End If
        End If

        If m_ProjectId <> 0 And strFromDate = "" And strToDate = "" Then
            Dim drGetDateRanges As IDataReader

            drGetDateRanges = CommonFunction.Data.GetDataReader("EXEC usp_GetDatesForTimeSheet " + m_ProjectId.ToString, MyBase.UseSQL)
            If drGetDateRanges.Read Then
                strFromDate = CommonFunction.Dates.GetDate(CType(drGetDateRanges(0), Date))
                strToDate = CommonFunction.Dates.GetDate(CType(drGetDateRanges(1), Date))
            End If
            CommonFunction.Data.DisposeDataReader(drGetDateRanges)
        End If

        'Timesheet No
        If Not Request.QueryString("TimeSheetNo") Is Nothing Then
            If Request.QueryString("TimeSheetNo") <> "" Then
                intTimeSheetNo = CType(Request.QueryString("TimeSheetNo"), Integer)

                Dim drTimeSheet As IDataReader
                'Commented and Added by Chakshuta H on 8th-Aug-2016 
                'drTimeSheet = CommonFunction.Data.GetDataReader("select FromDate, ToDate from tbl_PM_TimesheetInvoice where TimeSheetNo =  " + intTimeSheetNo.ToString, MyBase.UseSQL)
                drTimeSheet = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_TimeSheetInvoice_FromDate_ToDate " + intTimeSheetNo.ToString, MyBase.UseSQL)
                'End of Commented and Added by Chakshuta H on 8th-Aug-2016 
                If drTimeSheet.Read Then
                    strFromDate = CommonFunction.Dates.GetDate(CType(drTimeSheet(0), Date))
                    strToDate = CommonFunction.Dates.GetDate(CType(drTimeSheet(1), Date))
                End If
                CommonFunction.Data.DisposeDataReader(drTimeSheet)

            End If
        End If

        'bWSCheck = Request("CheckStatus")


        'Generate Invoice
        If Not Request.QueryString("GenerateInvoice") Is Nothing Then
            If Request.QueryString("GenerateInvoice") <> "" Then
                blnGenerateInvoice = CType(Request.QueryString("GenerateInvoice"), Boolean)
            End If
        End If
        If strMode.ToUpper <> "ADD_NEW" Then
            'm_blnTimeSheetAuthenticated = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("select dbo.udf_TimeSheetAuthenticated(" + intTimeSheetNo.ToString + ")", MyBase.UseSQL), "False"), Boolean)
            m_blnTimeSheetAuthenticated = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_udf_TimeSheetAuthenticated " + intTimeSheetNo.ToString, MyBase.UseSQL), "False"), Boolean)
            'm_blnTImeSheetReadyForAuthentication = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("select dbo.udf_TimeSheetReadyForAuthentication(" + intTimeSheetNo.ToString + ")", MyBase.UseSQL), "False"), Boolean)
            m_blnTImeSheetReadyForAuthentication = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_udf_TimeSheetReadyForAuthentication " + intTimeSheetNo.ToString, MyBase.UseSQL), "False"), Boolean)
        End If

        'added by HarshK for sp4 issueid 561
        'Commented and Added by Chakshuta H on 8th-Aug-2016 
        'm_strOverlapValidation = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT IsNull(OverlapValidation,0) FROM tbl_PM_CompanyInformation", MyBase.UseSQL), "False"))
        m_strOverlapValidation = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_CompanyInformation_OverlapValidation ", MyBase.UseSQL), "False"))
        'End of Commented and Added by Chakshuta H on 8th-Aug-2016 
        'end added by HarshK for sp4 issueid 561

        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
        If intTimeSheetNo.ToString = "0" Then
            If Trim(Request.QueryString("PKToken") & "") <> "" Then
                m_strToken_ViewAndGenerate = Request.QueryString("PKToken")
            Else
                m_strToken_ViewAndGenerate = CommonFunctions.Security.Token.GetToken(CType(CommonFunction.Data.CheckIsDBNull(Session("intProjectID").ToString, "0"), String) + CType(Session("intUserID"), String) + "0" + "1049")
            End If
        End If

        If intTimeSheetNo.ToString <> "0" Then
            If Trim(Request.QueryString("PKToken") & "") <> "" Then
                m_strToken_ViewAndGenerate = Request.QueryString("PKToken")
            Else
                m_strToken_ViewAndGenerate = Request.Form("txtPkToken").ToString
            End If
        End If
        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197

    End Sub

    Private Sub CreateGlobalObject()
        '=====================================================================
        ' Procedure Name        : CreateGlobalObject()	
        ' Purpose               : To get global object and set form level variables
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 20, 2004
        ' Revisions             :
        '=====================================================================

        'Global object
        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        With objGlobal
            m_LoginId = .LoginID
            m_LoginType = .LoginType
            m_RoleId = .RoleID
            m_RoleLevel = .RoleLevel
            m_ProjectId = .ProjectID
            m_UserId = .UserID
            m_UserName = .UserName
            m_CultureId = .LCID
            m_FromWhere = .FromWhere
            '.TagID = 
        End With

        Dim objAccess As New WebPage.Templates.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnEditAccess = objAccess.Edit 'If user has Edit Access

        'destroy global and AccessRights objects
        objGlobal = Nothing
        objAccess = Nothing
    End Sub 'Get all session variable values
    Private Sub DateValidation()
        'Created By -vivekP IssueID-87
        'Created On -On 1 August 2005
        Dim drDateValidation As IDataReader

        'Commented and added by Yogesh J on 04-Dec-2015
        'Dim strDateValidationSQl As String = "Select Replace(Convert(CHAR(20),FromDate,106),' ','-')AS FromDate,Replace(Convert(CHAR(20),ToDate,106),' ','-') As ToDate FROM tbl_PM_TimeSheetInvoice WHERE ProjectID=" + m_ProjectId.ToString
        'Commented and Added by Chakshuta H on 8th-Aug-2016 
        'Dim strDateValidationSQl As String = "Select Replace(Convert(CHAR(11),FromDate,106),' ','-')AS FromDate,Replace(Convert(CHAR(11),ToDate,106),' ','-') As ToDate FROM tbl_PM_TimeSheetInvoice WHERE ProjectID=" + m_ProjectId.ToString
        Dim strDateValidationSQl As String = "usp_sel_tbl_PM_TimeSheetInvoice_FromDate_ToDate_ProjectID " + m_ProjectId.ToString
        'End Of Commented and Added by Chakshuta H on 8th-Aug-2016 
        'End of addition by Yogesh J on 04-Dec-2015
        drDateValidation = CommonFunctions.Data.GetDataReader(strDateValidationSQl, MyBase.UseSQL)
        While drDateValidation.Read
            strFromDateVal &= CType(drDateValidation("FromDate"), String) & ","


            strToDateVal &= CType(drDateValidation("ToDate"), String) & ","
            dateCount = dateCount + 1
        End While
        CommonFunctions.Data.DisposeDataReader(drDateValidation)

    End Sub

    Private Sub objTaskListGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objTaskListGrid.DataRowTR_BeforePrint
        '=====================================================================
        ' Procedure Name        : objTaskListGrid_DataRowTR_BeforePrint()	
        ' Purpose               : To make grouping on EmployeeName, EntryDate and calculate GroupTotal
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 20, 2004
        ' Revisions             :
        '=====================================================================
        m_blnTaskGridDataPresent = True

        'Check for Group Value
        If m_strUserName <> Args.DataReader("EmployeeName").ToString.Trim Then
            'Added by vivekP On 16 Sep 2005 For WhizibleSEM SP4
            If blnInitialGrid = True Then
                If m_GroupTotal >= 0 Then
                    'Insert sum for the employee
                    Args.StringToBeInserted = "<TR class='clsTRSectionHeader' ><TD align='left' colspan=4><FONT color=blue>Total Actual Work(hrs) for " + m_strUserName + "</FONT></TD></TD><TD align=right width=15%><FONT color=blue>" + FormatNumber(m_GroupTotal, 2).ToString + "</FONT></TD></TR>"
                End If
            End If
            blnInitialGrid = True
            'End Of Addition by vivekP On 16 Sep 2005

            'Initialize GroupSum to 0 for next group
            m_GroupTotal = 0

            'reset strUserName
            m_strUserName = Args.DataReader("EmployeeName").ToString + ""

            'Insert TR which will have group value
            Args.StringToBeInserted += "<TR class='clsTRSectionHeader' ><TD align='left' colspan=5>" + Args.DataReader("EmployeeName").ToString + "</FONT></TD></TR>"
            m_GroupTotal += CType(Args.DataReader("Duration"), Double)
            m_strEntryDate = ""
        Else
            'update GroupSum
            m_GroupTotal += CType(Args.DataReader("Duration"), Double)
        End If

        If m_strEntryDate <> Args.DataReader("EntryDate").ToString.Trim Then
            m_strEntryDate = Args.DataReader("EntryDate").ToString + ""
            Args.StringToBeInserted += "<TR class='clsTRSectionHeader' ><TD align='left'></TD><TD align='left' colspan=4>" + CommonFunction.Dates.CGetDate(CType(Args.DataReader("EntryDate"), Date)) + "</TD></TR>"
        End If
    End Sub

    Private Sub objTaskListGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objTaskListGrid.DataRowTD_BeforePrint
        '=====================================================================
        ' Procedure Name        : objTaskListGrid_DataRowTD_BeforePrint()	
        ' Purpose               : To avoid repeatition of first group value (EmployeeName) 
        ' Description           : Inserts blank value for first column of grid(EmployeeName)
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 20, 2004
        ' Revisions             :
        '=====================================================================

        If Args.ColIndex = 1 Then 'If second column (Entry Date)
            Args.StringToBeInserted = "<TD align='left'></TD>"
            Cancel = True
        ElseIf Args.ColIndex = 0 Then 'if first column(Employee Name)

            'Determine stylesheet for row
            If Args.NoOfRowsPrinted Mod 2 = 0 Then
                'While cancelling TD, TR will also get cancelled. hence add <TR>, grid class will close it.
                Args.StringToBeInserted = "<TR class='clsTREven'><TD align='left'></TD>"
            Else
                Args.StringToBeInserted = "<TR class='clsTROdd'><TD align='left'></TD>"
            End If
            Cancel = True
        End If
    End Sub

    Private Sub objGenerateTimeSheetGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objGenerateTimeSheetGrid.DataRowTR_BeforePrint
        '=====================================================================
        ' Procedure Name        : objGenerateTimeSheetGrid_DataRowTR_BeforePrint()	
        ' Purpose               : To make grouping on EmployeeName, EntryDate and calculate GroupTotal
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 21, 2004
        ' Revisions             :
        '=====================================================================

        m_blnGenerateTimeSheetGridDataPresent = True

        'Check for Group Value
        If m_strUserName <> Args.DataReader("EmployeeName").ToString.Trim Then

            'TimeSheetID string 
            If m_intGroupNumber = -1 Then
                m_strTimeSheetIDList += Args.DataReader("TimeSheetID").ToString + ","
                'Commented And Added By Usha Pandit On 20.11.2020 For getting work hours in HH:MM to decimal format
                'm_GroupTotal += CType(Args.DataReader("Duration"), Double)
                m_GroupTotal += CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Duration"), "0") + "',2)", True)
                'End Of Added By Usha Pandit On 20.11.2020 For getting work hours in HH:MM to decimal format
            End If

            m_intGroupNumber += 1

            If m_GroupTotal >= 0 Then
                'Insert sum for the employee
                If m_strTimeSheetIDList <> "" Then
                    m_strTimeSheetIDList = Left(m_strTimeSheetIDList, Len(m_strTimeSheetIDList) - 1)
                End If

                'Modified By vivekP On 29 Aug 2005 For WhizibleSEM Sp4 IssueID-87
                If CType(intTimeSheetNo, String) <> "0" Then
                    If m_intGroupNumber <> 0 Then
                        'Commented And Added By Usha Pandit On 25.11.2020 For getting work hours in HH:MM from decimal format

                        'If ReadyToAuthenticate = "Y" Then
                        '    Args.StringToBeInserted = "<TR class='clsTRSectionHeader' width=100% ><TD align='left' colspan=4><FONT color=blue>Total Actual Work(hrs) for " + m_strUserName + "&nbsp;&nbsp;&nbsp;[WSR Status]&nbsp;" + CommonFunction.HTMLControls.DrawCheckBox("chkWSRStatus", "chkWSRStatus", , blnIsCheckedSatus, m_intGroupNumber.ToString, True, "OnClick=""javascript:WSR_Status(" + m_intGroupNumber.ToString + ",'" + m_strTimeSheetIDList + "')""", True) + "</FONT></TD></TD><TD align=right width=15%><FONT color=blue>" + FormatNumber(m_GroupTotal, 2).ToString + "</FONT></TD><TD class='clsTRSectionHeader' colspan=2></TD></TR>"
                        'Else
                        '    Args.StringToBeInserted = "<TR class='clsTRSectionHeader' width=100% ><TD align='left' colspan=4><FONT color=blue>Total Actual Work(hrs) for " + m_strUserName + "&nbsp;&nbsp;&nbsp;[WSR Status]&nbsp;" + CommonFunction.HTMLControls.DrawCheckBox("chkWSRStatus", "chkWSRStatus", , blnIsCheckedSatus, m_intGroupNumber.ToString, , "OnClick=""javascript:WSR_Status(" + m_intGroupNumber.ToString + ",'" + m_strTimeSheetIDList + "')""", True) + "</FONT></TD></TD><TD align=right width=15%><FONT color=blue>" + FormatNumber(m_GroupTotal, 2).ToString + "</FONT></TD><TD class='clsTRSectionHeader' colspan=2></TD></TR>"
                        'End If

                        If ReadyToAuthenticate = "Y" Then
                            'Commented & Added By Rutuja D. on 4 Jan 2021 For Remove Conversion Crash
                            'Args.StringToBeInserted = "<TR class='clsTRSectionHeader' width=100% ><TD align='left' colspan=4><FONT color=blue>Total Actual Work(hrs) for " + m_strUserName + "&nbsp;&nbsp;&nbsp;[WSR Status]&nbsp;" + CommonFunction.HTMLControls.DrawCheckBox("chkWSRStatus", "chkWSRStatus", , blnIsCheckedSatus, m_intGroupNumber.ToString, True, "OnClick=""javascript:WSR_Status(" + m_intGroupNumber.ToString + ",'" + m_strTimeSheetIDList + "')""", True) + "</FONT></TD></TD><TD align=right width=15%><FONT color=blue>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + FormatNumber(m_GroupTotal, 2).ToString + "',1)", True) + "</FONT></TD><TD class='clsTRSectionHeader' colspan=2></TD></TR>"
                            Args.StringToBeInserted = "<TR class='clsTRSectionHeader' width=100% ><TD align='left' colspan=4><FONT color=blue>Total Actual Work(hrs) for " + m_strUserName + "&nbsp;&nbsp;&nbsp;[WSR Status]&nbsp;" + CommonFunction.HTMLControls.DrawCheckBox("chkWSRStatus", "chkWSRStatus", , blnIsCheckedSatus, m_intGroupNumber.ToString, True, "OnClick=""javascript:WSR_Status(" + m_intGroupNumber.ToString + ",'" + m_strTimeSheetIDList + "')""", True) + "</FONT></TD></TD><TD align=right width=15%><FONT color=blue>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + m_GroupTotal.ToString + "',1)", True) + "</FONT></TD><TD class='clsTRSectionHeader' colspan=2></TD></TR>"
                            'End OF Commented & Added By Rutuja D. on 4 Jan 2021 For Remove Conversion Crash
                        Else
                            'Commented & Added By Rutuja D. on 4 Jan 2021 For Remove Conversion Crash
                            'Args.StringToBeInserted = "<TR class='clsTRSectionHeader' width=100% ><TD align='left' colspan=4><FONT color=blue>Total Actual Work(hrs) for " + m_strUserName + "&nbsp;&nbsp;&nbsp;[WSR Status]&nbsp;" + CommonFunction.HTMLControls.DrawCheckBox("chkWSRStatus", "chkWSRStatus", , blnIsCheckedSatus, m_intGroupNumber.ToString, , "OnClick=""javascript:WSR_Status(" + m_intGroupNumber.ToString + ",'" + m_strTimeSheetIDList + "')""", True) + "</FONT></TD></TD><TD align=right width=15%><FONT color=blue>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + FormatNumber(m_GroupTotal, 2).ToString + "',1)", True) + "</FONT></TD><TD class='clsTRSectionHeader' colspan=2></TD></TR>"
                            Args.StringToBeInserted = "<TR class='clsTRSectionHeader' width=100% ><TD align='left' colspan=4><FONT color=blue>Total Actual Work(hrs) for " + m_strUserName + "&nbsp;&nbsp;&nbsp;[WSR Status]&nbsp;" + CommonFunction.HTMLControls.DrawCheckBox("chkWSRStatus", "chkWSRStatus", , blnIsCheckedSatus, m_intGroupNumber.ToString, , "OnClick=""javascript:WSR_Status(" + m_intGroupNumber.ToString + ",'" + m_strTimeSheetIDList + "')""", True) + "</FONT></TD></TD><TD align=right width=15%><FONT color=blue>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + m_GroupTotal.ToString + "',1)", True) + "</FONT></TD><TD class='clsTRSectionHeader' colspan=2></TD></TR>"
                            'End OF Commented & Added By Rutuja D. on 4 Jan 2021 For Remove Conversion Crash
                        End If

                        'End Of Added By Usha Pandit On 25.11.2020 For getting work hours in HH:MM from decimal format
                        'Commented And Added By Usha Pandit On 20.11.2020 For getting work hours in HH:MM to decimal format
                        m_GrandTotal += m_GroupTotal
                        'End Of Added By Usha Pandit On 20.11.2020 For getting work hours in HH:MM to decimal format
                    End If
                End If
                'End Of Modification On 29 Aug 2055 For  WhizibleSEM Sp4

                'Initialize GroupTotal to -1 for next group
                m_GroupTotal = 0

                m_strTimeSheetIDList = ""
                m_strTimeSheetIDList += Args.DataReader("TimeSheetID").ToString + ","
                'Commented And Added By Usha Pandit On 20.11.2020 For getting work hours in HH:MM to decimal format
                'm_GroupTotal += CType(Args.DataReader("Duration"), Double)
                m_GroupTotal += CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Duration"), "0") + "',2)", True)
                'End Of Added By Usha Pandit On 20.11.2020 For getting work hours in HH:MM to decimal format
            End If

            'reset strUserName
            m_strUserName = Args.DataReader("EmployeeName").ToString + ""

            'Insert TR which will have group value
            Args.StringToBeInserted += "<TR class='clsTRSectionHeader'><TD align='left' colspan=5>" + Args.DataReader("EmployeeName").ToString + "</FONT><TD class='clsTRSectionHeader' colspan=2></TD></TD></TR>"
            'Args.StringToBeInserted += "<TR class='clsTRSectionHeader'><TD align='left' colspan=7>" + Args.DataReader("EmployeeName").ToString + "</FONT></TD></TR>"
            m_strEntryDate = ""
        Else
            'update GroupTotal
            'Commented And Added By Usha Pandit On 20.11.2020 For getting work hours in HH:MM to decimal format
            'm_GroupTotal += CType(Args.DataReader("Duration"), Double)
            m_GroupTotal += CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Duration"), "0") + "',2)", True)
            'End Of Added By Usha Pandit On 20.11.2020 For getting work hours in HH:MM to decimal format

            'TimeSheetID string 
            m_strTimeSheetIDList = m_strTimeSheetIDList + Args.DataReader("TimeSheetID").ToString + ","

        End If

        If m_strEntryDate <> Args.DataReader("EntryDate").ToString.Trim Then
            m_strEntryDate = Args.DataReader("EntryDate").ToString + ""
            Args.StringToBeInserted += "<TR class='clsTRSectionHeader' width='100%'><TD align='left'></TD><TD align='left' colspan=4>" + CommonFunction.Dates.CGetDate(CType(Args.DataReader("EntryDate"), Date)) + "</TD><TD colspan=2></TD></TR>"
        End If
    End Sub

    Private Sub objGenerateTimeSheetGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGenerateTimeSheetGrid.DataRowTD_BeforePrint
        '=====================================================================
        ' Procedure Name        : objGenerateTimeSheetGrid_DataRowTD_BeforePrint()	
        ' Purpose               : To avoid repeatition of first group value (EmployeeName) 
        ' Description           : Inserts blank value for first column of grid(EmployeeName)
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 21, 2004
        ' Revisions             :
        '=====================================================================


        If Args.ColIndex = 1 Then 'If second column (Entry Date)
            Args.StringToBeInserted = "<TD align='left'></TD>"
            Cancel = True
        ElseIf Args.ColIndex = 0 Then 'if first column(Employee Name)
            'Determine stylesheet for row
            If Args.NoOfRowsPrinted Mod 2 = 0 Then
                'While cancelling TD, TR will also get cancelled. hence add <TR>, grid class will close it.
                Args.StringToBeInserted = "<TR class='clsTREven'><TD align='left'></TD>"
            Else
                Args.StringToBeInserted = "<TR class='clsTROdd'><TD align='left'></TD>"
            End If
            Cancel = True
            'Added By JyotiG
            'Start_JG_11229_30-Mar-2007
        ElseIf Args.ColIndex = 3 Then 'if first column(Employee Name)
            'Args.StringToBeInserted = "<TD align='left' width=33%><pre>" + Args.DataReader("Description").ToString + "<pre></TD>"
            Args.StringToBeInserted = "<TD align='left' width=33%><p>" + Args.DataReader("Description").ToString + "<p></TD>"

            Cancel = True
            'End_JG_11229_30-Mar-2007
        ElseIf Args.ColIndex = 5 Then
            'Modified By VivekP On 19 August 2005 For WhizibleSEM Sp4 IssueID-87
            'ReadyToAuthenticate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT ReadyToAuthenticate FROM tbl_PM_TimeSheetInvoice WHERE TimesheetNo=" + intTimeSheetNo.ToString, MyBase.UseSQL), ""), String)
            If CType(Args.DataReader("WeeklyStatusEntry"), Boolean) = True Then
                If ReadyToAuthenticate = "Y" Then
                    Args.StringToBeInserted = "<TD align=center width=5%>" + CommonFunction.HTMLControls.DrawCheckBox("chkWSR", "chkWSR", , True, Args.DataReader("TimeSheetID").ToString, True, returnHTML:=True) + "</TD>"
                Else
                    Args.StringToBeInserted = "<TD align=center width=5%>" + CommonFunction.HTMLControls.DrawCheckBox("chkWSR", "chkWSR", , True, Args.DataReader("TimeSheetID").ToString, returnHTML:=True) + "</TD>"
                End If
                blnIsCheckedSatus = True
            Else
                If ReadyToAuthenticate = "Y" Then
                    Args.StringToBeInserted = "<TD align=center width=5%>" + CommonFunction.HTMLControls.DrawCheckBox("chkWSR", "chkWSR", , False, Args.DataReader("TimeSheetID").ToString, True, returnHTML:=True) + "</TD>"
                Else
                    Args.StringToBeInserted = "<TD align=center width=5%>" + CommonFunction.HTMLControls.DrawCheckBox("chkWSR", "chkWSR", , False, Args.DataReader("TimeSheetID").ToString, returnHTML:=True) + "</TD>"
                End If
                blnIsCheckedSatus = False
            End If


            'End Of Modification By VivekP On 19 August 2005 For WhizibleSEM Sp4 IssueID-87
        End If
    End Sub

    Private Sub objTaskListGrid_SummaryFunctionsTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTR) Handles objTaskListGrid.SummaryFunctionsTR_BeforePrint
        'Modified  By VivekP On 19 August 2005 For WhizibleSEM Sp4 IssueID-87
        'Insert sum for the employee
        If blnTaskListGridData = True Then
            If m_GroupTotal >= 0 Then
                'Args.StringToBeInserted = "<TR class='clsTRSectionHeader'><TD align='left' colspan=4><FONT color=blue>Total Actual Work(hrs) for " + m_strUserName + "</FONT></TD></TD><TD align=left width=15% colspan=3><FONT color=blue>" + m_GroupTotal.ToString + "</FONT></TD></TR>"
                Args.StringToBeInserted = "<TR class='clsTRSectionHeader'><TD align='left' colspan=4><FONT color=blue>Total Actual Work(hrs) for " + m_strUserName + "</FONT></TD><TD align=right width=15% colspan=1><FONT color=blue>" + FormatNumber(m_GroupTotal, 2).ToString + "</FONT></TD></TR>"
            Else
                Cancel = Not m_blnTaskGridDataPresent
            End If
        Else
            Cancel = True
        End If
        'Endf Of Modifucation By VivekP On 19 August 2005 For WhizibleSEM Sp4 IssueID-87
    End Sub

    Private Sub objGenerateTimeSheetGrid_SummaryFunctionsTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTR) Handles objGenerateTimeSheetGrid.SummaryFunctionsTR_BeforePrint

        'increase group as it will not be changed for last group
        m_intGroupNumber += 1
        'Insert sum for the employee
        If m_strTimeSheetIDList <> "" Then
            m_strTimeSheetIDList = Left(m_strTimeSheetIDList, Len(m_strTimeSheetIDList) - 1)
        End If

        'Modified By VivekP On 19 August 2005 For WhizibleSEM Sp4 IssueID-87

        If CType(intTimeSheetNo, String) <> "0" Then
            If m_GroupTotal >= 0 Then
                'ReadyToAuthenticate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT ReadyToAuthenticate FROM tbl_PM_TimeSheetInvoice WHERE TimesheetNo=" + intTimeSheetNo.ToString, MyBase.UseSQL), ""), String)
                'Commented And Added By Usha Pandit On 25.11.2020 For getting work hours in HH:MM from decimal format
                'If ReadyToAuthenticate = "Y" Then
                '    Args.StringToBeInserted = "<TR class='clsTRSectionHeader'><TD align='left' colspan=4><FONT color=blue>Total Actual Work(hrs) for " + m_strUserName + "&nbsp;&nbsp;&nbsp;[WSR Status]&nbsp;" + CommonFunction.HTMLControls.DrawCheckBox("chkWSRStatus", "chkWSRStatus", , blnIsCheckedSatus, m_intGroupNumber.ToString, True, "OnClick=""javascript:WSR_Status(" + m_intGroupNumber.ToString + ",'" + m_strTimeSheetIDList + "')""", True) + "</FONT></TD></TD><TD align=right width=15% ><FONT color=blue>" + FormatNumber(m_GroupTotal, 2).ToString + "</FONT></TD><TD colspan=3></TD></TR>"
                'Else
                '    Args.StringToBeInserted = "<TR class='clsTRSectionHeader'><TD align='left' colspan=4><FONT color=blue>Total Actual Work(hrs) for " + m_strUserName + "&nbsp;&nbsp;&nbsp;[WSR Status]&nbsp;" + CommonFunction.HTMLControls.DrawCheckBox("chkWSRStatus", "chkWSRStatus", , blnIsCheckedSatus, m_intGroupNumber.ToString, , "OnClick=""javascript:WSR_Status(" + m_intGroupNumber.ToString + ",'" + m_strTimeSheetIDList + "')""", True) + "</FONT></TD></TD><TD align=right width=15% ><FONT color=blue>" + FormatNumber(m_GroupTotal, 2).ToString + "</FONT></TD><TD colspan=3></TD></TR>"
                'End If

                If ReadyToAuthenticate = "Y" Then
                    'Commented & Added By Rutuja D. on 4 Jan 2021 For Remove Conversion Crash
                    'Args.StringToBeInserted = "<TR class='clsTRSectionHeader'><TD align='left' colspan=4><FONT color=blue>Total Actual Work(hrs) for " + m_strUserName + "&nbsp;&nbsp;&nbsp;[WSR Status]&nbsp;" + CommonFunction.HTMLControls.DrawCheckBox("chkWSRStatus", "chkWSRStatus", , blnIsCheckedSatus, m_intGroupNumber.ToString, True, "OnClick=""javascript:WSR_Status(" + m_intGroupNumber.ToString + ",'" + m_strTimeSheetIDList + "')""", True) + "</FONT></TD></TD><TD align=right width=15% ><FONT color=blue>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + FormatNumber(m_GroupTotal, 2).ToString + "',1)", True) + "</FONT></TD><TD colspan=3></TD></TR>"
                    Args.StringToBeInserted = "<TR class='clsTRSectionHeader'><TD align='left' colspan=4><FONT color=blue>Total Actual Work(hrs) for " + m_strUserName + "&nbsp;&nbsp;&nbsp;[WSR Status]&nbsp;" + CommonFunction.HTMLControls.DrawCheckBox("chkWSRStatus", "chkWSRStatus", , blnIsCheckedSatus, m_intGroupNumber.ToString, True, "OnClick=""javascript:WSR_Status(" + m_intGroupNumber.ToString + ",'" + m_strTimeSheetIDList + "')""", True) + "</FONT></TD></TD><TD align=right width=15% ><FONT color=blue>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + m_GroupTotal.ToString + "',1)", True) + "</FONT></TD><TD colspan=3></TD></TR>"
                    'End OF Commented & Added By Rutuja D. on 4 Jan 2021 For Remove Conversion Crash
                Else
                    'Commented & Added By Rutuja D. on 4 Jan 2021 For Remove Conversion Crash
                    'Args.StringToBeInserted = "<TR class='clsTRSectionHeader'><TD align='left' colspan=4><FONT color=blue>Total Actual Work(hrs) for " + m_strUserName + "&nbsp;&nbsp;&nbsp;[WSR Status]&nbsp;" + CommonFunction.HTMLControls.DrawCheckBox("chkWSRStatus", "chkWSRStatus", , blnIsCheckedSatus, m_intGroupNumber.ToString, , "OnClick=""javascript:WSR_Status(" + m_intGroupNumber.ToString + ",'" + m_strTimeSheetIDList + "')""", True) + "</FONT></TD></TD><TD align=right width=15% ><FONT color=blue>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + FormatNumber(m_GroupTotal, 2).ToString + "',1)", True) + "</FONT></TD><TD colspan=3></TD></TR>"
                    Args.StringToBeInserted = "<TR class='clsTRSectionHeader'><TD align='left' colspan=4><FONT color=blue>Total Actual Work(hrs) for " + m_strUserName + "&nbsp;&nbsp;&nbsp;[WSR Status]&nbsp;" + CommonFunction.HTMLControls.DrawCheckBox("chkWSRStatus", "chkWSRStatus", , blnIsCheckedSatus, m_intGroupNumber.ToString, , "OnClick=""javascript:WSR_Status(" + m_intGroupNumber.ToString + ",'" + m_strTimeSheetIDList + "')""", True) + "</FONT></TD></TD><TD align=right width=15% ><FONT color=blue>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + m_GroupTotal.ToString + "',1)", True) + "</FONT></TD><TD colspan=3></TD></TR>"
                    'End OF Commented & Added By Rutuja D. on 4 Jan 2021 For Remove Conversion Crash
                End If
                'End Of Added By Usha Pandit On 25.11.2020 For getting work hours in HH:MM from decimal format
                'Commented And Added By Usha Pandit On 20.11.2020 For getting work hours in HH:MM to decimal format
                m_GrandTotal += m_GroupTotal
                'End Of Added By Usha Pandit On 20.11.2020 For getting work hours in HH:MM to decimal format
            Else
                Cancel = Not m_blnGenerateTimeSheetGridDataPresent
            End If
        Else
            Cancel = True
        End If
    End Sub

    Public Sub New()

        '=====================================================================
        ' Procedure Name        : New()	
        ' Purpose               : Constructor for the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Jan 28, 2004
        ' Revisions             :
        '=====================================================================

        'Apply security
        ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016

        'Initialize standard menu resource file 
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

    End Sub 'Constructor for the page

    Private Sub objGenerateTimeSheetGrid_SummaryFunctionsTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTD) Handles objGenerateTimeSheetGrid.SummaryFunctionsTD_BeforePrint
        If Args.ColIndex = 3 Then
            Args.StringToBeInserted = "<TD align=right>" + MyBase.GetResourceString("GRANDTOTAL") + "</TD>"
            Cancel = True
        End If
        'Added By Usha Pandit On 20.11.2020 For getting work hours in HH:MM to decimal format
        If Args.ColIndex = 4 Then
            'Commented & Added By Rutuja D. on 4 Jan 2021 For Remove Conversion Crash
            'Args.StringToBeInserted = "<TD align=right>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + FormatNumber(m_GrandTotal, 2).ToString + "',1)", True) + "</TD>"
            Args.StringToBeInserted = "<TD align=right>" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + m_GrandTotal.ToString + "',1)", True) + "</TD>"
            'End OF Commented & Added By Rutuja D. on 4 Jan 2021 For Remove Conversion Crash
            Cancel = True
        End If
        'End Of Added By Usha Pandit On 20.11.2020 For getting work hours in HH:MM to decimal format
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub


    Private Sub objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles objMenu.Before_Link_Print
        'Dim drIsFreezed As IDataReader
        'Dim intIsFreezed As Integer
        'Dim strSQL As String
        Dim strMode As String

        'strSQL = "SELECT Distinct IsFreezed FROM tbl_PM_TimeSheet WHERE ProjectID = " + CType(m_ProjectId, String) + "AND TimeSheetNo = " + CType(intTimeSheetNo, String)
        ' strSQL = "Exec usp_CheckFreezed " + CType(intTimeSheetNo, String) + ", " + CType(m_ProjectId, String)

        'Added By VivekP On 5 August 2005 For WhizibleSEM SP4 IssueID-87
        'IsFreezed = CType(CommonFunctions.Data.GetDataScalar("SELECT IsFreezed FROM Tbl_PM_TimeSheet WHERE TimesheetNo=" + intTimeSheetNo.ToString, MyBase.UseSQL), Boolean)
        'ReadyToAuthenticate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT ReadyToAuthenticate FROM tbl_PM_TimeSheetInvoice WHERE TimesheetNo=" + intTimeSheetNo.ToString, MyBase.UseSQL), ""), String)
        'Authenticated = CType(CommonFunctions.Data.GetDataScalar("SELECT Authenticated FROM tbl_PM_TimeSheetInvoice WHERE TimesheetNo=" + intTimeSheetNo.ToString, MyBase.UseSQL), String)
        'End Of addition By VivekP On 5 August For WhizibleSEM SP4 IssueID-87

        'drIsFreezed = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        'If drIsFreezed.Read Then
        '    intIsFreezed = CType(CommonFunctions.Data.CheckIsDBNull(drIsFreezed("IsFreezed"), "-1"), Integer)
        '    If (intIsFreezed = 0) Then
        '        'Modified By VivekP On 5 August 2005 For WhizibleSEM SP4 IssueID-87
        '        If Args.LinkName = "Send For Approval" Then
        '            Cancel = True
        '        End If
        '    Else
        '        If Args.LinkName = "Delete" Then
        '            Cancel = True
        '        End If
        '        'If Authenticated <> "R" Then
        '        If Args.LinkName = "Re-Generate" Then
        '            Cancel = True
        '        End If
        '        'End If
        '        'End Of Modification On 5 August 2005 For WhizibleSEM SP4
        '    End If
        'End If

        'Modified By VivekP On 5 August 2005 For WhizibleSEM SP4 IssueID-87
        If ReadyToAuthenticate = "Y" Then
            If Args.LinkName.ToUpper = "SELECT ALL" Then

                Cancel = True
            End If
            If Args.LinkName.ToUpper = "CLEAR ALL" Then
                Cancel = True
            End If
            If Args.LinkName.ToUpper = "UPDATE WSR" Then
                Cancel = True
            End If
            If Args.LinkName.ToUpper = "DELETE" Then
                Cancel = True
            End If
            If Args.LinkName.ToUpper = "RE-GENERATE" Then
                Cancel = True
            End If
            ' added by harshada d for Whiziblesem SP7 for IssueID 4557 for DA Easy Entry on 28 Jun 2006
            'Added by PrashantD "Easy Edit"
            If Args.LinkName.ToUpper = "EASY EDIT" Then
                Cancel = True
            End If
            'End of addition by PrashantD

            'end of addition by harshada d for Whiziblesem SP7 for IssueID 4557 for DA Easy Entry 28 Jun 2006
        End If
        If CType(intTimeSheetNo, String) = "0" Then
            If Args.LinkName.ToUpper = "SEND FOR APPROVAL" Then
                Cancel = True
            End If
            If Args.LinkName.ToUpper = "SELECT ALL" Then
                Cancel = True
            End If
            If Args.LinkName.ToUpper = "CLEAR ALL" Then
                Cancel = True
            End If
            If Args.LinkName.ToUpper = "UPDATE WSR" Then
                Cancel = True
            End If
            If Args.LinkName.ToUpper = "DELETE" Then
                Cancel = True
            End If
            If Args.LinkName.ToUpper = "RE-GENERATE" Then
                Cancel = True
            End If
            If Args.LinkName.ToUpper = "GENERATE WSR" Then
                Cancel = True
            End If
            ' added by harshada d for Whiziblesem SP7 for IssueID 4557 for DA Easy Entry on 28 Jun 2006
            'Added by PrashantD "Easy Edit"
            If Args.LinkName.ToUpper = "EASY EDIT" Then
                Cancel = True
            End If
            'End of addition by PrashantD
            ' end of addition by harshada d for Whiziblesem SP7 for IssueID 4557 for DA Easy Entry 28 Jun 2006
        Else
            If Args.LinkName.ToUpper = "VIEW TASK LIST" Then
                Cancel = True
            End If

            '' START : Added By ParagD On 28-Sept-2006
            '' Purpose : Whiz SP7 IssueID : 6516 
            ''           - PT :- Click on the generate link. Java script error is given.
            If Args.LinkName.ToUpper = "GENERATE TIMESHEET" Then
                Cancel = True
            End If
            '' END : Commented and Modified By ParagD On 28-Sept-2006


        End If
        If Args.LinkName.ToUpper = "FREEZE TIMESHEET" Then
            Cancel = True
        End If
        If Args.LinkName.ToUpper = "SEND MAIL" Then
            Cancel = True
        End If
        'End Of Modification On 5 August 2005 For WhizibleSEM SP4
        strMode = CType(Request.QueryString("Mode"), String)
        If strMode = "View" Then
            'If Args.LinkName = "Generate TimeSheet" Then
            '    Cancel = True
            'End If
        End If


    End Sub

    Private Sub objTaskListGrid_DataRowTD_AfterPrint(ByRef Args As WAF_DataRowTD) Handles objTaskListGrid.DataRowTD_AfterPrint

    End Sub
    'Added By Vidya J ON 1 Feb 2016
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_Calender(Year As String, Month As String, EmployeeID As String) As String
        Try
            Dim m_PKToken_Calender As String
            m_PKToken_Calender = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(Year, String) + CType(Month, String) + "0" + "0")

            Return m_PKToken_Calender
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    'End Of Added By Vidya J ON 1 Feb 2016
End Class
