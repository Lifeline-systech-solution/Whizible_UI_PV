Public Class CRM_RequestAssignment
    Inherits WebPages.Template.WhizTemplate

    Protected m_strMode As String = ""
    Public m_strAction As String = ""
    Protected m_intPrevAssignTo As Long = 0
    Protected m_strQueryID As String

    Private m_lngEmployeeID As Long
    Private m_strLoginType As String = "E"
    Private m_strUserName As String = ""
    Private m_blnUseSQL As Boolean
    Private m_blnPreviousIssuesPresent As Boolean = False
    'harshada d on 10 feb 2006 for helpdesk enhancements
    ' Private m_blnHasTimesheetDetails As Boolean = False
    Protected m_blnHasTimesheetDetails As Boolean = False
    'Protected m_blnCheckValueChanged As Boolean = False

    Protected m_lngOldAssignTo As Long
    Protected m_lngOldTaskTypeID As Long
    Protected m_lngOldProjectID As Long

    Protected m_strAssignedTasks As String
    Protected m_strPrevAssignTo As String
    'Protected m_strPrevAssignTo As String
    'end of addition by harshada d on 10 Feb 2006 for helpdesk enhancements
    'Added by SavitaS on 18 Jan 2006
    Protected m_lngTaskTypeID As String
    Protected m_fltWork As Double
    Protected m_WorkHrs As Double
    Protected m_StartDate As String
    Protected m_EndDate As String
    Protected lngProjectID As Long = 0
    Protected lngFunctionID As Long = 0
    Protected m_strPerform As String
    Protected intCntDepts As Integer = 0
    'End Addition by SavitaS
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Protected lngTaskID As Long = 0
    Protected lngProjectHours As Long
    Protected lngAllocatedHours As Long
    Public m_strProjectsOnHold As String
    'Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    'Private WithEvents m_objGrid As WebPages.Template.GenericGrid

    '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
    Protected m_strQueyID As String
    Protected m_PKToken_FromRequestDetail_Multiple As String
    '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197

    'Added BY NitinVS on 12 Mar 2007 for WhizibleSEM SP 8 IssueId 11530 
    Protected m_blnProjectOnHold As Boolean = False
    Protected m_strProjectOnHoldMessage As String = ""
    Protected m_intBaselineNumber As Integer = 0
    Protected m_strBaselineMessage As String = ""
    Protected m_blnIsProjectCreationWorkflowReqd As Boolean = False
    Protected m_dblHoursPerDay As Double = 8
    Protected m_lngWeekDays As Long = 5
    'End Addition By NitinVS on 12 Mar 2007 for WhizibleSEM SP 8  IssueId 11530 
    'Integrated by ArchanaN on 27 Apr 2007
    'Added by SrikanthY 20 Dec 2006 For implementing New Issue list section in Issue Screen 
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Protected m_PKToken As String
    'End of Addition by SrikanthY
    'Added by SrikanthY on 17 Jan 2007 for Issues 9531,9522,9521,9526
    Protected m_strSortBy As String
    Protected m_strSortOrder As String
    Protected m_ChangedProject As Long
    Protected m_ChangedResource As Long
    Protected m_ChangedType As String = ""
    Protected m_ChangedStatus As String = ""
    Protected m_strIssueId As String = ""
    'Integration Ends
    Private strRequestorSUserName As String
    Private strRequestorSLoginType As String

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
        MyBase.ApplySecurity(True)
        Call Initialize()

        '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197 
        If (UCase(Trim(m_strMode & "")) <> "ASSIGN_REQUESTS" And UCase(Trim(m_strMode & "")) <> "ASSIGN_MULTIPLE_TASKS" And UCase(Trim(m_strMode & "")) <> "ASSIGN_MULTIPLE_ISSUES") Then
            If ((m_PKToken_FromRequestDetail_Multiple = "") And (m_strQueryID.ToString <> "0")) Or ((m_strQueryID.ToString <> "0") And (CommonFunctions.Security.Token.ValidateToken(CType(m_strQueryID, String) + CType(Session("intUserID"), String) + "0" + "0", m_PKToken_FromRequestDetail_Multiple) = False)) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Help Desk Multiple Tasks", 0, 0, "Query ID", m_strQueryID.ToString)
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        ElseIf (m_PKToken_FromRequestDetail_Multiple = "" Or CommonFunctions.Security.Token.ValidateToken("0" + CType(Session("intUserID"), String) + "0" + "0", m_PKToken_FromRequestDetail_Multiple) = False) Then
            Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Help Desk Multiple Tasks", 0, 0, "Query ID", "0")
            'Token is Invalid now redirect to the Invalid Access Page
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If
        '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197   

        Dim strSQL As String
        strSQL = "select functionid ,count (functionid)as Cnt from tbl_CRM_Query_Master where queryID IN "
        strSQL += "(" & m_strQueryID & ")"
        strSQL += " group by functionid"
        Dim dr As IDataReader = CommonFunction.Data.GetDataReader(strSQL, m_blnUseSQL)

        While dr.Read
            intCntDepts = intCntDepts + 1
        End While
        CommonFunctions.Data.DisposeDataReader(dr)

        If Page.IsPostBack Then
            Call PerformActions()
        End If
    End Sub


    Public Sub New()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        MyBase.ApplySecurity(False, 2)
    End Sub


    Private Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : To initialize the module variables here
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : module variables
        ' Author                : Rajanikant
        ' Created               : Feb 20,2004 
        ' Revisions             :
        '=====================================================================
        ' Action of the page
        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If
        ' Action of the page
        If Not Request.QueryString("Mode") Is Nothing Then
            m_strMode = Request.QueryString("Mode").ToString
        Else
            m_strMode = ""
        End If
        If Not Request.QueryString("QueryID") Is Nothing Then
            m_strQueryID = Request.QueryString("QueryID").ToString
        Else
            m_strQueryID = Request.QueryString("CRMQueryID")
        End If
        'm_strQueryID = Request.QueryString("QueryID")

        m_lngEmployeeID = CType(Session("intUserID"), Long)
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString

        ' added by harshada d on 07 Feb 2006 for Helpdesk enhancements
        If Not Request.QueryString("TaskID") Is Nothing Then
            lngTaskID = CType(Request.QueryString("TaskID"), Long)
        Else
            lngTaskID = 0
        End If
        'end of addition by harshada d on 07 Feb 2006
        ' whether to use SQL?
        If Not Request.QueryString("FunctionID") Is Nothing Then
            lngFunctionID = CType(Request.QueryString("FunctionID"), Long)
        Else
            lngFunctionID = 0
        End If

        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
        If Trim(Request.QueryString("PKToken") & "") <> "" Then
            m_PKToken_FromRequestDetail_Multiple = Request.QueryString("PKToken")
        Else
            m_PKToken_FromRequestDetail_Multiple = Request.Form("txtPkToken").ToString
        End If
        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197

        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

        'Integrated by ArchanaN on 27 Apr 2007
        'SrikanthY on 17 Jan 2007 Added below code,for providing sorting option in Prev Issues section, for Issues 9531,9522,9521,9526
        ' Sort by of the page
        If Not Request.QueryString("SortBy") Is Nothing Then
            m_strSortBy = Request.QueryString("SortBy").ToString
            If MyBase.GetFormValue("cboAssignTo") <> "" Then
                m_ChangedResource = CType(MyBase.GetFormValue("cboAssignTo"), Long)
            End If
            If MyBase.GetFormValue("cboProject") <> "" Then
                m_ChangedProject = CType(MyBase.GetFormValue("cboProject"), Long)
            End If
            m_ChangedType = CType(MyBase.GetFormValue("cboType"), String)
            m_ChangedStatus = CType(MyBase.GetFormValue("cboStatus"), String)

        Else
            m_strSortBy = "IssueID"
            'If Not Session("ParentQuerySortBY") Is Nothing Then
            Session.Remove("ParentQuerySortBY")
            Session.Add("ParentQuerySortBY", m_strSortBy)
            'End If

        End If
        ' Sort order of the page
        If Not Request.QueryString("SortOrder") Is Nothing Then
            m_strSortOrder = Request.QueryString("SortOrder").ToString
        Else
            m_strSortOrder = "DESC"
            ' If Not Session("ParentQuerySortOrder") Is Nothing Then
            Session.Remove("ParentQuerySortOrder")
            Session.Add("ParentQuerySortOrder", m_strSortOrder)
            'End If

        End If
        ' Sort order of the page
        If Not Request.QueryString("SortChange") Is Nothing Then
            If Request.QueryString("SortChange").ToString = "1" Then
                Session.Remove("ParentQuerySortBY")
                Session.Remove("ParentQuerySortOrder")
                Session.Add("ParentQuerySortBY", m_strSortBy)
                Session.Add("ParentQuerySortOrder", m_strSortOrder)
            End If
        End If
        'End of addition by SrikanthY
        'Integration Ends


    End Sub

    Private Sub PerformActions()
        '=====================================================================
        ' Procedure Name        : PerformActions()	
        ' Purpose               : To take requested actions on the page
        ' Description           : The proc. performs the actions for the page
        '                         Deletes, updates and inserts are done
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : Module variables are set.
        ' Dependencies          : module variables
        ' Author                : Rajanikant
        ' Created               : Feb 20,2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim blnSendMail As Boolean
        Dim blnShowPopup As Boolean
        'Dim lngProjectID As Long = 0
        Dim lngAssignTo As Long = 0

        Dim strType As String
        Dim strSummary As String
        Dim strStatus As String
        Dim strDescription As String

        Dim dr As IDataReader
        Dim strFromEmailID As String
        Dim strToMailID As String
        Dim strCCToMailID As String
        Dim strSubject, strMessage As String

        If Trim(MyBase.GetFormValue("cboProject") & "") <> "" Then
            lngProjectID = CType(MyBase.GetFormValue("cboProject"), Long)
        End If

        'Added by SavitaS on 18 Jan 2006 to retrive Task Type,WorkHrs,Start Date,End Date and Deliverable from Assign Task Page.
        If Trim(MyBase.GetFormValue("cboTaskType") & "") <> "" Then
            m_lngTaskTypeID = CType(MyBase.GetFormValue("cboTaskType"), String)
        End If

        If Trim(MyBase.GetFormValue("txtWork") & "") <> "" Then
            m_fltWork = CType(MyBase.GetFormValue("txtWork"), Double)
        End If

        If MyBase.GetFormValue("txtStartDate").Trim <> "" Then
            m_StartDate = "'" & CommonFunctions.Dates.GetDate(CType(MyBase.GetFormValue("txtStartDate"), Date)) & "'"
        Else
            m_StartDate = "NULL"
        End If

        If MyBase.GetFormValue("txtEndDate").Trim <> "" Then
            m_EndDate = "'" & CommonFunctions.Dates.GetDate(CType(MyBase.GetFormValue("txtEndDate"), Date)) & "'"
        Else
            m_EndDate = "NULL"
        End If
        'End addition by SavitaS on 18 Jan 2006

        If Trim(MyBase.GetFormValue("cboAssignTo") & "") <> "" Then
            lngAssignTo = CType(MyBase.GetFormValue("cboAssignTo"), Long)
        End If
        If Trim(MyBase.GetFormValue("txtTaskID") & "") <> "" Then
            lngTaskID = CType(MyBase.GetFormValue("txtTaskID"), Long)
        End If


        strType = MyBase.GetFormValue("cboType")
        strStatus = MyBase.GetFormValue("cboStatus")
        strSummary = MyBase.GetFormValue("txtSummary")
        strDescription = MyBase.GetFormValue("txtDescription")

        If UCase(Trim(m_strAction & "")) = "SAVE" Then
            Select Case UCase(Trim(m_strMode & ""))

                Case "ASSIGN_REQUESTS"
                    '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
                    If (m_PKToken_FromRequestDetail_Multiple = "" Or CommonFunctions.Security.Token.ValidateToken("0" + CType(Session("intUserID"), String) + "0" + "0", m_PKToken_FromRequestDetail_Multiple) = False) Then
                        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Help Desk Multiple Tasks", 0, 0, "Query ID", CType(0, String))
                        'Token is Invalid now redirect to the Invalid Access Page
                        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                    End If
                    '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197   

                    ' assign the requests the selected resource
                    'Commented and Modified By ShraddhaM on 9,Jan 2008 to update modifiedBy in tbl_CRM_Query_Master
                    'ctype(Session("strUserName"),String)
                    'Call CommonFunction.Data.InsertOrUpdateData("usp_CRM_Assign_Multiple_Requests " & lngAssignTo & ",'" & m_strQueryID & "'", m_blnUseSQL)
                    Call CommonFunction.Data.InsertOrUpdateData("usp_CRM_Assign_Multiple_Requests " & lngAssignTo & ",'" & m_strQueryID & "','" & CType(Session("strUserName"), String) & "'", m_blnUseSQL)
                    'End of comment and modification By ShraddhaM on 9,Jan 2008 to update modifiedBy in tbl_CRM_Query_Master
                    ' Assignment Email
                    blnSendMail = False : blnShowPopup = False
                    dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 43", m_blnUseSQL)
                    If dr.Read Then
                        blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
                        blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
                    End If
                    CommonFunctions.Data.DisposeDataReader(dr)

                    If blnSendMail Then
                        If blnShowPopup Then
                            With Response
                                .Write("<script language=javascript>")
                                .Write("window.open (""../General/SendEmail.aspx?MessageID=43&MultipleRequests=1&QueryID=" & m_strQueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                                .Write("</script>")
                            End With
                        Else
                            ' silent mail
                            CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_43(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, m_strQueryID, True)
                            CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                        End If
                    End If

                Case "ASSIGN_TASK", "ASSIGN_TASK,ADD_NEW"
                    ' assign selected request as task
                    '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197 
                    If ((m_PKToken_FromRequestDetail_Multiple = "") And (m_strQueryID.ToString <> "0")) Or ((m_strQueryID.ToString <> "0") And (CommonFunctions.Security.Token.ValidateToken(CType(m_strQueryID, String) + CType(Session("intUserID"), String) + "0" + "0", m_PKToken_FromRequestDetail_Multiple) = False)) Then
                        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Help Desk Assign_Task", 0, 0, "Query ID", CType(m_strQueryID, String))
                        'Token is Invalid now redirect to the Invalid Access Page 
                        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                    End If
                    Call CommonFunction.Data.InsertOrUpdateData("usp_CRM_Assign_Task " & lngProjectID & "," & lngAssignTo & "," & m_strQueryID & "," & m_lngTaskTypeID & "," & m_fltWork & "," & m_StartDate & "," & m_EndDate & "," & lngTaskID, m_blnUseSQL)
                    '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197

                Case "ASSIGN_MULTIPLE_TASKS"
                    '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
                    If (m_PKToken_FromRequestDetail_Multiple = "" Or CommonFunctions.Security.Token.ValidateToken("0" + CType(Session("intUserID"), String) + "0" + "0", m_PKToken_FromRequestDetail_Multiple) = False) Then
                        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Help Desk Multiple Tasks", 0, 0, "Query ID", CType(0, String))
                        'Token is Invalid now redirect to the Invalid Access Page
                        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                    End If
                    '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197 

                    ' assign multiple requests as tasks to the selected resource
                    Call CommonFunction.Data.InsertOrUpdateData("usp_CRM_Assign_Task " & lngProjectID & "," & lngAssignTo & "," & "'" & CommonFunctions.General.BuildQueryString(m_strQueryID & "") & "'," & m_lngTaskTypeID & "," & m_fltWork & "," & m_StartDate & "," & m_EndDate, m_blnUseSQL)
                Case "ASSIGN_ISSUE"

                    '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
                    If ((m_PKToken_FromRequestDetail_Multiple = "") And (m_strQueryID.ToString <> "0")) Or ((m_strQueryID.ToString <> "0") And (CommonFunctions.Security.Token.ValidateToken(CType(m_strQueryID, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String), m_PKToken_FromRequestDetail_Multiple) = False)) Then
                        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Help Desk Assign_Task", 0, 0, "Query ID", CType(m_strQueryID, String))
                        'Token is Invalid now redirect to the Invalid Access Page   
                        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                    End If
                    '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197


                    ' assign request as issue 
                    strSQL = "usp_CRM_Assign_Issue "
                    strSQL = strSQL & lngProjectID & ","
                    strSQL = strSQL & lngAssignTo & ","
                    strSQL = strSQL & "'" & strType & "',"
                    strSQL = strSQL & "'" & strStatus & "',"
                    strSQL = strSQL & "'" & m_strUserName & "',"
                    strSQL = strSQL & "'" & m_strLoginType & "',"
                    strSQL = strSQL & m_strQueryID & ","
                    strSQL = strSQL & "'" & strSummary & "',"
                    strSQL = strSQL & "'" & strDescription & "',"
                    'Added by PrashantD on 21 March 2007 for Product Association
                    If (Not Request.Form("cboPriority") Is Nothing) And Request.Form("cboPriority") <> "" Then
                        strSQL = strSQL & "'" & CommonFunction.General.BuildQueryString(Request.Form("cboPriority")) & "',"
                    Else
                        strSQL = strSQL & "NULL,"
                    End If
                    If (Not Request.Form("cboSeverity") Is Nothing) And Request.Form("cboSeverity") <> "" Then
                        strSQL = strSQL & "'" & CommonFunction.General.BuildQueryString(Request.Form("cboSeverity")) & "',"
                    Else
                        strSQL = strSQL & "NULL,"
                    End If

                    If (Not Request.Form("CustomerID") Is Nothing) And Request.Form("CustomerID") <> "" Then
                        strSQL = strSQL & Request.Form("CustomerID") & ","
                    Else
                        strSQL = strSQL & "NULL,"
                    End If
                    If (Not Request.Form("ProductVersionID") Is Nothing) And Request.Form("ProductVersionID") <> "" Then
                        strSQL = strSQL & Request.Form("ProductVersionID") & ","
                    Else
                        strSQL = strSQL & "NULL,"
                    End If
                    If (Not Request.Form("ComponentID") Is Nothing) And Request.Form("ComponentID") <> "" Then
                        strSQL = strSQL & Request.Form("ComponentID")
                    Else
                        strSQL = strSQL & "NULL"
                    End If



                    'End of addition by PrashantD on 21 March 2007
                    'Commenteted and Modified By JyotiG For Help Desk Request 
                    'Purpose : While converting Help Desk to issue pass all the attachements to that issue.
                    'Call CommonFunction.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                    m_strIssueId = CStr(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL))
                    PerformAttachment(m_strIssueId, m_strQueryID)
                    'End of modification by JyotiG
                    ' now since issue is enetered it will have previous issues link
                    m_blnPreviousIssuesPresent = True

                Case "ASSIGN_MULTIPLE_ISSUES"

                    ' assign requests as issues
                    strSQL = "usp_CRM_Assign_Multiple_Issues "
                    strSQL = strSQL & lngProjectID & ","
                    strSQL = strSQL & lngAssignTo & ","
                    strSQL = strSQL & "'" & strType & "',"
                    strSQL = strSQL & "'" & strStatus & "',"
                    strSQL = strSQL & "'" & m_strUserName & "',"
                    strSQL = strSQL & "'" & m_strLoginType & "',"
                    strSQL = strSQL & "'" & m_strQueryID & "',"
                    strSQL = strSQL & "'" & strSummary & "',"
                    strSQL = strSQL & "'" & strDescription & "'"

                    Call CommonFunction.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

                    ' now since issues are enetered it will have previous issues link
                    m_blnPreviousIssuesPresent = True

                Case Else
                    ' do nothing
            End Select


        End If
    End Sub

    Protected Sub WritePage()
        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : To write the page for adding report to user Dashboards
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : module variables are set before this
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Feb 20,2004
        ' Revisions             :
        '=====================================================================
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_TIMESHEETDETAILS"), MyBase.GetResourceString("MENU_PREVIOUSISSUES"), MyBase.GetResourceString("MENU_ASSIGN"), MyBase.GetResourceString("MENU_BACK"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_TIMESHEETDETAILS_TOOLTIP"), MyBase.GetResourceString("MENU_PREVIOUSISSUES_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGN_TOOLTIP"), MyBase.GetResourceString("MENU_BACK_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
        Dim arrCSFunction() As String = {"TimesheetDetails_OnClick()", "PreviousIssues_OnClick()", "Assign_OnClick(" & m_strQueryID & ")", "Back_OnClick()", "Close_OnClick()", "Help_OnClick('ASSIGN_TASK')"}


        Dim dr As IDataReader
        Dim strSQL As String
        Dim strMenu As String
        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}
        ' Dim lngProjectID As Long = 0
        Dim lngAssignTo As Long = 0
        'Dim lngFunctionID As Long = 0

        Dim strType As String
        Dim strSubject As String
        Dim strSummary As String
        Dim strStatus As String
        Dim strDescription As String

        'Integrated by ArchanaN on 27 Apr 2007
        If Trim(MyBase.GetFormValue("cboProject") & "") <> "" Then
            lngProjectID = CType(MyBase.GetFormValue("cboProject"), Long)


            'Added by PrashantD on 25 Feb 2006
            If (UCase(Trim(m_strMode & "")) = "ASSIGN_TASK" Or UCase(Trim(m_strMode & "")) = "ASSIGN_MULTIPLE_TASKS") Then
                dr = CommonFunction.Data.GetDataReader("select ExpectedStartDate,ExpectedEndDate from tbl_PM_Project where ProjectID = " + lngProjectID.ToString, MyBase.UseSQL)
                If dr.Read Then
                    If Not IsDBNull(dr("ExpectedStartDate")) Then
                        Response.Write("<input type=hidden id=hidProjectStartDate name=hidProjectStartDate value=" + CDate(dr("ExpectedStartDate")).ToString("dd-MMM-yyyy") + " />")
                    Else
                        Response.Write("<input type=hidden id=hidProjectStartDate name=hidProjectStartDate value=0 />")
                    End If
                    If Not IsDBNull(dr("ExpectedEndDate")) Then
                        Response.Write("<input type=hidden id=hidProjectEndDate name=hidProjectEndDate value=" + CDate(dr("ExpectedEndDate")).ToString("dd-MMM-yyyy") + " />")
                    Else
                        Response.Write("<input type=hidden id=hidProjectEndDate name=hidProjectEndDate value=0 />")
                    End If
                End If
                CommonFunction.Data.DisposeDataReader(dr)
            End If

            'End Of addition
        End If

        'Integration Ends



        If Trim(MyBase.GetFormValue("cboAssignTo") & "") <> "" Then
            lngAssignTo = CType(MyBase.GetFormValue("cboAssignTo"), Long)
        End If

        If Trim(Request.QueryString("ProjectChanged")) = "1" Then
            strType = ""
            'Integrated by ArchanaN on 27 Apr 2007 issues 9531,9522,9521,9526
            lngAssignTo = 0
            If MyBase.GetFormValue("cboProject") <> "" Then
                m_ChangedProject = CType(MyBase.GetFormValue("cboProject"), Long)
            End If

            'Integration Ends

        Else
            strType = MyBase.GetFormValue("cboType", False)
        End If

        'Integrated by ArchanaN on 27 Apr 2007
        If Trim(Request.QueryString("TypeChanged")) = "1" Then

            If MyBase.GetFormValue("cboAssignTo") <> "" Then
                m_ChangedResource = CType(MyBase.GetFormValue("cboAssignTo"), Long)
            End If
            If MyBase.GetFormValue("cboProject") <> "" Then
                m_ChangedProject = CType(MyBase.GetFormValue("cboProject"), Long)
            End If
            m_ChangedType = CType(MyBase.GetFormValue("cboType", False), String)
        End If
        'Integration Ends

        strStatus = MyBase.GetFormValue("cboStatus", False)
        strSummary = MyBase.GetFormValue("txtSummary", False)
        strDescription = MyBase.GetFormValue("txtDescription", False)
        ' modified by harshada d for helpdesk enhancements on  11 Feb 2006
        'If (UCase(Trim(m_strMode & "")) = "ASSIGN_TASK") then
        If (UCase(Trim(m_strMode & "")) = "ASSIGN_TASK" Or UCase(Trim(m_strMode & "")) = "ASSIGN_MULTIPLE_TASKS") Then

            dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestDetails_AssignTo	" & "'" & m_strQueryID & "'", m_blnUseSQL)
            If dr.Read Then
                'm_intPrevAssignTo = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeID"), "0"), Long)
                m_strPrevAssignTo = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeList"), "0"), String)
            End If
        End If
        ' modified by harshada d for helpdesk enhancements on  11 Feb 2006

        CommonFunction.Data.DisposeDataReader(dr)

        Dim drMultipleRequests As IDataReader
        'If (UCase(Trim(m_strMode & "")) = "ASSIGN_MULTIPLE_TASKS") Or (UCase(Trim(m_strMode & "")) = "ASSIGN_ISSUE") Then
        If (UCase(Trim(m_strMode & "")) = "ASSIGN_MULTIPLE_TASKS") Then
            'dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestDetails	'" & m_strQueryID & "'", m_blnUseSQL)
            drMultipleRequests = CommonFunction.Data.GetDataReader("usp_CRM_getFunctionID " & "'" & m_strQueryID & "'", m_blnUseSQL)
            If drMultipleRequests.Read Then
                lngFunctionID = CType(CommonFunctions.Data.CheckIsDBNull(drMultipleRequests("FunctionID"), "0"), Long) ' assigned to
            End If
        End If
        CommonFunction.Data.DisposeDataReader(drMultipleRequests)
        'following block is moved and modifed from below by PrashantD on 8 Aug 2007
        If UCase(Trim(m_strMode & "")) = "ASSIGN_ISSUE" Then

            ' get the default summary & description for the issue to be added

            drMultipleRequests = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestDetails " & m_strQueryID, m_blnUseSQL)
            If drMultipleRequests.Read Then
                lngFunctionID = CType(CommonFunctions.Data.CheckIsDBNull(drMultipleRequests("FunctionID"), "0"), Long) ' assigned to
                strRequestorSLoginType = drMultipleRequests("LoginType").ToString
                strRequestorSUserName = drMultipleRequests("CustomerID").ToString
                ' the default summary for the user
                'Commented & Added By AmitJ For SP7 Issue: Addition of RequestId in summary Field 
                'strSummary = "Help Request->" &  dr("Subject").ToString & ""
                If Trim(strSummary & "") = "" Then
                    strSummary = "Help Request->" & m_strQueryID & "-->" & drMultipleRequests("Subject").ToString & ""
                    'End of Modifications By AmitJ

                    ' the default desc. for the user
                    If Trim(drMultipleRequests("Description").ToString & "") = "" Then
                        strDescription = drMultipleRequests("Subject").ToString & ""
                    Else
                        strDescription = drMultipleRequests("Description").ToString & ""
                    End If

                End If
                CommonFunction.Data.DisposeDataReader(drMultipleRequests)
            End If

        End If
        'End of move by PrashantD

        ' get the function id & employee id for "Assign Task", "Assign Issue Mode"
        If lngAssignTo = 0 And (UCase(Trim(m_strMode & "")) = "ASSIGN_TASK") Then
            'dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestDetails	'" & m_strQueryID & "'", m_blnUseSQL)
            dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestDetails " & "'" & m_strQueryID & "'", m_blnUseSQL)
            If dr.Read Then
                lngFunctionID = CType(CommonFunctions.Data.CheckIsDBNull(dr("FunctionID"), "0"), Long)
                ' assigned to
                lngAssignTo = CType(CommonFunctions.Data.CheckIsDBNull(dr("TaskEmployeeID"), "0"), Long)
                If lngAssignTo = 0 Then
                    lngAssignTo = CType(CommonFunctions.Data.CheckIsDBNull(dr("AssignTo"), "0"), Long)
                End If
            End If
            CommonFunction.Data.DisposeDataReader(dr)

            dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_Request_Task_Details  " & "'" & m_strQueryID & "'", m_blnUseSQL)
            If dr.Read Then
                lngProjectID = CType(CommonFunctions.Data.CheckIsDBNull(dr("ProjectID"), "0"), Long)
            End If
            CommonFunction.Data.DisposeDataReader(dr)
        End If

        ' get the department 
        If lngFunctionID = 0 Then
            lngFunctionID = GetEmployeeDepartment(m_lngEmployeeID)
        End If

        If Trim(MyBase.GetFormValue("cboProject") & "") <> "" Then
            lngProjectID = CType(MyBase.GetFormValue("cboProject"), Long)

        End If

        ' get the default project 
        If lngProjectID = 0 Then
            lngProjectID = GetDefaultProject(lngFunctionID)
        End If



        'Added by PrashantD on 25 Feb 2006
        If (UCase(Trim(m_strMode & "")) = "ASSIGN_TASK" Or UCase(Trim(m_strMode & "")) = "ASSIGN_MULTIPLE_TASKS") Then
            dr = CommonFunction.Data.GetDataReader("select ExpectedStartDate,ExpectedEndDate from tbl_PM_Project where ProjectID = " + lngProjectID.ToString, MyBase.UseSQL)
            If dr.Read Then
                If Not IsDBNull(dr("ExpectedStartDate")) Then
                    Response.Write("<input type=hidden id=hidProjectStartDate name=hidProjectStartDate value=" + CDate(dr("ExpectedStartDate")).ToString("dd-MMM-yyyy") + " />")
                Else
                    Response.Write("<input type=hidden id=hidProjectStartDate name=hidProjectStartDate value=0 />")
                End If
                If Not IsDBNull(dr("ExpectedEndDate")) Then
                    Response.Write("<input type=hidden id=hidProjectEndDate name=hidProjectEndDate value=" + CDate(dr("ExpectedEndDate")).ToString("dd-MMM-yyyy") + " />")
                Else
                    Response.Write("<input type=hidden id=hidProjectEndDate name=hidProjectEndDate value=0 />")
                End If
            End If
            CommonFunction.Data.DisposeDataReader(dr)
        End If

        m_blnIsProjectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_PM_GetProjectCreationWorkflowReqd_Status " & CommonFunction.General.CheckIsNothing(lngProjectID, "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)

        'End Of addition

        'Added BY NitinVS on 12 Mar 2007 for WhizibleSEM SP 8 IssueId 11530 
        strSQL = "Exec usp_Sel_tbl_CNF_Project_Status " + lngProjectID.ToString()
        dr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(dr) <> "" Then
            If dr.Read() Then
                m_blnProjectOnHold = CType(CommonFunctions.Data.CheckIsDBNull(dr.Item("ProjectOnHold"), "False"), Boolean)
                m_strProjectOnHoldMessage = CommonFunctions.General.CheckIsNothing(dr.Item("ProjectOnHoldMsg"), "")
                'Added by VidyaJ on  Jan 15, 2005
                'For IssueID - 15416
                m_intBaselineNumber = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("BaselineNumber"), "0"), "0"), Integer)
                m_strBaselineMessage = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("BaseLineMessage"), ""), ""), String)
                'End of addition 
            End If
        End If
        CommonFunction.Data.DisposeDataReader(dr)
        'End Addition BY NitinVS on 12 Mar 2007 for WhizibleSEM SP 8 IssueId 11530 

        'Get the WeekDays and Hours Per Day
        strSQL = "Exec usp_Get_ProjectLocationWorkingHours_Days " & lngProjectID.ToString()
        dr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(dr) <> "" Then
            If dr.Read() Then
                m_dblHoursPerDay = CType(CommonFunctions.Data.CheckIsDBNull(dr.Item("WorkingHours"), "0"), Double)
                m_lngWeekDays = CType(CommonFunctions.Data.CheckIsDBNull(dr.Item("WorkingDays"), "0"), Long)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
        strSQL = ""
        If UCase(Trim(m_strMode & "")) = "ASSIGN_TASK" And UCase(Trim(m_strAction & "")) = "EDIT" Then

            ' are there any timesheet entries for the request and for the same employee?
            If lngTaskID <> 0 Then
                Dim drTimesheet As IDataReader = CommonFunction.Data.GetDataReader("select dailyActivityEntryID from tbl_PM_DailyActivity Where TaskID = " & lngTaskID, m_blnUseSQL)
                If drTimesheet.Read Then
                    m_blnHasTimesheetDetails = True
                Else
                    m_blnHasTimesheetDetails = False
                    CommonFunction.Data.DisposeDataReader(drTimesheet)
                End If
            End If
        End If

        If UCase(Trim(m_strMode & "")) = "ASSIGN_ISSUE" Then
            If m_blnPreviousIssuesPresent = False Then
                ' are any issues already present for the request?
                m_blnPreviousIssuesPresent = CheckIssues(m_strQueryID)
            End If
        Else
            m_blnPreviousIssuesPresent = False
        End If

        ' change the help id
        Select Case UCase(Trim(m_strMode & ""))
            Case "ASSIGN_REQUESTS"
                'harshada 07 feb 2006 for helpdesk enhancements
                arrCSFunction(5) = "Help_OnClick('ASSIGN_MULTIPLE_REQUESTS')"
            Case "ASSIGN_MULTIPLE_TASKS"
                arrCSFunction(5) = "Help_OnClick('ASSIGN_MULTIPLE_TASKS')"
                'harshada 07 feb 2006 for helpdesk enhancements
            Case "ASSIGN_TASK"
                arrCSFunction(5) = "Help_OnClick('ASSIGN_TASK')"
            Case "ASSIGN_ISSUE"
                arrCSFunction(5) = "Help_OnClick('ASSIGN_ISSUE')"
                If m_blnPreviousIssuesPresent Then
                    arrMenu(1) = MyBase.GetResourceString("MENU_PREVIOUSISSUES") & "(" & GetIssueCount(m_strQueryID) & ")"
                End If
        End Select

        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)

        MyBase.InitializeResources("AppResources.CRM_RequestAssignment", "AppResources")

        With Response
            ' menu
            .Write(strMenu)

            'legends    
            WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend)

            'page caption
            Select Case UCase(Trim(m_strMode & ""))
                Case "ASSIGN_REQUESTS" : .Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAPTION_ASSIGNMULTIPLEREQUESTS")))
                Case "ASSIGN_MULTIPLE_TASKS" : .Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAPTION_ASSIGNMULTIPLETASKS")))
                Case "ASSIGN_TASK" : .Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAPTION_ASSIGNTASK")))
                Case "ASSIGN_ISSUE" : .Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAPTION_ASSIGNISSUE")))
            End Select

            .Write("<BR>")
            'Modified By sonalD on 17th Sept 2008 IssueID-22520
            'Purpose : added grid when Mode is 'Assign_Task' and To have proper alignment in Mozilla
            '.Write("<div id=DivList Style='Overflow:None;width=100%;height=300' >")
            .Write("<div id=DivMain Style='Overflow:auto;width=100%;height=300' >")
            'End of modification by sonalD 

            'Integrated by ArchanaN on 27 Apr 2007
            'Added by SrikanthY on 1 Mar 2007 , To show the Parent Request Details While Assigning Issues,Tasks
            Select Case UCase(Trim(m_strMode & ""))
                Case "ASSIGN_TASK" : DrawParentDetails(m_strQueryID.ToString)
                    .Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAPTION_ASSIGNTASK")))
                    .Write("<BR>")
                Case "ASSIGN_ISSUE" : DrawParentDetails(m_strQueryID.ToString)
                    .Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAPTION_ASSIGNISSUE")))
                    .Write("<BR>")
            End Select
            'End of Code Addition by SrikanthY on 1 Mar 2007

            'Integration Ends
            .Write("<Table class=clsTable cellpadding=0 cellspacing=0 width=99.9%>")


            If UCase(Trim(m_strMode & "")) = "ASSIGN_ISSUE" Then
                'Code Commented by PrashantD on 8 Aug 2007 . Move this commneted part to above
                '    ' get the default summary & description for the issue to be added
                '    If Trim(strSummary & "") = "" Then
                '        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestDetails " & m_strQueryID, m_blnUseSQL)
                '        If dr.Read Then
                '            ' the default summary for the user
                '            'Commented & Added By AmitJ For SP7 Issue: Addition of RequestId in summary Field 
                '            'strSummary = "Help Request->" &  dr("Subject").ToString & ""
                '            strSummary = "Help Request->" & m_strQueryID & "-->" & dr("Subject").ToString & ""
                '            'End of Modifications By AmitJ

                '            ' the default desc. for the user
                '            If Trim(dr("Description").ToString & "") = "" Then
                '                strDescription = dr("Subject").ToString & ""
                '            Else
                '                strDescription = dr("Description").ToString & ""
                '            End If

                '        End If
                '        CommonFunction.Data.DisposeDataReader(dr)
                '    End If
                'End of comment by PrashantD 

                ' capture the summary & description for issues
                .Write("<tr class=clsTREven>" & vbCrLf)
                .Write("<td  width='30%' align=right VAlign=top>" & MyBase.GetResourceString("CAPTION_SUMMARY") & "</td>" & vbCrLf)
                .Write("<td  width='70%'>" & vbCrLf)
                'Modified By ShraddhaM on 27 July 2006
                CommonFunctions.HTMLControls.DrawTextArea("txtSummary", "txtSummary", "Summary", , , "frmRequestAssignment", , , 350, 90, , strSummary, , , , , , , , , True, , , , , , "Soft", )
                .Write("</TD>")
                .Write("</tr>" & vbCrLf)
                .Write("<tr class=clsTREven>" & vbCrLf)
                .Write("<td  width='30%' align=right VAlign=Top>" & MyBase.GetResourceString("CAPTION_DESCRIPTION") & "</td>" & vbCrLf)
                .Write("<td  width='70%'>" & vbCrLf)
                'Modified By ShraddhaM on 27 July 2006
                CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "frmRequestAssignment", , , 350, 90, , strDescription, , , , , , , , , True, , , , , , "Soft", )
                .Write("</TD>")
                .Write("</tr>" & vbCrLf)



            End If

            Dim drProjectsOnHold As IDataReader
            Dim strSQLQuery As String

            m_strProjectsOnHold = ""
            strSQLQuery = " Select ProjectID From tbl_PM_Project where ProjectStatusID in ( Select ProjectStatusID From tbl_CNF_ProjectStatus Where MaptoProjectOnHold=1) "

            drProjectsOnHold = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            While drProjectsOnHold.Read
                m_strProjectsOnHold = m_strProjectsOnHold & "," & CType(CommonFunction.Data.CheckIsDBNull(drProjectsOnHold("ProjectID"), "0"), String) & ","

            End While

            CommonFunction.Data.DisposeDataReader(drProjectsOnHold)



            Select Case UCase(Trim(m_strMode & ""))
                '-------------------------------------------------------------------------------------------------------
                'Added by SavitaS on 17 Jan 2006 to add Task Type,WorkHrs,Start Date,End Date and Deliverable on Assign Task Page.
                Case "ASSIGN_TASK", "ASSIGN_MULTIPLE_TASKS", "ASSIGN_TASK,ADD_NEW"
                    If m_strAction = "ADD_NEW" Or m_strAction = "" Then
                        Dim strSQLTaskType As String
                        Dim strSelSQL As String
                        Dim strStartDate As DateTime
                        Dim strEndDate As String = ""
                        Dim strSubmittedDate As DateTime
                        Dim lngDeliverableID As Long
                        Dim dr1 As IDataReader
                        'Dim drGetDeliverable As IDataReader
                        Dim drWorkHrs As IDataReader
                        Dim lngsubRequesttypeID As Long
                        Dim lngTaskType As Long
                        ' If lngProjectID <> 0 Then
                        If CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboProject"), "0"), String) <> "0" Then
                            If CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboProject"), "0"), String) = "" Then
                                lngProjectID = 0
                            Else
                                lngProjectID = CType(MyBase.GetFormValue("cboProject"), Long)
                            End If
                        Else
                            lngProjectID = 0
                            'Get Default Project
                            Dim strDefaultProject As String
                            strDefaultProject = "select ISNULL(ProjectID,0) as ProjectID from tbl_CRM_Function_projects Where FunctionID=" & lngFunctionID & "  And IsDefaultProject=1 "

                            lngProjectID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strDefaultProject, True), "0"), Long)


                        End If
                        'added by harshada d on 12 March 2006 for whiziblesem 6 helpdesk enhancements for issue id 1936
                        dr = CommonFunction.Data.GetDataReader("usp_Sel_PM_DepartmentBalanceLCE " + lngProjectID.ToString, MyBase.UseSQL)
                        If dr.Read Then
                            lngProjectHours = CType(CommonFunctions.Data.CheckIsDBNull(dr("LCETotal"), "0"), Long)
                            lngAllocatedHours = CType(CommonFunctions.Data.CheckIsDBNull(dr("AllocatedLCETotal"), "0"), Long)
                        End If
                        CommonFunctions.Data.DisposeDataReader(dr)
                        'end of addition by harshada for issue id 1936



                        ' project combo box
                        .Write("<tr class=clsTREven><td  width='30%' align=right>" & MyBase.GetResourceString("CAPTION_PROJECT") & "</td>" & vbCrLf)
                        .Write("<td  width='70%'>" & vbCrLf)
                        If intCntDepts > 1 Then
                            CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_CRM_ProjectList_ForFunction 0", 0, lngProjectID.ToString, "onchange=javascript:cboProject_OnChange()", True, , , True)
                        Else
                            CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_CRM_ProjectList_ForFunction " & lngFunctionID, 0, lngProjectID.ToString, "onchange=javascript:cboProject_OnChange()", True, , , True)
                        End If


                        .Write("</td></tr>" & vbCrLf)
                        'Task Type
                        strSQLTaskType = "Exec usp_Sel_TaskTypeMappedToProject " & lngProjectID.ToString
                        .Write("<tr class=clsTREven><td  width='30%' align=right>" & MyBase.GetResourceString("CAPTION_TASK_TYPE") & "</td>" & vbCrLf)
                        .Write("<td  width='70%'>" & vbCrLf)

                        'Select Task type corresponding to respective Sub Request Type and show it as default value in combo
                        'harsjada on 02 Feb 2006
                        strSelSQL = "Select SubRequestTypeID from tbl_crm_query_master where QueryId IN (" & m_strQueryID & ")"
                        dr1 = CommonFunctions.Data.GetDataReader(strSelSQL, MyBase.UseSQL)
                        If dr1.Read Then
                            lngsubRequesttypeID = CType(CommonFunctions.Data.CheckIsDBNull(dr1("SubRequestTypeID"), "0"), Long)
                        End If
                        CommonFunctions.Data.DisposeDataReader(dr1)

                        strSelSQL = "SELECT tbl_PM_TaskTypes.TaskTypeID,tbl_CRM_SubRequestType.TaskType FROM tbl_PM_TaskTypes,tbl_CRM_SubRequestType WHERE tbl_PM_TaskTypes.TaskType=tbl_CRM_SubRequestType.TaskType and tbl_CRM_SubRequestType.SubRequestTypeID=" & lngsubRequesttypeID
                        dr1 = CommonFunctions.Data.GetDataReader(strSelSQL, MyBase.UseSQL)
                        If dr1.Read Then
                            lngTaskType = CType(CommonFunctions.Data.CheckIsDBNull(dr1("TaskTypeID"), "0"), Long)
                        End If
                        CommonFunctions.Data.DisposeDataReader(dr1)

                        CommonFunctions.HTMLControls.DrawComboBox("cboTaskType ", strSQLTaskType, 0, lngTaskType.ToString, , True, , , True)
                        .Write("</td></tr>" & vbCrLf)

                        'Work hrs

                        .Write("<tr class=clsTREven><td  width='30%' align=right>" & MyBase.GetResourceString("CAPTION_WORK") & "</td>" & vbCrLf)
                        .Write("<td  width='70%'>" & vbCrLf)

                        strSelSQL = "Select SubRequestTypeID,DefaultWork from tbl_CRM_SubRequestType where SubRequestTypeID=" & lngsubRequesttypeID
                        drWorkHrs = CommonFunctions.Data.GetDataReader(strSelSQL, MyBase.UseSQL)
                        If drWorkHrs.Read Then
                            m_WorkHrs = CType(CommonFunctions.Data.CheckIsDBNull(drWorkHrs("DefaultWork"), "0"), Double)
                        End If

                        CommonFunctions.Data.DisposeDataReader(drWorkHrs)
                        CommonFunctions.HTMLControls.DrawTextBox("txtWork", "txtWork", , 50, , m_WorkHrs.ToString, , , False, , , , , , True)
                        .Write("</td></tr>" & vbCrLf)

                        'Start Date

                        strSelSQL = "Select SubmittedDate from tbl_CRM_Query_Master where QueryID IN (" & m_strQueryID & ")"
                        dr1 = CommonFunctions.Data.GetDataReader(strSelSQL, m_blnUseSQL)
                        If dr1.Read Then
                            'strStartDate = CommonFunction.Data.CheckIsDBNull(dr1("SubmittedDate"), "").ToString()
                            strStartDate = CType(CommonFunction.Data.CheckIsDBNull(dr1("Submitteddate"), ""), Date)
                        End If
                        CommonFunctions.Data.DisposeDataReader(dr1)

                        .Write("<tr class=clsTREven><td  width='30%' align=right>" & MyBase.GetResourceString("CAPTION_START_DATE") & "</td>" & vbCrLf)
                        .Write("<td  width='70%'>" & vbCrLf)
                        'CommonFunctions.HTMLControls.DrawDateControl("txtStartDate", "txtStartDate", , , strStartDate, , "frmRequestAssignment", , , , False, True, , , True)
                        CommonFunctions.HTMLControls.DrawDateControl("txtStartDate", "txtStartDate", , , CommonFunctions.Dates.GetDate(strStartDate), , "frmRequestAssignment", , , , False, True, , , True)
                        .Write("</td></tr>" & vbCrLf)

                        'End Date

                        strSelSQL = "Select ExpectedResolvedDate from tbl_CRM_Query_Master where QueryID IN (" & m_strQueryID & ")"
                        dr1 = CommonFunctions.Data.GetDataReader(strSelSQL, m_blnUseSQL)
                        If dr1.Read Then
                            strEndDate = CommonFunction.Data.CheckIsDBNull(dr1("ExpectedResolvedDate"), "").ToString
                        End If
                        CommonFunctions.Data.DisposeDataReader(dr1)

                        .Write("<tr class=clsTREven><td  width='30%' align=right>" & MyBase.GetResourceString("CAPTION_END_DATE") & "</td>" & vbCrLf)
                        .Write("<td  width='70%'>" & vbCrLf)
                        'CommonFunctions.HTMLControls.DrawDateControl("txtEndDate", "txtEndDate", , , strEndDate, , "frmRequestAssignment", , , , False, True, , , True)
                        CommonFunctions.HTMLControls.DrawDateControl("txtEndDate", "txtEndDate", , , , , "frmRequestAssignment", , , , False, True, , , True)
                        .Write("</td></tr>" & vbCrLf)

                        ' resources of the project 
                        .Write("<tr class=clsTREven><td  width='30%' align=right>" & MyBase.GetResourceString("CAPTION_ASSIGNTO") & "</td>" & vbCrLf)
                        .Write("<td  width='70%'>" & vbCrLf)
                        Dim strSQLAssignTo As String = "usp_CRM_Get_ProjectEmployees " & lngProjectID & ",0"

                        CommonFunctions.HTMLControls.DrawComboBox("cboAssignTo", strSQLAssignTo.ToString, 0, lngAssignTo.ToString, , , , , True)

                        .Write("</td></tr>" & vbCrLf)

                        strSelSQL = "Select Submitteddate from tbl_CRM_Query_Master where QueryID IN (" & m_strQueryID & ")"
                        dr1 = CommonFunctions.Data.GetDataReader(strSelSQL, MyBase.UseSQL)
                        If dr1.Read Then
                            'strSubmittedDate = CommonFunction.Data.CheckIsDBNull(dr1("Submitteddate"), "").ToString
                            strSubmittedDate = CType(CommonFunction.Data.CheckIsDBNull(dr1("Submitteddate"), ""), Date)
                        End If
                        CommonFunctions.Data.DisposeDataReader(dr1)
                        CommonFunctions.HTMLControls.DrawTextBox("txtHiddenSubmittedDate", "txtHiddenSubmittedDate", , 400, 100, CommonFunctions.Dates.GetDate(strSubmittedDate), , , , , , True, , )

                        'End Addition by SavitaS
                        '--------------------------------------------------------------------------------------------------------
                        'added by harshada d on 07 feb 2006 for helpdesk enhancements

                        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                        CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_FromRequestDetail_Multiple, , , , , , , , , , , , True, )
                        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197  

                    Else
                        Dim strSQLEditMode As String = " SELECT tbl_PM_ProjectTasks.EmployeeID ,tbl_PM_Project.ProjectID ,Projectname,EmployeeName,"
                        strSQLEditMode += " StartDate,EndDate,Work,tbl_PM_TaskTypes.TaskTypeID , tbl_PM_TaskTypes.TaskType"
                        strSQLEditMode += " FROM tbl_PM_ProjectTasks, tbl_PM_Employee,tbl_PM_Project,tbl_pm_taskTypes"
                        strSQLEditMode += " where tbl_PM_ProjectTasks.TaskID = " & lngTaskID.ToString
                        strSQLEditMode += " and tbl_PM_ProjectTasks.EmployeeID = tbl_PM_Employee.EmployeeID"
                        strSQLEditMode += " and tbl_PM_Project.ProjectID = tbl_PM_ProjectTasks.ProjectID"
                        strSQLEditMode += " and tbl_PM_TaskTypes.TaskTypeID = tbl_PM_ProjectTasks.TaskTypeID"
                        Dim drEditMode As IDataReader = CommonFunctions.Data.GetDataReader(strSQLEditMode, MyBase.UseSQL)
                        Dim lngTaskTypeID As Long
                        If drEditMode.Read Then
                            lngProjectID = CType(CommonFunctions.Data.CheckIsDBNull(drEditMode("ProjectID"), "0"), Long)
                            lngTaskTypeID = CType(CommonFunctions.Data.CheckIsDBNull(drEditMode("TaskTypeID"), "0"), Long)
                            m_WorkHrs = CType(CommonFunctions.Data.CheckIsDBNull(drEditMode("Work"), "0"), Double)
                            Dim dtmStartdate As Date = CType(CommonFunctions.Data.CheckIsDBNull(drEditMode("startdate"), ""), Date)
                            Dim dtmEndDate As Date = CType(CommonFunctions.Data.CheckIsDBNull(drEditMode("EndDate"), ""), Date)
                            lngAssignTo = CType(CommonFunctions.Data.CheckIsDBNull(drEditMode("employeeID"), "0"), Long)
                            ' project combo box
                            .Write("<tr class=clsTREven><td  width='30%' align=right>" & MyBase.GetResourceString("CAPTION_PROJECT") & "</td>" & vbCrLf)
                            .Write("<td  width='70%'>" & vbCrLf)
                            Dim strSQLOldProjects As String
                            strSQLOldProjects = "usp_CRM_ProjectList_ForFunction " & lngFunctionID.ToString & ", " & lngProjectID.ToString
                            CommonFunctions.HTMLControls.DrawComboBox("cboProject", strSQLOldProjects, 0, lngProjectID.ToString, "onchange=javascript:cboProject_OnChange()", True, , , True)
                            .Write("</td></tr>" & vbCrLf)
                            .Write("<tr class=clsTREven><td  width='30%' align=right>" & MyBase.GetResourceString("CAPTION_TASK_TYPE") & "</td>" & vbCrLf)
                            .Write("<td  width='70%'>" & vbCrLf)
                            'Dim strSelSQL As String = "SELECT tbl_PM_TaskTypes.TaskTypeID,tbl_PM_TaskTypes.TaskType FROM tbl_PM_TaskTypes,tbl_PM_projectTasks where tbl_PM_projectTasks.taskTypeID =tbl_PM_TaskTypes.TaskTypeID and  ProjectID =" & lngProjectID
                            Dim strSelSQL As String = "usp_Sel_TaskTypeMappedToProject " & lngProjectID.ToString
                            CommonFunctions.HTMLControls.DrawComboBox("cboTaskType ", strSelSQL, 0, lngTaskTypeID.ToString, , True, , , True)
                            .Write("</td></tr>" & vbCrLf)
                            .Write("<tr class=clsTREven><td  width='30%' align=right>" & MyBase.GetResourceString("CAPTION_WORK") & "</td>" & vbCrLf)
                            .Write("<td  width='70%'>" & vbCrLf)
                            CommonFunctions.HTMLControls.DrawTextBox("txtWork", "txtWork", , 50, , m_WorkHrs.ToString, , , False, , , , , , True)
                            .Write("</td></tr>" & vbCrLf)
                            .Write("<tr class=clsTREven><td  width='30%' align=right>" & MyBase.GetResourceString("CAPTION_START_DATE") & "</td>" & vbCrLf)
                            .Write("<td  width='70%'>" & vbCrLf)
                            CommonFunctions.HTMLControls.DrawDateControl("txtStartDate", "txtStartDate", , , CommonFunctions.Dates.GetDate(dtmStartdate), , "frmRequestAssignment", , , , False, True, , , True)
                            .Write("</td></tr>" & vbCrLf)
                            .Write("<tr class=clsTREven><td  width='30%' align=right>" & MyBase.GetResourceString("CAPTION_END_DATE") & "</td>" & vbCrLf)
                            .Write("<td  width='70%'>" & vbCrLf)
                            CommonFunctions.HTMLControls.DrawDateControl("txtEndDate", "txtEndDate", , , CommonFunctions.Dates.GetDate(dtmEndDate), , "frmRequestAssignment", , , , False, True, , , True)
                            .Write("</td></tr>" & vbCrLf)
                            ' resources of the project 
                            .Write("<tr class=clsTREven><td  width='30%' align=right>" & MyBase.GetResourceString("CAPTION_ASSIGNTO") & "</td>" & vbCrLf)
                            .Write("<td  width='70%'>" & vbCrLf)
                            Dim strSQLAssignTo As String = "usp_CRM_Get_ProjectEmployees " & lngProjectID & ",0," & lngAssignTo.ToString
                            CommonFunctions.HTMLControls.DrawComboBox("cboAssignTo", strSQLAssignTo, 0, lngAssignTo.ToString, , , , , True)
                            .Write("</td></tr>" & vbCrLf)
                            strSelSQL = "Select Submitteddate from tbl_CRM_Query_Master where QueryID IN (" & m_strQueryID & ")"
                            Dim dr1 As IDataReader = CommonFunctions.Data.GetDataReader(strSelSQL, MyBase.UseSQL)
                            Dim strSubmittedDate As Date
                            If dr1.Read Then
                                strSubmittedDate = CType(CommonFunction.Data.CheckIsDBNull(dr1("Submitteddate"), ""), Date)
                            End If
                            CommonFunctions.Data.DisposeDataReader(dr1)
                            CommonFunctions.HTMLControls.DrawTextBox("txtHiddenSubmittedDate", "txtHiddenSubmittedDate", , 400, 100, CommonFunctions.Dates.GetDate(strSubmittedDate), , , , , , True, , )

                            If Not Request.QueryString("TaskID") Is Nothing Then
                                lngTaskID = CType(Request.QueryString("TaskID"), Long)
                            Else
                                lngTaskID = CType(MyBase.GetFormValue("txtTaskID"), Long)
                            End If

                            CommonFunctions.HTMLControls.DrawTextBox("txtTaskID", "txtTaskID", , 400, 100, lngTaskID.ToString, , , , , , True, , )

                            '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                            CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_FromRequestDetail_Multiple, , , , , , , , , , , , True, )
                            '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197  

                        End If
                        CommonFunctions.Data.DisposeDataReader(drEditMode)
                    End If

                    'added by harshada d on 12 March 2006 for whiziblesem 6 helpdesk enhancements for issue id 1936
                    dr = CommonFunction.Data.GetDataReader("usp_Sel_PM_DepartmentBalanceLCE " + lngProjectID.ToString, MyBase.UseSQL)
                    If dr.Read Then
                        lngProjectHours = CType(CommonFunctions.Data.CheckIsDBNull(dr("LCETotal"), "0"), Long)
                        lngAllocatedHours = CType(CommonFunctions.Data.CheckIsDBNull(dr("AllocatedLCETotal"), "0"), Long)
                    End If
                    CommonFunctions.Data.DisposeDataReader(dr)
                    'end of addition by harshada for issue id 1936

                    If Not lngTaskID.ToString Is Nothing Then
                        AllowValueChanged(lngTaskID.ToString)
                    End If

                Case "ASSIGN_ISSUE"
                    ' project combo box
                    .Write("<tr class=clsTREven><td  width='30%' align=right>" & MyBase.GetResourceString("CAPTION_PROJECT") & "</td>" & vbCrLf)
                    .Write("<td  width='70%'>" & vbCrLf)

                    ' added by harshada d on 28 feb 2006 for helpdesk enhancements in whizible 6.0 for issue id 1936
                    If CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboProject"), "0"), String) <> "0" Then
                        If CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboProject"), "0"), String) = "" Then
                            lngProjectID = 0
                        Else
                            lngProjectID = CType(MyBase.GetFormValue("cboProject"), Long)
                        End If
                    Else
                        lngProjectID = 0
                        'Get Default Project
                        Dim strDefaultProject As String
                        strDefaultProject = "select ISNULL(ProjectID,0) as ProjectID from tbl_CRM_Function_projects Where FunctionID=" & lngFunctionID & "  And IsDefaultProject=1 "

                        lngProjectID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strDefaultProject, True), "0"), Long)
                        m_ChangedProject = lngProjectID


                    End If
                    ' end of addition by harshada d on 28 feb 2006 for helpdesk enhancements in whizible 6.0 for issue id 1936
                    'Integrated by ArchanaN on 27 Apr 2007
                    'SrikanthY on 17 Jan 2007 modified code for issues 9531,9522
                    If m_ChangedProject <> 0 Then lngProjectID = m_ChangedProject

                    'Integration Ends
                    'Modified by PrashantD on 8 Aug 2007
                    'CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_CRM_ProjectList_ForFunction " & lngFunctionID, 0, lngProjectID.ToString, "onchange=javascript:cboProject_OnChange()", True, , , True)
                    CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_CRM_ProjectList_ForFunction_ForAssignIssueHelpDesk  " + lngFunctionID.ToString + "," + m_strQueryID + ",'" + strRequestorSLoginType + "'" + ",'" + strRequestorSUserName + "'", 0, lngProjectID.ToString, "onchange=javascript:cboProject_OnChange()", True, , , True)
                    'End of modification by PrashantD on 8 Aug 2007

                    .Write("</td></tr>" & vbCrLf)

                    ' resources of the project 
                    .Write("<tr class=clsTREven><td  width='30%' align=right>" & MyBase.GetResourceString("CAPTION_ASSIGNTO") & "</td>" & vbCrLf)
                    .Write("<td  width='70%'>" & vbCrLf)
                    Dim strSQLAssignTo As String = "usp_CRM_Get_ProjectEmployees " & lngProjectID & ",0," & lngAssignTo.ToString
                    CommonFunctions.HTMLControls.DrawComboBox("cboAssignTo", strSQLAssignTo, 0, lngAssignTo.ToString, , , , , True)
                    .Write("</td></tr>" & vbCrLf)

                Case "ASSIGN_REQUESTS"

                    ' resources of the function belonging to the request	

                    .Write("<tr class=clsTREven><td  width='30%' align=right>" & MyBase.GetResourceString("CAPTION_ASSIGNTO") & "</td>" & vbCrLf)
                    .Write("<td  width='70%'>" & vbCrLf)
                    Dim strFunctionEmployees As String
                    Dim drfunctionID As IDataReader
                    drfunctionID = CommonFunctions.Data.GetDataReader("select FunctionID FROM tbl_CRM_Query_master Where QueryID IN ( " & m_strQueryID.ToString & ")", MyBase.UseSQL)
                    If drfunctionID.Read Then
                        lngFunctionID = CType(CommonFunction.Data.CheckIsDBNull(drfunctionID("FunctionID"), ""), Long)
                    End If
                    CommonFunctions.Data.DisposeDataReader(drfunctionID)

                    strFunctionEmployees = "usp_CRM_Get_FunctionEmployees " & lngFunctionID & " ,0," & lngAssignTo

                    'Commented by ShraddhaM on 27, July 2007
                    'Purpose : Change AssignTo Combo in TextBox on HelpDesk --> Assign Multiple Request Page
                    'If intCntDepts > 1 Then
                    '    CommonFunctions.HTMLControls.DrawComboBox("cboAssignTo", "usp_CRM_Get_FunctionEmployees 0 , 0" & lngAssignTo.ToString, 0, lngAssignTo.ToString, , , , , True)
                    'Else
                    '    CommonFunctions.HTMLControls.DrawComboBox("cboAssignTo", strFunctionEmployees, 0, lngAssignTo.ToString, , , , , True)
                    'End If
                    'End of Comment by ShraddhaM on 27, July 2007

                    'Added by ShraddhaM on 27, July 2007
                    'Purpose : Change AssignTo Combo in TextBox on HelpDesk --> Assign Multiple Request Page
                    CommonFunctions.HTMLControls.DrawTextBox("txtAssignTo", "txtAssignTo", IsDisabled:=True)
                    CommonFunctions.HTMLControls.DrawTextBox("cboAssignTo", "cboAssignTo", DisplayNone:=True)

                    'End of Addition by ShraddhaM on 27, July 2007


                    '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                    CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_FromRequestDetail_Multiple, , , , , , , , , , , , True, )
                    '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197  
                    'Added  by ShraddhaM on 27, July 2007
                    'Purpose : Change AssignTo Combo in TextBox on HelpDesk --> Assign Multiple Request Page
                    .Write("<A Href='JavaScript:AssignTo_OnClick()' >Assign To</A>" & vbCrLf)
                    .Write("</td></tr>" & vbCrLf)
                    'End of Addition  by ShraddhaM on 27, July 2007
                Case Else
                    ' do nothing
            End Select

            If UCase(Trim(m_strMode & "")) = "ASSIGN_ISSUE" Then
                ' the default type	

                If Trim(strType & "") = "" Then
                    strType = GetDefaultType(lngProjectID)
                End If

                ' type combo box		
                .Write("<tr class=clsTREven><td  width='30%' align=right>" & MyBase.GetResourceString("CAPTION_ISSUETYPE") & "</td>" & vbCrLf)
                .Write("<td  width='70%'>" & vbCrLf)


                'Integrated by ArchanaN on 27 Apr 2007
                'CommonFunctions.HTMLControls.DrawComboBox("cboType", "usp_CRM_Project_IssueTypes_ForCombo " & lngProjectID, 0, strType, "onchange=javascript:cboType_OnChange()", True, , , True)				 
                'SrikanthY on 17 Jan 2007 modified code for issues 9531,9522
                'CommonFunctions.HTMLControls.DrawComboBox("cboType", "usp_CRM_Project_IssueTypes_ForCombo " & lngProjectID, 0, , "onchange=javascript:cboType_OnChange()", True, , , True)
                If m_ChangedType <> "" Then
                    CommonFunctions.HTMLControls.DrawComboBox("cboType", "usp_CRM_Project_IssueTypes_ForCombo " & lngProjectID, 0, m_ChangedType, "onchange=javascript:cboType_OnChange()", True, , , True)
                Else
                    CommonFunctions.HTMLControls.DrawComboBox("cboType", "usp_CRM_Project_IssueTypes_ForCombo " & lngProjectID, 0, , "onchange=javascript:cboType_OnChange()", True, , , True)
                End If
                'Integration Ends


                '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_FromRequestDetail_Multiple, , , , , , , , , , , , True, )
                '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197  

                .Write("</td></tr>" & vbCrLf)

                ' the default status

                strStatus = GetDefaultStatus(lngProjectID, strType)

                'Integrated by ArchanaN on 27 Apr 2007
                'SrikanthY on 22 Jan 2007 To get the Role of the Employee
                Dim drRole As IDataReader
                Dim lngPostID As Long = 0
                drRole = CommonFunctions.Data.GetDataReader("SELECT PostID FROM tbl_PM_Employee Where EmployeeID = " & m_lngEmployeeID.ToString, m_blnUseSQL)
                If drRole.Read Then
                    lngPostID = CType(CommonFunctions.Data.CheckIsDBNull(drRole("Postid"), "0"), Long)
                End If
                CommonFunctions.Data.DisposeDataReader(drRole)
                'End of addition by SrikanthY on 22 Jan 2007

                'SrikanthY on 1 Mar 2007 Modified below code, in order to keep the Default Status as Selected when we select the issue type
                'Integration Ends
                ' status combo box			
                .Write("<tr class=clsTREven><td  width='30%' align=right>" & MyBase.GetResourceString("CAPTION_ISSUESTATUS") & "</td>" & vbCrLf)
                .Write("<td  width='70%'>" & vbCrLf)
                'Integrated by ArchanaN on 27 Apr 2007
                'CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_CRM_Project_IssueStatus_ForCombo " & lngProjectID & ",'" & CommonFunctions.General.BuildQueryString(strType & "") & "'", 0, strStatus, , True, , , True)
                If m_ChangedStatus <> "" Then
                    If Trim(Request.QueryString("TypeChanged")) = "1" Then
                        CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_Sel_tbl_IB_Project_Type_Status_OpenStatus " & lngProjectID & ",'" & CommonFunctions.General.BuildQueryString(strType & "") & "'," & lngPostID.ToString, 0, strStatus, , True, , , True)
                    Else
                        CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_Sel_tbl_IB_Project_Type_Status_OpenStatus " & lngProjectID & ",'" & CommonFunctions.General.BuildQueryString(strType & "") & "'," & lngPostID.ToString, 0, m_ChangedStatus, , True, , , True)
                    End If
                Else
                    If m_ChangedType <> "" Then
                        CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_Sel_tbl_IB_Project_Type_Status_OpenStatus " & lngProjectID & ",'" & CommonFunctions.General.BuildQueryString(strType & "") & "'," & lngPostID.ToString, 0, strStatus, , True, , , True)
                    Else
                        CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_Sel_tbl_IB_Project_Type_Status_OpenStatus " & lngProjectID & ",'" & CommonFunctions.General.BuildQueryString(strType & "") & "'," & lngPostID.ToString, 0, , , True, , , True)
                    End If
                End If
                .Write("</td></tr>" & vbCrLf)

                'end of modification by SrikanthY on 17 Jan 2007
                'end of modification by SrikanthY on 1 Mar 207

                'Added by PrashantD on 21 March 2007
                'Purpose: for adding Priority and Severity combos.
                Dim m_ProjectID As String
                Dim m_Priority As String
                Dim m_Severity As String
                Dim drDefault As IDataReader
                'Added by ArchanaN on 11 Jun 2007 for Regression testing IssueID = 13309
                'm_ProjectID = "0" & Request.Form("cboProject")
                m_ProjectID = "0" & lngProjectID
                'End by ArchanaN
                m_Priority = Request.Form("cboPriority")
                m_Severity = Request.Form("cboSeverity")
                If (m_Priority Is Nothing Or m_Priority = "") Or Request.QueryString("ProjectChanged") = "1" Then
                    drDefault = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_IB_Project_Priorities " + m_ProjectID.ToString + ",1", MyBase.UseSQL)
                    If drDefault.Read Then
                        m_Priority = drDefault("Priority").ToString()
                    Else
                        m_Priority = "0"
                    End If
                    CommonFunction.Data.DisposeDataReader(drDefault)

                End If

                If (m_Severity Is Nothing Or m_Severity = "") Or Request.QueryString("ProjectChanged") = "1" Then
                    drDefault = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_IB_Project_Severity " + m_ProjectID.ToString + ",1", MyBase.UseSQL)
                    If drDefault.Read Then
                        m_Severity = drDefault("Severity").ToString()
                    Else
                        m_Severity = "0"
                    End If
                    CommonFunction.Data.DisposeDataReader(drDefault)

                End If
                CommonFunction.General.WriteHTML("<TR class=clsTREven>")
                CommonFunction.General.WriteHTML("<TD align=right>Priority</TD>")
                CommonFunction.General.WriteHTML("<TD>")
                CommonFunction.HTMLControls.DrawComboBox("cboPriority", "Exec usp_Sel_tbl_IB_Project_Priorities " + m_ProjectID.ToString, 200, m_Priority, , True)
                CommonFunction.General.WriteHTML("</TD>")
                CommonFunction.General.WriteHTML("</TR>")

                CommonFunction.General.WriteHTML("<TR class=clsTREven>")
                CommonFunction.General.WriteHTML("<TD align=right>Severity </TD>")
                CommonFunction.General.WriteHTML("<TD>")
                CommonFunction.HTMLControls.DrawComboBox("cboSeverity ", "Exec usp_Sel_tbl_IB_Project_Severity " + m_ProjectID.ToString, 200, m_Severity, , True)
                CommonFunction.General.WriteHTML("</TD>")
                CommonFunction.General.WriteHTML("</TR>")

                'End of addition by PrashantD on 21 March 2007
                'Added by PrashantD on 21 March 2007 for Helpdesk Product Association
                Dim drProduct As IDataReader
                Dim m_CustomerId As String
                Dim m_LoginID As String

                Dim strComboSQL As String

                Dim m_ProductVersion As String
                Dim m_Component As String
                Dim m_ProductExecutionPractice As Boolean
                Dim m_EnableProductExecution As Boolean
                Dim m_EnableProjectProductExecution As Boolean
                m_ProductVersion = Request.Form("ProductVersionID")
                If m_ProductVersion Is Nothing Or m_ProductVersion = "" Then
                    m_ProductVersion = "0"
                End If
                m_Component = Request.Form("ComponentID")
                If m_Component Is Nothing Or m_Component = "" Then
                    m_Component = "0"
                End If

                If m_ProjectID <> "0" And m_ProjectID <> "" And m_ProjectID <> "00" Then
                    m_EnableProductExecution = CommonFunction.Application.EnableProductExecution
                    If m_EnableProductExecution Then
                        drProduct = CommonFunction.Data.GetDataReader("SELECT 1 FROM tbl_PM_DepartMentMaster WHERE ISNULL(ExposeToProductExecution,0) = 1 AND DepartMentID = " + lngFunctionID.ToString, MyBase.UseSQL)
                        If drProduct.Read Then
                            m_EnableProductExecution = True
                        Else
                            m_EnableProductExecution = False
                        End If
                        CommonFunction.Data.DisposeDataReader(drProduct)
                    End If

                    'If drProduct.Read And m_ProductExecutionPractice = True And m_EnableProductExecution = True Then
                    If m_EnableProductExecution = True Then
                        'blnPupulateProductDetail = CType(drProduct("PupulateProductDetail"), Boolean)


                        drProduct = CommonFunction.Data.GetDataReader("usp_Sel_tbl_CRM_Query_Master_ProductAssociation " + m_strQueryID + "," + m_ProjectID, MyBase.UseSQL)
                        drProduct.Read()

                        m_CustomerId = Request.Form("CustomerID")
                        If m_CustomerId Is Nothing OrElse m_CustomerId = "" Then
                            If strRequestorSLoginType.ToUpper = "C" Then
                                m_CustomerId = drProduct("CustomerID").ToString
                            Else
                                m_CustomerId = ""
                            End If
                        End If

                        If strRequestorSLoginType.ToUpper = "C" Then
                            If m_ProductVersion = "0" Then
                                If Not IsDBNull(drProduct("ProductID")) Then
                                    m_ProductVersion = drProduct("ProductID").ToString
                                    If Not IsDBNull(drProduct("ComponentID")) Then
                                        m_Component = drProduct("ComponentID").ToString
                                    End If
                                End If
                            End If
                            m_LoginID = drProduct("LoginID").ToString
                        End If



                        If strRequestorSLoginType = "C" Then
                            Response.Write("<INPUT type=hidden name=CustomerID id=CustomerID value=" + m_CustomerId + ">")
                        Else
                            CommonFunction.General.WriteHTML("<TR class=clsTREven>")
                            CommonFunction.General.WriteHTML("<TD align=right>Customer</TD>")
                            CommonFunction.General.WriteHTML("<TD>")
                            CommonFunction.HTMLControls.DrawComboBox("CustomerID", "usp_Sel_tbl_PM_Customer_ProductExecution", 200, m_CustomerId, "onchange=Customer_OnChange()", True, IsMandatory:=True)
                            CommonFunction.General.WriteHTML("</TD></TR>")
                        End If

                        CommonFunction.General.WriteHTML("<TR class=clsTREven>")
                        CommonFunction.General.WriteHTML("<TD align=right>Product</TD>")
                        CommonFunction.General.WriteHTML("<TD>")
                        If strRequestorSLoginType = "C" Then
                            strComboSQL = "EXEC usp_Sel_tbl_PRD_ProductVersion_CustomerWise " + m_CustomerId + " , 'C' ," + m_LoginID + CStr(IIf(CommonFunctions.Application.ShowEvenReleaseFromProject, ",1", " ,0 ")) + ",Null , " + m_CustomerId + " , " + m_ProjectID
                        Else
                            If m_CustomerId = "" Then
                                strComboSQL = "if (1=2) SELECT '',''"
                            Else
                                strComboSQL = "EXEC usp_Sel_tbl_PRD_ProductVersion_CustomerWise " + m_CustomerId + " , 'C' ,NULL" + CStr(IIf(CommonFunctions.Application.ShowEvenReleaseFromProject, ",1", " ,0 ")) + ",Null , " + m_CustomerId + " , " + m_ProjectID
                            End If
                        End If

                        CommonFunction.HTMLControls.DrawComboBox("ProductVersionID", strComboSQL, 200, m_ProductVersion, "onchange=ProductVersion_OnChange()", True, IsMandatory:=True)
                        CommonFunction.General.WriteHTML("</TD>")
                        CommonFunction.General.WriteHTML("</TR><TR class=clsTREven><TD align=right>Component</TD>")
                        CommonFunction.General.WriteHTML("<TD>")
                        If strRequestorSLoginType = "C" Then
                            strComboSQL = "EXEC USP_SEL_Tbl_PRD_ProductVersion_Component " + m_ProductVersion + " , " + m_CustomerId + " , " + m_ProjectID + " , " + m_CustomerId + " , 'C' ," + m_LoginID + CStr(IIf(CommonFunctions.Application.ShowEvenReleaseFromProject, ",1", " ,0 "))
                        Else
                            If m_CustomerId = "" Then
                                strComboSQL = "if (1=2) SELECT '',''"
                            Else
                                strComboSQL = "EXEC USP_SEL_Tbl_PRD_ProductVersion_Component " + m_ProductVersion + " , " + m_CustomerId + " , " + m_ProjectID + " , " + m_CustomerId + " , 'C' ,NULL" + CStr(IIf(CommonFunctions.Application.ShowEvenReleaseFromProject, ",1", " ,0 "))
                            End If
                        End If

                        CommonFunction.HTMLControls.DrawComboBox("ComponentID", strComboSQL, 200, m_Component, , True)
                        CommonFunction.General.WriteHTML("</TD>")
                        CommonFunction.General.WriteHTML("</TR>")

                        CommonFunction.General.WriteHTML("<TR class=clsTREven><TD align=right colspan=2 ><I>Note: Product dropdown is populated only if selected project is 'Support Project' or requestor is a customer of selected project.</I></TD></TR>")

                        CommonFunction.Data.DisposeDataReader(drProduct)
                    End If
                End If

                'End of addition by PrashantD on 21 March 2007 for Helpdesk Product Association

                '.Write("</Table>")
                '.Write("<BR>")
                '.Write("<BR>")
            End If

            'SrikanthY on 20 Dec 2006 To display issues list on issue screen 
            If UCase(Trim(m_strMode & "")) = "ASSIGN_ISSUE" Then
                Session("IssueProject") = lngProjectID
                '.Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAPTION_ATTACHMENTS")))
                .Write(WebPage.Templates.PageCaption.GetPageCaptions(, "Previous Issues"))
                .Write("<BR>")
                PlotPreviousIssueListGrid()
            End If

            'Srikanth Addition Ends

            .Write("</Table>")
            .Write("<BR>")
            'Integration Ends

            ' Notes for assignment
            Select Case UCase(Trim(m_strMode & ""))

                Case "ASSIGN_MULTIPLE_TASKS", "ASSIGN_TASK"
                    'commented by harshada d for helpdesk enhancement 
                    '' note for the task assignment
                    '.Write("<table class=clsTable width='100%'><tr class=clsTREven><td width='100%'>" & vbCrLf)
                    '.Write(MyBase.GetResourceString("NOTE_ASSIGN_TASK_1") & vbCrLf)
                    'If UCase(Trim(m_strMode & "")) = "ASSIGN_MULTIPLE_TASKS" Then
                    '    .Write(MyBase.GetResourceString("NOTE_ASSIGN_TASK_2") & vbCrLf)
                    '    .Write(MyBase.GetResourceString("NOTE_ASSIGN_MULTIPLE_TASKS") & vbCrLf)
                    'End If
                    '.Write("</td></tr></table>" & vbCrLf)
                    'Comment By PrashantD on 25 Feb 2006 for IssueID 1936
                Case "ASSIGN_ISSUE"
                    ' note for the issue assignment
                    '.Write("<table class=clsTable width='100%'><tr class=clsTREven><td width='100%'>" & vbCrLf)
                    '.Write(MyBase.GetResourceString("NOTE_ASSIGN_ISSUE") & vbCrLf)
                    '.Write("</td></tr></table>" & vbCrLf)
                    'End Of Commnet by PrashantD 
                Case Else
                    ' do nothing	
            End Select
            '.Write("</Div>")  '****
            'added by SonalD on 16th sept 2008
            If UCase(Trim(m_strMode & "")) = "ASSIGN_TASK" Then
                Dim strQuery As String
                Dim drgrid As IDataReader
                Dim StartDate As Date
                Dim EndDate As Date
                strQuery = "usp_sel_tbl_PM_helpdesk_Tasks " + m_strQueryID
                drgrid = CommonFunction.Data.GetDataReader(strQuery, True)
                '.Write("<div id=divList style='overflow:auto;width:99.9%'>")
                .Write("<Table class=clsGridTable width ='99.9%' cellpadding=0 cellspacing=1>" & vbCrLf)
                .Write("<tr class=clsTRColumnHeader><td>")
                .Write("Employee Name")
                .Write("</TD>")
                .Write("<TD>")
                .Write("Start Date")
                .Write("</TD>")
                .Write("<TD>")
                .Write("End Date")
                .Write("</TD>")
                .Write("<TD align=center>")
                .Write("Work(Hrs)")
                .Write("</TD>")
                .Write("<TD align=center>")
                .Write("Is Task Active?")
                .Write("</TD>")
                .Write("<TD align=center>")
                .Write("Actual(Hrs)")
                .Write("</TD>")
                .Write("</tr>")
                While drgrid.Read()
                    StartDate = drgrid("startDate")
                    EndDate = drgrid("endDate")
                    .Write("<tr class=clsTREven>")
                    .Write("<TD>")
                    .Write(drgrid("EmployeeName"))
                    .Write("</TD>")
                    .Write("<TD>")
                    .Write(StartDate.ToShortDateString)
                    .Write("</TD>")
                    .Write("<TD>")
                    .Write(EndDate.ToShortDateString)
                    .Write("</TD>")
                    .Write("<TD align=right>")
                    .Write(FormatNumber(drgrid("work"), 1))
                    .Write("</TD>")
                    .Write("<TD align=center>")
                    If drgrid("IsActive") = True Then
                        .Write("Yes")
                    Else
                        .Write("No")
                    End If
                    .Write("</TD>")
                    .Write("<TD align=right>")
                    .Write(FormatNumber(drgrid("Duration"), 2))
                    .Write("</TD>")
                    .Write("</tr>")
                End While
                .Write("</Table>")
            End If
            .Write("</Div>")
            'end of addition
            ' menu
            .Write(strMenu)
        End With
    End Sub
    'Integrated by ArchanaN on 27 Apr 2007
    'Modified by SrikanthY on 2007 for Issues-9521,9526
    'Added by SrikanthY on 20 Dec 2006 To display issues list on issue screen
    Private Sub PlotPreviousIssueListGrid()

        Dim strSQL As String
        Dim arrUserFriendlyCols() As String = {"Discussions", "Issue ID", "Project Name", "Summary", "Type", "Reported By", "Reported Date", "Responsible Person", "Due Date", "Status"}
        Dim arrActualCols() As String = {"", "IssueID", "ProjectName", "Summary", "Type", "ReportedBy", "ReportedDate", "AssignTo", "DueDate", "Status"}

        strSQL = "usp_CRM_Get_Request_Issue_Details  " & m_strQueryID
        strSQL += ",'" & m_strSortBy & "','" & m_strSortOrder & "'"

        m_objGrid = New WebPages.Template.GenericGrid
        With m_objGrid
            .NoOfDataColumns = 10
            .UserFriendlyColumnArray = arrUserFriendlyCols
            .ActualColumnArray = arrActualCols
            .returnHTML = False
            .SortBy = m_strSortBy
            .SortOrder = m_strSortOrder
            .ClientSideSortFunctionName = "Sort_OnClick"
            .SQL = strSQL
            .UseSQL = m_blnUseSQL
            .DIVHeight = 300
            .DIVID = "divList"
            .DIVStyle = "overflow:auto"
            .DrawGrid()
        End With
        m_objGrid = Nothing
    End Sub
    'End of addition by SrikanthY
    'End of modification by SrikanthY on 17 Jan 2007
    'Integration Ends

    'Private Sub WriteGrid(ByVal SQL As String)

    '    ' Modified By NitinVs on 10 Aug 2005 for WhizibleSEM SP4 IssueID 2 Added Column for Department
    '    Dim arrActualCols() As String = {"EmployeeName", "StartDate", "EndDate", "WorkHrs"}
    '        Dim arrIgnoreHTMLEncode() As String = {"1"}
    '    Dim arrLink() As String = {"EmployeeName(TaskID)", "", "", ""}
    '    Dim arrChkBox() As String = {"", "", "", ""}
    '        ' End Modification By NitinVs on 10 Aug 2005 for WhizibleSEM SP4 IssueID 2 Added Column for Department
    '        Dim intNoOfRows As Integer
    '        Dim strQueryID_Caption As String
    '        Dim strSubject_Caption As String
    '        Dim strDescription_Caption As String
    '        Dim strAssignTo_Caption As String
    '        Dim strPriority_Caption As String
    '        Dim strExpectedResolvedDate_Caption As String
    '        Dim strCRMExpectedResolvedDate_Caption As String
    '        Dim strStatus_Caption As String

    '        'Modification By SantoshK on 2nd Dec 2004 after adding New field in table tbl_CRM_SubRequestType_Caption_Master
    '        Dim strRequestType_Caption As String
    '        'Modification Ends

    '        Dim strSubRequestType_Caption As String
    '        Dim strTargetLocation_Caption As String
    '        Dim strFunction_Caption As String
    '        Dim strSubmittedBy_Caption As String
    '        Dim strSubmittedDate_Caption As String
    '        Dim dr As IDataReader
    '        Dim ds As DataSet
    '        ' get the captions from the caption template	
    '             strSubject_Caption = dr("Subject").ToString & ""
    '            strAssignTo_Caption = dr("AssignTo").ToString & ""
    '            strPriority_Caption = dr("Priority").ToString & ""
    '            strExpectedResolvedDate_Caption = dr("ExpectedResolvedDate").ToString & ""
    '            strStatus_Caption = dr("Status").ToString & ""
    '            'Added By SantoshK on 2nd Dec 2004
    '            strRequestType_Caption = dr("RequestType").ToString & ""
    '            'Addition Ends
    '            strSubRequestType_Caption = dr("SubRequestType").ToString & ""
    '            strSubmittedBy_Caption = dr("SubmittedBy").ToString & ""
    '            strSubmittedDate_Caption = dr("SubmittedDate").ToString & ""

    '    Dim arrUserFriendlyCols() As String = {"Employee", "Start Date", "End Date", "Work(Hrs)"}
    '        m_objGrid = New WebPages.Template.GenericGrid
    '        With m_objGrid
    '            ' Modified By NitinVS on 9 Aug 2005 for WhizibleSEM SP 4 IssueID 2  
    '            'Modified by SiddharthS on 15 Feb 2005 for IssueID 15602.
    '            'Purpose : To display the proper value for the status column in a grid.
    '            '.NoOfDataColumns = 10
    '        .NoOfDataColumns = 4
    '            'Modification ends.
    '            ' End Modification  By NitinVS on 9 Aug 2005 for WhizibleSEM SP 4 IssueID 2  

    '            .UserFriendlyColumnArray = arrUserFriendlyCols
    '            .ActualColumnArray = arrActualCols
    '            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
    '            .RowLinkArray = arrLink
    '        .PrimaryKey = "TaskID"
    '            .returnHTML = False

    '        '.SortBy = m_strSortBy
    '        ' .SortOrder = m_strSortOrder
    '            .ClientSideSortFunctionName = "Sort_OnClick"
    '            .SQL = SQL
    '            .UseSQL = m_blnUseSQL

    '        ' .CurrentPage = m_intPageNumber
    '            .PageSize = 20

    '            .DIVID = "divList"
    '            .DIVStyle = "overflow:auto"
    '            .DIVHeight = 300
    '            .DrawGrid()
    '            intNoOfRows = .NoOfRowsInPage
    '        End With
    '        m_objGrid = Nothing
    '    CommonFunctions.General.WriteTotalRecordsHTML(m_intTotalNoOfRows, "Total Records:", False, "clsTREven")
    '    CommonFunctions.General.WriteTotalRecordsHTML(m_intTotalNoOfRows, "Total Records:", False, "clsTREven")


    'End Sub


    Private Function GetEmployeeDepartment(ByVal EmployeeID As Long) As Long
        '=====================================================================
        ' Procedure Name        : GetEmployeeDepartment
        ' Description           : to get the employee department
        ' Purpose               : 
        ' Parameters Passed     : intEmployeeID
        ' Returns               : the department id of employee
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Rajanikant
        ' Created               : Feb 19,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        ' get the function id of the CRM	
        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_EmployeeDepartment " & EmployeeID, m_blnUseSQL)
        If dr.Read Then
            GetEmployeeDepartment = CType(CommonFunctions.General.CheckIsNothing(dr("DepartmentID"), "0"), Long)
        Else
            GetEmployeeDepartment = 0
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Function

    Private Function GetDefaultProject(ByVal FunctionID As Long) As Long
        '=====================================================================
        ' Procedure Name        : GetDefaultProject
        ' Description           : to get the employee department
        ' Purpose               : 
        ' Parameters Passed     : Function ID
        ' Returns               : the department id of employee
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Rajanikant
        ' Created               : Feb 19,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        ' get the function id of the CRM	
        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_DefaultProject " & FunctionID, m_blnUseSQL)
        If dr.Read Then
            GetDefaultProject = CType(CommonFunctions.General.CheckIsNothing(dr("ProjectID"), "0"), Long)
        Else
            GetDefaultProject = 0
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Function

    Private Function GetIssueCount(ByVal RequestID As String) As Long
        '=====================================================================
        ' Procedure Name        : GetDefaultProject
        ' Description           : to get the employee department
        ' Purpose               : 
        ' Parameters Passed     : Function ID
        ' Returns               : the department id of employee
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Rajanikant
        ' Created               : Feb 19,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_IssueCount " & RequestID, m_blnUseSQL)
        If dr.Read Then
            GetIssueCount = CType(dr("IssueCount"), Long)
        Else
            GetIssueCount = 0
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Function
    Private Function AllowValueChanged(ByVal TaskID As String) As Boolean
        '=====================================================================
        ' Procedure Name        : GetDefaultProject
        ' Description           : to get the employee department
        ' Purpose               : 
        ' Parameters Passed     : Function ID
        ' Returns               : the department id of employee
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Harshada D
        ' Created               : Feb 19,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        dr = CommonFunction.Data.GetDataReader("Select ProjectID , EmployeeID ,TaskTypeID FROM tbl_PM_ProjectTasks Where TaskID = " & TaskID, m_blnUseSQL)
        If dr.Read Then
            m_lngOldProjectID = CType(CommonFunctions.General.CheckIsNothing(dr("ProjectID"), "0"), Long)
            m_lngOldTaskTypeID = CType(CommonFunctions.General.CheckIsNothing(dr("TaskTypeID"), "0"), Long)
            m_lngOldAssignTo = CType(CommonFunctions.General.CheckIsNothing(dr("EmployeeID"), "0"), Long)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Function
    Private Function CheckTimesheet(ByVal RequestID As String) As Boolean
        '=====================================================================
        ' Procedure Name        : GetDefaultProject
        ' Description           : to get the employee department
        ' Purpose               : 
        ' Parameters Passed     : Function ID
        ' Returns               : the department id of employee
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Rajanikant
        ' Created               : Feb 19,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_Request_TimesheetDetails " & RequestID, m_blnUseSQL)
        If dr.Read Then
            CheckTimesheet = True
        Else
            CheckTimesheet = False
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Function

    Private Function CheckIssues(ByVal RequestID As String) As Boolean
        '=====================================================================
        ' Procedure Name        : GetDefaultProject
        ' Description           : to get the employee department
        ' Purpose               : 
        ' Parameters Passed     : Function ID
        ' Returns               : the department id of employee
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Rajanikant
        ' Created               : Feb 19,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_Request_IssueDetails " & RequestID, m_blnUseSQL)
        If dr.Read Then
            CheckIssues = True
        Else
            CheckIssues = False
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Function

    Private Function GetDefaultStatus(ByVal ProjectID As Long, ByVal strType As String) As String
        '=====================================================================
        ' Procedure Name        : GetDefaultStatus
        ' Description           : to get the default status for the type & proj.
        ' Purpose               : 
        ' Parameters Passed     : intProjectID, strType
        ' Returns               : the default status
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Rajanikant
        ' Created               : Feb 20,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_Default_IssueTypeStatus " & ProjectID & ",'" & CommonFunctions.General.BuildQueryString(strType & "") & "'", m_blnUseSQL)
        If dr.Read Then
            ' the default status for the selected type
            GetDefaultStatus = dr("Status").ToString & ""
        Else
            GetDefaultStatus = ""
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Function

    Private Function GetDefaultType(ByVal ProjectID As Long) As String
        '=====================================================================
        ' Procedure Name        : GetDefaultType
        ' Description           : to get the default type for the proj.
        ' Purpose               : 
        ' Parameters Passed     : intProjectID
        ' Returns               : the default type
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Rajanikant
        ' Created               : Feb 20,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim strType As String = ""

        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_Default_IssueType " & ProjectID, m_blnUseSQL)
        If dr.Read Then
            If Trim(dr("Type").ToString & "") <> "" Then
                strType = Trim(dr("Type").ToString & "")
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

        GetDefaultType = ""
        If Trim(strType & "") = "" Then
            dr = CommonFunction.Data.GetDataReader("usp_CRM_Project_IssueTypes_ForCombo " & ProjectID, m_blnUseSQL)
            If dr.Read Then
                GetDefaultType = dr("type").ToString & ""
            End If
            CommonFunctions.Data.DisposeDataReader(dr)
        Else
            GetDefaultType = strType & ""
        End If

    End Function


