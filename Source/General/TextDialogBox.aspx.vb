Public Class TextDialogBox
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub
    Public Sub DrawPage()
        

        Dim strTitle As String = Request.QueryString("Title")


        CommonFunctions.General.WriteHTML("<TABLE Width='99.9%' cellpadding=0 class=clsTable cellSpacing=0>")
        If strTitle.Trim <> "" Then
            CommonFunctions.General.WriteHTML("<TR><TD>")
            CommonFunctions.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, , , "Enter " + strTitle, True))
            CommonFunctions.General.WriteHTML("</TR></TD>")
        End If
        CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD align=center>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'CommonFunction.HTMLControls.DrawTextArea("txtText", "txtText", , , , , , , 500, 400)
        CommonFunction.HTMLControls.DrawTextArea("txtText", "txtText", , , , , , , 500, 400, EnableHTMLEncode:=True)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.General.WriteHTML("</TD></TR>")
        CommonFunctions.General.WriteHTML("<TR class=clsTRODD><TD align=center>")
        CommonFunctions.General.WriteHTML("<Input type=button Value=Ok name=cmdOk  style='Width=100px' onClick=doOK()>&nbsp;&nbsp;<Input type=button style='Width=100px' Value=Cancel name=cmdCancel onClick=doCancel()></TD></TR></TABLE>")

    End Sub
End Class
