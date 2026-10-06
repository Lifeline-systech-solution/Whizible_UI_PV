'******************************************************************
'           CSPL Code Header
' Project Name     :    Whizible Enterprise Version
' Module Name      :    Add Comments
' Purpose          :    Adding the Comments in the table, for the Particular action.
' Description      :    This is the common page, to accept the Comments again the action.
'                       So to know the action 'Action' name is passed using the querystring.
' Assumptions      :    None
' Dependencies     :    None
' Author           :    JayavantK
' Reviewed         :    
' Tested           :    
' Created          :    April 28, 2004
' Revisions        :    
'******************************************************************

Public Class HR_AddComments
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.

        ''commented by nilesh g on 31/12/2015 for Security
        If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
            Response.Write(vbCrLf + "<script>")
            Response.Write(vbCrLf + "		if (window.opener == null)")
            Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
            If strRedirectToPage.Trim = "" Then
                Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
            Else
                Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
            End If
            Response.Write(vbCrLf + "</script>")
        End If
        ''end of commented by nilesh g on 31/12/2015 for Security
        InitializeComponent()
    End Sub

#End Region

#Region " Constants "
    Protected Const ACTION_SAVE As String = "SAVE"
    Private Const MODE_APPROVE As String = "APPROVE"
    Private Const MODE_REJECT As String = "REJECT"
    Private Const MODE_LEAVE_SHOWCOMMENTS As String = "SHOW_LEAVE_COMMENTS"
    Private Const MODE_CLOSE_REQUEST As String = "CLOSEREQUEST"
    Private Const MODE_REJECT_REQUEST As String = "REJECT_REQUEST"
    Private Const MODE_SHOWCOMMENTS As String = "SHOW_COMMENTS"
    Private Const MODE_REJECT_RESOURCE As String = "REJECT_RESOURCE"
    Private Const MODE_REJECT_RESOURCE_VIEW_COMMENTS As String = "REJECT_RESOURCE_VIEW"
#End Region

#Region " Variable Declaretions "
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_arrMenuItem(2) As String
    Private m_arrMenuTooltip(2) As String
    Private m_arrClientSideFunctions(2) As String

    Protected m_strMode As String = ""
    Protected m_strClientSideScript As String = ""
    Protected m_lngLeaveId As Long = 0
    Protected m_lngRequestID As Long = 0
    Protected m_lngEmployeeID As Long = 0
    Private m_strAction As String = ""
    Protected m_strEmployeeIDs As String = ""
    Protected m_FromWhere As String
    ' Following variable is used to check whether the Employee to reject is the first employee or not
    ' As this is required to ask for the confirmation whether to apply the comments to all the selected resources
    ' or only for the current employee in process.
    Protected m_blnFirstEmployee As Boolean = False
    ' Protected m_PageTitle As String = "Add Comments" 'MyBase.GetResourceString("ADD_COMMENTS")
    'Added By AratiS On 19-Feb-2010 For RequestID-24339
    Protected m_intFlag As Integer
