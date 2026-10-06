Public Class KM_Display
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
    Protected Const SHOW_DETAILS As String = "Details"
    Protected Const SHOW_ATTACHMENTS As String = "Attachments"
    Protected Const SHOW_PROCEDURECODE As String = "ProcedureCode"
    Protected Const SHOW_PROCEDURECOMMENT As String = "ProcedureComment"
    Protected Const SHOW_PROCEDUREEXAMPLE As String = "ProcedureExample"

    Protected Const TYPE_FAVORITE As String = "Favorite"
    Protected Const TYPE_ARTICLE As String = "Article"
    Protected Const TYPE_QSD As String = "QSD"

    Protected Const RELATION_SIBLING As String = "sibling"
    Protected Const RELATION_CHILD As String = "child"

    Protected Const ACTION_DELETE As String = "Delete"

    Protected Const MODE_AUTHENTICATE As String = "Authenticate"
    Protected Const MODE_CLEAR_SEARCH As String = "ClearSearch"
    Protected Const MODE_ADD_TO_FAVORITES As String = "AddToFavorite"
    Protected Const MODE_REMOVE_FROM_FAVORITES As String = "RemoveFavorite"
    Protected Const MODE_DELETE As String = "Delete"
    Protected Const MODE_SAVE As String = "Save"
    Protected Const MODE_CANCEL As String = "Cancel"
    Protected Const MODE_NEW As String = "New"

    Private Enum MenuIndex
        ADD_ATTACHMENT
        DELETE_ATTACHMENTS
        SAVE
        BACK
        HELP
    End Enum

    Private Const NUMBER_OF_MENUITEMS As Integer = 5
#End Region

