Imports Whiz

Public Class PM_ViewAttachment
    Inherits WebPages.Template.WhizTemplate


#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region
    Private m_strDisplayFileName As String
    Private m_strSystemFileName As String
    Private m_DocummentID As String
    Private m_MasterTAGID As String
    Private m_PkToken As String
    Private m_ProjectID As String

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023
        Dim drFileName As IDataReader

        m_MasterTAGID = Request.QueryString("MasterTagID")

        If m_MasterTAGID = 2104 Then
            m_DocummentID = Request.QueryString("DocumentID")
            m_PkToken = Request.QueryString("PKToken")
            m_ProjectID = Request.QueryString("ProjectID")
            If m_PkToken = "" Or m_PkToken Is Nothing And (CommonFunctions.Security.Token.ValidateToken(CType(m_MasterTAGID, String) + CType(m_DocummentID, String) + CType(Request.QueryString("StakeholderID"), String) + m_ProjectID, m_PkToken) = False) Then

                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")

            End If
        End If

        'Added By Chetan M on 11 Nov 2019 For Download the Lesson Learned Document
        If m_MasterTAGID = 39 Then
            m_DocummentID = Request.QueryString("DocumentID")
            m_PkToken = Request.QueryString("PKToken")
            m_ProjectID = Request.QueryString("ProjectID")
            If m_PkToken = "" Or m_PkToken Is Nothing And (CommonFunctions.Security.Token.ValidateToken(CType(m_MasterTAGID, String) + CType(m_DocummentID, String) + CType(Request.QueryString("LessonID"), String) + m_ProjectID, m_PkToken) = False) Then
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If
        'End of Addition By Chetan M.

        drFileName = CommonFunction.Data.GetDataReader("usp_Whizible2_Sel_DownloadDocument " & m_DocummentID & "," & m_MasterTAGID, MyBase.UseSQL)

        If drFileName.Read Then
            m_strSystemFileName = CType(drFileName("SystemFileName"), String)
            m_strDisplayFileName = CType(drFileName("OriginalFileName"), String)
        End If


        m_strSystemFileName = m_strSystemFileName.Trim()
        m_strDisplayFileName = m_strDisplayFileName.Trim()
        ' allow content types for all report formats
        Response.Clear()
        ' get the path for reports folder
        Dim strFilePath As String
        Dim strFromWhere As String
        strFromWhere = CommonFunctions.General.CheckIsNothing(Request.QueryString("FromWhere"), "").Trim

        'added by Aniruddha for downloading msp history item
        If (strFromWhere.ToString() = "MSP") Then
            strFilePath = CommonFunction.General.GetApplicationKeySetting("AddinPhysicalPath")
            'Added By Chetan M On 11 Nov 2019 for Download the lesson learnt document
        ElseIf (strFromWhere.ToString() = "LessonLearntDocument") Then
            strFilePath = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../../Documents/" + strFromWhere))
            'End of Addition By Chetan M.
        Else
            strFilePath = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../../Attachments/" + strFromWhere))
        End If
        'commented by Aniruddha
        'strFilePath = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Attachments/" + strFromWhere))
        strFilePath += m_strSystemFileName
        Dim arrFileName As String() = m_strSystemFileName.Split(".")
        Dim strCheckFileExtensions As String() = Convert.ToString(CommonFunction.General.GetApplicationKeySetting("checkFileExtensionForDownLoad")).Split(Convert.ToChar(","))
        Dim intFlag As Integer = 0
        For i As Integer = 0 To strCheckFileExtensions.Length - 1
            If (Not arrFileName(arrFileName.Length - 1).ToUpper() = strCheckFileExtensions(i).ToUpper()) Then
            Else
                intFlag = 1
            End If
        Next

        If intFlag = 0 Then
            Response.Write("<script>alert('The requested file type is not valid.');window.close();</script>")
            Response.Flush()
            Exit Sub
        End If
        Response.ContentType = "application/octet-stream"
        If Request.QueryString("SubTagID") & "" <> "" Then
            ViewCLCPAttachementsInZip()
            Response.End()
        End If
        Try

            Response.AddHeader("Content-Disposition", "attachment; filename=""" + m_strDisplayFileName + """")

            If CommonFunctions.FileDirectory.IsFileExists(strFilePath) Then

                Call ViewDocument(strFilePath)

            Else
                Throw New Exception("Cannot open the file." + vbCrLf + "The file was not found at the path!")
            End If
            If (m_strSystemFileName & "").StartsWith("AllAttachedFiles") Then
                If System.IO.File.Exists(strFilePath) Then
                    System.IO.File.Delete(strFilePath)
                End If
            End If
            Response.Flush()
        Catch exc As Exception
            exc.Source = "PM_ViewMPP.aspx->Page_Load()"
            ' Throw exc
        End Try
        ''End Commented And Added By Vaijat K ON 24/05/2017 For Mastercard file inclusion issue

    End Sub
    'Integrated by Harshada d for WhizSEMP SP4 IssueID 432
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
            iStream = New System.IO.FileStream(filepath, System.IO.FileMode.Open,
                                                   IO.FileAccess.Read, IO.FileShare.Read)

            ' Total bytes to read:
            dataToRead = iStream.Length

            Response.ContentType = "application/octet-stream"
            'Response.AddHeader("Content-Disposition", "attachment; filename=" & filename)

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
    'END Of Integration by Harshada d for WhizSEM SP4 IssueID 432

    'Integrated by PrashantSJ on 06 Nov 2006
    'Purpose: For Multi attachement Enhacements
    Private Sub ViewCLCPAttachementsInZip()
        '=====================================================================
        ' Procedure Name		:	ViewCLCPAttachementsInZip
        ' Purpose				:	To send the zip file which contains all attached files in SubTag.
        ' Description			:	To send the zip file which contains all attached files in SubTag.  
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Assumptions			:   "PK" is provided throgh queryString   
        ' Dependencies			:
        ' Author				:	PrashantD
        ' Created				:	Wednesday, August 09, 2006 
        '=====================================================================
        Dim dr, drFiles As IDataReader
        Dim Ori_Files(0) As String
        Dim Eny_Files(0) As String
        Dim strFilePath As String
        Dim zipFileName As String

        Dim strSQL As String

        ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        '' dr = CommonFunction.Data.GetDataReader("SELECT AttachmentFolderPath ,AttTblCol_SystemFileName,AttTblCol_OriginalFileName,AttTblCol_ForeignKey,tableName FROM tbl_UI_SubTagMaster where SubTagID = " + Request.QueryString("SubTagID"), True)
        dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_UI_SubTagMaster_AttachmentFolderPath " + Request.QueryString("SubTagID"), True)
        ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        If dr.Read Then
            Try
                ' get the path for reports folder
                strFilePath = CommonFunctions.FileDirectory.CleanPath(Server.MapPath(dr("AttachmentFolderPath").ToString.Trim))

                strSQL = "SELECT " + dr("AttTblCol_SystemFileName").ToString.Trim + "," + dr("AttTblCol_OriginalFileName").ToString.Trim + " FROM " + dr("tableName").ToString.Trim + " WHERE " + dr("AttTblCol_ForeignKey").ToString.Trim + "=" + Request.QueryString("PK")
                drFiles = CommonFunction.Data.GetDataReader(strSQL, True)
                If drFiles.Read Then
                    Ori_Files(0) = drFiles(1).ToString
                    Eny_Files(0) = drFiles(0).ToString
                End If

                While drFiles.Read
                    ReDim Preserve Ori_Files(Ori_Files.Length)
                    ReDim Preserve Eny_Files(Eny_Files.Length)
                    Ori_Files(Ori_Files.Length - 1) = drFiles(1).ToString
                    Eny_Files(Eny_Files.Length - 1) = drFiles(0).ToString
                End While
                ' commented by miint (missing visual j# support in .net 4.5
                'zipFileName = CommonFunction.ZipUtils.GetZipFile(Ori_Files, Eny_Files, strFilePath, True)

            Catch ex As Exception
            Finally
                CommonFunction.Data.DisposeDataReader(drFiles)
            End Try
        End If
        CommonFunction.Data.DisposeDataReader(dr)
        strFilePath += zipFileName

        'Setting Resonpnse object

        Try
            ' add the file name to the header
            Response.AddHeader("Content-Disposition", "attachment;filename=" + zipFileName.Trim)

            ' if the file exists write the file
            If CommonFunctions.FileDirectory.IsFileExists(strFilePath) Then
                Call ViewDocument(strFilePath)
            Else
                Throw New Exception("Cannot open the file." + vbCrLf + "The file was not found at the path!")
            End If


            If System.IO.File.Exists(strFilePath) Then
                System.IO.File.Delete(strFilePath)
            End If


            Response.Flush()
        Catch exc As Exception
            Throw New Exception("Cannot open the file." + vbCrLf + "The file was not found at the path!")
            ' Throw exc
        End Try


    End Sub
    'End of Integration by PrashantSJ on 06 Nov 2006
End Class
