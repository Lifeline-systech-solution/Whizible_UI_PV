Partial Public Class CRM_LineManagerApprovals
    Inherits WebPages.Template.WhizTemplate
    Private m_intUserID As Integer
    Private m_intTotalNoOfRows As Integer
    Protected m_intPageNumber As Integer = 1
    Private strStatus As String
    Private strQueryID As String
    Private strQuery As String
    Private strComment As String
    ''Added by Amit Mahadik on 23Mar2011 Purpose:Encore Show details of request
    Protected m_PKToken_Query_DT As String
    Private m_lngEmployeeID As Long
    ''END Added by Amit Mahadik on 23Mar2011 Purpose:Encore Show details of request
    'Added By VarunA on 28-Nov-2008 IssueID-24169
    'Purpose:All Types of Requests are been seen in all the pages when cliked on any radio button.
    Protected m_strFilterID As String
    'End By VarunA on 28-Nov-2008 IssueID-24169

    Private strHTML As System.Text.StringBuilder
    Protected WithEvents m_objMenu As WebPage.Templates.StaticMenu

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        Call Initialize()
    End Sub
    Protected Sub WritePage()

        m_intUserID = HttpContext.Current.Session("intUserID")

        ' page number
        If Not Request.QueryString("PageNumber") Is Nothing AndAlso Request.QueryString("PageNumber") <> "" Then
            m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        End If

        If Request.QueryString("ACTION") = "SUBMIT" Then
            Call PerformAction()
        End If

        ''Added By VarunA on 28-Nov-2008 IssueID-24169
        ''Purpose:All Types of Requests are been seen in all the pages when cliked on any radio button.
        'If CommonFunction.General.CheckIsNothing(Request.QueryString("Filter"), "") <> "" Then
        '    m_strFilterID = Request.QueryString("Filter")
        'End If
        If Not Request.Form("optInbox") Is Nothing Then
            If Request.Form("optInbox").ToUpper() = "REQUESTS FOR MY APPROVAL" Then
                m_strFilterID = "1"
            ElseIf Request.Form("optInbox").ToUpper() = "REQUESTS APPROVED/REJECTED BY ME" Then
                m_strFilterID = "2"
            ElseIf Request.Form("optInbox").ToUpper() = "REQUESTS SUBMITTED BY ME" Then
                m_strFilterID = "3"
            End If
        End If


        Response.Write(GenerateMenu())
        Call PlotFilter()
        Call WriteNumericPaging()
        Call DrawPage()
        Response.Write(GenerateMenu())
    End Sub
    Private Sub DrawPage()
        Dim strSQL As String
        Dim dr As IDataReader
        Dim strQueryID As String
        Dim strSubject As String
        Dim strApprovalStatus As String
        Dim strCustomerID As String
        Dim strPriority As String
        Dim RequestType As String
        Dim SubRequestType As String
        Dim arrstatus() As String
        Dim strImagePath As String
        Dim InboxORwatchList As String
        Dim oldInboxORwatchList As String
        Dim iterator As Integer
        Dim blnRejected As Boolean = False
        Dim ReadCount As Integer
        Dim m_intPageNumberForSP As String

        If m_intPageNumber > 0 Then
            m_intPageNumberForSP = m_intPageNumber
        Else
            m_intPageNumberForSP = "NULL"
        End If

        'comment and Added By VarunA on 28-Nov-2008 IssueID-24169
        'Purpose:All Types of Requests are been seen in all the pages when cliked on any radio button.
        'strSQL = "usp_Sel_LineManager_Approvals " + m_intUserID.ToString + ",'" + Request.Form("optInbox") + "'"
        strSQL = "usp_Sel_LineManager_Approvals " + m_intUserID.ToString + ",'" + m_strFilterID + "'," + m_intPageNumberForSP
        'End By VarunA on 28-Nov-2008 IssueID-24169

        dr = CommonFunction.Data.GetDataReader(strSQL, True)


        If m_intPageNumber > 0 Then
            For ReadCount = 1 To (20 * (m_intPageNumber - 1))
                dr.Read()
            Next
        End If



        'Context Menu
        CommonFunction.General.WriteHTML("<Div id='divContextMenu' class='DropdownMenu'>")
        CommonFunction.General.WriteHTML("<Table cellspacing='0' cellpadding='3'>")
        ''Added by Amit Mahadik on 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request
        CommonFunction.General.WriteHTML("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
        CommonFunction.General.WriteHTML("<td class='CtMn_LeftFill' ></td>")
        CommonFunction.General.WriteHTML("<td id='tdShowDetails' title='Show Details' >&nbsp;&nbsp;&nbsp;Show Details")
        CommonFunction.General.WriteHTML("</td></tr>")

        CommonFunction.General.WriteHTML("<TR><td class='CtMn_LeftFill' ></td>")
        CommonFunction.General.WriteHTML("<td class='CtMn_Hr'></td></tr>")
        ''End Added by Amit Mahadik on 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request

        CommonFunction.General.WriteHTML("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
        CommonFunction.General.WriteHTML("<td class='CtMn_LeftFill' ></td>")
        CommonFunction.General.WriteHTML("<td id='tdApprove' title='Approve' >&nbsp;&nbsp;&nbsp;Approve")
        CommonFunction.General.WriteHTML("</td></tr>")
        ''deleted by Amit Mahadik on 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request
        '''''CommonFunction.General.WriteHTML("<TR><td class='CtMn_LeftFill' ></td>")
        '''''CommonFunction.General.WriteHTML("<td class='CtMn_Hr'></td></tr>")
        ''end deleted by Amit Mahadik on 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request
        CommonFunction.General.WriteHTML("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
        CommonFunction.General.WriteHTML("<td class='CtMn_LeftFill' ></td>")
        CommonFunction.General.WriteHTML("<td id='tdReject' title='Reject' >&nbsp;&nbsp;&nbsp;Reject")
        CommonFunction.General.WriteHTML("</td></tr>")
        CommonFunction.General.WriteHTML("</table>" + vbCrLf)
        CommonFunction.General.WriteHTML("</div>" + vbCrLf)

        'Commnet Div
        CommonFunction.General.WriteHTML("<DIV id='DivNOI' style='WIDTH: 10px;height:150px;DISPLAY:none;OVERFLOW:hidden;border:black 1px outset;'>" + vbCrLf)
        CommonFunction.General.WriteHTML("<Table class=clsTable cellspacing=0 cellpadding=0 style='height=99.99%;'>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TR class=clsTREven ><td id='tdComment'><b>Add Comment</b></td></TR>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TR class=clsTREven>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TD>" + vbCrLf)
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextArea("txtSubmitComments", "txtSubmitComments", , widthInPixel:=300, heightInPixel:=70, maxLength:=1000, returnHTML:=True, IsMandatory:=True) + vbCrLf)
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextArea("txtSubmitComments", "txtSubmitComments", , widthInPixel:=300, heightInPixel:=70, maxLength:=1000, returnHTML:=True, IsMandatory:=True, EnableHTMLEncode:=True) + vbCrLf)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunction.General.WriteHTML("</TD>" + vbCrLf)
        CommonFunction.General.WriteHTML("</TR>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TR class=clsTREven>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TD><input type=button id= btnOK name= btnOK Value = '   OK   ' style ='font size=9 width=10pts' onClick = SubmitOK_Onclick()> <input type=button id= btnCancel name= btnCancel style ='font size=9' Value = CANCEL onClick = Cancel_OnClick()>" + vbCrLf)
        CommonFunction.General.WriteHTML("</td></tr>" + vbCrLf)
        CommonFunction.General.WriteHTML("</table>" + vbCrLf)
        CommonFunction.General.WriteHTML("</DIV>" + vbCrLf)


        CommonFunction.General.WriteHTML("<div ID='PageDiv' Style='HEIGHT:99.99%;OVERFLOW:auto; WIDTH:99.9%'>")
        CommonFunction.General.WriteHTML("<TABLE class='clsGridTable' cellpadding=0 cellspacing=1 width='99.9%'>" + vbCrLf)
        CommonFunction.General.WriteHTML("<THEAD class=clsTRColumnHeader>" + vbCrLf)

        CommonFunction.General.WriteHTML("<TH></TH>" + vbCrLf)

        CommonFunction.General.WriteHTML("<TH class='divListTag' align ='Right'>" + vbCrLf)
        CommonFunction.General.WriteHTML("Request ID" + vbCrLf)
        CommonFunction.General.WriteHTML("</TH>" + vbCrLf)

        CommonFunction.General.WriteHTML("<TH class='divListTag' align ='Left'>" + vbCrLf)
        CommonFunction.General.WriteHTML("Submitted Date" + vbCrLf)
        CommonFunction.General.WriteHTML("</TH>" + vbCrLf)

        CommonFunction.General.WriteHTML("<TH class='divListTag' align ='Left'>" + vbCrLf)
        CommonFunction.General.WriteHTML("Status" + vbCrLf)
        CommonFunction.General.WriteHTML("</TH>" + vbCrLf)

        CommonFunction.General.WriteHTML("<TH class='divListTag' align ='Left'>" + vbCrLf)
        CommonFunction.General.WriteHTML("Subject" + vbCrLf)
        CommonFunction.General.WriteHTML("</TH>" + vbCrLf)


        CommonFunction.General.WriteHTML("<TH class='divListTag' align ='Left'>" + vbCrLf)
        CommonFunction.General.WriteHTML("Request Type" + vbCrLf)
        CommonFunction.General.WriteHTML("</TH>" + vbCrLf)

        CommonFunction.General.WriteHTML("<TH class='divListTag' align ='Left'>" + vbCrLf)
        CommonFunction.General.WriteHTML("Sub Request Type" + vbCrLf)
        CommonFunction.General.WriteHTML("</TD>" + vbCrLf)

        CommonFunction.General.WriteHTML("<TH class='divListTag' align ='Left'>" + vbCrLf)
        CommonFunction.General.WriteHTML("Requestor" + vbCrLf)
        CommonFunction.General.WriteHTML("</TH>" + vbCrLf)

        CommonFunction.General.WriteHTML("<TH class='divListTag' align ='Left'>")
        CommonFunction.General.WriteHTML("Priority")
        CommonFunction.General.WriteHTML("</TH>")
        CommonFunction.General.WriteHTML("</THEAD>")

        While dr.Read()
            strQueryID = CommonFunctions.Data.CheckIsDBNull(dr("QueryID"), "")
            ''Added by Amit Mahadik on 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request

            m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(strQueryID, String) + CType(m_lngEmployeeID, String) + "0" + "0")
            ''END Added by Amit Mahadik on 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request
            'Temp By VarunA
            'strSubject = CommonFunctions.Data.CheckIsDBNull(dr("Subject"), "")
            strSubject = CommonFunctions.Data.CheckIsDBNull(Server.HtmlEncode(dr("Subject")), "")
            'End By VarunA
            strApprovalStatus = CommonFunctions.Data.CheckIsDBNull(dr("ApprovalStatus"), "")
            strCustomerID = CommonFunctions.Data.CheckIsDBNull(dr("CustomerID"), "")
            strPriority = CommonFunctions.Data.CheckIsDBNull(dr("Priority"), "")
            InboxORwatchList = CommonFunctions.Data.CheckIsDBNull(dr("InboxORwatchList"), "")
            RequestType = CommonFunctions.Data.CheckIsDBNull(dr("RequestType"), "")
            SubRequestType = CommonFunctions.Data.CheckIsDBNull(dr("SubRequestType"), "")
            blnRejected = False
            If strApprovalStatus <> "" Then
                arrstatus = strApprovalStatus.Split(",")
            End If

            If oldInboxORwatchList <> InboxORwatchList Then
                CommonFunction.General.WriteHTML("<TR class='clsTRSectionHeader'><TD colspan=9 align=left >" + InboxORwatchList + "</td></tr>" + vbCrLf)
            End If

            oldInboxORwatchList = InboxORwatchList

            CommonFunction.General.WriteHTML("<tr class='clsTREven'>" + vbCrLf)

            CommonFunction.General.WriteHTML("<TD></TD>" + vbCrLf)

            CommonFunction.General.WriteHTML("<td align=right>")
            CommonFunction.General.WriteHTML(strQueryID)
            CommonFunction.General.WriteHTML("</TD>")

            CommonFunction.General.WriteHTML("<td align='left'>")
            CommonFunction.General.WriteHTML(CommonFunction.Dates.CGetDate(CType(CommonFunctions.Data.CheckIsDBNull(dr("SubmittedDate"), ""), Date)))
            CommonFunction.General.WriteHTML("</TD>")
            'Added by vidyak on 31 may 2010 for Whiziblesem9 SP1-HotFix 9.0.045 (Helpdesk Request Approval Status Workflow Modifications)
            If strApprovalStatus = "G,G" Then
                CommonFunction.General.WriteHTML("<td nowrap Title='Request Approved'>")
            ElseIf strApprovalStatus = "G,Y" Then
                CommonFunction.General.WriteHTML("<td nowrap  Title='Request Submitted'>")
            ElseIf strApprovalStatus = "G,R" Then
                CommonFunction.General.WriteHTML("<td nowrap  Title='Request Rejected'>")
            End If
            'End Added by vidyak on 31 may 2010 for Whiziblesem9 SP1-HotFix 9.0.045 (Helpdesk Request Approval Status Workflow Modifications)

            For iterator = 0 To arrstatus.Length - 1
                If arrstatus(iterator) = "G" Then
                    strImagePath = "<IMG border=0 src='../../Images/InitiativeGreen.gif' />"
                    CommonFunction.General.WriteHTML(strImagePath)
                ElseIf arrstatus(iterator) = "Y" Then
                    strImagePath = "<IMG border=0 src='../../Images/InitiativeYellow.gif' />"
                    CommonFunction.General.WriteHTML(strImagePath)
                ElseIf arrstatus(iterator) = "R" Then
                    strImagePath = "<IMG border=0 src='../../Images/InitiativeRed.gif' />"
                    blnRejected = True
                    CommonFunction.General.WriteHTML(strImagePath)
                End If
            Next
            CommonFunction.General.WriteHTML("</TD>")

            If InboxORwatchList = "Requests For My Approval" And blnRejected = False Then
                '-- Modified By purvaj on 10 Aug 2009
                '-- Onclick replaced with href
                '-- As href was set to #, entire frame was getting shifted upwards.
                'CommonFunction.General.WriteHTML("<td><A href=""#"" onclick='javascript:ShowPopup(event,this," + strQueryID + ")'>")
                '''''  CommonFunction.General.WriteHTML("<td style='text-decoration:underline;'><A onclick='javascript:ShowPopup(event,this," + strQueryID + ")'>")
                ''Added parameter Token by Amit Mahadik on 23Mar2011 Purpose:WhizibleSEM10.0 Show details of request
                CommonFunction.General.WriteHTML("<td style='text-decoration:underline;'><A onclick=""javascript:ShowPopup(event,this," + strQueryID + ",'" + m_PKToken_Query_DT + "')"">")
                ''end Added parameter Token by Amit Mahadik on 23Mar2011 Purpose:WhizibleSEM10.0 Show details of request
                '--End modification purvaj

                CommonFunction.General.WriteHTML(strSubject)
                CommonFunction.General.WriteHTML("</A></TD>")
            Else
                CommonFunction.General.WriteHTML("<td>")
                CommonFunction.General.WriteHTML(strSubject)
                CommonFunction.General.WriteHTML("</A></TD>")
            End If
            
            CommonFunction.General.WriteHTML("<td>")
            CommonFunction.General.WriteHTML(RequestType)
            CommonFunction.General.WriteHTML("</TD>")

            CommonFunction.General.WriteHTML("<td>")
            CommonFunction.General.WriteHTML(SubRequestType)
            CommonFunction.General.WriteHTML("</TD>")

            CommonFunction.General.WriteHTML("<td >")
            CommonFunction.General.WriteHTML(strCustomerID)
            CommonFunction.General.WriteHTML("</TD>")

            CommonFunction.General.WriteHTML("<td>")
            CommonFunction.General.WriteHTML(strPriority)
            CommonFunction.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("</TR>")
        End While
        CommonFunction.General.WriteHTML("</TABLE>")
        CommonFunction.General.WriteHTML("</DIV>")
        CommonFunction.General.WriteHTML("<BR>")
        CommonFunctions.Data.DisposeDataReader(dr)
    End Sub
    Private Function GenerateMenu()

        Dim arrMenuList As New ArrayList
        Dim arrMenuToolTipList As New ArrayList
        Dim arrClientSideFunctionsList As New ArrayList

        '--- Commented by purvaj on 20 Jul 2009 SEM 8.1 New UI
        ''arrMenuList.Add("<Img Border=0 src='../../Images/cssImages/Link images/close.gif'>&nbsp;Close")
        ''arrMenuToolTipList.Add("Close")
        ''arrClientSideFunctionsList.Add("close_OnClick()")
        '--- End Comment purvaj

        arrMenuList.Add("<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>")
        arrMenuToolTipList.Add("Help")
        arrClientSideFunctionsList.Add("Help_OnClick('CRMApprovals')")

        Dim arrMenu() As String = GetArray(arrMenuList)
        Dim arrMenuToolTip() As String = GetArray(arrMenuToolTipList)
        Dim arrClientSideFunctions() As String = GetArray(arrClientSideFunctionsList)

        m_objMenu = New WebPage.Templates.StaticMenu
        GenerateMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
    End Function

    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements
    End Function

    Private Sub PerformAction()
        Dim blnSendMail As Boolean
        Dim blnShowPopup As Boolean
        Dim dr As IDataReader
        Dim strFromEmailID As String
        Dim strToMailID As String
        Dim strCCToMailID As String
        Dim strSubject, strMessage As String
        Dim MessageID As String

        strStatus = Request.QueryString("Status").ToString()
        strQueryID = Request.QueryString("QueryID").ToString()
        'Comment and modification by SuchitraP on 30-Dec-2008 for IssueID 26321
        'strComment = Request.Form("txtSubmitComments")
        strComment = CommonFunction.General.BuildQueryString(Request.Form("txtSubmitComments"))
        'End of comment and modification by SuchitraP on 30-Dec-2008 for IssueID 26321

        strQuery = "usp_UPD_Request_ApprovalStatus " + strQueryID + ",'" + strStatus + "','" + strComment + "'," + m_intUserID.ToString()
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
            If blnShowPopup Then
                With Response
                    .Write("<script language=javascript>")
                    'Comment and addition of comments field by SuchitraP on 16-Dec-2008 for IssueID:25892
                    'Purpose:To display comments in Approval/Rejection mail
                    '.Write("window.open (""../General/SendEmail.aspx?MessageID=" + MessageID + "&ApprovalStatus=" + strStatus + "&QueryID=" & strQueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                    .Write("window.open (""../General/SendEmail.aspx?MessageID=" + MessageID + "&ApprovalStatus=" + strStatus + "&QueryID=" & strQueryID & "&EmployeeIDList=" & Session("intUserid").ToString & "&Comments=" & Left(strComment, 100) & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                    'End of comment and addition by SuchitraP on 16-Dec-2008 
                    .Write("</script>")
                End With
            Else
                ' silent mail
                If strStatus = "R" Then
                    'Comment and addition of comments field by SuchitraP on 16-Dec-2008 for IssueID:25892
                    'Purpose:To display comments in Approval/Rejection mail
                    'CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_530(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, strQueryID)
                    CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_530(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, strQueryID, Left(strComment, 100))
                    'End of comment and addition by SuchitraP on 16-Dec-2008 
                    'CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                Else
                    'Comment and addition of comments field by SuchitraP on 16-Dec-2008 for IssueID:25892
                    'Purpose:To display comments in Approval/Rejection mail
                    'CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_531(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, strQueryID)
                    CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_531(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, strQueryID, Left(strComment, 100))
                    'End of comment and addition by SuchitraP on 16-Dec-2008 
                    CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                End If
                
            End If
        End If

    End Sub
    Private Sub PlotFilter()

        Dim IsMyApprovalsChecked As Boolean = False
        Dim IsWatchListChecked As Boolean = False
        Dim IsMyRequest As Boolean = False
        Dim IsAllChecked As Boolean = True

        If Request.Form("optInbox") <> "" OrElse Not Request.Form("optInbox") Is Nothing Then
            If Request.Form("optInbox") = "Requests For My Approval" Then
                IsMyApprovalsChecked = True
                IsWatchListChecked = False
                IsAllChecked = False
                IsMyRequest = False
            ElseIf Request.Form("optInbox") = "Requests Approved/Rejected By Me" Then
                IsWatchListChecked = True
                IsMyApprovalsChecked = False
                IsAllChecked = False
                IsMyRequest = False
            ElseIf Request.Form("optInbox") = "Requests Submitted By Me" Then
                IsMyRequest = True
                IsWatchListChecked = False
                IsMyApprovalsChecked = False
                IsAllChecked = False
            Else
                IsAllChecked = True
                IsMyApprovalsChecked = False
                IsWatchListChecked = False
                IsMyRequest = False
            End If
        End If

        CommonFunction.General.WriteHTML("<BR>")
        CommonFunction.General.WriteHTML("<TABLE CellSpacing=0 BORDER=0 class='clsTable' width='99.9%'>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TR align=Left class='clsTREven'>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TD colspan=2 align=center>" + vbCrLf)
        'Added filter parameter to function OptFilter_OnChange By VarunA on 28-Nov-2008 IssueID-24169
        'Purpose:All Types of Requests are been seen in all the pages when cliked on any radio button.
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawOptionButton("optInbox", "optInbox", , IsMyApprovalsChecked, "Requests For My Approval", , "onclick=javascript:OptFilter_OnChange(1)", True))
        CommonFunction.General.WriteHTML("&nbsp;Requests For My Approval</TD>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TD colspan=2 align=center>" + vbCrLf)
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawOptionButton("optInbox", "optInbox", , IsWatchListChecked, "Requests Approved/Rejected By Me", , "onclick=javascript:OptFilter_OnChange(2)", True))
        CommonFunction.General.WriteHTML("&nbsp;Requests Approved/Rejected By Me</TD>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TD colspan=2 align=center>" + vbCrLf)
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawOptionButton("optInbox", "optInbox", , IsMyRequest, "Requests Submitted By Me", , "onclick=javascript:OptFilter_OnChange(3)", True))
        CommonFunction.General.WriteHTML("&nbsp;Requests Submitted By Me</TD>" + vbCrLf)

        CommonFunction.General.WriteHTML("<TD colspan=2 align=center>" + vbCrLf)
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawOptionButton("optInbox", "optInbox", , IsAllChecked, "All", , "onclick=javascript:OptFilter_OnChange(4)", True))
        'end By VarunA on 28-Nov-2008 IssueID-24169
        CommonFunction.General.WriteHTML("&nbsp;All</TD>" + vbCrLf)
        CommonFunction.General.WriteHTML("</TR>" + vbCrLf)
        CommonFunction.General.WriteHTML("</TABLE>" + vbCrLf)
        CommonFunction.General.WriteHTML("<BR>")

        'Plot Page Name
        CommonFunction.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TR class=clsTRPageCaption>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TD align=Left>Request Approvals</TD>" + vbCrLf)
        CommonFunction.General.WriteHTML("</TR>" + vbCrLf)
        CommonFunction.General.WriteHTML("</TABLE>" + vbCrLf)
        CommonFunction.General.WriteHTML("<BR>")

    End Sub

    Private Sub WriteNumericPaging()

        Dim intRecordCount As Integer
        Dim strPaging As String = ""
        Dim PagingSQL As String

        'Comment and modification by SuchitraP on 28-May-2009 
        'Purpose:When logged in user contained single quote in Username ,When clicked on Request approvals link,page crash occured
        'PagingSQL = "usp_CNT_LineManager_Approvals " + m_intUserID.ToString + ",'" + CommonFunction.General.BuildQueryString(Request.Form("optInbox")) + "'"
        PagingSQL = "usp_CNT_LineManager_Approvals " + m_intUserID.ToString + ",'" + m_strFilterID + "'"
        'End of comment and modification by SuchitraP on 28-May-2009 


        m_intTotalNoOfRows = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(PagingSQL, MyBase.UseSQL), ""), ""), Integer)

        If Math.Ceiling(m_intTotalNoOfRows / 20) < m_intPageNumber Then
            m_intPageNumber = 1
        End If

        strPaging = "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage()"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>"

        If m_intPageNumber = -1 Or m_intTotalNoOfRows = 0 Then

            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
        Else
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
        End If
        'ended by Yogesh J for HTML encoding Date:05/10/15
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage()"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage()"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> "
        strPaging += "<input type=hidden id=hidNoOfPages value=" + (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString + ">"

        strPaging += " of " + (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString
        strPaging += "|<A href='javascript:Page_OnClick(""-1"")' TITLE='Show All Records'><B>All<B></A>"
        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True)

        'ended by Yogesh J for HTML encoding Date:05/10/15
        Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'>")

        ''For Applied Filters
        'If Trim(strAppliedFilters & "") <> "" Then
        '    If strAppliedFilters.Length > 50 Then
        '        strAppliedFilters = strAppliedFilters.Substring(0, 50) + "..."
        '    End If

        '    If strAppliedFilters = "None" Then
        '        Response.Write("<td align=left  >Current Filter : None")
        '    Else
        '        Response.Write("<td align=left  >Current Filter : <A href='javascript:showFilters(1)' >" + strAppliedFilters + "</A>")
        '        If strAppliedFilters <> "None" Then
        '            Response.Write("<img id='imgFilter' style='text-decoration:none;' onMouseOver=this.style.cursor='hand' border='0' src='..\..\Images\cssImages\Link Images\Clearfilter.gif' alt='Clear Filter' onclick='ClearFilter()'/>")
        '        End If
        '        Response.Write("</td>")
        '    End If

        'End If
        'If strFrom = 2 Then
        '    Response.Write("<td>Resource Pool : ")
        '    Response.Write(strResourcePoolName)
        '    Response.Write("</td>")
        'End If
        ''End of Applied Filters

        If Trim(strPaging & "") <> "" Then
            'Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'><td align=right>" + strPaging + "</TD></TR></Table>")
            Response.Write("<td align=right>" + strPaging + "</TD>")
        End If

        Response.Write("</TR></TABLE>")

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
        ' Author                : AMIT MAHADIK
        ' Created               : 29 MAR,2011
        ' Revisions             :
        '=====================================================================
        ' Mode of the  page
        ''Added by Amit Mahadik on 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request for approver
        m_lngEmployeeID = CType(Session("intUserID"), Long)
        ''Added by Amit Mahadik on 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request for approver
    End Sub
End Class