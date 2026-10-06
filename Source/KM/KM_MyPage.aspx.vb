Public Class KM_MyPage
    Inherits WebPages.Template.WhizTemplate
#Region " Constant Variables "
    Protected Const ACTION_SAVE As String = "SAVE"
    Protected Const ACTION_DELETEATTACHEMENT As String = "DELETEATTACHMENT"
    Protected Const MODE_NEW As String = "NEW"
    Protected Const MODE_EDIT As String = "EDIT"
    Protected Const MODE_VIEW As String = "VIEW"
    'Addition by SuchitraP on 4 July 2008
    'Purpose: Called when clicked on Publish link from Publish to KM link in helpdesk
    Protected Const ACTION_CRM_ARTICLESAVE As String = "CRMSAVE"
    'End by SuchitraP
    Private m_blnValidate As Boolean = True

#End Region
#Region " Global Variables "
    Protected m_strPageTitle As String = ""
    Protected m_intPageID As Integer = 0
    Protected m_strMode As String = ""
    Protected m_strAction As String = ""
    Protected m_strPageSubject As String = "My Page"
    Protected m_strMenu As String = ""
    Protected m_strLegends As String = ""
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_lngUserId As Long = 0
    Private m_lngPostId As Long = 0
    Protected m_strContents As String = ""
    Protected m_lngStylesheetID As Long
    Protected m_strBGDarkcolor As String


    'Addition by SuchitraP on 4 July 2008
    Protected m_intQueryID As Integer = 0
    'End by SuchitraP
    'Addition by SuchitraP on 25-Aug-2008 to create new pages under spaces
    Protected m_strSpaceID As String
    Protected m_strFrom As String
    Protected m_strSynopsis As String = ""
    Protected m_strFromWhere As String
    'End by SuchitraP
    Private strSQL As String
    Private drPageDetails As IDataReader
    Private strLabels As String = ""
    Private strSynopsis As String = ""
    Private blnRestrictView As Boolean = False
    Private blnRestrictEdit As Boolean = False
    Protected m_strtxtSearch As String = ""
    Protected m_strPagingNumber As String = ""
    Protected strProcedureTitleDB As String = ""
    Private drArticleName As IDataReader
    Protected strflag As String = "1"
    Protected strEditClick As String = "0"
    Protected m_strActionLink As String
    Protected m_strPrimaryKey As String
    Private m_strVersionID As String

    ''added by RohiniK on 10 Nov 09
    Protected m_strVersion As String = 0
    Protected m_From As String = ""
    ''End of addition by RohiniK on 10 Nov 09


