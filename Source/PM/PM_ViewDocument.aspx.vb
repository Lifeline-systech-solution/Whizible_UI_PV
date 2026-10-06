Imports CommonFunctions

Public Class PM_ViewDocument
    Inherits WebPages.Template.WhizTemplate

    'Added by VivekP On 2 jun 2005
    Protected FromTimesheet As String
    Protected TempProjectId As Long
    'End Of addition On 2 jun 2005
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
    '=====================================================================
    ' Class Name		    :	PM_ViewDocument
    ' Purpose				:	To open the documents fromthe documents directory.
    ' Description			:	This class will take document ID as parameter from the querystring and get the 
    '                           details about the path of the document and name of document from the database
    '                           and open the document in this window.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Mar 3 2004
    ' Revisions				:	
    '=====================================================================


    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
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
            Dim strDirectoryName As String
            Dim strFileName As String
            Dim strDocumentID As String
            Dim strProjectID As String
            Dim strSQL As String
            Dim objDr As IDataReader

            strDocumentID = Request.QueryString("DocumentID") + ""
            'Added By VivekP On 5 Jun 2005
            FromTimesheet = Request.QueryString("FromTimesheet")
            If Request.QueryString("FromTimesheet") = "CreateTask" Then
                strProjectID = CType(Request.QueryString("ProjectID"), String)
                TempProjectId = CType(Request.QueryString("ProjectID"), Long)
            Else
                'Commented and Modified by JyotiG
                'Start
                'strProjectID = Session("intProjectID").ToString + ""
                If Session("intProjectID") Is Nothing Then
                    strProjectID = "0"
                Else
                    strProjectID = Session("intProjectID").ToString + ""
                End If
                'End
                If Request.QueryString("ProjectID") = "" Then
                    strProjectID = Session("intProjectID").ToString
                Else
                    strProjectID = Request.QueryString("ProjectID").ToString
                End If


                'Modified by ShraddhaM on Date 19 July,2006 for WhizibleSEM  
                Dim strFromDashboard As String = ""

                strFromDashboard = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Request.QueryString("FromDashboard"), ""), ""), String)
                If strFromDashboard = "Dashboard" Then
                    strProjectID = CType(Request.QueryString("ProjectID"), String)
                    TempProjectId = CType(Request.QueryString("ProjectID"), Long)
                End If

            End If

            'get the name of the file and name of the directory for the given documentID and projectID
            strSQL = "usp_Sel_tbl_PM_ProjectDocuments " + strProjectID.Trim + "," + strDocumentID.Trim + ",'I'"
            objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
            If objDr.Read Then
                strDirectoryName = Data.CheckIsDBNull(objDr("DirectoryName"), "").ToString + ""
                strFileName = Data.CheckIsDBNull(objDr("FileName"), "").ToString + ""
            End If
            Data.DisposeDataReader(objDr)

            ' create the path for the file to open
            strFilePath = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Documents/"))
            strFilePath += strDirectoryName.Trim + "\" + strFileName.Trim

            'add the file name to the header
            ' Response.AddHeader("Content-Disposition", "attachment;filename=" + strFileName.Trim)

            ' if the file exists write the file
            If CommonFunctions.FileDirectory.IsFileExists(strFilePath) Then
                'Response.WriteFile(strFilePath)
                ' Integrated by Harshadad for WhizSEM SP 4 IssueID 432
                'Added by PrajaktaR on 10 May 2005 for IssueID 15610 of 4L 
                Call ViewDocument(strFilePath)
                'End of Addition by PrajaktaR on 10 May 2005 for IssueID 15610 of 4L
                'END Of Integration by Harshada d  for  WhizSEM SP 4 IssueID 432
            Else
                Throw New Exception("Cannot open the file." + vbCrLf + "The file was not found at the path!")
            End If
            Response.Flush()

        Catch exc As Exception
            exc.Source = "PM_ViewDocument.aspx->Page_Load()"
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
        Dim length As Integer = 0

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
            Response.Clear() 'Added by Chetan M on 20 May 2021 for avoid extra data in txt file
            Response.ContentType = "application/octet-stream"
            Response.AddHeader("Content-Disposition", "attachment; filename=" & filename)
            'Response.AddHeader("Content-Length", iStream.Length.ToString()) 'Added by Chetan M on 20 May 2021 for avoid extra data in txt file
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
