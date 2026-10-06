
Partial Class Mobile_RTApprovalList
    Inherits System.Web.UI.MobileControls.MobilePage

    Dim intPageNumber As Integer = 1
    Dim intNoofRecords As Integer
    Dim intNoofRecordsPerPage As Integer = 10
    Dim strPageNo As String
    Dim arrTimesheetID As New ArrayList()
    Dim strUserID As String
    Dim strUserName As String
    Private WithEvents objApproveCmd As New Web.UI.MobileControls.Command
    Private WithEvents objRejectCmd As New Web.UI.MobileControls.Command
    Dim objLbl1 As New Web.UI.MobileControls.Label
    Dim objLbl2 As New Web.UI.MobileControls.Label

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim dsTimesheet As DataSet
        Dim strDetails As New StringBuilder()
        Dim blnIsRecordExists As Boolean = False
        Dim strMode As String
        Dim strTimesheetID As String
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

        strUserID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString()
        strUserName = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "").ToString()

        'Paging
        dsTimesheet = CommonFunctions.Data.GetDataSet("usp_sel_tbl_PM_ResourceTimesheet_Approval " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString() + ",NULL,'R'", "TblLeaves", UseSQL:=True)
        intNoofRecords = dsTimesheet.Tables(0).Rows.Count

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
            LnkPrevious.NavigateUrl = "Mobile_RTApprovalList.aspx?PageNo=1"
        Else
            LnkPrevious.NavigateUrl = "Mobile_RTApprovalList.aspx?PageNo=" + (intPageNumber - 1).ToString()
        End If

        If strPageNo > Math.Ceiling(intNoofRecords / intNoofRecordsPerPage - 1).ToString() Then
            LnkNext.NavigateUrl = "Mobile_RTApprovalList.aspx?PageNo=" + Math.Ceiling(intNoofRecords / intNoofRecordsPerPage).ToString()
        Else
            LnkNext.NavigateUrl = "Mobile_RTApprovalList.aspx?PageNo=" + (intPageNumber + 1).ToString()
        End If

        LnkLast.NavigateUrl = "Mobile_RTApprovalList.aspx?PageNo=" + Math.Ceiling(intNoofRecords / intNoofRecordsPerPage).ToString()

        dsTimesheet = CommonFunctions.Data.GetDataSet("usp_sel_tbl_PM_ResourceTimesheet_Approval " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString() + ",NULL,'R'", "TblLeaves", (intPageNumber - 1) * intNoofRecordsPerPage, IIf(intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage < intNoofRecordsPerPage, intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage, intNoofRecordsPerPage), UseSQL:=True)

        'Plot Request list
        For Each drTimesheet As DataRow In dsTimesheet.Tables(0).Rows
            Dim objLink As New Web.UI.MobileControls.Link()
            Dim objTextView As New Web.UI.MobileControls.TextView()
            Dim objLbl As New Web.UI.MobileControls.Label()
            Dim objChkBox As New Web.UI.MobileControls.SelectionList

            strTimesheetID = CommonFunctions.Data.CheckIsDBNull(drTimesheet("TimesheetID"), "0").ToString()
            arrTimesheetID.Add(strTimesheetID)

            Dim objItem As New Web.UI.MobileControls.MobileListItem()

            Dim sym As New Encryption.Symmetric(Encryption.Symmetric.Provider.Rijndael)
            Dim key As New Encryption.Data("crazyFrogJumpsTo")
            Dim encryptedData As New Encryption.Data

            encryptedData = sym.Encrypt(New Encryption.Data(strTimesheetID), key)
            strEncryptedString = HttpUtility.UrlEncode(encryptedData.ToBase64)

            objLink.ID = "lnkTimesheet_" + strTimesheetID
            objLink.NavigateUrl = "Mobile_RTApproval.aspx?Token=" + strEncryptedString
            objLink.Text = CommonFunctions.Data.CheckIsDBNull(drTimesheet("EmployeeName"), "").ToString()

            objTextView.ID = "txtTimesheet_" + strTimesheetID

            strDetails.Append("From: ")
            If CommonFunctions.Data.CheckIsDBNull(drTimesheet("FromDate"), "").ToString() <> "" Then
                strDetails.Append(CommonFunctions.Dates.GetDate(drTimesheet("FromDate")) & " ")
            Else
                strDetails.Append("- ")
            End If

            strDetails.Append("To: ")
            If CommonFunctions.Data.CheckIsDBNull(drTimesheet("ToDate"), "").ToString() <> "" Then
                strDetails.Append(CommonFunctions.Dates.GetDate(drTimesheet("ToDate")) & " ")
            Else
                strDetails.Append("- ")
            End If

            strDetails.Append("Actual Work(Hrs): ") : strDetails.Append(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drTimesheet("TotalAMH"), "0.0"), 2) & " ")

            objTextView.Text = strDetails.ToString()
            strDetails.Length = 0

            objLbl.ID = "Lbl_" + strTimesheetID
            objLbl.Text = ""

            objItem.Value = strTimesheetID
            objItem.Text = " "
            objItem.ID = "ChkSelect" + strTimesheetID


            objChkBox.ID = "Chk" + strTimesheetID
            objChkBox.SelectType = MobileControls.ListSelectType.CheckBox
            objChkBox.BreakAfter = False
            objChkBox.Items.Add(objItem)

            Page.FindControl("frmRTApproval").Controls.Add(objChkBox)
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
        objLogOut.NavigateUrl = "Mobile_RTApprovalList.aspx?Mode=Logout"
        objLogOut.BreakAfter = False
        'objLblLogout.ID = "LblLogout"
        'objLblLogout.Text = ""

        'Page.FindControl("frmRTApproval").Controls.Add(objLblLogout)
        Page.FindControl("frmRTApproval").Controls.Add(objLogOut)

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

        Page.FindControl("frmRTApproval").Controls.Add(objLbl1)
        Page.FindControl("frmRTApproval").Controls.Add(objApproveCmd)
        Page.FindControl("frmRTApproval").Controls.Add(objLbl2)
        Page.FindControl("frmRTApproval").Controls.Add(objRejectCmd)


        strDetails = Nothing
    End Sub

    Private Sub LogOut()
        'Logout
        Session.Abandon()
        Response.Clear()
        Response.Redirect("Login.aspx")
    End Sub

    Private Sub CmdApprove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles CmdApprove.Click, objApproveCmd.Click
        Dim i As Integer
        Dim strQuery As String
        Dim m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage As String
        Dim m_drTimesheet As IDataReader
        Dim strDailyActivityID As String
        Dim dsTimesheet As DataSet
        Dim dteFromDate As String
        Dim dteToDate As String
        Dim strResourceID As String
        Dim blnSendMail As Boolean
        Dim dr As IDataReader

        ' send mail
        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 435", True)
        If dr.Read Then
            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

        For i = 0 To arrTimesheetID.Count - 1
            If Not HttpContext.Current.Request.Form("Chk" + arrTimesheetID(i).ToString()) Is Nothing Then
                dsTimesheet = CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_ResourceTimesheet " + arrTimesheetID(i).ToString(), "TblTimesheet")
                dteFromDate = CommonFunctions.Data.CheckIsDBNull(dsTimesheet.Tables(0).Rows(0)("FromDate")).ToString()
                dteToDate = CommonFunctions.Data.CheckIsDBNull(dsTimesheet.Tables(0).Rows(0)("ToDate")).ToString()
                strResourceID = CommonFunctions.Data.CheckIsDBNull(dsTimesheet.Tables(0).Rows(0)("EmployeeID")).ToString()

                strQuery = "usp_Sel_ResourceTimesheetDADetails " & arrTimesheetID(i).ToString() & "," & strUserID

                m_drTimesheet = CommonFunctions.Data.GetDataReader(strQuery, True)

                'Get Activity record details for the resource timesheet
                Do While m_drTimesheet.Read()
                    If CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("IsDisabled"), "0"), Integer) = "0" Then
                        strDailyActivityID = CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("DailyActivityEntryID"), "0").ToString()
                        '--- Execute sp to update verification details to Daily Activity Table
                        CommonFunctions.Data.InsertOrUpdateData("usp_Upd_PM_ResourceTimesheetVerification " + strDailyActivityID + ",1," + strUserID + ",'" + CType(Now(), String) + "',''", True)
                    End If
                Loop

                'Change Status to Verified in tbl_PM_ResourceTimesheetStatus table
                CommonFunctions.Data.InsertOrUpdateData("usp_Upd_tbl_PM_ResourceTimesheetStatus " & arrTimesheetID(i).ToString() & "," & strUserID & "," & "'V'", True)

                If blnSendMail Then
                    'Notify Project owener about approval 
                    CommonFunction.EmailMessages.ResourceTimesheetMessages.GetEmailMessage_435(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(strUserID, Integer), CType(strResourceID, Integer), CType(dteFromDate, Date), CType(dteToDate, Date))
                    CommonFunction.Emails.AppSendEmailWithCC(m_strToEmailID, m_strCCEmailID, m_strFromEmailID, m_strSubject, m_strMessage)
                End If

                CommonFunction.Data.DisposeDataReader(m_drTimesheet)
            End If
        Next
        Response.Redirect("Mobile_RTApprovalList.aspx")

    End Sub

    Private Sub CmdReject_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles CmdReject.Click, objRejectCmd.Click
        Dim i As Integer
        Dim strQuery As String
        Dim m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage As String
        Dim m_drTimesheet As IDataReader
        Dim strDailyActivityID As String
        Dim strRTEntry As New StringBuilder
        Dim dsTimesheet As DataSet
        Dim dteFromDate As String
        Dim dteToDate As String
        Dim strResourceID As String
        Dim blnSendMail As Boolean
        Dim dr As IDataReader

        ' send mail
        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 437", True)
        If dr.Read Then
            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

        For i = 0 To arrTimesheetID.Count - 1
            If Not HttpContext.Current.Request.Form("Chk" + arrTimesheetID(i).ToString()) Is Nothing Then
                dsTimesheet = CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_ResourceTimesheet " + arrTimesheetID(i).ToString(), "TblTimesheet")
                dteFromDate = CommonFunctions.Data.CheckIsDBNull(dsTimesheet.Tables(0).Rows(0)("FromDate")).ToString()
                dteToDate = CommonFunctions.Data.CheckIsDBNull(dsTimesheet.Tables(0).Rows(0)("ToDate")).ToString()
                strResourceID = CommonFunctions.Data.CheckIsDBNull(dsTimesheet.Tables(0).Rows(0)("EmployeeID")).ToString()

                strQuery = "usp_Sel_ResourceTimesheetDADetails " & arrTimesheetID(i).ToString() & "," & strUserID

                m_drTimesheet = CommonFunctions.Data.GetDataReader(strQuery, True)

                'Get Activity record details for the resource timesheet
                Do While m_drTimesheet.Read()
                    If CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("IsDisabled"), "0"), Integer) = "0" Then
                        strDailyActivityID = CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("DailyActivityEntryID"), "0").ToString()
                        '--- Execute sp to update verification details to Daily Activity Table
                        CommonFunctions.Data.InsertOrUpdateData("usp_Upd_PM_ResourceTimesheetVerification " + strDailyActivityID + ",0," + strUserID + ",'" + CType(Now(), String) + "','Rejected'", True)
                        If strRTEntry.ToString() = "" Then
                            strRTEntry.Append(strDailyActivityID)
                        Else
                            strRTEntry.Append("," + strDailyActivityID)
                        End If
                    End If
                Loop

                If strRTEntry.ToString() <> "" Then
                    CommonFunctions.Data.InsertOrUpdateData("usp_Upd_UnverifyResouceTimesheetStatus " + arrTimesheetID(i).ToString() + "," + strUserID + ",'" + strRTEntry.ToString() + "'", True)
                End If

                'Change Status to Verified in tbl_PM_ResourceTimesheetStatus table
                CommonFunctions.Data.InsertOrUpdateData("usp_Upd_tbl_PM_ResourceTimesheetStatus " & arrTimesheetID(i).ToString() & "," & strUserID & "," & "'J'", True)

                If blnSendMail Then
                    'Notify Project owener about rejection 
                    CommonFunction.EmailMessages.ResourceTimesheetMessages.GetEmailMessage_437(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(strUserID, Integer), CType(strResourceID, Integer), CType(dteFromDate, Date), CType(dteToDate, Date))
                    CommonFunction.Emails.AppSendEmailWithCC(m_strToEmailID, m_strCCEmailID, m_strFromEmailID, m_strSubject, m_strMessage)
                End If
                CommonFunction.Data.DisposeDataReader(m_drTimesheet)
            End If
        Next
        Response.Redirect("Mobile_RTApprovalList.aspx")
    End Sub
End Class
