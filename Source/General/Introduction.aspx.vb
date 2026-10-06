Public Class Introduction
    Inherits WebPages.Template.WhizTemplate

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

    Private strFromWhere As String
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        MyBase.ApplySecurity(True)
        'Put user code to initialize the page here
        If Not Request.QueryString("FromWhere") Is Nothing Then
            strFromWhere = CommonFunction.General.BuildQueryString(Request.QueryString("FromWhere").ToString)
        End If

    End Sub
    Public Sub GetModuleIntroduction()

        Dim objSystemModules As CommonEngines.HashTables.SystemModules

        If CType(MyBase.DefaultUILCID, Integer) = MyBase.CurrentThreadUICultureID Then
            objSystemModules = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObject("SystemModules", strFromWhere)
        Else
            'If current thread ui culture id is supported by the system then only
            If InStr(CommonFunction.General.GetApplicationKeySetting("SupportedUICultureIDs"), CType(MyBase.CurrentThreadUICultureID, String)) > 0 Then
                objSystemModules = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObject("SystemModules" + MyBase.CurrentThreadUICultureID.ToString, strFromWhere)
            Else
                objSystemModules = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObject("SystemModules", strFromWhere)
            End If

        End If
        If Not objSystemModules Is Nothing Then
            Response.Write(objSystemModules.Introduction)
        End If
        objSystemModules = Nothing
    End Sub

End Class
