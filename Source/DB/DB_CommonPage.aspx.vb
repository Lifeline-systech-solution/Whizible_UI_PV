Public Class DB_CommonPage
    Inherits System.Web.UI.Page

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
    'Addition by MonikaI on 21st Aug 2006 For WhizibleSEM SP7
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim blnIsMasterTag As Boolean
        Dim sbScript As System.Text.StringBuilder
        Dim drInfo As IDataReader
        Dim strDependentControlName, strCboValue As String

        If Not Request.QueryString.Get("DependentControlName") Is Nothing Then
            strDependentControlName = Request.QueryString.Get("DependentControlName").ToString
            If Not strDependentControlName = "" Then
                If Not Request.QueryString.Get("CboValue") Is Nothing Then
                    strCboValue = Request.QueryString.Get("CboValue").ToString
                End If
            End If
        End If
        Response.ContentType = "text/html"

        sbScript = New System.Text.StringBuilder

        Dim strProc As String

        If strCboValue = "" Then
            strProc = "usp_sel_WhizToday_Resource " & Session("intUserID").ToString
        Else
            strProc = "usp_sel_WhizToday_Resource " & Session("intUserID").ToString & "," & strCboValue
        End If

        drInfo = CommonFunctions.Data.GetDataReader(strProc, True)

        While drInfo.Read
            sbScript.Append("|" + CType(CommonFunctions.General.CheckIsNothing(drInfo.Item(1)), String) + "->" + CType(CommonFunctions.General.CheckIsNothing(drInfo.Item(0)), String))
        End While

        sbScript.Append("::")

        CommonFunctions.Data.DisposeDataReader(drInfo)
        Response.Write(sbScript.ToString)
    End Sub

End Class
