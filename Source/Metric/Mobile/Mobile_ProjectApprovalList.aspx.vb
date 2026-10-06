
Partial Class Mobile_ProjectApprovalList
    Inherits System.Web.UI.MobileControls.MobilePage

    Dim intPageNumber As Integer = 1
    Dim intNoofRecords As Integer
    Dim intNoofRecordsPerPage As Integer = 10
    Dim strPageNo As String

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim dsProject As DataSet
        Dim strDetails As New StringBuilder()
        Dim blnIsRecordExists As Boolean = False
        Dim strMode As String
        Dim strProjectID As String
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
        dsProject = CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_ProjectRevision_MobileApprovals " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString(), "TblProject", UseSQL:=True)
        intNoofRecords = dsProject.Tables(0).Rows.Count

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
            LnkPrevious.NavigateUrl = "Mobile_ProjectApprovalList.aspx?PageNo=1"
        Else
            LnkPrevious.NavigateUrl = "Mobile_ProjectApprovalList.aspx?PageNo=" + (intPageNumber - 1).ToString()
        End If

        If strPageNo > Math.Ceiling(intNoofRecords / intNoofRecordsPerPage - 1).ToString() Then
            LnkNext.NavigateUrl = "Mobile_ProjectApprovalList.aspx?PageNo=" + Math.Ceiling(intNoofRecords / intNoofRecordsPerPage).ToString()
        Else
            LnkNext.NavigateUrl = "Mobile_ProjectApprovalList.aspx?PageNo=" + (intPageNumber + 1).ToString()
        End If

        LnkLast.NavigateUrl = "Mobile_ProjectApprovalList.aspx?PageNo=" + Math.Ceiling(intNoofRecords / intNoofRecordsPerPage).ToString()

        dsProject = CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_ProjectRevision_MobileApprovals " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString(), "TblProject", (intPageNumber - 1) * intNoofRecordsPerPage, IIf(intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage < intNoofRecordsPerPage, intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage, intNoofRecordsPerPage), UseSQL:=True)

        'Plot Request list
        For Each drProject As DataRow In dsProject.Tables(0).Rows
            Dim objLink As New Web.UI.MobileControls.Link()
            Dim objTextView As New Web.UI.MobileControls.TextView()
            Dim objLbl As New Web.UI.MobileControls.Label()

            strProjectID = CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "0").ToString()

            Dim sym As New Encryption.Symmetric(Encryption.Symmetric.Provider.Rijndael)
            Dim key As New Encryption.Data("crazyFrogJumpsTo")
            Dim encryptedData As New Encryption.Data

            encryptedData = sym.Encrypt(New Encryption.Data(strProjectID), key)
            strEncryptedString = HttpUtility.UrlEncode(encryptedData.ToBase64)

            objLink.ID = "lnkProject_" + strProjectID
            objLink.NavigateUrl = "Mobile_ProjectApproval.aspx?Token=" + strEncryptedString
            objLink.Text = CommonFunctions.Data.CheckIsDBNull(drProject("ProjectCode"), "").ToString() + " / " + CommonFunctions.Data.CheckIsDBNull(drProject("ProjectName"), "").ToString()

            objTextView.ID = "txtPropect_" + strProjectID

            strDetails.Append("<b>Start Date: </b>")
            If CommonFunctions.Data.CheckIsDBNull(drProject("ExpectedStartDate"), "").ToString() <> "" Then
                strDetails.Append(CommonFunctions.Dates.GetDate(drProject("ExpectedStartDate")) & " ")
            Else
                strDetails.Append("- ")
            End If

            strDetails.Append("  <b>End Date: </b>")
            If CommonFunctions.Data.CheckIsDBNull(drProject("ExpectedEndDate"), "").ToString() <> "" Then
                strDetails.Append(CommonFunctions.Dates.GetDate(drProject("ExpectedEndDate")) & " ")
            Else
                strDetails.Append("- ")
            End If
            strDetails.Append("  <b>Work (Hrs): </b>")
            strDetails.Append(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drProject("EstimatedEfforts"), "0.0"), 2))
            strDetails.Append("  <b>Project Value: </b>")
            strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drProject("CurrencyCode"), "") & " " & FormatNumber(CommonFunctions.Data.CheckIsDBNull(drProject("ContractValue"), "0.0"), 2))
            strDetails.Append("  <b>Organization Unit: </b>" + CommonFunctions.Data.CheckIsDBNull(drProject("Location"), "").ToString())
            strDetails.Append("  <b>Practice: </b>" + CommonFunctions.Data.CheckIsDBNull(drProject("ProjectType"), "").ToString())

            objTextView.Text = strDetails.ToString()
            strDetails.Length = 0

            objLbl.ID = "Lbl_" + strProjectID
            objLbl.Text = ""

            Page.FindControl("frmProjectApproval").Controls.Add(objLink)
            Page.FindControl("frmProjectApproval").Controls.Add(objTextView)
            Page.FindControl("frmProjectApproval").Controls.Add(objLbl)
            blnIsRecordExists = True
        Next

        If Not blnIsRecordExists Then
            Dim objLabel As New Web.UI.MobileControls.Label()
            objLabel.Text = "There are no items to show in this view."
            Page.FindControl("frmProjectApproval").Controls.Add(objLabel)
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

        Page.FindControl("frmProjectApproval").Controls.Add(objBack)
        Page.FindControl("frmProjectApproval").Controls.Add(objLblBack)

        'Logout Link
        Dim objLogOut As New Web.UI.MobileControls.Link()
        'Dim objLblLogout As New Web.UI.MobileControls.Label()

        objLogOut.Text = "Logout"
        objLogOut.ID = "LnkLogOut"
        objLogOut.NavigateUrl = "Mobile_ProjectApprovalList.aspx?Mode=Logout"
        'objLblLogout.ID = "LblLogout"
        'objLblLogout.Text = ""

        'Page.FindControl("frmProjectApproval").Controls.Add(objLblLogout)
        Page.FindControl("frmProjectApproval").Controls.Add(objLogOut)

        strDetails = Nothing
    End Sub

    Private Sub LogOut()
        'Logout
        HttpContext.Current.Session.Abandon()
        Response.Clear()
        Response.Redirect("Login.aspx")
    End Sub

End Class
