Public Class RM_Tree
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
        ' Added By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        MyBase.ApplySecurity(True)
        ' End Added By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
    End Sub

#End Region
#Region "Variables"
    Private m_strProjectID As String
    Dim strPagingAlpha As String
#End Region
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        m_strProjectID = Session("intProjectID").ToString
        strPagingAlpha = Request.QueryString("PagingChar")
        If strPagingAlpha Is Nothing Then
            strPagingAlpha = "-1"
        End If
    End Sub
    Protected Sub DrawPage()
        Call DrawPaging()
        Call DrawPageCapation()
    End Sub
    Protected Sub DrawTreeVariables()
        Dim c As Integer = 0
        Dim dr As IDataReader
        Dim strJSTreeVariable As String
        Dim strPKToken As String

        dr = CommonFunction.Data.GetDataReader("usp_Sel_tbl_RM_ProjectRequirements_Tree " + m_strProjectID + ",'" + strPagingAlpha + "'", MyBase.UseSQL)


        CommonFunction.General.WriteHTML("<SCRIPT>")
        CommonFunction.General.WriteHTML("var Tree = new Array;")
        CommonFunction.General.WriteHTML("// nodeId | parentNodeId | nodeName | nodeUrl |Tooltip |IsParent |ImageName")
        While dr.Read
            strPKToken = CommonFunctions.Security.Token.GetToken(CType(dr("NodeID"), String) + CType(Session("intUserID"), String) + "0" + "0")
            'NodeID , ParentNodeID
            strJSTreeVariable = "'" + dr("NodeID").ToString + "|" + dr("parentNodeID").ToString + "|"
            'NodeName
            strJSTreeVariable += dr("NodeName").ToString + "|"
            'nodeUrl
            strJSTreeVariable += "../RM/ProjectRequirements_CommonPage.aspx?ProjectRequirementID_PK=" + dr("NodeID").ToString + "&PKToken=" + strPKToken + "&MasterTagID=3714&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1" + "|"
            'ToolTip
            strJSTreeVariable += dr("NodeName").ToString + "|"
            'isParent
            strJSTreeVariable += dr("IsParent").ToString + "|"
            'ImageName
            strJSTreeVariable += dr("ImageName").ToString + "';"


            CommonFunction.General.WriteHTML("Tree[" + c.ToString + "] = " + strJSTreeVariable)
            c += 1
        End While

        'CommonFunction.General.WriteHTML("createTree(Tree);")
        'CommonFunction.General.WriteHTML("OpenAllNodes();")
        CommonFunction.General.WriteHTML("</SCRIPT>")
        CommonFunction.Data.DisposeDataReader(dr)
    End Sub
    Protected Sub DrawPaging()

        CommonFunction.General.WriteHTML("<table class=clsTable width=99.8%><tr class='clsTRMenu'><td>")

        Dim objPaging As WebPage.Templates.Paging = New WebPage.Templates.Paging
        Response.Write(objPaging.DrawPaging(strPagingAlpha, "usp_Sel_tbl_RM_ProjectRequirements_Paging " + m_strProjectID, "Select"))
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr></table>")



    End Sub
    Private Sub DrawPageCapation()
        'Dim objPageCaption As WebPage.Templates.PageCaption = New WebPage.Templates.PageCaption
        CommonFunction.General.WriteHTML("<BR>")
        'objPageCaption.GetPageCaptions(, "Requirements")

        CommonFunction.General.WriteHTML("<TABLE id='tblCap00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageCaption>")
        CommonFunction.General.WriteHTML("<TD align=Left>Requirements</TD>")
        CommonFunction.General.WriteHTML("<TD align=Left>|<A class='Menu' style='TEXT-DECORATION:NONE' Title='Add Requirement' href='javascript:addRequirement_onClick()'>Add</A>|</TD>")
        CommonFunction.General.WriteHTML("</TR></TABLE>")






    End Sub
End Class