#Region " Class scope Variables Declarations "
    Private m_blnViewAccess As Boolean = False
    Private m_blnAddAccess As Boolean = False
    Private m_blnEditAccess As Boolean = False
    Private m_blnDeleteAccess As Boolean = False
    'Menu
    Private m_blnFooter As Boolean = False
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_arrMenuItem(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrMenuTooltip(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrClientSideFunctions(NUMBER_OF_MENUITEMS - 1) As String

    'Generic Grid
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private m_intCount As Integer = 0

    'This variable is used to decide which help is suppose to be shown.
    Private m_blnHelpQSD As Boolean = False
    Protected m_strClientSideScript As String = ""
    Private m_strPageTitle As String = ""
    Private m_lngUserId As Long = 0
    Private m_lngPostId As Long = 0
    Protected m_strMode As String = ""
    Protected m_lngProcedureId As Long = 0
    Protected m_strWhatToShow As String = ""

    Protected m_lngPreviousId As Long = 0
    Protected m_strType As String = ""

    Private m_strData As String = ""
    Private m_strProcedureTitle As String = ""
    Private m_lngPlatformId As Long = 0
    Private m_lngCategoryId As Long = 0
    Private m_lngSubCategoryId As Long = 0
    Private m_lngProjectId As Long = 0
    Private m_strProcedurePreset As String = ""
    Private m_strProcedureAppliances As String = ""
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here


        m_lngUserId = CType("0" & Session.Item("intUserID").ToString(), Long)
        m_lngPostId = CType("0" & Session.Item("intPostID").ToString(), Long)
        m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE")
        m_strMode = "" & CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode")).Trim()
        m_lngProcedureId = CType("0" & CommonFunctions.General.CheckIsNothing(Request.QueryString("ProcedureID")), Long)
        m_strWhatToShow = "" & CommonFunctions.General.CheckIsNothing(Request.QueryString("WhatToShow")).Trim()
        If m_strWhatToShow = "" Then m_strWhatToShow = SHOW_DETAILS

        m_lngPreviousId = CType("0" & CommonFunctions.General.CheckIsNothing(Request.QueryString("PrevID")), Long)
        m_strType = "" & CommonFunctions.General.CheckIsNothing(Request.QueryString("Type")).Trim()
        Select Case m_strMode
            Case MODE_AUTHENTICATE
                Authenticate_Article()

            Case MODE_CLEAR_SEARCH
                Clear_Search()

            Case MODE_ADD_TO_FAVORITES
                Add_Article_To_Favorites()

            Case MODE_REMOVE_FROM_FAVORITES
                Remove_Article_From_Favorites()

            Case MODE_DELETE
                Delete_Article()

            Case MODE_SAVE
                Save_Article()
        End Select
    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objGrid = Nothing
        m_objMenu = Nothing
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        MyBase.InitializeResources("AppResources.KM_Display", "AppResources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "KM_Display : " & UserInput & " " & Cause
        Throw ex
    End Sub

    Private Sub InitPageMenu()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")


        'm_arrMenuItem(MenuIndex.ARTICLE_SUMMARY) = MyBase.GetResourceString("MENU_KM_ARTICLE_SUMMARY")
        'm_arrMenuTooltip(MenuIndex.ARTICLE_SUMMARY) = MyBase.GetResourceString("MENU_KM_ARTICLE_SUMMARY_TOOLTIP")
        'm_arrClientSideFunctions(MenuIndex.ARTICLE_SUMMARY) = "Details_OnClick()"

        'm_arrMenuItem(MenuIndex.CODE_OR_ARTICLE) = MyBase.GetResourceString("MENU_KM_CODE_ARTICLE")
        'm_arrMenuTooltip(MenuIndex.CODE_OR_ARTICLE) = MyBase.GetResourceString("MENU_KM_CODE_ARTICLE_TOOLTIP")
        'm_arrClientSideFunctions(MenuIndex.CODE_OR_ARTICLE) = "Code_OnClick()"

        'm_arrMenuItem(MenuIndex.EXAMPLE) = MyBase.GetResourceString("MENU_KM_EXAMPLE")
        'm_arrMenuTooltip(MenuIndex.EXAMPLE) = MyBase.GetResourceString("MENU_KM_EXAMPLE_TOOLTIP")
        'm_arrClientSideFunctions(MenuIndex.EXAMPLE) = "Example_OnClick()"

        'm_arrMenuItem(MenuIndex.COMMENTS) = MyBase.GetResourceString("MENU_KM_COMMENTS")
        'm_arrMenuTooltip(MenuIndex.COMMENTS) = MyBase.GetResourceString("MENU_KM_COMMENTS_TOOLTIP")
        'm_arrClientSideFunctions(MenuIndex.COMMENTS) = "Comment_OnClick()"

        'm_arrMenuItem(MenuIndex.ATTACHMENTS) = MyBase.GetResourceString("MENU_KM_ATTACHMENTS")
        'm_arrMenuTooltip(MenuIndex.ATTACHMENTS) = MyBase.GetResourceString("MENU_KM_ATTACHMENTS_TOOLTIP")
        'm_arrClientSideFunctions(MenuIndex.ATTACHMENTS) = "Attach_OnClick()"

        
        m_arrMenuItem(MenuIndex.ADD_ATTACHMENT) = MyBase.GetResourceString("MENU_KM_ADD_ATTACHMENT")
        m_arrMenuTooltip(MenuIndex.ADD_ATTACHMENT) = MyBase.GetResourceString("MENU_KM_ADD_ATTACHMENT_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.ADD_ATTACHMENT) = "AddAttachment_OnClick()"

        m_arrMenuItem(MenuIndex.DELETE_ATTACHMENTS) = MyBase.GetResourceString("MENU_KM_DELETE_ATTACHMENTS")
        m_arrMenuTooltip(MenuIndex.DELETE_ATTACHMENTS) = MyBase.GetResourceString("MENU_KM_DELETE_ATTACHMENTS_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.DELETE_ATTACHMENTS) = "DeleteAttachments_OnClick()"

        m_arrMenuItem(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE")
        m_arrMenuTooltip(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SAVE) = "Save_OnClick()"

        m_arrMenuItem(MenuIndex.BACK) = MyBase.GetResourceString("MENU_BACK")
        m_arrMenuTooltip(MenuIndex.BACK) = MyBase.GetResourceString("MENU_BACK_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.BACK) = "Back_OnClick()"

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick()"


        MyBase.InitializeResources("AppResources.KM_Display", "AppResources")

        CommonFunction.General.WriteHTML("<TABLE id='tblCap00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTableNavLinks><TR class=clsTRNavLinks valign=middle>")
        'CommonFunction.General.WriteHTML("<TD align=Left>Product Features</TD>")

        CommonFunction.General.WriteHTML("<td  nowrap align=Left>")
        'if mstrfromwhere="
        If m_strWhatToShow = SHOW_DETAILS Then
            Response.Write("<a class=menuclsselected href='javascript:Details_OnClick()'>")
            Response.Write(CommonFunction.General.FormatString(Server.HtmlEncode("Article Summary")))

        Else
            Response.Write("<a class=menunavtab href='javascript:Details_OnClick()'>")
            Response.Write(CommonFunction.General.FormatString(Server.HtmlEncode("Article Summary    ")))

        End If

        Response.Write("&nbsp;&nbsp;&nbsp;&nbsp;")
        Response.Write("</a>")

        If m_strWhatToShow = SHOW_PROCEDURECODE Then
            Response.Write("<a class=menuclsselected href='javascript:Code_OnClick()'>")
            Response.Write(CommonFunction.General.FormatString(Server.HtmlEncode("Code Article        ")))

        Else
            Response.Write("<a class=menunavtab href='javascript:Code_OnClick()'>")
            Response.Write(CommonFunction.General.FormatString(Server.HtmlEncode("Code Article        ")))

        End If
        Response.Write("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        Response.Write("</a>")

        If m_strWhatToShow = SHOW_PROCEDUREEXAMPLE Then
            Response.Write("<a class=menuclsselected href='javascript:Example_OnClick'>")
            Response.Write(CommonFunction.General.FormatString(Server.HtmlEncode("Example              ")))

        Else
            Response.Write("<a class=menunavtab href='javascript:Example_OnClick()'>")
            Response.Write(CommonFunction.General.FormatString(Server.HtmlEncode("Example              ")))

        End If
        Response.Write("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        Response.Write("</a>")

        If m_strWhatToShow = SHOW_PROCEDURECOMMENT Then
            Response.Write("<a class=menuclsselected href='javascript:Comment_OnClick()'>")
            Response.Write(CommonFunction.General.FormatString(Server.HtmlEncode("Comments")))

        Else
            Response.Write("<a class=menunavtab href='javascript:Comment_OnClick()'>")
            Response.Write(CommonFunction.General.FormatString(Server.HtmlEncode("Comments")))

        End If
        Response.Write("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        Response.Write("</a>")

        If m_strWhatToShow = SHOW_ATTACHMENTS Then
            Response.Write("<a class=menuclsselected href='javascript:Attach_OnClick()'>")
            Response.Write(CommonFunction.General.FormatString(Server.HtmlEncode("Attachments")))

        Else
            Response.Write("<a class=menunavtab href='javascript:Attach_OnClick()'>")
            Response.Write(CommonFunction.General.FormatString(Server.HtmlEncode("Attachments")))

        End If

        Response.Write("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        Response.Write("</a>")



        CommonFunction.General.WriteHTML("</td></TR></Table>")



    End Sub

    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub

    Private Sub WritePageLegend()
        Dim arrLegends(0) As String
        Dim arrLegendImg(0) As String
        arrLegends(0) = "&nbsp;" & MyBase.GetResourceString("MANDATORY")
        arrLegendImg(0) = CommonFunctions.HTMLControls.DrawMandatoryImage(, True)
        CommonFunctions.General.WriteHTML(WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImg, arrLegends, True))
    End Sub

    Public Sub WritePage()
        Dim strHTML As String = ""

        InitPageMenu()

        If m_strMode = "" Or m_strMode = MODE_SAVE Or m_strMode = MODE_NEW Then
            GetArticleInformation()
            If m_lngProcedureId > 0 Then GetAccessRights()

            If m_lngProcedureId <> 0 And m_blnEditAccess = False Then
                strHTML &= "<DIV ID=divList style='OVERFLOW:auto;HEIGHT:260;WIDTH:100%'>"
                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

                strHTML &= "<TABLE id=tblHeader cellSpacing=0 width='99.9%' class=clsTable>"
                strHTML &= "<TR class='clsTREven'>"
                strHTML &= "<TD align=center height=50 valign=center>" & MyBase.GetResourceString("NOT_AUTHORIZED") & "</TD>"
                strHTML &= "</TR>"
                strHTML &= "</TABLE>"
                strHTML &= "</DIV>"
                CommonFunctions.General.WriteHTML(strHTML)
            Else
                'Display the Menu at Header
                CommonFunctions.General.WriteHTML(m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True))

                'Display The Legend 
                WritePageLegend()
                CommonFunctions.General.WriteHTML("<br>")

                CommonFunctions.General.WriteHTML("<DIV ID=divList style='OVERFLOW:auto;width:100%'>")

                If m_strWhatToShow = SHOW_ATTACHMENTS Then
                    Display_Attachments()
                ElseIf m_strWhatToShow <> SHOW_DETAILS Then
                    strHTML &= "<TABLE class='clsTable' width='99.9%' height='100%'><TR class='clsTREven'><TD>"
                    'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                    ''  strHTML &= CommonFunctions.HTMLControls.DrawTextArea("txtCode", "txtCode", Style:="width:100%;height:100%", value:=m_strData, returnHTML:=True)
                    strHTML &= CommonFunctions.HTMLControls.DrawTextArea("txtCode", "txtCode", style:="width:100%;height:100%", value:=m_strData, returnHTML:=True, EnableHTMLEncode:=True)
                    'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                    strHTML &= "</TD></TR></TABLE>"
                    CommonFunctions.General.WriteHTML(strHTML)
                Else
                    Display_Article_Details()
                End If
                CommonFunctions.General.WriteHTML("</DIV>")
                CommonFunctions.General.WriteHTML("<br>")

                'Display the Menu at footer
                m_objMenu = Nothing
                m_blnFooter = True
                m_objMenu = New WebPages.Template.StaticMenu
                CommonFunctions.General.WriteHTML(m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True))
            End If
        End If
    End Sub

    Private Sub Display_Attachments()
        Dim lngAttachmentId As Long = 0
        Dim strURL As String = ""
        'Grid Related Fields
        Dim strQuery As String
        Dim arrDataColumn() As String = {"", "OriginalFileName", ""}
        Dim arrColumnHeader() As String = {MyBase.GetResourceString("SEARIAL_NO"), MyBase.GetResourceString("ATTACHMENT"), MyBase.GetResourceString("DELETE")}
        Dim arrCheckBoxId() As String = {"", "", "chkDelete"}
        Dim arrColumnLink() As String = {"", "Show_File(AttachmentID)", ""}
        Dim arrTDStyle() As String = {"Width='20%'", "align='left'", "Width='20%' align='center'"}
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        ' If the attachments are to be deleted, then...
        If "" & Request.QueryString("Action") = ACTION_DELETE Then
            Delete_Attachments()
        End If

        lngAttachmentId = CType("0" & CommonFunctions.General.CheckIsNothing(Request.QueryString("AttachmentID")), Long)
        ' Purpose : to retain original file name for every attachment
        If lngAttachmentId <> 0 Then
            strURL = CommonFunction.General.funcReturnOriginalFileName("KM", lngAttachmentId)
            If strURL <> "" Then
                m_strClientSideScript = "window.open('../General/ViewAttachment.aspx?FileName=" & strURL & "&FromWhere=KM' ,'_new','resizable=yes,menubar=yes,scrollbars=yes');"
            End If
        End If

        'Display Page Caption
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(Nothing, MyBase.GetResourceString("ATTACHMENTS"), , , True))
        CommonFunctions.General.WriteHTML("<br>")

        'Display the Attachments List
        strQuery = "usp_Sel_tbl_KM_Attachments " & m_lngProcedureId.ToString()

        m_intCount = 0
        'Set Grid Peroperties
        With m_objGrid
            .UserFriendlyColumnArray = arrColumnHeader
            .ActualColumnArray = arrDataColumn
            .CheckBoxIDArray = arrCheckBoxId
            .TDStyleArray = arrTDStyle
            .RowLinkArray = arrColumnLink
            .NoOfDataColumns = 2
            .PrimaryKey = "AttachmentID"
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .returnHTML = True
            .EmptyValueReplacement = "&nbsp;"
            'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHtml
            'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
    End Sub

    Private Sub Display_Article_Details()

        Dim strHTML As String = ""
        Dim strQuery As String = ""
        Dim intArticleType As Integer
        Dim strRelation As String = ""
        Dim blnChecked As Boolean = False
        Dim blnDisabled As Boolean = False
        'Dim objGate As CommonEngines.HashTables.Gates = CommonEngines.HashTables.Gates.GetGetsHashTableObject("")

        If m_lngPostId = CommonFunctions.Constants.ROLE_ADMINISTRATOR Then
            intArticleType = CType("0" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("optArticleType")), Integer)
            If intArticleType = 0 Then
                If m_strType = TYPE_QSD Then
                    intArticleType = 2
                Else
                    intArticleType = 1
                End If
            End If
        Else
            intArticleType = 1
        End If

        If m_strMode = MODE_NEW Then
            strRelation = RELATION_SIBLING
        Else
            strRelation = RELATION_CHILD
        End If

        strHTML &= "<TABLE class='clsTable' cellspacing=0 cellpadding=0 width='99.9%' height='100%'>"
        If m_strMode = MODE_NEW Then
            strHTML &= "<tr class='clsTREven' >"
            strHTML &= "<td colspan=2 align='center'>"
            If m_lngPostId <> CommonFunctions.Constants.ROLE_ADMINISTRATOR Then blnDisabled = True
            If intArticleType = 1 Then blnChecked = True
            strHTML &= CommonFunctions.HTMLControls.DrawOptionButton("optArticleType", "optKnowledgeArticle", , blnChecked, "1", blnDisabled, "onclick='KnowledgeArticle_OnClick()'", True)
            strHTML &= MyBase.GetResourceString("KNOWLEDGE_ARTICLE") & "&nbsp;&nbsp;&nbsp;&nbsp;"
            blnChecked = False
            If intArticleType = 2 Then
                blnChecked = True
                m_blnHelpQSD = True
            End If
            strHTML &= CommonFunctions.HTMLControls.DrawOptionButton("optArticleType", "optQSDArticle", , blnChecked, "2", blnDisabled, "onclick='QSDArticle_OnClick()'", True)
            strHTML &= MyBase.GetResourceString("QS_BOK_ARTICLE")
            strHTML &= "</td>"
            strHTML &= "</tr>"

        End If

        'Title Row
        strHTML &= "<tr class='clsTREven' >"
        strHTML &= "<td width='30%' align='right'>" & MyBase.GetResourceString("TITLE") & "</td>"
        strHTML &= "<td>"
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        'strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtProcedureTitle", "txtProcedureTitle", , , 100, m_strProcedureTitle, Style:="width:95%", returnHTML:=True, IsMandatory:=True)
        'strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtDummyField", "txtDummyField", , 0, , "", Style:="height:0; width:0", returnHTML:=True)
        strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtProcedureTitle", "txtProcedureTitle", , , 100, m_strProcedureTitle, style:="width:95%", returnHTML:=True, IsMandatory:=True, EnableHTMLEncode:=True)
        strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtDummyField", "txtDummyField", , 0, , "", style:="height:0; width:0", returnHTML:=True, EnableHTMLEncode:=True)

        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        strHTML &= "</td>"
        strHTML &= "</tr>"


        'Category and Sub Category
        ''strHTML &= "<tr id=rowCategory style='"
        ''If intArticleType = 1 Then
        ''    strHTML &= "visibility:visible;display:block"
        ''Else
        ''    strHTML &= "visibility:hidden;display:none"
        ''End If
        ''strHTML &= "'>"
        'Category
        strHTML &= "<tr class='clsTREven' >"
        strHTML &= "<td align='right'>" & MyBase.GetResourceString("CATEGORY") & "</td>"
        strHTML &= "<td>"
        strQuery = "usp_Sel_tbl_KM_Categories"
        strHTML &= CommonFunctions.HTMLControls.DrawComboBox("cboCategory", strQuery, 200, m_lngPlatformId.ToString(), , True, True, , True)
        strHTML &= "</td>"
        strHTML &= "</tr>"

        'Sub Category
        strHTML &= "<tr class='clsTREven' >"
        strHTML &= "<td align='right'>" & MyBase.GetResourceString("SUBCATEGORY") & "</td>"
        strHTML &= "<td>"
        strQuery = "Exec usp_Sel_tbl_KM_SubCategories"
        strHTML &= CommonFunctions.HTMLControls.DrawComboBox("cboSubCategory", strQuery, 200, m_lngSubCategoryId.ToString(), , True, True)
        strHTML &= "</td>"
        strHTML &= "</tr>"
        strHTML &= "</tbody>"

        'Template
        strHTML &= "<tr id=rowTemplate class='clsTREven' style='"
        If intArticleType = 2 Then
            strHTML &= "visibility:visible;display:block"
        Else
            strHTML &= "visibility:hidden;display:none"
        End If
        strHTML &= "'>"
        If m_strMode = MODE_NEW Then
            strHTML &= "<td align='right' valign='top'>" & MyBase.GetResourceString("CHOOSE_TEMPLATE") & "</td>"
            strHTML &= "<td>"
            strQuery = "Exec usp_Sel_tbl_KM_QSDTemplates"
            strHTML &= CommonFunctions.HTMLControls.DrawComboBox("cboTemplate", strQuery, 200, m_lngPreviousId.ToString(), , True, True, , True)
            strHTML &= "<br><br>"
            If strRelation = RELATION_SIBLING Then blnChecked = True
            strHTML &= CommonFunctions.HTMLControls.DrawOptionButton("optRelation", "optSibling", , blnChecked, RELATION_SIBLING, , , True)
            strHTML &= MyBase.GetResourceString("ADD_AS_NEW_SIBLING") & "&nbsp;&nbsp;&nbsp;&nbsp;"
            blnChecked = False
            If strRelation = RELATION_CHILD Then blnChecked = True
            strHTML &= CommonFunctions.HTMLControls.DrawOptionButton("optRelation", "optChild", , blnChecked, RELATION_CHILD, , , True)
            strHTML &= MyBase.GetResourceString("ADD_AS_NEW_CHILD")
            strHTML &= "</td>"
        Else
            strHTML &= "<td align='right'>" & MyBase.GetResourceString("TEMPLATE_NAME") & "</td>"
            strHTML &= "<td>"
            strQuery = "Exec usp_Sel_tbl_KM_QSDTemplates"
            strHTML &= CommonFunctions.HTMLControls.DrawComboBox("cboTemplate", strQuery, 200, m_lngProcedureId.ToString(), "disabled", True, True)
            strHTML &= "</td>"
        End If
        strHTML &= "</tr>"


        'Prerequisites
        strHTML &= "<tr class='clsTREven'>"
        strHTML &= "<td valign='top' align='right'>" & MyBase.GetResourceString("PREREQUISITES") & "<br>(" & MyBase.GetResourceString("IF_ANY") & ")</td>"
        strHTML &= "<td>"
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        '' strHTML &= CommonFunctions.HTMLControls.DrawTextArea("txtBeforeImplement", "txtBeforeImplement", Style:="height:100%;width:100%", value:=m_strProcedurePreset, returnHTML:=True)
        strHTML &= CommonFunctions.HTMLControls.DrawTextArea("txtBeforeImplement", "txtBeforeImplement", style:="height:100%;width:100%", value:=m_strProcedurePreset, returnHTML:=True, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        strHTML &= "</td>"
        strHTML &= "</tr>"


        'Procedure Appliences
        strHTML &= "<tr class='clsTREven'>"
        strHTML &= "<td valign='top' align='right'>" & MyBase.GetResourceString("WHERE_ARTICLE_APPLIED") & "</td>"
        strHTML &= "<td>"
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''strHTML &= CommonFunctions.HTMLControls.DrawTextArea("txtCodeAppliance", "txtCodeAppliance", Style:="height:100%;width:100%", value:=m_strProcedureAppliances, returnHTML:=True)
        strHTML &= CommonFunctions.HTMLControls.DrawTextArea("txtCodeAppliance", "txtCodeAppliance", style:="height:100%;width:100%", value:=m_strProcedureAppliances, returnHTML:=True, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        strHTML &= "</td>"
        strHTML &= "</tr>"


        'Project
        strHTML &= "<tr class='clsTREven' >"
        strHTML &= "<td align='right'>" & "Product " & "</td>"
        strHTML &= "<td>"
        strQuery = "Select ProductID,Product from tbl_PRD_Product order by product "
        strHTML &= CommonFunctions.HTMLControls.DrawComboBox("cboProduct", strQuery, 200, m_lngProjectId.ToString(), , True, True)
        strHTML &= "</td>"
        strHTML &= "</tr>"

        strHTML &= "</TABLE>"

        'Write the HTML
        CommonFunctions.General.WriteHTML(strHTML)
    End Sub

    Private Function GenerateKMTree() As String
        '=====================================================================
        ' Procedure Name		:	GenerateKMTree
        ' Parameters Passed		:	None
        ' Returns				:	The created file name.
        ' Parameters Affected	:	None
        ' Purpose				:	Generates the KM tree depending upon the tree type and browser type.
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Jayavant
        ' Created				:	23-Mar-2004
        '=====================================================================
        Dim strReturn As String = ""

        'If client browser is IE then generate the XML tree
        If CommonFunction.General.IsClientBrowserIE = True Then
            'check even though client browser is IE and application settings is set to HTML then
            'generate HTML
            If CommonFunction.General.GetApplicationKeySetting("KMTreeType").ToUpper = "HTML" Then
                'Call CommonFunctionsTree.GenerateTree.GenerateHTMLTreeForKM()
                Call CommonFunction.GenerateTree.GenerateHTMLTreeForKM()
                strReturn = "../../Reports/KMTree" & CType(Session("intUserID"), Long) & ".html"
            Else
                Call CommonFunction.GenerateTree.subGenerateXMLTreeForKM()
                strReturn = "../../Reports/KMTree" & CType(Session("intUserID"), Long) & ".xml"
            End If
        Else
            'Call CommonFunctionsTree.GenerateTree.GenerateHTMLTreeForKM()
            Call CommonFunction.GenerateTree.GenerateHTMLTreeForKM()
            strReturn = "../../Reports/KMTree" & CType(Session("intUserID"), Long) & ".html"
        End If

        Return strReturn
    End Function

#Region " Database realted procedures "
    Private Sub GetArticleInformation()
        Dim drCodeHeadings As IDataReader
        Dim strQuery As String = ""

        If m_strMode = MODE_NEW Then
            m_strData = ""
            m_strProcedureTitle = ""
            m_lngPlatformId = 0
            m_lngSubCategoryId = 0
            m_lngProjectId = 0
            m_strProcedureAppliances = ""
            m_strProcedurePreset = ""
        Else
            ' if procedure id is not passed then and if strmode is cancel then select all records from
            ' the database
            If m_lngProcedureId <> 0 And m_strMode <> MODE_CANCEL Then
                strQuery = "SELECT * From tbl_KM_CodeHeadings Where ProcedureID= " & m_lngProcedureId.ToString()
            Else
                strQuery = "SELECT * From tbl_KM_CodeHeadings Order By PlatFormID"
            End If
            drCodeHeadings = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drCodeHeadings) <> "" Then
                If drCodeHeadings.Read() Then
                    If m_strWhatToShow <> SHOW_DETAILS And m_strWhatToShow <> SHOW_ATTACHMENTS Then
                        m_strData = "" & CommonFunctions.General.CheckIsNothing(drCodeHeadings.Item(m_strWhatToShow))
                        m_strData = CommonFunctions.General.UnBuildQueryString(m_strData)
                    End If
                    m_strProcedureTitle = "" & CommonFunctions.General.CheckIsNothing(drCodeHeadings.Item("ProcedureTitle"))
                    m_strProcedureTitle = CommonFunctions.General.UnBuildQueryString(m_strProcedureTitle)
                    m_lngPlatformId = CType("0" & CommonFunctions.Data.CheckIsDBNull(drCodeHeadings.Item("PlatFormID"), "0").ToString(), Long)
                    m_lngSubCategoryId = CType("0" & CommonFunctions.Data.CheckIsDBNull(drCodeHeadings.Item("SubCategoryID"), "0").ToString(), Long)
                    m_lngProjectId = CType("0" & CommonFunctions.Data.CheckIsDBNull(drCodeHeadings.Item("ProjectID"), "0").ToString(), Long)
                    m_strProcedurePreset = "" & CommonFunctions.General.CheckIsNothing(drCodeHeadings.Item("ProcedurePreSet"))
                    m_strProcedurePreset = CommonFunctions.General.UnBuildQueryString(m_strProcedurePreset)
                    m_strProcedureAppliances = "" & CommonFunctions.General.CheckIsNothing(drCodeHeadings.Item("ProcedureAppliances"))
                    m_strProcedureAppliances = CommonFunctions.General.UnBuildQueryString(m_strProcedureAppliances)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drCodeHeadings)
        End If
    End Sub

    Private Sub Authenticate_Article()
        Dim strQuery As String = ""
        Dim strFileName As String = ""

        strQuery = "Exec usp_Upd_AuthenticateKMArticles " & m_lngPreviousId.ToString()
        strQuery &= ", " & m_lngUserId.ToString()
        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

        strFileName = GenerateKMTree()
        m_strClientSideScript = "	window.parent.frames(" & Chr(34) & "Main" & Chr(34) & ").document.location.href = " & Chr(34) & strFileName & Chr(34) & ";" & vbCrLf
        m_strClientSideScript &= "	window.location.href = " & Chr(34) & "KM_PlainTextDisplay.aspx?Type=" & TYPE_ARTICLE & "&ID=" & m_lngPreviousId.ToString() & Chr(34) & ";" & vbCrLf
    End Sub

    Private Sub Clear_Search()
        Dim strFileName As String = ""

        Session.Item("KM_Search_Query") = ""
        Session.Item("KM_Search_FreeText") = ""

        m_strClientSideScript = "if(isSubstringExists(window.parent.frames('Sub').document.location.href, 'KM_SearchResults.aspx') == true)" & vbCrLf
        m_strClientSideScript &= "  window.parent.frames('Sub').document.location.href = '../General/Introduction.aspx?FromWhere=KM';" & vbCrLf

        m_strClientSideScript &= "if(isSubstringExists(window.parent.frames('Sub').document.location.href, 'KM_PlainTextDisplay.aspx') == true){" & vbCrLf
        m_strClientSideScript &= "  var strPageName;" & vbCrLf
        m_strClientSideScript &= "  strPageName = window.parent.frames('Sub').document.location.href;" & vbCrLf
        m_strClientSideScript &= "  if(isSubstringExists(strPageName, 'Mode') == true)" & vbCrLf
        m_strClientSideScript &= "      strPageName = strPageName.substring(0, strPageName.indexOf('Mode')-1);" & vbCrLf
        m_strClientSideScript &= "  window.parent.frames('Sub').document.location.href = strPageName;" & vbCrLf
        m_strClientSideScript &= "}" & vbCrLf
        strFileName = GenerateKMTree()
        m_strClientSideScript &= "window.parent.frames(" & Chr(34) & "Main" & Chr(34) & ").document.location.href = " & Chr(34) & strFileName & Chr(34) & ";" & vbCrLf
    End Sub

    Private Sub Add_Article_To_Favorites()
        Dim strQuery As String = ""
        Dim strFileName As String = ""

        strQuery = "usp_Ins_tbl_KM_Bookmarks  " & m_lngProcedureId.ToString()
        strQuery &= ", " & m_lngUserId.ToString()
        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

        strFileName = GenerateKMTree()

        m_strClientSideScript = "	window.parent.frames(" & Chr(34) & "Main" & Chr(34) & ").document.location.href = " & Chr(34) & strFileName & Chr(34) & ";" & vbCrLf
        m_strClientSideScript &= "	window.location.href = " & Chr(34) & "KM_PlainTextDisplay.aspx?Type=" & m_strType & "&ID=" & m_lngPreviousId.ToString() & Chr(34) & ";" & vbCrLf
    End Sub

    Private Sub Remove_Article_From_Favorites()
        Dim strQuery As String = ""
        Dim strType As String = ""
        Dim strFileName As String = ""

        strQuery = "usp_Del_tbl_KM_BookMark " & m_lngUserId.ToString()
        strQuery &= ", " & m_lngProcedureId.ToString()
        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

        strFileName = GenerateKMTree()

        If m_strType = TYPE_FAVORITE Then
            strType = TYPE_ARTICLE
        Else
            strType = m_strType
        End If

        m_strClientSideScript = "	window.parent.frames(" & Chr(34) & "Main" & Chr(34) & ").document.location.href = " & Chr(34) & strFileName & Chr(34) & ";" & vbCrLf
        m_strClientSideScript &= "	window.location.href = " & Chr(34) & "KM_PlainTextDisplay.aspx?Type=" & strType & "&ID=" & m_lngPreviousId.ToString() & Chr(34) & ";" & vbCrLf
    End Sub

    Private Sub Delete_Article()
        Dim objFileSystem As New CommonFunctions.FileDirectory
        Dim drAttachment As IDataReader
        Dim strQuery As String = ""
        Dim strOriginalFileName As String = ""
        Dim strAttachments As String = ""
        Dim strFileName As String = ""
        Dim blnHasAttachments As Boolean = False

        strQuery = "Exec usp_Sel_tbl_KM_Attachments " & m_lngProcedureId.ToString()

        drAttachment = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drAttachment) <> "" Then
            While drAttachment.Read()
                blnHasAttachments = True
                strOriginalFileName = "" & drAttachment.Item("OriginalFileName").ToString().Trim()
                strOriginalFileName = CommonFunctions.General.UnBuildQueryString(strOriginalFileName)
                strAttachments = "" & drAttachment.Item("Attachments").ToString().Trim()
                strAttachments = CommonFunctions.General.UnBuildQueryString(strAttachments)

                If strOriginalFileName <> "" Then
                    strFileName = Server.MapPath("../../Attachments/KM/") & "\" & strOriginalFileName
                    If objFileSystem.IsFileExists(strFileName) Then
                        objFileSystem.DeleteFile(strFileName)
                    End If
                End If
                If strAttachments <> "" Then
                    strFileName = Server.MapPath("../../Attachments/KM/") & "\" & strAttachments
                    If objFileSystem.IsFileExists(strFileName) Then
                        objFileSystem.DeleteFile(strFileName)
                    End If
                End If
            End While

            If blnHasAttachments = True Then
                ' Build the query to delete the selected attachments in the database.
                strQuery = "Exec usp_Del_tbl_KM_Attachments " & m_lngProcedureId.ToString()
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drAttachment)

        ' delete query for the selected procedure
        strQuery = "usp_Del_tbl_KM_CodeHeadings_And_tbl_KM_BookMarks " & m_lngProcedureId.ToString()
        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        m_lngProcedureId = 0

        strFileName = GenerateKMTree()

        m_strClientSideScript = "	window.parent.frames(" & Chr(34) & "Main" & Chr(34) & ").document.location.href = " & Chr(34) & strFileName & Chr(34) & ";" & vbCrLf
        m_strClientSideScript &= "	window.parent.frames(" & Chr(34) & "Sub" & Chr(34) & ").document.location.href = " & Chr(34) & "../General/Introduction.aspx?FromWhere=KM" & Chr(34) & ";" & vbCrLf
    End Sub

    Private Sub Save_Article()
        Dim strQuery As String = ""
        Dim strCode As String = ""
        Dim intArticleTypeId As Integer = 0
        Dim lngParentId As Long = -1
        Dim strRelation As String = ""
        Dim drTemplate As IDataReader
        Dim strFileName As String = ""

        If m_lngProcedureId = 0 And m_strWhatToShow = SHOW_DETAILS Then
            m_strProcedureTitle = "" & MyBase.FixString(MyBase.GetFormValue("txtProcedureTitle"), 100, False, True)
            m_strProcedureTitle = CommonFunctions.General.UnBuildQueryString(m_strProcedureTitle)
            m_strProcedurePreset = "" & MyBase.FixString(MyBase.GetFormValue("txtBeforeImplement"), 0, False, False)
            m_strProcedurePreset = CommonFunctions.General.UnBuildQueryString(m_strProcedurePreset)
            m_strProcedureAppliances = "" & MyBase.FixString(MyBase.GetFormValue("txtCodeAppliance"), 0, False, False)
            m_strProcedureAppliances = CommonFunctions.General.UnBuildQueryString(m_strProcedureAppliances)
            m_lngCategoryId = CType("0" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboCategory")), Long)
            m_lngSubCategoryId = CType("0" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboSubCategory")), Long)
            m_lngProjectId = CType("0" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboProduct")), Long)
            intArticleTypeId = CType("0" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("optArticleType")), Integer)

            If intArticleTypeId = 2 Then
                m_lngCategoryId = 0
                m_lngSubCategoryId = 0
                strQuery = "Exec usp_Sel_KM_GetArticleDetails 1, " & CType("0" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboTemplate")), Integer)
                drTemplate = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                If CommonFunctions.General.CheckIsNothing(drTemplate) <> "" Then
                    If drTemplate.Read() Then
                        strRelation = "" & MyBase.FixString(MyBase.GetFormValue("optRelation"), 0, False, True)
                        If strRelation = RELATION_SIBLING Then
                            lngParentId = CType(CommonFunctions.Data.CheckIsDBNull(drTemplate.Item("ParentID"), "0"), Long)
                        ElseIf strRelation = RELATION_CHILD Then
                            lngParentId = CType(CommonFunctions.Data.CheckIsDBNull(drTemplate.Item("ProcedureID"), "0"), Long)
                        End If
                    End If
                End If
                CommonFunctions.Data.DisposeDataReader(drTemplate)
            End If

            strQuery = "DECLARE @pnProcedureID int" & vbCrLf
            strQuery &= "Exec usp_Ins_tbl_KM_CodeHeadings " & m_lngUserId.ToString()
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strProcedureTitle) & "'"
            If m_lngCategoryId = 0 Then
                strQuery &= ", NULL"
            Else
                strQuery &= ", " & m_lngCategoryId.ToString()
            End If
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(Left(m_strProcedurePreset, 3000)) & "'"
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(Left(m_strProcedureAppliances, 3000)) & "'"
            If m_lngProjectId = 0 Then
                strQuery &= ", NULL"
            Else
                strQuery &= ", " & m_lngProjectId.ToString()
            End If
            strQuery &= ", @pnProcedureID OUTPUT"
            strQuery &= ", " & intArticleTypeId.ToString()
            If lngParentId = -1 Then
                strQuery &= ", NULL"
            Else
                strQuery &= ", " & lngParentId.ToString()
            End If
            If m_lngSubCategoryId = 0 Then
                strQuery &= ", NULL"
            Else
                strQuery &= ", " & m_lngSubCategoryId.ToString()
            End If
            strQuery &= vbCrLf
            strQuery &= "SELECT 'ProcedureId' = @pnProcedureID" & vbCrLf
            m_lngProcedureId = CType("0" & CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL)), Long)

            strFileName = GenerateKMTree()

            m_strClientSideScript = "	window.parent.frames(" & Chr(34) & "Main" & Chr(34) & ").document.location.href = " & Chr(34) & strFileName & Chr(34) & ";" & vbCrLf
            If intArticleTypeId = 1 Then
                m_strClientSideScript &= "alert('" & MyBase.GetResourceString("THANK_YOU_MESSAGE") & "')" & vbCrLf
            End If

        ElseIf m_strWhatToShow = SHOW_DETAILS Then
            m_strProcedureTitle = "" & MyBase.FixString(MyBase.GetFormValue("txtProcedureTitle"), 100, False, True)
            m_strProcedureTitle = CommonFunctions.General.UnBuildQueryString(m_strProcedureTitle)
            m_strProcedurePreset = "" & MyBase.FixString(MyBase.GetFormValue("txtBeforeImplement"), 0, False, False)
            m_strProcedurePreset = CommonFunctions.General.UnBuildQueryString(m_strProcedurePreset)
            m_strProcedureAppliances = "" & MyBase.FixString(MyBase.GetFormValue("txtCodeAppliance"), 0, False, False)
            m_strProcedureAppliances = CommonFunctions.General.UnBuildQueryString(m_strProcedureAppliances)
            m_lngCategoryId = CType("0" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboCategory")), Long)
            m_lngSubCategoryId = CType("0" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboSubCategory")), Long)
            m_lngProjectId = CType("0" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboProduct")), Long)

            strQuery = "usp_Upd_tbl_KM_CodeHeadings '" & CommonFunctions.General.BuildQueryString(m_strProcedureTitle) & "' "
            If m_lngCategoryId = 0 Then
                strQuery &= ", NULL"
            Else
                strQuery &= ", " & m_lngCategoryId.ToString()
            End If
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(Left(m_strProcedurePreset, 3000)) & "'"
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(Left(m_strProcedureAppliances, 3000)) & "'"
            If m_lngProjectId = 0 Then
                strQuery &= ", NULL"
            Else
                strQuery &= ", " & m_lngProjectId.ToString()
            End If
            strQuery &= ", " & m_lngProcedureId.ToString()
            If m_lngSubCategoryId = 0 Then
                strQuery &= ", NULL"
            Else
                strQuery &= ", " & m_lngSubCategoryId.ToString()
            End If
            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        End If

        If m_lngProcedureId <> 0 Then
            strCode = "" & MyBase.FixString(MyBase.GetFormValue("txtCode"), 0, False, False)
            strCode = CommonFunctions.General.UnBuildQueryString(strCode)
            Select Case m_strWhatToShow
                Case SHOW_PROCEDURECODE
                    strQuery = "usp_Upd_tbl_KM_CodeHeadingsForDCC 'ProcedureCode', " & m_lngProcedureId.ToString()
                    strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strCode) & "'"
                    CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

                Case SHOW_PROCEDURECOMMENT
                    strQuery = "usp_Upd_tbl_KM_CodeHeadingsForDCC 'ProcedureComment', " & m_lngProcedureId.ToString()
                    strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strCode) & "'"
                    CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

                Case SHOW_PROCEDUREEXAMPLE
                    strQuery = "usp_Upd_tbl_KM_CodeHeadingsForDCC 'ProcedureExample', " & m_lngProcedureId.ToString()
                    strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strCode) & "'"
                    CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            End Select
        End If
    End Sub

    Private Sub GetAccessRights()
        Dim drAccessRights As IDataReader
        Dim strQuery As String = ""

        strQuery = "Exec usp_Sel_KM_GetAuthorizationInformation " & m_lngProcedureId.ToString()
        strQuery &= ", " & m_lngUserId.ToString()
        drAccessRights = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drAccessRights) <> "" Then
            If drAccessRights.Read() Then
                m_blnViewAccess = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("ViewAccess"), "False"), Boolean)
                m_blnAddAccess = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("AddAccess"), "False"), Boolean)
                m_blnEditAccess = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("EditAccess"), "False"), Boolean)
                m_blnDeleteAccess = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("DeleteAccess"), "False"), Boolean)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drAccessRights)
    End Sub

    Private Sub Delete_Attachments()
        Dim objFileSystem As New CommonFunctions.FileDirectory
        Dim drAttachment As IDataReader
        Dim strQuery As String = ""
        Dim strAttachmentsIds As String = ""
        Dim arrAttachmentId() As String
        Dim intCnt As Integer
        Dim strOriginalFileName As String = ""
        Dim strAttachments As String = ""
        Dim strFileName As String = ""

        strAttachmentsIds = "" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkDelete"))
        If strAttachmentsIds <> "" Then
            arrAttachmentId = strAttachmentsIds.Split(CType(",", Char))
            For intCnt = 0 To arrAttachmentId.Length - 1
                strQuery = "Exec usp_Sel_tbl_KM_Attachments NULL, " & arrAttachmentId(intCnt)
                drAttachment = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                If CommonFunctions.General.CheckIsNothing(drAttachment) <> "" Then
                    If drAttachment.Read() Then
                        strOriginalFileName = "" & drAttachment.Item("OriginalFileName").ToString().Trim()
                        strOriginalFileName = CommonFunctions.General.UnBuildQueryString(strOriginalFileName)
                        strAttachments = "" & drAttachment.Item("Attachments").ToString().Trim()
                        strAttachments = CommonFunctions.General.UnBuildQueryString(strAttachments)
                    End If
                End If
                CommonFunctions.Data.DisposeDataReader(drAttachment)

                If strOriginalFileName <> "" Then
                    strFileName = Server.MapPath("../../Attachments/KM/") & "\" & strOriginalFileName
                    If objFileSystem.IsFileExists(strFileName) Then
                        objFileSystem.DeleteFile(strFileName)
                    End If
                End If
                If strAttachments <> "" Then
                    strFileName = Server.MapPath("../../Attachments/KM/") & "\" & strAttachments
                    If objFileSystem.IsFileExists(strFileName) Then
                        objFileSystem.DeleteFile(strFileName)
                    End If
                End If
            Next

            ' Build the query to delete the selected attachments in the database.
            strQuery = "Exec usp_Del_tbl_KM_Attachments NULL, '" & CommonFunctions.General.BuildQueryString(strAttachmentsIds) & "'"
            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        End If
    End Sub
