
Partial Class Mobile_Approvals
    Inherits System.Web.UI.MobileControls.MobilePage

#Region "Variables"
    Private strMode As String
    Private intUserID As Integer
#End Region

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'Dim dsLeaves As DataSet
        'Dim dsTimesheet As DataSet
        'Dim dsProject As DataSet
        'Dim dsHelpDesk As DataSet
        'Dim dsProjectTimesheet As DataSet

        'If Session("intUserID") Is Nothing Then
        '    Call LogOut()
        'End If

        'strMode = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "").ToString()

        'If strMode.ToLower = "logout" Then
        '    Call LogOut()
        'End If

        'dsLeaves = CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_EmployeeLeaveDetails_Pending_Approval " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString(), "TblLeaves", UseSQL:=True)
        'dsTimesheet = CommonFunctions.Data.GetDataSet("usp_sel_tbl_PM_ResourceTimesheet_Approval " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString() + ",NULL,'R'", "TblLeaves", UseSQL:=True)
        'dsProject = CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_ProjectRevision_MobileApprovals " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString(), "TblProject", UseSQL:=True)
        'dsHelpDesk = CommonFunctions.Data.GetDataSet("usp_CRM_Sel_AllRequests_Mobile " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString(), "TblHelpDeskRequests", UseSQL:=True)
        'dsProjectTimesheet = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_PM_TimeSheetInvoice 1,NULL,NULL,NULL,NULL,NULL," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString(), "TblProjectTimesheet", UseSQL:=True)

        'If dsLeaves.Tables(0).Rows.Count = 0 Then
        '    LnkLeaveApproval.Visible = False
        'Else
        '    LnkLeaveApproval.Text = "Leave Approvals (" + FormatNumber(dsLeaves.Tables(0).Rows.Count, 0) + " approvals pending)"
        'End If

        'If dsTimesheet.Tables(0).Rows.Count = 0 Then
        '    LnkRTApprovals.Visible = False
        'Else
        '    LnkRTApprovals.Text = "Resource Timesheet Approvals (" + FormatNumber(dsTimesheet.Tables(0).Rows.Count, 0) + " approvals pending)"
        'End If

        'If dsProject.Tables(0).Rows.Count = 0 Then
        '    LnkProjectApprovals.Visible = False
        'Else
        '    LnkProjectApprovals.Text = "Project Approvals (" + FormatNumber(dsProject.Tables(0).Rows.Count, 0) + " approvals pending)"
        'End If

        'If dsHelpDesk.Tables(0).Rows.Count = 0 Then
        '    LnkHelpDesk.Visible = False
        'Else
        '    LnkHelpDesk.Text = "HelpDesk Requests (" + FormatNumber(dsHelpDesk.Tables(0).Rows.Count, 0) + " requests pending)"
        'End If

        'If dsProjectTimesheet.Tables(0).Rows.Count = 0 Then
        '    LnkProjectTimeSheet.Visible = False
        'Else
        '    LnkProjectTimeSheet.Text = "Project Timesheet Approval (" + FormatNumber(dsProjectTimesheet.Tables(0).Rows.Count, 0) + " requests pending)"
        'End If

        Dim dsRequests As DataSet
        Dim blnRequestsPending As Boolean = False

        If Session("intUserID") Is Nothing Then
            Call LogOut()
        End If

        strMode = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "").ToString()

        If strMode.ToLower = "logout" Then
            Call LogOut()
        End If

        intUserID = CType(Session("intUserID"), Integer)

        'Leave Approvals Link
        dsRequests = CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_EmployeeLeaveDetails_Pending_Approval " + intUserID.ToString(), "TblLeaves", UseSQL:=True)

        If dsRequests.Tables(0).Rows.Count = 0 Then
            LnkLeaveApproval.Visible = False
        Else
            blnRequestsPending = True
            LnkLeaveApproval.Text = "Leave Approvals (" + FormatNumber(dsRequests.Tables(0).Rows.Count, 0) + " approvals pending)"
        End If

        'Resource Timesheet Approvals Link 
        dsRequests = CommonFunctions.Data.GetDataSet("usp_sel_tbl_PM_ResourceTimesheet_Approval " + intUserID.ToString() + ",NULL,'R'", "Tbl_RT", UseSQL:=True)

        If dsRequests.Tables(0).Rows.Count = 0 Then
            LnkRTApprovals.Visible = False
        Else
            blnRequestsPending = True
            LnkRTApprovals.Text = "Resource Timesheet Approvals (" + FormatNumber(dsRequests.Tables(0).Rows.Count, 0) + " approvals pending)"
        End If

        'Project Approvals Link 
        dsRequests = CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_ProjectRevision_MobileApprovals " + intUserID.ToString(), "TblProject", UseSQL:=True)

        If dsRequests.Tables(0).Rows.Count = 0 Then
            LnkProjectApprovals.Visible = False
        Else
            blnRequestsPending = True
            LnkProjectApprovals.Text = "Project Transfer Approvals(" + FormatNumber(dsRequests.Tables(0).Rows.Count, 0) + " approvals pending)"
        End If

        'HelpDesk Approvals Link 
        dsRequests = CommonFunctions.Data.GetDataSet("usp_CRM_Sel_AllRequests_Mobile " + intUserID.ToString(), "TblHelpDeskRequests", UseSQL:=True)

        If dsRequests.Tables(0).Rows.Count = 0 Then
            LnkHelpDesk.Visible = False
        Else
            blnRequestsPending = True
            LnkHelpDesk.Text = "Help Desk Requests(" + FormatNumber(dsRequests.Tables(0).Rows.Count, 0) + " requests pending)"
        End If

        'Project Timesheet Approvals Link 
        dsRequests = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_PM_TimeSheetInvoice 1,NULL,NULL,NULL,NULL,NULL," + intUserID.ToString(), "TblProjectTimesheet", UseSQL:=True)

        If dsRequests.Tables(0).Rows.Count = 0 Then
            LnkProjectTimeSheet.Visible = False
        Else
            blnRequestsPending = True
            LnkProjectTimeSheet.Text = "Project Timesheet Approvals(" + FormatNumber(dsRequests.Tables(0).Rows.Count, 0) + " approvals pending)"
        End If

        If Not blnRequestsPending Then
            LblNoRequests.Visible = True
        End If

    End Sub

    Private Sub LogOut()
        Session.Abandon()
        Response.Clear()
        Response.Redirect("Login.aspx")
    End Sub

End Class
