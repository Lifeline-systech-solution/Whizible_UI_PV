
Partial Class Mobile_LeaveApprovals
    Inherits System.Web.UI.MobileControls.MobilePage

    Private strLeaveID As String
    Private strUserID As String
    Private strMode As String

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("intUserID") Is Nothing Then
            Call LogOut()
        End If

        strMode = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "").ToString()
        strUserID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString()

        If strMode.ToLower = "logout" Then
            Call LogOut()
        End If

        Dim dsLeave As DataSet
        Dim strDecryptedString As String

        strLeaveID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Token"), "").ToString()

        Dim sym As New Encryption.Symmetric(Encryption.Symmetric.Provider.Rijndael)
        Dim key As New Encryption.Data("crazyFrogJumpsTo")
        Dim encryptedData As New Encryption.Data
        encryptedData.Base64 = strLeaveID

        Dim decrypteddata As Encryption.Data
        decrypteddata = sym.Decrypt(encryptedData, key)
        strLeaveID = HttpUtility.UrlDecode(decrypteddata.ToString)

        dsLeave = CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_EmployeeLeaveDetails_Pending_Approval " + strUserID, "TblLeave")

        'Dim drLeave As DataRow = dsLeave.Tables("0").Select("LeaveID=" + strLeaveID)(0)
        For Each drLeave As DataRow In dsLeave.Tables(0).Select("LeaveID=" + strLeaveID)
            EmployeeName.Text = "<b>Employee Name: </b>" + CommonFunctions.Data.CheckIsDBNull(drLeave("EmployeeName"), "").ToString()
            If CommonFunctions.Data.CheckIsDBNull(drLeave("FromDate"), "").ToString() <> "" Then
                FromDate.Text = "<b>From Date: </b>" + CommonFunctions.Dates.CGetDate(drLeave("FromDate"))
            Else
                FromDate.Text = "<b>From Date: </b>-"
            End If
            If CommonFunctions.Data.CheckIsDBNull(drLeave("ToDate"), "").ToString() <> "" Then
                ToDate.Text = "<b>To Date: </b>" + CommonFunctions.Dates.CGetDate(drLeave("ToDate"))
            Else
                ToDate.Text = "<b>To Date: </b>-"
            End If
            LeaveType.Text = "<b>Leave Type: </b>" + CommonFunctions.Data.CheckIsDBNull(drLeave("LeaveType"), "").ToString()
            LeaveBalance.Text = "<b>Leave Balance: </b>" + CommonFunctions.Data.CheckIsDBNull(drLeave("LeaveBalance"), "").ToString()
            IsHalfDay.Text = "<b>Is Half Day: </b>" + CommonFunctions.Data.CheckIsDBNull(drLeave("HalfDay"), "No").ToString()
        Next
        'Logout Link
        Dim objLogOut As New Web.UI.MobileControls.Link()
        Dim objLblLogout As New Web.UI.MobileControls.Label()

        'objLogOut.Text = "Logout"
        'objLogOut.ID = "LnkLogOut"
        'objLogOut.NavigateUrl = "Mobile_LeaveApprovals.aspx?Mode=Logout"
        'objLblLogout.ID = "LblLogout"
        'objLblLogout.Text = ""

        'Page.FindControl("frmLeaveApprovalEdit").Controls.Add(objLblLogout)
        'Page.FindControl("frmLeaveApprovalEdit").Controls.Add(objLogOut)
    End Sub

    Protected Sub Approve_OnClick(ByVal sender As Object, ByVal e As System.EventArgs) Handles CmdApprove.Click
        Dim strQuery As String
        Dim strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage As String
        Dim blnSendMail As Boolean
        Dim dr As IDataReader

        If Page.IsValid Then
            strQuery = "usp_Upd_tbl_PM_EmployeeLeaveDetails_AND_Master " & strLeaveID
            strQuery &= ",2"
            strQuery &= ", " & strUserID
            strQuery &= ", N'" & txtComment.Text & "'"
            CommonFunctions.Data.InsertOrUpdateData(strQuery, True)

            ' send mail
            dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 69", True)
            If dr.Read Then
                blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
            End If
            CommonFunctions.Data.DisposeDataReader(dr)

            If blnSendMail Then
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_69(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CType(strLeaveID, Integer))
                CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
            End If
            Response.Redirect("Mobile_LeaveApprovalList.aspx")
        End If
    End Sub

    Protected Sub Reject_OnClick(ByVal sender As Object, ByVal e As System.EventArgs) Handles CmdReject.Click
        Dim strQuery As String
        Dim strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage As String
        Dim blnSendMail As Boolean
        Dim dr As IDataReader

        If Page.IsValid Then
            strQuery = "usp_Upd_tbl_PM_EmployeeLeaveDetails_AND_Master " & strLeaveID
            strQuery &= ",3"
            strQuery &= ", " & strUserID
            strQuery &= ", N'" & txtComment.Text & "'"
            CommonFunctions.Data.InsertOrUpdateData(strQuery, True)

            ' send mail
            dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 70", True)
            If dr.Read Then
                blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
            End If
            CommonFunctions.Data.DisposeDataReader(dr)

            If blnSendMail Then
                'To notify requestor about rejection
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_70(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CType(strLeaveID, Integer))
                CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
            End If
            Response.Redirect("Mobile_LeaveApprovalList.aspx")
        End If
    End Sub

    Private Sub LogOut()
        Session.Abandon()
        Response.Clear()
        Response.Redirect("Login.aspx")
    End Sub

End Class


