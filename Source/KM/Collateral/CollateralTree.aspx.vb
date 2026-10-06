Public Class CollateralTree
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
        MyBase.ApplySecurity(True)
        If mstrFromWhere = "" Then
            mstrFromWhere = "Contents"
        End If
    End Sub


    Protected Sub DrawPage()
        'Call DrawPaging()
        Call DrawPageCapation()
    End Sub
    Protected Sub DrawPageHeadTag()
        Dim strHTML As New System.Text.StringBuilder
        Dim strSQL As String
        Dim strStyleSheet As String

        strSQL = "usp_get_StyleSheet " + HttpContext.Current.Session("intUserID").ToString
        strStyleSheet = CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)

        strHTML.Append("<HEAD>" + vbCrLf)
        strHTML.Append("<TITLE>Collateral Tree</TITLE>" + vbCrLf)
        strHTML.Append("<meta name='GENERATOR' content='Microsoft Visual Studio.NET 7.0'>" + vbCrLf)
        strHTML.Append("<meta name='CODE_LANGUAGE' content='Visual Basic 7.0'>" + vbCrLf)
        strHTML.Append("<meta name='vs_defaultClientScript' content='JavaScript'>" + vbCrLf)
        strHTML.Append("<meta name='vs_targetSchema' content='http://schemas.microsoft.com/intellisense/ie5'>" + vbCrLf)
        strHTML.Append("<meta http-equiv=""Cache-Control"" CONTENT=""no-cache"">" + vbCrLf)
        strHTML.Append("<meta http-equiv=""Pragma"" CONTENT=""no-cache"">" + vbCrLf)
        strHTML.Append("<link rel='stylesheet' type='text/css' href='../../General/" + strStyleSheet + "'/>" + vbCrLf)
        strHTML.Append("<link id='lnkWhizStyleSheetImgDir' type='text/plain' href='../../images/cssImages/'/>" + vbCrLf)
        strHTML.Append("<script language='javascript' src='../../General/CommonFunctions.js'></script>" + vbCrLf)
        strHTML.Append("<script language='javascript' src='../../General/CommonValidations.js'></script>" + vbCrLf)
        strHTML.Append("</HEAD>" + vbCrLf)

        Response.Write(strHTML.ToString)
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

        mintProductID = 0

        dr = CommonFunction.Data.GetDataReader("usp_Sel_tbl_Product_Tree", MyBase.UseSQL)

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


    End Sub
    Protected Sub DrawPaging()


    End Sub
    Private Sub DrawPageCapation()




    End Sub
End Class
