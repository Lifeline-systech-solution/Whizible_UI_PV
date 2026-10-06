
Partial Class Mobile_RequestApprovalRejection
    Inherits System.Web.UI.MobileControls.MobilePage

#Region "Member Variables"
    Private strPrimaryKeyValue As String
    Private strUserID As String
    Private strUserName As String
    Private strMode As String
    Private strType As String
    Private strCurrency As String

    Private strProcessID As String
    Private strStageID As String
    Private strInboxID As String
    Private strInstanceID As String
    Private strEmployeeID As String
    Private strNewActionID As String
    Private strWithEffectFrom As String
    Private strNewBusinessGroupID As String = ""
    Private strNewLocationID As String = ""
    Private strNewResourcePoolID As String = ""
    Private strNewGroupID As String = ""
    Dim dteFromDate As String
    Dim dteToDate As String
    Dim strResourceID As String
    Private intRecipientID As Integer
    Private strWorkFlowType As String = ""

    'Private Enum EmployeeTransfer
    '    Grade = 1
    '    Role = 2
    '    EmployeeType = 3
    '    Designation = 4
    '    ReportingManager = 5
    '    CostCenter = 9
    '    OrganizationStucture = 10
    'End Enum

    Private ObjTxtComments As New Web.UI.MobileControls.TextBox
    Private WithEvents ObjCmdApprove As New Web.UI.MobileControls.Command
    Private WithEvents ObjCmdReject As New Web.UI.MobileControls.Command

