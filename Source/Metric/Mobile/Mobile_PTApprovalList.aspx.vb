
Partial Class Mobile_PTApprovalList
    Inherits System.Web.UI.MobileControls.MobilePage

    Dim intPageNumber As Integer = 1
    Dim intNoofRecords As Integer
    Dim intNoofRecordsPerPage As Integer = 10
    Dim strPageNo As String

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim dsProjectTimesheet As DataSet
        Dim strDetails As New StringBuilder()
        Dim blnIsRecordExists As Boolean = False
        Dim strMode As String
        Dim strTimesheetNo As String
        Dim strEncryptedString As String

        'Session Expired
        If HttpContext.Current.Session("intUserID") Is Nothing Then
            Call LogOut()
        End If

        'Logout
        strMode = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "").ToString()
        If strMode.ToLower = "logout" Then
            Call LogOut()
        End If

        'Paging
        dsProjectTimesheet = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_PM_TimeSheetInvoice 1,NULL,NULL,NULL,NULL,NULL," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString(), "TblProject", UseSQL:=True)
        intNoofRecords = dsProjectTimesheet.Tables(0).Rows.Count

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
            LnkPrevious.NavigateUrl = "Mobile_PTApprovalList.aspx?PageNo=1"
        Else
            LnkPrevious.NavigateUrl = "Mobile_PTApprovalList.aspx?PageNo=" + (intPageNumber - 1).ToString()
        End If

        If strPageNo > Math.Ceiling(intNoofRecords / intNoofRecordsPerPage - 1).ToString() Then
            LnkNext.NavigateUrl = "Mobile_PTApprovalList.aspx?PageNo=" + Math.Ceiling(intNoofRecords / intNoofRecordsPerPage).ToString()
        Else
            LnkNext.NavigateUrl = "Mobile_PTApprovalList.aspx?PageNo=" + (intPageNumber + 1).ToString()
        End If

        LnkLast.NavigateUrl = "Mobile_PTApprovalList.aspx?PageNo=" + Math.Ceiling(intNoofRecords / intNoofRecordsPerPage).ToString()

        dsProjectTimesheet = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_PM_TimeSheetInvoice 1,NULL,NULL,NULL,NULL,NULL," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString(), "TblProject", (intPageNumber - 1) * intNoofRecordsPerPage, IIf(intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage < intNoofRecordsPerPage, intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage, intNoofRecordsPerPage), UseSQL:=True)

        'Plot Request list
        For Each drProjectTimesheet As DataRow In dsProjectTimesheet.Tables(0).Rows
            Dim objLink As New Web.UI.MobileControls.Link()
            Dim objTextView As New Web.UI.MobileControls.TextView()
            Dim objLbl As New Web.UI.MobileControls.Label()

            strTimesheetNo = CommonFunctions.Data.CheckIsDBNull(drProjectTimesheet("TimesheetNo"), "0").ToString()

            Dim sym As New Encryption.Symmetric(Encryption.Symmetric.Provider.Rijndael)
            Dim key As New Encryption.Data("crazyFrogJumpsTo")
            Dim encryptedData As New Encryption.Data

            encryptedData = sym.Encrypt(New Encryption.Data(strTimesheetNo), key)
            strEncryptedString = HttpUtility.UrlEncode(encryptedData.ToBase64)

            objLink.ID = "lnkProject_" + strTimesheetNo
            objLink.NavigateUrl = "Mobile_PTApproval.aspx?Token=" + strEncryptedString
            strDetails.Append("Timesheet No: ")
            strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drProjectTimesheet("TimesheetNo"), "").ToString())
            strDetails.Append("  Date: ")
            strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drProjectTimesheet("CreatedDate1"), "").ToString())

            objLink.Text = strDetails.ToString()

            strDetails.Length = 0

            objTextView.ID = "txtPropect_" + strTimesheetNo

            strDetails.Append("<b>From Date: </b>")
            If CommonFunctions.Data.CheckIsDBNull(drProjectTimesheet("FromDate"), "").ToString() <> "" Then
                strDetails.Append(CommonFunctions.Dates.GetDate(drProjectTimesheet("FromDate")) & " ")
            Else
                strDetails.Append("- ")
            End If
            strDetails.Append("  <b>Project: </b>" + CommonFunctions.Data.CheckIsDBNull(drProjectTimesheet("ProjectName"), "").ToString())
            strDetails.Append("  <b>To Date: </b>")
            If CommonFunctions.Data.CheckIsDBNull(drProjectTimesheet("ToDate"), "").ToString() <> "" Then
                strDetails.Append(CommonFunctions.Dates.GetDate(drProjectTimesheet("ToDate")) & " ")
            Else
                strDetails.Append("- ")
            End If
            strDetails.Append("  <b>Timesheet Hrs: </b>")
            strDetails.Append(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drProjectTimesheet("TotalTimesheetHours"), "0.0"), 2))

            objTextView.Text = strDetails.ToString()
            strDetails.Length = 0

            objLbl.ID = "Lbl_" + strTimesheetNo
            objLbl.Text = ""

            Page.FindControl("frmProjectTimesheetApproval").Controls.Add(objLink)
            Page.FindControl("frmProjectTimesheetApproval").Controls.Add(objTextView)
            Page.FindControl("frmProjectTimesheetApproval").Controls.Add(objLbl)
            blnIsRecordExists = True
        Next

        If Not blnIsRecordExists Then
            Dim objLabel As New Web.UI.MobileControls.Label()
            objLabel.Text = "There are no items to show in this view."
            Page.FindControl("frmProjectTimesheetApproval").Controls.Add(objLabel)
        End If

        Dim objBack As New Web.UI.MobileControls.Link()
        Dim objLblBack As New Web.UI.MobileControls.Label()

        'Back Link
        objBack.Text = "Back"
        objBack.ID = "LnkBack"
        objBack.NavigateUrl = "Mobile_Approvals.aspx"
        objBack.BreakAfter = False

        objLblBack.ID = "LblBack"
        objLblBack.Text = " | "
        objLblBack.BreakAfter = False

        Page.FindControl("frmProjectTimesheetApproval").Controls.Add(objBack)
        Page.FindControl("frmProjectTimesheetApproval").Controls.Add(objLblBack)

        'Logout Link
        Dim objLogOut As New Web.UI.MobileControls.Link()
        'Dim objLblLogout As New Web.UI.MobileControls.Label()

        objLogOut.Text = "Logout"
        objLogOut.ID = "LnkLogOut"
        objLogOut.NavigateUrl = "Mobile_PTApprovalList.aspx?Mode=Logout"
        'objLblLogout.ID = "LblLogout"
        'objLblLogout.Text = ""

        'Page.FindControl("frmProjectTimesheetApproval").Controls.Add(objLblLogout)
        Page.FindControl("frmProjectTimesheetApproval").Controls.Add(objLogOut)

        strDetails = Nothing
    End Sub

    Private Sub LogOut()
        'Logout
        HttpContext.Current.Session.Abandon()
        Response.Clear()
        Response.Redirect("Login.aspx")
    End Sub

End Class
