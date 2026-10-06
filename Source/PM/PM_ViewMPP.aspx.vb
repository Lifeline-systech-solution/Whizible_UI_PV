Public Class PM_ViewMPP
    'Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate
    '=====================================================================
    ' Class Name            :	PM_ViewMPP
    ' Purpose               :	Page used for viewing the MPP File
    ' Description           :	Filename is passed to this page, which open it from "Attachments/PM" folder.
    ' Assumptions           :	None.
    ' Dependencies          :	None.
    ' Author                :	SuryabirD
    ' Created               :	Feb 19, 2004
    ' Revisions             :
    '=====================================================================
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
        ' allow content types for all report formats
        'Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.ApplySecurity(True)
        'End Of Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        Response.Clear()

        'Modified by NitinVS on 21 Aug 2007 for WhizibleSEM 7 
        ' Changed the Content Type to application/octet-stream as suggested by framework team in 2.0.07-SP8-WAF Hotfix 
        'Response.ContentType = "Application/pdf/html/csv/excel/rtf/xml/text/msp"
        Response.ContentType = "application/octet-stream"
        'End Modification by NitinVs on 21 Aug 2007 for WhizibleSEM 7
        Try
            Dim strFilePath As String
            Dim strFromWhere As String

            ' get the path for reports folder
            strFromWhere = CommonFunctions.General.CheckIsNothing(Request.QueryString("FromWhere"), "").Trim
            strFilePath = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Attachments/" + strFromWhere))
            strFilePath += Request.QueryString("FileName").Trim


            ' add the file name to the header
            Response.AddHeader("Content-Disposition", "attachment;filename=" + Request.QueryString("FileName").Trim)

            ' if the file exists write the file
            If CommonFunctions.FileDirectory.IsFileExists(strFilePath) Then
                Response.WriteFile(strFilePath)
            Else
                Throw New Exception("Cannot open the file." + vbCrLf + "The file was not found at the path!")
            End If
            Response.Flush()
        Catch exc As Exception
            exc.Source = "PM_ViewMPP.aspx->Page_Load()"
            Throw exc
        End Try
    End Sub
End Class
