Imports System.Text

Public Class KM_PlainTextDisplay
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
    Protected Const TYPE_LESSON As String = "Lesson"
    Private Const TYPE_UNAUTHENTICATED As String = "Unauthenticated"
    Private Const TYPE_QSD As String = "QSD"
    Private Const MODE_SHOWFILE As String = "ShowFile"

    Private Enum MenuIndex
        'Added by DipaliS
        RATE_ARTICLE
        'End of Addition
        PROBLEM_SUMMARY
        SOLUTION
        PREVENTIVE_ACTION
        REFERRED_DOCUMENT
        ARTICLE_SUMMARY
        CODE_ARTICLE
        EXAMPLE
        COMMENTS
        ATTACHMENTS
        LOCATE_IN_TREE
        SEARCHED_ARTICLES
        ADD_NEW
        EDIT
        DELETE
        AUTHENTICATE
        ADD_TO_FAVORITES
        REMOVE_FROM_FAVORITES
        AUTHENTICATION_RIGHTS
        HELP
        'Added by DipaliS
        HOME
        'End of Addition
    End Enum

    'Changed by Dipalis
    'Private Const NUMBER_OF_MENUITEMS As Integer = 19
    Private Const NUMBER_OF_MENUITEMS As Integer = 21
#End Region

#Region " Class scope Variables Declarations "
    Private m_blnViewAccess As Boolean = False
    Private m_blnAddAccess As Boolean = False
    Private m_blnEditAccess As Boolean = False
    Private m_blnDeleteAccess As Boolean = False

    'Menu
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_arrMenuItem(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrMenuTooltip(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrClientSideFunctions(NUMBER_OF_MENUITEMS - 1) As String

    Private m_lngUserId As Long = 0
    Private m_strPageTitle As String = ""
    Protected m_strType As String = ""
    Private m_strCompanyName As String = ""
    Private m_strProjectName As String = ""
    Private m_strTextToBeHighlighted As String = ""

    Protected m_strClientSideScript As String = ""

    'Article Related Variables (Lesson Type)
    Protected m_lngArticleId As Long = 0
    Private m_strSolution As String = ""
    Private m_strPreventiveAction As String = ""
    Private m_strReferredDocument As String = ""
    Private m_strProblemDescription As String = ""
    Private m_lngLessonId As Long = 0
    Private m_strProblemType As String = ""

    'Article Related Variables (Not Lesson Type)
    Private m_lngTypeId As Long = 0
    Private m_lngProcedureId As Long = 0
    Private m_strProcedureCode As String = ""
    Private m_strProcedureExample As String = ""
    Private m_strProcedureComments As String = ""
    Private m_strProcedureTitle As String = ""
    Private m_strProcedurePreSet As String = ""
    Private m_strProcedureAppliances As String = ""
    Private m_strEmployeeName As String = ""
    Private m_strEmailId As String = ""
    Private m_strDateCreated As String = ""
    Private m_strDescription As String = ""
    Private m_strAuthenticated As String = ""
    Private m_intFavorite As Integer = 0

    'Used to differentiate the Menu at header and footer. Used only when type is not Lesson
    Private m_blnFooter As Boolean = False
    'Used to show or not the attachments menu item
    Private m_blnHasAttachments As Boolean = False
    'Added by DipaliS
    Protected m_blnCustomize As Boolean
    Private m_intAvgRating As Integer
    Private m_intNoOfUsers As Integer
    Private m_intRateCount As Integer
    Private m_intArticleBy As Integer
    Private m_strArticleLevel As String

    'End of Addition
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim strURL As String = ""

        m_lngArticleId = CType("0" & CommonFunctions.General.CheckIsNothing(Request.QueryString("ID")), Long)

        'Added By DipaliS
        Dim objGates As CommonEngines.HashTables.Gates

        objGates = CommonEngines.HashTables.Gates.GetGetsHashTableObject("CSPL-KM-KCCS-01")
        If Not objGates Is Nothing Then
            m_blnCustomize = True
        End If

        objGates = Nothing
        If m_blnCustomize = True Then

            Dim strQuery As String
            'The value of this decides whether this article is rated by the user  or not
            Dim drResult As IDataReader
            Dim strKccsConn As String
            '0 represents not rated,
            '1 represents article is rated

            strKccsConn = CommonFunctions.General.GetApplicationKeySetting("KCCSConnectionString")
            'Check whether the user has already rate the article	
            strQuery = "Exec usp_KC_Sel_IsArticleRated_ByUser " & CType(Session("intUserID"), Integer) & "," & m_lngArticleId
            drResult = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL, strKccsConn)

            If drResult.Read Then
                If Not IsDBNull(drResult.Item("ArticleCount")) Then
                    m_intRateCount = CType(drResult.Item("ArticleCount"), Integer)
                Else
                    m_intRateCount = 0
                End If
            End If
            CommonFunction.Data.DisposeDataReader(drResult)

            'Get the avg article rating and number of users who have rated the article

            strQuery = "Exec usp_KC_Sel_GetAvgRating_ByUsers " & m_lngArticleId
            drResult = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL, strKccsConn)

            If drResult.Read Then
                If Not IsDBNull(drResult.Item("AvgRating")) Then
                    m_intAvgRating = CType(drResult.Item("AvgRating"), Integer)
                Else
                    m_intAvgRating = 0
                End If
                If Not IsDBNull(drResult.Item("NoOfUsers")) Then
                    m_intNoOfUsers = CType(drResult.Item("NoOfUsers"), Integer)
                Else
                    m_intNoOfUsers = 0
                End If
            End If
            CommonFunction.Data.DisposeDataReader(drResult)
            'Get the article level

            strQuery = "Exec usp_KC_Sel_GetArticleLevelDescription " & m_lngArticleId
            drResult = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL, strKccsConn)

            If drResult.Read Then
                If Not IsDBNull(drResult.Item("ArticleLevelDescription")) Then
                    m_strArticleLevel = CType(drResult.Item("ArticleLevelDescription"), String) & ""
                Else
                    m_strArticleLevel = ""
                End If
                If Not IsDBNull(drResult.Item("UserID")) Then
                    m_intArticleBy = CType(drResult.Item("UserID"), Integer)
                Else
                    m_intArticleBy = 0
                End If
            End If
            CommonFunction.Data.DisposeDataReader(drResult)

            strQuery = "Exec usp_KC_Ins_ArticleVisitCredits " & CType(Session("intUserID"), Integer) & "," & m_lngArticleId
            drResult = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL, strKccsConn)
            CommonFunction.Data.DisposeDataReader(drResult)

        End If
        'End of Addition

        InitPageMenu()

        m_lngUserId = CType("0" & CommonFunctions.General.CheckIsNothing(MyBase.Session.Item("intUserID")).ToString(), Long)
        m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE")
        m_strTextToBeHighlighted = "" & CommonFunctions.General.CheckIsNothing(MyBase.Session.Item("KM_Search_FreeText"))
        m_strType = CommonFunctions.General.CheckIsNothing(Request.QueryString("Type"))


        If "" & Request.QueryString("Mode") = MODE_SHOWFILE Then
            strURL = CommonFunction.General.funcReturnOriginalFileName("KM", CType("0" & CommonFunctions.General.CheckIsNothing(Request.QueryString("AttachmentID")), Long))
            If strURL <> "" Then
                m_strClientSideScript = "window.open('../General/ViewAttachment.aspx?FileName=" & strURL & "&FromWhere=KM' ,'_new','resizable=yes,menubar=yes,scrollbars=yes');"
            End If
        End If

    End Sub

    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        MyBase.InitializeResources("AppResources.KM_PlainTextDisplay", "AppResources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "KM_PlainTextDisplay : " & UserInput & " " & Cause
        Throw ex
    End Sub

    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub

    Private Sub InitPageMenu()
        '=====================================================================
        ' Procedure Name        : InitPageMenu
        ' Purpose               : This procedure initiates the arrays required to Draw the Menu
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Jayavant
        ' Created               : 2-Mar-2004
        ' Revisions             :
        '=====================================================================

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        m_arrMenuItem(MenuIndex.PROBLEM_SUMMARY) = MyBase.GetResourceString("MENU_KM_PROBLEM_SUMMARY")
        m_arrMenuTooltip(MenuIndex.PROBLEM_SUMMARY) = MyBase.GetResourceString("MENU_KM_PROBLEM_SUMMARY_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.PROBLEM_SUMMARY) = "MenuLink_OnClick('#Summary')"

        m_arrMenuItem(MenuIndex.SOLUTION) = MyBase.GetResourceString("MENU_KM_SOLUTION")
        m_arrMenuTooltip(MenuIndex.SOLUTION) = MyBase.GetResourceString("MENU_KM_SOLUTION_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SOLUTION) = "MenuLink_OnClick('#Solution')"

        m_arrMenuItem(MenuIndex.PREVENTIVE_ACTION) = MyBase.GetResourceString("MENU_KM_PREVENTIVE_ACTION")
        m_arrMenuTooltip(MenuIndex.PREVENTIVE_ACTION) = MyBase.GetResourceString("MENU_KM_PREVENTIVE_ACTION_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.PREVENTIVE_ACTION) = "MenuLink_OnClick('#PreventiveAction')"

        m_arrMenuItem(MenuIndex.REFERRED_DOCUMENT) = MyBase.GetResourceString("MENU_KM_REFERRED_DOCUMENT")
        m_arrMenuTooltip(MenuIndex.REFERRED_DOCUMENT) = MyBase.GetResourceString("MENU_KM_REFERRED_DOCUMENT_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.REFERRED_DOCUMENT) = "MenuLink_OnClick('#ReferredDocument')"

        m_arrMenuItem(MenuIndex.ARTICLE_SUMMARY) = MyBase.GetResourceString("MENU_KM_ARTICLE_SUMMARY")
        m_arrMenuTooltip(MenuIndex.ARTICLE_SUMMARY) = MyBase.GetResourceString("MENU_KM_ARTICLE_SUMMARY_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.ARTICLE_SUMMARY) = "MenuLink_OnClick('#Summary')"

        m_arrMenuItem(MenuIndex.CODE_ARTICLE) = MyBase.GetResourceString("MENU_KM_CODE_ARTICLE")
        m_arrMenuTooltip(MenuIndex.CODE_ARTICLE) = MyBase.GetResourceString("MENU_KM_CODE_ARTICLE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CODE_ARTICLE) = "MenuLink_OnClick('#Code')"

        m_arrMenuItem(MenuIndex.EXAMPLE) = MyBase.GetResourceString("MENU_KM_EXAMPLE")
        m_arrMenuTooltip(MenuIndex.EXAMPLE) = MyBase.GetResourceString("MENU_KM_EXAMPLE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.EXAMPLE) = "MenuLink_OnClick('#Example')"

        m_arrMenuItem(MenuIndex.COMMENTS) = MyBase.GetResourceString("MENU_KM_COMMENTS")
        m_arrMenuTooltip(MenuIndex.COMMENTS) = MyBase.GetResourceString("MENU_KM_COMMENTS_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.COMMENTS) = "MenuLink_OnClick('#Comments')"

        m_arrMenuItem(MenuIndex.ATTACHMENTS) = MyBase.GetResourceString("MENU_KM_ATTACHMENTS")
        m_arrMenuTooltip(MenuIndex.ATTACHMENTS) = MyBase.GetResourceString("MENU_KM_ATTACHMENTS_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.ATTACHMENTS) = "MenuLink_OnClick('#Attachments')"

        m_arrMenuItem(MenuIndex.LOCATE_IN_TREE) = MyBase.GetResourceString("MENU_KM_LOCATE_IN_TREE")
        m_arrMenuTooltip(MenuIndex.LOCATE_IN_TREE) = MyBase.GetResourceString("MENU_KM_LOCATE_IN_TREE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.LOCATE_IN_TREE) = "SynchronizeTOC()"

        m_arrMenuItem(MenuIndex.SEARCHED_ARTICLES) = MyBase.GetResourceString("MENU_KM_SEARCHED_ARTICLES")
        m_arrMenuTooltip(MenuIndex.SEARCHED_ARTICLES) = MyBase.GetResourceString("MENU_KM_SEARCHED_ARTICLES_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SEARCHED_ARTICLES) = "Back_OnClick()"

        m_arrMenuItem(MenuIndex.ADD_NEW) = MyBase.GetResourceString("MENU_ADDNEW")
        m_arrMenuTooltip(MenuIndex.ADD_NEW) = MyBase.GetResourceString("MENU_ADDNEW_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.ADD_NEW) = "New_OnClick()"

        m_arrMenuItem(MenuIndex.EDIT) = MyBase.GetResourceString("MENU_KM_EDIT")
        m_arrMenuTooltip(MenuIndex.EDIT) = MyBase.GetResourceString("MENU_KM_EDIT_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.EDIT) = "Edit_OnClick()"

        m_arrMenuItem(MenuIndex.DELETE) = MyBase.GetResourceString("MENU_DELETE")
        m_arrMenuTooltip(MenuIndex.DELETE) = MyBase.GetResourceString("MENU_DELETE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.DELETE) = "Delete_OnClick()"

        m_arrMenuItem(MenuIndex.AUTHENTICATE) = MyBase.GetResourceString("MENU_AUTHENTICATE")
        m_arrMenuTooltip(MenuIndex.AUTHENTICATE) = MyBase.GetResourceString("MENU_AUTHENTICATE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.AUTHENTICATE) = "Authenticate_OnClick()"

        m_arrMenuItem(MenuIndex.ADD_TO_FAVORITES) = MyBase.GetResourceString("MENU_KM_ADD_TO_FAVORITES")
        m_arrMenuTooltip(MenuIndex.ADD_TO_FAVORITES) = MyBase.GetResourceString("MENU_KM_ADD_TO_FAVORITES_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.ADD_TO_FAVORITES) = "AddToFavorite_Onclick()"

        m_arrMenuItem(MenuIndex.REMOVE_FROM_FAVORITES) = MyBase.GetResourceString("MENU_KM_REMOVE_FROM_FAVORITES")
        m_arrMenuTooltip(MenuIndex.REMOVE_FROM_FAVORITES) = MyBase.GetResourceString("MENU_KM_REMOVE_FROM_FAVORITES_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.REMOVE_FROM_FAVORITES) = "RemoveFavorite_OnClick()"

        m_arrMenuItem(MenuIndex.AUTHENTICATION_RIGHTS) = MyBase.GetResourceString("MENU_KM_AUTHENTICATION_RIGHTS")
        m_arrMenuTooltip(MenuIndex.AUTHENTICATION_RIGHTS) = MyBase.GetResourceString("MENU_KM_AUTHENTICATION_RIGHTS_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.AUTHENTICATION_RIGHTS) = "Rights_OnClick()"

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick('KM')"

        MyBase.InitializeResources("AppResources.KM_PlainTextDisplay", "AppResources")
        'Added by DipaliS
        m_arrMenuItem(MenuIndex.RATE_ARTICLE) = MyBase.GetResourceString("RATE_ARTICLE")
        m_arrMenuTooltip(MenuIndex.RATE_ARTICLE) = MyBase.GetResourceString("RATE_ARTICLE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.RATE_ARTICLE) = "RateArticle_OnClick(" & m_lngArticleId & ")"

        m_arrMenuItem(MenuIndex.HOME) = MyBase.GetResourceString("HOME")
        m_arrMenuTooltip(MenuIndex.HOME) = MyBase.GetResourceString("HOME_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.HOME) = "Home_OnClick()"
        'End of Addition

    End Sub

    Public Sub WritePage()
        'Get AccessRights, the company name and Article Details from the database
        GetAccessRights()
        GetCompanyName()
        GetArticleDetails()

        If m_strType = TYPE_LESSON Then
            WritePage_Lesson()
        Else
            WritePage_Article()
        End If
    End Sub

    Private Sub WritePage_Lesson()
        Dim strTemp As String = ""
        Dim strLeftCaption As String = ""
        Dim strRightCaption As String = ""

        Dim sbHTML As New StringBuilder("")

        'Display the Menu
        CommonFunctions.General.WriteHTML(m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True))
        CommonFunctions.General.WriteHTML("<br>")

        'Display Page Caption
        strLeftCaption = Left(m_strProblemDescription, 40)
        If Len(strLeftCaption) = 40 Then strLeftCaption &= "..."
        strRightCaption = "[" & MyBase.GetResourceString("LESSON_ID") & " : " & m_lngLessonId.ToString() & "]"
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(Nothing, strLeftCaption, strRightCaption, , True))

        'Prepare the Page Body HTML string
        sbHTML.Append("<DIV id='divList' name='divList' class=clsDivKM style='OVERFLOW:auto;HEIGHT:260;WIDTH:100%'>")
        sbHTML.Append("<BR>")

        'Problem Summary
        sbHTML.Append("<H5><A name='Summary'>" & MyBase.GetResourceString("PROBLEM_SUMMARY") & "</A></H5>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        sbHTML.Append("<TABLE CellSpacing=0 width='99.9%' style='FONT-FAMILY: Verdana, Arial;FONT-SIZE: 8pt;'>")
        If m_strProjectName <> "" Then
            sbHTML.Append("<TR>")
            sbHTML.Append("<TD valign=top>" & MyBase.GetResourceString("PROJECT_NAME") & "</TD>")
            sbHTML.Append("<TD valign=top>:</TD>")
            sbHTML.Append("<TD valign=top><B>" & Server.HtmlEncode(m_strProjectName) & "</B></TD>")
            sbHTML.Append("</TR>")
        End If
        If m_strProblemType <> "" Then
            sbHTML.Append("<TR>")
            sbHTML.Append("<TD valign=top>" & MyBase.GetResourceString("PROBLEM_TYPE") & "</TD>")
            sbHTML.Append("<TD valign=top>:</TD>")
            sbHTML.Append("<TD valign=top><B>" & Server.HtmlEncode(m_strProblemType) & "</B></TD>")
            sbHTML.Append("</TR>")
        End If
        If m_strProblemDescription <> "" Then
            sbHTML.Append("<TR>")
            sbHTML.Append("<TD valign=top>" & MyBase.GetResourceString("PROBLEM_DESCRIPTION") & "</TD>")
            sbHTML.Append("<TD valign=top>:</TD>")
            sbHTML.Append("<TD valign=top><PRE>" & Server.HtmlEncode(m_strProblemDescription) & "</PRE></TD>")
            sbHTML.Append("</TR>")
        End If
        sbHTML.Append("</TABLE>")
        sbHTML.Append("<HR style='color:#99CCFF' size=1pt>")

        'Solution
        If m_strSolution <> "" Then
            sbHTML.Append("<H5><A name='Solution'>" & MyBase.GetResourceString("SOLUTION") & "</A></H5>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            sbHTML.Append("<TABLE CellSpacing=0 width='99.9%' style='FONT-FAMILY: Verdana, Arial;FONT-SIZE: 8pt;'>")
            sbHTML.Append("<TR>")
            sbHTML.Append("<TD valign=top><PRE>" & Server.HtmlEncode(m_strSolution) & "</PRE></TD>")
            sbHTML.Append("</TR>")
            sbHTML.Append("</TABLE>")
            sbHTML.Append("<HR style='color:#99CCFF' size=1pt>")
        End If

        'Preventive Action
        If m_strPreventiveAction <> "" Then
            sbHTML.Append("<H5><A name='PreventiveAction'>" & MyBase.GetResourceString("PREVENTIVE_ACTION") & "</A></H5>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            sbHTML.Append("<TABLE CellSpacing=0 width='99.9%' style='FONT-FAMILY: Verdana, Arial;FONT-SIZE: 8pt;'>")
            sbHTML.Append("<TR>")
            sbHTML.Append("<TD valign=top><PRE>" & Server.HtmlEncode(m_strPreventiveAction) & "</PRE></TD>")
            sbHTML.Append("</TR>")
            sbHTML.Append("</TABLE>")
            sbHTML.Append("<HR style='color:#99CCFF' size=1pt>")
        End If

        'Referred Document
        If m_strReferredDocument <> "" Then
            sbHTML.Append("<H5><A name='ReferredDocument'>" & MyBase.GetResourceString("REDERRED_DOCUMENT") & "</A></H5>")
            sbHTML.Append("<TABLE CellSpacing=0 width='99.9%' style='FONT-FAMILY: Verdana, Arial;FONT-SIZE: 8pt;'>")
            sbHTML.Append("<TR>")
            sbHTML.Append("<TD valign=top><PRE>" & Server.HtmlEncode(m_strReferredDocument) & "</PRE></TD>")
            sbHTML.Append("</TR>")
            sbHTML.Append("</TABLE>")
            sbHTML.Append("<HR style='color:#99CCFF' size=1pt>")
        End If

        'Copyright Warning
        sbHTML.Append("<H6>")
        strTemp = MyBase.GetResourceString("COPYRIGHT")
        strTemp = Replace(strTemp, "<=>", Year(Now).ToString())
        strTemp = Replace(strTemp, "<==>", m_strCompanyName)
        sbHTML.Append(strTemp)
        sbHTML.Append("</H6>")

        sbHTML.Append("</DIV>")

        'Display the Body HTML
        CommonFunctions.General.WriteHTML(sbHTML.ToString())
    End Sub

    Private Sub WritePage_Article()
        Dim sbHTML As New StringBuilder("")

        If m_blnViewAccess = False Then
            sbHTML.Append("<DIV ID=divList style='OVERFLOW:auto;HEIGHT:260;WIDTH:100%'>")
            sbHTML.Append("<TABLE id=tblHeader cellSpacing=0 width='99.9%' class=clsTable>")
            sbHTML.Append("<TR class='clsTREven'>")
            sbHTML.Append("<TD align=center height=50 valign=center>" & MyBase.GetResourceString("NOT_AUTHORIZED") & "</TD>")
            sbHTML.Append("</TR>")
            sbHTML.Append("</TABLE>")
            sbHTML.Append("</DIV>")
        Else
            Dim strLeftCaption As String = ""
            Dim strRightCaption As String = ""
            Dim strTemp As String = ""
            Dim drAttachments As IDataReader
            Dim intCount As Integer = 0
            Dim lngAttachmentId As Long = 0
            Dim strOriginalFileName As String = ""
            Dim strDescription As String = ""

            drAttachments = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_KM_Attachments " & m_lngArticleId.ToString(), MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drAttachments) <> "" Then
                If drAttachments.Read() Then m_blnHasAttachments = True
            End If

            If m_lngTypeId = 2 Then m_strType = TYPE_QSD

            'Display the Menu at Header
            CommonFunctions.General.WriteHTML(m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True))
            CommonFunctions.General.WriteHTML("<br>")

            'Display Page Caption
            strLeftCaption = Server.HtmlEncode(m_strProcedureTitle)
            If m_strEmployeeName <> "" Then
                strLeftCaption &= " - " & MyBase.GetResourceString("BY") & " " & Server.HtmlEncode(m_strEmployeeName)
            End If
            strRightCaption = "[" & MyBase.GetResourceString("ARTICLE_ID") & " : " & m_lngProcedureId.ToString() & "]"
            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(Nothing, strLeftCaption, strRightCaption, , True))

            'Prepare the Page Body HTML string
            sbHTML.Append("<DIV ID=divList class=clsDivKM style='OVERFLOW:auto;HEIGHT:260;WIDTH:100%'>")
            sbHTML.Append("<BR>")

            'Article Summary
            sbHTML.Append("<H5><A name='Summary'>" & MyBase.GetResourceString("ARTICLE_SUMMARY") & "</A></H5>")

            'Added by DipaliS
            If m_blnCustomize = True Then
                Dim strImages As String = ""
                Dim intCounter As Integer
                Dim strKCCSURL As String
                Dim strRate As String
                'Add ths Images for Star
                strKCCSURL = CommonFunctions.General.GetApplicationKeySetting("PBN_KMBaseURL")
                For intCounter = 0 To m_intAvgRating - 1
                    strImages += CommonFunctions.HTMLControls.DrawImage(strKCCSURL & "/Images/Rate_star_Orange.gif", "height=10 width=10", , , , , , True)
                Next
                For intCounter = 0 To (5 - m_intAvgRating - 1)
                    strImages += CommonFunctions.HTMLControls.DrawImage(strKCCSURL & "/Images/Rate_star_White.gif", "height=10 width=10", , , , , , True)
                Next

                strRate = MyBase.GetResourceString("RATING_LINE")
                strRate = strRate.Replace("<images>", strImages)
                strRate = strRate.Replace("<users>", m_intNoOfUsers.ToString)

                sbHTML.Append("<TABLE CellSpacing=0 width='99.9%' style='FONT-FAMILY: Verdana, Arial;FONT-SIZE: 8pt;'>")
                sbHTML.Append("<TR>")

                sbHTML.Append("<TD align=left>")
                sbHTML.Append(strRate)
                sbHTML.Append("</TD>")
                sbHTML.Append("</TR>")
                sbHTML.Append("</Table>")
            End If
            'End of Addition

            sbHTML.Append("<TABLE CellSpacing=0 width='99.9%' style='FONT-FAMILY: Verdana, Arial;FONT-SIZE: 8pt;'>")
            sbHTML.Append("<TR>")
            sbHTML.Append("<TD valign=top>" & MyBase.GetResourceString("ARTICLE_NAME") & "</TD>")
            sbHTML.Append("<TD valign=top>:</TD>")
            sbHTML.Append("<TD valign=top><B>" & HighLightedString(m_strProcedureTitle) & "</B></TD>")
            sbHTML.Append("</TR>")

            'Contributed to
            If m_strEmployeeName <> "" Then
                sbHTML.Append("<TR>")
                sbHTML.Append("<TD valign=top>" & MyBase.GetResourceString("CONTRIBUTED_BY") & "</TD>")
                sbHTML.Append("<TD valign=top>:</TD>")
                sbHTML.Append("<TD valign=top><B>" & Server.HtmlEncode(m_strEmployeeName) & "</B>")
                If m_strEmailId <> "" Then
                    sbHTML.Append("[" & Server.HtmlEncode(m_strEmailId) & "]")
                End If
                sbHTML.Append("</TD>")
                sbHTML.Append("</TR>")
            End If

            'Added by DipaliS
            'Article level
            If m_blnCustomize = True Then
                sbHTML.Append("<TR><TD valign=top>")
                sbHTML.Append(MyBase.GetResourceString("ARTICLE_LEVEL"))
                sbHTML.Append("</TD><TD valign=top>: </TD><TD valign=top><B>" & m_strArticleLevel & "</B></TD></TR>")
            End If

            'End of addition

            'Date Created
            If m_strDateCreated <> "" Then
                sbHTML.Append("<TR>")
                sbHTML.Append("<TD valign=top>" & MyBase.GetResourceString("SUBMITTED_ON") & "</TD>")
                sbHTML.Append("<TD valign=top>:</TD>")
                sbHTML.Append("<TD valign=top><B>" & Server.HtmlEncode(CommonFunctions.Dates.CGetDate(CType(m_strDateCreated, Date))) & "</B></TD>")
                sbHTML.Append("</TR>")
            End If

            'Description
            If m_strDescription <> "" Then
                sbHTML.Append("<TR>")
                sbHTML.Append("<TD valign=top>" & MyBase.GetResourceString("CATEGORY") & "</TD>")
                sbHTML.Append("<TD valign=top>:</TD>")
                sbHTML.Append("<TD valign=top><B>" & Server.HtmlEncode(m_strDescription) & "</B></TD>")
                sbHTML.Append("</TR>")
            End If

            'Pre Requisites
            If m_strProcedurePreSet <> "" Then
                sbHTML.Append("<TR>")
                sbHTML.Append("<TD valign=top>" & MyBase.GetResourceString("PREREQUISITES") & "</TD>")
                sbHTML.Append("<TD valign=top>:</TD>")
                sbHTML.Append("<TD valign=top><B>" & HighLightedString(m_strProcedurePreSet) & "</B></TD>")
                sbHTML.Append("</TR>")
            End If

            'Procedure Appliances
            If m_strProcedureAppliances <> "" Then
                sbHTML.Append("<TR>")
                sbHTML.Append("<TD valign=top>" & MyBase.GetResourceString("WHERE_ARTICLE_APPLIED") & "</TD>")
                sbHTML.Append("<TD valign=top>:</TD>")
                sbHTML.Append("<TD valign=top><B>" & HighLightedString(m_strProcedureAppliances) & "</B></TD>")
                sbHTML.Append("</TR>")
            End If

            'Project Name
            If m_strProjectName <> "" Then
                sbHTML.Append("<TR>")
                sbHTML.Append("<TD valign=top>" & MyBase.GetResourceString("PROJECT_NAME") & "</TD>")
                sbHTML.Append("<TD valign=top>:</TD>")
                sbHTML.Append("<TD valign=top><B>" & Server.HtmlEncode(m_strProjectName) & "</B></TD>")
                sbHTML.Append("</TR>")
            End If
            sbHTML.Append("</TABLE>")
            sbHTML.Append("<HR style='color:#99CCFF' size=1pt>")

            'Procedure Code 
            If m_strProcedureCode <> "" Then
                sbHTML.Append("<H5><A name='Code'>" & MyBase.GetResourceString("CODE_OR_ARTICLE") & "</A></H5>")
                sbHTML.Append("<TABLE CellSpacing=0 width='99.9%' style='FONT-FAMILY: Verdana, Arial;FONT-SIZE: 8pt;'>")
                sbHTML.Append("<TR>")
                sbHTML.Append("<TD valign=top><pre>" & HighLightedString(m_strProcedureCode) & "</pre></TD>")
                sbHTML.Append("</TR>")
                sbHTML.Append("</TABLE>")
                sbHTML.Append("<HR style='color:#99CCFF' size=1pt>")
            End If

            'Procedure Example
            If m_strProcedureExample <> "" Then
                sbHTML.Append("<H5><A name='Example'>" & MyBase.GetResourceString("EXAMPLE") & "</A></H5>")
                sbHTML.Append("<TABLE CellSpacing=0 width='99.9%' style='FONT-FAMILY: Verdana, Arial;FONT-SIZE: 8pt;'>")
                sbHTML.Append("<TR>")
                sbHTML.Append("<TD valign=top><pre>" & HighLightedString(m_strProcedureExample) & "</pre></TD>")
                sbHTML.Append("</TR>")
                sbHTML.Append("</TABLE>")
                sbHTML.Append("<HR style='color:#99CCFF' size=1pt>")
            End If

            'Procedure Comments
            If m_strProcedureComments <> "" Then
                sbHTML.Append("<H5><A name='Comments'>" & MyBase.GetResourceString("COMMENTS") & "</A></H5>")
                sbHTML.Append("<TABLE CellSpacing=0 width='99.9%' style='FONT-FAMILY: Verdana, Arial;FONT-SIZE: 8pt;'>")
                sbHTML.Append("<TR>")
                sbHTML.Append("<TD valign=top>" & HighLightedString(m_strProcedureComments, False) & "</TD>")
                sbHTML.Append("</TR>")
                sbHTML.Append("</TABLE>")
                sbHTML.Append("<HR style='color:#99CCFF' size=1pt>")
            End If

            'Attachments
            If m_blnHasAttachments = True Then
                sbHTML.Append("<H5><A name='Attachments'>" & MyBase.GetResourceString("ATTACHMENTS") & "</A></H5>")
                sbHTML.Append("<TABLE class='clsTable' width='99.9%'>")
                sbHTML.Append("<TR class='clsTRColumnHeader'>")
                sbHTML.Append("<TD>" & MyBase.GetResourceString("SEARIAL_NO") & "</TD>")
                sbHTML.Append("<TD>" & MyBase.GetResourceString("ATTACHMENT") & "</TD>")
                sbHTML.Append("</TR>")
                Do
                    intCount = intCount + 1
                    lngAttachmentId = CType("0" & CommonFunctions.Data.CheckIsDBNull(drAttachments.Item("AttachmentID")).ToString(), Long)
                    strOriginalFileName = "" & CommonFunctions.General.CheckIsNothing(drAttachments.Item("OriginalFileName")).Trim()
                    strOriginalFileName = CommonFunctions.General.UnBuildQueryString(strOriginalFileName)
                    strDescription = "" & CommonFunctions.General.CheckIsNothing(drAttachments.Item("Description")).Trim()
                    strDescription = CommonFunctions.General.UnBuildQueryString(strDescription)

                    sbHTML.Append("<TR class='clsTREven'>")
                    sbHTML.Append("<TD width='20%'>" & intCount & "</TD>")
                    sbHTML.Append("<TD>")
                    sbHTML.Append("<A HREF='javascript:Show_File(" & lngAttachmentId & ")'>")
                    If strOriginalFileName = "" Then
                        sbHTML.Append(HighLightedString(strDescription))
                    Else
                        sbHTML.Append(HighLightedString(strOriginalFileName))
                    End If
                    sbHTML.Append("</A></TD>")
                    sbHTML.Append("</TR>")
                Loop While drAttachments.Read()
                sbHTML.Append("</TABLE>")
                sbHTML.Append("<HR style='color:#99CCFF' size=1pt>")
            End If
            CommonFunctions.Data.DisposeDataReader(drAttachments)

            'Copyright Warning
            sbHTML.Append("<H6>")
            strTemp = MyBase.GetResourceString("COPYRIGHT")
            strTemp = Replace(strTemp, "<=>", Year(Now).ToString())
            strTemp = Replace(strTemp, "<==>", m_strCompanyName)
            sbHTML.Append(strTemp)
            sbHTML.Append("</H6>")

            sbHTML.Append("</DIV>")

            'Display the Body HTML
            Response.Write(sbHTML.ToString())

            'Display the Menu at footer
            m_blnFooter = True
            m_objMenu = Nothing
            m_objMenu = New WebPages.Template.StaticMenu
            CommonFunctions.General.WriteHTML(m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True))
            End If
    End Sub

    Private Sub GetArticleDetails()
        '=====================================================================
        ' Procedure Name        : GetArticleDetails
        ' Purpose               : This procedure fetches the article information from database.
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Jayavant
        ' Created               : 2-Mar-2004
        ' Revisions             :
        '=====================================================================
        Dim drArticle As IDataReader
        Dim strQuery As String = ""

        If m_strType = TYPE_LESSON Then
            strQuery = "usp_Sel_KM_GetArticleDetails 2, " & m_lngArticleId.ToString()
            drArticle = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drArticle) <> "" Then
                If drArticle.Read() Then
                    m_strSolution = "" & CommonFunctions.General.CheckIsNothing(drArticle.Item("Solution")).Trim()
                    m_strSolution = CommonFunctions.General.UnBuildQueryString(m_strSolution)
                    m_strPreventiveAction = "" & CommonFunctions.General.CheckIsNothing(drArticle.Item("PreventiveAction")).Trim()
                    m_strPreventiveAction = CommonFunctions.General.UnBuildQueryString(m_strPreventiveAction)
                    m_strReferredDocument = "" & CommonFunctions.General.CheckIsNothing(drArticle.Item("ReferedDocument")).Trim()
                    m_strReferredDocument = CommonFunctions.General.UnBuildQueryString(m_strReferredDocument)
                    m_strProblemDescription = "" & CommonFunctions.General.CheckIsNothing(drArticle.Item("ProblemDescription")).Trim()
                    m_strProblemDescription = CommonFunctions.General.UnBuildQueryString(m_strProblemDescription)
                    m_lngLessonId = CType("0" & CommonFunctions.Data.CheckIsDBNull(drArticle.Item("LessonID")).ToString(), Long)
                    m_strProjectName = "" & CommonFunctions.General.CheckIsNothing(drArticle.Item("ProjectName")).Trim()
                    m_strProjectName = CommonFunctions.General.UnBuildQueryString(m_strProjectName)
                    m_strProblemType = "" & CommonFunctions.General.CheckIsNothing(drArticle.Item("ProblemType")).Trim()
                    m_strProblemType = CommonFunctions.General.UnBuildQueryString(m_strProblemType)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drArticle)

        Else
            strQuery = "usp_Sel_KM_GetArticleDetails 1," & m_lngArticleId.ToString() & ", " & m_lngUserId.ToString()
            drArticle = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drArticle) <> "" Then
                If drArticle.Read() Then
                    m_lngTypeId = CType("0" & CommonFunctions.Data.CheckIsDBNull(drArticle.Item("TypeID")).ToString(), Long)
                    m_strProcedureCode = "" & CommonFunctions.General.CheckIsNothing(drArticle.Item("ProcedureCode")).Trim()
                    m_strProcedureCode = CommonFunctions.General.UnBuildQueryString(m_strProcedureCode)
                    m_strProcedureExample = "" & CommonFunctions.General.CheckIsNothing(drArticle.Item("ProcedureExample")).Trim()
                    m_strProcedureExample = CommonFunctions.General.UnBuildQueryString(m_strProcedureExample)
                    m_strProcedureComments = "" & CommonFunctions.General.CheckIsNothing(drArticle.Item("ProcedureComment")).Trim()
                    m_strProcedureComments = CommonFunctions.General.UnBuildQueryString(m_strProcedureComments)
                    m_strProcedureTitle = "" & CommonFunctions.General.CheckIsNothing(drArticle.Item("ProcedureTitle")).Trim()
                    m_strProcedureTitle = CommonFunctions.General.UnBuildQueryString(m_strProcedureTitle)
                    m_strEmployeeName = "" & CommonFunctions.General.CheckIsNothing(drArticle.Item("EmployeeName")).Trim()
                    m_strEmployeeName = CommonFunctions.General.UnBuildQueryString(m_strEmployeeName)
                    m_lngProcedureId = CType("0" & CommonFunctions.Data.CheckIsDBNull(drArticle.Item("ProcedureID")).ToString(), Long)
                    m_strEmailId = "" & CommonFunctions.General.CheckIsNothing(drArticle.Item("EmailID")).Trim()
                    m_strEmailId = CommonFunctions.General.UnBuildQueryString(m_strEmailId)
                    m_strDateCreated = "" & CommonFunctions.General.CheckIsNothing(drArticle.Item("DateCreated")).Trim()
                    m_strDateCreated = CommonFunctions.General.UnBuildQueryString(m_strDateCreated)
                    m_strDescription = "" & CommonFunctions.General.CheckIsNothing(drArticle.Item("Description")).Trim()
                    m_strDescription = CommonFunctions.General.UnBuildQueryString(m_strDescription)
                    m_strProcedurePreSet = "" & CommonFunctions.General.CheckIsNothing(drArticle.Item("ProcedurePreSet")).Trim()
                    m_strProcedurePreSet = CommonFunctions.General.UnBuildQueryString(m_strProcedurePreSet)
                    m_strProcedureAppliances = "" & CommonFunctions.General.CheckIsNothing(drArticle.Item("ProcedureAppliances")).Trim()
                    m_strProcedureAppliances = CommonFunctions.General.UnBuildQueryString(m_strProcedureAppliances)
                    m_strProjectName = "" & CommonFunctions.General.CheckIsNothing(drArticle.Item("ProjectName")).Trim()
                    m_strProjectName = CommonFunctions.General.UnBuildQueryString(m_strProjectName)
                    m_strAuthenticated = "" & CommonFunctions.General.CheckIsNothing(drArticle.Item("Authenticated")).Trim()
                    m_strAuthenticated = CommonFunctions.General.UnBuildQueryString(m_strAuthenticated)
                    m_intFavorite = CType("0" & CommonFunctions.Data.CheckIsDBNull(drArticle.Item("Favorite")).ToString(), Integer)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drArticle)
        End If
    End Sub

    Private Sub GetCompanyName()
        '=====================================================================
        ' Procedure Name        : GetCompanyName
        ' Purpose               : This procedure fetches the company name from database.
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Jayavant
        ' Created               : 2-Mar-2004
        ' Revisions             :
        '=====================================================================
        Dim drCompany As IDataReader
        Dim strQuery As String = ""

        strQuery = "usp_sel_TagName_CompanyName 0"
        drCompany = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drCompany) <> "" Then
            If drCompany.Read() Then
                m_strCompanyName = "" & CommonFunctions.General.CheckIsNothing(drCompany.Item("CompanyTitle")).Trim()
                m_strCompanyName = CommonFunctions.General.UnBuildQueryString(m_strCompanyName)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drCompany)
    End Sub

    Private Sub GetAccessRights()
        Dim drAccessRights As IDataReader
        Dim strQuery As String = ""

        strQuery = "Exec usp_Sel_KM_GetAuthorizationInformation " & m_lngArticleId.ToString()
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

    Private Function HighLightedString(ByVal strStringToWrite As String, _
                                       Optional ByVal blnHTMLEncode As Boolean = True) As String
        '=====================================================================
        ' Procedure Name        : HighLightedString
        ' Purpose               : This function return the string after highlighting the search string
        ' Description           : If no search string then function returns the string as it is. But if not blank
        '                         then highlighting it and then returns the resulted string
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Jayavant
        ' Created               : 2-Mar-2004
        ' Revisions             :
        '=====================================================================
        Dim strHighLightedText As String = ""
        Dim strTextToBeHighlighted As String = ""
        Dim intIndex As Integer = 0
        Dim intHTMLOpenTagIndex As Integer = 0
        Dim intNextCharacter As Integer = 0

        If m_strTextToBeHighlighted = "" Then
            If blnHTMLEncode = True Then
                Return Server.HtmlEncode(strStringToWrite)
            Else
                Return strStringToWrite
            End If
        Else
            strTextToBeHighlighted = m_strTextToBeHighlighted
            strHighLightedText = ""
            intIndex = InStr(strStringToWrite, strTextToBeHighlighted, CompareMethod.Text)

            Do While intIndex <> 0

                ' Retrieve the left part of the string, upto the first occurance of the search value.
                If blnHTMLEncode = True Then
                    strHighLightedText = strHighLightedText & Server.HtmlEncode(Left(strStringToWrite, intIndex - 1))
                Else
                    strHighLightedText = strHighLightedText & Left(strStringToWrite, intIndex - 1)
                End If
                intHTMLOpenTagIndex = InStrRev(Left(strStringToWrite, intIndex - 1), "<")

                If InStrRev(Left(strStringToWrite, intIndex - 1), ">") > intHTMLOpenTagIndex Then
                    intHTMLOpenTagIndex = 0
                End If

                If intHTMLOpenTagIndex <> 0 Then
                    intNextCharacter = Asc(Mid(Left(strStringToWrite, intIndex - 1), intHTMLOpenTagIndex + 1, 1) & "/")
                    If intNextCharacter = Asc("!") Or intNextCharacter = Asc("/") Or intNextCharacter = Asc("?") Or (intNextCharacter >= Asc("a") And intNextCharacter <= Asc("z")) Or (intNextCharacter >= Asc("A") And intNextCharacter <= Asc("Z")) Then
                    Else
                        intHTMLOpenTagIndex = 0
                    End If
                End If

                strStringToWrite = Right(strStringToWrite, Len(strStringToWrite) - intIndex + 1)

                If intHTMLOpenTagIndex = 0 Then
                    ' Now insert the searched value in the highlighted font.
                    strHighLightedText = strHighLightedText & "<font color=white style='BACKGROUND-COLOR: #3366cc'><b>"
                    If blnHTMLEncode = True Then
                        strHighLightedText = strHighLightedText & Server.HtmlEncode(Left(strStringToWrite, Len(strTextToBeHighlighted)))
                    Else
                        strHighLightedText = strHighLightedText & Left(strStringToWrite, Len(strTextToBeHighlighted))
                    End If
                    strHighLightedText = strHighLightedText & "</b></font>"
                Else
                    ' Now insert the searched value as it is.				
                    If blnHTMLEncode = True Then
                        strHighLightedText = strHighLightedText & Server.HtmlEncode(Left(strStringToWrite, Len(strTextToBeHighlighted)))
                    Else
                        strHighLightedText = strHighLightedText & Left(strStringToWrite, Len(strTextToBeHighlighted))
                    End If
                End If
                ' Trim the string upto where it has been processed already.
                strStringToWrite = Right(strStringToWrite, Len(strStringToWrite) - Len(strTextToBeHighlighted))
                intIndex = InStr(strStringToWrite, strTextToBeHighlighted, CompareMethod.Text)
            Loop

            ' Retrieve the remaining part of the text.
            If blnHTMLEncode = True Then
                strHighLightedText = strHighLightedText & Server.HtmlEncode(strStringToWrite)
            Else
                strHighLightedText = strHighLightedText & strStringToWrite
            End If

            Return strHighLightedText
        End If
    End Function

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        'Show or hide the Locate In Tree Menu Link
        If Args.MenuColIndex = MenuIndex.LOCATE_IN_TREE Then
            If CommonFunction.General.IsClientBrowserIE = True Then
                If CommonFunction.General.GetApplicationKeySetting("KMTreeType").ToUpper = "HTML" Then
                    Cancel = True
                    Return
                End If
            Else
                Cancel = True
                Return
            End If
        End If

        If m_strType = TYPE_LESSON Then
            If Not (Args.MenuColIndex = MenuIndex.PROBLEM_SUMMARY Or _
                   Args.MenuColIndex = MenuIndex.SOLUTION Or _
                   Args.MenuColIndex = MenuIndex.PREVENTIVE_ACTION Or _
                   Args.MenuColIndex = MenuIndex.REFERRED_DOCUMENT Or _
                   Args.MenuColIndex = MenuIndex.HELP) Then
                Cancel = True
                Return
            End If

            If Args.MenuColIndex = MenuIndex.SOLUTION And m_strSolution = "" Then Cancel = True
            If Args.MenuColIndex = MenuIndex.PREVENTIVE_ACTION And m_strPreventiveAction = "" Then Cancel = True
            If Args.MenuColIndex = MenuIndex.REFERRED_DOCUMENT And m_strReferredDocument = "" Then Cancel = True
        Else
            If Args.MenuColIndex = MenuIndex.PROBLEM_SUMMARY Or _
               Args.MenuColIndex = MenuIndex.SOLUTION Or _
               Args.MenuColIndex = MenuIndex.PREVENTIVE_ACTION Or _
               Args.MenuColIndex = MenuIndex.REFERRED_DOCUMENT Then
                Cancel = True
                Return
            Else
                If m_blnFooter = True Then
                    If Args.MenuColIndex = MenuIndex.ARTICLE_SUMMARY Or _
                       Args.MenuColIndex = MenuIndex.CODE_ARTICLE Or _
                       Args.MenuColIndex = MenuIndex.EXAMPLE Or _
                       Args.MenuColIndex = MenuIndex.COMMENTS Or _
                       Args.MenuColIndex = MenuIndex.ATTACHMENTS Or _
                       Args.MenuColIndex = MenuIndex.HELP Then
                        Cancel = True
                        Return
                    End If
                    'Added by DipaliS
                    If m_blnCustomize = False Then
                        If Args.MenuColIndex = MenuIndex.RATE_ARTICLE Or Args.MenuColIndex = MenuIndex.HOME Then
                            Cancel = True
                            Return
                        End If
                    End If
                    If Args.MenuColIndex = MenuIndex.RATE_ARTICLE Then
                        If m_intRateCount = 0 And m_intArticleBy <> CType(Session("intUserID"), Integer) Then
                            Cancel = False
                        Else
                            Cancel = True
                        End If
                    End If
                    'end of addition
                Else
                    'added by DipaliS the check for Rate article and home
                    If Args.MenuColIndex = MenuIndex.LOCATE_IN_TREE Or _
                       Args.MenuColIndex = MenuIndex.SEARCHED_ARTICLES Or _
                       Args.MenuColIndex = MenuIndex.ADD_NEW Or _
                       Args.MenuColIndex = MenuIndex.EDIT Or _
                       Args.MenuColIndex = MenuIndex.DELETE Or _
                       Args.MenuColIndex = MenuIndex.AUTHENTICATE Or _
                       Args.MenuColIndex = MenuIndex.ADD_TO_FAVORITES Or _
                       Args.MenuColIndex = MenuIndex.REMOVE_FROM_FAVORITES Or _
                       Args.MenuColIndex = MenuIndex.AUTHENTICATION_RIGHTS Or _
                       Args.MenuColIndex = MenuIndex.RATE_ARTICLE Or _
                       Args.MenuColIndex = MenuIndex.HOME Then
                        Cancel = True
                        Return
                    End If

                End If

                If Args.MenuColIndex = MenuIndex.CODE_ARTICLE And m_strProcedureCode = "" Then Cancel = True
                If Args.MenuColIndex = MenuIndex.EXAMPLE And m_strProcedureExample = "" Then Cancel = True
                If Args.MenuColIndex = MenuIndex.COMMENTS And m_strProcedureComments = "" Then Cancel = True
                If Args.MenuColIndex = MenuIndex.ATTACHMENTS And m_blnHasAttachments = False Then Cancel = True
                If Args.MenuColIndex = MenuIndex.SEARCHED_ARTICLES And CommonFunctions.General.CheckIsNothing(MyBase.Session.Item("KM_Search_Query")).ToString() = "" Then Cancel = True
                If Args.MenuColIndex = MenuIndex.ADD_NEW And m_blnAddAccess = False Then Cancel = True
                If Args.MenuColIndex = MenuIndex.EDIT And m_blnEditAccess = False Then Cancel = True

                If Args.MenuColIndex = MenuIndex.DELETE Then
                    If m_blnDeleteAccess = True Then
                        If CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("SELECT ProcedureId FROM tbl_KM_CodeHeadings WHERE TypeID = 2 AND ParentID = " & m_lngArticleId.ToString(), MyBase.UseSQL)) <> "" Then
                            Cancel = True
                        End If
                    Else
                        Cancel = True
                    End If
                End If

                If Args.MenuColIndex = MenuIndex.AUTHENTICATE And m_strType <> TYPE_UNAUTHENTICATED Then Cancel = True
                If m_strAuthenticated = "Y" And m_strType <> TYPE_QSD Then
                    If m_intFavorite = 1 Then
                        If Args.MenuColIndex = MenuIndex.ADD_TO_FAVORITES Then Cancel = True
                    Else
                        If Args.MenuColIndex = MenuIndex.REMOVE_FROM_FAVORITES Then Cancel = True
                    End If
                Else
                    If Args.MenuColIndex = MenuIndex.ADD_TO_FAVORITES Then Cancel = True
                    If Args.MenuColIndex = MenuIndex.REMOVE_FROM_FAVORITES Then Cancel = True
                End If
                If Args.MenuColIndex = MenuIndex.AUTHENTICATION_RIGHTS And CType("0" & CommonFunctions.General.CheckIsNothing(MyBase.Session.Item("intPostID")).ToString(), Integer) <> CommonFunctions.Constants.ROLE_ADMINISTRATOR Then Cancel = True
            End If
        End If
    End Sub
End Class
