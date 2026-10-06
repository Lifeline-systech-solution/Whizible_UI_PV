Public Partial Class Default_NewsArticles
    Inherits WebPages.Template.WhizTemplate

    Protected m_intArticleID As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
    End Sub

    Protected Sub DrawPage()
        Dim strHTML As New StringBuilder

        Call InitVariables()

        Select Case m_intArticleID
            Case 0
                'Commented and Added by NitinC for WhizibleSEM v10.0 - New Home Page
                'strHTML.Append(DrawNewsArticleList())
                strHTML.Append(DrawNewsArticleList_New())
                'End of Commented and Added by NitinC for WhizibleSEM v10.0 - New Home Page

            Case Else
                strHTML.Append("<div id=""DivMain"" style=""height:99.99%;width:99.99%;overflow:auto;"">")
                strHTML.Append(DrawNewsArticle(m_intArticleID))
                strHTML.Append("</div>")
        End Select

        CommonFunctions.General.WriteHTML(strHTML.ToString())

    End Sub

    Private Sub InitVariables()
        m_intArticleID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ArticleID"), "0"), Integer)
    End Sub
    'Added by NitinC for WhizibleSEM v10.0 - New Home Page
    Private Function DrawNewsArticleList_New() As String
        Dim strHTML As New StringBuilder
        Dim drArticles As IDataReader
        Dim intTRCount As Integer
        Dim strTitle As String

        drArticles = CommonFunctions.Data.GetDataReader("Usp_SEL_Tbl_SEM_HomeNewsArticle", True)
        strTitle = Convert.ToString(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Usp_SEL_NewsArticles_HeaderText", True))))

        strHTML.Append("<table width=""99%"" height=""250"" border=""0"" cellpadding=""0"" cellspacing=""0"" class=""tdbg"">")
        strHTML.Append("<tr>")
        strHTML.Append("<td>")
        strHTML.Append("<table width=""90%"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""0"">")
        strHTML.Append("<tr>")
        strHTML.Append("<td width=""37%"">")
        strHTML.Append("<table width=""95%"" border=""0px"" cellspacing=""0"" cellpadding=""0""> ")

        intTRCount = 0
        While drArticles.Read()

            strHTML.Append("<tr>")
            strHTML.Append("<td height=""25px""><table width=""90%"" border=""0px"" cellspacing=""0"" cellpadding=""0"">")
            strHTML.Append("<tr>")
            strHTML.Append("<td width=""11%""><img src='")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drArticles("ImagePath"), "").ToString())
            strHTML.Append("' width=""16"" height=""15"" /></td>")
            strHTML.Append("<td width=""89%""><a href='javascript:Tab_OnClick(")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drArticles("ArticleID"), "0").ToString())
            strHTML.Append(",")
            strHTML.Append(intTRCount.ToString())
            strHTML.Append(")' class=""bluetext"">")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drArticles("ArticleName"), "").ToString())
            strHTML.Append("</a></td>")
            strHTML.Append("</tr>")
            strHTML.Append("</table></td>")
            strHTML.Append("</tr>")
            strHTML.Append("<tr>")
            strHTML.Append("<td height=""1px"" bgcolor=""#dfe1e9""></td>")
            strHTML.Append("</tr>")
            intTRCount += 1
        End While
        strHTML.Append("</table>")
        strHTML.Append("</td>")
        strHTML.Append("</tr>")
        strHTML.Append("</table></td>")
        strHTML.Append("</tr>")
        strHTML.Append("</table>")
        CommonFunctions.Data.DisposeDataReader(drArticles)
        DrawNewsArticleList_New = strHTML.ToString()
    End Function
    'End of Added by NitinC for WhizibleSEM v10.0 - New Home Page
    Private Function DrawNewsArticleList() As String
        Dim strHTML As New StringBuilder
        Dim drArticles As IDataReader
        Dim intTRCount As Integer
        Dim strTitle As String

        drArticles = CommonFunctions.Data.GetDataReader("Usp_SEL_Tbl_SEM_HomeNewsArticle", True)
        strTitle = Convert.ToString(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Usp_SEL_NewsArticles_HeaderText", True))))

        strHTML.Append("<div id=""DivMain"" style=""height:150px;width:99.99%;border:lightblue 1px outset;overflow:visible;"">")


        strHTML.Append("<Table border=0 height=20% cellspacing=0 cellpadding=0 class='clsTable' valign='top'>")
        strHTML.Append("<TR  id='trModuleBar' name='trModuleBar' class='clsTRBlank'>")
        strHTML.Append("<Td id='tdModuleBar' colspan='2'  style=""font-family:Comic Sans MS;font-size:14;font-weight:bold;"" >")
        strHTML.Append(strTitle)
        strHTML.Append("</Td>")
        strHTML.Append("</TR>")
        strHTML.Append("</table>")

        strHTML.Append("<Table cellspacing=0 cellpadding=0 class='clsTable' style=""border:none;height:6%;vertical-align:top;width:99.99%;"" >")
        strHTML.Append("<TR class='clsTRMenu' style='cursor:pointer;text-align:left;' onclick='javascript:MoveUp()'>")
        strHTML.Append("<Td align='center' style='height:15%;'><img src='../../Images/Sort_up.gif' border=0 /></td>")
        strHTML.Append("</TR>")
        strHTML.Append("</table>")

        strHTML.Append("<div id=""DivMain1"" style=""height:68%;width:99.99%;overflow:hidden;"" >")
        strHTML.Append("<Table id='TblArticles' cellspacing=0 cellpadding=0 width='99.9%' class='clsTable' valign='top' >")

        intTRCount = 0
        While drArticles.Read()
            strHTML.Append("<TR class='clsTRMenu' id='trModules' name='trModules' style='cursor:pointer;text-align:left;' onmousedown='javascript:Tab_OnClick(")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drArticles("ArticleID"), "0").ToString())
            strHTML.Append(",")
            strHTML.Append(intTRCount.ToString())
            strHTML.Append(")'  onmouseover='javascript:ModulesOnMouseOver(this)' onmouseout='javascript:ModulesOnMouseOut(this,")
            strHTML.Append(intTRCount.ToString())
            strHTML.Append(")'>")
            strHTML.Append("<Td align='left' >")
            strHTML.Append("<img src='")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drArticles("ImagePath"), "").ToString())
            strHTML.Append("' border=0 style=""vertical-align:bottom;align:left;"">")
            strHTML.Append("</Td>")
            strHTML.Append("<Td align='left'  style='cursor:pointer;text-align:left;height:15%;' id='iMenu'>")
            strHTML.Append("<A style='text-decoration:none;width:170px;' class='clsMenu'")
            strHTML.Append(" href='javascript:Tab_OnClick(")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drArticles("ArticleID"), "0").ToString())
            strHTML.Append(",")
            strHTML.Append(intTRCount.ToString())
            strHTML.Append(")'>")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(drArticles("ArticleName"), "").ToString())
            strHTML.Append("</A>")
            strHTML.Append("</Td>")
            strHTML.Append("</TR>")
            intTRCount += 1
        End While
        strHTML.Append("</table>")
        strHTML.Append("</div>")

        strHTML.Append("<Table cellspacing=0 cellpadding=0 class='clsTable' style=""border:none;height:6%;vertical-align:top;width:99.99%;"" >")
        strHTML.Append("<TR class='clsTRMenu' style='cursor:pointer;text-align:left;' onmousedown='javascript:MoveDown()'>")
        strHTML.Append("<Td align='center' style='height:15%;'><img src='../../Images/Sort_down.gif' border=0 /></td>")
        strHTML.Append("</TR>")
        strHTML.Append("</table>")
        strHTML.Append("</div>")
        CommonFunctions.Data.DisposeDataReader(drArticles)
        DrawNewsArticleList = strHTML.ToString()
    End Function

    Private Function DrawNewsArticle(ByVal m_intArticleID As Integer) As String
        Dim drArticles As IDataReader
        Dim strContent As String = ""
        Dim strPagePath As String = ""

        drArticles = CommonFunctions.Data.GetDataReader("Usp_SEL_Tbl_SEM_HomeNewsArticle " + m_intArticleID.ToString(), True)

        If drArticles.Read() Then
            strContent = CommonFunctions.Data.CheckIsDBNull(drArticles("Contents"), "").ToString()
            strPagePath = CommonFunctions.Data.CheckIsDBNull(drArticles("PagePath"), "").ToString()
        End If
        CommonFunctions.Data.DisposeDataReader(drArticles)

        If strPagePath = "" Then
            DrawNewsArticle = strContent
        Else
            Response.Redirect(strPagePath)
        End If

    End Function

End Class