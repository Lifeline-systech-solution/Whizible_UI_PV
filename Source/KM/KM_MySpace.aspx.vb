Public Class KM_MySpace
    Inherits WebPages.Template.WhizTemplate
#Region " Constant Variables "
    Protected Const ACTION_SAVE As String = "SAVE"
    Protected Const MODE_NEW As String = "NEW"
    Protected Const MODE_EDIT As String = "EDIT"
#End Region
#Region " Global Variables "
    Protected m_intSpaceID As Integer = 0
    Protected m_strMode As String = "EDIT"
    Protected m_strAction As String = ""
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_lngUserId As Long = 0
    Private m_lngPostId As Long = 0
    'Addition by SuchitraP on 25-Aug-2008 to get the TeamID when Pages are created from My Team
    Protected m_strTeamID As String
    Protected m_strSubTab As String
    Protected m_strFrom As String
    Protected blnflag As Boolean
    Protected m_strFromWhere As String = ""
    Protected m_strtxtSearch As String = ""
    Protected m_strPagingNumber As String = ""
    Private strFlag As String = ""
    Protected strSpaceNameDB As String = ""
    Private drSpaceName As IDataReader
    Protected flag As String = "1"
    Protected m_strPopup As String
    Protected m_strActionLink As String
    Protected m_strPrimaryKey As String
    'End by SuchitraP
    Private m_blnValidate As Boolean = True