#End Region

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim sym As New Encryption.Symmetric(Encryption.Symmetric.Provider.Rijndael)
        Dim key As New Encryption.Data("crazyFrogJumpsTo")
        Dim encryptedData As New Encryption.Data

        If Session("intUserID") Is Nothing Then
            Call LogOut()
        End If

        strMode = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "").ToString()
        strType = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Type"), "").ToString()
        strUserID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString()
        strUserName = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "").ToString()
        strPrimaryKeyValue = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Token"), "").ToString()
        'strCurrency = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_CompanyInformation_Currency", True))).ToString()
        LnkBack1.NavigateUrl = "Mobile_RequestlList.aspx?Mode=" + strMode

        If strMode.ToLower() <> "logout" Then
            encryptedData.Base64 = strPrimaryKeyValue

            Dim decrypteddata As Encryption.Data
            decrypteddata = sym.Decrypt(encryptedData, key)
            strPrimaryKeyValue = HttpUtility.UrlDecode(decrypteddata.ToString)
        End If

        Dim ObjLabel As New Web.UI.MobileControls.Label
        Dim ObjBlankLabel As New Web.UI.MobileControls.Label
        Dim ObjLblComment As New Web.UI.MobileControls.Label
        Dim objRequiredFileldValidator As New System.Web.UI.MobileControls.RequiredFieldValidator

        Select Case strMode.ToLower()
            Case "logout"
                Call LogOut()

            Case "leave"
                Call PlotLeaveDetails()

            Case "resourcetimesheet"
                ObjTxtComments.Visible = False
                ObjLblComment.Visible = False
                Call PlotResourceTimesheetDetails()

            Case "project"
                Call PlotProjectDetails()

            Case "projecttimesheet"
                Call PlotProjectTimesheetDetails()
        End Select

        'Dim objFontInfo As Web.UI.MobileControls.FontInfo
        'objFontInfo.Bold = MobileControls.BooleanOption.True

        ObjTxtComments.ID = "TxtComments"
        ObjTxtComments.Size = 50
        ObjTxtComments.MaxLength = 100

        ObjCmdApprove.Text = "Approve"
        ObjCmdApprove.BreakAfter = False

        ObjCmdReject.Text = "Reject"

        ObjLabel.ID = "LblBlank"
        ObjLabel.Text = ""

        ObjBlankLabel.ID = "LblBlank1"
        ObjBlankLabel.Text = ""

        ObjLblComment.ID = "LblComment"
        ObjLblComment.Text = "Comment:"
        ObjLblComment.BreakAfter = True

        objRequiredFileldValidator.ID = "ValidateComment"
        objRequiredFileldValidator.ControlToValidate = "TxtComments"
        objRequiredFileldValidator.ErrorMessage = "Please, Enter Comment"
        objRequiredFileldValidator.BreakAfter = True

        Page.FindControl("frmRequestApprovalRejection").Controls.Add(ObjLabel)
        Page.FindControl("frmRequestApprovalRejection").Controls.Add(ObjLblComment)
        Page.FindControl("frmRequestApprovalRejection").Controls.Add(ObjTxtComments)
        Page.FindControl("frmRequestApprovalRejection").Controls.Add(objRequiredFileldValidator)
        Page.FindControl("frmRequestApprovalRejection").Controls.Add(ObjCmdApprove)
        Page.FindControl("frmRequestApprovalRejection").Controls.Add(ObjCmdReject)
        Page.FindControl("frmRequestApprovalRejection").Controls.Add(ObjBlankLabel)

        'Logout Link
        Dim objLogOut As New Web.UI.MobileControls.Link()
        Dim objBack As New Web.UI.MobileControls.Link
        Dim objLblLogout As New Web.UI.MobileControls.Label()


        objBack.Text = "Back"
        objBack.ID = "LnkBack"
        If strMode.ToLower() = "emptransfer" Then
            LnkBack1.NavigateUrl = "Mobile_RequestlList.aspx?Mode=" + strMode + "&Type=" + strType
            objBack.NavigateUrl = "Mobile_RequestlList.aspx?Mode=" + strMode + "&Type=" + strType
        Else
            objBack.NavigateUrl = "Mobile_RequestlList.aspx?Mode=" + strMode
        End If
        objBack.BreakAfter = False

        objLblLogout.ID = "LblLogout"
        objLblLogout.Text = " | "
        objLblLogout.BreakAfter = False

        objLogOut.Text = "Logout"
        objLogOut.ID = "LnkLogOut"
        objLogOut.NavigateUrl = "Mobile_RequestApprovalRejection.aspx?Mode=Logout"

        Page.FindControl("frmRequestApprovalRejection").Controls.Add(objBack)
        Page.FindControl("frmRequestApprovalRejection").Controls.Add(objLblLogout)
        Page.FindControl("frmRequestApprovalRejection").Controls.Add(objLogOut)
    End Sub

    Private Sub PlotLeaveDetails()
        '=====================================================================
        ' Procedure Name        : PlotLeaveDetails()
        ' Purpose               : To plot leave details
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
        Dim dsLeaveDetails As DataSet
        Dim objTxtLeaveDetails As New Web.UI.MobileControls.TextView
        Dim strLeaveDetails As New StringBuilder("")

        dsLeaveDetails = CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_EmployeeLeaveDetails_Pending_Approval " + strUserID + ",NULL," + strPrimaryKeyValue, "tbl_Leave", UseSQL:=True)

        For Each drLeave As DataRow In dsLeaveDetails.Tables(0).Rows
            strLeaveDetails.Append("<b>Employee ID:</b> ")
            strLeaveDetails.Append(CommonFunctions.Data.CheckIsDBNull(drLeave("EmployeeCode")).ToString())
            strLeaveDetails.Append("<br />")
            strLeaveDetails.Append("<b>Employee Name:</b> ")
            strLeaveDetails.Append(CommonFunctions.Data.CheckIsDBNull(drLeave("EmployeeName")).ToString())
            strLeaveDetails.Append("<br />")
            strLeaveDetails.Append("<b>From Date:</b> ")
            If CommonFunctions.Data.CheckIsDBNull(drLeave("FromDate")).ToString() = "" Then
                strLeaveDetails.Append("-")
            Else
                strLeaveDetails.Append(CommonFunctions.Dates.GetDate(CType(drLeave("FromDate"), Date)))
            End If
            strLeaveDetails.Append("<br />")
            strLeaveDetails.Append("<b>To Date:</b> ")
            If CommonFunctions.Data.CheckIsDBNull(drLeave("ToDate")).ToString() = "" Then
                strLeaveDetails.Append("-")
            Else
                strLeaveDetails.Append(CommonFunctions.Dates.GetDate(CType(drLeave("ToDate"), Date)))
            End If
            strLeaveDetails.Append("<br />")
            strLeaveDetails.Append("<b>Leave Type:</b> ")
            strLeaveDetails.Append(CommonFunctions.Data.CheckIsDBNull(drLeave("LeaveType")))
            strLeaveDetails.Append("<br />")
            strLeaveDetails.Append("<b>Is Half Day:</b> ")
            strLeaveDetails.Append(CommonFunctions.Data.CheckIsDBNull(drLeave("HalfDay")).ToString())
            strLeaveDetails.Append("<br />")
            strLeaveDetails.Append("<b>No. of Days:</b> ")
            strLeaveDetails.Append(CommonFunctions.Data.CheckIsDBNull(drLeave("NumberOfDays")).ToString())
            strLeaveDetails.Append("<br />")
            strLeaveDetails.Append("<b>Leave Balance:</b> ")
            strLeaveDetails.Append(CommonFunctions.Data.CheckIsDBNull(drLeave("LeaveBalance")).ToString())
        Next
        objTxtLeaveDetails.ID = "TxtLeaveDetails"
        objTxtLeaveDetails.Text = strLeaveDetails.ToString()
        Page.FindControl("frmRequestApprovalRejection").Controls.Add(objTxtLeaveDetails)
        strLeaveDetails = Nothing
    End Sub

    Private Sub PlotResourceTimesheetDetails()
        '=====================================================================
        ' Procedure Name        : PlotResourceTimesheetDetails()
        ' Purpose               : To plot Resource Timesheet details
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
        Dim dsRTDetails As DataSet
        Dim objTxtRTDetails As New Web.UI.MobileControls.TextView
        Dim strRTDetails As New StringBuilder("")
        Dim dblTotalWorkHrs As Double = 0.0

        dsRTDetails = CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_ResourceTimesheet " + strPrimaryKeyValue, "tbl_RT", UseSQL:=True)


        If dsRTDetails.Tables(0).Rows.Count > 0 Then
            strRTDetails.Append("<b>Employee ID:</b> ")
            strRTDetails.Append(CommonFunctions.Data.CheckIsDBNull(dsRTDetails.Tables(0).Rows(0)("EmployeeCode")))
            strRTDetails.Append("<br />")
            strRTDetails.Append("<b>Employee Name:</b> ")
            strRTDetails.Append(CommonFunctions.Data.CheckIsDBNull(dsRTDetails.Tables(0).Rows(0)("EmployeeName")))
            strRTDetails.Append("<br />")
            strRTDetails.Append("<b>Period:</b> ")
            If CommonFunctions.Data.CheckIsDBNull(dsRTDetails.Tables(0).Rows(0)("FromDate")).ToString() = "" Then
                strRTDetails.Append(" - ")
            Else
                strRTDetails.Append(CommonFunctions.Dates.CGetDate(dsRTDetails.Tables(0).Rows(0)("FromDate")))
            End If
            strRTDetails.Append(" <b>To</b> ")
            If CommonFunctions.Data.CheckIsDBNull(dsRTDetails.Tables(0).Rows(0)("ToDate")).ToString() = "" Then
                strRTDetails.Append(" - ")
            Else
                strRTDetails.Append(CommonFunctions.Dates.CGetDate(dsRTDetails.Tables(0).Rows(0)("ToDate")))
            End If

            dteFromDate = CommonFunctions.Data.CheckIsDBNull(dsRTDetails.Tables(0).Rows(0)("FromDate")).ToString()
            dteToDate = CommonFunctions.Data.CheckIsDBNull(dsRTDetails.Tables(0).Rows(0)("ToDate")).ToString()
            strResourceID = CommonFunctions.Data.CheckIsDBNull(dsRTDetails.Tables(0).Rows(0)("EmployeeID")).ToString()
        End If
        strRTDetails.Append("<br /><br />")
        strRTDetails.Append("<b>Timesheet Details</b><br/>")
        For Each drTimesheet As DataRow In dsRTDetails.Tables(0).Rows
            strRTDetails.Append("<b>Project: </b>" + CommonFunctions.Data.CheckIsDBNull(drTimesheet("ProjectName")))
            strRTDetails.Append("    <b>Actual Work(Hrs): </b>" + FormatNumber(CommonFunctions.Data.CheckIsDBNull(drTimesheet("WorkHrs"), "0.0"), 2))
            strRTDetails.Append("<br/>")
            dblTotalWorkHrs += CType(CommonFunctions.Data.CheckIsDBNull(drTimesheet("WorkHrs"), "0.0"), Double)
        Next
        strRTDetails.Append("<br />")
        strRTDetails.Append("<b>Total Work(Hrs) for the period: </b>")
        strRTDetails.Append(FormatNumber(dblTotalWorkHrs))


        objTxtRTDetails.ID = "TxtLeaveDetails"
        objTxtRTDetails.Text = strRTDetails.ToString()
        Page.FindControl("frmRequestApprovalRejection").Controls.Add(objTxtRTDetails)
        strRTDetails = Nothing
    End Sub

    Private Sub PlotProjectTimesheetDetails()
        '=====================================================================
        ' Procedure Name        : PlotProjectTimesheetDetails()
        ' Purpose               : To plot Project Timesheet details
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
        Dim dsPTDetails As DataSet
        Dim objTxtPTDetails As New Web.UI.MobileControls.TextView
        Dim strPTDetails As New StringBuilder("")
        Dim dblTotalWorkHrs As Double = 0.0

        dsPTDetails = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_PM_TimeSheetInvoice 1,NULL," + strPrimaryKeyValue + ",NULL,NULL,NULL,61", "TblTimesheet")

        If dsPTDetails.Tables(0).Rows.Count > 0 Then
            strPTDetails.Append("<b>Timesheet No:</b> ")
            strPTDetails.Append(CommonFunctions.Data.CheckIsDBNull(dsPTDetails.Tables(0).Rows(0)("TimesheetNo"), "").ToString())
            strPTDetails.Append("<br />")
            If CommonFunctions.Data.CheckIsDBNull(dsPTDetails.Tables(0).Rows(0)("CreatedDate"), "").ToString() = "" Then
                strPTDetails.Append("<b>Date:</b> -")
            Else
                strPTDetails.Append("<b>Date:</b> " + CommonFunctions.Dates.CGetDate(dsPTDetails.Tables(0).Rows(0)("CreatedDate")))
            End If
            strPTDetails.Append("<br />")
            strPTDetails.Append("<b>Project Name:</b> ")
            strPTDetails.Append(CommonFunctions.Data.CheckIsDBNull(dsPTDetails.Tables(0).Rows(0)("ProjectName")))
            strPTDetails.Append("<br />")
            strPTDetails.Append("<b>From Date:</b> ")
            If CommonFunctions.Data.CheckIsDBNull(dsPTDetails.Tables(0).Rows(0)("FromDate")).ToString() = "" Then
                strPTDetails.Append(" - ")
            Else
                strPTDetails.Append(CommonFunctions.Dates.CGetDate(dsPTDetails.Tables(0).Rows(0)("FromDate")))
            End If
            strPTDetails.Append("<br />")
            strPTDetails.Append(" <b>To Date</b> ")
            If CommonFunctions.Data.CheckIsDBNull(dsPTDetails.Tables(0).Rows(0)("ToDate")).ToString() = "" Then
                strPTDetails.Append(" - ")
            Else
                strPTDetails.Append(CommonFunctions.Dates.CGetDate(dsPTDetails.Tables(0).Rows(0)("ToDate")))
            End If
            strPTDetails.Append("<br />")
            strPTDetails.Append("<b>Total Work(Hrs): </b>")
            strPTDetails.Append(FormatNumber(CommonFunctions.Data.CheckIsDBNull(dsPTDetails.Tables(0).Rows(0)("TotalTimesheetHours"), "0.0"), 2))
        End If

        dsPTDetails = CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_TimeSheet_EmployeeWiseTotal " + strPrimaryKeyValue, "TblTimesheet")

        strPTDetails.Append("<br /><br />")
        strPTDetails.Append("<b>Timesheet Details</b><br/>")
        For Each drTimesheet As DataRow In dsPTDetails.Tables(0).Rows
            strPTDetails.Append("<b>Employee Name: </b>")
            strPTDetails.Append(CommonFunctions.Data.CheckIsDBNull(drTimesheet("EmployeeName")))
            strPTDetails.Append("    <b>Actual Work(Hrs): </b>")
            strPTDetails.Append(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drTimesheet("WorkHrs"), "0.0"), 2))
            strPTDetails.Append("<br/>")
            dblTotalWorkHrs += CType(CommonFunctions.Data.CheckIsDBNull(drTimesheet("WorkHrs"), "0.0"), Double)
        Next

        objTxtPTDetails.ID = "TxtLeaveDetails"
        objTxtPTDetails.Text = strPTDetails.ToString()
        Page.FindControl("frmRequestApprovalRejection").Controls.Add(objTxtPTDetails)
        strPTDetails = Nothing
    End Sub

    Private Sub PlotProjectDetails()
        '=====================================================================
        ' Procedure Name        : PlotProjectDetails()
        ' Purpose               : To plot Project details
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
        Dim dsProjectDetails As DataSet
        Dim objTxtProjectDetails As New Web.UI.MobileControls.TextView
        Dim strProjectDetails As New StringBuilder("")
        Dim strSentForApprovalBy As String = ""

        dsProjectDetails = CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_ProjectRevision_MobileApprovals " + strUserID + "," + strPrimaryKeyValue, "tbl_Project", UseSQL:=True)

        For Each drProject As DataRow In dsProjectDetails.Tables(0).Rows
            strProjectDetails.Append("<b>Project Code:</b> ")
            strProjectDetails.Append(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectCode")))
            strProjectDetails.Append("<br />")
            strProjectDetails.Append("<b>Project Name:</b> ")
            strProjectDetails.Append(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectName")))
            strProjectDetails.Append("<br />")
            strProjectDetails.Append("<b>Start Date:</b> ")
            If CommonFunctions.Data.CheckIsDBNull(drProject("ExpectedStartDate")).ToString() = "" Then
                strProjectDetails.Append(" - ")
            Else
                strProjectDetails.Append(CommonFunctions.Dates.CGetDate(drProject("ExpectedStartDate")))
            End If
            strProjectDetails.Append("<br />")
            strProjectDetails.Append(" <b>End Date:</b> ")
            If CommonFunctions.Data.CheckIsDBNull(drProject("ExpectedEndDate")).ToString() = "" Then
                strProjectDetails.Append(" - ")
            Else
                strProjectDetails.Append(CommonFunctions.Dates.CGetDate(drProject("ExpectedEndDate")))
            End If
            strProjectDetails.Append("<br />")
            strProjectDetails.Append("<b>Work (Hrs):</b> ")
            strProjectDetails.Append(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drProject("EstimatedEfforts"), "0"), 2))
            strProjectDetails.Append("<br />")
            strProjectDetails.Append("<b>Project Value:</b> ")
            strProjectDetails.Append(CommonFunctions.Data.CheckIsDBNull(drProject("CurrencyCode")))
            strProjectDetails.Append(" ")
            strProjectDetails.Append(FormatNumber(CommonFunctions.Data.CheckIsDBNull(drProject("ContractValue"), "0"), 2))
            strProjectDetails.Append("<br />")
            strProjectDetails.Append("<b>Organization Unit:</b> ")
            strProjectDetails.Append(CommonFunctions.Data.CheckIsDBNull(drProject("Location")))
            strProjectDetails.Append("<br />")
            strProjectDetails.Append("<b>Practice:</b> ")
            strProjectDetails.Append(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectType")))

            strWorkFlowType = CommonFunctions.Data.CheckIsDBNull(drProject("WorkFlowType"))

            Select Case strWorkFlowType
                Case "O" 'Old Project Approval WorkFlow
                    strSentForApprovalBy = CommonFunctions.Data.CheckIsDBNull(drProject("SentForApprovalBy"), "")
                    intRecipientID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_GetEmployeeID N'" & strSentForApprovalBy & "'", True), "0"), "0"), Integer)

                Case "N" 'New project Approval WorkFlow
            End Select
        Next
        objTxtProjectDetails.ID = "TxtProjectDetails"
        objTxtProjectDetails.Text = strProjectDetails.ToString()
        Page.FindControl("frmRequestApprovalRejection").Controls.Add(objTxtProjectDetails)
        strProjectDetails = Nothing
    End Sub

    'Private Sub PlotBenefitClaimDetails()
    '    '=====================================================================
    '    ' Procedure Name        : PlotBenefitClaimDetails()
    '    ' Purpose               : To plot Benefit Claim details
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
    '    Dim dsBenefitClaimDetails As DataSet
    '    Dim objTxtLeaveDetails As New Web.UI.MobileControls.TextView
    '    Dim strDetaiils As New StringBuilder("")

    '    dsBenefitClaimDetails = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_WF_Inbox_ForBenefit_ExpenseClaim_Mobile " + strUserID + "," + strPrimaryKeyValue, "tbl_Leave", UseSQL:=True)
    '    For Each drBenefitClaimDetails As DataRow In dsBenefitClaimDetails.Tables(0).Rows

    '        strProcessID = CommonFunctions.Data.CheckIsDBNull(drBenefitClaimDetails("ProcessID")).ToString()
    '        strStageID = CommonFunctions.Data.CheckIsDBNull(drBenefitClaimDetails("StageID")).ToString()
    '        intTagID = CType(CommonFunctions.Data.CheckIsDBNull(drBenefitClaimDetails("TagID"), "0").ToString(), Integer)
    '        strInboxID = CommonFunctions.Data.CheckIsDBNull(drBenefitClaimDetails("InboxID")).ToString()
    '        strInstanceID = CommonFunctions.Data.CheckIsDBNull(drBenefitClaimDetails("InstanceID")).ToString()

    '        strDetaiils.Append("<b>Employee Name:</b> ")
    '        strDetaiils.Append(CommonFunctions.Data.CheckIsDBNull(drBenefitClaimDetails("Claimer")).ToString())
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>Benefit Type:</b> ")
    '        strDetaiils.Append(CommonFunctions.Data.CheckIsDBNull(drBenefitClaimDetails("BenifitType")).ToString())
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>Claimed Amount:</b> ")
    '        strDetaiils.Append(FormatNumber(CType(CommonFunctions.Data.CheckIsDBNull(drBenefitClaimDetails("ClaimAmount"), "0"), Double), 2))
    '        strDetaiils.Append(" ")
    '        strDetaiils.Append(strCurrency)
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>Claimed Date:</b> ")
    '        If CommonFunctions.Data.CheckIsDBNull(drBenefitClaimDetails("ClaimDate")).ToString() = "" Then
    '            strDetaiils.Append("-")
    '        Else
    '            strDetaiils.Append(CommonFunctions.Dates.GetDate(CType(drBenefitClaimDetails("ClaimDate"), Date)))
    '        End If
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>Financial Year:</b> ")
    '        strDetaiils.Append(CommonFunctions.Data.CheckIsDBNull(drBenefitClaimDetails("FinancialYear")))
    '        strDetaiils.Append("<br />")
    '    Next
    '    objTxtLeaveDetails.ID = "TxtBenefitClaimDetails"
    '    objTxtLeaveDetails.Text = strDetaiils.ToString()
    '    Page.FindControl("frmRequestApprovalRejection").Controls.Add(objTxtLeaveDetails)
    '    strDetaiils = Nothing
    'End Sub

    Private Sub ApproveRejectLeave(ByVal strStatusID As String)
        '=====================================================================
        ' Procedure Name        : ApproveRejectLeave()
        ' Purpose               : To approve/reject leave request
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
        Dim strSQL As New StringBuilder()
        Dim strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage As String
        Dim blnSendMail As Boolean
        Dim dr As IDataReader
        Dim strMsgID As String

        strSQL.Append("usp_Upd_tbl_PM_EmployeeLeaveDetails_AND_Master ")
        strSQL.Append(strPrimaryKeyValue)
        strSQL.Append(",")
        strSQL.Append(strStatusID)
        strSQL.Append(",")
        strSQL.Append(strUserID)
        strSQL.Append(",N'")
        strSQL.Append(CommonFunctions.General.BuildQueryString(ObjTxtComments.Text))
        strSQL.Append("'")
        CommonFunctions.Data.InsertOrUpdateData(strSQL.ToString(), True)

        If strStatusID = "2" Then
            strMsgID = "69"
        Else
            strMsgID = "70"
        End If

        ' send mail
        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages " + strMsgID, True)
        If dr.Read Then
            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

        If blnSendMail Then
            If strMsgID = "69" Then
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_69(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CType(strPrimaryKeyValue, Integer))
            Else
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_70(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CType(strPrimaryKeyValue, Integer))
            End If
            CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
        End If
    End Sub

    Private Sub ApproveRejectResourceTimesheet(ByVal strStatusID As String)
        '=====================================================================
        ' Procedure Name        : ApproveRejectLeave()
        ' Purpose               : To approve/reject resource timesheet
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
        Dim strQuery As String
        Dim m_drTimesheet As IDataReader
        Dim strDailyActivityID As String
        Dim m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage As String
        Dim blnSendMail As Boolean
        Dim dr As IDataReader
        Dim strMessageID As String
        Dim strRTEntry As New StringBuilder("")


        strQuery = "usp_Sel_ResourceTimesheetDADetails " & strPrimaryKeyValue & "," & strUserID

        m_drTimesheet = CommonFunctions.Data.GetDataReader(strQuery, True)

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

        If strStatusID = "1" Then
            strMessageID = "435"
        Else
            strMessageID = "437"
            If strRTEntry.ToString() <> "" Then
                CommonFunctions.Data.InsertOrUpdateData("usp_Upd_UnverifyResouceTimesheetStatus " + strPrimaryKeyValue + "," + strUserID + ",'" + strRTEntry.ToString() + "'", True)
            End If
        End If

        'Change Status to Verified in tbl_PM_ResourceTimesheetStatus table
        CommonFunctions.Data.InsertOrUpdateData("usp_Upd_tbl_PM_ResourceTimesheetStatus " & strPrimaryKeyValue & "," & strUserID & "," & "'" + IIf(strStatusID = "1", "V", "J").ToString() + "'", True)

        If strStatusID = "1" Then
            Dim strSQLQuery As String
            Dim drVerify As IDataReader
            'If Resource TimeSheet are verified then change the status to 'verified' 
            strSQLQuery = "Exec usp_Sel_ResourceTimesheet_GetVerifiedTasksStatus " & strPrimaryKeyValue
            drVerify = CommonFunctions.Data.GetDataReader(strSQLQuery, True)

            If drVerify.Read = False Then
                strSQLQuery = "Exec usp_Upd_ResouceTimesheetStatus " & strPrimaryKeyValue & ",'V'"
                CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, UseSQL:=True)
                'drResourceTimesheetstatus = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                'CommonFunctions.Data.DisposeDataReader(drResourceTimesheetstatus)
            End If
            CommonFunctions.Data.DisposeDataReader(drVerify)
        End If

        ' send mail
        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages " + strMessageID, True)
        If dr.Read Then
            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

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
    End Sub

    Private Sub ApproveProjectTimesheet()
        '=====================================================================
        ' Procedure Name        : ApproveRejectLeave()
        ' Purpose               : To approve/reject resource timesheet
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
        Dim strQuery As String
        Dim strFromMail As String = ""
        Dim strMailTo As String = ""
        Dim strCCEmailID As String = ""
        Dim strSubject As String = ""
        Dim strMessage As String = ""
        Dim blnSendMail As Boolean
        Dim dr As IDataReader

        strQuery = "usp_Upd_tbl_PM_TimeSheetInvoice '" & strPrimaryKeyValue & "',N'" & CommonFunctions.General.BuildQueryString(ObjTxtComments.Text) & "',N'" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName")) + "'"
        CommonFunctions.Data.InsertOrUpdateData(strQuery, True)

        ' send mail
        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 6", True)
        If dr.Read Then
            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

        If blnSendMail Then
            'Notify Project owener about Approval 
            CommonFunction.EmailMessages.FAMessages.GetEmailMessage_6(strFromMail, strMailTo, strCCEmailID, strSubject, strMessage, CType(strPrimaryKeyValue, Long))
            CommonFunction.Emails.AppSendEmail(strMailTo, strFromMail, strSubject, strMessage)
        End If
    End Sub

    Private Sub RejectProjectTimesheet()
        '=====================================================================
        ' Procedure Name        : RejectProjectTimesheet()
        ' Purpose               : To reject project timesheet
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
        Dim strQuery As String
        Dim strFromMail As String = ""
        Dim strMailTo As String = ""
        Dim strCCToEmailID As String = ""
        Dim strSubject As String = ""
        Dim strMessage As String = ""
        Dim blnSendMail As Boolean
        Dim dr As IDataReader

        strQuery = "usp_Upd_tbl_PM_TimeSheetInvoice_For_Rejection " + strPrimaryKeyValue + ",N'" + CommonFunctions.General.BuildQueryString(ObjTxtComments.Text) + "','" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName")) + "'"
        CommonFunctions.Data.InsertOrUpdateData(strQuery, True)

        ' send mail
        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 442", True)
        If dr.Read Then
            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

        If blnSendMail Then
            'Notify Project owener about rejection 
            CommonFunction.EmailMessages.FAMessages.GetEmailMessage_442(strFromMail, strMailTo, strCCToEmailID, strSubject, strMessage, CType(strPrimaryKeyValue, Long))
            CommonFunction.Emails.AppSendEmailWithCC(strMailTo, strFromMail, strCCToEmailID, strSubject, strMessage)
        End If
    End Sub


    Private Sub LogOut()
        Session.Abandon()
        Response.Clear()
        Response.Redirect("Login.aspx")
    End Sub

    Private Sub ObjCmdApprove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ObjCmdApprove.Click
        If Page.IsValid Then
            Select Case strMode.ToLower()
                Case "leave"
                    Call ApproveRejectLeave("2")

                Case "resourcetimesheet"
                    Call ApproveRejectResourceTimesheet("1")

                Case "project"
                    Select Case strWorkFlowType
                        Case "O"
                            Call ApproveRejectProject_OldWorkFlow("A")
                        Case "N"
                            Call ApproveRejectProject_NewWorkFlow("SYS_APPROVE")
                    End Select

                Case "projecttimesheet"
                    Call ApproveProjectTimesheet()
            End Select
            Response.Redirect("Mobile_RequestlList.aspx?Mode=" + strMode)
        End If
    End Sub

    Private Sub ObjCmdReject_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ObjCmdReject.Click
        If Page.IsValid Then
            Select Case strMode.ToLower()
                Case "leave"
                    Call ApproveRejectLeave("3")

                Case "resourcetimesheet"
                    Call ApproveRejectResourceTimesheet("0")

                Case "project"
                    Select Case strWorkFlowType
                        Case "O"
                            Call ApproveRejectProject_OldWorkFlow("R")
                        Case "N"
                            Call ApproveRejectProject_NewWorkFlow("SYS_REJECT")
                    End Select
                Case "projecttimesheet"
                    Call RejectProjectTimesheet()

            End Select
            Response.Redirect("Mobile_RequestlList.aspx?Mode=" + strMode)
        End If
    End Sub

    Private Sub ApproveRejectProject_NewWorkFlow(ByVal strAction As String)
        '=====================================================================
        ' Procedure Name        : ApproveRejectProject_NewWorkFlow
        ' Purpose               : To Approve/Reject New Project workflow action
        ' Description           : 
        ' Parameters Passed     : strAction
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Amol Changle
        ' Created               : 08 Mar 2009
        ' Revisions             :
        '=====================================================================

        Dim m_objGlobalObject As WebPages.Template.IGlobal
        Dim objWhizTemplate As New WebPages.Template.WhizTemplate


        objWhizTemplate.FillGlobalObject(objWhizTemplate.CurrentThreadUICultureID)
        m_objGlobalObject = objWhizTemplate.GlobalObject
        m_objGlobalObject.TagID = 32


        CommonFunction.WhizibleWorkflow.UpdateWhizibleWorkflowData(m_objGlobalObject, CType(strPrimaryKeyValue, Integer), strAction, "32", "", "", ObjTxtComments.Text, True)

    End Sub

    Private Sub ApproveRejectProject_OldWorkFlow(ByVal strAction As String)
        '=====================================================================
        ' Procedure Name        : ApproveRejectProject_OldWorkFlow
        ' Purpose               : To Approve/Reject Old Project workflow action
        ' Description           : 
        ' Parameters Passed     : strAction
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Amol Changle
        ' Created               : 08 Mar 2009
        ' Revisions             :
        '=====================================================================
        Dim strSQL As New StringBuilder
        Dim strFromEmailID As String = "", strToMailID As String = "", strCCToMailID As String = ""
        Dim strToEmailID As String = "", strCCToEmailID As String = ""
        Dim strEmailMessage As String = "", strSubject As String = "", strMessage As String = ""
        Dim intRevisionReasonID As Integer
        Dim blnSendMail As Boolean
        Dim dr As IDataReader

        If strAction = "A" Then
            strSQL.Append("usp_Ins_tbl_PM_Project_BaselineRevisionReason ")
        Else
            strSQL.Append("usp_Ins_tbl_PM_ProjectBaselineRejectionReason ")
        End If
        strSQL.Append(strPrimaryKeyValue + ",")
        strSQL.Append("N'" & CommonFunction.General.BuildQueryString(ObjTxtComments.Text) & "',")
        strSQL.Append("N'" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "").ToString()) & "'")

        If strAction = "A" Then
            strSQL.Append(",'A'")
        End If

        intRevisionReasonID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL.ToString(), True), "0"), Integer)

        ' send mail
        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 441", True)
        If dr.Read Then
            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

        If blnSendMail Then
            CommonFunction.EmailMessages.PMMessages.GetEmailMessage_441(intRecipientID.ToString(), strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CType(strPrimaryKeyValue, Integer), "" + strAction + "", intRevisionReasonID)
            CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
        End If
        strSQL = Nothing
    End Sub

    'Private Sub PlotReportingManagerChangeDetails()
    '    '=====================================================================
    '    ' Procedure Name        : PlotReportingManagerChangeDetails()
    '    ' Purpose               : To plot Reporting Manager details
    '    ' Description           : 
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : Amol Changle
    '    ' Created               : 10 Apr 2009
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim dsReportingMgrChange As DataSet
    '    Dim objTxtLeaveDetails As New Web.UI.MobileControls.TextView
    '    Dim strDetaiils As New StringBuilder("")
    '    Dim drCurrentDetails As IDataReader
    '    Dim strCurrentReportingToID As String = ""
    '    Dim strCurrentReportingToName As String = ""
    '    Dim strJoiningDate As String = ""
    '    Dim strFromDate As String

    '    dsReportingMgrChange = CommonFunctions.Data.GetDataSet("usp_sel_tbl_PM_EmployeeReportingTo_Change NULL,2," + strUserID + ",NULL,NULL," + strPrimaryKeyValue, "tbl", UseSQL:=True)
    '    For Each drReportingMgrChange As DataRow In dsReportingMgrChange.Tables(0).Rows

    '        strEmployeeID = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("EmployeeID"), "0").ToString()
    '        strNewActionID = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("ReportingToID"), "0").ToString()
    '        strWithEffectFrom = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("WithEffectFrom"), "").ToString()

    '        drCurrentDetails = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_Amendment " + strEmployeeID, True)
    '        If drCurrentDetails.Read() Then
    '            strCurrentReportingToID = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("ReportingTo"), "0").ToString()
    '            strCurrentReportingToName = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("ReportingToName"), "").ToString()
    '            strJoiningDate = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("JoiningDate"), "").ToString()
    '        End If
    '        CommonFunctions.Data.DisposeDataReader(drCurrentDetails)

    '        strFromDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_EmployeeReportingTo_Change " + strEmployeeID + ",3", True)))

    '        strDetaiils.Append("<b>Employee Name:</b> ")
    '        strDetaiils.Append(CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("EmployeeName")).ToString())
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>Current Reporting Manager:</b> ")
    '        strDetaiils.Append(strCurrentReportingToName)
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>From Date:</b> ")
    '        If strFromDate = "" Then
    '            strDetaiils.Append(CommonFunctions.Dates.GetDate(CType(strJoiningDate, Date).AddDays(1)))
    '        Else
    '            strDetaiils.Append(CommonFunctions.Dates.GetDate(CType(strFromDate, Date)))
    '        End If
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>New Line Manager:</b> ")
    '        strDetaiils.Append(CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("ReportingTo")).ToString())
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>With Effect From:</b> ")
    '        If strWithEffectFrom = "" Then
    '            strDetaiils.Append("-")
    '        Else
    '            strDetaiils.Append(CommonFunctions.Dates.GetDate(CType(strWithEffectFrom, Date)))
    '        End If
    '        strDetaiils.Append("<br />")
    '        ObjTxtComments.Text = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("Comments")).ToString()
    '    Next
    '    objTxtLeaveDetails.ID = "TxtBenefitClaimDetails"
    '    objTxtLeaveDetails.Text = strDetaiils.ToString()
    '    Page.FindControl("frmRequestApprovalRejection").Controls.Add(objTxtLeaveDetails)
    '    strDetaiils = Nothing
    'End Sub

    'Private Sub PlotGradeChangeDetails()
    '    '=====================================================================
    '    ' Procedure Name        : PlotGradeChangeDetails()
    '    ' Purpose               : To plot Grade details
    '    ' Description           : 
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : Amol Changle
    '    ' Created               : 10 Apr 2009
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim dsReportingMgrChange As DataSet
    '    Dim objTxtLeaveDetails As New Web.UI.MobileControls.TextView
    '    Dim strDetaiils As New StringBuilder("")
    '    Dim drCurrentDetails As IDataReader
    '    Dim strCurrentGradeID As String = ""
    '    Dim strCurrentGrade As String = ""
    '    Dim strJoiningDate As String = ""
    '    Dim strFromDate As String

    '    dsReportingMgrChange = CommonFunctions.Data.GetDataSet("usp_sel_tbl_PM_EmployeeGrade_Change NULL,2," + strUserID + ",NULL,NULL," + strPrimaryKeyValue, "tbl", UseSQL:=True)
    '    For Each drReportingMgrChange As DataRow In dsReportingMgrChange.Tables(0).Rows

    '        strEmployeeID = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("EmployeeID"), "0").ToString()
    '        strNewActionID = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("GradeID"), "0").ToString()
    '        strWithEffectFrom = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("WithEffectFrom"), "").ToString()

    '        drCurrentDetails = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_Amendment " + strEmployeeID, True)
    '        If drCurrentDetails.Read() Then
    '            strCurrentGradeID = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("GradeID"), "0").ToString()
    '            strCurrentGrade = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("Grade"), "").ToString()
    '            strJoiningDate = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("JoiningDate"), "").ToString()
    '        End If
    '        CommonFunctions.Data.DisposeDataReader(drCurrentDetails)

    '        strFromDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_EmployeeGrade_Change " + strEmployeeID + ",3", True)))

    '        strDetaiils.Append("<b>Employee Name:</b> ")
    '        strDetaiils.Append(CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("EmployeeName")).ToString())
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>Current Grade:</b> ")
    '        strDetaiils.Append(strCurrentGrade)
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>From Date:</b> ")
    '        If strFromDate = "" Then
    '            strDetaiils.Append(CommonFunctions.Dates.GetDate(CType(strJoiningDate, Date).AddDays(1)))
    '        Else
    '            strDetaiils.Append(CommonFunctions.Dates.GetDate(CType(strFromDate, Date)))
    '        End If
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>New Grade:</b> ")
    '        strDetaiils.Append(CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("Grade")).ToString())
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>With Effect From:</b> ")
    '        If strWithEffectFrom = "" Then
    '            strDetaiils.Append("-")
    '        Else
    '            strDetaiils.Append(CommonFunctions.Dates.GetDate(CType(strWithEffectFrom, Date)))
    '        End If
    '        strDetaiils.Append("<br />")
    '        ObjTxtComments.Text = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("Comments")).ToString()
    '    Next
    '    objTxtLeaveDetails.ID = "TxtBenefitClaimDetails"
    '    objTxtLeaveDetails.Text = strDetaiils.ToString()
    '    Page.FindControl("frmRequestApprovalRejection").Controls.Add(objTxtLeaveDetails)
    '    strDetaiils = Nothing
    'End Sub

    'Private Sub PlotRoleChangeDetails()
    '    '=====================================================================
    '    ' Procedure Name        : PlotRoleChangeDetails()
    '    ' Purpose               : To plot Role Change details
    '    ' Description           : 
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : Amol Changle
    '    ' Created               : 10 Apr 2009
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim dsReportingMgrChange As DataSet
    '    Dim objTxtLeaveDetails As New Web.UI.MobileControls.TextView
    '    Dim strDetaiils As New StringBuilder("")
    '    Dim drCurrentDetails As IDataReader
    '    Dim strCurrentRoleID As String = ""
    '    Dim strCurrentRole As String = ""
    '    Dim strJoiningDate As String = ""
    '    Dim strFromDate As String

    '    dsReportingMgrChange = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_PM_EmployeeRole_Change NULL,2," + strUserID + ",NULL,NULL," + strPrimaryKeyValue, "tbl", UseSQL:=True)
    '    For Each drReportingMgrChange As DataRow In dsReportingMgrChange.Tables(0).Rows

    '        strEmployeeID = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("EmployeeID"), "0").ToString()
    '        strNewActionID = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("PostID"), "0").ToString()
    '        strWithEffectFrom = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("WithEffectFrom"), "").ToString()

    '        drCurrentDetails = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_Amendment " + strEmployeeID, True)
    '        If drCurrentDetails.Read() Then
    '            strCurrentRoleID = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("PostID"), "0").ToString()
    '            strCurrentRole = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("RoleName"), "").ToString()
    '            strJoiningDate = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("JoiningDate"), "").ToString()
    '        End If
    '        CommonFunctions.Data.DisposeDataReader(drCurrentDetails)

    '        strFromDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_PM_EmployeeRole_Change " + strEmployeeID + ",3", True)))

    '        strDetaiils.Append("<b>Employee Name:</b> ")
    '        strDetaiils.Append(CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("EmployeeName")).ToString())
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>Current Role:</b> ")
    '        strDetaiils.Append(strCurrentRole)
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>From Date:</b> ")
    '        If strFromDate = "" Then
    '            strDetaiils.Append(CommonFunctions.Dates.GetDate(CType(strJoiningDate, Date).AddDays(1)))
    '        Else
    '            strDetaiils.Append(CommonFunctions.Dates.GetDate(CType(strFromDate, Date)))
    '        End If
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>New Role:</b> ")
    '        strDetaiils.Append(CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("RoleDescription")).ToString())
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>With Effect From:</b> ")
    '        If strWithEffectFrom = "" Then
    '            strDetaiils.Append("-")
    '        Else
    '            strDetaiils.Append(CommonFunctions.Dates.GetDate(CType(strWithEffectFrom, Date)))
    '        End If
    '        strDetaiils.Append("<br />")
    '        ObjTxtComments.Text = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("Comments")).ToString()
    '    Next
    '    objTxtLeaveDetails.ID = "TxtBenefitClaimDetails"
    '    objTxtLeaveDetails.Text = strDetaiils.ToString()
    '    Page.FindControl("frmRequestApprovalRejection").Controls.Add(objTxtLeaveDetails)
    '    strDetaiils = Nothing
    'End Sub

    'Private Sub PlotEmployeeTypeChangeDetails()
    '    '=====================================================================
    '    ' Procedure Name        : PlotEmployeeTypeChangeDetails()
    '    ' Purpose               : To plot Employee Type Change details
    '    ' Description           : 
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : Amol Changle
    '    ' Created               : 10 Apr 2009
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim dsReportingMgrChange As DataSet
    '    Dim objTxtLeaveDetails As New Web.UI.MobileControls.TextView
    '    Dim strDetaiils As New StringBuilder("")
    '    Dim drCurrentDetails As IDataReader
    '    Dim strCurrentEmployeeType As String = ""
    '    Dim strJoiningDate As String = ""
    '    Dim strFromDate As String

    '    dsReportingMgrChange = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_PM_EmployeeType_Change NULL,2," + strUserID + ",NULL,NULL," + strPrimaryKeyValue, "tbl", UseSQL:=True)
    '    For Each drReportingMgrChange As DataRow In dsReportingMgrChange.Tables(0).Rows

    '        strEmployeeID = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("EmployeeID"), "0").ToString()
    '        strNewActionID = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("EmployeeType"), "0").ToString()
    '        strWithEffectFrom = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("WithEffectFrom"), "").ToString()

    '        drCurrentDetails = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_Amendment " + strEmployeeID, True)
    '        If drCurrentDetails.Read() Then
    '            strCurrentEmployeeType = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("EmployeeType"), "").ToString()
    '            strJoiningDate = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("JoiningDate"), "").ToString()
    '        End If
    '        CommonFunctions.Data.DisposeDataReader(drCurrentDetails)

    '        strFromDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_PM_EmployeeType_Change " + strEmployeeID + ",3", True)))

    '        strDetaiils.Append("<b>Employee Name:</b> ")
    '        strDetaiils.Append(CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("EmployeeName")).ToString())
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>Current Employee Type:</b> ")
    '        strDetaiils.Append(strCurrentEmployeeType)
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>From Date:</b> ")
    '        If strFromDate = "" Then
    '            strDetaiils.Append(CommonFunctions.Dates.GetDate(CType(strJoiningDate, Date).AddDays(1)))
    '        Else
    '            strDetaiils.Append(CommonFunctions.Dates.GetDate(CType(strFromDate, Date)))
    '        End If
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>New Employee Type:</b> ")
    '        strDetaiils.Append(CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("EmployeeType")).ToString())
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>With Effect From:</b> ")
    '        If strWithEffectFrom = "" Then
    '            strDetaiils.Append("-")
    '        Else
    '            strDetaiils.Append(CommonFunctions.Dates.GetDate(CType(strWithEffectFrom, Date)))
    '        End If
    '        strDetaiils.Append("<br />")
    '        ObjTxtComments.Text = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("Comments")).ToString()
    '    Next
    '    objTxtLeaveDetails.ID = "TxtBenefitClaimDetails"
    '    objTxtLeaveDetails.Text = strDetaiils.ToString()
    '    Page.FindControl("frmRequestApprovalRejection").Controls.Add(objTxtLeaveDetails)
    '    strDetaiils = Nothing
    'End Sub

    'Private Sub PlotDesignationChangeDetails()
    '    '=====================================================================
    '    ' Procedure Name        : PlotDesignationChangeDetails()
    '    ' Purpose               : To plot Role Change details
    '    ' Description           : 
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : Amol Changle
    '    ' Created               : 10 Apr 2009
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim dsReportingMgrChange As DataSet
    '    Dim objTxtLeaveDetails As New Web.UI.MobileControls.TextView
    '    Dim strDetaiils As New StringBuilder("")
    '    Dim drCurrentDetails As IDataReader
    '    Dim strCurrentDesignationID As String = ""
    '    Dim strCurrentDesignation As String = ""
    '    Dim strJoiningDate As String = ""
    '    Dim strFromDate As String

    '    dsReportingMgrChange = CommonFunctions.Data.GetDataSet("usp_sel_tbl_PM_EmployeeDesignation_Change NULL,2," + strUserID + ",NULL,NULL," + strPrimaryKeyValue, "tbl", UseSQL:=True)
    '    For Each drReportingMgrChange As DataRow In dsReportingMgrChange.Tables(0).Rows

    '        strEmployeeID = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("EmployeeID"), "0").ToString()
    '        strNewActionID = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("DesignationID"), "0").ToString()
    '        strWithEffectFrom = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("WithEffectFrom"), "").ToString()

    '        drCurrentDetails = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_Amendment " + strEmployeeID, True)
    '        If drCurrentDetails.Read() Then
    '            strCurrentDesignationID = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("DesignationID"), "0").ToString()
    '            strCurrentDesignation = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("DesignationName"), "").ToString()
    '            strJoiningDate = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("JoiningDate"), "").ToString()
    '        End If
    '        CommonFunctions.Data.DisposeDataReader(drCurrentDetails)

    '        strFromDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_EmployeeDesignation_Change " + strEmployeeID + ",3", True)))

    '        strDetaiils.Append("<b>Employee Name:</b> ")
    '        strDetaiils.Append(CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("EmployeeName")).ToString())
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>Current Designation:</b> ")
    '        strDetaiils.Append(strCurrentDesignation)
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>From Date:</b> ")
    '        If strFromDate = "" Then
    '            strDetaiils.Append(CommonFunctions.Dates.GetDate(CType(strJoiningDate, Date).AddDays(1)))
    '        Else
    '            strDetaiils.Append(CommonFunctions.Dates.GetDate(CType(strFromDate, Date)))
    '        End If
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>New Designation:</b> ")
    '        strDetaiils.Append(CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("DesignationName")).ToString())
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>With Effect From:</b> ")
    '        If strWithEffectFrom = "" Then
    '            strDetaiils.Append("-")
    '        Else
    '            strDetaiils.Append(CommonFunctions.Dates.GetDate(CType(strWithEffectFrom, Date)))
    '        End If
    '        strDetaiils.Append("<br />")
    '        ObjTxtComments.Text = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("Comments")).ToString()
    '    Next
    '    objTxtLeaveDetails.ID = "TxtBenefitClaimDetails"
    '    objTxtLeaveDetails.Text = strDetaiils.ToString()
    '    Page.FindControl("frmRequestApprovalRejection").Controls.Add(objTxtLeaveDetails)
    '    strDetaiils = Nothing
    'End Sub

    'Private Sub PlotCostCenterChangeDetails()
    '    '=====================================================================
    '    ' Procedure Name        : PlotCostCenterChangeDetails()
    '    ' Purpose               : To plot Cost Center Change details
    '    ' Description           : 
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : Amol Changle
    '    ' Created               : 10 Apr 2009
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim dsReportingMgrChange As DataSet
    '    Dim objTxtLeaveDetails As New Web.UI.MobileControls.TextView
    '    Dim strDetaiils As New StringBuilder("")
    '    Dim drCurrentDetails As IDataReader
    '    Dim strCurrentCostCenterID As String = ""
    '    Dim strCurrentCostCenter As String = ""
    '    Dim strJoiningDate As String = ""
    '    Dim strFromDate As String

    '    dsReportingMgrChange = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_PM_EmployeeCostCenter_Change NULL,2," + strUserID + ",NULL,NULL," + strPrimaryKeyValue, "tbl", UseSQL:=True)
    '    For Each drReportingMgrChange As DataRow In dsReportingMgrChange.Tables(0).Rows

    '        strEmployeeID = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("EmployeeID"), "0").ToString()
    '        strNewActionID = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("CostCenterID"), "0").ToString()
    '        strWithEffectFrom = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("WithEffectFrom"), "").ToString()

    '        drCurrentDetails = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_Amendment " + strEmployeeID, True)
    '        If drCurrentDetails.Read() Then
    '            strCurrentCostCenterID = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("CostCenterID"), "0").ToString()
    '            strCurrentCostCenter = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("CostCenter"), "").ToString()
    '            strJoiningDate = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("JoiningDate"), "").ToString()
    '        End If
    '        CommonFunctions.Data.DisposeDataReader(drCurrentDetails)

    '        strFromDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_PM_EmployeeCostCenter_Change " + strEmployeeID + ",3", True)))

    '        strDetaiils.Append("<b>Employee Name:</b> ")
    '        strDetaiils.Append(CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("EmployeeName")).ToString())
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>Current Cost Center:</b> ")
    '        strDetaiils.Append(strCurrentCostCenter)
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>From Date:</b> ")
    '        If strFromDate = "" Then
    '            strDetaiils.Append(CommonFunctions.Dates.GetDate(CType(strJoiningDate, Date).AddDays(1)))
    '        Else
    '            strDetaiils.Append(CommonFunctions.Dates.GetDate(CType(strFromDate, Date)))
    '        End If
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>New Cost Center:</b> ")
    '        strDetaiils.Append(CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("CostCenter")).ToString())
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>With Effect From:</b> ")
    '        If strWithEffectFrom = "" Then
    '            strDetaiils.Append("-")
    '        Else
    '            strDetaiils.Append(CommonFunctions.Dates.GetDate(CType(strWithEffectFrom, Date)))
    '        End If
    '        strDetaiils.Append("<br />")
    '        ObjTxtComments.Text = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("Comments")).ToString()
    '    Next
    '    objTxtLeaveDetails.ID = "TxtBenefitClaimDetails"
    '    objTxtLeaveDetails.Text = strDetaiils.ToString()
    '    Page.FindControl("frmRequestApprovalRejection").Controls.Add(objTxtLeaveDetails)
    '    strDetaiils = Nothing
    'End Sub

    'Private Sub ApproveEmployeeTransferChangeRequest()
    '    '=====================================================================
    '    ' Procedure Name        : ApproveEmployeeTransferChangeRequest
    '    ' Purpose               : To Approve/Reject Reporting Manager Change Request
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
    '    Dim strSQL As New StringBuilder
    '    Select Case CType(strType, Integer)
    '        Case EmployeeTransfer.Grade
    '            strSQL.Append("usp_Upd_tbl_PM_EmployeeGrade_Change  ")
    '        Case EmployeeTransfer.Role
    '            strSQL.Append("usp_Upd_tbl_PM_EmployeeRole_Change  ")
    '        Case EmployeeTransfer.EmployeeType
    '            strSQL.Append("usp_Upd_tbl_PM_EmployeeType_Change  ")
    '        Case EmployeeTransfer.Designation
    '            strSQL.Append("usp_Upd_tbl_PM_EmployeeDesignation_Change  ")
    '        Case EmployeeTransfer.ReportingManager
    '            strSQL.Append("usp_Upd_tbl_PM_EmployeeReportingTo_Change  ")
    '        Case EmployeeTransfer.OrganizationStucture
    '            strSQL.Append("usp_Upd_tbl_PM_EmployeeOrgsStr_Change ")
    '        Case EmployeeTransfer.CostCenter
    '            strSQL.Append("usp_Upd_tbl_PM_EmployeeCostCenter_Change  ")
    '    End Select

    '    strSQL.Append(strEmployeeID)
    '    If strType = "10" Then
    '        strSQL.Append(",")
    '        strSQL.Append(strNewBusinessGroupID)
    '        strSQL.Append(",")
    '        strSQL.Append(strNewLocationID)
    '        strSQL.Append(",")
    '        strSQL.Append(strNewResourcePoolID)
    '        strSQL.Append(",")
    '        strSQL.Append(strNewGroupID)
    '        strSQL.Append(",'")
    '    Else
    '        strSQL.Append(",N'")
    '        strSQL.Append(strNewActionID)
    '        strSQL.Append("','")
    '    End If
    '    strSQL.Append(strWithEffectFrom)
    '    strSQL.Append("',N'")
    '    strSQL.Append(CommonFunctions.General.BuildQueryString(ObjTxtComments.Text))
    '    strSQL.Append("',N'")
    '    strSQL.Append(strUserName)
    '    strSQL.Append("',")
    '    strSQL.Append(strPrimaryKeyValue)
    '    CommonFunctions.Data.InsertOrUpdateData(strSQL.ToString(), True)

    '    Call SendEmployeeTransferEmail(166, strType)

    'End Sub

    'Private Sub RejectEmployeeTransferChangeRequest()
    '    '=====================================================================
    '    ' Procedure Name        : RejectEmployeeTransferChangeRequest
    '    ' Purpose               : To Reject Reporting Manager Change Request
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
    '    Dim strSQL As New StringBuilder
    '    Select Case CType(strType, Integer)
    '        Case EmployeeTransfer.Grade
    '            strSQL.Append("usp_Upd_tbl_PM_EmployeeGrade_Change_Rejected  N'")
    '        Case EmployeeTransfer.Role
    '            strSQL.Append("usp_Upd_tbl_PM_EmployeeRole_Change_Rejected  N'")
    '        Case EmployeeTransfer.EmployeeType
    '            strSQL.Append("usp_Upd_tbl_PM_EmployeeType_Change_Rejected  N'")
    '        Case EmployeeTransfer.Designation
    '            strSQL.Append("usp_Upd_tbl_PM_EmployeeDesignation_Change_Rejected  N'")
    '        Case EmployeeTransfer.ReportingManager
    '            strSQL.Append("usp_Upd_tbl_PM_EmployeeReportingTo_Change_Rejected  N'")
    '        Case EmployeeTransfer.OrganizationStucture
    '            strSQL.Append("usp_Upd_tbl_PM_EmployeeOrgsStr_Change_Rejected  N'")
    '        Case EmployeeTransfer.CostCenter
    '            strSQL.Append("usp_Upd_tbl_PM_EmployeeCostCenter_Change_Rejected  N'")
    '    End Select

    '    strSQL.Append(CommonFunctions.General.BuildQueryString(ObjTxtComments.Text))
    '    strSQL.Append("',")
    '    strSQL.Append(strPrimaryKeyValue)
    '    CommonFunctions.Data.InsertOrUpdateData(strSQL.ToString(), True)

    '    Call SendEmployeeTransferEmail(167, strType)

    'End Sub

    'Private Sub SendEmployeeTransferEmail(ByVal intMsgID As Integer, ByVal strActionType As String)
    '    Dim dr As IDataReader
    '    Dim blnSendMail As Boolean
    '    Dim strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage As String


    '    ' send mail
    '    dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages " + intMsgID.ToString(), True)
    '    If dr.Read Then
    '        blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
    '    End If
    '    CommonFunctions.Data.DisposeDataReader(dr)

    '    If blnSendMail Then
    '        If intMsgID = 166 Then
    '            CommonFunction.EmailMessages.HRMessages.GetEmailMessage_166(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, strPrimaryKeyValue, strActionType, intMsgID)
    '        Else
    '            CommonFunction.EmailMessages.HRMessages.GetEmailMessage_167(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, strPrimaryKeyValue, strActionType, intMsgID)
    '        End If
    '        CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
    '    End If

    'End Sub

    'Private Sub PlotOrgStrChangeDetails()
    '    '=====================================================================
    '    ' Procedure Name        : PlotOrgStrChangeDetails()
    '    ' Purpose               : To plot Grade details
    '    ' Description           : 
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : Amol Changle
    '    ' Created               : 10 Apr 2009
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim dsReportingMgrChange As DataSet
    '    Dim objTxtLeaveDetails As New Web.UI.MobileControls.TextView
    '    Dim strDetaiils As New StringBuilder("")
    '    Dim drCurrentDetails As IDataReader
    '    Dim strCurrentBusinessGroupID As String = ""
    '    Dim strCurrentLocationID As String = ""
    '    Dim strCurrentResourcePoolID As String = ""
    '    Dim strCurrentGroupID As String = ""
    '    Dim strCurrentBusinessGroup As String = ""
    '    Dim strCurrentLocation As String = ""
    '    Dim strCurrentResourcePool As String = ""
    '    Dim strCurrentGroup As String = ""
    '    Dim strJoiningDate As String = ""
    '    Dim strFromDate As String

    '    dsReportingMgrChange = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_PM_EmployeeOrgsStr_Change NULL,2," + strUserID + ",NULL,NULL," + strPrimaryKeyValue, "tbl", UseSQL:=True)
    '    For Each drReportingMgrChange As DataRow In dsReportingMgrChange.Tables(0).Rows

    '        strEmployeeID = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("EmployeeID"), "0").ToString()
    '        strNewBusinessGroupID = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("BusinessGroupID"), "NULL").ToString()
    '        strNewLocationID = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("LocationID"), "NULL").ToString()
    '        strNewResourcePoolID = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("ResourcePoolID"), "NULL").ToString()
    '        strNewGroupID = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("GroupID"), "NULL").ToString()
    '        strWithEffectFrom = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("WithEffectFrom"), "").ToString()

    '        drCurrentDetails = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_Amendment " + strEmployeeID, True)
    '        If drCurrentDetails.Read() Then
    '            strCurrentBusinessGroupID = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("BusinessGroupID"), "0").ToString()
    '            strCurrentLocationID = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("LocationID"), "0").ToString()
    '            strCurrentResourcePoolID = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("ResourcePoolID"), "0").ToString()
    '            strCurrentGroupID = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("GroupID"), "0").ToString()
    '            strCurrentBusinessGroup = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("BusinessGroup"), "-").ToString()
    '            strCurrentLocation = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("OrganizationUnit"), "-").ToString()
    '            strCurrentResourcePool = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("DeliveryUnit"), "-").ToString()
    '            strCurrentGroup = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("DeliveryTeam"), "-").ToString()
    '            strJoiningDate = CommonFunctions.Data.CheckIsDBNull(drCurrentDetails("JoiningDate"), "").ToString()
    '        End If
    '        CommonFunctions.Data.DisposeDataReader(drCurrentDetails)

    '        strFromDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_PM_EmployeeOrgsStr_Change " + strEmployeeID + ",3", True)))

    '        strDetaiils.Append("<b>Employee Name:</b> ")
    '        strDetaiils.Append(CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("EmployeeName")).ToString())
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>Current Business Group:</b> ")
    '        strDetaiils.Append(strCurrentBusinessGroup)
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>Current Organization Unit:</b> ")
    '        strDetaiils.Append(strCurrentLocation)
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>Current Delivery Unit:</b> ")
    '        strDetaiils.Append(strCurrentResourcePool)
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>Current Delivery Team:</b> ")
    '        strDetaiils.Append(strCurrentGroup)
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>From Date:</b> ")
    '        If strFromDate = "" Then
    '            strDetaiils.Append(CommonFunctions.Dates.GetDate(CType(strJoiningDate, Date).AddDays(1)))
    '        Else
    '            strDetaiils.Append(CommonFunctions.Dates.GetDate(CType(strFromDate, Date)))
    '        End If
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>New Business Group:</b> ")
    '        strDetaiils.Append(CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("BusinessGroup"), "-").ToString())
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>New Organization Unit:</b> ")
    '        strDetaiils.Append(CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("OrganizationUnit"), "-").ToString())
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>New Delivery Unit:</b> ")
    '        strDetaiils.Append(CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("DeliveryUnit"), "-").ToString())
    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>New Delivery Team:</b> ")
    '        strDetaiils.Append(CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("DeliveryTeam"), "-").ToString())

    '        strDetaiils.Append("<br />")
    '        strDetaiils.Append("<b>With Effect From:</b> ")
    '        If strWithEffectFrom = "" Then
    '            strDetaiils.Append("-")
    '        Else
    '            strDetaiils.Append(CommonFunctions.Dates.GetDate(CType(strWithEffectFrom, Date)))
    '        End If
    '        strDetaiils.Append("<br />")
    '        ObjTxtComments.Text = CommonFunctions.Data.CheckIsDBNull(drReportingMgrChange("Comments")).ToString()
    '    Next
    '    objTxtLeaveDetails.ID = "TxtBenefitClaimDetails"
    '    objTxtLeaveDetails.Text = strDetaiils.ToString()
    '    Page.FindControl("frmRequestApprovalRejection").Controls.Add(objTxtLeaveDetails)
    '    strDetaiils = Nothing
    'End Sub

