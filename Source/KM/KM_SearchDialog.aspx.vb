Imports System.Text

Public Class KM_SearchDialog
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
    Private Const EMPLOYEE_COUNT_LOWER_THRESHOLD As Integer = 0

    Protected Const ACTION_SEARCH As String = "Search"
    Protected Const ACTION_CLEAR_SEARCH As String = "ClearSearch"

    Private Enum MenuIndex
        SEARCH
        CLEAR_SEARCH
        CLOSE
        HELP
    End Enum
    Private Const NUMBER_OF_MENUITEMS As Integer = 4
#End Region

#Region " Class scope Variables Declarations "
    'Menu
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_arrMenuItem(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrMenuTooltip(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrClientSideFunctions(NUMBER_OF_MENUITEMS - 1) As String

    Private m_lngPostId As Long = 0
    Private m_strPageTitle As String = ""
    Private m_strAction As String = ""
    Protected m_strClientSideScript As String = ""

    'Search Fields
    Private m_strFreeText As String = ""
    Private m_blnSearchInTitle As Boolean = False
    Private m_blnSearchInCode As Boolean = False
    Private m_blnSearchInExample As Boolean = False
    Private m_blnSearchInComments As Boolean = False
    Private m_blnSearchInPrerequisites As Boolean = False
    Private m_blnSearchInApplication As Boolean = False
    Private m_blnSearchInAttachmentName As Boolean = False
    Private m_blnSearchInAll As Boolean = False
    Private m_lngContributorId As Long = 0
    Private m_strContributorName As String = ""
    Private m_strSubmission_FromDate As String = ""
    Private m_strSubmission_ToDate As String = ""
    Private m_lngAuthenticatorId As Long = 0
    Private m_strAuthenticatorName As String = ""
    Private m_strAuthentication_FromDate As String = ""
    Private m_strAuthentication_ToDate As String = ""
    Private m_lngCategoryId As Long = 0
    Private m_lngSubCategoryId As Long = 0
    Private m_lngProjectId As Long = 0
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        InitPageMenu()

        m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE")

        m_lngPostId = CType("0" & CommonFunctions.General.CheckIsNothing(Session.Item("intPostID")), Long)
        m_strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("Action"))
        If m_strAction = ACTION_SEARCH Then
            KM_Search()
        ElseIf m_strAction = ACTION_CLEAR_SEARCH Then
            KM_ClearSearch()
        End If

        ' Get the previously applied search parameters.
        If CommonFunctions.General.CheckIsNothing(Session.Item("KM_Search_Query")) <> "" Then
            GetSearchParameters()
        Else
            m_blnSearchInTitle = True
        End If
    End Sub

    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        MyBase.InitializeResources("AppResources.KM_SearchDialog", "AppResources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "KM_SearchDialog : " & UserInput & " " & Cause
        Throw ex
    End Sub

    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub

    Private Sub InitPageMenu()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        m_arrMenuItem(MenuIndex.SEARCH) = MyBase.GetResourceString("MENU_SEARCH")
        m_arrMenuTooltip(MenuIndex.SEARCH) = MyBase.GetResourceString("MENU_SEARCH_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SEARCH) = "Search_OnClick()"

        m_arrMenuItem(MenuIndex.CLEAR_SEARCH) = MyBase.GetResourceString("MENU_CLEARSEARCH")
        m_arrMenuTooltip(MenuIndex.CLEAR_SEARCH) = MyBase.GetResourceString("MENU_CLEARSEARCH_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CLEAR_SEARCH) = "ClearSearch_OnClick()"

        m_arrMenuItem(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE")
        m_arrMenuTooltip(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CLOSE) = "Close_OnClick()"

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick('KM_SEARCH')"

        MyBase.InitializeResources("AppResources.KM_SearchDialog", "AppResources")
    End Sub

    Public Sub WritePage()
        Dim strMenu As String = ""

        'Display the Menu
        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<br>")

        'Display the Page Caption
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(Nothing, MyBase.GetResourceString("SEARCH"), , , True))
        CommonFunctions.General.WriteHTML("<br>")

        'Display the Page Body
        Display_SearchPage()

        'Display Menu at the Footer
        CommonFunctions.General.WriteHTML("<br>")
        CommonFunctions.General.WriteHTML(strMenu)
    End Sub

    Private Sub Display_SearchPage()
        Dim strQuery As String = ""
        Dim sbHTML As New StringBuilder("")

        sbHTML.Append("<div ID='divList' style='scroll:auto; width:100%'>")
        sbHTML.Append("<table CellSpacing='0' width='99.9%' class='clsTable'>")
        sbHTML.Append("<tr class='clsTREven'>")
        sbHTML.Append("<td>&nbsp;</td>")
        sbHTML.Append("<td>")
        sbHTML.Append("[<I>" & MyBase.GetResourceString("USE_FILTER_TEXT") & "</I>]")
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("<tr class='clsTREven'>")
        sbHTML.Append("<td valign='top' align='right'>")
        sbHTML.Append(MyBase.GetResourceString("TEXT_TO_BE_SEARCHED"))
        sbHTML.Append("</td>")
        sbHTML.Append("<td valign='top'>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        '' sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtFreeText", "txtFreeText", , , 200, m_strFreeText, Style:="WIDTH:100%", returnHTML:=True))
        sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtFreeText", "txtFreeText", , , 200, m_strFreeText, style:="WIDTH:100%", returnHTML:=True, EnableHTMLEncode:=True))
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("<tr id='rowFreeText_SearchParameters' class='clsTREven'>")
        sbHTML.Append("<td>&nbsp;</td>")
        sbHTML.Append("<td valign='top'>")
        sbHTML.Append(MyBase.GetResourceString("SEARCH_IN"))
        sbHTML.Append("<table cellSpacing='0' width='99.9%' class='clsTable' border='1'>")
        sbHTML.Append("<tr class='clsTREven'>")
        sbHTML.Append("<td valign='top' width='25%'>")
        sbHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkTitle", "chkTitle", , m_blnSearchInTitle, "1", m_blnSearchInAll, returnHTML:=True))
        sbHTML.Append(MyBase.GetResourceString("TITLE"))
        sbHTML.Append("</td>")
        sbHTML.Append("<td valign='top' width='25%'>")
        sbHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkCode", "chkCode", , m_blnSearchInCode, "1", m_blnSearchInAll, returnHTML:=True))
        sbHTML.Append(MyBase.GetResourceString("CODE_ARTICLE"))
        sbHTML.Append("</td>")
        sbHTML.Append("<td valign='top' width='25%'>")
        sbHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkExample", "chkExample", , m_blnSearchInExample, "1", m_blnSearchInAll, returnHTML:=True))
        sbHTML.Append(MyBase.GetResourceString("EXAMPLE"))
        sbHTML.Append("</td>")
        sbHTML.Append("<td valign='top' width='25%'>")
        sbHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkComments", "chkComments", , m_blnSearchInComments, "1", m_blnSearchInAll, returnHTML:=True))
        sbHTML.Append(MyBase.GetResourceString("COMMENTS"))
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("<tr class='clsTREven'>")
        sbHTML.Append("<td valign='top'>")
        sbHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkPrerequisites", "chkPrerequisites", , m_blnSearchInPrerequisites, "1", m_blnSearchInAll, returnHTML:=True))
        sbHTML.Append(MyBase.GetResourceString("PREREQUISITES"))
        sbHTML.Append("</td>")
        sbHTML.Append("<td valign='top'>")
        sbHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkApplication", "chkApplication", , m_blnSearchInApplication, "1", m_blnSearchInAll, returnHTML:=True))
        sbHTML.Append(MyBase.GetResourceString("WHERE_CAN_APPLIED"))
        sbHTML.Append("</td>")
        sbHTML.Append("<td valign='top'>")
        sbHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkAttachmentName", "chkAttachmentName", , m_blnSearchInAttachmentName, "1", m_blnSearchInAll, returnHTML:=True))
        sbHTML.Append(MyBase.GetResourceString("ATTACHMENTS_NAMES"))
        sbHTML.Append("</td>")
        sbHTML.Append("<td valign='top'>")
        sbHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkAll", "chkAll", , m_blnSearchInAll, "1", , "OnClick='chkAll_OnClick()'", True))
        sbHTML.Append(MyBase.GetResourceString("ALL"))
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("</table>")
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("<tr class='clsTREven'>")
        sbHTML.Append("<td>&nbsp;</td>")
        sbHTML.Append("<td>")
        sbHTML.Append("[<I>" & MyBase.GetResourceString("USE_FILTER_ARTICLE") & "</I>]")
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("<tr class='clsTREven'>")
        sbHTML.Append("<td valign='top' align='right' width='20%'>")
        sbHTML.Append(MyBase.GetResourceString("CONTRIBUTED_BY"))
        sbHTML.Append("</td>")
        sbHTML.Append("<td valign='top'>")
        strQuery = "Exec usp_Sel_KM_Contributors"
        If IsEmployeesLessThanThreshold(strQuery) = True Then
            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("txtContributorID", strQuery, 150, m_lngContributorId.ToString(), , True, ReturnAsHTML:=True))
        Else
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            ''sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtContributorName", "txtContributorName", , , , m_strContributorName, style:="WIDTH:150px", IsReadonly:=True, returnHTML:=True))
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtContributorName", "txtContributorName", , , , m_strContributorName, style:="WIDTH:150px", IsReadonly:=True, returnHTML:=True, EnableHTMLEncode:=True))
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

            sbHTML.Append("&nbsp;" & CommonFunctions.HTMLControls.DrawImage("../../images/dblclick.gif", "imgValidationRules", , "JavaScript:SelectEmployee('Contributor')", 12, 12, , True))
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            ''sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtContributorID", "txtContributorID", , , , m_lngContributorId.ToString(), IsReadonly:=True, IsHidden:=True, returnHTML:=True))
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtContributorID", "txtContributorID", , , , m_lngContributorId.ToString(), IsReadonly:=True, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

            sbHTML.Append("| <A style='text-decoration:none' href='javascript:ClearContributor_OnClick()'><B>" & MyBase.GetResourceString("CLEAR") & "</B></A>	|")
        End If
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("<tr class='clsTREven'>")
        sbHTML.Append("<td>&nbsp;</td>")
        sbHTML.Append("<td>")
        sbHTML.Append("[<I>" & MyBase.GetResourceString("USE_FILTER_SUMITTED_ARTICLES") & "</I>]")
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("<tr class='clsTREven'>")
        sbHTML.Append("<td valign='top' align='right' width='20%'>")
        sbHTML.Append(MyBase.GetResourceString("DATE_OF_SUBMISSION"))
        sbHTML.Append("</td>")
        sbHTML.Append("<td valign='top'>")
        sbHTML.Append("<table cellSpacing='0' width='99.9%' class='clsTable' border='1'>")
        sbHTML.Append("<tr class='clsTREven'>")
        sbHTML.Append("<td valign='top' width='20' align='right'>")
        sbHTML.Append(MyBase.GetResourceString("FROM"))
        sbHTML.Append("</td>")
        sbHTML.Append("<td valign='top' width='50%'>")
        sbHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtSubmission_FromDate", "txtSubmission_FromDate", , , m_strSubmission_FromDate, , "frmKMSearch", returnHTML:=True))
        sbHTML.Append("</td>")
        sbHTML.Append("<td valign='top' width='20' align='right'>")
        sbHTML.Append(MyBase.GetResourceString("TO"))
        sbHTML.Append("</td>")
        sbHTML.Append("<td valign='top' width='50%'>")
        sbHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtSubmission_ToDate", "txtSubmission_ToDate", , , m_strSubmission_ToDate, , "frmKMSearch", returnHTML:=True))
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("</table>")
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")
        If m_lngPostId = CommonFunctions.Constants.ROLE_ADMINISTRATOR Then
            sbHTML.Append("<tr class='clsTREven'>")
            sbHTML.Append("<td>&nbsp;</td>")
            sbHTML.Append("<td>")
            sbHTML.Append("[<I>" & MyBase.GetResourceString("USE_FILTER_AUTHENTICATED_ARTICLES_SELECTED_EMPLOYEE") & "</I>]")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
            sbHTML.Append("<tr class='clsTREven'>")
            sbHTML.Append("<td valign='top' align='right'>")
            sbHTML.Append(MyBase.GetResourceString("AUTHENTICATED_BY"))
            sbHTML.Append("</td>")
            sbHTML.Append("<td valign='top'>")
            strQuery = "Exec usp_Sel_KM_Authenticators"
            If IsEmployeesLessThanThreshold(strQuery) = True Then
                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("txtAuthenticatorID", strQuery, 150, m_lngAuthenticatorId.ToString(), , True, ReturnAsHTML:=True))
            Else
                'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                ''sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtAuthenticatorName", "txtAuthenticatorName", , , , m_strAuthenticatorName, style:="WIDTH:150px", IsReadonly:=True, returnHTML:=True))
                sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtAuthenticatorName", "txtAuthenticatorName", , , , m_strAuthenticatorName, style:="WIDTH:150px", IsReadonly:=True, returnHTML:=True, EnableHTMLEncode:=True))
                'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

                sbHTML.Append("&nbsp;" & CommonFunctions.HTMLControls.DrawImage("../../images/dblclick.gif", "imgValidationRules", , "JavaScript:SelectEmployee('Authentication')", 12, 12, , True))
                'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                ''sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtAuthenticatorID", "txtAuthenticatorID", , , , m_lngAuthenticatorId.ToString(), IsReadonly:=True, IsHidden:=True, returnHTML:=True))
                sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtAuthenticatorID", "txtAuthenticatorID", , , , m_lngAuthenticatorId.ToString(), IsReadonly:=True, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
                'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

                sbHTML.Append("| <A style='text-decoration:none' href='javascript:ClearAuthenticator_OnClick()'><B>" & MyBase.GetResourceString("CLEAR") & "</B></A>	|")
            End If
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
            sbHTML.Append("<tr class='clsTREven'>")
            sbHTML.Append("<td>&nbsp;</td>")
            sbHTML.Append("<td>")
            sbHTML.Append("[<I>" & MyBase.GetResourceString("USE_FILTER_AUTHENTICATED_ARTICLES_FROM_TO_DATE") & "</I>]")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
            sbHTML.Append("<tr class='clsTREven'>")
            sbHTML.Append("<td valign='top' align='right' width='20%'>")
            sbHTML.Append(MyBase.GetResourceString("DATE_OF_AUTHETICATION"))
            sbHTML.Append("</td>")
            sbHTML.Append("<td valign='top'>")
            sbHTML.Append("<table cellSpacing='0' width='99.9%' class='clsTable' border='1'>")
            sbHTML.Append("<tr class='clsTREven'>")
            sbHTML.Append("<td valign='top' width='20' align='right'>")
            sbHTML.Append(MyBase.GetResourceString("FROM"))
            sbHTML.Append("</td>")
            sbHTML.Append("<td valign='top' width='50%'>")
            sbHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtAuthentication_FromDate", "txtAuthentication_FromDate", , , m_strAuthentication_FromDate, , "frmKMSearch", returnHTML:=True))
            sbHTML.Append("</td>")
            sbHTML.Append("<td valign='top' width='20' align='right'>")
            sbHTML.Append(MyBase.GetResourceString("TO"))
            sbHTML.Append("</td>")
            sbHTML.Append("<td valign='top' width='50%'>")
            sbHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtAuthentication_ToDate", "txtAuthentication_ToDate", , , m_strAuthentication_ToDate, , "frmKMSearch", returnHTML:=True))
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
            sbHTML.Append("</table>")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
        End If
        sbHTML.Append("<tr class='clsTREven'>")
        sbHTML.Append("<td>&nbsp;</td>")
        sbHTML.Append("<td>")
        sbHTML.Append("[<I>" & MyBase.GetResourceString("USE_FILTER_ARTICLES_CATEGORY") & "</I>]")
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("<tr class='clsTREven'>")
        sbHTML.Append("<td valign='top' align='right'>")
        sbHTML.Append(MyBase.GetResourceString("CATEGORY"))
        sbHTML.Append("</td>")
        sbHTML.Append("<td valign='top'>")
        strQuery = "usp_Sel_tbl_KM_Categories"
        sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboCategoryID", strQuery, 300, m_lngCategoryId.ToString(), , True, ReturnAsHTML:=True))
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("<tr class='clsTREven'>")
        sbHTML.Append("<td>&nbsp;</td>")
        sbHTML.Append("<td>")
        sbHTML.Append("[<I>" & MyBase.GetResourceString("USE_FILTER_ARTICLES_SUBCATEGORY") & "</I>]")
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("<tr class='clsTREven'>")
        sbHTML.Append("<td valign='top' align='right'>")
        sbHTML.Append(MyBase.GetResourceString("SUBCATEGORY"))
        sbHTML.Append("</td>")
        sbHTML.Append("<td valign='top'>")
        strQuery = "Exec usp_Sel_tbl_KM_SubCategories"
        sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSubCategoryID", strQuery, 300, m_lngSubCategoryId.ToString(), , True, ReturnAsHTML:=True))
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("<tr class='clsTREven'>")
        sbHTML.Append("<td>&nbsp;</td>")
        sbHTML.Append("<td>")
        sbHTML.Append("[<I>" & " [Use this filter to get the list of articles taken from the specified product.] " & "</I>]")
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("<tr class='clsTREven'>")
        sbHTML.Append("<td valign='top' align='right'>")
        sbHTML.Append("Product")
        sbHTML.Append("</td>")
        sbHTML.Append("<td valign='top'>")
        strQuery = "select ProductID,Product from tbl_PRD_product order by product"
        sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProjectID", strQuery, 300, m_lngProjectId.ToString(), , True, ReturnAsHTML:=True))
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("</table>")
        sbHTML.Append("</div>")

        CommonFunctions.General.WriteHTML(sbHTML.ToString())
    End Sub

    Private Sub GetSearchParameters()
        '=====================================================================
        ' Procedure Name        :	GetSearchParameters
        ' Description           :	To retrieve the previous settings of the search criteria.
        ' Purpose               :	Same as above.
        ' Parameters Passed     :	None.
        ' Returns               :	None.
        ' Parameters Affected   :	None.
        ' Assumptions           :	This function retrieves the previous sessions from the search query that was built.
        '							If any of the parameters in the stored procedure are modified or rearranged,
        '							the corresponding changes must be made in this function as well.
        ' Dependencies          :	None.
        ' Author                :	Jayavant
        ' Created               :	5-Mar-2004
        ' Revisions             :
        '=====================================================================

        Dim arrTemp() As String
        Dim strFilterQuery As String = ""
        Dim intUbound As Integer = 0

        '####################################################################
        '	NOTE: IF THERE IS ANY CHANGE IN THIS FUNCTION MAKE THE CORRESPONDING 
        '			CHANGES IN...
        '			PAGE		"KM_SearchResults.aspx"
        '			FUNCTION	GetUserFriendlySearchQuery
        '#####################################################################

        strFilterQuery = CommonFunctions.General.CheckIsNothing(Session.Item("KM_Search_Query"))

        ' NOTE: The parameters to the stored procedure can be retrieved by splitting them at
        '		every occurance of comma. But if the free text itself contains comma(s), 
        '		it may cause a problem. This case needs to be handled.
        ' If the free text contains any commas, then...

        If InStr(CommonFunctions.General.CheckIsNothing(Session.Item("KM_Search_FreeText")), ",", CompareMethod.Text) <> 0 Then
            ' Split the free text and get the number of commas present in the string.
            arrTemp = CommonFunctions.General.CheckIsNothing(Session.Item("KM_Search_FreeText")).Split(CType(",", Char))

            ' Now, split the main query on the commas, and replace them with empty string. 
            ' This operation will remove the commas from the free text in the main query.
            ' This query can now be split correctly for the other parameters.
            intUbound = arrTemp.Length
            arrTemp = Split(strFilterQuery, ",", intUbound + 1, CompareMethod.Text)
            strFilterQuery = Join(arrTemp, "")
        End If
        arrTemp = Split(strFilterQuery, ",")

        intUbound = UBound(arrTemp)
        If intUbound < 17 Then
            Exit Sub
        End If

        ' Free Text.
        m_strFreeText = CommonFunctions.General.CheckIsNothing(Session.Item("KM_Search_FreeText"))

        ' Search in Title.
        If Trim(arrTemp(1)) = "1" Then
            m_blnSearchInTitle = True
        End If

        ' Search in Code.
        If Trim(arrTemp(2)) = "1" Then
            m_blnSearchInCode = True
        End If

        ' Search in Example.
        If Trim(arrTemp(3)) = "1" Then
            m_blnSearchInExample = True
        End If

        ' Search in Comments.
        If Trim(arrTemp(4)) = "1" Then
            m_blnSearchInComments = True
        End If

        ' Search in Prerequisites.
        If Trim(arrTemp(5)) = "1" Then
            m_blnSearchInPrerequisites = True
        End If

        ' Search in Application.
        If Trim(arrTemp(6)) = "1" Then
            m_blnSearchInApplication = True
        End If

        ' Search in Attachment Names.
        If Trim(arrTemp(7)) = "1" Then
            m_blnSearchInAttachmentName = True
        End If

        ' Search in All.
        If Trim(arrTemp(8)) = "1" Then
            m_blnSearchInAll = True
        End If

        ' Contributed By.
        If Trim(arrTemp(9)) <> "NULL" Then
            m_lngContributorId = CType("0" & Trim(arrTemp(9)), Long)
            GetEmployeeInfo(m_lngContributorId, m_strContributorName)
        End If

        ' Date of Submission (From date).
        If Trim(arrTemp(10)) <> "NULL" Then
            m_strSubmission_FromDate = Trim(arrTemp(10))
            m_strSubmission_FromDate = Mid(m_strSubmission_FromDate, 2, Len(m_strSubmission_FromDate) - 2)
        End If

        ' Date of Submission (To date).
        If Trim(arrTemp(11)) <> "NULL" Then
            m_strSubmission_ToDate = Trim(arrTemp(11))
            m_strSubmission_ToDate = Mid(m_strSubmission_ToDate, 2, Len(m_strSubmission_ToDate) - 2)
        End If

        ' Authenticated By.
        If Trim(arrTemp(12)) <> "NULL" Then
            m_lngAuthenticatorId = CType("0" & Trim(arrTemp(12)), Long)
            GetEmployeeInfo(m_lngAuthenticatorId, m_strAuthenticatorName)
        End If

        ' Date of Authentication (From date).
        If Trim(arrTemp(13)) <> "NULL" Then
            m_strAuthentication_FromDate = Trim(arrTemp(13))
            m_strAuthentication_FromDate = Mid(m_strAuthentication_FromDate, 2, Len(m_strAuthentication_FromDate) - 2)
        End If

        ' Date of Authentication (To date).
        If Trim(arrTemp(14)) <> "NULL" Then
            m_strAuthentication_ToDate = Trim(arrTemp(14))
            m_strAuthentication_ToDate = Mid(m_strAuthentication_ToDate, 2, Len(m_strAuthentication_ToDate) - 2)
        End If

        ' Category.
        If Trim(arrTemp(15)) <> "NULL" Then
            m_lngCategoryId = CType("0" & Trim(arrTemp(15)), Long)
        End If

        ' Sub Category.
        If Trim(arrTemp(16)) <> "NULL" Then
            m_lngSubCategoryId = CType("0" & Trim(arrTemp(16)), Long)
        End If

        ' Project.
        If Trim(arrTemp(17)) <> "NULL" Then
            m_lngProjectId = CType("0" & Trim(arrTemp(17)), Long)
        End If
    End Sub

    Private Sub GetEmployeeInfo(ByVal lngEmployeeId As Long, ByRef strEmployeeName As String)
        Dim drEmployee As IDataReader
        Dim strQuery As String = ""

        strEmployeeName = ""
        If lngEmployeeId <= 0 Then Return

        strQuery = "usp_tbl_Sel_EmployeeInfo " & lngEmployeeId.ToString()
        drEmployee = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drEmployee) <> "" Then
            If drEmployee.Read() Then
                strEmployeeName = drEmployee.Item("UserName").ToString()
                strEmployeeName = CommonFunctions.General.UnBuildQueryString(strEmployeeName)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drEmployee)
    End Sub

    Private Function IsEmployeesLessThanThreshold(ByVal strQuery As String) As Boolean
        Dim drEmployee As IDataReader
        Dim intCount As Integer = 0

        drEmployee = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drEmployee) <> "" Then
            While drEmployee.Read()
                intCount += 1
                If intCount >= EMPLOYEE_COUNT_LOWER_THRESHOLD Then
                    drEmployee.Close()
                    CommonFunctions.Data.DisposeDataReader(drEmployee)
                    Return False
                End If
            End While
        End If
        CommonFunctions.Data.DisposeDataReader(drEmployee)

        If intCount < EMPLOYEE_COUNT_LOWER_THRESHOLD Then
            Return False
        Else
            Return True
        End If
    End Function

    Private Sub KM_Search()
        Dim strFilterQuery As String = ""
        Dim blnFilterApplied As Boolean = False

        ' Build the Search query according to the parameters selected.	
        strFilterQuery = "Exec usp_Sel_tbl_KM_CodeHeadings_SearchedArticles "

        ' Free Text.	
        m_strFreeText = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtFreeText"))
        m_strFreeText = CommonFunctions.General.UnBuildQueryString(m_strFreeText).Trim()
        If m_strFreeText <> "" Then
            blnFilterApplied = True
            Session.Item("KM_Search_FreeText") = m_strFreeText
            strFilterQuery &= "'" & CommonFunctions.General.BuildQueryString(Left(m_strFreeText, 200)) & "'"
        Else
            Session.Item("KM_Search_FreeText") = ""
            strFilterQuery &= "NULL"
        End If

        ' Title.        
        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkTitle")) <> "" Then
            strFilterQuery &= ", 1"
        Else
            strFilterQuery &= ", NULL"
        End If

        ' Code.
        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkCode")) <> "" Then
            strFilterQuery &= ", 1"
        Else
            strFilterQuery &= ", NULL"
        End If

        ' Example.
        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkExample")) <> "" Then
            strFilterQuery &= ", 1"
        Else
            strFilterQuery &= ", NULL"
        End If

        ' Comments.
        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkComments")) <> "" Then
            strFilterQuery &= ", 1"
        Else
            strFilterQuery &= ", NULL"
        End If

        ' Prerequisites.
        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkPrerequisites")) <> "" Then
            strFilterQuery &= ", 1"
        Else
            strFilterQuery &= ", NULL"
        End If

        ' Application.
        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkApplication")) <> "" Then
            strFilterQuery &= ", 1"
        Else
            strFilterQuery &= ", NULL"
        End If

        ' Attachment Name.
        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkAttachmentName")) <> "" Then
            strFilterQuery &= ", 1"
        Else
            strFilterQuery &= ", NULL"
        End If

        ' All.
        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkAll")) <> "" Then
            strFilterQuery &= ", 1"
        Else
            strFilterQuery &= ", NULL"
        End If

        ' Contributor.
        m_lngContributorId = CType("0" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtContributorID")), Long)
        If m_lngContributorId <> 0 Then
            blnFilterApplied = True
            strFilterQuery &= ", " & m_lngContributorId.ToString()
        Else
            strFilterQuery &= ", NULL"
        End If

        ' Submission From Date.
        m_strSubmission_FromDate = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtSubmission_FromDate")).Trim()
        If m_strSubmission_FromDate <> "" Then
            blnFilterApplied = True
            m_strSubmission_FromDate = CommonFunctions.Dates.GetDate(CType(m_strSubmission_FromDate, Date))
            strFilterQuery &= ", '" & m_strSubmission_FromDate & "'"
        Else
            strFilterQuery &= ", NULL"
        End If

        ' Submission To Date.
        m_strSubmission_ToDate = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtSubmission_ToDate")).Trim()
        If m_strSubmission_ToDate <> "" Then
            blnFilterApplied = True
            m_strSubmission_ToDate = CommonFunctions.Dates.GetDate(CType(m_strSubmission_ToDate, Date))
            strFilterQuery &= ", '" & m_strSubmission_ToDate & "'"
        Else
            strFilterQuery &= ", NULL"
        End If

        ' Authenticator.
        m_lngAuthenticatorId = CType("0" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtAuthenticatorID")), Long)
        If m_lngAuthenticatorId <> 0 Then
            blnFilterApplied = True
            strFilterQuery &= ", " & m_lngAuthenticatorId.ToString()
        Else
            strFilterQuery &= ", NULL"
        End If

        ' Authentication From Date.
        m_strAuthentication_FromDate = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtAuthentication_FromDate")).Trim()
        If m_strAuthentication_FromDate <> "" Then
            blnFilterApplied = True
            m_strAuthentication_FromDate = CommonFunctions.Dates.GetDate(CType(m_strAuthentication_FromDate, Date))
            strFilterQuery &= ", '" & m_strAuthentication_FromDate & "'"
        Else
            strFilterQuery &= ", NULL"
        End If

        ' Authentication To Date.
        m_strAuthentication_ToDate = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtAuthentication_ToDate")).Trim()
        If m_strAuthentication_ToDate <> "" Then
            blnFilterApplied = True
            m_strAuthentication_ToDate = CommonFunctions.Dates.GetDate(CType(m_strAuthentication_ToDate, Date))
            strFilterQuery &= ", '" & m_strAuthentication_ToDate & "'"
        Else
            strFilterQuery &= ", NULL"
        End If

        ' Category.
        m_lngCategoryId = CType("0" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboCategoryID")), Long)
        If m_lngCategoryId <> 0 Then
            blnFilterApplied = True
            strFilterQuery &= ", " & m_lngCategoryId.ToString()
        Else
            strFilterQuery &= ", NULL"
        End If

        ' Sub Category.
        m_lngSubCategoryId = CType("0" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboSubCategoryID")), Long)
        If m_lngSubCategoryId <> 0 Then
            blnFilterApplied = True
            strFilterQuery &= ", " & m_lngSubCategoryId.ToString()
        Else
            strFilterQuery &= ", NULL"
        End If

        ' Project.
        m_lngProjectId = CType("0" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboProjectID")), Long)
        If m_lngProjectId <> 0 Then
            blnFilterApplied = True
            strFilterQuery &= ", " & m_lngProjectId.ToString()
        Else
            strFilterQuery &= ", NULL"
        End If
        'shraddha

        


        If blnFilterApplied = True Then
            Session.Item("KM_Search_Query") = strFilterQuery
            'Modified by ShraddhaM on Date 05 Jully,2006 for WhizibleSEM Issue ID.4168

            m_strClientSideScript = "window.opener.parent.frames[""Sub""].document.location.href = ""KM_SearchResults.aspx"";" & vbCrLf

            ' m_strClientSideScript = "window.opener.frames(""Sub"").document.location.href = ""KM_SearchResults.aspx"";" & vbCrLf
            m_strClientSideScript &= "window.close();" & vbCrLf
        Else
            Session.Item("KM_Search_Query") = ""
            m_strClientSideScript = "if(isSubstringExists(window.opener.parent.frames[""Sub""].document.location.href, ""KM_SearchResults.aspx""))" & vbCrLf
            m_strClientSideScript &= "  window.opener.parent.frames[""Sub""].document.location.href = ""../General/Introduction.aspx?FromWhere=KM"";" & vbCrLf
            m_strClientSideScript &= "else if(isSubstringExists(window.opener.parent.frames[""Sub""].document.location.href, ""KM_PlainTextDisplay.aspx"")){" & vbCrLf
            m_strClientSideScript &= "  var strPageName;" & vbCrLf
            m_strClientSideScript &= "  strPageName = window.opener.parent.frames[""Sub""].document.location.href;" & vbCrLf
            m_strClientSideScript &= "  if(isSubstringExists(strPageName,'Mode'))" & vbCrLf
            m_strClientSideScript &= "      strPageName = strPageName.substring(0, strPageName.indexOf['Mode']-1);" & vbCrLf
            m_strClientSideScript &= "   window.opener.parent.frames[""Sub""].document.location.href = strPageName;" & vbCrLf
            m_strClientSideScript &= "}" & vbCrLf
            m_strClientSideScript &= "window.close();" & vbCrLf
        End If
    End Sub

    Private Sub KM_ClearSearch()
        Session.Item("KM_Search_Query") = ""
        Session.Item("KM_Search_FreeText") = ""
        'm_strClientSideScript = "alert('hi');"
        m_strClientSideScript = "if(isSubstringExists(window.opener.parent.frames[""Sub""].document.location.href, ""KM_SearchResults.aspx""))" & vbCrLf
        m_strClientSideScript &= "  window.opener.parent.frames[""Sub""].document.location.href = ""../General/Introduction.aspx?FromWhere=KM"";" & vbCrLf
        m_strClientSideScript &= "else if(isSubstringExists(window.opener.parent.frames[""Sub""].document.location.href, ""KM_PlainTextDisplay.aspx"")){" & vbCrLf
        m_strClientSideScript &= "  var strPageName;" & vbCrLf
        m_strClientSideScript &= "  strPageName = window.opener.parent.frames[""Sub""].document.location.href;" & vbCrLf
        m_strClientSideScript &= "  if(isSubstringExists(strPageName,""#""))" & vbCrLf
        m_strClientSideScript &= "      strPageName = strPageName.substring(0, strPageName.indexOf[""#""]);" & vbCrLf
        m_strClientSideScript &= "   window.opener.parent.frames[""Sub""].document.location.href = strPageName;" & vbCrLf
        m_strClientSideScript &= "}" & vbCrLf
        m_strClientSideScript &= "window.close();" & vbCrLf
        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

        ''window.opener.location.href()
        ''''''''''''''''''''''''''''''''''''''''''''''''''''
         
       
        
    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        If CommonFunctions.General.CheckIsNothing(Session.Item("KM_Search_Query")) = "" And Args.LinkName = m_arrMenuItem(MenuIndex.CLEAR_SEARCH) Then Cancel = True
    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objMenu = Nothing
    End Sub
End Class
