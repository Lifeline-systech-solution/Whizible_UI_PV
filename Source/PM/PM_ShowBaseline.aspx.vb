Public Class PM_ShowBaseline
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    'Global Variables

    ''Commented and Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
    'Private m_objGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    ''End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change

    Private m_lngTaskId As Long
    Private m_strSortBy As String = ""
    Private m_strSortOrder As String = ""
    Private m_intHelpId As Integer = 0

    ''Added by Dhanashri S on 11 Aug 2016
    Protected m_EmployeeID As String
    Protected m_blnValidate As Boolean = "True"
    ''End of Addition by Dhanashri S on 11 Aug 2016

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim strCalledFrom As String = ""

        m_lngTaskId = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("TaskId"), "0"), Long)

        strCalledFrom = CommonFunctions.General.CheckIsNothing(Request.QueryString("FromWhere")).Trim()
        If strCalledFrom = "AssignedTask" Then
            m_intHelpId = 1038
        ElseIf strCalledFrom = "TaskManagement" Then
            m_intHelpId = 406
        End If

        m_strSortBy = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortBy")).Trim()
        m_strSortBy = CommonFunctions.General.UnBuildQueryString(m_strSortBy)
        m_strSortOrder = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortOrder")).Trim()
        m_strSortOrder = CommonFunctions.General.UnBuildQueryString(m_strSortOrder)

        If m_strSortBy = "" Then m_strSortBy = "BaselineChangeDate"
        If m_strSortOrder = "" Then m_strSortOrder = "ASC"
        ''Added  By Shamkant s 31/12/2015
        'If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
        '    Response.Write(vbCrLf + "<script>")
        '    Response.Write(vbCrLf + "		if (window.opener == null)")
        '    Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
        '    If strRedirectToPage.Trim = "" Then
        '        Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
        '    Else
        '        Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
        '    End If
        '    Response.Write(vbCrLf + "</script>")
        'End If
        'Ended By Shamkant s 31/12/2015
        'Added by Yogesh J on on 29-Jan-2016 to validate Token

        If Not Request.QueryString("EmployeeID") Is Nothing Then
            m_EmployeeID = Trim(Request.QueryString("EmployeeID") & "")
        End If
        If Request.QueryString("FromWhere") = "AssignedTask" Or Request.QueryString("FromWhere") = "TaskManagement" Then
            If Request.QueryString("TaskID") IsNot Nothing Then
                If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("TaskID"), String) + CType(m_EmployeeID, String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False)) Then
                   m_blnValidate = "False"
                End If
            End If
        End If
        If (m_blnValidate = "False") Then
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If
        ''End of addition by Yogesh J on on 29-Jan-2016 to validate Token
    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objGrid = Nothing
    End Sub

    Public Sub New()
        ' MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

        MyBase.InitializeResources("AppResources.PM_ShowBaseline", "AppResources")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "PM_ShowBaseline : " & UserInput & " " & Cause
        Throw ex
    End Sub

    Private Function DisplayPageMenu() As String
        Dim strMenu As String = ""
        Dim arrMenuItem(1) As String
        Dim arrMenuTooltip(1) As String
        Dim arrClientSideFunctions(1) As String
        Dim objMenu As New WebPages.Template.StaticMenu

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        arrMenuItem(0) = MyBase.GetResourceString("MENU_CLOSE")
        arrMenuTooltip(0) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        arrClientSideFunctions(0) = "Close_OnClick()"

        arrMenuItem(1) = MyBase.GetResourceString("MENU_HELP")
        arrMenuTooltip(1) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        arrClientSideFunctions(1) = "Help_OnClick(" & m_intHelpId.tostring() & ")"

        MyBase.InitializeResources("AppResources.PM_ShowBaseline", "AppResources")

        strMenu = objMenu.DrawMenuWithEvents(arrMenuItem, arrClientSideFunctions, arrMenuTooltip, True)
        Return strMenu
    End Function

    Public Sub PageInit()
        Dim strMenu As String = ""
        Dim strPageCaption As String = ""
        Dim strTaskName As String = ""

        'Display the Menu
        strMenu = DisplayPageMenu()
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

        'Display the Page Caption
        strTaskName = GetTaskName()
        strPageCaption = MyBase.GetResourceString("PAGE_CAPTION") & " : "
        strPageCaption &= Server.HtmlEncode(strTaskName)
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, strPageCaption, , , True))
        CommonFunctions.General.WriteHTML("<BR>")

        'Display the Baseline change History List
        Display_BaselineList()
        CommonFunctions.General.WriteHTML("<BR>")

        'Display the Menu at bottom
        CommonFunctions.General.WriteHTML(strMenu)

        'Hidden Sort Fields
        'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortBy", "txthidSortBy", , , , m_strSortBy, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortOrder", "txthidSortOrder", , , , m_strSortOrder, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
    End Sub

    Private Sub Display_BaselineList()
        Dim strQuery As String = ""
        Dim arrActualColumns() As String = {"BaselineChangeDate", "StartDate", "EndDate", _
                                            "BaselineStartDate", "BaselineEndDate", _
                                            "Work", "Duration"}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("CHANGE_DATE"), _
                                                 MyBase.GetResourceString("CURRENT_START_DATE"), _
                                                 MyBase.GetResourceString("CURRENT_END_DATE"), _
                                                 MyBase.GetResourceString("BASELINE_START_DATE"), _
                                                 MyBase.GetResourceString("BASELINE_END_DATE"), _
                                                 MyBase.GetResourceString("BASELINE_WORK"), _
                                                 MyBase.GetResourceString("BASELINE_DURATION")}

        Dim arrTDStyle() As String = {"width=16% align=center", "width=16% align=center", "width=16% align=center", _
                                      "width=16% align=center", "width=16% align=center", "width=10% align=center", _
                                      "width=10% align=center"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'Get the Query to plot the Grid
        strQuery = "EXEC usp_Sel_tbl_PM_TaskBaselines " & m_lngTaskId.ToString()
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strSortBy) & "'"
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strSortOrder) & "'"

        'Set the Grid Properties
        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            .PrimaryKey = "BaselineId"
            .SortBy = m_strSortBy
            .SortOrder = m_strSortOrder
            .ClientSideSortFunctionName = "Sort_OnClick"
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "PageDiv"
            .DIVHeight = 420
            .DIVStyle = "overflow:auto;width:100%"
            .NoOfDataColumns = 7
            .EmptyValueReplacement = "&nbsp;"
            .returnHTML = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
    End Sub

    Private Function GetTaskName() As String
        Dim strRetrun As String = ""
        Dim strQuery As String = ""

        ''strQuery = "SELECT TaskName FROM tbl_PM_ProjectTasks WHERE TaskID = " & m_lngTaskId.ToString()
        strQuery = "usp_sel_tbl_PM_ProjectTasks_TaskName " & m_lngTaskId.ToString()

        strRetrun = CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL).ToString()
        Return strRetrun
    End Function
    ''Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Select Case Args.ColIndex
            Case 5
                Dim m_strdispWork As String
                Cancel = True
                m_strdispWork = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + Args.DataReader("Work").ToString() + "',1)", True)
                Args.StringToBeInserted = "<td valign='top' align='right'>" + m_strdispWork + "</td>"
        End Select
    End Sub
    ''End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
End Class