End Class


'Public Class SendWorkFlowEmail_Mobile
'    Public Shared Sub SendWorkFlowEmail(ByVal strProcessID As String, ByVal strStageID As String, ByVal strAction As String, ByVal strPrimaryKeyValue As String, ByVal strInstanceID As String)
'        '=====================================================================
'        ' Procedure Name        : SendWorkFlowEmail
'        ' Purpose               : To send Emails of workflow actions
'        ' Description           : 
'        ' Parameters Passed     : ProcessID,StageID,Action,PrimaryKeyValue,InstanceID
'        ' Returns               : NA
'        ' Parameters Affected   : 
'        ' Assumptions           : 
'        ' Dependencies          : 
'        ' Author                : Amol Changle
'        ' Created               : 08 Mar 2009
'        ' Revisions             :
'        '=====================================================================
'        Dim drMessageDetails As IDataReader
'        Dim blnSendmail As Boolean
'        Dim sbScript As New StringBuilder
'        Dim m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage As String

'        'Benefit Claim Process
'        If strProcessID.ToUpper = "0402BAC8-BEF5-46C5-8222-CFAC9681EC92" Then
'            Select Case UCase(strStageID)
'                Case "62EBB584-D35D-4D04-9E06-4E215B985FE5" ' Benefit_Claim Application
'                    drMessageDetails = CommonFunction.Data.GetDataReader("usp_Get_EmailMessages_Status 28 ", True)
'                    If drMessageDetails.Read Then
'                        blnSendmail = CBool(CommonFunction.Data.CheckIsDBNull(drMessageDetails("SendMail")))
'                    End If
'                    CommonFunction.Data.DisposeDataReader(drMessageDetails)
'                    If blnSendmail Then
'                        CommonFunction.EmailMessages.HRMessages.GetEmailMessage_28(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, strPrimaryKeyValue, 28, 0)
'                        CommonFunctions.Emails.SendEmailWithCC(m_strToEmailID, m_strCCEmailID, m_strFromEmailID, m_strSubject, m_strMessage)
'                    End If
'                Case "A2B221D2-79D0-4D5A-A567-E0E1718AACF6" ' Benefit_Claim ReportingTo Approval

