Public Class CodeTemplates
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
    '=====================================================================
    ' Page Name             : CodeTemplates
    ' Purpose               : To display code templates
    ' Description           : This page is called from the Corporate Settings page
    ' Parameters Passed     : 
    ' Assumptions           : 
    ' Dependencies          : CommonFunction.vb, CommonFunctions.js
    ' Author                : AbhijeetD
    ' Created               : 4th May 2004
    ' Revisions             : 
    '=====================================================================

    Private m_blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objMenu As New WebPage.Templates.StaticMenu


    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit
        ' Purpose               : Entry to the page
        ' Description           : Called from within the <Form> Tag
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 4th May 2004
        ' Revisions             :
        '=====================================================================

        Dim strMenu As String

        'Render top menu
        strMenu = DrawMenu()
        Response.Write(strMenu)

        'Render the Page Legend
        Dim arrLegend() As String = {MyBase.GetResourceString("MANDATORY")}
        Dim arrLegendImage() As String = {CommonFunctions.HTMLControls.DrawMandatoryImage(, True)}
        CommonFunction.General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend) + vbCrLf)

        'Draw Header
        Dim objHeader As New WebPage.Templates.HeaderFooter
        objHeader.HeaderFooter = ""
        objHeader.DrawHeaderFooter()
        objHeader = Nothing

        'CommonFunction.General.WriteHTML("<BR>")

        'Render page caption
        CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION"), , , True))
        CommonFunction.General.WriteHTML("<BR>")

        Response.Write("<DIV ID='PageDiv' Style='Height:300px;WIDTH:100%;OVERFLOW:auto;'>")

        'Render UI for the page
        DrawTemplateList()
        Response.Write("</DIV>")

        'Render botton menu
        Response.Write("<br>" + strMenu)

    End Sub

    Public Sub New()
        'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub

    Private Function DrawMenu() As String
        '=====================================================================
        ' Procedure Name        : DrawMenu
        ' Purpose               : Returns Menu as string for the page
        ' Description           : NOTE: Access Rights are handled in the Menu events
        ' Parameters Passed     : None
        ' Returns               : String (Menu)
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 4th May, 2004   
        ' Revisions             :
        '=====================================================================

        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrClientSideFunctions() As String = {"Close_OnClick()", "Help_OnClick('CODE_TEMPLATE')"}
        Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)

        MyBase.InitializeResources("AppResources.CodeTemplates", "AppResources")
        Return (strMenu)

    End Function

    Private Sub DrawTemplateList()
        '=====================================================================
        ' Procedure Name        : DrawTemplateList
        ' Purpose               : Render the list of templates
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 4th May 2004
        ' Revisions             :
        '=====================================================================

        Dim arrstrActualList() As String = {"ModuleName", "CodeTemplate", MyBase.GetResourceString("DEFINE_SERIES") + "..."}
        Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("MODULE_NAME"), MyBase.GetResourceString("CODE_TEMPLATE"), MyBase.GetResourceString("DEFINE_SERIES")}
        Dim arrstrRowLink() As String = {"", "", "DefineSeries_OnClick(ModuleID,ModuleName)"}
        Dim arrstrTDStyle() As String = {" noWrap align='left' ", " noWrap align='left' ", " noWrap align='center' "}
        Dim strGRID As String
        'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
        ''Dim strSQL As String = "SELECT * FROM tbl_PM_CodeTemplates" 'Where ModuleID<>4" 'Commented By Paresh B on July 28, 2004
        Dim strSQL As String = "usp_Sel_tbl_PM_CodeTemplates " 'Where ModuleID<>4" 'Commented By Paresh B on July 28, 2004
        'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:06/10/15

        With m_objGrid

            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0) - 1
            .RowLinkArray = arrstrRowLink
            .TDStyleArray = arrstrTDStyle
            .PrimaryKey = "ModuleID"
            .ColumnHeaderAlignment = "left"
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .SQL = strSQL
            .DIVHeight = 0
            .DIVStyle = " width:100% "
            .returnHTML = True
            .UseSQL = m_blnUseSQL
            .ColNameToolTipOnEachRow = True

            strGRID = .DrawGrid()
        End With
        Response.Write(strGRID)
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.ColIndex = 1 Then
            Args.DataFieldValue = Args.DataFieldValue.ToString.Replace("&#60;", "<")
            Args.DataFieldValue = Args.DataFieldValue.ToString.Replace("&#62;", ">")
        End If
    End Sub
End Class
