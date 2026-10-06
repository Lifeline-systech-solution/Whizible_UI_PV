Public Class KM_List
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
#Region " Global Variables "
    Public m_strMode As String = ""
    Protected m_strAction As String = ""
    Protected m_strTab As String = "HOME"
    Protected m_strSubTab As String = "MY PAGES"
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_strPageTitle As String = ""
    Private m_lngUserId As Long = 0
    Private m_lngPostId As Long = 0
    Private m_lngTeamId As Long = 0
    Private m_intLeftRows As Integer = 0
    Private m_intRightRows As Integer = 0
    Protected m_strFrom As String
    Private strColor As String
    Protected StrArticleID As String
    Protected strArticle() As String
    'Addition for New UI
    Protected strSelectList As String
    Private m_intTotalNoOfRows As Integer
    Protected m_intPageNumber As Integer = 1
    Private ReadCount As Integer
    Protected m_strFromWhere As String
    Protected m_strtxtSearch As String = ""
    Protected m_strPagingNumber As String = ""
    Protected m_strTeamID As String
    Protected m_strPrimaryKey As String
    'End

    Protected intCurrentpageNumber As Integer = 0
    Protected intPageSize As Integer = "10"
    Protected Recordcount_Article As Double = 0
    Protected Recordcount_Space As Double = 0
    Protected Recordcount_Team As Double = 0
    Protected intmenuClick As Integer = 0

    Private Enum EntityType
        PAGE
        SPACE
        BLOG
        TEAM
    End Enum

