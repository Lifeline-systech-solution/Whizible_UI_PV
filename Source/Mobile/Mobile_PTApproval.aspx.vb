
Partial Class Mobile_PTApproval
    Inherits System.Web.UI.MobileControls.MobilePage

    Private strTimesheetNo As String
    Private strUserID As String
    Private strMode As String
    Dim dteFromDate As String
    Dim dteToDate As String
    Dim strResourceID As String

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("intUserID") Is Nothing Then
            Call LogOut()
        End If

        strMode = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "").ToString()
        strUserID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString()

        If strMode.ToLower = "logout" Then
            Call LogOut()
        End If

        Dim dsTimesheet As DataSet
        Dim strText As New StringBuilder
        Dim dblTotalWorkHrs As Double = 0.0

        strTimesheetNo = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Token"), "").ToString()

        Dim sym As New Encryption.Symmetric(Encryption.Symmetric.Provider.Rijndael)
        Dim key As New Encryption.Data("crazyFrogJumpsTo")
        Dim encryptedData As New Encryption.Data
        encryptedData.Base64 = strTimesheetNo

        Dim decrypteddata As Encryption.Data
        decrypteddata = sym.Decrypt(encryptedData, key)
        strTimesheetNo = HttpUtility.UrlDecode(decrypteddata.ToString)

        dsTimesheet = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_PM_TimeSheetInvoice 1,NULL," + strTimesheetNo + ",NULL,NULL,NULL,61", "TblTimesheet")

        If dsTimesheet.Tables(0).Rows.Count > 0 Then
            TxtTimesheetNo.Text = "<b>Timesheet No:</b> " + CommonFunctions.Data.CheckIsDBNull(dsTimesheet.Tables(0).Rows(0)("TimesheetNo"), "").ToString()
            If CommonFunctions.Data.CheckIsDBNull(dsTimesheet.Tables(0).Rows(0)("CreatedDate"), "").ToString() = "" Then
                TxtDate.Text = "<b>Date:</b> -"
            Else
                TxtDate.Text = "<b>Date:</b> " + CommonFunctions.Dates.CGetDate(dsTimesheet.Tables(0).Rows(0)("CreatedDate"))
            End If
            TxtProjectName.Text = "<b>Project Name:</b> " + CommonFunctions.Data.CheckIsDBNull(dsTimesheet.Tables(0).Rows(0)("ProjectName"))
            strText.Append("<b>From Date:</b> ")
            If CommonFunctions.Data.CheckIsDBNull(dsTimesheet.Tables(0).Rows(0)("FromDate")).ToString() = "" Then
                strText.Append(" - ")
            Else
                strText.Append(CommonFunctions.Dates.CGetDate(dsTimesheet.Tables(0).Rows(0)("FromDate")))
            End If
            TxtFromDate.Text = strText.ToString()
            strText.Length = 0
            strText.Append(" <b>To Date</b> ")
            If CommonFunctions.Data.CheckIsDBNull(dsTimesheet.Tables(0).Rows(0)("ToDate")).ToString() = "" Then
                strText.Append(" - ")
            Else
                strText.Append(CommonFunctions.Dates.CGetDate(dsTimesheet.Tables(0).Rows(0)("ToDate")))
            End If
            TxtToDate.Text = strText.ToString()
            strText.Length = 0
            TxtSummary.Text = "<b>Total Work(Hrs): </b>" + FormatNumber(CommonFunctions.Data.CheckIsDBNull(dsTimesheet.Tables(0).Rows(0)("TotalTimesheetHours"), "0.0"), 2)

            'dteFromDate = CommonFunctions.Data.CheckIsDBNull(dsTimesheet.Tables(0).Rows(0)("FromDate")).ToString()
            'dteToDate = CommonFunctions.Data.CheckIsDBNull(dsTimesheet.Tables(0).Rows(0)("ToDate")).ToString()
            'strResourceID = CommonFunctions.Data.CheckIsDBNull(dsTimesheet.Tables(0).Rows(0)("EmployeeID")).ToString()
        End If

        dsTimesheet = CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_TimeSheet_EmployeeWiseTotal " + strTimesheetNo, "TblTimesheet")


        strText.Append("<b>Timesheet Details</b><br/>")
        For Each drTimesheet As DataRow In dsTimesheet.Tables(0).Rows
            strText.Append("<b>Employee Name: </b>" + CommonFunctions.Data.CheckIsDBNull(drTimesheet("EmployeeName")))
            strText.Append("    <b>Actual Work(Hrs): </b>" + FormatNumber(CommonFunctions.Data.CheckIsDBNull(drTimesheet("WorkHrs"), "0.0"), 2))
            strText.Append("<br/>")
            dblTotalWorkHrs += CType(CommonFunctions.Data.CheckIsDBNull(drTimesheet("WorkHrs"), "0.0"), Double)
        Next
        TxtTimesheetDetails.Text = strText.ToString()
        strText.Length = 0

        ''Logout Link
        'Dim objLogOut As New Web.UI.MobileControls.Link()
        'Dim objLblLogout As New Web.UI.MobileControls.Label()

        'objLogOut.Text = "Logout"
        'objLogOut.ID = "LnkLogOut"
        'objLogOut.NavigateUrl = "Mobile_PTApproval.aspx?Mode=Logout"
        'objLblLogout.ID = "LblLogout"
        'objLblLogout.Text = ""

        'Page.FindControl("frmPTApprovalEdit").Controls.Add(objLblLogout)
        'Page.FindControl("frmPTApprovalEdit").Controls.Add(objLogOut)
    End Sub

    Protected Sub Approve_OnClick(ByVal sender As Object, ByVal e As System.EventArgs) Handles CmdApprove.Click
        Dim strQuery As String
        Dim strFromMail As String = ""
        Dim strMailTo As String = ""
        Dim strCCEmailID As String = ""
        Dim strSubject As String = ""
        Dim strMessage As String = ""
        Dim blnSendMail As Boolean
        Dim dr As IDataReader

        If Page.IsValid Then

            strQuery = "usp_Upd_tbl_PM_TimeSheetInvoice '" & strTimesheetNo & "',N'" & CommonFunctions.General.BuildQueryString(txtComment.Text) & "',N'" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName")) + "'"
            CommonFunctions.Data.InsertOrUpdateData(strQuery, True)

            ' send mail
            dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 6", True)
            If dr.Read Then
                blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
            End If
            CommonFunctions.Data.DisposeDataReader(dr)

            If blnSendMail Then
                'Notify Project owener about Approval 
                CommonFunction.EmailMessages.FAMessages.GetEmailMessage_6(strFromMail, strMailTo, strCCEmailID, strSubject, strMessage, CType(strTimesheetNo, Long))
                CommonFunction.Emails.AppSendEmail(strMailTo, strFromMail, strSubject, strMessage)
            End If

            Response.Redirect("Mobile_PTApprovalList.aspx")
        End If

    End Sub

    Protected Sub Reject_OnClick(ByVal sender As Object, ByVal e As System.EventArgs) Handles CmdReject.Click
        Dim strQuery As String
        Dim strFromMail As String = ""
        Dim strMailTo As String = ""
        Dim strCCToEmailID As String = ""
        Dim strSubject As String = ""
        Dim strMessage As String = ""
        Dim blnSendMail As Boolean
        Dim dr As IDataReader

        If Page.IsValid Then

            strQuery = "usp_Upd_tbl_PM_TimeSheetInvoice_For_Rejection " + strTimesheetNo + ",N'" + CommonFunctions.General.BuildQueryString(txtComment.Text) + "','" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName")) + "'"
            CommonFunctions.Data.InsertOrUpdateData(strQuery, True)

            ' send mail
            dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 442", True)
            If dr.Read Then
                blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
            End If
            CommonFunctions.Data.DisposeDataReader(dr)

            If blnSendMail Then
                'Notify Project owener about rejection 
                CommonFunction.EmailMessages.FAMessages.GetEmailMessage_442(strFromMail, strMailTo, strCCToEmailID, strSubject, strMessage, CType(strTimesheetNo, Long))
                CommonFunction.Emails.AppSendEmailWithCC(strMailTo, strFromMail, strCCToEmailID, strSubject, strMessage)
            End If
            Response.Redirect("Mobile_PTApprovalList.aspx")
        End If
    End Sub

    Private Sub LogOut()
        Session.Abandon()
        Response.Clear()
        Response.Redirect("Login.aspx")
    End Sub


End Class