'                    Select Case UCase(strAction)
'                        'Approved Benefit_Claim Application
'                        Case "SYS_APPROVE"
'                            drMessageDetails = CommonFunction.Data.GetDataReader("usp_Get_EmailMessages_Status 29 ", True)
'                            If drMessageDetails.Read Then
'                                blnSendmail = CBool(CommonFunction.Data.CheckIsDBNull(drMessageDetails("SendMail")))
'                            End If
'                            CommonFunction.Data.DisposeDataReader(drMessageDetails)
'                            If blnSendmail Then
'                                CommonFunction.EmailMessages.HRMessages.GetEmailMessage_29(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, strPrimaryKeyValue, 29)
'                                CommonFunctions.Emails.SendEmailWithCC(m_strToEmailID, m_strCCEmailID, m_strFromEmailID, m_strSubject, m_strMessage)
'                            End If

'                        Case "SYS_REJECT"
'                            'Rejected Benefit_Claim Application
'                            drMessageDetails = CommonFunction.Data.GetDataReader("usp_Get_EmailMessages_Status 30 ", True)
'                            If drMessageDetails.Read Then
'                                blnSendmail = CBool(CommonFunction.Data.CheckIsDBNull(drMessageDetails("SendMail")))
'                            End If
'                            CommonFunction.Data.DisposeDataReader(drMessageDetails)
'                            If blnSendmail Then
'                                CommonFunction.EmailMessages.HRMessages.GetEmailMessage_30(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, strPrimaryKeyValue, 30, strInstanceID)
'                                CommonFunctions.Emails.SendEmailWithCC(m_strToEmailID, m_strCCEmailID, m_strFromEmailID, m_strSubject, m_strMessage)
'                            End If
'                    End Select

