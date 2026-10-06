Public Class DM_ViewDocument
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
        'Put user code to initialize the page here
        ' Added By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        MyBase.ApplySecurity(True)
        ' End Added By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting

        Response.Clear()
        Response.ContentType = "Application/pdf/html/csv/excel/rtf/xml/text/msp"
        Try
            Dim strFilePath As String = ""
            Dim strDirectoryName As String = ""
            Dim strFileName As String = ""
            Dim strOriginalFileName As String = ""
            Dim strDocumentID As String = ""
            Dim strInitiativeID As String = ""
            Dim strSQL As String = ""
            Dim objDr As IDataReader

            strDocumentID = CommonFunctions.General.CheckIsNothing(Request.QueryString("DocumentID"), "")

            'Code added by SwatiC on 12 Mar 2008 For Template Download
            If CommonFunctions.General.CheckIsNothing(Request.QueryString("FromWhere"), "") = "Template" Then

                Dim m_NatureOfDemandID, m_RequestStageID, m_RevisionID As String

                m_NatureOfDemandID = CommonFunctions.General.CheckIsNothing(Request.QueryString("DemandID"), "0")
                m_RequestStageID = CommonFunctions.General.CheckIsNothing(Request.QueryString("StageID"), "0")
                m_RevisionID = CommonFunctions.General.CheckIsNothing(Request.QueryString("RevisionID"), "0")

                strOriginalFileName = CommonFunctions.Data.GetDataScalar("Usp_Sel_OriginalFileName_Template  " + strDocumentID.ToString + ", " + m_NatureOfDemandID + ", " + m_RequestStageID + ", " + m_RevisionID, MyBase.UseSQL)
                strFileName = strOriginalFileName

                ' create the path for the file to open
                strFilePath = Server.MapPath("../../Documents/Templates/")
                strFilePath += strFileName.Trim
            Else
                'End of Code addition by SwatiC on 12 Mar 2008 For Template Download

                strInitiativeID = CommonFunctions.Data.GetDataScalar("select IdeaID from tbl_IM_InitiativeDocuments where DocumentID=" + strDocumentID.ToString, True)

                strOriginalFileName = CommonFunctions.Data.GetDataScalar("usp_sel_originalFileName " + strDocumentID.ToString, True)

                'get the name of the file and name of the directory for the given documentID and projectID
                strSQL = "usp_sel_tbl_im_Initiativedocuments " + strInitiativeID.Trim + "," + strDocumentID.Trim + ",'I'"
                objDr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                If objDr.Read Then
                    strDirectoryName = CommonFunctions.Data.CheckIsDBNull(objDr("DirectoryName"), "").ToString + ""
                    strFileName = CommonFunctions.Data.CheckIsDBNull(objDr("FileName"), "").ToString + ""
                End If
                CommonFunctions.Data.DisposeDataReader(objDr)

                ' create the path for the file to open
                strFilePath = Server.MapPath("../../Documents/")
                strFilePath += strDirectoryName.Trim + "\" + strFileName.Trim
                'Code added by SwatiC on 12 Mar 2008 For Template Download
            End If
            'End of Code addition by SwatiC on 12 Mar 2008 For Template Download

            'add the file name to the header
            Response.AddHeader("Content-Disposition", "attachment;filename=" + strOriginalFileName.ToString)

            Dim iStream As System.IO.Stream

            ' Buffer to read 10K bytes in chunk:
            Dim buffer(10000) As Byte

            ' Length of the file:
            Dim length As Integer

            ' Total bytes to read:
            Dim dataToRead As Long

            ' Identify the file to download including its path.
            Dim filepath As String = strFileName

            ' Identify the file name.
            Dim filename As String = System.IO.Path.GetFileName(strFilePath)
            If CommonFunctions.FileDirectory.IsFileExists(strFilePath) Then
                Try
                    ' Open the file.
                    iStream = New System.IO.FileStream(strFilePath, System.IO.FileMode.Open, _
                                                            IO.FileAccess.Read, IO.FileShare.Read)
                    ' Total bytes to read:
                    dataToRead = iStream.Length
                    Response.ContentType = "application/octet-stream"
                    Response.AddHeader("Content-Disposition", "attachment; filename=" & strOriginalFileName)
                    ' Read the bytes.
                    While dataToRead > 0
                        ' Verify that the client is connected.
                        If Response.IsClientConnected Then
                            ' Read the data in buffer
                            length = iStream.Read(buffer, 0, 10000)
                            ' Write the data to the current output stream.
                            Response.OutputStream.Write(buffer, 0, length)
                            ' Flush the data to the HTML output.
                            Response.Flush()

                            ReDim buffer(10000) ' Clear the buffer
                            dataToRead = dataToRead - length
                        Else
                            'prevent infinite loop if user disconnects
                            dataToRead = -1
                        End If
                    End While
                Catch ex As Exception
                    ' Trap the error, if any.
                    Response.Write("Error : " & ex.Message)
                Finally
                    If IsNothing(iStream) = False Then
                        ' Close the file.
                        iStream.Close()
                    End If
                End Try
            Else
                Throw New Exception("Cannot open the file." + vbCrLf + "The file was not found at the path!")
            End If

            Response.Flush()

        Catch exc As Exception
            exc.Source = "IM_ViewDocument.aspx->Page_Load()"
            Throw exc
        End Try
    End Sub

End Class