#End Region
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        InitVariables()
        PerformAction()

    End Sub
    Private Sub PerformAction()
        Dim strSQL As String
        Dim strDeletionIDs As String

        Dim strPagesInuse As String
        Dim strPagesDeleted As String
        Dim sbMessage As New System.Text.StringBuilder
        Dim arrIDs() As String
        Dim strId As String
        Dim PlotPaging As String
        If m_strAction.ToUpper = "DELETE" Then
            'strDeletionIDs = Request("chkDelete")
            strDeletionIDs = Request.QueryString("DeletionID")
            'arrIDs = strDeletionIDs.Split(",")
            Select Case m_strSubTab.ToUpper
                Case "MY PAGES"
                    'For Each strId In arrIDs
                    strSQL = "usp_del_tbl_KM_CodeHeadings_ForUI " & strDeletionIDs
                    sbMessage.Append("\n" & CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL).ToString)
                    'Next
                Case "MY SPACES"
                    'For Each strId In arrIDs
                    strSQL = "usp_del_tbl_KM_Space_ForUI " & strDeletionIDs
                    sbMessage.Append("\n" & CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL).ToString)
                    ' Next
                Case "MY BLOGS"
                    ' strDeletionIDs = Request("chkDelete")
                    'strSQL = "usp_del_tbl_KM_CodeHeadings '" & strDeletionIDs & "'"
                Case "MY TEAMS"
                    'For Each strId In arrIDs
                    strSQL = "usp_del_tbl_KM_Team_ForUI " & strDeletionIDs
                    sbMessage.Append("\n" & CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL).ToString)
                    'Next
            End Select
            CommonFunctions.General.WriteHTML("<Script>")
            CommonFunctions.General.WriteHTML("alert('" & sbMessage.ToString.Replace("'", "\'") & "')")
            CommonFunctions.General.WriteHTML("</Script>")
        End If
    End Sub
    Private Sub DetailsView_Home(ByVal FromWhere As String, ByVal From As String)
        Dim strMenu As String = ""
        Dim sbHtml As New System.Text.StringBuilder
        Dim sbHtmlMenu As New System.Text.StringBuilder
        Dim strSQL As String = ""
        Dim drMenuGroup As IDataReader
        Dim drMenu As IDataReader
        Dim EntityName As String
        Dim EntityPKID As Integer
        Dim NoOfArticles As Integer

        Dim strSQL_Page As String
        Dim strSPname_Page As String
        Dim dsEntity_Page As IDataReader
        Dim strSearchText_Page As String = ""
        Dim strIDColumn_Page As String
        Dim strTitleColumn_Page As String
        Dim strEditFunctionName_Page As String

        Dim strSQL_Space As String
        Dim strSPname_Space As String
        Dim dsEntity_Space As IDataReader
        Dim strSearchText_Space As String = ""
        Dim strIDColumn_Space As String
        Dim strTitleColumn_Space As String
        Dim strEditFunctionName_Space As String

        Dim strSQL_Team As String
        Dim strSPname_Team As String
        Dim dsEntity_Team As IDataReader
        Dim strSearchText_Team As String = ""
        Dim strIDColumn_Team As String
        Dim strTitleColumn_Team As String
        Dim strEditFunctionName_Team As String
        Dim blnEditAccess As Boolean
        Dim blnViewAccess As Boolean

        Dim strRatingNew As String
        Dim tempRating As Double
        Dim strRating As String
        Dim counter As Integer
        Dim flag As Integer
        Dim strQuery As String
        Dim strEditAccess As String
        Dim strProgrammerID As String
        Dim drEditAccess As IDataReader

        sbHtml.Append("<Table class=clsTable cellspacing=0 cellpadding=0 width='100%'>" + vbCrLf)
        sbHtml.Append("<TR class=clsTRMenu>" + vbCrLf)
        sbHtml.Append("<TD align=Right>" + vbCrLf)
        sbHtml.Append("|" + vbCrLf)
        sbHtml.Append("<A class='Menu' style=''  Title=""Back""  onclick=""HomeBack_OnClick('" + FromWhere + "')"" >Back</A> | " + vbCrLf)
        sbHtml.Append("</TD></TR></TABLE><BR>")

        sbHtml.Append("<div id='PageDiv'  name='PageDiv' style='overflow:auto;width:100%;height:680px;'>") 'height:480px
        sbHtml.Append("<BR><TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>")
        sbHtml.Append("<TR class=clsTRPageCaption><TD align=Left>")

        If From.ToUpper = "ARTICLES" Then
            FromWhere = FromWhere.Replace("Articles", "Search")
            sbHtml.Append("Articles")
            sbHtml.Append("</TD></TR></Table><BR>")

            strIDColumn_Page = "ProcedureID"
            strTitleColumn_Page = "ProcedureTitle"
            strSPname_Page = "usp_Sel_tbl_KM_CodeHeadings"
            strEditFunctionName_Page = "Page_OnClick"

            If Not Request.Form("txtSearch") Is Nothing Then
                strSearchText_Page = Request.Form("txtSearch").Trim()
                strSearchText_Page = CommonFunctions.General.BuildQueryString(strSearchText_Page)
            ElseIf Not Request.QueryString("txtSearch") Is Nothing Then
                strSearchText_Page = Request.QueryString("txtSearch").Trim()
                strSearchText_Page = CommonFunctions.General.BuildQueryString(strSearchText_Page)
            End If

            strSQL_Page = strSPname_Page & " "
            strSQL_Page = strSQL_Page & "-1," & m_lngUserId.ToString & ",NULL,0,"

            strSQL_Page = strSQL_Page & "N'" & strSearchText_Page & "'"

            If m_strTab.ToUpper = "EDIT" Then
                strSQL_Page = strSQL_Page & ",1"
            ElseIf m_strTab.ToUpper = "HOME" Then
                strSQL_Page = strSQL_Page & ",2"
            End If

            drMenu = CommonFunctions.Data.GetDataReader(strSQL_Page, MyBase.UseSQL)
            sbHtml.Append("<table width='100%' class='clsTable' border='0' cellpadding='0'>")
            sbHtml.Append("<tr><td align='left' valign='top' width='33.33%'>")
            sbHtml.Append("<table width='95%'  border='0' cellpadding='5'>")

            While drMenu.Read
                EntityName = drMenu("ProcedureTitle").ToString
                EntityPKID = drMenu("ProcedureID").ToString

                sbHtml.Append("<tr name=trItem_" + HttpUtility.HtmlEncode(EntityName) + " id=trItem_" + HttpUtility.HtmlEncode(EntityName) + " >") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                'sbHtml.Append("<td valign=top width=35>")


                'To show edit link if user has edit access as well as user is a creator
                strQuery = ""
                strEditAccess = ""
                strProgrammerID = ""
                strQuery = "usp_Get_EditAccess " + EntityPKID.ToString + "," + HttpContext.Current.Session("intUserID").ToString
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

                'sbHtml.Append("<img src='..\..\Images\Discussions.gif' vspace=1 border=0></a></td>")
                sbHtml.Append("<td valign=top width=100%><font fontFamily:'Verdana, Arial'; size='1'>")
                If strEditAccess = "1" Or strProgrammerID = HttpContext.Current.Session("intUserID").ToString Then
                    sbHtml.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:ArticleEdit_OnClick(" + EntityPKID.ToString + ",'Edit','" + FromWhere + "')"">")
                Else
                    sbHtml.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:ArticleEdit_OnClick(" + EntityPKID.ToString + ",'View','" + FromWhere + "')"">")
                End If


                sbHtml.Append(HttpUtility.HtmlEncode(EntityName)) 'HtmlEncode Added By Vaijat K ON 20/11/2015
                sbHtml.Append("</a>")
                sbHtml.Append("</font>&nbsp;&nbsp;&nbsp;")

                strRating = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT AVG(Rating) AS Rating FROM tbl_KM_ArticleRating WHERE ProcedureID=" + EntityPKID.ToString, True), "")

                If strRating.LastIndexOf(".") <> "-1" Then
                    strRatingNew = strRating.Substring(0, strRating.LastIndexOf("."))
                Else
                    strRatingNew = strRating
                End If

                If strRating <> "" Then
                    For counter = 0 To 5
                        If CType(strRatingNew, Integer) <> counter Then
                            sbHtml.Append("<img id='imgstaron'  SRC=""../../Images/star_on.gif"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                        Else
                            tempRating = CType(strRating, Double) - CType(strRatingNew, Double)
                            If tempRating < 0.5 And tempRating <> 0.0 Then
                                sbHtml.Append("<img id='imgstaron'  SRC=""../../Images/starl5.GIF"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                            ElseIf tempRating = 0.5 Then
                                sbHtml.Append("<img id='imgstaron'  SRC=""../../Images/stare5.GIF"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                            ElseIf tempRating > 0.5 Then
                                sbHtml.Append("<img id='imgstaron'  SRC=""../../Images/starg5.GIF"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                            ElseIf tempRating = 0.0 And CType(strRating, Double) <> 5.0 Then
                                sbHtml.Append("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                            End If
                            flag = strRatingNew + 2
                            Exit For
                        End If
                    Next

                    For counter = flag To 5
                        sbHtml.Append("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                    Next
                Else
                    For counter = 0 To 4
                        sbHtml.Append("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                    Next
                End If
                sbHtml.Append("</td></tr>")
            End While

            CommonFunction.Data.DisposeDataReader(drMenu)

            sbHtml.Append("</table>")
            sbHtml.Append("</td></tr></table>")
            sbHtml.Append("</Div>")

        ElseIf From.ToUpper = "SPACES" Then
            FromWhere = FromWhere.Replace("Spaces", "Search")
            sbHtml.Append("Spaces")
            sbHtml.Append("</TD></TR></Table><BR>")

            strIDColumn_Space = "SpaceID"
            strTitleColumn_Space = "SpaceName"
            strSPname_Space = "usp_Sel_tbl_KM_Space"
            strEditFunctionName_Space = "Space_OnClick"

            If Not Request.Form("txtSearch") Is Nothing Then
                strSearchText_Space = Request.Form("txtSearch").Trim()
                strSearchText_Space = CommonFunctions.General.BuildQueryString(strSearchText_Space)
            ElseIf Not Request.QueryString("txtSearch") Is Nothing Then
                strSearchText_Space = Request.QueryString("txtSearch").Trim()
                strSearchText_Space = CommonFunctions.General.BuildQueryString(strSearchText_Space)
            End If

            strSQL_Space = strSPname_Space & " "
            strSQL_Space = strSQL_Space & "-1," & m_lngUserId.ToString & ",NULL,0,"

            strSQL_Space = strSQL_Space & "N'" & strSearchText_Space & "'"

            If m_strTab.ToUpper = "EDIT" Then
                strSQL_Space = strSQL_Space & ",1"
            ElseIf m_strTab.ToUpper = "HOME" Then
                strSQL_Space = strSQL_Space & ",2"
            End If

            drMenu = CommonFunctions.Data.GetDataReader(strSQL_Space, MyBase.UseSQL)
            sbHtml.Append("<table width='100%' class='clsTable' border='0' cellpadding='0'>")
            sbHtml.Append("<tr><td align='left' valign='top' width='33.33%'>")
            sbHtml.Append("<table width='95%'  border='0' cellpadding='5'>")

            While drMenu.Read
                EntityName = drMenu("SpaceName").ToString
                EntityPKID = drMenu("SpaceID").ToString

                sbHtml.Append("<tr name=trItem_" + HttpUtility.HtmlEncode(EntityName) + " id=trItem_" + HttpUtility.HtmlEncode(EntityName) + " >") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                'sbHtml.Append("<td valign=top width=35>")

                'sbHtml.Append("<img src='..\..\Images\Discussions.gif' vspace=1 border=0></a></td>")
                sbHtml.Append("<td valign=top width=100%><font style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>")
                sbHtml.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:Space_OnClick(" + EntityPKID.ToString + ",'View','" + FromWhere + "')"">")

                sbHtml.Append(HttpUtility.HtmlEncode(EntityName)) 'HtmlEncode Added By Vaijat K ON 20/11/2015
                sbHtml.Append("</a>")

                sbHtml.Append("<br>")
                If drMenu("SpaceDescription").ToString.Length > 50 Then
                    sbHtml.Append(HttpUtility.HtmlEncode(Left(drMenu("SpaceDescription").ToString, 80)) + "....") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                Else
                    sbHtml.Append(HttpUtility.HtmlEncode(drMenu("SpaceDescription"))) 'HtmlEncode Added By Vaijat K ON 20/11/2015
                End If
                sbHtml.Append("</font>")
                sbHtml.Append("</td></tr>")
            End While
            CommonFunction.Data.DisposeDataReader(drMenu)

            sbHtml.Append("</table>")
            sbHtml.Append("</td></tr></table>")
            sbHtml.Append("</Div>")
        ElseIf From.ToUpper = "TEAMS" Then
            FromWhere = FromWhere.Replace("Teams", "Search")
            sbHtml.Append("Teams")
            sbHtml.Append("</TD></TR></Table><BR>")

            strIDColumn_Space = "TeamID"
            strTitleColumn_Space = "TeamName"
            strSPname_Team = "usp_Sel_tbl_KM_Team"
            strEditFunctionName_Team = "Edit_TeamDetails"


            If Not Request.Form("txtSearch") Is Nothing Then
                strSearchText_Team = Request.Form("txtSearch").Trim()
                strSearchText_Team = CommonFunctions.General.BuildQueryString(strSearchText_Team)
            ElseIf Not Request.QueryString("txtSearch") Is Nothing Then
                strSearchText_Team = Request.QueryString("txtSearch").Trim()
                strSearchText_Team = CommonFunctions.General.BuildQueryString(strSearchText_Team)
            End If

            strSQL_Team = strSPname_Team & " "
            strSQL_Team = strSQL_Team & "-1," & m_lngUserId.ToString & ",NULL,"

            If m_strTab.ToUpper = "MY" Then
                strSQL_Team = strSQL_Team & "1,"
            Else
                strSQL_Team = strSQL_Team & "0,"
            End If
            strSQL_Team = strSQL_Team & "N'" & strSearchText_Team & "'"

            'If m_strTab.ToUpper = "EDIT" Then
            '    strSQL_Team = strSQL_Team & ",1"
            'ElseIf m_strTab.ToUpper = "HOME" Then
            '    strSQL_Team = strSQL_Team & ",2"
            'End If

            strSQL_Team = strSQL_Team & ",2"

            drMenu = CommonFunctions.Data.GetDataReader(strSQL_Team, MyBase.UseSQL)
            sbHtml.Append("<table width='100%' class='clsTable' border='0' cellpadding='0'>")
            sbHtml.Append("<tr><td align='left' valign='top' width='33.33%'>")
            sbHtml.Append("<table width='95%'  border='0' cellpadding='5'>")

            'Addition by SuchitraP on 27-May-2009,When clicked on more Teams link all teams shown could not be editted
            Dim strAccessSQL As String
            Dim strAccessForEmp As IDataReader
            'End by SuchitraP
            While drMenu.Read
                EntityName = drMenu("TeamName").ToString
                EntityPKID = drMenu("TeamID").ToString

                sbHtml.Append("<tr name=trItem_" + HttpUtility.HtmlEncode(EntityName) + " id=trItem_" + HttpUtility.HtmlEncode(EntityName) + " >") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                'sbHtml.Append("<td valign=top width=35>")

                'sbHtml.Append("<img src='..\..\Images\Discussions.gif' vspace=1 border=0></a></td>")
                sbHtml.Append("<td valign=top width=100%><font style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>")

                If EntityPKID > 0 Then
                    'Comment and Addition by SuchitraP on 27-May-2009,When clicked on more Teams link all teams shown could not be editted
                    ''strSQL = " Select dbo.udf_GetTeamAccess(1," & m_lngUserId & "," & EntityPKID & ")"
                    ''blnEditAccess = CBool(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL))
                    ''strSQL = " Select dbo.udf_GetTeamAccess(2," & m_lngUserId & "," & EntityPKID & ")"
                    ''blnViewAccess = CBool(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL))
                    ''If blnEditAccess Then
                    ''    sbHtml.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:Edit_TeamDetails(" + EntityPKID.ToString + ",'EDIT','" + FromWhere + "')"">")
                    ''ElseIf blnViewAccess Then
                    ''    sbHtml.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:Edit_TeamDetails(" + EntityPKID.ToString + ",'View','" + FromWhere + "')"">")
                    ''End If
                    strAccessSQL = "usp_GetAccessForTeam " + EntityPKID.ToString + "," + HttpContext.Current.Session("intUserID").ToString
                    strAccessForEmp = CommonFunction.Data.GetDataReader(strAccessSQL, MyBase.UseSQL)
                    'strAccessSQL = "SELECT DISTINCT UserGroupID,MIN(AccessType) AS AccessType FROM tbl_KM_Teams_RestrictedUserGroups WHERE TeamID=" + dsEntity_Team("TeamID").ToString + "AND UserGroupID=" + HttpContext.Current.Session("intUserID").ToString + " Group BY UserGroupID"
                    'strAccessForEmp = CommonFunction.Data.GetDataReader(strAccessSQL, MyBase.UseSQL)
                    If strAccessForEmp.Read Then
                        sbHtml.Append("<tr class=""clsTRControlMenu"">")
                        'sbHtml.Append("<td valign=top width=20>")
                        'sbHtml.Append("<img src='..\..\Images\Discussions.gif' vspace=1 border=0></a>")
                        sbHtml.Append("<td valign=top width=75% style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>")

                        If strAccessForEmp("AccessType").ToString = "1" Then
                            strSQL = " Select dbo.udf_GetTeamAccess(1," & HttpContext.Current.Session("intUserID").ToString & "," & EntityPKID.ToString & ")"
                            blnEditAccess = CBool(CommonFunctions.Data.GetDataScalar(strSQL, True))
                            sbHtml.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:Edit_TeamDetails(" + EntityPKID.ToString + ",'EDIT','" + m_strFromWhere + "')"">")
                            sbHtml.Append(HttpUtility.HtmlEncode(EntityName)) 'HtmlEncode Added By Vaijat K ON 20/11/2015
                            sbHtml.Append("</a>")
                        ElseIf strAccessForEmp("AccessType").ToString = "2" Then
                            strSQL = "SELECT dbo.udf_GetTeamAccess(2," & HttpContext.Current.Session("intUserID").ToString & "," & EntityPKID.ToString & ")"
                            blnViewAccess = CBool(CommonFunctions.Data.GetDataScalar(strSQL, True))
                            sbHtml.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:Edit_TeamDetails(" + EntityPKID.ToString + ",'View','" + m_strFromWhere + "')"">")
                            sbHtml.Append(HttpUtility.HtmlEncode(EntityName)) 'HtmlEncode Added By Vaijat K ON 20/11/2015
                            sbHtml.Append("</a>")
                        End If
                    End If
                    CommonFunction.Data.DisposeDataReader(strAccessForEmp)

                    'End of comment and addition by SuchitraP
                End If

                'Comment by SuchitraP on 27-May-2009,When clicked on more Teams link all teams shown could not be editted
                ''sbHtml.Append(EntityName)
                ''sbHtml.Append("</a>")
                'End of comment by SuchitraP

                sbHtml.Append("<br>")
                If drMenu("Description").ToString.Length > 50 Then
                    'Commented And Added By Vaijat K ON 19/11/2015
                    'sbHtml.Append(Left(drMenu("Description").ToString, 80) + "....")
                    sbHtml.Append(HttpUtility.HtmlEncode(Left(drMenu("Description").ToString, 80)) + "....") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                Else
                    sbHtml.Append(HttpUtility.HtmlEncode(drMenu("Description"))) 'HtmlEncode Added By Vaijat K ON 20/11/2015
                End If
                sbHtml.Append("</font>")
                sbHtml.Append("</td></tr>")
            End While

            CommonFunction.Data.DisposeDataReader(drMenu)

            sbHtml.Append("</table>")
            sbHtml.Append("</td></tr></table>")
            sbHtml.Append("</Div>")

            'Addition by SuchitraP on 27-May-2009,When clicked on more Teams link all teams shown could not be editted
            'CommonFunction.Data.DisposeDataReader(strAccessForEmp)
            'End of addition by SuchitraP
        End If

        sbHtml.Append("<BR>")
        sbHtml.Append("<Table class=clsTable cellspacing=0 cellpadding=0 width='100%'>" + vbCrLf)
        sbHtml.Append("<TR class=clsTRMenu>" + vbCrLf)
        sbHtml.Append("<TD align=Right>" + vbCrLf)
        sbHtml.Append("|" + vbCrLf)
        sbHtml.Append("<A class='Menu' style=''  Title=""Back""  onclick=""HomeBack_OnClick('" + FromWhere + "')"" >Back</A> | " + vbCrLf)
        sbHtml.Append("</TD></TR></TABLE>")

        CommonFunction.General.WriteHTML(sbHtml.ToString)
        sbHtml = Nothing


    End Sub
    Private Sub DetailsView_Team()
        Dim strMenu As String = ""
        Dim sbHtml As New System.Text.StringBuilder
        Dim sbHtmlMenu As New System.Text.StringBuilder
        Dim strSQL As String = ""
        Dim drMenuGroup As IDataReader
        Dim drMenu As IDataReader
        Dim strGroupName As String = ""
        Dim EntityName As String
        Dim EntityPKID As Integer
        Dim NoOfArticles As Integer
        Dim strTab As String
        Dim strSubTab As String

        If CommonFunction.General.CheckIsNothing(Request.QueryString("Tab").ToUpper, "") <> "" Then
            strTab = Request.QueryString("Tab")
        End If

        strMenu = PlotTabMenu()
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

        sbHtml.Append("<div id='PageDiv'  name='PageDiv' style='overflow:auto;width:100%;height:680px;'>") 'height:480px
        sbHtml.Append("<BR><TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>")
        sbHtml.Append("<TR class=clsTRPageCaption><TD align=Left>")

        strSQL = " usp_Sel_tbl_KM_Space " & m_intPageNumber.ToString() & ",null," & Request.QueryString("PrimaryKey")
        drMenuGroup = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If drMenuGroup.Read Then
            strGroupName = CommonFunction.Data.CheckIsDBNull(drMenuGroup("SpaceName"))
        End If
        CommonFunction.Data.DisposeDataReader(drMenuGroup)

        strSQL = " usp_Sel_tbl_KM_SpacePages " & Request.QueryString("PrimaryKey")

        sbHtml.Append("TEAM'S Space : " + HttpUtility.HtmlEncode(strGroupName)) 'HtmlEncode Added By Vaijat K ON 20/11/2015
        sbHtml.Append("</TD></TR></Table><BR>")

        drMenu = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        sbHtml.Append("<table width='100%' class='clsTable' border='0' cellpadding='0'>")
        sbHtml.Append("<tr><td align='left' valign='top' width='33.33%'>")
        sbHtml.Append("<table width='95%'  border='0' cellpadding='5'>")

        While drMenu.Read
            EntityName = drMenu("ProcedureTitle").ToString
            EntityPKID = drMenu("ProcedureID").ToString


            sbHtml.Append("<tr name=trItem_" + HttpUtility.HtmlEncode(EntityName) + " id=trItem_" + HttpUtility.HtmlEncode(EntityName) + " >") 'HtmlEncode Added By Vaijat K ON 20/11/2015
            'sbHtml.Append("<td valign=top width=35>")

            'sbHtml.Append("<img src='..\..\Images\Discussions.gif' vspace=1 border=0></a></td>")
            sbHtml.Append("<td valign=top width=100%><font fontFamily:'Verdana, Arial'; size='1'>")
            sbHtml.Append("<a HREF=""Javascript:Page_OnClick(" + EntityPKID.ToString + ",'Edit','" + m_strFromWhere + "')"">")

            sbHtml.Append(HttpUtility.HtmlEncode(EntityName)) 'HtmlEncode Added By Vaijat K ON 20/11/2015
            sbHtml.Append("</a>")
            sbHtml.Append("</font></td>")
            sbHtml.Append("</tr>")
        End While
        CommonFunction.Data.DisposeDataReader(drMenu)
        sbHtml.Append("</table>")
        sbHtml.Append("</td></tr></table>")
        sbHtml.Append("</Div>")
        CommonFunction.General.WriteHTML(sbHtml.ToString)
        CommonFunction.General.WriteHTML(strMenu)
        sbHtml = Nothing



    End Sub
    Private Sub DetailsView_My()
        Dim strMenu As String = ""
        Dim sbHtml As New System.Text.StringBuilder
        Dim sbHtmlMenu As New System.Text.StringBuilder
        Dim strHtml As New System.Text.StringBuilder
        Dim strSQL As String = ""
        Dim drMenuGroup As IDataReader
        Dim drMenu As IDataReader
        Dim strGroupName As String = ""
        Dim EntityName As String
        Dim EntityPKID As Integer
        Dim NoOfArticles As Integer
        Dim strTab As String
        Dim strSubTab As String
        Dim dbTeamIDForSpace As String = ""

        If CommonFunction.General.CheckIsNothing(Request.QueryString("Tab").ToUpper, "") <> "" Then
            strTab = Request.QueryString("Tab")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("Subtab").ToUpper, "") <> "" Then
            strSubTab = Request.QueryString("Subtab")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("PrimaryKey").ToUpper, "") <> "" Then
            m_strPrimaryKey = Request.QueryString("PrimaryKey")
        End If

        strHtml.Append("<Table class=clsTable cellspacing=0 cellpadding=0 width='100%'>" + vbCrLf)
        strHtml.Append("<TR class=clsTRMenu>" + vbCrLf)
        strHtml.Append("<TD align=Right>" + vbCrLf)
        strHtml.Append("|" + vbCrLf)
        strHtml.Append("<A class='Menu' style=''  Title=""Back""  onclick=""Back_OnClick('" + strTab + "','" + strSubTab + "')"" ><img border=0 src='../../Images/cssImages/Link Images/back.gif'>Back</A> | " + vbCrLf)
        strHtml.Append("<A class='Menu' style=''  Title=""Help""  onclick=""Help_OnClick('KM')"" ><Img Border=0 src='../../Images/cssImages/Link images/help.gif'></A> |" + vbCrLf)
        strHtml.Append("</TD></TR></TABLE>" + vbCrLf)
        CommonFunctions.General.WriteHTML(strHtml.ToString)
        CommonFunctions.General.WriteHTML("<BR>")

        'If strTab = "MY" Then

        sbHtml.Append("<TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>")
        sbHtml.Append("<TR class=clsTRPageCaption><TD align=Left style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>")


        If strSubTab = "MY PAGES" Then
            strSQL = " SELECT ProcedureTitle FROM tbl_KM_CodeHeadings ProcedureID= " & Request.QueryString("PrimaryKey")
        ElseIf strSubTab = "MY SPACES" Then
            strSQL = " usp_Sel_tbl_KM_Space " & m_intPageNumber.ToString() & ",null," & Request.QueryString("PrimaryKey")
        ElseIf strSubTab = "MY TEAMS" Then
            strSQL = " usp_Sel_tbl_KM_Team " & m_intPageNumber.ToString() & ",null," & Request.QueryString("PrimaryKey")
        End If


        drMenuGroup = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If drMenuGroup.Read Then

            If strSubTab = "MY PAGES" Then
                strGroupName = CommonFunction.Data.CheckIsDBNull(drMenuGroup("ProcedureTitle"))
            ElseIf strSubTab = "MY SPACES" Then
                strGroupName = CommonFunction.Data.CheckIsDBNull(drMenuGroup("SpaceName"))
            ElseIf strSubTab = "MY TEAMS" Then
                strGroupName = CommonFunction.Data.CheckIsDBNull(drMenuGroup("TeamName"))
            End If

        End If
        CommonFunction.Data.DisposeDataReader(drMenuGroup)

        If strSubTab = "MY PAGES" Then
            strSQL = " SELECT ProcedureID,ProcedureTitle,ProcedureCode FROM tbl_KM_CodeHeadings WHERE SpaceID IS NULL AND ProcedureID= " & Request.QueryString("PrimaryKey")
        ElseIf strSubTab = "MY SPACES" Then
            strSQL = " usp_Sel_tbl_KM_SpacePages " & Request.QueryString("PrimaryKey")
        ElseIf strSubTab = "MY TEAMS" Then
            strSQL = " usp_Sel_tbl_KM_TeamSpaces " & Request.QueryString("PrimaryKey")
        End If


        If strSubTab = "MY SPACES" Then
            sbHtml.Append("MY SPACE : " + HttpUtility.HtmlEncode(strGroupName)) 'HtmlEncode Added By Vaijat K ON 20/11/2015
        ElseIf strSubTab = "MY TEAMS" Then
            sbHtml.Append("MY TEAM'S : " + HttpUtility.HtmlEncode(strGroupName)) 'HtmlEncode Added By Vaijat K ON 20/11/2015
        End If
        sbHtml.Append("</TD></TR></Table><BR>")

        sbHtml.Append("<div id='PageDiv' name='PageDiv' style='overflow:auto;width:100%;height:680px;'>") 'height:480px

        drMenu = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        sbHtml.Append("<table width='100%' class='clsTable' border='0' cellpadding='0'>")
        sbHtml.Append("<tr><td align='left' valign='top' width='33.33%' style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>")
        'Commented and Added By Bharat T on 30th-Nov-2015
        'sbHtml.Append("<table width='95%'  border='0' cellpadding='5'>")
        sbHtml.Append("<table width='95%'  border='0' cellpadding='5' style='border-collapse:separate; border-spacing:10px;'>")
        'End of Commented and Added By Bharat T on 30th-Nov-2015

        While drMenu.Read
            Select Case strSubTab
                Case "MY PAGES"
                    EntityName = drMenu("ProcedureCode").ToString
                    EntityPKID = drMenu("ProcedureID").ToString
                Case "MY SPACES"
                    EntityName = drMenu("ProcedureTitle").ToString
                    EntityPKID = drMenu("ProcedureID").ToString
                Case "MY TEAMS"
                    EntityName = drMenu("SpaceName").ToString
                    EntityPKID = drMenu("SpaceID").ToString
                    NoOfArticles = CommonFunction.Data.CheckIsDBNull(drMenu("ArticleCount"), "0")
            End Select

            sbHtml.Append("<tr name=trItem_" + HttpUtility.HtmlEncode(EntityName) + " id=trItem_" + HttpUtility.HtmlEncode(EntityName) + " >") 'HtmlEncode Added By Vaijat K ON 20/11/2015
            'sbHtml.Append("<td valign=top width=35>")

            'If strSubTab.ToUpper = "MY SPACES" Or strSubTab.ToUpper = "MY PAGES" Then
            '    sbHtml.Append("<img src='..\..\Images\Discussions.gif' vspace=1 border=0></a></td>")
            'Else
            '    sbHtml.Append("<img src='..\..\Images\spaces1.gif' vspace=1 border=0></a></td>")
            'End If

            sbHtml.Append("<td valign=top width=100%><font fontFamily:'Verdana, Arial'; size='1'>")

            Select Case strSubTab
                Case "MY PAGES"
                    sbHtml.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:Page_OnClick(" + EntityPKID.ToString + ",'View','" + m_strFromWhere + "')"">")
                Case "MY SPACES"
                    Dim strQuery As String = ""
                    Dim drEditAccess As IDataReader
                    Dim strEditAccess As String = ""
                    Dim strProgrammerID As String = ""

                    strEditAccess = ""
                    strProgrammerID = ""

                    strQuery = "usp_Get_EditAccess " + EntityPKID.ToString + "," + HttpContext.Current.Session("intUserID").ToString
                    drEditAccess = CommonFunction.Data.GetDataReader(strQuery, True)
                    If drEditAccess.Read() Then
                        strEditAccess = drEditAccess("IsPresent").ToString
                    End If

                    If drEditAccess.NextResult() Then
                        If drEditAccess.Read() Then
                            strProgrammerID = drEditAccess("ProgrammerID").ToString
                        End If
                    End If

                    If strEditAccess = "1" Or strProgrammerID = HttpContext.Current.Session("intUserID").ToString Then
                        sbHtml.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:SpacePage_OnClick(" + EntityPKID.ToString + ",'Edit','" + m_strFromWhere + "')"" >")
                    Else
                        sbHtml.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:SpacePage_OnClick(" + EntityPKID.ToString + ",'View','" + m_strFromWhere + "')"" >")
                    End If

                    CommonFunction.Data.DisposeDataReader(drEditAccess)

                    'sbHtml.Append("<a HREF=""Javascript:Page_OnClick(" + EntityPKID.ToString + ",'Edit')"">")
                Case "MY TEAMS"
                    Dim strQuery As String = ""
                    Dim drEditAccess As IDataReader
                    Dim strEditAccess As String = ""
                    Dim strProgrammerID As String = ""

                    strEditAccess = ""
                    strProgrammerID = ""

                    strQuery = "usp_Get_EditAccess_Space " + EntityPKID.ToString + "," + HttpContext.Current.Session("intUserID").ToString
                    drEditAccess = CommonFunction.Data.GetDataReader(strQuery, True)
                    If drEditAccess.Read() Then
                        strEditAccess = drEditAccess("IsPresent").ToString
                    End If

                    If drEditAccess.NextResult() Then
                        If drEditAccess.Read() Then
                            strProgrammerID = drEditAccess("AuthorID").ToString
                        End If
                    End If

                    dbTeamIDForSpace = CommonFunction.Data.GetDataScalar("SELECT ISNULL(TeamID,0) FROM tbl_Km_Space WHERE SpaceID =" + EntityPKID.ToString, MyBase.UseSQL)

                    If strEditAccess = "1" Or strProgrammerID = HttpContext.Current.Session("intUserID").ToString Then
                        sbHtml.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:TeamSpace_OnClick(" + EntityPKID.ToString + ",'Edit','" + m_strFromWhere + "'," + dbTeamIDForSpace + ")"">")
                    Else
                        sbHtml.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:TeamSpace_OnClick(" + EntityPKID.ToString + ",'View','" + m_strFromWhere + "'," + dbTeamIDForSpace + ")"">")
                    End If

                    CommonFunction.Data.DisposeDataReader(drEditAccess)

                    'sbHtml.Append("<a HREF=""Javascript:Space_OnClick(" + EntityPKID.ToString + ",'Edit')"">")
            End Select

            sbHtml.Append(HttpUtility.HtmlEncode(EntityName)) 'HtmlEncode Added By Vaijat K ON 20/11/2015
            sbHtml.Append("</a>")
            sbHtml.Append("</font></td>")
            sbHtml.Append("</tr>")

        End While
        CommonFunction.Data.DisposeDataReader(drMenu)
        sbHtml.Append("</table>")
        sbHtml.Append("</td></tr></table>")
        sbHtml.Append("</Div>")
        CommonFunction.General.WriteHTML(sbHtml.ToString)
        'strHtml.Append("<Table class=clsTable cellspacing=0 cellpadding=0 width='100%'>" + vbCrLf)
        'strHtml.Append("<TR class=clsTRMenu>" + vbCrLf)
        'strHtml.Append("<TD align=Right>" + vbCrLf)
        'strHtml.Append("|" + vbCrLf)
        'strHtml.Append("<A class='Menu' style=''  Title=""Back""  onclick=""Back_OnClick('" + strTab + "','" + strSubTab + "')"" ><img border=0 src='../../Images/cssImages/Link Images/back.gif'>Back</A> | " + vbCrLf)
        'strHtml.Append("<A class='Menu' style=''  Title=""Help""  onclick=""Help_OnClick('KM')"" ><Img Border=0 src='../../Images/cssImages/Link images/help.gif'></A> |" + vbCrLf)
        'strHtml.Append("</TD></TR></TABLE><BR>" + vbCrLf)
        CommonFunctions.General.WriteHTML(strHtml.ToString)
        sbHtml = Nothing


        'sbHtmlMenu.Append("<Div id='divContextMenu' class='DropdownMenu' style='width:180px'>")
        'sbHtmlMenu.Append("<Table align=center height='100%' width='100%' cellspacing='0' cellpadding='2'>")
        'sbHtmlMenu.Append("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
        'sbHtmlMenu.Append("<td class='CtMn_LeftFill' ></td>")
        'sbHtmlMenu.Append("<td id='tdMyPages' title='My Pages' >&nbsp;&nbsp;&nbsp;My Pages")
        'sbHtmlMenu.Append("</td></tr>")
        'sbHtmlMenu.Append("<TR><td class='CtMn_LeftFill_hr' ></td>")
        'sbHtmlMenu.Append("<td class='CtMn_Hr'></td></tr>")

        'sbHtmlMenu.Append("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
        'sbHtmlMenu.Append("<td class='CtMn_LeftFill' ></td>")
        'sbHtmlMenu.Append("<td id='tdMySpaces' title='My Spaces' >&nbsp;&nbsp;&nbsp;My Spaces")
        'sbHtmlMenu.Append("</td></tr>")
        'sbHtmlMenu.Append("<TR><td class='CtMn_LeftFill_hr' ></td>")
        'sbHtmlMenu.Append("<td class='CtMn_Hr'></td></tr>")

        'sbHtmlMenu.Append("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
        'sbHtmlMenu.Append("<td class='CtMn_LeftFill' ></td>")
        'sbHtmlMenu.Append("<td id='tdMyTeam' title='My Team''s' >&nbsp;&nbsp;&nbsp;My Team")
        'sbHtmlMenu.Append("</td></tr>")
        'sbHtmlMenu.Append("</table></Div>")
        'CommonFunction.General.WriteHTML(sbHtmlMenu.ToString)
        'sbHtmlMenu = Nothing

    End Sub

    Public Sub PageInit()
        'Dim PKToken_ProcedureID As String
        'PKToken_ProcedureID = CommonFunctions.Security.Token.GetToken(intPKID.ToString + HttpContext.Current.Session("intUserID").ToString + "0" + "0")
        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("IsXMLHTTP"), 0) = 1 Then
            If CommonFunction.General.CheckIsNothing(Request.QueryString("SelectList"), "") <> "" Then
                If Request.QueryString("SelectList") = "3" Or Request.QueryString("SelectList") = "1" Then
                    m_strtxtSearch = m_strtxtSearch.Replace("""", "\""")
                    Select Case intmenuClick
                        Case 1
                            Response.Write(searchArticle(1, intmenuClick)) 'for article
                        Case 2
                            Response.Write(searchArticle(1, intmenuClick))  'for space
                        Case 3
                            Response.Write(searchArticle(1, intmenuClick))  'for team
                    End Select
                End If
            End If
        Else
            WritePage()
        End If
    End Sub
    Protected Sub WritePage()
        'PlotAllTabs()
        Dim strFromWhere As String
        Dim strFrom As String
        Dim strSQL As String
        Dim strvalue As String = ""

        Dim cnt As Integer
        'Added for new UI
        If CommonFunction.General.CheckIsNothing(Request.QueryString("SelectList"), "") <> "" Then
            strSelectList = Request.QueryString("SelectList")
        End If

        For cnt = 1 To 3
            strvalue = CommonFunction.General.CheckIsNothing(Request.Form("txtCurrentPage" + cnt.ToString), "0")
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            ''CommonFunction.HTMLControls.DrawTextBox("txtCurrentPage" + cnt.ToString, "txtCurrentPage" + cnt.ToString, , 200, , strvalue, , , , , , True)
            CommonFunction.HTMLControls.DrawTextBox("txtCurrentPage" + cnt.ToString, "txtCurrentPage" + cnt.ToString, , 200, , strvalue, , , , , , True, EnableHTMLEncode:=True)
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        Next

        If strSelectList = "1" Then
            Response.Write(FeaturedArticle_NewUI())
            Response.Write(searchArticle())
            Exit Sub
        ElseIf strSelectList = "2" Then
            Response.Write(TopTenArticles())
            Exit Sub
        ElseIf strSelectList = "3" Then
            m_strtxtSearch = m_strtxtSearch.Replace("""", "\""")
            ''integrated by RohiniK on 03 Nov 09
            Response.Write(FeaturedArticle_NewUI())
            ''End of integratition by RohiniK on 03 Nov 09
            Response.Write(searchArticle())
            Exit Sub
        End If


        If CommonFunction.General.CheckIsNothing(Request.QueryString("PageNumber"), "") <> "" Then
            m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        End If


        Dim strSearchText As String = ""
        If Not Request.Form("txtSearch") Is Nothing Then
            strSearchText = Request.Form("txtSearch").Trim()
        ElseIf Not Request.QueryString("txtSearch") Is Nothing Then
            strSearchText = Request.QueryString("txtSearch").Trim()
            strSearchText = HttpContext.Current.Server.UrlDecode(strSearchText)
        End If
        'End of New UI


        If m_strAction.ToUpper = "MORE" Then
            m_strtxtSearch = m_strtxtSearch.Replace("""", "\""")
            If CommonFunction.General.CheckIsNothing(Request.QueryString("Tab"), "") = "MY" Then
                Call DetailsView_My()
                Exit Sub
            ElseIf CommonFunction.General.CheckIsNothing(Request.QueryString("Tab"), "") = "TEAM" Then
                Call DetailsView_Team()
                Exit Sub
            ElseIf CommonFunction.General.CheckIsNothing(Request.QueryString("Tab"), "") = "HOME" Then
                If CommonFunction.General.CheckIsNothing(Request.QueryString("FromWhere"), "") <> "" Then
                    strFromWhere = Request.QueryString("FromWhere")
                End If
                If CommonFunction.General.CheckIsNothing(Request.QueryString("From"), "") <> "" Then
                    strFrom = Request.QueryString("From")
                End If
                Call DetailsView_Home(strFromWhere, strFrom)
                Exit Sub
            End If
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("From"), "") <> "" Then
            m_strFrom = Request.QueryString("From")
        End If

        Dim strMenu As String
        If Not m_strFrom Is Nothing Then
            If m_strFrom.ToUpper = "PRODUCT" Then
                strMenu = PlotTabMenu()
                CommonFunctions.General.WriteHTML(strMenu)
                'CommonFunctions.General.WriteHTML("<BR>")
                Exit Sub
            End If
        Else
            strMenu = PlotTabMenu()
        End If

        ''CommonFunctions.General.WriteHTML(strMenu)
        'CommonFunctions.General.WriteHTML("<BR>")

        ''Addition by SuchitraP on 26-Aug-2008 to generate context menu
        ''Context menu 
        'CommonFunction.General.WriteHTML("<Div id='divContextMenu' class='DropdownMenu' style='width:180px'>")
        'CommonFunction.General.WriteHTML("<Table align=center height='100%' width='100%' cellspacing='0' cellpadding='2'>")
        'CommonFunction.General.WriteHTML("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
        'CommonFunction.General.WriteHTML("<td class='CtMn_LeftFill' ></td>")
        'CommonFunction.General.WriteHTML("<td id='tdMyPages' title='My Pages' >&nbsp;&nbsp;&nbsp;My Pages")
        'CommonFunction.General.WriteHTML("</td></tr>")
        'CommonFunction.General.WriteHTML("<TR><td class='CtMn_LeftFill_hr' ></td>")
        'CommonFunction.General.WriteHTML("<td class='CtMn_Hr'></td></tr>")

        'CommonFunction.General.WriteHTML("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
        'CommonFunction.General.WriteHTML("<td class='CtMn_LeftFill' ></td>")
        'CommonFunction.General.WriteHTML("<td id='tdMySpaces' title='My Spaces' >&nbsp;&nbsp;&nbsp;My Spaces")
        'CommonFunction.General.WriteHTML("</td></tr>")
        'CommonFunction.General.WriteHTML("<TR><td class='CtMn_LeftFill_hr' ></td>")
        'CommonFunction.General.WriteHTML("<td class='CtMn_Hr'></td></tr>")

        'CommonFunction.General.WriteHTML("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
        'CommonFunction.General.WriteHTML("<td class='CtMn_LeftFill' ></td>")
        'CommonFunction.General.WriteHTML("<td id='tdMyTeam' title='My Team''s' >&nbsp;&nbsp;&nbsp;My Team")
        'CommonFunction.General.WriteHTML("</td></tr>")
        'CommonFunction.General.WriteHTML("</table></Div>")
        ''End by SuchitraP

        If m_strTab.ToUpper = "MY" Then
            m_strtxtSearch = m_strtxtSearch.Replace("""", "\""")
            If m_strSubTab.ToUpper = "MY PAGES" Then

                ''<input type='button' id=btnGo name=btnGo title='Go' value='Go' onclick='Javascript:Go_OnClick()'/>
                'CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "My Articles &nbsp;&nbsp;&nbsp;<input type='button' id=btnGo name=btnAdd title='Add' value='Add' onclick=""Javascript:AddNew_OnClick('" & m_strTab.ToString & "','" + m_strSubTab + "')""/>", WritePaging("usp_Sel_tbl_KM_CodeHeadings_Count 61,null,1,N'',2"), , True))
                ''CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "My Articles &nbsp;&nbsp;&nbsp;<a Class=""clsLinkControlMenu"" HREF=""Javascript:AddNew_OnClick('" & m_strTab.ToString & "','" + m_strSubTab + "')""> Add Articles </a>", , , True))
                ''CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "My Articles", "<a Class=""clsLinkControlMenu"" Title=""Manage"" HREF=""Javascript:Manage_OnClick('" & m_strTab.ToString & "','" + m_strSubTab + "')""><font size=2 color='blue'>Manage</font></a>&nbsp;&nbsp;&nbsp;", , True))
                'CommonFunctions.General.WriteHTML("<BR>")
                ''PlotMenu()
                CommonFunction.General.WriteHTML("<Table id=tblLegend class='clsTable' border = 0 width=100% cellspacing=0 cellpadding = 0>")
                CommonFunction.General.WriteHTML("<TR class=clsTRPageCaption colspan=13>")
                CommonFunction.General.WriteHTML("<TD align=left class='clsLinkChildNavMenu'>&nbsp;&nbsp;My Articles")
                CommonFunction.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' id=btnAdd name=btnAdd title='Add' value='Add' onclick=""Javascript:AddNew_OnClick('" & m_strTab.ToString & "','" + m_strSubTab + "')""/></TD>")
                CommonFunction.General.WriteHTML("<TD align=right>")
                Call WritePaging("usp_Sel_tbl_KM_CodeHeadings_Count " + HttpContext.Current.Session("intUserID").ToString + ",null,1,N'" + strSearchText + "',null")
                CommonFunction.General.WriteHTML("</TD>")
                CommonFunction.General.WriteHTML("</TR>")
                CommonFunction.General.WriteHTML("</Table>")
            ElseIf m_strSubTab.ToUpper = "MY SPACES" Then

                'CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "My Spaces &nbsp;&nbsp;&nbsp;<input type='button' id=btnGo name=btnAdd title='Add' value='Add' onclick=""Javascript:AddNew_OnClick('" & m_strTab.ToString & "','" + m_strSubTab + "')""/>", WritePaging(strSQL), , True))
                ''CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "My Spaces &nbsp;&nbsp;&nbsp;<a Class=""clsLinkControlMenu"" HREF=""Javascript:AddNew_OnClick('" & m_strTab.ToString & "','" + m_strSubTab + "')"">Add Space</a>", , , True))
                ''CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "My Spaces", "<a Class=""clsLinkControlMenu"" Title=""Manage"" HREF=""Javascript:Manage_OnClick('" & m_strTab.ToString & "','" + m_strSubTab + "')""><font size=2 color='blue'>Manage</font></a>&nbsp;&nbsp;&nbsp;", , True))
                'CommonFunctions.General.WriteHTML("<BR>")
                ''PlotMenu()
                CommonFunction.General.WriteHTML("<Table id=tblLegend class='clsTable' border = 0 width=100% cellspacing=0 cellpadding = 0>")
                CommonFunction.General.WriteHTML("<TR class=clsTRPageCaption colspan=13>")
                CommonFunction.General.WriteHTML("<TD align=left class='clsLinkChildNavMenu'>&nbsp;&nbsp;My Spaces")
                CommonFunction.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' id=btnAdd name=btnAdd title='Add' value='Add' onclick=""Javascript:AddNew_OnClick('" & m_strTab.ToString & "','" + m_strSubTab + "')""/></TD>")
                CommonFunction.General.WriteHTML("<TD align=right>")
                Call WritePaging("usp_Sel_tbl_KM_Space_Count " + HttpContext.Current.Session("intUserID").ToString + ",null,1,N'" + strSearchText + "',null")
                CommonFunction.General.WriteHTML("</TD>")
                CommonFunction.General.WriteHTML("</TR>")
                CommonFunction.General.WriteHTML("</Table>")
            ElseIf m_strSubTab.ToUpper = "MY TEAMS" Then

                'CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "My Team's &nbsp;&nbsp;&nbsp;<input type='button' id=btnGo name=btnAdd title='Add' value='Add' onclick=""Javascript:AddNew_OnClick('" & m_strTab.ToString & "','" + m_strSubTab + "')""/>", WritePaging(strSQL), , True))
                ''CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "My Team's &nbsp;&nbsp;&nbsp;<a Class=""clsLinkControlMenu"" HREF=""Javascript:AddNew_OnClick('" & m_strTab.ToString & "','" + m_strSubTab + "')"">Add Team</a>", , , True))
                ''CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "My Team's", "<a Class=""clsLinkControlMenu"" Title=""Page View"" HREF=""Javascript:PageView_OnClick(0)""><font size=1 color='blue'>Page View</font></a>&nbsp;&nbsp;<a Class=""clsLinkControlMenu"" Title=""Space View"" HREF=""Javascript:SpaceView_OnClick(0)""><font size=1 color='blue'>Space View</font></a>&nbsp;&nbsp;<a Class=""clsLinkControlMenu"" Title=""Manage"" HREF=""Javascript:Manage_OnClick('" & m_strTab.ToString & "','" + m_strSubTab + "')""><font size=1 color='blue'>Manage</font></a>&nbsp;&nbsp;&nbsp;", , True))
                'CommonFunctions.General.WriteHTML("<BR>")
                ''PlotMenu()
                CommonFunction.General.WriteHTML("<Table id=tblLegend class='clsTable' border = 0 width=100% cellspacing=0 cellpadding = 0>")
                CommonFunction.General.WriteHTML("<TR class=clsTRPageCaption colspan=13>")
                CommonFunction.General.WriteHTML("<TD align=left class='clsLinkChildNavMenu'>&nbsp;&nbsp;My Teams")
                CommonFunction.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' id=btnAdd name=btnAdd title='Add' value='Add' onclick=""Javascript:AddNew_OnClick('" & m_strTab.ToString & "','" + m_strSubTab + "')""/></TD>")
                CommonFunction.General.WriteHTML("<TD align=right>")
                Call WritePaging("usp_Sel_tbl_KM_Team_Count " + HttpContext.Current.Session("intUserID").ToString + ",null,1,N'" + strSearchText + "',null")
                CommonFunction.General.WriteHTML("</TD>")
                CommonFunction.General.WriteHTML("</TR>")
                CommonFunction.General.WriteHTML("</Table>")
            End If
        End If

        ''Response.Write("<DIV Id=divMain Style='HEIGHT:80%;OVERFLOW:auto; WIDTH:100%'>")
        'If m_strTab.ToUpper = "MY" Then
        '    Response.Write("<TABLE id=maintable cellSpacing=0 cellPadding=0 width='100%' border=0><TBODY> <TR><TD id=leftbar vAlign=top width='100px'>")
        '    PlotAllSubTabs()
        '    Response.Write("</td> <TD id=contentarea vAlign=top>")
        'End If
        Select Case m_strTab
            Case "HOME"
                'Dim strSearchText As String = ""
                'If Not Request.Form("txtSearch") Is Nothing Then
                '    strSearchText = Request.Form("txtSearch").Trim()
                'ElseIf Not Request.QueryString("txtSearch") Is Nothing Then
                '    strSearchText = Request.QueryString("txtSearch").Trim()
                'End If

                If strSearchText <> "" Then
                    PlotAccessibleEntities("View")
                Else
                    PlotFeaturedArticle()
                End If
            Case "EDIT"
                PlotAccessibleEntities("Edit")
            Case "MY"
                Select Case m_strSubTab.ToUpper
                    Case "MY PAGES"
                        PlotList(EntityType.PAGE, "Edit", True, False, blnPlotAuthor:=False)
                    Case "MY SPACES"
                        PlotList(EntityType.SPACE, "Edit", True, False, blnPlotAuthor:=False)
                    Case "MY BLOGS"
                        PlotList(EntityType.BLOG, "Edit", True, False, blnPlotAuthor:=False)
                    Case "MY TEAMS"
                        PlotList(EntityType.TEAM, "Edit", True, False, blnPlotAuthor:=False)
                    Case "MY STATISTICS"
                        PlotMyStastics()
                End Select
                Response.Write("</td></tr></Table>")
            Case "TEAM"
                PlotTeam()

        End Select

        ''Response.Write("</DIV>")
        'CommonFunction.General.WriteHTML("<TABLE CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Width='99.9%'><TR class=""clsTREven""><TD >Note : Non Internet Explorer browser not supported.</TD></TR></TABLE>")

        CommonFunction.General.WriteHTML("<input type=hidden name=hidFromwhere id=hidFromwhere value='" + m_strFromWhere + "'>" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidtxtSearch id=hidtxtSearch value='" + m_strtxtSearch + "'>" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidtxtPageNumber id=hidtxtPageNumber value='" + Request.Form("txtPageNumber") + "'>" + vbCrLf)



        If m_strTab.ToUpper = "MY" Then
            'PlotMenu()
        End If


        'Response.Write("<BR>")
        ''Response.Write(strMenu)


    End Sub

    Private Sub PlotMyStastics()
        Dim strSQLquery As String
        Dim drStatistics As IDataReader
        Dim intCount As Integer

        ''integrated by RohiniK on 03 Nov 09
        'strSQLquery = " Select Count(1) from tbl_KM_CodeHeadings "
        strSQLquery = " Select Count(1) from tbl_KM_CodeHeadings WHERE ProgrammerID IS NOT NULL "

        ''End of integratition by RohiniK on 03 Nov 09
        intCount = CommonFunctions.Data.GetDataScalar(strSQLquery, MyBase.UseSQL)

        strSQLquery = "usp_sel_tbl_KM_CodeHeadings_Statistics " + HttpContext.Current.Session("intUserID").ToString
        drStatistics = CommonFunction.Data.GetDataReader(strSQLquery, MyBase.UseSQL)

        'style='border-right:solid 1px #989898;background-color:#FBFBFB' valign=top
        Response.Write("<Table id='tblpane4' width=100% CellSpacing=0 CellPadding=0  class='clsGridTable'>")
        Response.Write("<tr width=100% style=""background-color:#FFFFFF "">")
        Response.Write("<TD width=10%><IMG Border=0 src='../../Images/Statistics.jpg'></TD>")
        Response.Write("<TD align=left width=90%><FONT face=""Verdana"" color=""#990033"" size=""3""><I><B>Stastics</B></I></FONT></TD>")
        Response.Write("</tr>")
        Response.Write("<tr width=100% style=""background-color:#FFFFFF "">")
        Response.Write("<TD colspan=2 align=left style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>Total Articles in Knowledge : <B>" + intCount.ToString + "</B></TD>")
        Response.Write("</tr>")
        Response.Write("<tr width=100% style=""background-color:#FFFFFF "">")
        If drStatistics.Read Then
            If CommonFunction.Data.CheckIsDBNull(drStatistics("Counter").ToString, "0") <> "0" Then
                Response.Write("<TD colspan=2 align=left style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>Articles submitted this month : <B>" + drStatistics("Counter").ToString + "</B> </TD>")
            Else
                Response.Write("<TD colspan=2 align=left style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>Articles submitted this month : <B>0</B> </TD>")
            End If
        End If

        Response.Write("</tr>")
        Response.Write("<tr width=100% style=""background-color:#FFFFFF "">")
        If drStatistics.NextResult Then
            If drStatistics.Read Then
                If CommonFunction.Data.CheckIsDBNull(drStatistics("Counter").ToString, "0") <> "0" Then
                    Response.Write("<TD colspan=2 align=left style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>You submitted <B>" + drStatistics("Counter").ToString + "</B> Articles this month</TD>")
                Else
                    Response.Write("<TD colspan=2 align=left style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>You submitted <B>0</B> Articles this month</TD>")
                End If
            End If
        End If

        CommonFunction.Data.DisposeDataReader(drStatistics)

        Response.Write("</tr>")
    End Sub
    Private Sub InitVariables()
        If Not Request("Mode") Is Nothing Then
            m_strMode = Request("Mode")
        End If
        If Not Request("Tab") Is Nothing Then
            m_strTab = Request("Tab")
        End If
        If Not Request("SubTab") Is Nothing Then
            m_strSubTab = Request("SubTab")
        End If
        If Not Request("Action") Is Nothing Then
            m_strAction = Request("Action")
        End If
        If Not Request("cboTeam") Is Nothing Then
            If Request("cboTeam") <> "" Then
                m_lngTeamId = Request("cboTeam")
            End If

        End If

        intmenuClick = CommonFunction.General.CheckIsNothing(Request("MenuClick"), "0")

        If CommonFunction.General.CheckIsNothing(Request.QueryString("Fromwhere"), "") <> "" Then
            m_strFromWhere = Request.QueryString("Fromwhere")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidFromwhere"), "") <> "" Then
            m_strFromWhere = Request.Form("hidFromwhere")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("txtSearch"), "") <> "" Then
            m_strtxtSearch = CommonFunction.General.BuildQueryString(Request.QueryString("txtSearch"))
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidtxtSearch"), "") <> "" Then
            m_strtxtSearch = CommonFunction.General.BuildQueryString(Request.Form("hidtxtSearch"))
        End If

        If CommonFunction.General.CheckIsNothing(Request.Form("txtPageNumber"), "") <> "" Then
            m_strPagingNumber = Request.Form("txtPageNumber")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidtxtPageNumber"), "") <> "" Then
            m_strPagingNumber = Request.Form("hidtxtPageNumber")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("PageNumber"), "") <> "" Then
            m_strPagingNumber = Request.QueryString("PageNumber")
        End If

        m_strPageTitle = "Knowledge"
        m_lngUserId = Session("intUserID")
        m_lngPostId = Session("intPostID")
    End Sub
    Private Sub PlotSearchControl()
        Dim sbHTML As New System.Text.StringBuilder
        Dim strSearchText As String = ""
        If Not Request.Form("txtSearch") Is Nothing Then
            strSearchText = Request.Form("txtSearch").Trim()
        ElseIf Not Request.QueryString("txtSearch") Is Nothing Then
            strSearchText = Request.QueryString("txtSearch").Trim()
        End If

        ''sbHTML.Append("<TR class=clsTREven valign=middle>")
        '''sbHTML.Append("<TR valign=middle>")
        ''sbHTML.Append("<td  align=right width=30% colspan=1><font fontFamily:'Verdana'> Search </font></td><td align=left colspan=2>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearch", "txtSearch", , 300, 200, value:=strSearchText, returnHTML:=True))
        sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearch", "txtSearch", , 300, 200, value:=strSearchText, returnHTML:=True, EnableHTMLEncode:=True))
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        ''sbHTML.Append("</td></tr>")
        CommonFunctions.General.WriteHTML(sbHTML.ToString)
        sbHTML = Nothing
    End Sub
    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
        CommonFunction.General.WriteHTML("<LINK href='tabcontent.css' type=text/css rel=stylesheet>")
    End Sub
    Private Sub PlotAllTabs()
        Dim sbHTML As New System.Text.StringBuilder

        sbHTML.Append("<div style='border:1px solid gray; width ='100%'; margin-bottom: 1em; padding: 10px'>")
        sbHTML.Append("<ul id='Maintabs' class=shadetabs>")
        sbHTML.Append(PlotTab("Home"))
        sbHTML.Append(PlotTab("My"))
        sbHTML.Append(PlotTab("Team"))
        'sbHTML.Append(PlotTab("Edit"))

        sbHTML.Append("</ul></div>")
        CommonFunction.General.WriteHTML(sbHTML.ToString)

    End Sub
    Private Function PlotTabMenu()
        Dim strHtml As New System.Text.StringBuilder
        Dim strSQL As String
        Dim IsProductExecution As String

        strSQL = "SELECT EnableProductExecution FROM tbl_PM_CompanyInformation"
        IsProductExecution = CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)

        strHtml.Append("<Table class=clsTable cellspacing=0 cellpadding=0 width='100%'>" + vbCrLf)
        strHtml.Append("<TR class='clsTRMenu'>" + vbCrLf)
        strHtml.Append("<TD align=Left><B>" + vbCrLf)
        strHtml.Append("|" + vbCrLf)
        If IsProductExecution = True Then
            strHtml.Append("<A class='Menu' style=''  Title=""Product Collateral""  onclick=""Product_OnClick()"" >Product Collateral</A> | " + vbCrLf)
        End If

        If Not m_strFrom Is Nothing Then
            If m_strFrom.ToUpper <> "PRODUCT" Then
                strHtml.Append("<A class='Menu' style=''  Title=""My Articles""  onclick=""ShowContextMenu('MY PAGES')"" >My Articles</A> | " + vbCrLf)
                strHtml.Append("<A class='Menu' style=''  Title=""My Spaces""  onclick=""ShowContextMenu('MY SPACES')"" >My Spaces</A> | " + vbCrLf)
                strHtml.Append("<A class='Menu' style=''  Title=""My Team's""  onclick=""ShowContextMenu('MY TEAMS')"" >My Team's</A> | " + vbCrLf)
            End If
        Else
            strHtml.Append("<A class='Menu' style=''  Title=""My Articles""  onclick=""ShowContextMenu('MY PAGES')"" >My Articles</A> | " + vbCrLf)
            strHtml.Append("<A class='Menu' style=''  Title=""My Spaces""  onclick=""ShowContextMenu('MY SPACES')"" >My Spaces</A> | " + vbCrLf)
            strHtml.Append("<A class='Menu' style=''  Title=""My Teams""  onclick=""ShowContextMenu('MY TEAMS')"" >My Teams</A> | " + vbCrLf)
        End If

        strHtml.Append("</B></TD>" + vbCrLf)
        strHtml.Append("<TD align=Right>" + vbCrLf)
        strHtml.Append("<B><A class='Menu' style=''  Title=""Home""  onclick=""Home_OnClick('HOME')"" ><img border=0 src='..\..\Images\home.gif'> Home </A> | " + vbCrLf)

        'If Not m_strFrom Is Nothing Then
        '    If m_strFrom.ToUpper <> "PRODUCT" Then
        '        strHtml.Append("<A class='Actions' Title=""My"" onmouseover=""JavaScript:ShowContextMenu(event,this)"" >My</A> | " + vbCrLf)
        '    End If
        'Else
        '    strHtml.Append("<A class='Actions' Title=""My"" onmouseover=""JavaScript:ShowContextMenu(event,this)"" >My</A> | " + vbCrLf)
        'End If
        ''strHtml.Append("<A class='Menu' style=''  Title=""Team""  onclick=""Team_OnClick('TEAM')"" >Team</A> | " + vbCrLf)
        ''strHtml.Append("<A class='Menu' style=''  Title=""Help""  onclick=""Help_OnClick('KM')"" ><Img Border=0 src='../../Images/cssImages/Link images/help.gif'></A> |" + vbCrLf)
        strHtml.Append("</B></TD></TR></TABLE>" + vbCrLf)

        Return strHtml.ToString
    End Function

    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
    Private Sub PlotAllSubTabs()
        Dim sbHTML As New System.Text.StringBuilder
        'sbHTML.Append("<div style='border:1px solid gray; width ='100%'; margin-bottom: 1em; padding: 10px'>")
        sbHTML.Append("<ul id='Subtabs' class='categorylinks'>")
        sbHTML.Append(PlotSubTab("My", "My Pages"))
        sbHTML.Append(PlotSubTab("My", "My Spaces"))
        'sbHTML.Append(PlotSubTab("My", "My Blogs"))
        sbHTML.Append(PlotSubTab("My", "My Teams"))
        sbHTML.Append("</ul>")
        CommonFunction.General.WriteHTML(sbHTML.ToString)
    End Sub
    Private Function PlotTab(ByVal strTabName As String) As String
        Dim sbHTML As New System.Text.StringBuilder
        If m_strTab = strTabName.ToUpper Then
            sbHTML.Append("<li><a  class=selected href='javascript:Tab_Onclick(""" + strTabName.ToUpper + """) '>")
            sbHTML.Append(CommonFunction.General.FormatString(Server.HtmlEncode(strTabName)))
        Else
            sbHTML.Append("<li><a  href='javascript:Tab_Onclick(""" + strTabName.ToUpper + """)'>")
            sbHTML.Append(CommonFunction.General.FormatString(Server.HtmlEncode(strTabName)))
        End If
        sbHTML.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        sbHTML.Append("</a></li>")
        Return sbHTML.ToString
    End Function
    Private Function PlotSubTab(ByVal strTabName As String, ByVal strSubTabName As String) As String

        Dim sbHTML As New System.Text.StringBuilder

        If m_strSubTab = strSubTabName.ToUpper Then
            sbHTML.Append("<li><a  class=subTabselected href='javascript:SubTab_Onclick(""" + strTabName.ToUpper + """,""" + strSubTabName.ToUpper + """) '>")
            sbHTML.Append(CommonFunction.General.FormatString(Server.HtmlEncode(strSubTabName)))

        Else
            sbHTML.Append("<li><a href='javascript:SubTab_Onclick(""" + strTabName.ToUpper + """,""" + strSubTabName.ToUpper + """)'>")
            sbHTML.Append(CommonFunction.General.FormatString(Server.HtmlEncode(strSubTabName)))
        End If
        'sbHTML.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        sbHTML.Append("</a></li>")
        Return sbHTML.ToString

    End Function



    Private Sub PlotAccessibleEntities(ByVal strMode As String)
        Dim strSQL_Page As String
        Dim strSPname_Page As String
        Dim dsEntity_Page As IDataReader
        Dim strSearchText_Page As String = ""
        Dim strIDColumn_Page As String
        Dim strTitleColumn_Page As String
        Dim strEditFunctionName_Page As String

        Dim strSQL_Space As String
        Dim strSPname_Space As String
        Dim dsEntity_Space As IDataReader
        Dim strSearchText_Space As String = ""
        Dim strIDColumn_Space As String
        Dim strTitleColumn_Space As String
        Dim strEditFunctionName_Space As String

        'Added by SuchitraP on 1-Oct-2008 to display team on search page
        Dim strSQL_Team As String
        Dim strSPname_Team As String
        Dim dsEntity_Team As IDataReader
        Dim strSearchText_Team As String = ""
        Dim strIDColumn_Team As String
        Dim strTitleColumn_Team As String
        Dim strEditFunctionName_Team As String
        Dim blnEditAccess As Boolean
        Dim strSQL As String
        Dim blnViewAccess As Boolean
        'End by SuchitraP

        Dim intCount As Integer
        Dim intRecordCount As Integer = 0

        Dim sbHtml As New System.Text.StringBuilder
        Dim sbHtmlLeft As New System.Text.StringBuilder
        Dim sbHtml_Left As New System.Text.StringBuilder
        Dim sbHtmlRight As New System.Text.StringBuilder

        PlotUpperHeaderSection()

        strIDColumn_Page = "ProcedureID"
        strTitleColumn_Page = "ProcedureTitle"
        strSPname_Page = "usp_Sel_tbl_KM_CodeHeadings"
        strEditFunctionName_Page = "Page_OnClick"

        If Not Request.Form("txtSearch") Is Nothing Then
            strSearchText_Page = Request.Form("txtSearch").Trim()
            strSearchText_Page = CommonFunctions.General.BuildQueryString(strSearchText_Page)
        ElseIf Not Request.QueryString("txtSearch") Is Nothing Then
            strSearchText_Page = Request.QueryString("txtSearch").Trim()
            strSearchText_Page = CommonFunctions.General.BuildQueryString(strSearchText_Page)
        End If
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''sbHtml.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearchChar", "txtSearchChar", , , , Request("txtSearch").Trim(), IsHidden:=True, returnHTML:=True))
        sbHtml.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearchChar", "txtSearchChar", , , , Request("txtSearch").Trim(), IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding


        strSQL_Page = strSPname_Page & " "
        strSQL_Page = strSQL_Page & m_intPageNumber.ToString() & "," & m_lngUserId.ToString & ",NULL,"

        If m_strTab.ToUpper = "MY" Then
            strSQL_Page = strSQL_Page & "1,"
        Else
            strSQL_Page = strSQL_Page & "0,"
        End If
        strSQL_Page = strSQL_Page & "N'" & strSearchText_Page & "'"

        If m_strTab.ToUpper = "EDIT" Then
            strSQL_Page = strSQL_Page & ",1"
        ElseIf m_strTab.ToUpper = "HOME" Then
            strSQL_Page = strSQL_Page & ",2"
        End If

        dsEntity_Page = CommonFunctions.Data.GetDataReader(strSQL_Page, MyBase.UseSQL)

        sbHtml.Append("<BR>")
        sbHtml.Append("<table CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Width='99.9%' >")
        sbHtml.Append("<TR>")

        sbHtmlLeft.Append("<TD align=center valign=top WIDTH=""49%"">")
        sbHtmlRight.Append("<TD align=center valign=top WIDTH=""49%"">")

        sbHtmlLeft.Append("<table id='HeaderTable' WIDTH=99.9% CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Class=""clsRoundedTableHeader"" >")
        sbHtmlLeft.Append("<tr>")
        sbHtmlLeft.Append("<td WIDTH=""14"" class=""clsTDTopLeftCorner"">  </td>")
        sbHtmlLeft.Append("<td  rowspan=""2"" valign=""middle""> ")
        sbHtmlLeft.Append("<table WIDTH=100% Class=""clsRoundedTableHeader"" ><tr><td align=""Left""><b>Articles</b></td>")
        sbHtmlLeft.Append("<td align=right><a Class=""clsLinkControlMenu"" HREF=""Javascript:ShowHideGroup_Onclick(1)""><img id='imgGroup1'  SRC=""../../Images/MoveUp.GIF"" BORDER=""0"" ALT=""..."" width=""14"" height=""14""></a></td></tr></table>")
        sbHtmlLeft.Append("<br>")
        sbHtmlLeft.Append("</td>")

        sbHtmlLeft.Append("<td WIDTH=""14"" class=""clsTDTopRightCorner"">  </td>")
        sbHtmlLeft.Append("</tr>")
        sbHtmlLeft.Append("<tr>")
        sbHtmlLeft.Append("<td>&nbsp;&nbsp;</td>")
        sbHtmlLeft.Append("<td>&nbsp;&nbsp;</td>")
        sbHtmlLeft.Append("</tr>")
        sbHtmlLeft.Append("</table>")
        sbHtmlLeft.Append("<table  id=tblGroup1 WIDTH=100% CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Class=""clsRoundedTableMenu"">")

        While dsEntity_Page.Read
            sbHtmlLeft.Append("<tr class=""clsTRControlMenu"">")
            'sbHtmlLeft.Append("<td valign=top width=20>")
            'sbHtmlLeft.Append("<img src='..\..\Images\Discussions.gif' vspace=1 border=0></a>")
            sbHtmlLeft.Append("<td valign=top width=100%><font fontFamily:'Verdana, Arial'; size='1'>")
            sbHtmlLeft.Append("<a HREF=""Javascript:Page_OnClick(" + dsEntity_Page("ProcedureID").ToString + ",'View','" + m_strFromWhere + "')"">")
            sbHtmlLeft.Append(HttpUtility.HtmlEncode(dsEntity_Page("ProcedureTitle").ToString)) 'HtmlEncode Added By Vaijat K ON 20/11/2015
            sbHtmlLeft.Append("</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            sbHtmlLeft.Append("</font>")
            sbHtmlLeft.Append("</td>")
            sbHtmlLeft.Append("<td valign='top' align='right'>")
            sbHtmlLeft.Append("</td>")
            sbHtmlLeft.Append("</tr>")
            intCount = intCount + 1
            If intCount >= 10 Then
                Exit While
            End If
        End While
        CommonFunction.Data.DisposeDataReader(dsEntity_Page)

        If intCount >= 10 Then
            sbHtmlLeft.Append("<tr class=""clsTRControlMenu"">")
            sbHtmlLeft.Append("<td align=right colspan=3>")
            sbHtmlLeft.Append("&nbsp;&nbsp;<a HREF=""Javascript:ShowDetailsHome_Onclick(1)""> <font color='blue' style='font-size:10px'>More Articles...</font>")
            sbHtmlLeft.Append("</a>&nbsp;&nbsp;&nbsp;&nbsp;</td>")
            sbHtmlLeft.Append("</tr>")
        Else
            sbHtmlLeft.Append("<tr class=""clsTRControlMenu"">")
            sbHtmlLeft.Append("<td align=center colspan=3>")
            If intCount = 0 Then
                sbHtmlLeft.Append("There are no items to show in this view...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
            End If
            sbHtmlLeft.Append("</TD></tr>")
        End If

        sbHtmlLeft.Append(" <tr>")
        sbHtmlLeft.Append("<td  class=""clsTDBottomLeftCorner"">  </td>")
        sbHtmlLeft.Append("<td WIDTH=" & (400 - 28).ToString & " ></td>")
        sbHtmlLeft.Append("<td></td><td class=""clsTDBottomRightCorner""></td>")
        sbHtmlLeft.Append("</tr>")
        sbHtmlLeft.Append("</table>")


        'Space
        intCount = 0
        strIDColumn_Space = "SpaceID"
        strTitleColumn_Space = "SpaceName"
        strSPname_Space = "usp_Sel_tbl_KM_Space"
        strEditFunctionName_Space = "Space_OnClick"

        If Not Request.Form("txtSearch") Is Nothing Then
            strSearchText_Space = Request.Form("txtSearch").Trim()
            strSearchText_Space = CommonFunctions.General.BuildQueryString(strSearchText_Space)
        ElseIf Not Request.QueryString("txtSearch") Is Nothing Then
            strSearchText_Space = Request.QueryString("txtSearch").Trim()
            strSearchText_Space = CommonFunctions.General.BuildQueryString(strSearchText_Space)
        End If

        strSQL_Space = strSPname_Space & " "
        strSQL_Space = strSQL_Space & m_intPageNumber.ToString() & "," & m_lngUserId.ToString & ",NULL,"

        If m_strTab.ToUpper = "MY" Then
            strSQL_Space = strSQL_Space & "1,"
        Else
            strSQL_Space = strSQL_Space & "0,"
        End If
        strSQL_Space = strSQL_Space & "N'" & strSearchText_Space & "'"

        If m_strTab.ToUpper = "EDIT" Then
            strSQL_Space = strSQL_Space & ",1"
        ElseIf m_strTab.ToUpper = "HOME" Then
            strSQL_Space = strSQL_Space & ",2"
        End If

        dsEntity_Space = CommonFunctions.Data.GetDataReader(strSQL_Space, MyBase.UseSQL)

        sbHtmlRight.Append("<table id='HeaderTable' WIDTH=99.9% CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Class=""clsRoundedTableHeader"" >")
        sbHtmlRight.Append("<tr>")
        sbHtmlRight.Append("<td WIDTH=""14"" class=""clsTDTopLeftCorner"">  </td>")
        sbHtmlRight.Append("<td  rowspan=""2"" valign=""middle""> ")
        sbHtmlRight.Append("<table WIDTH=100% Class=""clsRoundedTableHeader"" ><tr><td align=""Left""><b>Spaces</b></td>")
        sbHtmlRight.Append("<td align=right><a Class=""clsLinkControlMenu"" HREF=""Javascript:ShowHideGroup_Onclick(2)""><img id='imgGroup2'  SRC=""../../Images/MoveUp.GIF"" BORDER=""0"" ALT=""..."" width=""14"" height=""14""></a></td></tr></table>")
        sbHtmlRight.Append("<br>")
        sbHtmlRight.Append("</td>")

        sbHtmlRight.Append("<td WIDTH=""14"" class=""clsTDTopRightCorner"">  </td>")
        sbHtmlRight.Append("</tr>")
        sbHtmlRight.Append("<tr>")
        sbHtmlRight.Append("<td>&nbsp;&nbsp;</td>")
        sbHtmlRight.Append("<td>&nbsp;&nbsp;</td>")
        sbHtmlRight.Append("</tr>")
        sbHtmlRight.Append("</table>")
        sbHtmlRight.Append("<table  id=tblGroup2 WIDTH=100% CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Class=""clsRoundedTableMenu"">")

        While dsEntity_Space.Read
            sbHtmlRight.Append("<tr class=""clsTRControlMenu"">")
            'sbHtmlRight.Append("<td valign=top width=20>")
            'sbHtmlRight.Append("<img src='..\..\Images\spaces1.gif' vspace=1 border=0></a></td>")
            sbHtmlRight.Append("<td valign=top width=100%><font fontFamily:'Verdana, Arial'; size='1'>")
            sbHtmlRight.Append("<a HREF=""Javascript:Space_OnClick(" + dsEntity_Space("SpaceID").ToString + ",'View','" + m_strFromWhere + "')"">")
            sbHtmlRight.Append(HttpUtility.HtmlEncode(dsEntity_Space("SpaceName").ToString)) 'HtmlEncode Added By Vaijat K ON 20/11/2015
            sbHtmlRight.Append("</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            sbHtmlRight.Append("</font>")
            sbHtmlRight.Append("</td>")
            sbHtmlRight.Append("<td valign='top' align='right'>")
            sbHtmlRight.Append("</td>")
            sbHtmlRight.Append("</tr>")
            intCount = intCount + 1
            If intCount >= 10 Then
                Exit While
            End If
        End While
        CommonFunction.Data.DisposeDataReader(dsEntity_Space)

        If intCount >= 10 Then
            sbHtmlRight.Append("<tr class=""clsTRControlMenu"">")
            sbHtmlRight.Append("<td align=right colspan=3>")
            sbHtmlRight.Append("&nbsp;&nbsp;<a HREF=""Javascript:ShowDetailsHome_Onclick(2)""> <font color='blue' style='font-size:10px'>More Spaces...</font>")
            sbHtmlRight.Append("</a>&nbsp;&nbsp;&nbsp;&nbsp;</td>")
            sbHtmlRight.Append("</tr>")
        Else
            sbHtmlRight.Append("<tr class=""clsTRControlMenu"">")
            sbHtmlRight.Append("<td align=center colspan=3>")
            If intCount = 0 Then
                sbHtmlRight.Append("There are no items to show in this view...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
            End If
            sbHtmlRight.Append("</TD></tr>")
        End If

        sbHtmlRight.Append(" <tr>")
        sbHtmlRight.Append("<td  class=""clsTDBottomLeftCorner"">  </td>")
        sbHtmlRight.Append("<td WIDTH=" & (400 - 28).ToString & " ></td>")
        sbHtmlRight.Append("<td></td><td class=""clsTDBottomRightCorner""></td>")
        sbHtmlRight.Append("</tr>")
        sbHtmlRight.Append("</table>")


        sbHtmlLeft.Append("</TD>")
        sbHtmlRight.Append("</TD>")


        sbHtml.Append(sbHtmlLeft.ToString)
        sbHtml.Append("<td WIDTH=""2%""></td>")
        sbHtml.Append(sbHtmlRight.ToString)
        sbHtml.Append("</tr>")

        'Added by SuchitraP on 1-Oct-2008 to display team on search page
        intCount = 0
        strIDColumn_Team = "TeamID"
        strTitleColumn_Team = "TeamName"
        strSPname_Team = "usp_Sel_tbl_KM_Team"
        strEditFunctionName_Team = "Edit_TeamDetails"

        If Not Request.Form("txtSearch") Is Nothing Then
            strSearchText_Team = Request.Form("txtSearch").Trim()
            strSearchText_Team = CommonFunctions.General.BuildQueryString(strSearchText_Team)
        ElseIf Not Request.QueryString("txtSearch") Is Nothing Then
            strSearchText_Team = Request.QueryString("txtSearch").Trim()
            strSearchText_Team = CommonFunctions.General.BuildQueryString(strSearchText_Team)
        End If
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''sbHtml.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearchChar", "txtSearchChar", , , , CommonFunction.General.CheckIsNothing(Request("txtSearch")).Trim, IsHidden:=True, returnHTML:=True))
        sbHtml.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearchChar", "txtSearchChar", , , , CommonFunction.General.CheckIsNothing(Request("txtSearch")).Trim, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding


        strSQL_Team = strSPname_Team & " "
        strSQL_Team = strSQL_Team & m_intPageNumber.ToString() & "," & m_lngUserId.ToString & ",NULL,"

        If m_strTab.ToUpper = "MY" Then
            strSQL_Team = strSQL_Team & "1,"
        Else
            strSQL_Team = strSQL_Team & "0,"
        End If
        strSQL_Team = strSQL_Team & "N'" & strSearchText_Team & "'"

        'If m_strTab.ToUpper = "EDIT" Then
        '    strSQL_Team = strSQL_Team & ",1"
        'ElseIf m_strTab.ToUpper = "HOME" Then
        '    strSQL_Team = strSQL_Team & ",2"
        'End If

        strSQL_Team = strSQL_Team & ",2"

        dsEntity_Team = CommonFunctions.Data.GetDataReader(strSQL_Team, MyBase.UseSQL)
        sbHtml.Append("<TR><TD align=center valign=top WIDTH=""49%"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD></TR>")
        sbHtml.Append("<TR>")

        sbHtml_Left.Append("<TD align=center valign=top WIDTH=""49%"">")
        sbHtml_Left.Append("<table id='HeaderTable' WIDTH=99.9% CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Class=""clsRoundedTableHeader"" >")
        sbHtml_Left.Append("<tr>")
        sbHtml_Left.Append("<td WIDTH=""14"" class=""clsTDTopLeftCorner"">  </td>")
        sbHtml_Left.Append("<td  rowspan=""2"" valign=""middle""> ")
        sbHtml_Left.Append("<table WIDTH=100% Class=""clsRoundedTableHeader"" ><tr><td align=""Left""><b>Teams</b></td>")
        sbHtml_Left.Append("<td align=right><a Class=""clsLinkControlMenu"" HREF=""Javascript:ShowHideGroup_Onclick(3)""><img id='imgGroup3'  SRC=""../../Images/MoveUp.GIF"" BORDER=""0"" ALT=""..."" width=""14"" height=""14""></a></td></tr></table>")
        sbHtml_Left.Append("<br>")
        sbHtml_Left.Append("</td>")

        sbHtml_Left.Append("<td WIDTH=""14"" class=""clsTDTopRightCorner"">  </td>")
        sbHtml_Left.Append("</tr>")
        sbHtml_Left.Append("<tr>")
        sbHtml_Left.Append("<td>&nbsp;&nbsp;</td>")
        sbHtml_Left.Append("<td>&nbsp;&nbsp;</td>")
        sbHtml_Left.Append("</tr>")
        sbHtml_Left.Append("</table>")
        sbHtml_Left.Append("<table  id=tblGroup3 WIDTH=100% CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Class=""clsRoundedTableMenu"">")

        While dsEntity_Team.Read
            sbHtml_Left.Append("<tr class=""clsTRControlMenu"">")
            'sbHtml_Left.Append("<td valign=top width=20>")
            'sbHtml_Left.Append("<img src='..\..\Images\Discussions.gif' vspace=1 border=0></a>")
            sbHtml_Left.Append("<td valign=top width=100%><font fontFamily:'Verdana, Arial'; size='1'>")

            If dsEntity_Team("TeamID").ToString > 0 Then
                strSQL = " Select dbo.udf_GetTeamAccess(1," & m_lngUserId & "," & dsEntity_Team("TeamID").ToString & ")"
                blnEditAccess = CBool(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL))
                strSQL = "SELECT dbo.udf_GetTeamAccess(2," & m_lngUserId & "," & dsEntity_Team("TeamID").ToString & ")"
                blnViewAccess = CBool(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL))
                If blnEditAccess Then
                    sbHtml_Left.Append("<a HREF=""Javascript:Edit_TeamDetails(" + dsEntity_Team("TeamID").ToString + ",'EDIT','" + m_strFromWhere + "')"">")
                ElseIf blnViewAccess Then
                    sbHtml_Left.Append("<a HREF=""Javascript:Edit_TeamDetails(" + dsEntity_Team("TeamID").ToString + ",'View','" + m_strFromWhere + "')"">")
                End If
            End If

            sbHtml_Left.Append(HttpUtility.HtmlEncode(dsEntity_Team("TeamName").ToString)) 'HtmlEncode Added By Vaijat K ON 20/11/2015
            sbHtml_Left.Append("</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            sbHtml_Left.Append("</font>")
            sbHtml_Left.Append("</td>")
            sbHtml_Left.Append("<td valign='top' align='right'>")
            sbHtml_Left.Append("</td>")
            sbHtml_Left.Append("</tr>")
            intCount = intCount + 1
            If intCount >= 10 Then
                Exit While
            End If
        End While
        CommonFunction.Data.DisposeDataReader(dsEntity_Team)

        If intCount >= 10 Then
            sbHtml_Left.Append("<tr class=""clsTRControlMenu"">")
            sbHtml_Left.Append("<td align=right colspan=3>")
            sbHtml_Left.Append("&nbsp;&nbsp;<a HREF=""Javascript:ShowDetailsHome_Onclick(3)""> <font color='blue' style='font-size:10px'>More Teams...</font>")
            sbHtml_Left.Append("</a>&nbsp;&nbsp;&nbsp;&nbsp;</td>")
            sbHtml_Left.Append("</tr>")
        Else
            sbHtml_Left.Append("<tr class=""clsTRControlMenu"">")
            sbHtml_Left.Append("<td align=center colspan=3>")
            If intCount = 0 Then
                sbHtml_Left.Append("There are no items to show in this view...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
            End If
            sbHtml_Left.Append("</TD></tr>")
        End If

        sbHtml_Left.Append(" <tr>")
        sbHtml_Left.Append("<td  class=""clsTDBottomLeftCorner"">  </td>")
        sbHtml_Left.Append("<td WIDTH=" & (400 - 28).ToString & " ></td>")
        sbHtml_Left.Append("<td></td><td class=""clsTDBottomRightCorner""></td>")
        sbHtml_Left.Append("</tr>")
        sbHtml_Left.Append("</table>")
        sbHtml_Left.Append("</TD>")

        sbHtml.Append(sbHtml_Left.ToString)
        sbHtml.Append("<td WIDTH=""2%""></td>")
        sbHtml.Append("</tr>")

        'End by SuchitraP

        sbHtml.Append("</table>")
        sbHtml.Append("</Div>")
        CommonFunction.General.WriteHTML(sbHtml.ToString)

        sbHtml = Nothing

    End Sub
    Private Sub PlotTeam()
        Dim strSQL As String
        Dim blnEditAccess As Boolean

        strSQL = "usp_Sel_tbl_KM_Team "
        strSQL = strSQL & m_intPageNumber.ToString() & "," & m_lngUserId.ToString & ",NULL,2"

        Response.Write("<br>")
        Response.Write("<TABLE id='tblCap00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageCaption><td align=Right>View Spaces for Team</td><td align=left>")
        Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboTeam", strSQL, 200, m_lngTeamId, "onChange=Team_OnChange()", True))


        If m_lngTeamId > 0 Then
            strSQL = " Select dbo.udf_GetTeamAccess(1," & m_lngUserId & "," & m_lngTeamId & ")"
            blnEditAccess = CBool(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL))

            If blnEditAccess Then
                Response.Write("&nbsp;&nbsp;&nbsp;<a Href=""javascript:Edit_TeamDetails(" & m_lngTeamId.ToString & ",'EDIT','" + m_strFromWhere + "')""><font color='blue'>Edit</font></a>")
                Response.Write("&nbsp;&nbsp;&nbsp;&nbsp;")
                Response.Write("<a Href=""javascript:Add_Space()""><img id='imgAddSpace'  SRC=""../../Images/plus.gif"" BORDER=""0"" ALT=""Add Space"" width=""10"" height=""10""></a>")
            End If

        End If
        Response.Write("</td></tr></Table>")
        Response.Write("<br>")

        PlotTeamSpaces()

    End Sub
    Private Sub PlotTeamSpaces()
        Dim strSQL As String
        Dim dsTeams As IDataReader
        Dim strTRClass As String
        Dim intCount As Integer
        Dim intRowStart As Integer = 1
        Dim intRowEnd As Integer = 1
        Dim intGridRecords As Integer


        Dim inCount As Integer
        Dim intPageNumber As Integer = 1
        Dim strPagingSQL As String
        Dim strPagingQueryString As String
        Dim strPagingHTML As String
        Dim strPagingDivName As String
        Dim intRecordCount As Integer = 0

        Dim sbHtml As New System.Text.StringBuilder
        Dim sbHtmlLeft As New System.Text.StringBuilder
        Dim sbHtmlRight As New System.Text.StringBuilder


        strSQL = " usp_Sel_tbl_KM_TeamSpaces " & m_lngTeamId.ToString()
        dsTeams = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        sbHtml.Append("<BR>")
        sbHtml.Append("<table CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Width='99.9%' >")
        sbHtml.Append("<TR>")

        sbHtmlLeft.Append("<TD align=center valign=top WIDTH=""49%>"">")
        sbHtmlRight.Append("<TD align=center valign=top WIDTH=""49%"">")


        While dsTeams.Read
            If m_intLeftRows <= m_intRightRows Then
                sbHtmlLeft.Append(PlotControlMenuTab("MY SPACES", "Page_OnClick", "View", dsTeams("SpaceName"), 3, dsTeams("SpaceID"), 1, 430))
                sbHtmlLeft.Append("<br>")
            Else
                sbHtmlRight.Append(PlotControlMenuTab("MY SPACES", "Page_OnClick", "View", dsTeams("SpaceName"), 3, dsTeams("SpaceID"), 2, 430))
                sbHtmlRight.Append("<br>")

            End If
        End While
        CommonFunction.Data.DisposeDataReader(dsTeams)

        sbHtmlLeft.Append("</TD>")
        sbHtmlRight.Append("</TD>")


        sbHtml.Append(sbHtmlLeft.ToString)
        sbHtml.Append("<td WIDTH=""2%""></td>")
        sbHtml.Append(sbHtmlRight.ToString)
        sbHtml.Append("</tr></table>")
        sbHtml.Append("</Div>")
        CommonFunction.General.WriteHTML(sbHtml.ToString)

        sbHtml = Nothing



        'strPagingSQL = " usp_Sel_tbl_KM_TeamSpaces_Count " & m_lngTeamId.ToString()

        'If Not Request.QueryString("IsPaging") Is Nothing Then
        '    If Not Request.QueryString("SpacePageNumber") Is Nothing Then
        '        intPageNumber = CInt(Request.QueryString("SpacePageNumber"))
        '    Else
        '        If Not Request.Form("txtSpacePageNumber") Is Nothing Then
        '            intPageNumber = CInt(Request.Form("txtSpacePageNumber"))
        '        End If
        '    End If
        'End If

        'strPagingHTML = PlotPaging("SpacePageNumber", strPagingSQL, intPageNumber, "DivSpacePaging", intRecordCount)

        'If intPageNumber > 0 Then
        '    intRowStart = (intPageNumber - 1) * 10 + 1
        'End If

        'dsTeams = CommonFunctions.Data.GetDataSet(strSQL, "Spaces")

        'intRowEnd = dsTeams.Tables(0).Rows.Count

        'If intPageNumber > 0 Then 'PageNumber 0 then display all records
        '    intGridRecords = IIf((intRowEnd - intRowStart) > 10, 10, (intRowEnd - intRowStart + 1))
        'Else
        '    intGridRecords = intRowEnd
        'End If
        'CommonFunctions.General.WriteHTML("<DIV ID=divList style='OVERFLOW:auto;width:100%'>")
        'CommonFunctions.General.WriteHTML("<Table ID=tblList width='99.9%'  CellSpacing=0 CellPadding=0  class='clsGridTable' >")
        'CommonFunctions.General.WriteHTML("<THEAD class=clsTRColumnHeader>")
        'CommonFunctions.General.WriteHTML("<TH  ALIGN='Left' class='divListTag' ></TH>")
        'CommonFunctions.General.WriteHTML("<TH  ALIGN='Left' colspan=2 class='divListTag' >Title</TH>")

        ''If blnShowDeleteColumn Then
        ''CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag'>Delete</TH>")
        ''End If
        'CommonFunctions.General.WriteHTML("</THEAD>")

        ''drPages = CommonFunctions.Data.GetDataReader(strSQL, True)
        ''intRowStart = 1
        ''intRowEnd = dsTeams.Tables(0).Rows.Count
        ''If m_intPageNumber > 0 Then
        ''    intGridRecords = IIf((intRowEnd - intRowStart) > 50, 50, (intRowEnd - intRowStart))
        ''Else
        ''    intGridRecords = intRowEnd
        ''End If
        ''intGridRecords = intRowEnd

        'For intCount = intRowStart - 1 To intRowStart + intGridRecords - 2
        '    strTRClass = "clsTREven"
        '    CommonFunctions.General.WriteHTML("<Tr class=" & strTRClass & ">")
        '    'If m_strTab.ToUpper = "MY" Then
        '    CommonFunctions.General.WriteHTML("<td colspan=3 ><li><a style='font-size:120%;' href='javascript:Space_OnClick(" & dsTeams.Tables(0).Rows(intCount).Item("SpaceID") & ",""View"")'>" & dsTeams.Tables(0).Rows(intCount).Item("SpaceName") & "</a>  (" & dsTeams.Tables(0).Rows(intCount).Item("ArticleCount") & " Articles)</li></td>")
        '    'Else
        '    '    CommonFunctions.General.WriteHTML("<td colspan=3 class=clstdOdd><li><a href='javascript:" & strEditFunctionName & "(" & drPages(strIDColumn) & ",""View"")'>" & drPages(strTitleColumn) & "</a></li></td></tr>")
        '    'End If

        '    'If blnPlotHeader And blnShowDeleteColumn Then
        '    '    CommonFunctions.General.WriteHTML("<td >&nbsp;</td>")
        '    'End If


        '    'If blnPlotHeader And blnShowDeleteColumn Then
        '    '    CommonFunctions.General.WriteHTML("<td  align='center'>")
        '    '    CommonFunctions.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", Value:=drPages(strIDColumn))
        '    '    CommonFunctions.General.WriteHTML("</td>")
        '    'End If
        '    CommonFunctions.General.WriteHTML("</tr>")
        'Next
        'If intRowEnd = 0 Then
        '    CommonFunctions.General.WriteHTML("<Tr class=clsTREven><td colspan=3 >There are no items to show in this view.</td></tr>")
        'End If
        'If intGridRecords > 0 Then
        '    CommonFunctions.General.WriteHTML("<br>")
        '    CommonFunctions.General.WriteHTML("<Table class='clstable' CellSpacing=0 CellPadding=0 width=100% ><tr class=clsTREven><td align=right>Total Records:" & intRecordCount.ToString & "</td></tr>")
        '    CommonFunctions.General.WriteHTML("</Table>")
        '    'CommonFunctions.General.WriteHTML("<br>")
        'End If
        'CommonFunctions.General.WriteHTML(strPagingHTML)
        'CommonFunctions.General.WriteHTML("</Table>")

        'CommonFunctions.General.WriteHTML("</DIV>")

    End Sub
    Private Sub PlotUpperHeaderSection()
        Dim strSQL As String
        Dim intCount As Integer
        Dim strQuery As String
        Dim drTopTenArticles As IDataReader
        Dim counter As Integer
        Dim iterator As Integer
        Dim strSQLquery As String
        Dim drStatistics As IDataReader
        counter = 0

        Dim strRating As String
        Dim flag As Integer
        flag = 0

        strSQL = " Select Count(1) from tbl_KM_CodeHeadings "
        intCount = CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL)

        strQuery = "usp_sel_tbl_KM_ArticleRating_Avg"

        drTopTenArticles = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

        ''Response.Write("<BR>")
        '''Response.Write("<TABLE id='PageCaption'  cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable><TR class=clsTRPageCaption><TD align=Left> Main </TD></TR></TABLE><BR>")

        ''Response.Write("<TABLE id='tbltop'  style='width:100%;' cellspacing=0 cellpadding=0 class=clsTable><TR class=""clsTREven"">")

        '''For showing top 10 articles 
        '''Response.Write("<TD align=left bgcolor=""#F0F0F0"" colspan=2>")
        '''Response.Write("<TABLE id='tbltopten'  cellspacing=0 cellpadding=0 class=clsTable><TR>")
        '''Response.Write("<TD align=left bgcolor=""#F0F0F0"" ><Img Border=0 src='../../Images/Toppers.jpg'></TD>")
        '''Response.Write("<TD align=left bgcolor=""#F0F0F0"" >")
        '''While drTopTenArticles.Read()
        '''    Response.Write(Left(drTopTenArticles("ProcedureTitle").ToString, 50) + "....")
        '''    Response.Write("<BR>")
        '''End While
        '''Response.Write("</TD>")
        '''Response.Write("</TR><TR><TD align=left bgcolor=""#F0F0F0"" > Articles </TD></TR><TABLE>")
        '''Response.Write("</TD>")
        '''End of top ten articles

        ''Response.Write("<TD align=Right colspan=1><Img Border=0 src='../../Images/KMLogo.gif'></TD>")
        ''Response.Write("<TD align=left style='font-size:162%;color:blue;' colspan=2 width=100%>Welcome to KM</TD></TR>")
        '''Response.Write("<TABLE id='tblLefttop'  cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable><TR class=clsTREven><TD align=Left>Welcome to KM</TD></TR>")
        ''If intCount > 1 Then
        ''    Response.Write("<TR class=clsTREven><TD colspan=1></TD><TD colspan=2 align=left>" & intCount.ToString & " Articles</TD></tr>")
        ''    'Response.Write("<TR class=""clsTREven""><TD bgcolor=""#F0F0F0"" colspan=1></TD><TD bgcolor=""#F0F0F0"" colspan=2 align=left><font fontFamily:'Verdana'>" & intCount.ToString & " Articles</font></TD></tr>")
        ''Else
        ''    Response.Write("<TR class=clsTREven><TD colspan=1></TD><TD colspan=2 align=left>" & intCount.ToString & " Article</TD></tr>")
        ''    'Response.Write("<TR class=""clsTREven""><TD bgcolor=""#F0F0F0"" colspan=1></TD><TD bgcolor=""#F0F0F0""colspan=2 align=left><font fontFamily:'Verdana'>" & intCount.ToString & " Article</font></TD></tr>")
        ''End If

        '''Response.Write("<TABLE id='tblRighttop'  cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable><TR class=clsTREven><TD align=Left>")

        '''Response.Write("<TABLE id='tblRighttop1'  cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable><TR class=clsTREven><TD align=Left>Spaces</TD></TR></TABLE></td></tr> <TR class=clsTREven><td>")
        ''PlotSearchControl()
        ''Response.Write("</TABLE><BR>")

        'Response.Write("<BR>")
        Response.Write("<Table id='tbltop' width=100% CellSpacing=0 CellPadding=0  class='clsGridTable'>")
        Response.Write("<tr width=100% class='clsTREven' valign=top>")
        Response.Write("<TD width=10%>")

        Response.Write("<Table id='tblpane1' width=100% CellSpacing=0 CellPadding=0  class='clsGridTable'>")
        Response.Write("<tr class='clsTREven'>")
        Response.Write("<TD><Img Border=0 src='../../Images/Toppers.jpg'></TD>")
        Response.Write("</tr>")
        Response.Write("<tr class='clsTREven'>")
        Response.Write("<TD>Articles</TD>")
        Response.Write("</tr>")
        Response.Write("</Table>")

        Response.Write("</TD>")

        Response.Write("<TD width=30%>")

        Response.Write("<Table id='tblpane2' width=100% CellSpacing=0 CellPadding=0  class='clsGridTable'>")
        While drTopTenArticles.Read
            counter = counter + 1
            Response.Write("<tr width=100% class='clsTREven'>")
            If drTopTenArticles("ProcedureTitle").ToString.Length > 50 Then
                Response.Write("<TD>")
                Response.Write("<a HREF=""Javascript:Article_OnClick(" + drTopTenArticles("ProcedureID").ToString + ")"">")
                Response.Write(HttpUtility.HtmlEncode(Left(drTopTenArticles("ProcedureTitle"), 50))) 'HtmlEncode Added By Vaijat K ON 20/11/2015
                Response.Write("</a>")
                Response.Write("...</TD>")
            Else
                Response.Write("<TD>")
                Response.Write("<a HREF=""Javascript:Article_OnClick(" + drTopTenArticles("ProcedureID").ToString + ")"">")
                Response.Write(HttpUtility.HtmlEncode(drTopTenArticles("ProcedureTitle").ToString)) 'HtmlEncode Added By Vaijat K ON 20/11/2015
                Response.Write("</a>")
                Response.Write("</TD>")
            End If
            StrArticleID = StrArticleID + drTopTenArticles("ProcedureID").ToString + ","

            Response.Write("</tr>")
            If counter = 5 Then
                Exit While
            End If


        End While
        CommonFunction.Data.DisposeDataReader(drTopTenArticles)

        'For iterator = counter To 9
        '    Response.Write("<tr width=100% class='clsTREven'>")
        '    Response.Write("<TD>&nbsp;</TD>")
        '    Response.Write("</tr>")
        '    counter = counter + 1
        'Next

        Response.Write("</Table>")

        Response.Write("</TD>")

        Response.Write("<TD width=35% align=center>")
        Response.Write("<Table id='tblpane3' width=100% CellSpacing=0 CellPadding=0  class='clsGridTable'>")
        Response.Write("<tr  width=100% class='clsTREven'>")
        Response.Write("<TD align=Right width=15%><Img Border=0 src='../../Images/KMLogo.gif'></TD>")
        Response.Write("<TD align=left width=85% style='font-size:162%;color:blue;'>Knowledge Management")
        Response.Write("</TD>")
        Response.Write("</tr>")
        Response.Write("<tr width=100% class='clsTREven'>")
        Response.Write("<TD colspan=2 align=center>")
        PlotSearchControl()
        'Response.Write("<input class=ButtonStyle name=Search id=Search type=button value='Search' onclick=""Search_Onclick()"">")
        Response.Write("</TD>")
        Response.Write("</tr>")
        Response.Write("</Table>")
        Response.Write("</TD>")

        Response.Write("<TD width=25% align=left>")

        strSQLquery = "usp_sel_tbl_KM_CodeHeadings_Statistics " + HttpContext.Current.Session("intUserID").ToString
        drStatistics = CommonFunction.Data.GetDataReader(strSQLquery, MyBase.UseSQL)

        Response.Write("<Table id='tblpane4' width=100% CellSpacing=0 CellPadding=0  class='clsGridTable'>")
        Response.Write("<tr width=100% class='clsTREven'>")
        Response.Write("<TD width=10%><IMG Border=0 src='../../Images/Statistics.jpg'></TD>")
        Response.Write("<TD align=left width=90%><FONT face=""Verdana"" color=""#990033"" size=""3""><I><B>Stastics</B></I></FONT></TD>")
        Response.Write("</tr>")
        Response.Write("<tr width=100% class='clsTREven'>")
        Response.Write("<TD colspan=2 align=left>Total Articles in Knowledge : <B>" + intCount.ToString + "</B></TD>")
        Response.Write("</tr>")
        Response.Write("<tr width=100% class='clsTREven'>")
        If drStatistics.Read Then
            If CommonFunction.Data.CheckIsDBNull(drStatistics("Counter").ToString, "0") <> "0" Then
                Response.Write("<TD colspan=2 align=left>Articles submitted this month : <B>" + drStatistics("Counter").ToString + "</B> </TD>")
            Else
                Response.Write("<TD colspan=2 align=left>Articles submitted this month : <B>0</B> </TD>")
            End If
        End If

        Response.Write("</tr>")
        Response.Write("<tr width=100% class='clsTREven'>")
        If drStatistics.NextResult Then
            If drStatistics.Read Then
                If CommonFunction.Data.CheckIsDBNull(drStatistics("Counter").ToString, "0") <> "0" Then
                    Response.Write("<TD colspan=2 align=left>You submitted <B>" + drStatistics("Counter").ToString + "</B> Articles this month</TD>")
                Else
                    Response.Write("<TD colspan=2 align=left>You submitted <B>0</B> Articles this month</TD>")
                End If
            End If
        End If
        Response.Write("</tr>")
        Response.Write("<tr width=100% class='clsTREven'>")
        Response.Write("<TD colspan=2 align=left><a HREF=""Javascript:FavSpace_OnClick()"">Your favourite Space</a>&nbsp;&nbsp;&nbsp;&nbsp;")
        Response.Write("<a HREF=""Javascript:FavTeam_OnClick()"">Your favourite Team</a></TD>")
        Response.Write("</tr>")
        Response.Write("</Table>")

        Response.Write("</TD>")
        Response.Write("</tr>")
        Response.Write("</Table>")

        CommonFunction.Data.DisposeDataReader(drStatistics)

    End Sub
    Private Sub PlotFeaturedArticle()
        Dim strSQL As String
        Dim drArticle As IDataReader
        Dim strQuery As String
        Dim strRating As String
        Dim counter As Integer
        Dim flag As Integer
        Dim strStyleSheet As String
        Dim iterator As Integer
        Dim strSQLQuery As String
        Dim dr As IDataReader
        Dim strRatingNew As String
        Dim tempRating As Double



        flag = 0

        strSQL = "usp_Sel_tbl_KM_CodeHeadings_FeaturedArticle " & m_lngUserId.ToString()
        drArticle = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        strStyleSheet = CommonFunction.Data.GetDataScalar("usp_get_StyleSheet " + HttpContext.Current.Session("intUserID").ToString, MyBase.UseSQL)

        If strStyleSheet = "StyleSheetChanakya.css" Then
            strColor = "#E7F1FE"
        ElseIf strStyleSheet = "StyleSheetChanakya_BrickRed.css" Then
            strColor = "#fcefec"
        ElseIf strStyleSheet = "StyleSheetChanakya_BurntSienna.css" Then
            strColor = "#f8f0e5"
        ElseIf strStyleSheet = "StyleSheetChanakya_Green.css" Then
            strColor = "#e1f6e3"
        ElseIf strStyleSheet = "StyleSheetChanakya_Purple.css" Then
            strColor = "#f1eefb"
        ElseIf strStyleSheet = "StyleSheetChanakya_GYellow.css" Then
            strColor = "#f7f5d7"
        ElseIf strStyleSheet = "StyleSheetChanakya_turquoise.css" Then
            strColor = "#daf0f3"
        ElseIf strStyleSheet = "StyleSheetChanakya_black.css" Then
            strColor = "#F2F3F3"
        End If

        PlotUpperHeaderSection()

        Response.Write("<DIV ID=divPage style='OVERFLOW:auto;width:100%'>")
        '''Response.Write("<DIV Id=divPage Style='HEIGHT:99.99%;OVERFLOW:auto; WIDTH:100%'>")
        ''Response.Write("<TABLE valign=bottom class='clsTable'  CellSpacing='0' CellPadding=0  width=100% height=100%>")
        '''Response.Write("<TR class='clsTREven' style='border:1px solid #ccc;'><TD colspan=3 style='width:100%;' valign='top' align=center>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Latest Featured Article by </td>")
        '''Response.Write("<TR style='border:1px solid #ccc;'>")
        '''Response.Write("<TD bgcolor=""#F0F0F0"" style='width:90%;' valign='top' align=center><font fontFamily:'Verdana'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Latest Featured Article</font></td>")

        If drArticle.Read Then
            ''Response.Write("<TR class='clsTREven'><TD style='width:100%;' align=center>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<B>Latest Featured Article by " + drArticle("EmployeeName").ToString + "</B></td>")
            ''Response.Write("</tr>")
            ''Response.Write("</Table>")
            'Response.Write("</DIV>")
            'Response.Write("<DIV ID=divArticle style='width:100%;height:100%'>")
            Response.Write("<TABLE class='clsTable' style=""border-top:1px solid #383838;"" CellSpacing='0' CellPadding=0  width=100% height=100%>")
            'Response.Write("<TR class='clsTREven'><TD id='TD_Left'style='width:99.99%;border:1px solid #ccc;' valign='top'>")
            'Response.Write("<TABLE id='tblCap00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageCaption><td align=left>Articles</td></tr></Table>")
            'If drArticle.Read Then
            Response.Write("<TR class='clsTREven'><TD width=40% align=left title=Attachment><A href=""JavaScript:Document_OnClick()""><img border=0 src='../../Images/Attachment.gif'></A></TD><TD width=40% align=left >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<B> Article Name : </B>" & HttpUtility.HtmlEncode(drArticle("ProcedureTitle")) & "</TD>") 'HtmlEncode Added By Vaijat K ON 20/11/2015

            strRating = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT AVG(Rating) AS Rating FROM tbl_KM_ArticleRating WHERE ProcedureID=" + drArticle("ProcedureID").ToString, MyBase.UseSQL), "")
            'End If

            If strRating.LastIndexOf(".") <> "-1" Then
                strRatingNew = strRating.Substring(0, strRating.LastIndexOf("."))
            Else
                strRatingNew = strRating
            End If

            If strRating <> "" Then
                Response.Write("<TD style='width:10%;' align=right><font fontFamily:'Verdana'> Rating </font></TD>")
                For counter = 0 To 5
                    If CType(strRatingNew, Integer) <> counter Then
                        Response.Write("<TD style='width:1%;' align=left>")
                        Response.Write("<img id='imgstaron'  SRC=""../../Images/star_on.gif"" BORDER=""0""  width=""16"" height=""16"">")
                        Response.Write("</TD>")
                    Else
                        tempRating = CType(strRating, Double) - CType(strRatingNew, Double)
                        If tempRating < 0.5 And tempRating <> 0.0 Then
                            Response.Write("<TD style='width:1%;' align=left>")
                            Response.Write("<img id='imgstaron'  SRC=""../../Images/starl5.GIF"" BORDER=""0""  width=""16"" height=""16"">")
                            Response.Write("</TD>")
                        ElseIf tempRating = 0.5 Then
                            Response.Write("<TD style='width:1%;' align=left>")
                            Response.Write("<img id='imgstaron'  SRC=""../../Images/stare5.GIF"" BORDER=""0""  width=""16"" height=""16"">")
                            Response.Write("</TD>")
                        ElseIf tempRating > 0.5 Then
                            Response.Write("<TD style='width:1%;' align=left>")
                            Response.Write("<img id='imgstaron'  SRC=""../../Images/starg5.GIF"" BORDER=""0""  width=""16"" height=""16"">")
                            Response.Write("</TD>")
                        ElseIf tempRating = 0.0 And CType(strRating, Double) <> 5.0 Then
                            Response.Write("<TD style='width:1%;' align=left>")
                            Response.Write("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""16"" height=""16"">")
                            Response.Write("</TD>")
                        End If
                        flag = strRatingNew + 2
                        Exit For
                    End If
                Next

                For counter = flag To 5
                    Response.Write("<TD style='width:1%;' align=left>")
                    Response.Write("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""16"" height=""16"">")
                    Response.Write("</TD>")
                Next
            Else
                Response.Write("<TD style='width:10%;' align=right><font fontFamily:'Verdana'> Rating </font></TD>")
                For counter = 0 To 4
                    Response.Write("<TD style='width:1%;' align=left>")
                    Response.Write("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""16"" height=""16"">")
                    Response.Write("</TD>")
                Next
            End If
            Response.Write("<TD style='width:10%;' nowrap align=left><a href='Javascript:RateArticle(" + drArticle("ProcedureID").ToString + ")'><font fontFamily:'Verdana' color='#660099'> Rate Article</font></a></TD>")

            Response.Write("</TR>")
            Response.Write("<TR class='clsTREven'><TD align=center colspan=9>&nbsp;</TD></TR>")
            Response.Write("<TR style=""FONT-SIZE: 8pt;font-family: Verdana, Arial;height: 500px;background-color:" + strColor + ";""><TD colspan=9 style='width:99.99%;' valign=top>" & drArticle("ProcedureCode") & "</TD></TR>") 'HtmlEncode Added By Vaijat K ON 20/11/2015
        Else
            Response.Write("</Table><hr size=-2 style=""color:White"">")
            Response.Write("<TABLE  class='clsTable' style=""border-top:1px solid #383838;"" CellSpacing='0' CellPadding=0  width=100% height=100%>")
            Response.Write("<TR style=""FONT-SIZE: 8pt;font-family: Verdana, Arial;height: 500px;background-color:" + strColor + ";""><TD align=center> No Article</TD></TR>")
        End If

        CommonFunction.Data.DisposeDataReader(drArticle)

        Response.Write("</TABLE>")
        'CommonFunctions.General.WriteHTML("</DIV>")
        Response.Write("</DIV>")
        'Response.Write("</td>")

        'Div for article click
        strArticle = StrArticleID.Split(",")
        For iterator = 0 To strArticle.Length - 2
            strSQLQuery = "SELECT ProcedureTitle,ProcedureCode FROM tbl_KM_CodeHeadings WHERE ProcedureID=" + strArticle(iterator).ToString
            dr = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

            If dr.Read Then
                Response.Write("<DIV ID=divArticle_" + iterator.ToString + " style='OVERFLOW:auto;width:100%'>")
                Response.Write("<TABLE valign=bottom class='clsTable'  CellSpacing='0' CellPadding=0  width=100% height=100%>")


                Response.Write("<TR class='clsTREven'><TD style='width:40%;' align=center>&nbsp;</TD><TD style='width:40%;' align=Left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>")

                strRating = CommonFunction.Data.GetDataScalar("SELECT AVG(Rating) AS Rating FROM tbl_KM_ArticleRating WHERE ProcedureID=" + strArticle(iterator).ToString, MyBase.UseSQL)
                'End If
                If strRating.LastIndexOf(".") <> "-1" Then
                    strRatingNew = strRating.Substring(0, strRating.LastIndexOf("."))
                Else
                    strRatingNew = strRating
                End If

                Response.Write("</tr>")
                Response.Write("</Table>")
                Response.Write("<TABLE class='clsTable' style=""border-top:1px solid #383838;"" CellSpacing='0' CellPadding=0  width=100% height=100%>")
                ''Commented and Added by Usha Pandit on 11.06.2019 for object reference not set exception
                'Response.Write("<TR class='clsTREven'><TD width=40% align=center >&nbsp;</TD><TD width=40% align=left >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<B> Article Name : </B>" & drArticle("ProcedureTitle") & "</TD>") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                Response.Write("<TR class='clsTREven'><TD width=40% align=center >&nbsp;</TD><TD width=40% align=left >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<B> Article Name : </B>" & dr("ProcedureTitle") & "</TD>") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                ''End of Added by Usha Pandit on 11.06.2019 for object reference not set exception

                If strRating <> "" Then
                    Response.Write("<TD style='width:10%;' align=right><font fontFamily:'Verdana'> Rating </font></TD>")
                    For counter = 0 To 5
                        If CType(strRatingNew, Integer) <> counter Then
                            Response.Write("<TD style='width:1%;' align=left>")
                            Response.Write("<img id='imgstaron'  SRC=""../../Images/star_on.gif"" BORDER=""0""  width=""16"" height=""16"">")
                            Response.Write("</TD>")
                        Else
                            tempRating = CType(strRating, Double) - CType(strRatingNew, Double)
                            If tempRating < 0.5 And tempRating <> 0.0 Then
                                Response.Write("<TD style='width:1%;' align=left>")
                                Response.Write("<img id='imgstaron'  SRC=""../../Images/starl5.GIF"" BORDER=""0""  width=""16"" height=""16"">")
                                Response.Write("</TD>")
                            ElseIf tempRating = 0.5 Then
                                Response.Write("<TD style='width:1%;' align=left>")
                                Response.Write("<img id='imgstaron'  SRC=""../../Images/stare5.GIF"" BORDER=""0""  width=""16"" height=""16"">")
                                Response.Write("</TD>")
                            ElseIf tempRating > 0.5 Then
                                Response.Write("<TD style='width:1%;' align=left>")
                                Response.Write("<img id='imgstaron'  SRC=""../../Images/starg5.GIF"" BORDER=""0""  width=""16"" height=""16"">")
                                Response.Write("</TD>")
                            ElseIf tempRating = 0.0 And CType(strRating, Double) <> 5.0 Then
                                Response.Write("<TD style='width:1%;' align=left>")
                                Response.Write("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""16"" height=""16"">")
                                Response.Write("</TD>")
                            End If
                            flag = strRatingNew + 2
                            Exit For
                        End If
                    Next

                    For counter = flag To 5
                        Response.Write("<TD style='width:1%;' align=left>")
                        Response.Write("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""16"" height=""16"">")
                        Response.Write("</TD>")
                    Next
                Else
                    Response.Write("<TD style='width:10%;' align=right><font fontFamily:'Verdana'> Rating </font></TD>")
                    For counter = 0 To 4
                        Response.Write("<TD style='width:1%;' align=left>")
                        Response.Write("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""16"" height=""16"">")
                        Response.Write("</TD>")
                    Next
                End If
                Response.Write("<TD style='width:10%;' nowrap align=left><a href='Javascript:RateArticle(" + strArticle(iterator).ToString + ")'><font fontFamily:'Verdana' color='#660099'> Rate Article</font></a></TD>")
                Response.Write("</TR>")
                Response.Write("<TR class='clsTREven'><TD align=center colspan=9>&nbsp;</TD></TR>")
                Response.Write("<TR style=""FONT-SIZE: 8pt;font-family: Verdana, Arial;height: 500px;background-color:" + strColor + ";""><TD colspan=9 style='width:99.99%;' valign=top>" & HttpUtility.HtmlEncode(dr("ProcedureCode")) & "</TD></TR>") 'HtmlEncode Added By Vaijat K ON 23/11/2015


                Response.Write("</TABLE>")
                Response.Write("</DIV>")
            End If

            CommonFunction.Data.DisposeDataReader(dr)

        Next
        'End of div


    End Sub
    Private Sub PlotList(ByVal strEntityType As EntityType, ByVal strMode As String, Optional ByVal blnShowDeleteColumn As Boolean = False, Optional ByVal blnPlotContents As Boolean = False, Optional ByVal blnPlotDiv As Boolean = True, Optional ByVal blnPlotHeader As Boolean = True, Optional ByVal blnPlotAuthor As Boolean = True)
        Dim strSQL As String
        Dim strSPname As String
        Dim dsEntity_My As IDataReader
        Dim dsEntity As DataSet
        Dim drEntity As IDataReader
        Dim blnOddEven As Boolean = False
        Dim strTRClass As String
        Dim strSearchText As String = ""
        Dim strIDColumn As String
        Dim strTitleColumn As String
        'Dim strListHeadCaption As String
        Dim strEditFunctionName As String

        Dim intRowStart As Integer = 1
        Dim intRowEnd As Integer = 1
        Dim intGridRecords As Integer
        Dim inCount As Integer
        Dim intPageNumber As Integer = 1
        Dim strPagingSQL As String
        Dim strPagingQueryString As String
        Dim strPagingHTML As String
        Dim strPagingDivName As String
        Dim intRecordCount As Integer = 0

        'Addition by SuchitraP on 28-Aug-2008
        Dim sbHtml As New System.Text.StringBuilder
        Dim sbHtmlLeft As New System.Text.StringBuilder
        Dim sbHtmlRight As New System.Text.StringBuilder
        'End by SuchitraP

        Select Case strEntityType
            Case EntityType.PAGE
                strIDColumn = "ProcedureID"
                strTitleColumn = "ProcedureTitle"
                strSPname = "usp_Sel_tbl_KM_CodeHeadings"
                'strSQL = "usp_Sel_tbl_KM_CodeHeadings "
                strEditFunctionName = "Page_OnClick"
                strPagingQueryString = "ArticlePageNumber"
                If Not Request.QueryString("IsPaging") Is Nothing Then
                    If Not Request.QueryString("ArticlePageNumber") Is Nothing Then
                        intPageNumber = CInt(Request.QueryString("ArticlePageNumber"))
                    Else
                        If Not Request.Form("txtArticlePageNumber") Is Nothing Then
                            intPageNumber = CInt(Request.Form("txtArticlePageNumber"))
                        End If
                    End If
                End If
                strPagingDivName = "divPagingArticle"
                'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                ''CommonFunctions.HTMLControls.DrawTextBox("txtArticlePageNumber", "txtArticlePageNumber", , , , intPageNumber, IsHidden:=True)
                CommonFunctions.HTMLControls.DrawTextBox("txtArticlePageNumber", "txtArticlePageNumber", , , , intPageNumber, IsHidden:=True, EnableHTMLEncode:=True)
                'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

            Case EntityType.SPACE
                strIDColumn = "SpaceID"
                strTitleColumn = "SpaceName"
                strSPname = "usp_Sel_tbl_KM_Space"
                'strSQL = "usp_Sel_tbl_KM_Space "
                strEditFunctionName = "Space_OnClick"
                strPagingQueryString = "SpacePageNumber"
                If Not Request.QueryString("IsPaging") Is Nothing Then
                    If Not Request.QueryString("SpacePageNumber") Is Nothing Then
                        intPageNumber = CInt(Request.QueryString("SpacePageNumber"))
                    Else
                        If Not Request.Form("txtSpacePageNumber") Is Nothing Then
                            intPageNumber = CInt(Request.Form("txtSpacePageNumber"))
                        End If
                    End If
                End If
                strPagingDivName = "divPagingSpace"
                'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                ''CommonFunctions.HTMLControls.DrawTextBox("txtSpacePageNumber", "txtSpacePageNumber", , , , intPageNumber, IsHidden:=True)
                CommonFunctions.HTMLControls.DrawTextBox("txtSpacePageNumber", "txtSpacePageNumber", , , , intPageNumber, IsHidden:=True, EnableHTMLEncode:=True)
                'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

            Case EntityType.BLOG
                strIDColumn = "SpaceID"
                strTitleColumn = "SpaceName"
                strSPname = "usp_Sel_tbl_KM_Space"
                'strSQL = "usp_Sel_tbl_KM_Space "
                strEditFunctionName = "Space_OnClick"
                strPagingQueryString = "SpacePageNumber"
                If Not Request.QueryString("IsPaging") Is Nothing Then
                    If Not Request.QueryString("SpacePageNumber") Is Nothing Then
                        intPageNumber = CInt(Request.QueryString("SpacePageNumber"))
                    Else
                        If Not Request.Form("txtSpacePageNumber") Is Nothing Then
                            intPageNumber = CInt(Request.Form("txtSpacePageNumber"))
                        End If
                    End If
                End If
                strPagingDivName = "divPagingSpace"
                'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                ''CommonFunctions.HTMLControls.DrawTextBox("txtSpacePageNumber", "txtSpacePageNumber", , , , intPageNumber, IsHidden:=True)
                CommonFunctions.HTMLControls.DrawTextBox("txtSpacePageNumber", "txtSpacePageNumber", , , , intPageNumber, IsHidden:=True, EnableHTMLEncode:=True)
                'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

            Case EntityType.TEAM
                strIDColumn = "TeamID"
                strTitleColumn = "TeamName"
                'strSQL = "usp_Sel_tbl_KM_Team "
                strSPname = "usp_Sel_tbl_KM_Team"
                strEditFunctionName = "Edit_TeamDetails"
                strPagingQueryString = "TeamPageNumber"
                If Not Request.QueryString("IsPaging") Is Nothing Then
                    If Not Request.QueryString("TeamPageNumber") Is Nothing Then
                        intPageNumber = CInt(Request.QueryString("TeamPageNumber"))
                    Else
                        If Not Request.Form("txtTeamPageNumber") Is Nothing Then
                            intPageNumber = CInt(Request.Form("txtTeamPageNumber"))
                        End If
                    End If
                End If
                strPagingDivName = "divPagingTeam"
                'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                '' CommonFunctions.HTMLControls.DrawTextBox("txtTeamPageNumber", "txtTeamPageNumber", , , , intPageNumber, IsHidden:=True)
                CommonFunctions.HTMLControls.DrawTextBox("txtTeamPageNumber", "txtTeamPageNumber", , , , intPageNumber, IsHidden:=True, EnableHTMLEncode:=True)
                'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        End Select



        If Not Request.Form("txtSearch") Is Nothing Then
            strSearchText = Request.Form("txtSearch").Trim()
            strSearchText = CommonFunctions.General.BuildQueryString(strSearchText)
        ElseIf Not Request.QueryString("txtSearch") Is Nothing Then
            strSearchText = Request.QueryString("txtSearch").Trim()
            strSearchText = HttpContext.Current.Server.UrlDecode(strSearchText)
            strSearchText = CommonFunctions.General.BuildQueryString(strSearchText)
        End If

        strSQL = strSPname & " "
        strSQL = strSQL & m_intPageNumber.ToString() & "," & m_lngUserId.ToString & ",NULL,"

        If m_strTab.ToUpper = "MY" Then
            strSQL = strSQL & "1,"
        Else
            strSQL = strSQL & "0,"
        End If
        strSQL = strSQL & "N'" & strSearchText & "'"

        If m_strTab.ToUpper = "EDIT" Then
            strSQL = strSQL & ",1"
        ElseIf m_strTab.ToUpper = "HOME" Then
            strSQL = strSQL & ",2"
        End If



        'strPagingSQL = strSQL.Replace(strSPname, strSPname & "_Count")
        'strPagingHTML = PlotPaging(strPagingQueryString, strPagingSQL, intPageNumber, strPagingDivName, intRecordCount)

        'If intPageNumber > 0 Then 'PageNumber 0 then display all records
        '    intRowStart = (intPageNumber - 1) * 10 + 1
        'End If

        'drEntity = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)


        If m_strTab.ToUpper = "MY" Then
            dsEntity_My = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

            sbHtml.Append("<BR>")
            sbHtml.Append("<table CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Width='99.9%' >")
            sbHtml.Append("<TR>")

            sbHtmlLeft.Append("<TD align=center valign=top WIDTH=""49%>"">")
            sbHtmlRight.Append("<TD align=center valign=top WIDTH=""49%"">")

            If m_intPageNumber > 0 Then
                For ReadCount = 1 To (8 * (m_intPageNumber - 1))
                    dsEntity_My.Read()
                Next
            End If

            While dsEntity_My.Read
                If m_intLeftRows <= m_intRightRows Then
                    Select Case strEntityType
                        Case EntityType.PAGE
                            sbHtmlLeft.Append(PlotControlMenuTab("MY PAGES", strEditFunctionName, strMode, dsEntity_My("ProcedureTitle"), 3, dsEntity_My("ProcedureID"), 1, 430))
                            sbHtmlLeft.Append("<br>")
                        Case EntityType.SPACE
                            sbHtmlLeft.Append(PlotControlMenuTab("MY SPACES", strEditFunctionName, strMode, dsEntity_My("SpaceName"), 3, dsEntity_My("SpaceID"), 1, 430))
                            sbHtmlLeft.Append("<br>")
                        Case EntityType.TEAM
                            sbHtmlLeft.Append(PlotControlMenuTab("MY TEAMS", strEditFunctionName, strMode, dsEntity_My("TeamName"), 3, dsEntity_My("TeamID"), 1, 430))
                            sbHtmlLeft.Append("<br>")
                    End Select
                Else
                    Select Case strEntityType
                        Case EntityType.PAGE
                            sbHtmlRight.Append(PlotControlMenuTab("MY PAGES", strEditFunctionName, strMode, dsEntity_My("ProcedureTitle"), 3, dsEntity_My("ProcedureID"), 2, 430))
                            sbHtmlRight.Append("<br>")
                        Case EntityType.SPACE
                            sbHtmlRight.Append(PlotControlMenuTab("MY SPACES", strEditFunctionName, strMode, dsEntity_My("SpaceName"), 3, dsEntity_My("SpaceID"), 2, 430))
                            sbHtmlRight.Append("<br>")
                        Case EntityType.TEAM
                            sbHtmlRight.Append(PlotControlMenuTab("MY TEAMS", strEditFunctionName, strMode, dsEntity_My("TeamName"), 3, dsEntity_My("TeamID"), 2, 430))
                            sbHtmlRight.Append("<br>")
                    End Select
                End If
            End While

            CommonFunction.Data.DisposeDataReader(dsEntity_My)

            sbHtmlLeft.Append("</TD>")
            sbHtmlRight.Append("</TD>")


            sbHtml.Append(sbHtmlLeft.ToString)
            sbHtml.Append("<td WIDTH=""2%""></td>")
            sbHtml.Append(sbHtmlRight.ToString)
            sbHtml.Append("</tr></table>")
            ''sbHtml.Append("</Div>")
            CommonFunction.General.WriteHTML(sbHtml.ToString)

            sbHtml = Nothing
            'ElseIf m_strTab.ToUpper = "HOME" Then

            '    If blnPlotDiv Then
            '        CommonFunctions.General.WriteHTML("<DIV ID=divList style='OVERFLOW:auto;width:100%'>")
            '    End If


            '    CommonFunctions.General.WriteHTML("<Table ID=tblList width='99.9%'  CellSpacing=0 CellPadding=0  class='clsGridTable' >")
            '    If blnPlotHeader Then
            '        CommonFunctions.General.WriteHTML("<THEAD class=clsTRColumnHeader>")
            '        CommonFunctions.General.WriteHTML("<TH  ALIGN='Left' class='divListTag' >Title</TH>")
            '        If blnPlotContents Then
            '            CommonFunctions.General.WriteHTML("<TH  ALIGN='center' colspan=2 class='divListTag' ></TH>")
            '        Else
            '            CommonFunctions.General.WriteHTML("<TH  ALIGN='center' colspan=3 class='divListTag' ></TH>")
            '        End If

            '        If blnShowDeleteColumn Then
            '            CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag'>Delete</TH>")
            '        End If
            '        CommonFunctions.General.WriteHTML("</THEAD>")
            '    End If

            '    dsEntity = CommonFunctions.Data.GetDataSet(strSQL, "Entity", , , MyBase.UseSQL)

            '    intRowEnd = dsEntity.Tables(0).Rows.Count

            '    If intPageNumber > 0 Then
            '        intGridRecords = IIf((intRowEnd - intRowStart) > 10, 10, (intRowEnd - intRowStart + 1))
            '    Else
            '        intGridRecords = intRowEnd
            '    End If

            '    For inCount = intRowStart To intRowStart + intGridRecords - 1
            '        'blnOddEven = Not blnOddEven
            '        'If blnOddEven = True Then
            '        strTRClass = "clsTREven"
            '        'Else
            '        '    strTRClass = "clsTROdd"
            '        'End If
            '        CommonFunctions.General.WriteHTML("<Tr class=" & strTRClass & ">")
            '        'If m_strTab.ToUpper = "MY" Then
            '        CommonFunctions.General.WriteHTML("<td colspan=3 ><li><a style='font-size:120%;' href='javascript:" & strEditFunctionName & "(" & dsEntity.Tables(0).Rows(inCount - 1).Item(strIDColumn) & ",""" & strMode & """)'>" & dsEntity.Tables(0).Rows(inCount - 1).Item(strTitleColumn) & "</a></li> ")

            '        If blnPlotAuthor Then
            '            CommonFunctions.General.WriteHTML(" CreateBy:" & dsEntity.Tables(0).Rows(inCount - 1).Item("Author") & " ")
            '        End If
            '        CommonFunctions.General.WriteHTML("</td>")
            '        'Else
            '        '    CommonFunctions.General.WriteHTML("<td colspan=3 class=clstdOdd><li><a href='javascript:" & strEditFunctionName & "(" & drPages(strIDColumn) & ",""View"")'>" & drPages(strTitleColumn) & "</a></li></td></tr>")
            '        'End If

            '        If blnPlotHeader And blnShowDeleteColumn Then
            '            CommonFunctions.General.WriteHTML("<td >&nbsp;</td>")
            '        End If

            '        If blnPlotContents Then
            '            CommonFunctions.General.WriteHTML("</tr><tr><td >&nbsp;&nbsp;&nbsp;</td>")
            '            CommonFunctions.General.WriteHTML("<td >" & dsEntity.Tables(0).Rows(inCount - 1).Item("Keywords") & "</td><td >&nbsp;</td>")
            '        End If
            '        If blnPlotHeader And blnShowDeleteColumn Then
            '            CommonFunctions.General.WriteHTML("<td  align='center'>")
            '            CommonFunctions.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", value:=dsEntity.Tables(0).Rows(inCount - 1).Item(strIDColumn))
            '            CommonFunctions.General.WriteHTML("</td>")
            '        End If
            '        CommonFunctions.General.WriteHTML("</tr>")

            '    Next
            '    If intGridRecords = 0 Then
            '        CommonFunctions.General.WriteHTML("<Tr class=clsTREven><td colspan=" & (IIf(blnShowDeleteColumn, 5, 4)) & " align='center' >There are no items to show in this view.</td></tr>")
            '    End If
            '    CommonFunctions.General.WriteHTML("</Table>")
            '    If intRecordCount > 0 Then
            '        CommonFunctions.General.WriteHTML("<br>")
            '        CommonFunctions.General.WriteHTML("<Table class='clstable' CellSpacing=0 CellPadding=0 width=100% ><tr class=clsTREven><td align=right>Total Records:" & intRecordCount.ToString & "</td></tr>")
            '        CommonFunctions.General.WriteHTML("</Table>")
            '        'CommonFunctions.General.WriteHTML("<br>")
            '    End If

            '    'CommonFunctions.General.WriteHTML("<Div id='divPaging'>")
            '    CommonFunctions.General.WriteHTML(strPagingHTML)
            '    'CommonFunctions.General.WriteHTML("</Div>")

            '    If blnPlotDiv Then
            '        CommonFunctions.General.WriteHTML("</DIV>")
            '    End If
        End If

    End Sub
    Private Function PlotControlMenuTab(ByVal strEntity As String, ByVal strEditFunctionName As String, ByVal strMode As String, ByVal strEntityName As String, ByVal MaxControlLimit As Integer, ByVal intPKID As Integer, Optional ByVal intPanel As Integer = 1, Optional ByVal intTableWidth As Integer = 400) As String

        Dim sbHtml As New System.Text.StringBuilder
        Dim strSQL As String
        Dim drMenu As IDataReader
        Dim drDiscussionCount As IDataReader
        Dim intRowCount As Integer = 0
        Dim strRating As String
        Dim counter As Integer
        Dim flag As Integer
        Dim Cancel As Boolean = False
        Dim intCount As Integer = 0
        Dim EntityName As String
        Dim EntityPKID As Integer
        Dim NoOfArticles As Integer
        Dim strQuery As String = ""
        Dim strEditAccess As String = ""
        Dim strProgrammerID As String = ""
        Dim drEditAccess As IDataReader
        Dim submitter As String
        Dim strRatingNew As String
        Dim tempRating As Double
        Dim dbTeamIDForSpace As String = ""


        Dim strAttachments As String
        Dim PKToken_ProcedureID As String

        flag = 0

        Select Case strEntity
            Case "MY PAGES"
                strSQL = " SELECT ProcedureID,ProcedureTitle,Synopsis FROM tbl_KM_CodeHeadings WHERE SpaceID IS NULL AND ProcedureID= " & intPKID.ToString
            Case "MY SPACES"
                strSQL = " usp_Sel_tbl_KM_SpacePages " & intPKID.ToString
            Case "MY TEAMS"
                strSQL = " usp_Sel_tbl_KM_TeamSpaces " & intPKID.ToString
        End Select

        drMenu = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        sbHtml.Append("<table id='HeaderTable' WIDTH=99.9% CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Class=""clsRoundedTableHeader"" >")
        sbHtml.Append("<tr>")
        sbHtml.Append("<td WIDTH=""14"" class=""clsTDTopLeftCorner"">  </td>")
        sbHtml.Append("<td  rowspan=""2"" valign=""middle""> ")


        Select Case strEntity
            Case "MY PAGES"
                'Commented and Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
                'PKToken_ProcedureID = CommonFunctions.Security.Token.GetToken(intPKID.ToString)
                PKToken_ProcedureID = CommonFunctions.Security.Token.GetToken(intPKID.ToString + HttpContext.Current.Session("intUserID").ToString + "0" + "0")
                'End Of Commented and Added By Chakshuta H on 11th-Aug-2016

                strAttachments = CommonFunction.Data.GetDataScalar("IF EXISTS(SELECT ProcedureID FROM tbl_KM_Attachments WHERE ProcedureID = " + intPKID.ToString + ") SELECT 1", True)
                sbHtml.Append("<table WIDTH=100% Class=""clsRoundedTableHeader"" >") '<tr><td align=""Left"" class='clsTDChildNavMenu'><b>" & strEntityName & "</b>&nbsp;&nbsp;&nbsp;&nbsp;")
                'Added by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0
                strSQL = " usp_Sel_tbl_KM_CodeHeadings_MyArticles  " & intPKID.ToString
                drDiscussionCount = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                While drDiscussionCount.Read
                    'End of Addition by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0
                    If strAttachments = "1" Then
                        'Commented and Modified by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0
                        'sbHtml.Append("<TR><TD class='clsLinkChildNavMenu' align=left ><A title='Attachment' href=""JavaScript:Document_OnClick('" + intPKID.ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Attachment1.gif'></A>&nbsp;<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + intPKID.ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'></A>&nbsp;<b>" & strEntityName & "</b>&nbsp;&nbsp;&nbsp;&nbsp;")
                        If Trim(drDiscussionCount("NoOfDiscussions").ToString & "") <> "" And Trim(drDiscussionCount("NoOfDiscussions").ToString & "") <> "0" Then
                            sbHtml.Append("<TR><TD class='clsLinkChildNavMenu' align=left ><A title='Attachment' href=""JavaScript:Document_OnClick('" + intPKID.ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Attachment1.gif'></A>&nbsp;<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + intPKID.ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'>(" + drDiscussionCount("NoOfDiscussions").ToString + ")</A>&nbsp;<b>" & HttpUtility.HtmlEncode(strEntityName) & "</b>&nbsp;&nbsp;&nbsp;&nbsp;") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                        Else
                            sbHtml.Append("<TR><TD class='clsLinkChildNavMenu' align=left ><A title='Attachment' href=""JavaScript:Document_OnClick('" + intPKID.ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Attachment1.gif'></A>&nbsp;<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + intPKID.ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'></A>&nbsp;<b>" & HttpUtility.HtmlEncode(strEntityName) & "</b>&nbsp;&nbsp;&nbsp;&nbsp;") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                        End If
                        'End of Comment and Modification by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0
                    Else
                        'Commented and Modified by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0
                        'sbHtml.Append("<TR><TD class='clsLinkChildNavMenu' align=left >&nbsp;<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + intPKID.ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'></A>&nbsp;<b>" & strEntityName & "</b>&nbsp;&nbsp;&nbsp;&nbsp;")
                        If Trim(drDiscussionCount("NoOfDiscussions").ToString & "") <> "" And Trim(drDiscussionCount("NoOfDiscussions").ToString & "") <> "0" Then
                            sbHtml.Append("<TR><TD class='clsLinkChildNavMenu' align=left >&nbsp;<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + intPKID.ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'>(" + drDiscussionCount("NoOfDiscussions").ToString + ") </A>&nbsp;<b>" & HttpUtility.HtmlEncode(strEntityName) & "</b>&nbsp;&nbsp;&nbsp;&nbsp;") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                        Else
                            sbHtml.Append("<TR><TD class='clsLinkChildNavMenu' align=left >&nbsp;<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + intPKID.ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'></A>&nbsp;<b>" & HttpUtility.HtmlEncode(strEntityName) & "</b>&nbsp;&nbsp;&nbsp;&nbsp;") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                        End If
                        'End of Comment and Modification by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0
                    End If
                End While
                CommonFunction.Data.DisposeDataReader(drDiscussionCount)

            Case "MY SPACES"
                sbHtml.Append("<table WIDTH=100% Class=""clsRoundedTableHeader"" ><tr><td align=""Left"" class='clsTDChildNavMenu'><b>" & HttpUtility.HtmlEncode(strEntityName) & "</b>&nbsp;&nbsp;&nbsp;&nbsp;<a HREF=""Javascript:Space_OnClick(" + intPKID.ToString + ",'" + strMode + "','" + m_strFromWhere + "')""><font color='blue' style='font-size:10px'>[edit]</font></a>") 'HtmlEncode Added By Vaijat K ON 20/11/2015
            Case "MY TEAMS"
                sbHtml.Append("<table WIDTH=100% Class=""clsRoundedTableHeader"" ><tr><td align=""Left"" class='clsTDChildNavMenu'><b>" & HttpUtility.HtmlEncode(strEntityName) & "</b>&nbsp;&nbsp;&nbsp;&nbsp;<a HREF=""Javascript:Edit_TeamDetails(" + intPKID.ToString + ",'" + strMode + "','" + m_strFromWhere + "')""><font color='blue' style='font-size:10px'>[edit]</font>") 'HtmlEncode Added By Vaijat K ON 20/11/2015
        End Select


        If strEntity = "MY PAGES" Then
            strRating = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT AVG(Rating) AS Rating FROM tbl_KM_ArticleRating WHERE ProcedureID=" + intPKID.ToString, True), "")

            If strRating.LastIndexOf(".") <> "-1" Then
                strRatingNew = strRating.Substring(0, strRating.LastIndexOf("."))
            Else
                strRatingNew = strRating
            End If

            If strRating <> "" Then
                For counter = 0 To 5
                    If CType(strRatingNew, Integer) <> counter Then
                        'sbHtml.Append("<TD style='width:1%;' align=left>")
                        sbHtml.Append("<a class='clsLinkChildNavMenu' href='Javascript:RateArticle(" + intPKID.ToString + ")'><img id='imgstaron'  SRC=""../../Images/star_on.gif"" BORDER=""0""  width=""10"" height=""10""></a>&nbsp;&nbsp;")
                        'sbHtml.Append("</TD>")
                    Else
                        tempRating = CType(strRating, Double) - CType(strRatingNew, Double)
                        If tempRating < 0.5 And tempRating <> 0.0 Then
                            sbHtml.Append("<a class='clsLinkChildNavMenu' href='Javascript:RateArticle(" + intPKID.ToString + ")'><img id='imgstaron'  SRC=""../../Images/starl5.GIF"" BORDER=""0""  width=""10"" height=""10""></a>&nbsp;&nbsp;")
                        ElseIf tempRating = 0.5 Then
                            sbHtml.Append("<a class='clsLinkChildNavMenu' href='Javascript:RateArticle(" + intPKID.ToString + ")'><img id='imgstaron'  SRC=""../../Images/stare5.GIF"" BORDER=""0""  width=""10"" height=""10""></a>&nbsp;&nbsp;")
                        ElseIf tempRating > 0.5 Then
                            sbHtml.Append("<a class='clsLinkChildNavMenu' href='Javascript:RateArticle(" + intPKID.ToString + ")'><img id='imgstaron'  SRC=""../../Images/starg5.GIF"" BORDER=""0""  width=""10"" height=""10""></a>&nbsp;&nbsp;")
                        ElseIf tempRating = 0.0 And CType(strRating, Double) <> 5.0 Then
                            sbHtml.Append("<a class='clsLinkChildNavMenu' href='Javascript:RateArticle(" + intPKID.ToString + ")'><img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""10"" height=""10""></a>&nbsp;&nbsp;")
                        End If

                        flag = strRatingNew + 2
                        Exit For
                    End If
                Next

                For counter = flag To 5
                    'sbHtml.Append("<TD style='width:1%;' align=left>")
                    sbHtml.Append("<a class='clsLinkChildNavMenu' href='Javascript:RateArticle(" + intPKID.ToString + ")'><img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""10"" height=""10""></a>&nbsp;&nbsp;")
                    'sbHtml.Append("</TD>")
                Next
            Else
                For counter = 0 To 4
                    sbHtml.Append("<a class='clsLinkChildNavMenu' href='Javascript:RateArticle(" + intPKID.ToString + ")'><img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""10"" height=""10""></a>&nbsp;&nbsp;")
                Next
            End If
        End If
        sbHtml.Append("</td>")
        sbHtml.Append("<td align=right>")
        'Subtab=MY PAGES
        ''If m_strTab.ToUpper <> "TEAM" Then
        ''If m_strSubTab.ToUpper = "MY PAGES" Then
        sbHtml.Append("<a Class=""clsLinkControlMenu"" HREF=""Javascript:Delete_OnClick(" & intPKID.ToString & ")""><img id='imgDel" & intPKID.ToString & "'  SRC=""../../Images/delete.gif"" BORDER=""0"" ALT=""Delete"" width=""14"" height=""14""></a>&nbsp;&nbsp;&nbsp;")
        ''End If
        ''End If
        If strEntity = "MY TEAMS" Then
            'sbHtml.Append("<a Class=""clsLinkControlMenu"" Title=""Page View"" HREF=""Javascript:PageView_OnClick(" & intPKID.ToString & ")""><font size=1 color='blue'>Page View</font></a>&nbsp;&nbsp;<a Class=""clsLinkControlMenu"" Title=""Space View"" HREF=""Javascript:SpaceView_OnClick(" & intPKID.ToString & ")""><font size=1 color='blue'>Space View</font></a>" + vbCrLf)
            sbHtml.Append("<a Class=""clsLinkControlMenu"" Title=""Article View"" HREF=""Javascript:PageView_OnClick(" & intPKID.ToString & ")""><font size=1 color='blue'>Article View</font></a>" + vbCrLf)
        End If
        sbHtml.Append("<a Class=""clsLinkControlMenu"" HREF=""Javascript:ShowHideGroup_Onclick(" & intPKID.ToString & ")""><img id='imgGroup" & intPKID.ToString & "'  SRC=""../../Images/MoveUp.GIF"" BORDER=""0"" ALT=""..."" width=""14"" height=""14""></a></td></tr></table>")
        sbHtml.Append("</td>")

        sbHtml.Append("<td WIDTH=""14"" class=""clsTDTopRightCorner"">  </td>")
        sbHtml.Append("</tr>")
        sbHtml.Append("<tr>")
        sbHtml.Append("<td>&nbsp;&nbsp;</td>")
        sbHtml.Append("<td>&nbsp;&nbsp;</td>")
        sbHtml.Append("</tr>")
        sbHtml.Append("</table>")
        sbHtml.Append("<table  id=tblGroup" & intPKID.ToString & " WIDTH=100% CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Class=""clsRoundedTableMenu"">")

        While (drMenu.Read())
            Cancel = False
            intRowCount = intRowCount + 1
            Select Case strEntity
                Case "MY PAGES"
                    EntityName = drMenu("Synopsis").ToString
                    EntityPKID = drMenu("ProcedureID").ToString
                    intCount = 1
                Case "MY SPACES"
                    EntityName = drMenu("ProcedureTitle").ToString
                    EntityPKID = drMenu("ProcedureID").ToString
                    intCount = intCount + 1
                Case "MY TEAMS"
                    EntityName = drMenu("SpaceName").ToString
                    EntityPKID = drMenu("SpaceID").ToString
                    NoOfArticles = CommonFunction.Data.CheckIsDBNull(drMenu("ArticleCount"), "0")
                    intCount = intCount + 1
            End Select
            sbHtml.Append("<tr class=""clsTRControlMenu"">")
            'sbHtml.Append("<td valign=top width=20>")

            'Discussions.gif
            'If m_strSubTab.ToUpper = "MY SPACES" Or m_strSubTab.ToUpper = "MY PAGES" Then
            '    sbHtml.Append("<img src='..\..\Images\Discussions.gif' vspace=1 border=0></a></td>")
            'Else
            '    sbHtml.Append("<img src='..\..\Images\spaces1.gif' vspace=1 border=0></a></td>")
            'End If

            Select Case strEntity
                Case "MY PAGES"
                    sbHtml.Append("<td valign=top width=100% style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>")
                    If EntityName.Length > 150 Then
                        sbHtml.Append(HttpUtility.HtmlEncode(Left(EntityName, 200)) + "....") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                    Else
                        sbHtml.Append(HttpUtility.HtmlEncode(EntityName)) 'HtmlEncode Added By Vaijat K ON 20/11/2015
                    End If
                Case "MY SPACES"
                    sbHtml.Append("<td valign=top width=80% style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>")
                    submitter = CommonFunction.Data.GetDataScalar("Select UserName FROM tbl_KM_CodeHeadings INNER JOIN  tbl_PM_Employee ON ProgrammerID=EmployeeID WHERE ProcedureID=" + EntityPKID.ToString, True)
                    sbHtml.Append("" + HttpUtility.HtmlEncode(EntityName) + "</td><td valign=top align=left width=20% style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>By " + submitter) 'HtmlEncode Added By Vaijat K ON 20/11/2015
                    ''sbHtml.Append("<a HREF=""Javascript:Page_OnClick(" + EntityPKID.ToString + ",'" + strMode + "')"">")
                Case "MY TEAMS"
                    sbHtml.Append("<td valign=top width=70% style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>")
                    sbHtml.Append("" + HttpUtility.HtmlEncode(EntityName) + "</td><td valign=top align=left nowrap width=30% style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                    ''sbHtml.Append("<a HREF=""Javascript:Space_OnClick(" + EntityPKID.ToString + ",'" + strMode + "')"">")
            End Select

            ''If strEntity = "MY PAGES" Then
            ''    'If EntityName.Length > 50 Then
            ''    '    sbHtml.Append(Left(EntityName, 300) + "...." + "<a HREF=""Javascript:Page_OnClick(" + EntityPKID.ToString + ",'Edit')"" style=""color:ThreeDShadow"">(More)")
            ''    'Else
            ''    sbHtml.Append(EntityName + "...." + "<a HREF=""Javascript:Page_OnClick(" + EntityPKID.ToString + ",'Edit')"" style=""color:ThreeDShadow"">(More)")
            ''    'End If
            ''Else
            ''    sbHtml.Append(EntityName)
            ''End If

            ''sbHtml.Append("</a>&nbsp;&nbsp;&nbsp;&nbsp;")

            If strEntity = "MY TEAMS" Then
                sbHtml.Append("[No.Of Articles " + NoOfArticles.ToString + "]")
            End If
            'sbHtml.Append("</font>")
            sbHtml.Append("</td>")
            If strEntity = "MY PAGES" Then
                sbHtml.Append("<td valign='top' align='right'><a HREF=""Javascript:Page_OnClick(" + EntityPKID.ToString + ",'Edit','" + m_strFromWhere + "')"" ><img src='../../Images/Home/maximize.gif' border='0' alt='Max' /></a>")
            ElseIf strEntity = "MY SPACES" Then
                strEditAccess = ""
                strProgrammerID = ""
                strQuery = "usp_Get_EditAccess " + EntityPKID.ToString + "," + HttpContext.Current.Session("intUserID").ToString
                drEditAccess = CommonFunction.Data.GetDataReader(strQuery, True)
                If drEditAccess.Read() Then
                    strEditAccess = drEditAccess("IsPresent").ToString
                End If

                If drEditAccess.NextResult() Then
                    If drEditAccess.Read() Then
                        strProgrammerID = drEditAccess("ProgrammerID").ToString
                    End If
                End If

                If strEditAccess = "1" Or strProgrammerID = HttpContext.Current.Session("intUserID").ToString Then
                    'sbHtml.Append("<td valign='top' align='right'><a HREF=""Javascript:SpacePage_OnClick(" + EntityPKID.ToString + ",'Edit','" + m_strFromWhere + "')"" ><img src='../../Images/Home/maximize.gif' border='0' alt='Max' /></a>")
                    'sbHtml.Append("<td valign='top' align='right'><a HREF=""Javascript:Page_OnClick(" + EntityPKID.ToString + ",'Edit','" + m_strFromWhere + "')"" ><img src='../../Images/Home/maximize.gif' border='0' alt='Max' /></a>")
                    sbHtml.Append("<td valign='top' align='right'><a  style='text-decoration:none' HREF=""Javascript:Page_OnClick(" + EntityPKID.ToString + ",'Edit','" + m_strFromWhere + "')"" ><img src='../../Images/Home/maximize.gif' border='0' alt='Max' /></a>")
                Else
                    'sbHtml.Append("<td valign='top' align='right'><a   style='text-decoration:none' HREF=""Javascript:SpacePage_OnClick(" + EntityPKID.ToString + ",'View','" + m_strFromWhere + "')"" ><img src='../../Images/Home/maximize.gif'  border='0' alt='Max' /></a>")
                    sbHtml.Append("<td valign='top' align='right'><a   style='text-decoration:none' HREF=""Javascript:Page_OnClick(" + EntityPKID.ToString + ",'View','" + m_strFromWhere + "')"" ><img src='../../Images/Home/maximize.gif'  border='0'  alt='Max' /></a>")
                End If

                CommonFunction.Data.DisposeDataReader(drEditAccess)

            ElseIf strEntity = "MY TEAMS" Then
                strEditAccess = ""
                strProgrammerID = ""
                strQuery = "usp_Get_EditAccess_Space " + EntityPKID.ToString + "," + HttpContext.Current.Session("intUserID").ToString
                drEditAccess = CommonFunction.Data.GetDataReader(strQuery, True)
                If drEditAccess.Read() Then
                    strEditAccess = drEditAccess("IsPresent").ToString
                End If

                If drEditAccess.NextResult() Then
                    If drEditAccess.Read() Then
                        strProgrammerID = drEditAccess("AuthorID").ToString
                    End If
                End If
                'm_strTeamID = intPKID.ToString

                dbTeamIDForSpace = CommonFunction.Data.GetDataScalar("SELECT ISNULL(TeamID,0) FROM tbl_Km_Space WHERE SpaceID =" + EntityPKID.ToString, MyBase.UseSQL)

                If strEditAccess = "1" Or strProgrammerID = HttpContext.Current.Session("intUserID").ToString Then
                    sbHtml.Append("<td valign='top' align='right'><a HREF=""Javascript:TeamSpace_OnClick(" + EntityPKID.ToString + ",'Edit','" + m_strFromWhere + "'," + dbTeamIDForSpace + ")"" ><img src='../../Images/Home/maximize.gif' border='0' alt='Max' /></a><br>")
                Else
                    sbHtml.Append("<td valign='top' align='right'><a   style='text-decoration:none' HREF=""Javascript:TeamSpace_OnClick(" + EntityPKID.ToString + ",'View','" + m_strFromWhere + "'," + dbTeamIDForSpace + ")"" ><img src='../../Images/Home/maximize.gif'  border='0' alt='Max' /></a><br>")
                End If
                CommonFunction.Data.DisposeDataReader(drEditAccess)
            End If
            sbHtml.Append("</td>")
            sbHtml.Append("</tr>")

            If intCount > MaxControlLimit Then
                Exit While
            End If
        End While

        CommonFunction.Data.DisposeDataReader(drMenu)

        If intCount > MaxControlLimit Then
            sbHtml.Append("<tr class=""clsTRControlMenu"">")
            sbHtml.Append("<td colspan=4>&nbsp;</td></tr>")
            sbHtml.Append("<tr class=""clsTRControlMenu"">")
            sbHtml.Append("<td valign=bottom align=right colspan=3 style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>")
            'sbHtml.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", value:=intPKID, returnHTML:=True))
            'sbHtml.Append("&nbsp;<a HREF=""Javascript:Edit_TeamDetails(" + intPKID.ToString + ",'" + strMode + "')""><font color='blue'>Edit</font></a>&nbsp;&nbsp;")
            'If strEntity = "MY SPACES" Then
            '    sbHtml.Append("&nbsp;<a HREF=""Javascript:Space_OnClick(" + intPKID.ToString + ",'" + strMode + "')""><font color='blue'>Edit</font></a>")
            'ElseIf strEntity = "MY TEAMS" Then
            '    sbHtml.Append("&nbsp;<a HREF=""Javascript:Edit_TeamDetails(" + intPKID.ToString + ",'" + strMode + "')""><font color='blue'>Edit</font></a>")
            'End If
            If strEntity = "MY SPACES" Then
                'sbHtml.Append("<a Class=""clsLinkControlMenu"" HREF=""Javascript:AddPage_OnClick(" & intPKID.ToString & ")""><img id='imgAdd" & intPKID.ToString & "'  SRC=""../../Images/AddAns.gif"" BORDER=""0"" ALT=""Add Page"" width=""16"" height=""16""></a>&nbsp;&nbsp;&nbsp;")
                sbHtml.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a HREF=""Javascript:ShowDetails_Onclick(" + intPKID.ToString + ",'" + m_strFromWhere + "')""> <font color='blue' style='font-size:10px'>More Articles</font>")
            ElseIf strEntity = "MY TEAMS" Then
                'sbHtml.Append("<a Class=""clsLinkControlMenu"" HREF=""Javascript:AddSpace_OnClick(" & intPKID.ToString & ")""><img id='imgAdd" & intPKID.ToString & "'  SRC=""../../Images/AddAns.gif"" BORDER=""0"" ALT=""Add Space"" width=""16"" height=""16""></a>&nbsp;&nbsp;&nbsp;")
                sbHtml.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a HREF=""Javascript:ShowDetails_Onclick(" + intPKID.ToString + ",'" + m_strFromWhere + "')""> <font color='blue' style='font-size:10px'>More Spaces</font>")
            End If

            sbHtml.Append("</a>&nbsp;&nbsp;&nbsp;&nbsp;</td>")
            sbHtml.Append("</tr>")
        Else
            sbHtml.Append("<tr class=""clsTRControlMenu"">")
            sbHtml.Append("<td align=center colspan=4 style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>")
            If intCount = 0 Then
                sbHtml.Append("There are no items to show in this view...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
            End If
            sbHtml.Append("</TD><TD align=right colspan=3>")
            'sbHtml.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", value:=intPKID, ToBeInserted:="", returnHTML:=True))
            'If strEntity = "MY PAGES" Then
            'sbHtml.Append("&nbsp;<a HREF=""Javascript:Page_OnClick(" + intPKID.ToString + ",'" + strMode + "')""><font color='blue'>Edit</font></a>")
            'If strEntity = "MY SPACES" Then
            '    sbHtml.Append("<a Class=""clsLinkControlMenu"" HREF=""Javascript:AddPage_OnClick(" & intPKID.ToString & ")""><img id='imgAdd" & intPKID.ToString & "'  SRC=""../../Images/AddAns.gif"" BORDER=""0"" ALT=""Add Page"" width=""16"" height=""16""></a>&nbsp;&nbsp;&nbsp;")
            'ElseIf strEntity = "MY TEAMS" Then
            '    sbHtml.Append("<a Class=""clsLinkControlMenu"" HREF=""Javascript:AddSpace_OnClick(" & intPKID.ToString & ")""><img id='imgAdd" & intPKID.ToString & "'  SRC=""../../Images/AddAns.gif"" BORDER=""0"" ALT=""Add Space"" width=""16"" height=""16""></a>&nbsp;&nbsp;&nbsp;")
            'End If
            sbHtml.Append("</TD></tr>")
        End If
        sbHtml.Append(" <tr>")
        sbHtml.Append("<td  class=""clsTDBottomLeftCorner"">  </td>")
        sbHtml.Append("<td WIDTH=" & (intTableWidth - 28).ToString & " ></td>")
        sbHtml.Append("<td></td><td class=""clsTDBottomRightCorner""></td>")
        sbHtml.Append("</tr>")

        sbHtml.Append("</table>")

        If intPanel = 1 Then
            m_intLeftRows += intRowCount + 3
        Else
            m_intRightRows += intRowCount + 3
        End If

        Return sbHtml.ToString
    End Function
    Private Function PlotPaging(ByVal strPagingQueryString As String, ByVal strPagingSQL As String, ByRef intPagingNumber As Integer, ByVal strPagingDivName As String, ByRef intRecordCount As Integer) As String
        Dim sbHTML As New System.Text.StringBuilder
        'Dim intRecordCount As Integer
        Dim intPageCount As Integer
        Dim intCount As Integer
        Dim intStartPage As Integer
        Dim intEndPage As Integer

        intRecordCount = CommonFunctions.Data.GetDataScalar(strPagingSQL, MyBase.UseSQL)

        If Math.Ceiling(intRecordCount / 10) < intPagingNumber Then
            intPagingNumber = 1
        End If

        intStartPage = (Math.Floor((intPagingNumber - 1) / 10)) * 10 + 1

        intPageCount = Math.Ceiling(intRecordCount / 10)
        intEndPage = intStartPage + 9
        If intEndPage > intPageCount Then
            intEndPage = intPageCount
        End If
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtPageCount", "txtPageCount", , , , intPageCount.ToString(), IsHidden:=True, returnHTML:=True))
        sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtPageCount", "txtPageCount", , , , intPageCount.ToString(), IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        If intPageCount > 1 Then
            sbHTML.Append("<Div id='" & strPagingDivName & "' width=99.99%>")
            sbHTML.Append("<Table id='tblPaging' class=clstable width=99.99%><tr class=clsTREven><td>")
            sbHTML.Append("Result Pages ")
            If intStartPage >= 11 Then
                sbHTML.Append("<a style='font-size:120%;' href=""javascript:Paging_PrevOnclick(" & intStartPage.ToString & "," & intPageCount & ",'" & strPagingQueryString & "','" & strPagingDivName & "')"">Prev</a>")
            End If
            sbHTML.Append("&nbsp;&nbsp;&nbsp;&nbsp;")
            For intCount = intStartPage To intEndPage
                sbHTML.Append("<a style='font-size:120%;' href=""javascript:Paging_Onclick(" & intCount.ToString & ",'" & strPagingQueryString & "')"">" & intCount.ToString & "</a>")
                sbHTML.Append("&nbsp;&nbsp;&nbsp;&nbsp;")
            Next
            If intPageCount > intEndPage Then
                sbHTML.Append("<a style='font-size:120%;' href=""javascript:Paging_NextOnclick(" & intStartPage.ToString & "," & intPageCount & ",'" & strPagingQueryString & "','" & strPagingDivName & "')"">Next</a>")
            End If

            sbHTML.Append("</td></tr></Table>")
            sbHTML.Append("</Div>")
        End If
        Return sbHTML.ToString()
    End Function
    Private Sub PlotMenu()
        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips


        ArrMenuCaptionsList.Add("Add")
        ArrMenuToolTipsList.Add("Add")
        ArrClientSideFunctionsList.Add("AddNew_OnClick('" & m_strTab & "','" & m_strSubTab & "')")

        If m_strTab.ToUpper = "MY" Then
            ArrMenuCaptionsList.Add("Delete")
            ArrMenuToolTipsList.Add("Delete")
            ArrClientSideFunctionsList.Add("Delete_OnClick('" & m_strSubTab & "')")
        End If


        ArrMenuCaptionsList.Add("Help")
        ArrMenuToolTipsList.Add("Help")
        ArrClientSideFunctionsList.Add("Help_OnClick('KM')")

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
        CommonFunctions.General.WriteHTML(m_objMenu.DrawMenuWithEvents(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True))
        m_objMenu = Nothing

    End Sub

    '-------------------------------------For New UI---------------------------------------------------------
    Public Function FeaturedArticle_NewUI()
        Dim strSQL As String
        Dim drArticle As IDataReader
        Dim strQuery As String
        Dim strRating As String
        Dim counter As Integer
        Dim flag As Integer
        Dim strStyleSheet As String
        Dim iterator As Integer
        Dim strSQLQuery As String
        Dim dr As IDataReader
        Dim strHtml As New System.Text.StringBuilder
        Dim strcolor As String
        Dim strRatingNew As String
        Dim tempRating As Double
        Dim PKToken_ProcedureID As String
        Dim strAttachments As String

        ''integrated by RohiniK on 03 Nov 09
        Dim strcboDateFilter As String = ""
        If Not HttpContext.Current.Request.Form("cboDateFilter") Is Nothing Then
            strcboDateFilter = HttpContext.Current.Request.Form("cboDateFilter")
        ElseIf Not HttpContext.Current.Request.QueryString("cboDateFilterValue") Is Nothing Then
            strcboDateFilter = HttpContext.Current.Request.QueryString("cboDateFilterValue")
        End If
        ''End of integratition by RohiniK on 03 Nov 09

        flag = 0

        strSQL = "usp_Sel_tbl_KM_CodeHeadings_FeaturedArticle " & HttpContext.Current.Session("intUserID").ToString
        drArticle = CommonFunctions.Data.GetDataReader(strSQL, True)

        strStyleSheet = CommonFunction.Data.GetDataScalar("usp_get_StyleSheet " + HttpContext.Current.Session("intUserID").ToString, True)

        If strStyleSheet = "StyleSheetChanakya.css" Then
            strcolor = "#E7F1FE"
        ElseIf strStyleSheet = "StyleSheetChanakya_BrickRed.css" Then
            strcolor = "#fcefec"
        ElseIf strStyleSheet = "StyleSheetChanakya_BurntSienna.css" Then
            strcolor = "#f8f0e5"
        ElseIf strStyleSheet = "StyleSheetChanakya_Green.css" Then
            strcolor = "#e1f6e3"
        ElseIf strStyleSheet = "StyleSheetChanakya_Purple.css" Then
            strcolor = "#f1eefb"
        ElseIf strStyleSheet = "StyleSheetChanakya_GYellow.css" Then
            strcolor = "#f7f5d7"
        ElseIf strStyleSheet = "StyleSheetChanakya_turquoise.css" Then
            strcolor = "#daf0f3"
        ElseIf strStyleSheet = "StyleSheetChanakya_black.css" Then
            strcolor = "#F2F3F3"
        End If

        ''Commented And Added By Vaijat K ON 03/12/2015
        'strHtml.Append("<DIV ID=divPage style='OVERFLOW:auto;width:100%;height:99.99%'>")
        strHtml.Append("<DIV ID=divPage style='OVERFLOW:auto;width:100%;'>")
        '''strHtml.Append("<DIV Id=divPage Style='HEIGHT:99.99%;OVERFLOW:auto; WIDTH:100%'>")
        ''strHtml.Append("<TABLE valign=bottom class='clsTable'  CellSpacing='0' CellPadding=0  width=100% >")
        '''strHtml.Append("<TR class='clsTREven' style='border:1px solid #ccc;'><TD colspan=3 style='width:100%;' valign='top' align=center>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Latest Featured Article by </td>")
        '''strHtml.Append("<TR style='border:1px solid #ccc;'>")
        '''strHtml.Append("<TD bgcolor=""#F0F0F0"" style='width:90%;' valign='top' align=center><font fontFamily:'Verdana'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Latest Featured Article</font></td>")

        ''integrated by RohiniK on 03 Nov 09
        'Code added by KapilK on 19-Aug-09[Olam KM changes]
        Dim objDynamicLink As WebPages.UI.cDynamicLink
        objDynamicLink = New WebPages.UI.cDynamicLink
        objDynamicLink.LinkName = "Show"
        objDynamicLink.Tooltip = "Show"
        objDynamicLink.FunctionName = "Show_OnClick()"
        objDynamicLink.ReturnHTML = True

        strHtml.Append("<DIV ID=divFilter>")
        strHtml.Append("<TABLE class='clsTable'  CellSpacing='0' CellPadding=0  width=100% >")
        strHtml.Append("<TR class='clsTREven' style='border:1px solid #ccc;'><TD style='width:15%;' valign='top' align=right><font fontFamily:'Verdana'>Articles Timeline</font></td>")
        strHtml.Append("<TD style='width:15%;' valign='top' align=left>")
        strHtml.Append(CommonFunction.HTMLControls.DrawComboBox("cboDateFilter", "usp_SEL_tbl_KM_DateFilter", 100, strcboDateFilter, , True, True))
        strHtml.Append("</TD><TD style='width:15%;' valign='top' align=right><font fontFamily:'Verdana'>Article Editable By Me</font></TD><TD style='width:15%;' valign='top' align=left>")
        strHtml.Append(CommonFunction.HTMLControls.DrawCheckBox("chkEditToMe", "chkEditToMe", , CBool(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("chkEditToMe"), "0")), "1", , , True, False))
        strHtml.Append("</TD><TD style='width:40%;' valign='top' align=left><font fontFamily:'Verdana'><b>")
        strHtml.Append(objDynamicLink.GetDynamicLink())
        strHtml.Append("</b></font></TD><TD></TD></TR></Table></DIV>")
        strHtml.Append("<hr>")
        'End;Code added by KapilK on 19-Aug-09[Olam KM changes]

        ''End of integratition by RohiniK on 03 Nov 09
        If drArticle.Read Then
            ''strHtml.Append("<TR ><TD width=35% align=center >&nbsp;</td><TD style='width:65%;font-weight :lighter ; font-family:Tahoma ;  font-size:13px;' align=left><B>Latest Featured Article by " + drArticle("EmployeeName").ToString + "</B></td>")
            ''strHtml.Append("</tr>")
            ''strHtml.Append("<TR ><TD width=100% colspan=2 align=center >&nbsp;</td>")
            ''strHtml.Append("</tr>")
            ''strHtml.Append("</Table>")
            'strHtml.Append("</DIV>")
            'strHtml.Append("<DIV ID=divArticle style='width:100%;height:100%'>")
            strHtml.Append("<TABLE class='clsTable' CellSpacing='0' CellPadding=0  width=100% >")
            'strHtml.Append("<TR class='clsTREven'><TD id='TD_Left'style='width:99.99%;border:1px solid #ccc;' valign='top'>")
            'strHtml.Append("<TABLE id='tblCap00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageCaption><td align=left>Articles</td></tr></Table>")
            'If drArticle.Read Then
            'Commented and Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
            'PKToken_ProcedureID = CommonFunctions.Security.Token.GetToken(CType(drArticle("ProcedureID"), String))
            PKToken_ProcedureID = CommonFunctions.Security.Token.GetToken(CType(drArticle("ProcedureID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0")
            'End Of Commented and Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
            strAttachments = CommonFunction.Data.GetDataScalar("IF EXISTS(SELECT ProcedureID FROM tbl_KM_Attachments WHERE ProcedureID = " + drArticle("ProcedureID").ToString + ") SELECT 1", True)
            If drArticle("ProcedureTitle").ToString.Length > 25 Then
                If strAttachments = "1" Then
                    ''Commented And Added By Vaijat K ON 19/11/2015
                    'strHtml.Append("<TR class='clsTREven'><TD class='clsLinkChildNavMenu' width=20% align=left ><A title='Attachment' href=""JavaScript:Document_OnClick('" + drArticle("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Attachment.gif'></A> &nbsp; &nbsp; <A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drArticle("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions.gif'></A></td><TD width=55% style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;' align=center ><B> Latest Article Name : </B>" & Left(CType(drArticle("ProcedureTitle"), String), 25) & "... <br> by " + drArticle("EmployeeName").ToString + "</TD>")
                    strHtml.Append("<TR class='clsTREven'><TD class='clsLinkChildNavMenu' width=20% align=left ><A title='Attachment' href=""JavaScript:Document_OnClick('" + drArticle("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Attachment.gif'></A> &nbsp; &nbsp; <A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drArticle("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions.gif'></A></td><TD width=55% style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;' align=center ><B> Latest Article Name : </B>" & HttpUtility.HtmlEncode(Left(CType(drArticle("ProcedureTitle"), String), 25)) & "... <br> by " + drArticle("EmployeeName").ToString + "</TD>") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                Else
                    'Commented and Modified by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0
                    'strHtml.Append("<TR class='clsTREven'><TD class='clsLinkChildNavMenu' width=20% align=left >&nbsp;&nbsp;&nbsp;<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drArticle("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions.gif'></A></td><TD width=55% style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;' align=center ><B> Article Name : </B>" & Left(CType(drArticle("ProcedureTitle"), String), 25) & "... <br> by " + drArticle("EmployeeName").ToString + "</TD>")
                    If Trim(drArticle("NoOfDiscussions").ToString & "") <> "" And Trim(drArticle("NoOfDiscussions").ToString & "") <> "0" Then
                        ''Commented And Added By Vaijat K ON 19/11/2015
                        'strHtml.Append("<TR class='clsTREven'><TD class='clsLinkChildNavMenu' width=20% align=left >&nbsp;&nbsp;&nbsp;<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drArticle("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions.gif'>(" + drArticle("NoOfDiscussions").ToString + ") </A></td><TD width=55% style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;' align=center ><B> Article Name : </B>" & Left(CType(drArticle("ProcedureTitle"), String), 25) & "... <br> by " + drArticle("EmployeeName").ToString + "</TD>")
                        strHtml.Append("<TR class='clsTREven'><TD class='clsLinkChildNavMenu' width=20% align=left >&nbsp;&nbsp;&nbsp;<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drArticle("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions.gif'>(" + drArticle("NoOfDiscussions").ToString + ") </A></td><TD width=55% style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;' align=center ><B> Article Name : </B>" & HttpUtility.HtmlEncode(Left(CType(drArticle("ProcedureTitle"), String), 25)) & "... <br> by " + drArticle("EmployeeName").ToString + "</TD>") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                    Else
                        ''Commented And Added By Vaijat K ON 19/11/2015
                        strHtml.Append("<TR class='clsTREven'><TD class='clsLinkChildNavMenu' width=20% align=left >&nbsp;&nbsp;&nbsp;<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drArticle("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions.gif'></A></td><TD width=55% style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;' align=center ><B> Article Name : </B>" & Left(CType(drArticle("ProcedureTitle"), String), 25) & "... <br> by " + drArticle("EmployeeName").ToString + "</TD>")
                        'strHtml.Append("<TR class='clsTREven'><TD class='clsLinkChildNavMenu' width=20% align=left >&nbsp;&nbsp;&nbsp;<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drArticle("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions.gif'></A></td><TD width=55% style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;' align=center ><B> Article Name : </B>" & HttpUtility.HtmlEncode(Left(CType(drArticle("ProcedureTitle"), String), 25)) & "... <br> by " + drArticle("EmployeeName").ToString + "</TD>") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                    End If
                    'End of Comment and Modification by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0
                End If
            Else
                If strAttachments = "1" Then
                    strHtml.Append("<TR class='clsTREven'><TD class='clsLinkChildNavMenu' width=20% align=left ><A title='Attachment' href=""JavaScript:Document_OnClick('" + drArticle("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Attachment.gif'></A>&nbsp;&nbsp;<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drArticle("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions.gif'></A></td><TD width=55% style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;' align=center ><B>  Latest Article Name : </B>" & HttpUtility.HtmlEncode(drArticle("ProcedureTitle").ToString) & " <br> by " + drArticle("EmployeeName").ToString + "</TD>") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                Else
                    'Commented and Modified by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0
                    'strHtml.Append("<TR class='clsTREven'><TD class='clsLinkChildNavMenu' width=20% align=left>&nbsp;&nbsp;&nbsp;<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drArticle("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions.gif'></A></td><TD width=55% style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;' align=center ><B> Latest Article Name : </B>" & drArticle("ProcedureTitle").ToString & " <br> by " + drArticle("EmployeeName").ToString + "</TD>")
                    If Trim(drArticle("NoOfDiscussions").ToString & "") <> "" And Trim(drArticle("NoOfDiscussions").ToString & "") <> "0" Then
                        ''Commented And Added By Vaijat K ON 19/11/2015
                        'strHtml.Append("<TR class='clsTREven'><TD class='clsLinkChildNavMenu' width=20% align=left>&nbsp;&nbsp;&nbsp;<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drArticle("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions.gif'>(" + drArticle("NoOfDiscussions").ToString + ")</A></td><TD width=55% style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;' align=center ><B> Latest Article Name : </B>" & drArticle("ProcedureTitle").ToString & " <br> by " + drArticle("EmployeeName").ToString + "</TD>")
                        strHtml.Append("<TR class='clsTREven'><TD class='clsLinkChildNavMenu' width=20% align=left>&nbsp;&nbsp;&nbsp;<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drArticle("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions.gif'>(" + drArticle("NoOfDiscussions").ToString + ")</A></td><TD width=55% style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;' align=center ><B> Latest Article Name : </B>" & HttpUtility.HtmlEncode(drArticle("ProcedureTitle").ToString) & " <br> by " + drArticle("EmployeeName").ToString + "</TD>") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                    Else
                        ''Commented And Added By Vaijat K ON 19/11/2015
                        'strHtml.Append("<TR class='clsTREven'><TD class='clsLinkChildNavMenu' width=20% align=left>&nbsp;&nbsp;&nbsp;<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drArticle("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions.gif'></A></td><TD width=55% style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;' align=center ><B> Latest Article Name : </B>" & drArticle("ProcedureTitle").ToString & " <br> by " + drArticle("EmployeeName").ToString + "</TD>")
                        strHtml.Append("<TR class='clsTREven'><TD class='clsLinkChildNavMenu' width=20% align=left>&nbsp;&nbsp;&nbsp;<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drArticle("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions.gif'></A></td><TD width=55% style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;' align=center ><B> Latest Article Name : </B>" & HttpUtility.HtmlEncode(drArticle("ProcedureTitle").ToString) & " <br> by " + drArticle("EmployeeName").ToString + "</TD>") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                    End If
                    'End of Comment and Modification by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0
                End If
            End If


            strRating = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT AVG(Rating) AS Rating FROM tbl_KM_ArticleRating WHERE ProcedureID=" + drArticle("ProcedureID").ToString, True), "")
            'End If

            If strRating.LastIndexOf(".") <> "-1" Then
                strRatingNew = strRating.Substring(0, strRating.LastIndexOf("."))
            Else
                strRatingNew = strRating
            End If

            If strRating <> "" Then
                strHtml.Append("<TD style='width:10%;' style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;' align=right>Rating&nbsp;</TD>")

                For counter = 0 To 5
                    If CType(strRatingNew, Integer) <> counter Then
                        strHtml.Append("<TD style='width:1%;' align=left>")
                        strHtml.Append("<img id='imgstaron'  SRC=""../../Images/star_on.gif"" BORDER=""0""  width=""16"" height=""16"">")
                        strHtml.Append("</TD>")
                    Else
                        tempRating = CType(strRating, Double) - CType(strRatingNew, Double)
                        If tempRating < 0.5 And tempRating <> 0.0 Then
                            strHtml.Append("<TD style='width:1%;' align=left>")
                            strHtml.Append("<img id='imgstaron'  SRC=""../../Images/starl5.GIF"" BORDER=""0""  width=""16"" height=""16"">")
                            strHtml.Append("</TD>")
                        ElseIf tempRating = 0.5 Then
                            strHtml.Append("<TD style='width:1%;' align=left>")
                            strHtml.Append("<img id='imgstaron'  SRC=""../../Images/stare5.GIF"" BORDER=""0""  width=""16"" height=""16"">")
                            strHtml.Append("</TD>")
                        ElseIf tempRating > 0.5 Then
                            strHtml.Append("<TD style='width:1%;' align=left>")
                            strHtml.Append("<img id='imgstaron'  SRC=""../../Images/starg5.GIF"" BORDER=""0""  width=""16"" height=""16"">")
                            strHtml.Append("</TD>")
                        ElseIf tempRating = 0.0 And CType(strRating, Double) <> 5.0 Then
                            strHtml.Append("<TD style='width:1%;' align=left>")
                            strHtml.Append("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""16"" height=""16"">")
                            strHtml.Append("</TD>")
                        End If
                        flag = strRatingNew + 2
                        Exit For
                    End If
                Next

                For counter = flag To 5
                    strHtml.Append("<TD style='width:1%;' align=left>")
                    strHtml.Append("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""16"" height=""16"">")
                    strHtml.Append("</TD>")
                Next
            Else
                'strHtml.Append("<TD style='width:15%;' colspan=6 align=right>&nbsp;</TD>")
                strHtml.Append("<TD style='width:10%;' align=right><font style='width:10%;' style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;'> Rating&nbsp;</font></TD>")
                For counter = 0 To 4
                    strHtml.Append("<TD style='width:1%;' align=left>")
                    strHtml.Append("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""16"" height=""16"">")
                    strHtml.Append("</TD>")
                Next
            End If

            strHtml.Append("<TD style='width:10%;' nowrap align=left>&nbsp;<a class='clsLinkChildNavMenu' href='Javascript:RateArticle(" + drArticle("ProcedureID").ToString + ")'>Rate Article</a> ")
            strHtml.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:ArticleEdit_OnClick(" + drArticle("ProcedureID").ToString + ",'Edit','" + m_strFromWhere + "')""><img src='../../Images/Home/maximize.gif'  border='0'  alt='Max' /></a>")
            strHtml.Append("</TD>")


            strHtml.Append("</TR>")
            strHtml.Append("<TR ><TD align=center colspan=9>&nbsp;</TD></TR>")
            strHtml.Append("<TR ><TD colspan=9 wrap style='width:99.99%;font-weight :lighter ; font-family:Tahoma ;  font-size:14px;' valign=top>" & Left(CommonFunctions.Data.CheckIsDBNull(drArticle("ProcedureCode"), ""), 150) & "</TD></TR>") 'HtmlEncode Added By Vaijat K ON 23/11/2015
        Else
            strHtml.Append("</Table><hr size=-2 style=""color:White"">")
            strHtml.Append("<TABLE  class='clsTable' style=""border-top:1px solid #383838;"" CellSpacing='0' CellPadding=0  width=100% height=100%>")
            strHtml.Append("<TR ><TD align=center style='font-weight :lighter ; font-family:Tahoma ;  font-size:14px;'> No Article</TD></TR>")
        End If
        CommonFunction.Data.DisposeDataReader(drArticle)

        strHtml.Append("</TABLE>")
        'CommonFunctions.General.WriteHTML("</DIV>")
        strHtml.Append("</DIV>")
        'strHtml.Append("</td>")
        strHtml.Append("</br>")

        Return strHtml.ToString
    End Function

    Public Shared Function TopTenArticles()
        Dim strSQL As String
        Dim drTopTenArticles As IDataReader
        Dim intCount As Integer
        Dim strSynopsis As String
        Dim strRating As String
        Dim counter As Integer
        Dim flag As Integer
        Dim drSynopsis As IDataReader
        Dim strQuery As String
        Dim strEditAccess As String
        Dim strProgrammerID As String
        Dim drEditAccess As IDataReader
        Dim strRatingNew As String
        Dim tempRating As Double
        Dim PKToken_ProcedureID As String
        Dim strAttachments As String

        flag = 0

        Dim sbHtml As New System.Text.StringBuilder
        Dim sbHtml_Left As New System.Text.StringBuilder
        Dim sbHtml_Right As New System.Text.StringBuilder

        strSQL = "usp_sel_tbl_KM_ArticleRating_Avg "
        drTopTenArticles = CommonFunction.Data.GetDataReader(strSQL, True)

        sbHtml.Append("<table CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Width='99.9%' >")
        sbHtml.Append("<tr class='clsTREven'>")
        sbHtml.Append("<td align=center valign=top WIDTH=""100%"" class='clsLinkChildNavMenu'><b> Top 10 Articles </b>")
        sbHtml.Append("</td>")
        sbHtml.Append("</tr>")
        sbHtml.Append("</table><br>")


        sbHtml.Append("<table CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Width='99.9%' >")
        sbHtml.Append("<TR>")

        sbHtml.Append("<TD  align=center valign=top WIDTH=""100%"">")

        sbHtml.Append("<table id='HeaderTable' WIDTH=99.9% CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Class=""clsRoundedTableHeader"" >")
        sbHtml.Append("<tr>")
        sbHtml.Append("<td WIDTH=""14"" class=""clsTDTopLeftCorner"">  </td>")
        sbHtml.Append("<td  rowspan=""2"" valign=""middle""> ")
        sbHtml.Append("<table WIDTH=100% Class=""clsRoundedTableHeader"" ><tr class='clsTREven'><td align=""Left"" class='clsLinkChildNavMenu'><b>Articles</b></td>")
        sbHtml.Append("<td align=right><a Class=""clsLinkControlMenu"" HREF=""Javascript:ShowHideGroup_Onclick(1)""><img id='imgGroup1'  SRC=""../../Images/MoveUp.GIF"" BORDER=""0"" ALT=""..."" width=""14"" height=""14""></a></td></tr></table>")
        sbHtml.Append("<br>")
        sbHtml.Append("</td>")

        sbHtml.Append("<td WIDTH=""14"" class=""clsTDTopRightCorner"">  </td>")
        sbHtml.Append("</tr>")
        sbHtml.Append("<tr>")
        sbHtml.Append("<td>&nbsp;&nbsp;</td>")
        sbHtml.Append("<td>&nbsp;&nbsp;</td>")
        sbHtml.Append("</tr>")
        sbHtml.Append("</table>")
        sbHtml.Append("<table  id=tblGroup1 WIDTH=100% CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Class=""clsRoundedTableMenu"">")

        While drTopTenArticles.Read
            intCount = intCount + 1

            If intCount = 1 Or intCount = 3 Or intCount = 5 Or intCount = 7 Or intCount = 9 Then
                sbHtml_Left.Remove(0, sbHtml_Left.Length)
                sbHtml.Append("<tr class=""clsTRControlMenu"">")
            End If

            If intCount = 1 Or intCount = 3 Or intCount = 5 Or intCount = 7 Or intCount = 9 Then
                'To show edit link if user has edit access as well as user is a creator
                strQuery = ""
                strEditAccess = ""
                strProgrammerID = ""
                PKToken_ProcedureID = ""
                strAttachments = ""

                strQuery = "usp_Get_EditAccess " + drTopTenArticles("ProcedureID").ToString + "," + HttpContext.Current.Session("intUserID").ToString
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

                'Commented and Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
                'PKToken_ProcedureID = CommonFunctions.Security.Token.GetToken(CType(drTopTenArticles("ProcedureID"), String))
                PKToken_ProcedureID = CommonFunctions.Security.Token.GetToken(CType(drTopTenArticles("ProcedureID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0")
                'End Of Commented and Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
                strAttachments = CommonFunction.Data.GetDataScalar("IF EXISTS(SELECT ProcedureID FROM tbl_KM_Attachments WHERE ProcedureID = " + drTopTenArticles("ProcedureID").ToString + ") SELECT 1", True)

                sbHtml_Left.Append("<td valign=top align=left width=40% style='font-weight :lighter ; font-family:Tahoma ;  font-size:12px;'>")
                If strAttachments = "1" Then
                    sbHtml_Left.Append("<A title='Attachment' href=""JavaScript:Document_OnClick('" + drTopTenArticles("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img title='Attachment' border=0 src='../../Images/Attachment1.gif'></A>&nbsp;")

                    'Commented and Modified by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0
                    'sbHtml_Left.Append("<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drTopTenArticles("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'></A>&nbsp;")
                    If Trim(drTopTenArticles("NoOfDiscussions").ToString & "") <> "" And Trim(drTopTenArticles("NoOfDiscussions").ToString & "") <> "0" Then
                        sbHtml_Left.Append("<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drTopTenArticles("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'>(" + drTopTenArticles("NoOfDiscussions").ToString + ")</A>&nbsp;")
                    Else
                        sbHtml_Left.Append("<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drTopTenArticles("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'></A>&nbsp;")
                    End If
                    'End of Comment and Modification by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0
                Else
                    'Commented and Modified by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0
                    'sbHtml_Left.Append("<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drTopTenArticles("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'></A>&nbsp;")
                    If Trim(drTopTenArticles("NoOfDiscussions").ToString & "") <> "" And Trim(drTopTenArticles("NoOfDiscussions").ToString & "") <> "0" Then
                        sbHtml_Left.Append("<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drTopTenArticles("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'>(" + drTopTenArticles("NoOfDiscussions").ToString + ")</A>&nbsp;")
                    Else
                        sbHtml_Left.Append("<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drTopTenArticles("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'></A>&nbsp;")
                    End If
                    'End of Comment and Modification by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0
                End If

                If strEditAccess = "1" Or strProgrammerID = HttpContext.Current.Session("intUserID").ToString Then
                    sbHtml_Left.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:ArticleEdit_OnClick(" + drTopTenArticles("ProcedureID").ToString + ",'edit','TopTen')"">")
                Else
                    sbHtml_Left.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:ArticleEdit_OnClick(" + drTopTenArticles("ProcedureID").ToString + ",'view','TopTen')"">")
                End If
                sbHtml_Left.Append("<b>" + HttpUtility.HtmlEncode(drTopTenArticles("ProcedureTitle").ToString) + "</b>") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                sbHtml_Left.Append("</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
                'sbHtml_Left.Append("</font>")
                'sbHtml_Left.Append("</td>")

                strRating = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT AVG(Rating) AS Rating FROM tbl_KM_ArticleRating WHERE ProcedureID=" + drTopTenArticles("ProcedureID").ToString, True), "")

                If strRating.LastIndexOf(".") <> "-1" Then
                    strRatingNew = strRating.Substring(0, strRating.LastIndexOf("."))
                Else
                    strRatingNew = strRating
                End If


                sbHtml_Left.Append("<BR>")
                drSynopsis = CommonFunction.Data.GetDataReader("SELECT Synopsis,EmployeeName FROM tbl_KM_CodeHeadings INNER JOIN tbl_PM_Employee ON tbl_KM_CodeHeadings.ProgrammerID = tbl_PM_Employee.EmployeeID WHERE ProcedureID=" + drTopTenArticles("ProcedureID").ToString, True)
                If drSynopsis.Read Then
                    sbHtml_Left.Append("Author : " + drSynopsis("EmployeeName").ToString)
                    sbHtml_Left.Append("<BR>")
                    If drSynopsis("Synopsis").ToString.Length > 50 Then
                        sbHtml_Left.Append(HttpUtility.HtmlEncode(Left(drSynopsis("Synopsis").ToString, 150)) + "....") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                    Else
                        sbHtml_Left.Append(HttpUtility.HtmlEncode(drSynopsis("Synopsis").ToString)) 'HtmlEncode Added By Vaijat K ON 20/11/2015
                    End If
                End If
                CommonFunction.Data.DisposeDataReader(drSynopsis)


                sbHtml_Left.Append("</td>")
                sbHtml_Left.Append("<td valign=top align=center width=9% >")
                If strRating <> "" Then
                    For counter = 0 To 5
                        If CType(strRatingNew, Integer) <> counter Then
                            'sbHtml_Left.Append("<TD style='width:1%;' align=left>")
                            sbHtml_Left.Append("<img id='imgstaron'  SRC=""../../Images/star_on.gif"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                            'sbHtml_Left.Append("</TD>")
                        Else
                            tempRating = CType(strRating, Double) - CType(strRatingNew, Double)
                            If tempRating < 0.5 And tempRating <> 0.0 Then
                                sbHtml_Left.Append("<img id='imgstaron'  SRC=""../../Images/starl5.GIF"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                            ElseIf tempRating = 0.5 Then
                                sbHtml_Left.Append("<img id='imgstaron'  SRC=""../../Images/stare5.GIF"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                            ElseIf tempRating > 0.5 Then
                                sbHtml_Left.Append("<img id='imgstaron'  SRC=""../../Images/starg5.GIF"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                            ElseIf tempRating = 0.0 And CType(strRating, Double) <> 5.0 Then
                                sbHtml_Left.Append("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                            End If
                            flag = strRatingNew + 2
                            Exit For
                        End If
                    Next

                    For counter = flag To 5
                        'sbHtml_Left.Append("<TD style='width:1%;' align=left>")
                        sbHtml_Left.Append("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                        'sbHtml_Left.Append("</TD>")
                    Next
                    'Else
                    '    For counter = 0 To 4
                    '        sbHtml_Left.Append("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""8"" height=""8"">&nbsp;&nbsp;")
                    '    Next
                End If

                'sbHtml_Left.Append("</td><td valign=top align=left width=7%>")
                If strEditAccess = "1" Or strProgrammerID = HttpContext.Current.Session("intUserID").ToString Then
                    'sbHtml_Left.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=""Javascript:Edit_OnClick(" + drTopTenArticles("ProcedureID").ToString + ",'Edit','TopTen')""><font style=""color:Blue"">[edit]</font></a></td>")
                    'sbHtml_Left.Append("&nbsp;&nbsp;<a href=""Javascript:ArticleEdit_OnClick(" + drTopTenArticles("ProcedureID").ToString + ",'Edit','TopTen')""><img src='../../Images/Home/maximize.gif' border='0' alt='Max' /></a>&nbsp;&nbsp;</td>")
                    sbHtml_Left.Append("&nbsp;&nbsp;<a  style='text-decoration:none' href=""Javascript:ArticleEdit_OnClick(" + drTopTenArticles("ProcedureID").ToString + ",'Edit','TopTen')""><img src='../../Images/Home/maximize.gif'  border='0'  alt='Max' /></a>&nbsp;&nbsp;</td>")
                Else
                    'sbHtml_Left.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=""Javascript:Edit_OnClick(" + drTopTenArticles("ProcedureID").ToString + ",'view','TopTen')""><font style=""color:Blue"">[view]</font></a></td>")
                    sbHtml_Left.Append("&nbsp;&nbsp;<a style='text-decoration:none' href=""Javascript:ArticleEdit_OnClick(" + drTopTenArticles("ProcedureID").ToString + ",'view','TopTen')""><img src='../../Images/Home/maximize.gif'  border='0'  alt='Max'  /></a>&nbsp;&nbsp;</td>")
                End If
                sbHtml_Left.Append("</td>")
                'End to show edit link if user has edit access as well as user is a creator 
                sbHtml.Append(sbHtml_Left.ToString)
            ElseIf intCount = 2 Or intCount = 4 Or intCount = 6 Or intCount = 8 Or intCount = 10 Then

                'To show edit link if user has edit access as well as user is a creator
                strQuery = ""
                strEditAccess = ""
                strProgrammerID = ""
                PKToken_ProcedureID = ""
                strAttachments = ""

                strQuery = "usp_Get_EditAccess " + drTopTenArticles("ProcedureID").ToString + "," + HttpContext.Current.Session("intUserID").ToString
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

                'Commented and Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
                'PKToken_ProcedureID = CommonFunctions.Security.Token.GetToken(CType(drTopTenArticles("ProcedureID"), String))
                PKToken_ProcedureID = CommonFunctions.Security.Token.GetToken(CType(drTopTenArticles("ProcedureID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0")
                'End Of Commented and Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
                strAttachments = CommonFunction.Data.GetDataScalar("IF EXISTS(SELECT ProcedureID FROM tbl_KM_Attachments WHERE ProcedureID = " + drTopTenArticles("ProcedureID").ToString + ") SELECT 1", True)

                sbHtml_Right.Append("<td align=left width=40% style='font-weight :lighter ; font-family:Tahoma ;  font-size:12px;'>")
                If strAttachments = "1" Then
                    sbHtml_Right.Append("<A title='Attachment' href=""JavaScript:Document_OnClick('" + drTopTenArticles("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img title='Attachment' border=0 src='../../Images/Attachment1.gif'></A>&nbsp;")

                    sbHtml_Right.Append("<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drTopTenArticles("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'>(" + drTopTenArticles("NoOfDiscussions").ToString + ")</A>&nbsp;")
                    'Commented and Modified by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0
                    'sbHtml_Right.Append("<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drTopTenArticles("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'></A>&nbsp;")
                    If Trim(drTopTenArticles("NoOfDiscussions").ToString & "") <> "" And Trim(drTopTenArticles("NoOfDiscussions").ToString & "") <> "0" Then
                        sbHtml_Left.Append("<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drTopTenArticles("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'>(" + drTopTenArticles("NoOfDiscussions").ToString + ")</A>&nbsp;")
                    Else
                        sbHtml_Right.Append("<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drTopTenArticles("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'></A>&nbsp;")
                    End If
                    'End of Comment and Modification by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0
                Else
                    'Commented and Modified by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0
                    'sbHtml_Right.Append("<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drTopTenArticles("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'></A>&nbsp;")
                    If Trim(drTopTenArticles("NoOfDiscussions").ToString & "") <> "" And Trim(drTopTenArticles("NoOfDiscussions").ToString & "") <> "0" Then
                        sbHtml_Right.Append("<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drTopTenArticles("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'>(" + drTopTenArticles("NoOfDiscussions").ToString + ")</A>&nbsp;")
                    Else
                        sbHtml_Right.Append("<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + drTopTenArticles("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'></A>&nbsp;")
                    End If
                    'End of Comment and Modification by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0
                End If

                If strEditAccess = "1" Or strProgrammerID = HttpContext.Current.Session("intUserID").ToString Then
                    sbHtml_Right.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:ArticleEdit_OnClick(" + drTopTenArticles("ProcedureID").ToString + ",'edit','TopTen')"">")
                Else
                    sbHtml_Right.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:ArticleEdit_OnClick(" + drTopTenArticles("ProcedureID").ToString + ",'view','TopTen')"">")
                End If
                sbHtml_Right.Append("<b>" + HttpUtility.HtmlEncode(drTopTenArticles("ProcedureTitle").ToString) + "</b>") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                sbHtml_Right.Append("</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
                'sbHtml_Right.Append("</font>")
                'sbHtml_Right.Append("</td>")

                strRating = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT AVG(Rating) AS Rating FROM tbl_KM_ArticleRating WHERE ProcedureID=" + drTopTenArticles("ProcedureID").ToString, True), "")

                If strRating.LastIndexOf(".") <> "-1" Then
                    strRatingNew = strRating.Substring(0, strRating.LastIndexOf("."))
                Else
                    strRatingNew = strRating
                End If


                sbHtml_Right.Append("<BR>")
                drSynopsis = CommonFunction.Data.GetDataReader("SELECT Synopsis,EmployeeName FROM tbl_KM_CodeHeadings INNER JOIN tbl_PM_Employee ON tbl_KM_CodeHeadings.ProgrammerID = tbl_PM_Employee.EmployeeID WHERE ProcedureID=" + drTopTenArticles("ProcedureID").ToString, True)
                If drSynopsis.Read Then
                    sbHtml_Right.Append("Author : " + drSynopsis("EmployeeName").ToString)
                    sbHtml_Right.Append("<BR>")
                    If drSynopsis("Synopsis").ToString.Length > 50 Then
                        sbHtml_Right.Append(HttpUtility.HtmlEncode(Left(drSynopsis("Synopsis").ToString, 150)) + "....") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                    Else
                        sbHtml_Right.Append(HttpUtility.HtmlEncode(drSynopsis("Synopsis").ToString)) 'HtmlEncode Added By Vaijat K ON 20/11/2015
                    End If
                End If

                CommonFunction.Data.DisposeDataReader(drSynopsis)
                sbHtml_Right.Append("</td><td valign=top align=center width=9% >")

                If strRating <> "" Then
                    For counter = 0 To 5
                        If CType(strRatingNew, Integer) <> counter Then
                            'sbHtml_Right.Append("<TD style='width:1%;' align=left>")
                            sbHtml_Right.Append("<img id='imgstaron'  SRC=""../../Images/star_on.gif"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                            'sbHtml_Right.Append("</TD>")
                        Else
                            tempRating = CType(strRating, Double) - CType(strRatingNew, Double)
                            If tempRating < 0.5 And tempRating <> 0.0 Then
                                sbHtml_Right.Append("<img id='imgstaron'  SRC=""../../Images/starl5.GIF"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                            ElseIf tempRating = 0.5 Then
                                sbHtml_Right.Append("<img id='imgstaron'  SRC=""../../Images/stare5.GIF"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                            ElseIf tempRating > 0.5 Then
                                sbHtml_Right.Append("<img id='imgstaron'  SRC=""../../Images/starg5.GIF"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                            ElseIf tempRating = 0.0 And CType(strRating, Double) <> 5.0 Then
                                sbHtml_Right.Append("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                            End If
                            flag = strRatingNew + 2
                            Exit For
                        End If
                    Next

                    For counter = flag To 5
                        'sbHtml_Right.Append("<TD style='width:1%;' align=left>")
                        sbHtml_Right.Append("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                        'sbHtml_Right.Append("</TD>")
                    Next
                    'Else
                    '    For counter = 0 To 4
                    '        sbHtml_Right.Append("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""8"" height=""8"">&nbsp;&nbsp;")
                    '    Next
                End If

                'sbHtml_Right.Append("</td><td valign=top align=left width=7%>")

                If strEditAccess = "1" Or strProgrammerID = HttpContext.Current.Session("intUserID").ToString Then
                    'sbHtml_Right.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=""Javascript:Edit_OnClick(" + drTopTenArticles("ProcedureID").ToString + ",'Edit','TopTen')""><font style=""color:Blue"">[edit]</font></a></td>")
                    'sbHtml_Right.Append("&nbsp;&nbsp;<a href=""Javascript:ArticleEdit_OnClick(" + drTopTenArticles("ProcedureID").ToString + ",'Edit','TopTen')""><img src='../../Images/Home/maximize.gif' border='0' alt='Max' /></a>&nbsp;&nbsp;</td>")
                    sbHtml_Right.Append("&nbsp;&nbsp;<a   style='text-decoration:none'  href=""Javascript:ArticleEdit_OnClick(" + drTopTenArticles("ProcedureID").ToString + ",'Edit','TopTen')""><img src='../../Images/Home/maximize.gif'  border='0' alt='Max' /></a>&nbsp;&nbsp;</td>")
                Else
                    'sbHtml_Right.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=""Javascript:Edit_OnClick(" + drTopTenArticles("ProcedureID").ToString + ",'view','TopTen')""><font style=""color:Blue"">[view]</font></a></td>")
                    sbHtml_Right.Append("&nbsp;&nbsp;<a  style='text-decoration:none' href=""Javascript:ArticleEdit_OnClick(" + drTopTenArticles("ProcedureID").ToString + ",'view','TopTen')""><img src='../../Images/Home/maximize.gif'  border='0'  alt='Max' /></a>&nbsp;&nbsp;</td>")
                End If
                sbHtml_Right.Append("</td>")
                'End to show edit link if user has edit access as well as user is a creator 
                sbHtml.Append(sbHtml_Right.ToString)

            End If
            'sbHtml.Append("<td valign='top' align='right'>")
            'sbHtml.Append("</td>")
            'sbHtml_Left.Append("<td align=right nowrap width=49%>&nbsp;</TD>")
            'sbHtml_Right.Append("<td align=left nowrap width=49%>&nbsp;</TD>")

            If intCount = 2 Or intCount = 4 Or intCount = 6 Or intCount = 8 Or intCount = 10 Then
                sbHtml_Right.Remove(0, sbHtml_Right.Length)
                sbHtml.Append("</tr>")

            End If
        End While

        CommonFunction.Data.DisposeDataReader(drTopTenArticles)

        If intCount = 1 Or intCount = 3 Or intCount = 5 Or intCount = 7 Or intCount = 9 Then
            sbHtml.Append("</tr>")
        End If

        sbHtml.Append("<tr class=""clsTRControlMenu"">")
        sbHtml.Append("<td align=center colspan=3 style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>")
        If intCount = 0 Then
            sbHtml.Append("There are no items to show in this view...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        End If
        sbHtml.Append("</TD></tr>")

        sbHtml.Append(" <tr>")
        sbHtml.Append("<td  class=""clsTDBottomLeftCorner"">  </td>")
        sbHtml.Append("<td WIDTH=" & (400 - 28).ToString & " ></td>")
        sbHtml.Append("<td></td><td class=""clsTDBottomRightCorner""></td>")
        sbHtml.Append("</tr>")
        sbHtml.Append("</table>")
        sbHtml.Append("</td>")
        sbHtml.Append("</tr>")
        sbHtml.Append("</table>")

        Return sbHtml.ToString

    End Function
    Private Function searchArticle(Optional ByVal intFromAjax As Integer = 0, Optional ByVal intCounter As Integer = 0) As String
        Dim strSQL_Page As String
        Dim strSPname_Page As String
        Dim drEntity_PageCount As String
        Dim dsEntity_Page As DataSet
        Dim strSearchText_Page As String = ""
        Dim strIDColumn_Page As String
        Dim strTitleColumn_Page As String
        Dim strEditFunctionName_Page As String
        Dim PageParameters As String

        Dim strSQL_Space As String
        Dim strSPname_Space As String
        Dim drEntity_SpaceCount As String
        Dim dsEntity_Space As DataSet
        Dim strSearchText_Space As String = ""
        Dim strIDColumn_Space As String
        Dim strTitleColumn_Space As String
        Dim strEditFunctionName_Space As String
        Dim SpaceParameters As String

        Dim strSynopsis As String
        Dim strRating As String
        Dim counter As Integer
        Dim flag As Integer
        Dim drSynopsis As IDataReader
        Dim strQuery As String
        Dim strEditAccess As String
        Dim strProgrammerID As String
        Dim drEditAccess As IDataReader
        Dim PageCount As String
        Dim SpaceCount As String
        Dim submitter As String
        Dim strRatingNew As String
        Dim tempRating As Double


        flag = 0

        'Added by SuchitraP on 1-Oct-2008 to display team on search page
        Dim strSQL_Team As String
        Dim strSPname_Team As String
        Dim drEntity_TeamCount As String
        Dim dsEntity_Team As DataSet
        Dim strSearchText_Team As String = ""
        Dim strIDColumn_Team As String
        Dim strTitleColumn_Team As String
        Dim strEditFunctionName_Team As String
        Dim blnEditAccess As Boolean
        Dim strSQL As String
        Dim blnViewAccess As Boolean
        Dim TeamParameters As String
        'End by SuchitraP

        Dim intCount As Integer
        Dim intRecordCount As Integer = 0

        Dim sbHtml As New System.Text.StringBuilder
        Dim sbHtmlLeft As New System.Text.StringBuilder
        Dim sbHtml_Left As New System.Text.StringBuilder
        Dim sbHtml_Right As New System.Text.StringBuilder
        Dim m_strTab As String


        Dim strAccessForEmp As IDataReader
        Dim strAccessSQL As String
        Dim PKToken_ProcedureID As String
        Dim strAttachments As String

        ''integrated by RohiniK on 03 Nov 09
        Dim strEditToMeValue As String = "0"
        Dim strcboDateFilter As String = "0"
        ''End of integratition by RohiniK on 03 Nov 09
        m_strTab = "HOME"

        'PlotUpperHeaderSection()
        If intCounter = 1 Then
            If intFromAjax = 1 Then
                intCurrentpageNumber = CommonFunction.General.CheckIsNothing(Request("PageNumber"), "0")
            End If
        Else
            intCurrentpageNumber = CommonFunction.General.CheckIsNothing(Request.Form("txtCurrentPage1"), "0")
        End If

        strIDColumn_Page = "ProcedureID"
        strTitleColumn_Page = "ProcedureTitle"
        strSPname_Page = "usp_Sel_tbl_KM_CodeHeadings "
        strEditFunctionName_Page = "Page_OnClick"

        If Not HttpContext.Current.Request.Form("txtSearch") Is Nothing Then
            strSearchText_Page = HttpContext.Current.Request.Form("txtSearch").Trim()
            strSearchText_Page = CommonFunctions.General.BuildQueryString(strSearchText_Page)
        ElseIf Not HttpContext.Current.Request.QueryString("txtSearch") Is Nothing Then
            strSearchText_Page = HttpContext.Current.Request.QueryString("txtSearch").Trim()
            strSearchText_Page = HttpContext.Current.Server.UrlDecode(strSearchText_Page)
            strSearchText_Page = CommonFunctions.General.BuildQueryString(strSearchText_Page)
        End If

        ''integrated by RohiniK on 03 Nov 09
        ''commented below stmt
        'sbHtml.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearchChar", "txtSearchChar", , , , CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("txtSearch")).Trim(), IsHidden:=True, returnHTML:=True))
        If Not HttpContext.Current.Request.Form("chkEditToMe") Is Nothing Then
            strEditToMeValue = HttpContext.Current.Request.Form("chkEditToMe")
        ElseIf Not HttpContext.Current.Request.QueryString("EditToMeValue") Is Nothing Then
            strEditToMeValue = HttpContext.Current.Request.QueryString("EditToMeValue")
        End If

        If Not HttpContext.Current.Request.Form("cboDateFilter") Is Nothing Then
            strcboDateFilter = HttpContext.Current.Request.Form("cboDateFilter")
        ElseIf Not HttpContext.Current.Request.QueryString("cboDateFilterValue") Is Nothing Then
            strcboDateFilter = HttpContext.Current.Request.QueryString("cboDateFilterValue")
        End If
        'Code Added by KapilK on 3-Aug-09 [Check nothing cond. added]
        If Not HttpContext.Current.Request.QueryString("txtSearch") Is Nothing Then
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            '    sbHtml.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearchChar", "txtSearchChar", , , , HttpContext.Current.Request.QueryString("txtSearch").Trim(), IsHidden:=True, returnHTML:=True))
            'Else
            '    sbHtml.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearchChar", "txtSearchChar", , , , , IsHidden:=True, returnHTML:=True))
            sbHtml.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearchChar", "txtSearchChar", , , , HttpContext.Current.Request.QueryString("txtSearch").Trim(), IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
        Else
            sbHtml.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearchChar", "txtSearchChar", , , , , IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))

            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        End If
        'End;Code Added by KapilK on 3-Aug-09 [Check nothing cond. added]

        ''End of integratition by RohiniK on 03 Nov 09
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        '' sbHtml.Append(CommonFunctions.HTMLControls.DrawTextBox("txtFromwhere", "txtFromwhere", , , , m_strFromWhere, IsHidden:=True, returnHTML:=True))
        sbHtml.Append(CommonFunctions.HTMLControls.DrawTextBox("txtFromwhere", "txtFromwhere", , , , m_strFromWhere, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding


        strSQL_Page = strSPname_Page & " "
        strSQL_Page = strSQL_Page & "-1," & HttpContext.Current.Session("intUserID").ToString & ",NULL,"

        If m_strTab.ToUpper = "MY" Then
            strSQL_Page = strSQL_Page & "1,"
        Else
            strSQL_Page = strSQL_Page & "0,"
        End If
        strSQL_Page = strSQL_Page & "N'" & strSearchText_Page & "'"

        If m_strTab.ToUpper = "EDIT" Then
            strSQL_Page = strSQL_Page & ",1"
        ElseIf m_strTab.ToUpper = "HOME" Then
            strSQL_Page = strSQL_Page & ",2"
        End If
        ''integrated by RohiniK on 03 Nov 09
        strSQL_Page = strSQL_Page & "," & strEditToMeValue
        If strcboDateFilter <> "" Then
            strSQL_Page = strSQL_Page & "," & strcboDateFilter
        End If
        ''End of integratition by RohiniK on 03 Nov 09

        PageParameters = PageParameters & " "
        PageParameters = PageParameters & HttpContext.Current.Session("intUserID").ToString & ",NULL,"

        If m_strTab.ToUpper = "MY" Then
            PageParameters = PageParameters & "1,"
        Else
            PageParameters = PageParameters & "0,"
        End If
        PageParameters = PageParameters & "N'" & strSearchText_Page & "'"

        If m_strTab.ToUpper = "EDIT" Then
            PageParameters = PageParameters & ",1"
        ElseIf m_strTab.ToUpper = "HOME" Then
            PageParameters = PageParameters & ",2"
        End If

        ''integrated by RohiniK on 03 Nov 09
        PageParameters = PageParameters & "," & strEditToMeValue
        If strcboDateFilter <> "" Then
            PageParameters = PageParameters & "," & strcboDateFilter
        End If
        ''End of integratition by RohiniK on 03 Nov 09

        'dsEntity_Page = CommonFunctions.Data.GetDataReader(strSQL_Page, True)
        dsEntity_Page = CommonFunction.Data.GetDataSet(strSQL_Page, "Page", (intCurrentpageNumber * intPageSize), intPageSize, True)

        drEntity_PageCount = CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_KM_CodeHeadings_Count " & PageParameters, True)

        Recordcount_Article = Math.Ceiling(drEntity_PageCount / 10)
        'sbHtml.Append("<BR>")
        ''ADDED BY nILESH G ON 29/12/2015
        sbHtml.Append("<DIV ID=divSearchMain style='OVERFLOW:auto;width:100%;'>")
        ''ENDED BY nILESH G ON 29/12/2015
        sbHtml.Append("<table id='SearchMain' CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Width='99.9%' >")
        sbHtml.Append("<TR>")

        sbHtml.Append("<TD align=center colspan=4 valign=top WIDTH=""100%"">")

        sbHtml.Append("<table id='HeaderTable' WIDTH=99.9% CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Class=""clsRoundedTableHeader"" >")
        sbHtml.Append("<tr>")
        sbHtml.Append("<td WIDTH=""14"" class=""clsTDTopLeftCorner"">  </td>")
        sbHtml.Append("<td  rowspan=""2"" valign=""middle""> ")
        sbHtml.Append("<table WIDTH=100% Class=""clsRoundedTableHeader"" ><tr><td align=""Left""><b>Articles</b>&nbsp;&nbsp;&nbsp;&nbsp;[" + drEntity_PageCount + "]</td>")

        sbHtml.Append("<td align='right'><img style='cursor:pointer;' align='middle' src='../../Images/NumNavPreviousEnable.gif' border=0 onclick='javascript:Previous_Onclick(1)'>")
        sbHtml.Append("<img style='cursor:pointer;' align='middle' src='../../Images/NumNavNextEnable.gif' border=0 onclick='javascript:Next_Onclick(1)'>")
        sbHtml.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a Class=""clsLinkControlMenu"" HREF=""Javascript:ShowHideGroup_Onclick(1)""><img id='imgGroup1'  SRC=""../../Images/MoveUp.GIF"" BORDER=""0"" ALT=""..."" width=""14"" height=""14""></a></td></tr></table>")
        sbHtml.Append("<br>")
        sbHtml.Append("</td>")

        sbHtml.Append("<td WIDTH=""14"" class=""clsTDTopRightCorner"">  </td>")
        sbHtml.Append("</tr>")
        sbHtml.Append("<tr>")
        sbHtml.Append("<td>&nbsp;&nbsp;</td>")
        sbHtml.Append("<td>&nbsp;&nbsp;</td>")
        sbHtml.Append("</tr>")
        sbHtml.Append("</table>")
        sbHtml.Append("<table  id=tblGroup1 WIDTH=100% CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Class=""clsRoundedTableMenu"">")

        'While dsEntity_Page.Read
        For Each objDr As DataRow In dsEntity_Page.Tables(0).Rows
            intCount = intCount + 1

            If intCount = 1 Or intCount = 3 Or intCount = 5 Or intCount = 7 Or intCount = 9 Then
                sbHtml_Left.Remove(0, sbHtml_Left.Length)
                sbHtml.Append("<tr class=""clsTRControlMenu"">")
            End If

            ''sbHtml.Append("<td valign=top width=20>")
            ''sbHtml.Append("<img src='..\..\Images\Discussions.gif' vspace=1 border=0></a>")
            'sbHtml.Append("<td valign=top width=100%><font fontFamily:'Verdana, Arial'; size='1'>")
            'sbHtml.Append("<a HREF=""Javascript:Page_OnClick(" + dsEntity_Page("ProcedureID").ToString + ",'View')"">")
            'sbHtml.Append(dsEntity_Page("ProcedureTitle").ToString)
            'sbHtml.Append("</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            'sbHtml.Append("</font>")

            'sbHtml.Append("</td>")
            'sbHtml.Append("<td valign='top' align='right'>")
            'sbHtml.Append("</td>")
            'sbHtml.Append("</tr>")

            If intCount = 1 Or intCount = 3 Or intCount = 5 Or intCount = 7 Or intCount = 9 Then
                'To show edit link if user has edit access as well as user is a creator
                strQuery = ""
                strEditAccess = ""
                strProgrammerID = ""
                PKToken_ProcedureID = ""
                strAttachments = ""

                strQuery = "usp_Get_EditAccess " + objDr("ProcedureID").ToString + "," + HttpContext.Current.Session("intUserID").ToString
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
                'Commented and Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
                'PKToken_ProcedureID = CommonFunctions.Security.Token.GetToken(CType(objDr("ProcedureID"), String))
                PKToken_ProcedureID = CommonFunctions.Security.Token.GetToken(CType(objDr("ProcedureID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0")
                'End Of Commented and Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
                strAttachments = CommonFunction.Data.GetDataScalar("IF EXISTS(SELECT ProcedureID FROM tbl_KM_Attachments WHERE ProcedureID = " + objDr("ProcedureID").ToString + ") SELECT 1", True)

                sbHtml_Left.Append("<td align=left width=40% style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>")
                If strAttachments = "1" Then
                    sbHtml_Left.Append("<A title='Attachment' href=""JavaScript:Document_OnClick('" + objDr("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img title='Attachment' border=0 src='../../Images/Attachment1.gif'></A>&nbsp;")
                    'Commented and Modified by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0
                    'sbHtml_Left.Append("<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + objDr("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'></A>&nbsp;")
                    If Trim(objDr("NoOfDiscussions").ToString & "") <> "" And Trim(objDr("NoOfDiscussions").ToString & "") <> "0" Then
                        sbHtml_Left.Append("<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + objDr("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'>(" + objDr("NoOfDiscussions").ToString + ")</A>&nbsp;")
                    Else
                        sbHtml_Left.Append("<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + objDr("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'></A>&nbsp;")
                    End If
                    'End of Comment and Modification by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0

                Else
                    'Commented and Modified by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0
                    'sbHtml_Left.Append("<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + objDr("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'></A>&nbsp;")
                    If Trim(objDr("NoOfDiscussions").ToString & "") <> "" And Trim(objDr("NoOfDiscussions").ToString & "") <> "0" Then
                        sbHtml_Left.Append("<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + objDr("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'>(" + objDr("NoOfDiscussions").ToString + ")</A>&nbsp;")
                    Else
                        sbHtml_Left.Append("<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + objDr("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'></A>&nbsp;")
                    End If
                    'End of Comment and Modification by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0

                End If

                If strEditAccess = "1" Or strProgrammerID = HttpContext.Current.Session("intUserID").ToString Then
                    sbHtml_Left.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:ArticleEdit_OnClick(" + objDr("ProcedureID").ToString + ",'Edit','Search')"">")
                Else
                    sbHtml_Left.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:ArticleEdit_OnClick(" + objDr("ProcedureID").ToString + ",'View','Search')"">")
                End If

                sbHtml_Left.Append("<b>" + HttpUtility.HtmlEncode(objDr("ProcedureTitle").ToString) + "</b>") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                sbHtml_Left.Append("</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
                'sbHtml_Left.Append("</font>")
                'sbHtml_Left.Append("</td>")

                strRating = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT AVG(Rating) AS Rating FROM tbl_KM_ArticleRating WHERE ProcedureID=" + objDr("ProcedureID").ToString, True), "")

                If strRating.LastIndexOf(".") <> "-1" Then
                    strRatingNew = strRating.Substring(0, strRating.LastIndexOf("."))
                Else
                    strRatingNew = strRating
                End If

                sbHtml_Left.Append("<BR>")
                drSynopsis = CommonFunction.Data.GetDataReader("SELECT Synopsis,EmployeeName FROM tbl_KM_CodeHeadings INNER JOIN tbl_PM_Employee ON tbl_KM_CodeHeadings.ProgrammerID = tbl_PM_Employee.EmployeeID WHERE ProcedureID=" + objDr("ProcedureID").ToString, True)
                If drSynopsis.Read Then
                    sbHtml_Left.Append("Author : " + drSynopsis("EmployeeName").ToString)
                    sbHtml_Left.Append("<BR>")
                    If drSynopsis("Synopsis").ToString.Length > 50 Then
                        sbHtml_Left.Append(HttpUtility.HtmlEncode(Left(drSynopsis("Synopsis").ToString, 150)) + "....") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                    Else
                        sbHtml_Left.Append(HttpUtility.HtmlEncode(drSynopsis("Synopsis").ToString)) 'HtmlEncode Added By Vaijat K ON 20/11/2015
                    End If
                End If
                CommonFunction.Data.DisposeDataReader(drSynopsis)

                sbHtml_Left.Append("</td><td valign=top align=center width=9%>")

                If strRating <> "" Then
                    For counter = 0 To 5
                        If CType(strRatingNew, Integer) <> counter Then
                            'sbHtml_Left.Append("<TD style='width:1%;' align=left>")
                            sbHtml_Left.Append("<img id='imgstaron'  SRC=""../../Images/star_on.gif"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                            'sbHtml_Left.Append("</TD>")
                        Else
                            tempRating = CType(strRating, Double) - CType(strRatingNew, Double)
                            If tempRating < 0.5 And tempRating <> 0.0 Then
                                sbHtml_Left.Append("<img id='imgstaron'  SRC=""../../Images/starl5.GIF"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                            ElseIf tempRating = 0.5 Then
                                sbHtml_Left.Append("<img id='imgstaron'  SRC=""../../Images/stare5.GIF"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                            ElseIf tempRating > 0.5 Then
                                sbHtml_Left.Append("<img id='imgstaron'  SRC=""../../Images/starg5.GIF"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                            ElseIf tempRating = 0.0 And CType(strRating, Double) <> 5.0 Then
                                sbHtml_Left.Append("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                            End If
                            flag = strRatingNew + 2
                            Exit For
                        End If
                    Next

                    For counter = flag To 5
                        'sbHtml_Left.Append("<TD style='width:1%;' align=left>")
                        sbHtml_Left.Append("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                        'sbHtml_Left.Append("</TD>")
                    Next
                Else
                    For counter = 0 To 4
                        sbHtml_Left.Append("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                    Next
                End If

                'sbHtml_Left.Append("</td><td valign=top align=left  width=7%>")

                If strEditAccess = "1" Or strProgrammerID = HttpContext.Current.Session("intUserID").ToString Then
                    'sbHtml_Left.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=""Javascript:Edit_OnClick(" + dsEntity_Page("ProcedureID").ToString + ",'Edit','Search')""><font style=""color:Blue"">[edit]</font></a></td>")
                    'sbHtml_Left.Append("&nbsp;&nbsp;<a href=""Javascript:ArticleEdit_OnClick(" + dsEntity_Page("ProcedureID").ToString + ",'Edit','Search')""><img src='../../Images/Home/maximize.gif' border='0' alt='Max' /></a>&nbsp;&nbsp;")
                    sbHtml_Left.Append("&nbsp;&nbsp;<a  style='text-decoration:none' href=""Javascript:ArticleEdit_OnClick(" + objDr("ProcedureID").ToString + ",'Edit','Search')""><img src='../../Images/Home/maximize.gif'  border='0'  alt='Max' /></a>&nbsp;&nbsp;")
                Else
                    'sbHtml_Left.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=""Javascript:Edit_OnClick(" + dsEntity_Page("ProcedureID").ToString + ",'view','Search')""><font style=""color:Blue"">[view]</font></a></td>")
                    sbHtml_Left.Append("&nbsp;&nbsp;<a   style='text-decoration:none' href=""Javascript:ArticleEdit_OnClick(" + objDr("ProcedureID").ToString + ",'view','Search')""><img src='../../Images/Home/maximize.gif'   border='0' alt='Max' /></a>&nbsp;&nbsp;")
                End If
                sbHtml_Left.Append("</td>")
                'End to show edit link if user has edit access as well as user is a creator 
                sbHtml.Append(sbHtml_Left.ToString)
            ElseIf intCount = 2 Or intCount = 4 Or intCount = 6 Or intCount = 8 Or intCount = 10 Then

                'To show edit link if user has edit access as well as user is a creator
                strQuery = ""
                strEditAccess = ""
                strProgrammerID = ""
                PKToken_ProcedureID = ""
                strAttachments = ""

                strQuery = "usp_Get_EditAccess " + objDr("ProcedureID").ToString + "," + HttpContext.Current.Session("intUserID").ToString
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

                'Commented and Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
                'PKToken_ProcedureID = CommonFunctions.Security.Token.GetToken(CType(objDr("ProcedureID"), String))
                PKToken_ProcedureID = CommonFunctions.Security.Token.GetToken(CType(objDr("ProcedureID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0")
                'End of Commented and Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation

                strAttachments = CommonFunction.Data.GetDataScalar("IF EXISTS(SELECT ProcedureID FROM tbl_KM_Attachments WHERE ProcedureID = " + objDr("ProcedureID").ToString + ") SELECT 1", True)

                sbHtml_Right.Append("<td align=left width=40% style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>")
                If strAttachments = "1" Then
                    sbHtml_Right.Append("<A title='Attachment' href=""JavaScript:Document_OnClick('" + objDr("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img title='Attachment' border=0 src='../../Images/Attachment1.gif'></A>&nbsp;")

                    'Commented and Modified by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0
                    'sbHtml_Right.Append("<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + objDr("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'></A>&nbsp;")
                    If Trim(objDr("NoOfDiscussions").ToString & "") <> "" And Trim(objDr("NoOfDiscussions").ToString & "") <> "0" Then
                        sbHtml_Right.Append("<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + objDr("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'>(" + objDr("NoOfDiscussions").ToString + ")</A>&nbsp;")
                    Else
                        sbHtml_Right.Append("<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + objDr("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'></A>&nbsp;")
                    End If
                    'End of Comment and Modification by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0
                Else
                    'Commented and Modified by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0
                    'sbHtml_Right.Append("<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + objDr("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'></A>&nbsp;")
                    If Trim(objDr("NoOfDiscussions").ToString & "") <> "" And Trim(objDr("NoOfDiscussions").ToString & "") <> "0" Then
                        sbHtml_Right.Append("<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + objDr("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'>(" + objDr("NoOfDiscussions").ToString + ")</A>&nbsp;")
                    Else
                        sbHtml_Right.Append("<A title='Discussion' href=""JavaScript:ShowDiscussions_OnClick('" + objDr("ProcedureID").ToString + "','" + PKToken_ProcedureID + "')""><img border=0  src='../../Images/Discussions1.gif'></A>&nbsp;")
                    End If
                    'End of Comment and Modification by AbhijeetC on 10 Nov 2009 for Whizible SEM 9.0
                End If

                If strEditAccess = "1" Or strProgrammerID = HttpContext.Current.Session("intUserID").ToString Then
                    sbHtml_Right.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:ArticleEdit_OnClick(" + objDr("ProcedureID").ToString + ",'Edit','Search')"">")
                Else
                    sbHtml_Right.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:ArticleEdit_OnClick(" + objDr("ProcedureID").ToString + ",'View','Search')"">")
                End If

                sbHtml_Right.Append("<b>" + HttpUtility.HtmlEncode(objDr("ProcedureTitle").ToString) + "</b>") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                sbHtml_Right.Append("</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
                'sbHtml_Right.Append("</font>")
                'sbHtml_Right.Append("</td>")

                strRating = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT AVG(Rating) AS Rating FROM tbl_KM_ArticleRating WHERE ProcedureID=" + objDr("ProcedureID").ToString, True), "")

                If strRating.LastIndexOf(".") <> "-1" Then
                    strRatingNew = strRating.Substring(0, strRating.LastIndexOf("."))
                Else
                    strRatingNew = strRating
                End If

                sbHtml_Right.Append("<BR>")
                drSynopsis = CommonFunction.Data.GetDataReader("SELECT Synopsis,EmployeeName FROM tbl_KM_CodeHeadings INNER JOIN tbl_PM_Employee ON tbl_KM_CodeHeadings.ProgrammerID = tbl_PM_Employee.EmployeeID WHERE ProcedureID=" + objDr("ProcedureID").ToString, True)
                If drSynopsis.Read Then
                    sbHtml_Right.Append("Author : " + drSynopsis("EmployeeName").ToString)
                    sbHtml_Right.Append("<BR>")
                    If drSynopsis("Synopsis").ToString.Length > 50 Then
                        sbHtml_Right.Append(HttpUtility.HtmlEncode(Left(drSynopsis("Synopsis").ToString, 150)) + "....") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                    Else
                        sbHtml_Right.Append(HttpUtility.HtmlEncode(drSynopsis("Synopsis").ToString)) 'HtmlEncode Added By Vaijat K ON 20/11/2015
                    End If
                End If
                CommonFunction.Data.DisposeDataReader(drSynopsis)

                sbHtml_Right.Append("</td><td valign=top align=center width=9%>")

                If strRating <> "" Then
                    For counter = 0 To 5
                        If CType(strRatingNew, Integer) <> counter Then
                            'sbHtml_Right.Append("<TD style='width:1%;' align=left>")
                            sbHtml_Right.Append("<img id='img1'  SRC=""../../Images/star_on.gif"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                            'sbHtml_Right.Append("</TD>")
                        Else
                            tempRating = CType(strRating, Double) - CType(strRatingNew, Double)
                            If tempRating < 0.5 And tempRating <> 0.0 Then
                                sbHtml_Right.Append("<img id='imgstaron'  SRC=""../../Images/starl5.GIF"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                            ElseIf tempRating = 0.5 Then
                                sbHtml_Right.Append("<img id='imgstaron'  SRC=""../../Images/stare5.GIF"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                            ElseIf tempRating > 0.5 Then
                                sbHtml_Right.Append("<img id='imgstaron'  SRC=""../../Images/starg5.GIF"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                            ElseIf tempRating = 0.0 And CType(strRating, Double) <> 5.0 Then
                                sbHtml_Right.Append("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                            End If
                            flag = strRatingNew + 2
                            Exit For
                        End If
                    Next

                    For counter = flag To 5
                        'sbHtml_Right.Append("<TD style='width:1%;' align=left>")
                        sbHtml_Right.Append("<img id='img2'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                        'sbHtml_Right.Append("</TD>")
                    Next
                Else
                    For counter = 0 To 4
                        sbHtml_Right.Append("<img id='imgstaroff'  SRC=""../../Images/star_off.gif"" BORDER=""0""  width=""10"" height=""10"">&nbsp;&nbsp;")
                    Next
                End If

                'sbHtml_Right.Append("</td><td valign=top align=left width=7%>")

                If strEditAccess = "1" Or strProgrammerID = HttpContext.Current.Session("intUserID").ToString Then
                    'sbHtml_Right.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=""Javascript:Edit_OnClick(" + dsEntity_Page("ProcedureID").ToString + ",'Edit','Search')""><font style=""color:Blue"">[edit]</font></a></td>")
                    'sbHtml_Right.Append("&nbsp;&nbsp;<a href=""Javascript:ArticleEdit_OnClick(" + dsEntity_Page("ProcedureID").ToString + ",'Edit','Search')""><img src='../../Images/Home/maximize.gif' border='0' alt='Max' /></a>&nbsp;&nbsp;")
                    sbHtml_Right.Append("&nbsp;&nbsp;<a   style='text-decoration:none' href=""Javascript:ArticleEdit_OnClick(" + objDr("ProcedureID").ToString + ",'Edit','Search')""><img src='../../Images/Home/maximize.gif'  border='0' alt='Max' /></a>&nbsp;&nbsp;")
                Else
                    'sbHtml_Right.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=""Javascript:Edit_OnClick(" + dsEntity_Page("ProcedureID").ToString + ",'view','Search')""><font style=""color:Blue"">[view]</font></a></td>")
                    sbHtml_Right.Append("&nbsp;&nbsp;<a  style='text-decoration:none'  href=""Javascript:ArticleEdit_OnClick(" + objDr("ProcedureID").ToString + ",'view','Search')""><img src='../../Images/Home/maximize.gif'  border='0' alt='Max' /></a>&nbsp;&nbsp;")
                End If
                sbHtml_Right.Append("</td>")
                'End to show edit link if user has edit access as well as user is a creator 
                sbHtml.Append(sbHtml_Right.ToString)

            End If

            If intCount = 2 Or intCount = 4 Or intCount = 6 Or intCount = 8 Or intCount = 10 Then
                sbHtml_Right.Remove(0, sbHtml_Right.Length)
                sbHtml.Append("</tr>")

            End If

            'If intCount >= 10 Then
            '    Exit For
            'End If
        Next

        ''CommonFunction.Data.DisposeDataReader(dsEntity_Page)

        ''If intCount >= 10 Then
        ''    sbHtml.Append("<tr class=""clsTRControlMenu"">")
        ''    sbHtml.Append("<td align=right colspan=3>")
        ''    sbHtml.Append("&nbsp;&nbsp;<a HREF=""Javascript:ShowDetailsHome_Onclick(1)""> <font color='blue' style='font-size:10px'>More Articles...</font>")
        ''    sbHtml.Append("</a>&nbsp;&nbsp;&nbsp;&nbsp;</td>")
        ''    sbHtml.Append("</tr>")
        ''Else
        If intCount = 0 Then
            sbHtml.Append("<tr class=""clsTRControlMenu"">")
            sbHtml.Append("<td align=center colspan=3 style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>")
            If intCount = 0 Then
                sbHtml.Append("There are no items to show in this view...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
            End If
            sbHtml.Append("</TD></tr>")
        End If

        sbHtml.Append(" <tr>")
        sbHtml.Append("<td  class=""clsTDBottomLeftCorner"">  </td>")
        sbHtml.Append("<td WIDTH=" & (400 - 28).ToString & " ></td>")
        sbHtml.Append("<td></td><td class=""clsTDBottomRightCorner""></td>")
        sbHtml.Append("</tr>")
        sbHtml.Append("</table>")


        sbHtml.Append("</TD>")
        sbHtml.Append("<td WIDTH=""2%""></td>")
        sbHtml.Append("</tr>")
        sbHtml.Append("<tr><td align=left colspan=4 valign=top WIDTH=""100%"">&nbsp;</td></tr> ")
        sbHtml.Append("<tr>")

        If intCounter = 2 Then
            If intFromAjax = 1 Then
                intCurrentpageNumber = CommonFunction.General.CheckIsNothing(Request("PageNumber"), "0")
            End If
        Else
            intCurrentpageNumber = CommonFunction.General.CheckIsNothing(Request.Form("txtCurrentPage2"), "0")
        End If

        'Space
        intCount = 0
        strIDColumn_Space = "SpaceID"
        strTitleColumn_Space = "SpaceName"
        strSPname_Space = "usp_Sel_tbl_KM_Space"
        strEditFunctionName_Space = "Space_OnClick"

        If Not HttpContext.Current.Request.Form("txtSearch") Is Nothing Then
            strSearchText_Space = HttpContext.Current.Request.Form("txtSearch").Trim()
            strSearchText_Space = CommonFunctions.General.BuildQueryString(strSearchText_Space)
        ElseIf Not HttpContext.Current.Request.QueryString("txtSearch") Is Nothing Then
            strSearchText_Space = HttpContext.Current.Request.QueryString("txtSearch").Trim()
            strSearchText_Space = HttpContext.Current.Server.UrlDecode(strSearchText_Space)
            strSearchText_Space = CommonFunctions.General.BuildQueryString(strSearchText_Space)
        End If

        strSQL_Space = strSPname_Space & " "
        strSQL_Space = strSQL_Space & "-1," & HttpContext.Current.Session("intUserID").ToString & ",NULL,"

        If m_strTab.ToUpper = "MY" Then
            strSQL_Space = strSQL_Space & "1,"
        Else
            strSQL_Space = strSQL_Space & "0,"
        End If
        strSQL_Space = strSQL_Space & "N'" & strSearchText_Space & "'"

        If m_strTab.ToUpper = "EDIT" Then
            strSQL_Space = strSQL_Space & ",1"
        ElseIf m_strTab.ToUpper = "HOME" Then
            strSQL_Space = strSQL_Space & ",2"
        End If
        ''integrated by RohiniK on 03 Nov 09
        strSQL_Space = strSQL_Space & "," & strEditToMeValue
        If strcboDateFilter <> "" Then
            strSQL_Space = strSQL_Space & "," & strcboDateFilter
        End If

        ''End of integratition by RohiniK on 03 Nov 09

        SpaceParameters = SpaceParameters & " "
        SpaceParameters = SpaceParameters & HttpContext.Current.Session("intUserID").ToString & ",NULL,"

        If m_strTab.ToUpper = "MY" Then
            SpaceParameters = SpaceParameters & "1,"
        Else
            SpaceParameters = SpaceParameters & "0,"
        End If
        SpaceParameters = SpaceParameters & "N'" & strSearchText_Space & "'"

        If m_strTab.ToUpper = "EDIT" Then
            SpaceParameters = SpaceParameters & ",1"
        ElseIf m_strTab.ToUpper = "HOME" Then
            SpaceParameters = SpaceParameters & ",2"
        End If

        ''integrated by RohiniK on 03 Nov 09
        SpaceParameters = SpaceParameters & "," & strEditToMeValue
        If strcboDateFilter <> "" Then
            SpaceParameters = SpaceParameters & "," & strcboDateFilter
        End If
        ''End of integratition by RohiniK on 03 Nov 09

        sbHtml.Append("<TD align=center valign=top WIDTH=""49%"">")

        'dsEntity_Space = CommonFunctions.Data.GetDataReader(strSQL_Space, True)
        dsEntity_Space = CommonFunction.Data.GetDataSet(strSQL_Space, "Space", (intCurrentpageNumber * intPageSize), intPageSize, True)

        drEntity_SpaceCount = CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_KM_Space_Count " & SpaceParameters, True)

        Recordcount_Space = Math.Ceiling(drEntity_SpaceCount / 10)

        sbHtml.Append("<table id='HeaderTable' WIDTH=99.9% CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Class=""clsRoundedTableHeader"" >")
        sbHtml.Append("<tr>")
        sbHtml.Append("<td WIDTH=""14"" class=""clsTDTopLeftCorner"">  </td>")
        sbHtml.Append("<td  rowspan=""2"" valign=""middle""> ")
        sbHtml.Append("<table WIDTH=100% Class=""clsRoundedTableHeader"" ><tr><td align=""Left""><b>Spaces</b>&nbsp;&nbsp;&nbsp;&nbsp;[" + drEntity_SpaceCount + "]</td>")
        sbHtml.Append("<td align='right'><img style='cursor:pointer;' align='middle' src='../../Images/NumNavPreviousEnable.gif' border=0 onclick='javascript:Previous_Onclick(2)'>")
        sbHtml.Append("<img style='cursor:pointer;' align='middle' src='../../Images/NumNavNextEnable.gif' border=0 onclick='javascript:Next_Onclick(2)'>")
        sbHtml.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a Class=""clsLinkControlMenu"" HREF=""Javascript:ShowHideGroup_Onclick(2)""><img id='imgGroup2'  SRC=""../../Images/MoveUp.GIF"" BORDER=""0"" ALT=""..."" width=""14"" height=""14""></a></td></tr></table>")
        sbHtml.Append("<br>")
        sbHtml.Append("</td>")

        sbHtml.Append("<td WIDTH=""14"" class=""clsTDTopRightCorner"">  </td>")
        sbHtml.Append("</tr>")
        sbHtml.Append("<tr>")
        sbHtml.Append("<td>&nbsp;&nbsp;</td>")
        sbHtml.Append("<td>&nbsp;&nbsp;</td>")
        sbHtml.Append("</tr>")
        sbHtml.Append("</table>")
        sbHtml.Append("<table  id=tblGroup2 WIDTH=100% CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Class=""clsRoundedTableMenu"">")

        'While dsEntity_Space.Read
        For Each objDr As DataRow In dsEntity_Space.Tables(0).Rows
            sbHtml.Append("<tr class=""clsTRControlMenu"">")
            'sbHtml.Append("<td valign=top width=20>")
            'sbHtml.Append("<img src='..\..\Images\spaces1.gif' vspace=1 border=0></a></td>")
            sbHtml.Append("<td valign=top width=75% style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>")
            sbHtml.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:Space_OnClick(" + objDr("SpaceID").ToString + ",'View','" + m_strFromWhere + "')"">")
            sbHtml.Append("<b>" + HttpUtility.HtmlEncode(objDr("SpaceName").ToString) + "</b>") 'HtmlEncode Added By Vaijat K ON 20/11/2015
            sbHtml.Append("</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            'sbHtml.Append("</font>")
            PageCount = CommonFunction.Data.GetDataScalar("SELECT Count(2) FROM tbl_KM_SpacePages WHERE SpaceID=" + objDr("SpaceID").ToString, True) '+ " AND AddedBy=(Select UserName FROM tbl_PM_Employee WHERE EmployeeID=" + HttpContext.Current.Session("intUserID").ToString + ")", True)
            'submitter = CommonFunction.Data.GetDataScalar("Select UserName FROM tbl_KM_Space INNER JOIN  tbl_PM_Employee ON AuthorID=EmployeeID WHERE SpaceID=" + dsEntity_Space("SpaceID").ToString, True)
            sbHtml.Append("<br>")
            If objDr("SpaceDescription").ToString.Length > 50 Then
                sbHtml.Append(HttpUtility.HtmlEncode(Left(objDr("SpaceDescription").ToString, 150)) + "....") 'HtmlEncode Added By Vaijat K ON 20/11/2015
            Else
                sbHtml.Append(HttpUtility.HtmlEncode(objDr("SpaceDescription"))) 'HtmlEncode Added By Vaijat K ON 20/11/2015
            End If
            sbHtml.Append("</td><td valign=top nowrap width=25% style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'> No.Of Articles(" + PageCount + ")&nbsp;&nbsp;&nbsp;&nbsp;")
            sbHtml.Append("</td>")


            strQuery = ""
            strEditAccess = ""
            strProgrammerID = ""

            strQuery = "usp_Get_EditAccess_Space " + objDr("SpaceID").ToString + "," + HttpContext.Current.Session("intUserID").ToString
            drEditAccess = CommonFunction.Data.GetDataReader(strQuery, True)
            If drEditAccess.Read() Then
                strEditAccess = drEditAccess("IsPresent").ToString
            End If

            If drEditAccess.NextResult() Then
                If drEditAccess.Read() Then
                    strProgrammerID = drEditAccess("AuthorID").ToString
                End If
            End If

            If strEditAccess = "1" Or strProgrammerID = HttpContext.Current.Session("intUserID").ToString Then
                sbHtml.Append("<td valign='top' align='right'><a HREF=""Javascript:Space_OnClick(" + objDr("SpaceID").ToString + ",'View','" + m_strFromWhere + "')"" ><img src='../../Images/Home/maximize.gif' border='0' alt='Max' /></a><br>")
            Else
                sbHtml.Append("<td valign='top' align='right'><a  style='text-decoration:none' HREF=""Javascript:Space_OnClick(" + objDr("SpaceID").ToString + ",'View','" + m_strFromWhere + "')"" ><img src='../../Images/Home/maximize.gif'  border='0'  alt='Max' /></a><br>")
            End If


            'sbHtml.Append("<td valign='top' align='right'><a href=""Javascript:Space_OnClick(" + dsEntity_Space("SpaceID").ToString + ",'View','" + m_strFromWhere + "')""><font style=""color:Blue"">[view]</font></a>")
            sbHtml.Append("</td>")
            sbHtml.Append("</tr>")
            intCount = intCount + 1
            ''If intCount >= 10 Then
            ''    Exit While
            ''End If
            CommonFunction.Data.DisposeDataReader(drEditAccess)
        Next

        'CommonFunction.Data.DisposeDataReader(dsEntity_Space)


        ''If intCount >= 10 Then
        ''    sbHtml.Append("<tr class=""clsTRControlMenu"">")
        ''    sbHtml.Append("<td align=right colspan=3>")
        ''    sbHtml.Append("&nbsp;&nbsp;<a HREF=""Javascript:ShowDetailsHome_Onclick(2)""> <font color='blue' style='font-size:10px'>More Spaces...</font>")
        ''    sbHtml.Append("</a>&nbsp;&nbsp;&nbsp;&nbsp;</td>")
        ''    sbHtml.Append("</tr>")
        ''Else
        If intCount = 0 Then
            sbHtml.Append("<tr class=""clsTRControlMenu"">")
            sbHtml.Append("<td align=center colspan=3 style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>")
            If intCount = 0 Then
                sbHtml.Append("There are no items to show in this view...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
            End If
            sbHtml.Append("</TD></tr>")
        End If

        sbHtml.Append(" <tr>")
        sbHtml.Append("<td  class=""clsTDBottomLeftCorner"">  </td>")
        sbHtml.Append("<td WIDTH=" & (400 - 28).ToString & " ></td>")
        sbHtml.Append("<td></td><td class=""clsTDBottomRightCorner""></td>")
        sbHtml.Append("</tr>")
        sbHtml.Append("</table>")



        sbHtml.Append("</TD>")
        sbHtml.Append("<td>&nbsp;&nbsp;</td>")
        sbHtml.Append(" <td>&nbsp;&nbsp;</td>")
        'sbHtml.Append("</tr>")

        If intCounter = 3 Then
            If intFromAjax = 1 Then
                intCurrentpageNumber = CommonFunction.General.CheckIsNothing(Request("PageNumber"), "0")
            End If
        Else
            intCurrentpageNumber = CommonFunction.General.CheckIsNothing(Request.Form("txtCurrentPage3"), "0")
        End If

        'Added by SuchitraP on 1-Oct-2008 to display team on search page
        intCount = 0
        strIDColumn_Team = "TeamID"
        strTitleColumn_Team = "TeamName"
        strSPname_Team = "usp_Sel_tbl_KM_Team"
        strEditFunctionName_Team = "Edit_TeamDetails"

        If Not HttpContext.Current.Request.Form("txtSearch") Is Nothing Then
            strSearchText_Team = HttpContext.Current.Request.Form("txtSearch").Trim()
            strSearchText_Team = CommonFunctions.General.BuildQueryString(strSearchText_Team)
        ElseIf Not HttpContext.Current.Request.QueryString("txtSearch") Is Nothing Then
            strSearchText_Team = HttpContext.Current.Request.QueryString("txtSearch").Trim()
            strSearchText_Team = HttpContext.Current.Server.UrlDecode(strSearchText_Team)
            strSearchText_Team = CommonFunctions.General.BuildQueryString(strSearchText_Team)
        End If


        ''integrated by RohiniK on 03 Nov 09
        ''commented below stmt
        ' sbHtml.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearchChar", "txtSearchChar", , , , CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("txtSearch")).Trim(), IsHidden:=True, returnHTML:=True))
        'Code Added by KapilK on 3-Aug-09 [Check nothing cond. added]
        If Not HttpContext.Current.Request("txtSearch") Is Nothing Then
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            '    sbHtml.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearchChar", "txtSearchChar", , , , HttpContext.Current.Request("txtSearch").Trim(), IsHidden:=True, returnHTML:=True))
            'Else
            '    sbHtml.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearchChar", "txtSearchChar", , , , , IsHidden:=True, returnHTML:=True))
            sbHtml.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearchChar", "txtSearchChar", , , , HttpContext.Current.Request("txtSearch").Trim(), IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
        Else
            sbHtml.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearchChar", "txtSearchChar", , , , , IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))

            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        End If
        'End;Code Added by KapilK on 3-Aug-09 [Check nothing cond. added]

        ''End of integratition by RohiniK on 03 Nov 09

        strSQL_Team = strSPname_Team & " "
        strSQL_Team = strSQL_Team & "-1," & HttpContext.Current.Session("intUserID").ToString & ",NULL,"

        If m_strTab.ToUpper = "MY" Then
            strSQL_Team = strSQL_Team & "1,"
        Else
            strSQL_Team = strSQL_Team & "0,"
        End If
        strSQL_Team = strSQL_Team & "N'" & strSearchText_Team & "'"

        'Uncommented by SuchitraP for IssueID : 30052
        If m_strTab.ToUpper = "EDIT" Then
            strSQL_Team = strSQL_Team & ",1"
        ElseIf m_strTab.ToUpper = "HOME" Then
            strSQL_Team = strSQL_Team & ",2"
        End If
        'End by SuchitraP

        ''integrated by RohiniK on 03 Nov 09
        strSQL_Team = strSQL_Team & "," & strEditToMeValue
        If strcboDateFilter <> "" Then
            strSQL_Team = strSQL_Team & "," & strcboDateFilter
        End If

        ''End of integratition by RohiniK on 03 Nov 09
        'Commented by SuchitraP for IssueID : 30052
        'strSQL_Team = strSQL_Team & ",'null'"
        'End of comment by SuchitraP

        TeamParameters = TeamParameters & " "
        TeamParameters = TeamParameters & HttpContext.Current.Session("intUserID").ToString & ",NULL,"

        If m_strTab.ToUpper = "MY" Then
            TeamParameters = TeamParameters & "1,"
        Else
            TeamParameters = TeamParameters & "0,"
        End If
        TeamParameters = TeamParameters & "N'" & strSearchText_Team & "'"

        'Commented And Added by Usha Pandit On 23.05.2020 For getting correct Team count
        'TeamParameters = TeamParameters & ",'null'"
        If m_strTab.ToUpper = "EDIT" Then
            TeamParameters = TeamParameters & ",1"
        ElseIf m_strTab.ToUpper = "HOME" Then
            TeamParameters = TeamParameters & ",2"
        End If
        'End Of Added by Usha Pandit On 23.05.2020 For getting correct Team count

        ''integrated by RohiniK on 03 Nov 09
        TeamParameters = TeamParameters & "," & strEditToMeValue
        If strcboDateFilter <> "" Then
            TeamParameters = TeamParameters & "," & strcboDateFilter
        End If
        ''End of integratition by RohiniK on 03 Nov 09
        'dsEntity_Team = CommonFunctions.Data.GetDataReader(strSQL_Team, True)
        dsEntity_Team = CommonFunction.Data.GetDataSet(strSQL_Team, "Team", (intCurrentpageNumber * intPageSize), intPageSize, True)
        'sbHtml.Append("<TR><TD align=center valign=top WIDTH=""49%"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD></TR>")
        'sbHtml.Append("<TR>")

        drEntity_TeamCount = CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_KM_Team_Count" & TeamParameters, True)

        Recordcount_Team = Math.Ceiling(drEntity_TeamCount / 10)

        sbHtml.Append("<TD align=center valign=top WIDTH=""49%"">")
        sbHtml.Append("<table id='HeaderTable' WIDTH=99.9% CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Class=""clsRoundedTableHeader"" >")
        sbHtml.Append("<tr>")
        sbHtml.Append("<td WIDTH=""14"" class=""clsTDTopLeftCorner"">  </td>")
        sbHtml.Append("<td  rowspan=""2"" valign=""middle""> ")
        sbHtml.Append("<table WIDTH=100% Class=""clsRoundedTableHeader"" ><tr><td align=""Left""><b>Teams</b>&nbsp;&nbsp;&nbsp;&nbsp;[" + drEntity_TeamCount + "]</td>")
        sbHtml.Append("<td align='right'><img style='cursor:pointer;' align='middle' src='../../Images/NumNavPreviousEnable.gif' border=0 onclick='javascript:Previous_Onclick(3)'>")
        sbHtml.Append("<img style='cursor:pointer;' align='middle' src='../../Images/NumNavNextEnable.gif' border=0 onclick='javascript:Next_Onclick(3)'>")
        sbHtml.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a Class=""clsLinkControlMenu"" HREF=""Javascript:ShowHideGroup_Onclick(3)""><img id='imgGroup3'  SRC=""../../Images/MoveUp.GIF"" BORDER=""0"" ALT=""..."" width=""14"" height=""14""></a></td></tr></table>")
        sbHtml.Append("<br>")
        sbHtml.Append("</td>")

        sbHtml.Append("<td WIDTH=""14"" class=""clsTDTopRightCorner"">  </td>")
        sbHtml.Append("</tr>")
        'Commented by SuchitraP for IssueID : 30052
        'sbHtml.Append("<tr>")
        'sbHtml.Append("<td>&nbsp;&nbsp;</td>")
        'sbHtml.Append("<td>&nbsp;&nbsp;</td>")
        'sbHtml.Append("</tr>")
        'End of comment by SuchitraP
        sbHtml.Append("</table>")
        sbHtml.Append("<table  id=tblGroup3 WIDTH=100% CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Class=""clsRoundedTableMenu"">")

        'While dsEntity_Team.Read
        For Each objDr As DataRow In dsEntity_Team.Tables(0).Rows
            strSQL = ""
            blnEditAccess = False
            blnViewAccess = False
            strAccessSQL = ""

            If objDr("TeamID").ToString > 0 Then
                strAccessSQL = "usp_GetAccessForTeam " + objDr("TeamID").ToString + "," + HttpContext.Current.Session("intUserID").ToString
                strAccessForEmp = CommonFunction.Data.GetDataReader(strAccessSQL, MyBase.UseSQL)
                'strAccessSQL = "SELECT DISTINCT UserGroupID,MIN(AccessType) AS AccessType FROM tbl_KM_Teams_RestrictedUserGroups WHERE TeamID=" + dsEntity_Team("TeamID").ToString + "AND UserGroupID=" + HttpContext.Current.Session("intUserID").ToString + " Group BY UserGroupID"
                'strAccessForEmp = CommonFunction.Data.GetDataReader(strAccessSQL, MyBase.UseSQL)
                If strAccessForEmp.Read Then
                    sbHtml.Append("<tr class=""clsTRControlMenu"">")
                    'sbHtml.Append("<td valign=top width=20>")
                    'sbHtml.Append("<img src='..\..\Images\Discussions.gif' vspace=1 border=0></a>")
                    sbHtml.Append("<td valign=top width=75% style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>")

                    If strAccessForEmp("AccessType").ToString = "1" Then
                        strSQL = " Select dbo.udf_GetTeamAccess(1," & HttpContext.Current.Session("intUserID").ToString & "," & objDr("TeamID").ToString & ")"
                        blnEditAccess = CBool(CommonFunctions.Data.GetDataScalar(strSQL, True))
                        sbHtml.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:Edit_TeamDetails(" + objDr("TeamID").ToString + ",'EDIT','" + m_strFromWhere + "')"">")
                        sbHtml.Append("<b>" + HttpUtility.HtmlEncode(objDr("TeamName").ToString) + "</b>") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                        sbHtml.Append("</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                    ElseIf strAccessForEmp("AccessType").ToString = "2" Then
                        strSQL = "SELECT dbo.udf_GetTeamAccess(2," & HttpContext.Current.Session("intUserID").ToString & "," & objDr("TeamID").ToString & ")"
                        blnViewAccess = CBool(CommonFunctions.Data.GetDataScalar(strSQL, True))
                        sbHtml.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:Edit_TeamDetails(" + objDr("TeamID").ToString + ",'View','" + m_strFromWhere + "')"">")
                        sbHtml.Append("<b>" + HttpUtility.HtmlEncode(objDr("TeamName").ToString) + "</b>") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                        sbHtml.Append("</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                    End If

                    'strSQL = " Select dbo.udf_GetTeamAccess(1," & HttpContext.Current.Session("intUserID").ToString & "," & dsEntity_Team("TeamID").ToString & ")"
                    'blnEditAccess = CBool(CommonFunctions.Data.GetDataScalar(strSQL, True))
                    'strSQL = "SELECT dbo.udf_GetTeamAccess(2," & HttpContext.Current.Session("intUserID").ToString & "," & dsEntity_Team("TeamID").ToString & ")"
                    'blnViewAccess = CBool(CommonFunctions.Data.GetDataScalar(strSQL, True))
                    'If blnEditAccess Then
                    '    sbHtml.Append("<a HREF=""Javascript:Edit_TeamDetails(" + dsEntity_Team("TeamID").ToString + ",'EDIT','" + m_strFromWhere + "')"">")
                    'ElseIf blnViewAccess Then
                    '    sbHtml.Append("<a HREF=""Javascript:Edit_TeamDetails(" + dsEntity_Team("TeamID").ToString + ",'View','" + m_strFromWhere + "')"">")
                    'End If
                    ' End If


                    sbHtml.Append("&nbsp;&nbsp;")
                    SpaceCount = CommonFunction.Data.GetDataScalar("SELECT Count(2) FROM tbl_KM_TeamSpaces WHERE TeamID=" + objDr("TeamID").ToString, True) '+ " AND AddedBy=(Select UserName FROM tbl_PM_Employee WHERE EmployeeID=" + HttpContext.Current.Session("intUserID").ToString + ")", True)
                    'submitter = ""
                    'submitter = CommonFunction.Data.GetDataScalar("Select UserName FROM tbl_KM_Team INNER JOIN  tbl_PM_Employee ON AuthorID=EmployeeID WHERE TeamID=" + dsEntity_Team("TeamID").ToString, True)

                    sbHtml.Append("<br>")
                    If objDr("Description").ToString.Length > 50 Then
                        sbHtml.Append(HttpUtility.HtmlEncode(Left(objDr("Description").ToString, 150)) + "....") 'HtmlEncode Added By Vaijat K ON 20/11/2015
                    Else
                        sbHtml.Append(HttpUtility.HtmlEncode(objDr("Description"))) 'HtmlEncode Added By Vaijat K ON 20/11/2015
                    End If
                    sbHtml.Append("</td><td valign=top align=left nowarp width=25% style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>No.Of Spaces(" + SpaceCount + ")")
                    sbHtml.Append("</td>")
                    sbHtml.Append("<td valign='top' align=right>")
                    'If dsEntity_Team("TeamID").ToString > 0 Then
                    'strSQL = ""
                    'blnEditAccess = False
                    'blnViewAccess = False
                    'strAccessSQL = ""
                    'strAccessSQL = "SELECT DISTINCT UserGroupID,MIN(AccessType) AS AccessType FROM tbl_KM_Teams_RestrictedUserGroups WHERE TeamID=" + dsEntity_Team("TeamID").ToString + " Group BY UserGroupID"
                    'strAccessForEmp = CommonFunction.Data.GetDataReader(strAccessSQL, MyBase.UseSQL)
                    'While strAccessForEmp.Read
                    If strAccessForEmp("AccessType").ToString = "1" Then
                        strSQL = " Select dbo.udf_GetTeamAccess(1," & HttpContext.Current.Session("intUserID").ToString & "," & objDr("TeamID").ToString & ")"
                        blnEditAccess = CBool(CommonFunctions.Data.GetDataScalar(strSQL, True))
                        sbHtml.Append("<a HREF=""Javascript:Edit_TeamDetails(" + objDr("TeamID").ToString + ",'EDIT','" + m_strFromWhere + "')""><img src='../../Images/Home/maximize.gif' border='0' alt='Max' /></a>")
                    ElseIf strAccessForEmp("AccessType").ToString = "2" Then
                        strSQL = "SELECT dbo.udf_GetTeamAccess(2," & HttpContext.Current.Session("intUserID").ToString & "," & objDr("TeamID").ToString & ")"
                        blnViewAccess = CBool(CommonFunctions.Data.GetDataScalar(strSQL, True))
                        sbHtml.Append("<a  style='text-decoration:none' HREF=""Javascript:Edit_TeamDetails(" + objDr("TeamID").ToString + ",'View','" + m_strFromWhere + "')""><img src='../../Images/Home/maximize.gif'  border='0'  alt='Max' /></a>")
                    End If
                    sbHtml.Append("</td>")
                    sbHtml.Append("</tr>")
                    '    Else
                    '        strSQL = " Select dbo.udf_GetTeamAccess(1," & HttpContext.Current.Session("intUserID").ToString & "," & dsEntity_Team("TeamID").ToString & ")"
                    '        blnEditAccess = CBool(CommonFunctions.Data.GetDataScalar(strSQL, True))
                    '        strSQL = "SELECT dbo.udf_GetTeamAccess(2," & HttpContext.Current.Session("intUserID").ToString & "," & dsEntity_Team("TeamID").ToString & ")"
                    '        blnViewAccess = CBool(CommonFunctions.Data.GetDataScalar(strSQL, True))
                    '        If blnEditAccess Then
                    '            sbHtml.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:Edit_TeamDetails(" + dsEntity_Team("TeamID").ToString + ",'EDIT','" + m_strFromWhere + "')"">")
                    '        ElseIf blnViewAccess Then
                    '            sbHtml.Append("<a style='font-weight :lighter ; font-family:Tahoma ;font-size:12px' HREF=""Javascript:Edit_TeamDetails(" + dsEntity_Team("TeamID").ToString + ",'View','" + m_strFromWhere + "')"">")
                    '        End If

                    '        sbHtml.Append("<b>" + dsEntity_Team("TeamName").ToString + "</b>")
                    '        sbHtml.Append("</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                    '        sbHtml.Append("&nbsp;&nbsp;")
                    '        SpaceCount = CommonFunction.Data.GetDataScalar("SELECT Count(2) FROM tbl_KM_TeamSpaces WHERE TeamID=" + dsEntity_Team("TeamID").ToString, True) '+ " AND AddedBy=(Select UserName FROM tbl_PM_Employee WHERE EmployeeID=" + HttpContext.Current.Session("intUserID").ToString + ")", True)
                    '        'submitter = ""
                    '        'submitter = CommonFunction.Data.GetDataScalar("Select UserName FROM tbl_KM_Team INNER JOIN  tbl_PM_Employee ON AuthorID=EmployeeID WHERE TeamID=" + dsEntity_Team("TeamID").ToString, True)

                    '        sbHtml.Append("<br>")
                    '        If dsEntity_Team("Description").ToString.Length > 50 Then
                    '            sbHtml.Append(Left(dsEntity_Team("Description").ToString, 150) + "....")
                    '        Else
                    '            sbHtml.Append(dsEntity_Team("Description"))
                    '        End If
                    '        sbHtml.Append("</td><td valign=top align=left nowarp width=25% style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>No.Of Spaces(" + SpaceCount + ")")
                    '        sbHtml.Append("</td>")
                    '        sbHtml.Append("<td valign='top'>")
                    '        If dsEntity_Team("TeamID").ToString > 0 Then
                    '            strSQL = " Select dbo.udf_GetTeamAccess(1," & HttpContext.Current.Session("intUserID").ToString & "," & dsEntity_Team("TeamID").ToString & ")"
                    '            blnEditAccess = CBool(CommonFunctions.Data.GetDataScalar(strSQL, True))
                    '            strSQL = "SELECT dbo.udf_GetTeamAccess(2," & HttpContext.Current.Session("intUserID").ToString & "," & dsEntity_Team("TeamID").ToString & ")"
                    '            blnViewAccess = CBool(CommonFunctions.Data.GetDataScalar(strSQL, True))
                    '            If blnEditAccess Then
                    '                sbHtml.Append("<a HREF=""Javascript:Edit_TeamDetails(" + dsEntity_Team("TeamID").ToString + ",'EDIT','" + m_strFromWhere + "')""><img src='../../Images/Home/maximize.gif' border='0' alt='Max' /></a>")
                    '            ElseIf blnViewAccess Then
                    '                sbHtml.Append("<a HREF=""Javascript:Edit_TeamDetails(" + dsEntity_Team("TeamID").ToString + ",'View','" + m_strFromWhere + "')""><img src='../../Images/Home/maximize.gif'  border='0'   style='text-decoration:none' alt='Max' /></a>")
                    '            End If
                    '        End If
                    '        sbHtml.Append("</td>")
                    '        sbHtml.Append("</tr>")
                    '    End If
                    '    'End If
                    '    'If blnEditAccess Then
                    '    'ElseIf blnViewAccess Then
                    '    'End If
                    '    'End While

                    'End If
                    intCount = intCount + 1
                End If

                CommonFunction.Data.DisposeDataReader(strAccessForEmp)
            End If
            ''If intCount >= 10 Then
            ''    Exit While
            ''End If
        Next


        ''CommonFunction.Data.DisposeDataReader(dsEntity_Team)

        ''If intCount >= 10 Then
        ''    sbHtml.Append("<tr class=""clsTRControlMenu"">")
        ''    sbHtml.Append("<td align=right colspan=3>")
        ''    sbHtml.Append("&nbsp;&nbsp;<a HREF=""Javascript:ShowDetailsHome_Onclick(3)""> <font color='blue' style='font-size:10px'>More Teams...</font>")
        ''    sbHtml.Append("</a>&nbsp;&nbsp;&nbsp;&nbsp;</td>")
        ''    sbHtml.Append("</tr>")
        ''Else
        If intCount = 0 Then
            sbHtml.Append("<tr class=""clsTRControlMenu"">")
            sbHtml.Append("<td align=center colspan=3 style='font-weight :lighter ; font-family:Tahoma ;  font-size:13px;'>")
            If intCount = 0 Then
                sbHtml.Append("There are no items to show in this view...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
            End If
            sbHtml.Append("</TD></tr>")
        End If

        sbHtml.Append(" <tr>")
        sbHtml.Append("<td  class=""clsTDBottomLeftCorner"">  </td>")
        sbHtml.Append("<td WIDTH=" & (400 - 28).ToString & " ></td>")
        sbHtml.Append("<td></td><td class=""clsTDBottomRightCorner""></td>")
        sbHtml.Append("</tr>")
        sbHtml.Append("</table>")
        sbHtml.Append("</TD>")

        'sbHtml.Append(sbHtml_Left.ToString)
        sbHtml.Append("<td WIDTH=""2%""></td>")
        sbHtml.Append("</tr>")

        'End by SuchitraP

        sbHtml.Append("</table>")
        ''ADDED BY nILESH G ON 29/12/2015
        sbHtml.Append("</Div>")
        ''ENDED BY nILESH G ON 29/12/2015

        If intFromAjax = 0 Then
            CommonFunction.General.WriteHTML(sbHtml.ToString)
        Else
            Response.Clear()
            CommonFunction.General.WriteHTML(sbHtml.ToString)
            Response.End()
            sbHtml = Nothing
        End If

    End Function
    Private Sub WritePaging(ByVal PagingSQL As String)

        Dim intRecordCount As Integer
        Dim strPaging As String = ""

        m_intTotalNoOfRows = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(PagingSQL, MyBase.UseSQL), ""), ""), Integer)

        If Math.Ceiling(m_intTotalNoOfRows / 8) < m_intPageNumber Then
            m_intPageNumber = 1
        End If

        If m_intTotalNoOfRows > 0 Then

            strPaging = "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage()"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">"
            strPaging += "<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>"
            strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">"
            strPaging += "<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>"

            If m_intPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
                'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                '    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True)
                'Else
                '    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True)
                strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
            Else
                strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)

                'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                            End If

            strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage()"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">"
            strPaging += "<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>"
            strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage()"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">"
            strPaging += "<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> "
            strPaging += "<input type=hidden id=hidNoOfPages value=" + (Math.Ceiling(m_intTotalNoOfRows / 8)).ToString + ">"

            strPaging += "<font size=1><b> of " + (Math.Ceiling(m_intTotalNoOfRows / 8)).ToString
            strPaging += "| </b></font><A href='javascript:All_OnClick(""-1"")' TITLE='Show All Records'><B>All<B></A>"
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            ''strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , (Math.Ceiling(m_intTotalNoOfRows / 8)).ToString, returnHTML:=True, DisplayNone:=True)
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , (Math.Ceiling(m_intTotalNoOfRows / 8)).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True)
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding


            Response.Write("<Table width='99.9%' cellpadding=0 cellspacing=0><TR>")


            If Trim(strPaging & "") <> "" Then
                'Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'><td align=right>" + strPaging + "</TD></TR></Table>")
                Response.Write("<td align=right>" + strPaging + "</TD>")
            End If

            Response.Write("</TR></TABLE>")

        End If
    End Sub

    ''Added by Dhanashri S on 29 Mar 2016 Purpose:to generate and validate Token
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateDiscussionToken(ProcedureID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(ProcedureID, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of Addition by Dhanashri S on 29 Mar 2016
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateDocumentToken(ProcedureID As String, EmployeeID As String) As String
        Try
            Dim m_PKToken_DocumentToken As String
            m_PKToken_DocumentToken = CommonFunctions.Security.Token.GetToken(CType(ProcedureID, String) + CType(EmployeeID, String) + "0" + "0")

            Return m_PKToken_DocumentToken
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    'Added By Chakshuta H on 11th-Aug-2016
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateRateArticleToken(ProcedureID As String, EmployeeID As String) As String
        Try
            Dim m_PKToken_RateArticleToken As String
            m_PKToken_RateArticleToken = CommonFunctions.Security.Token.GetToken(CType(ProcedureID, String) + CType(EmployeeID, String) + "0" + "0")

            Return m_PKToken_RateArticleToken
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    'End of Added By Chakshuta H on 11th-Aug-2016

End Class
