Public Class ProjectDB_ShowList
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Public m_intProjectID As Integer
    Private m_strPageTitle As String
    Private m_blnUseSQL As Boolean

    Private m_intMetric As Integer

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        MyBase.InitializeResources("AppResources.ProjectDB_ShowList", "AppResources")
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
        m_intProjectID = CType(Request.QueryString("ProjectID"), Integer)
        m_strPageTitle = MyBase.GetResourceString("PAGE_CAPTION")

        m_intProjectID = CType(Request.QueryString("ProjectID"), Integer)

    End Sub
    'Draw Top Menu
    Public Sub WritePage()
        Dim strMenu As String

        Dim arrstrActualFields() As String = {"IssueID", "ReportedDate", "Summary", "Type", "Status", "SubType", "Priority"}
        Dim arrstrUFFields() As String = {"Issue ID", "Reported On", "Summary", "Type", "Status", "Sub Type", "Priority"}
        Dim arrstrTDStyle() As String = {"align=center nowrap", "align=center nowrap", "", "align=left", "align=left", "align=left", "align=left"}

        Dim strCriteria As String = Trim(Request.QueryString("Criteria").ToString)
        Dim strParameter As String = Trim(Request.QueryString("Parameter").ToString)
        Dim strQuery As String
        '-- Array for Providing links to the Issue Entry Page from within the Data Grid
        Dim arrstrRowLinkField() As String = {"Issue_OnClick(IssueID)", "", "", "", "", "", ""}
        Dim cObjPageCaption As New WebPages.Template.PageCaption

        strMenu = PrepareMenu()
        CommonFunctions.General.WriteHTML(strMenu + "<BR>")

        '-- Page Caption
        MyBase.InitializeResources("AppResources.ProjectDB_ShowList", "AppResources")
        CommonFunction.General.WriteHTML(cObjPageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION"), , , True) + vbCrLf)
        cObjPageCaption = Nothing

        CommonFunction.General.WriteHTML("<DIV id='InitialDiv' STYLE='OVERFLOW: auto; HEIGHT: 100%'>")
        CommonFunction.General.WriteHTML("" + vbCrLf)

        If strParameter = MyBase.GetResourceString("NOT_SPECIFIED") Then
            strParameter = ""
        End If

        If strParameter.ToUpper = "[NOT SPECIFIED]" Then
            strParameter = ""
        End If
        '--SQL Query for populating grid
        strQuery = "usp_Sel_ProjectDB_tbl_IB_Issue " + m_intProjectID.ToString & ",'" + strCriteria + "','" & Replace(strParameter, "'", "''") & "'"
        '-- Draw Data Grid
        Dim objGrid As New WebPages.Template.GenericGrid
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        With objGrid
            .DIVHeight = 360
            .DIVID = "DivIssueList"
            .DIVStyle = " OVERFLOW: auto; HEIGHT: 100% "
            .ActualColumnArray = arrstrActualFields
            .UserFriendlyColumnArray = arrstrUFFields
            .TDStyleArray = arrstrTDStyle
            .NoOfDataColumns = 7
            .ColumnHeaderAlignment = "left"
            .SQL = strQuery
            .RowLinkArray = arrstrRowLinkField
            .UseSQL = m_blnUseSQL
            .EmptyValueReplacement = MyBase.GetResourceString("NOT_SPECIFIED")
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid() ' Called from within the section below

        End With

        CommonFunction.General.WriteHTML("</DIV>")
        CommonFunction.General.WriteHTML(strMenu)

    End Sub

    Private Function PrepareMenu() As String
        '-- Draw the Menu
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrClientSideFunctions() As String = {"Close_OnClick()", "Help_OnClick('PROJECT_GRAPHS')"}
        Dim strMenu As String = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        Return strMenu

    End Function

    Public Sub PlotHead()
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub

    Public Sub New()
        ' MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

    End Sub
End Class
