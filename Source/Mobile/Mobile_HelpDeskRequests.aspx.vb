
Partial Class Mobile_HelpDeskRequests
    Inherits System.Web.UI.MobileControls.MobilePage

    Dim intPageNumber As Integer = 1
    Dim intNoofRecords As Integer
    Dim intNoofRecordsPerPage As Integer = 10
    Dim strPageNo As String

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim dsHelpDesk As DataSet
        Dim strDetails As New StringBuilder()
        Dim blnIsRecordExists As Boolean = False
        Dim strMode As String
        Dim strRequestID As String
        Dim strEncryptedString As String

        'Session Expired
        If Session("intUserID") Is Nothing Then
            Call LogOut()
        End If

        'Logout
        strMode = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "").ToString()
        If strMode.ToLower = "logout" Then
            Call LogOut()
        End If

        'Paging
        dsHelpDesk = CommonFunctions.Data.GetDataSet("usp_CRM_Sel_AllRequests_Mobile " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString(), "TblHelpDeskRequests", UseSQL:=True)
        intNoofRecords = dsHelpDesk.Tables(0).Rows.Count

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
            LnkPrevious.NavigateUrl = "Mobile_HelpDeskRequests.aspx?PageNo=1"
        Else
            LnkPrevious.NavigateUrl = "Mobile_HelpDeskRequests.aspx?PageNo=" + (intPageNumber - 1).ToString()
        End If

        If strPageNo > Math.Ceiling(intNoofRecords / intNoofRecordsPerPage - 1).ToString() Then
            LnkNext.NavigateUrl = "Mobile_HelpDeskRequests.aspx?PageNo=" + Math.Ceiling(intNoofRecords / intNoofRecordsPerPage).ToString()
        Else
            LnkNext.NavigateUrl = "Mobile_HelpDeskRequests.aspx?PageNo=" + (intPageNumber + 1).ToString()
        End If

        LnkLast.NavigateUrl = "Mobile_HelpDeskRequests.aspx?PageNo=" + Math.Ceiling(intNoofRecords / intNoofRecordsPerPage).ToString()

        dsHelpDesk = CommonFunctions.Data.GetDataSet("usp_CRM_Sel_AllRequests_Mobile " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString(), "TblHelpDeskRequests", (intPageNumber - 1) * intNoofRecordsPerPage, IIf(intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage < intNoofRecordsPerPage, intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage, intNoofRecordsPerPage), UseSQL:=True)

        'Plot Request list
        For Each drHelpDesk As DataRow In dsHelpDesk.Tables(0).Rows
            Dim objLink As New Web.UI.MobileControls.Link()
            Dim objTextView As New Web.UI.MobileControls.TextView()
            Dim objLbl As New Web.UI.MobileControls.Label()

            strRequestID = CommonFunctions.Data.CheckIsDBNull(drHelpDesk("QueryID"), "0").ToString()

            Dim sym As New Encryption.Symmetric(Encryption.Symmetric.Provider.Rijndael)
            Dim key As New Encryption.Data("crazyFrogJumpsTo")
            Dim encryptedData As New Encryption.Data

            encryptedData = sym.Encrypt(New Encryption.Data(strRequestID), key)
            strEncryptedString = HttpUtility.UrlEncode(encryptedData.ToBase64)

            objLink.ID = "lnkQuery" + strRequestID
            objLink.NavigateUrl = "PostDiscussion.aspx?Token=" + strEncryptedString
            objLink.Text = "Post Discussion"

            objTextView.ID = "txtRequest" + strRequestID

            strDetails.Append("<b>RequestID: </b>" + CommonFunctions.Data.CheckIsDBNull(drHelpDesk("QueryID"), "").ToString() + " <b>Subject: </b>" + CommonFunctions.Data.CheckIsDBNull(drHelpDesk("Subject"), "").ToString() + "</b>")

            strDetails.Append("<br/><b>Request Type: </b>")
            strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drHelpDesk("RequestType"), "-") & " ")

            strDetails.Append("<b>Priority: </b>")
            strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drHelpDesk("Priority"), "-") & " ")

            'strDetails.Append(" <b>Requestor: </b>")
            'strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drHelpDesk("CustomerName"), "-") & " ")

            strDetails.Append(" <b>Requestor : </b>")
            strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drHelpDesk("CustomerID"), "-") & " ")

            objTextView.Text = strDetails.ToString()
            strDetails.Length = 0

            objLbl.ID = "Lbl_" + strRequestID
            objLbl.Text = ""

            Page.FindControl("frmRTApproval").Controls.Add(objLink)
            Page.FindControl("frmRTApproval").Controls.Add(objTextView)
            Page.FindControl("frmRTApproval").Controls.Add(objLbl)
            blnIsRecordExists = True
        Next

        If Not blnIsRecordExists Then
            Dim objLabel As New Web.UI.MobileControls.Label()
            objLabel.Text = "There are no items to show in this view."
            Page.FindControl("frmRTApproval").Controls.Add(objLabel)
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

        Page.FindControl("frmRTApproval").Controls.Add(objBack)
        Page.FindControl("frmRTApproval").Controls.Add(objLblBack)

        'Logout Link
        Dim objLogOut As New Web.UI.MobileControls.Link()
        'Dim objLblLogout As New Web.UI.MobileControls.Label()

        objLogOut.Text = "Logout"
        objLogOut.ID = "LnkLogOut"
        'objLogOut.NavigateUrl = "Mobile_HelpDeskRequests.aspx?Mode=Logout"
        'objLblLogout.ID = "LblLogout"
        'objLblLogout.Text = ""

        'Page.FindControl("frmRTApproval").Controls.Add(objLblLogout)
        Page.FindControl("frmRTApproval").Controls.Add(objLogOut)

        strDetails = Nothing
    End Sub

    Private Sub LogOut()
        'Logout
        Session.Abandon()
        Response.Clear()
        Response.Redirect("Login.aspx")
    End Sub

End Class
