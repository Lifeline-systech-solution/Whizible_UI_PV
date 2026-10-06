Public Class KM_UserAuthentication
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

#Region " Constants Used in the Class "
    Protected Const MODE_SAVE As String = "Save"

    Private Enum MenuIndex
        SAVE
        CLOSE
        HELP
    End Enum
#End Region

#Region " Class scope Variables Declarations "
    'Menu
    Private m_objMenu As New WebPages.Template.StaticMenu
    Private m_arrMenuItem(2) As String
    Private m_arrMenuTooltip(2) As String
    Private m_arrClientSideFunctions(2) As String

    Private m_strPageTitle As String = ""
    Private m_strMode As String = ""
    Private m_lngEmployeeId As Long = 0
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim strQuery As String = ""
        Dim strRights As String = ""

        InitPageMenu()

        m_strPageTitle = CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("PAGE_TITLE"))
        m_lngEmployeeId = CType("0" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboEmployee")), Long)
        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"))
        If m_strMode = MODE_SAVE Then
            strRights = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidRights"))
            strQuery = "EXEC usp_Upd_tbl_KM_UserAuthentications " & m_lngEmployeeId.ToString()
            strQuery &= ", '" & strRights & "'"
            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        End If
    End Sub

    Public Sub New()
        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        MyBase.InitializeResources("AppResources.KM_UserAuthentication", "AppResources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "KM_UserAuthentication : " & UserInput & " " & Cause
        Throw ex
    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objMenu = Nothing
    End Sub

    Private Sub InitPageMenu()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        m_arrMenuItem(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE")
        m_arrMenuTooltip(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SAVE) = "Save_OnClick()"

        m_arrMenuItem(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE")
        m_arrMenuTooltip(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CLOSE) = "Close_OnClick()"

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick('KM')"

        MyBase.InitializeResources("AppResources.KM_UserAuthentication", "AppResources")
    End Sub

    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub

    Public Sub WritePage()
        Dim strMenu As String = ""
        Dim strQuery As String = ""
        Dim strTemp As String = ""
        Dim strEmployeeName As String = ""
        Dim drEmployee As IDataReader
        Dim objHref As New WebPages.UI.cDynamicLink

        'Display the Menu
        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<Br>")

        'Display the Page Caption
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(Nothing, MyBase.GetResourceString("PAGE_TITLE"), , , True))
        CommonFunctions.General.WriteHTML("<br>")

        'Display the Page body
        CommonFunctions.General.WriteHTML("<div ID='divList' style='scroll:auto; width:100%'>")
        CommonFunctions.General.WriteHTML("<table class='clsTable' cellSpacing='0' width='99.9%'>")
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td colspan='3'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SELECT_EMPLOYEE") & " : ")
        strQuery = "usp_Sel_tbl_PM_Employee"
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", strQuery, 250, m_lngEmployeeId.ToString(), "OnChange='cboEmployee_onchange()'", True, True))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")

        If m_lngEmployeeId > 0 Then
            strQuery = "usp_tbl_Sel_EmployeeInfo " & m_lngEmployeeId.ToString()
            drEmployee = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drEmployee) <> "" Then
                If drEmployee.Read() Then
                    strEmployeeName = drEmployee.Item("UserName").ToString()
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drEmployee)

            CommonFunctions.General.WriteHTML("<tr><td colspan='3'>&nbsp;</td></tr>")

            'Header after selecting the Employee
            CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td colspan='3'>")
            CommonFunctions.General.WriteHTML(Replace(MyBase.GetResourceString("PAGE_HEADER"), "<=>", strEmployeeName))
            CommonFunctions.General.WriteHTML("</td></tr>")

            CommonFunctions.General.WriteHTML("<tr><td colspan='3'>&nbsp;</td></tr>")

            CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td align='left'><label style='width:200'>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("AVAILABLE_CATEGORIES") & " : ")
            CommonFunctions.General.WriteHTML("</label></td><td align='center'>&nbsp;</td><td align='right'><label style='text-align=left;width:200'>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SELECTED_CATEGORIES") & " : ")
            CommonFunctions.General.WriteHTML("</label></td></tr>")

            CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td align='left' rowspan='4'>")
            strQuery = "Exec usp_Sel_tbl_KM_Categories NULL," & m_lngEmployeeId.ToString() & ", 0"
            strTemp = "OnDblClick = 'AddToAccessRightsList()' Onfocus= 'lstNonAccessibleCategories_onfocus()'"
            CommonFunctions.HTMLControls.DrawListBox("lstNonAccessibleCategories", strQuery, 200, 180, , strTemp)
            CommonFunctions.General.WriteHTML("</td>")

            CommonFunctions.General.WriteHTML("<td align='center'>")
            objHref.FunctionName = "AddAllToAccessRightsList()"
            objHref.LinkName = "<img src='../../images/allright.gif' border='0'>"
            objHref.ReturnHTML = True
            CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
            CommonFunctions.General.WriteHTML("</td>")

            CommonFunctions.General.WriteHTML("<td align='right' rowspan='4'>")
            strQuery = "Exec usp_Sel_tbl_KM_Categories NULL, " & m_lngEmployeeId.ToString() & ", 1"
            strTemp = "OnDblClick = 'AddToNoAccessRightsList()' Onfocus= 'lstAccessibleCategories_onfocus()'"
            CommonFunctions.HTMLControls.DrawListBox("lstAccessibleCategories", strQuery, 200, 180, , strTemp)
            CommonFunctions.General.WriteHTML("</td></tr>")

            CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td align='center'>")
            objHref.FunctionName = "AddToAccessRightsList()"
            objHref.LinkName = "<img src='../../images/right.gif' border='0'>"
            objHref.ReturnHTML = True
            CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
            CommonFunctions.General.WriteHTML("</td></tr>")

            CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td align='center'>")
            objHref.FunctionName = "AddToNoAccessRightsList()"
            objHref.LinkName = "<img src='../../images/left.gif' border='0'>"
            objHref.ReturnHTML = True
            CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
            CommonFunctions.General.WriteHTML("</td></tr>")

            CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td align='center'>")
            objHref.FunctionName = "AddAllToNoAccessRightsList()"
            objHref.LinkName = "<img src='../../images/allleft.gif' border='0'>"
            objHref.ReturnHTML = True
            CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
            CommonFunctions.General.WriteHTML("</td></tr>")

            CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td colspan='3'>&nbsp;</td></tr>")
        End If
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</div>")

        'Hidden Controls
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txthidRights", "txthidRights", value:="", IsHidden:=True, returnHTML:=True))
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txthidRights", "txthidRights", value:="", IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding


        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<Br>")
        CommonFunctions.General.WriteHTML(strMenu)
    End Sub
End Class
