Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Net.Mail
Imports System.Configuration
'Imports PMLifeLineMobile.PMLifeLineWCFService
Public Class MyApproval
    Inherits WebPages.Template.WhizTemplate

    'Private cls As LoginClient = New LoginClient
    Protected m_strExpenseSheetID As String
    Private EmployeePhoneNo As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles MyBase.Load
        '' Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
          MyBase.ApplySecurity(True)
        ''End Of Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        Try
            'If (Convert.ToInt32(Session("EmpLevel")) = 3) Then
            '    Response.Redirect("DashBord.aspx")
            'End If
            ''Commented By Nikhil A on 29-Nov-2016 for session expire issue on tiesheet page
            ''Added by swapnil A for session timeout expire on 18-1-2016
            'If Context.Session IsNot Nothing Then
            '    If Session.IsNewSession Then

            '        Response.Redirect("../../default.aspx?Message=SESSIONEXPIRED")

            '    End If
            'End If
            '' ''End of Commented and addeed by Nikihil A on 29-Nov-2016 for session expire issue on tiesheet page
            Dim Value2 As ArrayList = CommonEngines.HashTables.GetHashTableObject.GetUserSessionCacheItemValue(Session("intLoginID"))
            If Value2 IsNot Nothing Then
                For i As Integer = 0 To Value2.Count - 1
                    ''Commented and addeed by Nikihil A on 29-Nov-2016 for session expire issue on tiesheet page
                    'If Value2.Item(i) <> Session.SessionID Then
                    If Value2.Item(i) <> Session("SessionID") Then
                        ''End of Commented and addeed by Nikihil A on 29-Nov-2016 for session expire issue on tiesheet page
                        CommonEngines.HashTables.GetHashTableObject.RemoveUserSessionCacheItem(Session("intLoginID"))
                        Session("intUserID") = Nothing
                        Session.Abandon()
                        Response.Redirect("../../Default.aspx?Message=SESSIONEXPIRED")
                    End If
                Next
            End If
            ''Ended

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            'Session("email") = CommonFunction.Data.GetDataScalar("SELECT EmailID FROM tbl_PM_Employee where EmployeeID=" & CommonFunction.General.CheckIsNothing(Session("intUserID"), 0), True)
            Session("email") = CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_Employee_EmployeeIDWiseEmailID " & CommonFunction.General.CheckIsNothing(Session("intUserID"), 0), True)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            If Request.QueryString("Mode") = "Send" Then
                'Dim EmployeeIds As String = Request.QueryString("ids")
                'Dim arrEmployeeId() As String = EmployeeIds.Split(Microsoft.VisualBasic.ChrW(44))
                'Dim filterarrEmployeeId() As String = arrEmployeeId.Distinct.ToArray
                'Dim LoginID As Integer = Int32.Parse(Session("intUserID").ToString)
                'Dim Mailmessage As MailMessage = New MailMessage
                'Dim client As SmtpClient = New SmtpClient
                'Try
                '    client.Host = ConfigurationManager.AppSettings("EmailHostName").ToString
                '    client.Credentials = New Net.NetworkCredential("swapnil.aswale@lifeline-sys.com", "lenovo@1234")
                '    client.Port = Convert.ToInt32(ConfigurationManager.AppSettings("Emailport"))
                '    Mailmessage.IsBodyHtml = True
                '    '  Mailmessage.From = New MailAddress(Request.QueryString("Msgfrom"))
                '    Mailmessage.From = New MailAddress("swapnil.aswale@lifeline-sys.com")
                '    Mailmessage.To.Add(New MailAddress(Request.QueryString("Msgto")))
                '    If Request.QueryString("MsgCC") IsNot Nothing Then
                '        If Request.QueryString("MsgCC") <> "" Then
                '            Mailmessage.CC.Add(New MailAddress(Request.QueryString("MsgCC")))
                '        End If
                '    End If
                '    Mailmessage.Subject = Request.QueryString("MsgSubject")
                '    Mailmessage.Body = Request.QueryString("EmailMsg")
                '    client.Send(Mailmessage)
                '    Page.RegisterStartupScript("myscript", "<script>alert('Send Mail Successful')</script>")
                'Catch ex As Exception
                '    Page.RegisterStartupScript("myscript", ("<script>alert('" _
                '                    + (ex.Message + "')</script>")))
                'End Try
                'Dim strToEmailID As String = CommonFunction.General.CheckIsNothing(Request.QueryString("Msgto"), "")
                'Dim strCCEmailID As String = CommonFunction.General.CheckIsNothing(Request.QueryString("MsgCC"), "")
                'Dim strFromEmailID As String = CommonFunction.General.CheckIsNothing(Request.QueryString("Msgfrom"), "")
                'Dim strSubject As String = CommonFunction.General.CheckIsNothing(Request.QueryString("MsgSubject"), "")
                'Dim strMessage As String = CommonFunction.General.CheckIsNothing(Request.QueryString("EmailMsg"), "")
                'CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCEmailID, strFromEmailID, strSubject, strMessage)

                ''Added By Chakshuta H on 1st-June-2016 Purpose::Hitachi Next Gen Integration
                'Dim strMsg As String() = Request.QueryString("EmailMsg").ToString.Split("*")
                'Dim strEmpID As String() = Request.QueryString("Msgto").ToString.Split(",")
                'For iEmp As Integer = 0 To strEmpID.Length - 1
                '    Dim strToEmailID As String = CommonFunction.General.CheckIsNothing(strEmpID(iEmp), "")
                '    Dim strCCEmailID As String = CommonFunction.General.CheckIsNothing(Request.QueryString("MsgCC"), "")
                '    Dim strFromEmailID As String = CommonFunction.General.CheckIsNothing(Session("email"), "")
                '    Dim strSubject As String = CommonFunction.General.CheckIsNothing(Request.QueryString("MsgSubject"), "")
                '    Dim strMessage As String = CommonFunction.General.CheckIsNothing(strMsg(iEmp), "")
                '    If (strToEmailID <> "" And strToEmailID <> ";") Then
                '        CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCEmailID, strFromEmailID, strSubject, strMessage)
                '    End If
                'Next
                ' Dim strMsg As String() = Request.QueryString("EmailMsg").ToString.Split("*")

                ' Dim strEmpID As String() = Request.QueryString("Msgto").ToString.Split(",")
                Dim strLeaveID As String() = Request.QueryString("LeaveID").ToString.Split(",")
                For iEmp As Integer = 0 To strLeaveID.Length - 1

                    'Dim strToEmailID As String = CommonFunction.General.CheckIsNothing(strEmpID(iEmp), "")
                    'Dim strCCEmailID As String = CommonFunction.General.CheckIsNothing(Request.QueryString("MsgCC"), "")
                    'Dim strFromEmailID As String = CommonFunction.General.CheckIsNothing(Session("email"), "")
                    'Dim strSubject As String = CommonFunction.General.CheckIsNothing(Request.QueryString("MsgSubject"), "")
                    'Dim strMessage As String = CommonFunction.General.CheckIsNothing(strMsg(iEmp), "")
                    'If (strToEmailID <> "" And strToEmailID <> ";") Then
                    '    CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCEmailID, strFromEmailID, strSubject, strMessage)
                    'End If
                    Dim strToEmailID As String '= CommonFunction.General.CheckIsNothing(strEmpID(iEmp), "")
                    Dim strCCEmailID As String '= CommonFunction.General.CheckIsNothing(Request.QueryString("MsgCC"), "")
                    Dim strFromEmailID As String '= CommonFunction.General.CheckIsNothing(Session("email"), "")
                    Dim strSubject As String '= CommonFunction.General.CheckIsNothing(Request.QueryString("MsgSubject"), "")
                    Dim strMessage As String '= CommonFunction.General.CheckIsNothing(strMsg(iEmp), "")
                    If Request.QueryString("ApproveorReject") = "A" Then
                        CommonFunction.EmailMessages.PMMessages.GetEmailMessage_69(strFromEmailID, strToEmailID, strCCEmailID, strSubject, strMessage, strLeaveID(iEmp))
                    Else
                        CommonFunction.EmailMessages.PMMessages.GetEmailMessage_70(strFromEmailID, strToEmailID, strCCEmailID, strSubject, strMessage, strLeaveID(iEmp))
                    End If
                    If (strToEmailID <> "" And strToEmailID <> ";") Then
                        CommonFunction.Emails.AppSendEmailWithCC(strToEmailID.Trim(), strCCEmailID, strFromEmailID.Trim(), strSubject, strMessage)
                    End If
                Next
                ''End Of Added By Chakshuta H on 1st-June-2016 Purpose::Hitachi Next Gen Integration
            End If


            'If Request.QueryString("Mode") = "Timesheet" Then
            '    If Request.QueryString("TimesheetID") IsNot Nothing Then
            '        DBProcess(Request.QueryString("TimesheetID"))
            '    End If
            'End If
            'If Request.QueryString("Mode") = "ProjTimesheet" Then
            '    If Request.QueryString("TimesheetID") IsNot Nothing Then
            '        AuthenticateORReject_Timesheet(Request.QueryString("TimesheetID"))
            '    End If
            'End If
            'If Request.QueryString("Mode") = "Expense" Then
            '    If Request.QueryString("ExpensesEntryID") IsNot Nothing Then
            '        ExpenseApproval(Request.QueryString("ExpensesEntryID"))
            '    End If
            'End If
            'If Request.QueryString("Mode") = "Entity" Then
            '    If Request.QueryString("EntityID") IsNot Nothing Then
            '        EntityApproval(Request.QueryString("EntityID"), Request.QueryString("MasterTagID"))
            '    End If
            'End If


            If Request.QueryString("Mode") = "Timesheet" Then
                If Request.QueryString("TimesheetID") IsNot Nothing Then
                    Dim strEmpID As String() = Request.QueryString("TimesheetID").ToString.Split(",")
                    For iEmp As Integer = 0 To strEmpID.Length - 1
                        DBProcess(strEmpID(iEmp))
                    Next

                End If
            End If

            If Request.QueryString("Mode") = "Expense" Then
                If Request.QueryString("ExpensesEntryID") IsNot Nothing Then
                    Dim strEmpID As String() = Request.QueryString("ExpensesEntryID").ToString.Split(",")
                    Dim strisExpense As String() = Request.QueryString("isExpense").ToString.Split(",")
                    For iEmp As Integer = 0 To strEmpID.Length - 1
                        ExpenseApproval(strEmpID(iEmp), strisExpense(iEmp))
                    Next
                End If
            End If
            'If Request.QueryString("Mode") = "Finance" Then
            '    If Request.QueryString("ExpensesEntryID") IsNot Nothing Then
            '        Dim strEmpID As String() = Request.QueryString("ExpensesEntryID").ToString.Split(",")
            '        For iEmp As Integer = 0 To strEmpID.Length - 1
            '            financeApproval(strEmpID(iEmp))
            '        Next
            '    End If
            'End If
            ''dhn 19
            ''dhn 20
            If Request.QueryString("Mode") = "Entity" Then
                If Request.QueryString("EntityID") IsNot Nothing Then
                    Dim strEmpID As String() = Request.QueryString("EntityID").ToString.Split(",")
                    For iEmp As Integer = 0 To strEmpID.Length - 1
                        EntityApproval(strEmpID(iEmp), Request.QueryString("MasterTagID"))
                    Next
                End If
            End If
            If Request.QueryString("Mode") = "ProjTimesheet" Then
                If Request.QueryString("TimesheetID") IsNot Nothing Then
                    Dim strEmpID As String() = Request.QueryString("TimesheetID").ToString.Split(",")
                    For iEmp As Integer = 0 To strEmpID.Length - 1
                        AuthenticateORReject_Timesheet(strEmpID(iEmp))
                    Next

                End If
            End If
            If Request.QueryString("Mode") = "HelpDesk" Then
                If Request.QueryString("QueryID") IsNot Nothing Then
                    Dim strEmpID As String() = Request.QueryString("QueryID").ToString.Split(",")
                    For iEmp As Integer = 0 To strEmpID.Length - 1
                        PerformAction(strEmpID(iEmp), Request.QueryString("ApproveorReject"), Request.QueryString("Remarks"))
                    Next
                End If
            End If
            'Page_Load(sender, e)
        Catch ex As Exception
        End Try
    End Sub

    'protected void btnsend_Click(object sender, EventArgs e)
    '{
    '    cls.Open();
    '    string EmployeeIds = ids.Value;
    '    string[] arrEmployeeId = EmployeeIds.Split(',');
    '    string[] filterarrEmployeeId = arrEmployeeId.Distinct().ToArray();
    '    int LoginID = Int32.Parse(Session["EmployeeID"].ToString());
    '    for (int i = 0; i < filterarrEmployeeId.Count(); i++)
    '    {
    '        if (filterarrEmployeeId[i].ToString() == "")
    '        {
    '        }
    '        else
    '        {
    '            int EmployeeId = Int32.Parse(filterarrEmployeeId[i].ToString());
    '            var datalst = cls.GetEmployeePhoneNoForWhatsApp(EmployeeId).AsEnumerable();
    '            var enumrat = datalst.GetEnumerator();
    '            while (enumrat.MoveNext())
    '            {
    '                //ApproverPhoneNo= "91"+enumrat.Current.phone.ToString();              
    '                //EmployeePhoneNo = "919822440555";
    '                EmployeePhoneNo = "91" + enumrat.Current.phone.ToString();
    '                try
    '                {
    '                    var user = WhatsAppPort.User.UserExists(EmployeePhoneNo, "Saji");
    '                    WhatSocket.Instance.SendMessage(user.WhatsUser.GetFullJid(), "Your Leave is Approved");
    '                    //List<string> listOfStrings = new List<string>();
    '                    //listOfStrings.Add("919822440555");
    '                    //listOfStrings.Add("919404441896");
    '                    ////listOfStrings.Add("three");
    '                    ////listOfStrings.Add("four");
    '                    //WhatSocket.Instance.SendCreateGroupChat("TEST");
    '                    //WhatSocket.Instance.SendAddParticipants("918600644914@s.whatsapp.net", listOfStrings);
    '                }
    '                catch (Exception)
    '                {
    '                    throw;
    '                }
    '                finally { Page.Response.Redirect(Page.Request.Url.ToString(), true); }
    '            }
    '        }
    '    }
    '}
    Private Sub PerformAction(ByVal strQueryID As String, strStatus As String, strComment As String)
        Try
            If Session("intUserID") IsNot Nothing Then

                Dim blnSendMail As Boolean
                Dim blnShowPopup As Boolean
                Dim dr As IDataReader
                Dim strFromEmailID As String
                Dim strToMailID As String
                Dim strCCToMailID As String
                Dim strSubject, strMessage As String
                Dim MessageID As String
                Dim strQuery As String
                'strStatus = Request.QueryString("Status").ToString()
                'strQueryID = Request.QueryString("QueryID").ToString()
                'Comment and modification by SuchitraP on 30-Dec-2008 for IssueID 26321
                'strComment = Request.Form("txtSubmitComments")
                strComment = CommonFunction.General.BuildQueryString(Request.Form("txtSubmitComments"))
                'End of comment and modification by SuchitraP on 30-Dec-2008 for IssueID 26321

                strQuery = "usp_UPD_Request_ApprovalStatus " & strQueryID & ",'" & strStatus & "','" & strComment & "'," & Session("intUserID")
                CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

                If strStatus = "A" Then
                    MessageID = "531"
                ElseIf strStatus = "R" Then
                    MessageID = "530"
                End If
                'Send Mail
                blnSendMail = False : blnShowPopup = False
                dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages " + MessageID, MyBase.UseSQL)
                If dr.Read Then
                    blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
                    blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
                End If
                CommonFunctions.Data.DisposeDataReader(dr)

                strComment = Server.UrlEncode(strComment)

                If blnSendMail Then
                    'If blnShowPopup Then
                    '    With Response
                    '        .Write("<script language=javascript>")
                    '        'Comment and addition of comments field by SuchitraP on 16-Dec-2008 for IssueID:25892
                    '        'Purpose:To display comments in Approval/Rejection mail
                    '        '.Write("window.open (""../General/SendEmail.aspx?MessageID=" + MessageID + "&ApprovalStatus=" + strStatus + "&QueryID=" & strQueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                    '        .Write("window.open (""../General/SendEmail.aspx?MessageID=" + MessageID + "&ApprovalStatus=" + strStatus + "&QueryID=" & strQueryID & "&EmployeeIDList=" & Session("intUserid").ToString & "&Comments=" & Left(strComment, 100) & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                    '        'End of comment and addition by SuchitraP on 16-Dec-2008 
                    '        .Write("</script>")
                    '    End With
                    'Else
                    ' silent mail
                    If strStatus = "R" Then
                        'Comment and addition of comments field by SuchitraP on 16-Dec-2008 for IssueID:25892
                        'Purpose:To display comments in Approval/Rejection mail
                        'CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_530(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, strQueryID)
                        CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_530(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, strQueryID, Left(strComment, 100))
                        'End of comment and addition by SuchitraP on 16-Dec-2008 
                        If strToMailID <> "" And strToMailID <> ";" Then
                            'CommonFunction.Emails.SendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                            CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                        End If
                    Else
                        'Comment and addition of comments field by SuchitraP on 16-Dec-2008 for IssueID:25892
                        'Purpose:To display comments in Approval/Rejection mail
                        'CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_531(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, strQueryID)
                        CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_531(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, strQueryID, Left(strComment, 100))
                        'End of comment and addition by SuchitraP on 16-Dec-2008 
                        If strToMailID <> "" And strToMailID <> ";" Then
                            'CommonFunction.Emails.SendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                            CommonFunction.Emails.AppSendEmailWithCC(strToMailID.Trim(), strCCToMailID, strFromEmailID.Trim(), strSubject, strMessage)
                        End If
                    End If
                    'End If
                End If
            End If
        Catch ex As Exception
        End Try
    End Sub
    Protected Sub sendemailbtn_Click(ByVal sender As Object, ByVal e As EventArgs)
        'Dim EmployeeIds As String = ids.Value
        'Dim arrEmployeeId() As String = EmployeeIds.Split(Microsoft.VisualBasic.ChrW(44))
        'Dim filterarrEmployeeId() As String = arrEmployeeId.Distinct.ToArray
        'Dim LoginID As Integer = Int32.Parse(Session("EmployeeID").ToString)
        'Dim Mailmessage As MailMessage = New MailMessage
        'Dim client As SmtpClient = New SmtpClient
        'Try
        '    client.Host = ConfigurationManager.AppSettings("EmailHostName").ToString
        '    client.Port = Convert.ToInt32(ConfigurationManager.AppSettings("Emailport"))
        '    Mailmessage.IsBodyHtml = True
        '    Mailmessage.From = New MailAddress(from.Value)
        '    Mailmessage.To.Add(New MailAddress(to.Value))
        '    ' message.CC.Add(new MailAddress());
        '    Mailmessage.Subject = mailsubject.Value
        '    Mailmessage.Body = message.Value
        '    client.Send(Mailmessage)
        '    Page.RegisterStartupScript("myscript", "<script>alert('Send Mail Successful')</script>")
        'Catch ex As Exception
        '    Page.RegisterStartupScript("myscript", ("<script>alert('" _
        '                    + (ex.Message + "')</script>")))
        'End Try

        ''cls.Open();
        ''for (int i = 0; i < filterarrEmployeeId.Count(); i++)
        ''{
        ''    if (filterarrEmployeeId[i].ToString() == "")
        ''    {
        ''    }
        ''    else
        ''    {
        ''        int EmployeeId = Int32.Parse(filterarrEmployeeId[i].ToString());
        ''        var datalst = cls.GetEmployeePhoneNoForWhatsApp(EmployeeId).AsEnumerable();
        ''        var enumrat = datalst.GetEnumerator();
        ''        while (enumrat.MoveNext())
        ''        {
        ''            //ApproverPhoneNo= "91"+enumrat.Current.phone.ToString();              
        ''            //EmployeePhoneNo = "919822440555";
        ''            if (!string.IsNullOrEmpty(enumrat.Current.phone))
        ''            {
        ''                EmployeePhoneNo = "91" + enumrat.Current.phone.ToString();
        ''                try
        ''                {
        ''                    var user = PMlifelineUser.User.UserExists(EmployeePhoneNo, "Saji");
        ''                    WhatSocket.Instance.SendMessage(user.WhatsUser.GetFullJid(), message.Value);
        ''                    //List<string> listOfStrings = new List<string>();
        ''                    //listOfStrings.Add("919822440555");
        ''                    //listOfStrings.Add("919404441896");
        ''                    ////listOfStrings.Add("three");
        ''                    ////listOfStrings.Add("four");
        ''                    //WhatSocket.Instance.SendCreateGroupChat("TEST");
        ''                    //WhatSocket.Instance.SendAddParticipants("918600644914@s.whatsapp.net", listOfStrings);
        ''                }
        ''                catch (Exception)
        ''                {
        ''                    throw;
        ''                }
        ''            }
        ''        }
        ''    }
        ''}
        'Page.Response.Redirect(Page.Request.Url.ToString, True)
    End Sub

    Private Sub DBProcess(ByVal intTimesheetID As Integer)
        Try
            '=====================================================================
            ' Procedure Name        : DBProcess()	
            ' Purpose               : To Approve timesheet
            ' Description           : same as above
            ' Parameters Passed     : None
            ' Returns               : 
            ' Parameters Affected   : 
            ' Assumptions           : 
            ' Dependencies          : 
            ' Author                : HarshK
            ' Created               : 02/08/2005
            ' Revisions             :
            '=====================================================================
            'If m_blnVerify = True Then
            If Session("intUserID") IsNot Nothing Then

                Dim intVerifiedBy As Integer
                Dim intCount As Integer
                Dim intCtr As Integer
                ' Dim intTimesheetID As Integer
                Dim intDailyActivityID As Integer

                Dim drVerify As IDataReader
                Dim drResourceTimesheetstatus As IDataReader
                Dim m_drTimesheet As IDataReader
                Dim m_drActivites As IDataReader

                Dim strVerifiedActivities As String
                Dim strSQLQuery As String
                Dim strRemarks As String
                Dim intVerified As Integer
                Dim dtVerificationDate As String

                Dim arrVerifiedActivities As String()
                Dim arrVerifiedActivitiesLength As Integer

                Dim strFromDate As String
                Dim strToDate As String
                Dim dblTotalExtraAMH As Double
                Dim dblTotalAMH As Double
                Dim m_strPrevTimesheetID As String
                'Variables for sending E-mail
                Dim drEmailMessage As IDataReader
                Dim drResource As IDataReader
                Dim blnSendEmail As Boolean
                Dim blnShowPopup As Boolean
                Dim strOnloadClientScript As String
                Dim strFromEmailID As String
                Dim strToEmailID As String
                Dim strCCToEmailID As String
                Dim strSubject As String
                Dim strEmailMessage As String
                Dim strMessage As String
                Dim strResourceID As String
                Dim strQuery As String
                Dim blnVerifiedAll As Boolean
                Dim blnRemarks As Boolean
                Dim strCCEmailID As String
                Dim intRowCount As Integer
                ' RajkumarM on 6th Oct 2008
                Dim intChkCount As Integer
                Dim drUnVerify As IDataReader
                Dim strRemarksIDs As String
                dtVerificationDate = CType(Now(), String)
                If Request.QueryString("ApproveorReject") = "A" Then
                    intVerifiedBy = CType(Session("intUserID"), Integer)

                    'strVerifiedActivities = CType(MyBase.GetFormValue("chkApprove"), String)
                    'If strVerifiedActivities <> "" Then
                    '    arrVerifiedActivities = Split(strVerifiedActivities, ",")
                    'End If

                    'If Not IsNothing(arrVerifiedActivities) Then
                    '    arrVerifiedActivitiesLength = arrVerifiedActivities.Length
                    'Else
                    '    arrVerifiedActivitiesLength = 0
                    'End If

                    'For intCount = 0 To arrVerifiedActivitiesLength - 1
                    '    intTimesheetID = CType(arrVerifiedActivities(intCount), Integer)

                    '' START : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
                    '' m_strToken = Request.QueryString("PKToken") & ""
                    'If (CommonFunctions.Security.Token.ValidateToken("0" + CType(m_intUserID, String) + CType(s_ParentTagID, String) + CType(m_TagTimesheetApproval, String), m_strTokenForApproveLink) = True) Then
                    '' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197

                    strSQLQuery = "usp_Sel_ResourceTimesheetDADetails " & intTimesheetID & "," & CType(Session("intUserID"), String)

                    m_drTimesheet = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    'Get Activity record details for the resource timesheet
                    Do While m_drTimesheet.Read()
                        ' RajkumarM 6th Oct 2008
                        If CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("IsDisabled"), "0"), Integer) = "0" Then
                            ' RajkumarM 6th Oct 2008
                            strFromDate = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("FromDate"), CType(Now(), String)), String)
                            strToDate = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("ToDate"), CType(Now(), String)), String)
                            intDailyActivityID = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("DailyActivityEntryID"), "0"), Integer)
                            intVerified = 1
                            strRemarks = Request.QueryString("Remarks")

                            '--- Execute sp to update verification details to Daily Activity Table
                            strSQLQuery = "Exec usp_Upd_PM_ResourceTimesheetVerification " + CType(intDailyActivityID, String) + "," + CType(intVerified, String)
                            strSQLQuery = strSQLQuery + "," + CType(intVerifiedBy, String) + ",'" + CType(dtVerificationDate, String) + "','" + strRemarks + "'"

                            'm_drActivites = 
                            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            ' RajkumarM 6th Oct 2008
                        End If
                        ' RajkumarM 6th Oct 2008
                    Loop
                    CommonFunction.Data.DisposeDataReader(m_drTimesheet)
                    'Change Status to Verified in tbl_PM_ResourceTimesheetStatus table
                    strSQLQuery = "Exec usp_Upd_tbl_PM_ResourceTimesheetStatus " & intTimesheetID & "," & CType(intVerifiedBy, String) & "," & "'V'"

                    drVerify = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    CommonFunctions.Data.DisposeDataReader(drVerify)


                    'If Resource TimeSheet are verified then change the status to 'verified' 
                    strSQLQuery = "Exec usp_Sel_ResourceTimesheet_GetVerifiedTasksStatus " & CType(intTimesheetID, String)

                    drVerify = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    If drVerify.Read = False Then
                        strSQLQuery = "Exec usp_Upd_ResouceTimesheetStatus " & CType(intTimesheetID, String) & ",'V'"
                        drResourceTimesheetstatus = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                        CommonFunctions.Data.DisposeDataReader(drResourceTimesheetstatus)
                    End If
                    CommonFunctions.Data.DisposeDataReader(drVerify)

                    ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                    ''strSQLQuery = "SELECT EmployeeID FROM tbl_PM_ResourceTimesheet WHERE TimesheetID = " & intTimesheetID
                    strSQLQuery = "usp_sel_tbl_PM_ResourceTimesheet_EmployeeID " & intTimesheetID
                    '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                    drResource = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    If drResource.Read Then
                        strResourceID = CType(drResource("EmployeeID"), String)
                    End If
                    CommonFunctions.Data.DisposeDataReader(drResource)

                    strSQLQuery = "usp_Sel_tbl_PM_EmailMessages 435"
                    drEmailMessage = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    If drEmailMessage.Read Then
                        blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                        blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                    End If
                    CommonFunctions.Data.DisposeDataReader(drEmailMessage)

                    'Check if the mail has to be sent.
                    If blnSendEmail = True Then
                        ' Check if a popup message has to be shown.
                        'If blnShowPopup = True Then
                        '    CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
                        '    CommonFunctions.General.WriteHTML("window.open('../../Source/General/SendEmail.aspx?MessageID=435&VerifiedBy=" + CType(intVerifiedBy, String) + "&ResourceID=" + CType(strResourceID, String) + "&FromDate=" + strFromDate + "&ToDate=" + strToDate + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')" + vbCrLf)
                        '    CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
                        '    ' Else, if the mail has to be sent silently, then...
                        'Else

                        'TO DO: SEND EMAIL MESSAGE WITH CC
                        'CommonFunction.EmailMessages.PMMessages. CRMMessages.GetEmailMessage_45(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, intVerifiedBy, m_strEmployeeID)
                        'CommonFunction.EmailMessages.ResourceTimesheetMessages.GetEmailMessage_435(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strMessage, intVerifiedBy, CType(Request.QueryString("EmployeeID"), Integer), CType(strFromDate, Date), CType(strToDate, Date))
                        'Call CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage)
                        CommonFunction.EmailMessages.ResourceTimesheetMessages.GetEmailMessage_435(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strMessage, intVerifiedBy, CType(strResourceID, Integer), CType(strFromDate, Date), CType(strToDate, Date))
                        Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID.Trim(), strCCToEmailID, strFromEmailID.Trim(), strSubject, strMessage)

                    End If
                    'End If

                    '' START : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
                    'Else
                    'Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Timesheet Approval", m_TagTimesheetApproval, 0, "Timesheet ID", CType(intTimesheetID, String))
                    ''Token is Invalid now redirect to the Invalid Access Page
                    'System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                    'End If
                    '' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
                    'Next
                Else
                    'If (CType(m_strTimesheetID, String) <> "0") And (CommonFunctions.Security.Token.ValidateToken(CType(m_strTimesheetID, String) + CType(m_strEmployeeID, String) + CType(s_ParentTagID, String) + CType(m_TagVerifyTimesheetList, String), m_strToken_ApproveReject) = True) Then
                    '' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197

                    'Get list of all verified activities		
                    'strDailyActivityIDS = ""
                    'If arrVerifiedActivitiesLength <> 0 Then
                    '    For intCtr = 1 To arrVerifiedActivitiesLength
                    '        intEntryID = CType(arrVerifiedActivities(intCtr - 1), Integer)

                    '        strDailyActivityIDS = strDailyActivityIDS + CType(intEntryID, String) + ","

                    '        'CommonFunctions.General.WriteHTML(strDailyActivityIDS)
                    '    Next
                    'End If

                    'If strDailyActivityIDS = "" Then
                    '    strDailyActivityIDS = "0"
                    'End If

                    'Update Remarks

                    ''Added By Chakshuta H on 1st-June-2016 Purpose::Hitachi Next Gen Integration
                    strSQLQuery = "usp_Sel_ResourceTimesheetDADetails " & intTimesheetID & "," & CType(Session("intUserID"), String)

                    m_drTimesheet = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    'Get Activity record details for the resource timesheet
                    Do While m_drTimesheet.Read()
                        ' RajkumarM 6th Oct 2008
                        If CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("IsDisabled"), "0"), Integer) = "0" Then
                            ' RajkumarM 6th Oct 2008
                            strFromDate = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("FromDate"), CType(Now(), String)), String)
                            strToDate = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("ToDate"), CType(Now(), String)), String)
                            intDailyActivityID = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("DailyActivityEntryID"), "0"), Integer)
                            intVerified = 0
                            strRemarks = Request.QueryString("Remarks")

                            '--- Execute sp to update verification details to Daily Activity Table
                            strSQLQuery = "Exec usp_Upd_PM_ResourceTimesheetVerification " + CType(intDailyActivityID, String) + "," + CType(intVerified, String)
                            strSQLQuery = strSQLQuery + "," + CType(intVerifiedBy, String) + ",'" + CType(dtVerificationDate, String) + "','" + strRemarks + "'"

                            'm_drActivites = 
                            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            ' RajkumarM 6th Oct 2008
                        End If
                        ' RajkumarM 6th Oct 2008
                    Loop
                    ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                    ''strSQLQuery = "SELECT EmployeeID FROM tbl_PM_ResourceTimesheet WHERE TimesheetID = " & intTimesheetID
                    strSQLQuery = "usp_sel_tbl_PM_ResourceTimesheet_EmployeeID " & intTimesheetID
                    '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
                    ''' 
                    drResource = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    If drResource.Read Then
                        strResourceID = CType(drResource("EmployeeID"), String)
                    End If
                    CommonFunctions.Data.DisposeDataReader(drResource)
                    ''End Of Added By Chakshuta H on 1st-June-2016 Purpose::Hitachi Next Gen Integration

                    dtVerificationDate = CType(Now(), String)

                    'For intCtr = 1 To intRowCount
                    'intEntryID = CType(Request.Form("txtEntryID" + CType(intCtr, String)), Integer)
                    strRemarks = CType(Server.HtmlEncode(Request.QueryString("Remarks")), String)
                    'Modified Code By VidyaJ - IssueID - 86 - SP4
                    'Commented OR Condition
                    If strRemarks <> "" Then  'Or InStr(intEntryID & ",", strDailyActivityIDS) <= 0 Then
                        intVerified = 0
                        strQuery = "Exec usp_Upd_PM_ResourceTimesheetVerification " + CType(intTimesheetID, String) + "," + CType(intVerified, String)
                        strQuery = strQuery + "," + CType(Session("intUserID"), String) + ",'" + CType(dtVerificationDate, String) + "','" + Trim(Replace(strRemarks, "'", "''")) & "'"
                        drUnVerify = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                        CommonFunctions.Data.DisposeDataReader(drUnVerify)
                        strRemarksIDs = strRemarksIDs + CType(intTimesheetID, String) + ","
                    End If
                    ' Next

                    If intTimesheetID = "0" Then
                        If IsNothing(strRemarksIDs) Then
                            strRemarksIDs = "0"
                        End If
                        intTimesheetID = CType(strRemarksIDs, String)

                    End If

                    'Unverify all Unchecked Activities
                    'Added UserID to SP Paramtere
                    'Modified Code By VidyaJ - IssueID - 20550
                    'Change status of only for actvities which are rejected and not all activities
                    'Changed ID list From strDailyActivityIDS to strRemarksIDs
                    strQuery = "usp_Upd_UnverifyResouceTimesheetStatus " + CType(intTimesheetID, String) + "," + CType(Session("intUserID"), String) + ",'" + CType(strRemarksIDs, String) + "'"
                    drUnVerify = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                    CommonFunctions.Data.DisposeDataReader(drUnVerify)

                    'Change Status to Verified in tbl_PM_ResourceTimesheetStatus table
                    strSQLQuery = "Exec usp_Upd_tbl_PM_ResourceTimesheetStatus " + CType(intTimesheetID, String) + "," + CType(Session("intUserID"), String) + "," + "'J'"
                    drUnVerify = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                    CommonFunctions.Data.DisposeDataReader(drUnVerify)


                    '##### Send Mail For Rejection
                    strSQLQuery = "usp_Sel_tbl_PM_EmailMessages 437"
                    drEmailMessage = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

                    If drEmailMessage.Read Then
                        blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                        blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                    End If
                    'CommonFunctions.Data.DisposeDataReader(drEmailMessage)
                    ''AUJ, get the next TimesheetID after current one is processed(i.e. Rejected)
                    ''m_strPrevTimesheetID = intTimesheetID
                    ' ''Modified By VarunA on 3-Dec-2007 DSS RequestID-10747
                    ' ''Purpose : If TimesheeID is more than 8000 characters
                    ' ''m_strTimesheetID = CType(CommonFunction.Data.GetDataScalar("usp_sel_WSEM_TSIDS '" & HttpContext.Current.Session("TSIDs").ToString & "', " + HttpContext.Current.Session("intUserID").ToString + ", 2, " + m_strTimesheetID.ToString, True), String)
                    ''intTimesheetID = CType(CommonFunction.Data.GetDataScalar("usp_sel_WSEM_TSIDS '" & strArray(0) & "','" & strArray(1) & "','" & strArray(2) & "', " + HttpContext.Current.Session("intUserID").ToString + ", 2, " + m_strTimesheetID.ToString, True), String)
                    ' ''End By VarunA on 3-Dec-2007
                    ''AUJ
                    '' Check if the mail has to be sent.
                    'If blnSendEmail = True Then
                    ' Check if a popup message has to be shown.
                    If blnShowPopup = True Then
                        ''CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
                        'CommonFunctions.General.WriteHTML("window.open('../../Source/General/SendEmail.aspx?MessageID=435&VerifiedBy=" + CType(intVerifiedBy, String) + "&ResourceID=" + CType(m_strEmployeeID, String) + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left='" + "(window.screen.width - 600) / 2" + "',top='" + "(window.screen.height - 500) / 2" + "',width=600,height=500')" + vbCrLf)
                        'Modofied By HarshK on 11/08/05 - IssueID - 86 - SP4
                        'CommonFunctions.General.WriteHTML("window.location.href = '../General/CommonList.aspx?FromWhere=SM&MasterTagID=" + CType(m_TagVerifyTimesheetList, String) + "';")
                        'AUJ,Following line Commented. Do not redirect to list page.(i.e. RT_TimesheetApproval.aspx)
                        'CommonFunctions.General.WriteHTML("window.location.href = '../RT/RT_TimesheetApproval.aspx?MasterTagID=" + CType(m_TagVerifyTimesheetList, String) + "';")
                        'end HarshK on 11/08/05
                        'AUJ,Commented and added below, instead of taking EmployeeID from Querystring take it from variable.
                        'CommonFunctions.General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=437&VerifiedBy=" + CType(Session("intUserID"), String) + "&ResourceID=" + CType(Request.QueryString("EmployeeID"), String) + "&FromDate=" + strFromDate + "&ToDate=" + strToDate + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')" + vbCrLf)
                        '' CommonFunctions.General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=437&VerifiedBy=" + CType(Session("intUserID"), String) + "&ResourceID=" + strResourceID + "&FromDate=" + strFromDate + "&ToDate=" + strToDate + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')" + vbCrLf)
                        '' CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
                        ' Else, if the mail has to be sent silently, then...
                        ''' Else

                        'Commented & Modified By amitJ On 23-June-2010 for WhizibleSEM9 SP1 For HotFix 9.0.053 
                        'Page Crash while rejecting approved timesheet. (Set mail id 437 sendmail = true,showpopup =false and 435 send mail=false,showpopup =false)
                        'Wrong Email function was called also timesheet approverid was not passed to the funciton.
                        'CommonFunction.EmailMessages.ResourceTimesheetMessages.GetEmailMessage_435(strFromEmailID, strToEmailID, strCCEmailID, strSubject, strMessage, intVerifiedBy, CType(strResourceID, Integer), CType(strFromDate, Date), CType(strToDate, Date))
                        CommonFunction.EmailMessages.ResourceTimesheetMessages.GetEmailMessage_437(strFromEmailID, strToEmailID, strCCEmailID, strSubject, strMessage, CType(Session("intUserID"), Integer), CType(strResourceID, Integer), CType(strFromDate, Date), CType(strToDate, Date))
                        'End Of Modificaiton By Amit J
                        'Call CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCEmailID, strFromEmailID, strSubject, strMessage)
                        Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID.Trim(), strCCEmailID, strFromEmailID.Trim(), strSubject, strMessage)
                        ''End If
                    End If
                    '' ##### End

                    '' START : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
                    '    Else
                    '    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Timesheet Approval : Rejection", m_TagVerifyTimesheetList, 0, "Timesheet ID", CType(m_strTimesheetID, String))
                    '    'Token is Invalid now redirect to the Invalid Access Page
                    '    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                    'End If
                End If

                'End If
                ''Response.Write("<script> var objFrm = document.getElementById('frmMyApproval');objFrm.submit();</script>")
            End If
        Catch ex As Exception
        End Try
    End Sub
    Private Sub ExpenseApproval(ByVal intExpenseID As Integer, ByVal intisExpense As Integer)
        'Try
        '    Dim strSQL As String
        '    Dim strFromEmailId As String
        '    Dim strToEmailId As String
        '    Dim m_strExpenseSheetID As String
        '    Dim strCCToEmailId As String
        '    Dim strSubject As String
        '    Dim strMailBody As String
        '    m_strExpenseSheetID = CommonFunction.Data.GetDataScalar("SELECT ExpenseSheetID FROM tbl_PM_ExpenseSheet_Details WHERE ExpensesEntryID=" & intExpenseID, True)
        '    If Request.QueryString("ApproveorReject") = "A" Then
        '        strSQL = "usp_upd_tbl_PM_ExpenseEntry_Approved "
        '        strSQL += CommonFunction.General.CheckIsNothing(m_strExpenseSheetID, 0) + ", "
        '        strSQL += "'" + intExpenseID.ToString() + "' , '"
        '        strSQL += CommonFunction.General.CheckIsNothing(Request.QueryString("Remarks"), "") + "', "
        '        strSQL += CommonFunction.General.CheckIsNothing(Session("intUserID"), "") + ","
        '        strSQL += "1"
        '        CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
        '        CommonFunction.EmailMessages.EWFMessages.GetEmailMessage_460(strFromEmailId, strToEmailId, strCCToEmailId, strSubject, strMailBody, CType(m_strExpenseSheetID, Long), intExpenseID)
        '    Else
        '        strSQL = "usp_upd_tbl_PM_ExpenseEntry_Rejected "
        '        strSQL += CommonFunction.General.CheckIsNothing(m_strExpenseSheetID, 0) + ", "
        '        strSQL += "'" + intExpenseID.ToString + "' , '"
        '        strSQL += CommonFunction.General.CheckIsNothing(Request.QueryString("Remarks"), "") + "', "
        '        strSQL += CommonFunction.General.CheckIsNothing(Session("intUserID"), "") + ""
        '        CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
        '        CommonFunction.EmailMessages.EWFMessages.GetEmailMessage_467(strFromEmailId, strToEmailId, strCCToEmailId, strSubject, strMailBody, CType(m_strExpenseSheetID, Long), intExpenseID)
        '    End If
        '    CommonFunction.Emails.SendEmailWithCC(strToEmailId, strCCToEmailId, strFromEmailId, strSubject, strMailBody)
        '    '' Response.Write("<script> var objFrm = document.getElementById('frmMyApproval');objFrm.submit();</script>")
        'Catch ex As Exception
        'End Try
        Try
            If Session("intUserID") IsNot Nothing Then

                Dim strFromEmailId As String = ""
                Dim strToEmailId As String = ""
                Dim strCheckEntry As String = ""
                Dim strCCToEmailId As String = ""
                Dim strSubject As String = ""
                Dim strMailBody As String = ""
                Dim strSQL As String
                Dim strQuery As String
                Dim stRejectSQL As String
                Dim strMailTo As String = ""
                Dim strFromMail As String = ""
                Dim strMessage As String = ""
                Dim drEmailMessage As IDataReader
                Dim blnSendEmail As Boolean
                Dim blnShowPopup As Boolean
                Dim strSQLQuery As String
                Dim intMessageID As Integer
                Dim blnSendMail As Boolean
                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''m_strExpenseSheetID = CommonFunction.Data.GetDataScalar("SELECT ExpenseSheetID FROM tbl_PM_ExpenseSheet_Details WHERE ExpensesEntryID=" & intExpenseID, True)
                m_strExpenseSheetID = CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_ExpenseSheet_Details_ExpenseSheetID " & intExpenseID, True)
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                ''strCheckEntry = CommonFunction.Data.GetDataScalar("SELECT 1 FROM tbl_PM_ExpenseEntry_status_history WHERE ExpensesEntryID = " & m_strExpenseSheetID & " AND ActionTaken='Approved' AND NextActorType='FinanceApprover' ", True)
                If Request.QueryString("ApproveorReject") = "A" Then

                    If intisExpense = "1" Then
                        intMessageID = 461
                        strSQL = "usp_upd_tbl_PM_ExpenseEntry_FinanceApproved "
                        strSQL += m_strExpenseSheetID + ", "
                        strSQL += "'" + intExpenseID.ToString() + "' , "
                        strSQL += "'Approved:#:', "
                        strSQL += CommonFunction.General.CheckIsNothing(Session("intUserID"), "")
                    Else
                        intMessageID = 460
                        strSQL = "usp_upd_tbl_PM_ExpenseEntry_Approved "
                        strSQL += m_strExpenseSheetID + ", "
                        strSQL += "'" + intExpenseID.ToString() + "' , "
                        strSQL += "'Approved', "
                        strSQL += CommonFunction.General.CheckIsNothing(Session("intUserID"), "") + ","
                        strSQL += "1"
                    End If
                Else
                    'If intisExpense = "1" Then
                    If intisExpense = "0" Then
                        intMessageID = 467
                        strSQL = "usp_upd_tbl_PM_ExpenseEntry_Rejected "
                        strSQL += m_strExpenseSheetID + ", "
                        strSQL += "'" + intExpenseID.ToString + "' , "
                        strSQL += "'Rejected', "
                        strSQL += CommonFunction.General.CheckIsNothing(Session("intUserID"), "") + ""
                    Else
                        intMessageID = 464
                        strSQL = "usp_upd_tbl_PM_ExpenseEntry_FinanceRejected "
                        strSQL += m_strExpenseSheetID + ", "
                        strSQL += "'" + intExpenseID.ToString() + "' , "
                        strSQL += "'Rejected:#:', "
                        strSQL += CommonFunction.General.CheckIsNothing(Session("intUserID"), "")
                    End If
                End If
                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                strSQLQuery = "usp_Sel_tbl_PM_EmailMessages " + intMessageID.ToString
                drEmailMessage = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

                If drEmailMessage.Read Then
                    blnSendMail = CType(CommonFunction.Data.CheckIsDBNull(drEmailMessage("SendMail"), "0"), Boolean)
                    blnShowPopup = CType(CommonFunction.Data.CheckIsDBNull(drEmailMessage("ShowPopup"), "0"), Boolean)
                End If
                CommonFunction.Data.DisposeDataReader(drEmailMessage)
                If blnSendMail = True Then
                    'If blnShowPopup = True Then

                    '    CommonFunction.General.WriteHTML("<SCRIPT>" + vbCrLf)
                    '    CommonFunction.General.WriteHTML(" window.open(""../General/SendEmail.aspx?MessageID=" + intMessageID.ToString + "&ExpenseSheetID=" + m_strExpenseSheetID + "&ExpenseEntryIDList=" + CommonFunction.General.BuildQueryString(intExpenseID) + """, """", ""resizable=no,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                    '    CommonFunction.General.WriteHTML("</SCRIPT>" + vbCrLf)
                    'Else
                    Select Case intMessageID
                        Case 460
                            CommonFunction.EmailMessages.EWFMessages.GetEmailMessage_466(strFromEmailId, strToEmailId, strCCToEmailId, strSubject, strMailBody, CType(m_strExpenseSheetID, Long), intExpenseID)
                        Case 467
                            CommonFunction.EmailMessages.EWFMessages.GetEmailMessage_467(strFromEmailId, strToEmailId, strCCToEmailId, strSubject, strMailBody, CType(m_strExpenseSheetID, Long), intExpenseID)
                        Case 461
                            CommonFunction.EmailMessages.EWFMessages.GetEmailMessage_461(strFromEmailId, strToEmailId, strCCToEmailId, strSubject, strMailBody, CType(m_strExpenseSheetID, Long), intExpenseID)
                        Case 464
                            CommonFunction.EmailMessages.EWFMessages.GetEmailMessage_464(strFromEmailId, strToEmailId, strCCToEmailId, strSubject, strMailBody, CType(m_strExpenseSheetID, Long), intExpenseID)
                    End Select

                    If strToEmailId <> "" And strToEmailId <> ";" Then
                        'CommonFunction.Emails.SendEmailWithCC(strToEmailId, strCCToEmailId, strFromEmailId, strSubject, strMailBody)
                        CommonFunction.Emails.AppSendEmailWithCC(strToEmailId.Trim(), strCCToEmailId, strFromEmailId.Trim(), strSubject, strMailBody)
                    End If
                End If
            End If
        Catch ex As Exception
        End Try
    End Sub
    Protected Shared WithEvents objWorkFlowDefinition As WorkFlowGeneral.DefinitionDetails.Definition
    Private Sub EntityApproval(ByVal intEntityID As Integer, ByVal MasterTagID As Integer)
        Try
            If Session("intUserID") IsNot Nothing Then

                Dim IsComplete As Integer
                Dim NewstrSql As String
                Dim sbScript_Deliverable As New System.Text.StringBuilder
                If Session("intProjectID") Is Nothing Then
                    Session("intProjectID") = "0"
                End If
                Dim m_objGlobalObject As WebPages.Template.IGlobal
                Dim m_objAccessRights As WebPages.Security.cAccessRights
                MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
                m_objGlobalObject = MyBase.GlobalObject()
                m_objGlobalObject.TagID = 3986 ''CommonFunction.Constants.APP_Tag_TIMESHEET_MYTIMESHEETS
                m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobalObject)
                m_objAccessRights.GetAccess()
                Dim strWorkflowoption As String
                If Request.QueryString("ApproveorReject") IsNot Nothing Then
                    If Request.QueryString("ApproveorReject") = "A" Then
                        strWorkflowoption = "SYS_APPROVE"
                    Else
                        strWorkflowoption = "SYS_REJECT"
                    End If
                End If
                Dim strPrimaryKeyvalue As String
                If strWorkflowoption.ToUpper.ToString = "SYS_APPROVE" Then

                    NewstrSql = "usp_Get_Deliverable_Stage_Details " & intEntityID.ToString
                    IsComplete = CommonFunctions.Data.GetDataScalar(NewstrSql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    'If IsComplete.ToString <> "2" Then
                    If IsComplete.ToString = "1" Then
                        sbScript_Deliverable.Append("<Script language=javascript>")
                        sbScript_Deliverable.Append("alert('Some tasks from this stage are incomplete.Please complete the task!');")
                        sbScript_Deliverable.Append("</Script>")
                        CommonFunction.General.WriteHTML(sbScript_Deliverable.ToString)
                        Exit Sub
                    End If
                    'End If
                End If

                strPrimaryKeyvalue = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_ins_UPD_tbl_IM_WorkflowInstance " + intEntityID.ToString + "," + MasterTagID.ToString + "," + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0").ToString + ",0,'" + CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "").ToString) + "'", True), "")
                'CommonFunction.WhizibleWorkflow.UpdateWhizibleWorkflowData(m_objGlobalObject, intEntityID, strWorkflowoption, MasterTagID.ToString)
                'Public Shared Sub UpdateWhizibleWorkflowData(ByVal m_GlobalObject As WebPages.Template.IGlobal, ByVal PrimaryKeyValue As String, ByVal strAction As String, ByVal strTagID As String, Optional ByVal strWorkflowOption As String = "", Optional ByVal FromWhere As String = "", Optional ByVal ActionComments As String = "", Optional ByVal FromMobileApprovals As Boolean = False)
                '=============================================
                ' Procedure Name		: UpdateWhizibleWorkflowData
                ' Description           : perform approve reject submit actions
                ' Purpose               : 
                ' Parameters Passed     : 
                ' Parameters Affected   :
                ' Assumptions           :
                ' Dependencies          :
                ' Author                : PurvaJ
                ' Created               : April 30 2008
                ' Revisions             :
                '==============================================
                Dim m_strToEmailID As String = ""
                Dim m_strCCEmailID As String = ""
                Dim m_strSubject As String = ""
                Dim m_strMessage As String = ""
                Dim m_strFromEmailID As String = ""
                Dim FromWhere As String = ""
                Dim strTagID As String = MasterTagID.ToString
                Dim strAction As String = strWorkflowoption
                Dim strActionID As String = ""
                Dim strInstanceID As String = ""
                Dim strPrimaryKey As String = ""
                Dim m_strStageConditionError As String = ""
                Dim strRequestStageID As String = ""
                Dim strProjectNODID As String = ""
                Dim dr As IDataReader
                Dim strComments As String = ""
                Dim objDS As DataSet
                Dim sb_UWW As New System.Text.StringBuilder
                Dim iMsgID As Integer
                Dim ActionComments As String
                Dim FromMobileApprovals As Boolean = False
                ''Added by PrashantSJ on 14th Apr 2009 : WhizibleSEM 8.0
                If ActionComments <> "" Then
                    strComments = ActionComments
                Else
                    strComments = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Remarks"), "").ToString
                End If

                'strComments = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtComments_hidden"), "").ToString
                ''End of addition and comment by PrashantSJ on 14th Apr 2009

                dr = CommonFunction.Data.GetDataReader("usp_get_WorkflowDetails " + intEntityID.ToString + "," + strTagID + ",'" + strAction + "'", True)
                If dr.Read Then
                    strPrimaryKey = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("PrimaryKey"), ""), "").ToString
                    strActionID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("ActionID"), ""), "").ToString
                    strInstanceID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("InstanceID"), ""), "").ToString
                    strRequestStageID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("RequestStageID"), ""), "").ToString
                    strProjectNODID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("ProjectNatureOfDemandID"), ""), "").ToString
                End If

                CommonFunction.Data.DisposeDataReader(dr)

                objWorkFlowDefinition = New WorkFlowGeneral.DefinitionDetails.Definition
                objWorkFlowDefinition.Initialize()

                objWorkFlowDefinition.m_strConnString = CommonFunctions.General.BuildConnectionString(CommonFunction.General.GetApplicationKeySetting("ConnectionString"))

                objWorkFlowDefinition.FillWorkFlowDefinition(m_objGlobalObject, strPrimaryKey)

                m_objGlobalObject.TagID = 3929

                If intEntityID.ToString <> "" Then
                    If strAction <> "" Then
                        '''<Summary>
                        '''Author   :   PrashantSJ
                        '''Date     :   10 May 2008
                        '''Date     :   To return the Action Type MsgID w.r.t TagID
                        '''</Summary>
                        sb_UWW.Append("usp_Sel_IM_EmailMessages NULL ")
                        sb_UWW.Append("," + strTagID)

                        objDS = CommonFunction.Data.GetDataSet(sb_UWW.ToString, "ActionMessage", , , CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                        For Each objdataRow As DataRow In objDS.Tables(0).Select("ActionType='" + strAction + "'")
                            iMsgID = CInt(CommonFunction.Data.CheckIsDBNull(objdataRow("MsgID"), "0"))
                        Next

                        sb_UWW.Remove(0, sb_UWW.Length)

                        '''End of addition by PrashantSJ on 10 May 2008

                        If strAction = "SYS_SUBMIT" Then
                            m_strStageConditionError = objWorkFlowDefinition.UpdateWorkFlowData(m_objGlobalObject, strPrimaryKey, "SUBMIT", strActionID, "")
                            If objWorkFlowDefinition.m_strInstanceID <> "" Then
                                CommonFunction.WhizibleWorkflow.UpdateEvent(UCase(CommonFunction.General.CheckIsNothing(objWorkFlowDefinition.m_strInstanceID, "")), strComments)
                            End If
                        ElseIf strAction = "SYS_APPROVE" Then


                            m_strStageConditionError = objWorkFlowDefinition.UpdateWorkFlowData(m_objGlobalObject, strPrimaryKey, "APPROVE", strActionID, strInstanceID)
                            If strInstanceID <> "" Then
                                CommonFunction.WhizibleWorkflow.UpdateEvent(UCase(CommonFunction.General.CheckIsNothing(strInstanceID, "")), strComments)
                            End If
                            'End If
                        ElseIf strAction = "SYS_REJECT" Then
                            m_strStageConditionError = objWorkFlowDefinition.UpdateWorkFlowData(m_objGlobalObject, strPrimaryKey, "REJECT", strActionID, strInstanceID)
                            'If objWorkFlowDefinition.m_blnIsCommentsAllowed = True Then
                            If strInstanceID <> "" Then
                                CommonFunction.WhizibleWorkflow.UpdateEvent(UCase(CommonFunction.General.CheckIsNothing(strInstanceID, "")), strComments)
                            End If
                            'End If
                        End If

                        If m_strStageConditionError = "" Then

                            If strTagID = CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING.ToString Then
                                CommonFunction.WhizibleWorkflow.UpdateProjectRevisionDetails(intEntityID.ToString, strAction, strTagID, strRequestStageID, strProjectNODID, strWorkflowoption, strComments)
                            Else
                                CommonFunction.WhizibleWorkflow.UpdateOtherEntityRevisions(intEntityID.ToString, strAction, strTagID, strRequestStageID, strProjectNODID, strWorkflowoption)
                            End If

                            'Chaned by DarshanK on 4-Aug-2008
                            If FromWhere = "" Then
                                'End of Change by DarshanK on 4-Aug-2008
                                CommonFunction.WhizibleWorkflow.SendWorkflowEmails(iMsgID, strPrimaryKey, strComments, FromMobileApprovals)
                                'If strPrimaryKey = PrimaryKeyValue Then

                                'Added By Amol Changle On: 24 Apr 2009
                                'Purpose: Not to refresh parent page when method is called from WhizibleMobile application
                                'If Not FromMobileApprovals Then
                                '    'End Addition By Amol Changle
                                '    '''To refresh Workflow Approval page after specified action
                                '    sb_UWW.Append("<script language='javascript'>" & vbCrLf)
                                '    sb_UWW.Append("if (window.opener!=null )" & vbCrLf)
                                '    sb_UWW.Append("{" & vbCrLf)
                                '    sb_UWW.Append("refreshParent('frmDM_WorkFlowApprovals','DM_WorkFlowApprovals.aspx','../DM/DM_WorkFlowApprovals.aspx',true);" & vbCrLf)
                                '    sb_UWW.Append("}" & vbCrLf)
                                '    sb_UWW.Append("</script>" & vbCrLf)
                                '    CommonFunction.General.WriteHTML(sb_UWW.ToString)
                                'End If
                            End If
                            Call CommonFunction.EmailMessages.ConfigurableWorkflowMessages.GetEmailMessage(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, iMsgID, strPrimaryKey, strComments)
                            'CommonFunction.Emails.SendEmailWithCC(m_strToEmailID, m_strCCEmailID, m_strFromEmailID, m_strSubject, m_strMessage)
                            CommonFunction.Emails.AppSendEmailWithCC(m_strToEmailID.Trim(), m_strCCEmailID, m_strFromEmailID.Trim(), m_strSubject, m_strMessage)
                        End If
                    End If
                End If
                objDS = Nothing
                sb_UWW = Nothing
                objWorkFlowDefinition = Nothing
                m_objGlobalObject.TagID = strTagID.ToString
                '' Response.Write("<script> var objFrm = document.getElementById('frmMyApproval');objFrm.submit();</script>")
            End If
        Catch ex As Exception
        End Try
    End Sub
    Private Sub AuthenticateORReject_Timesheet(ByVal intTimesheetID As Integer)
        Try
            If Session("intUserID") IsNot Nothing Then

                Dim strQuery As String
                Dim stRejectSQL As String
                Dim strMailTo As String = ""
                Dim strFromMail As String = ""
                Dim strSubject As String = ""
                Dim strMessage As String = ""
                Dim drEmailMessage As IDataReader
                Dim strCCToEmailID As String = ""
                Dim blnSendEmail As Boolean
                Dim blnShowPopup As Boolean

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                'Dim stremployeename As String = CType(CommonFunctions.Data.GetDataScalar("SELECT EmployeeName FROM tbl_PM_Employee WHERE EmployeeID=" + CType(Session("intUserID"), String), True), String)
                Dim stremployeename As String = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Employee_EmployeeName " + CType(Session("intUserID"), String), True), String)
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                If Request.QueryString("ApproveorReject") IsNot Nothing Then
                    If Request.QueryString("ApproveorReject") = "A" Then
                        strQuery = "usp_Upd_tbl_PM_TimeSheetInvoice '" & intTimesheetID.ToString() & "','" & CommonFunction.General.CheckIsNothing(Request.QueryString("Remarks"), "") & "','" + CommonFunction.General.BuildQueryString(stremployeename) + "'"
                        ' end Modification by NitinVs on 30 jun 2009 to Handle single quote 
                        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                        drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 4", MyBase.UseSQL)
                        If drEmailMessage.Read Then
                            blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                            blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                        End If
                        CommonFunction.Data.DisposeDataReader(drEmailMessage)
                        'If blnSendEmail = True And blnShowPopup = True Then
                        '    Response.Write("<Script language='javascript'>")
                        '    CommonFunctions.General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=4&TimeSheetID=" + intTimesheetID.ToString() + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')" + vbCrLf)
                        '    Response.Write("</Script>")
                        'End If

                        If blnSendEmail = True Then
                            CommonFunction.EmailMessages.FAMessages.GetEmailMessage_4(strFromMail, strMailTo, strCCToEmailID, strSubject, strMessage, CType(intTimesheetID, Long))
                            'CommonFunction.Emails.AppSendEmail(strMailTo, strFromMail, strSubject, strMessage)
                            CommonFunction.Emails.AppSendEmailWithCC(strMailTo.Trim(), strCCToEmailID, strFromMail.Trim(), strSubject, strMessage)
                        End If
                    End If
                Else
                    stRejectSQL = "usp_Upd_tbl_PM_TimeSheetInvoice_For_Rejection " + intTimesheetID.ToString() + ",'" + CommonFunction.General.CheckIsNothing(Request.QueryString("Remarks"), "") + "','" + stremployeename + "'"
                    CommonFunctions.Data.InsertOrUpdateData(stRejectSQL, MyBase.UseSQL)
                    drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 442", MyBase.UseSQL)
                    If drEmailMessage.Read Then
                        blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                        blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                    End If
                    CommonFunction.Data.DisposeDataReader(drEmailMessage)
                    'If blnSendEmail = True And blnShowPopup = True Then
                    '    Response.Write("<Script language='javascript'>")
                    '    CommonFunctions.General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=442&TimeSheetID=" + intTimesheetID.ToString() + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')" + vbCrLf)
                    '    Response.Write("</Script>")
                    'End If

                    If blnSendEmail = True Then
                        CommonFunction.EmailMessages.FAMessages.GetEmailMessage_442(strFromMail, strMailTo, strCCToEmailID, strSubject, strMessage, CType(intTimesheetID, Long))
                        CommonFunction.Emails.SendEmailWithCC(strMailTo, strCCToEmailID, strFromMail, strSubject, strMessage)
                    End If
                End If
            End If
        Catch ex As Exception
        End Try
    End Sub
    <System.Web.Services.WebMethod()>
    Public Shared Function GetEmailID(ByVal intTimesheetID As String) As String
        Try
            Dim strEmailID As String

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strEmailID = CommonFunctions.Data.GetDataScalar("SELECT EmailID FROM tbl_PM_Employee where EmployeeID=(Select  EmployeeID From tbl_PM_ResourceTimesheet WHERE TimeSheetID=" & intTimesheetID & ")", True)
            strEmailID = CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Employee_TimeSheetIDWiseEmailID " & intTimesheetID, True)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            Return strEmailID

        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetEMPEmailID(ByVal intEmpID As String) As String
        Try
            Dim strEmailID As String

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strEmailID = CommonFunctions.Data.GetDataScalar("SELECT EmailID FROM tbl_PM_Employee where EmployeeID=" & intEmpID & "", True)
            strEmailID = CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Employee_EmployeeIDWiseEmailID " & intEmpID & "", True)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            Return strEmailID
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetEmailIDProject(ByVal intProjectID As String) As String
        Try
            Dim dt As New DataTable()

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''dt = CommonFunction.Data.GetDataTable("SELECT EmailID,EmployeeName FROM tbl_PM_Employee where EmployeeID=(Select  timesheetAuthenticatorID From tbl_pm_project WHERE ProjectID=" & intProjectID & ")", True)
            dt = CommonFunction.Data.GetDataTable("usp_sel_tbl_PM_Employee_timesheetAuthenticatorWise_EmailID_EmployeeName " & intProjectID, True)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            Dim strEmailID As String = GetSerialized(dt)
            Return strEmailID
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetEmailForWorkFlow(ByVal strTagID As String, ByVal strAction As String, ByVal strComments As String, ByVal intEntityID As String) As String
        Try
            Dim m_strToEmailID As String = ""
            Dim m_strCCEmailID As String = ""
            Dim m_strSubject As String = ""
            Dim m_strMessage As String = ""
            Dim m_strFromEmailID As String = ""
            Dim objDS As DataSet
            Dim sb_UWW As New System.Text.StringBuilder
            Dim iMsgID As String
            Dim strReturn As String
            sb_UWW.Append("usp_Sel_IM_EmailMessages NULL ")
            sb_UWW.Append("," + strTagID)
            objDS = CommonFunction.Data.GetDataSet(sb_UWW.ToString, "ActionMessage", , , CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            For Each objdataRow As DataRow In objDS.Tables(0).Select("ActionType='" + strAction + "'")
                iMsgID = CInt(CommonFunction.Data.CheckIsDBNull(objdataRow("MsgID"), "0"))
            Next
            sb_UWW.Remove(0, sb_UWW.Length)
            Call CommonFunction.EmailMessages.ConfigurableWorkflowMessages.GetEmailMessage(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, iMsgID, intEntityID.ToString, strComments)
            strReturn = m_strFromEmailID + "," + m_strToEmailID + "," + m_strCCEmailID + "," + m_strSubject + "," + m_strMessage
            Return strReturn
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetUserAccess(ByVal intUserID As String, ByVal intTagID As String) As String
        Try
            Dim strAccess As String
            strAccess = CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Login_AccessibleModules_ForRole_MyApproval " & intUserID & "," & intTagID, True)
            Return strAccess
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function SetWork(LoginID As String, LeaveID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(LoginID, String) + CType(LeaveID, String))
            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetHeplDeskApprovalData(ByVal intUserID As String)
        Try
            Dim dt As New DataTable()
            dt = CommonFunction.Data.GetDataTable("usp_Sel_LineManager_Approvals " & CType(intUserID, Long) & ",'1' ", True)
            Dim str As String = GetSerialized(dt)
            Return str
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetHeplDeskApprovalDataCount(ByVal intUserID As String)
        Try
            Dim dt As New DataTable()
            dt = CommonFunction.Data.GetDataTable("usp_CNT_LineManager_Approvals_MyApproval " & CType(intUserID, Long), True)
            Dim str As String = GetSerialized(dt)
            Return str
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetDataHelpDeskForQuery(ByVal intUserID As String, ByVal QueryID As String) As String
        Try
            Dim dt As New DataTable()
            dt = CommonFunction.Data.GetDataTable(" usp_Sel_LineManager_Approvals_MyApproval " & CType(intUserID, Long) & ",'1',null," & QueryID, True)
        Dim str As String = GetSerialized(dt)
        Return str
        Catch ex As Exception
        Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function SetWork1(LoginID As String, Comments As String, EmployeeID As String, leaveID As String, status As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(LoginID, String) + CType(EmployeeID, String) + CType(leaveID, String))
            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    Public Shared Function GetSerialized(dt As DataTable) As String
        Try
            Dim serializer As New System.Web.Script.Serialization.JavaScriptSerializer()
            Dim rows As New List(Of Dictionary(Of String, Object))()
            Dim row As Dictionary(Of String, Object)
            For Each dr As DataRow In dt.Rows
                row = New Dictionary(Of String, Object)()
                For Each col As DataColumn In dt.Columns
                    row.Add(col.ColumnName, dr(col))
                Next
                rows.Add(row)
            Next
            Return serializer.Serialize(rows)
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
End Class