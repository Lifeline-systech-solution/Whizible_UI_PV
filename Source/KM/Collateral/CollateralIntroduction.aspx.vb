Public Class CollateralIntroduction
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
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        MyBase.ApplySecurity(True)
        'Put user code to initialize the page here
    End Sub

    Public Sub PageInit()

        '     Dim strProductID As String
        ' Dim drIntro As IDataReader

        ' strProductID = Session("ProductID")

        Response.Write("<DIV id='ShowFeature' name='ShowFeature'  style=height:550px;overflow:auto;> ")

        ' Response.Write("<TABLE width=99.9% class=clsTable cellspacing=0 cellpadding=0><TR class=clsTRPageCaption><TD ><b> Feature Usecases</b></TD> ")

        'Response.Write("<TD align=right><a  class='Menu' style='TEXT-DECORATION:NONE'  href=javascript:Close_OnClick() > Close </a></TD></TR></TABLE> ")

        Response.Write("<TABLE width=99.9% class=clsTable cellspacing=0 cellpadding=0><TR class=clsTROdd><TD >")
        '   drIntro = CommonFunction.Data.GetDataReader("Select Product,ProductCurrentersion,IntroText from tbl_PRD_Product Where ProductID=" & strProductID, True)


        ' While drIntro.Read

        '    Response.Write(CommonFunction.Data.CheckIsDBNull(drIntro("introText"), ""))

        'End While

        'CommonFunction.Data.DisposeDataReader(drIntro)
        Commonfunction.General.WriteHTML("Collaterals")
        Response.Write("</td></tr></table>")

        Response.Write("</div>")
    End Sub


End Class