#End Region
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
        'Commented By Nikita on 22-Jan-2016 for Session Expire issue on Myspaces
        ''commented by nilesh g on 31/12/2015 for Security
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
        ''end of commented by nilesh g on 31/12/2015 for Security
        'End Commented By Nikita on 22-Jan-2016 for Session Expire issue on Myspaces
        'Put user code to initialize the page here
        InitPage()

        ''Added by Dhanashri S on 29 Mar 2016
        'If (Request.QueryString("PKSpaceToken") <> "" And Request.QueryString("SpaceID") <> "" And Request.QueryString("TeamID") <> "") Then
        '    If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("SpaceID"), String) + CType(Request.QueryString("TeamID"), String) + "0" + "0", Request.QueryString("PKSpaceToken")) = False) Then

        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("SpaceID"), String))
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    End If
        'End If
        ''End of Addition by Dhanashri S on 29 MAr 2016
        'Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
        If (Request.QueryString("FromWhere")) = "MyTeam" Or (Request.QueryString("FromWhere") = "LatestFeatured" And Request.QueryString("Subtab") = "MY TEAM") Then

            'If (Request.QueryString("PKToken") = "" And HttpContext.Current.Session("intUserID").ToString <> "0") And Request.QueryString("Action") <> "SAVE" Then
            '    m_blnValidate = False
            '    'ElseIf Request.QueryString("Action") <> "SAVE" And (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("TeamID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0", Request.QueryString("PKToken")) = False) Then
            '    '    m_blnValidate = False         
            'End If
            'If Request.QueryString("SpaceID") <> "" Then
            '    If Request.QueryString("Action") <> "SAVE" And (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("SpaceID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0" + CType(Request.QueryString("TeamID"), String), Request.QueryString("PKToken")) = False) Then
            '        m_blnValidate = False
            '    End If
            'ElseIf Request.QueryString("SpaceID") = "" Then
            '    If Request.QueryString("Action") <> "SAVE" And (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("TeamID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0", Request.QueryString("PKToken")) = False) Then
            '        m_blnValidate = False
            '    End If
            'End If
            'If (Request.QueryString("PKToken") = "" And HttpContext.Current.Session("intUserID").ToString <> "0") And Request.QueryString("Action") <> "SAVE" Then
            '    m_blnValidate = False
            ''Updated by Dhanashri S on 19 Aug 2016 Purpose:Mastercard NxtGen Upgrade Issue Fixing
            If Request.QueryString("Myflag") = "2" And Request.QueryString("Action") <> "SAVE" And Request.QueryString("Action") <> "DELETE_PAGES" And Request.QueryString("Mode") <> "EDIT" And (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("SpaceID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0" + CType(Request.QueryString("TeamID"), String), Request.QueryString("PKToken")) = False) Then
                ''End of updation by Dhanashri S on 19 Aug 2016
                m_blnValidate = False
                'ElseIf Request.QueryString("Myflag") = "2" And Request.QueryString("Action") <> "SAVE" And (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("TeamID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0", Request.QueryString("PKToken")) = False) Then
                '    m_blnValidate = False
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
        '' CommonFunctions.HTMLControls.DrawTextBox("txtPK", "txtPK", , , , CStr(m_intSpaceID), IsHidden:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtPK", "txtPK", , , , CStr(m_intSpaceID), IsHidden:=True, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        CommonFunction.General.WriteHTML("<input type=hidden name=hidFromwhere id=hidFromwhere value=" + Request.QueryString("Fromwhere") + ">" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidtxtSearch id=hidtxtSearch value=" + Request.QueryString("txtSearch") + ">" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidtxtPageNumber id=hidtxtPageNumber value=" + Request.QueryString("PageNumber") + ">" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidFlag id=hidFlag value=" + Request.QueryString("Flag") + ">" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidSpaceName id=hidSpaceName value='" + strSpaceNameDB + "'>" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidSubTab id=hidSubTab value='" + Request.QueryString("Subtab") + "'>" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidMode id=hidMode value=" + Request.QueryString("Mode") + ">" + vbCrLf)
        'hidMyflag
        CommonFunction.General.WriteHTML("<input type=hidden name=hidMyflag id=hidMyflag value=" + Request.QueryString("MyFlag") + ">" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidPopup id=hidPopup value=" + Request.QueryString("Popup") + ">" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidActionLink id=hidActionLink value=" + Request.QueryString("ActionLink") + ">" + vbCrLf)
    End Sub
    Private Sub InitPage()
       
        If Not Request("Action") Is Nothing Then
            m_strAction = CStr(Request("Action"))
        End If

        If Not Request("SpaceID") Is Nothing Then
            m_intSpaceID = CInt(Request("SpaceID"))
        Else
            If Not Request("txtPK") Is Nothing Then
                m_intSpaceID = CInt(Request("txtPK"))
            End If
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "") <> "" Then
            m_strMode = Request.QueryString("Mode").ToUpper
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidMode"), "") <> "" Then
            m_strMode = Request.Form("hidMode").ToUpper
        End If


        m_lngUserId = Session("intUserID")
        m_lngPostId = Session("intPostID")

        'Addition by SuchitraP on 25-Aug-2008 to get the TeamID when Pages are created from My Team
        If Not Request.QueryString("From") Is Nothing Then
            If Request.QueryString("From").ToUpper = "MANAGE" Then
                m_strFrom = Request.QueryString("From")
            Else
                m_strFrom = Request.QueryString("From")
            End If
        Else
            m_strFrom = Request.Form("hidFrom")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("TeamID"), "") <> "" Then
            m_strTeamID = Request.QueryString("TeamID")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidTeamID"), "") <> "" Then
            m_strTeamID = Request.Form("hidTeamID").ToString
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("Popup"), "") <> "" Then
            m_strPopup = Request.QueryString("Popup")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidPopup"), "") <> "" Then
            m_strPopup = Request.Form("hidPopup")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("Subtab"), "") <> "" Then
            m_strSubTab = Request.QueryString("Subtab")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidSubTab"), "") <> "" Then
            m_strSubTab = Request.Form("hidSubTab")
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

        If CommonFunction.General.CheckIsNothing(Request.QueryString("Flag"), "") <> "" Then
            strFlag = Request.QueryString("Flag")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidFlag"), "") <> "" Then
            strFlag = Request.Form("hidFlag")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("Myflag"), "") <> "" Then
            flag = Request.QueryString("Myflag")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidMyflag"), "") <> "" Then
            flag = Request.Form("hidMyflag")
        End If

        'drSpaceName = CommonFunction.Data.GetDataReader("SELECT SpaceName FROM tbl_KM_Space WHERE AuthorID=" + HttpContext.Current.Session("intUserID").ToString + " ORDER BY 1 ", MyBase.UseSQL)
        'To check duplication accross all logins
        drSpaceName = CommonFunction.Data.GetDataReader("SELECT LTRIM(RTRIM(SpaceName)) SpaceName FROM tbl_KM_Space ORDER BY 1 ", MyBase.UseSQL)
        While drSpaceName.Read
            strSpaceNameDB = strSpaceNameDB + "," + drSpaceName("SpaceName").ToString
        End While
        'Commented And Edited By Yogesh J for cross scripting 20-11-15 
        '    strSpaceNameDB = strSpaceNameDB.Replace("'", "@") + ","
        strSpaceNameDB = Server.HtmlEncode(strSpaceNameDB.Replace("'", "@") + ",")
        'End of comment by Yogesh J on 20-11-15 

        CommonFunction.Data.DisposeDataReader(drSpaceName)
        'End by SuchitraP

        ''If m_strPopup <> "1" Then
        ''    flag = "2"
        ''End If
      
    End Sub
    Private Sub PerformAction()
        Dim strSQL As String


        If m_strAction = ACTION_SAVE Then
            Dim strTitle As String = ""
            Dim strContents As String = ""
            Dim strLabels As String = ""
            Dim strEditUserIDs As String = ""
            Dim strViewUserIDs As String = ""
            Dim blnRestrictEdit As Boolean = False
            Dim blnRestrictView As Boolean = False
            Dim strDescription As String

            'COMMENT BY KIRAN K K FOR HTML ENCODE TO THIS FIELD 10/11/15
            'strTitle = CommonFunctions.General.BuildQueryString(Request.Form("txtTitle"))
            'Commented & Added By Dipali V On 7th April 2020 For Issue ID 24200
            'strTitle = Server.HtmlEncode(CommonFunctions.General.BuildQueryString(Request.Form("txtTitle")))
            strTitle = CommonFunctions.General.BuildQueryString(Request.Form("txtTitle"))
            'COMMENT ENDED BY KIRAN K K FOR HTML ENCODE TO THIS FIELD 10/11/15
            'End of Commented & Added By Dipali V On 7th April 2020 For Issue ID 24200
            strLabels = CommonFunctions.General.BuildQueryString(Request.Form("txtLabels"))

            strDescription = CommonFunctions.General.BuildQueryString(Request.Form("txtDescription"))



            If Not Request("chkEdit") Is Nothing Then
                strEditUserIDs = Request("txtEditUserIDs")
                blnRestrictEdit = True
            End If
            If Not Request("chkView") Is Nothing Then
                strViewUserIDs = Request("txtViewUserIDs")
                blnRestrictView = True
            End If

            'Comment and modification by SuchitraP on 25-Aug-2008 to get the TeamID when Pages are created from My Team
            'strSQL = " usp_InsUpd_tbl_KM_Space " & m_intSpaceID & "," & m_lngUserId.ToString & ",N'" & strTitle & "',N'" & strLabels & "'," & CStr(IIf(blnRestrictEdit, 1, 0)) & ",'" & strEditUserIDs & "'," & CStr(IIf(blnRestrictView, 1, 0)) & ",'" & strViewUserIDs & "'"
            If m_strTeamID Is Nothing Then
                m_strTeamID = "NULL"
            End If

            If m_strPopup <> "1" Then
                flag = "2"
            End If

            strSQL = " usp_InsUpd_tbl_KM_Space " & m_intSpaceID & "," & m_lngUserId.ToString & ",N'" & strTitle & "',N'" & strLabels & "'," & CStr(IIf(blnRestrictEdit, 1, 0)) & ",'" & strEditUserIDs & "'," & CStr(IIf(blnRestrictView, 1, 0)) & ",'" & strViewUserIDs & "'" & "," & m_strTeamID & ",'" & strDescription & "'"
            'End by SuchitraP
            m_intSpaceID = CommonFunctions.Data.GetDataScalar(strSQL, True)
            m_strMode = MODE_EDIT

        ElseIf m_strAction.ToUpper = "DELETE_PAGES" Then
            Dim strPageIDs As String
            strPageIDs = Request("chkDelete")
            strSQL = " usp_del_tbl_KM_SpacePages " & m_intSpaceID & ",'" & strPageIDs & "'"
            CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
        End If
    End Sub
    Public Sub WritePage()
        Dim strSQL As String
        Dim drPageDetails As IDataReader
        Dim strLabels As String = ""
        Dim strDescription As String = ""
        Dim strSpaceName As String = ""
        Dim strMenu As String = ""
        Dim blnRestrictView As Boolean = False
        Dim blnRestrictEdit As Boolean = False

        Dim strQuery As String = ""
        Dim drEditAccess As IDataReader
        Dim strEditAccess As String = ""
        Dim strProgrammerID As String = ""

        PerformAction()
        strMenu = InitializeMenu()
        Response.Write(strMenu)

        PlotLegends()
        'Response.Write("<br>")
        Response.Write(WebPages.Template.PageCaption.GetPageCaptions(, "Space", , , True))
        Response.Write("<br>")

        strEditAccess = ""
        strProgrammerID = ""

        strQuery = "usp_Get_EditAccess_Space " + m_intSpaceID.ToString + "," + HttpContext.Current.Session("intUserID").ToString
        drEditAccess = CommonFunction.Data.GetDataReader(strQuery, True)
        If drEditAccess.Read() Then
            strEditAccess = drEditAccess("IsPresent").ToString
        End If

        If drEditAccess.NextResult() Then
            If drEditAccess.Read() Then
                strProgrammerID = drEditAccess("AuthorID").ToString
            End If
        End If

        If m_strMode.ToUpper = "VIEW" Then
            If strEditAccess = "1" Or strProgrammerID = HttpContext.Current.Session("intUserID").ToString Then
            Else
                Response.Write("<TABLE CellSpacing=0 class='clsTable' width=99.99%>")
                Response.Write("<TR class=clsTREven><td align=left >You have only View Access of this Space</td></TR>")
                Response.Write("</TABLE><br>")
            End If
        End If

        Response.Write("<DIV Id=divMain Style='OVERFLOW:auto; WIDTH:100%'>")
        Response.Write("<TABLE CellSpacing=0 class='clsTable' width=99.99%>")

        If m_intSpaceID <> 0 Then
            strSQL = "usp_Sel_tbl_KM_Space_My Null," & m_intSpaceID.ToString
            drPageDetails = CommonFunctions.Data.GetDataReader(strSQL, True)
            If drPageDetails.Read Then
                strSpaceName = drPageDetails("SpaceName")
                strLabels = drPageDetails("Keywords")
                strDescription = CommonFunction.Data.CheckIsDBNull(drPageDetails("SpaceDescription"), "")
                blnRestrictView = IIf(drPageDetails("RestrictViewAccess") Is DBNull.Value, False, drPageDetails("RestrictViewAccess"))
                blnRestrictEdit = IIf(drPageDetails("RestrictEditAccess") Is DBNull.Value, False, drPageDetails("RestrictEditAccess"))
            End If

            CommonFunction.Data.DisposeDataReader(drPageDetails)

        End If

        If m_strMode.ToUpper <> "VIEW" Then
            Response.Write("<tr class=clsTRBody><td align=right>Space Name</td><td>")
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            ''CommonFunctions.HTMLControls.DrawTextBox("txtTitle", "txtTitle", maxLength:=50, value:=strSpaceName, widthInPixel:=400, IsDisabled:=IIf(m_strMode.ToUpper = "VIEW", True, False), IsMandatory:=True)
            CommonFunctions.HTMLControls.DrawTextBox("txtTitle", "txtTitle", maxLength:=50, value:=strSpaceName, widthInPixel:=400, IsDisabled:=IIf(m_strMode.ToUpper = "VIEW", True, False), IsMandatory:=True, EnableHTMLEncode:=True)
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

            Response.Write("</td></tr>")

            Response.Write("<tr class=clsTRBody><td align=right valign=top>Description</td><td>")
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            ''CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", value:=strDescription, maxLength:=1000, widthInPixel:=400, heightInPixel:=100, IsMandatory:=True, MandatoryImagePath:="../../Images/Star.gif")
            CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", value:=strDescription, maxLength:=1000, widthInPixel:=400, heightInPixel:=100, IsMandatory:=True, MandatoryImagePath:="../../Images/Star.gif", EnableHTMLEncode:=True)
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

            Response.Write("</td></tr>")
        Else
            Response.Write("<tr class=clsTRBody><td align=right><b>Space Name</b> : </td><td align=left width=80%>")
            Response.Write(strSpaceName)
            Response.Write("</td></tr>")

            Response.Write("<tr class=clsTRBody><td align=right valign=top><b>Description</b> : </td><td align=left width=80%>")
            Response.Write(strDescription)
            Response.Write("</td></tr>")
        End If
        

        If m_strMode.ToUpper <> "VIEW" Then
            Response.Write("<tr class=clsTRBody><td align=right valign=top>Search Labels</td><td>")
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            ''CommonFunctions.HTMLControls.DrawTextArea("txtLabels", "txtLabels", "Labels", value:=strLabels, widthInPixel:=400, heightInPixel:=100, IsMandatory:=True)
            CommonFunctions.HTMLControls.DrawTextArea("txtLabels", "txtLabels", "Labels", value:=strLabels, widthInPixel:=400, heightInPixel:=100, IsMandatory:=True, EnableHTMLEncode:=True)
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

            Response.Write("</td></tr>")

            'Response.Write("<tr class='clsTRBody'><TD colspan=2>")
            PlotAccessBlock(blnRestrictEdit, blnRestrictView)
            'Response.Write("</td></tr>")
        End If


        Response.Write("</TABLE>")


        PlotHiddenControls()
        If m_intSpaceID > 0 Then
            PlotPages()
        End If

        Response.Write("</DIV>")
        Response.Write(strMenu)

        'Addition by SuchitraP on 25-Aug-2008 to get the TeamID when Pages are created from My Team
        Response.Write("<input type=hidden name='hidTeamID' id='hidTeamID' value='" + m_strTeamID + "'>")
        Response.Write("<input type=hidden name='hidFrom' id='hidFrom' value='" + m_strFrom + "'>")

        CommonFunction.Data.DisposeDataReader(drEditAccess)
        'End by SuchitraP

    End Sub
    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag("Space")
    End Sub
    Private Sub PlotPages()
        Dim cObjSectionTitle As New WebPage.Templates.SectionTitle
        Response.Write("<br>")

        With cObjSectionTitle
            Response.Write(.GetSectionTitle("Articles included in above space", "DivSpacePages", "ShowHideSpacePages", , ))

            Response.Write("<SCRIPT Language=javascript>" + vbCrLf)
            Response.Write(.ClientsideScript)
            Response.Write("</SCRIPT>")

        End With

        cObjSectionTitle = Nothing


        Response.Write("<DIV Id=DivSpacePages >")
        Response.Write("<TABLE class='clsTable' width=100%>")

        PlotPageList(m_strMode)
        Response.Write("</Table>")
        Response.Write("</Div>")

    End Sub
    Private Sub PlotAccessBlock(ByVal blnRestrictEdit As Boolean, ByVal blnRestrictView As Boolean)
        Dim strEditUsers As String = ""
        Dim strEditUserIDs As String = ""

        Dim strViewUsers As String = ""
        Dim strViewUserIDs As String = ""

        Dim strSQL As String
        Dim drAccessUsers As IDataReader

        If m_intSpaceID > 0 And (blnRestrictEdit = True Or blnRestrictView = True) Then
            strSQL = "Exec usp_Sel_tbl_KM_Spaces_RestrictedUserGroups " & m_intSpaceID
            drAccessUsers = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
            If drAccessUsers.Read Then
                strEditUsers = drAccessUsers("EditUsers")
                strEditUserIDs = drAccessUsers("EditUserIDs")
                strViewUsers = drAccessUsers("ViewUsers")
                strViewUserIDs = drAccessUsers("ViewUserIDs")
            End If

            CommonFunction.Data.DisposeDataReader(drAccessUsers)

        End If
        'Response.Write("<TABLE valign=bottom class='clsTable'  CellSpacing='0' CellPadding=0  width=100% height=100%>")

        'Response.Write("<tr class='clsTREven'><TD id='TD_Left'style='width:50%;border:1px solid #ccc;' valign='top'>")

        
        'Response.Write("<TABLE valign=bottom class='clsTable'  CellSpacing='0' CellPadding=0  width=100% height=100%>")

        Response.Write("<tr class='clsTRBody'><td align=right valign=top>Allow Edit&nbsp;</td><td>")
        CommonFunctions.HTMLControls.DrawCheckBox("chkEdit", "chkEdit", , blnRestrictEdit, TobeInserted:="Onclick=""ShowHideTr('tr_EditUsers',this)""")
        Response.Write("</td></tr>")
        Response.Write("<tr id='tr_EditUsers' class='clsTRBody'><td align=right valign=top> <a Href=""javascript:UserSelection_Onclick('Edit')"">Users</a></td><td>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        'CommonFunctions.HTMLControls.DrawTextArea("txtEditUsers", "txtEditUsers", "Users", value:=strEditUsers, widthInPixel:=400, heightInPixel:=100, IsReadonly:=True)
        'CommonFunctions.HTMLControls.DrawTextBox("txtEditUserIDs", "txtEditUserIDs", value:=strEditUserIDs, IsHidden:=True)
        CommonFunctions.HTMLControls.DrawTextArea("txtEditUsers", "txtEditUsers", "Users", value:=strEditUsers, widthInPixel:=400, heightInPixel:=100, IsReadonly:=True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtEditUserIDs", "txtEditUserIDs", value:=strEditUserIDs, IsHidden:=True, EnableHTMLEncode:=True)

        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
               Response.Write("</td></tr>")


        'Response.Write("</td></tr></Table></td></tr></table>")

    End Sub

    Private Sub PlotLegends()
        Dim arrLegends(0) As String
        Dim arrLegendImg(0) As String
        arrLegends(0) = "&nbsp;Mandatory"
        arrLegendImg(0) = CommonFunctions.HTMLControls.DrawMandatoryImage(, True)
        WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImg, arrLegends)
    End Sub


    Private Sub PlotPageList(ByVal strMode As String)
        Dim strSQL As String
        Dim drPages As IDataReader
        Dim blnOddEven As Boolean = False
        Dim strTRClass As String
        Dim strSearchText As String = ""
        'Dim strListHeadCaption As String
        Dim strEditFunctionName As String
        Dim strQuery As String
        Dim strEditAccess As String = ""
        Dim strProgrammerID As String = ""
        Dim drEditAccess As IDataReader


        strSQL = "usp_Sel_tbl_KM_SpacePages " & m_intSpaceID

        Response.Write("<table id='tblList' width='99.9%'  cellspacing=1 cellpadding=0  class='clsGridTable' >")

        Response.Write("<thead class=clsTRColumnHeader>")
        Response.Write("<th colspan=3 align='left' class='divListTag' width=90%>Article Name</th>")
        Response.Write("<TH align='left'>")
        Response.Write("Submitted By")
        Response.Write("</TH>")
        Response.Write("<th align=left>")
        Response.Write("Submitted Date")
        Response.Write("</th>")
        If m_strMode.ToUpper = "EDIT" Then
            Response.Write("<th align='center' class='divListTag' WIDTH=10%>Delete</th>")
        End If
        Response.Write("</thead>")

        drPages = CommonFunctions.Data.GetDataReader(strSQL, True)
        While drPages.Read()
            blnOddEven = Not blnOddEven
            If blnOddEven = True Then
                strTRClass = "clsTREven"
            Else
                strTRClass = "clsTROdd"
            End If
            Response.Write("<Tr class=" & strTRClass & ">")
            If m_strFromWhere.ToUpper = "MYSPACE" Then
                m_strFromWhere = m_strFromWhere.Replace("MySpace", "MySpaceEdit")
            End If

            strQuery = ""
            strEditAccess = ""
            strProgrammerID = ""
            strQuery = "usp_Get_EditAccess " + drPages("ProcedureID").ToString + "," + HttpContext.Current.Session("intUserID").ToString
            drEditAccess = CommonFunction.Data.GetDataReader(strQuery, True)
            If drEditAccess.Read() Then
                strEditAccess = drEditAccess("IsPresent").ToString
            End If

            If drEditAccess.NextResult() Then
                If drEditAccess.Read() Then
                    strProgrammerID = drEditAccess("ProgrammerID").ToString
                End If
            End If
            CommonFunction.Data.DisposeDataReader(drEditAccess)

            'Commented and Added By Bharat T on 1st-Dec-2015
            'If strEditAccess = "1" Or strProgrammerID = HttpContext.Current.Session("intUserID").ToString Then
            '    Response.Write("<td colspan=3 WIDTH=85%><a href='javascript:Page_OnClick(" & drPages("ProcedureID") & ",""Edit"",""" & m_intSpaceID.ToString() & """,""" & m_strFromWhere & """)'>" & drPages("ProcedureTitle") & "</a>")
            'Else
            '    Response.Write("<td colspan=3 WIDTH=85%><a href='javascript:Page_OnClick(" & drPages("ProcedureID") & ",""View"",""" & m_intSpaceID.ToString() & """,""" & m_strFromWhere & """)'>" & drPages("ProcedureTitle") & "</a>")
            'End If

            If strEditAccess = "1" Or strProgrammerID = HttpContext.Current.Session("intUserID").ToString Then
                Response.Write("<td colspan=3 WIDTH=85%><a href='javascript:Page_OnClick(" & drPages("ProcedureID") & ",""Edit"",""" & m_intSpaceID.ToString() & """,""" & m_strFromWhere & """)'>" & HttpUtility.HtmlEncode(drPages("ProcedureTitle")) & "</a>")
            Else
                Response.Write("<td colspan=3 WIDTH=85%><a href='javascript:Page_OnClick(" & drPages("ProcedureID") & ",""View"",""" & m_intSpaceID.ToString() & """,""" & m_strFromWhere & """)'>" & HttpUtility.HtmlEncode(drPages("ProcedureTitle")) & "</a>")
            End If
            'End of Commented and Added By Bharat T on 1st-Dec-2015

            'Response.Write("<td colspan=3 WIDTH=85%>" & drPages("ProcedureTitle"))
            Response.Write("</td>")

            Response.Write("<td align=left>")
            Response.Write(drPages("Author"))
            Response.Write("</td>")

            Response.Write("<td align=left>")
            If IsDBNull(drPages("DateCreated")) = False Then
                Response.Write(CommonFunction.Dates.CGetDate(drPages("DateCreated")))
            Else
                Response.Write("&nbsp;")
            End If

            Response.Write("</td>")

            If m_strMode.ToUpper = "EDIT" Then
                Response.Write("<td WIDTH=5% align=center>")
                CommonFunctions.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", value:=drPages("ProcedureID"))
                Response.Write("</td>")
            End If
            Response.Write("</tr>")

            'Response.Write("<tr class=" & strTRClass & "><td >&nbsp;&nbsp;&nbsp;</td>")
            'Response.Write("<td colspan=2>" & drPages("Keywords") & "</td><td>&nbsp;</td></tr>")



        End While

        CommonFunction.Data.DisposeDataReader(drPages)

        Response.Write("</table>")
        Response.Write("</div>")


    End Sub
    Private Function InitializeMenu() As String
        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips
        Dim strMenu As String = ""
        'Addition by SuchitraP on 25-Aug-2008 to display AddPage link only if that user has Edit Access for that Space
        Dim strSQL As String
        Dim strEditAccess As String
        Dim strAuthorID As String
        Dim drEditAccess As IDataReader
        'End by SuchitraP

        If m_strTeamID = "NULL" Then
            m_strTeamID = "0"
        End If

        If m_strMode.ToUpper = "EDIT" Then
            If m_intSpaceID > 0 Then
                If CommonFunction.General.CheckIsNothing(m_strTeamID, "0") <> "0" Then 'm_strSubTab = "MY TEAM" And  Then
                    ArrMenuCaptionsList.Add("Add New Article")
                    ArrMenuToolTipsList.Add("Add New Article")
                    ArrClientSideFunctionsList.Add("AddNewPage(" + m_intSpaceID.ToString + ")")

                    ArrMenuCaptionsList.Add("Add Existing Article")
                    ArrMenuToolTipsList.Add("Add Existing Article")
                    ArrClientSideFunctionsList.Add("AddPage_OnClick('" + m_strSubTab + "','" + m_strMode + "','" + m_strFromWhere + "')")
                Else
                    ArrMenuCaptionsList.Add("Add Article")
                    ArrMenuToolTipsList.Add("Add Article")
                    ArrClientSideFunctionsList.Add("AddPage_OnClick('" + m_strSubTab + "','" + m_strMode + "','" + m_strFromWhere + "')")
                End If

                ArrMenuCaptionsList.Add("Delete Article")
                ArrMenuToolTipsList.Add("Delete Article")
                ArrClientSideFunctionsList.Add("DeletePage_OnClick()")
            End If

            'ArrMenuCaptionsList.Add("Select All")
            'ArrMenuToolTipsList.Add("Select All")
            'ArrClientSideFunctionsList.Add("SelectAll_OnClick('frmKMMySpace','chkDelete')")

            'ArrMenuCaptionsList.Add("Clear All")
            'ArrMenuToolTipsList.Add("Clear All")
            'ArrClientSideFunctionsList.Add("ClearAll_OnClick('frmKMMySpace','chkDelete')")

            ArrMenuCaptionsList.Add("Save")
            ArrMenuToolTipsList.Add("Save")
            ArrClientSideFunctionsList.Add("Save_OnClick()")
        ElseIf m_strMode.ToUpper = "ADD_NEW" Then
            ArrMenuCaptionsList.Add("Save")
            ArrMenuToolTipsList.Add("Save")
            ArrClientSideFunctionsList.Add("Save_OnClick()")
        End If


        'Addition by SuchitraP on 25-Aug-2008 to display AddPage link only if that user has Edit Access for that Space
        If m_strMode.ToUpper = "VIEW" Then
            strSQL = ""
            strSQL = "usp_Get_EditAccess_Space " + m_intSpaceID.ToString + "," + m_lngUserId.ToString
            drEditAccess = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
            If drEditAccess.Read() Then
                strEditAccess = drEditAccess("IsPresent").ToString
            End If

            If drEditAccess.NextResult() Then
                If drEditAccess.Read() Then
                    strAuthorID = drEditAccess("AuthorID").ToString
                End If
            End If

            If strEditAccess = "1" Or strAuthorID = m_lngUserId.ToString Then
                ArrMenuCaptionsList.Add("Add Article")
                ArrMenuToolTipsList.Add("Add Article")
                ArrClientSideFunctionsList.Add("AddPage_OnClick('" + m_strSubTab + "','" + m_strMode + "','" + m_strFromWhere + "')")
            End If

            CommonFunction.Data.DisposeDataReader(drEditAccess)
        End If
        'End of addition by SuchitraP

        'If m_strFromWhere.ToUpper <> "MYTEAMEDIT" And m_strFromWhere.ToUpper <> "MYTEAM" And m_strTeamID = "0" Then
        '    ArrMenuCaptionsList.Add("Back")
        '    ArrMenuToolTipsList.Add("Back")
        '    ArrClientSideFunctionsList.Add("Back_OnClick('" + m_strFromWhere + "'," + m_intSpaceID.ToString + ")")
        'End If

        'If m_strFromWhere.ToUpper = "MYTEAMEDIT" Then
        '    ArrMenuCaptionsList.Add("Close")
        '    ArrMenuToolTipsList.Add("Close")
        '    ArrClientSideFunctionsList.Add("Close_OnClick()")
        'End If

        'If m_strFromWhere.ToUpper = "MYTEAM" Or m_strTeamID <> "0" Then
        '    ArrMenuCaptionsList.Add("Close")
        '    ArrMenuToolTipsList.Add("Close")
        '    ArrClientSideFunctionsList.Add("Close_OnClick()")
        'End If

        If m_strFromWhere.ToUpper = "SEARCH" And m_strTeamID Is Nothing Then
            ArrMenuCaptionsList.Add("Back")
            ArrMenuToolTipsList.Add("Back")
            ArrClientSideFunctionsList.Add("Back_OnClick('" + m_strFromWhere + "'," + m_intSpaceID.ToString + ")")
        ElseIf m_strFromWhere.ToUpper = "SEARCH" And m_strTeamID = "0" Then
            ArrMenuCaptionsList.Add("Close")
            ArrMenuToolTipsList.Add("Close")
            ArrClientSideFunctionsList.Add("Close_OnClick()")
        ElseIf m_strFromWhere.ToUpper = "SEARCH" And m_strTeamID <> "0" Then
            ArrMenuCaptionsList.Add("Close")
            ArrMenuToolTipsList.Add("Close")
            ArrClientSideFunctionsList.Add("Close_OnClick()")
        ElseIf m_strFromWhere.ToUpper = "MYSPACE" Or m_strFromWhere.ToUpper = "MYSPACEEDIT" Then
            ArrMenuCaptionsList.Add("Back")
            ArrMenuToolTipsList.Add("Back")
            ArrClientSideFunctionsList.Add("Back_OnClick('" + m_strFromWhere + "'," + m_intSpaceID.ToString + ")")
        ElseIf m_strFromWhere.ToUpper = "MYTEAM" And flag <> "5" Then
            ArrMenuCaptionsList.Add("Close")
            ArrMenuToolTipsList.Add("Close")
            ArrClientSideFunctionsList.Add("Close_OnClick()")
        ElseIf m_strFromWhere.ToUpper = "LATESTFEATURED" Then
            ArrMenuCaptionsList.Add("Back")
            ArrMenuToolTipsList.Add("Back")
            ArrClientSideFunctionsList.Add("Back_OnClick('" + m_strFromWhere + "'," + m_intSpaceID.ToString + ")")
        End If

        ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>")
        ArrMenuToolTipsList.Add("Help")
        ArrClientSideFunctionsList.Add("Help_OnClick('3960')")

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
        strMenu = m_objMenu.DrawMenuWithEvents(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True)
        m_objMenu = Nothing

        Return strMenu
    End Function


    ''Added by Dhanashri S on 29 Mar 2016 Purpose:to generate and validate Token
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateArticleToken(PageID As String, SpaceID As String, EmployeeId As String) As String
        Try
            Dim m_PKToken_Article As String
            m_PKToken_Article = CommonFunctions.Security.Token.GetToken(CType(PageID, String) + CType(EmployeeId, String) + "0" + "0" + CType(SpaceID, String))

        Return m_PKToken_Article
        Catch ex As Exception
        Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateAddpageToken(SpaceID As String, EmployeeId As String) As String
        Try
            Dim m_PKToken_Article As String
            m_PKToken_Article = CommonFunctions.Security.Token.GetToken(CType(SpaceID, String) + CType(EmployeeId, String) + "0" + "0")

        Return m_PKToken_Article
        Catch ex As Exception
        Return "Bad Request Found"
        End Try
    End Function
    ''End of Addition by Dhanashri S on 29 Mar 2016

End Class
