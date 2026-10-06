Public Class ftb_inserttable
    ' Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate ' Added By Sanyogeeta on 10-10-2016  For Apply Security
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
        ' Added By Sanyogeeta on 10-10-2016  For Apply Security
        MyBase.ApplySecurity(True)
        ' End Added By Sanyogeeta on 10-10-2016 For Apply Security
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub

End Class