#Region "events"
    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        Select Case UCase(Trim(m_strMode & ""))
            Case "ASSIGN_ISSUE"
                ' "Previous Issues" Link has to be shown only if there are any prev. issues for the request
                If Args.MenuColIndex = 0 Then
                    Cancel = True
                ElseIf Args.MenuColIndex = 1 Then
                    Cancel = Not m_blnPreviousIssuesPresent
                End If
            Case "ASSIGN_TASK"
                ' "Show Timesheet Detailsa" Link has to be shown only if there are timesheet entries
                If Args.MenuColIndex = 0 Then
                    Cancel = Not m_blnHasTimesheetDetails
                ElseIf Args.MenuColIndex = 1 Then
                    Cancel = True
                End If
            Case "ASSIGN_MULTIPLE_TASKS", "ASSIGN_REQUESTS"

                If UCase(Trim(m_strMode & "")) = "ASSIGN_MULTIPLE_TASKS" Then
                    If Args.MenuColIndex = 0 Then
                        Cancel = Not m_blnHasTimesheetDetails
                    ElseIf Args.MenuColIndex = 1 Then
                        Cancel = True
                    End If

                ElseIf UCase(Trim(m_strMode & "")) = "ASSIGN_REQUESTS" Then
                    If Args.LinkName.ToUpper = "SHOW TIMESHEET DETAILS" Then
                        Cancel = True
                    End If
                    If Args.LinkName.ToUpper = "PREVIOUS ISSUES" Then
                        Cancel = True
                    End If
                End If
                'Commented by ShraddhaM on 27, July 2007
                'Purpose : Now Requests of different departments can be assign to 1 resource
                ' harshada for assign link hide in assign multiple case for whiziblesem 6 issue id 1936
                'Dim strSQL As String
                'strSQL = "select functionid ,count (functionid)as Cnt from tbl_CRM_Query_Master where queryID IN "
                'strSQL += "(" & m_strQueryID & ")"
                'strSQL += " group by functionid"
                'Dim dr As IDataReader = CommonFunction.Data.GetDataReader(strSQL, m_blnUseSQL)
                'Dim cntDepts As Integer = 0
                'While dr.Read
                '    cntDepts = cntDepts + 1
                'End While

                'If cntDepts > 1 Then
                '    If Args.LinkName.ToUpper = "ASSIGN" Then
                '        Cancel = True
                '    End If
                'End If
                'CommonFunctions.Data.DisposeDataReader(dr)
                ' end harshada for assign link hide in assign multiple case for whiziblesem 6 issue id 1936
                'End of Comment by ShraddhaM on 27, July 2007
            Case Else
                ' for all others "Previous Issues" & "Show Timesheet Details" are to be hidden
                If Args.MenuColIndex = 0 Or Args.MenuColIndex = 1 Then
                    Cancel = True
                End If
        End Select

        If Args.MenuColIndex = 2 Then
            ' "Assign" link : Hide if Request.QueryString("ShowAssignLink")= "0"
            If Not Request.QueryString("ShowAssignLink") Is Nothing Then
                If Trim(Request.QueryString("ShowAssignLink") & "") = "0" Then
                    Cancel = True
                End If
            End If
        End If
        'added by harshada d on 07 feb 2006 for helpdesk enhancements issue id 1936
        Select Case UCase(Trim(m_strMode & ""))
            Case "ASSIGN_TASK", "ASSIGN_TASK,ADD_NEW"
            Case Else
                If Args.LinkName.ToUpper = "BACK" Then
                    Cancel = True
                End If

        End Select
        'end of addition by harshada d on 07 feb 2006 for helpdesk enhancements issue id 1936
    End Sub

