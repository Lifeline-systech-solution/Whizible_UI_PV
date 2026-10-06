
Public Class ErrorPage
    Inherits WebPages.Template.WhizTemplate
    Private strLineNo As String = ""
    Private strMessage As String = ""
    Private strErrorPageName As String = ""
    Private strSource As String = ""
    Private strInnerSource As String

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
        MyBase.ApplySecurity(True)

        If Request.QueryString("Mode").ToString = "Detail" Then
            strLineNo = CType(Request.QueryString("LineNo"), String)
            strMessage = CType(Request.QueryString("Msg"), String)
            strErrorPageName = CType(Request.QueryString("PageName"), String)
            strSource = CType(Request.QueryString("Source"), String)
            strInnerSource = CType(Request.QueryString("InnerSource"), String)
        Else
            strMessage = Request.QueryString("Msg") & ""
        End If
    End Sub
    Public Sub WriteError()
        If Request.QueryString("Mode").ToString = "Detail" Then
            WriteDetailError()
        Else
            WriteErrMsg()
        End If
    End Sub
    Private Sub WriteDetailError()

        CommonFunction.General.WriteHTML("<TABLE class=clsTable cellpadding=0 width='99.9%'" + " style=" + Chr(34) + "Z-INDEX: 101; LEFT: 11px; WIDTH: 100%; POSITION: absolute; TOP: 85px; HEIGHT: 120px" + Chr(34) + ">")
        CommonFunction.General.WriteHTML("<TR class=clsTROdd><TD colspan=2><B>" & MyBase.GetResourceString("ERROR") + "</B></TD></TR>")
        CommonFunction.General.WriteHTML("<TR class=clsTREven><TD><B>" + MyBase.GetResourceString("ERR_MSG") + "</B></TD>")
        CommonFunction.General.WriteHTML("<TD>" + strMessage + "</TD></TR>")
        CommonFunction.General.WriteHTML("<TR class=clsTREven><TD><B>" + MyBase.GetResourceString("LINE_NO") + "</B></TD>")
        CommonFunction.General.WriteHTML("<TD>" + strLineNo + "</TD></TR>")
        CommonFunction.General.WriteHTML("<TR class=clsTREven><TD><B>" + MyBase.GetResourceString("ERR_PAGE") + "</B></TD>")
        CommonFunction.General.WriteHTML("<TD>" + strErrorPageName + "</TD></TR>")
        If strSource.Trim <> "" Then
            CommonFunction.General.WriteHTML("<TR class=clsTREven><TD><B>" + MyBase.GetResourceString("SOURCE") + "</B></TD>")
            CommonFunction.General.WriteHTML("<TD>" + strSource + "</TD></TR>")
        End If
        If strInnerSource.Trim <> "" Then
            CommonFunction.General.WriteHTML("<TR class=clsTREven><TD><B>" + MyBase.GetResourceString("INNER_SOURCE") + "</B></TD>")
            CommonFunction.General.WriteHTML("<TD>" + strInnerSource + "</TD></TR>")
        End If
        CommonFunction.General.WriteHTML("<TR class=clsTREven><TD><B>" + MyBase.GetResourceString("ADDITONAL_INFO") + "</B></TD>")
        If IsDatabaseError() = False Then
            CommonFunction.General.WriteHTML("<TD>" + MyBase.GetResourceString("ADDITIONAL_INFO_MSG") + "</TD></TR></TABLE>")
        Else
            CommonFunction.General.WriteHTML("<TD><B>Database Connection Erorr:</B></TD></TR>")
            Response.Write(MyBase.GetResourceString("DB_ERROR"))
            'CommonFunction.General.WriteHTML("<TR class=clsTREven><TD>Following are the possible reasons.</TD></TR>")
            'CommonFunction.General.WriteHTML("<TR class=clsTREven><TD>1.Connection between database server and web server is borken.</TD></TR>")
            'CommonFunction.General.WriteHTML("<TR class=clsTREven><TD>2.Your database server is down.</TD></TR>")
            'CommonFunction.General.WriteHTML("<TR class=clsTREven><TD>3.Your database server password may have got changed, and the same change may not be reflected in connection string.</TD></TR></TABLE>")

        End If


    End Sub
    Private Sub WriteErrMsg()

        CommonFunction.General.WriteHTML("<TABLE class=clsTable cellpadding=0 width='99.9%'" + " style=" + Chr(34) + "Z-INDEX: 101; LEFT: 11px; WIDTH: 100%; POSITION: absolute; TOP: 85px; HEIGHT: 120px" + Chr(34) + ">")
        CommonFunction.General.WriteHTML("<TR class=clsTRODD><TD><B>" & MyBase.GetResourceString("ERROR") + "</B></TD></TR>")
        If IsDatabaseError() = False Then
            CommonFunction.General.WriteHTML("<TR class=clsTREven><TD><B>" & MyBase.GetResourceString("PLAIN_ERR_MSG") + "</B></TD></TR></TABLE>")
        Else
            CommonFunction.General.WriteHTML("<TR class=clsTREven><TD><B>Database Connection Error:" + strMessage + "</B></TD></TR>")
            Response.Write(MyBase.GetResourceString("DB_ERROR"))
            'CommonFunction.General.WriteHTML("<TR class=clsTREven><TD>Following are the possible reasons.</TD></TR>")
            'CommonFunction.General.WriteHTML("<TR class=clsTREven><TD>1.Connection between database server and web server is borken.</TD></TR>")
            'CommonFunction.General.WriteHTML("<TR class=clsTREven><TD>2.Your database server is down.</TD></TR>")
            'CommonFunction.General.WriteHTML("<TR class=clsTREven><TD>3.Your database server password may have got changed, and the same change may not be reflected in connection string.</TD></TR></TABLE>")
        End If
    End Sub
    Sub New()
        MyBase.InitializeResources("Resources.ErrorPage", "Resources")
    End Sub
    Private Function IsDatabaseError() As Boolean
        '=====================================================================
        ' Procedure Name        : IsDatabaseError
        ' Description           : The function will whether it is a database error
        ' Purpose               : Same As above
        ' Parameters Passed     : None
        '						 
        ' Returns               : 
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AshishR
        ' Created               : 31 July 2003
        ' Revisions             : 
        '=====================================================================
        If InStr(strMessage, "Specified SQL server not found", CompareMethod.Text) > 0 Then
            Return True
        End If

        If InStr(strMessage, "Login failed for user", CompareMethod.Text) > 0 Then
            Return True
        End If
        If InStr(strMessage, "Cannot open database requested", CompareMethod.Text) > 0 Then
            Return True
        End If
        Return False
    End Function
End Class
