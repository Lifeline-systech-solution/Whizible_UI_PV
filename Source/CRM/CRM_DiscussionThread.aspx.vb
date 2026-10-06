
'Code Added by SiddharthS on 8 Mar 2005 for IssueID 15475
'Purpose:To display the text properly for disussion thread.
Imports System.Web.HttpUtility
'End Addition

Public Class CRM_DiscussionThread
    Inherits WebPages.Template.WhizTemplate
    Protected m_strAction As String = ""
    Private m_lngEmployeeID As Long
    Protected m_strLoginType As String = "E"
    Private m_strUserName As String = ""
    Private m_blnUseSQL As Boolean
    ' Modified by NitinVS on 24 Aug 2005 for WhizibleSEM SP4 Help desk Performance Improvement. 
    ' Private m_lngQueryID As Long
    Protected m_lngQueryID As Long
    ' End Modification By NitinVS 24 Aug 2005 for WhizibleSEM SP4 Help desk Performance Improvement. 
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    ' Added by NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueId 2 To Show Status Combo 
    Private m_intStatusID As Integer = 0
    ' End Addition by NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueId 2 To Show Status Combo 
    'Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4262
    'Added By shraddhaM on 17th Mar 06 - SLA For HelpDesk

    Private m_strStatusChangeDate As String = "Status Change Date"
    Private m_strStatusChangeTime As String = "Status Change Time"
    Protected strDate As String
    Protected strTime As String
    Protected m_strMode As String
    Protected strStatusChangeDate As String
    Protected strStatusChangeTime As String
    Protected serverDT As String
    Protected serverTime As String
    Protected serverH As String
    Protected serverM As String
    Protected WithEvents frmDiscussion As System.Web.UI.HtmlControls.HtmlForm
    Protected serverS As String
    'Ended By shraddhaM - SLA For HelpDesk
    'End Modification

    '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
    Protected m_PKToken_FromDT As String
    '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197

    'Addition by SuchitraP on 13-Mar-2009 for Whiziblesem7.2 for IssueID 29248
    'Purpose: To show Save link on Discussion page on e-dashboard when logged in user is HRM
    Protected m_strFromWhere As String = ""

    ''Added by AMIT MAHADIK on 16 Mar 2011,17 Mar 2011
    Private m_strSubmittedBy As String = ""
    Private m_strRowCount As Boolean = False
    'Added By Sanyogeeta on 12-Aug-2016
    Private m_blnValidate As Boolean = True
    Private m_blnIsRecordInGrid As Boolean
    ''End Added by AMIT MAHADIK on 16 Mar 2011
    ''Added by AMIT MAHADIK on 28 Mar 2011,17 Mar 2011
    Private m_blnIsAllowDeleteAtDeptLevel As Boolean
    ''END Added by AMIT MAHADIK on 28 Mar 2011,17 Mar 2011
    'Added by Amit Mahadik on 19 August 2011 whizibleSEM 10.0 (FAQ)
    Protected m_DepartmentName As String
    'ENDAdded by Amit Mahadik on 19 August 2011 whizibleSEM 10.0 (FAQ)
    Protected WithEvents m_strMenu As New WebPages.Template.StaticMenu

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
        Call Initialize()
        If Page.IsPostBack Then
            Call PerformActions()
        End If
        'If (m_PKToken_FromDT = "" And HttpContext.Current.HttpContext.Current.Session("intUserID") <> 0) Then
        '    m_blnValidate = False
        'ElseIf (m_lngQueryID <> 0) Then
        '    If (CommonFunctions.Security.Token.ValidateToken(CType(m_lngQueryID, String) + CType(m_lngEmployeeID, String) + CType(0, String) + CType(0, String), m_PKToken_FromDT) = True) Then
        '        m_blnValidate = False
        '    End If
        'End If
        'If (m_blnValidate = False) Then
        '    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        'End If

        ' '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
        'If (m_PKToken_FromDT = "" And HttpContext.Current.HttpContext.Current.Session("intUserID") <> 0) Then
        '    m_blnValidate = False
        'ElseIf (m_PKToken_FromDT <> "" And (CommonFunctions.Security.Token.ValidateToken(CType(m_lngQueryID, String) + CType(m_lngEmployeeID, String) + CType(0, String) + CType(0, String), m_PKToken_FromDT) = True)) Then
        '    If Page.IsPostBack Then
        '        Call PerformActions()
        '    End If
        'Else
        '    m_blnValidate = False
        'End If
        'If (m_blnValidate = False) Then
        '    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Help Desk Discussion Thread", 0, 0, "Query ID", CType(m_lngQueryID, String))
        '    'Token is Invalid now redirect to the Invalid Access Page
        '    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        'End If
        '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197
    End Sub


    Public Sub New()
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")
        ''COMMENTED AND ADDED BY NILESH G ON 24/10/2016 PURPOSE : SECURITY  
        '' MyBase.ApplySecurity(True, 1, , , True)
        MyBase.ApplySecurity(True)
        ''END OF COMMENTED AND ADDED BY NILESH G ON 24/10/2016 PURPOSE : SECURITY  
    End Sub

    ''Added by Nilesh Gundecha on 19/1/2015 for URL blocking issue
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken(Queryid As String, selectedids As String) As String
        Dim m_PKToken_Request_Multiple As String
        m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(Queryid, String) + CType(selectedids, String) + "0" + "0")
        Return m_PKToken_Request_Multiple

    End Function
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
        ' Created               : Feb 17,2004
        ' Revisions             :
        '=====================================================================
        ' Action of the page
        'Token will be generated from code below, when task is created and and without going to list page user continues with furthur actions
        If (m_lngQueryID.ToString <> "" And Trim(Request.QueryString("PKToken")) = "") Then
            'Added And Commented By Sanyogeeta R on 16-Aug-2016
            'm_PKToken_FromDT = Request.Form("txtPkToken").ToString
            If (Request.Form("txtPkToken") <> "") Then
                m_PKToken_FromDT = Request.Form("txtPkToken").ToString
            End If
            '''End of Comment and Addition by Sanyogeeta R on 16-Aug-2016
        Else
            m_PKToken_FromDT = Trim(Request.QueryString("PKToken") & "")
        End If
        '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197
        m_lngQueryID = CType(Request.QueryString("QueryID"), Long)
        m_lngEmployeeID = CType(HttpContext.Current.Session("intUserID"), Long)
        '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
        If (m_PKToken_FromDT = "" And HttpContext.Current.Session("intUserID") <> 0) Then
            m_blnValidate = False
        ElseIf (m_PKToken_FromDT <> "" And (CommonFunctions.Security.Token.ValidateToken(CType(m_lngQueryID, String) + CType(m_lngEmployeeID, String) + CType(0, String) + CType(0, String), m_PKToken_FromDT) = False)) Then
            m_blnValidate = False
        End If
        If (m_blnValidate = False) Then
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If
        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If

        'Addition by SuchitraP on 13-Mar-2009 for Whiziblesem7.2 for IssueID 29248
        'Purpose: To show Save link on Discussion page on e-dashboard when logged in user is HRM
        If Not Request.QueryString("FromWhere") Is Nothing Then
            m_strFromWhere = Request.QueryString("FromWhere")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidFromWhere"), "") <> "" Then
            m_strFromWhere = Request.Form("hidFromWhere")
        End If
        'End of addition by SuchitraP


        m_strUserName = HttpContext.Current.Session("strUserName").ToString
        m_strLoginType = HttpContext.Current.Session("LoginType").ToString

        'Added by Amit Mahadik on 28 Mar 2011 
        ''Purpose:Whizible SEM 10.0 ,option added at department level to allow delete discusion threads or not...
        ''so checking here if that option is enabled? 

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''Dim strIsAllowDeleteAtDeptLevel As String = "SELECT isshowtocustomer FROM tbl_PM_DepartmentMaster WHERE Departmentid IN (SELECT FunctionID FROM tbl_CRM_Query_Master WHERE QueryID = " & m_lngQueryID.ToString() & ")"
        Dim strIsAllowDeleteAtDeptLevel As String = "usp_sel_tbl_PM_DepartmentMaster_isshowtocustomer " & m_lngQueryID.ToString()
        ''''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        m_blnIsAllowDeleteAtDeptLevel = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strIsAllowDeleteAtDeptLevel.ToString(), True), ""), ""), Boolean)
        '''''select isshowtocustomer from tbl_PM_DepartmentMaster where Departmentid in (select FunctionID from tbl_CRM_Query_Master where QueryID = 362)
        'END Added by Amit Mahadik on 28 Mar 2011 

        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

        'Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4262
        'Code Added By PradipK for Help Desk SLA 
        If Not Request.QueryString("Mode") Is Nothing Then
            m_strMode = Request.QueryString("Mode").ToString
        Else
            m_strMode = ""
        End If
        'End Addition By PradipK for Help Desk SLA 
        'End Integration


        '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197


        'Added by Amit Mahadik on 19 August 2011 whizibleSEM 10.0 (FAQ)
        Dim strSQLDeptName As String = "usp_Sel_CRM_DeptName_QueryId " & m_lngQueryID
        m_DepartmentName = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQLDeptName, True))
        'Added by Amit Mahadik on 19 August 2011 whizibleSEM 10.0 (FAQ)

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
        ' Created               : Feb 17,2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim dr As IDataReader
        Dim blnShowPopup As Boolean
        Dim blnSendMail As Boolean
        Dim strFromEmailID As String
        Dim strToMailID As String
        Dim strCCToMailID As String
        Dim strSubject, strMessage As String
        Dim FeedbackID As String
        Dim FeedbackComments As String
        'Added by Amit Mahadik on 16 Mar 2011 Purpose:Whizible SEM 10.0
        Dim strIsShowToCustomer As String
        'end Added by Amit Mahadik on 16 Mar 2011 Purpose:Whizible SEM 10.0
        If UCase(Trim(m_strAction & "")) = "SAVE" Then
            ' save the discussion
            FeedbackID = MyBase.GetFormValue("cboFeedback")
            'Added by Amit Mahadik on 16 Mar 2011 Purpose:Whizible SEM 10.0
            strIsShowToCustomer = MyBase.GetFormValue("chkIsShowToCustomer")
            If strIsShowToCustomer <> "" And strIsShowToCustomer.ToUpper.Equals("ON") Then
                strIsShowToCustomer = "TRUE"
            Else
                strIsShowToCustomer = "FALSE"
            End If
            'Added by Amit Mahadik on 17 Mar 2011 Purpose:Whizible SEM 10.0 PURPOSE: customer can see his/her comments.
            If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("LoginType"), "") = "C" Then
                strIsShowToCustomer = "TRUE"
            End If
            'end Added by Amit Mahadik on 17 Mar 2011 Purpose:Whizible SEM 10.0 PURPOSE: customer can see his/her comments.
            'end Added by Amit Mahadik on 16 Mar 2011 Purpose:Whizible SEM 10.0
            'Added by Amit Mahadik on 01 August 2011 Purpose:Whizible SEM 10.0 IssueID 50822


            ''Dim strSQLTemp As String = "SELECT LoginType FROM tbl_CRM_Query_Master WHERE QueryID='" & m_lngQueryID.ToString() & "'"

            ''Dim strSQLTemp As String = "SELECT LoginType FROM tbl_CRM_Query_Master WHERE QueryID='" & m_lngQueryID.ToString() & "'"
            Dim strSQLTemp As String = "usp_sel_tbl_CRM_Query_Master_LoginType '" & m_lngQueryID.ToString() & "'"


            Dim strLoginTypeTemp As String = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLTemp, MyBase.UseSQL), ""), ""), String)
            If strLoginTypeTemp <> "C" Then
                strIsShowToCustomer = "TRUE"
            End If
            'Added by Amit Mahadik on 01 August 2011 Purpose:Whizible SEM 10.0 IssueID 50822
            If FeedbackID = "" Then
                FeedbackID = "NULL"
            End If
            FeedbackComments = Replace(MyBase.GetFormValue("txtFeedbackComments"), "'", "''")

            strSQL = "usp_CRM_Insert_DiscussionThread " & m_lngQueryID
            strSQL = strSQL & ",'" & Now().ToString & "'"
            strSQL = strSQL & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName & "") & "'"
            strSQL = strSQL & ",'" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
            strSQL = strSQL & ",'" & MyBase.GetFormValue("txtComments") & "'"

            'Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4262
            'Code Added By PradipK for Help Desk SLA 
            strSQL = strSQL & ",'" & MyBase.GetFormValue("txtchangedDate") & "'"
            strSQL = strSQL & ",'" & MyBase.GetFormValue("txtchangedTime") & "'"
            'End Addition By PradipK for Help Desk SLA 
            'End Integration
            'Added by ShraddhaM to save feedback for close status 24,Sep 2009
            strSQL = strSQL & "," & FeedbackID & ","
            strSQL = strSQL & "'" & FeedbackComments & "'"
            'Added by Amit Mahadik on 16 Mar 2011 Purpose:Whizible SEM 10.0
            strSQL = strSQL & "," & strIsShowToCustomer
            'end Added by Amit Mahadik on 16 Mar 2011 Purpose:Whizible SEM 10.0
            'Ended by ShraddhaM
            CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)


            ' send mail
            dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 47", m_blnUseSQL)
            If dr.Read Then
                blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
                blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
            End If
            CommonFunctions.Data.DisposeDataReader(dr)

            If blnSendMail Then
                If blnShowPopup Then
                    With Response
                        .Write("<script language=javascript>")
                        'Modified by Amit Mahadik Whiziblesem 10.0 Issue ID:50821 ,01 August 2011   1003  
                        Dim strTempIsShowToCustomer As String
                        If MyBase.GetFormValue("chkIsShowToCustomer").ToUpper.Equals("ON") Then
                            strTempIsShowToCustomer = "1"
                        Else
                            strTempIsShowToCustomer = "0"
                        End If
                        'Added By Amit Mahadik Whiziblesem 10.0 Issue ID:50821 ,01 August 2011     
                        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("LoginType"), "") = "C" Then
                            strTempIsShowToCustomer = "1"
                        End If
                        'END Added By Amit Mahadik Whiziblesem 10.0 Issue ID:50821 ,01 August 2011     

                        ''Commented And Added By Vaijat K ON 14/07/2017 For generating Token
                        Dim strToken As String = CommonFunctions.Security.Token.GetToken("1003" & m_lngQueryID & strTempIsShowToCustomer & HttpContext.Current.Session("intUserid") & "0")
                        ''.Write(" window.open (""../General/SendEmail.aspx?MessageID=1003&QueryID=" & m_lngQueryID & "&IsShowToCustomer=" & strTempIsShowToCustomer & "&MultipleRequests=0&EmployeeIDList=" & HttpContext.Current.Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                        'Added & Commented by Dipali V On 25th Oct 2017 For Send Mail PopUp 
                        ' .Write(" window.open (""../General/SendEmail.aspx?MessageID=1003&QueryID=" & m_lngQueryID & "&IsShowToCustomer=" & strTempIsShowToCustomer & "&MultipleRequests=0&EmployeeIDList=" & HttpContext.Current.Session("intUserid").ToString & "&PkToken=" & strToken & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                        .Write(" window.open (""../General/CRMSendEmail.aspx?MessageID=1003&DiscussionID=431263&QueryID=" & m_lngQueryID & "&IsShowToCustomer=" & strTempIsShowToCustomer & "&MultipleRequests=0&EmployeeIDList=" & HttpContext.Current.Session("intUserid").ToString & "&PkToken=" & strToken & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                        'Added & Commented by Dipali V On 25th Oct 2017 For Send Mail PopUp 
                        ''End of Commented And Added By Vaijat K ON 14/07/2017 For generating Token
                        'End Modified by Amit Mahadik Whiziblesem 10.0 Issue ID:50821 ,01 August 2011
                        ''Added by NitinC on 10 Aug 2011 for WhizibleSEM v10.0 to close discussion thread window
                        '.Write("window.close();")
                        ''End
                        .Write("</script>")
                    End With
                Else
                    ' silent mail
                    CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_47(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, m_lngQueryID)
                    CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                End If
            End If


            ' Added by NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueId 2 To Show Status Combo 

            Dim strCurrStatus As String
            Dim strPrevStatus As String
            Dim dtmResolvedDate As String
            Dim objDr As IDataReader
            Dim strSQLStatus As String

            m_intStatusID = CType(MyBase.GetFormValue("cbostatus"), Integer)

            objDr = CommonFunctions.Data.GetDataReader("usp_CRM_Get_RequestDetails " & m_lngQueryID, m_blnUseSQL)
            If objDr.Read Then
                strPrevStatus = objDr("Status").ToString
                dtmResolvedDate = CType(CommonFunctions.Data.CheckIsDBNull(objDr("ResolvedDate"), ""), String)
            End If
            CommonFunctions.Data.DisposeDataReader(objDr)
            ' code modified by Harshada D for whizibleSEM 6 on 31 May 2006 for Issue ID 1936 helpdesk enhancements
            'closed date and resolved dates are not getting updated by discussion thread page .
            'Commented By PrashantD on 9,Jan 2008 for whizible 7.1
            'Purpose : No need of this code bcoz same updation occurs in following update SP
            ''''Select Case m_intStatusID.ToString
            ''''    Case "2"
            ''''        If dtmResolvedDate = "" Then
            ''''            strSQLStatus = "Update Tbl_CRM_Query_Master SET StatusID = " + m_intStatusID.ToString + " ,closedDate = getDate() ,ResolvedDate = getDate()  WHERE QueryID = " + m_lngQueryID.ToString
            ''''        Else
            ''''            strSQLStatus = "Update Tbl_CRM_Query_Master SET StatusID = " + m_intStatusID.ToString + " ,closedDate = getDate() WHERE QueryID = " + m_lngQueryID.ToString
            ''''        End If
            ''''    Case "3"
            ''''        strSQLStatus = "Update Tbl_CRM_Query_Master SET StatusID = " + m_intStatusID.ToString + " ,closedDate = null,ResolvedDate = getDate()  WHERE QueryID = " + m_lngQueryID.ToString
            ''''    Case Else
            ''''        strSQLStatus = "Update Tbl_CRM_Query_Master SET StatusID = " + m_intStatusID.ToString + ",closedDate = null,ResolvedDate = null WHERE QueryID = " + m_lngQueryID.ToString

            ''''End Select
            'End of comment By PrashantD on 9,Jan 2008 for whizible 7.1
            'strSQLStatus = "Update Tbl_CRM_Query_Master SET StatusID = " + m_intStatusID.ToString + " WHERE QueryID = " + m_lngQueryID.ToString
            'end of modifications by harshada D for closed date issue in helpdesk from discussion thread

            'Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4262
            'Modified by VarunA on 6-Jan-2009 IssueID-26293
            'Purpose : To handle the single quote for custome & employee user name
            'strSQLStatus = "usp_UPD_tbl_CRM_Query_master_DT " + m_lngQueryID.ToString + "," + m_intStatusID.ToString + ",'" + HttpContext.Current.Session("strUserName").ToString + "'"
            strSQLStatus = "usp_UPD_tbl_CRM_Query_master_DT " + m_lngQueryID.ToString + "," + m_intStatusID.ToString + ",'" + CommonFunctions.General.BuildQueryString(HttpContext.Current.Session("strUserName").ToString) + "'"
            'End by VarunA on 6-Jan-2009 IssueID-26293
            'Added By shraddhaM on 20th Mar 06 - SLA For HelpDesk
            strSQLStatus = strSQLStatus & ",'" & MyBase.GetFormValue("txtchangedDate") & "'"
            strSQLStatus = strSQLStatus & ",'" & MyBase.GetFormValue("txtchangedTime") & "'"
            'Ended By shraddhaM - SLA For HelpDesk
            'End Integration

            CommonFunction.Data.InsertOrUpdateData(strSQLStatus, MyBase.UseSQL)

            objDr = CommonFunctions.Data.GetDataReader("usp_CRM_Get_RequestDetails " & m_lngQueryID, m_blnUseSQL)
            If objDr.Read Then
                strCurrStatus = objDr("Status").ToString
            End If
            CommonFunctions.Data.DisposeDataReader(objDr)



            ' Status change mail
            If Trim(strCurrStatus & "") <> "" And Trim(strPrevStatus & "") <> Trim(strCurrStatus & "") Then
                blnSendMail = False : blnShowPopup = False
                dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 44", m_blnUseSQL)
                If dr.Read Then
                    blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
                    blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
                End If
                CommonFunctions.Data.DisposeDataReader(dr)

                If blnSendMail Then
                    If blnShowPopup Then
                        With Response
                            .Write("<script language=javascript>")
                            .Write("window.open (""../General/SendEmail.aspx?MessageID=44&QueryID=" & m_lngQueryID & "&EmployeeIDList=" & HttpContext.Current.Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                            .Write("</script>")
                        End With
                    Else
                        ' silent mail
                        CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_44(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, m_lngQueryID)
                        CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                    End If
                End If
            End If
            ' End Addition by NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueId 2 To Show Status Combo 
            ''Added by NitinC on 10 Aug 2011 for WhizibleSEM v10.0 to close discussion thread window
            With Response
                .Write("<script language=javascript>")
                'Added By Bharat Tekade on 3rd-Feb-2016 for Parent page Refresh
                .Write(" window.opener.location.href=window.opener.location.href; ")
                'End of Added By Bharat Tekade on 3rd-Feb-2016 for Parent page Refresh
                .Write("window.close();")
                .Write("</script>")
            End With
            ''End
            'Modified by Amit Mahadik on 15 Mar 2011 Purpose:Whizible SEM 10.0
        ElseIf UCase(Trim(m_strAction & "")) = "DELETE" Then
            ' DELETE THE DISCUSSION THREAD
            Dim strDeleteIDS As String
            Dim strQuery As String
            strDeleteIDS = MyBase.GetFormValue("chkDiscussionThread")
            If Not strDeleteIDS Is Nothing And strDeleteIDS <> "" Then
                strQuery = "usp_del_tbl_CRM_Query_Details '" + strDeleteIDS + "'"
                CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                ''==
                CommonFunction.General.WriteHTML("<script language=javascript>")
                ''TODO refresh parent page i.e.    ../CRM/CRM_Dashboard.aspx
                ''CommonFunction.General.WriteHTML("refreshParent('frmDashboard','CRM_Dashboard.aspx','../CRM/CRM_Dashboard.aspx?Mode=DB',true);")
                ''CommonFunction.General.WriteHTML("opener.window.location.href = 'CRM_Dashboard.aspx?Mode=DB';")
                CommonFunction.General.WriteHTML("</script>")
                ''==
            End If
            'END Modified by Amit Mahadik on 15 Mar 2011 Purpose:Whizible SEM 10.0


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
        ' Created               : Feb 17,2004
        ' Revisions             :
        '=====================================================================
        'Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
        'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}

        'Dim arrCSFunction() As String = {"Save_OnClick(" & m_lngQueryID & ")", "Close_OnClick()", "Help_OnClick('CRM_DISCUSSIONS')"}

        'Modified by PrajaktaR
        Dim strSQLStatus As String

        Dim strMenu As String
        Dim drHRM As IDataReader
        Dim strHRM As String
        Dim blnIsHRM As Integer = 0
        blnIsHRM = 0
        strHRM = "Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID.ToString
        drHRM = CommonFunctions.Data.GetDataReader(strHRM, m_blnUseSQL)
        If drHRM.Read Then
            blnIsHRM = 1
        End If
        drHRM.Close()
        CommonFunctions.Data.DisposeDataReader(drHRM)

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQLStatus = "SELECT StatusID FROM Tbl_CRM_Query_Master WHERE QueryID = " + m_lngQueryID.ToString
        strSQLStatus = "usp_sel_Tbl_CRM_Query_Master_StatusID '" + m_lngQueryID.ToString + "'"
        ''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        m_intStatusID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLStatus, MyBase.UseSQL), "0"), "0"), Integer)
        'If m_intStatusID = 2 And blnIsHRM <> 1 Then
        If m_intStatusID = 2 And Request.QueryString("FromWhere") <> "DB" Then
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
            Dim arrCSFunction() As String = {"Close_OnClick()", "Help_OnClick('CRM_DISCUSSIONS')"}
            strMenu = m_strMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
        Else
            'Modified by Amit Mahadik on 19 August 2011 whizibleSEM 10.0 (FAQ)
            If (m_strFromWhere = "AR" Or m_strFromWhere = "DB") Then
                Dim arrMenu() As String = {"Convert To FAQ", "FAQs", MyBase.GetResourceString("MENU_DELETE"), MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
                Dim arrMenuToolTip() As String = {"Convert Discussion Threads to FAQs", "Frequently Asked Questions", MyBase.GetResourceString("MENU_DELETE_TOOLTIP"), MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
                Dim arrCSFunction() As String = {"Faq_Convert()", "Faq_Onlick()", "Delete_OnClick(" & m_lngQueryID & ")", "Save_OnClick(" & m_lngQueryID & ")", "Close_OnClick()", "Help_OnClick('CRM_DISCUSSIONS')"}
                'End Modified by Amit Mahadik on 19 August 2011 whizibleSEM 10.0 (FAQ)
                strMenu = m_strMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
            Else
                Dim arrMenu() As String = {"FAQs", MyBase.GetResourceString("MENU_DELETE"), MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
                Dim arrMenuToolTip() As String = {"Frequently Asked Questions", MyBase.GetResourceString("MENU_DELETE_TOOLTIP"), MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
                Dim arrCSFunction() As String = {"Faq_Onlick()", "Delete_OnClick(" & m_lngQueryID & ")", "Save_OnClick(" & m_lngQueryID & ")", "Close_OnClick()", "Help_OnClick('CRM_DISCUSSIONS')"}
                'End Modified by Amit Mahadik on 19 August 2011 whizibleSEM 10.0 (FAQ)
                strMenu = m_strMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
            End If

        End If

        'Modified by PrajaktaR
        Dim dr As IDataReader
        Dim strSQL As String
        'Dim strMenu As String

        'Modified by Amit Mahadik on 17 Mar 2011 Purpose:Whizible SEM 10.0
        ''' Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}

        'Display the PageLegends 
        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("LoginType"), "") = "C" Then
            Dim strarrLegend() As String = {"Mandatory"}
            Dim strarrLegendImage() As String = {"<img src='../../images/star.gif'>"}
            CommonFunctions.General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, strarrLegendImage, strarrLegend) + vbCrLf)
        Else
            Dim strarrLegend() As String = {"Discussion thread in blue color indicates thread shown to customer", "Mandatory"}
            Dim strarrLegendImage() As String = {"", "<img src='../../images/star.gif'>"}
            CommonFunctions.General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, strarrLegendImage, strarrLegend) + vbCrLf)
        End If

        'END Modified by Amit Mahadik on 17 Mar 2011 Purpose:Whizible SEM 10.0


        '        strMenu = WebPages.Template.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip)

        MyBase.InitializeResources("AppResources.CRM_DiscussionThread", "AppResources")

        'Added by ShraddhaM on 16,Apr 2009 to display subject for request.
        Dim strDTQuery As String
        Dim drDT As IDataReader
        Dim strSubject As String
        Dim strCount As String

        strDTQuery = "USP_Sel_QuerySubject_DTCount " + m_lngQueryID.ToString
        drDT = CommonFunction.Data.GetDataReader(strDTQuery, MyBase.UseSQL)

        While drDT.Read()
            strSubject = drDT("Subject").ToString()
            strCount = drDT("DTCount").ToString()
        End While
        'Ended by ShraddhaM
        CommonFunctions.Data.DisposeDataReader(drDT)
        'Modified by Amit Mahadik on 15 Mar 2011 Purpose:Whizible SEM 10.0
        Dim arrActualCols() As String = {"SubmittedBy", "SubmittedDate", "DiscussionThread", "", ""}
        Dim arrUserFriendlyCols() As String = {MyBase.GetResourceString("COL_USERNAME"), MyBase.GetResourceString("COL_DATE"), MyBase.GetResourceString("COL_COMMENTS"), "Delete", "Convert"} ''TODO : MyBase.GetResourceString("SELECT")
        Dim arrCheckBox() As String = {"", "", "", "chkDiscussionThread", "chkConvertToFAQ"}
        'End Modified by Amit Mahadik on 15 Mar 2011 Purpose:Whizible SEM 10.0
        ' menu
        Response.Write(strMenu)
        'legends    
        '''WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend)


        'page caption
        'Commented and Modified by SavitaS on 11 Sept 2006 for SP7 Integration IssueId 5458
        'Purpose : To Display help request id on pop-up of discussion thread page
        'Response.Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("DISCUSSION_THREAD_CAPTION"))) 
        'Response.Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("DISCUSSION_THREAD_CAPTION"), "Request ID  : " + CType(m_lngQueryID, String)))
        Response.Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("DISCUSSION_THREAD_CAPTION") + "&nbsp;(" + strCount + ")", ))
        'End of Commented and Modified by SavitaS on 11 Sept 2006 for SP7 Integration IssueId 5458


        'Added by ShraddhaM on 16,Apr 2009 to display subject for request.
        Response.Write("<BR>")

        Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0>")

        Response.Write("<tr class=clsTRColumnHeader>")
        Response.Write("<td  width='25%' align=center><B>Request ID<BR><Font size=4>" + m_lngQueryID.ToString() + "</Font></B></td>")
        Response.Write("<td  width='75%' ><B>Subject&nbsp;:&nbsp;" + strSubject + "</B></td>")
        Response.Write("</tr>")
        Response.Write("</Table>")

        'Ended by shraddhaM


        Response.Write("<BR>")
        'Commented And Added By Vaijat K ON 05/12/2015 Issue ID-2635
        'Response.Write("<div id=divList style='overflow:auto;width=100%;height=300;Z-INDEX: 120;' >")
        Response.Write("<div id=divList style='overflow:auto;width:100%;Z-INDEX: 120;' >")

        ' user name
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        Response.Write("<tr class=clsTREven>")
        Response.Write("<td  width='25%' align=right>")
        Response.Write(MyBase.GetResourceString("USERNAME_CAPTION") & "</td>")
        Response.Write("<td  width='75%' >" & m_strUserName)
        Response.Write("</td>")
        Response.Write("</tr>")

        ' date
        Response.Write("<tr class=clsTREven>")
        Response.Write("<td  width='25%' align=right>")
        Response.Write(MyBase.GetResourceString("DATE_CAPTION") & "</td>")
        Response.Write("<td  width='75%' >" & CommonFunctions.Dates.CGetDateTime(Now()))
        Response.Write("</td>")
        Response.Write("</tr>")

        ' text area for comments
        Response.Write("<tr class=clsTREven>")
        Response.Write("<td  width='25%' align=right VAlign=Top>")
        Response.Write(MyBase.GetResourceString("COMMENTS_CAPTION") & "</td>")
        Response.Write("<td  width='75%'>")
        'Added by Amit Mahadik on 22 August 2011 whizibleSEM 10.0 (FAQ)
        If (CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ConvertFlag")).ToString.ToUpper() = "CONVERT") Then
            Dim RequiredIdArray As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RequiredFaqId"))
            Dim selectedID() As String
            Dim SqlQry As String
            Dim ResultString As String = ""
            Dim SqlResult As String
            Dim i As Integer
            selectedID = RequiredIdArray.Split(CChar(","))
            For i = 0 To selectedID.Length - 1
                SqlQry = "Usp_Sel_FaqToConvert_DT " + selectedID(i) & ""
                SqlResult = CommonFunction.Data.GetDataScalar(SqlQry, True).ToString
                ResultString = ResultString + SqlResult + vbCrLf
            Next
            'CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", MyBase.GetResourceString("COL_COMMENTS"), , , "frmDiscussion", , , 390, 100, , ResultString, , , , , , , , , True, , , , , , ,)
            'Commented By Shamkant S on 17 Nov 2015
            CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", MyBase.GetResourceString("COL_COMMENTS"), , , "frmDiscussion", , , 390, 100, , ResultString, , , , , , , , , True, , , , , , , EnableHTMLEncode:=True)
        Else
            'End Added by Amit Mahadik on 22 August 2011 whizibleSEM 10.0 (FAQ)
            'Modified By ShraddhaM on 27 July 2006
            'CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", MyBase.GetResourceString("COL_COMMENTS"), , , "frmDiscussion", , , 390, 100, , , , , , , , , , , True, , , , , , ,)

            CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", MyBase.GetResourceString("COL_COMMENTS"), , , "frmDiscussion", , , 390, 100, , , , , , , , , , , True, , , , , , , EnableHTMLEncode:=True)
        End If
        'CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", MyBase.GetResourceString("COL_COMMENTS"), , , "frmDiscussion", , , 390, 100, , , , , , , , , , , True, , , , , , , )
        Response.Write("</td></tr>")

        ' Added by NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueId 2 To Show Status Combo 

        ' Draw Status Combo
        ' Fetch The Current Status of the Request 

        ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQL = "SELECT StatusID FROM Tbl_CRM_Query_Master WHERE QueryID = " + m_lngQueryID.ToString
        strSQL = "usp_sel_Tbl_CRM_Query_Master_StatusID '" + m_lngQueryID.ToString + "'"
        ''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        m_intStatusID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), "0"), Integer)

        'Modified by Amit Mahadik on 16 Mar 2011 Purpose:Whizible SEM 10.0
        'Modified by Amit Mahadik on 28 July 2011 Purpose:Whizible SEM 10.0 IssueID 50822

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''Dim strSQLReuestLoginType As String = "SELECT LoginType FROM Tbl_CRM_Query_Master WHERE QueryID = " + m_lngQueryID.ToString
        Dim strSQLReuestLoginType As String = "usp_sel_tbl_CRM_Query_Master_LoginType '" + m_lngQueryID.ToString + "'"
        ''End of Comment and Addition by Dhanashri S on 3 Aug 2016


        Dim strReuestLoginType As String = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLReuestLoginType, MyBase.UseSQL), ""), ""), String)
        If (m_strLoginType <> "C" And strReuestLoginType.ToUpper() = "C") Then
            'End Modified by Amit Mahadik on 28 July 2011 Purpose:Whizible SEM 10.0 IssueID 50822
            Response.Write("<TR class=clsTREven>")
            Response.Write("<td  width='25%' align=right VAlign=Top>")
            Response.Write("Show To Customer" & "</td>") '' TODO MyBase.GetResourceString("")
            Response.Write("<td  width='75%'>")


            'Response.Write(CommonFunction.HTMLControls.DrawCheckBox("chkIsShowToCustomer", "chkIsShowToCustomer", , CType(False, Boolean), , , "", , False, , True))
            CommonFunction.General.WriteHTML("<Input type=checkbox name='chkIsShowToCustomer' id='chkIsShowToCustomer' class='clsCheckBox' CHECKED>")

            Response.Write("</td></tr>")
        End If
        'END Modified by Amit Mahadik on 16 Mar 2011 Purpose:Whizible SEM 10.0

        Response.Write("<TR class=clsTREven>")
        Response.Write("<td  width='25%' align=right VAlign=Top>")
        Response.Write(MyBase.GetResourceString("STATUS_CAPTION") & "</td>")
        Response.Write("<td  width='75%'>")

        'Added by GaneshD on 05 Oct 2009 for showing only those statuses which are configured
        '        CommonFunctions.HTMLControls.DrawComboBox("cbostatus", "usp_CRM_Get_RequestStatus", 200, m_intStatusID.ToString, " onchange=javascript:cboStatus_OnChange() ", , , , True)
        'Commented And Added by NitinC on 25 March 2011 for WhizibleSEM 10.0 to provide Role wise Acces to Reuest status
        'CommonFunctions.HTMLControls.DrawComboBox("cbostatus", "usp_CRM_Get_RequestStatus " + m_lngQueryID.ToString, 200, m_intStatusID.ToString, " onchange=javascript:cboStatus_OnChange() ", , , , True)
        Dim RoleId As String = HttpContext.Current.Session("intPostId")
        CommonFunctions.HTMLControls.DrawComboBox("cbostatus", "usp_CRM_Get_RequestStatus " + m_lngQueryID.ToString + "," + RoleId, 200, m_intStatusID.ToString, " onchange=javascript:cboStatus_OnChange() ", , , , True)
        'End of Commented And Added by NitinC on 25 March 2011 for WhizibleSEM 10.0 to provide Role wise Acces to Reuest status
        ' End of modification by GaneshD
        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        CommonFunction.HTMLControls.DrawTextBox("cboStatusOld", "cboStatusOld", , , , m_intStatusID.ToString, DisplayNone:=True, EnableHTMLEncode:=True)

        'ended by Yogesh J for HTML encoding Date:05/10/15

        ' Added by VijayD on 11 Jun 2009 For HelpDesk StatusFlow Configuration
        Dim m_StatusFlowCount As String = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Exec usp_Sel_CRM_GetStatusFlowCount " + CType(m_lngQueryID, String) + "", MyBase.UseSQL), "0"), String)

        Dim strOldStatus As String = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Exec usp_Sel_CRM_GetStatus " + CType(m_intStatusID, String), MyBase.UseSQL), "0"), String)

        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("StatusFlowCount", "StatusFlowCount", , , , m_StatusFlowCount, IsHidden:=True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtOldStatus", "txtOldStatus", , , , strOldStatus, IsHidden:=True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:05/10/15
        Dim m_IntSubRequestID As String = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("select SubRequestTypeID from tbl_CRM_Query_Master where queryID=" + CType(m_lngQueryID, String) + "", MyBase.UseSQL), "0"), String)

        Response.Write(CommonFunction.HTMLControls.DrawComboBox("CmbStatus", "Exec usp_CRM_ValidateCRMStatus '" + m_IntSubRequestID + "',2,'" + strOldStatus + "'", DisplayNone:=True)) '--, displaynone:=True
        Response.Write(CommonFunction.HTMLControls.DrawComboBox("CmbPrevStatus", "Exec usp_CRM_ValidateCRMStatus '" + m_IntSubRequestID + "'," + "1", DisplayNone:=True)) ', displaynone:=True
        ' Addition End by VijayD on 11 Jun 2009


        Response.Write("</td></tr>")
        ' End Addition by NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueId 2 To Show Status Combo 

        'Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4262
        'Code Added By PradipK for Help Desk SLA 
        Dim rec As Integer
        Dim record As String
        If UCase(Trim(m_strMode & "")) = "EDIT" Then
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strDate = "select ISNULL(REPLACE((convert(varchar(50),cast(StatusChangeDate as smallDatetime),106)),' ','-'),'') FROM Tbl_CRM_Query_Master where QueryID='" & m_lngQueryID & "'"
            strDate = "usp_sel_Tbl_CRM_Query_Master_StatusChangeDate '" & m_lngQueryID & "'"
            ''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strTime = "select ISNULL(StatusChangeTime,'') from Tbl_CRM_Query_Master where QueryID='" & m_lngQueryID & "'"
            strTime = "usp_sel_Tbl_CRM_Query_Master_StatusChangeTime '" & m_lngQueryID & "'"
            ''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            Response.Write("<TR class=clsTREven>")
            Response.Write("<td align=right>" & m_strStatusChangeDate & "</TD>")
            Response.Write("<TD>")


            '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197

            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_FromDT, , , , , , , , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:05/10/15
            '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197


            Dim strSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
            Dim strDate1 As String = CommonFunction.Data.GetDataScalar(strSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString


            Dim strdt As String
            strdt = CType(CommonFunctions.Data.GetDataScalar(strDate, True), String).ToString

            Dim strtm As String
            strtm = CType(CommonFunctions.Data.GetDataScalar(strTime, True).ToString, String)

            'Addition by SuchitraP on 13-Mar-2009 for Whiziblesem7.2 for IssueID 29248
            'Purpose: To show Save link on Discussion page on e-dashboard when logged in user is HRM
            CommonFunction.General.WriteHTML("<input type=Hidden name=hidFromWhere id=hidFromWhere value=" + m_strFromWhere + ">")

            'End of addition by SuchitraP

            'Hidden date control contains DateValue of particular status from database
            CommonFunction.HTMLControls.DrawDateControl("txtchangedDatehidden1", "txtchangedDateHidden1", , , strdt, , "frmDiscussion", , , , , , , , False, , , True)
            'control contains DateValue of particular status from database
            CommonFunction.HTMLControls.DrawDateControl("txtchangedDate", "txtchangedDate", , , strdt, , "frmDiscussion", , , , , , , , True, , , )

            Response.Write("</TD>")
            Response.Write("<td align=right>" & m_strStatusChangeTime & "</TD>")
            Response.Write("<TD>")

            'hidden time control contains TimeValue of particular status from database
            'shraddha
            'CommonFunction.HTMLControls.DrawTextBox("txtchangedTimeHidden1", "txtchangedTimeHidden1", , , , strtm, , , , , , True, , , False, , , )
            CommonFunction.HTMLControls.DrawTextArea("txtchangedTimehidden1", "txtchangedTimehidden1", , , , "frmDiscussion", , , , , , strtm, , , , , , True, , , , , , , , True, "Soft", )
            'CommonFunction.HTMLControls.DrawTextArea("txtchangedTimeHidden1", "txtchangedTimeHidden1", , , , "frmDiscussion", , , , , , strtm, , , , , , True, , , , , , , , True, , )
            'control contains TimeValue of particular status from database   

            'Commented and added by Yogesh J for HTML encoding Date:05/10/15

            CommonFunction.HTMLControls.DrawTextBox("txtchangedTime", "txtchangedTime", , 50, , strtm, , , , , , , , , True, , , EnableHTMLEncode:=True).ToString()

            'ended by Yogesh J for HTML encoding Date:05/10/15
            Response.Write("</TD>")
            Response.Write("</TR>")

            'Hidden contols contains Current server date and time
            Dim strGetServerTimeSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
            Dim strGetServerTime1 As String = CommonFunction.Data.GetDataScalar(strGetServerTimeSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
            Dim strGetServerDateSQL1 As String = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
            Dim strGetServerDate1 As String = CommonFunction.Data.GetDataScalar(strGetServerDateSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

            ' "Select Case Convert(VARCHAR(30), GetDate(), 105)"
            'CType(CommonFunctions.Data.GetDataScalar("Select Case Convert(VARCHAR(30), GetDate(), 105)", True), String)()
            'Dim strSDate As String = CommonFunction.Data.GetDataScalar("Select ISNULL(REPLACE(convert(VARCHAR(30), GetDate(), 106),' ','-'),'')", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

            'CommonFunction.HTMLControls.DrawDateControl("CurrentDate", "CurrentDate", , , CommonFunction.Dates.GetDate(Now()), , "frmDiscussion", , , , , , , , False, , , True)
            Response.Write(CommonFunction.HTMLControls.DrawDateControl("CurrentDate", "CurrentDate", , , strGetServerDate1, , "frmDiscussion", , , , , , , , False, , , True)) 'CommonFunctions.Dates.CGetDate(CType(strSDate, Date))


            'Response.Write(CommonFunction.HTMLControls.DrawTextBox("CurrentDate", "CurrentDate", , , , CType(CommonFunction.Dates.GetDate(Date.Now), String), IsHidden:=True))

            'Dim strSDate As String = CommonFunction.Data.GetDataScalar("Select Case Convert(VARCHAR(30), GetDate(), 105)", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString


            'Response.Write(CommonFunction.HTMLControls.DrawTextBox("CurrentDate", "CurrentDate", , , , CType(CommonFunctions.Data.GetDataScalar(strSDate, True), String), IsHidden:=True))

            'Response.Write(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , h & ":" & m, IsHidden:=True))
            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            Response.Write(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strDate1, IsHidden:=True, EnableHTMLEncode:=True))


            'ended by Yogesh J for HTML encoding Date:05/10/15

        Else
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strDate = "select IsNull(REPLACE((convert(varchar(50),cast(StatusChangeDate as smallDatetime),106)),' ','-'),'') FROM Tbl_CRM_Query_Master where QueryID='" & m_lngQueryID & "'"
            strDate = "usp_sel_Tbl_CRM_Query_Master_StatusChangeDate '" & m_lngQueryID & "'"
            ''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strTime = "select IsNull(StatusChangeTime,'') from Tbl_CRM_Query_Master where QueryID='" & m_lngQueryID & "'"
            strTime = "usp_sel_Tbl_CRM_Query_Master_StatusChangeTime '" & m_lngQueryID & "'"
            ''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            Response.Write("<TR class=clsTREven>")
            ''shraddha 24 
            If m_strLoginType = "E" Then
                Response.Write("<td align=right>" & m_strStatusChangeDate & "</TD>")
            Else
                Response.Write("<td align=right> </TD>")
            End If
            Response.Write("<TD>")

            Dim strSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
            Dim strDate1 As String = CommonFunction.Data.GetDataScalar(strSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

            Dim strdt As String
            strdt = CType(CommonFunctions.Data.GetDataScalar(strDate, True), String).ToString

            Dim strtm As String
            strtm = CType(CommonFunctions.Data.GetDataScalar(strTime, True).ToString, String)

            '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_FromDT, , , , , , , , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:05/10/15
            '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197


            'Hidden date control contains DateValue of particular status from database
            CommonFunction.HTMLControls.DrawDateControl("txtchangedDatehidden1", "txtchangedDateHidden1", , , strdt, , "frmDiscussion", , , , , , , , False, , , True)
            'control contains DateValue of particular status from database
            If m_strLoginType = "C" Then
                ' Modified By shraddhaM on 24 July 2006 for WhizibleSEM
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                CommonFunction.HTMLControls.DrawTextBox("txtReadOnlychangedDate", "txtReadOnlychangedDate", , 80, , CommonFunctions.HTMLControls.ConvertDateTo_InputDateFormat(strdt), , , , True, , True, , , False, , , EnableHTMLEncode:=True).ToString()

                'ended by Yogesh J for HTML encoding Date:05/10/15
                CommonFunction.HTMLControls.DrawDateControl("txtchangedDate", "txtchangedDate", , , strdt, , "frmDiscussion", , , , , , , , True, , , True)
            Else
                'Mrugaja
                'Modified by Mrugaja on Date 11 July,2006 for WhizibleSEM Issue ID.4168

                'CommonFunction.HTMLControls.DrawDateControl("txtchangedDate", "txtchangedDate", , , strdt, , "frmRequestDetails", , , , , , , , True, , , )
                ' Response.Write("<td align=right>" & m_strStatusChangeDate & "</TD>")
                CommonFunction.HTMLControls.DrawDateControl("txtchangedDate", "txtchangedDate", , , strdt, , "frmDiscussion", , , , , , , , True, , , )
            End If
            ' CommonFunction.HTMLControls.DrawDateControl("txtchangedDate", "txtchangedDate", , , strdt, , "frmDiscussion", , , , , , , ,  True, , , )

            ' Response.Write("</TD>")
            'Response.Write("      " & m_strStatusChangeTime)
            'Response.Write("<TD>")

            'hidden time control contains TimeValue of particular status from database
            'shraddha
            'Modified By ShraddhaM on 27 July 2006
            CommonFunction.HTMLControls.DrawTextArea("txtchangedTimehidden1", "txtchangedTimehidden1", , , , "frmDiscussion", , , , , , strtm, , , , , , True, , , , , , , , True, "Soft", )
            'CommonFunction.HTMLControls.DrawTextArea("txtchangedTimeHidden1", "txtchangedTimeHidden1", , , , "frmDiscussion", , , , , , strtm, , , , , , True, , , , , , , , True, , )
            'CommonFunction.HTMLControls.DrawTextBox("txtchangedTimeHidden1", "txtchangedTimeHidden1", , , , strtm, , , , , , True, , , False, , , )
            'control contains TimeValue of particular status from database   

            If m_strLoginType = "C" Then
                ' Modified By shraddhaM on 24 July 2006 for WhizibleSEM
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                CommonFunction.HTMLControls.DrawTextBox("txtchangedTime", "txtchangedTime", , 50, , strtm, , , , True, , True, , , False, , , EnableHTMLEncode:=True).ToString()
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            Else
                Response.Write("      " & m_strStatusChangeTime)
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                CommonFunction.HTMLControls.DrawTextBox("txtchangedTime", "txtchangedTime", , 50, , strtm, , , , , , , , , True, , , EnableHTMLEncode:=True).ToString()
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            End If
            ' CommonFunction.HTMLControls.DrawTextBox("txtchangedTime", "txtchangedTime", , 50, , strtm, , , , , , , , , True, , , ).ToString()

            Response.Write("</TD>")
            Response.Write("</TR>")

            'Added by PrashantD on 14 April 2006
            Dim strHour As String
            Dim strMinute As String

            Dim h As Integer
            Dim m As Integer
            h = Now().Hour
            m = Now().Minute
            'integrated by harshada d 
            'Modified By AmitJ For PSPL IssueId = 22880
            'h = Now().Hour
            'm = Now().Minute

            h = CType(Left(strDate1, 2), Integer)
            m = CType(Right(strDate1, 2), Integer)
            'End of Modification 
            'end of integration by harshada d 
            If h < 10 Then
                strHour = "0" + h.ToString
            Else
                strHour = h.ToString

            End If
            If m < 10 Then
                strMinute = "0" + m.ToString
            Else
                strMinute = m.ToString
            End If
            'End Of addition by PrashantD
            'CommonFunction.HTMLControls.DrawDateControl("CurrentDate", "CurrentDate", , , CommonFunction.Dates.GetDate(Now()), , "frmDiscussion", , , , , , , , False, , , True)

            Dim strGetServerTimeSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
            Dim strGetServerTime1 As String = CommonFunction.Data.GetDataScalar(strGetServerTimeSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
            Dim strGetServerDateSQL1 As String = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
            Dim strGetServerDate1 As String = CommonFunction.Data.GetDataScalar(strGetServerDateSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString


            'Dim strSDate As Date = CommonFunction.Data.GetDataScalar("Select ISNULL(REPLACE(convert(VARCHAR(30), GetDate(), 106),' ','-'),'')", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

            'CommonFunction.HTMLControls.DrawDateControl("CurrentDate", "CurrentDate", , , CommonFunction.Dates.GetDate(Now()), , "frmDiscussion", , , , , , , , False, , , True)
            CommonFunction.HTMLControls.DrawDateControl("CurrentDate", "CurrentDate", , , strGetServerDate1, , "frmDiscussion", , , , , , , , False, , , True) 'CommonFunctions.Dates.CGetDate(CType(strSDate, Date))

            'CommonFunction.HTMLControls.DrawTextBox("CurrentDate", "CurrentDate", , , , CType(CommonFunctions.Data.GetDataScalar(strSDate, True), String), IsHidden:=True)

            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strHour + ":" + strMinute, IsHidden:=True, EnableHTMLEncode:=True)

            'ended by Yogesh J for HTML encoding Date:05/10/15
            Dim strExpectedResolvedDate As String
            Dim ExpDate As String


            'Code Added By PradipK on 19 May 2006 
            'Purpose :Page crashes if  ExpectedResolvedDate is NULL
            'strExpectedResolvedDate = "select REPLACE((convert(varchar(50),cast(ExpectedResolvedDate as smallDatetime),106)),' ','-') FROM tbl_CRM_Query_Master where QueryID='" & m_lngQueryID & "'"

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strExpectedResolvedDate = "select ISNULL(REPLACE((convert(varchar(50),cast(ExpectedResolvedDate as smallDatetime),106)),' ','-'),'') FROM tbl_CRM_Query_Master where QueryID='" & m_lngQueryID & "'"
            strExpectedResolvedDate = "usp_sel_tbl_CRM_Query_Master_ExpectedResolvedDate '" & m_lngQueryID & "'"
            ''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            'End Addition By PradipK on 19 May 2006 

            ExpDate = CType(CommonFunctions.Data.GetDataScalar(strExpectedResolvedDate, True), String).ToString

            CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , ExpDate, , "frmDiscussion", , , , , True, , , True, , , True)
        End If
        'End Addition By PradipK for Help Desk SLA 
        'End Integration

        'Added by Amit Mahadik on 19 August 2011 whizibleSEM 10.0 (FAQ)
        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtIdList", "txtIdList", "clsTextBox", , 500, , , , , , , True, , True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:05/10/15
        'End Added by Amit Mahadik on 19 August 2011 whizibleSEM 10.0 (FAQ)

        Response.Write("</table>")

        'CommonFunctions.HTMLControls.DrawComboBox("cboFeedback", "usp_CRM_Get_Feedback_ForCombo", 100, , , , , , True, , True)
        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        CommonFunctions.HTMLControls.DrawTextBox("cboFeedback", "cboFeedback", , , , "", IsHidden:=True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:05/10/15
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'CommonFunctions.HTMLControls.DrawTextArea("txtFeedbackComments", "txtFeedbackComments", "Feedback Comments", , , "frmRequestDetails", , , 100, 10, , , , , True, True, , True, , , , , , , , True, "Soft", )
        CommonFunctions.HTMLControls.DrawTextArea("txtFeedbackComments", "txtFeedbackComments", "Feedback Comments", , , "frmRequestDetails", , , 100, 10, , , , , True, True, , True, , , , , , , , True, "Soft", , EnableHTMLEncode:=True)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode


        Response.Write("<BR>")
        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:05/10/15
        ' grid
        strSQL = "usp_CRM_Discussions " & m_lngQueryID
        m_objGrid = New WebPages.Template.GenericGrid
        With m_objGrid
            '.DIVHeight = 330
            .DIVID = "divDiscussion"
            'Commented And Added By Vaijat K ON 09/02/2016
            '.DIVStyle = "overflow:auto; width:100%;Z-INDEX: 90; Height:275px"
            .DIVStyle = "overflow:auto; width:100%;Z-INDEX: 90;Height:260px"
            'Ended
            'Modified by Amit Mahadik on 15 Mar 2011 Purpose:Whizible SEM 10.0
            .NoOfDataColumns = 3
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .UserFriendlyColumnArray = arrUserFriendlyCols
            .ActualColumnArray = arrActualCols
            .CheckBoxIDArray = arrCheckBox
            .PrimaryKey = "CRMQueryDetailid"
            'END Modified by Amit Mahadik on 15 Mar 2011 Purpose:Whizible SEM 10.0
            .returnHTML = False
            .SQL = strSQL
            .UseSQL = m_blnUseSQL
            .DrawGrid()

        End With
        m_objGrid = Nothing

        Response.Write("</div>")

        Response.Write(strMenu)

        CommonFunction.cDiv.ShowHelpDeskFeedbackDiv()


        ' update the flag (now user has viewed discussions!!)
        CommonFunctions.Data.InsertOrUpdateData("usp_update_tbl_CRM_Discussion_Accessed " & m_lngQueryID & "," & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(m_strLoginType & "") & "'", m_blnUseSQL)
    End Sub




    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        ''===================================DISCUSSION THREAD / Comments ===================
        If Args.DataField.Trim.ToUpper = "DISCUSSIONTHREAD" Then

            'Commented by SiddharthS on 17 Feb 2005 for IssueID 15475

            'Args.StringToBeInserted = "<TD><PRE>" & Args.DataReader("DiscussionThread").ToString & "</PRE></TD>"
            'Cancel = True

            'End comments.

            'Code modified by SiddharthS on 8 Mar 2005 for IssueID 15475
            'Purpose:To display the text properly for disussion thread.
            Dim strComments As String
            strComments = Args.DataReader("DiscussionThread").ToString
            strComments = HtmlEncode(strComments)
            ''Commented and added by Yogesh J on 22-Jan-2016
            Args.StringToBeInserted = "<TD><PRE>" & strComments & "</PRE></TD>"
            'Args.StringToBeInserted = "<TD><P>" & strComments & "</P></TD>"
            ''End of addition by Yogesh J on 22-Jan-2016
            Cancel = True
        End If
        'End modification.
        ''===================================DATE============================================
        If Args.DataField.Trim.ToUpper = "SUBMITTEDDATE" Then
            Args.ShowTimeWithDate = True
        End If

        ''===================================User Name=======================================
        'ADDED AND DELETED by Amit Mahadik on 16 Mar 2011 Purpose:Whizible SEM 10.0 
        '''''If Args.DataField.Trim.ToUpper = "SUBMITTEDBY" Then
        '''''    m_strSubmittedBy = Args.DataReader("SUBMITTEDBY").ToString
        '''''End If
        '''''''===================================Select==========================================
        '''''If Args.ColumnName = "Select" Then
        '''''    '''Dim strIsValidDeleteQuery = "usp_validate_del_tbl_CRM_Query_Details " & m_lngEmployeeID & "," & m_strSubmittedBy

        '''''    '''Dim isValidDelete As Boolean = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strIsValidDeleteQuery, MyBase.UseSQL), "0"), "0"), Boolean)
        '''''    Dim isValidDelete As Boolean
        '''''    if CType(CommonFunction.General.CheckIsNothing(
        '''''        If isValidDelete Then
        '''''            Args.StringToBeInserted = "<TD>&nbsp;</TD>"
        '''''            Cancel = True
        '''''        End If

        '''''    End If
        'ADDED AND DELETED by Amit Mahadik on 16 Mar 2011 Purpose:Whizible SEM 10.0
    End Sub
    'Added by Amit Mahadik on 17 Mar 2011 Purpose:Whizible SEM 10.0
    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint

        Dim ShowToCustFlag As Boolean
        Dim strTR As String
        Dim isValidDelete As Boolean

        ShowToCustFlag = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("ISSHOWTOCUSTOMER"), "0"), Boolean)

        m_strSubmittedBy = Args.DataReader("SUBMITTEDBY").ToString
        ''user can delete comments if allow delete is enabled at department level.......
        If m_blnIsAllowDeleteAtDeptLevel = True Then
            ''user can delete only todays comments....
            If CType(Args.DataReader.Item("SUBMITTEDDATE"), Date).ToShortDateString() = CType(DateTime.Today, Date).ToShortDateString() Then
                ''user can delete only self posted comments
                If m_strUserName = m_strSubmittedBy Then
                    isValidDelete = True
                Else
                    isValidDelete = False
                End If
            Else
                isValidDelete = False
            End If
        Else
            isValidDelete = False
        End If

        If m_strRowCount = True Then
            m_strRowCount = False
        Else
            m_strRowCount = True
        End If

        If m_strRowCount = False Then
            strTR = "<TR class='clsTREven'> "
        Else
            strTR = "<TR class='clsTROdd'> "
        End If
        'Added by Amit Mahadik on 02 August 2011 Purpose:Whizible SEM 10.0,do not show in blue if query is not submitted by customer.

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''Dim strSQLTemp As String = "SELECT LoginType FROM tbl_CRM_Query_Master WHERE QueryID='" & m_lngQueryID.ToString() & "'"
        Dim strSQLTemp As String = "usp_sel_tbl_CRM_Query_Master_LoginType '" & m_lngQueryID.ToString() & "'"
        ''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        Dim strLoginTypeTemp As String = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLTemp, MyBase.UseSQL), ""), ""), String)
        ''If strLoginTypeTemp <> "C" Then

        ''End If
        'End Added by Amit Mahadik on 02 August 2011 Purpose:Whizible SEM 10.0,do not show in blue if query is not submitted by customer.
        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("LoginType"), "") <> "C" And ShowToCustFlag = True And strLoginTypeTemp = "C" Then
            ''IF LoginType IS NOT C THEN SHOW IN BLUE COLOR
            strTR += "<TD vAlign=top title='User Name'><font color='BLUE'> " & CType(Args.DataReader.Item("SUBMITTEDBY"), String) & " </font></td>"
            strTR += "<TD vAlign=top title='Date'><font color='BLUE'> " & CType(Args.DataReader.Item("SUBMITTEDDATE"), Date) & " </font></td>"
            '''Commented and Added by Dhanashri S on 12 Jan 2015
            ''strTR += "<TD vAlign=top title='Comments'><font color='BLUE'><PRE>" & CType(Args.DataReader.Item("DISCUSSIONTHREAD"), String) & "<PRE></font></TD>"
            ''Commented and added by Yogesh J on 22-Jan-2016
            strTR += "<TD vAlign=top title='Comments'><PRE><font color='BLUE'>" & CType(Args.DataReader.Item("DISCUSSIONTHREAD"), String) & "</font></PRE></TD>"
            'strTR += "<TD vAlign=top title='Comments'><P><font color='BLUE'>" & CType(Args.DataReader.Item("DISCUSSIONTHREAD"), String) & "</font></P></TD>"
            ''End of addition by Yogesh J on 22-Jan-2016
            '''End of Comment and Addition by Dhanashri S on 12 Jan 2015
        Else
            ''IF LoginType IS C THEN SHOW IN NORMAL COLOR
            strTR += "<TD vAlign=top title='User Name'> " & CType(Args.DataReader.Item("SUBMITTEDBY"), String) & " </td>"
            strTR += "<TD vAlign=top title='Date'> " & CType(Args.DataReader.Item("SUBMITTEDDATE"), Date) & " </td>"
            strTR += "<TD vAlign=top title='Comments'><PRE>" & CType(Args.DataReader.Item("DISCUSSIONTHREAD"), String) & "</PRE></TD>"
            ''added by shamkant S on 19 Dec 2015
            'strTR += "<TD vAlign=top title='Comments'>" & CType(Args.DataReader.Item("DISCUSSIONTHREAD"), String) & "</TD>"
            ''Ended by Shamkant S on 19 Dec 2015
        End If

        If isValidDelete Then
            strTR += "<TD  align=center>" & "<Input type=checkbox name='chkDiscussionThread' id='chkDiscussionThread' class='clsCheckBox' value='" & CType(Args.DataReader.Item("CRMQueryDetailid"), String) & "' >" & "</TD>"
        Else
            strTR += "<TD>&nbsp;</TD>"
        End If

        'Added by Amit Mahadik on 19 August 2011 whizibleSEM 10.0 (FAQ)
        'Modified by Amit Mahadik on 22 August 2011 whizibleSEM 10.0 (FAQ)

        If (m_strFromWhere = "AR" Or m_strFromWhere = "DB") Then
            strTR += "<TD  align=center>" & "<Input type=checkbox name='chkConvertToFAQ' id='chkConvertToFAQ' class='clsCheckBox' value='" & CType(Args.DataReader.Item("CRMQueryDetailid"), String) & "' >" & "</TD>"
        Else
            strTR += "<TD>&nbsp;</TD>"
        End If
        'End Modified by Amit Mahadik on 22 August 2011 whizibleSEM 10.0 (FAQ)
        'End Added by Amit Mahadik on 19 August 2011 whizibleSEM 10.0 (FAQ)



        strTR += "</TR>"
        If Not (CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("LoginType"), "") = "C" And ShowToCustFlag = False) Then
            Args.StringToBeInserted = strTR
        End If


        Cancel = True

        m_blnIsRecordInGrid = True
    End Sub
    Private Sub m_objGrid_NoDataCommentTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_NoDataCommentTR) Handles m_objGrid.NoDataCommentTR_BeforePrint
        If m_blnIsRecordInGrid = True Then
            Cancel = True
        End If
    End Sub
    'END Added by Amit Mahadik on 17 Mar 2011 Purpose:Whizible SEM 10.0

    Private Sub m_strMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_strMenu.Before_Link_Print
        If Args.LinkName.ToUpper = "SAVE" Then
            Cancel = True
            Args.StringToBeInserted = "<label id='lblSave'>| <A class='Menu' style='' onmouseover=""this.style.backgroundColor='#FFD695'"" onmouseout=""this.style.backgroundColor=''""  onclick='Javascript:Save_OnClick(" + m_lngQueryID.ToString + ")' Title=""Save"" >Save</A></label>"
        End If
    End Sub
End Class