#End Region

#Region " Event Handlers For Grid and Menu "
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If m_strWhatToShow = SHOW_ATTACHMENTS Then
            Select Case Args.ColIndex
                Case 0
                    m_intCount += 1
                    Args.DataFieldValue = m_intCount.ToString()

                Case 1
                    Dim strOriginalFileName As String = ""
                    Dim strDescription As String = ""

                    strOriginalFileName = "" & CommonFunctions.General.CheckIsNothing(Args.DataReader.Item("OriginalFileName")).Trim()
                    strOriginalFileName = CommonFunctions.General.UnBuildQueryString(strOriginalFileName)
                    strDescription = "" & CommonFunctions.General.CheckIsNothing(Args.DataReader.Item("Description")).Trim()
                    strDescription = CommonFunctions.General.UnBuildQueryString(strDescription)

                    If strOriginalFileName = "" Then
                        Args.DataFieldValue = strDescription
                    End If
            End Select
        End If
    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        If m_blnFooter = False Then
            If Args.LinkName = m_arrMenuItem(MenuIndex.HELP) Then
                If m_strType = TYPE_QSD Then
                    Args.FunctionName = "Help_OnClick('KM_QSD')"
                Else
                    If m_blnHelpQSD = True Then
                        Args.FunctionName = "Help_OnClick('KM_QSD')"
                    Else
                        Args.FunctionName = "Help_OnClick('KM')"
                    End If
                End If
            End If
        Else
            If Args.LinkName = m_arrMenuItem(MenuIndex.HELP) Then
                Cancel = True
                Return
            Else
                If m_strWhatToShow = SHOW_ATTACHMENTS Then
                    If Args.LinkName = m_arrMenuItem(MenuIndex.SAVE) Then Cancel = True
                    If Args.LinkName = m_arrMenuItem(MenuIndex.DELETE_ATTACHMENTS) And m_intCount = 0 Then Cancel = True
                Else
                    If Args.LinkName = m_arrMenuItem(MenuIndex.ADD_ATTACHMENT) Then Cancel = True
                    If Args.LinkName = m_arrMenuItem(MenuIndex.DELETE_ATTACHMENTS) Then Cancel = True
                End If
            End If
        End If

        If m_strWhatToShow <> SHOW_ATTACHMENTS Then
            If Args.LinkName = m_arrMenuItem(MenuIndex.ADD_ATTACHMENT) Or Args.LinkName = m_arrMenuItem(MenuIndex.DELETE_ATTACHMENTS) Then
                Cancel = True
            End If
        End If
    End Sub
#End Region

End Class