'                Case "4E86AC5C-8C65-41D5-85C0-6D72DFB48234" ' Benefit_Claim Financer Approval

'                    Select Case UCase(strAction)

'                        'Approved Benefit_Claim Application
'                        Case "SYS_APPROVE"
'                            drMessageDetails = CommonFunction.Data.GetDataReader("usp_Get_EmailMessages_Status 31 ", True)
'                            If drMessageDetails.Read Then
'                                blnSendmail = CBool(CommonFunction.Data.CheckIsDBNull(drMessageDetails("SendMail")))
'                            End If
'                            CommonFunction.Data.DisposeDataReader(drMessageDetails)
'                            If blnSendmail Then
'                                CommonFunction.EmailMessages.HRMessages.GetEmailMessage_31(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, strPrimaryKeyValue, 31)
'                                CommonFunctions.Emails.SendEmailWithCC(m_strToEmailID, m_strCCEmailID, m_strFromEmailID, m_strSubject, m_strMessage)
'                            End If

'                        Case "SYS_REJECT"
'                            'SYS_REJECT Benefit_Claim Application
'                            drMessageDetails = CommonFunction.Data.GetDataReader("usp_Get_EmailMessages_Status 32 ", True)
'                            If drMessageDetails.Read Then
'                                blnSendmail = CBool(CommonFunction.Data.CheckIsDBNull(drMessageDetails("SendMail")))
'                            End If
'                            CommonFunction.Data.DisposeDataReader(drMessageDetails)
'                            If blnSendmail Then
'                                CommonFunction.EmailMessages.HRMessages.GetEmailMessage_32(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, strPrimaryKeyValue, 32, strInstanceID)
'                                CommonFunctions.Emails.SendEmailWithCC(m_strToEmailID, m_strCCEmailID, m_strFromEmailID, m_strSubject, m_strMessage)
'                            End If
'                    End Select
'            End Select
'        End If
'    End Sub
'End Class
