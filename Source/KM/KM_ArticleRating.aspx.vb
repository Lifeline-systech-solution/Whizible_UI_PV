Public Partial Class KM_ArticleRating
    '' Inherits System.Web.UI.Page ''WebPages.Template.WhizTemplate
    Inherits WebPages.Template.WhizTemplate
    Protected stroptRate As String
    Private strArticleRatingID As String
    Protected strProcedureID As String
    Protected strFrom As String
    Protected m_PKToken_RateArticle As String
    Private WithEvents m_objGrid As New WebPage.Templates.GenericGrid ''added by RohiniK on 13 Nov 09
    Private m_blnValidate As Boolean = True
    Protected CheckFlag As String  ''Added By Reshma Chavan on 7th Feb 2022 For IssueID-32059

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ' ''commented by nilesh g on 31/12/2015 for Security
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
        ' ''end of commented by nilesh g on 31/12/2015 for Security

        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        Call InitVariables()

        If Request.QueryString("Action") = "SAVE" Then
            Call SaveData()
        End If

        'Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
        If (Request.QueryString("PKToken") = "" And HttpContext.Current.Session("intUserID").ToString <> "0") And Request.QueryString("Action") <> "SAVE" Then
            m_blnValidate = False
        ElseIf Request.QueryString("Action") <> "SAVE" And (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProcedureID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0", Request.QueryString("PKToken")) = False) Then
            m_blnValidate = False
        ElseIf Request.QueryString("Action") <> "SAVE" And (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProcedureID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0", Request.QueryString("PKToken")) = False) Then
            m_blnValidate = False
        ElseIf Request.QueryString("Action") <> "SAVE" And (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProcedureID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0", Request.QueryString("PKToken")) = False) Then
            m_blnValidate = False
        End If
        If m_blnValidate = False Then
            'Token is Invalid now redirect to the Invalid Access Page
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If

        'Added By Reshma Chavan on 7th Feb 2022 For IssueID-32059
        If CommonFunction.General.CheckIsNothing(Request.QueryString("CheckFlag"), "") <> "" Then
            CheckFlag = Request.QueryString("CheckFlag")
        End If
        'End of Added By Reshma Chavan on 7th Feb 2022 For IssueID-32059

        'End Of Added By Chakshuta H on 11th-Aug-2016 Purpose:PkToken validation
        ' ''Added by Dhanashri S on 31 Mar 2016

        'If (Request.QueryString("PKRateArticleToken") <> "" And Request.QueryString("ProcedureID") <> "") Then
        '    If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProcedureID"), String) + "0" + "0", Request.QueryString("PKRateArticleToken")) = False) Then

        '        'Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("Year"), String))
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    End If
        'End If

        ' ''End of Addition by Dhanashri S on 31 MAr 2016
    End Sub
    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag("Article Rating")
        CommonFunction.General.WriteHTML("<LINK href='tabcontent.css' type=text/css rel=stylesheet>")
    End Sub

    Public Sub WritePage()
        Dim strMenu As String = ""
        strMenu = PlotMenu()
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Article Rating", , , True))
        Call drawHiddenControls()

        ''commented and added by RohiniK on 13 Nov 09
        'CommonFunctions.General.WriteHTML("<div id=""divPage"" style='WIDTH:100%;HEIGHT:90%;'>")
        Call DrawRatings()
        'CommonFunctions.General.WriteHTML("</DIV>")

        Dim strSQL As String
        Dim strUserID As String = 0
        strSQL = "select programmerID from tbl_KM_CodeHeadings where ProcedureId=" + strProcedureID
        strUserID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, True), "0"), String)


        If Session("intUserID") = 61 Or Session("intUserID") = strUserID Then
            'CommonFunctions.General.WriteHTML("<BR>")
            Call DrawRatingAuditTrail()
            'CommonFunctions.General.WriteHTML(strMenu)
        Else
            CommonFunctions.General.WriteHTML("<BR>")
            CommonFunction.General.WriteHTML("<Div id='DivBody' width=100% height=90% style='overflow: auto;' >")
            CommonFunctions.General.WriteHTML(strMenu)
            Response.Write("</DIV>")
        End If

        'CommonFunctions.General.WriteHTML("</DIV>")
        ''added by RohiniK on 13 Nov 09

        'CommonFunctions.General.WriteHTML("<BR>")
        'CommonFunctions.General.WriteHTML(strMenu)
    End Sub
    Private Sub InitVariables()
        If CommonFunctions.General.CheckIsNothing(Request.Form("optRate"), "") <> "" Then
            stroptRate = Request.Form("optRate")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidOptRate"), "") <> "" Then
            stroptRate = Request.Form("hidOptRate")
        Else
            stroptRate = "NULL"
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("OptValue"), "") <> "" Then
            stroptRate = Request.QueryString("OptValue")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("ProcedureID"), "") <> "" Then
            strProcedureID = Request.QueryString("ProcedureID")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidProcedureID"), "") <> "" Then
            strProcedureID = Request.Form("hidProcedureID")
        Else
            strProcedureID = "NULL"
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("From"), "") <> "" Then
            strFrom = Request.QueryString("From")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidFrom"), "") <> "" Then
            strFrom = Request.Form("hidFrom")
        End If
        ''Added By Vidya J On 29-Mar-2016
        If Not Request.QueryString("Token") Is Nothing Then
            m_PKToken_RateArticle = Request.QueryString("Token").ToString
        End If

        If m_PKToken_RateArticle <> "" Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(strProcedureID, String) + CType(0, String) + CType(0, String), m_PKToken_RateArticle) = False) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(strProcedureID, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If
        ''End Of Addtion By Vidya J On 26 Mar 2016
    End Sub
    Private Function PlotMenu()
        Dim strHtml As New System.Text.StringBuilder
        Dim ArticleRating As Integer = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_tbl_KM_ArticleRating " + strProcedureID.ToString() + "," + HttpContext.Current.Session("intUserID").ToString, True), "0"), "0"), Integer)

        strHtml.Append("<Table class=clsTable cellspacing=0 cellpadding=0 width='100%'>" + vbCrLf)
        strHtml.Append("<TR class=clsTRMenu>" + vbCrLf)
        strHtml.Append("<TD align=Right>" + vbCrLf)
        strHtml.Append("|" + vbCrLf)
        If ArticleRating = 0 Then
            strHtml.Append("<A class='Menu' style=''  Title=""Save""  onclick=""Save_OnClick()"" >Save</A> | " + vbCrLf)
        End If
        strHtml.Append("<A class='Menu' style=''  Title=""Close""  onclick=""Close_OnClick()"" >Close</A> |" + vbCrLf)
        strHtml.Append("</TD></TR></TABLE>" + vbCrLf)

        Return strHtml.ToString
    End Function
    Private Sub DrawRatings()
        Dim sbHtml As New System.Text.StringBuilder
        Dim counter As Integer
        Dim i As Integer
        Dim strSQL As String
        Dim intRating As Integer
        Dim drArticleRate As IDataReader
        Dim blnchecked As Boolean

        strSQL = "usp_sel_tbl_KM_ArticleRating " + strProcedureID + "," + HttpContext.Current.Session("intUserID").ToString
        drArticleRate = CommonFunction.Data.GetDataReader(strSQL, True)

        If drArticleRate.Read Then
            intRating = CType(CommonFunction.Data.CheckIsDBNull(drArticleRate("Rating"), "0"), Integer)

            sbHtml.Append("<BR>")
            sbHtml.Append("<table CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Width='99.9%' >")
            sbHtml.Append("<TR class=""clsTREven"">")

            For counter = 1 To 5
                If counter = intRating Then
                    blnchecked = True
                Else
                    blnchecked = False
                End If
                sbHtml.Append("<TD align=center colspan=1>")
                sbHtml.Append(CommonFunction.HTMLControls.DrawOptionButton("optRate", "optRate", , blnchecked, counter, , , True))
                sbHtml.Append("&nbsp;&nbsp;&nbsp;&nbsp;")
                sbHtml.Append("</td>")
            Next
            sbHtml.Append("</TR>")
            sbHtml.Append("<TR class=""clsTREven"">")
            For i = 0 To 4
                sbHtml.Append("<TD align=center colspan=1>")
                sbHtml.Append(i + 1)
                sbHtml.Append("&nbsp;&nbsp;&nbsp;&nbsp;")
                sbHtml.Append("</td>")
            Next
            sbHtml.Append("</TR>")
            sbHtml.Append("</table>")
            sbHtml.Append("<BR>")
            sbHtml.Append("<table CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Width='99.9%' >")
            sbHtml.Append("<TR class=""clsTREven"">")
            sbHtml.Append("<td align=left colspan=5>Note:</TD>")
            sbHtml.Append("</TR>")
            sbHtml.Append("<TR class=""clsTREven"">")
            sbHtml.Append("<td align=left>1 - <B>Poor</B></TD>")
            sbHtml.Append("<td align=left>2 - Fair</TD>")
            sbHtml.Append("<td align=left>3 - Good</TD>")
            sbHtml.Append("<td align=left>4 - Very Good</TD>")
            sbHtml.Append("<td align=left>5 - <B>Excellent</B></TD>")
            sbHtml.Append("</TR>")

            sbHtml.Append("<br><TR class=""clsTREven"">")
            sbHtml.Append("<td align=left colspan=5>You have already rated this article.</TD>")
            sbHtml.Append("</TR>")

            sbHtml.Append("</table>")
        Else
            sbHtml.Append("<BR>")
            sbHtml.Append("<table CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Width='99.9%' >")
            sbHtml.Append("<TR class=""clsTREven"">")

            For counter = 1 To 5
                sbHtml.Append("<TD align=center colspan=1>")
                sbHtml.Append(CommonFunction.HTMLControls.DrawOptionButton("optRate", "optRate", , False, stroptRate, , , True))
                sbHtml.Append("&nbsp;&nbsp;&nbsp;&nbsp;")
                sbHtml.Append("</td>")
            Next
            sbHtml.Append("</TR>")
            sbHtml.Append("<TR class=""clsTREven"">")
            For i = 0 To 4
                sbHtml.Append("<TD align=center colspan=1>")
                sbHtml.Append(i + 1)
                sbHtml.Append("&nbsp;&nbsp;&nbsp;&nbsp;")
                sbHtml.Append("</td>")
            Next
            sbHtml.Append("</TR>")
            sbHtml.Append("</table>")
            sbHtml.Append("<BR>")
            sbHtml.Append("<table CELLPADDING=""0"" CELLSPACING=""0"" BORDER=""0"" Width='99.9%' >")
            sbHtml.Append("<TR class=""clsTREven"">")
            sbHtml.Append("<td align=left colspan=5>Note:</TD>")
            sbHtml.Append("</TR>")
            sbHtml.Append("<TR class=""clsTREven"">")
            sbHtml.Append("<td align=left>1 - <B>Poor</B></TD>")
            sbHtml.Append("<td align=left>2 - Fair</TD>")
            sbHtml.Append("<td align=left>3 - Good</TD>")
            sbHtml.Append("<td align=left>4 - Very Good</TD>")
            sbHtml.Append("<td align=left>5 - <B>Excellent</B></TD>")
            sbHtml.Append("</TR>")
            sbHtml.Append("</table>")
        End If
        CommonFunction.Data.DisposeDataReader(drArticleRate)

        CommonFunction.General.WriteHTML(sbHtml.ToString)
        sbHtml = Nothing

    End Sub

    ''added by RohiniK on 13 Nov 09
    Private Sub DrawRatingAuditTrail()
        Dim strSQL As String
        Dim arrColHeader() As String = {"Employee Name", "Points", "Rating"}
        Dim arrAN() As String = {"EmployeeName", "Points", "Rating"}
        Dim strMenu As String = ""
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        strMenu = PlotMenu()

        strSQL = "Exec usp_sel_tbl_KM_ArticleRating_AuditTrail " + strProcedureID.ToString

        CommonFunction.General.WriteHTML("<BR>")
        CommonFunction.General.WriteHTML("<Div id='DivBody' width=100% height=90% style='overflow: auto;' >")

        With m_objGrid
            .ActualColumnArray = arrAN
            .UserFriendlyColumnArray = arrColHeader
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 100
            ''.DIVStyle = "overflow:auto; width:100% "
            .NoOfDataColumns = 3
            .returnHTML = False
            .SQL = strSQL
            .UseSQL = True
            'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHtml
            'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

            .DrawGrid()
        End With
        m_objGrid = Nothing

        CommonFunction.General.WriteHTML("</Div>")
        ''CommonFunction.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)
    End Sub
    ''End of addition by RohiniK on 13 Nov 09

    Private Sub SaveData()
        Dim strquery As String

        strquery = "usp_insupd_tbl_KM_ArticleRating " + strProcedureID + "," + HttpContext.Current.Session("intUserID").ToString + "," + stroptRate
        CommonFunction.Data.InsertOrUpdateData(strquery, True)
    End Sub
    Private Sub drawHiddenControls()
        If CommonFunction.General.CheckIsNothing(Request.QueryString("ProcedureID"), "") <> "" Then
            CommonFunction.General.WriteHTML("<input type=hidden name=hidProcedureID id=hidProcedureID value=" + Request.QueryString("ProcedureID") + ">" + vbCrLf)
        End If
        If CommonFunction.General.CheckIsNothing(Request.Form("optRate"), "") <> "" Then
            CommonFunction.General.WriteHTML("<input type=hidden name=hidOptRate id=hidOptRate value=" + Request.Form("optRate") + ">" + vbCrLf)
        End If
        CommonFunction.General.WriteHTML("<input type=hidden name=hidFrom id=hidFrom value=" + Request.QueryString("From") + ">" + vbCrLf)
    End Sub
End Class