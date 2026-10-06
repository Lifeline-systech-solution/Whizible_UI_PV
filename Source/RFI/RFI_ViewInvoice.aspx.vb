'=====================================================================
' Module Name       :   RFI_ViewInvoice
' Purpose           :   To show RFI Invoice
' Description       :   Same as above
' Dependencies      :   None
' Author            :   DipaliS
' Created           :   August 26, 2004
' Revisions         :
'=====================================================================

Imports CommonFunctions
Public Class RFI_ViewInvoice
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
        ' Added  By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
        MyBase.ApplySecurity(True)
        ' End Added  By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting


    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        ' allow content types for all report formats
        Dim strFileName As String = ""
        Response.Clear()

        'Modified by NitinVS on 21 Aug 2007 for WhizibleSEM 7 
        ' Changed the Content Type to application/octet-stream as suggested by framework team in 2.0.07-SP8-WAF Hotfix 
        'Response.ContentType = "Application/pdf/html/csv/excel/rtf/xml/text"
        Response.ContentType = "application/octet-stream"
        'End Modification by NitinVs on 21 Aug 2007 for WhizibleSEM 7
        Try
            Dim strFilePath As String

            ' get the path for reports folder
            strFilePath = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Reports/"))
            strFilePath += Request.QueryString("FileName").Trim
            strFileName = Request.QueryString("FileName").Trim
            ' add the file name to the header
            Response.AddHeader("Content-Disposition", "attachment;filename=" + strFileName)


            ' if the file exists write the file
            If CommonFunctions.FileDirectory.IsFileExists(strFilePath) Then
                'Response.WriteFile(strFilePath)
                Call ViewDocument(strFilePath)
            Else
                Throw New Exception("Cannot open the file." + vbCrLf + "The file was not found at the path!")
            End If
            Response.Flush()
        Catch exc As Exception
            exc.Source = "RFI_ViewInvoice.aspx->Page_Load()"
            Throw exc
        End Try
    End Sub

    'Integrated by Harshda d for for  Whiz SP4 IssueID 432
    'Added by PrajaktaR on 10 May 2005 for IssueID 15610 of 4L 
    Sub ViewDocument(ByVal strFile As String)
        Dim iStream As System.IO.Stream

        ' Buffer to read 10K bytes in chunk:
        Dim buffer(10000) As Byte

        ' Length of the file:
        Dim length As Integer

        ' Total bytes to read:
        Dim dataToRead As Long

        ' Identify the file to download including its path.
        Dim filepath As String = strFile

        ' Identify the file name.
        Dim filename As String = System.IO.Path.GetFileName(filepath)

        Try
            ' Open the file.
            iStream = New System.IO.FileStream(filepath, System.IO.FileMode.Open, _
                                                   IO.FileAccess.Read, IO.FileShare.Read)

            ' Total bytes to read:
            dataToRead = iStream.Length

            Response.ContentType = "application/octet-stream"

            Response.AddHeader("Content-Disposition", "attachment; filename=" & filename)

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

    End Sub
    'End of Addition by PrajaktaR on 10 May 2005 for IssueID 15610 of 4L 
    'END Of Integration by HarshadaD for  Whiz SP4 IssueID 432
End Class
