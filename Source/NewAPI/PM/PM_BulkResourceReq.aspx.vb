Imports System.IO
Imports System.Web.UI
Imports Whizible
Imports System.Collections.Generic

Public Class PM_BulkResourceReq
    Inherits WebPages.Template.WhizTemplate
    Protected m_blnAddAccess As Boolean = False    'user has Add Access ?
    Protected m_blnDeleteAccess As Boolean = False 'User has Delete Access ?
    Protected m_blnEditAccess As Boolean = False   'User has Edit Access ?
    Public m_blnViewAccess As Boolean = False      'User has View Access ?

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' ── JD upload intercept ───────────────────────────────────────────────
        ' Must run BEFORE ApplySecurity so the security redirect does not fire
        ' and corrupt the JSON response.
        If Request.QueryString("action") = "UploadJD" Then
            HandleJDUpload()
            Return
        End If
        ' ── Normal page load ─────────────────────────────────────────────────
        MyBase.ApplySecurity(True)
        CreateGlobalObject()
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_BulkResourceReq", "Whizible2Resources")
        Dim UserName As String = Session("strUserName").ToString()
    End Sub

    'Created By : Nikhil Mane
    'Created Date : 01/01/2026
    'Purpose: For Bulk Resource Request Page

    Public Sub CreateGlobalObject()
        Dim m_objGlobal As WebPages.Template.IGlobal
        Dim m_objAccess As New WebPage.Templates.AccessRights
        m_objAccess = New WebPage.Templates.AccessRights

        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, 86140, CType(Session("intPostID"), Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString())
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal

        m_blnAddAccess = m_objAccess.Add       'If user has AddNew Access
        m_blnDeleteAccess = m_objAccess.Delete 'If User has Delete Access
        m_blnEditAccess = m_objAccess.Edit     'If user has Edit Access
        m_blnViewAccess = m_objAccess.View     'If user has View Access

        'Added by Aditya J. on 19-08-2026 for restricting changes to closed projects
        Dim intSessionProjectID As Integer = Convert.ToInt32(CommonFunction.General.CheckIsNothing(Session("intProjectID"), "0"))
        Dim strIsSessionProjectClosed As String = "0"

        If intSessionProjectID > 0 Then
            strIsSessionProjectClosed = Convert.ToString(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("EXEC usp_Whizible2_CheckSessionProjectClosed @SessionProjectID = " & intSessionProjectID, True), "0"))

            If strIsSessionProjectClosed = "1" OrElse strIsSessionProjectClosed.ToLower() = "true" Then
                m_blnAddAccess = False
                m_blnEditAccess = False
                m_blnDeleteAccess = False
            End If
        End If
        'End of Added by Aditya J. on 19-08-2026 for restricting changes to closed projects

        If m_blnAddAccess = True Or m_blnEditAccess = True Or m_blnDeleteAccess = True Then
            m_blnViewAccess = True
        End If
    End Sub

    ' =========================================================================
    ' HandleJDUpload
    ' Saves the posted file to ~/Uploads/JDAttachments/
    ' Returns plain JSON: { "filePath": "...", "fileName": "..." }
    '
    ' Performance notes:
    '   - Response.Buffer = False  → bytes stream out immediately instead of
    '     waiting for ASP.NET to accumulate the full page before flushing.
    '     This is the main reason a 3 KB file felt slow.
    '   - Called before ApplySecurity so no security redirect can fire and
    '     corrupt the JSON response.
    '   - Never calls Response.End() — uses CompleteRequest() instead to
    '     avoid ThreadAbortException corrupting the response.
    '
    ' Added by Nikhil Mane on 01-01-2026
    ' =========================================================================
    Private Sub HandleJDUpload()

        ' Disable output buffering so the JSON response is sent to the
        ' browser as soon as it is written, not after the whole page renders.
        Response.Buffer = False
        Response.ContentType = "application/json"
        Response.Charset = "utf-8"
        Response.TrySkipIisCustomErrors = True

        ' _written: True once any JSON has been written.
        ' Stops the Catch from appending a second block if the success path
        ' already ran and only the pipeline teardown raises an exception.
        Dim _written As Boolean = False

        Try
            ' ── Read form fields ─────────────────────────────────────────────
            Dim projectId As Integer = 0
            Integer.TryParse(Request.Form("projectId"), projectId)

            Dim rowId As Integer = 0
            Integer.TryParse(Request.Form("rowId"), rowId)

            ' ── Validate file present ─────────────────────────────────────────
            If Request.Files.Count = 0 OrElse Request.Files(0).ContentLength = 0 Then
                Response.StatusCode = 400
                Response.Write("{""error"":""No file received.""}")
                _written = True
                Return
            End If

            Dim postedFile As Web.HttpPostedFile = Request.Files(0)

            ' ── Validate extension ────────────────────────────────────────────
            Dim allowedExts As New HashSet(Of String)(StringComparer.OrdinalIgnoreCase) From {
                ".pdf", ".doc", ".docx",
                ".jpg", ".jpeg", ".png", ".gif", ".bmp", ".webp"
            }
            Dim ext As String = Path.GetExtension(postedFile.FileName).ToLowerInvariant()
            If Not allowedExts.Contains(ext) Then
                Response.StatusCode = 400
                Response.Write("{""error"":""File type not allowed. Allowed: PDF, Word, or image files.""}")
                _written = True
                Return
            End If

            ' ── Validate size (10 MB) ─────────────────────────────────────────
            Const maxBytes As Long = 10L * 1024L * 1024L
            If postedFile.ContentLength > maxBytes Then
                Response.StatusCode = 400
                Response.Write("{""error"":""File exceeds the 10 MB size limit.""}")
                _written = True
                Return
            End If

            ' ── Build physical save path ──────────────────────────────────────
            ' Resolves to: {AppRoot}\Uploads\JDAttachments\
            ' Folder is created automatically if it does not exist.
            Dim uploadFolder As String = Server.MapPath("~/Uploads/JDAttachments/")

            If Not Directory.Exists(uploadFolder) Then
                Directory.CreateDirectory(uploadFolder)
            End If

            ' ── Build unique filename ─────────────────────────────────────────
            Dim safeOriginal As String = Path.GetFileNameWithoutExtension(postedFile.FileName) _
                .Replace(" ", "_") _
                .Replace("..", "") _
                .Replace("/", "") _
                .Replace("\", "")
            If safeOriginal.Length > 60 Then safeOriginal = safeOriginal.Substring(0, 60)

            Dim uniqueName As String =
                DateTime.UtcNow.ToString("yyyyMMddHHmmssfff") &
                "_" & safeOriginal & ext

            Dim physicalPath As String = Path.Combine(uploadFolder, uniqueName)

            ' ── Save file to disk ─────────────────────────────────────────────
            postedFile.SaveAs(physicalPath)

            ' ── Build file path returned in JSON and stored in DB ─────────────
            ' Format: Uploads/JDAttachments/filename
            ' Matches exactly the folder path used above to save the file.
            Dim webPath As String = "Uploads/JDAttachments/" & uniqueName

            ' ── Write success JSON ────────────────────────────────────────────
            Response.StatusCode = 200
            Response.Write(
                "{""filePath"":""" & EscapeJson(webPath) & """," &
                """fileName"":""" & EscapeJson(postedFile.FileName) & """}"
            )
            _written = True

        Catch ex As Exception
            ' Only write error JSON if nothing written yet — prevents
            ' a second JSON block appearing after the success response.
            If Not _written Then
                Response.StatusCode = 500
                Response.Write("{""error"":""Upload error: " & EscapeJson(ex.Message) & """}")
            End If

        Finally
            ' CompleteRequest() signals ASP.NET to skip remaining pipeline
            ' steps (page render, master page, HTTP modules) WITHOUT throwing
            ' ThreadAbortException — the correct replacement for Response.End().
            Response.Flush()
            Response.SuppressContent = True
            HttpContext.Current.ApplicationInstance.CompleteRequest()
        End Try

    End Sub

    ' ── Minimal JSON string escaping ──────────────────────────────────────────
    Private Function EscapeJson(value As String) As String
        If String.IsNullOrEmpty(value) Then Return ""
        Return value _
            .Replace("\", "/") _
            .Replace("""", "\""") _
            .Replace(vbCr, "\r") _
            .Replace(vbLf, "\n")
    End Function

End Class
