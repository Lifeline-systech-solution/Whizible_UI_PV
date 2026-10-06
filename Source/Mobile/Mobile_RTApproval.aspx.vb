
Partial Class Mobile_RTApproval
    Inherits System.Web.UI.MobileControls.MobilePage

    Private strTimesheetID As String
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

        strTimesheetID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Token"), "").ToString()

        Dim sym As New Encryption.Symmetric(Encryption.Symmetric.Provider.Rijndael)
        Dim key As New Encryption.Data("crazyFrogJumpsTo")
        Dim encryptedData As New Encryption.Data
        encryptedData.Base64 = strTimesheetID

        Dim decrypteddata As Encryption.Data
        decrypteddata = sym.Decrypt(encryptedData, key)
        strTimesheetID = HttpUtility.UrlDecode(decrypteddata.ToString)

        dsTimesheet = CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_ResourceTimesheet " + strTimesheetID, "TblTimesheet")

        If dsTimesheet.Tables(0).Rows.Count > 0 Then
            TxtEmployeeName.Text = "<b>Employee Name:</b> " + CommonFunctions.Data.CheckIsDBNull(dsTimesheet.Tables(0).Rows(0)("EmployeeName"))

            strText.Append("<b>Period:</b> ")
            If CommonFunctions.Data.CheckIsDBNull(dsTimesheet.Tables(0).Rows(0)("FromDate")).ToString() = "" Then
                strText.Append(" - ")
            Else
                strText.Append(CommonFunctions.Dates.CGetDate(dsTimesheet.Tables(0).Rows(0)("FromDate")))
            End If
            strText.Append(" <b>To</b> ")
            If CommonFunctions.Data.CheckIsDBNull(dsTimesheet.Tables(0).Rows(0)("ToDate")).ToString() = "" Then
                strText.Append(" - ")
            Else
                strText.Append(CommonFunctions.Dates.CGetDate(dsTimesheet.Tables(0).Rows(0)("ToDate")))
            End If
            TxtPeriod.Text = strText.ToString()
            strText.Length = 0


            dteFromDate = CommonFunctions.Data.CheckIsDBNull(dsTimesheet.Tables(0).Rows(0)("FromDate")).ToString()
            dteToDate = CommonFunctions.Data.CheckIsDBNull(dsTimesheet.Tables(0).Rows(0)("ToDate")).ToString()
            strResourceID = CommonFunctions.Data.CheckIsDBNull(dsTimesheet.Tables(0).Rows(0)("EmployeeID")).ToString()
        End If

        strText.Append("<b>Timesheet Details</b><br/>")
        For Each drTimesheet As DataRow In dsTimesheet.Tables(0).Rows
            strText.Append("<b>Project: </b>" + CommonFunctions.Data.CheckIsDBNull(drTimesheet("ProjectName")))
            strText.Append("    <b>Actual Work(Hrs): </b>" + FormatNumber(CommonFunctions.Data.CheckIsDBNull(drTimesheet("WorkHrs"), "0.0"), 2))
            strText.Append("<br/>")
            dblTotalWorkHrs += CType(CommonFunctions.Data.CheckIsDBNull(drTimesheet("WorkHrs"), "0.0"), Double)
        Next
        TxtProjectDetails.Text = strText.ToString()
        strText.Length = 0

        TxtSummary.Text = "<b>Total Work(Hrs) for the period: </b>" + FormatNumber(dblTotalWorkHrs)

        ''Logout Link
        'Dim objLogOut As New Web.UI.MobileControls.Link()
        'Dim objLblLogout As New Web.UI.MobileControls.Label()

        'objLogOut.Text = "Logout"
        'objLogOut.ID = "LnkLogOut"
        'objLogOut.NavigateUrl = "Mobile_RTApproval.aspx?Mode=Logout"
        'objLblLogout.ID = "LblLogout"
        'objLblLogout.Text = ""

        'Page.FindControl("frmRTApprovalEdit").Controls.Add(objLblLogout)
        'Page.FindControl("frmRTApprovalEdit").Controls.Add(objLogOut)
    End Sub

    Protected Sub Approve_OnClick(ByVal sender As Object, ByVal e As System.EventArgs) Handles CmdApprove.Click
        Dim strQuery As String
        Dim m_drTimesheet As IDataReader
        Dim strDailyActivityID As String
        Dim m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage As String
        Dim blnSendMail As Boolean
        Dim dr As IDataReader

        If Page.IsValid Then
            strQuery = "usp_Sel_ResourceTimesheetDADetails " & strTimesheetID & "," & CType(Session("intUserID"), String)

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
            CommonFunctions.Data.InsertOrUpdateData("usp_Upd_tbl_PM_ResourceTimesheetStatus " & strTimesheetID & "," & strUserID & "," & "'V'", True)

            ' send mail
            dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 435", True)
            If dr.Read Then
                blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
            End If
            CommonFunctions.Data.DisposeDataReader(dr)

            If blnSendMail Then
                'Notify Project owener about approval 
                CommonFunction.EmailMessages.ResourceTimesheetMessages.GetEmailMessage_435(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(strUserID, Integer), CType(strResourceID, Integer), CType(dteFromDate, Date), CType(dteToDate, Date))
                CommonFunction.Emails.AppSendEmailWithCC(m_strToEmailID, m_strCCEmailID, m_strFromEmailID, m_strSubject, m_strMessage)
            End If

            CommonFunction.Data.DisposeDataReader(m_drTimesheet)
            Response.Redirect("Mobile_RTApprovalList.aspx")
        End If

    End Sub

    Protected Sub Reject_OnClick(ByVal sender As Object, ByVal e As System.EventArgs) Handles CmdReject.Click
        Dim strQuery As String
        Dim m_drTimesheet As IDataReader
        Dim strDailyActivityID As String
        Dim strRTEntry As New StringBuilder
        Dim m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage As String
        Dim blnSendMail As Boolean
        Dim dr As IDataReader

        If Page.IsValid Then
            strQuery = "usp_Sel_ResourceTimesheetDADetails " & strTimesheetID & "," & CType(Session("intUserID"), String)

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
                CommonFunctions.Data.InsertOrUpdateData("usp_Upd_UnverifyResouceTimesheetStatus " + strTimesheetID + "," + CType(Session("intUserID"), String) + ",'" + strRTEntry.ToString() + "'", True)
            End If

            'Change Status to Verified in tbl_PM_ResourceTimesheetStatus table
            CommonFunctions.Data.InsertOrUpdateData("usp_Upd_tbl_PM_ResourceTimesheetStatus " & strTimesheetID & "," & strUserID & "," & "'J'", True)

            ' send mail
            dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 437", True)
            If dr.Read Then
                blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
            End If
            CommonFunctions.Data.DisposeDataReader(dr)

            If blnSendMail Then
                'Notify Project owener about rejection 
                CommonFunction.EmailMessages.ResourceTimesheetMessages.GetEmailMessage_437(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(strUserID, Integer), CType(strResourceID, Integer), CType(dteFromDate, Date), CType(dteToDate, Date))
                CommonFunction.Emails.AppSendEmailWithCC(m_strToEmailID, m_strCCEmailID, m_strFromEmailID, m_strSubject, m_strMessage)
            End If

            CommonFunction.Data.DisposeDataReader(m_drTimesheet)
            Response.Redirect("Mobile_RTApprovalList.aspx")
        End If
    End Sub

    Private Sub LogOut()
        Session.Abandon()
        Response.Clear()
        Response.Redirect("Login.aspx")
    End Sub

End Class


