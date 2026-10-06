Public Class HR_ProRataDetails
    'Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate

  
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
    Dim WithEvents objGrid As New WebPage.Templates.GenericGrid
    Private m_strGridSQL As String
    Private blnIsTestSessionClosed As Boolean = False

    'Protected m_strSortBy As String
    'Protected m_strSortOrder As String
    Private m_strdesignationID As String
    Private m_strleavetypeID As String
    Private m_strAction As String
    Private m_strEmployeeName As String
    Private m_strUniqueIDs As String = ""
    Private m_strEmployeeNameforGroup As String = ""



    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function


    Protected Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()
        ' Purpose               : Start of Page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : This function must be called within FORM tag in aspx page.
        ' Author                : SuchitraP
        ' Created               : May 17,2007
        ' Revisions             :
        '=====================================================================

        MyBase.InitializeResources("AppResources.HR_ProRataDetails", "AppResources")

        InitVariable()

        Dim arrMenu As New System.Collections.ArrayList
        Dim arrMenuToolTip As New System.Collections.ArrayList
        Dim arrCSFunction As New System.Collections.ArrayList
        If blnIsTestSessionClosed = False Then
            arrMenu.Add(MyBase.GetResourceString("MENU_SAVE"))
            arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE"))
           
            arrCSFunction.Add("Save_Click()")

        End If

        arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrMenu.Add(MyBase.GetResourceString("MENU_HELP"))
        

        arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        

        arrCSFunction.Add("Close_OnClick()")
        'Comment and modification done by SuchitraP on 25-JUN-2007 for IssueID 13526
        'arrCSFunction.Add("Help_OnClick()")
        arrCSFunction.Add("Help_OnClick('ProRata')")
        'End of Comment and modification done by SuchitraP on 25-JUN-2007 for IssueID 13526

        With Response

            'Upper menu
            'Addition done by SuchitraP on 4-JUN-2007 for IssueID 13525
            .Write("<div id='divUpperMenu'>")
            'end on 4-JUN-2007 for IssueID 13525
            .Write(WebPages.Template.StaticMenu.DrawMenu(GetArray(arrMenu), GetArray(arrCSFunction), GetArray(arrMenuToolTip)))
            'Addition done by SuchitraP on 4-JUN-2007 for IssueID 13525
            .Write("</div>")
            'Addition done by SuchitraP on 4-JUN-2007 for IssueID 13525

            .Write("<BR>")
            'page caption
            .Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("LBL_PAGE_CAPTION")))
            .Write("<BR>")
            Call drawPageFilters()
            .Write("<BR>")

            Call DrawPage()

            'Bottom menu
            .Write("<BR>")
            'Addition done by SuchitraP on 4-JUN-2007 for IssueID 13525
            .Write("<div id='divBottomMenu'>")
            'end on 4-JUN-2007 for IssueID 13525
            .Write(WebPages.Template.StaticMenu.DrawMenu(GetArray(arrMenu), GetArray(arrCSFunction), GetArray(arrMenuToolTip)))
            'Addition done by SuchitraP on 4-JUN-2007 for IssueID 13525
            .Write("</div>")
            'Addition done by SuchitraP on 4-JUN-2007 for IssueID 13525

        End With


    End Sub
    Private Sub InitVariable()

        ' Sort by of the page
        'If Not Request.QueryString("SortBy") Is Nothing Then
        '    m_strSortBy = Request.QueryString("SortBy")
        'Else
        '    m_strSortBy = "DesignationName"
        'End If
        '' Sort order of the page
        'If Not Request.QueryString("SortOrder") Is Nothing Then
        '    m_strSortOrder = Request.QueryString("SortOrder")
        'Else
        '    m_strSortOrder = "DESC"
        'End If

        m_strEmployeeName = HttpContext.Current.Request.Form.Get("txtFltEmployeeName")
        m_strdesignationID = HttpContext.Current.Request.Form.Get("cboFltDesignation")
        m_strleavetypeID = HttpContext.Current.Request.Form.Get("cboFltLeaveType")
        If m_strdesignationID Is Nothing Then
            m_strdesignationID = ""
        End If
        If m_strleavetypeID Is Nothing Then
            m_strleavetypeID = ""
        End If
        If m_strEmployeeName Is Nothing Then
            m_strEmployeeName = ""
        End If

        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action")
        Else
            m_strAction = ""
        End If

        If m_strAction.ToUpper = "SAVE" Then
            SaveData()
        End If

    End Sub
    Private Sub DrawPage()
        Dim strCss As String = "clsTREven"
        Dim strEmployeeName As String
        Dim strDesignation As String
        Dim strLeaveType As String
        Dim strLeaveEntitlement As Double
        Dim strBalanceLeaves As Double
        Dim strProRata As Double
        Dim strSQL As String = "usp_Sel_tbl_PM_EmployeeLeaveMaster_ProRata "

        Dim arrActualColumns As String() = {"DesignationName", "EmployeeName", "LeaveType", "LeaveEntitlement", "BalanceLeaves", "ProRata"}
        'Dim arrUserfriendlyColNames As String() = {"Designation", "Employee Name", "Leave Type", "Leave Entitlement", "Balance Leaves", "Pro-Rata"}
        Dim arrUserfriendlyColNames As String() = {MyBase.GetResourceString("LBL_DESIGNATION"), MyBase.GetResourceString("LBL_EMPLOYEE_NAME"), MyBase.GetResourceString("LBL_LEAVE_TYPE"), MyBase.GetResourceString("LBL_LEAVE_ENTITLEMENT"), MyBase.GetResourceString("LBL_BALANCE_LEAVE"), MyBase.GetResourceString("LBL_PRO_RATA")}
        Dim arrGroupOnColumn As String() = {"DesignationName"}

        CommonFunctions.General.PlotStaticHeaderStyle("divPage")

        If m_strEmployeeName <> "" Then
            strSQL += "'" + CommonFunction.General.BuildQueryString(m_strEmployeeName) + "'" + ","
        Else
            strSQL += "NULL ,"
        End If

        If m_strdesignationID <> "" Then
            strSQL += m_strdesignationID + ","
        Else
            strSQL += "NULL ,"
        End If

        If m_strleavetypeID <> "" Then
            strSQL += m_strleavetypeID
        Else
            strSQL += "NULL"
        End If
        'Commented and added by Shamkant s for HTML encoding Date:07/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Shamkant s  for HTML encoding Date:07/10/15

        With objGrid
            .ActualColumnArray = arrActualColumns
            .UserFriendlyColumnArray = arrUserfriendlyColNames
            .NoOfDataColumns = 6
            .DIVID = "divPage"
            .DIVHeight = 300
            .DIVStyle = "overflow:auto"
            .returnHTML = False
            '.SortBy = m_strSortBy
            '.SortOrder = m_strSortOrder
            '.ClientSideSortFunctionName = "Sort_OnClick"
            .GroupOnColumn = arrGroupOnColumn
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode

            .SQL = strSQL
            .UseSQL = CBool(CommonFunctions.General.CheckIsNothing(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), "True"))
            .ConnectionString = CommonFunctions.Application.ConnectionString
            .DrawGrid()
        End With

        CommonFunction.General.WriteHTML("<input type=hidden name=hidUniqueIDs id=hidUniqueIDs value=" + m_strUniqueIDs + " >")

    End Sub
    Private Sub drawPageFilters()
        CommonFunction.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>")
        CommonFunction.General.WriteHTML("<TR class=clsTRSectionHeader>")
        'CommonFunction.General.WriteHTML("<TD>Filter")
        CommonFunction.General.WriteHTML("<TD>" + MyBase.GetResourceString("LBL_FILTER") + "")
        CommonFunction.General.WriteHTML("</TD></TR></TABLE>")

        CommonFunction.General.WriteHTML("<TABLE ID='PageFilter' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
        CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
        'Employee Name text search'
        'Addition of title done by SuchitraP on 5-JUN-2007 for IssueID 13528
        CommonFunction.General.WriteHTML("<TD align=right title='Starts with'>")
        'CommonFunction.General.WriteHTML("Employee Name")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_EMPLOYEE_NAME"))
        'Addition of title done by SuchitraP on 5-JUN-2007 for IssueID 13528
        CommonFunction.General.WriteHTML("</TD><TD title='Starts with'>")
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        CommonFunction.HTMLControls.DrawTextBox("txtFltEmployeeName", "txtFltEmployeeName", "clsTextBox", , , m_strEmployeeName, , , , , , , " onKeyPress=txtEmployeeName_onKeyPress(event)", EnableHTMLEncode:=True)
        'ended by Shamkant s  for HTML encoding Date:06/10/15
        CommonFunction.General.WriteHTML("</TD>")


        'Designation combo
        CommonFunction.General.WriteHTML("<TD align=right>")
        'CommonFunction.General.WriteHTML("Designation")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_DESIGNATION"))
        CommonFunction.General.WriteHTML("</TD><TD>")

        CommonFunction.HTMLControls.DrawComboBox("cboFltDesignation", "usp_Sel_tbl_PM_DesignationMaster", 150, m_strdesignationID, "onchange=Designation_onchange()", True)
        CommonFunction.General.WriteHTML("</TD>")


        'Leave Type combo
        CommonFunction.General.WriteHTML("<TD align=right>")
        'CommonFunction.General.WriteHTML("Leave Type")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_LEAVE_TYPE"))
        CommonFunction.General.WriteHTML("</TD><TD>")
        CommonFunction.HTMLControls.DrawComboBox("cboFltLeaveType", "usp_Sel_tbl_PM_LeaveTypemaster 0", 150, m_strleavetypeID, "onchange=LeaveType_onchange()", True)
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR>")
        CommonFunction.General.WriteHTML("</TABLE>")
    End Sub

    Private Sub objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGrid.DataRowTD_BeforePrint
        If Args.ColIndex = 5 And Args.ColumnName = "Pro-Rata" Then
            Cancel = True
            Args.StringToBeInserted = "<TD align='center'><input type=text maxlength=4 name = 'txtProRata" + Args.DataReader("UniqueID").ToString + "' id='txtProRata" + Args.DataReader("UniqueID").ToString + "' style='width:30px;text-align:right' class='clstextbox' value=" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ProRata"), "0"), String) + " ></TD>"
        End If
        'Addition done by SuchitraP on 25-JUN-2007
        'To provide Grouping on EmployeeName
        If Args.ColIndex = 1 And Args.ColumnName = "Employee Name" Then
            If m_strEmployeeNameforGroup = "" Then
                m_strEmployeeNameforGroup = Args.DataReader("EmployeeName").ToString
            Else
                If (m_strEmployeeNameforGroup = Args.DataReader("EmployeeName").ToString) Then
                    Cancel = True
                    Args.StringToBeInserted = "<TD></TD>"
                End If
            End If
            m_strEmployeeNameforGroup = Args.DataReader("EmployeeName").ToString
        End If

    End Sub

   

    Private Sub SaveData()
        Dim strreturn As String = Request.Form("hidUniqueIDs")
        Dim arrStrUniqueIDs() As String = strreturn.Split(CType(",", Char))
        Dim count As Integer = 0
        Dim strProRata As String
        Dim strUniqueID As String
        Dim strsql As String = ""
        While count < arrStrUniqueIDs.Length - 1
            strProRata = Request.Form("txtProRata" + arrStrUniqueIDs(count))
            strUniqueID = arrStrUniqueIDs(count)
            strsql = "usp_upd_tbl_PM_EmployeeLeaveMaster_ProRata " + strUniqueID + ",'" + strProRata + "'"
            CommonFunctions.Data.InsertOrUpdateData(strsql, True)
            count += 1

        End While
        'Addition done by SuchitraP on 5-JUN-2007
        Response.Write("<script>")
        Response.Write("alert('Balance Leaves Updated successfully..');")
        Response.Write("</script>")

    End Sub

    Private Sub objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objGrid.DataRowTR_BeforePrint
        m_strUniqueIDs += Args.DataReader("UniqueID").ToString + ","
    End Sub
End Class
