Imports CommonFunctions
Imports System.IO

Partial Public Class EmailApproval 'EmailApprover
    Inherits WebPages.Template.WhizTemplate

    Protected m_strMode As String = ""
    Protected m_strAction As String = ""
    Protected m_lngMessageID As Long = 0
    Protected m_strGUID As String = ""
    Protected strComments As String = ""
    Protected m_strWindowTitle As String = ""
    Dim arrMenu As System.Collections.ArrayList
    Dim arrMenuToolTip As System.Collections.ArrayList
    Dim arrClientSideFunctions As System.Collections.ArrayList
    Dim strMenu As String
    Dim objHeader As WebPage.Templates.HeaderFooter
    Protected m_strClientSideScript As String = ""
    Dim strHTML As New StringBuilder
    'Dim Response As StreamWriter = New StreamWriter(HttpContext.Current.Response.OutputStream)
    Dim Response As New StreamWriter(HttpContext.Current.Response.OutputStream)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        'set the window title 
        m_strWindowTitle = "Email Approval"
        PageInit()
    End Sub

    Public Sub PageInit()
        Initialization()
        '        If m_strMode = "EMAIL" Then
        Dim m_strPKValue As String
        Dim m_strApproverID As String
        Dim m_strApproverEmailID As String
        Dim m_strUserId As String
        Dim m_strEmployeeID As String
        Dim m_strUserName As String
        Dim m_strEntityName As String = ""
        Dim strWhatHappens As String = ""
        Dim m_strActionTaken As String = ""
        Dim m_intActionCount As Integer
        Dim m_blnstatus As Boolean = False
        Dim m_strleavingDate As String = ""
        Dim blnHasAlreadyDone As Boolean = False

        Dim SQLString As String = ""
        Dim dataReader As IDataReader
        Dim m_objGlobalObject As WebPages.Template.IGlobal

        'Generates the Menu
        strMenu = GenerateMenu()

        SQLString = "usp_Sel_tbl_EmailApprovers_Employee '" + m_strGUID + "'"
        dataReader = CommonFunctions.Data.GetDataReader(SQLString, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If dataReader.Read() Then
            m_strApproverEmailID = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dataReader("ApproverEmailID")).ToString, "").ToString
            m_strApproverID = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dataReader("ApproverID")).ToString, "").ToString
            m_strPKValue = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dataReader("PrimaryKeyValue")).ToString, "").ToString
            m_strUserId = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dataReader("UserID")).ToString, "").ToString
            m_strEmployeeID = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dataReader("EmployeeID")).ToString, "").ToString
            m_strUserName = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dataReader("UserName")).ToString, "").ToString
            m_strEntityName = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dataReader("EntityName")).ToString, "").ToString
            m_intActionCount = CType(dataReader("ActionTaken"), Integer)
            m_strActionTaken = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dataReader("Action")).ToString, "").ToString
            m_blnstatus = CType(dataReader("status"), Boolean)
            m_strleavingDate = CommonFunctions.Data.CheckIsDBNull(dataReader("LeavingDate").ToString, "")


            If m_intActionCount <> 0 Then
                blnHasAlreadyDone = True
            End If

            If (Not m_blnstatus) Or (m_strleavingDate <> "") Then
                MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
                m_objGlobalObject = MyBase.GlobalObject
                m_objGlobalObject.IsCustomerCreated = False
                m_objGlobalObject.LCID = 1033
                m_objGlobalObject.LoginID = CInt(m_strEmployeeID)
                m_objGlobalObject.LoginType = "E"
                m_objGlobalObject.ParentTagID = 0
                m_objGlobalObject.ProjectID = CInt(m_strPKValue)
                m_objGlobalObject.returnHTML = False
                m_objGlobalObject.RoleID = 1
                m_objGlobalObject.RoleLevel = 1
                m_objGlobalObject.TagID = 32
                m_objGlobalObject.UseHashTable = "Y"
                m_objGlobalObject.UserID = CInt(m_strApproverID)
                m_objGlobalObject.UserName = m_strUserName

                If Not blnHasAlreadyDone Then
                    Dim strSQL As String = "usp_ins_upd_tbl_EmailApprovers '" + m_strApproverEmailID + "',"
                    strSQL += "'" + m_strAction + "',"
                    strSQL += "1,"
                    strSQL += m_strPKValue + ","
                    strSQL += "'" + m_strGUID + "'"
                    Try
                        CommonFunction.Data.InsertOrUpdateData(strSQL, True)
                        Dim strSQLL As String = ""
                        strComments = m_strAction
                        Select Case m_strAction.ToUpper
                            Case "APPROVE"
                                Select Case m_strEntityName.ToUpper
                                    Case "LEAVE"
                                        'Leave Approve
                                        'strSQLL = "usp_Upd_tbl_PM_EmployeeLeaveDetails_AND_Master " + m_strPKValue
                                        strSQLL = "usp_Upd_tbl_PM_EmployeeLeaveDetails_AND_Master_ViaEmail " + m_strPKValue
                                        strSQLL &= ", 2"
                                        strSQLL &= ", " + m_strApproverID
                                        strSQLL &= ", '" + CommonFunctions.General.BuildQueryString("Approved") & "'"
                                        CommonFunction.Data.InsertOrUpdateData(strSQLL, True)
                                        strSQLL = ""
                                        strWhatHappens = "Leave has been approved."
                                        Response.Write(strWhatHappens)
                                        GetDetails(m_strPKValue, m_strEntityName)
                                        'For dependent Mail
                                        'SendMails(CommonFunction.General.DecryptString(m_strAction), CInt(m_strPKValue))
                                    Case "PROJECT"
                                        'Project Approve
                                        CommonFunction.WhizibleWorkflow.UpdateWhizibleWorkflowData(m_objGlobalObject, m_strPKValue, "SYS_APPROVE", "32", FromWhere:="E")
                                        strWhatHappens = "Project has been approved."
                                        Response.Write(strWhatHappens)
                                    Case "PROJECTAPPROVALBYOLD"
                                        Dim strSQLQuery As String
                                        Dim intRevisionReasonID As Integer
                                        strSQLQuery = "EXEC usp_Ins_tbl_PM_Project_BaselineRevisionReason " + m_strPKValue + ",'" + CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing("Approved")) + "'," + "'" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(m_strUserName, "")) + "','A'"
                                        intRevisionReasonID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0"), Integer)
                                        strWhatHappens = "Project has been approved."
                                        Response.Write(strWhatHappens)
                                End Select
                            Case "REJECT"
                                Select Case m_strEntityName.ToUpper
                                    Case "LEAVE"
                                        'Leave Reject
                                        'strSQLL = "usp_Upd_tbl_PM_EmployeeLeaveDetails_AND_Master " + m_strPKValue
                                        strSQLL = "usp_Upd_tbl_PM_EmployeeLeaveDetails_AND_Master_ViaEmail " + m_strPKValue
                                        strSQLL &= ", 3"
                                        strSQLL &= ", " + m_strApproverID
                                        strSQLL &= ", '" + CommonFunctions.General.BuildQueryString("Rejected") & "'"
                                        CommonFunction.Data.InsertOrUpdateData(strSQLL, True)
                                        strSQLL = ""
                                        strWhatHappens = "Leave has been rejected."
                                        Response.Write(strWhatHappens)
                                        GetDetails(m_strPKValue, m_strEntityName)
                                        'For dependent Mail
                                        'SendMails(CommonFunction.General.DecryptString(m_strAction), CInt(m_strPKValue))
                                    Case "PROJECT"
                                        'Project Reject
                                        CommonFunction.WhizibleWorkflow.UpdateWhizibleWorkflowData(m_objGlobalObject, m_strPKValue, "SYS_REJECT", "32", FromWhere:="E")
                                        strWhatHappens = "Project has been rejected."
                                        Response.Write(strWhatHappens)
                                    Case "PROJECTAPPROVALBYOLD"
                                        Dim strSQLQuery As String
                                        Dim intRevisionReasonID As Integer
                                        strSQLQuery = "EXEC usp_Ins_tbl_PM_ProjectBaselineRejectionReason " + m_strPKValue + ",'" + CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing("Rejected")) + "'," + "'" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(m_strUserName, "")) + "'"
                                        intRevisionReasonID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0"), Integer)
                                        strWhatHappens = "Project has been rejected."
                                        Response.Write(strWhatHappens)
                                End Select
                        End Select
                    Catch ex As Exception
                        strWhatHappens = "Error Occured while processing: " + ex.Message

                        Response.Write("Error Occured while processing: " + ex.Message)
                        Response.Close()
                        Context.Response.OutputStream.Close()
                        Exit Sub
                    End Try
                Else
                    Dim strDisplayString As String
                    Select Case m_strEntityName.ToUpper
                        Case "LEAVE"
                            strDisplayString = "Leave"
                        Case "PROJECT"
                        Case "PROJECTAPPROVALBYOLD"
                            strDisplayString = "Project"
                    End Select
                    If m_strActionTaken.ToUpper = "APPROVE" Then
                        strHTML.AppendLine(strDisplayString + " has already been approved.")
                    Else
                        strHTML.AppendLine(strDisplayString + " has already been rejected.")
                    End If
                    Response.Write(strHTML.ToString)
                End If

                'General.WriteHTML(strMenu)
                'General.WriteHTML("<BR>")
                'General.WriteHTML("<Div id='DivBody' width=100% height=90% style='Overflow: auto;'>")
                'General.WriteHTML("<Table width=99.9% class='clsTable' cellspacing=0 cellpadding=0 >")
                'General.WriteHTML("<TR class='clsTREven' >")
                'Response.Write(strHTML.ToString)
                'General.WriteHTML("</TR><Table></Div>")
                'General.WriteHTML("<BR>")
                'General.WriteHTML(strMenu)
                'strWhatHappens = ""
                'strMenu = ""
            Else
                '    'General.WriteHTML(strMenu)
                '    'General.WriteHTML("<BR>")
                '    'General.WriteHTML("<Div id='DivBody' width=100% height=90% style='Overflow: auto;'>")
                '    'General.WriteHTML("<Table width=99.9% class='clsTable' cellspacing=0 cellpadding=0 >")
                '    'General.WriteHTML("<TR class='clsTREven' >")
                Response.Write("No record exist.")
                '    'General.WriteHTML("</TR><Table></Div>")
                '    'General.WriteHTML("<BR>")
                '    'General.WriteHTML(strMenu)
                '    'strMenu = ""
            End If
        Else
            '    'General.WriteHTML(strMenu)
            '    'General.WriteHTML("<BR>")
            '    'General.WriteHTML("<Div id='DivBody' width=100% height=90% style='Overflow: auto;'>")
            '    'General.WriteHTML("<Table width=99.9% class='clsTable' cellspacing=0 cellpadding=0 >")
            '    'General.WriteHTML("<TR class='clsTREven' ><TD>")
            '    General.WriteHTML("Login for " + m_strUserName + " has been deactivated.It is not possible to perform any operation.")
            Response.Write("Login for " + m_strUserName + " has been deactivated.It is not possible to perform any operation.")
            '    'General.WriteHTML("</TD></TR><Table></Div>")
            '    'General.WriteHTML("<BR>")
            '    'General.WriteHTML(strMenu)
            '    'strMenu = ""
        End If
        Response.Close()
        HttpContext.Current.Response.OutputStream.Close()
    End Sub

    Public Sub Initialization()
        'If Request.QueryString("Mode") <> "" Then
        '    m_strMode = Request.QueryString("Mode")
        'End If
        If Request.QueryString("GUID") <> "" Then
            m_strGUID = Request.QueryString("GUID")
            'm_strAction = m_strGUID.Substring(37)
            'm_strGUID = m_strGUID.Substring(0, 36)
        End If
        If Request.QueryString("Action") <> "" Then
            m_strAction = Request.QueryString("Action")
        End If

        'If Request.QueryString("Action") <> "" Then
        '    m_strAction = Request.QueryString("Action")
        'End If

        'If Request.QueryString("MessageID") <> "" Then
        '    m_lngMessageID = Request.QueryString("MessageID")
        'End If
    End Sub

    Private Sub SendMails(ByVal strAction As String, ByVal intPKValue As Integer)
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

        If strAction.ToUpper = "APPROVE" Then
            intMessageID = 69
        ElseIf strAction.ToUpper = "REJECT" Then
            intMessageID = 70
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

        If strAction.ToUpper = "APPROVE" Or strAction.ToUpper = "REJECT" Then
            If blnSendMail = True Then
                If blnShowPopup = False Then
                    If intMessageID = 69 Then
                        CommonFunction.EmailMessages.PMMessages.GetEmailMessage_69(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, intPKValue)
                    ElseIf intMessageID = 70 Then
                        CommonFunction.EmailMessages.PMMessages.GetEmailMessage_70(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, intPKValue)
                    End If
                    CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                Else
                    m_strClientSideScript = "window.open(""../General/SendEmail.aspx?MessageID=" & intMessageID.ToString()
                    m_strClientSideScript &= "&LeaveID=" + intPKValue.ToString
                    m_strClientSideScript &= ""","""",""resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left="" "
                    m_strClientSideScript &= "+ (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"""
                    m_strClientSideScript &= ");" & vbCrLf
                End If
            End If
        End If
    End Sub

    Private Sub GetDetails(ByVal m_strPKValue As String, ByVal m_strEntityName As String)
        If m_strEntityName.ToUpper = "LEAVE" Then
            Dim drLeaveDetails As IDataReader
            drLeaveDetails = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_EmployeeLeaveDetails " + m_strPKValue, True)
            While drLeaveDetails.Read
                strHTML.AppendLine("Details are as follows - ")
                strHTML.AppendLine("</TR><TR class='clsTREven' >")
                strHTML.AppendLine("<TD align='center'>")
                strHTML.AppendLine("Employee Name: " + drLeaveDetails("EmployeeName"))
                strHTML.AppendLine("</TD></TR>")
                strHTML.AppendLine("<TR class='clsTREven' >")
                strHTML.AppendLine("<TD align='center'>")
                strHTML.AppendLine("From Date    : " + drLeaveDetails("FromDate"))
                strHTML.AppendLine("</TD></TR>")
                strHTML.AppendLine("<TR class='clsTREven' >")
                strHTML.AppendLine("<TD align='center'>")
                strHTML.AppendLine("To Date      : " + drLeaveDetails("ToDate"))
                strHTML.AppendLine("</TD>")
            End While
        End If
    End Sub

    Private Function GenerateMenu() As String
        Dim strMenuString As String = ""
        arrMenu = New System.Collections.ArrayList
        arrMenuToolTip = New System.Collections.ArrayList
        arrClientSideFunctions = New System.Collections.ArrayList

        arrMenu.Add("Close") : arrMenuToolTip.Add("Close") : arrClientSideFunctions.Add("Close_OnClick()")

        'copy all the element to string array
        Dim arrstrMenu(arrMenu.Count - 1) As String
        Dim arrstrMenuToolTip(arrMenuToolTip.Count - 1) As String
        Dim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1) As String
        arrMenu.CopyTo(arrstrMenu)
        arrMenuToolTip.CopyTo(arrstrMenuToolTip)
        arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
        arrMenu = Nothing
        arrMenuToolTip = Nothing
        arrClientSideFunctions = Nothing
        strMenuString = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
        Return strMenuString
    End Function
End Class