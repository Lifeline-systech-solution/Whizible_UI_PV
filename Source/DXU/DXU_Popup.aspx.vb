Public Class DXU_Popup
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub

    Public Sub PageInit()
        'Put user code to initialize the page here
        Dim strSQL As String
        Dim strRequestID As String
        Dim strErrMsg As String
        strRequestID = HttpContext.Current.Request("RequestID")
        If strRequestID <> "" Then
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSQL = "Select Isnull(Errmsg,'') from tbl_DXU_UploadRequestsQueue Where RequestID=" & strRequestID
            strSQL = "usp_sel_tbl_DXU_UploadRequestsQueue_Errmsg " & strRequestID
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
            strErrMsg = CStr(CommonFunctions.Data.GetDataScalar(strSQL, True))
        End If

        Response.Write("<br>")
        Response.Write(" <TABLE  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageCaption><TD align=Left>Request Status</TD></TR></TABLE>")
        Response.Write("<br>")

        'Commented by Yogesh J on 23-NOV-2015
        'HttpContext.Current.Response.Write("<DIV Id='DivMap'" + " Style='HEIGHT:150px;'>")
        HttpContext.Current.Response.Write("<DIV Id='DivMap'" + " Style='HEIGHT:270px;'>")
        'End of comment by Yogesh J on 23-NOV-2015
        HttpContext.Current.Response.Write("<TABLE CellSpacing=0 width='99.9%' class=clsTable colspan=3><TR class=clsTREven><TD align='left'>")
        HttpContext.Current.Response.Write("<p>" & strErrMsg & "</p>")
        HttpContext.Current.Response.Write("</td></tr></Table>")
        HttpContext.Current.Response.Write("</Div>")

    End Sub

End Class