#End Region

    Public Sub PageInit()
        Dim strMenu As String = ""
        Dim strComments As String = ""
        Dim strQuery As String = ""
        Dim lngLeaveStatusID As Long = 0
        Dim lngUserID As Long = 0
        'Added by TruptiK on 22-Jan-2008
        'Purpose:-For prepone Release
        Dim flag As Integer
        flag = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("Flag"), "0"), Integer)
        'Added By AratiS On 19-Feb-2010 For RequestID-24339
        m_intFlag = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("Flag"), "0"), Integer)
        'End of addition by TruptiK on 22-Jan-2008
        m_FromWhere = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("From"), ""), String)
        m_strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("Action")).ToUpper()
        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode")).ToUpper()
        m_lngLeaveId = CType(CommonFunctions.General.CheckIsNothing("0" & Request.QueryString("LeaveID"), "0"), Long)
        m_lngRequestID = CType(CommonFunctions.General.CheckIsNothing("0" & Request.QueryString("RequestID"), "0"), Long)
        m_strEmployeeIDs = CommonFunctions.General.CheckIsNothing("" & Request.QueryString("EmployeeIDs"), "")
        m_strEmployeeIDs = m_strEmployeeIDs.Trim()
        m_lngEmployeeID = CType(CommonFunctions.General.CheckIsNothing("0" & Request.QueryString("EmployeeID"), "0"), Long)

        If m_strAction = ACTION_SAVE Then
            strComments = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtComments"))
            strComments = CommonFunctions.General.UnBuildQueryString(strComments)

            Select Case m_strMode

                Case MODE_APPROVE
                    lngLeaveStatusID = 2
                    lngUserID = CType(CommonFunctions.General.CheckIsNothing(Session.Item("intUserID"), "0"), Long)

                    strQuery = "usp_Upd_tbl_PM_EmployeeLeaveDetails_AND_Master " & m_lngLeaveId.ToString()
                    strQuery &= ", " & lngLeaveStatusID.ToString()
                    strQuery &= ", " & lngUserID.ToString()
                    strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strComments) & "'"

                    CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                    SendMails()

                Case MODE_REJECT
                    lngLeaveStatusID = 3
                    lngUserID = CType(CommonFunctions.General.CheckIsNothing(Session.Item("intUserID"), "0"), Long)

                    strQuery = "usp_Upd_tbl_PM_EmployeeLeaveDetails_AND_Master " & m_lngLeaveId.ToString()
                    strQuery &= ", " & lngLeaveStatusID.ToString()
                    strQuery &= ", " & lngUserID.ToString()
                    strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strComments) & "'"

                    CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                    SendMails()

                    'Case MODE_CLOSE_REQUEST
                    '    strQuery = "usp_Upd_tbl_PM_ResourceRequest " & m_lngRequestID.ToString
                    '    strQuery += ", '" & CommonFunction.General.BuildQueryString(strComments) & "'"
                    '    strQuery += ", 'C'"
                    '    CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                    '    m_strClientSideScript = "window.opener.location = ""../General/CommonList.aspx?FromWhere=PM&MasterTagId=" & CommonFunction.Constants.APP_TAG_RESOURCEREQUEST & """;" & vbCrLf
                    '    m_strClientSideScript &= "window.close();"
                    '    CommonFunctions.General.WriteHTML(m_strClientSideScript)

                Case MODE_REJECT_REQUEST
                    strQuery = "Exec usp_Upd_tbl_PM_ResourceRequest_RejectRequest " & m_lngRequestID.ToString
                    strQuery += ", '" & CommonFunction.General.BuildQueryString(strComments) & "'"
                    CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                    'Commented By AratiS on 18-Feb-2010 For RequestID-24399
                    '''Added by TruptiK on 22-Jan-2008
                    '''Purpose:-For prepone Release
                    ''If flag = 1 Then
                    ''    m_strClientSideScript = "RefreshParent();" & vbCrLf
                    ''    m_strClientSideScript &= "window.close();" + vbCrLf
                    ''    'm_strClientSideScript &= "window.opener.location=window.opener.location;" & vbCrLf
                    ''    m_strClientSideScript &= "window.open(""../General/SendEmail.aspx?MessageID=500&RequestID=" & m_lngRequestID.ToString
                    ''    m_strClientSideScript &= """ ,'',"
                    ''    m_strClientSideScript &= "'resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left='"
                    ''    m_strClientSideScript &= " + (window.screen.width - 600)/2 + ',top='"
                    ''    m_strClientSideScript &= " + (window.screen.height - 500)/2 + ',width=600,height=500')" & vbCrLf
                    ''ElseIf flag = 2 Then
                    ''    m_strClientSideScript = "RefreshParent();" & vbCrLf
                    ''    m_strClientSideScript &= "window.close();" + vbCrLf
                    ''    'm_strClientSideScript &= "window.opener.location=window.opener.location;" & vbCrLf
                    ''    m_strClientSideScript &= "window.open(""../General/SendEmail.aspx?MessageID=501&RequestID=" & m_lngRequestID.ToString
                    ''    m_strClientSideScript &= """ ,'',"
                    ''    m_strClientSideScript &= "'resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left='"
                    ''    m_strClientSideScript &= " + (window.screen.width - 600)/2 + ',top='"
                    ''    m_strClientSideScript &= " + (window.screen.height - 500)/2 + ',width=600,height=500')" & vbCrLf
                    ''    'added by Sanas on 8-Sep-09 for Rejection of Change Allocation request
                    ''ElseIf flag = 3 Then
                    ''    m_strClientSideScript = "RefreshParent();" & vbCrLf
                    ''    m_strClientSideScript &= "window.close();" + vbCrLf
                    ''    'm_strClientSideScript &= "window.opener.location=window.opener.location;" & vbCrLf
                    ''    m_strClientSideScript &= "window.open(""../General/SendEmail.aspx?MessageID=542&RequestID=" & m_lngRequestID.ToString
                    ''    m_strClientSideScript &= """ ,'',"
                    ''    m_strClientSideScript &= "'resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left='"
                    ''    m_strClientSideScript &= " + (window.screen.width - 600)/2 + ',top='"
                    ''    m_strClientSideScript &= " + (window.screen.height - 500)/2 + ',width=600,height=500')" & vbCrLf
                    ''    'End addition by Sanas on 8-Sep-09 for Rejection of Change Allocation request
                    ''    'Else
                    ''    '    m_strClientSideScript = "RefreshParent();" & vbCrLf
                    ''End If
                    '''End of addition by TruptiK
                    '''m_strClientSideScript = "RefreshParent();" & vbCrLf
                    'End:Commented By AratiS on 18-Feb-2010 For RequestID-24399

                    'Added By AratiS on 18-Feb-2010 For RequestID-24399
                    If flag = 1 Or flag = 2 Or flag = 3 Then
                        SendMails()
                    End If
                    'End:Added By AratiS on 18-Feb-2010 For RequestID-24399

                Case MODE_REJECT_RESOURCE
                    Dim blnApplyAll As Boolean = False
                    Dim intIndex As Integer = 0

                    blnApplyAll = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ApplyAll"), "False"), Boolean)
                    If blnApplyAll = True Then
                        While m_lngEmployeeID <> 0
                            strQuery = "Exec usp_Upd_RejectResource " & m_lngEmployeeID.ToString
                            strQuery += ", " & m_lngRequestID.ToString()
                            strQuery += ", '" & CommonFunction.General.BuildQueryString(strComments) & "'"
                            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                            SendMails()
                            If m_strEmployeeIDs <> "" Then
                                intIndex = InStr(m_strEmployeeIDs, ",")
                                If intIndex = 0 Then
                                    m_lngEmployeeID = CType(m_strEmployeeIDs, Long)
                                    m_strEmployeeIDs = ""
                                Else
                                    m_lngEmployeeID = CType(Left(m_strEmployeeIDs, intIndex), Long)
                                    m_strEmployeeIDs = Mid(m_strEmployeeIDs, intIndex + 1, Len(m_strEmployeeIDs))
                                End If
                            Else
                                m_lngEmployeeID = 0
                            End If
                        End While
                    Else
                        strQuery = "Exec usp_Upd_RejectResource " & m_lngEmployeeID.ToString
                        strQuery += ", " & m_lngRequestID.ToString()
                        strQuery += ", '" & CommonFunction.General.BuildQueryString(strComments) & "'"
                        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                        SendMails()

                        If m_strEmployeeIDs <> "" Then
                            ShowCommentsField()
                        End If
                    End If
            End Select
        Else
            m_blnFirstEmployee = True
            ShowCommentsField()
        End If
        'If m_strMode = MODE_SHOWCOMMENTS Then
        '    m_PageTitle = MyBase.GetResourceString("VIEW_COMMNETS")
        'End If
    End Sub

    Private Sub ShowCommentsField()
        Dim strMenu As String = ""
        Dim strComments As String = ""
        Dim intIndex As Integer = 0
        Dim lngCommentsLength As Long = 1000

        Dim strQuery As String = ""
        Dim drResourceDetails As IDataReader
        Dim strEmployeeName As String = ""
        Dim strAssignmentDate As String = ""
        Dim strFromDate As String = ""
        Dim strToDate As String = ""
        Dim dblWorkHours As Double = 0

        If m_strMode = MODE_CLOSE_REQUEST Or m_strMode = MODE_REJECT_REQUEST Or m_strMode = MODE_REJECT_RESOURCE Then
            lngCommentsLength = 1700
        End If

        strMenu = GetPageMenuString()   ' Get the string of HTML for Menu 
        strComments = GetComments() 'Get the Comments

        'Display Menu
        CommonFunctions.General.WriteHTML(strMenu)

        'Display Page Legend
        WritePageLegend()

        'Display Page Body
        CommonFunctions.General.WriteHTML("<DIV ID='PageDiv' Style='Overflow:auto'>")

        If m_strMode = MODE_REJECT_RESOURCE Then
            intIndex = InStr(m_strEmployeeIDs, ",")
            If intIndex = 0 Then
                m_lngEmployeeID = CType(m_strEmployeeIDs, Long)
                m_strEmployeeIDs = ""
            Else
                m_lngEmployeeID = CType(Left(m_strEmployeeIDs, intIndex), Long)
                m_strEmployeeIDs = Mid(m_strEmployeeIDs, intIndex + 1, Len(m_strEmployeeIDs))
            End If
            'Do not show message if the Selected employee is only one.
            If m_blnFirstEmployee = True And m_strEmployeeIDs = "" Then m_blnFirstEmployee = False

            'Get the Resource Details
            strQuery = "Exec usp_Sel_tbl_PM_AssignedResources " & m_lngRequestID.ToString()
            strQuery &= ", " & m_lngEmployeeID.ToString()
            drResourceDetails = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drResourceDetails, "") <> "" Then
                If drResourceDetails.Read() Then
                    strEmployeeName = CommonFunctions.General.CheckIsNothing(drResourceDetails.Item("EmployeeName"), "")
                    strEmployeeName = CommonFunctions.General.UnBuildQueryString(strEmployeeName)
                    strAssignmentDate = CommonFunctions.General.UnBuildQueryString(drResourceDetails.Item("AssignmentDate").ToString())
                    strAssignmentDate = CommonFunctions.Dates.GetDate(CType(strAssignmentDate, Date))
                    strFromDate = CommonFunctions.General.UnBuildQueryString(drResourceDetails.Item("FromDate").ToString())
                    strFromDate = CommonFunctions.Dates.GetDate(CType(strFromDate, Date))
                    strToDate = CommonFunctions.General.UnBuildQueryString(drResourceDetails.Item("ToDate").ToString())
                    strToDate = CommonFunctions.Dates.GetDate(CType(strToDate, Date))
                    dblWorkHours = CType(CommonFunctions.Data.CheckIsDBNull(drResourceDetails.Item("WorkHours"), "0"), Double)

                    CommonFunctions.General.WriteHTML("<Table Class='clsTable' cellpadding=0 cellspacing=0 width=99.9%>")
                    CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD align='right' width='50%'>")
                    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("EMPLOYEENAME") & " : ")
                    CommonFunctions.General.WriteHTML("</TD><TD align='left' width='50%'>")
                    CommonFunctions.General.WriteHTML(strEmployeeName)
                    CommonFunctions.General.WriteHTML("</TD></TR>")

                    CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD align='right' width='50%'>")
                    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("ASSIGNMENT_DATE") & " : ")
                    CommonFunctions.General.WriteHTML("</TD><TD align='left' width='50%'>")
                    CommonFunctions.General.WriteHTML(strAssignmentDate)
                    CommonFunctions.General.WriteHTML("</TD></TR>")

                    CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD align='right' width='50%'>")
                    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("FROM_DATE") & " : ")
                    CommonFunctions.General.WriteHTML("</TD><TD align='left' width='50%'>")
                    CommonFunctions.General.WriteHTML(strFromDate)
                    CommonFunctions.General.WriteHTML("</TD></TR>")

                    CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD align='right' width='50%'>")
                    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("TO_DATE") & " : ")
                    CommonFunctions.General.WriteHTML("</TD><TD align='left' width='50%'>")
                    CommonFunctions.General.WriteHTML(strToDate)
                    CommonFunctions.General.WriteHTML("</TD></TR>")

                    CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD align='right' width='50%'>")
                    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("WORK_HOURS") & " : ")
                    CommonFunctions.General.WriteHTML("</TD><TD align='left' width='50%'>")
                    CommonFunctions.General.WriteHTML(FormatNumber(dblWorkHours, 2))
                    CommonFunctions.General.WriteHTML("</TD></TR>")

                    CommonFunctions.General.WriteHTML("</Table>")
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drResourceDetails)
        End If

        CommonFunctions.General.WriteHTML("<Table Class='clsTable' cellpadding=0 cellspacing=0 width=99.9%>")
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD valign='top'>")
        If m_strMode = MODE_APPROVE Then
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("APPROVAL_COMMENTS"))
        ElseIf m_strMode = MODE_REJECT Then
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("REJECT_COMMENTS"))
        Else
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("COMMENTS"))
        End If
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("<TD valign='top'>")

        'Modified By VarunA on 25-Apr-2007 Issue-12828 Whizible Regression Project
        'Purpose : To have caption as "Enter Comments" instead of "Enter txtComments" 
        'CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", , , , "frmHR_AddComments", , , 400, 150, lngCommentsLength, strComments, IsMandatory:=True)
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmHR_AddComments", , , 400, 150, lngCommentsLength, strComments, IsMandatory:=True)
        CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmHR_AddComments", , , 400, 150, lngCommentsLength, strComments, IsMandatory:=True, EnableHTMLEncode:=True)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'End By VarunA on 25-Apr-2007 

        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</Table>")
        CommonFunctions.General.WriteHTML("</DIV>")

        'Display Page Menu at bottom
        CommonFunctions.General.WriteHTML(strMenu)
    End Sub

    Private Function GetPageMenuString() As String
        Dim strMenu As String = ""

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        If m_strMode = MODE_APPROVE Then
            m_arrMenuItem(0) = MyBase.GetResourceString("MENU_APPROVE")
            m_arrMenuTooltip(0) = MyBase.GetResourceString("MENU_APPROVE_TOOLTIP")
            m_arrClientSideFunctions(0) = "MenuLink_OnClick()"
        ElseIf m_strMode = MODE_REJECT Then
            m_arrMenuItem(0) = MyBase.GetResourceString("MENU_REJECT")
            m_arrMenuTooltip(0) = MyBase.GetResourceString("MENU_REJECT_TOOLTIP")
            m_arrClientSideFunctions(0) = "MenuLink_OnClick()"
        ElseIf m_strMode = MODE_LEAVE_SHOWCOMMENTS Then      'Dummy Menu Link
            m_arrMenuItem(0) = ""
            m_arrMenuTooltip(0) = ""
            m_arrClientSideFunctions(0) = ""
        ElseIf m_strMode = MODE_CLOSE_REQUEST Or m_strMode = MODE_SHOWCOMMENTS Then
            m_arrMenuItem(0) = MyBase.GetResourceString("MENU_CLOSE_REQUEST")
            m_arrMenuTooltip(0) = MyBase.GetResourceString("MENU_CLOSE_REQUEST_TOOLTIP")
            m_arrClientSideFunctions(0) = "CloseRequestLink_OnClick()"
        ElseIf m_strMode = MODE_REJECT_REQUEST Then
            m_arrMenuItem(0) = MyBase.GetResourceString("MENU_DECLINE_REQUEST")
            m_arrMenuTooltip(0) = MyBase.GetResourceString("MENU_DECLINE_REQUEST_TOOLTIP")
            m_arrClientSideFunctions(0) = "RejectRequest_OnClick()"
        ElseIf m_strMode = MODE_REJECT_RESOURCE Or m_strMode = MODE_REJECT_RESOURCE_VIEW_COMMENTS Then
            m_arrMenuItem(0) = MyBase.GetResourceString("MENU_REJECT_RESOURCE")
            m_arrMenuTooltip(0) = MyBase.GetResourceString("MENU_REJECT_RESOURCE_TOOLTIP")
            m_arrClientSideFunctions(0) = "RejectResource_OnClick()"
        End If

        m_arrMenuItem(1) = MyBase.GetResourceString("MENU_CLOSE")
        m_arrMenuTooltip(1) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        m_arrClientSideFunctions(1) = "Close_OnClick()"

        m_arrMenuItem(2) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(2) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        ' added by harshada d for adding helpid for this page whiziblesem 6
        'm_arrClientSideFunctions(2) = "Help_OnClick(" & CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEDETAILS & ")"
        m_arrClientSideFunctions(2) = "Help_OnClick('HR_ADDCOMMENTS')"
        ' added by harshada d for adding helpid for this page whiziblesem 6
        MyBase.InitializeResources("AppResources.HR_AddComments", "AppResources")

        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
        m_objMenu = Nothing

        Return (strMenu)
    End Function

    Private Sub WritePageLegend()
        Dim arrLegends(0) As String
        Dim arrLegendImg(0) As String
        arrLegends(0) = "&nbsp;" & MyBase.GetResourceString("MANDATORY")
        arrLegendImg(0) = CommonFunctions.HTMLControls.DrawMandatoryImage(, True)
        CommonFunctions.General.WriteHTML(WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImg, arrLegends, True))
    End Sub

    Private Sub SendMails()
        '==================================================================================
        ' Procedure Name	:	SendMails
        ' Purpose			:	This procedure Fetches the Two Flags related to Email messages from Database. 
        '                       and depending upon them send emails.
        ' Description		:	The Flags are 'Send Mails' and 'Show Popup'.
        '                       These falgs are used to send the mails. And also to show the 
        '                       'Send Mail' Menu link. If Show Popup is false then mail is sent silently 
        '                       else popup opens.
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Jayavant
        ' Created			:	5-April-2004
        ' Revisions			:	
        '==================================================================================
        Dim strQuery As String = ""
        Dim intMessageID As Integer = 0
        Dim drEmail As IDataReader
        Dim blnSendMail As Boolean = False
        Dim blnShowPopup As Boolean = False
        Dim strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage As String

        If m_strMode = MODE_APPROVE Then
            intMessageID = 69
        ElseIf m_strMode = MODE_REJECT Then
            intMessageID = 70
        ElseIf m_strMode = MODE_REJECT_RESOURCE Then
            intMessageID = 203
            'Added By AratiS on 19-Feb-2010 For RequestID-24339
        ElseIf m_strMode = MODE_REJECT_REQUEST Then
            If m_intFlag = 1 Then
                intMessageID = 500
            ElseIf m_intFlag = 2 Then
                intMessageID = 501
            ElseIf m_intFlag = 3 Then
                intMessageID = 542
            End If
            'End:Added By AratiS on 19-Feb-2010 For RequestID-24339
        End If

        strQuery = "usp_Sel_tbl_PM_EmailMessages " & intMessageID.ToString()
        drEmail = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drEmail) <> "" Then
            If drEmail.Read() Then
                blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("SendMail"), "False"), Boolean)
                blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("ShowPopup"), "False"), Boolean)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drEmail)

        If m_strMode = MODE_APPROVE Or m_strMode = MODE_REJECT Then
            If blnSendMail = True Then
                If blnShowPopup = False Then
                    If intMessageID = 69 Then
                        CommonFunction.EmailMessages.PMMessages.GetEmailMessage_69(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, m_lngLeaveId)
                    ElseIf intMessageID = 70 Then
                        CommonFunction.EmailMessages.PMMessages.GetEmailMessage_70(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, m_lngLeaveId)
                    End If
                    CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                    ''Modified by MnaishK on 6th Feb 2006 as inherited page is added for this page
                    ' m_strClientSideScript = "window.opener.location = ""../General/CommonList.aspx?FromWhere=RM&MasterTagId=" & CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEDETAILS & """;" & vbCrLf
                    m_strClientSideScript = "window.opener.location = ""../HR/EmployeeLeaves_CommonList.aspx?FromWhere=RM&MasterTagId=" & CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEDETAILS & """;" & vbCrLf
                    ''End of Modified by MnaishK on 6th Feb 2006 as inherited page is added for this page
                    m_strClientSideScript &= "window.close();"
                Else
                    m_strClientSideScript = "window.open(""../General/SendEmail.aspx?MessageID=" & intMessageID.ToString()
                    m_strClientSideScript &= "&LeaveID=" & m_lngLeaveId.ToString()
                    m_strClientSideScript &= ""","""",""resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left="" "
                    m_strClientSideScript &= "+ (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"""
                    m_strClientSideScript &= ");" & vbCrLf
                    ''Modified by MnaishK on 6th Feb 2006 as inherited page is added for this page
                    ' m_strClientSideScript = "window.opener.location = ""../General/CommonList.aspx?FromWhere=RM&MasterTagId=" & CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEDETAILS & """;" & vbCrLf
                    m_strClientSideScript &= "window.opener.location = ""../HR/EmployeeLeaves_CommonList.aspx?FromWhere=RM&MasterTagId=" & CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEDETAILS & """;" & vbCrLf
                    ''End of Modified by MnaishK on 6th Feb 2006 as inherited page is added for this page
                    m_strClientSideScript &= "window.close();"
                End If
            Else
                'Added by VidyaJ - SP8 Regression
                m_strClientSideScript = "window.opener.location = ""../HR/EmployeeLeaves_CommonList.aspx?FromWhere=RM&MasterTagId=" & CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEDETAILS & """;" & vbCrLf
                ''End of Modified by MnaishK on 6th Feb 2006 as inherited page is added for this page
                m_strClientSideScript &= "window.close();"

            End If
        ElseIf m_strMode = MODE_REJECT_RESOURCE Then
            If blnSendMail = True Then
                If blnShowPopup = False Then
                    CommonFunction.EmailMessages.PMMessages.GetEmailMessage_203(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, m_lngEmployeeID, m_lngRequestID)
                    CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                    If m_strEmployeeIDs = "" Then
                        'm_strClientSideScript = "refreshParent('" & Whizible.CommonPage.FORM_NAME & "','CommonPage.aspx','CommonPage.aspx?FocusOn=" & Whizible.CommonPage.FocusOn_SUBTAG & "',true);" & vbCrLf
                        m_strClientSideScript = "refreshParent('frmCommonPage','CommonPage.aspx','CommonPage.aspx?FocusOn=SUBTAG',true);" & vbCrLf
                        m_strClientSideScript &= "window.close();"
                    End If
                Else
                    m_strClientSideScript &= "window.open(""../General/SendEmail.aspx?MessageID=" & intMessageID.ToString()
                    m_strClientSideScript &= "&EmployeeID=" & m_lngEmployeeID.ToString()
                    m_strClientSideScript &= "&RequestID=" & m_lngRequestID.ToString()
                    m_strClientSideScript &= ""","""",""resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left="" "
                    m_strClientSideScript &= "+ (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"""
                    m_strClientSideScript &= ");" & vbCrLf
                    If m_strEmployeeIDs = "" Then
                        m_strClientSideScript &= "refreshParent('frmCommonPage','CommonPage.aspx','CommonPage.aspx?FocusOn=SUBTAG',true);" & vbCrLf
                        m_strClientSideScript &= "window.close();"
                    End If
                End If
            Else
                'Added by VidyaJ - SP8 Regression
                If m_strEmployeeIDs = "" Then
                    'm_strClientSideScript = "refreshParent('" & Whizible.CommonPage.FORM_NAME & "','CommonPage.aspx','CommonPage.aspx?FocusOn=" & Whizible.CommonPage.FocusOn_SUBTAG & "',true);" & vbCrLf
                    m_strClientSideScript = "refreshParent('frmCommonPage','CommonPage.aspx','CommonPage.aspx?FocusOn=SUBTAG',true);" & vbCrLf
                    m_strClientSideScript &= "window.close();"
                End If
            End If
            'Added by aratis on 18-Feb-2010 For RequestID-24399
        ElseIf m_strMode = MODE_REJECT_REQUEST Then
            If m_intFlag = 1 Then
                If blnSendMail = True Then
                    If blnShowPopup = True Then
                        m_strClientSideScript = "RefreshParent();" & vbCrLf
                        m_strClientSideScript &= "window.close();" + vbCrLf
                        m_strClientSideScript &= "window.open(""../General/SendEmail.aspx?MessageID=" & intMessageID.ToString()
                        m_strClientSideScript &= "&RequestID=" & m_lngRequestID.ToString()
                        m_strClientSideScript &= ""","""",""resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left="" "
                        m_strClientSideScript &= "+ (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"""
                        m_strClientSideScript &= ");" & vbCrLf
                        'CommonFunctions.General.WriteHTML(m_strClientSideScript.ToString)
                    Else
                        CommonFunction.EmailMessages.PMMessages.GetEmailMessage_500(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, m_lngRequestID)
                        CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                    End If
                End If
            ElseIf m_intFlag = 2 Then
                If blnSendMail = True Then
                    If blnShowPopup = True Then
                        m_strClientSideScript = "RefreshParent();" & vbCrLf
                        m_strClientSideScript &= "window.close();" + vbCrLf
                        m_strClientSideScript &= "window.open(""../General/SendEmail.aspx?MessageID=" & intMessageID.ToString()
                        m_strClientSideScript &= "&RequestID=" & m_lngRequestID.ToString()
                        m_strClientSideScript &= ""","""",""resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left="" "
                        m_strClientSideScript &= "+ (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"""
                        m_strClientSideScript &= ");" & vbCrLf
                        'CommonFunctions.General.WriteHTML(m_strClientSideScript.ToString)
                    Else
                        CommonFunction.EmailMessages.PMMessages.GetEmailMessage_501(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, m_lngRequestID)
                        CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                    End If
                End If
            ElseIf m_intFlag = 3 Then
                If blnSendMail = True Then
                    If blnShowPopup = True Then
                        m_strClientSideScript = "RefreshParent();" & vbCrLf
                        m_strClientSideScript &= "window.close();" + vbCrLf
                        m_strClientSideScript &= "window.open(""../General/SendEmail.aspx?MessageID=" & intMessageID.ToString()
                        m_strClientSideScript &= "&RequestID=" & m_lngRequestID.ToString()
                        m_strClientSideScript &= ""","""",""resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left="" "
                        m_strClientSideScript &= "+ (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"""
                        m_strClientSideScript &= ");" & vbCrLf
                        'CommonFunctions.General.WriteHTML(m_strClientSideScript.ToString)
                    Else
                        CommonFunction.EmailMessages.PMMessages.GetEmailMessage_542(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, m_lngRequestID)
                        CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                    End If
                End If
            End If
            'End:Added by aratis on 18-Feb-2010 For RequestID-24399
        End If
    End Sub

    Private Function GetComments() As String
        '==================================================================================
        ' Procedure Name	:	GetComments
        ' Purpose			:	
        ' Description		:	The function fetches the comments against from the database.
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Jayavant
        ' Created			:	15-April-2004
        ' Revisions			:	
        '==================================================================================
        Dim strReturn As String = ""
        Dim strQuery As String = ""
        Dim strRequestType As String = ""
        Dim lngAssignmentID As Long = 0

        If m_strMode = MODE_SHOWCOMMENTS Then
            strRequestType = CommonFunctions.General.CheckIsNothing(Request.QueryString("RequestType")).ToString()
            strQuery = "EXEC usp_Sel_tbl_PM_ResourceRequest_Comments " & m_lngRequestID.ToString()
            strQuery &= ",'" & strRequestType & "'"

            strReturn = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL))
            strReturn = CommonFunctions.General.UnBuildQueryString(strReturn)
        ElseIf m_strMode = MODE_REJECT_RESOURCE_VIEW_COMMENTS Then
            lngAssignmentID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("AssignmentID")), Long)
            strQuery = "Exec usp_Sel_tbl_PM_AssignedResources_GetRejectComments " & lngAssignmentID.ToString()

            strReturn = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL))
            strReturn = CommonFunctions.General.UnBuildQueryString(strReturn)
        ElseIf m_strMode = MODE_LEAVE_SHOWCOMMENTS Then
            ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
            ''strQuery = "SELECT Comments FROM tbl_PM_EmployeeLeaveDetails WHERE LeaveID = " & m_lngLeaveId.ToString()
            strQuery = "usp_sel_tbl_PM_EmployeeLeaveDetails_comment " & m_lngLeaveId.ToString()
            ''End of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
            strReturn = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL))
            strReturn = CommonFunctions.General.UnBuildQueryString(strReturn)
        Else
            strReturn = ""
        End If

        Return strReturn
    End Function

    Public Sub New()
        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        MyBase.InitializeResources("AppResources.HR_AddComments", "AppResources")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        If m_strMode = MODE_SHOWCOMMENTS Or m_strMode = MODE_REJECT_RESOURCE_VIEW_COMMENTS Or _
            m_strMode = MODE_LEAVE_SHOWCOMMENTS Then
            If Args.MenuColIndex = 0 Then
                Cancel = True
            End If
        End If
    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objMenu = Nothing
    End Sub
End Class
