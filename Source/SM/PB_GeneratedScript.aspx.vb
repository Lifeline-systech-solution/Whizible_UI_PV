Imports ScriptGenerator
Imports System.Text
Public Class PB_GeneratedScript
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


    Public Sub PageInit()
        '######### Page Code starts here
        Dim sbScript As New StringBuilder
        Dim objScriptGenerator As New ScriptGenerator.ScriptGenerator
        Dim strError As String = ""
        Dim strFilePath As String
        Dim strRedirectPath As String
        Dim strPath As String = System.AppDomain.CurrentDomain.BaseDirectory
        strRedirectPath = strPath

        strRedirectPath = strRedirectPath.Remove(strRedirectPath.Length - 1, 1)
        strRedirectPath = strRedirectPath.Remove(0, strRedirectPath.LastIndexOf("/"))
        strRedirectPath = "\\" + System.Environment.MachineName + strRedirectPath + "\"
        strRedirectPath = strRedirectPath.Replace("/", "\") + "Scripts\"

        'Response.Clear()
        'Response.ContentType = "Application/pdf/html/csv/excel/rtf/xml/text/msp/sql"

        If Not Request.QueryString("TagID") Is Nothing Then
            'Initialize the script generator class properties 
            objScriptGenerator.SQLConnectionString = CommonFunction.General.BuildConnectionString(CType(CommonFunction.General.GetApplicationKeySetting("ConnectionString"), String))
            objScriptGenerator.WhereField = "TagID"
            objScriptGenerator.WhereValue = Request.QueryString("TagID")
            If CType(Request.QueryString("TagID"), Long) < 50000 Then
                objScriptGenerator.TemplateID = "TagMasterDetails"
            Else
                objScriptGenerator.TemplateID = "TagMasterDetails_User"
            End If
            strFilePath = strPath + "Scripts\ScriptGenerator.mdb"
            'strFilePath = CommonFunction.FileDirectory.CleanPath(strFilePath)
            strFilePath = strFilePath.Replace("/", "\")
            objScriptGenerator.AccessPath = strFilePath

            'invoke the method
            sbScript = objScriptGenerator.GenerateScript(strError)
            'if no error occure the write the file and redirect to that file
            If strError = "" Then
                strFilePath = strPath + "Scripts\"
                strFilePath = CommonFunction.FileDirectory.CleanPath(strFilePath)
                strFilePath = strFilePath.Replace("/", "\")
                If CommonFunction.FileDirectory.IsFileExists(strFilePath + "DATA_tbl_UI_TagMaster_" + objScriptGenerator.WhereValue + ".sql") = True Then
                    CommonFunction.FileDirectory.DeleteFile(strFilePath + "DATA_tbl_UI_TagMaster_" + objScriptGenerator.WhereValue + ".sql")
                End If
                CommonFunction.FileDirectory.WriteFileStream(strFilePath, "DATA_tbl_UI_TagMaster_" + objScriptGenerator.WhereValue + ".sql", sbScript.ToString)
                'Dim strTemp As String
                'strTemp = strFilePath
                strFilePath = strRedirectPath + "DATA_tbl_UI_TagMaster_" + objScriptGenerator.WhereValue + ".sql"
                'CommonFunction.FileDirectory.WriteFileStream(strTemp, "Path.txt", strFilePath + vbCrLf)
                Response.Redirect(strFilePath)
                'Response.AddHeader("Content-Disposition", "Generated Script;filename=" + "DATA_tbl_UI_TagMaster_" + objScriptGenerator.WhereValue + ".sql")
                'Response.WriteFile(strFilePath)
                'else write the error message to page
            Else
                Response.Write(strError)
            End If

        End If

    End Sub

    Public Sub New()
        'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.InitializeResources("Resources.PB_GeneratedScript", "Resources")
    End Sub

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub
End Class
