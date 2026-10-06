Imports CommonEngines.General.cEventHandlers
Public Class Test_Session_CommonList
    Inherits CommonList



#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)

        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
        'If CType(Request.QueryString("FromXML"), Double) = 1 Then
        '    '    populateComboString()
        'End If

        'CommonFunction.General.WriteHTML("")


    End Sub

#End Region

   


    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
       
        MyBase.strListPage = "Test_Session_CommonList.aspx"
        MyBase.strFormPage = "Test_Session_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)


    End Sub

    
End Class