#End Region
#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    'Protected WithEvents FreeTextBox As FreeTextBoxControls.FreeTextBox
    Protected WithEvents lnkBtnSet As System.Web.UI.WebControls.LinkButton
    Protected WithEvents txtHTML As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents Literal1 As System.Web.UI.WebControls.Literal
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
        'Put user code to initialize the page here
        'If IsPostBack = True Then
        '    Dim strHTML As String = txtHTML.Value
        '    If strHTML.Trim <> "" Then
        '        'commented and Added by KIRAN KK on 26-11-15 for HTML Encoding
        '        '    If FreeTextBox.Text.Trim = "" Then FreeTextBox.Text = strHTML
        '        'End If
        '        ''Remove html encoding for page not required it on 7/12/2015 by Nilesh g
        '        '' If FreeTextBox.Text.Trim = "" Then FreeTextBox.Text = Server.HtmlEncode(strHTML)
        '        If FreeTextBox.Text.Trim = "" Then FreeTextBox.Text = strHTML
        '    End If
        '    'commented and Added by KIRAN KK on 26-11-15 for HTML Encoding 
        'End If
        'FreeTextBox.BackColor = System.Drawing.Color.AliceBlue
        'FreeTextBox.AllowHtmlMode = False  

        'FreeTextBox.DesignModeCss = "FreeText.css"
        'FreeTextBox.DownlevelMode = FreeTextBoxControls.DownlevelMode.TextArea

        'FreeTextBox.ScrollbarStyle.CssClass = "clsPageBody"
        'FreeTextBox.ToolbarType = FreeTextBoxControls.ToolbarType.Office2000
        InitPage()

        ' ''Added by Dhanashri S on 29 Mar 2016
        'If (Request.QueryString("PKArticleToken") <> "" And Request.QueryString("PageID") <> "" And Request.QueryString("SpaceID") <> "") Then
        '    If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("PageID"), String) + CType(Request.QueryString("SpaceID"), String) + "0" + "0", Request.QueryString("PKArticleToken")) = False) Then

        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("PageID"), String))
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    End If
        'End If
        ' ''End of Addition by Dhanashri S on 29 MAr 2016
        'Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
        If (Request.QueryString("FromWhere")) = "MyTeam" Then
            If Request.QueryString("EditClick") = "2" And Request.QueryString("Myflag") = "2" And Request.QueryString("Action") <> "SAVE" And (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("PageID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0" + CType(Request.QueryString("SpaceID"), String), Request.QueryString("PKToken")) = False) Then
                m_blnValidate = True
            ElseIf Request.QueryString("EditClick") <> "1" And (Request.QueryString("PKToken") = "" And HttpContext.Current.Session("intUserID").ToString <> "0") And Request.QueryString("Action") <> "SAVE" And Request.QueryString("Action") <> "DELETEATTACHMENT" Then
                m_blnValidate = False
            ElseIf Request.QueryString("EditClick") <> "1" And Request.QueryString("Myflag") = "2" And Request.QueryString("Action") <> "SAVE" And (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("PageID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0" + CType(Request.QueryString("SpaceID"), String), Request.QueryString("PKToken")) = False) Then
                m_blnValidate = False
            ElseIf Request.QueryString("Myflag") = "1" And Request.QueryString("Action") <> "SAVE" And (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("SpaceID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0", Request.QueryString("PKToken")) = False) Then
                m_blnValidate = False
            End If
        End If
        If (Request.QueryString("FromWhere")) = "MyTeam" Then
            If Request.QueryString("EditClick") = "2" And Request.QueryString("Myflag") = "2" And Request.QueryString("Action") <> "SAVE" And (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("SpaceID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0" + CType(Request.QueryString("PageID"), String), Request.QueryString("PKToken")) = False) Then
                m_blnValidate = False
            End If
        End If
        If (Request.QueryString("Action")) = "History" Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("PageID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0" + CType(Request.QueryString("VersionID"), String), Request.QueryString("PKToken")) = False) Then
                m_blnValidate = False
            End If
        End If
        If (Request.QueryString("FromWhere")) = "MySpaceEdit" Or (Request.QueryString("FromWhere")) = "LatestFeatured" Then
            If (Request.QueryString("PKToken") = "" And HttpContext.Current.Session("intUserID").ToString <> "0") And Request.QueryString("Action") <> "SAVE" Then
                m_blnValidate = False
            ElseIf Request.QueryString("Myflag") = "2" And Request.QueryString("Action") <> "SAVE" And (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("PageID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0" + CType(Request.QueryString("SpaceID"), String), Request.QueryString("PKToken")) = False) Then
                m_blnValidate = False
            End If
        End If
        If m_blnValidate = False Then
            'Token is Invalid now redirect to the Invalid Access Page
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If

        'End Of Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
    End Sub
    Private Sub PlotHiddenControls()
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''CommonFunctions.HTMLControls.DrawTextBox("txtPK", "txtPK", , , , CStr(m_intPageID), IsHidden:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtPK", "txtPK", , , , CStr(m_intPageID), IsHidden:=True, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        CommonFunction.General.WriteHTML("<input type=hidden name=hidFromwhere id=hidFromwhere value=" + Request.QueryString("Fromwhere") + ">" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidtxtSearch id=hidtxtSearch value=" + Request.QueryString("txtSearch") + ">" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidtxtPageNumber id=hidtxtPageNumber value=" + Request.QueryString("PageNumber") + ">" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidProcedureTitle id=hidProcedureTitle value='" + strProcedureTitleDB + "'>" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidEditClick id=hidEditClick value='" + Request.QueryString("EditClick") + "'>" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidMode id=hidMode value=" + Request.QueryString("Mode") + ">" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidActionLink id=hidActionLink value=" + Request.QueryString("ActionLink") + ">" + vbCrLf)
    End Sub
    Private Sub InitPage()
        Dim strscrollbarFACECOLOR As String
        Dim strscrollbarHIGHLIGHTCOLOR As String
        Dim strscrollbarSHADOWCOLOR As String
        Dim strscrollbarARROWCOLOR As String
        Dim strscrollbarTRACKCOLOR As String
        Dim strscrollbarBASECOLOR As String
        Dim strscrollbarDARKSHADOWCOLOR As String
        Dim strscrollbar3DLIGHTCOLOR As String


        ''added by RohiniK on 10 Nov 09
        If CommonFunction.General.CheckIsNothing(Request.QueryString("From"), "") <> "" Then
            m_From = Request.QueryString("From").ToUpper
        Else
            m_From = ""
        End If
        ''End of addition by RohiniK on 10 Nov 09


        m_strPageTitle = "Article"
        m_strPageSubject = "My Article"
        If Not Request("Action") Is Nothing Then
            m_strAction = CStr(Request("Action"))
        End If

        If Not Request("PageID") Is Nothing Then
            m_intPageID = CInt(Request("PageID"))
        Else
            If Not Request("txtPK") Is Nothing Then
                m_intPageID = CInt(Request("txtPK"))
            End If
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "") <> "" Then
            m_strMode = Request.QueryString("Mode").ToUpper
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidMode"), "") <> "" Then
            m_strMode = Request.Form("hidMode").ToUpper
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("EditClick"), "") <> "" Then
            strEditClick = Request.QueryString("EditClick")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidEditClick"), "") <> "" Then
            strEditClick = Request.Form("hidEditClick")
        End If

        'Addition by SuchitraP on 4 July 2008
        'Purpose: To show Submit link when page opened from helpdesk
        If Not Request.QueryString("From") Is Nothing Then
            If Request.QueryString("From").ToUpper = "MANAGE" Then
                m_strFrom = Request.QueryString("From")
            End If
        Else
            m_strFrom = Request.Form("hidFrom")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("Fromwhere"), "") <> "" Then
            m_strFromWhere = Request.QueryString("Fromwhere")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidFromwhere"), "") <> "" Then
            m_strFromWhere = Request.Form("hidFromwhere")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("txtSearch"), "") <> "" Then
            m_strtxtSearch = Request.QueryString("txtSearch")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidtxtSearch"), "") <> "" Then
            m_strtxtSearch = Request.Form("hidtxtSearch")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("VersionID"), "") <> "" Then
            m_strVersionID = Request.QueryString("VersionID")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("PageNumber"), "") <> "" Then
            m_strPagingNumber = Request.QueryString("PageNumber")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidtxtPageNumber"), "") <> "" Then
            m_strPagingNumber = Request.Form("hidtxtPageNumber")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("ActionLink"), "") <> "" Then
            m_strActionLink = Request.QueryString("ActionLink")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidActionLink"), "") <> "" Then
            m_strActionLink = Request.Form("hidActionLink")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("PrimaryKey"), "") <> "" Then
            m_strPrimaryKey = Request.QueryString("PrimaryKey")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidPrimaryKey"), "") <> "" Then
            m_strPrimaryKey = Request.Form("hidPrimaryKey")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("Myflag"), "") <> "" Then
            strflag = Request.QueryString("Myflag")
        End If

        'drArticleName = CommonFunction.Data.GetDataReader("SELECT ProcedureTitle FROM tbl_KM_CodeHeadings WHERE ProgrammerID=" + HttpContext.Current.Session("intUserID").ToString + " ORDER BY 1 ", MyBase.UseSQL)
        'To check duplication accross all logins
        drArticleName = CommonFunction.Data.GetDataReader("SELECT LTRIM(RTRIM(ProcedureTitle)) ProcedureTitle FROM tbl_KM_CodeHeadings ORDER BY 1 ", MyBase.UseSQL)
        While drArticleName.Read
            strProcedureTitleDB = strProcedureTitleDB + "," + drArticleName("ProcedureTitle").ToString
        End While
        'Commented And Edited By KIRAN K K for cross scripting 20-11-15 
        ' strProcedureTitleDB = strProcedureTitleDB.Replace("'", "@") + ","
        strProcedureTitleDB = Server.HtmlEncode(strProcedureTitleDB.Replace("'", "@") + ",")
        'Commented And Edited End By KIRAN K K for cross scripting 20-11-15 
        If Not Request("QueryID") Is Nothing Then
            m_intQueryID = CInt(Request("QueryID"))
        End If

        If Not Request("FromWhere") Is Nothing Then
            If Request("FromWhere") = "PublishKM" Then
                If Not Request("ProcedureID") Is Nothing Then
                    If Request("ProcedureID") <> "" Then
                        m_intPageID = CInt(Request("ProcedureID"))
                    End If
                End If
            End If
        End If
        'End of addition by SuchitraP

        m_lngUserId = Session("intUserID")
        m_lngPostId = Session("intPostID")


        'Addition by SuchitraP on 25-Aug-2008 to create new pages under spaces
        If CommonFunction.General.CheckIsNothing(Request.QueryString("SpaceID"), "") <> "" Then
            m_strSpaceID = Request.QueryString("SpaceID")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidSpaceID"), "") <> "" Then
            m_strSpaceID = Request.Form("hidSpaceID").ToString
        End If
        'End by SuchitraP

        PerformAction()

        InitializeMenu()
        InitializePageLegend()
        WritePageHead()

        If Trim(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("WAF_StyleSheetID"), "") & "") <> "" Then
            ' set the session value set for style sheet by the user
            m_lngStylesheetID = CType(HttpContext.Current.Session("WAF_StyleSheetID"), Long)
        End If

        Select Case m_lngStylesheetID
            Case 2  ' Breek red
                strscrollbarFACECOLOR = "#f0d8ce"
                strscrollbarHIGHLIGHTCOLOR = "#f9efea"
                strscrollbarSHADOWCOLOR = "#f9efea"
                strscrollbarARROWCOLOR = "#921b19"
                strscrollbarTRACKCOLOR = "#f9efea"
                strscrollbarBASECOLOR = "#f0e2e2"
                strscrollbarDARKSHADOWCOLOR = "#f9efea"
                strscrollbar3DLIGHTCOLOR = "#f9efea"
            Case 3 'BurntSienna
                strscrollbarFACECOLOR = "#f5debe"
                strscrollbarHIGHLIGHTCOLOR = "#fbecd5"
                strscrollbarSHADOWCOLOR = "#fbecd5"
                strscrollbarARROWCOLOR = "#e28a05"
                strscrollbarTRACKCOLOR = "#fbecd5"
                strscrollbarBASECOLOR = "#e0e7ef"
                strscrollbarDARKSHADOWCOLOR = "#fbecd5"
                strscrollbar3DLIGHTCOLOR = "#fbecd5"

            Case 4 'Green
                strscrollbarFACECOLOR = "#dce1d0"
                strscrollbarHIGHLIGHTCOLOR = "#f2f7e7"
                strscrollbarSHADOWCOLOR = "#f2f7e7"
                strscrollbarARROWCOLOR = "#36470d"
                strscrollbarTRACKCOLOR = "#f2f7e7"
                strscrollbarBASECOLOR = "#f2f7e7"
                strscrollbarDARKSHADOWCOLOR = "#f2f7e7"
                strscrollbar3DLIGHTCOLOR = "#f2f7e7"
            Case 5 ' Purple
                strscrollbarFACECOLOR = "#dbd5ec"
                strscrollbarHIGHLIGHTCOLOR = "#efebfa"
                strscrollbarSHADOWCOLOR = "#efebfa"
                strscrollbarARROWCOLOR = "#56458c"
                strscrollbarTRACKCOLOR = "#efebfa"
                strscrollbarBASECOLOR = "#e2deee"
                strscrollbarDARKSHADOWCOLOR = "#efebfa"
                strscrollbar3DLIGHTCOLOR = "#efebfa"

            Case 6 'goldenyellow
                strscrollbarFACECOLOR = "#f9ecb6"
                strscrollbarHIGHLIGHTCOLOR = "#fefae9"
                strscrollbarSHADOWCOLOR = "#fefae9"
                strscrollbarARROWCOLOR = "#c3a21e"
                strscrollbarTRACKCOLOR = "#fefae9"
                strscrollbarBASECOLOR = "#f4f2e8"
                strscrollbarDARKSHADOWCOLOR = "#fefae9"
                strscrollbar3DLIGHTCOLOR = "#fefae9"

            Case 7 'turquoise
                strscrollbarFACECOLOR = "#cbe7eb"
                strscrollbarHIGHLIGHTCOLOR = "#e8f4f6"
                strscrollbarSHADOWCOLOR = "#e8f4f6"
                strscrollbarARROWCOLOR = "#37acba"
                strscrollbarTRACKCOLOR = "#e8f4f6"
                strscrollbarBASECOLOR = "#e0e7ef"
                strscrollbarDARKSHADOWCOLOR = "#e8f4f6"
                strscrollbar3DLIGHTCOLOR = "#e8f4f6"
            Case Else ' default
                strscrollbarFACECOLOR = "#D3E5FC"
                strscrollbarHIGHLIGHTCOLOR = "#EEF6FF"
                strscrollbarSHADOWCOLOR = "#EEF6FF"
                strscrollbarARROWCOLOR = "#3D5FA3"
                strscrollbarTRACKCOLOR = "#EEF6FF"
                strscrollbarBASECOLOR = "#E0E7EF"
                strscrollbarDARKSHADOWCOLOR = "#EEF6FF"
                strscrollbar3DLIGHTCOLOR = "#EEF6FF"
        End Select



        CommonFunction.Data.DisposeDataReader(drArticleName)

    End Sub
    'Public Sub plotTitleBox()
    '    Response.Write("<tr class=clsTREven><td>Title</td><td><input type=""TextBox"" id=""txtTitle"" name=""txtTitle"" value=""" & m_strPageSubject & """> </tr></td>")
    'End Sub
    Private Sub PerformAction()
        Dim strSQL As String
        If m_strAction = ACTION_SAVE Then
            Dim strTitle As String = ""
            Dim strContents As String = ""
            Dim strLabels As String = ""
            Dim strSynopsis As String = ""
            Dim strEditUserIDs As String = ""
            Dim strViewUserIDs As String = ""
            Dim blnRestrictEdit As Boolean = False
            Dim blnRestrictView As Boolean = False

            strTitle = CommonFunctions.General.BuildQueryString(Request("txtTitle"))
            'strContents = CommonFunctions.General.BuildQueryString(Request("txtFreeTextBox"))
            'Commentd And Edited by KIRAN K K ON 26-11-15 FOR Issue id:2207
            'strContents = CommonFunctions.General.BuildQueryString(FreeTextBox.Text)
            ''Remove html encoding for page not required it on 7/12/2015 by Nilesh g
            '' strContents = CommonFunctions.General.BuildQueryString(Server.HtmlEncode(FreeTextBox.Text))

            'strContents = CommonFunctions.General.BuildQueryString(FreeTextBox.Text)
            ''Added by swapnil aswale on 12-1-2015 for Responsive FreeTextBox
            strContents = CommonFunctions.General.BuildQueryString(Request.Form("freeHidden"))
            ''Ended

            'Commentd And Edited End by KIRAN K K ON 26-11-15 FOR Issue id:2207 
            strLabels = CommonFunctions.General.BuildQueryString(Request("txtLabels"))
            strSynopsis = CommonFunctions.General.BuildQueryString(Request("txtSynopsis"))


            If Not Request("chkEdit") Is Nothing Then
                strEditUserIDs = Request("txtEditUserIDs")
                blnRestrictEdit = True
            End If
            If Not Request("chkView") Is Nothing Then
                strViewUserIDs = Request("txtViewUserIDs")
                blnRestrictView = True
            End If

            'Comment and modification by SuchitraP on 26-Aug-2008 to get the SpaceID when Pages are created from My Team
            'strSQL = " usp_InsUpd_tbl_KM_CodeHeadings " & m_intPageID & "," & m_lngUserId.ToString & ",N'" & strTitle & "',N'" & strContents & "',N'" & strLabels & "'," & CStr(IIf(blnRestrictEdit, 1, 0)) & ",'" & strEditUserIDs & "'," & CStr(IIf(blnRestrictView, 1, 0)) & ",'" & strViewUserIDs & "'"
            If m_strSpaceID Is Nothing Then
                m_strSpaceID = "NULL"
            End If

            strSQL = " usp_InsUpd_tbl_KM_CodeHeadings " & m_intPageID & "," & m_lngUserId.ToString & ",N'" & strTitle & "',N'" & strContents & "',N'" & strLabels & "','" & strSynopsis & "'," & CStr(IIf(blnRestrictEdit, 1, 0)) & ",'" & strEditUserIDs & "'," & CStr(IIf(blnRestrictView, 1, 0)) & ",'" & strViewUserIDs & "'" & "," & m_strSpaceID
            m_intPageID = CommonFunctions.Data.GetDataScalar(strSQL, True)
            m_strMode = MODE_EDIT

        ElseIf m_strAction = ACTION_DELETEATTACHEMENT Then
            Dim strAttachmentIDs As String
            If Not Request("chkDelete") Is Nothing Then
                strAttachmentIDs = Request("chkDelete")
                If strAttachmentIDs <> "" Then
                    strSQL = "usp_Del_tbl_KM_Attachments NULL,'" & strAttachmentIDs & "'"
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                End If
            End If
            'Addition by SuchitraP on 4 July 2008
            'Purpose: to save data in draft until it is approved from WorkFlow
        ElseIf m_strAction = ACTION_CRM_ARTICLESAVE Then
            Dim strTitle As String = ""
            Dim strContents As String = ""
            Dim strLabels As String = ""
            Dim strSynopsis As String = ""
            Dim strEditUserIDs As String = ""
            Dim strViewUserIDs As String = ""
            Dim blnRestrictEdit As Boolean = False
            Dim blnRestrictView As Boolean = False

            strTitle = CommonFunctions.General.BuildQueryString(Request("txtTitle"))
            'strContents = CommonFunctions.General.BuildQueryString(Request("txtFreeTextBox"))
            'Commentd And Edited by KIRAN K K ON 26-11-15 FOR Issue id:2207
            ''Remove html encoding for page not required it on 7/12/2015 by Nilesh g
            ''strContents = CommonFunctions.General.BuildQueryString(Server.HtmlEncode(FreeTextBox.Text))
            strContents = CommonFunctions.General.BuildQueryString(Request("txtFreeTextBox"))
            'Commentd And Edited End by KIRAN K K ON 26-11-15 FOR Issue id:2207 
            strLabels = CommonFunctions.General.BuildQueryString(Request("txtLabels"))
            strSynopsis = CommonFunctions.General.BuildQueryString(Request("txtSynopsis"))

            If Not Request("chkEdit") Is Nothing Then
                strEditUserIDs = Request("txtEditUserIDs")
                blnRestrictEdit = True
            End If
            If Not Request("chkView") Is Nothing Then
                strViewUserIDs = Request("txtViewUserIDs")
                blnRestrictView = True
            End If

            strSQL = " usp_InsUpd_tbl_KM_CodeHeadings_Draft " & m_intPageID & "," & m_intQueryID & "," & m_lngUserId.ToString & ",N'" & strTitle & "',N'" & strContents & "',N'" & strLabels & "','" & strSynopsis & "'," & CStr(IIf(blnRestrictEdit, 1, 0)) & ",'" & strEditUserIDs & "'," & CStr(IIf(blnRestrictView, 1, 0)) & ",'" & strViewUserIDs & "'"
            m_intPageID = CommonFunctions.Data.GetDataScalar(strSQL, True)
            m_strMode = MODE_EDIT
            'End by SuchitraP

            ''added by RohiniK on 10 Nov 09
        ElseIf m_strAction.ToUpper = "ROLLBACK" Then
            Dim strTitle As String = ""
            Dim strContents As String = ""
            Dim strLabels As String = ""
            Dim strSynopsis As String = ""
            Dim strEditUserIDs As String = ""
            Dim strViewUserIDs As String = ""
            Dim RestrictView As Boolean = False
            Dim RestrictEdit As Boolean = False

            strSQL = "usp_sel_tbl_KM_CodeHeadings_History " & m_intPageID.ToString & "," & m_strVersionID

            drPageDetails = CommonFunctions.Data.GetDataReader(strSQL, True)
            If drPageDetails.Read Then
                strTitle = drPageDetails("ProcedureTitle")
                strSynopsis = CommonFunction.Data.CheckIsDBNull(drPageDetails("Synopsis"), "")
                strLabels = CommonFunction.Data.CheckIsDBNull(drPageDetails("Keywords"), "")
                strContents = CommonFunction.Data.CheckIsDBNull(drPageDetails("ProcedureCode"), "")
                m_strVersion = CommonFunction.Data.CheckIsDBNull(drPageDetails("ProcedureID"), "0")

                RestrictView = IIf(drPageDetails("RestrictViewAccess") Is DBNull.Value, False, drPageDetails("RestrictViewAccess"))
                RestrictEdit = IIf(drPageDetails("RestrictEditAccess") Is DBNull.Value, False, drPageDetails("RestrictEditAccess"))
            End If

            CommonFunction.Data.DisposeDataReader(drPageDetails)

            strTitle = strTitle.Replace("'", "''")
            strContents = strContents.Replace("'", "''")
            strLabels = strLabels.Replace("'", "''")
            strSynopsis = strSynopsis.Replace("'", "''")
            strSQL = " usp_Upd_tbl_KM_CodeHeadings_RollBack " & m_intPageID & "," & m_lngUserId.ToString & ",N'" & strTitle & "',N'" & strContents & "',N'" & strLabels & "','" & strSynopsis & "'"
            CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            ' m_intPageID = CommonFunctions.Data.GetDataScalar(strSQL, True)

            ' CommonFunction.General.WriteHTML("<script language='javascript'>")
            'CommonFunction.General.WriteHTML(" setTimeout(function() {   window.opener.location.href= '../KM/KM_MyPage.aspx?PageNumber=&txtSearch=&Fromwhere=Search&Mode=Edit&Myflag=2&EditClick=1&SpaceID=0&ActionLink=&PrimaryKey=&PageID=" & m_intPageID.ToString & "';    }, 20000);    } ")

            'CommonFunction.General.WriteHTML(" window.close(); ")

            Response.Write("<script language=javascript>")
            'Response.Write("refreshParent_Phases('frmKMMyPage','KM_MyPage.aspx.aspx','KM/KM_MyPage.aspx?ActionLink=&PageNumber=1&SpaceID=&Mode=Edit&Myflag=2&Fromwhere=MyArticle&PageID=486&txtSearch=',true);")
            ' Response.Write(" window.close(); ")
            ' Response.Write(" alert('asdasd') ")
            'Response.Write("function RefreshParent() {            if (window.opener != null && !window.opener.closed) {                window.opener.location.reload();            }        }")
            'Response.Write("window.onbeforeunload =RefreshParent);")
            ' Response.Write("</script>")
            If m_From = "KA" Then
                CommonFunction.General.WriteHTML(" window.opener.location.href= '../General/CommonList.aspx?MasterTagID=3992' ; ")
            Else

                CommonFunction.General.WriteHTML("window.opener.location.href = '../KM/KM_MyPage.aspx?PageNumber=&txtSearch=&Fromwhere=Search&Mode=Edit&Myflag=2&EditClick=1&SpaceID=0&ActionLink=&PrimaryKey=&PageID=" & m_intPageID.ToString & "';")
                CommonFunction.General.WriteHTML("window.close();")
                'CommonFunction.General.WriteHTML("alert( window.opener.location.href);")
                'CommonFunction.General.WriteHTML(" window.opener.location.href= '../KM/KM_MyPage.aspx?PageNumber=&txtSearch=&Fromwhere=Search&Mode=Edit&Myflag=2&EditClick=1&SpaceID=0&ActionLink=&PrimaryKey=&PageID=" & m_intPageID.ToString & "'; ")
                'Response.Write("window.opener.location.href= '../KM/KM_MyPage.aspx?PageNumber=&txtSearch=&Fromwhere=Search&Mode=Edit&Myflag=2&EditClick=1&SpaceID=0&ActionLink=&PrimaryKey=&PageID=" & m_intPageID.ToString & "';")
                ' Response.Write(" window.opener.location.href= '../KM/KM_MyPage.aspx?PageNumber=&txtSearch=&Fromwhere=Search&Mode=Edit&Myflag=2&EditClick=1&SpaceID=0&ActionLink=&PrimaryKey=&PageID=" & m_intPageID.ToString & "';")
                ' CommonFunction.General.WriteHTML(" window.opener.location.href= '../KM/KM_MyPage.aspx?PageNumber=&txtSearch=&Fromwhere=Search&Mode=Edit&Myflag=2&EditClick=1&SpaceID=0&ActionLink=&PrimaryKey=&PageID=" & m_intPageID.ToString & "'; ")
                '   CommonFunctions.General.WriteHTML("  window.top.location.reload();  window.close(); " + vbCrLf)
                ' CommonFunctions.General.WriteHTML(" refreshParent('frmKMMyPage','KM_MyPage.aspx','../KM/KM_MyPage.aspx?PageNumber=&txtSearch=&Fromwhere=Search&Mode=Edit&Myflag=2&EditClick=1&SpaceID=0&ActionLink=&PrimaryKey=&PageID=" & m_intPageID.ToString & "',true) " + vbCrLf)


                'Response.Redirect("../KM/KM_MyPage.aspx?PageNumber=&txtSearch=&Fromwhere=Search&Mode=Edit&Myflag=2&EditClick=1&SpaceID=0&ActionLink=&PrimaryKey=&PageID=" & m_intPageID.ToString & "")
            End If

            'CommonFunction.General.WriteHTML(" window.opener.location.href= 'KM_List.aspx?Fromwhere=LatestFeatured&SelectList=1'; ")
            'CommonFunction.General.WriteHTML("</script>")
            Response.Write("</script>")

            ''End of addition by RohiniK on 10 Nov 09
        End If
    End Sub
    Public Sub DrawControls()
        Dim IsPresent As String

        If m_intPageID <> 0 Then
            'Modification by SuchitraP on 4 July 2008
            'Purpose:To display the records saved in draft
            If m_strAction = ACTION_CRM_ARTICLESAVE Or Request("FromWhere") = "PublishKM" Then
                strSQL = "usp_Sel_tbl_KM_CodeHeadings_Draft Null," & m_intPageID.ToString
            ElseIf m_strAction.ToUpper = "HISTORY" Then
                IsPresent = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("SELECT 1 FROM tbl_KM_CodeHeadings_History WHERE ArticleID =" + m_intPageID.ToString, True), "0"), String)

                If IsPresent = "1" Then
                    strSQL = "usp_sel_tbl_KM_CodeHeadings_History " & m_intPageID.ToString & "," & m_strVersionID
                Else
                    strSQL = "SELECT * FROM tbl_KM_CodeHeadings WHERE ProcedureID = " & m_intPageID.ToString
                End If
            Else
                strSQL = "usp_Sel_tbl_KM_CodeHeadings_My Null," & m_intPageID.ToString
            End If
            'End by SuchitraP 
            drPageDetails = CommonFunctions.Data.GetDataReader(strSQL, True)
            If drPageDetails.Read Then
                ' Commented And Added By Bharat T on 24th-nov-2015 for SEM Upgrade Project module issue solving
                'm_strPageSubject = drPageDetails("ProcedureTitle")
                'm_strContents = CommonFunction.Data.CheckIsDBNull(drPageDetails("ProcedureCode"), "")

                m_strPageSubject = drPageDetails("ProcedureTitle")
                m_strContents = CommonFunction.Data.CheckIsDBNull(drPageDetails("ProcedureCode"), "")
                ' Commented And Added By Bharat T on 24th-nov-2015 for SEM Upgrade Project module issue solving
                strLabels = CommonFunction.Data.CheckIsDBNull(drPageDetails("Keywords"), "")
                ' Commented And Added By Bharat T on 24th-nov-2015 for SEM Upgrade Project module issue solving
                'm_strSynopsis = CommonFunction.Data.CheckIsDBNull(drPageDetails("Synopsis"), "")
                m_strSynopsis = CommonFunction.Data.CheckIsDBNull(drPageDetails("Synopsis"), "")
                'End of Commented And Added By Bharat T on 24th-nov-2015 for SEM Upgrade Project module issue solving
                blnRestrictView = IIf(drPageDetails("RestrictViewAccess") Is DBNull.Value, False, drPageDetails("RestrictViewAccess"))
                blnRestrictEdit = IIf(drPageDetails("RestrictEditAccess") Is DBNull.Value, False, drPageDetails("RestrictEditAccess"))
                ''added by RohiniK on 10 Nov 09
                m_strVersion = CommonFunction.Data.CheckIsDBNull(drPageDetails("ProcedureID"), "0")
                ''End of addition by RohiniK on 10 Nov 09
            End If
            'Commentd And Edited by KIRAN K K ON 26-11-15 FOR Issue id:2207
            'FreeTextBox.Text = m_strContents
            ''Remove html encoding for page not required it on 7/12/2015 by Nilesh g
            'FreeTextBox.Text = m_strContents
            '' FreeTextBox.Text = Server.HtmlEncode(m_strContents)
            'Commentd And Edited by KIRAN K K ON 26-11-15 FOR Issue id:2207 


        End If

        'CommonFunctions.General.WriteHTML("<div id=""DivMain"" style='OVERFLOW:auto;WIDTH:100%;HEIGHT:99.99%'>")

        If m_strAction.ToUpper = "HISTORY" And m_strMode = MODE_VIEW Then
            'CommonFunctions.General.WriteHTML("<TABLE id='tblCaption' cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>")
            'CommonFunctions.General.WriteHTML("<TR class=clsTRPageHeader>")
            'CommonFunctions.General.WriteHTML("<TD align=Left>Show History</TD>")
            'CommonFunctions.General.WriteHTML("<TD align=Right>Version No : " + drPageDetails("ProcedureID").ToString + "</TD>")
            'CommonFunctions.General.WriteHTML("</TR>")
            'CommonFunctions.General.WriteHTML("</TABLE>")
            If IsPresent = "1" Then
                WebPage.Templates.PageCaption.GetPageCaptions(, "Versions", "Version No. : " + drPageDetails("ProcedureID").ToString)
            Else
                WebPage.Templates.PageCaption.GetPageCaptions(, "Versions", "Version No. : 0.0")
            End If

            CommonFunctions.General.WriteHTML("<BR>")
        End If

        CommonFunctions.General.WriteHTML("<table  CellSpacing=0 class='clsTable' id=""tblMain"" width=""99.99%"">")

        CommonFunctions.General.WriteHTML("<tr class='clsTRBody'>")
        CommonFunctions.General.WriteHTML("<td valign=top align=right nowrap>")
        If m_strMode = MODE_VIEW Then
            CommonFunctions.General.WriteHTML("Article Name : </td><td>")
        Else
            CommonFunctions.General.WriteHTML("Article Name </td><td>")
        End If
        If m_strMode = MODE_VIEW Then
            ''Commented and added By Nikhil A on 28-jan-2016 for Html Encoding
            CommonFunction.General.WriteHTML(Server.HtmlEncode(m_strPageSubject))
            'CommonFunction.General.WriteHTML(m_strPageSubject)
            ''End of Added by Nikhil A on 28-jan-2016 for Html Encoding
        Else
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            ''CommonFunctions.HTMLControls.DrawTextBox("txtTitle", "txtTitle", "clsTextBox", 400, 50, m_strPageSubject, "left", , , , , , , , True)
            CommonFunctions.HTMLControls.DrawTextBox("txtTitle", "txtTitle", "clsTextBox", 400, 50, m_strPageSubject, "left", , , , , , , , True, EnableHTMLEncode:=True)
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        End If

        CommonFunctions.General.WriteHTML("</td></tr>")


        If m_strMode = MODE_VIEW Then
            CommonFunctions.General.WriteHTML("<tr class='clsTRBody'><td valign=top align=right>Synopsis : </td><td>")
            ''Commented and added By Nikhil A on 28-jan-2016 for Html Encoding
            CommonFunction.General.WriteHTML(Server.HtmlEncode(m_strSynopsis))
            'CommonFunction.General.WriteHTML(m_strSynopsis)
            ''End of Added by Nikhil A on 28-jan-2016 for Html Encoding
        Else
            CommonFunctions.General.WriteHTML("<tr class='clsTRBody'><td valign=top align=right>Synopsis</td><td>")
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            ''CommonFunctions.HTMLControls.DrawTextArea("txtSynopsis", "txtSynopsis", "Synopsis", "clsTextArea", "opentextdialog", "frmKMMyPage", "../../images/zoomin.gif", maxLength:=2000, value:=m_strSynopsis, widthInPixel:=400, heightInPixel:=80, IsMandatory:=True)
            ''Remove html encoding for page not required it on 7/12/2015 by Nilesh g
            ''CommonFunctions.HTMLControls.DrawTextArea("txtSynopsis", "txtSynopsis", "Synopsis", "clsTextArea", "opentextdialog", "frmKMMyPage", "../../images/zoomin.gif", maxLength:=2000, value:=m_strSynopsis, widthInPixel:=400, heightInPixel:=80, IsMandatory:=True, EnableHTMLEncode:=True)
            CommonFunctions.HTMLControls.DrawTextArea("txtSynopsis", "txtSynopsis", "Synopsis", "clsTextArea", "opentextdialog", "frmKMMyPage", "../../images/zoomin.gif", maxLength:=2000, value:=m_strSynopsis, widthInPixel:=400, heightInPixel:=80, IsMandatory:=True, EnableHTMLEncode:=True)
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        End If
        CommonFunctions.General.WriteHTML("</td></tr>")

        If m_strAction.ToUpper = "HISTORY" And m_strMode = MODE_VIEW Then
            CommonFunctions.General.WriteHTML("<tr class='clsTRBody'><td valign=top align=right>Keywords : </td><td>")
            ''Commented and added By Nikhil A on 28-jan-2016 for HTMl Encode issue
            'CommonFunction.General.WriteHTML(strLabels)
            CommonFunction.General.WriteHTML(Server.HtmlEncode(strLabels))
            ''End of Commented and added By Nikhil A on 28-jan-2016 for HTMl Encode issue

            CommonFunctions.General.WriteHTML("</td></tr>")
        End If
        CommonFunction.Data.DisposeDataReader(drPageDetails)
        'CommonFunctions.General.WriteHTML("</td></tr>")
    End Sub
    Public Sub WritePage()



        If m_strMode = MODE_VIEW Then
        Else
            CommonFunctions.General.WriteHTML("<tr class='clsTRBody'><td valign=top style='text-align:right'>Search Labels</td><td>")
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            ''Remove html encoding for page not required it on 7/12/2015 by Nilesh g
            '' CommonFunctions.HTMLControls.DrawTextArea("txtLabels", "txtLabels", "Labels", maxLength:=100, value:=strLabels, widthInPixel:=400, heightInPixel:=100, IsMandatory:=True)
            CommonFunctions.HTMLControls.DrawTextArea("txtLabels", "txtLabels", "Labels", maxLength:=100, value:=strLabels, widthInPixel:=400, heightInPixel:=100, IsMandatory:=True, EnableHTMLEncode:=True)
            'CommonFunctions.HTMLControls.DrawTextArea("txtLabels", "txtLabels", "Labels", maxLength:=100, value:=strLabels, widthInPixel:=400, heightInPixel:=100, IsMandatory:=True)
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

            CommonFunctions.General.WriteHTML("</td></tr>")

            PlotAccessBlock(blnRestrictEdit, blnRestrictView)
        End If

        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("<input type=hidden name='hidSpaceID' id='hidSpaceID' value='" + m_strSpaceID + "'>")
        CommonFunctions.General.WriteHTML("<input type=hidden name='hidFrom' id='hidFrom' value='" + m_strFrom + "'>")

        PlotHiddenControls()

        DrawAttachmentSection()
        'CommonFunctions.General.WriteHTML("</div>")



    End Sub
    Private Sub PlotAccessBlock(ByVal blnRestrictEdit As Boolean, ByVal blnRestrictView As Boolean)
        Dim strEditUsers As String = ""
        Dim strEditUserIDs As String = ""

        Dim strViewUsers As String = ""
        Dim strViewUserIDs As String = ""

        Dim strSQL As String
        Dim drAccessUsers As IDataReader

        If m_intPageID > 0 And (blnRestrictEdit = True Or blnRestrictView = True) Then
            'Modification by SuchitraP on 4 July 2008
            'Purpose:To display the records saved in draft
            If m_strAction = ACTION_CRM_ARTICLESAVE Then
                strSQL = "Exec usp_Sel_tbl_KM_Articles_RestrictedUserGroups_Draft " & m_intPageID
            Else
                strSQL = "Exec usp_Sel_tbl_KM_Articles_RestrictedUserGroups " & m_intPageID
            End If
            'End by SuchitraP
            drAccessUsers = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
            If drAccessUsers.Read Then
                strEditUsers = drAccessUsers("EditUsers")
                strEditUserIDs = drAccessUsers("EditUserIDs")
                strViewUsers = drAccessUsers("ViewUsers")
                strViewUserIDs = drAccessUsers("ViewUserIDs")
            End If
            CommonFunction.Data.DisposeDataReader(drAccessUsers)

        End If
        ''Response.Write("<TABLE valign=bottom class='clsTable'  CellSpacing='0' CellPadding=0  width=99.99% height=100%>")

        ''CommonFunctions.General.WriteHTML("<tr class='clsTRBody'><TD id='TD_Left'style='width:50%;border:0px solid #ccc;' valign='top'>")

        ''Response.Write("<TABLE valign=bottom class='clsTable'  CellSpacing='0' CellPadding=0  width=99.99% height=100%>")

        CommonFunctions.General.WriteHTML("<tr class='clsTRBody'><td valign=top align=right>Allow Edit</td><td>")
        CommonFunctions.HTMLControls.DrawCheckBox("chkEdit", "chkEdit", , blnRestrictEdit, ToBeInserted:="Onclick=""ShowHideTr('tr_EditUsers',this)""")
        CommonFunctions.General.WriteHTML("</td></tr>")
        ''Commented and Added By Vidya J ON 22 Aug 2016
        ' CommonFunctions.General.WriteHTML("<tr id='tr_EditUsers' class='clsTRBody'><td valign=top align=right><a  Href=""javascript:UserSelection_Onclick('Edit')"">Users</a></td><td>")
        CommonFunctions.General.WriteHTML("<tr id='tr_EditUsers' class='clsTRBody'><td valign=top align=right><a style='text-decoration:underline;color:#428bca' Href=""javascript:UserSelection_Onclick('Edit')"">Users</a></td><td>")
        ''End Of Commented and Added By Vidya J ON 22 Aug 2016
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        'CommonFunctions.HTMLControls.DrawTextArea("txtEditUsers", "txtEditUsers", "Users", value:=strEditUsers, widthInPixel:=400, heightInPixel:=100, IsReadonly:=True)
        'CommonFunctions.HTMLControls.DrawTextBox("txtEditUserIDs", "txtEditUserIDs", value:=strEditUserIDs, IsHidden:=True)
        CommonFunctions.HTMLControls.DrawTextArea("txtEditUsers", "txtEditUsers", "Users", value:=strEditUsers, widthInPixel:=400, heightInPixel:=100, IsReadonly:=True, EnableHTMLEncode:=True)
        'CommonFunctions.HTMLControls.DrawTextArea("txtEditUsers", "txtEditUsers", "Users", value:=strEditUsers, widthInPixel:=400, heightInPixel:=100, IsReadonly:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtEditUserIDs", "txtEditUserIDs", value:=strEditUserIDs, IsHidden:=True, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        CommonFunctions.General.WriteHTML("</td></tr>")


        'CommonFunctions.General.WriteHTML("</td></tr></Table></td></tr></table>")

    End Sub
    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub

    Private Sub InitializePageLegend()
        Dim arrLegends(0) As String
        Dim arrLegendImg(0) As String
        arrLegends(0) = "&nbsp;Mandatory"
        arrLegendImg(0) = CommonFunctions.HTMLControls.DrawMandatoryImage(, True)
        m_strLegends = WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImg, arrLegends, True)
    End Sub
    Private Sub InitializeMenu()
        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips

        'Addition by SuchitraP on 4 July 2008
        'Purpose: To show Submit link when page opened from helpdesk
        Dim strSQL As String
        Dim drArticle As IDataReader
        Dim PKToken_ProcedureID As String


        If m_strAction.ToUpper <> "HISTORY" Then
            If m_strSpaceID = "NULL" Then
                m_strSpaceID = "0"
            End If

            If m_intQueryID <> 0 Then
                strSQL = "SELECT * FROM tbl_KM_CodeHeadings_Draft WHERE QueryID=" + m_intQueryID.ToString
                drArticle = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

                If m_strMode <> MODE_VIEW Then

                    If drArticle.Read Then
                        ArrMenuCaptionsList.Add("Submit")
                        ArrMenuToolTipsList.Add("Submit")
                        ArrClientSideFunctionsList.Add("Submit_OnClick()")
                    End If

                    ArrMenuCaptionsList.Add("Save")
                    ArrMenuToolTipsList.Add("Save")
                    ArrClientSideFunctionsList.Add("CRMSave_OnClick()")

                End If
            End If

            CommonFunction.Data.DisposeDataReader(drArticle)
            'ArrMenuCaptionsList.Add("Save")
            'ArrMenuToolTipsList.Add("Save")
            'ArrClientSideFunctionsList.Add("Save_OnClick()")
            If m_strMode <> MODE_VIEW Then
                If m_intQueryID = 0 Then
                    ArrMenuCaptionsList.Add("Save")
                    ArrMenuToolTipsList.Add("Save")
                    ArrClientSideFunctionsList.Add("Save_OnClick()")
                End If
            End If
            'End of addition by SuchitraP

            If m_intPageID <> 0 Then
                'Dim ArticleRating As Integer = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_tbl_KM_ArticleRating " + m_intPageID.ToString() + "," + m_lngUserId.ToString(), MyBase.UseSQL), "0"), "0"), Integer)
                'If ArticleRating = 0 Then
                ArrMenuCaptionsList.Add("Rate This Article")
                ArrMenuToolTipsList.Add("Rate This Article")
                ArrClientSideFunctionsList.Add("RateArticle()")

                'Chakshuta
                'PKToken_ProcedureID = CommonFunctions.Security.Token.GetToken(CType(m_intPageID, String))
                PKToken_ProcedureID = CommonFunctions.Security.Token.GetToken(CType(m_intPageID, String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0")
                'Chakshuta

                ArrMenuCaptionsList.Add("Post Comment")
                ArrMenuToolTipsList.Add("Post Comment")
                ArrClientSideFunctionsList.Add("PostComment(" + m_intPageID.ToString + ",'" + PKToken_ProcedureID + "')")

                'End If
                If m_strMode <> MODE_VIEW Then
                    ArrMenuCaptionsList.Add("Show Versions")
                    ArrMenuToolTipsList.Add("Show Versions")
                    ArrClientSideFunctionsList.Add("ShowHistory(" + m_intPageID.ToString + ",'" + PKToken_ProcedureID + "')")

                    ArrMenuCaptionsList.Add("Add Attachment")
                    ArrMenuToolTipsList.Add("Add Attachment")
                    ArrClientSideFunctionsList.Add("AddAttachment()")

                    ArrMenuCaptionsList.Add("Delete Attachment")
                    ArrMenuToolTipsList.Add("Delete Attachment")
                    ArrClientSideFunctionsList.Add("DelAttachment()")
                End If
            End If

            If CommonFunction.General.CheckIsNothing(m_strSpaceID, "0") <> "0" Then
                ArrMenuCaptionsList.Add("Close")
                ArrMenuToolTipsList.Add("Close")
                ArrClientSideFunctionsList.Add("Close_OnClick()")
            End If

            If CommonFunction.General.CheckIsNothing(m_strSpaceID, "0") = "0" Then
                ArrMenuCaptionsList.Add("Back")
                ArrMenuToolTipsList.Add("Back")
                ArrClientSideFunctionsList.Add("Back_OnClick('" + m_strFromWhere + "'," + m_intPageID.ToString + ")")
            End If

        Else
            PKToken_ProcedureID = CommonFunctions.Security.Token.GetToken(m_intPageID.ToString)

            ''added by RohiniK on 10 Nov 09
            Dim IsPresent As String
            IsPresent = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("SELECT 1 FROM tbl_KM_CodeHeadings_History WHERE ArticleID =" + m_intPageID.ToString, True), "0"), String)

            If IsPresent = 1 Then
                ArrMenuCaptionsList.Add("Get This Version")
                ArrMenuToolTipsList.Add("Get This Version")
                ArrClientSideFunctionsList.Add("Rollback_OnClick(" + m_intPageID.ToString + ",'" + PKToken_ProcedureID + "')")
            End If
            ''End of addition by RohiniK on 10 Nov 09

            ArrMenuCaptionsList.Add("Back")
            ArrMenuToolTipsList.Add("Back")
            ArrClientSideFunctionsList.Add("HistoryBack_OnClick(" + m_intPageID.ToString + ",'" + PKToken_ProcedureID + "')")

            ArrMenuCaptionsList.Add("Close")
            ArrMenuToolTipsList.Add("Close")
            ArrClientSideFunctionsList.Add("Close_OnClick()")
        End If

        ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>")
        ArrMenuToolTipsList.Add("Help")
        ArrClientSideFunctionsList.Add("Help_OnClick('3959')")


        Dim ArrMenuCaptions(ArrMenuCaptionsList.Count - 1) As String
        ArrMenuCaptionsList.ToArray.CopyTo(ArrMenuCaptions, 0)
        ArrMenuCaptionsList = Nothing

        'Convert arraylist to array - Client side functions
        Dim ArrClientSideFunctions(ArrClientSideFunctionsList.Count - 1) As String
        ArrClientSideFunctionsList.ToArray.CopyTo(ArrClientSideFunctions, 0)
        ArrClientSideFunctionsList = Nothing

        'Convert arraylist to array - Menu tooltips
        Dim ArrMenuToolTips(ArrMenuToolTipsList.Count - 1) As String
        ArrMenuToolTipsList.ToArray.CopyTo(ArrMenuToolTips, 0)
        ArrMenuToolTipsList = Nothing

        m_objMenu = New WebPage.Templates.StaticMenu
        m_strMenu = m_objMenu.DrawMenuWithEvents(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True)
        m_objMenu = Nothing

        'm_strSpaceID = "NULL"

    End Sub

    Private Sub DrawAttachmentSection()
        Dim strSQL As String
        Dim drAttachments As IDataReader
        Dim blnOddEven As Boolean = False
        Dim strTRClass As String
        Dim strSearchText As String = ""
        'Dim strListHeadCaption As String
        Dim strEditFunctionName As String
        Dim blnRecordExixts As Boolean = False
        Dim intRecordNo As Integer = 0

        If m_intPageID <= 0 Then
            Return
        End If
        strSQL = "usp_Sel_tbl_KM_Attachments " & m_intPageID.ToString

        Response.Write("<br>")
        Response.Write(WebPages.Template.PageCaption.GetPageCaptions(, "Attachments", , , True))
        Response.Write("<br>")

        Response.Write("<DIV Id=divAttachment Style='HEIGHT:200px;OVERFLOW:auto; WIDTH:100%'>")
        CommonFunctions.General.WriteHTML("<Table ID=tblAttachments width='99.9%'  CellSpacing=1 CellPadding=0  class='clsGridTable' >")

        CommonFunctions.General.WriteHTML("<THEAD class=clsTRColumnHeader>")
        CommonFunctions.General.WriteHTML("<TH ALIGN='Left' class='divListTag' >Sr No.</TH>")
        CommonFunctions.General.WriteHTML("<TH ALIGN='Left' class='divListTag' >File Name</TH>")
        CommonFunctions.General.WriteHTML("<TH ALIGN='Left' class='divListTag' >Attached By</TH>")
        CommonFunctions.General.WriteHTML("<TH ALIGN='Left' class='divListTag' >Upload Date</TH>")
        CommonFunctions.General.WriteHTML("<TH ALIGN='Left' class='divListTag' >Description</TH>")
        If m_strMode = MODE_VIEW Then

        Else
            CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' >Delete</TH>")
        End If

        CommonFunctions.General.WriteHTML("</THEAD>")

        drAttachments = CommonFunctions.Data.GetDataReader(strSQL, True)
        While drAttachments.Read()
            blnRecordExixts = True
            intRecordNo = intRecordNo + 1

            blnOddEven = Not blnOddEven
            If blnOddEven = True Then
                strTRClass = "clsTREven"
            Else
                strTRClass = "clsTROdd"
            End If
            CommonFunctions.General.WriteHTML("<Tr class=" & strTRClass & ">")
            CommonFunctions.General.WriteHTML("<td>" + intRecordNo.ToString + "</td>")
            'CommonFunctions.General.WriteHTML("<td><a href='Javascript:Show_File(""" & CommonFunction.Data.CheckIsDBNull(drAttachments("Originalfilename"), "") & """,""" + CommonFunction.Data.CheckIsDBNull(drAttachments("Attachments"), "") + """ )'>" & CommonFunction.Data.CheckIsDBNull(drAttachments("Originalfilename"), "") & " </a></td>")
            'Code added by KapilK on 17-jul-09 [RequestID:21816 parameter added "strOriginalFileName"]
            CommonFunctions.General.WriteHTML("<td><a href='Javascript:Show_File(""" & drAttachments("Attachments") & """,""" & drAttachments("Originalfilename") & """)'>" & drAttachments("Originalfilename") & " </a></td>")
            'End;Code added by KapilK on 17-jul-09 [RequestID:21816 parameter added "strOriginalFileName"]
            CommonFunctions.General.WriteHTML("<td>" & CommonFunction.Data.CheckIsDBNull(drAttachments("AttachedBy"), "") & "</td>")
            CommonFunctions.General.WriteHTML("<td>" & CommonFunction.Data.CheckIsDBNull(drAttachments("AttachedDate"), "") & "</td>")
            'Commented And Added By Vaijat K ON 08/12/2015 Issue ID-2556
            'CommonFunctions.General.WriteHTML("<td>" & CommonFunction.Data.CheckIsDBNull(drAttachments("Description"), "") & "</td>")
            CommonFunctions.General.WriteHTML("<td>" & HttpUtility.HtmlEncode(CommonFunction.Data.CheckIsDBNull(drAttachments("Description"), "")) & "</td>")
            If m_strMode = MODE_VIEW Then

            Else

                CommonFunctions.General.WriteHTML("<td align=center>")
                CommonFunctions.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", value:=drAttachments("AttachmentID"))
                CommonFunctions.General.WriteHTML("</td>")
            End If
            CommonFunctions.General.WriteHTML("</tr>")
            'CommonFunctions.General.WriteHTML("<tr class=" & strTRClass & "><td >&nbsp;&nbsp;&nbsp;</td>")
            'CommonFunctions.General.WriteHTML("<td colspan=2>" & drPages("Keywords") & "</td><td>&nbsp;</td></tr>")

        End While
        CommonFunction.Data.DisposeDataReader(drAttachments)

        If blnRecordExixts = False Then
            CommonFunctions.General.WriteHTML("<Tr class=clsTREven><td colspan=6 Align=center>There are no items to view in this view</td></tr>")
        End If
        CommonFunctions.General.WriteHTML("</Table>")
        CommonFunctions.General.WriteHTML("</DIV>")

    End Sub

    Protected Sub StyleSheetCreation()
        Dim sbStyle As New System.Text.StringBuilder
        Dim strStyle As String = ""
        Dim strBGLightcolor As String


        sbStyle.Append("<style>")
        sbStyle.Append("td.FreeTextBox_StartTabOn {	font: 10pt MS Sans Serif;	padding:1px;	border-left: 1 solid <BGLightColor>;	border-right: 1 solid <BGLightColor>;	border-top: 1 solid <BGLightColor>;	border-bottom: 1 solid <BGLightColor>;	background-color: <BGLightColor>;}")
        sbStyle.Append("td.FreeTextBox_StartTabOff {font: 10pt MS Sans Serif;	padding:1px;	border-left: 1 solid <BGLightColor>;	border-right: 1 solid <BGLightColor>;	border-top: 1 solid <BGLightColor>;	border-bottom: 1 solid <BGLightColor>;	background-color: <BGLightColor>;}")
        sbStyle.Append("td.FreeTextBox_TabOn {	font: 8pt MS Sans Serif;	padding:1px;	padding-left:5px;	padding-right:5px;	border-left: 1 solid <BGLightColor>;	border-right: 1 solid <BGLightColor>;	border-top: 1 solid #D4D0C8;	border-bottom: 1 solid <BGLightColor>;	background-color: <BGLightColor>;}")
        sbStyle.Append("td.FreeTextBox_TabOffRight {	font: 8pt MS Sans Serif;	padding:1px;	padding-left:5px;	padding-right:5px;	border-left: 1 solid <BGLightColor>;	border-right: 1 solid <BGLightColor>;	border-top: 1 solid <BGLightColor>;	border-bottom: 1 solid <BGLightColor>;	background-color: <BGLightColor>;}")
        sbStyle.Append("td.FreeTextBox_TabOffLeft {	font: 8pt MS Sans Serif;	padding:1px;	padding-left:5px;	padding-right:5px;	border-left: 1 solid <BGLightColor>;	border-right: 1 solid <BGLightColor>;	border-top: 1 solid <BGLightColor>;	border-bottom: 1 solid #D4D0C8;	background-color: <BGLightColor>;}")
        sbStyle.Append("td.FreeTextBox_EndTab {	font: 10pt MS Sans Serif;	width: 100%;	padding:1px;	border-left: 1 solid <BGLightColor>;	border-right: 1 solid <BGLightColor>;	border-top: 1 solid <BGLightColor>;	border-bottom: 1 solid <BGDarkColor>;	background-color: <BGDarkColor>;}")
        sbStyle.Append("td.FreeTextBox_None {}")
        sbStyle.Append("td.FreeTextBox_ButtonNormal {	border: 1 solid <BGLightColor>;	background-color:  <BGLightColor>;	font-family: MS Sans Serif;	font-size: 10pt;}")
        sbStyle.Append("td.FreeTextBox_ButtonOver {	border-top: 1 solid #3169C6;		border-left: 1 solid #3169C6;	border-right: 1 solid #3169C6;	border-bottom: 1 solid #3169C6;	background-color: #B6BDD2;	font-family: MS Sans Serif;	font-size: 10pt;}")
        sbStyle.Append("td.FreeTextBox_ButtonDown {	border-top: 1 solid #3169C6;		border-left: 1 solid #3169C6;	border-right: 1 solid #3169C6;	border-bottom: 1 solid #3169C6;	background-color: #8592B5;	font-family: MS Sans Serif;	font-size: 10pt;}")
        sbStyle.Append("div.FreeTextBox_Toolbar {	margin-bottom: 1px;	margin-right: 2px;	float: left;	background-color: <BGLightColor>;}")
        sbStyle.Append("iframe.FreeTextBox_iframe {	width:100%;	height:100%;	border-right: 1 solid <BGLightColor>;	border-left: 1 solid <BGLightColor>;	border-top: 1 solid <BGLightColor>;	border-bottom: 1 solid <BGLightColor>;	frameBorder: 0;}")
        'sbStyle.Append("body.FTB {	scrollbar-3dlight-color: #D4D0C8;	scrollbar-arrow-color: #000000;	scrollbar-base-color: #D4D0C8;	scrollbar-darkshadow-color: #D4D0C8;	scrollbar-face-color: ##D4D0C8;	scrollbar-highlight-color: #808080;	scrollbar-shadow-color: #808080;	scrollbar-track-color: #D4D0C8;}")
        sbStyle.Append("</style>")


        Select Case m_lngStylesheetID
            Case 2
                strBGLightcolor = "#f9efea"
                m_strBGDarkcolor = "#f0d8ce"
            Case 3
                strBGLightcolor = "#fbecd5"
                m_strBGDarkcolor = "#f5debe"
            Case 4
                strBGLightcolor = "#e0e7ef"
                m_strBGDarkcolor = "#dce1d0"
            Case 5
                strBGLightcolor = "#efebfa"
                m_strBGDarkcolor = "#dbd5ec"
            Case 6
                strBGLightcolor = "#fefae9"
                m_strBGDarkcolor = "#f9ecb6"

            Case 7
                strBGLightcolor = "#e8f4f6"
                m_strBGDarkcolor = "#cbe7eb"
                'added by parag patil ON 21 NOV 2013 For PMLifeline Default style
            Case 8
                strBGLightcolor = "#B8B9BC"
                'm_strBGDarkcolor = "#B8B9BC"
                m_strBGDarkcolor = "#7F8388"
            Case 9
                strBGLightcolor = "#E6E6E7"
                m_strBGDarkcolor = "#808080"
                'End OF added by parag patil ON 21 NOV 2013 For PMLifeline Default style
            Case Else
                'Commented and added by parag patil ON 21 NOV 2013 For PMLifeline Default style
                'm_strBGDarkcolor = "#d3e5fc"
                'strBGLightcolor = "#eef6ff"
                strBGLightcolor = "#fbecd5"
                m_strBGDarkcolor = "#f5debe"
                'Commented and added by parag patil ON 21 NOV 2013 For PMLifeline Default style
        End Select
        strStyle = sbStyle.ToString()
        strStyle = strStyle.Replace("<BGLightColor>", strBGLightcolor)
        strStyle = strStyle.Replace("<BGDarkColor>", m_strBGDarkcolor)
        CommonFunctions.General.WriteHTML(strStyle)

    End Sub

    ''Added by Dhanashri S on 29 Mar 2016 Purpose:to generate and validate Token
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateCommentToken(ProcedureID As String, EmployeeID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(ProcedureID, String) + CType(EmployeeID, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of Addition by Dhanashri S on 29 Mar 2016

    ''Added by Vidya J on 29-Mar-2016  to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateToken_RateArticle(ProcedureID As String, EmployeeID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(ProcedureID, String) + CType(EmployeeID, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of addition by Vidya J on 29-Mar-2016
   
End Class
