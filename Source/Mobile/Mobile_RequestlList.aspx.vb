
Partial Class Mobile_RequestList
    Inherits System.Web.UI.MobileControls.MobilePage

#Region "Member Variables"
    Private intPageNumber As Integer = 1
    Private intNoofRecords As Integer
    Private intNoofRecordsPerPage As Integer = 10
    Private strPageNo As String
    Private arrLeaveID As New ArrayList()
    Private strUserID As String
    Private strUserName As String
    Private strMode As String = ""
    Private dsApprovalRequests As DataSet

    Private WithEvents objApproveCmd As New Web.UI.MobileControls.Command
    Private WithEvents objRejectCmd As New Web.UI.MobileControls.Command
    Private objLbl1 As New Web.UI.MobileControls.Label
    Private objLbl2 As New Web.UI.MobileControls.Label
    'Private strCurrency As String = ""
    'Private strType As String = ""

    'Private Enum EmployeeTransfer
    '    Grade = 1
    '    Role = 2
    '    EmployeeType = 3
    '    Designation = 4
    '    ReportingManager = 5
    '    CostCenter = 9
    '    OrganizationStucture = 10
    'End Enum

#End Region

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Session Expired
        If Session("intUserID") Is Nothing Then
            Call LogOut()
        End If


        strMode = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "").ToString()
        'strType = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Type"), "").ToString()

        strUserID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString()
        strUserName = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "").ToString()
        'strCurrency = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_CompanyInformation_Currency", True))).ToString()

        Select Case strMode.ToLower

            Case "logout"
                Call LogOut()

            Case "leave"
                PageCaption.Text = "Leave Approvals"
                Call PlotLeaveApprovalRequestList()

            Case "resourcetimesheet"
                PageCaption.Text = "Resource Timesheet Approvals"
                Call PlotRTApprovalRequestList()

            Case "project"
                PageCaption.Text = "Project Approvals"
                Call PlotProjectApprovalRequestList()

            Case "helpdesk"
                CmdApprove.Visible = False
                CmdReject.Visible = False
                LblBar4.Visible = False
                LblBar5.Visible = False
                PageCaption.Text = "Help Desks Requests"
                Call PlotHelpDesksRequestList()

            Case "projecttimesheet"
                PageCaption.Text = "Project Timesheet Approvals"
                Call PlotProjectTimesheetApprovalRequestList()

        End Select


        If intNoofRecords <= intNoofRecordsPerPage Then
            LnkFirst.Visible = False
            LnkPrevious.Visible = False
            LnkNext.Visible = False
            LnkLast.Visible = False
            LblBar1.Visible = False
            LblBar2.Visible = False
            LblBar3.Visible = False
        End If

        If intNoofRecords = 0 Then
            LblBar4.Visible = False
            LblBar5.Visible = False
            CmdApprove.Visible = False
            CmdReject.Visible = False
        End If

        Dim objBack As New Web.UI.MobileControls.Link()
        Dim objLblBack As New Web.UI.MobileControls.Label()

        'Back Link
        objBack.Text = "Back"
        objBack.ID = "LnkBack"
        objBack.NavigateUrl = "Mobile_Approvals.aspx"

        objBack.BreakAfter = False
        objLblBack.Text = " | "
        objLblBack.BreakAfter = False

        Page.FindControl("frmRequestList").Controls.Add(objBack)
        Page.FindControl("frmRequestList").Controls.Add(objLblBack)


        'Logout Link
        Dim objLogOut As New Web.UI.MobileControls.Link()

        objLogOut.Text = "Logout"
        objLogOut.ID = "LnkLogOut"
        objLogOut.NavigateUrl = "Mobile_RequestlList.aspx?Mode=Logout"
        objLogOut.BreakAfter = False

        Page.FindControl("frmRequestList").Controls.Add(objLogOut)


        If intNoofRecords > 0 Then
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

            If strMode.ToLower() <> "helpdesk" Then
                Page.FindControl("frmRequestList").Controls.Add(objLbl1)
                Page.FindControl("frmRequestList").Controls.Add(objApproveCmd)
                Page.FindControl("frmRequestList").Controls.Add(objLbl2)
                Page.FindControl("frmRequestList").Controls.Add(objRejectCmd)
            End If

        End If


    End Sub

    Private Sub PlotLeaveApprovalRequestList()
        '=====================================================================
        ' Procedure Name        : PlotLeaveApprovalRequestList()
        ' Purpose               : To plot list of leave requests to be approved/rejected
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Amol Changle
        ' Created               : 22 Apr 2009
        ' Revisions             :
        '=====================================================================
        Dim strDetails As New StringBuilder()
        Dim blnIsRecordExists As Boolean = False
        Dim strLeaveID As String
        Dim strEncryptedString As String

        dsApprovalRequests = CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_EmployeeLeaveDetails_Pending_Approval " + strUserID, "TblLeaves", UseSQL:=True)
        Call DrawPaging()
        dsApprovalRequests = CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_EmployeeLeaveDetails_Pending_Approval " + strUserID, "TblLeaves", (intPageNumber - 1) * intNoofRecordsPerPage, IIf(intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage < intNoofRecordsPerPage, intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage, intNoofRecordsPerPage), UseSQL:=True)

        'Plot Request list
        For Each drLeaves As DataRow In dsApprovalRequests.Tables(0).Rows
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
            objLink.NavigateUrl = "Mobile_RequestApprovalRejection.aspx?Mode=" + strMode + "&Token=" + strEncryptedString
            objLink.Text = CommonFunctions.Data.CheckIsDBNull(drLeaves("EmployeeName"), "").ToString()

            objTextView.ID = "txtLeave_" + strLeaveID

            strDetails.Append("Employee ID: ") : strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drLeaves("EmployeeCode"), "").ToString() & " ")
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
            strDetails.Append("Half day: ") : strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drLeaves("HalfDay")).ToString() & " ")
            strDetails.Append("No. of Days: ") : strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drLeaves("NumberOfDays"), "0.0").ToString() & " ")
            strDetails.Append("Leave Balance: ") : strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drLeaves("LeaveBalance"), "0.0").ToString() & " ")

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

            Page.FindControl("frmRequestList").Controls.Add(objChkBox)
            Page.FindControl("frmRequestList").Controls.Add(objLink)
            Page.FindControl("frmRequestList").Controls.Add(objTextView)
            Page.FindControl("frmRequestList").Controls.Add(objLbl)
            blnIsRecordExists = True
        Next

        If Not blnIsRecordExists Then
            Dim objLabel As New Web.UI.MobileControls.Label()
            objLabel.Text = "There are no items to show in this view."
            Page.FindControl("frmRequestList").Controls.Add(objLabel)
        End If

        strDetails = Nothing

    End Sub

    Private Sub PlotRTApprovalRequestList()
        '=====================================================================
        ' Procedure Name        : PlotRTApprovalRequestList()
        ' Purpose               : To plot list of Resource Timesheet requests to be approved/rejected
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Amol Changle
        ' Created               : 22 Apr 2009
        ' Revisions             :
        '=====================================================================
        Dim strDetails As New StringBuilder()
        Dim blnIsRecordExists As Boolean = False
        Dim strTimesheetID As String
        Dim strEncryptedString As String

        dsApprovalRequests = CommonFunctions.Data.GetDataSet("usp_sel_tbl_PM_ResourceTimesheet_Approval " + strUserID + ",NULL,'R'", "TblRT", UseSQL:=True)
        Call DrawPaging()
        dsApprovalRequests = CommonFunctions.Data.GetDataSet("usp_sel_tbl_PM_ResourceTimesheet_Approval " + strUserID + ",NULL,'R'", "TblRT", (intPageNumber - 1) * intNoofRecordsPerPage, IIf(intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage < intNoofRecordsPerPage, intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage, intNoofRecordsPerPage), UseSQL:=True)

        'Plot Request list
        For Each drRT As DataRow In dsApprovalRequests.Tables(0).Rows
            Dim objLink As New Web.UI.MobileControls.Link()
            Dim objTextView As New Web.UI.MobileControls.TextView()
            Dim objLbl As New Web.UI.MobileControls.Label()
            Dim objChkBox As New Web.UI.MobileControls.SelectionList


            strTimesheetID = CommonFunctions.Data.CheckIsDBNull(drRT("TimesheetID"), "0").ToString()
            arrLeaveID.Add(strTimesheetID)

            Dim objItem As New Web.UI.MobileControls.MobileListItem(strTimesheetID, strTimesheetID)

            Dim sym As New Encryption.Symmetric(Encryption.Symmetric.Provider.Rijndael)
            Dim key As New Encryption.Data("crazyFrogJumpsTo")
            Dim encryptedData As New Encryption.Data

            encryptedData = sym.Encrypt(New Encryption.Data(strTimesheetID), key)
            strEncryptedString = HttpUtility.UrlEncode(encryptedData.ToBase64)

            objLink.ID = "lnkLeave_" + strTimesheetID
            objLink.NavigateUrl = "Mobile_RequestApprovalRejection.aspx?Mode=" + strMode + "&Token=" + strEncryptedString
            objLink.Text = CommonFunctions.Data.CheckIsDBNull(drRT("EmployeeName"), "").ToString()

            objTextView.ID = "txtLeave_" + strTimesheetID

            strDetails.Append("Employee ID: ") : strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drRT("EmployeeCode"), "").ToString() & " ")
            strDetails.Append("From: ")
            If CommonFunctions.Data.CheckIsDBNull(drRT("FromDate"), "").ToString() <> "" Then
                strDetails.Append(CommonFunctions.Dates.GetDate(drRT("FromDate")) & " ")
            Else
                strDetails.Append("- ")
            End If

            strDetails.Append("To: ")
            If CommonFunctions.Data.CheckIsDBNull(drRT("ToDate"), "").ToString() <> "" Then
                strDetails.Append(CommonFunctions.Dates.GetDate(drRT("ToDate")) & " ")
            Else
                strDetails.Append("- ")
            End If

            strDetails.Append("Actual Work(Hrs): ") : strDetails.Append(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drRT("TotalAMH"), "0.0"), 2) & " ")

            objTextView.Text = strDetails.ToString()
            strDetails.Length = 0

            objLbl.ID = "Lbl_" + CommonFunctions.Data.CheckIsDBNull(drRT("TimesheetID"), "0").ToString()
            objLbl.Text = ""

            objItem.Value = strTimesheetID
            objItem.Text = " "
            objItem.ID = "ChkSelect" + strTimesheetID


            objChkBox.ID = "Chk" + strTimesheetID
            objChkBox.SelectType = MobileControls.ListSelectType.CheckBox
            objChkBox.BreakAfter = False
            objChkBox.Items.Add(objItem)

            Page.FindControl("frmRequestList").Controls.Add(objChkBox)
            Page.FindControl("frmRequestList").Controls.Add(objLink)
            Page.FindControl("frmRequestList").Controls.Add(objTextView)
            Page.FindControl("frmRequestList").Controls.Add(objLbl)
            blnIsRecordExists = True
        Next

        If Not blnIsRecordExists Then
            Dim objLabel As New Web.UI.MobileControls.Label()
            objLabel.Text = "There are no items to show in this view."
            Page.FindControl("frmRequestList").Controls.Add(objLabel)
        End If

        strDetails = Nothing

    End Sub

    Private Sub PlotProjectApprovalRequestList()
        '=====================================================================
        ' Procedure Name        : PlotProjectApprovalRequestList()
        ' Purpose               : To plot list of Project requests to be approved/rejected
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Amol Changle
        ' Created               : 22 Apr 2009
        ' Revisions             :
        '=====================================================================
        Dim strDetails As New StringBuilder()
        Dim blnIsRecordExists As Boolean = False
        Dim strProjectID As String
        Dim strEncryptedString As String

        dsApprovalRequests = CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_ProjectRevision_MobileApprovals " + strUserID, "TblProject", UseSQL:=True)
        Call DrawPaging()
        dsApprovalRequests = CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_ProjectRevision_MobileApprovals " + strUserID, "TblProject", (intPageNumber - 1) * intNoofRecordsPerPage, IIf(intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage < intNoofRecordsPerPage, intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage, intNoofRecordsPerPage), UseSQL:=True)

        'Plot Request list
        For Each drProject As DataRow In dsApprovalRequests.Tables(0).Rows
            Dim objLink As New Web.UI.MobileControls.Link()
            Dim objTextView As New Web.UI.MobileControls.TextView()
            Dim objLbl As New Web.UI.MobileControls.Label()
            Dim objChkBox As New Web.UI.MobileControls.SelectionList


            strProjectID = CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "0").ToString()
            arrLeaveID.Add(strProjectID)

            Dim objItem As New Web.UI.MobileControls.MobileListItem(strProjectID, strProjectID)

            Dim sym As New Encryption.Symmetric(Encryption.Symmetric.Provider.Rijndael)
            Dim key As New Encryption.Data("crazyFrogJumpsTo")
            Dim encryptedData As New Encryption.Data

            encryptedData = sym.Encrypt(New Encryption.Data(strProjectID), key)
            strEncryptedString = HttpUtility.UrlEncode(encryptedData.ToBase64)

            objLink.ID = "lnkLeave_" + strProjectID
            objLink.NavigateUrl = "Mobile_RequestApprovalRejection.aspx?Mode=" + strMode + "&Token=" + strEncryptedString
            objLink.Text = CommonFunctions.Data.CheckIsDBNull(drProject("ProjectCode"), "").ToString() + " / " + CommonFunctions.Data.CheckIsDBNull(drProject("ProjectName"), "").ToString()

            objTextView.ID = "txtLeave_" + strProjectID

            strDetails.Append("Start Date: ")
            If CommonFunctions.Data.CheckIsDBNull(drProject("ExpectedStartDate"), "").ToString() <> "" Then
                strDetails.Append(CommonFunctions.Dates.GetDate(drProject("ExpectedStartDate")) & " ")
            Else
                strDetails.Append("- ")
            End If

            strDetails.Append("  End Date: ")
            If CommonFunctions.Data.CheckIsDBNull(drProject("ExpectedEndDate"), "").ToString() <> "" Then
                strDetails.Append(CommonFunctions.Dates.GetDate(drProject("ExpectedEndDate")) & " ")
            Else
                strDetails.Append("- ")
            End If
            strDetails.Append("  Work (Hrs): ")
            strDetails.Append(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drProject("EstimatedEfforts"), "0.0"), 2))
            strDetails.Append("  Project Value: ")
            strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drProject("CurrencyCode"), "") & " " & FormatNumber(CommonFunctions.Data.CheckIsDBNull(drProject("ContractValue"), "0.0"), 2))
            strDetails.Append("  Organization Unit: " + CommonFunctions.Data.CheckIsDBNull(drProject("Location"), "").ToString())
            strDetails.Append("  Practice: " + CommonFunctions.Data.CheckIsDBNull(drProject("ProjectType"), "").ToString())

            objTextView.Text = strDetails.ToString()
            strDetails.Length = 0

            objLbl.ID = "Lbl_" + CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "0").ToString()
            objLbl.Text = ""

            objItem.Value = strProjectID
            objItem.Text = " "
            objItem.ID = "ChkSelect" + strProjectID


            objChkBox.ID = "Chk" + strProjectID
            objChkBox.SelectType = MobileControls.ListSelectType.CheckBox
            objChkBox.BreakAfter = False
            objChkBox.Items.Add(objItem)

            Page.FindControl("frmRequestList").Controls.Add(objChkBox)
            Page.FindControl("frmRequestList").Controls.Add(objLink)
            Page.FindControl("frmRequestList").Controls.Add(objTextView)
            Page.FindControl("frmRequestList").Controls.Add(objLbl)
            blnIsRecordExists = True
        Next

        If Not blnIsRecordExists Then
            Dim objLabel As New Web.UI.MobileControls.Label()
            objLabel.Text = "There are no items to show in this view."
            Page.FindControl("frmRequestList").Controls.Add(objLabel)
        End If

        strDetails = Nothing

    End Sub

    Private Sub PlotHelpDesksRequestList()
        '=====================================================================
        ' Procedure Name        : PlotHelpDesksRequestList()
        ' Purpose               : To plot list of Help Desks requests
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Amol Changle
        ' Created               : 22 Apr 2009
        ' Revisions             :
        '=====================================================================
        Dim strDetails As New StringBuilder()
        Dim blnIsRecordExists As Boolean = False
        Dim strRequestID As String
        Dim strEncryptedString As String

        dsApprovalRequests = CommonFunctions.Data.GetDataSet("usp_CRM_Sel_AllRequests_Mobile " + strUserID, "TblHelpDesksRequests", UseSQL:=True)
        Call DrawPaging()
        dsApprovalRequests = CommonFunctions.Data.GetDataSet("usp_CRM_Sel_AllRequests_Mobile " + strUserID, "TblHelpDesksRequests", (intPageNumber - 1) * intNoofRecordsPerPage, IIf(intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage < intNoofRecordsPerPage, intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage, intNoofRecordsPerPage), UseSQL:=True)

        'Plot Request list
        For Each drHelpDesk As DataRow In dsApprovalRequests.Tables(0).Rows
            Dim objLink As New Web.UI.MobileControls.Link()
            Dim objTextView As New Web.UI.MobileControls.TextView()
            Dim objLbl As New Web.UI.MobileControls.Label()


            strRequestID = CommonFunctions.Data.CheckIsDBNull(drHelpDesk("QueryID"), "0").ToString()
            arrLeaveID.Add(strRequestID)

            Dim objItem As New Web.UI.MobileControls.MobileListItem(strRequestID, strRequestID)

            Dim sym As New Encryption.Symmetric(Encryption.Symmetric.Provider.Rijndael)
            Dim key As New Encryption.Data("crazyFrogJumpsTo")
            Dim encryptedData As New Encryption.Data

            encryptedData = sym.Encrypt(New Encryption.Data(strRequestID), key)
            strEncryptedString = HttpUtility.UrlEncode(encryptedData.ToBase64)

            objLink.ID = "lnkLeave_" + strRequestID
            objLink.NavigateUrl = "PostDiscussion.aspx?Token=" + strEncryptedString
            objLink.Text = "Post Discussion"

            objTextView.ID = "txtLeave_" + strRequestID

            strDetails.Append("Request ID: " + CommonFunctions.Data.CheckIsDBNull(drHelpDesk("QueryID"), "").ToString() + " Subject: " + CommonFunctions.Data.CheckIsDBNull(drHelpDesk("Subject"), "").ToString() + "")

            strDetails.Append("<br/>Request Type: ")
            strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drHelpDesk("RequestType"), "-") & " ")

            strDetails.Append("Priority: ")
            strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drHelpDesk("Priority"), "-") & " ")

            strDetails.Append(" Requestor : ")
            strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drHelpDesk("CustomerID"), "-") & " ")


            objTextView.Text = strDetails.ToString()
            strDetails.Length = 0

            objLbl.ID = "Lbl_" + CommonFunctions.Data.CheckIsDBNull(drHelpDesk("QueryID"), "0").ToString()
            objLbl.Text = ""

            Page.FindControl("frmRequestList").Controls.Add(objLink)
            Page.FindControl("frmRequestList").Controls.Add(objTextView)
            Page.FindControl("frmRequestList").Controls.Add(objLbl)
            blnIsRecordExists = True
        Next

        If Not blnIsRecordExists Then
            Dim objLabel As New Web.UI.MobileControls.Label()
            objLabel.Text = "There are no items to show in this view."
            Page.FindControl("frmRequestList").Controls.Add(objLabel)
        End If

        strDetails = Nothing

    End Sub

    Private Sub PlotProjectTimesheetApprovalRequestList()
        '=====================================================================
        ' Procedure Name        : PlotProjectTimesheetApprovalRequestList()
        ' Purpose               : To plot list of Project Timesheet requests to be approved/rejected
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Amol Changle
        ' Created               : 22 Apr 2009
        ' Revisions             :
        '=====================================================================
        Dim strDetails As New StringBuilder()
        Dim blnIsRecordExists As Boolean = False
        Dim strTimesheetNo As String
        Dim strEncryptedString As String

        dsApprovalRequests = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_PM_TimeSheetInvoice 1,NULL,NULL,NULL,NULL,NULL," + strUserID, "TblPT", UseSQL:=True)
        Call DrawPaging()
        dsApprovalRequests = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_PM_TimeSheetInvoice 1,NULL,NULL,NULL,NULL,NULL," + strUserID, "TblPT", (intPageNumber - 1) * intNoofRecordsPerPage, IIf(intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage < intNoofRecordsPerPage, intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage, intNoofRecordsPerPage), UseSQL:=True)

        'Plot Request list
        For Each drProjectTimesheet As DataRow In dsApprovalRequests.Tables(0).Rows
            Dim objLink As New Web.UI.MobileControls.Link()
            Dim objTextView As New Web.UI.MobileControls.TextView()
            Dim objLbl As New Web.UI.MobileControls.Label()
            Dim objChkBox As New Web.UI.MobileControls.SelectionList


            strTimesheetNo = CommonFunctions.Data.CheckIsDBNull(drProjectTimesheet("TimesheetNo"), "0").ToString()
            arrLeaveID.Add(strTimesheetNo)

            Dim objItem As New Web.UI.MobileControls.MobileListItem(strTimesheetNo, strTimesheetNo)

            Dim sym As New Encryption.Symmetric(Encryption.Symmetric.Provider.Rijndael)
            Dim key As New Encryption.Data("crazyFrogJumpsTo")
            Dim encryptedData As New Encryption.Data

            encryptedData = sym.Encrypt(New Encryption.Data(strTimesheetNo), key)
            strEncryptedString = HttpUtility.UrlEncode(encryptedData.ToBase64)

            objLink.ID = "lnkLeave_" + strTimesheetNo
            objLink.NavigateUrl = "Mobile_RequestApprovalRejection.aspx?Mode=" + strMode + "&Token=" + strEncryptedString
            strDetails.Append("Timesheet No: ")
            strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drProjectTimesheet("TimesheetNo"), "").ToString())
            strDetails.Append("  Date: ")
            strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drProjectTimesheet("CreatedDate1"), "").ToString())

            objLink.Text = strDetails.ToString()

            strDetails.Length = 0

            objTextView.ID = "txtLeave_" + strTimesheetNo

            strDetails.Append("From Date: ")
            If CommonFunctions.Data.CheckIsDBNull(drProjectTimesheet("FromDate"), "").ToString() <> "" Then
                strDetails.Append(CommonFunctions.Dates.GetDate(drProjectTimesheet("FromDate")) & " ")
            Else
                strDetails.Append("- ")
            End If
            strDetails.Append("  Project: " + CommonFunctions.Data.CheckIsDBNull(drProjectTimesheet("ProjectName"), "").ToString())
            strDetails.Append("  To Date: ")
            If CommonFunctions.Data.CheckIsDBNull(drProjectTimesheet("ToDate"), "").ToString() <> "" Then
                strDetails.Append(CommonFunctions.Dates.GetDate(drProjectTimesheet("ToDate")) & " ")
            Else
                strDetails.Append("- ")
            End If
            strDetails.Append("  Timesheet Hrs: ")
            strDetails.Append(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drProjectTimesheet("TotalTimesheetHours"), "0.0"), 2))

            objTextView.Text = strDetails.ToString()
            strDetails.Length = 0

            objLbl.ID = "Lbl_" + CommonFunctions.Data.CheckIsDBNull(drProjectTimesheet("TimesheetNo"), "0").ToString()
            objLbl.Text = ""

            objItem.Value = strTimesheetNo
            objItem.Text = " "
            objItem.ID = "ChkSelect" + strTimesheetNo


            objChkBox.ID = "Chk" + strTimesheetNo
            objChkBox.SelectType = MobileControls.ListSelectType.CheckBox
            objChkBox.BreakAfter = False
            objChkBox.Items.Add(objItem)

            Page.FindControl("frmRequestList").Controls.Add(objChkBox)
            Page.FindControl("frmRequestList").Controls.Add(objLink)
            Page.FindControl("frmRequestList").Controls.Add(objTextView)
            Page.FindControl("frmRequestList").Controls.Add(objLbl)
            blnIsRecordExists = True
        Next

        If Not blnIsRecordExists Then
            Dim objLabel As New Web.UI.MobileControls.Label()
            objLabel.Text = "There are no items to show in this view."
            Page.FindControl("frmRequestList").Controls.Add(objLabel)
        End If

        strDetails = Nothing

    End Sub

    'Private Sub PlotBenefitClaimApprovalRequestList()
    '    '=====================================================================
    '    ' Procedure Name        : PlotBenefitClaimApprovalRequestList()
    '    ' Purpose               : To plot list of Benefit Claim requests to be approved/rejected
    '    ' Description           : 
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : Amol Changle
    '    ' Created               : 08 Mar 2009
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim strDetails As New StringBuilder()
    '    Dim blnIsRecordExists As Boolean = False
    '    Dim strEmployeeClaimID As String
    '    Dim strEncryptedString As String

    '    dsApprovalRequests = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_WF_Inbox_ForBenefit_ExpenseClaim_Mobile " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString(), "TblLeaves", UseSQL:=True)
    '    Call DrawPaging()
    '    dsApprovalRequests = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_WF_Inbox_ForBenefit_ExpenseClaim_Mobile " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString(), "TblLeaves", (intPageNumber - 1) * intNoofRecordsPerPage, IIf(intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage < intNoofRecordsPerPage, intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage, intNoofRecordsPerPage), UseSQL:=True)

    '    'Plot Request list
    '    For Each drBenefitClaim As DataRow In dsApprovalRequests.Tables(0).Rows
    '        Dim objLink As New Web.UI.MobileControls.Link()
    '        Dim objTextView As New Web.UI.MobileControls.TextView()
    '        Dim objLbl As New Web.UI.MobileControls.Label()
    '        Dim objChkBox As New Web.UI.MobileControls.SelectionList


    '        strEmployeeClaimID = CommonFunctions.Data.CheckIsDBNull(drBenefitClaim("EmployeeClaimID"), "0").ToString()
    '        arrLeaveID.Add(strEmployeeClaimID)

    '        Dim objItem As New Web.UI.MobileControls.MobileListItem(strEmployeeClaimID, strEmployeeClaimID)

    '        Dim sym As New Encryption.Symmetric(Encryption.Symmetric.Provider.Rijndael)
    '        Dim key As New Encryption.Data("crazyFrogJumpsTo")
    '        Dim encryptedData As New Encryption.Data

    '        encryptedData = sym.Encrypt(New Encryption.Data(strEmployeeClaimID), key)
    '        strEncryptedString = HttpUtility.UrlEncode(encryptedData.ToBase64)

    '        objLink.ID = "lnkBenefitClaim_" + strEmployeeClaimID
    '        objLink.NavigateUrl = "Mobile_RequestApprovalRejection.aspx?Mode=" + strMode + "&Token=" + strEncryptedString
    '        objLink.Text = CommonFunctions.Data.CheckIsDBNull(drBenefitClaim("Claimer"), "").ToString()

    '        objTextView.ID = "txtBenefitClaim_" + strEmployeeClaimID

    '        strDetails.Append("Benefit Type: ") : strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drBenefitClaim("BenifitType"), "").ToString() & " ")
    '        strDetails.Append("Distributed Amount: ") : strDetails.Append(FormatNumber(CType(CommonFunctions.Data.CheckIsDBNull(drBenefitClaim("DistributedAmount"), "0"), Double), 2) & " " & strCurrency & " ")
    '        strDetails.Append("Stage: ") : strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drBenefitClaim("StageName"), "").ToString() & " ")
    '        strDetails.Append("Claimed Amount: ") : strDetails.Append(FormatNumber(CType(CommonFunctions.Data.CheckIsDBNull(drBenefitClaim("ClaimAmount"), "0"), Double), 2) & " " & strCurrency & " ")
    '        strDetails.Append("Claimed Date: ")
    '        If CommonFunctions.Data.CheckIsDBNull(drBenefitClaim("ClaimDate"), "").ToString() <> "" Then
    '            strDetails.Append(CommonFunctions.Dates.GetDate(drBenefitClaim("ClaimDate")) & " ")
    '        Else
    '            strDetails.Append("- ")
    '        End If
    '        objTextView.Text = strDetails.ToString()
    '        strDetails.Length = 0

    '        objLbl.ID = "Lbl_" + CommonFunctions.Data.CheckIsDBNull(drBenefitClaim("EmployeeClaimID"), "0").ToString()
    '        objLbl.Text = ""

    '        objItem.Value = strEmployeeClaimID
    '        objItem.Text = " "
    '        objItem.ID = "ChkSelect" + strEmployeeClaimID


    '        objChkBox.ID = "Chk" + strEmployeeClaimID
    '        objChkBox.SelectType = MobileControls.ListSelectType.CheckBox
    '        objChkBox.BreakAfter = False
    '        objChkBox.Items.Add(objItem)

    '        Page.FindControl("frmRequestList").Controls.Add(objChkBox)
    '        Page.FindControl("frmRequestList").Controls.Add(objLink)
    '        Page.FindControl("frmRequestList").Controls.Add(objTextView)
    '        Page.FindControl("frmRequestList").Controls.Add(objLbl)
    '        blnIsRecordExists = True
    '    Next

    '    If Not blnIsRecordExists Then
    '        Dim objLabel As New Web.UI.MobileControls.Label()
    '        objLabel.Text = "There are no items to show in this view."
    '        Page.FindControl("frmRequestList").Controls.Add(objLabel)
    '    End If

    '    strDetails = Nothing

    'End Sub

    Private Sub DrawPaging()
        '=====================================================================
        ' Procedure Name        : DrawPaging()
        ' Purpose               : To plot numeric paging 
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Amol Changle
        ' Created               : 08 Mar 2009
        ' Revisions             :
        '=====================================================================
        intNoofRecords = dsApprovalRequests.Tables(0).Rows.Count

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

        LnkFirst.NavigateUrl = "Mobile_RequestlList.aspx?Mode=" + strMode + "&PageNo=1"

        If intPageNumber < 2 Then
            LnkPrevious.NavigateUrl = "Mobile_RequestlList.aspx?Mode=" + strMode + "&PageNo=1"
        Else
            LnkPrevious.NavigateUrl = "Mobile_RequestlList.aspx?Mode=" + strMode + "&PageNo=" + (intPageNumber - 1).ToString()
        End If

        If intPageNumber > Math.Ceiling(intNoofRecords / intNoofRecordsPerPage - 1).ToString() Then
            LnkNext.NavigateUrl = "Mobile_RequestlList.aspx?Mode=" + strMode + "&PageNo=" + Math.Ceiling(intNoofRecords / intNoofRecordsPerPage).ToString()
        Else
            LnkNext.NavigateUrl = "Mobile_RequestlList.aspx?Mode=" + strMode + "&PageNo=" + (intPageNumber + 1).ToString()
        End If

        LnkLast.NavigateUrl = "Mobile_RequestlList.aspx?Mode=" + strMode + "&PageNo=" + Math.Ceiling(intNoofRecords / intNoofRecordsPerPage).ToString()

    End Sub

    Private Sub LogOut()
        'Logout
        Session.Abandon()
        Response.Clear()
        Response.Redirect("Login.aspx")
    End Sub

    Private Sub CmdApprove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles CmdApprove.Click, objApproveCmd.Click
        Select Case strMode.ToLower()

            Case "leave"
                Call ApproveRejectLeave("2")

            Case "resourcetimesheet"
                Call ApproveRejectResourceTimesheet("1")

            Case "project"
                Call ApproveRejectProject("A")

            Case "projecttimesheet"
                Call ApproveProjectTimesheet()

        End Select
        Response.Redirect("Mobile_RequestlList.aspx?Mode=" + strMode)
    End Sub

    Private Sub CmdReject_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles CmdReject.Click, objRejectCmd.Click
        Select Case strMode.ToLower()

            Case "leave"
                Call ApproveRejectLeave("3")

            Case "resourcetimesheet"
                Call ApproveRejectResourceTimesheet("0")

            Case "project"
                Call ApproveRejectProject("R")

            Case "projecttimesheet"
                Call RejectProjectTimesheet()

        End Select
        Response.Redirect("Mobile_RequestlList.aspx?Mode=" + strMode)
    End Sub

    Private Sub ApproveProjectTimesheet()
        Dim i As Integer
        Dim strSQL As New StringBuilder()
        Dim strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage As String
        Dim blnSendMail As Boolean
        Dim dr As IDataReader

        ' send mail

        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 6", True)
        If dr.Read Then
            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)


        For i = 0 To arrLeaveID.Count - 1
            If Not HttpContext.Current.Request.Form("Chk" + arrLeaveID(i).ToString()) Is Nothing Then
                strSQL.Append("usp_Upd_tbl_PM_TimeSheetInvoice '")
                strSQL.Append(arrLeaveID(i).ToString())
                strSQL.Append("',N'Approved',N'")
                strSQL.Append(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName")))
                strSQL.Append("'")
                CommonFunctions.Data.InsertOrUpdateData(strSQL.ToString(), True)
                strSQL.Length = 0

                If blnSendMail Then
                    CommonFunction.EmailMessages.FAMessages.GetEmailMessage_6(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CType(arrLeaveID(i).ToString(), Long))
                    CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                End If
            End If
        Next
        strSQL = Nothing
    End Sub

    Private Sub RejectProjectTimesheet()
        Dim i As Integer
        Dim strSQL As New StringBuilder()
        Dim strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage As String
        Dim blnSendMail As Boolean
        Dim dr As IDataReader

        ' send mail

        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 442", True)
        If dr.Read Then
            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)


        For i = 0 To arrLeaveID.Count - 1
            If Not HttpContext.Current.Request.Form("Chk" + arrLeaveID(i).ToString()) Is Nothing Then
                strSQL.Append("usp_Upd_tbl_PM_TimeSheetInvoice_For_Rejection '")
                strSQL.Append(arrLeaveID(i).ToString())
                strSQL.Append("',N'Rejected',N'")
                strSQL.Append(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName")))
                strSQL.Append("'")
                CommonFunctions.Data.InsertOrUpdateData(strSQL.ToString(), True)
                strSQL.Length = 0

                If blnSendMail Then
                    CommonFunction.EmailMessages.FAMessages.GetEmailMessage_442(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CType(arrLeaveID(i).ToString(), Long))
                    CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                End If
            End If
        Next
        strSQL = Nothing
    End Sub

    Private Sub ApproveRejectLeave(ByVal strStatusID As String)
        Dim i As Integer
        Dim strSQL As New StringBuilder()
        Dim strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage As String
        Dim blnSendMail As Boolean
        Dim dr As IDataReader
        Dim strMsgID As String
        Dim strComments As String

        ' send mail

        If strStatusID = "2" Then
            strMsgID = "69"
            strComments = "Approved"
        Else
            strMsgID = "70"
            strComments = "Rejected"
        End If

        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages " + strMsgID, True)
        If dr.Read Then
            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)


        For i = 0 To arrLeaveID.Count - 1
            If Not HttpContext.Current.Request.Form("Chk" + arrLeaveID(i).ToString()) Is Nothing Then
                strSQL.Append("usp_Upd_tbl_PM_EmployeeLeaveDetails_AND_Master ")
                strSQL.Append(arrLeaveID(i).ToString())
                strSQL.Append(",")
                strSQL.Append(strStatusID)
                strSQL.Append(",")
                strSQL.Append(strUserID)
                strSQL.Append(",N'")
                strSQL.Append(strComments)
                strSQL.Append("'")
                CommonFunctions.Data.InsertOrUpdateData(strSQL.ToString(), True)
                strSQL.Length = 0

                If blnSendMail Then
                    If strMsgID = "69" Then
                        CommonFunction.EmailMessages.PMMessages.GetEmailMessage_69(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CType(arrLeaveID(i).ToString(), Integer))
                    Else
                        CommonFunction.EmailMessages.PMMessages.GetEmailMessage_70(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CType(arrLeaveID(i).ToString(), Integer))
                    End If
                    CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                End If
            End If
        Next

        strSQL = Nothing
    End Sub

    Private Sub ApproveRejectResourceTimesheet(ByVal strStatusID As String)
        '=====================================================================
        ' Procedure Name        : ApproveRejectResourceTimesheet
        ' Purpose               : To Approve/Reject Resource Timesheet
        ' Description           : 
        ' Parameters Passed     : strAction
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Amol Changle
        ' Created               : 22 Apr 2009
        ' Revisions             :
        '=====================================================================
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
        Dim strMessageID As String
        Dim strRTEntry As New StringBuilder("")

        If strStatusID = "1" Then
            strMessageID = "435"
        Else
            strMessageID = "437"
        End If

        ' send mail
        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages " + strMessageID, True)
        If dr.Read Then
            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

        For i = 0 To arrLeaveID.Count - 1
            If Not HttpContext.Current.Request.Form("Chk" + arrLeaveID(i).ToString()) Is Nothing Then

                dsTimesheet = CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_ResourceTimesheet " + arrLeaveID(i).ToString(), "TblTimesheet")
                dteFromDate = CommonFunctions.Data.CheckIsDBNull(dsTimesheet.Tables(0).Rows(0)("FromDate")).ToString()
                dteToDate = CommonFunctions.Data.CheckIsDBNull(dsTimesheet.Tables(0).Rows(0)("ToDate")).ToString()
                strResourceID = CommonFunctions.Data.CheckIsDBNull(dsTimesheet.Tables(0).Rows(0)("EmployeeID")).ToString()

                strQuery = "usp_Sel_ResourceTimesheetDADetails " & arrLeaveID(i).ToString() & "," & strUserID

                m_drTimesheet = CommonFunctions.Data.GetDataReader(strQuery, True)
                strRTEntry.Length = 0
                'Get Activity record details for the resource timesheet
                Do While m_drTimesheet.Read()
                    If CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("IsDisabled"), "0"), Integer) = "0" Then
                        strDailyActivityID = CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("DailyActivityEntryID"), "0").ToString()
                        '--- Execute sp to update verification details to Daily Activity Table
                        CommonFunctions.Data.InsertOrUpdateData("usp_Upd_PM_ResourceTimesheetVerification " + strDailyActivityID + "," + strStatusID + "," + strUserID + ",'" + CType(Now(), String) + "','" + IIf(strStatusID = "1", "", "Rejected").ToString() + "'", True)
                        If strRTEntry.ToString() = "" Then
                            strRTEntry.Append(strDailyActivityID)
                        Else
                            strRTEntry.Append("," + strDailyActivityID)
                        End If
                    End If
                Loop

                If strStatusID = "0" Then
                    If strRTEntry.ToString() <> "" Then
                        CommonFunctions.Data.InsertOrUpdateData("usp_Upd_UnverifyResouceTimesheetStatus " + arrLeaveID(i).ToString() + "," + strUserID + ",'" + strRTEntry.ToString() + "'", True)
                    End If
                End If

                'Change Status to Verified in tbl_PM_ResourceTimesheetStatus table
                CommonFunctions.Data.InsertOrUpdateData("usp_Upd_tbl_PM_ResourceTimesheetStatus " & arrLeaveID(i).ToString() & "," & strUserID & "," & "'" + IIf(strStatusID = "1", "V", "J").ToString() + "'", True)

                If strStatusID = "1" Then
                    Dim strSQLQuery As String
                    Dim drVerify As IDataReader
                    'If Resource TimeSheet are verified then change the status to 'verified' 
                    strSQLQuery = "Exec usp_Sel_ResourceTimesheet_GetVerifiedTasksStatus " & arrLeaveID(i).ToString()
                    drVerify = CommonFunctions.Data.GetDataReader(strSQLQuery, True)

                    If drVerify.Read = False Then
                        strSQLQuery = "Exec usp_Upd_ResouceTimesheetStatus " & arrLeaveID(i).ToString() & ",'V'"
                        CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, UseSQL:=True)
                        'drResourceTimesheetstatus = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                        'CommonFunctions.Data.DisposeDataReader(drResourceTimesheetstatus)
                    End If
                    CommonFunctions.Data.DisposeDataReader(drVerify)
                End If


                If blnSendMail Then
                    'Notify Project owener about approval
                    If strMessageID = "435" Then
                        CommonFunction.EmailMessages.ResourceTimesheetMessages.GetEmailMessage_435(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(strUserID, Integer), CType(strResourceID, Integer), CType(dteFromDate, Date), CType(dteToDate, Date))
                    Else
                        CommonFunction.EmailMessages.ResourceTimesheetMessages.GetEmailMessage_437(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(strUserID, Integer), CType(strResourceID, Integer), CType(dteFromDate, Date), CType(dteToDate, Date))
                    End If
                    CommonFunction.Emails.AppSendEmailWithCC(m_strToEmailID, m_strCCEmailID, m_strFromEmailID, m_strSubject, m_strMessage)
                End If

                CommonFunction.Data.DisposeDataReader(m_drTimesheet)
            End If
        Next
    End Sub

    Private Sub ApproveRejectProject(ByVal strAction As String)
        '=====================================================================
        ' Procedure Name        : ApproveRejectProject
        ' Purpose               : To Approve/Reject Project
        ' Description           : 
        ' Parameters Passed     : strAction
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Amol Changle
        ' Created               : 24 Apr 2009
        ' Revisions             :
        '=====================================================================
        Dim i As Integer
        Dim strSQL As New StringBuilder
        Dim strFromEmailID As String = "", strToMailID As String = "", strCCToMailID As String = ""
        Dim strToEmailID As String = "", strCCToEmailID As String = ""
        Dim strEmailMessage As String = "", strSubject As String = "", strMessage As String = ""
        Dim intRevisionReasonID As Integer
        Dim blnSendMail As Boolean
        Dim dr As IDataReader
        Dim strWorkFlowType As String
        Dim intRecipientID As Integer
        Dim strSentForApprovalBy As String

        Dim m_objGlobalObject As WebPages.Template.IGlobal
        Dim objWhizTemplate As New WebPages.Template.WhizTemplate


        objWhizTemplate.FillGlobalObject(objWhizTemplate.CurrentThreadUICultureID)
        m_objGlobalObject = objWhizTemplate.GlobalObject
        m_objGlobalObject.TagID = 32

        ' send mail
        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 441", True)
        If dr.Read Then
            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)


        For i = 0 To arrLeaveID.Count - 1
            If Not HttpContext.Current.Request.Form("Chk" + arrLeaveID(i).ToString()) Is Nothing Then
                For Each drProject As DataRow In dsApprovalRequests.Tables(0).Select("ProjectID=" + arrLeaveID(i).ToString())
                    strWorkFlowType = CommonFunctions.Data.CheckIsDBNull(drProject("WorkFlowType"))
                    Select Case strWorkFlowType
                        Case "N" 'Approve/reject New WorkFlow Project
                            CommonFunction.WhizibleWorkflow.UpdateWhizibleWorkflowData(m_objGlobalObject, CType(arrLeaveID(i).ToString(), Integer), IIf(strAction = "A", "SYS_APPROVE", "SYS_REJECT").ToString(), "32", "", "", IIf(strAction = "A", "Approved", "Rejected").ToString(), True)
                        Case "O" 'Approve/reject old WorkFlow Project
                            strSentForApprovalBy = CommonFunctions.Data.CheckIsDBNull(drProject("SentForApprovalBy"), "")
                            intRecipientID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_GetEmployeeID N'" & strSentForApprovalBy & "'", True), "0"), "0"), Integer)

                            If strAction = "A" Then
                                strSQL.Append("usp_Ins_tbl_PM_Project_BaselineRevisionReason ")
                            Else
                                strSQL.Append("usp_Ins_tbl_PM_ProjectBaselineRejectionReason ")
                            End If
                            strSQL.Append(arrLeaveID(i).ToString() + ",")
                            strSQL.Append("N'Approved',")
                            strSQL.Append("N'" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "").ToString()) & "'")

                            If strAction = "A" Then
                                strSQL.Append(",'A'")
                            End If

                            intRevisionReasonID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL.ToString(), True), "0"), Integer)
                            If blnSendMail Then
                                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_441(intRecipientID.ToString(), strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CType(arrLeaveID(i).ToString(), Integer), "" + strAction + "", intRevisionReasonID)
                                CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                            End If
                            strSQL.Length = 0
                    End Select
                Next
            End If
        Next
        strSQL = Nothing
    End Sub


    'Private Sub ApproveRejectBenefitClaim(ByVal strAction As String)
    '    '=====================================================================
    '    ' Procedure Name        : ApproveRejectBenefitClaim
    '    ' Purpose               : To Approve/Reject Benefit Claim workflow action
    '    ' Description           : 
    '    ' Parameters Passed     : strAction
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : Amol Changle
    '    ' Created               : 08 Mar 2009
    '    ' Revisions             :
    '    '=====================================================================

    '    Dim m_objGlobalObject As WebPages.Template.IGlobal
    '    Dim objWhizTemplate As New WebPages.Template.WhizTemplate
    '    Dim i As Integer
    '    Dim strProcessID As String
    '    Dim intTagID As Integer
    '    Dim strStageID As String
    '    Dim strInstanceID As String
    '    Dim strInboxID As String
    '    Dim objDataRow As DataRow

    '    objWhizTemplate.FillGlobalObject(objWhizTemplate.CurrentThreadUICultureID)
    '    m_objGlobalObject = objWhizTemplate.GlobalObject

    '    For i = 0 To arrLeaveID.Count - 1
    '        If Not HttpContext.Current.Request.Form("Chk" + arrLeaveID(i).ToString()) Is Nothing Then

    '            If dsApprovalRequests.Tables(0).Select("EmployeeClaimID=" + arrLeaveID(i).ToString()).Length > 0 Then
    '                objDataRow = dsApprovalRequests.Tables(0).Select("EmployeeClaimID=" + arrLeaveID(i).ToString())(0)

    '                strProcessID = CommonFunctions.Data.CheckIsDBNull(objDataRow("ProcessID")).ToString()
    '                strStageID = CommonFunctions.Data.CheckIsDBNull(objDataRow("StageID")).ToString()
    '                intTagID = CType(CommonFunctions.Data.CheckIsDBNull(objDataRow("TagID"), "0").ToString(), Integer)
    '                strInboxID = CommonFunctions.Data.CheckIsDBNull(objDataRow("InboxID")).ToString()
    '                strInstanceID = CommonFunctions.Data.CheckIsDBNull(objDataRow("InstanceID")).ToString()

    '                m_objGlobalObject.TagID = intTagID

    '                'To update Credited Amount and Date , when request is approved in "Finance Approval" stage
    '                If strStageID = "4E86AC5C-8C65-41D5-85C0-6D72DFB48234" And strAction = "SYS_APPROVE" Then
    '                    CommonFunctions.Data.InsertOrUpdateData("Usp_Upd_tbl_HR_Employee_BenefitClaimDetails_CreditedAmount " + arrLeaveID(i).ToString(), True)
    '                End If

    '                CommonFunction.WhizibleWorkflow.UpdateWhizibleWorkflowData(m_objGlobalObject, CType(arrLeaveID(i).ToString(), Integer), strAction, intTagID.ToString, strInboxID, IIf(strAction.ToLower = "sys_approve", "approved", "rejected").ToString())

    '                If strAction = "SYS_APPROVE" Then
    '                    CommonFunctions.Data.InsertOrUpdateData("usp_UPD_tbl_HR_Claims_ApprovalStatus " + strUserID + "," + arrLeaveID(i).ToString(), True)
    '                End If

    '                'Send WorkFlow action Emails
    '                SendWorkFlowEmail_Mobile.SendWorkFlowEmail(strProcessID, strStageID, strAction, arrLeaveID(i).ToString(), strInstanceID)
    '            End If
    '        End If
    '    Next

    'End Sub

    'Private Sub PlotEmployeeTransferApproval()
    '    '=====================================================================
    '    ' Procedure Name        : PlotEmployeeTransferApproval
    '    ' Purpose               : To plot Employee Transfer Approval Links
    '    ' Description           : 
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : Amol Changle
    '    ' Created               : 10 Mar 2009
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim dsEmpTransferApproval As DataSet

    '    If strType = "" Then
    '        dsEmpTransferApproval = CommonFunctions.Data.GetDataSet("Usp_Sel_Count_EmployeeTranferApprovals " + strUserID, "Tbl_EmpTransfer", UseSQL:=True)

    '        'Grade
    '        If dsEmpTransferApproval.Tables(0).Select("ChangeRequestID=" + CType(EmployeeTransfer.Grade, String))(0)(0) > 0 Then
    '            LnkGrade.Text = "Grade(" + dsEmpTransferApproval.Tables(0).Select("ChangeRequestID=" + CType(EmployeeTransfer.Grade, String))(0)(0).ToString() + ")"
    '            LnkGrade.Visible = True
    '        End If

    '        'Role
    '        If dsEmpTransferApproval.Tables(0).Select("ChangeRequestID=" + CType(EmployeeTransfer.Role, String))(0)(0) > 0 Then
    '            LnkRole.Text = "Role(" + dsEmpTransferApproval.Tables(0).Select("ChangeRequestID=" + CType(EmployeeTransfer.Role, String))(0)(0).ToString() + ")"
    '            LnkRole.Visible = True
    '        End If

    '        'Employee Type
    '        If dsEmpTransferApproval.Tables(0).Select("ChangeRequestID=" + CType(EmployeeTransfer.EmployeeType, String))(0)(0) > 0 Then
    '            LnkEmployeeType.Text = "Employee Type(" + dsEmpTransferApproval.Tables(0).Select("ChangeRequestID=" + CType(EmployeeTransfer.EmployeeType, String))(0)(0).ToString() + ")"
    '            LnkEmployeeType.Visible = True
    '        End If

    '        'Designation
    '        If dsEmpTransferApproval.Tables(0).Select("ChangeRequestID=" + CType(EmployeeTransfer.Designation, String))(0)(0) > 0 Then
    '            LnkDesignation.Text = "Designation(" + dsEmpTransferApproval.Tables(0).Select("ChangeRequestID=" + CType(EmployeeTransfer.Designation, String))(0)(0).ToString() + ")"
    '            LnkDesignation.Visible = True
    '        End If

    '        'Reporting Manager
    '        If dsEmpTransferApproval.Tables(0).Select("ChangeRequestID=" + CType(EmployeeTransfer.ReportingManager, String))(0)(0) > 0 Then
    '            LnkReportingManager.Text = "Reporting Manager(" + dsEmpTransferApproval.Tables(0).Select("ChangeRequestID=" + CType(EmployeeTransfer.ReportingManager, String))(0)(0).ToString() + ")"
    '            LnkReportingManager.Visible = True
    '        End If

    '        'Organization Alignment
    '        If dsEmpTransferApproval.Tables(0).Select("ChangeRequestID=" + CType(EmployeeTransfer.OrganizationStucture, String))(0)(0) > 0 Then
    '            LnkOrgStr.Text = "Organization Alignment(" + dsEmpTransferApproval.Tables(0).Select("ChangeRequestID=" + CType(EmployeeTransfer.OrganizationStucture, String))(0)(0).ToString() + ")"
    '            LnkOrgStr.Visible = True
    '        End If

    '        'Cost Center
    '        If dsEmpTransferApproval.Tables(0).Select("ChangeRequestID=" + CType(EmployeeTransfer.CostCenter, String))(0)(0) > 0 Then
    '            LnkCostCenter.Text = "Cost Center(" + dsEmpTransferApproval.Tables(0).Select("ChangeRequestID=" + CType(EmployeeTransfer.CostCenter, String))(0)(0).ToString() + ")"
    '            LnkCostCenter.Visible = True
    '        End If

    '    End If
    'End Sub

    'Private Sub PlotGradeChangeList()
    '    '=====================================================================
    '    ' Procedure Name        : PlotEmployeeTransferApproval
    '    ' Purpose               : To plot Employee Transfer Approval Links
    '    ' Description           : 
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : Amol Changle
    '    ' Created               : 10 Mar 2009
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim strDetails As New StringBuilder()
    '    Dim blnIsRecordExists As Boolean = False
    '    Dim strUniqueID As String
    '    Dim strEncryptedString As String

    '    dsApprovalRequests = CommonFunctions.Data.GetDataSet("usp_sel_tbl_PM_EmployeeGrade_Change NULL,2," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString() + ",7,0", "Tbl_ReportingMngr", UseSQL:=True)
    '    Call DrawPaging()
    '    dsApprovalRequests = CommonFunctions.Data.GetDataSet("usp_sel_tbl_PM_EmployeeGrade_Change NULL,2," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString() + ",7,0", "Tbl_ReportingMngr", (intPageNumber - 1) * intNoofRecordsPerPage, IIf(intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage < intNoofRecordsPerPage, intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage, intNoofRecordsPerPage), UseSQL:=True)

    '    'Plot Request list
    '    For Each drReportingMngr As DataRow In dsApprovalRequests.Tables(0).Rows
    '        Dim objLink As New Web.UI.MobileControls.Link()
    '        Dim objTextView As New Web.UI.MobileControls.TextView()
    '        Dim objLbl As New Web.UI.MobileControls.Label()
    '        Dim objChkBox As New Web.UI.MobileControls.SelectionList


    '        strUniqueID = CommonFunctions.Data.CheckIsDBNull(drReportingMngr("UniqueID"), "0").ToString()
    '        arrLeaveID.Add(strUniqueID)

    '        Dim objItem As New Web.UI.MobileControls.MobileListItem(strUniqueID, strUniqueID)

    '        Dim sym As New Encryption.Symmetric(Encryption.Symmetric.Provider.Rijndael)
    '        Dim key As New Encryption.Data("crazyFrogJumpsTo")
    '        Dim encryptedData As New Encryption.Data

    '        encryptedData = sym.Encrypt(New Encryption.Data(strUniqueID), key)
    '        strEncryptedString = HttpUtility.UrlEncode(encryptedData.ToBase64)

    '        objLink.ID = "lnkReportingMgrChange_" + strUniqueID
    '        objLink.NavigateUrl = "Mobile_RequestApprovalRejection.aspx?Mode=" + strMode + "&Type=" + strType + "&Token=" + strEncryptedString
    '        objLink.Text = CommonFunctions.Data.CheckIsDBNull(drReportingMngr("EmployeeName"), "").ToString()

    '        objTextView.ID = "txtReportingMgrChange_" + strUniqueID

    '        strDetails.Append("Change To: ") : strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drReportingMngr("ChangeTo"), "").ToString() & " ")
    '        strDetails.Append("With Effect From: ")
    '        If CommonFunctions.Data.CheckIsDBNull(drReportingMngr("WithEffectFrom"), "").ToString() <> "" Then
    '            strDetails.Append(CommonFunctions.Dates.GetDate(drReportingMngr("WithEffectFrom")) & " ")
    '        Else
    '            strDetails.Append("- ")
    '        End If

    '        objTextView.Text = strDetails.ToString()
    '        strDetails.Length = 0

    '        objLbl.ID = "Lbl_" + CommonFunctions.Data.CheckIsDBNull(drReportingMngr("UniqueID"), "0").ToString()
    '        objLbl.Text = ""

    '        objItem.Value = strUniqueID
    '        objItem.Text = " "
    '        objItem.ID = "ChkSelect" + strUniqueID


    '        objChkBox.ID = "Chk" + strUniqueID
    '        objChkBox.SelectType = MobileControls.ListSelectType.CheckBox
    '        objChkBox.BreakAfter = False
    '        objChkBox.Items.Add(objItem)

    '        Page.FindControl("frmRequestList").Controls.Add(objChkBox)
    '        Page.FindControl("frmRequestList").Controls.Add(objLink)
    '        Page.FindControl("frmRequestList").Controls.Add(objTextView)
    '        Page.FindControl("frmRequestList").Controls.Add(objLbl)
    '        blnIsRecordExists = True
    '    Next

    '    If Not blnIsRecordExists Then
    '        Dim objLabel As New Web.UI.MobileControls.Label()
    '        objLabel.Text = "There are no items to show in this view."
    '        Page.FindControl("frmRequestList").Controls.Add(objLabel)
    '    End If

    '    strDetails = Nothing
    'End Sub

    'Private Sub PlotRoleChangeList()
    '    '=====================================================================
    '    ' Procedure Name        : PlotEmployeeTransferApproval
    '    ' Purpose               : To plot Employee Transfer Approval Links
    '    ' Description           : 
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : Amol Changle
    '    ' Created               : 10 Mar 2009
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim strDetails As New StringBuilder()
    '    Dim blnIsRecordExists As Boolean = False
    '    Dim strUniqueID As String
    '    Dim strEncryptedString As String

    '    dsApprovalRequests = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_PM_EmployeeRole_Change NULL,2," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString() + ",7,0", "Tbl_ReportingMngr", UseSQL:=True)
    '    Call DrawPaging()
    '    dsApprovalRequests = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_PM_EmployeeRole_Change NULL,2," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString() + ",7,0", "Tbl_ReportingMngr", (intPageNumber - 1) * intNoofRecordsPerPage, IIf(intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage < intNoofRecordsPerPage, intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage, intNoofRecordsPerPage), UseSQL:=True)

    '    'Plot Request list
    '    For Each drReportingMngr As DataRow In dsApprovalRequests.Tables(0).Rows
    '        Dim objLink As New Web.UI.MobileControls.Link()
    '        Dim objTextView As New Web.UI.MobileControls.TextView()
    '        Dim objLbl As New Web.UI.MobileControls.Label()
    '        Dim objChkBox As New Web.UI.MobileControls.SelectionList


    '        strUniqueID = CommonFunctions.Data.CheckIsDBNull(drReportingMngr("UniqueID"), "0").ToString()
    '        arrLeaveID.Add(strUniqueID)

    '        Dim objItem As New Web.UI.MobileControls.MobileListItem(strUniqueID, strUniqueID)

    '        Dim sym As New Encryption.Symmetric(Encryption.Symmetric.Provider.Rijndael)
    '        Dim key As New Encryption.Data("crazyFrogJumpsTo")
    '        Dim encryptedData As New Encryption.Data

    '        encryptedData = sym.Encrypt(New Encryption.Data(strUniqueID), key)
    '        strEncryptedString = HttpUtility.UrlEncode(encryptedData.ToBase64)

    '        objLink.ID = "lnkReportingMgrChange_" + strUniqueID
    '        objLink.NavigateUrl = "Mobile_RequestApprovalRejection.aspx?Mode=" + strMode + "&Type=" + strType + "&Token=" + strEncryptedString
    '        objLink.Text = CommonFunctions.Data.CheckIsDBNull(drReportingMngr("EmployeeName"), "").ToString()

    '        objTextView.ID = "txtReportingMgrChange_" + strUniqueID

    '        strDetails.Append("Change To: ") : strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drReportingMngr("ChangeTo"), "").ToString() & " ")
    '        strDetails.Append("With Effect From: ")
    '        If CommonFunctions.Data.CheckIsDBNull(drReportingMngr("WithEffectFrom"), "").ToString() <> "" Then
    '            strDetails.Append(CommonFunctions.Dates.GetDate(drReportingMngr("WithEffectFrom")) & " ")
    '        Else
    '            strDetails.Append("- ")
    '        End If

    '        objTextView.Text = strDetails.ToString()
    '        strDetails.Length = 0

    '        objLbl.ID = "Lbl_" + CommonFunctions.Data.CheckIsDBNull(drReportingMngr("UniqueID"), "0").ToString()
    '        objLbl.Text = ""

    '        objItem.Value = strUniqueID
    '        objItem.Text = " "
    '        objItem.ID = "ChkSelect" + strUniqueID


    '        objChkBox.ID = "Chk" + strUniqueID
    '        objChkBox.SelectType = MobileControls.ListSelectType.CheckBox
    '        objChkBox.BreakAfter = False
    '        objChkBox.Items.Add(objItem)

    '        Page.FindControl("frmRequestList").Controls.Add(objChkBox)
    '        Page.FindControl("frmRequestList").Controls.Add(objLink)
    '        Page.FindControl("frmRequestList").Controls.Add(objTextView)
    '        Page.FindControl("frmRequestList").Controls.Add(objLbl)
    '        blnIsRecordExists = True
    '    Next

    '    If Not blnIsRecordExists Then
    '        Dim objLabel As New Web.UI.MobileControls.Label()
    '        objLabel.Text = "There are no items to show in this view."
    '        Page.FindControl("frmRequestList").Controls.Add(objLabel)
    '    End If

    '    strDetails = Nothing
    'End Sub

    'Private Sub PlotEmployeeTypeChangeList()
    '    '=====================================================================
    '    ' Procedure Name        : PlotEmployeeTransferApproval
    '    ' Purpose               : To plot Employee Transfer Approval Links
    '    ' Description           : 
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : Amol Changle
    '    ' Created               : 10 Mar 2009
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim strDetails As New StringBuilder()
    '    Dim blnIsRecordExists As Boolean = False
    '    Dim strUniqueID As String
    '    Dim strEncryptedString As String

    '    dsApprovalRequests = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_PM_EmployeeType_Change NULL,2," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString() + ",7,0", "Tbl_ReportingMngr", UseSQL:=True)
    '    Call DrawPaging()
    '    dsApprovalRequests = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_PM_EmployeeType_Change NULL,2," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString() + ",7,0", "Tbl_ReportingMngr", (intPageNumber - 1) * intNoofRecordsPerPage, IIf(intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage < intNoofRecordsPerPage, intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage, intNoofRecordsPerPage), UseSQL:=True)

    '    'Plot Request list
    '    For Each drReportingMngr As DataRow In dsApprovalRequests.Tables(0).Rows
    '        Dim objLink As New Web.UI.MobileControls.Link()
    '        Dim objTextView As New Web.UI.MobileControls.TextView()
    '        Dim objLbl As New Web.UI.MobileControls.Label()
    '        Dim objChkBox As New Web.UI.MobileControls.SelectionList


    '        strUniqueID = CommonFunctions.Data.CheckIsDBNull(drReportingMngr("UniqueID"), "0").ToString()
    '        arrLeaveID.Add(strUniqueID)

    '        Dim objItem As New Web.UI.MobileControls.MobileListItem(strUniqueID, strUniqueID)

    '        Dim sym As New Encryption.Symmetric(Encryption.Symmetric.Provider.Rijndael)
    '        Dim key As New Encryption.Data("crazyFrogJumpsTo")
    '        Dim encryptedData As New Encryption.Data

    '        encryptedData = sym.Encrypt(New Encryption.Data(strUniqueID), key)
    '        strEncryptedString = HttpUtility.UrlEncode(encryptedData.ToBase64)

    '        objLink.ID = "lnkReportingMgrChange_" + strUniqueID
    '        objLink.NavigateUrl = "Mobile_RequestApprovalRejection.aspx?Mode=" + strMode + "&Type=" + strType + "&Token=" + strEncryptedString
    '        objLink.Text = CommonFunctions.Data.CheckIsDBNull(drReportingMngr("EmployeeName"), "").ToString()

    '        objTextView.ID = "txtReportingMgrChange_" + strUniqueID

    '        strDetails.Append("Change To: ") : strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drReportingMngr("ChangeTo"), "").ToString() & " ")
    '        strDetails.Append("With Effect From: ")
    '        If CommonFunctions.Data.CheckIsDBNull(drReportingMngr("WithEffectFrom"), "").ToString() <> "" Then
    '            strDetails.Append(CommonFunctions.Dates.GetDate(drReportingMngr("WithEffectFrom")) & " ")
    '        Else
    '            strDetails.Append("- ")
    '        End If

    '        objTextView.Text = strDetails.ToString()
    '        strDetails.Length = 0

    '        objLbl.ID = "Lbl_" + CommonFunctions.Data.CheckIsDBNull(drReportingMngr("UniqueID"), "0").ToString()
    '        objLbl.Text = ""

    '        objItem.Value = strUniqueID
    '        objItem.Text = " "
    '        objItem.ID = "ChkSelect" + strUniqueID


    '        objChkBox.ID = "Chk" + strUniqueID
    '        objChkBox.SelectType = MobileControls.ListSelectType.CheckBox
    '        objChkBox.BreakAfter = False
    '        objChkBox.Items.Add(objItem)

    '        Page.FindControl("frmRequestList").Controls.Add(objChkBox)
    '        Page.FindControl("frmRequestList").Controls.Add(objLink)
    '        Page.FindControl("frmRequestList").Controls.Add(objTextView)
    '        Page.FindControl("frmRequestList").Controls.Add(objLbl)
    '        blnIsRecordExists = True
    '    Next

    '    If Not blnIsRecordExists Then
    '        Dim objLabel As New Web.UI.MobileControls.Label()
    '        objLabel.Text = "There are no items to show in this view."
    '        Page.FindControl("frmRequestList").Controls.Add(objLabel)
    '    End If

    '    strDetails = Nothing
    'End Sub

    'Private Sub PlotDesignationChangeList()
    '    '=====================================================================
    '    ' Procedure Name        : PlotEmployeeTransferApproval
    '    ' Purpose               : To plot Employee Transfer Approval Links
    '    ' Description           : 
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : Amol Changle
    '    ' Created               : 10 Mar 2009
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim strDetails As New StringBuilder()
    '    Dim blnIsRecordExists As Boolean = False
    '    Dim strUniqueID As String
    '    Dim strEncryptedString As String

    '    dsApprovalRequests = CommonFunctions.Data.GetDataSet("usp_sel_tbl_PM_EmployeeDesignation_Change NULL,2," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString() + ",7,0", "Tbl_ReportingMngr", UseSQL:=True)
    '    Call DrawPaging()
    '    dsApprovalRequests = CommonFunctions.Data.GetDataSet("usp_sel_tbl_PM_EmployeeDesignation_Change NULL,2," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString() + ",7,0", "Tbl_ReportingMngr", (intPageNumber - 1) * intNoofRecordsPerPage, IIf(intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage < intNoofRecordsPerPage, intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage, intNoofRecordsPerPage), UseSQL:=True)

    '    'Plot Request list
    '    For Each drReportingMngr As DataRow In dsApprovalRequests.Tables(0).Rows
    '        Dim objLink As New Web.UI.MobileControls.Link()
    '        Dim objTextView As New Web.UI.MobileControls.TextView()
    '        Dim objLbl As New Web.UI.MobileControls.Label()
    '        Dim objChkBox As New Web.UI.MobileControls.SelectionList


    '        strUniqueID = CommonFunctions.Data.CheckIsDBNull(drReportingMngr("UniqueID"), "0").ToString()
    '        arrLeaveID.Add(strUniqueID)

    '        Dim objItem As New Web.UI.MobileControls.MobileListItem(strUniqueID, strUniqueID)

    '        Dim sym As New Encryption.Symmetric(Encryption.Symmetric.Provider.Rijndael)
    '        Dim key As New Encryption.Data("crazyFrogJumpsTo")
    '        Dim encryptedData As New Encryption.Data

    '        encryptedData = sym.Encrypt(New Encryption.Data(strUniqueID), key)
    '        strEncryptedString = HttpUtility.UrlEncode(encryptedData.ToBase64)

    '        objLink.ID = "lnkReportingMgrChange_" + strUniqueID
    '        objLink.NavigateUrl = "Mobile_RequestApprovalRejection.aspx?Mode=" + strMode + "&Type=" + strType + "&Token=" + strEncryptedString
    '        objLink.Text = CommonFunctions.Data.CheckIsDBNull(drReportingMngr("EmployeeName"), "").ToString()

    '        objTextView.ID = "txtReportingMgrChange_" + strUniqueID

    '        strDetails.Append("Change To: ") : strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drReportingMngr("ChangeTo"), "").ToString() & " ")
    '        strDetails.Append("With Effect From: ")
    '        If CommonFunctions.Data.CheckIsDBNull(drReportingMngr("WithEffectFrom"), "").ToString() <> "" Then
    '            strDetails.Append(CommonFunctions.Dates.GetDate(drReportingMngr("WithEffectFrom")) & " ")
    '        Else
    '            strDetails.Append("- ")
    '        End If

    '        objTextView.Text = strDetails.ToString()
    '        strDetails.Length = 0

    '        objLbl.ID = "Lbl_" + CommonFunctions.Data.CheckIsDBNull(drReportingMngr("UniqueID"), "0").ToString()
    '        objLbl.Text = ""

    '        objItem.Value = strUniqueID
    '        objItem.Text = " "
    '        objItem.ID = "ChkSelect" + strUniqueID


    '        objChkBox.ID = "Chk" + strUniqueID
    '        objChkBox.SelectType = MobileControls.ListSelectType.CheckBox
    '        objChkBox.BreakAfter = False
    '        objChkBox.Items.Add(objItem)

    '        Page.FindControl("frmRequestList").Controls.Add(objChkBox)
    '        Page.FindControl("frmRequestList").Controls.Add(objLink)
    '        Page.FindControl("frmRequestList").Controls.Add(objTextView)
    '        Page.FindControl("frmRequestList").Controls.Add(objLbl)
    '        blnIsRecordExists = True
    '    Next

    '    If Not blnIsRecordExists Then
    '        Dim objLabel As New Web.UI.MobileControls.Label()
    '        objLabel.Text = "There are no items to show in this view."
    '        Page.FindControl("frmRequestList").Controls.Add(objLabel)
    '    End If

    '    strDetails = Nothing
    'End Sub

    'Private Sub PlotReportingManagerChangeList()
    '    '=====================================================================
    '    ' Procedure Name        : PlotEmployeeTransferApproval
    '    ' Purpose               : To plot Employee Transfer Approval Links
    '    ' Description           : 
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : Amol Changle
    '    ' Created               : 10 Mar 2009
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim strDetails As New StringBuilder()
    '    Dim blnIsRecordExists As Boolean = False
    '    Dim strUniqueID As String
    '    Dim strEncryptedString As String

    '    dsApprovalRequests = CommonFunctions.Data.GetDataSet("usp_sel_tbl_PM_EmployeeReportingTo_Change NULL,2," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString() + ",7,0", "Tbl_ReportingMngr", UseSQL:=True)
    '    Call DrawPaging()
    '    dsApprovalRequests = CommonFunctions.Data.GetDataSet("usp_sel_tbl_PM_EmployeeReportingTo_Change NULL,2," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString() + ",7,0", "Tbl_ReportingMngr", (intPageNumber - 1) * intNoofRecordsPerPage, IIf(intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage < intNoofRecordsPerPage, intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage, intNoofRecordsPerPage), UseSQL:=True)

    '    'Plot Request list
    '    For Each drReportingMngr As DataRow In dsApprovalRequests.Tables(0).Rows
    '        Dim objLink As New Web.UI.MobileControls.Link()
    '        Dim objTextView As New Web.UI.MobileControls.TextView()
    '        Dim objLbl As New Web.UI.MobileControls.Label()
    '        Dim objChkBox As New Web.UI.MobileControls.SelectionList


    '        strUniqueID = CommonFunctions.Data.CheckIsDBNull(drReportingMngr("UniqueID"), "0").ToString()
    '        arrLeaveID.Add(strUniqueID)

    '        Dim objItem As New Web.UI.MobileControls.MobileListItem(strUniqueID, strUniqueID)

    '        Dim sym As New Encryption.Symmetric(Encryption.Symmetric.Provider.Rijndael)
    '        Dim key As New Encryption.Data("crazyFrogJumpsTo")
    '        Dim encryptedData As New Encryption.Data

    '        encryptedData = sym.Encrypt(New Encryption.Data(strUniqueID), key)
    '        strEncryptedString = HttpUtility.UrlEncode(encryptedData.ToBase64)

    '        objLink.ID = "lnkReportingMgrChange_" + strUniqueID
    '        objLink.NavigateUrl = "Mobile_RequestApprovalRejection.aspx?Mode=" + strMode + "&Type=" + strType + "&Token=" + strEncryptedString
    '        objLink.Text = CommonFunctions.Data.CheckIsDBNull(drReportingMngr("EmployeeName"), "").ToString()

    '        objTextView.ID = "txtReportingMgrChange_" + strUniqueID

    '        strDetails.Append("Change To: ") : strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drReportingMngr("ChangeTo"), "").ToString() & " ")
    '        strDetails.Append("With Effect From: ")
    '        If CommonFunctions.Data.CheckIsDBNull(drReportingMngr("WithEffectFrom"), "").ToString() <> "" Then
    '            strDetails.Append(CommonFunctions.Dates.GetDate(drReportingMngr("WithEffectFrom")) & " ")
    '        Else
    '            strDetails.Append("- ")
    '        End If

    '        objTextView.Text = strDetails.ToString()
    '        strDetails.Length = 0

    '        objLbl.ID = "Lbl_" + CommonFunctions.Data.CheckIsDBNull(drReportingMngr("UniqueID"), "0").ToString()
    '        objLbl.Text = ""

    '        objItem.Value = strUniqueID
    '        objItem.Text = " "
    '        objItem.ID = "ChkSelect" + strUniqueID


    '        objChkBox.ID = "Chk" + strUniqueID
    '        objChkBox.SelectType = MobileControls.ListSelectType.CheckBox
    '        objChkBox.BreakAfter = False
    '        objChkBox.Items.Add(objItem)

    '        Page.FindControl("frmRequestList").Controls.Add(objChkBox)
    '        Page.FindControl("frmRequestList").Controls.Add(objLink)
    '        Page.FindControl("frmRequestList").Controls.Add(objTextView)
    '        Page.FindControl("frmRequestList").Controls.Add(objLbl)
    '        blnIsRecordExists = True
    '    Next

    '    If Not blnIsRecordExists Then
    '        Dim objLabel As New Web.UI.MobileControls.Label()
    '        objLabel.Text = "There are no items to show in this view."
    '        Page.FindControl("frmRequestList").Controls.Add(objLabel)
    '    End If

    '    strDetails = Nothing
    'End Sub

    'Private Sub PlotOrgStrChangeList()
    '    '=====================================================================
    '    ' Procedure Name        : PlotEmployeeTransferApproval
    '    ' Purpose               : To plot Employee Transfer Approval Links
    '    ' Description           : 
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : Amol Changle
    '    ' Created               : 10 Mar 2009
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim strDetails As New StringBuilder()
    '    Dim blnIsRecordExists As Boolean = False
    '    Dim strUniqueID As String
    '    Dim strEncryptedString As String

    '    dsApprovalRequests = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_PM_EmployeeOrgsStr_Change NULL,2," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString() + ",7,0", "Tbl_ReportingMngr", UseSQL:=True)
    '    Call DrawPaging()
    '    dsApprovalRequests = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_PM_EmployeeOrgsStr_Change NULL,2," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString() + ",7,0", "Tbl_ReportingMngr", (intPageNumber - 1) * intNoofRecordsPerPage, IIf(intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage < intNoofRecordsPerPage, intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage, intNoofRecordsPerPage), UseSQL:=True)

    '    'Plot Request list
    '    For Each drReportingMngr As DataRow In dsApprovalRequests.Tables(0).Rows
    '        Dim objLink As New Web.UI.MobileControls.Link()
    '        Dim objTextView As New Web.UI.MobileControls.TextView()
    '        Dim objLbl As New Web.UI.MobileControls.Label()
    '        Dim objChkBox As New Web.UI.MobileControls.SelectionList


    '        strUniqueID = CommonFunctions.Data.CheckIsDBNull(drReportingMngr("UniqueID"), "0").ToString()
    '        arrLeaveID.Add(strUniqueID)

    '        Dim objItem As New Web.UI.MobileControls.MobileListItem(strUniqueID, strUniqueID)

    '        Dim sym As New Encryption.Symmetric(Encryption.Symmetric.Provider.Rijndael)
    '        Dim key As New Encryption.Data("crazyFrogJumpsTo")
    '        Dim encryptedData As New Encryption.Data

    '        encryptedData = sym.Encrypt(New Encryption.Data(strUniqueID), key)
    '        strEncryptedString = HttpUtility.UrlEncode(encryptedData.ToBase64)

    '        objLink.ID = "lnkReportingMgrChange_" + strUniqueID
    '        objLink.NavigateUrl = "Mobile_RequestApprovalRejection.aspx?Mode=" + strMode + "&Type=" + strType + "&Token=" + strEncryptedString
    '        objLink.Text = CommonFunctions.Data.CheckIsDBNull(drReportingMngr("EmployeeName"), "").ToString()

    '        objTextView.ID = "txtReportingMgrChange_" + strUniqueID

    '        strDetails.Append("Change To: ") : strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drReportingMngr("ChangeTo"), "").ToString() & " ")
    '        strDetails.Append("With Effect From: ")
    '        If CommonFunctions.Data.CheckIsDBNull(drReportingMngr("WithEffectFrom"), "").ToString() <> "" Then
    '            strDetails.Append(CommonFunctions.Dates.GetDate(drReportingMngr("WithEffectFrom")) & " ")
    '        Else
    '            strDetails.Append("- ")
    '        End If

    '        objTextView.Text = strDetails.ToString()
    '        strDetails.Length = 0

    '        objLbl.ID = "Lbl_" + CommonFunctions.Data.CheckIsDBNull(drReportingMngr("UniqueID"), "0").ToString()
    '        objLbl.Text = ""

    '        objItem.Value = strUniqueID
    '        objItem.Text = " "
    '        objItem.ID = "ChkSelect" + strUniqueID


    '        objChkBox.ID = "Chk" + strUniqueID
    '        objChkBox.SelectType = MobileControls.ListSelectType.CheckBox
    '        objChkBox.BreakAfter = False
    '        objChkBox.Items.Add(objItem)

    '        Page.FindControl("frmRequestList").Controls.Add(objChkBox)
    '        Page.FindControl("frmRequestList").Controls.Add(objLink)
    '        Page.FindControl("frmRequestList").Controls.Add(objTextView)
    '        Page.FindControl("frmRequestList").Controls.Add(objLbl)
    '        blnIsRecordExists = True
    '    Next

    '    If Not blnIsRecordExists Then
    '        Dim objLabel As New Web.UI.MobileControls.Label()
    '        objLabel.Text = "There are no items to show in this view."
    '        Page.FindControl("frmRequestList").Controls.Add(objLabel)
    '    End If

    '    strDetails = Nothing
    'End Sub

    'Private Sub PlotCostCenterChangeList()
    '    '=====================================================================
    '    ' Procedure Name        : PlotEmployeeTransferApproval
    '    ' Purpose               : To plot Employee Transfer Approval Links
    '    ' Description           : 
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : Amol Changle
    '    ' Created               : 10 Mar 2009
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim strDetails As New StringBuilder()
    '    Dim blnIsRecordExists As Boolean = False
    '    Dim strUniqueID As String
    '    Dim strEncryptedString As String

    '    dsApprovalRequests = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_PM_EmployeeCostCenter_Change NULL,2," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString() + ",7,0", "Tbl_ReportingMngr", UseSQL:=True)
    '    Call DrawPaging()
    '    dsApprovalRequests = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_PM_EmployeeCostCenter_Change NULL,2," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString() + ",7,0", "Tbl_ReportingMngr", (intPageNumber - 1) * intNoofRecordsPerPage, IIf(intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage < intNoofRecordsPerPage, intNoofRecords - (intPageNumber - 1) * intNoofRecordsPerPage, intNoofRecordsPerPage), UseSQL:=True)

    '    'Plot Request list
    '    For Each drReportingMngr As DataRow In dsApprovalRequests.Tables(0).Rows
    '        Dim objLink As New Web.UI.MobileControls.Link()
    '        Dim objTextView As New Web.UI.MobileControls.TextView()
    '        Dim objLbl As New Web.UI.MobileControls.Label()
    '        Dim objChkBox As New Web.UI.MobileControls.SelectionList


    '        strUniqueID = CommonFunctions.Data.CheckIsDBNull(drReportingMngr("UniqueID"), "0").ToString()
    '        arrLeaveID.Add(strUniqueID)

    '        Dim objItem As New Web.UI.MobileControls.MobileListItem(strUniqueID, strUniqueID)

    '        Dim sym As New Encryption.Symmetric(Encryption.Symmetric.Provider.Rijndael)
    '        Dim key As New Encryption.Data("crazyFrogJumpsTo")
    '        Dim encryptedData As New Encryption.Data

    '        encryptedData = sym.Encrypt(New Encryption.Data(strUniqueID), key)
    '        strEncryptedString = HttpUtility.UrlEncode(encryptedData.ToBase64)

    '        objLink.ID = "lnkReportingMgrChange_" + strUniqueID
    '        objLink.NavigateUrl = "Mobile_RequestApprovalRejection.aspx?Mode=" + strMode + "&Type=" + strType + "&Token=" + strEncryptedString
    '        objLink.Text = CommonFunctions.Data.CheckIsDBNull(drReportingMngr("EmployeeName"), "").ToString()

    '        objTextView.ID = "txtReportingMgrChange_" + strUniqueID

    '        strDetails.Append("Change To: ") : strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drReportingMngr("ChangeTo"), "").ToString() & " ")
    '        strDetails.Append("With Effect From: ")
    '        If CommonFunctions.Data.CheckIsDBNull(drReportingMngr("WithEffectFrom"), "").ToString() <> "" Then
    '            strDetails.Append(CommonFunctions.Dates.GetDate(drReportingMngr("WithEffectFrom")) & " ")
    '        Else
    '            strDetails.Append("- ")
    '        End If

    '        objTextView.Text = strDetails.ToString()
    '        strDetails.Length = 0

    '        objLbl.ID = "Lbl_" + CommonFunctions.Data.CheckIsDBNull(drReportingMngr("UniqueID"), "0").ToString()
    '        objLbl.Text = ""

    '        objItem.Value = strUniqueID
    '        objItem.Text = " "
    '        objItem.ID = "ChkSelect" + strUniqueID


    '        objChkBox.ID = "Chk" + strUniqueID
    '        objChkBox.SelectType = MobileControls.ListSelectType.CheckBox
    '        objChkBox.BreakAfter = False
    '        objChkBox.Items.Add(objItem)

    '        Page.FindControl("frmRequestList").Controls.Add(objChkBox)
    '        Page.FindControl("frmRequestList").Controls.Add(objLink)
    '        Page.FindControl("frmRequestList").Controls.Add(objTextView)
    '        Page.FindControl("frmRequestList").Controls.Add(objLbl)
    '        blnIsRecordExists = True
    '    Next

    '    If Not blnIsRecordExists Then
    '        Dim objLabel As New Web.UI.MobileControls.Label()
    '        objLabel.Text = "There are no items to show in this view."
    '        Page.FindControl("frmRequestList").Controls.Add(objLabel)
    '    End If

    '    strDetails = Nothing
    'End Sub

    'Private Sub ApproveEmployeeTransferChangeRequest()
    '    '=====================================================================
    '    ' Procedure Name        : ApproveEmployeeTransferChangeRequest
    '    ' Purpose               : To approve Employee Transfe
    '    ' Description           : 
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : Amol Changle
    '    ' Created               : 11 Mar 2009
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim i As Integer
    '    Dim strSQL As New StringBuilder()
    '    Dim strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage As String
    '    Dim blnSendMail As Boolean
    '    Dim dr As IDataReader
    '    Dim strEmployeeID As String
    '    Dim strNewActionID As String
    '    Dim strNewBusinessGroupID As String
    '    Dim strNewLocationID As String
    '    Dim strNewResourcePoolID As String
    '    Dim strNewGroupID As String
    '    Dim strWithEffectFrom As String
    '    Dim drRequest As DataRow

    '    ' send mail
    '    dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 166", True)
    '    If dr.Read Then
    '        blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
    '    End If
    '    CommonFunctions.Data.DisposeDataReader(dr)


    '    For i = 0 To arrLeaveID.Count - 1
    '        If Not HttpContext.Current.Request.Form("Chk" + arrLeaveID(i).ToString()) Is Nothing Then

    '            drRequest = dsApprovalRequests.Tables(0).Select("UniqueID=" + arrLeaveID(i).ToString())(0)
    '            strEmployeeID = CommonFunctions.Data.CheckIsDBNull(drRequest("EmployeeID"), ).ToString()
    '            strWithEffectFrom = CommonFunctions.Data.CheckIsDBNull(drRequest("WithEffectFrom"), Date.Now).ToString()

    '            Select Case CType(strType, Integer)
    '                Case EmployeeTransfer.Grade
    '                    strSQL.Append("usp_Upd_tbl_PM_EmployeeGrade_Change  ")
    '                    strNewActionID = CommonFunctions.Data.CheckIsDBNull(drRequest("GradeID"), ).ToString()
    '                Case EmployeeTransfer.Role
    '                    strSQL.Append("usp_Upd_tbl_PM_EmployeeRole_Change  ")
    '                    strNewActionID = CommonFunctions.Data.CheckIsDBNull(drRequest("PostID"), ).ToString()
    '                Case EmployeeTransfer.EmployeeType
    '                    strSQL.Append("usp_Upd_tbl_PM_EmployeeType_Change  ")
    '                    strNewActionID = CommonFunctions.Data.CheckIsDBNull(drRequest("EmployeeType"), ).ToString()
    '                Case EmployeeTransfer.Designation
    '                    strSQL.Append("usp_Upd_tbl_PM_EmployeeDesignation_Change  ")
    '                    strNewActionID = strEmployeeID = CommonFunctions.Data.CheckIsDBNull(drRequest("DesignationID"), ).ToString()
    '                Case EmployeeTransfer.ReportingManager
    '                    strSQL.Append("usp_Upd_tbl_PM_EmployeeReportingTo_Change  ")
    '                    strNewActionID = CommonFunctions.Data.CheckIsDBNull(drRequest("ReportingToID"), ).ToString()
    '                Case EmployeeTransfer.OrganizationStucture
    '                    strSQL.Append("usp_Upd_tbl_PM_EmployeeOrgsStr_Change ")
    '                    strNewBusinessGroupID = CommonFunctions.Data.CheckIsDBNull(drRequest("BusinessGroupID"), "NULL").ToString()
    '                    strNewLocationID = CommonFunctions.Data.CheckIsDBNull(drRequest("LocationID"), "NULL").ToString()
    '                    strNewResourcePoolID = CommonFunctions.Data.CheckIsDBNull(drRequest("ResourcePoolID"), "NULL").ToString()
    '                    strNewGroupID = CommonFunctions.Data.CheckIsDBNull(drRequest("GroupID"), "NULL").ToString()
    '                Case EmployeeTransfer.CostCenter
    '                    strSQL.Append("usp_Upd_tbl_PM_EmployeeCostCenter_Change  ")
    '                    strNewActionID = CommonFunctions.Data.CheckIsDBNull(drRequest("CostCenterID"), ).ToString()
    '            End Select

    '            strSQL.Append(strEmployeeID)
    '            If strType = "10" Then
    '                strSQL.Append(",")
    '                strSQL.Append(strNewBusinessGroupID)
    '                strSQL.Append(",")
    '                strSQL.Append(strNewLocationID)
    '                strSQL.Append(",")
    '                strSQL.Append(strNewResourcePoolID)
    '                strSQL.Append(",")
    '                strSQL.Append(strNewGroupID)
    '                strSQL.Append(",'")
    '            Else
    '                strSQL.Append(",N'")
    '                strSQL.Append(strNewActionID)
    '                strSQL.Append("','")
    '            End If
    '            strSQL.Append(strWithEffectFrom)
    '            strSQL.Append("',N'")
    '            strSQL.Append(CommonFunctions.General.BuildQueryString("approved"))
    '            strSQL.Append("',N'")
    '            strSQL.Append(strUserName)
    '            strSQL.Append("',")
    '            strSQL.Append(arrLeaveID(i).ToString())
    '            CommonFunctions.Data.InsertOrUpdateData(strSQL.ToString(), True)
    '            strSQL.Length = 0

    '            If blnSendMail Then
    '                CommonFunction.EmailMessages.HRMessages.GetEmailMessage_166(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, arrLeaveID(i).ToString(), strType, 166)
    '                CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
    '            End If
    '        End If
    '    Next

    '    strSQL = Nothing
    'End Sub

    'Private Sub RejectEmployeeTransferChangeRequest()
    '    '=====================================================================
    '    ' Procedure Name        : RejectEmployeeTransferChangeRequest
    '    ' Purpose               : To Reject Employee Transfer Request
    '    ' Description           : 
    '    ' Parameters Passed     : strAction
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : Amol Changle
    '    ' Created               : 11 Mar 2009
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim i As Integer
    '    Dim strSQL As New StringBuilder()
    '    Dim strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage As String
    '    Dim blnSendMail As Boolean
    '    Dim dr As IDataReader

    '    ' send mail
    '    dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 167", True)
    '    If dr.Read Then
    '        blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
    '    End If
    '    CommonFunctions.Data.DisposeDataReader(dr)


    '    For i = 0 To arrLeaveID.Count - 1
    '        If Not HttpContext.Current.Request.Form("Chk" + arrLeaveID(i).ToString()) Is Nothing Then
    '            Select Case CType(strType, Integer)
    '                Case EmployeeTransfer.Grade
    '                    strSQL.Append("usp_Upd_tbl_PM_EmployeeGrade_Change_Rejected  N'")
    '                Case EmployeeTransfer.Role
    '                    strSQL.Append("usp_Upd_tbl_PM_EmployeeRole_Change_Rejected  N'")
    '                Case EmployeeTransfer.EmployeeType
    '                    strSQL.Append("usp_Upd_tbl_PM_EmployeeType_Change_Rejected  N'")
    '                Case EmployeeTransfer.Designation
    '                    strSQL.Append("usp_Upd_tbl_PM_EmployeeDesignation_Change_Rejected  N'")
    '                Case EmployeeTransfer.ReportingManager
    '                    strSQL.Append("usp_Upd_tbl_PM_EmployeeReportingTo_Change_Rejected  N'")
    '                Case EmployeeTransfer.OrganizationStucture
    '                    strSQL.Append("usp_Upd_tbl_PM_EmployeeOrgsStr_Change_Rejected  N'")
    '                Case EmployeeTransfer.CostCenter
    '                    strSQL.Append("usp_Upd_tbl_PM_EmployeeCostCenter_Change_Rejected  N'")
    '            End Select

    '            strSQL.Append("rejected',")
    '            strSQL.Append(arrLeaveID(i).ToString())
    '            CommonFunctions.Data.InsertOrUpdateData(strSQL.ToString(), True)
    '            strSQL.Length = 0

    '            If blnSendMail Then
    '                CommonFunction.EmailMessages.HRMessages.GetEmailMessage_167(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, arrLeaveID(i).ToString(), strType, 167)
    '                CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
    '            End If
    '        End If
    '    Next

    '    strSQL = Nothing
    'End Sub

End Class


