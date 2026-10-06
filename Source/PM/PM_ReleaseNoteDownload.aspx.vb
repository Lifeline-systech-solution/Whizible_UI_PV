Public Class PM_ReleaseNoteDownload
    ''Inherits System.Web.UI.Page
    Inherits WebPage.Templates.WhizTemplate
    '=====================================================================
    ' Class Name            :	PM_ReleaseNoteDownload
    ' Purpose               :	Page used for viewing the the Release files
    ' Description           :	Opens the file identified by the FileID passed through query string
    ' Assumptions           :	None.
    ' Dependencies          :	None.
    ' Author                :	AbhijeetD
    ' Created               :	Apr 24, 2004
    ' Revisions             :
    '=====================================================================

    Private Const SUBTAGID_RELEASE_FILES As Long = 75

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

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ''Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        ''End of Addition by Dhanashri S on 10 Oct 2016
        Dim strSQL As String
        Dim strSourceFilePath As String
        Dim strDestFilePath As String
        Dim strAttFolderPath As String
        Dim drFileInfo As IDataReader
        Dim strFileName As String


        'Modified by NitinVS on 21 Aug 2007 for WhizibleSEM 7 
        ' Changed the Content Type to application/octet-stream as suggested by framework team in 2.0.07-SP8-WAF Hotfix 
        ' allow content types for all report formats
        'Response.ContentType = "Application/pdf/html/csv/excel/rtf/xml/text/msp"
        Response.ContentType = "application/octet-stream"
        'End Modification by NitinVs on 21 Aug 2007 for WhizibleSEM 7
        Try
            'get the attachment folder path

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSQL = "SELECT AttachmentFolderPath FROM tbl_UI_SubTagMaster WHERE SubTagID = " + SUBTAGID_RELEASE_FILES.ToString
            strSQL = "usp_sel_tbl_UI_SubTagMaster_AttachmentFolderPath_SubTagID " + SUBTAGID_RELEASE_FILES.ToString
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016


            strAttFolderPath = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))).ToString

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSQL = "SELECT * FROM tbl_PM_ReleaseFiles WHERE FileID = " + CommonFunction.General.CheckIsNothing(Request.QueryString("FileID"), "0")
            strSQL = "usp_sel_tbl_PM_ReleaseFiles_FileID " + CommonFunction.General.CheckIsNothing(Request.QueryString("FileID"), "0")
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            'Read the file information and set the source and destination file paths
            drFileInfo = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drFileInfo.Read Then
                strFileName = CommonFunction.Data.CheckIsDBNull(drFileInfo("FileName")).ToString
                strAttFolderPath += "/" + CommonFunction.Data.CheckIsDBNull(drFileInfo("DirName"), "").ToString

                strSourceFilePath = HttpContext.Current.Server.MapPath(strAttFolderPath + "/" + CommonFunction.Data.CheckIsDBNull(drFileInfo("SystemFileName"), "").ToString)

                strDestFilePath = HttpContext.Current.Server.MapPath(strAttFolderPath + "/" + CommonFunction.Data.CheckIsDBNull(drFileInfo("FileName"), "").ToString)

                If Not CommonFunctions.FileDirectory.IsFileExists(strSourceFilePath) Then
                    Throw New Exception("Cannot open the file." + vbCrLf + "The file was not found at the path!")
                End If

                If Not (CommonFunctions.FileDirectory.IsFileExists(strDestFilePath)) Then
                    CommonFunction.FileDirectory.CopyFile(strSourceFilePath, strDestFilePath, True)
                End If

                Response.AddHeader("Content-Disposition", "attachment;filename=" + CommonFunction.Data.CheckIsDBNull(drFileInfo("FileName"), "").ToString.Trim)
            End If
            CommonFunction.Data.DisposeDataReader(drFileInfo)

            ' if the file exists write the file
            If CommonFunctions.FileDirectory.IsFileExists(strDestFilePath) Then
                Response.WriteFile(strDestFilePath)
            Else
                Throw New Exception("Cannot open the file." + vbCrLf + "The file was not found at the path!")
            End If
            Response.Flush()
        Catch ex As Exception
            ex.Source = "PB_ReleaseNoteDownload.aspx->PageLoad()"
            Throw ex
        End Try
    End Sub
End Class
