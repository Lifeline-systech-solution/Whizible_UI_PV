
Partial Class Mobile_ProjectApproval
    Inherits System.Web.UI.MobileControls.MobilePage

    Private strProjectId As String
    Private strUserID As String
    Private strMode As String
    Private strSentForApprovalBy As String
    Private intRecipientID As Integer

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If HttpContext.Current.Session("intUserID") Is Nothing Then
            Call LogOut()
        End If

        strMode = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "").ToString()
        If strMode.ToLower = "logout" Then
            Call LogOut()
        End If

        Dim dsProject As DataSet
        Dim strText As New System.Text.StringBuilder

        strProjectId = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Token"), "").ToString()

        Dim sym As New Encryption.Symmetric(Encryption.Symmetric.Provider.Rijndael)
        Dim key As New Encryption.Data("crazyFrogJumpsTo")
        Dim encryptedData As New Encryption.Data
        encryptedData.Base64 = strProjectId

        Dim decrypteddata As Encryption.Data
        decrypteddata = sym.Decrypt(encryptedData, key)
        strProjectId = HttpUtility.UrlDecode(decrypteddata.ToString)

        strUserID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString()

        dsProject = CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_ProjectRevision_MobileApprovals " + strUserID + "," + strProjectId, "TblProject")

        If dsProject.Tables(0).Rows.Count > 0 Then
            TxtProjectCode.Text = "<b>Project Code:</b> " + CommonFunctions.Data.CheckIsDBNull(dsProject.Tables(0).Rows(0)("ProjectCode"))
            TxtProjectName.Text = "<b>Project Name:</b> " + CommonFunctions.Data.CheckIsDBNull(dsProject.Tables(0).Rows(0)("ProjectName"))
            strText.Append("<b>Start Date:</b> ")
            If CommonFunctions.Data.CheckIsDBNull(dsProject.Tables(0).Rows(0)("ExpectedStartDate")).ToString() = "" Then
                strText.Append(" - ")
            Else
                strText.Append(CommonFunctions.Dates.CGetDate(dsProject.Tables(0).Rows(0)("ExpectedStartDate")))
            End If
            TxtStartDate.Text = strText.ToString()
            strText.Length = 0
            strText.Append(" <b>End Date:</b> ")
            If CommonFunctions.Data.CheckIsDBNull(dsProject.Tables(0).Rows(0)("ExpectedEndDate")).ToString() = "" Then
                strText.Append(" - ")
            Else
                strText.Append(CommonFunctions.Dates.CGetDate(dsProject.Tables(0).Rows(0)("ExpectedEndDate")))
            End If
            TxtEndDate.Text = strText.ToString()
            strText.Length = 0
            TxtOrganizationUnit.Text = "<b>Project Code:</b> " + CommonFunctions.Data.CheckIsDBNull(dsProject.Tables(0).Rows(0)("Location"))
            TxtPractice.Text = "<b>Practice:</b> " + CommonFunctions.Data.CheckIsDBNull(dsProject.Tables(0).Rows(0)("ProjectType"))
            strText.Append("<b>Project Value:</b> ")
            strText.Append(CommonFunctions.Data.CheckIsDBNull(dsProject.Tables(0).Rows(0)("CurrencyCode")))
            strText.Append(" ")
            strText.Append(FormatNumber(CommonFunctions.Data.CheckIsDBNull(dsProject.Tables(0).Rows(0)("ContractValue"), "0"), 2))
            TxtProjectValue.Text = strText.ToString()
            TxtWork.Text = "<b>Work (Hrs):</b> " + FormatNumber(CommonFunctions.Data.CheckIsDBNull(dsProject.Tables(0).Rows(0)("EstimatedEfforts"), "0"), 2)
            strText.Length = 0

            strSentForApprovalBy = CommonFunctions.Data.CheckIsDBNull(dsProject.Tables(0).Rows(0)("SentForApprovalBy"), "")
            intRecipientID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_GetEmployeeID N'" & strSentForApprovalBy & "'", True), "0"), "0"), Integer)
        End If

        ''Logout Link
        'Dim objLogOut As New Web.UI.MobileControls.Link()
        'Dim objLblLogout As New Web.UI.MobileControls.Label()

        'objLogOut.Text = "Logout"
        'objLogOut.ID = "LnkLogOut"
        'objLogOut.NavigateUrl = "Mobile_ProjectApproval.aspx?Mode=Logout"
        'objLblLogout.ID = "LblLogout"
        'objLblLogout.Text = ""

        'Page.FindControl("frmProjectApprovalEdit").Controls.Add(objLblLogout)
        'Page.FindControl("frmProjectApprovalEdit").Controls.Add(objLogOut)

    End Sub

    Protected Sub Approve_OnClick(ByVal sender As Object, ByVal e As System.EventArgs) Handles CmdApprove.Click
        Dim strSQL As New StringBuilder
        Dim strFromEmailID As String = "", strToMailID As String = "", strCCToMailID As String = ""
        Dim strToEmailID As String = "", strCCToEmailID As String = ""
        Dim strEmailMessage As String = "", strSubject As String = "", strMessage As String = ""
        Dim intRevisionReasonID As Integer
        Dim blnSendMail As Boolean
        Dim dr As IDataReader

        strSQL.Append("usp_Ins_tbl_PM_Project_BaselineRevisionReason ")
        strSQL.Append(strProjectId + ",")
        strSQL.Append("N'" & CommonFunction.General.BuildQueryString(txtComment.Text) & "',")
        strSQL.Append("N'" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "").ToString()) & "','A' ")

        intRevisionReasonID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL.ToString(), True), "0"), Integer)

        ' send mail
        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 441", True)
        If dr.Read Then
            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

        If blnSendMail Then
            CommonFunction.EmailMessages.PMMessages.GetEmailMessage_441(intRecipientID.ToString(), strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CType(strProjectId, Integer), "'A'", intRevisionReasonID)
            CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
        End If
        strSQL = Nothing
        Response.Redirect("Mobile_ProjectApprovalList.aspx")
    End Sub

    Protected Sub Reject_OnClick(ByVal sender As Object, ByVal e As System.EventArgs) Handles CmdReject.Click
        Dim strSQL As New StringBuilder
        Dim strFromEmailID As String = "", strToMailID As String = "", strCCToMailID As String = ""
        Dim strToEmailID As String = "", strCCToEmailID As String = ""
        Dim strEmailMessage As String = "", strSubject As String = "", strMessage As String = ""
        Dim intRevisionReasonID As Integer
        Dim blnSendMail As Boolean
        Dim dr As IDataReader

        If Page.IsValid Then
            strSQL.Append("usp_Ins_tbl_PM_ProjectBaselineRejectionReason ")
            strSQL.Append(strProjectId & ",")
            strSQL.Append("N'" & CommonFunction.General.BuildQueryString(txtComment.Text) & "',")
            strSQL.Append("N'" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "").ToString()) & "'")
            intRevisionReasonID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL.ToString(), True), "0"), Integer)

            ' send mail
            dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 441", True)
            If dr.Read Then
                blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
            End If
            CommonFunctions.Data.DisposeDataReader(dr)

            If blnSendMail Then
                'Notify Project owener about Rejection 
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_441(intRecipientID.ToString(), strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CType(strProjectId, Integer), "'R'", intRevisionReasonID)
                CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
            End If
            Response.Redirect("Mobile_ProjectApprovalList.aspx")
        End If
        strSQL = Nothing
    End Sub

    Private Sub LogOut()
        Session.Abandon()
        Response.Clear()
        Response.Redirect("Login.aspx")
    End Sub

End Class


