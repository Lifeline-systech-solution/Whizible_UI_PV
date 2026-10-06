Public Partial Class KM_SpaceAndPageView
    Inherits WebPages.Template.WhizTemplate
    Private m_strMode As String
    Private m_strTeamID As String
    Private m_strSearchText_View As String = ""
    Protected m_strFromWhere As String
    Protected m_strPagingNumber As String = ""
    Protected m_strtxtSearch As String = ""

    ''Added by Vidya J on 29-Mar-2016  to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken(SpaceID As String, EmployeeID As String, PageID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(SpaceID, String) + CType(EmployeeID, String) + "0" + "0" + CType(PageID, String))

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of addition by Vidya J on 29-Mar-2016

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
    End Sub
    Public Sub WritePage()
        Dim strMenu As String = ""
        Dim sbHTML As New System.Text.StringBuilder
        Dim strTeamName As String = ""

        strMenu = DrawMenu()
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunction.General.WriteHTML("<br />")
        If CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "") <> "" Then
            m_strMode = Request.QueryString("Mode")
        End If

        If Not Request.QueryString("PrimaryKey") Is Nothing Then
            If Request.QueryString("PrimaryKey") = "0" Then
                m_strTeamID = "NULL"
            Else
                m_strTeamID = Request.QueryString("PrimaryKey")
            End If
        End If

        'If Not Request("txtSearch") Is Nothing Then
        '    m_strSearchText_View = Request("txtSearch").Trim()
        'End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("txtSearch"), "") <> "" Then
            m_strtxtSearch = Request.QueryString("txtSearch")
        End If

        If CommonFunction.General.CheckIsNothing(Request.Form("txtSearch"), "") <> "" Then
            m_strSearchText_View = Request.Form("txtSearch")
            'ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidtxtSearch"), "") <> "" Then
            '    m_strSearchText_View = Request.Form("hidtxtSearch")
            '    m_strtxtSearch = m_strSearchText_View
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("Fromwhere"), "") <> "" Then
            m_strFromWhere = Request.QueryString("Fromwhere")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidFromwhere"), "") <> "" Then
            m_strFromWhere = Request.Form("hidFromwhere")
        End If

        'If CommonFunction.General.CheckIsNothing(Request.QueryString("txtSearch"), "") <> "" Then
        '    m_strtxtSearch = Request.QueryString("txtSearch")
        'ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidtxtSearch"), "") <> "" Then
        '    m_strtxtSearch = Request.Form("hidtxtSearch")
        'End If

        If CommonFunction.General.CheckIsNothing(Request.Form("txtPageNumber"), "") <> "" Then
            m_strPagingNumber = Request.Form("txtPageNumber")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidtxtPageNumber"), "") <> "" Then
            m_strPagingNumber = Request.Form("hidtxtPageNumber")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("PageNumber"), "") <> "" Then
            m_strPagingNumber = Request.QueryString("PageNumber")
        End If

        sbHTML.Append("<TABLE id='tbltop'  style='width:100%;border:1px solid #ccc;' cellspacing=0 cellpadding=0 class=clsTable>")
        sbHTML.Append("<TR class=clsTREven valign=middle>")
        sbHTML.Append("<td align=right width=30%> Search </td><td align=left>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''  sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearch", "txtSearch", , 300, 200, value:=m_strSearchText_View, returnHTML:=True))
        sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearch", "txtSearch", , 300, 200, value:=m_strSearchText_View, returnHTML:=True, EnableHTMLEncode:=True))
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        sbHTML.Append("</td></tr></Table><BR>")
        CommonFunctions.General.WriteHTML(sbHTML.ToString)
        sbHTML = Nothing



        strTeamName = CommonFunction.Data.GetDataScalar("SELECT TeamName FROM tbl_KM_Team WHERE TeamID=" + m_strTeamID.ToString, MyBase.UseSQL)

        If m_strMode.ToUpper = "SPACEVIEW" Then
            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Team Spaces", , , True))
            CommonFunctions.General.WriteHTML("<DIV Id=divMain Style='HEIGHT:90%;OVERFLOW:auto; WIDTH:100%'>")
            CommonFunctions.General.WriteHTML("<BR>")
            Call PlotSpaceView()
        Else
            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Team Articles : " + strTeamName, , , True))
            CommonFunctions.General.WriteHTML("<DIV Id=divMain Style='HEIGHT:90%;OVERFLOW:auto; WIDTH:100%'>")
            CommonFunctions.General.WriteHTML("<BR>")
            Call PlotPageView()
        End If


        CommonFunctions.General.WriteHTML("</DIV>")
        CommonFunctions.General.WriteHTML("<BR>")

        CommonFunction.General.WriteHTML("<input type=hidden name=hidFromwhere id=hidFromwhere value='" + Request.QueryString("Fromwhere") + "'>" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidtxtSearch id=hidtxtSearch value='" + m_strSearchText_View + "'>" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidtxtPageNumber id=hidtxtPageNumber value='" + Request.Form("txtPageNumber") + "'>" + vbCrLf)
        CommonFunction.General.WriteHTML("<input type=hidden name=hidtxtSearch id=hidtxtSearch value='" + Request.QueryString("txtSearch") + "'>" + vbCrLf)

        CommonFunctions.General.WriteHTML(strMenu)



    End Sub
    Private Sub PlotSpaceView()
        Dim sbHtml As New System.Text.StringBuilder
        Dim strSQL As String
        Dim drMenu As IDataReader
        Dim intRowCount As Integer = 0
        Dim Cancel As Boolean = False
        Dim intCount As Integer = 0
        Dim EntityName As String
        Dim EntityPKID As Integer
        Dim NoOfArticles As Integer

        strSQL = " usp_sel_SpaceView " + m_strTeamID.ToString + "," + HttpContext.Current.Session("intUserID").ToString + ",N'" + CommonFunctions.General.BuildQueryString(m_strSearchText_View) + "'"
        drMenu = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        sbHtml.Append("<table width='100%' class='clsTable' border='0' cellspacing='1'>")
        sbHtml.Append("<tr><td align='left' valign='top' width='33.33%'>")
        sbHtml.Append("<table width='95%'  border='0' cellpadding='5'>")

        While drMenu.Read
            EntityName = drMenu("SpaceName").ToString
            EntityPKID = drMenu("SpaceID").ToString

            sbHtml.Append("<tr name=trItem_" + EntityName + " id=trItem_" + EntityName + " >")
            sbHtml.Append("<td valign=top><font fontFamily:'Verdana, Arial'; size='-2'>")
            sbHtml.Append(EntityName)
            sbHtml.Append("</a>")
            sbHtml.Append("</font></td>")
            sbHtml.Append("</tr>")

        End While

        CommonFunction.Data.DisposeDataReader(drMenu)

        sbHtml.Append("</table>")
        sbHtml.Append("</td></tr></table>")
        CommonFunction.General.WriteHTML(sbHtml.ToString)
        sbHtml = Nothing


    End Sub
    Private Sub PlotPageView()
        Dim sbHtmldPageView As New System.Text.StringBuilder
        Dim strSQL As String = ""
        Dim drPageView As IDataReader
        Dim intRowCount As Integer = 0
        Dim Cancel As Boolean = False
        Dim intCount As Integer = 0
        Dim EntityName As String
        Dim EntityPKID As Integer
        Dim NoOfArticles As Integer
        Dim strSpaceName As String
        Dim strSynopsis As String
        Dim strEmployeeName As String
        Dim strDateCreated As String
        Dim CurrentSpace As String = ""

        strSQL = " usp_sel_PageView " + m_strTeamID.ToString + "," + HttpContext.Current.Session("intUserID").ToString + ",N'" + CommonFunctions.General.BuildQueryString(m_strSearchText_View) + "'"
        drPageView = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        'sbHtmldPageView.Append("<table width='100%' class='clsTable' border='0' cellpadding='0'>")
        'sbHtmldPageView.Append("<tr><td align='left' valign='top' width='33.33%'>")
        sbHtmldPageView.Append("<table class='clsGridTable' width='99.99%'  CellSpacing=1 CellPadding=0  >")
        sbHtmldPageView.Append("<thead class=clsTRColumnHeader><th style='text-align:left' >Space</th>  <th  style='text-align:left' >Article Name</th> <th  style='text-align:left' >Submitted By</th><th  style='text-align:left' >Submitted On</th></thead>")

        While drPageView.Read
            EntityName = drPageView("ProcedureTitle").ToString
            EntityPKID = drPageView("PageID").ToString
            strSpaceName = drPageView("SpaceName").ToString
            strSynopsis = drPageView("Synopsis").ToString
            strEmployeeName = drPageView("EmployeeName").ToString

            If IsDBNull(drPageView("DateCreated")) = False Then
                strDateCreated = CommonFunction.Dates.CGetDate(drPageView("DateCreated"))
            Else
                strDateCreated = ""
            End If

            If CurrentSpace <> strSpaceName Then
                sbHtmldPageView.Append("<tr class='clsTRSectionHeader' name=trItem_" + EntityName + " id=trItem_" + strSpaceName + " >")
                sbHtmldPageView.Append("<td valign=top colspan='4' ><font fontFamily:'Verdana, Arial'; size='-2'  >")
                sbHtmldPageView.Append(strSpaceName)
                sbHtmldPageView.Append("</td>")
                sbHtmldPageView.Append("</tr>")
                CurrentSpace = strSpaceName


            End If

            sbHtmldPageView.Append("<tr class='clsTREven' name=trItem_" + EntityName + " id=trItem_" + EntityName + " >")

            If CurrentSpace = strSpaceName Then
                sbHtmldPageView.Append("<td valign=top ><font fontFamily:'Verdana, Arial'; size='-2' >&nbsp;</td>")
            End If

            sbHtmldPageView.Append("<td valign=top ><font fontFamily:'Verdana, Arial'; size='-2'>")
            sbHtmldPageView.Append("<a href=""javascript:Page_OnClick(").Append(EntityPKID)
            sbHtmldPageView.Append(",'Edit','0','MyTeam')"">")
            sbHtmldPageView.Append(EntityName)
            sbHtmldPageView.Append("</a>")
            sbHtmldPageView.Append("</font></td>")

            sbHtmldPageView.Append("<td valign=top ><font fontFamily:'Verdana, Arial'; size='-2'>")
            sbHtmldPageView.Append(strEmployeeName)
            sbHtmldPageView.Append("</font></td>")
            sbHtmldPageView.Append("<td valign=top ><font fontFamily:'Verdana, Arial'; size='-2'>")
            sbHtmldPageView.Append(strDateCreated)
            sbHtmldPageView.Append("</font></td>")

            sbHtmldPageView.Append("</tr>")

        End While

        If EntityName = "" Then
            sbHtmldPageView.Append("<tr  class='clsTREven'  name=trItem_" + EntityName + " id=trItem_" + EntityName + " >")
            sbHtmldPageView.Append("<td valign=top align=center colspan='4' ><font fontFamily:'Verdana, Arial'; size='-2'>")
            sbHtmldPageView.Append("There are no items to view.</font></td>")
            sbHtmldPageView.Append("</tr>")
        End If
        CommonFunction.Data.DisposeDataReader(drPageView)

        sbHtmldPageView.Append("</table>")
        'sbHtmldPageView.Append("</td></tr></table>")
        CommonFunction.General.WriteHTML(sbHtmldPageView.ToString)
        sbHtmldPageView = Nothing
    End Sub
    Private Function DrawMenu()
        Dim strHtml As New System.Text.StringBuilder

        strHtml.Append("<Table class=clsTable cellspacing=0 cellpadding=0 width='100%'>" + vbCrLf)
        strHtml.Append("<TR class=clsTRMenu>" + vbCrLf)
        strHtml.Append("<TD align=Right>" + vbCrLf)
        strHtml.Append("|" + vbCrLf)
        strHtml.Append("<A class='Menu' style=''  Title=""Back""  onclick=""Back_OnClick()"" ><img border=0 src='../../Images/cssImages/Link Images/back.gif'>Back</A> | " + vbCrLf)
        strHtml.Append("<A class='Menu' style=''  Title=""Help""  onclick=""Help_OnClick('3961')"" ><Img Border=0 src='../../Images/cssImages/Link images/help.gif'></A> |" + vbCrLf)
        strHtml.Append("</TD></TR></TABLE>" + vbCrLf)

        Return strHtml.ToString
    End Function
End Class