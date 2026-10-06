
Partial Class Mobile_LeaveApprovalList
    Inherits System.Web.UI.MobileControls.MobilePage

    Dim intPageNumber As Integer = 1
    Dim intNoofRecords As Integer
    Dim intNoofRecordsPerPage As Integer = 10
    Dim strPageNo As String
    Dim arrLeaveID As New ArrayList()
    Dim strUserID As String
    Dim strUserName As String

    Private WithEvents objApproveCmd As New Web.UI.MobileControls.Command
    Private WithEvents objRejectCmd As New Web.UI.MobileControls.Command
    Dim objLbl1 As New Web.UI.MobileControls.Label
    Dim objLbl2 As New Web.UI.MobileControls.Label

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim dsLeaves As DataSet
        Dim strDetails As New StringBuilder()
        Dim blnIsRecordExists As Boolean = False
        Dim strMode As String
        Dim strLeaveID As String
        Dim strEncryptedString As String

        'Session Expired
        If Session("intUserID") Is Nothing Then
            Call LogOut()
        End If

        'Logout
        strMode = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "").ToString()

        Select Case strMode.ToLower

            Case "logout"
                Call LogOut()
        End Select

        strUserID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString()
        strUserName = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "").ToString()

        'Paging
        dsLeaves = CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_EmployeeLeaveDetails_Pending_Approval " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString(), "TblLeaves", UseSQL:=True)
        intNoofRecords = dsLeaves.Tables(0).Rows.Count

        strPageNo = CommonFunctions.General.CheckIsNothing(Request.QueryString("PageNo"), "1").ToString()
        Try
            intPageNumber = CInt(strPageNo)
        Catch ex As Exception
            intPageNumber = 1
        End Try

        If intPageNumber > Math.Ceiling(intNoofRecords / intNoofRecordsPerPage) Then
            intPageNumber = Math.Ceiling(intNoofRecords / intNoofRecordsPerPage)
        End If

        If intPageNumber < 1 Then
            intPageNumber = 1
        End If

        If intPageNumber < 2 Then
            LnkPrevious.NavigateUrl = "Mobile_LeaveApprovalList.aspx?PageNo=1"
        Else
            LnkPrevious.NavigateUrl = "Mobile_LeaveApprovalList.aspx?PageNo=" + (intPageNumber - 1).ToString()
        End If

        If strPageNo > Math.Ceiling(intNoofRecords / intNoofRecordsPerPage - 1).ToString() Then
            LnkNext.NavigateUrl = "Mobile_LeaveApprovalList.aspx?PageNo=" + Math.Ceiling(intNoofRecords / intNoofRecordsPerPage).ToString()
        Else
            LnkNext.NavigateUrl = "Mobile_LeaveApprovalList.aspx?PageNo=" + (intPageNumber + 1).ToString()
        End If

        LnkLast.NavigateUrl = "Mobile_LeaveApprovalList.aspx?PageNo=" + Math.Ceiling(intNoofRecords / intNoofRecordsPerPage).ToString()

        dsLeaves = CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_EmployeeLeaveDetails_Pending_Approval " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString(), "TblLeaves", (intPageNumber - 1) * intNoofRecordsPerPage, IIf(intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage < intNoofRecordsPerPage, intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage, intNoofRecordsPerPage), UseSQL:=True)

        'Plot Request list
        For Each drLeaves As DataRow In dsLeaves.Tables(0).Rows
            Dim objLink As New Web.UI.MobileControls.Link()
            Dim objTextView As New Web.UI.MobileControls.TextView()
            Dim objLbl As New Web.UI.MobileControls.Label()
            Dim objChkBox As New Web.UI.MobileControls.SelectionList


            strLeaveID = CommonFunctions.Data.CheckIsDBNull(drLeaves("LeaveID"), "0").ToString()
            arrLeaveID.Add(strLeaveID)

            Dim objItem As New Web.UI.MobileControls.MobileListItem(strLeaveID, strLeaveID)

            Dim sym As New Encryption.Symmetric(Encryption.Symmetric.Provider.Rijndael)
            Dim key As New Encryption.Data("crazyFrogJumpsTo")
            Dim encryptedData As New Encryption.Data

            encryptedData = sym.Encrypt(New Encryption.Data(strLeaveID), key)
            strEncryptedString = HttpUtility.UrlEncode(encryptedData.ToBase64)

            objLink.ID = "lnkLeave_" + strLeaveID
            objLink.NavigateUrl = "Mobile_LeaveApprovals.aspx?Token=" + strEncryptedString
            objLink.Text = CommonFunctions.Data.CheckIsDBNull(drLeaves("EmployeeName"), "").ToString()

            objTextView.ID = "txtLeave_" + strLeaveID

            strDetails.Append("From: ")
            If CommonFunctions.Data.CheckIsDBNull(drLeaves("FromDate"), "").ToString() <> "" Then
                strDetails.Append(CommonFunctions.Dates.GetDate(drLeaves("FromDate")) & " ")
            Else
                strDetails.Append("- ")
            End If

            strDetails.Append("To: ")
            If CommonFunctions.Data.CheckIsDBNull(drLeaves("ToDate"), "").ToString() <> "" Then
                strDetails.Append(CommonFunctions.Dates.GetDate(drLeaves("ToDate")) & " ")
            Else
                strDetails.Append("- ")
            End If

            strDetails.Append("Leave Type: ") : strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drLeaves("LeaveType"), "").ToString() & " ")
            strDetails.Append("Leave Balance: ") : strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drLeaves("LeaveBalance"), "0.0").ToString() & " ")
            strDetails.Append("Half day: ") : strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drLeaves("HalfDay"), "No").ToString() & " ")

            objTextView.Text = strDetails.ToString()
            strDetails.Length = 0

            objLbl.ID = "Lbl_" + CommonFunctions.Data.CheckIsDBNull(drLeaves("LeaveID"), "0").ToString()
            objLbl.Text = ""

            objItem.Value = strLeaveID
            objItem.Text = " "
            objItem.ID = "ChkSelect" + strLeaveID


            objChkBox.ID = "Chk" + strLeaveID
            objChkBox.SelectType = MobileControls.ListSelectType.CheckBox
            objChkBox.BreakAfter = False
            objChkBox.Items.Add(objItem)

            Page.FindControl("frmLeaveApproval").Controls.Add(objChkBox)
            Page.FindControl("frmLeaveApproval").Controls.Add(objLink)
            Page.FindControl("frmLeaveApproval").Controls.Add(objTextView)
            Page.FindControl("frmLeaveApproval").Controls.Add(objLbl)
            blnIsRecordExists = True

        Next

        If Not blnIsRecordExists Then
            Dim objLabel As New Web.UI.MobileControls.Label()
            objLabel.Text = "There are no items to show in this view."
            Page.FindControl("frmLeaveApproval").Controls.Add(objLabel)
        End If

        Dim objBack As New Web.UI.MobileControls.Link()
        Dim objLblBack As New Web.UI.MobileControls.Label()

        'Back Link
        objBack.Text = "Back"
        objBack.ID = "LnkBack"
        objBack.NavigateUrl = "Mobile_Approvals.aspx"
        objBack.BreakAfter = False
        'objLblBack.ID = "LblBack"
        objLblBack.Text = " | "
        objLblBack.BreakAfter = False

        Page.FindControl("frmLeaveApproval").Controls.Add(objBack)
        Page.FindControl("frmLeaveApproval").Controls.Add(objLblBack)


        'Logout Link
        Dim objLogOut As New Web.UI.MobileControls.Link()
        'Dim objLblLogout As New Web.UI.MobileControls.Label()

        objLogOut.Text = "Logout"
        objLogOut.ID = "LnkLogOut"
        objLogOut.NavigateUrl = "Mobile_LeaveApprovalList.aspx?Mode=Logout"
        objLogOut.BreakAfter = False
        'objLblLogout.ID = "LblLogout"
        'objLblLogout.Text = ""

        'Page.FindControl("frmLeaveApproval").Controls.Add(objLblLogout)
        Page.FindControl("frmLeaveApproval").Controls.Add(objLogOut)

        objLbl1.ID = "Lbl1"
        objLbl1.Text = " | "
        objLbl1.BreakAfter = False

        objLbl2.ID = "Lbl2"
        objLbl2.Text = " | "
        objLbl2.BreakAfter = False

        objApproveCmd.Text = "Approve"
        objApproveCmd.BreakAfter = False
        objApproveCmd.Format = MobileControls.CommandFormat.Link

        objRejectCmd.Text = "Reject"
        objRejectCmd.BreakAfter = False
        objRejectCmd.Format = MobileControls.CommandFormat.Link

        Page.FindControl("frmLeaveApproval").Controls.Add(objLbl1)
        Page.FindControl("frmLeaveApproval").Controls.Add(objApproveCmd)
        Page.FindControl("frmLeaveApproval").Controls.Add(objLbl2)
        Page.FindControl("frmLeaveApproval").Controls.Add(objRejectCmd)

        strDetails = Nothing
    End Sub

    Private Sub LogOut()
        'Logout
        Session.Abandon()
        Response.Clear()
        Response.Redirect("Login.aspx")
    End Sub

    Private Sub CmdApprove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles CmdApprove.Click
        Call ApproveLeave()
    End Sub

    'Private Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
    '    Dim dsLeaves As DataSet
    '    Dim strDetails As New StringBuilder()
    '    Dim blnIsRecordExists As Boolean = False
    '    Dim strMode As String
    '    Dim strLeaveID As String
    '    Dim strEncryptedString As String

    '    strUserID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString()
    '    strUserName = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "").ToString()

    '    'Paging
    '    dsLeaves = CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_EmployeeLeaveDetails_Pending_Approval " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString(), "TblLeaves", UseSQL:=True)
    '    intNoofRecords = dsLeaves.Tables(0).Rows.Count

    '    strPageNo = CommonFunctions.General.CheckIsNothing(Request.QueryString("PageNo"), "1").ToString()
    '    Try
    '        intPageNumber = CInt(strPageNo)
    '    Catch ex As Exception
    '        intPageNumber = 1
    '    End Try

    '    If intPageNumber > Math.Ceiling(intNoofRecords / intNoofRecordsPerPage) Then
    '        intPageNumber = Math.Ceiling(intNoofRecords / intNoofRecordsPerPage)
    '    End If

    '    If intPageNumber < 1 Then
    '        intPageNumber = 1
    '    End If

    '    If intPageNumber < 2 Then
    '        LnkPrevious.NavigateUrl = "Mobile_LeaveApprovalList.aspx?PageNo=1"
    '    Else
    '        LnkPrevious.NavigateUrl = "Mobile_LeaveApprovalList.aspx?PageNo=" + (intPageNumber - 1).ToString()
    '    End If

    '    If strPageNo > Math.Ceiling(intNoofRecords / intNoofRecordsPerPage - 1).ToString() Then
    '        LnkNext.NavigateUrl = "Mobile_LeaveApprovalList.aspx?PageNo=" + Math.Ceiling(intNoofRecords / intNoofRecordsPerPage).ToString()
    '    Else
    '        LnkNext.NavigateUrl = "Mobile_LeaveApprovalList.aspx?PageNo=" + (intPageNumber + 1).ToString()
    '    End If

    '    LnkLast.NavigateUrl = "Mobile_LeaveApprovalList.aspx?PageNo=" + Math.Ceiling(intNoofRecords / intNoofRecordsPerPage).ToString()

    '    dsLeaves = CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_EmployeeLeaveDetails_Pending_Approval " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString(), "TblLeaves", (intPageNumber - 1) * intNoofRecordsPerPage, IIf(intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage < intNoofRecordsPerPage, intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage, intNoofRecordsPerPage), UseSQL:=True)

    '    'Plot Request list
    '    For Each drLeaves As DataRow In dsLeaves.Tables(0).Rows
    '        Dim objLink As New Web.UI.MobileControls.Link()
    '        Dim objTextView As New Web.UI.MobileControls.TextView()
    '        Dim objLbl As New Web.UI.MobileControls.Label()
    '        Dim objChkBox As New Web.UI.MobileControls.SelectionList


    '        strLeaveID = CommonFunctions.Data.CheckIsDBNull(drLeaves("LeaveID"), "0").ToString()
    '        arrLeaveID.Add(strLeaveID)

    '        Dim objItem As New Web.UI.MobileControls.MobileListItem(strLeaveID, strLeaveID)

    '        Dim sym As New Encryption.Symmetric(Encryption.Symmetric.Provider.Rijndael)
    '        Dim key As New Encryption.Data("crazyFrogJumpsTo")
    '        Dim encryptedData As New Encryption.Data

    '        encryptedData = sym.Encrypt(New Encryption.Data(strLeaveID), key)
    '        strEncryptedString = HttpUtility.UrlEncode(encryptedData.ToBase64)

    '        objLink.ID = "lnkLeave_" + strLeaveID
    '        objLink.NavigateUrl = "Mobile_LeaveApprovals.aspx?Token=" + strEncryptedString
    '        objLink.Text = CommonFunctions.Data.CheckIsDBNull(drLeaves("EmployeeName"), "").ToString()

    '        objTextView.ID = "txtLeave_" + strLeaveID

    '        strDetails.Append("From: ")
    '        If CommonFunctions.Data.CheckIsDBNull(drLeaves("FromDate"), "").ToString() <> "" Then
    '            strDetails.Append(CommonFunctions.Dates.GetDate(drLeaves("FromDate")) & " ")
    '        Else
    '            strDetails.Append("- ")
    '        End If

    '        strDetails.Append("To: ")
    '        If CommonFunctions.Data.CheckIsDBNull(drLeaves("ToDate"), "").ToString() <> "" Then
    '            strDetails.Append(CommonFunctions.Dates.GetDate(drLeaves("ToDate")) & " ")
    '        Else
    '            strDetails.Append("- ")
    '        End If

    '        strDetails.Append("Leave Type: ") : strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drLeaves("LeaveType"), "").ToString() & " ")
    '        strDetails.Append("Leave Balance: ") : strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drLeaves("LeaveBalance"), "0.0").ToString() & " ")
    '        strDetails.Append("Half day: ") : strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drLeaves("HalfDay"), "No").ToString() & " ")

    '        objTextView.Text = strDetails.ToString()
    '        strDetails.Length = 0

    '        objLbl.ID = "Lbl_" + CommonFunctions.Data.CheckIsDBNull(drLeaves("LeaveID"), "0").ToString()
    '        objLbl.Text = ""

    '        objItem.Value = strLeaveID
    '        objItem.Text = " "
    '        objItem.ID = "ChkSelect" + strLeaveID


    '        objChkBox.ID = "Chk" + strLeaveID
    '        objChkBox.SelectType = MobileControls.ListSelectType.CheckBox
    '        objChkBox.BreakAfter = False
    '        objChkBox.Items.Add(objItem)

    '        Page.FindControl("frmLeaveApproval").Controls.Add(objChkBox)
    '        Page.FindControl("frmLeaveApproval").Controls.Add(objLink)
    '        Page.FindControl("frmLeaveApproval").Controls.Add(objTextView)
    '        Page.FindControl("frmLeaveApproval").Controls.Add(objLbl)
    '        blnIsRecordExists = True

    '    Next

    '    If Not blnIsRecordExists Then
    '        Dim objLabel As New Web.UI.MobileControls.Label()
    '        objLabel.Text = "There are no items to show in this view."
    '        Page.FindControl("frmLeaveApproval").Controls.Add(objLabel)
    '    End If

    '    Dim objBack As New Web.UI.MobileControls.Link()
    '    Dim objLblBack As New Web.UI.MobileControls.Label()

    '    'Back Link
    '    objBack.Text = "Back"
    '    objBack.ID = "LnkBack"
    '    objBack.NavigateUrl = "Mobile_Approvals.aspx"
    '    objBack.BreakAfter = False
    '    'objLblBack.ID = "LblBack"
    '    objLblBack.Text = " | "
    '    objLblBack.BreakAfter = False

    '    Page.FindControl("frmLeaveApproval").Controls.Add(objBack)
    '    Page.FindControl("frmLeaveApproval").Controls.Add(objLblBack)


    '    'Logout Link
    '    Dim objLogOut As New Web.UI.MobileControls.Link()
    '    'Dim objLblLogout As New Web.UI.MobileControls.Label()

    '    objLogOut.Text = "Logout"
    '    objLogOut.ID = "LnkLogOut"
    '    objLogOut.NavigateUrl = "Mobile_LeaveApprovalList.aspx?Mode=Logout"
    '    'objLblLogout.ID = "LblLogout"
    '    'objLblLogout.Text = ""

    '    'Page.FindControl("frmLeaveApproval").Controls.Add(objLblLogout)
    '    Page.FindControl("frmLeaveApproval").Controls.Add(objLogOut)

    '    strDetails = Nothing
    'End Sub

    Private Sub CmdReject_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles CmdReject.Click
        Call RejectLeave()
    End Sub


    Private Sub objApproveCmd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles objApproveCmd.Click
        Call ApproveLeave()
    End Sub

    Private Sub objRejectCmd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles objRejectCmd.Click
        Call RejectLeave()
    End Sub

    Private Sub ApproveLeave()
        Dim i As Integer
        Dim strQuery As New StringBuilder
        Dim strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage As String
        Dim blnSendMail As Boolean
        Dim dr As IDataReader

        ' send mail
        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 69", True)
        If dr.Read Then
            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

        For i = 0 To arrLeaveID.Count - 1
            If Not HttpContext.Current.Request.Form("Chk" + arrLeaveID(i).ToString()) Is Nothing Then
                strQuery.Append("usp_Upd_tbl_PM_EmployeeLeaveDetails_AND_Master ")
                strQuery.Append(arrLeaveID(i).ToString())
                strQuery.Append(",2, ")
                strQuery.Append(strUserID)
                strQuery.Append(", N'Approved By ")
                strQuery.Append(strUserName)
                strQuery.Append(" on ")
                strQuery.Append(Date.Now.ToString())
                strQuery.Append("'")
                CommonFunctions.Data.InsertOrUpdateData(strQuery.ToString(), True)

                If blnSendMail Then
                    CommonFunction.EmailMessages.PMMessages.GetEmailMessage_69(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CType(arrLeaveID(i), Integer))
                    CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                    strQuery.Length = 0
                End If
            End If
        Next
        Response.Redirect("Mobile_LeaveApprovalList.aspx")
        strQuery = Nothing
    End Sub


    Private Sub RejectLeave()
        Dim i As Integer
        Dim strQuery As New StringBuilder
        Dim strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage As String
        Dim blnSendMail As Boolean
        Dim dr As IDataReader

        ' send mail
        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 70", True)
        If dr.Read Then
            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

        For i = 0 To arrLeaveID.Count - 1
            If Not HttpContext.Current.Request.Form("Chk" + arrLeaveID(i).ToString()) Is Nothing Then
                strQuery.Append("usp_Upd_tbl_PM_EmployeeLeaveDetails_AND_Master ")
                strQuery.Append(arrLeaveID(i).ToString())
                strQuery.Append(",3, ")
                strQuery.Append(strUserID)
                strQuery.Append(", N'Rejected By ")
                strQuery.Append(strUserName)
                strQuery.Append(" on ")
                strQuery.Append(Date.Now.ToString())
                strQuery.Append("'")
                CommonFunctions.Data.InsertOrUpdateData(strQuery.ToString(), True)
                strQuery.Length = 0

                If blnSendMail Then
                    'To notify requestor about rejection
                    CommonFunction.EmailMessages.PMMessages.GetEmailMessage_70(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CType(arrLeaveID(i).ToString(), Integer))
                    CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                End If
            End If
        Next
        Response.Redirect("Mobile_LeaveApprovalList.aspx")
        strQuery = Nothing
    End Sub

End Class


