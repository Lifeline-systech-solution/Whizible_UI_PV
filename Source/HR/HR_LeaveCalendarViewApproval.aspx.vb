Option Strict Off
#Region "Imports"
Imports GenericCalender.GenericCalender
Imports CommonFunctions
Imports CommonFunctions.HTMLControls
Imports CommonFunctions.General
Imports CommonFunctions.Data
Imports WebPages
Imports WebPages.Template
Imports WebPages.Security
Imports CommonEngines
Imports System
#End Region

Public Class HR_LeaveCalendarViewApproval
    Inherits WebPages.Template.WhizTemplate
    Private intEmployeeID As Integer
    Private intLeaveID As Integer
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        '=====================================================================
        ' Page Name             : HR_LeaveCalendarViewApproval.aspx.vb
        ' Purpose               : To Approve Leave from calendarview
        ' Author                : ShraddhaM
        ' Created               : 28,Sep 2007
        
        Call Initialize()
    End Sub
    Private Sub Initialize()
        'To retrive EmployeeID from query string
        intEmployeeID = CType(Request.QueryString("EmployeeID"), Integer)
        intLeaveID = CType(Request.QueryString("LeaveID"), Integer)

        'To retrive LeaveID from query string

    End Sub
    Public Sub DrawPage()
        Response.Write("<DIV Id='divPage' Style='height:100%; overflow:auto; width:99.99%' >")
        Call DrawMenu()

        Call DisplayDetails()

        Call DrawMenu()
        Response.Write("</DIV>")
    End Sub
    Private Sub DrawMenu()
        Dim arrMenuCaptionsList As New ArrayList
        Dim arrMenuToolTipsList As New ArrayList
        Dim arrClientSideFunctionList As New ArrayList
        Dim strMenu As String

        arrMenuCaptionsList.Add("Approve") : arrMenuToolTipsList.Add("Approve") : arrClientSideFunctionList.Add("Approve_onClick()")
        arrMenuCaptionsList.Add("Reject") : arrMenuToolTipsList.Add("Reject") : arrClientSideFunctionList.Add("Reject_onClick()")
        arrMenuCaptionsList.Add("Cancel") : arrMenuToolTipsList.Add("Cancel") : arrClientSideFunctionList.Add("Cancel_onClick()")
        arrMenuCaptionsList.Add("Close") : arrMenuToolTipsList.Add("Close") : arrClientSideFunctionList.Add("Close_onClick()")
        arrMenuCaptionsList.Add("?") : arrMenuToolTipsList.Add("Help") : arrClientSideFunctionList.Add("Help_onClick()")

        m_objMenu = New WebPages.Template.StaticMenu
        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)
        arrMenuCaptionsList = Nothing
        arrMenuToolTipsList = Nothing
        arrClientSideFunctionList = Nothing

        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")


        'CommonFunctions.General.WriteHTML("<table class='clsGridTable' cellspacing='0' cellpadding=0 border=0 width=99.9%>")
        'CommonFunctions.General.WriteHTML("<TR class='clsTRMenu' width=99.9% >")
        'CommonFunctions.General.WriteHTML("<TD align=right>")
        'CommonFunctions.General.WriteHTML("</TD>")
    End Sub

    Private Sub DisplayDetails()
        Dim drLeaveDetails As IDataReader
        Dim strLeaveQuery As String
        Dim strLeaveType As String
        Dim strEmployeeName As String
        Dim dtFromDate As Date
        Dim dtToDate As Date
        Dim strType As String
        Dim fltLeaveBalance As String
        Dim IsHalfDay As Boolean
        Dim strAddress As String
        Dim strReason As String
        Dim strPhoneNo As String
        Dim dtAppliedOn As Date

        strLeaveQuery = "usp_sel_EmployeeLeaveDetails_For_LeaveCalendar " & intLeaveID & "," & intEmployeeID

        drLeaveDetails = CommonFunctions.Data.GetDataReader(strLeaveQuery, MyBase.UseSQL)

        While drLeaveDetails.Read()

            strLeaveType = drLeaveDetails("LeaveOrWFH")

            If strLeaveType = "L" Then
                strLeaveType = "Leave"
            Else
                strLeaveType = "Work From Home"
            End If

            strEmployeeName = drLeaveDetails("EmployeeName")
            dtFromDate = drLeaveDetails("FromDate")
            dtToDate = drLeaveDetails("ToDate")
            strType = drLeaveDetails("LeaveTypeID")
            fltLeaveBalance = drLeaveDetails("LeaveBalance")
            IsHalfDay = drLeaveDetails("HalfDay")
            strAddress = drLeaveDetails("Address")
            strReason = drLeaveDetails("Reason")
            strPhoneNo = drLeaveDetails("Telephone")
            dtAppliedOn = drLeaveDetails("AppliedDate")

        End While

        CommonFunctions.General.WriteHTML("<TABLE class='clsGridTable' width=99.9% cellspacing='0'>")
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")

        CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD>Request Type</TD>")
        CommonFunctions.General.WriteHTML("<TD>")
        CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", "usp_sel_RequestLeaveType", 120, strLeaveType, , True, )
        CommonFunctions.General.WriteHTML("</TD></TR>")

        CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD>Employee Name</TD>")
        CommonFunctions.General.WriteHTML("<TD>")
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtEmployeeName", "txtEmployeeName", , 150, , strEmployeeName, , , True, EnableHTMLEncode:=True)
        'ended by Shamkant s  for HTML encoding Date:06/10/15

        CommonFunctions.General.WriteHTML("</TD></TR>")

        CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD>From Date</TD>")
        CommonFunctions.General.WriteHTML("<TD>")
        CommonFunctions.HTMLControls.DrawDateControl("dtFromDate", "dtFromDate", , , dtFromDate)
        CommonFunctions.General.WriteHTML("</TD></TR>")

        CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD>To Date</TD>")
        CommonFunctions.General.WriteHTML("<TD>")
        CommonFunctions.HTMLControls.DrawDateControl("dtToDate", "dtToDate", , , dtToDate)
        CommonFunctions.General.WriteHTML("</TD></TR>")

        CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD>ype</TD>")
        CommonFunctions.General.WriteHTML("<TD>")
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        '' CommonFunctions.HTMLControls.DrawComboBox("cboType", "SELECT LeaveTypeID, LeaveType FROM tbl_PM_LeaveTypeMaster ORDER BY LeaveType", , strType, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboType", "usp_sel_LeaveType_tbl_PM_LeaveTypeMaster", , strType, , True)
        ''End of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        CommonFunctions.General.WriteHTML("</TD></TR>")

        CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD>Leave Balance</TD>")
        CommonFunctions.General.WriteHTML("<TD>")
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtBalance", "txtBalance", , , , fltLeaveBalance, EnableHTMLEncode:=True)
        'ended by Shamkant s  for HTML encoding Date:06/10/15

        CommonFunctions.General.WriteHTML("</TD></TR>")

        CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD>Half day</TD>")
        CommonFunctions.General.WriteHTML("<TD>")
        CommonFunctions.HTMLControls.DrawCheckBox("chkIsHalfDay", "chkIsHalfDay", , , IsHalfDay, )
        CommonFunctions.General.WriteHTML("</TD></TR>")

        CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD>Address</TD>")
        CommonFunctions.General.WriteHTML("<TD>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'CommonFunctions.HTMLControls.DrawTextArea("txtAddress", "txtAddress", , , , "frmLeaveCalendarViewApproval", value:=strAddress)
        CommonFunctions.HTMLControls.DrawTextArea("txtAddress", "txtAddress", , , , "frmLeaveCalendarViewApproval", value:=strAddress, EnableHTMLEncode:=True)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.General.WriteHTML("</TD></TR>")

        CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD>Reason</TD>")
        CommonFunctions.General.WriteHTML("<TD>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'CommonFunctions.HTMLControls.DrawTextArea("txtReason", "txtReason", , , , "frmLeaveCalendarViewApproval", value:=strReason)
        CommonFunctions.HTMLControls.DrawTextArea("txtReason", "txtReason", , , , "frmLeaveCalendarViewApproval", value:=strReason, EnableHTMLEncode:=True)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.General.WriteHTML("</TD></TR>")

        CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD>Telephone</TD>")
        CommonFunctions.General.WriteHTML("<TD>")
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtPhone", "txtPhone", , , , strPhoneNo, EnableHTMLEncode:=True)
        'ended by Shamkant s  for HTML encoding Date:06/10/15
        CommonFunctions.General.WriteHTML("</TD></TR>")

        CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD>Applied On</TD>")
        CommonFunctions.General.WriteHTML("<TD>")
        CommonFunctions.HTMLControls.DrawDateControl("dtAppliedOn", "dtAppliedOn", , , dtAppliedOn)
        CommonFunctions.General.WriteHTML("</TD></TR>")


        CommonFunctions.General.WriteHTML("</TABLE>")
        CommonFunction.Data.DisposeDataReader(drLeaveDetails)
    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        '=====================================================================
        ' Function Name        : GetArray
        ' Purpose               : Return array
        ' Returns               : Array
        ' Created               : 11 nov 2005
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
End Class