#End Region

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        Session("taskID") = Nothing
    End Sub
    'Integrated by ArchanaN on 27 Apr 2007

    'Added by SrikanthY on 20 Dec 2006 For display issue list on Issue screen
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Select Case UCase(Trim(Args.DataField & ""))

            Case "ISSUEID"
                m_PKToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("IssueID"), String) + CType(Session("intUserID"), String) + "0" + "0")

                'SrikanthY on 17 Jan 2007 modifed javascript code for Issue 9517
                If Trim(Args.DataReader("IssueID").ToString & "") <> "" Then
                    Cancel = True
                    Args.StringToBeInserted = "<TD><A href=""JavaScript:IssueDetails('" & CType(Args.DataReader("IssueID"), String) & "','" & CType(Args.DataReader("ProjectID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken) & "')"">" & Args.DataReader("IssueID").ToString & "</A></TD>"
                    'end of modification by SrikanthY
                End If
        End Select

        Select Case UCase(Trim(Args.ColumnName & ""))
            Case "DISCUSSIONS"
                m_PKToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("IssueID"), String) + CType(Session("intUserID"), String) + "0" + "0")
                If CType(Args.DataReader("DiscussionCount"), Long) = 0 Then
                    Args.StringToBeInserted = "<TD  vAlign=top title='Discussions' style='TEXT_DECORATION:None' nowrap;><A href=""JavaScript:Discussion_Onclick('" & CType(Args.DataReader("IssueID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken) & "')""><IMG border=0 src='../../Images/Discussions.gif' title='Discussions'></A></TD>"

                    Cancel = True
                Else
                    Args.StringToBeInserted = "<TD  vAlign=top title='Discussions' style='TEXT_DECORATION:None' nowrap;><A href=""JavaScript:Discussion_Onclick('" & CType(Args.DataReader("IssueID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken) & "')""><IMG border=0 src='../../Images/Discussions.gif' title='Discussions'>" & "(" & CType(Args.DataReader("DiscussionCount"), Long) & ")" & "</A></TD>"

                    Cancel = True
                End If

        End Select

    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        Select Case UCase(Trim(Args.ColumnName & ""))
            Case "DISCUSSIONS"
                Cancel = True
                Args.StringToBeInserted = "<TH align=left class='divList'><IMG border=0 src='../../Images/Discussions.gif' title='Discussions'></TH>"

                'Args.ApplySorting = False
                'Args.ColumnName = "<IMG border=0 src='../../Images/Discussions.gif' title='Discussions'>"
                'Args.ApplyHTMLEncode = False
                'Case "ISSUE ID"
                '    Cancel = True
                '    Args.StringToBeInserted = "<TH align=left class='divList'>Issue Id</TH>"
                '    Args.ApplySorting = True

        End Select
    End Sub
    'End of Addition by SrikanthY
    Private Sub PerformAttachment(ByVal strIssueID As String, ByVal strQueryID As String)
        '=====================================================================
        ' Procedure Name        : PerformActions()	
        ' Purpose               : To take requested actions on the page
        ' Description           : The proc. performs the actions for the page
        '                         Deletes, updates and inserts are done
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : Module variables are set.
        ' Dependencies          : module variables
        ' Author                : JyotiG
        ' Created               : Feb 17,2007
        ' Revisions             :
        '=====================================================================
        Dim Attachedby As String

        Dim strDestinationSysFileName As String
        Dim drAttach As IDataReader
        Dim strInsSQL As String
        Dim strDestinationPath As String
        Dim strSourcePath As String

        drAttach = CommonFunction.Data.GetDataReader("SELECT * FROM tbl_CRM_Attachments  WHERE QueryID = " + strQueryID, MyBase.UseSQL)

        strDestinationPath = Server.MapPath("../../Attachments/BTS")
        strSourcePath = Server.MapPath("../../Attachments/CRM")

        While drAttach.Read
            strInsSQL = "usp_Ins_tbl_IB_Attachments " + strIssueID + "," + lngProjectID.ToString + ","

            If Not System.IO.File.Exists(strDestinationPath + "\" + drAttach("SystemFileName").ToString) Then
                strDestinationSysFileName = drAttach("SystemFileName").ToString
            Else
                strDestinationSysFileName = CommonFunctions.FileDirectory.GetUniqueFileName()
                strDestinationSysFileName += drAttach("SystemFileName").ToString.Substring(drAttach("SystemFileName").ToString.IndexOf("."))

            End If

            System.IO.File.Copy(strSourcePath + "\" + drAttach("SystemFileName").ToString, strDestinationPath + "\" + strDestinationSysFileName)
            strInsSQL += CType(Session("intUserID"), String) + "," + "'E','" + strDestinationSysFileName + "','" + CommonFunction.General.BuildQueryString(drAttach("OriginalFileName").ToString) + "','Attachment by CRM',0"
            CommonFunction.Data.InsertOrUpdateData(strInsSQL, MyBase.UseSQL)
        End While
        CommonFunction.Data.DisposeDataReader(drAttach)
    End Sub
    Private Sub DrawParentDetails(ByVal Query As String)
        Dim dr As IDataReader
        Dim strCustomerID, strCustomerName, strDepartment, strRtype, strRSubtype, strSubject, strProduct, strComponent, strPriority, strSeverity, strStatus As String
        Dim strSQL As String = "usp_CRM_Get_RequestDetails_AssignIssue " + Query
        dr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If dr.Read Then
            strCustomerID = CType(CommonFunctions.Data.CheckIsDBNull(dr("CustomerID"), ""), String)
            strCustomerName = CType(CommonFunctions.Data.CheckIsDBNull(dr("CustomerName"), ""), String)
            strRtype = CType(CommonFunctions.Data.CheckIsDBNull(dr("RequestType"), ""), String)
            strRSubtype = CType(CommonFunctions.Data.CheckIsDBNull(dr("SubRequestType"), ""), String)
            strSubject = CType(CommonFunctions.Data.CheckIsDBNull(dr("Subject"), ""), String)
            strProduct = CType(CommonFunctions.Data.CheckIsDBNull(dr("Product"), ""), String)
            strComponent = CType(CommonFunctions.Data.CheckIsDBNull(dr("Component"), ""), String)
            strPriority = CType(CommonFunctions.Data.CheckIsDBNull(dr("Priority"), ""), String)
            strSeverity = CType(CommonFunctions.Data.CheckIsDBNull(dr("Severity"), ""), String)
            strStatus = CType(CommonFunctions.Data.CheckIsDBNull(dr("Status"), ""), String)
            strDepartment = CType(CommonFunctions.Data.CheckIsDBNull(dr("Department"), ""), String)
        End If
        dr.Dispose()



        With Response
            .Write("<TABLE cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")

            .Write("<TR class=clsTREven>")
            .Write("<TD align=right> <B>Requestor : " & "</B>")
            .Write("</TD>")
            .Write("<TD align=left>")
            .Write(strCustomerID)
            If strCustomerName <> "" Then .Write(" | " + strCustomerName)
            .Write("</TD>")
            .Write("<TD align=right><B> Request ID : " & "</B>")
            .Write("</TD>")
            .Write("<TD align=left>")
            .Write(Query.ToString)
            .Write("</TD>")
            .Write("<TD></TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven>")
            .Write("<TD align=right><B>" & "Department :" & "</B>")
            .Write("</TD>")
            .Write("<TD align=left>")
            .Write(strDepartment)
            .Write("</TD>")


            .Write("<TD align=right><B>" & "Status : " & "</B>")
            .Write("</TD>")
            .Write("<TD align=left>")
            .Write(strStatus)
            .Write("</TD>")
            .Write("<TD></TD>")
            .Write("</TR>")


            .Write("<TR class=clsTREven>")
            .Write("<TD align=right><B>" & "Request Type :" & "</B>")
            .Write("</TD>")
            If CommonFunction.Application.SplitRequestTypeSubType = False Then
                strRtype = strRtype + "->" + strRSubtype
                .Write("<TD align=left colspan=3>")
                .Write(strRtype)
                .Write("</TD>")
                .Write("<TD></TD>")
            Else
                .Write("<TD align=left>")
                .Write(strRtype)
                .Write("</TD>")

                .Write("<TD align=right><B>" & " Sub Request Type : " & "</B>")
                .Write("</TD>")
                .Write("<TD align=left>")
                .Write(strRSubtype)
                .Write("</TD>")
                .Write("</TD><TD>")
            End If
            .Write("</TR>")

            .Write("<TR class=clsTREven >")
            .Write("<TD align=right><B>" & "Subject : " & "</B>")
            .Write("</TD>")
            .Write("<TD align=left colspan=5>")
            .Write(strSubject)
            .Write("</TD></TR>")

            .Write("<TR class=clsTREven>")
            .Write("<TD align=right><B>" & "Product : " & "</B>")
            .Write("</TD>")
            .Write("<TD align=left>")
            .Write(strProduct)
            .Write("</TD>")

            .Write("<TD align=right><B>" & "Module/Component : " & "</B>")
            .Write("</TD>")
            .Write("<TD align=left>")
            .Write(strComponent)
            .Write("</TD>")
            .Write("<TD></TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven>")
            .Write("<TD align=right><B>" & "Priority : " & "</B>")
            .Write("</TD>")
            .Write("<TD align=left>")
            .Write(strPriority)
            .Write("</TD>")

            .Write("<TD align=right><B>" & "Severity : " & "</B>")
            .Write("</TD>")
            .Write("<TD align=left>")
            .Write(strSeverity)
            .Write("</TD>")
            .Write("<TD></TD>")
            .Write("</TR>")

            .Write("</Table>")
            .Write("<BR>")

        End With

        'Integration Ends

    End Sub
End Class
