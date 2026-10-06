Public Partial Class ProductFeatureTree
    Inherits WebPages.Template.WhizTemplate
    Public mstrFromWhere As String
    Public mintProductID As Integer



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
#Region "Variables"
    'Private m_strProjectID As String
    Dim strPagingAlpha As String
    Public mintMax As Integer
#End Region
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        Dim strSql As String
        Dim strFrom As String

        mintProductID = Session("ProductID")

        'Put user code to initialize the page here
        'm_strProjectID = Session("intProjectID").ToString
        strPagingAlpha = Request.QueryString("PagingChar")
        If strPagingAlpha Is Nothing Then
            strPagingAlpha = "-1"
        End If

        mstrFromWhere = Request.QueryString("HelpFromWhere")
        If mstrFromWhere = "" Then
            mstrFromWhere = "Contents"
        End If

        If mstrFromWhere = "Favorites" Then

            If Request.QueryString("Mode") = "Add" And CommonFunction.General.CheckIsNothing(Session("CurrentFeature"), "") <> "" Then
                strSql = " Exec  usp_Ins_FavoriteFeature " & Session("intuserID") & ",'" & Session("LoginType") & "'," & Session("CurrentFeature") & "," & CStr(mintProductID)
                CommonFunction.Data.GetDataScalar(strSql, True)
            End If

            If Request.QueryString("Mode") = "Remove" Then

                strSql = " delete From tbl_PRD_FavoriteFeatures Where UserID= " & Session("intUserID")
                strSql = strSql & " And LoginType='" & Session("LoginType") & "' And FeatureID=" & Request.QueryString("RemoveFeatureID")

                CommonFunction.Data.GetDataScalar(strSql, True)
            End If


        End If
    End Sub


    Protected Sub DrawPage()
        'Call DrawPaging()
        Call DrawPageCapation()
    End Sub
    Protected Sub DrawTreeVariables()
        Dim c As Integer = 0
        Dim dr As IDataReader
        Dim ds As DataSet
        Dim strJSTreeVariable As String
        Dim strPKToken As String
        Dim intFoundCount As Integer
        Dim strTech As String
        Dim strsql As String


        If mstrFromWhere = "Contents" Then

            dr = CommonFunction.Data.GetDataReader("usp_Sel_tbl_ProductFeature_Tree " + CStr(mintProductID) + ",'" + strPagingAlpha + "'", MyBase.UseSQL)


            CommonFunction.General.WriteHTML("<SCRIPT>")
            CommonFunction.General.WriteHTML("var Tree = new Array;")
            CommonFunction.General.WriteHTML("// nodeId | parentNodeId | nodeName | nodeUrl |Tooltip |IsParent |ImageName")
            While dr.Read
                'strPKToken = CommonFunctions.Security.Token.GetToken(CType(dr("NodeID"), String) + CType(Session("intUserID"), String) + "0" + "0")
                'NodeID , ParentNodeID
                strJSTreeVariable = "'" + dr("NodeID").ToString + "|" + dr("parentNodeID").ToString + "|"
                'NodeName
                strJSTreeVariable += CommonFunction.General.BuildQueryString(dr("NodeName").ToString) + "|"
                'nodeUrl
                strJSTreeVariable += dr("PageName").ToString + "|"
                '"../Knowledge/DisplayFeatureDetails.aspx?FeatureID=" + dr("NodeID").ToString + "&PKToken=" + strPKToken + "&MasterTagID=3714&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1" + "|"
                'ToolTip
                strJSTreeVariable += dr("NodeName").ToString + "|"
                'isParent
                strJSTreeVariable += dr("IsParent").ToString + "|"
                'ImageName
                strJSTreeVariable += dr("ImageName").ToString + "';"


                CommonFunction.General.WriteHTML("Tree[" + c.ToString + "] = " + strJSTreeVariable)
                c += 1
            End While

            CommonFunction.General.WriteHTML("createTree(Tree);")
            'CommonFunction.General.WriteHTML("oc(4,0);")
            CommonFunction.General.WriteHTML("</SCRIPT>")
            CommonFunction.Data.DisposeDataReader(dr)
        Else
            If mstrFromWhere = "Index" Then
                mintMax = 0
                Response.Write("<Div class=divListTag id='PageDiv' Style='OVERFLOW:auto; WIDTH:99.9%';'>")

                Response.Write("<Table class=clstable  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clstreven><TD >")
                Response.Write("Type in keywords to find: ")
                Response.Write("</TD></TR><TR class=clstreven><TD>")
                'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                '' CommonFunction.HTMLControls.DrawTextBox("txtIndex", "txtIndex", "clstextbox", 210, , , , , , , , , " onkeypress=txtIndex_OnKeyPress(event)")
                CommonFunction.HTMLControls.DrawTextBox("txtIndex", "txtIndex", "clstextbox", 210, , , , , , , , , " onkeypress=txtIndex_OnKeyPress(event)", EnableHTMLEncode:=True)
                'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding


                Response.Write("</TD></TR></TABLE></DIV>")
                Response.Write("<Div class=divListDetail id='PageDiv' Style=';OVERFLOW:auto; WIDTH:99.9%';'>")
                Response.Write("<Table class=clstable  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clstreven><TD >")

                ' <TR class=clstreven><TD>")

                dr = CommonFunction.Data.GetDataReader("Select Feature,ProductFeatureID from tbl_PRD_ProductFeature " + " WHERE ProductID = " + CStr(mintProductID) + " order by feature", MyBase.UseSQL)

                Response.Write(" <select size=2 multiple id='lstFeatureList' name='lstFeatureList' class=clsCombobox style='height:400;width:220;'  ondblclick='javascript:lstFeatureList_OnDblClick()'>")
                While dr.Read
                    mintMax = mintMax + 1
                    Response.Write("<option value=" & CStr(dr("ProductFeatureID")) & ">" & CStr(dr("Feature")) & "</option>")
                End While

                CommonFunction.Data.DisposeDataReader(dr)

                Response.Write("</Select>")
                Response.Write("</TD></TR></TABLE></Div>")


            Else
                'Response.Write(mstrFromWhere)
                If mstrFromWhere = "Search" Then

                    Dim strSearchText As String
                    strSearchText = CommonFunction.General.CheckIsNothing(Request.QueryString("SearchText"), "")


                    Response.Write("<Table class=clstable  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clstreven><TD colspan=2 >")
                    Response.Write("Type in word(s) to search for: ")
                    Response.Write("</TD></TR><TR class=clstreven><TD colspan=2>")
                    'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                    ''CommonFunction.HTMLControls.DrawTextBox("txtSearch", "txtSearch", "clstextbox", 210, , strSearchText, , , , , , , " onkeypress=txtSearch_OnKeyPress(event)")
                    CommonFunction.HTMLControls.DrawTextBox("txtSearch", "txtSearch", "clstextbox", 210, , strSearchText, , , , , , , " onkeypress=txtSearch_OnKeyPress(event)", EnableHTMLEncode:=True)
                    'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding


                    Response.Write("</TD></TR><TR class=clstreven><TD>")
                    CommonFunctions.General.WriteHTML("<input class=ButtonStyle id=topics type=button value='List Topics' onclick=""ListTopic_OnClick()"">")
                    Response.Write("</TD><TD>")
                    CommonFunctions.General.WriteHTML("<input class=ButtonStyle id=display type=button value='Display' onclick=""Display_OnClick()"">")
                    If strSearchText <> "" Then

                        strTech = Request.QueryString("Tech")
                        ds = New DataSet
                        ds = CommonFunction.Data.GetDataSet("Exec usp_SearchInFeature '" & CommonFunction.General.BuildQueryString(strSearchText) & "'," & strTech & "," & CStr(mintProductID), MyBase.UseSQL)
                        intFoundCount = ds.Tables(0).Rows.Count()

                        Response.Write("</TD></TR><TR class=clstreven><TD > Select Topic </TD><TD> Found : " & CStr(intFoundCount) & " </TD></TR>")

                        Response.Write("<TR class=clstreven><TD colspan=2>")

                        Response.Write(" <select size=2 multiple id='lstSearchFeatureList' name='lstSearchFeatureList' class=clsCombobox style='height:300;width:220;'  ondblclick='javascript:lstSearchFeatureList_OnDblClick()'>")
                        Dim DataRow As DataRow

                        For Each DataRow In ds.Tables(0).Rows

                            Response.Write("<option value=" & CStr(DataRow("ProductFeatureID")) & ">" & CStr(DataRow("Feature")) & "</option>")
                        Next

                        ds = Nothing
                        DataRow = Nothing


                        Response.Write("</Select>")
                    Else
                        Response.Write("</TD></TR><TR class=clstreven><TD > Select Topic </TD><TD> Found :  </TD></TR>")
                        Response.Write("<TR class=clstreven><TD colspan=2>")

                        Response.Write(" <select size=2 multiple id='lstSearchFeatureList' name='lstSearchFeatureList' class=clsCombobox style='height:300;width:220;'  ondblclick='javascript:lstSearchFeatureList_OnDblClick()'>")
                        Response.Write("</Select>")
                    End If

                    'Response.Write("</TD></TR><TR class=clstreven><TD colspan=2>")
                    'CommonFunction.HTMLControls.DrawCheckBox("chkTitle", "chkTitle", , False, "0", , , , False)
                    'Response.Write("Search Titles ")
                    Response.Write("</TD></TR><TR class=clstreven><TD colspan=2>")

                    If strTech = "0" Then
                        CommonFunction.HTMLControls.DrawCheckBox("chkTech", "chkTech", , False, "0", , , , False)
                    Else
                        CommonFunction.HTMLControls.DrawCheckBox("chkTech", "chkTech", , True, "0", , , , False)
                    End If
                    Response.Write("Search in Technical details ")
                    Response.Write("</TD></TR></Table>")



                End If

            End If
        End If

        If mstrFromWhere = "Favorites" Then

            Response.Write("<Table class=clstable  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clstreven><TD colspan=2 >")
            Response.Write("Topics: ")
            Response.Write("</TD></TR>")

            Response.Write("<TR class=clstreven><TD colspan=2>")

            Response.Write(" <select size=2 multiple id='lstFavoriteList' name='lstFavoriteList' class=clsCombobox style='height:300;width:220;'  ondblclick='javascript:lstFavoriteList_OnDblClick()'>")

            strsql = "Exec usp_sel_GetFavoriteFeature " & Session("intUserID") & "," & CStr(mintProductID)

            dr = CommonFunction.Data.GetDataReader(strsql, True)

            While dr.Read

                Response.Write("<option value=" & CStr(dr("ProductFeatureID")) & ">" & CStr(dr("Feature")) & "</option>")

            End While

            CommonFunction.Data.DisposeDataReader(dr)

            Response.Write("</TD></TR><TR class=clstreven><TD>")
            CommonFunctions.General.WriteHTML("<input class=ButtonStyle id=topics type=button value='Remove' onclick=""Remove_OnClick()"">")
            Response.Write("</TD><TD>")
            CommonFunctions.General.WriteHTML("<input class=ButtonStyle id=display type=button value='Display' onclick=""DisplayFav_OnClick()"">")

            Response.Write("</TD></TR><TR class=clstreven><TD colspan=2 align=left>Current Topic: </TD></TR>")
            Response.Write("<TR class=clstreven><TD colspan=2>")
            Response.Write("  " & Session("CurrentFeatureDesc"))
            Response.Write("</TD></TR>")

            Response.Write("<TR class=clstreven><TD colspan=2 align=right>")
            CommonFunctions.General.WriteHTML("<input class=ButtonStyle id=display type=button value='Add' onclick=""AddFav_OnClick()"">")
            Response.Write("</TD></TR></TABLE>")



        End If


    End Sub
    Protected Sub DrawPaging()


    End Sub
    Private Sub DrawPageCapation()
        'Dim objPageCaption As WebPage.Templates.PageCaption = New WebPage.Templates.PageCaption
        ' CommonFunction.General.WriteHTML("<BR>")
        'objPageCaption.GetPageCaptions(, "Requirements")

        CommonFunction.General.WriteHTML("<TABLE id='tblCap00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTableNavLinks><TR class=clsTRNavLinks valign=middle>")
        'CommonFunction.General.WriteHTML("<TD align=Left>Product Features</TD>")

        CommonFunction.General.WriteHTML("<td   align=Left>")
        If mstrFromWhere = "Contents" Then
            Response.Write("<a class=menuclsSelected href='javascript:Tab_OnClick(" & Chr(34) & "Contents" & Chr(34) & ")'>")
            Response.Write(CommonFunction.General.FormatString(Server.HtmlEncode("Contents")))
            Response.Write("</a>")
        Else
            Response.Write("<a class=menunavtab href='javascript:Tab_OnClick(" & Chr(34) & "Contents" & Chr(34) & ")'>")
            Response.Write(CommonFunction.General.FormatString(Server.HtmlEncode("Contents")))
            Response.Write("</a>")
        End If

        If mstrFromWhere = "Index" Then
            Response.Write("<a class=menuclsSelected href='javascript:Tab_OnClick(" & Chr(34) & "Index" & Chr(34) & ")'>")
            Response.Write(CommonFunction.General.FormatString(Server.HtmlEncode("Index")))
            Response.Write("</a>")
        Else
            Response.Write("<a class=menunavtab href='javascript:Tab_OnClick(" & Chr(34) & "Index" & Chr(34) & ")'>")
            Response.Write(CommonFunction.General.FormatString(Server.HtmlEncode("Index")))
            Response.Write("</a>")
        End If


        If mstrFromWhere = "Search" Then
            Response.Write("<a class=menuclsSelected href='javascript:Tab_OnClick(" & Chr(34) & "Search" & Chr(34) & ")'>")
            Response.Write(CommonFunction.General.FormatString(Server.HtmlEncode("Search")))
            Response.Write("</a>")
        Else
            Response.Write("<a class=menunavtab href='javascript:Tab_OnClick(" & Chr(34) & "Search" & Chr(34) & ")'>")
            Response.Write(CommonFunction.General.FormatString(Server.HtmlEncode("Search")))
            Response.Write("</a>")
        End If


        If mstrFromWhere = "Favorites" Then
            Response.Write("<a class=menuclsSelected href='javascript:Tab_OnClick(" & Chr(34) & "Favorites" & Chr(34) & ")'>")
            Response.Write(CommonFunction.General.FormatString(Server.HtmlEncode("Favorites")))
            Response.Write("</a>")
        Else
            Response.Write("<a class=menunavtab href='javascript:Tab_OnClick(" & Chr(34) & "Favorites" & Chr(34) & ")'>")
            Response.Write(CommonFunction.General.FormatString(Server.HtmlEncode("Favorites")))
            Response.Write("</a>")
        End If

        'CommonFunction.General.WriteHTML("<TD align=Left>|<A class='Menu' style='TEXT-DECORATION:NONE' Title='Add Requirement' href='javascript:addRequirement_onClick()'>Add</A>|</TD>")
        CommonFunction.General.WriteHTML("</td></TR></Table>")



    End Sub



End Class